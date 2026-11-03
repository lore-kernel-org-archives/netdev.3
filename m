Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793718570;
	b=NXC1ZCUBukszmyRDqMqL7PT9MwH3igg2iv4JjAZkV6fPpjgE1fAcZOLb/M8HZlZ5vP6y
	 fxLkhiQ6JBgtTBrpGbpoqPc7twQzAhrqNS4CvGQo0hE5NGX+28ekafcTr+l/akDl0i4NG
	 ZaWp1dzAIEF6WKjpXUcRq5G0vVUMlwrJruk/kz88cfXHle9mKPomlPpBn9sDWty7ZBas0
	 RYvjvJ+WfQytiOh9QsHOh2uHjpzv/TWDK884zCLJg7wS5NpOMTuc9+Sz1+LQ1mBRy7uBQ
	 HIzL1aZ1Q5xjIO5S9VVgZj20k+OHFh1DKjpSsDw8rpepr3Rp9+nsKQqQpDz/vgfOvXw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793718570;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=WtnaI/rE8dqZ2TDAvhFl2l1GKkkDIiG6JUx0pMWVYEM=;
	b=wxbyaCIOrYwMn6F7gszZ2LwOqWlyygup+dgxjbKehNnLFq69B64aUJAJPR28XyKGQauM
	 U29zEgsxmfI186UHdFMQydUtop2l9IQ00dB4R1xoLfPcgGXBx679WDl2DLbzRMpanBOWG
	 9z1+tcWTyi3Ars04Nfnu8jPvcc9HbXZGYcT0Past/gL9rIVqOYF9RtobWR7wuqcGGdeg3
	 qTTJMO1ul4yhep3+7SME/O+DgkwbgHl73IC43M0VigOeUzJ1z916OiUOpsQvSCAwu4H7N
	 QcE9UYWt9e6UA8CKWfnA0so55nKsdl+/k6tTvgwIbL1X2mOVKURHEVYI0AC1dZ9ZYdQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=VsvtV3m1;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b="WIRhC/7S";
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B05B6606B258
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 15:09:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B05B6606B258
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=VsvtV3m1;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=WIRhC/7S
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A3E9wGB2727725
	for <netdev@vger.kernel.org>; Tue, 3 Nov 2026 15:09:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=WtnaI/rE8dqZ2TDAvhFl2l1G
	KkkDIiG6JUx0pMWVYEM=; b=VsvtV3m10nlkXZ186rhLO4fXxZ39IP3M8PkirN5C
	J539yVBBCInCy9QYSttMftMfkEaL6QsjEsnb9/RDBHV92d40CjDJz7ih50M4rz8o
	TK2naZkOM0fmNGNCiBnvZ3wRMdLSkzSmptMtt7GQt6dO/VxnuA9pUe6KgTrW7kzh
	R0d1lIJc1kdjdYm0Z9MTvTJI+WCuCG7Lu0i39aNLYcshkGP4zZOaSiofyfAU+ybR
	mqXdhY7DSz2hhRhMCNgSJaE1dxgY0LiHa3O5GAB1picCaLZawKfF18DSsV0305HE
	OV7cY0xmf588y2vhyX17iBh70D09IrgOB5m8maqWexiMSw==
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com [209.85.222.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hqh2bg96v-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 03 Nov 2026 15:09:28 +0000 (GMT)
Received: by mail-ua1-f72.google.com with SMTP id a1e0cc1a2514c-98c70917433so3755992241.0
        for <netdev@vger.kernel.org>; Tue, 03 Nov 2026 07:09:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793718568; x=1794323368; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WtnaI/rE8dqZ2TDAvhFl2l1GKkkDIiG6JUx0pMWVYEM=;
        b=WIRhC/7StYh2rC3dkCm4KbTxV5XjVDo9zXU9qc48guyYH3xJNy/KTLt9SQvG+k5yDv
         DskYq3UVTGsyLClvTXHkXWAtSpETT7GX8Ol9GOYAn71cmeSUn9b+o4z+H6seJ9k+seM8
         dN9Wb533yXg13gQ2603+QPWU70dVxcCOW5g0wttELLkUDUr9SO50EiwfiWYsjc0h+jvf
         nOexh/Kay1N4sXM+0mY6SK6Ro4wkdEI9Edlzo30keUZoS1ZC+He/5q/GX1Yy10hvaoHe
         eCZhrCmqHXaFSQYQPdv+8gAZQbZyudYHiE10CJ+/XNnpsEwM+yooQET63dbXJ0vjmuP+
         vLhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793718568; x=1794323368;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WtnaI/rE8dqZ2TDAvhFl2l1GKkkDIiG6JUx0pMWVYEM=;
        b=Rmo/5r/tT02ICIxKhO9L0pDNtNayvDQUMeQ/i/7f9uakhcCLrQ+w5lZJIagdSIqvCJ
         PpDENc+1cV3KebTXsT+i81sfbc+typZ9qfZ288YUJ+lD2TWQ/tQAfouhvLTsxSzcd4h8
         mlRDL1TUtxPjfT0SKn1V59rp3YtZBTy0bK4TnmOXfke1fabQJh7tArX2kOVgBMPdG56x
         +KdqXlbfjTPRt99Uj78A7IUx8hcwth3rY/3TzLg2zm8rsAenEPfeOYhrvE3/hPkieRjD
         jKsE8tTDlatskUFq626eiFREbYA2NlxpwJ73v2yYGGUFqu8jeICm9T7aFkuX8YIkxr6O
         apAA==
X-Forwarded-Encrypted: i=1; AKwUvBzLXs+gO+/Bw/Qg8W+mJA1rKX4XBSIsqIkoilkKKF+BmdknsszWjDX/PBdoTX9xB5QyYvF1xhg=@vger.kernel.org
X-Gm-Message-State: APuU4Z/zuTTGBF14bhdLBjoSw/e3EVXi//g5k89Gf5u7tdDMJpKL93jp
	NgqM4NWuwXmyKFgnw7KCCNom1KaEbrMO+nei572JkshW04r0GYguj0y50D9FhcjEXDjlPAa0bTb
	cYVXF13IG0JGJfvL31J4BkCSF/FVZkh0iETVEsHlbJIV7dofmvtPNsgv1a+Q=
X-Gm-Gg: AYBFou31unEaw2Fpcment93/rHQgSvVslZwsl6lQzVjl32mFmoSfwppVCG8GMaIp75/
	FLHNG8f6uvJIWXO7Lnh/kL1L3GP27lEF+k3ynzwb7NQqXMRvGe6686UCAxIPw8qDc0sfRghueHq
	sYkxOL+Z0Yc1ixXmGanHfFdaxbW5e6+Wfdm+7UqpkI86kT71d+gBvjetsdQ+LOGIpYWPGJRLLY1
	oGGMWCnBxwyT+JikgdMOAn8bEBT1v3YwEdAbBd/MGHp3AKPYBnUxFFXKF3XmHqQakV55iBC4Vqj
	GSi3q/xDmFY+zHqyt27Tfv4LQxg+P01atKgJ4GuqLvbd4MVPF6fvyfbdaNqFYSIKi6JWeqG9qTR
	gmO3tzuAqn/7DVEQz6Zyw2eYBc92r6eaZxIXWw0bSu0s44kRlZXbGLcN7LLkoRw==
X-Received: by 2002:a05:6102:f0e:b0:7cc:9d59:9b6e with SMTP id ada2fe7eead31-7d07261530emr5713666137.13.1793718567383;
        Tue, 03 Nov 2026 07:09:27 -0800 (PST)
X-Received: by 2002:a05:6102:f0e:b0:7cc:9d59:9b6e with SMTP id ada2fe7eead31-7d07261530emr5713641137.13.1793718566728;
        Tue, 03 Nov 2026 07:09:26 -0800 (PST)
Received: from localhost ([93.66.104.131])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4abeb77af8csm465070355e9.1.2026.11.03.07.09.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 07:09:24 -0800 (PST)
Date: Tue, 3 Nov 2026 16:09:22 +0100
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, Jakub Kicinski <kuba@kernel.org>,
        davem@davemloft.net, Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Russell King <linux@armlinux.org.uk>, thomas.petazzoni@bootlin.com,
        Alexis =?iso-8859-1?Q?Lothor=E9?= <alexis.lothore@bootlin.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net-next] net: stmmac: selftests: Add missing endianness
 conversions
Message-ID: <aun5IpJsYPwrnBYB@lore-desk>
References: <20261103122249.951523-1-maxime.chevallier@bootlin.com>
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
	protocol="application/pgp-signature"; boundary="IxJjiVHShnjx8PxM"
Content-Disposition: inline
In-Reply-To: <20261103122249.951523-1-maxime.chevallier@bootlin.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAzMDA2MCBTYWx0ZWRfX6y2P1Ecz6esk
 WwvftPx4J26lA+I47oYADyyu0nqmowevbhcm3+BE+BL6jRugMOffTMSxF3B3v9N8ZwXBm2xFg80
 YWPpsQBv86nE7SVN8Z0Hm0yHcffPCyw=
X-Authority-Analysis: v=2.4 cv=Xs1vqlF9 c=1 sm=1 tr=0 ts=6ae9f928 cx=c_pps
 a=ULNsgckmlI/WJG3HAyAuOQ==:117 a=cAAIdyqZgEis9HJxay2Blw==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=VwQbUJbxAAAA:8
 a=QyXUC8HyAAAA:8 a=P-IC7800AAAA:8 a=EUspDBNiAAAA:8 a=HEzXNubd1cMG4gQdFsAA:9
 a=CjuIK1q_8ugA:10 a=HiAPeVrv790yWpiQFZ0A:9 a=1WsBpfsz9X-RYQiigVTh:22
 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-ORIG-GUID: gGkmocnH1CkNvzVco_4Xsd9X2mOl9r6q
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAzMDA2MCBTYWx0ZWRfX3F8qCOq+aGrl
 K8EtZTGTRin4VKfuudIqu9CgN7I1g4pSo8cmnUYIH52ZuinxeOxDi1PQEnds/GJ17dgmcP1jyyQ
 OkEcuudh5/EuziD80aYFqnL/h/gPLDJoSEkcNmDZb0P43d8D7wyQ6qPIGl64QFx7sQ3NeprnHNN
 3svFK106o5DvcYZ//mbbw201A/7c2z1C1z3q/E9xfeQ56kW7Gf/IDVnL+zD/qNFIAAtkjdX7y3G
 iwgIHIy6GK9M9mkctZUqFq6pSxV/LvbzHA9Mj33PPJzFYszO5UwDQJ8tTjmlwccBDwt3tUEJmJE
 jecwjcbREnjuzajzirKE3LZQ/DMooDmmiSgYnBWy5v5k5tUtTaX7XQ0PYFlOCgYuEg+zsJOafQF
 60pCDG0mbomPZG8GFs5qL6X6a9zX7tb7fswBlqRIk35qiLJjXcwDoUrOw9+hSGD5cnyGSdejrce
 +rutncUORW7rrfjeOyw==
X-Proofpoint-GUID: gGkmocnH1CkNvzVco_4Xsd9X2mOl9r6q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-03_03,2026-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 clxscore=1015 suspectscore=0 lowpriorityscore=0
 bulkscore=0 adultscore=0 priorityscore=1501 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611030060

--IxJjiVHShnjx8PxM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> The kbuild bot found some endianness issues in the stmmac ethtool
> selftests [1] let's address these.
>=20
> In practice these missing conversions didn't cause any issue, as the
> masks / values on which the conversions were missing were either always
> 0 or ~0, so skipping the byte swaps lead to the same value being passed
> anyway.
>=20
> [1]: https://lore.kernel.org/oe-kbuild-all/202611010511.Mk620DTd-lkp@inte=
l.com/
>=20
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Reviewed-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>

> ---
> This isn't worth sending to net, I've dropped the Fixes / Reported-by /
> Closes tags, let me know if I should add'em back.
>=20
> There are more of these endianness warnings in other places, but they
> require a bit more attention. This'll be addressed at a later point, I
> don't think we have many big-endian stmmac setups anyways.
>=20
>  drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c b/dri=
vers/net/ethernet/stmicro/stmmac/stmmac_selftests.c
> index 40811df8f2b7..df696e2c1528 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c
> @@ -1216,7 +1216,7 @@ static int stmmac_test_rxp(struct stmmac_priv *priv)
>  	sel->offshift =3D 0;
>  	sel->keys[0].off =3D 6;
>  	sel->keys[0].val =3D htonl(0xdeadbeef);
> -	sel->keys[0].mask =3D ~0x0;
> +	sel->keys[0].mask =3D htonl(~0x0);
> =20
>  	ret =3D stmmac_tc_setup_cls_u32(priv, priv, &cls_u32);
>  	if (ret)
> @@ -1463,8 +1463,8 @@ static int __stmmac_test_l3filt(struct stmmac_priv =
*priv, u32 dst, u32 src,
> =20
>  	key.src =3D htonl(src);
>  	key.dst =3D htonl(dst);
> -	mask.src =3D src_mask;
> -	mask.dst =3D dst_mask;
> +	mask.src =3D htonl(src_mask);
> +	mask.dst =3D htonl(dst_mask);
> =20
>  	cls->rule =3D rule;
> =20
> @@ -1594,8 +1594,8 @@ static int __stmmac_test_l4filt(struct stmmac_priv =
*priv, u32 dst, u32 src,
>  	keys.key.dst =3D htons(dst);
>  	/* Match the full IP proto field */
>  	masks.bmask.ip_proto =3D 0xff;
> -	masks.mask.src =3D src_mask;
> -	masks.mask.dst =3D dst_mask;
> +	masks.mask.src =3D htons(src_mask);
> +	masks.mask.dst =3D htons(dst_mask);
> =20
>  	cls->rule =3D rule;
> =20
> --=20
> 2.56.0
>=20
>=20

--IxJjiVHShnjx8PxM
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaun5IgAKCRA6cBh0uS2t
rEreAP9RquFj7WKKDysqBVQoJ6e0dVIsW1UM/4cQsoIBq2aelwD/T9/Pdxsxz96+
bqDDg/n0YBnH3cZXcJCfxoB/tOAA1g0=
=hOaE
-----END PGP SIGNATURE-----

--IxJjiVHShnjx8PxM--
