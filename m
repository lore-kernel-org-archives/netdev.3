Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD6F12737F9
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 16:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790614317; cv=none; b=D06GFjBX0e8/efQs3PIK6r7QcMA2BPCg3xWvIxUDxNnoLSILECNbEA2E7kEAQncJ0vtJVGvvh+trnqtfKo6XmG+7UqTzsINpz0vUrcDjxKsaxfeV32OhhNtZl5lD1rd3hXRCVTOs9FCFxE8wv4Q32iQ0yqI/RSDxlLup1UoHIeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790614317; c=relaxed/simple;
	bh=M00uic8AvvE0BxLI2kWKEXPLKdvAB5ojyAyFLkti8iE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EYSJ9cIW3SpyXf9zPVmpELIIKA05WJNK41fYv9fJU3BMQLkyMW+tBR5VZm6dIQwfhbbzsdIzyQBocoG/2+aUop/TSey80tZn8P9rfK7kZh8IiYGNbcLfIVtakqpHdvitQMLA67DX/C8ucWtlNnzwuxH6D9qukzcAUkHBxVkaBlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dZ5SaJsr; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ZvQRIwc9; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dZ5SaJsr";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZvQRIwc9"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68SEe3Lp1498527
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 16:51:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=TBEwDTeJO1bAzkL7SkeN2AYJ
	AR0dEH6W3xkuViLva/g=; b=dZ5SaJsrrQev7bb1G2ZF9ct8LIrbJTfFCAg8u2L+
	Ap2eeNDZUphfcsLPPAoU+GmuiOTxO2TqZupjwp64S6OgWVUN1oeoYmuGHMyrL1VC
	4wU2djriWUa7QKFtEgLNhfDUHCY9hHbnLMWTqKw+w5Az3xFzzD1/y64tqRICtYMt
	x8EytUa3xmGtP09Tj7CCvjSzMqJ7NrzWgsvLVzA84KHkyU8RVaCZVP7gx9y0nvae
	z7PzjK0lA8ylCAlypoQPv+WHyrF0jvmJ8cVdBFWZRAJNIUZnvdbajzf6mjsZj5LQ
	qR5swhgMYp/kXPrzS/MQWG75PNpY9unsBh09nZ+Q3Rp/Sw==
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com [209.85.222.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gyk5mtc6d-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 16:51:54 +0000 (GMT)
Received: by mail-ua1-f72.google.com with SMTP id a1e0cc1a2514c-9806535f8ffso22220241.1
        for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 09:51:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790614314; x=1791219114; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=TBEwDTeJO1bAzkL7SkeN2AYJAR0dEH6W3xkuViLva/g=;
        b=ZvQRIwc91HjivWYDfIJl8SbD/W5y7+SMF7tjriLINFcebGL19b0Y6zZaPAiEte+YUt
         T3J0vuDyz+NTySQXH2WsKh161Lw/hshSiW1sdTRNWHTZLKQKafjxvNE4R5yJCEUPUpFt
         nSAZqY6zLTBSjTjajctecgUShPWcJqft7xikNHyV/O48wcWER90/LD7rA9414T/tQ69x
         LpEyjKfl69tpo9Bxy6ZcXH8uP8TutlypNXH640CZJyNQZm15snY53nBddyOYeSGBrjrP
         HHK4cIEjfst5trd8fftmvnC1gdZB2YKf0+zTzVgMwQ36xCmGlc3XKlTCudeidN8S/ktS
         Mx2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790614314; x=1791219114;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TBEwDTeJO1bAzkL7SkeN2AYJAR0dEH6W3xkuViLva/g=;
        b=mFoxvzr88bjW6bJZmlGZL+ch4ZakHvNeUBMAHNbQ94brc0lcwc5l89ArXzSkiD40pZ
         dv9R3Vb0Zq03HvDnnRcTTi1Z3gibrRRDQTjvJCWTE5v9mG5eQaKLWktOhulWS2ZMDN0A
         AoE3VHKSgOYcARGAO81ftIqVa5Sw07jXT1Ref0se6D9pKeH91sdY4lFrfOrdMdjO1GIZ
         CxE9yEJTdxE0caAtz5uwW0oA6R/8oHFzfz9u7nV3NeKlOY7z7ZfiPIrMjWUzGJ1cPaQ8
         r84I+YyH/I4PxALntE/IKTpfFUIsEVIpnAQHU/qsvOU6s0zLEdhXCaEUuKdYWP+0UzXV
         zcyg==
X-Forwarded-Encrypted: i=1; AKwUvByxPB0FvtZgywxVTbbk8h0WEDwV3ItlMZOxbrZCqa/YLVKruHJBikFvvPVAx10aAr8IfwtFQkA=@vger.kernel.org
X-Gm-Message-State: AFq9FYIAgVbG5ccq4ZxxxdHVEyaEztmcb9Y/8XkDJPb/ktAHHzteQ9Sr
	HOhyDNiAaXr6P9/EhG3w3BJw88dMo/GSWEdTFXADVBjXl5P2vtbOYpqJ30ReRvoKfmQYo3Um/1j
	5if0dhDFoXOci8hDI/P1few0LUGf/TudfpodcsHCJLEXG0Yp7Wlma+f/MgZg=
X-Gm-Gg: AYBFou3mxtPVAjgJnvbPhyQxDFOImh3au3ApYx35lAjtNIXP8RztrgMQaTsklE0Veia
	Xn/i9HPN7JbbE0zOCUx5z2dmowu+ZTVb1I2jZF0ixnkb25aHhh+77eLGggbube7hvuLcDURVav9
	rkoyO8P0Ib43pUYoZ7wrrzPT26PXG0nuARU11DcWat/QWvOHW+uZnilv/v6SZBftMFFyi95HV/U
	krIGT34RsnSfipxtlml7u+TwgY8Ys7ubRxJqMGpdNIzSEXaVje9lYHJWK7P7MVbI7Nq2ux4IjZs
	kFVGfxrLxusAhDLOgyLMoTroPiYgPpc8eB6mUK/irH5dj6p8VTYkxjh9EZ6RnHT+iXUZiq3TVJg
	EkTuNZMej1iFMTw==
X-Received: by 2002:a05:6102:8382:20b0:7b8:1f7b:5e98 with SMTP id ada2fe7eead31-7b81f7b65c8mr522760137.13.1790614313719;
        Mon, 28 Sep 2026 09:51:53 -0700 (PDT)
X-Received: by 2002:a05:6102:8382:20b0:7b8:1f7b:5e98 with SMTP id ada2fe7eead31-7b81f7b65c8mr522734137.13.1790614313013;
        Mon, 28 Sep 2026 09:51:53 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4887a34a314sm29445527f8f.6.2026.09.28.09.51.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 09:51:51 -0700 (PDT)
Date: Mon, 28 Sep 2026 18:51:51 +0200
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: Daniel Thompson <daniel@riscstar.com>, netdev@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Davide Caratti <dcaratti@redhat.com>
Subject: Re: [PATCH net-next v2 0/2] net: stmmac: Introduce hw queue priority
 offload
Message-ID: <arqbJyW6rZiy4-4c@lore-desk>
References: <20260924-stmmac-mqprio-prio-offload-v2-0-fdd8b69efccf@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vGo5f+qo7DXy1Scc"
Content-Disposition: inline
In-Reply-To: <20260924-stmmac-mqprio-prio-offload-v2-0-fdd8b69efccf@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: nP_ouuV9HLstXjHnVMilHefoiYCJSGtg
X-Proofpoint-GUID: nP_ouuV9HLstXjHnVMilHefoiYCJSGtg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDA2NyBTYWx0ZWRfX6RP6e8OUGq1j
 sUw3wTtye4Fp6J0Hx+2yoK2evbJwy4YXwmdv4YoWpbslKZT3bY9iDsx9LJY+bBTpUCbuU5f5GyS
 DfauCLtTded5CXkQRrPiOINtNifAoXh7Iq/JckTijEYIIG+lf0DkWmO6puBRzo87rMyr3LRe74V
 KgbYuOqLN6Jo2AQZVqKV2cSy/bdWPegs61Y0WU9k/MFvF2R7JkOuVzP3pYK9oa9kZe9OlFNzmRY
 hEGd+YHnoaqkwuXLR2ESVi/G9vn9cCKgmkbux/6h0zas4MXk/cwN1qQLSdBaE2hJa0vYShS/voK
 gMIuHSlxoIUdUWmWweh7M2jZ07aZSOv5AtWqYEyMWuGM1nT08H4JdMIPCPwmWw/3mnjqkOzmqB9
 mvkZErkqnYUC4HjVzY+FJyGLJdmsfDYzlhuX/btcBC05MMKWY3DU1eN/VECw0Acp/S/I4M2gOgC
 Gd9KF9mL7wzcDghkcpQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDA2NyBTYWx0ZWRfX7TLoic4y7sYj
 WzTTbGQBLwvaEkq9DCte9o1VSwl3cQRnJ11gJ8CXelF+59MQUaPrN0hvVBA3azsqAUJrXaCmr7O
 mFzooedUlcqGzlIqW+zmOJDAmIEuKoM=
X-Authority-Analysis: v=2.4 cv=asYnmiZV c=1 sm=1 tr=0 ts=6aba9b2a cx=c_pps
 a=ULNsgckmlI/WJG3HAyAuOQ==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=UBftKYhPbWsmCYAP9PIA:9 a=CjuIK1q_8ugA:10
 a=UBkmr0p7e9xWzdnbdSAA:9 a=1WsBpfsz9X-RYQiigVTh:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-28_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 clxscore=1015 adultscore=0 bulkscore=0 malwarescore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609280067

--vGo5f+qo7DXy1Scc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Implement the offload of the tc mqprio hw queue priority in the stmmac
> driver. This feature requires the mqprio to be configured in channel
> mode.
> Do not overwrite real_num_tx_queues configured by the qdisc in
> stmmac_hw_setup().
>=20
> ---
> Changes in v2:
> - Forbid cbs queue offload if mqprio is already enabled.
> - SP requires 1:1 TC to TXQ map.
> - Fix the real_num_tx_queue overwrite during device open.
> - Require the qdisc to be configured in channel mode to enable hw queue
>   priority offload in order to not introduce any regression in the
>   previous driver behaviour.
> - Link to v1: https://lore.kernel.org/r/20260918-stmmac-mqprio-prio-offlo=
ad-v1-1-5328157fcb58@oss.qualcomm.com
>=20
> ---
> Lorenzo Bianconi (2):
>       net: stmmac: add tc mqprio hw queue priority offload
>       net: stmmac: align real_num_tx_queues to mqprio configuration
>=20
>  drivers/net/ethernet/stmicro/stmmac/stmmac.h      |   7 ++
>  drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.c  |   2 +-
>  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c |  28 +++--
>  drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c   | 132 ++++++++++++++++=
++++--
>  4 files changed, 146 insertions(+), 23 deletions(-)
> ---
> base-commit: 6516ac5e6b164bf78fb34d36b4d84d495a07c844
> change-id: 20260918-stmmac-mqprio-prio-offload-3d82d87f7bc8

I will fix sashiko's reported issues in v3.

Regards,
Lorenzo

>=20
> Best regards,
> --=20
> Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
>=20

--vGo5f+qo7DXy1Scc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCarqbJwAKCRA6cBh0uS2t
rGwEAP9oEyG66/9samTs3kLG015oGLi4ZY8zTArmgBxztWzSnAD9EEmXN5lC8XDM
aaqDN+jFQC6d2CeuyiHYN8fDNZ19ggk=
=lTFk
-----END PGP SIGNATURE-----

--vGo5f+qo7DXy1Scc--
