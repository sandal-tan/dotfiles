"""My configuration for ipython."""

import typing as T

from IPython.terminal.prompts import Prompts, Token

c = get_config()

def truncate(string: str, max_length: int = 24, placeholder: str = '...') -> str:
    """Truncate a long string.

    Args:
        string: The string that will be truncated
        max_length: The length at which strings will be truncated. If they are shorter, no changes are made
        placeholder: The sequence used for replacement during truncation

    Returns:
        A truncated string if longer than ``max_length`` otherwise ``string``

    """

    if len(string) > max_length:
        return string[:max_length // 2] + placeholder + string[max_length // 2 * -1:]
    return string

class CustomPrompt(Prompts):
    """A custom prompt class for ipython."""

    @staticmethod
    def in_prompt_tokens(cli=None) -> T.List[T.Tuple['Token', str]]:
        """This makes my input prompt the following:

        >>> >>> import os

        As opposed to

        >>> In[1]: import os

        It also allows me to make my ipython colored using my existing wal setup.

        Args:
            cli: Dunno, don't use it

        Returns:
            The tokens to use in the input prompt

        """
        tokens = [(Token.OutPromptNum, '>>> ')]
        return tokens

    def continuation_prompt_tokens(self, cli=None, width=None) -> T.List[T.Tuple['Token', str]]:
        """Return the continuation prompt, which is:

        >>> In[1]: def some_func():
        >>>    ...:     return 'I do something'

        In this case, we are reusing the input prompt:

        >>> >>> def some_func():
        >>> >>>     return 'I do something'

        Args:
            cli: Dunno
            width: Dunno

        Returns:
            The tokens to use as the continuation prompt

        """
        return self.in_prompt_tokens(cli=cli)

    @staticmethod
    def out_prompt_tokens() -> T.List:
        """Return the output token displayed before output:

        >>> In[1]: 'asdf'
        >>> Out[1]: 'asdf'

        is changed to:

        >>> >>> 'asdf'
        >>> 'asdf't


        Returns:
            An empty list

        """
        return []

c.TerminalInteractiveShell.prompts_class = CustomPrompt
try:
    from pygments.styles import wal
    c.TerminalInteractiveShell.highlighting_style = 'wal'
except Exception:
    pass
