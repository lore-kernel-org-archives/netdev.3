Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9AC146D0B6
	for <netdev@vger.kernel.org>; Fri,  4 Sep 2026 10:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788519463; cv=none; b=VcbkZRnw4RJyiM5ji4noyJ2plUCnMblgLCKULTmwbG8bnTsPv4bgyK0lmgDYbDZcyykLlmLgquVf1snoqrDhedA1lNTiao770LDzMUPM3beoyZHwNzk8d+VC7KTjFK4Nlz17uJIJr4kt9qP/SljdM0RRgzVqHuh+Cbxuf+EegUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788519463; c=relaxed/simple;
	bh=loRyoL/vGeRGZeEOb1Q2wCfKJMQuGA1q7/HR20aBLQg=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=n2oezjSPMzZXNWmOr+kkTXKn/wqq9GZlqSGiCIs5bNeVBusxBl2TfLxdCAgozwLUuelHKG+gxdQCSYox0YdxERIeBL6lau518UMNMGwOjyPgFm8YQ2L6kn00YaFFpRjyOBVDA53NPAt1DDETdeUFrwz0/3Gontem7amF83Wgq68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P3o2DrPM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P3o2DrPM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D41451F00A3E;
	Fri,  4 Sep 2026 10:57:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788519461;
	bh=6ZGZLOqAdCgaieHUSDgUKuIaP8FQVxJKslPQPgAtisE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=P3o2DrPMPLH7vXl/CT3NgDkTfcLIXcAFSe9rvluqP6wo59Qvg03A/ee4JwJObvbP0
	 mSzsoaSCfR3axUwfoEilBw7IHnqKFYteaVVO1BzP4T2RR1bYIz8EGHhFz0NVaSXLEe
	 VxqeHn6mcGEQISVhcYrbKNs40hqYAlZP7v2X6d74RFyQj1GCbuikg0GEFxHmAXwOe2
	 yev0ZHWaKkwT5j6Xph16SB+t5sUvgG2fmnZB0J9eO8wwd/wWATAt+Sed+cS6ANgED2
	 fUm2Rg44ApVOBlTdr6u4BpAXjBNrDs+NUpoWCjjIdttlJAGu6yyqZWoglrmnzm7rHR
	 efqSLFocXzWIA==
Subject: Re: [PATCH net v5 3/4] selftests: net: Test UDP length overflow with
 PMTU discover and big MTU
From: netdev-bot+sashiko@kernel.org
To: alice.kernel@fastmail.im
Cc: willemdebruijn.kernel@gmail.com, dsahern@kernel.org, idosch@nvidia.com,
 kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net, edumazet@google.com,
 horms@kernel.org, shuah@kernel.org, hannes@stressinduktion.org,
 vadim.fedorenko@linux.dev, netdev@vger.kernel.org, alice@isovalent.com,
 willemb@google.com
Date: Fri, 04 Sep 2026 10:57:40 +0000
Message-ID: <178851946040.4131868.4350633164754043676@kernel.org>
In-Reply-To: <20260901195714.673548-4-alice.kernel@fastmail.im>
References: <20260901195714.673548-4-alice.kernel@fastmail.im>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 5 potential
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 2 · Low: 3

- [Medium] tools/testing/selftests/net/cork_fragsize.py:38 uses a PEP 604
  union annotation (`def check_kernel_config(option: str) -> bool |…
- [Medium] check_dmesg_clean() (cork_fragsize.py:72-79) greps the whole
  retained kernel ring buffer for `WARNING:.*<func>` after the send,…
- [Low] The `return None` at cork_fragsize.py:57 (last statement of the
  `for` body in check_kernel_config()) is unreachable: the `try` block…
- [Low] assert_debug_kernel() (cork_fragsize.py:60-69) treats an
  unreadable kernel configuration as "assume debug kernel and run the…
- [Low] check_dmesg_clean()'s docstring (cork_fragsize.py:73-75) says
  "Check if the given function produced a WARN in dmesg", which is the…

--

selftests: net: Test UDP length overflow with PMTU discover and big MTU

This adds a new python selftest, cork_fragsize.py, that sends an oversized
UDP datagram over a dummy netdev with a very large MTU while
IP(V6)_MTU_DISCOVER is set, and checks both the sendto() errno and dmesg.
A third test verifies UDP jumbograms over a raw IPv6 socket still work.

A few questions about the new test below.

> diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
> index 517c09d60bef7..3ee3378f8b26e 100644
> --- a/tools/testing/selftests/net/Makefile
> +++ b/tools/testing/selftests/net/Makefile
> @@ -25,6 +25,7 @@ TEST_PROGS := \
>  	cmsg_so_mark.sh \
>  	cmsg_so_priority.sh \
>  	cmsg_time.sh \
> +	cork_fragsize.py \
>  	double_udp_encap.sh \
>  	drop_monitor_tests.sh \
>  	ecmp_rehash.sh \
> diff --git a/tools/testing/selftests/net/cork_fragsize.py b/tools/testing/selftests/net/cork_fragsize.py
> new file mode 100755
> index 0000000000000..7afd643d07ec2
> --- /dev/null
> +++ b/tools/testing/selftests/net/cork_fragsize.py
> @@ -0,0 +1,187 @@
> +#!/usr/bin/env python3
> +# SPDX-License-Identifier: GPL-2.0
> +
> +'''Test possible UDP length overflow in udp_send_skb/udp_v6_send_skb.'''
> +
> +import errno
> +import gzip
> +import os
> +import socket
> +import struct
> +import subprocess
> +from contextlib import contextmanager

[ ... ]

> +def check_kernel_config(option: str) -> bool | None:

[Severity: Medium]
Does this signature work on the minimum supported interpreter?
Documentation/process/changes.rst lists:

  Python                 3.9.x            python3 --version

The PEP 604 union syntax "bool | None" in a function annotation is
evaluated eagerly when the def statement executes, i.e. at module import,
and type.__or__ only exists from CPython 3.10. Without
"from __future__ import annotations" in the file, would importing this on a
3.9 host raise:

  TypeError: unsupported operand type(s) for |: 'type' and 'NoneType'

before ksft_run() is reached, so that the entry just added to TEST_PROGS
reports a hard error instead of running or skipping the two UDP tests?

Would typing.Optional[bool], or the future import, avoid this?  The other
new annotations in the file (tuple[int, int, int], -> None) are fine on 3.9.

> +    '''
> +    Check whether the option is enabled in the config of the running kernel.
> +    Returns None if the config is not found; otherwise returns True/False
> +    depending on the option value in the config.
> +    '''
> +
> +    for filename, method in [
> +        ('/proc/config.gz', gzip.open),
> +        (f'/boot/config-{os.uname().release}', open),
> +    ]:
> +        try:
> +            with method(filename, 'rt') as config:
> +                for line in config:
> +                    if line.rstrip() == f'{option}=y':
> +                        return True
> +                return False
> +        except OSError:
> +            continue
> +        return None

[Severity: Low]
Is this return None reachable?  It sits at the end of the for body, but the
try block always returns (True on match, False once the file is exhausted)
and the only other path is "except OSError: continue", which restarts the
loop.  The documented "Returns None if the config is not found" behaviour
comes from falling off the end of the loop after both candidates raise
OSError.

If the try/except were ever reworked so that the statement did execute, it
would also stop the /boot/config-$(uname -r) candidate from being tried.
Was this meant to be dedented out of the loop, or dropped?

> +
> +
> +def assert_debug_kernel() -> None:
> +    '''
> +    Skip the test if CONFIG_DEBUG_NET is not set in the kernel config.
> +    '''
> +
> +    res = check_kernel_config('CONFIG_DEBUG_NET')
> +    if res is None:
> +        ksft_pr("WARN: Can't read kernel config; assuming debug kernel, and running the test")
> +    elif not res:
> +        raise KsftSkipEx('CONFIG_DEBUG_NET is not set')

[Severity: Low]
Should an unreadable config be treated as satisfying the CONFIG_DEBUG_NET
precondition rather than as a skip?

On a kernel built without CONFIG_IKCONFIG_PROC and with no /boot/config-*
file, check_kernel_config() returns None and the test proceeds.  If
CONFIG_DEBUG_NET happens to be off, the warning the ipv4 variant depends on
does not exist at all:

  include/net/net_debug.h:
  #define DEBUG_NET_WARN_ON_ONCE(cond) BUILD_BUG_ON_INVALID(cond)

An unfixed kernel then emits nothing, sendto() still returns EMSGSIZE from
ip_fragment(), check_dmesg_clean() reports clean, and the ipv4 variant
passes with the overflow still present.  Would KsftSkipEx be a safer
default here?

> +
> +
> +def check_dmesg_clean(func: str) -> bool:
> +    '''
> +    Check if the given function produced a WARN in dmesg.
> +    '''

[Severity: Low]
Is this docstring inverted with respect to the return value?  grep exits 0
on a match, so "res.returncode != 0" means no warning was found, and True
means "clean", which matches the function name but not the comment.

A future caller following the docstring would invert the verdict of the
test.

> +
> +    with subprocess.Popen(['dmesg'], stdout=subprocess.PIPE) as dmesg:
> +        res = subprocess.run(['grep', '-q', f'WARNING:.*{func}'], stdin=dmesg.stdout, check=False)
> +    return res.returncode != 0 and dmesg.returncode == 0

[Severity: Medium]
Can this grep of the whole retained ring buffer misreport in both
directions?  There is no pre-test snapshot, message count, timestamp filter
or dmesg -C to bound the window.

False failure: any earlier "WARNING:" line in this boot whose text contains
udp_send_skb or udp_v6_send_skb, including a previous run of this same test
in the same boot, makes a correctly fixed kernel report:

  not ok ... WARNING detected in dmesg

False pass: the diagnostic being consumed fires once per boot per site,

  include/linux/udp.h:udp_set_len_short() {
      DEBUG_NET_WARN_ON_ONCE(len >= GRO_LEGACY_MAX_SIZE);
  }

so if that record has already scrolled out of a wrapped buffer, or was
already consumed, the oversized send leaves no visible record.  For the
ipv4 variant the errno cannot discriminate either, since __ip_append_data()
returns -EMSGSIZE on a fixed kernel and ip_fragment() returns -EMSGSIZE on
an unfixed one after the warning, which the test docstring notes.  So a
still-broken kernel can pass.

Other net selftests bound the window with before/after counts, for example
fib_nexthops.sh and openvswitch/openvswitch.sh.  Would recording a dmesg
boundary before the send, and grepping only what was added, be more
reliable here?

Separately, does the "and dmesg.returncode == 0" term conflate two
different failures?  If dmesg itself exits non-zero, for instance under
kernel.dmesg_restrict or in an unprivileged container, the helper returns
False and the caller prints "WARNING detected in dmesg" for a warning that
was never observed.  Would a distinct error or skip be clearer for that
case?

[ ... ]

> +    if not ipv6:
> +        assert_debug_kernel()
> +
> +    with (
> +        NetNS() as ns,
> +        dummy_netdev(ns, 65556 + 20 * ipv6, ipv6),
> +        NetNSEnter(ns),
> +        socket.socket(af, socket.SOCK_DGRAM) as fd,
> +    ):
> +        fd.setsockopt(*sockopts)
> +        with ksft_raises(OSError) as e:
> +            fd.sendto(b' ' * 65528, (destip, 1234))
> +        # IPv6: EMSGSIZE happens on kernels with the fix.
> +        # IPv4: EMSGSIZE happens on both fixed and unfixed kernels, after the
> +        #       WARN is printed - ignore it and rely on the dmesg check.
> +        if e.exception is not None:
> +            ksft_eq(e.exception.errno, errno.EMSGSIZE)
> +
> +    ksft_true(check_dmesg_clean(func), 'WARNING detected in dmesg')

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260901195714.673548-1-alice.kernel%40fastmail.im
