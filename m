Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794489807;
	b=Hc0HuD0NYaK+vHEGt0CVF9dzMIZnxdBvDIsHJJrqlQyufaGyGrfPZ/MkMdY6RkewqJkr
	 FbFH7lk/m9yPuS24NEmXINY3NeQrqQbOITuFofYGe3v5uLIWo72d2+P7iYMHKZWQ3Lof7
	 kd/0dCG//l1cWkTDHXWlxVR4hBipZHYtjLhV1b4kOvVL9n+71v0XVfqU3o1MXbuz3aHtL
	 bp7fHMCm29hbihVtzM5QHCK2fVwR8jauPKbpUzOdlhI3fFnG0ju5rNtpp2wyi4RmvCam6
	 x+EUqI0EwXxXpLMV3iVZ/AUTpjnmKeXjG1nUpHjyhZ7F9OT+aoDKCAN7r9b2IjX5BKw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794489807;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=ghFbVMi6rgXawixTzgsSQ5cbDCjPINeM9K/QV7YYUEs=;
	b=y3OAaxltR+gXlQ4fC2YPeqQ69kW4QncID9As8QwFqS3FebrxF/JaH62J2giYSaRfCT1U
	 xhIhQK7VWyOiD5HJiqiysm5n3CwPGHVUIvPWEA3oFAvC42KBxEXYf43SGhJGh6r3V9L9u
	 c5p6Tm9pMnNkORoykNbEryIvg+hIFYsUE3qL+6mvq487sxXIfNzvPc7tngisCNFBQoAgH
	 Cvam5sJLnC2R4HfLr4NvsyKFgZ+Ry8W+I2nXJJmuZPSXLGsK/yEAxo3DPyLMB5zw0eu+j
	 IzqlOyITsd5aFd+d77uFD/5WBPy/iewe8lZMD7SGg/6Ssa7QV15/C6j8JWDEzHvm7rw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=u7CNYouD;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.47
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21302606A321
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 13:23:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 21302606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=u7CNYouD
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-c169ae1cb26so152226466b.1
        for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 05:23:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794489805; cv=none;
        d=google.com; s=arc-20260327;
        b=VIxcLyS1eHuAsz6aUy2j7u9hxSpuw5TDPMqRZfQFAaU34UbCq0hYTk92rpqR0BrZRP
         cRnxqpTj4ruYPaFDoajsf6ueKhB5qZFsO+gJcpfdMw24B3iAkGZXmO2dxFnigxG8/e0r
         V5dPgKhStgvuTaApQ0OGiB8c/B/ZrDMPGBSGEqR22pEDGEQ34M2RZDuZHorYrDEscCzK
         h2pzLMdDKRQCm+y6dDqLesQ5V/Sv2uQMnTeCqzy0zgttNYsH8ncOID95QCDjL9XXaG0x
         mytRoKXV9jwd/J4u9HFJOSEVwlnLEmcuadVXN5Qc25NO4Aq7HOa09C2YNOrJecrL8sX6
         Hiyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=ghFbVMi6rgXawixTzgsSQ5cbDCjPINeM9K/QV7YYUEs=;
        fh=ABrK3X9hIbERDGRQJTXDFdYjVPTu/LC4leZ2nXb7ujY=;
        b=DrhHg7JQhtBIZyHxxGctnQklaQNmDQbPoScinMF5iRXJ6RkARocs2wUiT2WSmSmq73
         4hnLAQZEmwTAPiRMHXtepU8RjPCc+c5/4GUGbcW4/knjvCZjGnegtmu1wy7QuoP9R6sp
         8Wndf0fOmiK97sHjnVoC4U/Xvs4m6SR3rZ79YX36Ua2aFS1wGFwGYsX5/kPldpNWVaSF
         hHYc3velluXxW6aNFhKe0Ew9Zrrcf+rVVHgSmJFhNiBTutsF7pU0qTg113ZmD0BFJtsR
         WtPxH0Fi4u2mD1kZ/JVlIfJK2npL09I1ycJi/eKBrlHUdyBEBMdH8h7a2ptOF4cc8k/0
         flcw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794489805; x=1795094605; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ghFbVMi6rgXawixTzgsSQ5cbDCjPINeM9K/QV7YYUEs=;
        b=u7CNYouDxtmkklFnZqQCQAU5YV0At+t5CI4iCxPZMku96NHqtVKf11c9d3bi4TNt3C
         cAgC5zPRGsKtCwvJAS0jhidMMM7illgLiiUs+X2zQQzo0K99wKHBOTYPdeHkHxC+/u4b
         xbUkSbhnTm7heHz0ZDuZPz/hiYyeeKyiB16aSm5KM+WRNQE/EGsEBGBqsyKgh09kgFZl
         8OHsMs2fZ1auB7hHUv8pXFAyekFfoeAKhVGx/TVFAocR8T5BY4q3ICnPifaEuaT7rd/L
         AR7IrBopgsUFEfs8T0vpPiVSTKibtVW+i44YdEraYXF0rWEuema7/YmtLWrCVM84Wjn8
         hH6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794489805; x=1795094605;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ghFbVMi6rgXawixTzgsSQ5cbDCjPINeM9K/QV7YYUEs=;
        b=CyH4er7MKfzes8XMzmJ97kOxQaVba8xNxrPqiaNO0HsCQ4llpqcmYVgILT6T2P/39K
         P38dOTe7/EWM+xlNN2lYMmSQLI8/cAkDJRN+eJdIGQ8H//esmIAehdcZjGst6L5fMsA4
         LdtRJ5IweGnVrMHcAFgwR0PvDtf/5n/tPtFcwH8G93rsX6VLQTCzFb7PmUeYfjXY7+NY
         7Sh6roDbKoqKbLWsc59jheoWmf5SGG83cDOj1TRICZvdzW8310RYShXtxVyYO9x8iZ4d
         Vhcdhhd4QRrHuC/165RUyw+zzXCsoJaXQn6FL+71EmWvCbqViN4xa+IdQaKKKtllH128
         2+GQ==
X-Forwarded-Encrypted: i=1; AL+hErHz30M99nXjRiggT+47ImAxlI/n92B24vtirH0/QCe6pB70SrAB5sll9UUPNo9F+fH5eyr1F2o=@vger.kernel.org
X-Gm-Message-State: APuU4Z8zOaGxG9HG+T+k8V/SiWjCi5lrBfWAb6hGYE93cV+gHJkOUP08
	dwVwye5FuudBH2lBPSbraw6O5OBFOMGwfZ9U7vJgLuPR2XFpfNKxpRpOhtaoBSu3VOIvRfPoorW
	gWhQ3lCOoJ2QHQFkJHIu4hdx+ArP06iE=
X-Gm-Gg: AYBFou0ts2jlVGPtaPmAI03qNUk7PBG9v01Kfh7vwdgV+Fo9qCEwlmParCnNeXS9Lcf
	J5PmEpAuqZELnwdsmGJ4J+Q9zlvM03u1wiYyJxfQEgkcYKi3oHB3EcGxfGjEkc3uHrN5NpWtdv9
	BOxovjjk7Bz3cVubpDO+OeOKBn3bOVJ4ESUUcnKefCPILqmg0uKxMwoLpEO/AnEnzLdP3hi24BI
	RyivdFRf7JZfBJuQ87nhIZqBMYc2Kt3HR9gDngLKIhB9m1p5yVK+iLK5Xoq7qtrE54/8ds1tqnM
	Jo2m436rfcJwZ+dayoaePqJYkGbNkCh/xLr+cfu5729OP4eh8KQTKT6QTAEJZDV86mea0gqvEar
	a9xNDAjCIt6uMCIxRQfhRtFg3aaUPufVBvpDutEgQPaOD5h3N2dPqBkc1Raxxs63Wm10otEGFZs
	KW
X-Received: by 2002:a17:906:478f:b0:c4c:c62a:b9b3 with SMTP id
 a640c23a62f3a-c507bc36f03mr224064866b.22.1794489805492; Thu, 12 Nov 2026
 05:23:25 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261112131056.234801-1-skalpesh942@gmail.com> <179448937301.2168702.18016211527226138253@kernel.org>
In-Reply-To: <179448937301.2168702.18016211527226138253@kernel.org>
From: KALPESH SOLANKI <skalpesh942@gmail.com>
Date: Thu, 12 Nov 2026 18:52:48 +0530
X-Gm-Features: AclHuK8Sqa4kefaWDnU4gXlBaTY8QTlThLLHR4_5ohyhfwkoqXKCWby2azhF0VU
Message-ID: <CADYuhkri8-W86GJeqa9D5yrYk13rAoC0JMV+XGUKUPmUw=GMng@mail.gmail.com>
Subject: Re: [PATCH] tun: disallow setting ARPHRD_MCTP link type via TUNSETLINK
To: netdev-bot+sinfo@kernel.org
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Jason Wang <jasowangio@gmail.com>, 
	Jeremy Kerr <jk@ozlabs.org>, Matt Johnston <matt@codeconstruct.com.au>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

To provide the requested context for reviewers:

1. Discovery:
The issue was identified via code inspection of TUNSETLINK type
transitions and mctp_known() / mctp_pkttype_receive().

2. Triggering / Symptoms:
The issue is triggerable at runtime by an unprivileged user in a user+net
namespace:
1. Open /dev/net/tun and create an IFF_TUN device (registered as ARPHRD_NONE,
   attaching mctp_dev).
2. Call ioctl(fd, TUNSETLINK, ARPHRD_MCTP) while down, then bring link UP.
3. Write a packet with ETH_P_MCTP in tun_pi.
4. On ingress, mctp_pkttype_receive() observes dev->type == ARPHRD_MCTP
   and invokes mctp_cb(skb), tripping WARN_ON(cb->magic != 0x4d435450)
   because the tun-allocated skb has an uninitialized control block.
On systems with panic_on_warn=1, this causes an immediate kernel panic.

Thanks,
Kalpesh

On Thu, 12 Nov 2026 at 18:46, <netdev-bot+sinfo@kernel.org> wrote:
>
> Hi!
>
> This is an automated message. This series looks like a fix, but its
> commit messages seem to be missing some information:
>
>  - How the issue was discovered, e.g. hit in production, hit during
>    development, syzbot report, manual code inspection, LLM or static
>    analysis tool scan.
>
>  - Whether the issue was actually triggered, or is only theoretical
>    (e.g. found by LLM and not proven at runtime). If it was triggered
>    please include the symptoms, like the stack trace or kernel messages.
>
> Please do not repost the series just to address the above. Instead,
> reply to this email with the missing information, so that reviewers
> can take it into account. If the series needs another revision for
> other reasons, please include the information in the commit messages
> then.
>
> The evaluation is done by an LLM so it may be wrong, if you think
> that is the case please reply and explain.
