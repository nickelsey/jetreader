#ifndef JETREADER_LIB_MAP_H
#define JETREADER_LIB_MAP_H

#include <unordered_map>

namespace jetreader {

// by default a jetreader_map is an unordered map with no template
// specialization by default - but we use the typedef to allow
// us to change to a different key-value implementation
// later, if necessary
template <class Key, class T, class Hash = std::hash<Key>>
using jetreader_map = std::unordered_map<Key, T, Hash>;

// if using enum classes and pairs as keys, need to specify
// the hash function
struct EnumClassHash {
  template <typename T>
  std::size_t operator()(T t) const {
    return static_cast<std::size_t>(t);
  }
};

struct PairHash {
  template <typename T, typename U>
  std::size_t operator()(const std::pair<T, U> &x) const {
    return std::hash<T>()(x.first) ^ std::hash<U>()(x.second);
  }
};
}  // namespace jetreader

#endif  // JETREADER_LIB_MAP_H
