Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 372663C3F76
	for <netdev@vger.kernel.org>; Fri, 21 Aug 2026 16:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787330316; cv=pass; b=OWPvy9/UR6SbkZyWj9fGwc1V7NY0m1G1Bm5xSxZIHahFI03XSviq3mQDDHW3omjuMcfJBb/HUM2d2ZIUYTqihGyVcA35Q1D4e+YPCjBm7qsXs6HJ50BEhQFBIQxy53IzgQkhLrS2BhFiPooIyNnwgcQvcw1zv0EJ729ffU7QMOs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787330316; c=relaxed/simple;
	bh=739k+zQEqGdV7V1L/t1tMPFaOUIQd626ub+Svf/bY+4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P35+/67gP+vu0+Ol16rjhkBdcTWPYtxLKYn+RHhmxUIfj5nhIQx0BUzG0I2o6/XO/Aty8aC6lHbf1Jvy5iPI2HK5DSafD7PynMDD7mRxFTv3el+2s17vUwmj6EHs93hv9yCfwIrPsdiWa2rLI9s6UItrwVWbGUEgojXxXVNyg1A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=B4MdwpS3; arc=pass smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B4MdwpS3"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6a1f8757b4eso13970a12.0
        for <netdev@vger.kernel.org>; Fri, 21 Aug 2026 09:38:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787330310; cv=none;
        d=google.com; s=arc-20260327;
        b=VSWFxrkIVU7Qwz0w7GTx1j0ZJIlrk7zhq3R2yJudpINZP8gXCPe/ar9iQGT9T1QbDr
         jt8GEe/LpNWSDNGg4FEM2YcGV+Tgc6rR2xqahgx74lulU2Oaz2Adqd2XPi+gNlYifHlE
         YJJdA8oYf58IY/drePOYddoZk2iwHCj2d5CkZBcbdZ24qaPLHoBocVsEIejgqnoZRP3A
         KsPKVNimWJVRpxLEiURZWZUqYGdH0GijZYHTKaZ8HtQetxU0bS1A1GiRVtrJecWjAect
         zR0Sa21DswqI2rnm2Asyt71q1YPnWE14DGVIlO/hg2lvaRWd3BJ+6rzwbb6TzQuqMRqT
         +Mcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5dENA6n5/WGxSCS6HU3D04SsaNXhFXC7pf6saOa79aE=;
        fh=SJv1MWtgvJZhPSZyQX9hVwfWFSgzWDdAQZjBTMMU1Mk=;
        b=fv2Siu/iszEG8TxfQ56hLlQgGqO6Av0KJI5ntlkuROeW5e1z9cir0hXrFLcZR8xBNP
         /cF0rwAkcefsz//SUWRpkn2d5J6UMfwKnKgBORROeooPtxq3jaz426ZgJqmGPDvVY8W2
         rBaUAkPpLC7M9PL8dvRj68XbzxBhKSglB0kr9BVxu0bMfF1htC+aCNfWhQbqJBXJ9iCe
         S1dKjdXOBoBUPk7wQjN+Ut6ND3WB93gdhl4TatIaXxHje+JZcudrjzjhoLnxQ2t3dwtK
         IKsYDyQNbKRN5e2k404cm/Ng7H9uFKj9HRqWPRFSKwUzhkWJVn8fa6jRTK/wFS1wiSuA
         r72A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787330310; x=1787935110; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5dENA6n5/WGxSCS6HU3D04SsaNXhFXC7pf6saOa79aE=;
        b=B4MdwpS3XOKvhBRrpkPtiQUwMS5+M0FmI/0GXmKDi15gLNtSKdu3audJqaRVx9VL61
         hQEp9S6+dvMXTqRnVrYys9jX+QD8Gt0VOKGz19eZPSdgQ0temzjdQsWDiIP+MA/OxAMC
         ADnb4taxwhr0LeX02dck293kv3ZmYXdjiCv4Bf2+u9L7cPSanEPZu2XCuFdT6+Zl20CY
         gwtoBTJginoewxryGL+S/jiZi2JTMg/PqVNlCOEpwpgR9nARE3wzJPKEb8xEWEwiBhAa
         IhDSDffqLdMy5wzHt86bNT3zBn/7t9pPRKKHezBrk8G1i4Iilz3Eu++i476otNHcQrh1
         PbeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787330310; x=1787935110;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5dENA6n5/WGxSCS6HU3D04SsaNXhFXC7pf6saOa79aE=;
        b=Rl+t+0QOwGc+Lk+FzeIIkXWIo/HnrMn6Qiqzi821AW7oHbv+eKOCrTi/he7eL8rPFu
         RfFv4lkWXpf1kOVje6rDhMoDFBqHH+42QyjOkJFsVEoBYsJprc94CyW5GwcL2/2B9o6W
         NQqR/CnsIJUUoKgWgPK5eJYXNNe3bvtFYNcDh5EUQMe8f8qgA9Rq3WRnbcwJEStsXx1N
         +1k9sxfz8KyGrMug7cebixFY2z6vRRvTOLSzU9KqGZZiwC+z4C41QJfz1vSfysNW/X8+
         VjtAHxsh9q3jO3KnD/ZhfVtFgK4zRm3m/7E7J1scSAZzXb/BENw4Q9pgDuWFOu7oPetD
         z+Qw==
X-Forwarded-Encrypted: i=1; AHgh+RrSxhRXXWlrX4QBzs+OhkAEYx6XhQ6aGmg6Eha5jVjX9ticYeyaUyfUgZADfLxgLZ9jl4sw+9E=@vger.kernel.org
X-Gm-Message-State: AFuF++ncb43CscDiQpQWVTgsc8qZye+nkPqWj8V/FQQAd4NriROnrJJ7
	AOWbgr8jvNW2NwJEdnux7PXeKt5aXg+mxfzw7/P1vHkMjuSOVMj4ZzvurRxyR9rsBHeFYLVpZDS
	seLmZE+RPYaCqmcx6HkjvMHprOGjnOmkyvJBdQb//
X-Gm-Gg: AR+sD12RrSQy90GyhqurgeGKo4O9YR1bqI18fne8iiOYzTgCcs88hlHZiDdGiuY0BJ+
	lAyfqD8sdyC7/RTiSPrcn71pYR/DzZ/0GkOXClgAycnTdeb+txqez/Kial3ODzhDNcpvbHGhH7p
	H+NJ35DTzxSWm3gLdYZgBWql0AtDAEu2EPzhhXv9rWU/7M9LOiwZZATpAB9Q1HhBOyidPRM4ndD
	G5h3Alqmqj6LiqGsn06bDWMRBBPr/U2ZCv4wA4t/R/kn5QE2oC83bJxbZmpjWTBPeuKHG5sRSJh
	B4kYdrWM38rNMjuRj6hcEEcJYzBZN5/NWr2WamJKZZ9SzfW+JJ2Ma/B99t9w3nmBQyoSeLbBL+U
	Ubti7GXHoKA==
X-Received: by 2002:aa7:d34f:0:b0:6a4:abe:52db with SMTP id
 4fb4d7f45d1cf-6a42f60959cmr67712a12.12.1787330309312; Fri, 21 Aug 2026
 09:38:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260814191336.187243-1-almasrymina@google.com> <178725782538.470503.1324832379530837261.git-patchwork-notify@kernel.org>
In-Reply-To: <178725782538.470503.1324832379530837261.git-patchwork-notify@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Fri, 21 Aug 2026 09:38:17 -0700
X-Gm-Features: AcwNN1XkzSoVkkBd0LcjbNxP8qE8mfjPqBhJfXoo68SrZ_ZPjrJrEXlVwRFEcsc
Message-ID: <CAHS8izMiO0Wm5dghHjj6ZJEOezPnLo3VP2AafYfLYv-DXM=kbQ@mail.gmail.com>
Subject: Re: [PATCH net v4 1/2] net: core: propagate unreadable flag in skb_zerocopy
To: patchwork-bot+netdevbpf@kernel.org
Cc: kuba@kernel.org, kaiyuanz@google.com, willemb@google.com, 
	edumazet@google.com, pabeni@redhat.com, sdf@fomichev.me, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, dev@openvswitch.org, 
	davem@davemloft.net, horms@kernel.org, ncardwell@google.com, 
	kuniyu@google.com, aconole@redhat.com, echaudro@redhat.com, 
	i.maximets@ovn.org, kerneljasonxing@gmail.com, asml.silence@gmail.com, 
	bobbyeshleman@gmail.com, fw@strlen.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 20, 2026 at 1:31=E2=80=AFPM <patchwork-bot+netdevbpf@kernel.org=
> wrote:
>
> Hello:
>
> This series was applied to netdev/net.git (main)
> by Jakub Kicinski <kuba@kernel.org>:
>
> On Fri, 14 Aug 2026 19:13:30 +0000 you wrote:
> > skb_zerocopy() fails to propagate the unreadable flag when copying
> > unreadable fragments, causing target skbs to appear as readable memory.
> >
> > This patch fixes the flag propagation. Additionally, it returns -EFAULT
> > if readable fragments are mixed with unreadable fragments during
> > extraction, and returns -EFAULT in openvswitch queue_userspace_packet()=
.
> >
> > [...]
>
> Here is the summary with links:
>   - [net,v4,1/2] net: core: propagate unreadable flag in skb_zerocopy
>     https://git.kernel.org/netdev/net/c/68d8c6532659
>   - [net,v4,2/2] net: tcp: block mixing readable and unreadable frags
>     https://git.kernel.org/netdev/net/c/d9c56501c72f
>
> You are awesome, thank you!
> --
> Deet-doot-dot, I am a bot.
> https://korg.docs.kernel.org/patchwork/pwbot.html
>
>

Thank you sir for picking this up. I was mildly concerned about going
down this "also this bit is broken" clashiko hole forever. I'll work
on submitting fixes for the other pre-existing issues separately.

--=20
Thanks,
Mina
