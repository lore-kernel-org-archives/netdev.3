Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792553425;
	b=O+hgjMZ8yaA2ERSlpPCX+//qRx7MLcNsU4ZAM0fLer6GW7IxmBgIG1oogLL7wN10XpU5
	 2MlAKX2JfVsOfGYdyfeQ7sX61Qo4mARvIWB4BG1FIU7WBIyqkSfeE0nkIAN3rM0qfyemv
	 OADnsDFmFH2WxpQigT25YCF5vIWIx32ATEiiwMm0RliRbbzrsdIC+s9V5FlIqRULl4UTk
	 cjyyG6gDVMgEaGIlQUCVnjT7FgmmQtnreufHMbKMLKV2u0I0y2+rfhkYt+ViqeXvFg9Mw
	 0OCPJfOXGR216gVhGR9az9JbElfjc6mC7R25AWalwEXI/aK4Dw2EgZ+3+8kSVzjR00g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792553425;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=vecFCOQHROmeXH4sokveMTWRACIiaiI2LhMKJ0dafGo=;
	b=qsnNXcwSdV7ez31PwdUER2t3ZBAYMII9WFnIPcL2sRxUaRxg/EdjyIO8F3Y6C+0unZxE
	 G4PZVTfITaHW70z0WPm5HeK5YPimJKRKmJLd+pDy7JBj+WTb8M1Oymk+yHoOzgtuT2+f9
	 wbtBa0xz+sxQ+pJv3GqyMG0c+9LjJOh7JAsj2cixQFPZWb2q5LPt88Morn4Vq+E3LOM3r
	 rX+JdDx8vgp70SQJ/ZLlMPsGVdbS+eHqT+wmcqE6+Nt2MDlPZwN25sa21Dxb+bppRUpmH
	 M5geim04mjZFnJgnu5fUT7lNQDdwz0ShzDrc3AtZa2GO/EIEAi4XYcaXeZAJYeb1yRQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=CJrfkMPo;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.47
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD756606A31A
	for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 03:30:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CD756606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=CJrfkMPo
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5bccb867d6fso240452e87.0
        for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 20:30:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792553423; cv=none;
        d=google.com; s=arc-20260327;
        b=pPfP5qN9zyfxuJeptLpPH4Q7Rpd79zN+LiOsnD5h3RsgVELF/BZV/s3ijaI/IjsvOO
         5U3fiK+vlyLKj0/mtx/CUUmKBUMee0vAafgFIpLsrVDgWGZXu9RgSS2aDbwQwqI/Cndc
         UmPuyjIBx+7WbvbCLUlFdJsPTzgtLX1v3NLIFrk8WUAR6LZrwyM1XC6FTVFkLBcP8Zs8
         3ke3cBrzXQhmMN77Qejp6NFhoN96bOdhEl82pSeEAFbm7NsCjTRk349XWZwr/5VkVzr/
         v6xerjZ0I6BiwxVkILAGB5pdwGJ86KPIP9J/eeMUON/+J7JxncrttGdyiQ8idRXjNksm
         a3GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vecFCOQHROmeXH4sokveMTWRACIiaiI2LhMKJ0dafGo=;
        fh=0ttJMWljK53ZtUgu/KJ4h1yBj5vg8ALnYuDBUdhF7aA=;
        b=B3rO3En8GLRsANv9UpPYQXo7vPuwqAnb+F0vzOjYPUr9bRIyoiAgK7rWU/j+m4el7N
         kLTW7/BU2dejd2kEDUz8Tc0udNU/knVoQafD6WbiRozVNZZsY5J6pUjFapSTSYW4jlaG
         e04WYngfRudAcdPIwFEgk2zfGpOK7zuUhhrmfflPZiZZrYKlDc7MXCkMuG+vtFRtchZv
         ccTq5deYCR0mPuViQaLLGQlYvEj6fjeHIM7oblCNqzrmZJ3bZoSSSuh6sL1NHUGmFiM/
         LpJ+uClquRTcqkPahMFXPuyf5xZjkUXVuZSrqq4vHLZ4bWdB+ErYcWtM4moDHj/rlkwP
         ZS5g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792553423; x=1793158223; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vecFCOQHROmeXH4sokveMTWRACIiaiI2LhMKJ0dafGo=;
        b=CJrfkMPoLGIsWAVgPF+fNHyzJN0umzx5lrJcqUDCBjx43r4JbeRF33G1JlzON/jlrz
         JETZtdepjzA7jk6SFh0nFHowQMV6m1+wQ5Oxh8UlMUxeLUnaEZUB4unCojOJbS9l5IW7
         VvG71LA7nnylqG6ybAbEc6s/LVHQaw961PcIIw2/13F2oyo1XyeO9bCUrE3lDQh9OfCA
         7F5kNMsQxrK708wpA0zc6tXFAAuHh6SpaA2+pHz8vEaI0oWP+AfY+FaQhgBJlP6cx1lV
         kpU2mR3QLeFyNtsuVsXl/OOiQJdl4fIJTerLNXmdGJZ7pjh79ID2IcVUg/Ydc1v+1pnm
         nyRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792553423; x=1793158223;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vecFCOQHROmeXH4sokveMTWRACIiaiI2LhMKJ0dafGo=;
        b=zaDNfdB9nCTen9rBhQezSaR4YpSFdIUAMAj3nYxHUuDGfZ103VqY8JzEGfIF76TrRk
         z7Ffhqy6JU8XN9L052SoiEpy0QyqwP56YiOE0qGQg/C+DZxIN/SCxTqIc0/qLq6yYDGs
         Eai6wdUJYnl76/bCxBatv3zrE4BKqgYY22aNwYBjQmPF87zYquRtEyLmZZyZnCziNTwH
         Ab/uYqtvHpRkDe/HqRe2MktVInhFFsI6HpQDh5lv1WaSNUfXmR3sWk/L6pWQfjQg3VFu
         NyB2VYY4U0PcJBD8wo3ClKP4pg5woAkl6qwDHcEeZaMSms5R7Q04RKmKJkAyJnprYlvj
         pr4g==
X-Forwarded-Encrypted: i=1; AKwUvBzJ8GnUv+1AfO3uaCzhJmm//hlJmvOD2F7rYTDT/AxZ6V+L0YhH/d9bqWk8J+zxtICrJcQ56RM=@vger.kernel.org
X-Gm-Message-State: AFq9FYLrUn0hxMVXyZ1+sPtP9XE/iHS+ia6PAWfYIGiqQAr4bx0dPOXI
	4By8c2B71InpotXc/vwB0y8XZmwk/XOVEF7GW3+GhDsaHpBBQI+P0yDl5u/xyuijryp241ZySaf
	CVOfqzPcLLLDTDLbUa8aX9BdxF4KQAlxHg+adDX8=
X-Gm-Gg: AYBFou12jVFYxlW2uCWhNiRlGn9owo4KPNt3faqNabvaTo0/FStIXaPGGeWDKC0CXV0
	jELs3dqhutEr4ELbfyrXStwEAll979aoJssn39kMs9QWT1Ikethprl/jGXsM6IRptTE85jAxSSS
	KRAujysa+UBWhtYEl20gKB5bVuX+ADYFUO/Ytvr2u4J8SRMK2aNIkC0+vMsGuXWVYttBJAdqm7Z
	EL2jRA0EIfjtW70wrcNmtAzQU1haZmzanO8sli8PnguAtUS+d5wCSb7FWNlmvaUo1PdpfyT2MMM
	pEP89bjDTHUP1YgxPSf2F0zN9gjDcrSIBcLhOpsRaYiGL7OFPv0/HCDVrrsMRB6kFWdOC70D6ee
	9p+ObA80OzZG81Gh1PFGTWAqYKFzP4atCkg0ZmqDc52zPWtavfmczvQgiWXuLIBMO3MRnbcSd3q
	u9pPGEbFzddhyGie49OrAQRwKqbiQndWbGlLeoDBYQ4JLupzooTAU=
X-Received: by 2002:a05:6512:3d94:b0:5be:3ed1:53cd with SMTP id
 2adb3069b0e04-5bfa1bf2ea2mr269978e87.13.1792553422723; Tue, 20 Oct 2026
 20:30:22 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261019230758.2960779-1-joshdon@google.com> <CAL+tcoBjWDwA+MrjzRapUeAom-4siL-cnXXLQrVf-A4myNRxyg@mail.gmail.com>
 <willemdebruijn.kernel.1a81a5aacc334@gmail.com>
In-Reply-To: <willemdebruijn.kernel.1a81a5aacc334@gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 21 Oct 2026 11:29:45 +0800
X-Gm-Features: AclHuK-0ckKCVs6VXksrv4_b4QVPbCKzz7eCkvLnHKLwFdezkMqTMA6m3Mk0B6Q
Message-ID: <CAL+tcoDDKrJ8aKrY_d3L48P4R7TauFVhcB03bHSpxzYFScH4Qw@mail.gmail.com>
Subject: Re: [PATCH] udp: Add noinline_for_tracing annotation for udp{,_v6}_send_skb()
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Josh Don <joshdon@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 20, 2026 at 9:50=E2=80=AFPM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Jason Xing wrote:
> > On Tue, Oct 20, 2026 at 7:08=E2=80=AFAM Josh Don <joshdon@google.com> w=
rote:
> > >
> > > We hook udp_send_skb() and udp_v6_send_skb() using BPF fentry program=
s
> > > to monitor UDP transmits. Both functions are static and have two
> > > callers: udp{,v6}_sendmsg() and udp{,_v6}_push_pending_frames().
> > >
> > > After an FDO profile update, udp_v6_send_skb() is now inlined into
> > > udpv6_sendmsg(), while an out-of-line copy remains for
> > > udp_v6_push_pending_frames(). The fentry program still attaches
> > > successfully, but it is silently bypassed for all uncorked sends.
> > >
> > > To address this, make both functions noinline explicitly for tracing,
> > > as was done for tcp_drop_reason() in commit dbd5e2e79ed8 ("net: tcp:
> > > Add noinline_for_tracing annotation for tcp_drop_reason()").
> > >
> > > Assisted-by: LLM
> > > Signed-off-by: Josh Don <joshdon@google.com>
> >
> > I actually mentioned this thing a few times before. The original
> > thread was from Breno who tried to apply a similar change for tcp
> > sendmsg. The fact is until now we don't guarantee those functions
> > should be kept noinline like how uAPI works just for BPF prog. What I
> > suggested was to select a series of functions in one Doc so that we
> > could tell people those functions should be noinline or whatever else
> > just for tracing in a soft way?
> >
> > Otherwise people would argue there are more functions that should be
> > done in the same way because they internally trace it.
> >
> > Willem, Kuniyuki, any thoughts?
>
> We'll have to review hooks on a case-by-case basis for performance
> impact.
>
> If possible, it's preferable to select hooks that cannot be inlined.
> Over limiting what the compiler is allowed to do.

I will initiate a standalone discussion via the mailing list with a
list of samples/functions as you suggested.

Thanks,
Jason
