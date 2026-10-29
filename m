Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.228.71
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793269405;
	b=kNeuJoyTdmGamS6Xo35W+XVNE9sEtxZ9ozwjofi3JsKDIyJKWbNCllyt5pd/x9mISYnm
	 5FEM2JmB46a1FHR2Oxikew9SdJAhkoBgouPmTY7t48s5auEK3DF77GqbaJKMfL8kcTLeS
	 RNKeXYrTZH/ah7glKZ84rWnsodqJuacsNwuY2GTPpb7d2YtcLuIqxLdk/8GNzf+KdRY0b
	 ChWMPvgQRCkkDu5inGi3wXKaVc+pwqxjqqcIBJ34r4a3ioC6ha5eCQ6kHJFuH9LX51kuy
	 U/QA4v4b2QeDWVTb4kKwPzqB1DHBFj509WVehSa+aefwg6eShXlQaspPB2o5UGKbacg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793269405;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=BA+kSJSuqF0Tp/mjbmAU8rE7i18xLMiTHg0IlzoVm5Y=;
	b=ks4fcfMd/OMFA1vsjjB5/7Bn6uZQGnMAbPgO6ITqijmQs6eoifpUjdKKVabJKgEyMYyt
	 yoIbF/GqxkwCgRWNJN0ruacW4SPvDu6qwb7AAcQwVqJ837YGgYgZiI4coxDADcwM9DcB9
	 MZHBqkU9dq0pyfJzZ0TsCdzgRCV5/TyxmToh7fmbpSwO1heZRdp3J1mNUoJPHO9tzkDv9
	 RFlVSbnZbPKaYZE8NfoSrNtmWXVPR/eZMpF/JbgaSRFh/h0rkpwGXARQIgNV1pKFn9p2l
	 FNkvzbqumwu9Um2yqqdKCGlqWOYAwexqrku65zUejaHdconWUXZB3YhoDwiq0LGz1JQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="WK6/y+1W";
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.228.71
Received: from mail-ed2-f7.google.com (mail-ed2-f7.google.com [74.125.228.71])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6147D606A327
	for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 10:23:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6147D606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WK6/y+1W
Received: by mail-ed2-f7.google.com with SMTP id 4fb4d7f45d1cf-6b1a8d1e6d8so887939a12.0
        for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 03:23:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793269404; cv=none;
        d=google.com; s=arc-20260327;
        b=ei7fptP1NKg7IfanvrOxj/8Z41Ojl+NZyCugIR8QxjQogK5D73jL8urWlZnqLjoNg+
         hUfedUMjrwB0YpAwjhxhNi3gz+qt/ihHqfbDk/QxGFy4uuc6OLrlS6R0MJd11i0sTYa6
         PreWK3XSQpfYiPDTCy9qi7FQcwoDUDV8ji1+9k5jjLWsmAjIKJIyBUmBG+p5KSoSq2NT
         jbZGZVl2nzDdCe7VJpjbsMGQdHlMKDNGBLqffjcbUOngCYRHAVjxqZBi5/eAzTljqVYg
         xy7K4iOfmg6PplcG2OLY4WWhxlUnlzH/b8nAWhUkwYNLUj0yjidvqFMa9OyY36q7eUAZ
         87aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BA+kSJSuqF0Tp/mjbmAU8rE7i18xLMiTHg0IlzoVm5Y=;
        fh=Emi15biMxhcQZg5FLwYOvymqhwz/W9NNVykBiHQkbok=;
        b=Vu3Z0JfsEcyASrmNfXo93lxGCxHZLWhXRPypwT3iNMn8DpSilv4UOb7Ry6JAPTdv56
         rbzDExzPKkMZEpi80PFOhdymKZZYpxFYqh5TBqk3aAEGs9UbH5cY7T8QkWZLgJCjV3u7
         zqRONfPiOSjIvaCjykRy9MsSbJ9EoKXz4+iuc7I9kykPGV9k7dXAaUbB/i2C9EpGhpff
         YF96/SP6EC0YvSFYnQp47fi04C3rJO9mRAKVYFfAMC6OnStAKVP87laNuZ0krMdQjP+u
         UVhdfiaYjLotDrisj715WGW3oidwZ9z/1rucKuq2hH4UOnNx0l6DwbozczZNGHswDSgy
         D24A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793269404; x=1793874204; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BA+kSJSuqF0Tp/mjbmAU8rE7i18xLMiTHg0IlzoVm5Y=;
        b=WK6/y+1Wz0AXURlsYTqtbMZgqlkEzPB5OmWVXA+pVAi/DAAFgbOASA1bLf6PDFz1XX
         dly3Kb/VlaE4cML+c9e/X+GPm5cjz0Kn2FFZwDYNOou/d7Js37KqyvHMTbJw18N7N2ED
         MZ2oFTyBjsoF1KpTWbn2znRJIPtd2uksw2EqLC9J0GeL5ryM4Md2J78ISM8Up8NhEIBm
         fs8AbogAwVcOeUecN34PoE21O7A3R5At3pvq8asYoTXyt/vF8qzM6qtPHsBFsuyM93o3
         C0f3JcE1S2hqxviECKEnUneKnLGd6XX/KdShGu3W9/4fmPoafghr4goKUVl1ZyuXR0nt
         qrgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793269404; x=1793874204;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BA+kSJSuqF0Tp/mjbmAU8rE7i18xLMiTHg0IlzoVm5Y=;
        b=rXNTU+D3X1IL49s9BcIj7DaLiOh7+BvpcwD0eUJL0k2SyXcgsy/v70Jq1P1q68kcbP
         pD/ZgpY13u7mpVzbmynk8+bLfpc66txvCcgA5s3hMLSItDEBrOVo9bD2owztmbK+43om
         SB5n7iva8CSPrnhUMYr0N7JKIvxrPQOZxzPDiYFeguF0vJD/txRts1baGfisk6HsMX33
         xHWx/7ss2ocnf0sBGOvJjx1Jbp8l3X7KaTQP1EnYM+GavyugoGzVA6Tcu/6I5goGE3gT
         HKYm3ivQ380iCQV7Kf6GZFeOAetDZrjr4ZLcG7GHr19XRxy7NaSNJkF5Jn0cXNiYnCuJ
         YB0w==
X-Forwarded-Encrypted: i=1; AKwUvBx80JgP44LGg96jFj1KpsqbvVI1RNhNMZ3sGmj2Ab/DFkeS/xFuw/E0JhMrog8u+wWjMP7Q0O4=@vger.kernel.org
X-Gm-Message-State: AFq9FYL4oTQ68TVbiTkur5jhaMfh5InoO0nAdrbVkmMdk6MoNi7Og5F6
	FOAGY+gIchEBnTfw7FG+tfFEaW6mFcaq1M9DcHHFkX7UGLhu63tuL8aZyldW71yzxrGHpeIEEji
	XJLV4EvXKbwWlYLsa7hP2fpboEim7nVc=
X-Gm-Gg: AYBFou336jYcJZ9SQvPBd/7NrGY4I8xqqPhvKdBK1c2wTLrcMtNv31p63Q5biRWzbmr
	BNY5ZiLo1BRTJ1mtc8QRoyS6fhh8qfSUiDZtqgPhIVHwCAVIi4J4bWN84a68hK6yJil5UqBpCzU
	DxALkCLm6d9HgGf3ZG7oDOupE09+SSr6XTDy6Ht7bAKYAz3BOlUqKsMacHbXwHcNn/65ls6sXf2
	YdZIAFLQ8t0LyxRJ2QahanVh+3U40jb+MiEFcEhUQzap+/g6zzKqey/Ko28uYvoWPNW1skJ06og
	widwrlotsFnqF8R+JHhtrDCMx37I6grLJfAauesfFUjXCjrWFxrvE7fTMl3xmfU425jjnEI+i7R
	+W7KAc53YTnmxNtbV9s3yDVtkJEWDIkegOaJxKwY=
X-Received: by 2002:a17:907:5c1:b0:c44:9a32:b27 with SMTP id
 a640c23a62f3a-c49bdf3efccmr409763966b.25.1793269403495; Thu, 29 Oct 2026
 03:23:23 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261029094916.3127193-2-coiaprant@gmail.com> <179326779144.3327.11596356628770174944@kernel.org>
In-Reply-To: <179326779144.3327.11596356628770174944@kernel.org>
From: Coia Prant <coiaprant@gmail.com>
Date: Thu, 29 Oct 2026 18:23:08 +0800
X-Gm-Features: AclHuK8EImYqqF5YHtT2i1-3dqjgRi3f79j4EOfGIpng75DJLEaq2ArfexxeNFU
Message-ID: <CALj3r0hX3Ded4G0KY+f5uhoJzRB4ivW+Sa3R-TeDcq=O6eaGDw@mail.gmail.com>
Subject: Re: [PATCH net] net: pcs: xpcs-rk: limit advertised interfaces
To: netdev-bot+sinfo@kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew@lunn.ch>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<netdev-bot+sinfo@kernel.org> =E4=BA=8E2026=E5=B9=B410=E6=9C=8829=E6=97=A5=
=E5=91=A8=E5=9B=9B 17:56=E5=86=99=E9=81=93=EF=BC=9A
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

Hi,

Thanks for the check. Replying with the missing information and a
respin that folds a related core fix into the same patch.

How the issue was discovered: this is a known gap previously flagged by
Sashiko review. xpcs_find_compat() only walks desc->compat[] and never
looks at pcs.supported_interfaces, so the mask the glue sets is written
but never consulted by the core. The same review pointed out that the
generic xpcs core fills pcs.supported_interfaces from the compat table,
which for the Synopsys ID includes 1000BASE-X, 2500BASE-X, USXGMII and
the 10G/25G modes. The RK3568 XPCS supports 1000BASE-X, SGMII and
QSGMII in hardware, but does not implement the C73 10G or 2500BASE-X
modes, and the RK3568 MAC side currently only supports SGMII.

The respin fixes both sides in one patch: the glue narrows the mask to
SGMII, and the core respects it in xpcs_find_compat().

Whether it was actually triggered: no, this is theoretical. The
affected Rockchip platform is not present in any released kernel, and
the MAC side forces the phy mode, so phylink start passes the mode
explicitly and does not normally pass an interface outside the mask.
The patch makes the mask the single source of truth for both the core
and the glue.

pw-bot: cr
