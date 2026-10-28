Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793206717;
	b=mcYnU3bep25MqPBMDoACRCnY44aGfi8Fsg58p4qdxenydZs/h3J/CM4UEyoyepkJrX/o
	 QQWyOpbPhJISpcxrJrCM53D5I3uuP3c87+foBOLfaTw98Zl7dIt7j5mCwTw3QzDfzEu9/
	 YCWWVJacXcv3H+OKY2HS37P7/sV5gTLdpWCsXwINeO2o+300SzJ5jjl1u5XNRCZvcIpLR
	 F2OpTG1jjEr5EIW/sGoWKaQDwrlcSQu4wWw8lsMJSg1le01UmuJIOKbeZ11BEEq5JuIXw
	 2XKfkQc/uAGGTJSWnjXsohDwpdP1fPAIVlg3gGJQuqAilyOw8v01Yz6xAKZ2LEZpQDw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793206717;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=ofD1f6oQnTuXn5+ZWN9fgQFsKj7OpffaK+7o/04+4t4=;
	b=PHPhTTFShS/WVChpXruLev0TXTxo2nvObcG7p3j6BmZJwW9T3WgX3cDZsoWyDtJIXLkL
	 IjhMwe2zxMhZITeo9hosEFlKuUVIEXyA/aGYAbMiAugAUr3F6n1E1N2HyPk1mt8TMTsLx
	 k2UsfzxBwciccE0u66Xq0QMOBsYmSW/Y6a6nKxXaTtSvVSWVQs1Nk4dqZKUNqdSG5JNNe
	 w+v2Eq2uFQ/EUmCGxq54I1ewfcQfUop41B9S83oDwBk9+F0wkJDW3xOHr+EDQ1bz+wsQk
	 rC+Zyma2GOC30egSqhuMm2+ggpY9T5mx5OSi99HXER2h2g8XAiOiZPa+P+2mvs8UBew==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=octane.security;
	spf=pass smtp.mailfrom=octane.security;
	dkim=pass header.d=octane.security header.i=@octane.security header.a=rsa-sha256 header.s=google header.b=fZvoaGfs;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.54
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1A5B606A31E
	for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 16:58:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D1A5B606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=octane.security
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=octane.security
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=octane.security header.i=@octane.security header.a=rsa-sha256 header.s=google header.b=fZvoaGfs
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4a549cd7fd2so11773945e9.0
        for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 09:58:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793206710; cv=none;
        d=google.com; s=arc-20260327;
        b=K8P5QLXB6xqjwG4sznA0ExFtCXCkkf01y6WUcXO4L51qR3eN6sjjEBmizbvhM5QtCU
         Oh2TWrROez7hxa7zPIiAN1NVSrJYHWUOltg30NBXAcCHVOARe8IaviDcgT2tHZmxwv3k
         6eCT7yvxTb0dThlQFzyuAxl7Fg4gWzKbu+OiUZP0mQQbRrJZza3WcF/BxgeOzf8pnHw/
         PoeyioshuuivSi7YsApH0bX511HAbKn0vYAx21VVDGL1aEzNx7wJETdaHNsDYc6gbsHP
         Hydw3QZL6LhslwEX+dNwtiLjCLbga5VRdR88fZIT66cWZz8iJqBhAYuQOAInoiBgk57u
         whpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ofD1f6oQnTuXn5+ZWN9fgQFsKj7OpffaK+7o/04+4t4=;
        fh=pbweQBlHfjI7rSLnx3wiROfmuBn6m/Xqb4rD6To9iQ0=;
        b=F/cyA+keHmZk06+appv+1kV2wZUNp/xLcjXwgGvUKpbmMmy/r+AbZEzOoBEYgbl5CJ
         3XQLYXcEo2Yw5vVlEVTDFYAP5AHQmWfVTqJIYzigN2xhxG2+CiWrsRuOVB2IZgH0SuRO
         U3u+JGtnFIRJCB15+vghIR7tT3HsODP26yVbn0Ukkqg0Xx9v5DezncpxHf0+fuHpbQH9
         e3FjCCNq+qNVbIR+5/tRRXSUeOC5jJK4IE9qAwK+KJACfpJ+qkR4D89dZI05GH415fT7
         N0/RzL+22HuqKzV/OfZfGPeYQBaoIgALby2wzeR8Ccyvwz2Dd+NFFfacSx9Gf8aG+oae
         yFgQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=octane.security; s=google; t=1793206710; x=1793811510; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ofD1f6oQnTuXn5+ZWN9fgQFsKj7OpffaK+7o/04+4t4=;
        b=fZvoaGfst6ORdRvAXEl6UJOkgc+9JvviynvCVVu/XF3BDJg3hzeWOZGaWUWgEmv6ql
         kJvYmnb+wzZaLWgaXotDJ7M3Okfv8MuER0P4BLUeyutUCTXG0Y2H42G9AkT3S+xQNLs4
         KkOUHVA4dXY5OXy0YyiyFsgq/mFXkACYV4vXRkyLnN4za0ODXIatIi/0Yo4vw9+3Ydeu
         8sxwR6/PF1FMbOQJyw8M9hp1GDN/JvmW0EBr3svYt7Pr0LRnFDBkUQ+lK8Og7+4U5Oex
         C5scxx8MHV1T060uR79AwebwXajsa24r9e95x80McgDfwf0OV1X3DJOUeEZqZNB1d9OO
         ngCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793206710; x=1793811510;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ofD1f6oQnTuXn5+ZWN9fgQFsKj7OpffaK+7o/04+4t4=;
        b=WvesTl14+8vZEmG7ThUltpDx/BotJ7shKHt1nOAsE5qm/5DKmddE9QNsNsQ9/O9O0v
         2F2dZVR7ufde50MleBESb/KL8ZaT2tTgfDqIzG7EJppMpMB17exOJ9QNHl3fGY3z6gpi
         +BZ7RY/aPQAwLeH0VwjqxQGFghEXirKC1yZI6tOHJ5IcuPpEjFqXEodApdXUWvOM7hNF
         pcj/52ij5AnLub54eK+PCH6vU42+AsnM/7EML127S5G0C9mn9p5imHa4prLyHYSyOr99
         ibVZszEcdskO/SVSjwWZrwm4N0n2VJU1tU9ymHBm/MBcOb2XZZJurwNjyIgOcJNenGrj
         /qBQ==
X-Forwarded-Encrypted: i=1; AKwUvBwMkHERn3LHOJlW8azmEmUqM3SN0lD2BN36to3Qu1VSmTdwwOA2FZ7nHSpf9rWR0NSu8hceLhc=@vger.kernel.org
X-Gm-Message-State: AFq9FYI6+oTmJTUjCJhrA9e9zVvY1y0Ho2B8X0iuI3za/ouiQA3gQ9Nl
	UBcPn7tRws4Fmr3ct0cMyv9YIu5Lj18T6t7TDQt2mFg48ihce+XFcoTjp4I5i8kFKCCiymDLqsS
	JL+B0/Y+or+6/ZxmPvmZXQpOZdWpLku4zr0+1ecqXIg==
X-Gm-Gg: AYBFou3niQVLQd3nsTNk+vB3EJTaqVlArV3LH/Z2n1G0jr8zGMpRIjjXE2JEQjZHI5D
	wWbhjV4POBYVEWC5xDMDxfltM+LbZk/ScSpwvTSsESoO+/RnH65+u2EFGlaxlI2UZo5iTRGGDR1
	wDd+b58sprNQpUME85kzJpUNAzwmpI2bGEusFXN4pE9CqvH0AkaUT8srvIZs34MWnioh0TObL2/
	AYBM5Q6esiOmQno+Ms8kMv0wLrLz+ks6h66UDiI8Mb6uncZLazL17h4ksbxsVJq3mNlxLL99uDK
	kflZ4vNVzmEktwukQc/O2TYdMzlK6g7XPstkY7dKSjRjDnJjUgExu7JNf5/0awpGFXKzjTu8TVp
	hQO8eNZ9gN7nFRvdspEYlFgaL51F3Fng8nd3qEBscyABRfLzmixfrkP33iDlyy1lODZ8pLXsLpe
	EQbQ2xSN/8aJcr62yVLoUuTaR6gw9vU6zrsC3ue7qBo1KRcQ==
X-Received: by 2002:a05:600c:4445:b0:4a2:526b:d40f with SMTP id
 5b1f17b1804b1-4aa83e0adefmr4884485e9.0.1793206710235; Wed, 28 Oct 2026
 09:58:30 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261021032443.44412-4-shubham@octane.security>
 <179290103732.3134.18298634182061634234@kernel.org> <20261028164349.GA257209@horms.kernel.org>
In-Reply-To: <20261028164349.GA257209@horms.kernel.org>
From: Shubham Antil <shubham@octane.security>
Date: Wed, 28 Oct 2026 22:28:19 +0530
X-Gm-Features: AclHuK8HPth5FoQdhYFleU3o7yVQURAnBdI4t3AFjYlVmMJjxx-cf02cRxHSgng
Message-ID: <CAEBzjKGrrBhOJM01D18AURz=0m6uOe+G6fpXZzc11h4ui_MqwQ@mail.gmail.com>
Subject: Re: [PATCH net v6 3/6] nfc: nci: uart: quiesce callbacks during teardown
To: Simon Horman <horms@kernel.org>
Cc: netdev-bot+sashiko@kernel.org, netdev@vger.kernel.org, david@ixit.cz, 
	oe-linux-nfc@lists.linux.dev, gio@octane.security, stable@vger.kernel.org, 
	kuba@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Simon,

I am still looking into these issues and will keep you updated.

Regards,
Shubham Antil

On Wed, Oct 28, 2026 at 10:13=E2=80=AFPM Simon Horman <horms@kernel.org> wr=
ote:
>
> On Sun, Oct 25, 2026 at 04:03:57AM +0000, netdev-bot+sashiko@kernel.org w=
rote:
> > Thank you for your contribution! Sashiko AI review found 3 potential
> > issue(s) to consider.
> >
> > Critical: 0 =C2=B7 High: 0 (3) =C2=B7 Medium: 2 =C2=B7 Low: 1
> >
> > If you believe none of the issues are legitimate, please reply to each
> > issue of Medium severity or higher and explain why the AI is wrong.
> > If any of them are legitimate and you plan to respin, please let patchw=
ork
> > know by including "pw-bot: cr" as a separate line at the end of your re=
ply
> > (one such reply per series is enough).
>
> Hi Shubham,
>
> The text above requests a response to this email, and similar ones sent
> for other patches of this patch-set. And I would appreciate it if you cou=
ld
> provide such responses.
>
> FWIIW, the Medium issue immediately below is of most concern to me.
>
> >
> > - [Medium] When nci_uart_tty_close() tears down an NCI UART whose NCI
> >   device is up, the NFC controller (NFCC) is left running in whatever R=
F=E2=80=A6
> > - [Medium] Baseline decision: fixed later in the series.
> > - [Low] Baseline decision: not a bug in practice.
> >
> > Pre-existing issues:
> > - [High] Pre-existing problem, not introduced by this patch: during a
> >   Marvell firmware download, the UART peer (NFCC) controls a 16-bit=E2=
=80=A6
> > - [High] Pre-existing problem, not introduced by this patch: the Marvel=
l
> >   firmware download copies from the firmware image at a peer-advanced=
=E2=80=A6
> > - [High] Baseline decision: pre-existing and fixed later in the series.
> >
> > --
>
> ...
