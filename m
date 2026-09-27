Received: from mail-qk2-f38.google.com (mail-qk2-f38.google.com [74.125.230.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC4DA3D7D69
	for <netdev@vger.kernel.org>; Sun, 27 Sep 2026 17:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.230
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790529051; cv=pass; b=RQajFqxXJKo17jdDve6FGHe7sK7xFvoLTvDhZbjmudOHJprolw+gAAwqIOuxi6rP4PfLzChFay/HC10VdWo6xNQXSDkIazY9Ust4fyKp+eg3bZZj/as3AthQSHei0p4699SG1gNc/FDdVTWN97f1UfdaOaGk37lVzUNQLPS4Ecc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790529051; c=relaxed/simple;
	bh=ikTxL5JuCzeBWeGH3nGI6q2+sz2cBQtCh19A8s6v9IU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qeDprkUkXNxdAt0kJERdakcJINXL1iA//UMS9l8+vjkbcX0BTFaFOlK3NN1b5vSvm2ViumjRaMe/M8xwuVAHDiSiaSzRB+ruUjnHm3otzokyRu5iilGR2QJxotaRlEuLEvKqJevcB7LcPA5HmeHWIRqMaSKj+YVsMa6DsvFPBNo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mjYrV562; arc=pass smtp.client-ip=74.125.230.230
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mjYrV562"
Received: by mail-qk2-f38.google.com with SMTP id d75a77b69052e-53336049862so5932061cf.3
        for <netdev@vger.kernel.org>; Sun, 27 Sep 2026 10:10:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790529049; cv=none;
        d=google.com; s=arc-20260327;
        b=Z9vGgBysEm/udhumPyt6JUDgdT+1qRnIH3KYM9bxeAksSWcyXn97nEIgx8KHMaxtC5
         /0YmwiIWkpwqG6pjGkbT7nMoVD+LmUGffnMYTqvY1lvWDOVpUNUk6CrbeUwZ7R2eoejJ
         TvJeP++VRDhYBBJqsESMOUKo93fRiHG9PHFnF0Zl2KEi61p+cJfdHAC7AVwiojObJ9UX
         ezeOt5neYKRul69b8a0USdB0cPlEqFUYUzMPYci/ndxHb/PgoH3Ll/63vRPYe32D3D5y
         GhPzr8Lqs79YzIH6ecs/cbrXJG0vMmR58xWRuwG5FJUzyuE5mRO6b3sisLP7IHFPZIuA
         m2rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ikTxL5JuCzeBWeGH3nGI6q2+sz2cBQtCh19A8s6v9IU=;
        fh=BqxlKKw+plAEXYbshrN8BCr2F710OVje5a9Jx90yYcs=;
        b=sGUVSdfA5yO2LBsLZ5PoEENZo8D64eoJB5viE8CBfDVFrYbwKiRHiHlJtcLvJgbsW4
         8UvSCCFrfi9relF84uWEv/s4wbgXri5zLvwpOpmBFkZha9GRK6U2+wmuD98yy1Nbtl6N
         iRKTiW+WyutRdTo0s3Cf5OcpGv505xlaYgnnxSfGsxQ20PdwlPzF0VSNSb5GnFxGumWM
         Ob0YjAcQmcuMiyWkLAU7zxeiJ17yQYuZ6QUIL7PQ7/aR7vT57+FpW5wbAc8YzBK5fiby
         9TLFk1/n60+ou6MrJAsQu/9MvwgDK7dMq+kPMxpr5MtmsGolVMth5H49tk938MgoobA9
         qJJw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790529049; x=1791133849; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ikTxL5JuCzeBWeGH3nGI6q2+sz2cBQtCh19A8s6v9IU=;
        b=mjYrV562TasJbRzRBYNqKC29SivwNhKDbxhj8AoHA2aSdNv6ISMmbfirO2kXhJKL7W
         aGEwcRZjVs2DINpoalIM15LpsqiJUzRmZpd6ulR4TYWF0/i1Q/ORxuHe9aSGrmGq2y6j
         +eznTl45kUfeKbiDC77TCXGz4rMAPmPj7a1aiFdteZQusu7fDZzskU1UBTr9CX2446P5
         emkugc5TJRPHYB7VDj7sKxybbe5+pivYaeWaH8VRPXd5VGI1+E2OxFaQs9ocsEwGVee9
         sw63SsjTbrp2VvrKiHftS7AofETr1d+kE9yWGCQhF73wbvnc9g14Q3T8D6KLATNqIovy
         DbXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790529049; x=1791133849;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ikTxL5JuCzeBWeGH3nGI6q2+sz2cBQtCh19A8s6v9IU=;
        b=l7w702pVUug4q7CW4NLcSedSt7IuDP4411LWixXNs8q1yMBrMaANYWGGVoRZ0TxhcU
         yKqN8G8zJpQp6Fi5U9M8UGnu4o5/ZKmsReQTrXBRmAToI+beHbBr6andCY9supiTbq1Z
         bdIwkWL02989qBefkJGfBoI95F7EIK6uhAlJ1TSMRBKcvUxdGM/GqUTvnHqPOcsyvgBL
         OP20OKFSG2kj77m7lfTmighZKbCQkkzHryV2Ln/eIuC1RU1hwZ5ZdPZYZM4Cd/5EL4ZL
         A01WaC3KYAZbmUh+r2OxXBdq2OFUOul1lXKR37qffU9XORjt6BVlaRgnB8JIMUybYVRV
         ek3Q==
X-Forwarded-Encrypted: i=1; AKwUvBxMoXDuu/+7rjSE+WHAu79Ht3Jy4Foj21cCYzXVDjh3iPvSZ+rfCtyxVhtMSqRd4qEAdgVDlTA=@vger.kernel.org
X-Gm-Message-State: AFuF++lSiq7AAAH699ExHAgIn/Wch9FO7TKpoNr3tmftYBvEBUh55RZB
	h/VXq5ln18CvDPd2IZHckXx6RmdnYx/FLbeMP2BOeokTkQhIJ6/y/bWdX0AgFXXIlTL7zYDRpPc
	/hDCleoPyberH2ZIazTPf1aPGsSggpwi5xxiHdpus
X-Gm-Gg: AYBFou1PuLL11wtQzOmK1VtJksG6NuPx93n3sfCZkJ2I087T+2OR48JqUCRxYS2gSYU
	jm/U5RAQydV2r1WCHznuStpCFXUz3J2h9b0iwj7E2L6dzrg1Iz65mVTOmh/Q9yLCwCu9Zc27QwB
	Ze/EuAiqniW5A+CKoALbiyGsDC/cTr67IJg27aQAK/zMW86FVBcMkp5zhlzv0eLM1OrPccnFlJu
	JipZFDhO3y5bcH7GWlOTmQDSQ34X9VHv+IaJ3jQY1mRZW0KljKNVFWdcK1V6t+x4YsqZtLE1TtZ
	ZWiargGPtpc75RrCIoX44gch7xUTT4y11u16fx58uEDaozCn34P1foBFcw0HxGpXvuUUn1PcTE1
	HXOPyjpxVeqtUiDLw8L451aqKMrAeoitALMEcjlZnDzSRyOu0dQz4xjKBwSko/eOdo4r6
X-Received: by 2002:a05:622a:6f16:20b0:533:3868:1f6d with SMTP id
 d75a77b69052e-53338682227mr27382171cf.59.1790529048151; Sun, 27 Sep 2026
 10:10:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260927163117.746432-2-bestswngs@gmail.com>
In-Reply-To: <20260927163117.746432-2-bestswngs@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Sun, 27 Sep 2026 19:10:36 +0200
X-Gm-Features: AclHuK-wtOUaURDTxb0s4NuF5eW9fAjvgRkV0CtGV9tL1ejWVBuFWcDjyUMkjB4
Message-ID: <CANn89i+monpTo=bjqnHRhuGaCkfHe9BJNhJncjK+vUq0YKAAag@mail.gmail.com>
Subject: Re: [PATCH 1/2] net: gso: validate TCP headers before segment length checks
To: Weiming Shi <bestswngs@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>, Shuah Khan <shuah@kernel.org>, 
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Xiang Mei <xmei5@asu.edu>, co+1fe9b56e2c61be5e@bugs.sh, 
	stable@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 27, 2026 at 6:31=E2=80=AFPM Weiming Shi <bestswngs@gmail.com> w=
rote:
>
> skb_gso_transport_seglen() derives the TCP header length with
> tcp_hdrlen() or inner_tcp_hdrlen(). Both helpers dereference transport
> header metadata without validating it first.
>
> A TUN user can supply a TCP GSO packet without NEEDS_CSUM and with an
> invalid IP header. The skb remains GSO while transport_header keeps the
> unset sentinel. TBF and police can then reach the length validator and
> read tcp->doff outside the skb head.

Do you realize this leaves non-TCP GSO broken with unset transport_header ?

Please fix tun instead of adding numerous workarounds in our fast paths.

__virtio_net_hdr_to_skb() needs hardening instead.

virtio_net/tun/af_packet MUST not feed 'gso' packets without transport
header being set,
among other things.

pw-bot: rejected
