Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE19F415F12
	for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 19:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785525128; cv=pass; b=iJjbjTdCSTYJPCCAAjUr6aenx2sNj/0g7v6G9Z52XwghxVSZHblnGLYBNHlQoD0k7AUTJc+T6l5copkc7vvOQgoZvjP4frw1qBjJYyV/MF0sMvBQ/UwEIKN0FeeN1new3jq913JoKzSx5CIHkex517yZ/1yE7YdubEcj3CC1jdQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785525128; c=relaxed/simple;
	bh=rmN6TuxQAplwFA0TMA6Ov1GEs5slxCSCDmmBL4VuRkA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ec3vSZnwPlBP7fWOsfxMt6bW8VK46u7kDC5eFQi/HdrwEn0JTB3ffi87n68injGKGnnsKhs8LvFbWSVaz8XNEG5ddLKZBa26xRCj2nuh7JqzXv0SAW5ltj30akZn8KH3lQvrV+fJlVlnLE6KBxOgtdQy43ul0yFvWBiNOOQdnu0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tFCLZXxt; arc=pass smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tFCLZXxt"
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-7eb61bbeb25so1004241a34.1
        for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 12:12:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785525124; cv=none;
        d=google.com; s=arc-20260327;
        b=r2JL2NVyKe/LkkAVzzQzIibdZS99BoZTahaqYA2oNnSaqigj63mt5UhC7EPJznyXsf
         pVJBMq5kcDyHUMugm5ZCyBsmIWu49uXNxeHZfuai93WH+1xUQL1zEJAsaRJsBkNlS2GJ
         F/8HOMTGxiudN0pAjaTvXvdxD06SngYQSM+xo+0nZxVE458NkchP+Lm14fkqI8PLLYq0
         vVFAPfXPoWvCV6x1O2ckHEY/JZJb69nIK/Vwg4qA6YOVV4FMRmlOZUgU/0pid64J5Eny
         chQzri/VMx0dw+b6M6oHqMikelE/96dVwKOAZW0Tq7w+nU4x8I0TAa+k9MNn3rBATCLv
         xL1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5Z1uE1v5BQ2Lf2WKOVOPjmUuxegiHDhMWRL9zm892DQ=;
        fh=yry/TOjFQorC1aM66nus1FB8yYQbQx7ckI8pdyDvgOU=;
        b=WAMd92r61WJbe6CW5oCvPi4rCFN8wh1QHUyKdtJWeTy8CErg54OYL7QBeASrZaEDYy
         caAYQrEw8rnlQQL57wq/tIvZ6PnAQfXzPvglcb0MjeA6tNxh4dlA/CM2N4MOd/8ppzhH
         47+uLk1ySGltuFvVnCSit3oLTKm/0rUWsW2QRDN38UZfOV1Fzoz4aFgJwaYLNv4RJbHq
         z4QW1eb3zMgqic6wjALxo0TgYWQ5aR8mj/PeELEga1v5o1Ej6SwiOhu9avwh/q4UtjeE
         QqIehhgs6Bo2ITQqAw0Zjr0NGqePScqmueL8bySZrQso0ufgXLP1TLtS6Cu7aHpx9HAB
         bDbQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785525124; x=1786129924; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5Z1uE1v5BQ2Lf2WKOVOPjmUuxegiHDhMWRL9zm892DQ=;
        b=tFCLZXxtmFRa9Fwk39lnyr5rNQkz26foij5bEY9svHjGOQiPDOleH95NwLWIhHlJ2Y
         pBDoTBEhXEFZZQHXzAuyG0Cb1cJHkIiGUcjr1oxMSVQx8T+MshT4AsEZ/9Zts6/754+e
         5Az6oLj0jc+a5ynjUP+3jdJVpwX/9+bEuTh/ZiNLsPY6px0UZlBkupTAZdNc0IHeUTmZ
         hAgMHc1wdXEc+CZ7VRuEK+cpiCfP276wc43AJilMWTz+08Z28kwi1+ilj/a3qqM/sQ0X
         3AF8Cs1zC8jBOPpattIqjT1KeSvfgFCXjfLh9IgjLiqbQNjf/nsrtv7wlX1HKj3ARZMy
         V3qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785525124; x=1786129924;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5Z1uE1v5BQ2Lf2WKOVOPjmUuxegiHDhMWRL9zm892DQ=;
        b=qHH+pS6r5fBlPHOQm8r/2QTzLOWbaNlJ4HEDYylYfeDNKBhh1LI/M9UpYemEs0RlJo
         CnUyeeEW+YzUSrkid5HgJQzt/cfgCX8DBO262FSGHI4Pthwwu7pSaeSakrvorbjijKV3
         A4iSKtovkqA0vTPVQnXXbACDtUClRT1PAvmsnaF+K+lgYvan67rqmbnxPFJj86/f0n9Z
         Z0UHd5GHCXdadxbewaR2Q73ygYVXBnZUQQlUFpxsbK7ml6AYtCYCx7AHyV5yB/5BO0fl
         lOuQAWtSEmj/KoPw2HwR1zfV+b+IxW2Vy5xqsmWOQ98RqXUP3XmKa0DrfeqQ0mK/CoX3
         h9kg==
X-Forwarded-Encrypted: i=1; AHgh+RqYUjbzdfY7eSgoUL5BfEhLygxPXg3m0epei8PkFk5ogdB97GRwW3sSVtR1wtfZqG6A3EHod2s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyGgzEtwZzjrgtiJ8qBZ9EDIzfq5+xCKd1DISmRdb9me1r/xAW
	q4ewREGO/PSrXuHPZ4d1B+J+pT+Kwr+bzhscfyAYeFnrL0FnJvMOLEsZzU+HndC9qY9FrpXSfuP
	v/4V5vPhSH9jzf+uo0DQyrJFzFtatOY4=
X-Gm-Gg: AR+sD11HDTm1cupaI73zRgppqVXuF8iPNnjeHKvp4zzVvT/mIPmqBE3sLqL2ujJ2QZM
	HTVxolfS6aB8nexm1T1+jvQeVBJYOkCNZN2ALEnX8hTOH+fgfxHy4rBREn/o0Sj3bIRLEVR7c6i
	ysKphw5D/QetWIClxNR7FmcwDA8vjv8VHKs/6vunKkzprcW7Atu9y0ph6yAK5rCTetyAojMFJdv
	PHQucxWCnjZIFh+Pf9RGUqM7v7f4S5DWvWXGQfz3T2b9IIlmR2U+5Ki3+ncO8cnWgGZzEC0Grxp
	D/45ti+U3MW8X1SIAeWBtpbvlBTXhu4s/h7xr/R00+UryQ==
X-Received: by 2002:a05:6830:488e:b0:7e9:d4b5:8004 with SMTP id
 46e09a7af769-7f196bccf05mr2378584a34.5.1785525123693; Fri, 31 Jul 2026
 12:12:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <amywpyZgGWyhzBjZ@hpe.com> <amyxgPYeowzWt_8W@hpe.com>
In-Reply-To: <amyxgPYeowzWt_8W@hpe.com>
From: Robin Holt <robinmholt@gmail.com>
Date: Fri, 31 Jul 2026 14:11:51 -0500
X-Gm-Features: AUfX_mwATQN78TO_5FYc73vsp1AMl7jSbTOZCt-SSZZyCxbd_Rn_rLAkJaXVzpc
Message-ID: <CAPp3RGodLL+zfZ_v13=nmkmUSXg514PV3YDQ6BtMLrjkPwR+cA@mail.gmail.com>
Subject: Re: [PATCH 1/2] misc: sgi-xp: Remove SGI XP drivers
To: Dimitri Sivanich <sivanich@hpe.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Steve Wahl <steve.wahl@hpe.com>, 
	"Anderson, Russ" <russ.anderson@hpe.com>, Arnd Bergmann <arnd@arndb.de>, Kees Cook <kees@kernel.org>, 
	Russell King <linux@armlinux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, 
	"David Hildenbrand (Arm)" <david@kernel.org>, "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>, 
	Muhammad Usama Anjum <usama.anjum@arm.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 31, 2026 at 9:30=E2=80=AFAM Dimitri Sivanich <sivanich@hpe.com>=
 wrote:
>
> Working XP drivers require the GRU driver.  The GRU driver is being
> removed, so remove XP as well.
>
> Signed-off-by: Dimitri Sivanich <sivanich@hpe.com>

Acked-by: Robin Holt <robinmholt@gmail.com>
