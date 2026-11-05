Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793872348;
	b=AMKcMLeeXYb7mJ2sGDoMvZYAdbpN92FKm0pBpVj0yEAgaXyZ8xKfN3LhoNKDoKooZj9S
	 +iExcPRCM6y+BpysJjfNdsj2rP5HmN+MVuWBMC8/omslnV0YYIc2R+R5g+fo+a2l34hxN
	 BLF2yNwjXYs/5g6cn2ezezTDEcWpVu63eI1XC2H1jmnJMM0hGQOMzLoN2k/sUgOMM+/7W
	 gRqXnzEg4RNEYsZuSh8N4lBWWAaz9kWqJ824nTG74UrLaQauP6t3YtMYsotL6Zefpcj/k
	 jeTom3P3BfbqdSHaN2MzxJ5XhR+d2GypGwdGyaDlBao6l9rDjQT3V1iAavROpTqes1g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793872348;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=E+qJ0z0fXRRbniKVccRo08SFzpNX7/DEea7wwix12bk=;
	b=GpHU0Bgdct1em5tXVc0NGuMihC6qU7et/dsC0TndNgNaWcFrrGtuqfFx6Vyi6PtktuSj
	 lHpwKdlgWsU0bTpGto7VaL8d+GcWDgqMD6dIegVNo9uwEMspiYnKVQ/vrbtCqlrWTUtin
	 ojo58pdPvb8Zyq0hOU68dWPnsZHCu2GJ1bFmaYUS/nEdgwPmABmOJIV/UnZmqJYK+noYZ
	 4U9O0BCxcY6RECehbBjRvsYuqjs5wnoMZNZyWFKK0yJbWigZNGa5QWNl8FoPoWGVHDc7u
	 40xJCIheXUr54MXX/JMzfa8gyH1BMRlOgVUL26J6UMgf8ozG4eL+5hgGQ3/Cse3q01w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=hUpRSQHQ;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=fIWDuhCA;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E403606A32F
	for <netdev@vger.kernel.org>; Thu,  5 Nov 2026 09:52:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4E403606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=hUpRSQHQ;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=fIWDuhCA
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A56Tps43223036
	for <netdev@vger.kernel.org>; Thu, 5 Nov 2026 09:52:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=E+qJ0z0fXRRbniKVccRo08SF
	zpNX7/DEea7wwix12bk=; b=hUpRSQHQNYfzfC83FLjaF9kiN+vrTNClTs2yMHLr
	V6U3/TFCDDuLfmA0v8TEcFYuBIc82veg0J/8uS8cQlbl7w7xhbaq5SNZVoA5PmWu
	dqi7rikyjTxN1viRfD7UGdZLuBBBa7t6Yv/mdF5kBHYjQ9kOczrzWlmcifJmnQBv
	nHZ3aHFDDIc7X0HnsSGD8Sl8VTl0roeSJuBw96nLMc2j0iLQw7OYGxUS9KPZD9+y
	TMZ/vajwlTI5PHq/BkyRlVH4sDSfcKvOiYkjM/LYrBi3JsTTj2iyazdeWcC010Gq
	gf39GtswjHYrSwOH71Q/qInyj2dBsdIcjU3DL5asIJXFeg==
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com [209.85.221.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hrj43he7p-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 05 Nov 2026 09:52:27 +0000 (GMT)
Received: by mail-vk1-f200.google.com with SMTP id 71dfb90a1353d-5ecb636b587so121740e0c.3
        for <netdev@vger.kernel.org>; Thu, 05 Nov 2026 01:52:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793872346; x=1794477146; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=E+qJ0z0fXRRbniKVccRo08SFzpNX7/DEea7wwix12bk=;
        b=fIWDuhCA2AMYcb+vBM1haVMFRfz0srQFqfhmiFkjTElnDCZZHxmLQbcpM6f+kww00C
         UpxMG0qFcKToFwI/Q9hGVrHEcdwiSTc1zbxuqbugR6YibOkhufOql30t914oSZyTNyT7
         y1jkUkkOAKWLTC67cp5Jp2B0FGtLzlxjZ8VCeMlSCGhk3PaYyMJmCq5Zb38qIbyvpJfT
         OX0+xPL/Cj89nBD2xbASNOoGt6WdRbIMT8W7a/GKyxkeO+YyBmWot8inQcX1HAPONTNq
         oVrXZp7z275jWoHrAlhw9hnn9nVfOdgaz3UGIabSre1JbKYNc0qkL6vhMr06LlP/RLBE
         AXnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793872346; x=1794477146;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=E+qJ0z0fXRRbniKVccRo08SFzpNX7/DEea7wwix12bk=;
        b=ooX+fpscf9rbu/3LxmQ/WZ4yT1U+REpRkUVdQtyZe5VyCSbZuiSIxMvxMhx3096vY+
         filFBe2BJvyaa5JSHpvZ4bpKtPuTt3K6PL3Tk3bw5B9K+9oH+LhfK115MvS9Sud6p0eu
         vzibfCQ243UYgav/kVZkQDyUlgQEqwnH7yAK4OoRLkMrIiMt6ap2YuaGVgrZWCF/cOTe
         eEg5NE7MPmzl+roPRW2Sxg0nBpu8sSr9oSR08brwXuDXB8oHBEZ4wbSnE1LzOe7/trhY
         oUDcgAO8x1jD4d87IuPAia4583d08N105vmfPvcistIbOioTkoPqdEWbzpc9w+IMKnYb
         uIkg==
X-Forwarded-Encrypted: i=1; AKwUvBxisegdtBLJp7KQE0+vdTZOoFAAOIIOHPXOqin1CrRwzBVi5rCBsG3CjUBCNVOXszzdymweeos=@vger.kernel.org
X-Gm-Message-State: APuU4Z8DXVa7cgYZxNwuYhFfNwqg+7OU2D62MxGOvYyE8TZbCdVJBM7d
	62ffNA7B9yEDuF0R/6o61LZEQFYjpBzqOVHGEEZBsCekVyF+z3Wyry5M46thTruir9pwLZyk9Tm
	DdNW97t6pnGLsmJpUeQgxcWGUFS/l5N0xsHJMn6ykoW/w/Y9n0tV+QIFfeJQ=
X-Gm-Gg: AYBFou154nHBLXzAwFDS+9GYuYGrXTn1u3lMxyR+AEtzdNu/EefMWkVj5FjDJrfJuEl
	GvDiyfyuErSDpu0pYtncaU8PltlU7QGPKVg16pNqs1THujFBv7YVk8pNRq5CjdpWyMWt3bOr563
	fevCwVYcSo0kig+GC8jV0i0fI1jNbA+7Aiv0JADVbMJJwlgB2+LacgPbjkTcqj6Eu9gQS/JL0ty
	dqlAlbH417EQsqk+/e1IHL/tPqlFO0ElqQEKeCc5nm4SKALye6wDdn7u1A1ulwB/RHrbn3ZF5SN
	+pKavvrA/b1J7BqqoV1vDbQmD1CAcpqbrfto+ZTlH8RbAFB5UvpAH4W+228WuotrzK3Kg4dwmM1
	8rfSWmpMR95vrBR8vHb42mkh0fCD/RWv/tAMLIriyUUc5RA88ES9psr198WNXeg==
X-Received: by 2002:a05:6102:32d4:b0:7d0:3ed0:c61d with SMTP id ada2fe7eead31-7d07227ce39mr7822340137.2.1793872346267;
        Thu, 05 Nov 2026 01:52:26 -0800 (PST)
X-Received: by 2002:a05:6102:32d4:b0:7d0:3ed0:c61d with SMTP id ada2fe7eead31-7d07227ce39mr7822312137.2.1793872345655;
        Thu, 05 Nov 2026 01:52:25 -0800 (PST)
Received: from localhost ([93.66.104.131])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48fee968763sm8898539f8f.56.2026.11.05.01.52.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 01:52:24 -0800 (PST)
Date: Thu, 5 Nov 2026 10:52:23 +0100
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Richard Cochran <richardcochran@gmail.com>, netdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net] net: stmmac: keep est_lock across PTP clock
 adjustment
Message-ID: <auxR19bfAdOc288M@lore-desk>
References: <20261102-stmmac-ptp-est-lock-v1-1-76fbc0cb230d@oss.qualcomm.com>
 <b7102713-8bc6-4a5a-bf33-b79a646f4126@bootlin.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rMRGzwt2sRAw4qTo"
Content-Disposition: inline
In-Reply-To: <b7102713-8bc6-4a5a-bf33-b79a646f4126@bootlin.com>
X-Proofpoint-ORIG-GUID: 6PFa9ho82BzTYQR-8d4RlCpFhTKDDrzj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDAzOSBTYWx0ZWRfX15SG8+IGOVay
 dMXN49cbQPLsEfxxdGSe0bLdz5iZg+nfcnnapN1QZkSoyhQza3QJ/syS04CGeptINE4FU7xbOJg
 gYcU2XZuS4q20WNnB8/mPAtP5blKI31nkDhAXO2ZueHcZ8xmkvt2fJiVXUtX7d4bqqlAig14Xh/
 o3F9fdE2OpB30gxp5zN296kGwi2VXeJto/hV3NIk8NzDA0erI4HEijHyddKqwgv6U0SP1gk5vhz
 HRuwQHTb/RU4XyiDWiULWuLXpwZXKBlyc2XuEJlYEpqeUNHuEoCjlbN/ypKrhN2TBPe7jYF0uDQ
 05EFF1QlJjgCg7vDru38BBohvlr0XengvWu2WP0aIfrAiyGe1MDUpqo4TMSpY/abhduUwLvEzeY
 myDtztRkQDc8yGLJs+kmQoOGFmr+rUOe6qnRu5ixsv8ULcedpl2t1YdSuRZKslXEsdYZUbbi5jd
 93Voo8DBbVyZu79hdig==
X-Proofpoint-GUID: 6PFa9ho82BzTYQR-8d4RlCpFhTKDDrzj
X-Authority-Analysis: v=2.4 cv=SZdi5fRu c=1 sm=1 tr=0 ts=6aec51db cx=c_pps
 a=wuOIiItHwq1biOnFUQQHKA==:117 a=cAAIdyqZgEis9HJxay2Blw==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=P-IC7800AAAA:8 a=yEE8vCkc6EYpfAGo-GYA:9 a=CjuIK1q_8ugA:10
 a=bkY8HCoThClCxJ_FmXcA:9 a=XD7yVLdPMpWraOa8Un9W:22 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDAzOSBTYWx0ZWRfX4zw63Io1TYSs
 uKkMq8lILB2ki4Mv+qKemK8K7o/MxlzxEuHX9MnC+TATVGwWSJiDNwbwPEcTPvLsz+TFyY2E6Av
 +0hANOcq42PamUH0WAH+SIgfFT4mH3A=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_02,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 spamscore=0 adultscore=0 bulkscore=0
 suspectscore=0 priorityscore=1501 malwarescore=0 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611050039

--rMRGzwt2sRAw4qTo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Hi,
>=20
> On 11/2/26 18:37, Lorenzo Bianconi wrote:
> > stmmac_adjust_time() disables EST, drops est_lock to step the PTP clock,
> > and then reacquires the lock to reprogram EST using a base time computed
> > from the new clock value.
> >=20
> > That leaves a window where a concurrent tc_taprio_configure() can progr=
am
> > EST enabled with a base time derived from the pre-step clock.  The gate
> > schedule then runs across the PTP step with a stale base time until
> > stmmac_adjust_time() reprograms it.
> >=20
> > Keep est_lock held for the whole disable/step/reprogram sequence so no
> > other EST user can program the block while the clock is being stepped.
> >=20
> > This does not introduce a new lock ordering: __stmmac_setup_est() alrea=
dy
> > takes ptp_lock through gettimex64() while holding est_lock, and
> > stmmac_adjust_systime() uses readl_poll_timeout_atomic(), so it does not
> > sleep under ptp_lock.
> >=20
> > Fixes: 23d96de472f7 ("net: stmmac: re-apply taprio offload in __stmmac_=
open() and stmmac_resume()")
> > Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
>=20
> I couldn't really figure out why the lock was released in the first
> place, LGTM :)

same here :)

>=20
> Do you plan on addressing the sashiko pre-existing stuff ? seems to be
> rare conditions but still :( sorry you end up having to deal with these...

yes, I am planning to post a fix for it, I am just awaiting to avoid to post
new patches on the ML before these ones are applied.

Regards,
Lorenzo

>=20
> Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
>=20
> Maxime
>=20

--rMRGzwt2sRAw4qTo
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCauxR1wAKCRA6cBh0uS2t
rE67AP4p7uxcDSU+u+UHizM3E7eioXxcsdqqYLpWaO+hcHviZgD9HdVMiBiy8Iav
M8tJFGknKjS0Sl1s04n16G8Y29tblwI=
=6ZuU
-----END PGP SIGNATURE-----

--rMRGzwt2sRAw4qTo--
