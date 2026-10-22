Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.53
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792656269;
	b=QjgovhXzSNI5Etg5tcvi/AVUXcgt9/VpIFYzgECqPbDJLdcCwm+Qz8M6Sz7ICbm4EvAU
	 E6moqSK0PTREsWvhTQ/0V/VbQDYZsbtvLgNNuWVLhT8nv8+Mc0BS8otc+8YWPvdAQxmkJ
	 KkfglrScCqstvQY2xllDSXloj8U/BVles1Z/3qdmOv5gzNQJMQxK/yC1nfNqUa775Mcms
	 FhgFBUnVeckHaBCA+7tnxyKt8iB2VXt6H2hRDRCwqf49gZu2lxag3hZGSTgf+FGc4YK3w
	 2ZPsG/0/UXdRRiKyeEB2K+EL51Gv5qifx2JPI2w1nBxTctx+h4cbFBLeOdYEp6SJIog==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792656269;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=UvDK0wI43J9wCVFly8Sel32okFV+wP/02Pa6wIx7AmQ=;
	b=ofoPQGlmVAsnxfga9Hs7cnVAPnZYw+6NuELyBMJOcPvP/nvUsGdSi2vmMshHm0cGf3z9
	 8XFEBqwUCJaj+NNUI6wgiwXKmi3LYNxg5v1/VEemEVXaDW7EgmJCA5h6/y2vlhzH+jpHA
	 NIzloEOH4AgtN0nDgpTtC2TjrG/9n+vfLLvWDTa/lhdZfrOLohCq8kBIfCiqhCtGbCI53
	 +CmJM7mAMcgsTvUX3fddYBsQL5d9R57QTl9yCjcZWyYFnMCC4agHPJcL6P8J1wqcnkXj7
	 qa1ULi0g8wNJ3vNziRBCBXKChuvaszldH4pPzcfUw6159b7air7wd7mZWTW7Rx/lQ0w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nebusec.ai;
	spf=pass smtp.mailfrom=nebusec.ai;
	dkim=pass header.d=nebusec.ai header.i=@nebusec.ai header.a=rsa-sha256 header.s=google header.b=M1i9kRr2;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.53
Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7372B606A319
	for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 08:04:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7372B606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nebusec.ai header.i=@nebusec.ai header.a=rsa-sha256 header.s=google header.b=M1i9kRr2
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-6798eb0d13fso1826454d50.0
        for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 01:04:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792656268; cv=none;
        d=google.com; s=arc-20260327;
        b=imzF0QdqBaha68sRacU3FIodBQFiepDO6QCZ6O3AyqGS+wAr05lITHgmtufWt8m/HV
         AYJTM/soD9Nk3IWLLkkvXHTcFefWBjHzDSGDa+CYq9gDv0r6OlJe4VT7pUXVooHY5clw
         dhstQA3X25iQ0d8HBzugdI3TTQ9+A/W79JuRBcj949z3mFwNSgDikgKoAjeZfHKTthwh
         YAH2elG9E1eb7XaIa6d4vbl3akBrRA7Ey5KxFH+YTInEphF758PukdLCh4o/OYEjSdcP
         hJRxREZivgQ0P+hxAGuSgnDt5LL0KLfcf2fgU/PHy0e7j1iCSmDZ0iqgUo7VWmaymbOe
         at1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UvDK0wI43J9wCVFly8Sel32okFV+wP/02Pa6wIx7AmQ=;
        fh=xr5yl59joksgJTFgmiBnQ6aAJSgyT6lzHMLAbh7REms=;
        b=Fr4O3YQ/zoadDB4Qwu4BoO1SlEVgCmeSUJFSzjW9jAD7o2tAms+AYDg6VwBluYI9fT
         c0WSU2zyFuTZiQUvNu9WnvQRIqnX0mbXtQlUxABBJ+ZMt1GQeaSGd/TquPdvPZThg4LB
         PspuURhJwTI8f8ukhehOFMUhTbEQXROgrOnIWTBxfKPjPySk/DdeGHbDlJVog6wuOmFH
         VYTleu2etUbZIbzVZGeLr8VJKNr1mnGmzJzpw8xqWUmdwi6Jno0Q0buHErrCa8T8EaTF
         tkEvs3X6x7pTLds2/7JAxTnCNSOP59Ip4TYyqOaeC7+KFwk81j7GNydlldcrUz+ZktOI
         ubpg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1792656268; x=1793261068; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UvDK0wI43J9wCVFly8Sel32okFV+wP/02Pa6wIx7AmQ=;
        b=M1i9kRr2So/mB54OOe7b24fDDZPhcuzLofxb1mTsd6/CnM7bhwcEYTqi+oH6KFV17j
         TbyI6v69ifh4j32NTNGCafeDMq/LAnZJ34jGKvMBl1Iz82n/4PRSJ7f0arcuVbFIm60K
         lgAK3Ut5OOBpnpbPm8eMhZf7+AEGMivWguzvGcE+1aM/fUA2v4xsXWjTeLA64ov47KA7
         EogOzuBwe5ACbOt9FG5bC7SPYjyU8QPHSvMenVAduMIFIHoeltXL4G2ri/P8MqvIjRUP
         gsKjU+NJasCWaqeoryJCSQtYYpxAaSjFZHQhZovpREwdvk1kllptrF2nhqveSzIWBg/l
         sswg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792656268; x=1793261068;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UvDK0wI43J9wCVFly8Sel32okFV+wP/02Pa6wIx7AmQ=;
        b=kDbM7mrIhzPjuT/IYNnW+7fhdvIetrqSw+NxBjf+RDgxf+Qx5TR2NMsLbH06c8j/gi
         wZjuBiIQiPcJ+ZPNP3EESTcLbbVgWljbJZMAFiuuVQXqEPfokRapfnL4SUDBvc5vQ6Jb
         9dky4QT7pbiHju9e5YW6KP8+CP+Wgjft/jTp0SXz1VS7JlVYP9+W8ocrJfKiuQS7qtUJ
         SlgsGnKkKNGTnJwQxlmIU1cnw0PXXyvoeUoS2W9eyFm+8mUQ1DfBj0peDNQKblzNODtI
         +33Gn9OgjcYfLkSonNH14QdutatbneEaRwJRSkIzv5IowZaUEI8L4AVkySGPMiEaNE9l
         m9wg==
X-Gm-Message-State: AFq9FYKeCKyNcn9JM6t07OxAUQYXv7NznVv4IwYeB629qfvP8vnJQu4q
	TT7lcAFyhLxJPR76GiE9V39vy1i22w3NF5HP8gGInoJvokKN/Eb53VydTFU5uNxGXcqhNEOtiZ6
	T2Urd7Umb+9BOzy09roumNvLcU47LKWKW2SnyJu1ilU8=
X-Gm-Gg: AYBFou2j/bR8A9p33i7xh/96uY1zsmf6U+6PDD2R/9ODgHwgbN9q+/lmy6yw3OEM+4+
	LKPbwOqhQjs61IZ3Edv1XYKWAC3P7kZChU97fTY6d25G4Y55H2endnkxX8ttO1oH4vSBN2T6rOM
	/ZyKaMxw9S8Lqechvdoe7pSaZ+MIMUN0n5yf/4ELspif3lkXDh/uGcZyW6TTB2hkKRSMUSBJlkn
	11kbu6ykaTSlRVrXQeDSHcc2ukx1n7UQW/09KsW8WOwJ7bEk54AJldhlm19CsO615DP4ZVwDC93
	HjpXRWe1Wbyuhsx8hVKuzCoE2zpCEzqbt0PgXiiIZoSiKwfDxeN6keCfQmInV4IwCPN7y08+iZE
	aOTTljnoZ1/2fpKkgU68CaxupBVqUFXFQxL5xWYJD2MiDmdoXs12BRvBp3A==
X-Received: by 2002:a05:690e:43cf:b0:679:a353:7a7d with SMTP id
 956f58d0204a3-67a0e499423mr1493514d50.53.1792656268256; Thu, 22 Oct 2026
 01:04:28 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <cover.1792654486.git.zhilinz@nebusec.ai> <179265618778.3290.6590304416142136273@kernel.org>
In-Reply-To: <179265618778.3290.6590304416142136273@kernel.org>
From: zhilin zou <zhilinz@nebusec.ai>
Date: Thu, 22 Oct 2026 16:04:16 +0800
X-Gm-Features: AclHuK-ttxpk1qZkWA7RJa0y-e5ZRmyvNmGza_feFtiOdaTdxm9Ij-dj8EOUrr8
Message-ID: <CANB6i5zgeY7U+2sjEWjvKxCJBM1vcwYVz_rJP2E6y56wjTxOLA@mail.gmail.com>
Subject: Re: [PATCH net 0/1] xsk: validate fill-ring producer index
To: netdev-bot+sinfo@kernel.org
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, magnus.karlsson@intel.com, 
	maciej.fijalkowski@intel.com, sdf@fomichev.me, davem@davemloft.net, 
	edumazet@kernel.org, pabeni@redhat.com, horms@kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com, 
	vega@nebusec.ai
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 22, 2026 at 4:03=E2=80=AFPM <netdev-bot+sinfo@kernel.org> wrote=
:
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
> Please do not repost the series just to address the above. Instead,
> reply to this email with the missing information, so that reviewers
> can take it into account. If the series needs another revision for
> other reasons, please include the information in the commit messages
> then.
>
> The evaluation is done by an LLM so it may be wrong, if you think
> that is the case please reply and explain.

Hi,

Please disregard the mismatch between the cover letter subject and the
patch subject. This was my mistake, and I apologize for the confusion. The
patch subject is the intended one; the patch itself is unchanged.

Best regards,
Zhiling
