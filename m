Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B925E349B0D
	for <netdev@vger.kernel.org>; Sat, 22 Aug 2026 18:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787424659; cv=none; b=gHolrLWXkBwUbGcW69NIbZZtBhN68lL4miSH1vBbzMXa27JHUqytE5l9lvY3jUJvVpkKYTFK/5bIS8q2Vr6gSxavXt0zZ3KEQFnjsU4ReeRRw1t3C4Z2ZJ4NwcwfhVM9lJhsJI2fMQm3WPSiauVkzu0pegLUgSKfN9JGHRRh930=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787424659; c=relaxed/simple;
	bh=WWf9LUQcpHwHuf1f+4b+5zsctcktrraS70CsgdLxNi4=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=UBGcnlwd1QOAODRFjqho7KYBvUDIImJCAWya0VQoh7A/d8YVUV7lw9+IEWkuSlkh9zGpwgMBFFfe/Ex2vHCfEJShy1ykwEGRxCn4KSyeJCXPRD0oBdYr5mmHEVwF0NnnOZ0ss6T/Dyp/jJH9x9R4yLKoz/+lmG0cAYOPsZ4QO1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ah4QBeMh; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ah4QBeMh"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-81f3b227a4aso34352617b3.1
        for <netdev@vger.kernel.org>; Sat, 22 Aug 2026 11:50:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787424655; x=1788029455; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=bBmCMXrHA99oVHH1jritYoFjKpO5jq3Zcr3ci9qCDJw=;
        b=Ah4QBeMhHnRTZYYkMZPsp4aymd/p2Z/jfkZKRyLl9YucWcoLGRLKWgK4/qtR2BWFI5
         tStkrSH1mou5kT++UQREsmaTP08d3o/AmJilXVP6yqlSXfgmWTajaZIxP18Z3xFehBOr
         rGcecQEBRdSzZr/VwHDfF4hsQmkvtENEbLFvXwLrZr1+gjpii2XVHLs4tMBPxhRcV1fd
         E8tTT7J5NUqKhfhEW8VH0sv0tvR9D3bXbrvVapwK6ZcjBFbKiyDVOAeMxcrhZTJxNyXC
         LvL0V2MlcjljmPsiGMopdOI27Xsuo2gNZ0kyPg+4NrhxEbtQPSVhZDzNk+cijDKlhB7L
         Q8Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787424655; x=1788029455;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bBmCMXrHA99oVHH1jritYoFjKpO5jq3Zcr3ci9qCDJw=;
        b=VugvvSKXnZnK1TTj90Spp+/+Bst0a9CgB62g1xeqIWVWIm9qQlMGwi3R0wgGiep8Ja
         MnT5QfXniOpg6xLPvSJ6LbMfMcWEAx2E1XiWE8t4tA2BsmwscD6KUj7lyEsLiu43iwFf
         rgFkBJcrc65rrSqrS6QiL/aQN4CCFCgMFp0MLRjvU1pskleFzAef/kBYfAxbzlo4hbSO
         6bVMDtkCGp+HL1apunV2aPpCCNdHfYAetuAbGZHaGKlg31PlmpONSbp9/SfMQwuALRiv
         5aFzZmRKWAodf+Ii/a3q4BF6SPK+LrKZAyo4wIlhCrvdB5wqnxuo8wBlQXNrCEU/F32l
         pHlA==
X-Forwarded-Encrypted: i=1; AHgh+RrWaSugvyrC8G/38vE4gn1NfKFxMPPQi+wpX7g1WCRLjpDbOiXGgpwxdSYhT95kCSpE4MPFmbo=@vger.kernel.org
X-Gm-Message-State: AFuF++my0nhSZ6k1z+3YWImjzyOzM+DZfkkDQiogb469P3KM0dNmxWzA
	+3MuoWvbDX2nW+LlN1Intt3bnH6gPG6G1a5NzGi7DuCdXYmWDVdFolTH
X-Gm-Gg: AR+sD13NNDm/K9xOg+I2SD+iEwPyd9GLN08+xevlRtZyUotzYWqyyi2DqPTXUxaDvRk
	fNY+CxYaIBEkQ/nj3vbfisKBmDyaqTyLAbYkN3yDQIkYEaqAJWFJ1BunZg6dW6dhb6JKTBcV3tV
	Lr4ekf4qXq2YlosYT5X7pfs22es8SrFleCD2Xn0kOvjhmqu/qq4HhbkzF5AQeHoKjwEyrsmenZe
	+B6cahLGWV+oBMXFCE/5JpVVm/NzTXG0YGI5oQyiQx4WO3HUt9Wl1sKWcyil1PPioijXBa5RwZR
	xLLetoAK239TlXPAT+GShVBRWTluOuxWxVK0dJBq6nHRt0gh7Z4T7bvOjrAjLuTlQpfWNxLzT/b
	22yRASKukozWFDjAC32GCo36FC0qrEJHBJzLbf0COCim4u54dfsQpcUnBDewAgXuh9XwPEo+pO8
	RNpitNRiEJgxdY1h3N68o/tcCyE5HxpJn/hlmVNgErHxfQgl1lN4G0qaWzcgKfZbWW/ecbjr3Qf
	PJm6uc2BSZYU9U16F37kWtSbdPiNVvExo2VO/AT/w==
X-Received: by 2002:a05:690c:c626:b0:845:2054:2351 with SMTP id 00721157ae682-849f014841fmr42948367b3.6.1787424654987;
        Sat, 22 Aug 2026 11:50:54 -0700 (PDT)
Received: from gmail.com (234.207.85.34.bc.googleusercontent.com. [34.85.207.234])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-84c9fbfff73sm13956087b3.0.2026.08.22.11.50.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Aug 2026 11:50:54 -0700 (PDT)
Date: Sat, 22 Aug 2026 14:50:53 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Alice Mikityanska <alice.kernel@fastmail.im>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 David Ahern <dsahern@kernel.org>, 
 Ido Schimmel <idosch@nvidia.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Simon Horman <horms@kernel.org>, 
 Shuah Khan <shuah@kernel.org>, 
 Hannes Frederic Sowa <hannes@stressinduktion.org>, 
 Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
 netdev@vger.kernel.org, 
 Alice Mikityanska <alice@isovalent.com>
Message-ID: <willemdebruijn.kernel.351b61ea6fb41@gmail.com>
In-Reply-To: <20260822115717.1161782-4-alice.kernel@fastmail.im>
References: <20260822115717.1161782-1-alice.kernel@fastmail.im>
 <20260822115717.1161782-4-alice.kernel@fastmail.im>
Subject: Re: [PATCH net v3 3/4] selftests: net: Test UDP length overflow with
 PMTU discover and big MTU
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Alice Mikityanska wrote:
> From: Alice Mikityanska <alice@isovalent.com>
> 
> Two previous commits fixed overflow of UDP length when setsockopt
> IP(V6)_MTU_DISCOVER is set to IPV6_PMTUDISC_DO or IP(V6)_PMTUDISC_PROBE,
> and a large packet is sent over a netdev with an unusually large MTU.
> 
> This commit adds the selftests that replicate the described steps to
> reproduce for IPv6 and IPv4, and also one more test that ensures that
> sending UDP jumbograms over a raw socket is still possible after the
> fix.
> 
> Signed-off-by: Alice Mikityanska <alice@isovalent.com>
> ---
>  tools/testing/selftests/net/Makefile         |   1 +
>  tools/testing/selftests/net/cork_fragsize.py | 130 +++++++++++++++++++
>  2 files changed, 131 insertions(+)
>  create mode 100755 tools/testing/selftests/net/cork_fragsize.py
> 
> diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
> index 0f5c178bc224..c6d332c90a54 100644
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
> index 000000000000..d89ef9892329
> --- /dev/null
> +++ b/tools/testing/selftests/net/cork_fragsize.py
> @@ -0,0 +1,130 @@
> +#!/usr/bin/env python3
> +# SPDX-License-Identifier: GPL-2.0
> +
> +# Test possible UDP length overflow in udp_send_skb/udp_v6_send_skb.
> +
> +from lib.py import ksft_run, ksft_exit, ksft_true, KsftSkipEx
> +from lib.py import ip, NetNS, NetNSEnter
> +import errno
> +import gzip
> +import os
> +import socket
> +import struct
> +import subprocess

Various pylint and ruff issues, such as ordering imports

> +
> +
> +IP_MTU_DISCOVER = 10
> +IP_PMTUDISC_PROBE = 3
> +IPV6_MTU_DISCOVER = 23
> +IPV6_PMTUDISC_DO = 2
> +IPV6_PMTUDISC_PROBE = 3
> +IPV6_TLV_JUMBO = 194
> +
> +
> +def check_kernel_config(option) -> bool | None:
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
> +
> +
> +def assert_debug_kernel() -> None:
> +    res = check_kernel_config('CONFIG_DEBUG_NET')
> +    if res is None:
> +        print("WARN: Can't read kernel config; assuming debug kernel, and running the test")
> +    elif not res:
> +        raise KsftSkipEx('CONFIG_DEBUG_NET is not set')
> +
> +
> +def check_dmesg_clean(func) -> bool:
> +    dmesg = subprocess.Popen(['dmesg'], stdout=subprocess.PIPE)
> +    result = subprocess.run(['grep', '-q', f'WARNING:.*{func}'], stdin=dmesg.stdout)
> +    dmesg.wait()
> +    return result.returncode != 0 and dmesg.returncode == 0
> +
> +
> +def ip_setup(ns: NetNS, mtu: int, ipv6: bool) -> None:
> +    ip('link add dummy type dummy', ns=ns)
> +    ip(f'link set dummy mtu {mtu}', ns=ns)
> +    ip('link set dummy up', ns=ns)
> +    flag = '-6' if ipv6 else ''
> +    nodad = 'nodad' if ipv6 else ''
> +    addr_local = 'fd00::1/64' if ipv6 else '10.0.0.1/24'
> +    addr_remote = 'fd00::2' if ipv6 else '10.0.0.2'
> +    ip(f'{flag} addr add {addr_local} dev dummy {nodad}', ns=ns)
> +    ip(f'{flag} neigh add {addr_remote} lladdr 02:00:00:00:00:02 dev dummy nud permanent', ns=ns)
> +
> +
> +def test_ipv6() -> None:
> +    assert_debug_kernel()
> +
> +    with NetNS() as ns:
> +        ip_setup(ns, 65576, True)
> +
> +        with NetNSEnter(ns):
> +            with socket.socket(socket.AF_INET6, socket.SOCK_DGRAM) as fd:
> +                fd.setsockopt(socket.IPPROTO_IPV6, IPV6_MTU_DISCOVER, IPV6_PMTUDISC_DO)
> +                try:
> +                    fd.sendto(b' ' * 65528, ('fd00::2', 1234))
> +                except OSError as e:
> +                    # Ignore EMSGSIZE: it happens on kernels with the fix.
> +                    if e.errno != errno.EMSGSIZE:
> +                        raise
> +
> +        ip('link del dummy', ns=ns)
> +
> +    ksft_true(check_dmesg_clean('udp_v6_send_skb'), 'WARNING detected in dmesg')
> +
> +
> +def test_ipv4() -> None:
> +    assert_debug_kernel()
> +
> +    with NetNS() as ns:
> +        ip_setup(ns, 65556, False)
> +
> +        with NetNSEnter(ns):
> +            with socket.socket(socket.AF_INET, socket.SOCK_DGRAM) as fd:
> +                fd.setsockopt(socket.IPPROTO_IP, IP_MTU_DISCOVER, IP_PMTUDISC_PROBE)
> +                try:
> +                    fd.sendto(b' ' * 65528, ('10.0.0.2', 1234))
> +                except OSError as e:
> +                    # Ignore EMSGSIZE: the check happens after the WARN is printed.
> +                    if e.errno != errno.EMSGSIZE:
> +                        raise
> +
> +        ip('link del dummy', ns=ns)
> +
> +    ksft_true(check_dmesg_clean('udp_send_skb'), 'WARNING detected in dmesg')

These two are identical apart from 7 constants.

Dedup and use @ksft_variants decorators?

> +def test_ipv6_jumbo() -> None:
> +    with NetNS() as ns:
> +        ip_setup(ns, 65584, True)
> +
> +        with NetNSEnter(ns):
> +            with socket.socket(socket.AF_INET6, socket.SOCK_RAW, socket.IPPROTO_UDP) as fd:
> +                hopopts = struct.pack('!BBBBI', 0, 0, IPV6_TLV_JUMBO, 4, 65544)
> +                fd.setsockopt(socket.IPPROTO_IPV6, socket.IPV6_HOPOPTS, hopopts)
> +                fd.setsockopt(socket.IPPROTO_IPV6, socket.IPV6_CHECKSUM, 6)
> +                fd.setsockopt(socket.IPPROTO_IPV6, IPV6_MTU_DISCOVER, IPV6_PMTUDISC_PROBE)
> +                udp = struct.pack('!HHHH', 1234, 1234, 0, 0) + b' ' * 65528
> +                fd.sendto(udp, ('fd00::2', 0))
> +
> +        ip('link del dummy', ns=ns)

Should this have some test at the end? check_dmesg_clean or perhaps
a socket receiving the data.

> +
> +
> +if __name__ == "__main__":
> +    ksft_run([
> +        test_ipv6,
> +        test_ipv4,
> +        test_ipv6_jumbo,
> +    ])
> +    ksft_exit()
> -- 
> 2.55.0
> 


