Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.179
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794339367;
	b=qTrYeADDQ9UGV2UOrLXx55aJB5OHp6B8eKCE7erw/+Fp4F6fcHIZz6gyiWDDCgdyl9pD
	 d9WfYZGD6W+Dy012qGPeJXOpkE99F4ze5RLDGHcSTS6MSRd/ydDmjhcsIGpRpnkzZdlfV
	 cHlUlfNSZXCyPXOsZdfipydUDnAX1YUtDU/LKEWi7ieoPhJaNsmGn6QCK/+u1RkydmZWx
	 LHEGl3pVYop1AFbw4F20auQT7ImnMmqZ6+vDRFAe+WFVlTgYSYgibFQGc/d52WUZpcyp4
	 W0FZtWDlrgFXOfuqPZbgjg5FBoMdWmk6hWeVbnf5ZedP+BMTkWa8AU/F/cg4+d1/LGg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794339367;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=s0VB72eLXTyvzuPole/vzKEB9qpR7L66QrwnqKGfowI=;
	b=EQLUyPe2uEzQH976E1WplpbCBiogVrr4U45/7Z+cNtyk+EkJVRW4xIaqrMxpA/0Tf5gD
	 BljF40kNi3/LRtFw+272QM51O8J0frqV4eXRJq1bWeL2G8ZJFhCbzQxualg1i8WraVAev
	 OsNUhluc4FlKdxkiR/EN/obLK+18PAA4Oi1FZBi+8M9x7V2NjQq896ZjrpvqfPi7dRXoM
	 GpjbXPGMCnlNZpa9n1AdL08aZU3qy0JOL6xOWUhZkcFTQEMwUNaNs3liChLLlJHslo1NT
	 ew+Kz0j5FOfKshe4VEDiB6S7e5/RHU9mTgSM9ji3Nm1vjxyHCuTg7izBF9MKEHkshgg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=FWAwVzKZ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.179
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF843606A31C
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 19:36:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EF843606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=FWAwVzKZ
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-8b6399ebb41so2152873b3a.0
        for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 11:36:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794339366; cv=none;
        d=google.com; s=arc-20260327;
        b=s1mJdBiEMHUQtaeYCIYQqpL32l41LXEKEkJ+gqdBBHZoE3GHUs0k3zhwshuTLg4aUf
         gyQQ18Ek7hGvwAUUrMHygb15bEKK+q+9hApJ1NknS03ANBoOeXdN5p9eFz1agwhMK61A
         jlZdXACbeAOeWVq7oGTi3Iow10W9VG//8DLPoXrexSEhGjFODzU8V7x8lIuCzZ75pbqa
         B2/6tm9ce6cmeF1vGKORgdsImrZvN0jd0lPaIPsGUNStZX8yTR2JXAK7niMnLU4kg6sq
         d3BMd/uYm3SODxV7lA4QexjxkgeBfZ2+SJJajfUIGbtoun9dDI7FDaULPDg8SWWgveMZ
         PG6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=s0VB72eLXTyvzuPole/vzKEB9qpR7L66QrwnqKGfowI=;
        fh=zXbUNcArQoHlT0i8TElKvmsF/SW2v6NBb+ZfnMrKkQ0=;
        b=Y0FWzx456Dga+M8Bt8U1gGVoUDhdGmT1TABy5iH4xYYCpG4u/dR5raLMzfivqAIfXn
         hw7uH9wvJgVKmrrpz93fZeaBneNa/RfiVHBXK2WRtCLh+0JXprq6192vUZmKk/1N92Dr
         ECfJpC5G6kfnSAWBALxcoimhQ3I9jERl2v/+4FCEpwQ7Ku8CjzlW86g0WGW6u06JA8Z1
         CukpmrZ+zsDAbWq0rnGzZU3PEbY5CA3KfDPv/MC+2dy4tDITV+vL8MqiE2eQCHOQUnKn
         WEJD2cUt68TbQl+YGWfKEGTB9wgRa+Q21Y4CC+cZDOpPMr1fVQs+K/30YFhnpPDQtnky
         lVBw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1794339366; x=1794944166; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=s0VB72eLXTyvzuPole/vzKEB9qpR7L66QrwnqKGfowI=;
        b=FWAwVzKZccDp7rR7Dqn6k21AGZt6CMeyzuf6frtfr2tL2xrmbBI+mRJOq1iAVqKEIO
         /IufWCAXSEco+eNvr1X/LMMbdmFHvqfpiYByOMPTYb8uccJ7DGqJFTlXjr/GZWpqxuTc
         X9GbzJ1hNUuS3+efNTHEmEmoWhzKWUp2GGgH4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794339366; x=1794944166;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=s0VB72eLXTyvzuPole/vzKEB9qpR7L66QrwnqKGfowI=;
        b=TQ5kiIjuEclyXxf+FdhQ/1zftmoG4XBPtJ+p9vQ5ceQemHyne8vngpjnPGIuTryBZD
         8ZhAvm20I8zDHM4aNlpHev5rC5Gw62F+DhvCINd6CljuRlnWrETpoJ49xM+Elg1Nd24h
         X8HCpQd0dG2fw+VRK/h8H8KCLu8PtkcWPQdLo85C9ZE+EIJZQ1n+xDZPl8wHPlTc4naV
         c2piwoRiDhNKEgRuf5I14CARZIv1Tis5oRjKHZElQErcw81XTyzEUSeXk+H1PrBeUwIk
         jBbXlgJZrznLO4MhuwRf0mVBlbafmCiTk3G92wmLg+PfS9m8mZpgXADVrsAgY8OOPx6E
         7zlA==
X-Forwarded-Encrypted: i=1; AL+hErF7tezdpVTdjtbQGHjVjsK7H/yZ6ne35R0SarN1JqREhKfiEneOeOzTtWyDfZGmWov9FEUunfc=@vger.kernel.org
X-Gm-Message-State: APuU4Z/JBQuS6U+JIPeLK4zjNLNc6AOt0at7n7P1DES1cu0bAO0CH5LV
	4YHn5g3nHFDTqyOe0f/ViiCD2YXuyC+cRCfPS06v0R5hScL0yAsqaQLlCS9V9oyunEQPQBPu9C1
	LJf7AN1HmMaRDaKZrCFDej0wZUBWS0pRMXep6vSJu
X-Gm-Gg: AYBFou2mFWjIxJbFd8vO4mG53TpSG7jvx85zxwgbW9A9ij70d0DM3s2oNYTB6u0sqc2
	7lERHtG6RrPzWKK8oE+F0ZdGk7O832ZZh5nwRi8eCxu518W3PVMe+Luqw5895FeskhQ3as5m9fa
	rxngUu6oFEMT0l8+z007ai5op/s7x4G5YWifIwygFnyPDIelEj2Me1JtH9R7sMLJEgax7b4SQqA
	0sZSQhgexmR6Xco9hhxqy/a+7B8QxGQP7NzSyC2n0IYVwgiNdJQUonTx8fn6uXoBQNvyc2n4skK
	Yt6swMn2XEAS+DHP2zXzxtItAuxS/5vZwvVcfHYi6ulUywgmp8CkgkVsHep0BJxXHD8NsbgPTEt
	DXdzkpcCjpEGISDEZ666BvxsClKsVF3c0A7sjUcZcuueWUNRIwJkfLPSNdvEIm8bYmgwz4XHns6
	xlpejAqfgruvhOXM5kNpkBz1qKtxjbE1n4TTWU
X-Received: by 2002:a05:6a00:1482:b0:878:3783:8a88 with SMTP id
 d2e1a72fcca58-8bc1deef93bmr85895b3a.52.1794339366268; Tue, 10 Nov 2026
 11:36:06 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <QDISC-6HS9.v3.r0.20261103062649-2@mojatatu.com>
 <179406458348.994134.6942745655171316289@kernel.org> <CAM0EoMnprPstSvZEj+FKtK_kM6JB-jkrhYRwSd_mmN3WAMFQFQ@mail.gmail.com>
 <20261110101953.6f7b6dac@kernel.org>
In-Reply-To: <20261110101953.6f7b6dac@kernel.org>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Tue, 10 Nov 2026 14:35:54 -0500
X-Gm-Features: AclHuK-o8fCkX4IOORxCRrQKTAN4fjHo9n1O3UvNIUpEqwk1J7vVfGugUqKjSgY
Message-ID: <CAM0EoMm76uc8OXSzvMCSpodkm+8Q69q-g6UORiu5J7pFHd0Lnw@mail.gmail.com>
Subject: Re: [PATCH net v3 2/2] net/sched: sch_teql: keep skb->dev consistent
 on the arp-queue path
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev-bot+sashiko@kernel.org, netdev@vger.kernel.org, victor@mojatatu.com, 
	jiri@resnulli.us, davem@davemloft.net, edumazet@kernel.org, pabeni@redhat.com, 
	horms@kernel.org, stable@vger.kernel.org, sashiko-bot@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 10, 2026 at 1:19=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Mon, 9 Nov 2026 06:44:09 -0500 Jamal Hadi Salim wrote:
> > I think i missed responding to this one. Sashiko-nipa responses are
> > very erratic. For some threads (not mine) a review shows up 2-3 days
> > later. For mine the average time seems to be 7 days and sometimes a vN
> > review appears a few days later after a vN+1.
>
> Response time is based on contributor score, you are pretty deep in
> the red given that you basically stopped reviewing patches from other
> people, and keep mis-posting stuff.

Yes, i just saw my grade, it's not good ;->
Mis-posting was for debugging what was happening;-> but I admit to not
reviewing.
Note: I still review credible submissions (such as Alexandre's) or if
one of you guys asked me to look at those (and what Victor posts as
well).

I stopped reviewing the drive-by AI patches because the returns
were/are low. My cost analysis shows reviewing and chasing someone,
testing, etc., takes about 5=E2=80=936 times longer than knocking one of 10=
0+
issues i have on my plate. Pre-AI there were much lower submissions
and i would review to encourage more contribution etc. But now it
costs someone 30 sec to send a patch and the count is just too high.
Worse, a lot of these patch authors just disappear when it comes down
to sending revision after revision. But my main motivation is a
majority of them now get their sources from sashiko "pre-existing
issues" which we are already collecting, analyzing and sending fixes
for.

My suggestion for the algorithm:
dont give authors that just submitted a high mark just because they
are new. "New contributor" scope has totally changed in meaning, I
would grade perseverance as a high mark. I just sent a v9 on one of
the patch series - and back and forth for over a month, I  feel i
deserve a better grade than someone posting a patch and disapearing.


cheers,
jamal
