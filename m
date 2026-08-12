Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88E383C584E
	for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 08:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786524963; cv=pass; b=EKlYVBNsscYM9SoMNYUgz58gOUe2r4Jzgfqi8yeYB6ByXlaSqOPj8816KIMsgAsRXjCqXcDRE5qVTecAigh7D9OBau0Obf61V+Wj3SUMxMmlHIuJtjwT8VEx4oQCTf27+l9B6F0GAOSW2wGb+2Ic3EITJ2/DjO67kIHW2q/XYAA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786524963; c=relaxed/simple;
	bh=T47o19nBajxd3p0ACIKnx6C1FG4G9r6jP2ZaIp76pfw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cysJlQ/DVwqJG0eo0+5tGE76xobccxw3MnEJfDyyS4mkTz5eqEJlmLKFA7PnLfDynKXWMvgO6iA5jr+FUsBsymPEL0JwJdDkwFRNpljwCyzTvGtaL+64L59mE0IswgDs/4BwJKWI8P7sHq9vIH6IDmVRMXuoBcBRAknWu8YWBN8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VvTIVOqW; arc=pass smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VvTIVOqW"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-51c0c45c580so5023911cf.0
        for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 01:56:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786524961; cv=none;
        d=google.com; s=arc-20260327;
        b=beNpkwPAzvJhyvZTXtkLiw7y0L5Msklv9z+nmnjPta0/woUCbZneliVafeByfWpy3b
         p+X/q5GG2S2wJWiNMWJHxVFdN+CJtwUOPBkkMrgAqUVfa2iqWqVOiB/PtlXY5WzXGhfR
         NaR6F8gdlC+c973mbmUg447QcdMxM3YxD4oCKhTtPQc50neItupsKofEXONATbigBQ8G
         v0vZZHZmcREFVx1kuKe0myp8hWQD2+WRXDWZTtW8HahofxA/SrTAazpUX6sLywBBIWM/
         s5LlQmp/DkXFFGb0MtdxdG7xH/pGtdYoGoSkJ5mCixrQpEM1ZoV9CmtVKz0G01Z1d919
         2AtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jUwXr+rZIPE4gfL0LfQClG7NcT5w6hgDoBAgrbWjs84=;
        fh=qICNnB3IttTpKUwCjPdmg9n/J34Fqe09blsgRBMmxFA=;
        b=JipZRpz/52MqwPT0lMn5pQJXaWgzVm6kSpYtLigfEhMNH2C+OmZ5/3FSSZQmQZnOvt
         dZ/3KtxHtCbSzgqKJ/lFDYbrhzGon1k8/a3XMposo2rY8pXpN6p0pelIcF8lmVuwXVuI
         XR5d6hF8K6KLSxr9TRKjImXOLbLQnJgmm2tpBBltnpCSsStc0p3ZkghF/RP+a+ssx9EK
         vWLrlqoSKq3daRd4BhQ/aFRiPahrKkMx7YLga/w/nobp+ggGK7vCrSUaVbmBvkYiDx6n
         iJgw0Nsb6wi7Jqo0Sogp2RUZgL4JzkNPiAg3lmsc8Eb2R9j7fZ6nO8pg8vxO8X2ohmxL
         cj/w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786524961; x=1787129761; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jUwXr+rZIPE4gfL0LfQClG7NcT5w6hgDoBAgrbWjs84=;
        b=VvTIVOqW1Rqrz+HbaqaAoBBvPYdqJxWoVBzE/IBUFFz3sbONLxrXODwy3/hS4DKHxB
         lsVlWTyCxX5++RkEDhkjItswB8xzpqLyoFxUdxnAv7LYw+VuNFHxhdLylOLWdQr73CVw
         IZnvrRl6dfdSKYXDvUOpn7GfgI7LIHJI0dU/AH8parK+6B8LxAtfOoJNGu7Zu3Mn7D87
         Gtn8mPiSZN43/V6JXQzDX2MjNaV6qrQEM3t9NbvxotL9DeC8/QOgTT6EkLpsbg+igCyL
         rDLNhSfkmeIxh7JZRskvttFfw54D8JrPF4dBoiYsXF7kA1kNsRC9mfcyF4U7dbMc2kyC
         +52A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786524961; x=1787129761;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jUwXr+rZIPE4gfL0LfQClG7NcT5w6hgDoBAgrbWjs84=;
        b=JqSJrgyTZN2dLHFL+ucjyXWy/Xw8ieaNu1KW3BZ3CgbS0kuP8hS4VC0XSmWyrF+l2H
         L6F5NaOumYbuNTBytGvqW2JLH6tuQ30fWYDppZF/+QyDkryF1oBB/L77QhPfyH8aoelX
         LFbtQ4m1NTlBbsagnLKe2kDkLPq8k/t1KSnhbhV8UxXpnevB/cYyMS7N6LJhK6cwW2U0
         JuJo6/zcuiePkRHOcPw4zXJ4L3K+uY0M2/35zGNnv+DBQuSKGgq8RQvc3/UH6i8TBdVq
         GsaemxD9Iv26g3E7E5L7ZKds/oV264bjs60vTEoA9jrVSGgvQ5x/5Ess7gYflm2tfKyR
         11kA==
X-Forwarded-Encrypted: i=1; AHgh+RrWOQQs8PPxf7t1SX6FOPDh98lAOzLiGtyN/l0dlIcbbU+Lr05my9ggj5Bjd9q+cruPT31/DeY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcV2Nzj1YZ5f0EyiVhOaOZQLZqlm6NLMOgn7ipC2jC/K6OYiay
	KwRlQiXEu2ZaHNMUJ91Xwun8+FkqnL10WQjCfW6bz4P75kVHPnmuW38zHZohNH3fsnzsf2gcBVD
	3d5xNEmGm7mZas3HnKWPFvnCcGfDa9LyHOBGsheud
X-Gm-Gg: AR+sD11u1aUAWiQGWohx5iHScQeaIsfgZSnx5YScuLpIl9+5MN+oTGxmH2C+YDOsn3q
	hCVdaScRBzla9L3Sw+fRW7IzXkOPW/3suC0UxQZXrT0PWsNWQCV/gA0270q4eKpH4dz3DmVHZo5
	Jk7KDN7LxdM0R884uV7gFULJdDkYYbjYQjU4TlgW8c04HHBVIOJkXaNfP+Gym/sSEP95bKSmqJ3
	wi1XuOnMq7ghwWpZewFx0anKx6SIMAGW/yrYLCJFmPjEGgzyuYlYkji5l6Ck0DIr5v+S8DCCA12
	G2athwzMPPukmVd53Z/6q5xmkhHNyuOtwR/D8H7c/2kLzfkzVBuLBj1WjHKgKz9ITZJ/ngU/0tt
	H5ppHXl1xvVC0jte9nYBxHopn0CvBUUaBlSE2k0pwQPmW/wpDS+L8+VOf9bjWLqioonKL6/PMwt
	+vGtE4I05QY0k1G5E=
X-Received: by 2002:a05:622a:14d4:b0:517:8011:3a4d with SMTP id
 d75a77b69052e-52d648063dbmr27368051cf.20.1786524960853; Wed, 12 Aug 2026
 01:56:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260811095237.2314234-1-edumazet@google.com>
In-Reply-To: <20260811095237.2314234-1-edumazet@google.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 12 Aug 2026 10:55:49 +0200
X-Gm-Features: AUfX_mzGxqJVOavTuCjfhHsLo4By6nxgn2TWJI5gCQhH-4WiQvEUy1h_BwmzYIA
Message-ID: <CANn89iLdtWLvwaHMk+dCxtidQf6Npfny6beFE3h4PVhWH9kadA@mail.gmail.com>
Subject: Re: [PATCH v3 net-next] gre: fix ERSPAN o_flags race/corruption in
 xmit and fill_info
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Ido Schimmel <idosch@nvidia.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 11, 2026 at 11:52=E2=80=AFAM Eric Dumazet <edumazet@google.com>=
 wrote:
>
> For IPv4 ERSPAN:
> In erspan_xmit(), the driver clears IP_TUNNEL_SEQ_BIT (for version 0)
> and IP_TUNNEL_KEY_BIT directly in the shared tunnel->parms.o_flags
> structure. Since transmit paths can run locklessly and concurrently,
> this leads to a data race.
>
> Furthermore, modifying tunnel->parms.o_flags permanently alters the
> tunnel configuration. To work around this, erspan_fill_info() (which
> reports config to userspace) was setting IP_TUNNEL_KEY_BIT back. If
> erspan_fill_info (running under RTNL) and erspan_xmit (running locklessly=
)
> race, erspan_xmit might see IP_TUNNEL_KEY_BIT set when it shouldn't,
> leading to GRE header corruption (injecting a key field into the ERSPAN
> GRE header).
>
> Fix this by:
> 1) Passing flags as an argument to __gre_xmit().
> 2) Using local flags in erspan_xmit() and passing them to __gre_xmit().
> 3) Removing the racy modification of t->parms.o_flags in erspan_fill_info=
().
> 4) Forcing IP_TUNNEL_KEY_BIT in the reported flags for ERSPAN locally
>    in ipgre_fill_info().

It seems sashiko found one issue, a V4 is needed.

https://sashiko.dev/#/patchset/20260811095237.2314234-1-edumazet%40google.c=
om

pw-bot: cr
