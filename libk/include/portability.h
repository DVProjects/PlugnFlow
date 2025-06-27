#ifndef LIBK_PORTABILITY_H
#define LIBK_PORTABILITY_H 1


/* The ATTRIBUTES macro applies an attribute only if using 
 * a compiler that conforms to the C23 standard or is a 
 * version of GCC above 2.0
 */

/* Check for C23 */
#if __STDC_VERSION__ >= 202311L
#define ATTRIBUTES(ATTRS) [[ATTRS]]

/* Check for GCC 2.0+ */
#elif __GNUC__ >= 2
#define ATTRIBUTES(ATTRS) __attribute__((ATTRS))

/* No known support for attributes */
#else
#define ATTRIBUTES(ATTRS)

#endif


/* The IFNOTC11 macro works only if compiler doesn't 
 * C11 or later standards
 * This is usefull when we want to declare a struct 
 * that may or may not be anonymus depending on the compiler
 */

/* Check for < C11 */
#if __STDC_VERSION__ < 201112L 
#define IFNOTC11(STATEMNT) STATEMNT

/* C11 standard supported */
#else 
#define IFNOTC11(STATEMNT)

#endif

#endif
