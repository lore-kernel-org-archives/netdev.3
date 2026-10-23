Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.45
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792716914;
	b=vxamAe9MWSa3b495owRWJMCERCg2+QI0/cKLkdy4vNfURprOe2ZMrhFDKzJDrZt84qMY
	 l9+l+Oi47D91NwdkDWvAO5OyHNS75LSw2+T6HJ248wH1/PIV7NQ6fxBYXNCn5csVV/FQa
	 uWQGqvnKdR1eyzO3BR38b/EvhSc8UNK85Vaz3phR8qB6Ks8924YEKC5QIoXG00HqdSmSQ
	 NMIsWy4mdM2SILf18F59a2ZGiHOkFMU3G/K+qPrZcwXIgTD8Ih2kf73GRUWt+NzYcAw8W
	 4LfZOtg/Z7v+Rtiytu5UiQuj9WJPteW3pmk3eJLByF62fGB00+Nd2Y4TvX69qbUTd5g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792716914;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=r0FMPduqJ0vMq61jwHyW/GEzTaVV+6BnR55xnPNeJP4=;
	b=LgZSJziaEWtRqtyLluRmLoouvka/P/qWx/wfMCYr8xI3GeyOdQhBCxfTItc54+E7Ulq0
	 d9b+el5P9aWf9x4qXwG37gstX9qtIdYvmE7Hd/iC6t90QN4beYjCC5Ge1AXoHP5ew3xJw
	 n/H5Haib1V9DxhkYZIaQVo6khL9VXYKyXIkJKFzonusXGkpFEVqBl8nCQFrCfOfymuUNQ
	 OFVIxzieupEDLXaQOBjj6I1dREMAryW8/7tAGrY2n/rfMiYAoc95Apspw6tq47oc3qwG6
	 YvYE343L9aghjD/RnRSukItPxrGTdaEPyWi54U7TbQk7vSlm/LeMiXRwXcnIbYdoIIg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=jGlZ3zwo;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.45
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D6F4606A31A
	for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 00:55:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2D6F4606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=jGlZ3zwo
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6b1b13e09ffso399764a12.3
        for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 17:55:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792716912; cv=none;
        d=google.com; s=arc-20260327;
        b=SSqrZeFg9lzCWp4WsbQVQCEDE04++sjxAg0NOr7a3nybu/+2prsvXsNHVHY+hgLky7
         Bpt26vi1I3fwHbib6Xz+6S59WzSsvRHDl4ImwpmL5o1wocaWF0CBN8tpT2pCaE6cRaPz
         gbWxYi9SgG2sLy6kS+WZn7n7KALIANgvzASccBqy/bnGAw4wSKVTPXhcbyiaHAlmUmXz
         KBbt3dzocBSxy+AMyht8c0kdP7v6T5tU0XUGCrJ4p2bWkTbydpe+rOOo6Sj0+6v4OY1t
         tURwGoIbFA2d7kciNFS2t07jGOITDPIJmwqCCsD9pCVCfLA1heso0reWhAyJoODzP+jw
         Nuww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=r0FMPduqJ0vMq61jwHyW/GEzTaVV+6BnR55xnPNeJP4=;
        fh=9Jni3+9H8vb0ZwkwGEa6+BG3BNO+8yFOqTLYhvxklmU=;
        b=mDdkZKRm5lKNpfb9m/HGNj23Y3krkbmevAV6jILy5uLQS3Dr48ODFI5dNYw5UznjTO
         Kb6R3pNYRbd38F7sLGJV2ezLKFDKqZzJaYddt1dmoW0926Bd5w/4XqSf9ROJUpue1hho
         w5lIwyMqTWc1g2HrvzSmthLkO6iHGEWwOl0X17Syz0L6FCeXwjis6S/Cxyjx8XX5P8iX
         VbwuGGdZMGGGo5Xy7e4FpWclQ3rscVNN2HPKOiB0/WM7Qd1a/ae4bnLEKCoY12lZLMj5
         yJNT7dS+DVZA+2jC3mVq4qGE2lORoobYg+xVxkO8tk+zs5Jwpz/bN1Wcgc3t/ob7+3Lp
         A1lA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792716912; x=1793321712; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=r0FMPduqJ0vMq61jwHyW/GEzTaVV+6BnR55xnPNeJP4=;
        b=jGlZ3zwoXzBUq07fcxzcXJvLGgVwYyqDidjGc2iDLleaPDD35UqIbed/CrFJDKNBX4
         1YUYE1LiwpyqIwZ979/clSVNKnbMrckzC47rNxHicsqkrFd5Pr4lccMq0QDFaq76zx8s
         cbDdYXpP5n0+cFcBQtDg1r1qn+FGsU/ZiQPYhRODeg9hjKnNwA4Nf9AioQ1b774Cd1r7
         UyPSG8YgbbSss9YmgJS/hOGsyoC8Sr2zaZRwleAxkBM9z1kvW84TTu5pjnu8iWG7Sjzb
         mTwbGjSL2GRPnK1DC0U1LMaiyJ0XvPlw1UVAH/gn1QCCvvgV+XwGrnAE7/Es5tojUHqQ
         qN7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792716912; x=1793321712;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=r0FMPduqJ0vMq61jwHyW/GEzTaVV+6BnR55xnPNeJP4=;
        b=KF5iKFfm1HTgWcWcm0g7gWZf09KfYkcmWyT/3E/wS9aSUPIbvkLyo2Npy2oGhn0hfU
         XX9+huGnl6ZRrgytB6esj+me/4+HpGpFn/dGLfAGE3Pi1bLImGFBqjZnYZHKkxrY8CjP
         eZkdAKOL5DjicQEvoao0qcVG4bIu3PY9A7CXraRkHX0MqTVbUz+8AMDgJREb44yFVc1w
         Zs+Pg9DoeAfHdRjr7aK9wOHm5H54uMj/xsNc22fZfejzI0J/ScuAE2qMiBEkwmtVgav2
         8VyVMGFKq97rt4vSge3vVjmq1Dhwwl4P1op5zWWqiE15/WgaxR0cgSV33icEICCNK8/L
         rrVQ==
X-Forwarded-Encrypted: i=1; AKwUvBxMgt09l8x4sfndD24Qc11xKZBC0O3LV4WC/GtrKWLVDWI5hOy9IReb9Rc48xW+dVH7D6BPbb0=@vger.kernel.org
X-Gm-Message-State: AFq9FYJWaTqpSPezp72f7Ggg86xvwqfWUzweRsQkJe5fztCF2fAZ8ock
	rf/aBuQkROfAee0XJ9T4e6CGStPR+CLEIz4yA/7nwRnH5a990eU6ZifQt0YNhGUZe6b4BBCPcgc
	SspSM6V6rp9Z81YnMxRynVhR1CPBWRaY=
X-Gm-Gg: AYBFou1JuxeJOaIPg44dnDkHa/vrMC4eqm/AjzcuVLCzlp/NeENwcdfkizKNrFvYvBq
	jLE7tGKoMl058QI04OgfXXZq5fPmE0zN1LEfzkbi/aIqBzwmf9Bg8JUXfMaU+Evj61f/NzKCqhy
	NXHpf1v3Ewr+kNDcx+GIY8uRgrZEDm8ui9hwnkjZA7QnTNfSilIlbiO+Ko+DGmMh1QCF/BrBMi0
	Ckd89TnJFtVChazdkRjxhKaeLkS65fT06baCq5muGa8TIzaCqV56XJp0GOFrFbgt200xWypozzP
	hkMZTR1KSbCxka7RkH+NMmeZBUxnFUj5IYdRZoD5Dm2BsHfSBP2vXda9nuOWLhGI43JtH4yGNP9
	CDByGjs3a/Qatqz+7L8cjRZ01sLykVzLpOyotxVvTj+VkYbl7whuNuuiibCzsCB1HUXp1BvNdtV
	oPcUbm7qzFmiNV+SuApvf2FXRsFIScvCJnygz6xSbjYA7+jVI27hgIWSeeBI94CmOKyviybwD56
	T7LNGCwOLRnaqyMKpZwyL/UHH7jq1TbPwL5fLxxQHuMSvqqyio=
X-Received: by 2002:a05:6402:205b:b0:6b3:e89b:126a with SMTP id
 4fb4d7f45d1cf-6b432bd8989mr1000942a12.12.1792716912331; Thu, 22 Oct 2026
 17:55:12 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261021001744.2042320-1-rosenp@gmail.com> <179254219525.3290.1761340258214254709@kernel.org>
 <20261020181423.68783c1b@kernel.org>
In-Reply-To: <20261020181423.68783c1b@kernel.org>
From: Rosen Penev <rosenp@gmail.com>
Date: Thu, 22 Oct 2026 17:55:01 -0700
X-Gm-Features: AclHuK9ICwt_OB5Rj30ELqyDL-gDO0EkUcuhCZlIOFTTDWA3-lrmMCR6ms3mofc
Message-ID: <CAKxU2N8ys_QztyhKLSp-PQ=BD20rvNSSRE16eXbd1KiV6wdCXw@mail.gmail.com>
Subject: Re: [PATCH net v2] net: bgmac: fix TX DMA unmapping and slot cleanup
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev-bot+sinfo@kernel.org, netdev@vger.kernel.org, 
	=?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Felix Fietkau <nbd@openwrt.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 20, 2026 at 6:14=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Wed, 21 Oct 2026 00:23:15 +0000 netdev-bot+sinfo@kernel.org wrote:
> > This is an automated message. This series looks like a fix, but its
> > commit messages seem to be missing some information:
> >
> >  - How the issue was discovered, e.g. hit in production, hit during
> >    development, syzbot report, manual code inspection, LLM or static
> >    analysis tool scan.
> >
> >  - Whether the issue was actually triggered, or is only theoretical
> >    (e.g. found by code inspection). If it was triggered please include
> >    the symptoms, like the stack trace or error messages.
> >
> >  - What hardware the change was tested on. For driver fixes please
> >    mention the device (and if relevant firmware version) used for
> >    testing, or say that the change was not tested on real hardware.
>
> This is getting tedious, the bot has emailed you 10 times asking for
> this info. One more fix without this info and you're getting a ban.
Noted.
