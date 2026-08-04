Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9B273B9929
	for <netdev@vger.kernel.org>; Tue,  4 Aug 2026 12:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785845680; cv=pass; b=QelNd0tr9VEqlGQEXjmCPs8i2vGHxTvGO4oKgK8XvnCa11duMfeagnpt27sHciOJ9mSRnVqU0GKHPEDOfsogW4nOAQB+CSy0SxyRwihkqkfgAvvzFSNWteIKCfGxpyjzN971vNSOFs01RvVNbO1qduDmt8p2Vq/9slXp+tswiZg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785845680; c=relaxed/simple;
	bh=ms6p7ER/WG9Qjzd8gnC+OsGxIvYrtwElhhEqL7PK6WA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uLz0gRV+DIdV5BIjMy1Vh3dm6cZ0G4onlznoUyjbp17J+tgwPPZwg+rC/n8t4w7wdU6rNfjRU/Ka+oj+2RM3jyqjBtBkOmYxZ74vQ9GOVFH/2o7k5chX8w8dpOPOClLNKxArR8uZ3FnHfumFonkcDP7iLrYoOg6L8D64W7dXIrQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JTG3FKco; arc=pass smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JTG3FKco"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5b2a8e4c77eso4508699e87.1
        for <netdev@vger.kernel.org>; Tue, 04 Aug 2026 05:14:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785845677; cv=none;
        d=google.com; s=arc-20260327;
        b=GPFH6NhAzBfpgRhdyc1LG2WevB0kA7ozL423w+mjD7Su22Yup9Dep2ed7OVo5L8Qh+
         45mc5NofwSx5kCrY5bBybErs4wTl3ehh2vTsr3sjuaf6xcHVgCVuQ92HCYKCtcSLCbxy
         hU6rvkuTGe2Mzooz3SiAf1ZIN5ltxRrLqde497r/9UfV7Yj3xkTSobuuXoDNGb1Wa2ng
         hrIQJQZckOD4l6yGh9R/QfXLJqxkgxE/mjvo03t2kqnSQghFjuRFp7krJB2o/PJAWhdm
         FntWD+8F6gZjvJ9W29KP54rqrtVS7Lyod08mODV0SjSHx3YT6UKkyMmMFxLzBb0I/qhU
         WyLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ms6p7ER/WG9Qjzd8gnC+OsGxIvYrtwElhhEqL7PK6WA=;
        fh=dsmG6lNSLPMkg2bGOfUfx8B6lEiSuUq69Cqfv57J0Sw=;
        b=p2bzYQCK+kzdwyog7CTWM0IkudqXigC/Iak4F/NQYMPSLoKY4iJG/c2MqN6yVrzQzv
         pj8jVO1Q3MurYXMK/2UDcRgHG8DCyvhJUBwN032x41uPvFehgVbTkCgcYVphCOjhGkna
         5hq1cN0G3FXxwNgtFdSsLFpIVl/wbQbjYqPzkj0ZRgZzzI86eY86RrKptRFdpetgNwqU
         Isd9UIPVLdHvaO3JLxx+7DZUYMxm4+E6wxsBdeiukY2oKrnC3a90khCwBBVyJY13Nyg7
         qfEZQnoTgHWzBS3eTl0E9koFQrcgESHr5vpakY4vGfbD80Cwqj3T2xILh4IAZ3yR1YaH
         aiaw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785845677; x=1786450477; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ms6p7ER/WG9Qjzd8gnC+OsGxIvYrtwElhhEqL7PK6WA=;
        b=JTG3FKcoyXD9+KkyoZkT+4ZpSd63OWCYlandM8KjZ3g/uYvYCDIJlSPDi6YQAQlWhp
         9elhvtyem6Rn76f33C+xh7+6nqtOSnHSpjgz9NtHYYMtjWboDm8pvK3ZgQbHHUqi3ptt
         aUjnr9koW2AvtmHc8iSmVYSTJjD+/VKe8lq0WvO6ExChe+Pt3fZ6ZMsngHnUQz8yLD3g
         LCmOOwVEycm0mYsaGetgOXJBtM+qWN/3rmPd5ZuYgj0hb0DcjY/75pwzrkDUbwbyiZVL
         1mJV+0IVs5qSfYuDxbzrcN5fya3tYYYcwKHbsrWsRBiVSXiR1OvpRiS3GZQ2/DnkLs03
         /6fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785845677; x=1786450477;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ms6p7ER/WG9Qjzd8gnC+OsGxIvYrtwElhhEqL7PK6WA=;
        b=NFg74URXgOeI6pI3Zk8mHJoOxhVVKuF8vuf04mtsrV7gQlXSTK/p8pReByE7LofoUs
         v+zX/DDjqUoWW+xgSlA4I0feDBi/LwzFyQOr+EoHFBXYZwNInhgUbbESN3JyQL+Bg64J
         p5jiRkWkU1wzzAUvcd8QPz/5Qo+qx5nMvx11TD68myCssvqr4uQjUEAIOCCSK+YSspne
         dIi/8IugEhdey6fSqaArVHqlx4J76CXz1Wm8aFI2WKQ9vl0COMSR+NY1DMGms0tL+I6s
         kTckgLQyoHPayBVfx2/OW3IVrDtd4cgY7aOoDSPJ5Z2mPwVxENugJyODE50q+JWBU96v
         NdsQ==
X-Gm-Message-State: AOJu0YycJiZX1UlgqQKVmyBunNKGjccMDtfS/bOpYHsf6rCThMOBAGEB
	LPL90AUWJQUnYqAeKZbgw2mKm+xg1/iDV8P1ioOwg3DhpNcgMkhH2t7wLBvKeaC5t36G+QfAIil
	G52/Zp1XOUQmRDLOlDefllm9E47hxa1A=
X-Gm-Gg: AR+sD136VjjgoYRGgnJB0gGzdW0F63rTMKrhRj69OJC90Tyk6pGLNIbBA3kV5h/g2Lv
	lnyc409cXIKGIWQQ1ljbVJXPgFnAD7vh+AVIzzXv3UakkS+PBqHxZ+i5Ocvc84zLnaJxO3oJvDn
	N2DEbohQ1Mwriuu/5xQMMYvMqFSthESQfhr7+OmGZf285wkkbowFS+30rPsJ8i0F0dXtOdJjcUP
	JcirhWPlCEMGNmrCFNb1q4Yol32VklVc8IBpCtTNcxwzlO2jgh07bKdRSVkJ0HnCAi6+xTh2biO
	mOsFB0REhQGtlsbjtZwKH/5Jwm2WW4BA6ZGu3Wr5Vj27cBC81H5LxEzlOETBcYTE1hOy29IUnFJ
	6rfLU2bbld766dZeZwdBL83YDVK3FgqehH7QEjII2WAKDAAqXMJM5PXosyHA=
X-Received: by 2002:a05:6512:400e:b0:5b2:a558:b222 with SMTP id
 2adb3069b0e04-5b2f0ce19c1mr609896e87.10.1785845676638; Tue, 04 Aug 2026
 05:14:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260803210707.1912217-1-willemdebruijn.kernel@gmail.com>
In-Reply-To: <20260803210707.1912217-1-willemdebruijn.kernel@gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 4 Aug 2026 20:13:59 +0800
X-Gm-Features: AUfX_my_EL6N_MS-28suKnKJLSuE06TW9KPNUI3ox4Goimy-hx0bTUFeNm2fQ_k
Message-ID: <CAL+tcoDDRQz9KJmABC3R+CzVxiS70r+-0=aB86yDdrPHU1EPRA@mail.gmail.com>
Subject: Re: [PATCH iwl-net v2] idpf: add missing cpu_to_le32 in idpf_tx_splitq_build_flow_desc
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org, 
	anthony.l.nguyen@intel.com, joshua.a.hay@intel.com, 
	przemyslaw.kitszel@intel.com, Willem de Bruijn <willemb@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 4, 2026 at 5:08=E2=80=AFAM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> From: Willem de Bruijn <willemb@google.com>
>
> idpf_tx_splitq_build_flow_desc performs a 32-bit store to &cmd_dtype
> to set the 8-bit cmd_dtype and zero the adjacent 3-byte timestamp
> field in a single operation.
>
> Descriptors are in little endian. Add missing cpu_to_le32 and cast to
> __le32 to ensure the fields are written correctly also on big endian
> platforms.
>
> Fixes: 1a49cf814fe1 ("idpf: add Tx timestamp flows")
> Signed-off-by: Willem de Bruijn <willemb@google.com>
> Reviewed-by: Tony Nguyen <anthony.l.nguyen@intel.com>

Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>

Thanks,
Jason
