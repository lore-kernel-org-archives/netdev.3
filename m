Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 179AD3546C2
	for <netdev@vger.kernel.org>; Wed, 26 Aug 2026 17:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787764710; cv=none; b=PdannDZjJeuh++UIDJRRKM2noAPn99/6gDc0KTlBqjrSIHov+OBc+rrNdZ9CALf6tB9eAXVLicWx/bxQ7oUJ0CLc+ZpnwYadXwFL0yVtSGUDkSjt9dVWOzoBOa21tIctZg16mIWKq/IkKqPlOMTydcpD1rR59NSODmYFWqtJn04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787764710; c=relaxed/simple;
	bh=p/3R7pDB+5TX/gkYttPa97Up0LnPUOzgc/791LDw8eY=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=nVCMyxovJrqeeMFOuDKf2x9/TZ7461bfYqSJ0NvGTNnsxceHsYXcRcimclyE4fFJ7IlVSrqftVTvoUb3CuE+hAaVHpivTGs3Orl1/o+Ogyk2RYnEqlEYPhLiI+AJyZiSKSXgQBx9cKoHFSo/lgSSz8F2FbRQdjJTqtN8DuuFxrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dOhLpuOK; arc=none smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dOhLpuOK"
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-66de7e0bc85so318761d50.2
        for <netdev@vger.kernel.org>; Wed, 26 Aug 2026 10:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787764700; x=1788369500; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=wQ0JzTmJJZsXzrleAx3dGwdXnsAEBsFvSA9gb2m/MvQ=;
        b=dOhLpuOKuqakFk1XRxT/2i5pIdcnHOeNSfLEIhDeHHqCcURme8B4StPzaBebnirkPM
         WBOAmz1ct8fKztqLR+MGwZ3S5JU3Q0ubBgbnw3Z6l2PW5rNExA36E8C4xK6jSq0pWi26
         oucyA+N3A3Jn/64rzDF7NAXzDp+F4TTX+CI3wweipbeCp4JoDJU+32IkVT1Z6CuZdZbt
         Nh/ylsNsKTyJ1LGwawd3JQAUuu0i0TYXEsTQHTfZlpZTK4yC/hRKHHjg9he1evPGI8Fy
         2oLOclcoISBmYDuEiAGlnUdOmCl13OCOy2gjLzWm74d5g14l4xRN0lcUZBENC8PgkxiK
         hNnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787764700; x=1788369500;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wQ0JzTmJJZsXzrleAx3dGwdXnsAEBsFvSA9gb2m/MvQ=;
        b=h1iiCor3MoUhYet1TiKeYnOknD/stFarXIacuQCjuhl/ccecyJ0bP2Vp2Be5ZMVOre
         r/huDNafNkLGOYyygqPsdnw8TgjgxetQqCSuBKYEtTQEqzUqM4Xx7tl69wzB9BUmd0gz
         0n9X8Wq7JtQMwb2+8JzrFuWCCLLsorEu6QCAYIGgJZzq6Kdz2SL4khTfHAz+slhe8/pR
         ZwRDhPjPF1w9UHKd7Coat4rmnNzEePIjjMLhKM+DiuBA5MY+6flOg9kpHZ69e00txXSV
         aTCBxGPdcxpBssLAddzNuFcLFsMcxQAG1GWJInYIGlCzqrSEYXjj0rgDzeWm++nhWbZP
         6tQg==
X-Forwarded-Encrypted: i=1; AHgh+RoRh72STPHPYshNOG8JYlUXIM9/f8l3cvLuYQrzvP1Gk3CdgMEFIKWET4aSdVJ+RJNlNw8/vU0=@vger.kernel.org
X-Gm-Message-State: AFuF++m65kHQ1tLhxr/ccw5xJ63B7knEu0C8pEuHkF7YWfwG4uhioO/l
	L5t3P8I8vEXixpRGtVgt2egFmTBoqIKt9JRcOTPp/aJmawrGu1H190cJ
X-Gm-Gg: AR+sD13CBaOK/eBPtIhcCPV+SM2V0Qe+m4XSlD3You/1hxWyBmnU+9aTkVpZ5xR+eNT
	fVhbjyKHH6IVvMx98NzOt5jGlaJiU+qJ5so7yilOxfwdBEzfZmwLQNqIm//nIDGSaC3GxlvlK6L
	z7rHH6aI5PEOLeOajsKTZcrR6NUT57hR+PcWL++dzjMbxn7P2Vj3qfxJG+QCX1MzGTkEeK7MfAe
	QbMAKRSiBT0IXGE/0VUGW3qAA17GKlIy6417ASo31HsD/Lx4Hvu1JVx9xrzOuxfs61szwYncnt5
	03mLe0FxvhWKnMdUIUr1iEz30Bdfc9KiadhUnvgpWnQta06Y+VRSVun7QXP+IaocPjsbshq0RL4
	sLuD4OWiSs15dlplJm4tI0R34mbpwUBMelbrChJ+bavxLh118X1he3hAvNbYH2oufwmcLU5LL0V
	7XNpnWHfyhGTSXT79n4YeYfeTgYluhlv2JbkIYZ/AYvcJtJCY8fPp0t4aTjUM84rfn/mkyADYAL
	yiO0AnHDAVoNLeVon+gp8sYm/bl2WFCHFCFA+iit2LdIUFPjV3w
X-Received: by 2002:a53:9003:0:b0:66c:f16e:fea7 with SMTP id 956f58d0204a3-66d2575b6bfmr2240985d50.28.1787764700071;
        Wed, 26 Aug 2026 10:18:20 -0700 (PDT)
Received: from gmail.com (234.207.85.34.bc.googleusercontent.com. [34.85.207.234])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66d24749dd2sm1749285d50.16.2026.08.26.10.18.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2026 10:18:19 -0700 (PDT)
Date: Wed, 26 Aug 2026 13:18:18 -0400
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
Message-ID: <willemdebruijn.kernel.3645a45d69737@gmail.com>
In-Reply-To: <20260825200215.90326-4-alice.kernel@fastmail.im>
References: <20260825200215.90326-1-alice.kernel@fastmail.im>
 <20260825200215.90326-4-alice.kernel@fastmail.im>
Subject: Re: [PATCH net v4 3/4] selftests: net: Test UDP length overflow with
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

Reviewed-by: Willem de Bruijn <willemb@google.com>

Thanks for respinning for the code dedup between ipv4 and ipv6
> ---
>  tools/testing/selftests/net/Makefile         |   1 +
>  tools/testing/selftests/net/cork_fragsize.py | 140 +++++++++++++++++++
>  2 files changed, 141 insertions(+)
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
> index 000000000000..c54af8f21e3b
> --- /dev/null
> +++ b/tools/testing/selftests/net/cork_fragsize.py
> @@ -0,0 +1,140 @@
> +#!/usr/bin/env python3
> +# SPDX-License-Identifier: GPL-2.0
> +
> +# Test possible UDP length overflow in udp_send_skb/udp_v6_send_skb.
> +
> +import errno
> +import gzip
> +import os
> +import socket
> +import struct
> +import subprocess
> +from contextlib import contextmanager
> +
> +from lib.py import KsftSkipEx, ksft_eq, ksft_raises, ksft_true
> +from lib.py import KsftNamedVariant, ksft_exit, ksft_pr, ksft_run, ksft_variants
> +from lib.py import NetNS, NetNSEnter, ip
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
> +def check_kernel_config(option: str) -> bool | None:
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
> +
> +
> +def assert_debug_kernel() -> None:
> +    res = check_kernel_config('CONFIG_DEBUG_NET')
> +    if res is None:
> +        ksft_pr("WARN: Can't read kernel config; assuming debug kernel, and running the test")
> +    elif not res:
> +        raise KsftSkipEx('CONFIG_DEBUG_NET is not set')
> +
> +
> +def check_dmesg_clean(func: str) -> bool:
> +    with subprocess.Popen(['dmesg'], stdout=subprocess.PIPE) as dmesg:
> +        res = subprocess.run(['grep', '-q', f'WARNING:.*{func}'], stdin=dmesg.stdout, check=False)
> +    return res.returncode != 0 and dmesg.returncode == 0
> +
> +
> +@contextmanager

Interesting approach. In ksft the built-in defer() mechanism may be
preferred. Not sure.

> +def dummy_netdev(ns: NetNS, mtu: int, ipv6: bool) -> None:
> +    try:
> +        ip('link add dummy type dummy', ns=ns)
> +        ip(f'link set dummy mtu {mtu}', ns=ns)
> +        ip('link set dummy up', ns=ns)
> +        flag = '-6' if ipv6 else ''
> +        nodad = 'nodad' if ipv6 else ''
> +        local = 'fd00::1/64' if ipv6 else '10.0.0.1/24'
> +        remote = 'fd00::2' if ipv6 else '10.0.0.2'
> +        ip(f'{flag} addr add {local} dev dummy {nodad}', ns=ns)
> +        ip(f'{flag} neigh add {remote} lladdr 02:00:00:00:00:02 dev dummy nud permanent', ns=ns)
> +        yield
> +    finally:
> +        ip('link del dummy', ns=ns)
> +
> +


