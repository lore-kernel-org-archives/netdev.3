Received: from mail-qv2-f0.google.com (mail-qv2-f0.google.com [74.125.230.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CE6B23507B
	for <netdev@vger.kernel.org>; Tue, 25 Aug 2026 07:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.128
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787642636; cv=pass; b=t6oIRmZCqWuHwYL1THZ8UFsSUJpeXYdFs0a1mNk0bsUY6VAcJIC1RLgar3BnTgmFfLKwHzXH2/ziBM/N0seH3VkNJBF/GMtErLJWrhA0R3+7FRdTQOSn59xrxvhmYzMkBQ6UlIi49q1rKypHQ2uODqm84phVTTJ1n6BjrEDfcSM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787642636; c=relaxed/simple;
	bh=LKEk+XM9h7fe2kCkYfRVhZVfEixMcq8nCj3l9CLhCnI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Lv6YtcsLCgk+kCI0sNHdOz7VwlOmtHLVTedl3MAIAXg69X9IczvPSdAlFHmtrg5kIUhiKmd6OCuswd3PIRL2fHiVotT1UINJzogI5H1AfVQohsW5KrHIYUV3vHuC6p8Kfs6y3m8fq+NXNLMMGC5BxuCDDm4LmFz28a+C6G+6N68=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m7TW0Oiw; arc=pass smtp.client-ip=74.125.230.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m7TW0Oiw"
Received: by mail-qv2-f0.google.com with SMTP id 6a1803df08f44-908600e9d17so12013386d6.0
        for <netdev@vger.kernel.org>; Tue, 25 Aug 2026 00:23:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787642634; cv=none;
        d=google.com; s=arc-20260327;
        b=CWQOQmFwyrtQVQb0LQAUJA3Wyu4KtTv8Oci6oSikv40u9M5Lp+4pdVViiDiwPaF43E
         IdphzmuTU7T6I+vY5rURNK5uG9GxmHf0q/ruHXMMZf4qKPvpOpSY6I0Vm2zNPIocYRtk
         RS2XUgIgKzdfBfcaT1d3ou8JhO0b/Uz5hBDWYVC08cq2wOr70udXUhNOR9JaNF0h4nJ3
         NZbL80hd1k8d/od7eDXVbrn9KQQVIUWvMOXNgB8lIghMgngajvA11ZJl05MTQ5YJ6xW8
         QdEtpW5E5IZ/t2gMyCEX8KvdJdpzI+GQ6WYCY58ylhrjeOXwEOSgd7BHDamOaCZ5s4Sx
         CaDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5MF/MBTrCfSXWzKNdT3Bf9ZX+eb/bc/7p3w8ZeuQtQM=;
        fh=iInzLF7b+nlVP/BHWYHJ5C/qHE0dgNX6Ghuy5Ra7ODA=;
        b=hLCvtWXpEI1Ocy4eACjaUbVkd29SEzfdZASgYZUunUeTm7heIZvL8RWdjVEa34gYSw
         WBslVB22pneJyAntniUKsKYu26UzQ74nk3WCkCCsVgWH+BkngHFnE/9KHf34kKB2kNNR
         uQRrbrrE3KxWW/Gb0Fn51IRHOpLeMj/lHzbd6Z+e1kvmcR64Y9CX5/bdzd6gw1zgvMVl
         mQRynFvO605GRCQ9Rj3HQgWTbNG9DDirdYlvxYWPqXwAmsnFST6obks0YJDqZz8xO3DV
         qmACqZYlcaUZHwnZbZjqr3uVn2NH8hwCPFrehWrC2CWIOM/8F9+mB8huSLDaFMimfY1g
         ZMhQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787642634; x=1788247434; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5MF/MBTrCfSXWzKNdT3Bf9ZX+eb/bc/7p3w8ZeuQtQM=;
        b=m7TW0OiwC2hjbVgQ6wqioYKsc2iP0J1bwn3brUdbzWGFgvI+dh21kh124OUGDV0GcT
         S5SKm4y7Km0UXwmSAKl5/dUFRB4hIK2a7kGyF/dWD25wX5eYVidQ6/AEbB5CEP8l0BFz
         dwM9pX06jwLP70qYxaU9xTXsr3hR5Bp2iHr1WC0KwAP+X9g0sxkoKmLEdyqCc825E0nb
         ZKPpImuciDojHrSLIcB0UAKgHAAiLi5hhUYmLRx//WG2+YsvHVc01ICG/E7VlMkYsfvg
         ZGB8gEL7lDPrnsrmH02KhEySq30wN60dGg6tYJ9PvL+GI9gijIrspDGFrulgYylca45u
         UxPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787642634; x=1788247434;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5MF/MBTrCfSXWzKNdT3Bf9ZX+eb/bc/7p3w8ZeuQtQM=;
        b=CU3Dk7T4wWGhKY6Ha/nqXmOH2C5VSGMpJmqM7SJj4zq73w1IM5RfpPFzzy8g6p8YiL
         GGNh3xO53B15ynRLW4yMKD78l4bTI7aP+ZNWMExF+fPDirOJ6N4yZkbub+9VCuK+og/r
         fLGbMtNHJrr8xts3G0oENzNxxVGl2ovF5xDTJZVkaAGt/eIg27MtLe7J+Wi0HqyTV3Xm
         bZQn4XgJmC0zXw9ibS575ugK0QOChXDij47/VW7BoratMZhZvw9c9Fo6sobo8zu0k+B9
         7KcGHt5v/jAn24SEWOxgGvJrAj2AY3Q5vUKJqqKMl5X/CpcuG2i4KKyg7p/HYv0TTMLA
         kBlQ==
X-Forwarded-Encrypted: i=1; AHgh+Rp4uF2/d9IN8ES7DQZVqJ7mWfA7UUh0fQZKTg3+nXNpb3K0w5sLTvaEc33qAyXKK7jXwZQjrq4=@vger.kernel.org
X-Gm-Message-State: AFuF++mcj3AoyvnJsxIGWO00B6W5Vb+mR49K/n3r20/bYB7+TlkUuCVJ
	XV52A/ksatHNsjmpXmfVXahPiSydF8tG0p0NmHy9R5FiAqJrqxlcANfjqPw7XfQmZJnfrGvbPEe
	XVXZyHWLowkNG+u7xQ5viRXrkuJ1knKA=
X-Gm-Gg: AR+sD13zXgzBT9CiofVMJ9o0nI3NZMhoOuO+xNsWUMgDhvlUkr3894Wnfyl2dfXXnq2
	sOThn+V53FswR2VpiFmBM5WqcEizzr+0F5VN2Qrl9Db6vLNKzueZ4uSCTyHUCEMnznaYj3x9g6k
	WlgfxINRam16L7TLtRHeh2f4ee4E9zN5UioNxht+RZx7VjOJVE24IeLMVSIuJbhhG7OS8mAVrqK
	G+yBanyXiz6IInNhSc4KvXe5aFTBvbP0sDQ9SXgcijcyE1Wu76EDPnGnuOgW6qyy/l3AgZDF+Re
	yoi538orfSN2MJ3B2Iwh8PuWQ/MjLgAT44P+dNuPinnP8w==
X-Received: by 2002:a05:6214:d6e:b0:8e8:7de7:ec20 with SMTP id
 6a1803df08f44-90cb77fb882mr44584586d6.4.1787642633883; Tue, 25 Aug 2026
 00:23:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1786088695.git.petalzu987@gmail.com> <b58876297f7d45de008f2e94b6ecab8b2ed84d21.1786088695.git.petalzu987@gmail.com>
 <20260808194001.853434-1-kuniyu@google.com> <20260809123335.GA2443083@shredder>
 <20260824194741.215979-1-iprintercanon@gmail.com>
In-Reply-To: <20260824194741.215979-1-iprintercanon@gmail.com>
From: Zixuan Chai <petalzu987@gmail.com>
Date: Tue, 25 Aug 2026 15:23:42 +0800
X-Gm-Features: AcwNN1V7fPWMZRWXGdq9p6gRwqiXR-NY1tN3vV0gO8XykdUJsoEnFBXTgKeFLNg
Message-ID: <CADTzadL++bLiuYUrzDYmTbEf+bb=hkT-bxBQYCtxZscF5Z6oxA@mail.gmail.com>
Subject: Re: [PATCH net v2 1/1] ip6_tunnel: snapshot encap in xmit
To: Artem Lytkin <iprintercanon@gmail.com>
Cc: Ido Schimmel <idosch@nvidia.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Eric Dumazet <edumazet@google.com>, Ren Wei <weir@nebusec.ai>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dear Artem,

Thanks for the detailed feedback.

I agree that the RCU-protected config object is the better long-term
direction, and it also addresses the control-plane issue where a
rejected changelink can leave encapsulation partially applied.

For the immediate bug, my intent with v3 is only to keep a minimal fix
for the transmit-side crash that seems suitable for net:
one packet uses one consistent encapsulation snapshot in xmit, without
trying to solve the larger config / lookup / synchronize_net() questions
in the same patch.

I have already dropped the headroom change around t->hlen, so v3 keeps
that line unchanged and only fixes the xmit-side inconsistency that can
lead to skb_under_panic().

At this point, it seems there are two possible ways forward:
1. take this minimal fix through net for the crash, and do the RCU config
   conversion separately in net-next; or
2. follow your proposed approach and address this as part of the RCU
   config conversion.

Please feel free to choose whichever approach you think is the most
appropriate and elegant.

If we go with your approach, could you also please keep the following
attribution tags?

Reported-by: Zixuan Chai <petalzu987@gmail.com>
Reported-by: Vega <vega@nebusec.ai>

Thank you for your time and review.

Best regards,
Zixuan Chai

Artem Lytkin <iprintercanon@gmail.com> =E4=BA=8E2026=E5=B9=B48=E6=9C=8825=
=E6=97=A5=E5=91=A8=E4=BA=8C 03:47=E5=86=99=E9=81=93=EF=BC=9A
>
> On Sun, Aug 09, 2026 at 03:33:35PM +0300, Ido Schimmel wrote:
> > It's on my TODO list since last week, but I don't have the time to work
> > on it right now. It's a very large change (see the geneve change) that
> > is needed across all the IP tunnels, not something that I consider
> > suitable for net.
>
> I'd like to pick this up for net-next, unless you have already started.
>
> The shape I have in mind follows the geneve conversion: a separately
> allocated config struct hanging off the tunnel under an __rcu pointer,
> holding encap together with encap_hlen, tun_hlen and hlen. xmit
> dereferences it once and passes the pointer down to ip6_tnl_encap() and
> the header length helpers. changelink builds a new one, validates it,
> and only then publishes it with rcu_assign_pointer(). That also stops a
> rejected changelink from leaving the encap half applied, which is what
> happens today when ip6_tnl_encap_setup() runs before the collect_md and
> duplicate checks.
>
> The synchronize_net() in ip6_tnl_update() and its siblings is a
> separate question. It is there for hash coherence: ip6_tnl_lookup()
> matches on parms.laddr, raddr and link while walking the bucket. It
> does nothing for the header geometry xmit reads, so it can only go once
> parms is in the config as well and the lookups dereference it.
>
> Two things I'd settle before writing code. Header geometry only in a
> first series, with parms following, or everything at once? And the
> order: ip6_tunnel first, since that is where the report landed and
> ip6_gre builds on it, then ip_tunnel.c for ipip and gre, and sit's own
> copy in net/ipv6/sit.c after that. vti has no encap and no hlen, so it
> needs nothing.
>
> If you have notes or a half-done branch I'd gladly build on them.
>
> Artem
