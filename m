Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 650084137B8
	for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 14:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784815921; cv=pass; b=PlchBUW//M3TaLE6XLwhEm6ynVDqMbiwKg3yPIjp/sxL5mqtdg6f8WBCdHqJ7/h9sL87GRb80US8Oqw8uEY4/kv5HimUGOuYXoWgFJ/EbmbkW4jo3R29kBOKpOJMhfoQMELMyX/aQX87M36z5dtLyp1nBTgd6FZ4TO48ZdW161Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784815921; c=relaxed/simple;
	bh=xeRbYF6M2YtLy2I7DOnIWmckXXjjpJclqaG6wylcrk0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qBH+Cd5jJ/UebMmpc2NIneaktXHC2Ik3JNEbd0NKrow07Yge6nrK3fmyM7FljX+k9JnNRBc+2dIOVM68XGiq/Hk4SuB4zxURZE02CGvJIP/8MxGMJTI0Y4TVw18s+fy+dS2lBX0Q7lgmnhwsanL8LX4kZovk29m5Lz2MsLqPaGg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com; spf=pass smtp.mailfrom=isovalent.com; dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b=aeT69Igq; arc=pass smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isovalent.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="aeT69Igq"
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-664ce3000e6so584282d50.0
        for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 07:11:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784815914; cv=none;
        d=google.com; s=arc-20260327;
        b=iscZaF4fpJLfqzvITu5Z122dIZFPTtYY3m35Zon3YPeqCRtzRnALT1rQiHoKEzCUQm
         ZJm/hu25R4gQ0IYuL1xO9HCsjjwjhn5kZvUbByG8KkgJwHltCQl3Ts4p63jlNLHn0r9F
         zMk3h+bTlhTGClsY62GpfxE6lm/XIzV97UTRC3GbXYk5R/HwUMStYwFw4WEzZtle7DdY
         koBEHU17Mw5H0DhOQCXmOpDhMDKQmK3UQyyilRBoSSdldDhAW5PI3mlgGhYm49t4+ya7
         uYNbcN+zq1crGMXVEXyB0j5Fm4IEIVVRQaVUNwNUAFSb6MlJAi0ZnW2xOAHzgy5yGBRj
         qMgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=0PLAHDIkan+UTOVwGQkBhU541O00b8RwDfkzkNMOwo8=;
        fh=F1C530ZTeKDEKNXOFNOChXLiqaXhmqmqYxHXk/+9tEI=;
        b=pdwgXnqFeRrTwZaqPQ0HrJlzd5zn1qCxZEglS+nVfyrWBBJtIXWHs1/t/vSH+jSBN8
         XYVbHJyZ3FN+nc1n6yG+zN3Y6BnFtBUOJbRhxGP3s0Y9xZNneKns2foi8vr81/1c7/Nl
         W4Ov5qV+TI2fPl9lGaj+n/xEjk5zOT7q1UGj2MCUKL7/G7Hr08+bPvaDDUZfyOu2yldq
         xzD/FiaEZGPSm994P4mQjQ5YJB/mrr11WrWPkAoWlFelResC7D61ucHx/5+NlLc3I5WO
         Vv7tGpH1721WcIx2JzJ8jRoB4zsGsO/Acu9ZetOdKehkdnGETUrRN5RYGFEQvfl8xWFT
         KOdQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1784815914; x=1785420714; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0PLAHDIkan+UTOVwGQkBhU541O00b8RwDfkzkNMOwo8=;
        b=aeT69IgqAViSb8PAeox4RoxnpBC6/7lgfKFRkvpb/vUTpMz0Ft85bTNRG2bu9vm0QC
         Tz3LzmU3oQwDwwu+fELpttRYaHX2KlWsPsDiL/ItYh4mwP9F+cNG8LyZHxR84hLu66f8
         /elsdmfw2VMKErkbHCJDGgFqfqIh4E3k1k0lD0PYkAtzApG0p4wpzINPhswvJgn1wDXe
         nP8YDcAbVeYdtdIDegm2zdGjspLxv2qQWYj8lc8zDcRF3gQzRucVFqCP61sB8FT7Hy9+
         +DCaIXLFOvxPClR86wz8fItxAthaCEzBXeiwOQfuu+3zGl/y56SDnh6ayFJIx+CN0QKw
         LtBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784815914; x=1785420714;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=0PLAHDIkan+UTOVwGQkBhU541O00b8RwDfkzkNMOwo8=;
        b=WlMuEHOjnapmIPJOA6Sb7/eqR3X/kt2n9tAzv3RTbM5SaWBypvqxN9GKC/ahd8Vmo5
         mz3zfXLuLo6ILl+SDmu2Fpu7Oo6j1E+IRuEXlai4ZBpiJDZ7WKjcTFmqgMKE/AHIGIK8
         Dn8DwiMn0sGz4z8kNwC5AHs1nKmBXEeNQw7QD5coVTYezofMBAI1m+uhPgzHbjNZ6+EQ
         Mui70meaTbcPCnS6L7fvI8N5MKivqBJVuYCf4o+9W8hxQEAjACosNU8ygLVt7ti+PEuB
         HH+z9gn9gKyWJta+uxhAqJwI3nlejjXZrFvhvE0FLtJaGJp2Kn/4Fc3f0/52pqTK0Qms
         LXLw==
X-Forwarded-Encrypted: i=1; AHgh+RqPTqs3LS+mFzelwEBA+yzXmmYnUZbFcMTVE3JN8+5i7XDrkM4ET0NEWHKgGFecbQEygKevfJA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCO1q5+LbKY2ZTvRGbWUPlhLkaoecrJFUtpoFHYVX98avYyOaQ
	TPIZdDQVdKxQG0enl2LOlQjS2q+7NqdA0HCQuWZmkEm8vOS04Jvbu07Vbns67tiMeYvBvhGXWdX
	tzPl4cVr8JbeTzcd/UDDyhYTXhZJY5AdWsF0Su/FBKQ==
X-Gm-Gg: AR+sD13jrveyu1BVbY9dG8s2trqsdmeehz1vvGDqA/p4QRK+3E8rjcK/g/5OcRN3V5g
	x8272siGW69Ub3mSmaBbP7cw2G5eMvfgUVgBz0nLDN+rtBZzrs3LO5aMs8SQS9PSW5bK6+w7vaH
	ST2piAeBGHKJanTeCfjqWjyKo3iyYWQUqrOuyAl+ImH5lcX9xAzj5PDePnmMnNI5lPliw7WXvAR
	gDgnSbNNxScjgaMGIAAG4tfv7zewyXiOnrRaHb4snBf5v1enXUZZZZVSSjbfoyvD412Ch+s6u6s
	MXDl46pmxAFC5fsmn7V6IYw5gdxRs4WWZYX+AXWYVcqjKLfd9iP+JudLyE8=
X-Received: by 2002:a05:690e:e05:b0:668:9f36:5497 with SMTP id
 956f58d0204a3-668a4d7391fmr552495d50.61.1784815914269; Thu, 23 Jul 2026
 07:11:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260710134242.216538-1-alice.kernel@fastmail.im> <20260722111522.569fc202@kernel.org>
In-Reply-To: <20260722111522.569fc202@kernel.org>
From: Alice Mikityanska <alice@isovalent.com>
Date: Thu, 23 Jul 2026 17:11:37 +0300
X-Gm-Features: AUfX_mxARLnemHA9xOUvlAHG80AyPBpE0y5Zt1zejlaZ8W0FL3Xc9ujjvWLb5Yg
Message-ID: <CAD0BsJWzSr2zduf5v3mVC4zd=Lj6ZAoC+V42-VBdg42aDY8XXw@mail.gmail.com>
Subject: Re: [PATCH net-next v9 0/9] BIG TCP for UDP tunnels
To: Jakub Kicinski <kuba@kernel.org>
Cc: Alice Mikityanska <alice.kernel@fastmail.im>, Daniel Borkmann <daniel@iogearbox.net>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Xin Long <lucien.xin@gmail.com>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Willem de Bruijn <willemb@google.com>, 
	David Ahern <dsahern@kernel.org>, Nikolay Aleksandrov <razor@blackwall.org>, Shuah Khan <shuah@kernel.org>, 
	Stanislav Fomichev <stfomichev@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Simon Horman <horms@kernel.org>, Florian Westphal <fw@strlen.de>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 22 Jul 2026 at 21:15, Jakub Kicinski <kuba@kernel.org> wrote:
>
> On Fri, 10 Jul 2026 16:42:33 +0300 Alice Mikityanska wrote:
> > Patch 09 adds selftests.
>
> Seems to fail:
>
> https://netdev-ctrl.bots.linux.dev/logs/vmksft/net/results/745543/157-big-tcp-tunnels-sh/stdout
>
> # selftests: net: big_tcp_tunnels.sh
> # 0.05 [+0.05] Setting up VXLAN over IPv4, veth tx csum offload on
> # 0.11 [+0.06] Warning: Extension comment revision 0 not supported, missing kernel module?
> # 0.13 [+0.01] iptables v1.8.11 (nf_tables):  RULE_INSERT failed (No such file or directory): rule in chain PREROUTING
> # 0.14 [+0.02] Warning: Extension comment revision 0 not supported, missing kernel module?
> # 0.16 [+0.02] iptables v1.8.11 (nf_tables):  RULE_INSERT failed (No such file or directory): rule in chain OUTPUT
> # 0.18 [+0.02] Warning: Extension comment revision 0 not supported, missing kernel module?
> # 0.20 [+0.02] iptables v1.8.11 (nf_tables):  RULE_INSERT failed (No such file or directory): rule in chain OUTPUT
> # 0.20 [+0.01] Running IPv4 traffic in the tunnel
> # 5.24 [+5.04] Warning: Extension comment revision 0 not supported, missing kernel module?
> # 5.24 [+0.00] iptables: Bad rule (does a matching rule exist in that chain?).
> # 5.26 [+0.01] Warning: Extension comment revision 0 not supported, missing kernel module?
> # 5.26 [+0.00] iptables: Bad rule (does a matching rule exist in that chain?).
> # 5.27 [+0.01] Warning: Extension comment revision 0 not supported, missing kernel module?
> # 5.28 [+0.00] iptables: Bad rule (does a matching rule exist in that chain?).
> # 5.28 [+0.00] Captured BIG TCP RX packets:
> # 5.28 [+0.00] Captured BIG TCP TX packets:
> # 5.29 [+0.00] Captured TCP SACK packets:
> # 5.29 [+0.00] ./big_tcp_tunnels.sh: line 150: [: : integer expected
> not ok 1 selftests: net: big_tcp_tunnels.sh # exit=1
>
> Sounds like we're missing some iptables options from the config?

Sorry about that! Just sent a quick fix, hopefully it will suffice:

https://lore.kernel.org/netdev/20260723140241.132120-1-alice.kernel@fastmail.im/T/#u
