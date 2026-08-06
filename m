Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33F6931E845
	for <netdev@vger.kernel.org>; Thu,  6 Aug 2026 03:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785986783; cv=none; b=PdxHisba8HUHZUwoSHvDRORm2U6EoZ8Q81CFHemJgyTCyegPK14vPZqS+MS2huw0pEn1BA9JzZdfBMdJtuTMgproyYPQC9gVCcPYSU7iuuvGFMvLsBV/UqdrlhQbvuJK/usYcEADqO2J8ot3GFBGFIZiNAQ5B3m0d1Dx1veRPvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785986783; c=relaxed/simple;
	bh=Go5avKT1QvaWrORePMMZlk0/5Uri0rRR5CIKExBX8XQ=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=U4fmvFPuAPxtnR468JvYY3p0XdJoZ9t5Sgkxmdqzhg/z2Jn2W73L0V3C89VPmfSTaN2dZhk0ds2lcdk2SgRup9LpV212UG+ADOz0SIbNSmrFjDX0YuY5ej6t6SvZ4/1oClCmg/v6GEPbqP1xPeP1IiqGnouQRzwgH/+VVkpoq+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UT1jzFJj; arc=none smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UT1jzFJj"
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-669944f60b3so2115921d50.1
        for <netdev@vger.kernel.org>; Wed, 05 Aug 2026 20:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785986781; x=1786591581; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=28Nn44OGd3bbYGO0uu6bNbKhsRmKcVMK2M9qsrDgIYQ=;
        b=UT1jzFJj0OzFttjRnEhuIYq1r5DTO2mi6JqEHI+RPTdEgOgIt5aXy2mLsLiRCu4W6d
         k7rrBcloBzOFB/hCnKt0/7p4/zpOGwFF3hVryzjFHzHFqjBvzAnzSl0+s6MstDDHtNns
         v7KpLhBOw/iiUeO7C2fliqRupcGVDhfKuRftTql4Vq1sPsiNZ9C6EolkmGbcefSS45nR
         3C7bGHjZTPS89zmkX/GJ6kauYSlQVQTp21I1y9MkcUXDeWKWPQnkBX7MdMNfmYgKZR7a
         yW+eeIE2zyqiLSnaK4kkDpKxDdpLht8egD0UMvUJn1wyegLwRGNVYU0oFOZ7JKXV/XCV
         H6Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785986781; x=1786591581;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=28Nn44OGd3bbYGO0uu6bNbKhsRmKcVMK2M9qsrDgIYQ=;
        b=rpQSrVZHBmYqSJJlA+LdKRmPE9h0BtpKQHaQhGI0FDgjpEnL8K7LXkOaSALjInPhV8
         jVYPQlRegnzcgBK/Kt/vx7O5lV5FLPdeH7edo30IH0MKssOOMfka1c9j+f0Et9P0THIy
         tLQomq7p3QLF6COsY2xIRxu9J6QjigmXgdmRltpn7qnzUXie0hIhLpaKyKYprFzi+z0b
         M28zrPldBeo7+HvV/VEzGTGCmyZHomwINMK1/NkAWXp0VPV2rUAAj3iQ8ZEhIWwwMKeh
         bQCR4Ec9W5KIAUGDGmeb4aVM7WO8Xpmj6Pp2LfQicSH1IxF2D4FP3EVVX19rrI+mQo5K
         qCsQ==
X-Forwarded-Encrypted: i=1; AHgh+Ro6q6mMNN9Oy7w23Wp7btpx9uylFKtKQzBhcSx985giEz2nkTWmrfaRlZI99S5r69P/ExWA0/I=@vger.kernel.org
X-Gm-Message-State: AOJu0YylZHEQkA7mfgeObckVVXs9evOasxZIC0OX8yJxfykEGqBu7XNp
	FPdOu+Si86/gIKL89n3YJ1i9X27ZKUH2R6DRk7goAUou0cVV1pBim+gH
X-Gm-Gg: AR+sD12KGknygr3mqzOMuoXv0RWipzBZqTsX2HHXPHbjXTpbD8AzXxqovz9H7lrwFxR
	dLHwtzKbCIfaRyOIgCADmeo1tZfMDs93Mpi0x3PWrju4WTiVbsRL8OTZyDZOGGd4VqQ+doeKPwy
	DvW3rZhzLCdcDgHcrrnmmURq2iDpFilJ7Khsfk62OXn5CNVZ+5VtfDBEM3zW8jIhPA7JMIvDbU9
	zkwmIJxIaBk5juzP9YJvyvvYnC7dvlsyVpBNgt7seI/2HME8/K91b4J7/X2OG8sDJdgyDOlEwLs
	jZ4cmA807ZGyRGizXk+tNQ+B18xh2sQq9P5OJoDqMtUHHbDZaSHdHIOmNWTwbKE46DwEia27Q8p
	UGNaP0hsNKdWz1kGxFntzXmtkM1YQ32+gu3wok9DEMp/IGEvqTUWrAin2fMeZXbCDAg7G+NgvGN
	AWUjelBGdPWN3lrki9SIDsW+FudAm1oSwjIEIgGAuT5lclD+rIW13hi/0jqbAEOwy/Z08du+zDL
	WQ+KMXMXb6f80gJLFp+0Pd1G4CZUdgUYx6p
X-Received: by 2002:a05:690e:ed2:b0:668:15aa:4f79 with SMTP id 956f58d0204a3-6699a919b25mr5215994d50.2.1785986780972;
        Wed, 05 Aug 2026 20:26:20 -0700 (PDT)
Received: from gmail.com (250.4.48.34.bc.googleusercontent.com. [34.48.4.250])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6699166dc17sm4222731d50.19.2026.08.05.20.26.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 20:26:19 -0700 (PDT)
Date: Wed, 05 Aug 2026 23:26:19 -0400
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
 netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 Alice Mikityanska <alice@isovalent.com>, 
 syzbot+ce13c07d96d04716eaa2@syzkaller.appspotmail.com, 
 vadim.fedorenko@linux.dev
Message-ID: <willemdebruijn.kernel.220b53c78c5f4@gmail.com>
In-Reply-To: <20260805205957.1652619-1-alice.kernel@fastmail.im>
References: <20260805205957.1652619-1-alice.kernel@fastmail.im>
Subject: Re: [PATCH net-next 4/4] net: Fix UDP length overflow with PMTU
 discover and big MTU
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
> This commit bounds cork->base.fragsize to IP(6)_MAX_MTU to avoid a
> possible overflow of UDP length that triggers a WARN in
> udp_set_len_short when setsockopt IP(V6)_MTU_DISCOVER is set to
> IPV6_PMTUDISC_DO or IP(V6)_PMTUDISC_PROBE, and a large packet is sent
> over a netdev with an unusually large MTU.
> 
> Steps to reproduce (included in the new selftest):
> 
> 1. Set device MTU bigger than IP6_MAX_MTU (or IP_MAX_MTU + 20).
>    cork->base.fragsize will be set to that MTU in ip(6)_setup_cork.
> 2. Set IP(V6)_MTU_DISCOVER to IP(V6)_PMTUDISC_PROBE or IPV6_PMTUDISC_DO.
>    It lets maxnonfragsize be set to device MTU (cork->fragsize) in
>    __ip(6)_append_data, rather than to IP(6)_MAX_MTU.
> 3. Send 65528 bytes of payload (+8 bytes of UDP header, +20/40 bytes of
>    IPv4/IPv6 header). Device MTU allows it (it's only one byte bigger
>    than IP6_MAX_MTU or IP_MAX_MTU + IPv4 header, and the device MTU is
>    bigger than that).
> 4. The UDP length in the built packet is 65536, which overflows the
>    16-bit length field and triggers the WARN in udp_set_len_short.

This is discovered thanks to udp_set_len_short, but is this a
preexisting bug and the fix go to net with a Fixes tag?

> Note: IP_PMTUDISC_DO with IPv4 is safe, because ip_dst_mtu_maybe_forward
> always clamps at IP_MAX_MTU, unlike ip6_dst_mtu_maybe_forward.

That was introduced in commit 14972cbd34ff ("net: lwtunnel: Handle
fragmentation"), the message of which includes "This includes .. some
mtu fixes" without elaborating on those.

That introduced the same clamp in ip6_mtu. Which was removed in
commit 427faee167bc ("net: ipv6: introduce ip6_dst_mtu_maybe_forward")

Tangential to this fix, but maybe that should be reinstated. I don't
immediately see why the two would diverge on this point.

> Reported-by: syzbot+ce13c07d96d04716eaa2@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/netdev/6a6a966c.86abc875.e5c3d.0054.GAE@google.com/
> Signed-off-by: Alice Mikityanska <alice@isovalent.com>
> Assisted-by: Claude:claude-sonnet-4.6
> Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>

I only see this patch 4/4. Is there more that did not make it to the list?


> ---
>  net/ipv4/ip_output.c                         |  2 +
>  net/ipv6/ip6_output.c                        |  2 +-
>  tools/testing/selftests/net/Makefile         |  1 +
>  tools/testing/selftests/net/cork_fragsize.py | 77 ++++++++++++++++++++
>  4 files changed, 81 insertions(+), 1 deletion(-)
>  create mode 100755 tools/testing/selftests/net/cork_fragsize.py
> 
> diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
> index e6dd1e5b8c32..2bc997c4fa7b 100644
> --- a/net/ipv4/ip_output.c
> +++ b/net/ipv4/ip_output.c
> @@ -1299,6 +1299,8 @@ static int ip_setup_cork(struct sock *sk, struct inet_cork *cork,
>  
>  	cork->fragsize = ip_sk_use_pmtu(sk) ?
>  			 dst4_mtu(&rt->dst) : READ_ONCE(rt->dst.dev->mtu);
> +	if (cork->fragsize > IP_MAX_MTU)
> +		cork->fragsize = IP_MAX_MTU;
>  
>  	if (!inetdev_valid_mtu(cork->fragsize))
>  		return -ENETUNREACH;
> diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
> index 368e4fa3b43c..91c92cb8e529 100644
> --- a/net/ipv6/ip6_output.c
> +++ b/net/ipv6/ip6_output.c
> @@ -1430,7 +1430,7 @@ static int ip6_setup_cork(struct sock *sk, struct inet_cork_full *cork,
>  	if (frag_size && frag_size < mtu)
>  		mtu = frag_size;
>  
> -	cork->base.fragsize = mtu;
> +	cork->base.fragsize = min(mtu, IP6_MAX_MTU);
>  	cork->base.gso_size = ipc6->gso_size;
>  	cork->base.tx_flags = 0;
>  	cork->base.mark = ipc6->sockc.mark;
> diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
> index b43ddf192ecc..628203fda424 100644
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
> index 000000000000..7a1bb069227a
> --- /dev/null
> +++ b/tools/testing/selftests/net/cork_fragsize.py
> @@ -0,0 +1,77 @@
> +#!/usr/bin/env python3
> +# SPDX-License-Identifier: GPL-2.0
> +
> +# Test possible UDP length overflow in udp_send_skb/udp_v6_send_skb.
> +
> +from lib.py import ksft_run, ksft_exit, ksft_true
> +from lib.py import ip, NetNS, NetNSEnter
> +import errno
> +import socket
> +import subprocess
> +
> +
> +IP_MTU_DISCOVER = 10
> +IP_PMTUDISC_PROBE = 3
> +IPV6_MTU_DISCOVER = 23
> +IPV6_PMTUDISC_DO = 2
> +
> +
> +def check_dmesg_clean(func) -> bool:
> +    dmesg = subprocess.Popen(['dmesg'], stdout=subprocess.PIPE)
> +    result = subprocess.run(['grep', '-q', f'WARNING:.*{func}'], stdin=dmesg.stdout)
> +    dmesg.wait()
> +    return result.returncode != 0 and dmesg.returncode == 0
> +
> +
> +def test_ipv6() -> None:
> +    with NetNS() as ns:
> +        ip('link add dummy type dummy', ns=ns)
> +        ip('link set dummy mtu 65576', ns=ns)
> +        ip('link set dummy up', ns=ns)
> +        ip('-6 addr add fd00::1/64 dev dummy nodad', ns=ns)
> +        ip('-6 neigh add fd00::2 lladdr 02:00:00:00:00:02 dev dummy nud permanent', ns=ns)
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
> +    with NetNS() as ns:
> +        ip('link add dummy type dummy', ns=ns)
> +        ip('link set dummy mtu 65556', ns=ns)
> +        ip('link set dummy up', ns=ns)
> +        ip('addr add 10.0.0.1/24 dev dummy', ns=ns)
> +        ip('neigh add 10.0.0.2 lladdr 02:00:00:00:00:02 dev dummy nud permanent', ns=ns)
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
> +
> +
> +if __name__ == "__main__":
> +    ksft_run([
> +        test_ipv6,
> +        test_ipv4,
> +    ])
> +    ksft_exit()
> -- 
> 2.55.0
> 


