Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C026A27AC57
	for <netdev@vger.kernel.org>; Sat, 10 Oct 2026 13:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791639612; cv=pass; b=O0wzm302aqs1HfhpmSeQZOooFshGZxlDc9bvpkJcWblzTNtAXPkUfy2J3f1GTiwiGKX0ZuQDikSw2HhSJryrN9C4NWi/YjW4eUiC+KCbXtYvbq3kEPjAK9B6+Tmbt7GNrDULGkRu+A+/0ZJubCUU9a65PF+9SVq2PJZTgKWtb1s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791639612; c=relaxed/simple;
	bh=iYqhoVZ+Jyml4P0MGYzZBl9up/LYhbapQ8gAv8jGngA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Uv1Kqzxuoa4ZoQo5/PP9YzpmpQNFMTtzLOWFUUdeXn2/Vwvl/9N3V3oV5DtlVgJMDRtRVCpvII3T6Jk8032DvfQI4DDjlfS/YR9NMYkIxN/JYsG8ueecQXAib/jr8x0bt55XX7AhqQYKT6Xkdww0tfM8JwPLENBXK3I1NptUrz0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZXAZ9GWq; arc=pass smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZXAZ9GWq"
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-3a20367cf82so5306291fa.1
        for <netdev@vger.kernel.org>; Sat, 10 Oct 2026 06:40:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791639609; cv=none;
        d=google.com; s=arc-20260327;
        b=hJo/SrjFjAYWjKq2mXevDU9xP7HJ+d0IMGnMdPOC06gYnWuYStBrMklL90ufzVeJ7o
         8JmZJeVu82qI5i9h45JXZa9/STHhzXvSON2uqqXaZKeQGmHpiNWZk+MD0aZm9h5mJXjS
         4IxK5wzLwzIvj7kQ15gllSIftP6RwbTVj2Uy6OYPAb0sxTdmJC+JWEqNWjB1D7YvcR0b
         ALxi0R7BvusWMEafNyjg9zKMQdLxplrwMV4reRZ0WX84+Xaptu9RfnCBtaQsecUfRFy0
         umnnLANash0C6dFYl5/Y3XzU1kqajTO/TI7IMFOz26qy5/EOs9dvbqE/diBXpU+a4xs5
         cWFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1OMPvqt3i2+F+trWLfv914nMC+RGH+n0BOpujrLH77w=;
        fh=aEB7JnvzRNgm/kIelCj/qxa0U96lvJQT0+D3qUa+Rq8=;
        b=rnzU8cb94meu0yI2jzre5uJQy0WKDuzNj8kBQwRAWFWOhjRUdMH55feTZmtX6T7QyP
         9OIn4VcxeH19H2vf5xh9pM8Wj+amxTSGSCwlXmfKxJqodwHnm6vLuoxFXvS8oC8W6Rz3
         WRaQrmUCHU9xyYWPkcbs0xBX/elnk6KLzAKX74X46GT19k+IHxfsG+hx4GLSRV6CoHyY
         cuoXH4wWZuCvscUuITgHRWA3zjop2Jo+rRxnqGIXFEujR0rHLe3DsI4OgRQz08wEQ65z
         CVzQ71eCMMOKq4N/LMtY/p0qiBtmXX/SRY4DIFp+ax1G1+IgvM7klDl/7BGH/l6DPjKZ
         qDwQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791639609; x=1792244409; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1OMPvqt3i2+F+trWLfv914nMC+RGH+n0BOpujrLH77w=;
        b=ZXAZ9GWq2w2N/D2wWSTnlOkfEAe51ltRLDrYbuiULJDm7BKDbfNcqJWB0jDk7LsJjM
         zpSXQMq21iq+Uq4i8loxLMWjHSNKMJN5vv3+jzIc+STsBnF0cIELEho0GZTiYEOR4jsi
         3J9Rs9gsSPM63oCfE135zN/SgdVq9hbvy2yta4oTJ1JHo1HNhDajWflXmGiG8XLuDl69
         HGSLHWTR9gUOvDtkqc6O58y8bw44wmUW5ejuuNyf0AV4OrrVqWK48M92yJDeGDYzsTGe
         UECbrTh73toJRj+3j/J+SuN3rtW6enoSZ7iIctMYVc6JKYEbsu6meBwLNhxeWVVF97ec
         brkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791639609; x=1792244409;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1OMPvqt3i2+F+trWLfv914nMC+RGH+n0BOpujrLH77w=;
        b=OEyONP41VQ/UmHyl93QNsQf8BZFU6/iNhfRiYlqorWMYmXhWVtwh/9reHDGGPbpPoP
         2MGdNHqAyQ+/2VWCFEY4TPMll6860PNuLg7B0xSAYB7jgD21XfL3ccDDgQe5GpwvXIlc
         pYtsmofElR/HtAl9kL4YsNGQQ7C+4XeXJtyWUmRcMfnKxk9qAeyKA7lHiHB6EqvRMrOs
         YN05ZppGf5BAoN83cj+PrljItYsTebOeUTzGxDPG2PRoJXAGai2OBg8uMMVgtgI5kB+Q
         8H6ofnEhbFJiLcwqD0BJkMHmL/mAHJCAcsUuFu7amq9rhGgUSilO87JWnGv+TC2hImEL
         RGGw==
X-Forwarded-Encrypted: i=1; AKwUvByT9X9+8qqk4bC5IfDTCC4mAFFmsS8ABqTK54DJrcNJ3mw/a9kHz0DizLAlSEGHHVKKnXuOu+Y=@vger.kernel.org
X-Gm-Message-State: AFq9FYLxMpdPiQVyfQsC/XM8ObFs6GgDuHdYFVDmWggMO+da8IZgeGz5
	ZQpnWJZbfsDlovewR7GwrHQfV895b9yxAFas5gsymFqXPONzdePVSjuToJDLCMKChWYCd9lZ1vv
	RcmTEArNHOi8LYtQ4uRN4CIi5Lbt0qSg=
X-Gm-Gg: AYBFou3IigQmQFaPIfvEvAoUoCA7ZawXp96kag+SUB6twXfU6C5+xXwTyPmen+Mg+UU
	KE/aH+WBvVQqqIbUGHM50vWHm1JNTuPKM7rwVhSVT94v5POoDTv8mca948z4MIfqC0Tq3pnAnen
	dCEWuJoeIO+EOO4ak6tDOqv3txibsA/DeB2vzg518GAA4ElPFIaTAZ3hKJqA26Acd41C5bwEvK+
	OFGJ5nDD6x1AJ0f84APfShOz0YKxVRFNphteiqMrYhaZF/5pUy2Ae9qvuO2NzJ2u0K3NmaH98dN
	TCmguFbkeeoNbm6rmx1xfSnBg4hSEsv+/tqhFqjTkQqOajaIR9nCaTkRTT3tEkQNZ/yX5Lsqb3d
	N9WgB0/ZI274q/kieTYK8QnTe96Ou5l5Du6T63dctgIJS
X-Received: by 2002:a05:651c:54d:b0:3a9:7f37:9bbc with SMTP id
 38308e7fff4ca-3a9c535761amr10525921fa.11.1791639608635; Sat, 10 Oct 2026
 06:40:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261007115821.11332-5-sigefriedhyy@gmail.com> <179154713266.434549.3119718667275543634@kernel.org>
In-Reply-To: <179154713266.434549.3119718667275543634@kernel.org>
From: Yuyang Huang <sigefriedhyy@gmail.com>
Date: Sat, 10 Oct 2026 22:39:57 +0900
X-Gm-Features: AclHuK-8lTLLnkYqyGO4ub-KfSnA41bLKl_MgKWzh-nerGwP6xbhIB0UlOeiU2Q
Message-ID: <CA+7S2vJEYr7sbRqf=QdURN+gLp=5aaRGXG3iprA5Rz4-sEqj3w@mail.gmail.com>
Subject: Re: [PATCH net-next v10 4/6] net: add AF_PACKET multicast dumps
To: netdev-bot+sashiko@kernel.org
Cc: ajay.kathat@microchip.com, aleksandr.loktionov@intel.com, 
	andrew+netdev@lunn.ch, claudiu.beznea@tuxon.dev, davem@davemloft.net, 
	dsahern@kernel.org, donald.hunter@gmail.com, edumazet@google.com, 
	idosch@nvidia.com, jacob.e.keller@intel.com, kuba@kernel.org, 
	johannes@sipsolutions.net, kees@kernel.org, kory.maincent@bootlin.com, 
	kuniyu@google.com, nicolas.dichtel@6wind.com, nickgarlis@gmail.com, 
	pabeni@redhat.com, sd@queasysnail.net, shuah@kernel.org, horms@kernel.org, 
	sdf.kernel@gmail.com, vadim.fedorenko@linux.dev, willemb@google.com, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> - [Medium] dev_mc_dump() (net/core/dev_addr_lists.c) calls
>   nl_dump_check_consistent(cb, nlmsg_hdr(skb)) once at the end of every=
=E2=80=A6

> - [Medium] dev_mc_dump() reads the generation (cb->seq =3D
>   dev_mc_base_seq()) only after the walk, once dev_mc_dump_dev() has=E2=
=80=A6

Both are real and are the same problem as reported on patch 3, will fix in =
v11.

> - [Low] At this commit, Documentation/netlink/specs/rt-addr.yaml is not
>   updated for the new AF_PACKET RTM_GETMULTICAST dump.

This is done in the same patch series.
