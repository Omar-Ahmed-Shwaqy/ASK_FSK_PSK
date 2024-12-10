/* Include files */

#include "untitled_cgxe.h"
#include "m_maUNAviaFGW4OOzuJMkDGF.h"

unsigned int cgxe_untitled_method_dispatcher(SimStruct* S, int_T method, void
  * data)
{
  if (ssGetChecksum0(S) == 3631040165 &&
      ssGetChecksum1(S) == 3991999844 &&
      ssGetChecksum2(S) == 3604649854 &&
      ssGetChecksum3(S) == 393605356) {
    method_dispatcher_maUNAviaFGW4OOzuJMkDGF(S, method, data);
    return 1;
  }

  return 0;
}
