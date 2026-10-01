Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6340137646C
	for <netdev@vger.kernel.org>; Thu,  1 Oct 2026 13:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790862801; cv=none; b=Iaq02V2vZ9X/k55A+e9bVNnTOg9zLwtjbkCCk/+xwbLBjy6+8pvtQVL+/u5h71sft/lHj6fctx1FcIEbHUgIumGtna0/oNfKn4pYoHMDSWPzapPGxmsL+A0g2LhdDzbh8yqpRrmdNaYZJIw5HNSPiAdASBE7JyK3T7xJ4d6MPIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790862801; c=relaxed/simple;
	bh=D/BxxDzc/Lc+HxTghuFBlgbWpPveHMoR9Ck3Cs/KYwA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VbEEFQFhptftFh1YOqSs8EE8QxXbW0SeYW5kdcp3TlcSZZSQxQ8M8kWJjgCC5es6xmqd7yw30EQFoMn4Tn26b30CSeI5u++S2JF4KoizXBk7PGQJTl5S9Br5I7Vt6knKXFT14IZARwujnVJBYBLNcM3j9dMuwZorKszBs1SMyvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bpp8giiU; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=U+SvlZUL; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bpp8giiU";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="U+SvlZUL"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 691DjBKv3703675
	for <netdev@vger.kernel.org>; Thu, 1 Oct 2026 13:53:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=OFDrY6jJae9sQwA/g3w+iQrt
	Izp0EFP/zxY0CoXTnCI=; b=bpp8giiUnK4uLsq6baRkCaK0oAqKx8JpJWoUzFCq
	oR/aRp2lcOKpy2LKgjB3ELJBHdlHgiVQvDYaQEtha9CcLcbst0+rzdN0T/QqpddL
	diTXXMK7mRp/C/w/meg5cQoZklX5IoF6k2citY3xg7rlVIT4OXznbCqCXFtq8s5V
	VzZ88BSR5WZub9EP1BPXj2Wqb3dgJKjl0IVnmAkz/7cF9yuOv0jePA/pxr/709DX
	O7DW2jf/g2Gs9AlfAjaBOrvfpatao0IOD7jEPWeFzvvVIaKn/agVIMpnhMAh1MxI
	Ei+BZLZPupa12MLnQ4vAqUI/Y/z7cxUJIJo1Jh3nva99xQ==
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com [209.85.217.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h1hvkhyvw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 01 Oct 2026 13:53:17 +0000 (GMT)
Received: by mail-vs1-f72.google.com with SMTP id ada2fe7eead31-7be858243a6so342378137.0
        for <netdev@vger.kernel.org>; Thu, 01 Oct 2026 06:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790862796; x=1791467596; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=OFDrY6jJae9sQwA/g3w+iQrtIzp0EFP/zxY0CoXTnCI=;
        b=U+SvlZULpbntB6F2ZWr6Hdhojab5FiVesWgh04Grh+DFVqgZYh64eEdBxv+5AIeRJ6
         d9SgZlUBFDBWXaN37OWDn8e46AIU5/MePJCEHc6SFD5hY+9xl2DUjiz2Pb/8YRI5IgAh
         IFasica6mPNqlSZB15VQbL91Qw1IWlobxgimFod9aicTy0nND46iAVMzZuD1MB4ztzbH
         5F6FoOkTe5oWIpT5lDSh1YNkrBM+bJPqzFA51FJHyKJo9MHNVh4hBhNX9r+6AdxyBOYA
         8deuIzcBPcBq1iPeLHnmgjXIil/NzmL8y9Wqho12C1db7EuzIbfv2M7JNAyPqP9B+Ht8
         pIeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790862796; x=1791467596;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OFDrY6jJae9sQwA/g3w+iQrtIzp0EFP/zxY0CoXTnCI=;
        b=ijgb3xDY8x83wnypNPAAfXLRj2R9BIXAZmkS54eYN5iktzBoQd9VTioRImBnto6fGF
         W4D1Ii+4TE4HxSM5bJaoNcmFfs/PSjuTC5Z3gxASZiXL8yXYK0PE+7qq9oMFp1qgjY7q
         YvxKR7IxdHazd0oHZHLJjKa0nl0vh6ell7MnWbrG5mA3m93muQHfOFv0sVA5BdvlP/lX
         LkkILPD77ct7VvRm+sbUiG11RgK9NsJE4vL4PEoglNdsMriBwqraceoDm0lALwOEZU0I
         nrsLcPoEEZOITVxxUUBaGfFilkiUi47ylwmmV1PJdQ8827Zvg4XdYwrV21OZdElWjCrX
         sV3A==
X-Forwarded-Encrypted: i=1; AKwUvBzFOAKReQtcBF9VZQKDqxM4++qdbPst6GPj4aDocDRl2Nd91b9ibn735K1GPNXGMGYQgOhgrck=@vger.kernel.org
X-Gm-Message-State: AFq9FYKMqNMQqR4leGZVgg2FXTZJ6KN3rMBTthQJuyHwCEdo5mIvdj7d
	Z/HruDjc0Cub8S3UIc4WGPeE9WFXu5+3TmZeflSbTQwYPiBUv+CNmAU0tFI8TlD9xS1aLjS4UFt
	KZnhMK0Vi0ye+CUFLGlpzk/7z9sWGnOAq70yfUoEz3hOkKhBaO0++CN5jx/w=
X-Gm-Gg: AYBFou1ohxEQYU9J8u5GrwPBW283arl2vmHRmGnBWo6xG7BwymKCATsFVQR6cxHlzvF
	e4F+c8zAbe7ehhVVzBDcCAeK/VlKBZw1dgiiI7yNUYlTEpbBxWu4Hl39Slxjbm+MYDuLyWS4QFV
	FJ+N0ASqw/n/13KImYPAdEHS0PA0dZ9MYiXDdvA7EGzUr5vb8iBcnzpqrigNj9c76bXuT4EW23i
	GJN/B2IYdfAIbnNbt8BBsnv/ANyU6BrgIf3if5gGe9bmKqzFIfr/sJa0gyEbHdOCZ4dhtxYYw1u
	hsGjuMKgtJ0iMpWUq46E6ILve2jNgd0Fo0kFIvoe6xB6AtxyQSevQXEPisWSZ2U61Iox6C5KPMP
	s4dzg4sgqrqJeCQ==
X-Received: by 2002:a05:6102:2b84:b0:7b2:f790:c028 with SMTP id ada2fe7eead31-7be73a8dd26mr1146110137.25.1790862795953;
        Thu, 01 Oct 2026 06:53:15 -0700 (PDT)
X-Received: by 2002:a05:6102:2b84:b0:7b2:f790:c028 with SMTP id ada2fe7eead31-7be73a8dd26mr1146103137.25.1790862795417;
        Thu, 01 Oct 2026 06:53:15 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48b0690d284sm6096797f8f.17.2026.10.01.06.53.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 06:53:13 -0700 (PDT)
Date: Thu, 1 Oct 2026 15:53:12 +0200
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Vladimir Oltean <olteanv@gmail.com>, Furong Xu <0x1207@gmail.com>
Cc: Daniel Thompson <daniel@riscstar.com>, netdev@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        Davide Caratti <dcaratti@redhat.com>
Subject: Re: [PATCH net-next v3 0/2] net: stmmac: Introduce hw queue priority
 offload
Message-ID: <ar5lyAFx3H7Z5McI@lore-desk>
References: <20260928-stmmac-mqprio-prio-offload-v3-0-abbe181f5024@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="oVNdUR3qC5DoPBrS"
Content-Disposition: inline
In-Reply-To: <20260928-stmmac-mqprio-prio-offload-v3-0-abbe181f5024@oss.qualcomm.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDA1NSBTYWx0ZWRfXyj2ZfGdJBevC
 Zu3HAKEYGed+yrN/lcqerDaeepKkFinISk5rG7RQilnODBHzX6/flgDXQRl7QHyPmhI+qC2TWAZ
 mkhfHdImavuimnz05/TyhZmROq7yOyk=
X-Proofpoint-ORIG-GUID: rOF6eKqOO5K6fjX7EfzvyxMg_aJoOrA9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDA1NSBTYWx0ZWRfX92swGinmfFEH
 FjeJnwJwodV8eKZVRQackRoB23wGE7ls6LNosoU4CPtutWX3J4+Pg4STsNpKHjRB+UrcJD5ATg+
 oOpGqCoUPzKe/RzgNDIgDySs6ujAgZWK0w/iIsxCFS8GrNF0BAuvc9LTUN0GwKt9E2GgfHRlHvh
 DSzuhWApKpEvwGbIAWzlT+4ndZFH9EczkVfkSDQTuyekEzxSTb2vMbw3G4YrMOwyXHQN6Xb3uVj
 8T9CQRjBEx7zH88swwzgnTytESl18LtNxPdmGvyrbu2zk7h7c+QINlEOwT8gGtLChwfvykouy3e
 oCNADP2V/kwWVkracNAtO7HASaMo0d+T1grkLbpIdkVEGARueQa67illkfhG3KzM5aOxFYK3krJ
 GHaVJUprjEYxQLOzwOKwrGV0z/yRJM4rTwtVGoRLdrh+YwhfNN27h7Dyv0PBp2sEaT/duuP0ncg
 YpeG7ZV7ZXN4L5LMg/A==
X-Authority-Analysis: v=2.4 cv=IY8Symqa c=1 sm=1 tr=0 ts=6abe65cd cx=c_pps
 a=DUEm7b3gzWu7BqY5nP7+9g==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=n-0y5aq-Uey8P2rTCuMA:9 a=CjuIK1q_8ugA:10
 a=TfBcX7fOkBFiNxCBcSgA:9 a=-aSRE8QhW-JAV6biHavz:22
X-Proofpoint-GUID: rOF6eKqOO5K6fjX7EfzvyxMg_aJoOrA9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0
 bulkscore=0 impostorscore=0 priorityscore=1501 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610010055

--oVNdUR3qC5DoPBrS
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
> Changes in v3:
> - Fix cbs overwriting removing mqprio qdisc configured in dcb mode.
> - Return an error in stmmac_reinit_queues() if configured number of tx
>   queues is lower than xmit_qdisc.num_tx_queues and mqprio offloading is
>   enabled.
> - Link to v2: https://lore.kernel.org/r/20260924-stmmac-mqprio-prio-offlo=
ad-v2-0-fdd8b69efccf@oss.qualcomm.com
>=20
> Changes in v2:
> - Forbid cbs queue offload if mqprio is already enabled.
> - SP requires 1:1 TC to TXQ map.
> - Fix the real_num_tx_queue overwrite during device open.
> - Require the qdisc to be configured in channel mode to enable hw queue
>   priority offload in order to not introduce any regression in the
>   previous driver behaviour.
> - Link to v1: https://lore.kernel.org/r/20260918-stmmac-mqprio-prio-offlo=
ad-v1-1-5328157fcb58@oss.qualcomm.com

I will address sashiko's comment in v4.

Regards,
Lorenzo

>=20
> ---
> Lorenzo Bianconi (2):
>       net: stmmac: add tc mqprio hw queue priority offload
>       net: stmmac: align real_num_tx_queues to mqprio configuration
>=20
>  drivers/net/ethernet/stmicro/stmmac/stmmac.h      |   9 ++
>  drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.c  |   2 +-
>  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c |  37 ++++--
>  drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c   | 144 ++++++++++++++++=
++++--
>  4 files changed, 169 insertions(+), 23 deletions(-)
> ---
> base-commit: 014d795c73837ea2339a4ea8e8f82c6e959b845d
> change-id: 20260918-stmmac-mqprio-prio-offload-3d82d87f7bc8
>=20
> Best regards,
> --=20
> Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
>=20

--oVNdUR3qC5DoPBrS
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCar5lyAAKCRA6cBh0uS2t
rFoYAPwIof3Ii6CtUjrRrswysbsJ6mXCQG3Qm6KMH59m8VQIswEAtY/GVTsy0GxB
UK5hZzSmyHk71qhui2ggdZrfK5RAnQ8=
=vuXL
-----END PGP SIGNATURE-----

--oVNdUR3qC5DoPBrS--
