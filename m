Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90D2629BDB5
	for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 05:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786686721; cv=pass; b=ZhEVh2Gg7iFTjfZx0d6WRExonSOstWfQwc3gHnB/qPUMauLWEEIApysB54KXOQ/3ewIi6J05P/877kUpadAj25oOddyKNSooKcGzL03UIEa3nv8q6Pa3D1T1CHHnCgsyHwREkuAgapbVmIl6phAoGeYuv89p2y3QBIqhhjGZ2WI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786686721; c=relaxed/simple;
	bh=jJKEps0LhOwAnsLOcHFRmmtsxKWG2GV6+TTWMQJdFzI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IULFGxjSsN4pJZ6nxxnAZqdm3ilM6uHdfC2eEAwshwuPajemXWaKlgzTSBp9iMCB6CS49caY5w4Ft9ZpR4Rb6kTTjMUhzUuXj4uF3863ZtFoCo5UqNJxwxadhQdLA9pvoDJRp6Zpz0wVk/igGA3TWJa5WLhlFUSu0E1uhE5wE34=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SYH636Ua; arc=pass smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SYH636Ua"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-51c1372f84dso4849431cf.2
        for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 22:51:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786686718; cv=none;
        d=google.com; s=arc-20260327;
        b=l4reICMYu4GakW7ZeZsuaUdP35KAhA2/GQgA/64+piSuBuQTsF652Qxcrn3+I/aD1H
         Awgz/t+V9uYpgbKIATLAO5yv3zNZnT9xnVThakRJAMabu5Q95pYJ18AKLE/FA4EQjBlR
         HBxQwrD/vB3Ji+G8bwn+bep2OM0YxoANM+xnqRrbzILCwc1ou4TPNw+N5ZA0vceFsOjo
         KAmiMh4Tzpb5KeXpXcXnEt3n0vpfQwm8FBIhuItjrWJxkEGSOPNPRxSDNorVn4m3IktG
         SAb71wta9kuoXjbZ5QPltPtrk7JSeTE7ci4quenCOZgx046+k8BWcgzhybFL0IxNrAAA
         u7TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jJKEps0LhOwAnsLOcHFRmmtsxKWG2GV6+TTWMQJdFzI=;
        fh=1akay2enwkEBG1GbngWxg4N0bZ7sPFAR/hASr6cudZU=;
        b=bGwdQDJqOflRkRwezZgkQZAfy6zdFGBZLJDrE77F9S4phfSxYv9yOvV7Sdkn+eBbZ0
         X++pd5D+vo+8dsoOwbFbYOXdEoxLrq+ieTBOPf/0jfIS8m8GR/T7psd0Y/7K17kPjU7r
         vmpDHygUaJyT6OB9j7SXDb+6IRckzwfH7Z1hbA/vWIPLG3+yE4kt9l6JlR2E2VJpq4JL
         4EQ/eKliXbu9uIs8YkQo9v90x3H7cPih/ZVzp/7AD/Cv+HbGZMK9zJshk8ANDXSp6YVB
         +iVQF0DsZ1hRJhvIK90hbusimoffupZW1x1O+L5MtULhGXoYDGy61dt5kxeW/hLSUBS8
         g0Cg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786686718; x=1787291518; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jJKEps0LhOwAnsLOcHFRmmtsxKWG2GV6+TTWMQJdFzI=;
        b=SYH636UamLinyW771XF+v3QMAbC+q6K+CS5iRewUJsboFPpadFRoOxPXbrxYq7wp1x
         sZC+pz7jN21yUc6ilsmmn1wxendKsPqgfR59cYBFwP5BZ+Dk1L+vfWPJH5DOck0xIwsq
         85CkAGNFkJUq90Co2i2F4pcSagfemLvx/3TDTp42GecEnYTif7nkpQ8l/p6aC7QlBQZS
         4QXPzio52rlSR1RRRWWigQuACNOQrcAG8j9xsc2ie9NKsz8PgPoxM5ORskG3uLPNf4je
         eO0myN1/v9zVhXwmU8mRejU7od8NntTtrcJDWLHvWnnU5iTursHmonJMc7XcywSYBtSG
         +Jkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786686718; x=1787291518;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jJKEps0LhOwAnsLOcHFRmmtsxKWG2GV6+TTWMQJdFzI=;
        b=XWFvVpuLc3bqrwUY9RQFJqojKnSs63+Mt9CDII7k8ZE4M0Pu/dyx5IN37McX/4Pvkv
         cwJ6goj3GgtFixbCjffeAULx1LXFInR7+QFW41t5wG9niJOAUk334qQ1P/M3/Ja8vmVk
         IkmWLeOBnKDMBUbyrcKBSwozi3U1u4AGwsiyi41z1c+lY6ePNdCUEglFYMF041LB9LkV
         SWC7dOhU4Y7FyxzWeuTe/fAHhh4YfNMB/XFXJ3Uy9Ik6hYatvVK72CYKAPuuyAuDdnbo
         WIB401EslIoRx0LLWTeb8cofAY0QcxCuUbGWOmiHw9HHROU2r2B6xE/h811t3nGt7j/O
         OATw==
X-Forwarded-Encrypted: i=1; AHgh+RrhCUvCal26IPyDO5QciUII4z4u7ZkwR/B/thh/DB4zaqWRUPxp+uGXyPsoYEN2Wh/czsxGkWk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKD5bSG+qG/ErPXGufDn2MjDb6IoKd717yVdQfJxRpvDw3UBG/
	PHV+/1K+RT5UDqosZ7oib7adS5WHZIF6KLyq9eAb2O0peHyC7nPaPTNC2UB4hooUmmt7BiDyUCa
	HWMNsbJCJVIW1V9/RG8A03+ChC/RCuIS/FOtYP8Qv
X-Gm-Gg: AR+sD10ktnxutl1EP7k8UtXeuW0MlwrWVRu2IDlBIkWtTjNGwk0EPKTpCHLFwwxhm4Z
	zF1uyg8w/dhXjRBuUt3rff3kdXkXJ7pQer5fwQIEuVm9oG41ApqraObOkKllhPvVcsXfOgs5oJe
	026eDWcBQ/KlbeWbt1JaL6gGHQbINmCHT5RV/evuk1kYyh464FbizrFSgFL8GWioX1YX7P7mAau
	U7bZ07zK37/T+BynUH5zvgLxH5HVBSr8Lg9MTqR+GMKni2znFVUeIccm3C3jAdWJUNmSPhhnsqT
	mMnwxHMrtgLMJeelD9To4ZDXyCgeTNkdfqoO2lC+7Ox6A/11DeFCtLnQrQRQSTjS5Ei1nja9cSb
	nhbCGxyGMO1MoqPWUUy5u1DyupcIe0nhcBYLPp1A3szyvVDMekd7VUvCfYXldwZ48GfXlxl6TzN
	Rv/QpPERZs1trhTw0=
X-Received: by 2002:a05:622a:418d:b0:517:72e0:612 with SMTP id
 d75a77b69052e-52d855ae71emr40763651cf.42.1786686717932; Thu, 13 Aug 2026
 22:51:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260812205946.356185-1-edumazet@google.com> <20260812205946.356185-2-edumazet@google.com>
In-Reply-To: <20260812205946.356185-2-edumazet@google.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 14 Aug 2026 07:51:46 +0200
X-Gm-Features: AUfX_mxz1OIVH9c3lhBqbGUcSe47HT0cev3HytK1FYXlY2hlPx2eRMHo54sl1N8
Message-ID: <CANn89i+kQ2qoBpi=W4dEpgkUWBCPMOMp2bvTOroSESMeECgydA@mail.gmail.com>
Subject: Re: [PATCH net 1/2] inetpeer: enforce hard limit on tree size and fix
 NULL peer rate limit
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Michael Blunt <michaelbblunt@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 12, 2026 at 10:59=E2=80=AFPM Eric Dumazet <edumazet@google.com>=
 wrote:
>
> Currently, inet_peer_threshold is used to trigger aggressive garbage
> collection when tree size reaches the threshold. However, if garbage
> collection is unable to reclaim candidate entries (e.g. due to held
> references or active fragment queues), base->total can grow without
> any upper bound, consuming excessive slab memory.
>
> Fix this by enforcing a hard limit on inet_peer allocations when
> (u64)base->total reaches 2ULL * READ_ONCE(inet_peer_threshold). Casting
> to 64-bit unsigned avoids signed integer overflow if inet_peer_threshold
> is configured to large values via sysctl.
>
> Additionally, when peer allocation fails and returns NULL,
> inet_peer_xrlim_allow() previously returned true, allowing packets
> without rate limiting. Fix this to return false when peer is NULL,
> ensuring rate limiting fails closed under memory pressure.
>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Reported-by: Michael Blunt <michaelbblunt@gmail.com>
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---

I will drop this patch, sashiko is not happy and I do not really care.

pw-bot: cr
