Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.176
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794173498;
	b=yI3LGR9TCMf9yhRtWmoE1U+KKm5FqnBSm6ZD0wCH1IGzreJJkwakBjiiX4xPzUmdOqlI
	 YBc1X6m6NHKFIwoqCyxSNgIo4HQdmwjl9Jx7sfypkxpFjMcDSYf1c1t7U9eJDa8Ep+K3a
	 tcSo2ezx7/zJ4lkDNmup08BrMwovcWUY+62KotHcUJcN80uCuEp1l3oTLtpviA4J2Nipb
	 DzOQWT+usGdhE7kqYD4Cfls6IVlkmQpaquI5XKEY5eCyCD3SYQGcnr5339UqApq2eMJfd
	 fQrD6fOOVwV3ztiFHVPms+tgM9cDEZ3zIxd+vw0QGDfDDZmpjohrNm/voCtNCNsjA5g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794173498;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=mNnSytHabs4CSN2sn2OhzEVzq3LVe6ObrYpizxNtHsM=;
	b=HcNQzOtM40JUVQWFALQBC3kzwHPnuH1i4OgH4Rk6goxV1L+a6KA6QU7XAwYVpIfpXL06
	 U40uJnmdkSOrh+IVcw8Zqr+HLDOX2ZYY/MPChVkj5VMhpjJhP6kfWC99koxejGnDYeioM
	 HztiMZ42TvNFrZSaDz4VTxkOEz0zzCpkExobxw5t5kaB+pAhSOp9trx/xEH32OvX+G/79
	 ob8yu9nZZBnOpPHzmdrDgldmEpYbJvV0gSrS0kn2XjkyCpw10uvxxEo3id0jrcP54A5ET
	 CHsQUvYMeDB3l/4d5tBZ4x8fkgJN8I5bDtzhKuAoilg/BoEFo/jjHWwiJ91+qG3gr1w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SaNgY0wi;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.176
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65CB6606A31C
	for <netdev@vger.kernel.org>; Sun,  8 Nov 2026 21:31:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 65CB6606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SaNgY0wi
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-539a57a0b1fso69528b6e.2
        for <netdev@vger.kernel.org>; Sun, 08 Nov 2026 13:31:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794173497; cv=none;
        d=google.com; s=arc-20260327;
        b=ER5F9aWymk+MsGJC9f7kRQO6mjMiFMpPb/ACL7EZAFspytoIQJW3hPZtknle8h70oE
         Zs1Y5GrqjErvqzkb4wwKoB/fAgV4bKJCzRl3bxc/UwtbvhZJ+hajxRNVmOJCWS7QxAtP
         OX3ejkd1J2jlyVYiy3L4PGBelQQFrNS8Jf3aXU8lsGZUSBsAF5hGTbHQMxL3WUKj7mQR
         Bn14P3uBVqw5Faq1yVPjgnuGehPW+JfgRzufJeZ6iQpmb8rNvcRw1sSxepVaKg5mWioq
         hZggpQ7bVPA4RhderTuJyrEXKOFDLqEPlQvRZ5cI6FlxZUWQZ09Xd9prSAxxp7AGAapK
         S3xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mNnSytHabs4CSN2sn2OhzEVzq3LVe6ObrYpizxNtHsM=;
        fh=apboHd9+R1dvvCkJdZDZKmUVNsbKVTk7ZyeK9b5N4V4=;
        b=eQUwnLMsB2qz6kgUXAu0Odr+c6rjd/Jqh38QNXobj0+S1oEirTBbb47y7Aqo7/byBf
         RNz8q/TJnoWH/ydslW/ewyjnXqRdaukJn9HGxkEZOgRMLs59T/Y4T8DUVB48GshqbaH+
         8oGCPr337JUBJnq21spDFIyo90hDPDceujyhh16A5QNteTq98ZcEI13c4nqianCCMkmU
         mjFmEkaV/QONg48KgAMoa8KTuzj5FOL/bavtTEj/zFnIMxbgu8WA5+7TAdx9WzIPIOLo
         3CP6KVoErrgfvjNpoZOJQlmMdSyCszvkPeAnDoUVfoN428AfNIlAalGR7HZU5eXW+GTe
         Fgfg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794173497; x=1794778297; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mNnSytHabs4CSN2sn2OhzEVzq3LVe6ObrYpizxNtHsM=;
        b=SaNgY0wi61CAMHoAaSAQElsriA2ewO4xeY3dct06JAYBGplqD3C6/rek6GQ+oVhW1V
         c96l3/xt+NQ87IE2kKzyUC2egVoZkyzkRlIIJzKNijtNlJsI6TytrvFuQOTrS/kIQiCs
         MttP++uinY9OyXbMycU/YsPR/3kINXZF2w7XbDEX8JRWjqiagJ62o3+LIrskahKivXjs
         LuDenNmzPDb6qxKXf+T67kSCeN6+OWZEV6TK0AfHduSy+uRlVJY/adPJ+hPutNEE8QEk
         9uxME+zB1P0yQWN0JTWXMlCvV+J3DVbCyR7jdd/aubIZGtKQxQKapbarULmtBmqbOF7O
         7XrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794173497; x=1794778297;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mNnSytHabs4CSN2sn2OhzEVzq3LVe6ObrYpizxNtHsM=;
        b=NZKwrXQ8+6T51kRH5IXrP7t6cLjLUqwy2nb7KJB/VgquNEFFM2LtTx/N2wUkqtqNim
         z1b+eY9zsvclVeNTDZH5ebMESc+4s0KBXUWcQDA59zD/CeXd8NFMHm20GpvXAv6d2APN
         SixAalRtVdKgycMW0Qko7bTviB9u+rLsvdFPjjzdfZnqpmhXKeqNRSmzT19Mpb4GWYDn
         3kitcsUdT+4er18NPBTr4W0REwQ19pR5GpYvSVlhQc0fAcWZoAvRujH/wdBQVsLJnlbr
         OPY35LYqyjQDRes3xSe/loyjguFwB2UYaQDRldgPCjpPqth+h+u0XW5HyAzI8pVjmf8V
         2nFg==
X-Gm-Message-State: APuU4Z9FNalUcGohMdB+d6ShdsMbyVziD+39qgcVmcQudANyPyesCPME
	3BSryzwfaRka3jRhFurB7xrq69uPuhHWiNFUusLHO+T+bI/ZP/4gl46wURR3mEKUaMrq2Zruxae
	uaHzafjsvdSX6bN8VLfL6FbHBIRBBHck=
X-Gm-Gg: AYBFou36gBOxIDDNaqBHvg30dZ1+D3AQ2wSj+GdVmUJSndj3u1maB14Tgil43vsBrcd
	wAQWc+J06+Qt7RprXwWrKjtzt893Jr2i7b19ZqPXYr/aRzk5tmUxTnksb74r8AUM1LAsbrna4AL
	H1oXnvGeaJubKfM4ar9RUKFf5KcBLHyGGlE0F47qxxE/Esk41Hz2jpJVgMzEgUCYwvzPEgXT32D
	WeUSBUPxDdzcFHS00D4f6qss+a2tSVnhftquwiLekxXZFcwWAEifcDHxUl9lh1BqTj5Pl5UkCn+
	vJgHv0EUBKfl9d7ZRcK1JWdfIuFHY0V8R1rAXQpRE1wrG/EWvjWfbAXxnO2XIsl2jsSRRXgjP3/
	ETG1Q5526Ep0r+e40QTQbFI/+LfYljbccGCcf4E/Fd+HxgrvVGR2FV27f/LJZjsjLp7iCvFII
X-Received: by 2002:a05:6808:bc5:b0:53b:1d13:dffd with SMTP id
 5614622812f47-568143a72e9mr1609971b6e.7.1794173497308; Sun, 08 Nov 2026
 13:31:37 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261108210357.1633411-1-mmyangfl@gmail.com> <179417201494.488859.17405768719520305251@kernel.org>
In-Reply-To: <179417201494.488859.17405768719520305251@kernel.org>
From: David Yang <mmyangfl@gmail.com>
Date: Mon, 9 Nov 2026 05:31:01 +0800
X-Gm-Features: AclHuK-7rjeMC6REsEvqypnWoJ8UWs35DflZP2w5x1Ar7W3Kfyao2q3Crk9apyI
Message-ID: <CAAXyoMPFUTnyw9+oR9_RTi0EA5og8zXt6C4pj2ceqMEwb9+GVQ@mail.gmail.com>
Subject: Re: [PATCH net] net: dsa: motorcomm: Reread port flags on bridge joining
To: netdev-bot+sinfo@kernel.org
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>, 
	Vladimir Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 9, 2026 at 5:06=E2=80=AFAM <netdev-bot+sinfo@kernel.org> wrote:
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
>    (e.g. found by code inspection). If it was triggered please include
>    the symptoms, like the stack trace or error messages.
>
> Please do not repost the series just to address the above. Instead,
> reply to this email with the missing information, so that reviewers
> can take it into account. If the series needs another revision for
> other reasons, please include the information in the commit messages
> then.
>
> The evaluation is done by an LLM so it may be wrong, if you think
> that is the case please reply and explain.

Reported by sashiko, code inspection only.
