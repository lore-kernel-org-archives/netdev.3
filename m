Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.41
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793430442;
	b=BKQ8uFtf2k5GzMQ/G4Jt+IENHmxgF55GQ5/6eIOJofm1GjctMktxwiXGHrKM/Y9R3zZp
	 lSW437OUxhDgqBxRLq5TcDq6GtgBFKFmFrBrOCvN2dsJ0xWuCHfq6E5zmXzwla8k1D+O4
	 Bu6cH4XU+i7UgNcYbiuLIEPD9XK4F0QX0yW06q4muPfxPiIv55XSkCIR0YtsOGoVgbfSW
	 PpVH5oymgj2gyDaD0J+NuitQeZQwzj+p89/t0i7TQMTxFIvfD3GQsZAFU56s2wOcg2dwU
	 K2bCJ8j0/qWXz/kpj8YkgKwfoAwvFS1qPmDRagwXa40BTrCxJ2gYazBLbZaPXArTpng==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793430442;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=txDCh0MaBRHOsX7sa9cngelOTlX0ltFLjaAJVMdJYaM=;
	b=3psjrpyfezguWOjgjd2rWwvKoR1p0Ptpl+zDfUdEW4lHs2wMKJMcY4j7RRFga3zSqWWW
	 ucQWhSPEk0/GyoK+2jzu2FosCkX23+Wz3Hal4pdzTBI7Ft9iolSTCar07eqixYwKBqzNM
	 HYxUc8Ddpx5lG1hMW6tLygCupHbJAsK5wm67tDqNKnWAs+3MTdlAsiPI22LPBHUZXOb0q
	 DxJ4e3Yn8CIydSYNJ7yoscOtNBodJsTxsuooh80L7q0eTSqZJw75yrDv46LckeGS/SniW
	 3E1rm0FErAw9GXQsQCo3G5elA9RbLMw9qIwUKMC6BLbqHcjP3tGWZsf5gSg/C4ZZxdg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="mUC/ZNRG";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.41
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C995606A31A
	for <netdev@vger.kernel.org>; Sat, 31 Oct 2026 07:07:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6C995606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mUC/ZNRG
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5bcdae234ecso1337392e87.3
        for <netdev@vger.kernel.org>; Sat, 31 Oct 2026 00:07:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793430441; cv=none;
        d=google.com; s=arc-20260327;
        b=BFZvZBtLfyDk9MeQmqHU3QmqwAPk/mivIF6J3oBBG7KHD1Jx2q0M9SIwHDilca0sQo
         G81La5bvS/cTbON0Wig8nhFYch1ek3aVfu3GhdlkLNtbrpTgD54ygvOk4Il95BPrLDMt
         2D2sWs0qAhq0D1mKI85Wm/oP6BPqj9UsogW1N4+47ntZePQVoSKJmFs38LM9tc5rxXjQ
         Vwt8UVd4aD0AOmiz746OzJHUV6UUaO6TLLhZwIl+xN9mSJyUuN/8QN0MmdZtt8Ceqa4Y
         CTEDEmmLCyjZbn+3kW0Is2pA4EwNvptQK/uqQbrfr9MvAoYhROJBIW+b2Iels7IJyYuJ
         l6Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=txDCh0MaBRHOsX7sa9cngelOTlX0ltFLjaAJVMdJYaM=;
        fh=POi4IZlG6thFD2jrCaLtr2/Yj7xVqboRSxGzM1quxOg=;
        b=htcKO4T9zLN6wjPGYXzIhVjEmbnlBiz6mxhGP2vNd6NnHpBPSEhaYCInTC92l1O2KY
         KGoT/eDomIg1GVJDO/rBbZ/hzQBGw9FcWPGuSRiOzb5SuUN8s2xQhikdRYEtLYrG0FxQ
         Zx4c1y5VQcld+1GSlEreZSgiJNW/1zy/g3Xm1Zj0eZEfY20JmH8qBfT/UrJf4AMdNGuG
         P6e4W6gLkNgjibSpo4MJHWPbDM7zUcxibwhCX5jg3kyplI4MdCfwMZBOyNpI3Yp56pvq
         OTuGJN7UtMHDKnlztAkSr1kvFFGVpTueZUJp5LXsXMiqHsKsSjqQFLLlM2bFxyVjAUhc
         mXMg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793430441; x=1794035241; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=txDCh0MaBRHOsX7sa9cngelOTlX0ltFLjaAJVMdJYaM=;
        b=mUC/ZNRGxHvMseEtdOEJmWVOL8SEcrnIyl+LO+rOY+pCywr6fgr+KDK2CIyE8lIsuz
         yQ1Np9gk8b8jKxaAfhEqP2bROPaNrhie/nknplsY5izO+GtjCMaTsnSI4wdjbSEFbJ2A
         v1V+FQHw3oxr+3yAX12D/DT/sUQ9qKE4G+uooZlPDxfs/u+oPXzxb9TRBVUps5TvUVPa
         1zS0+tldYvPBypmRuTh5upf+mvaRVO/3IMi4ZTkryxZGkOjq3yCeaf6+X5a4ylvGgOOQ
         lKmC7vQgmHoRcJHX40cgu4raIzql04uewGD2ZHWOa8sSFvfRTprZZlnZaInECB72XWYU
         O0Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793430441; x=1794035241;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=txDCh0MaBRHOsX7sa9cngelOTlX0ltFLjaAJVMdJYaM=;
        b=JqStNbcQXW0Kl3iA7qhDAH/yet+hDIL/3SaCgK/rAmqe8jNIKl1gmpBN69t3gcYy9a
         fvPPCLTV9WdYmqdMFzQsRm4hdi2o14bgcuEhqPReSTCHGcqkqL8KEH7FJehm1OQLtTYB
         BHRzK495bvY0oQXBvYqWBiiOWUGiEhPB31UCDJ0HhQociXpLVOjW1dS9X5fTgmnTQtg0
         ooo2rtCYc+wmW+oemW3dZyEXn3y4Y12udbkM3c7bsXthy3VUK+dVFjNSgdhfYaDFrMBI
         NOdmhAR8HO/oYCMDA84+JWy6KpnlWduLyeBz0uBzBT6MUDwSUxTL0Mnw7q/qY/UBBDos
         8IJg==
X-Forwarded-Encrypted: i=1; AKwUvBy49ngCGmkyhebF8Gl7auMqHuMdUdchW+YFPDJamAg3gkKQJ3mNZz9vgAl3SM/4/f5k2vt41Ng=@vger.kernel.org
X-Gm-Message-State: AFq9FYLuXGdhQGp6Jbr2BLln0fb0GEGKsnRHERbyRlSTlpd2x/fomCec
	+rJMX7WnC9juwVUHHxWvC58xH9Rz05yWZStaN+e9qcDCIAuKs1MIQrSlFW40ZxXQ1zsD0vHCmu8
	ucP8boP60oyt1+hMszfJNh+ZFyTYYjSc=
X-Gm-Gg: AYBFou3CTY2La9F/Lz5M88rGQ7fjZA5Z+ixMArxKQtFkKVK0FwRxLS2Ud8H1Uffw4du
	WCko29b6gdWXLmyYYazc2XPG0oj3B194UQZIJW8XYxW81XoZ/2yz4Hku1rTwUCUTjmm3UN9Hulj
	d9TRnW8TDifokG8LtJkIpOQ7HT0/L0XmTUOEPEfEb4ifvRfmlyK7Gray91etg115P9GnaM9s+kS
	la9SD6oV2QBR51sXgORSmTM1i5VQpmCo23M3lJsNovBu9x4BX96+dACQIYzYotXL43OdAQUU7un
	OyH4a+kZNx8NVgPPllm/cL6Zbuk1FENOw5kNa46wYMy2fJRtlQ+gNHFVl7wW5gtRd60DKh/LyI6
	BGyeOik4jf5xsLZp1PBol8auxPf6fqms8DAZzzHNH35ZI3mE/8ryk5Xd+QnVHbGaM0f8O6t+Kwq
	11nXsREO3tYZLZ+h+qw/rycZJFI/CY9KwPOdaYWPDfqhS8CUUpev5iH7B/3yim9ntyIMxyTyK+p
	cSJftOzhiM=
X-Received: by 2002:a05:6512:1393:b0:5bf:cfc6:edb2 with SMTP id
 2adb3069b0e04-5bfd951d540mr1610800e87.1.1793430440393; Sat, 31 Oct 2026
 00:07:20 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261030023248.78802-1-testwrzwrz@gmail.com> <20261030023248.78802-2-testwrzwrz@gmail.com>
 <CAL+tcoDUGqk-KfMBqdG4RBURHQc=9J+Ce7B7CZZWRN5yN7pRrw@mail.gmail.com>
 <20261030084017.16202-1-testwrzwrz@gmail.com> <CAL+tcoBThTe7299eVU=tsUdi392dS9cioXX5RA5AKRsYAGbdVg@mail.gmail.com>
 <20261030094633.27910-1-testwrzwrz@gmail.com> <auSF/bDmOW0Y7T4D@boxer>
In-Reply-To: <auSF/bDmOW0Y7T4D@boxer>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Sat, 31 Oct 2026 15:06:42 +0800
X-Gm-Features: AclHuK-0fsS0Xg_Rkxrpa9yorygM-pSbQySVfqzZJZ8DT6_AjEHZacGUrZv2dts
Message-ID: <CAL+tcoC+bwVdf2N+Ku92+ifPOQMvak8KMYM9RvMpv6hkdpMt2w@mail.gmail.com>
Subject: Re: [PATCH net v4 1/2] xsk: defer software checksum until the skb is complete
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: Rongzheng Wang <testwrzwrz@gmail.com>, netdev@vger.kernel.org, 
	Magnus Karlsson <magnus.karlsson@intel.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, stable@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 30, 2026 at 7:57=E2=80=AFPM Maciej Fijalkowski
<maciej.fijalkowski@intel.com> wrote:
>
> On Fri, Oct 30, 2026 at 05:46:33PM +0800, Rongzheng Wang wrote:
> > Hi Jason,
> >
> > Makes sense, thanks. I'll wait for their feedback on the selftest patch
> > before sending v5, and fold it in together with the rest.
>
> Can you stop removing all the previous conversations and rather reply
> inline to related paragraphs?
>
> I don't think v5 is necessary. And as Jason said you received 3 review/ac=
k
> tags and none of them got included in v4.

Given it's his first contribution, I suggest sending a v5 with our
tags and that change (removing else), so you don't need to re-add the
tags one by one :) And then Jakub can easily pick it up with auto
tagging.

Thanks,
Jason

>
> >
> > Thanks,
> > Rongzheng
