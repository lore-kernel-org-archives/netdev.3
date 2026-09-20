Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 366173E7BA8
	for <netdev@vger.kernel.org>; Sun, 20 Sep 2026 08:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789893591; cv=none; b=OqLX+Hrcc1aGy3aUd8IfRYrQ3X/lIUmi7EYrCWShJ/xK7N+HLRHqbXm9AV+cCmuOVHS9sL6Y3RTb588BN80F4sCtqAGx65n86pT06vPOyesPsQiBaaStckpKDTsoqz9z2iE6PMwDJieT/l+JKeBpJlEMG4j3ZPn7Eaj1u80uWeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789893591; c=relaxed/simple;
	bh=AEVzG3BZZKQ7YDpiXhSDIeW+q0FP+8c46hNGmBogobg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EaUbCgTBXUGUFzz++1zzDlrWiA65Y+r5NkrB73E4999s/Q6KthdF02iNYRed2OnUf0GFy49mOydC7jesRMqM4mqC8BmLe4/Ig5tEo31hG6gS/bb2A2y4SrR2+ik/rumbNcxDaEC5+rMsJt/fLimmR7FE+r0DvsiOYJJ+F/2XGRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EbmYetsu; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Iwp5EkXB; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="EbmYetsu";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Iwp5EkXB"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68K8VZGc2025187
	for <netdev@vger.kernel.org>; Sun, 20 Sep 2026 08:39:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=2AGAP2Ybmw0L7jOZJjvxtsmn
	LMJVGg8ukn0BH3Z2m38=; b=EbmYetsuXA9InbIe1SWN3OR7BiVZ4a3X8RJgVnaV
	+1WZFbhyVVg9phlno0Fi0kZuD+Ro8v2kNF14xyTq3IV71pJfgqeQXD6a0mn4ag49
	keQ4ibW5j87Dqcr0xfyPbnLD2I4Aolnhu5He0lwPgpqBRc580LAjKZmHWs3HiPvT
	Y7wlVro2lGOuuOW8dB05hikiOZUz5nTRbcjk0lJmad616dI0iKCXQ1yjoNxgYMsq
	ZCy8US5c7XyxvORavdCKc67m0z9k7tZWYxMggSvACs/OrxJ67293mcM5BspNoHcs
	R9wEFcVi0kJh8+OAxILSDBzGfPgnAZpJgrzDYz4m2NgAkg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gsjm32kpw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Sun, 20 Sep 2026 08:39:49 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-9393ac4961fso302701185a.2
        for <netdev@vger.kernel.org>; Sun, 20 Sep 2026 01:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789893588; x=1790498388; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2AGAP2Ybmw0L7jOZJjvxtsmnLMJVGg8ukn0BH3Z2m38=;
        b=Iwp5EkXBmlVF6EbI55DUHRRm95KGj0Z/SsKH67sAQ372VinrfNKV9Zlj67yDk15jcO
         KuKk/+Xn6cD7B7Gsp1V8bl7CdnjQBrF4nhHu2RAQTcJuuC4OthSR63JpsCL2WLJ1+Ruw
         8409XCO4aoIAFT0JJPg/njFRvxoH+5iK1Wci8B2GH55L6LILEAtZuQvV5VFFYw0go+Sp
         UqjCFzwJdHh++dHW2v1uA0JLmI1psXWJzarjQEbUbrlmxlQMHwfC2Vl4MsKW0TS35/34
         6Qar+rmaENOu6ykI7VN+2TXm9m1bTEFN++gPRdo/JrkoJvBmdtHDb7QYHasIcjugsAq3
         uaZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789893588; x=1790498388;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2AGAP2Ybmw0L7jOZJjvxtsmnLMJVGg8ukn0BH3Z2m38=;
        b=w/n7ny1PCfFwUTlOEasqYbUF/j3Waa1No7ZkWksoG8QMK3uVx2CCwq82aDRksEtbU5
         lj5NeHGQv+0bkYlgW8bFko5oqo7O3+3pcGNTgQAmYc0L07XzBBSDyBrA+VVRXL17uw1f
         +izaZdkhDbldR8/x9S2z7TH1oVcLXWQKotXgXodDJUAIIdhqMwIzrOhT73TJlCD9IuIl
         9Vt8Qnm0kn2XSDp4zPlgNVEqttEmAGPn7gvesgH4bBlXFrm4zD3CiQgSOLfGWDE5RkD1
         oDl5ajtEkop31s5H+ZL1RTvBywESdUrGS+7QdZARNPWJf8Lk3qhHfQcJqYY9Z3eendBM
         VTBQ==
X-Forwarded-Encrypted: i=1; AKwUvBzSPYIFGT9bNfRKoxfpxuS4noUOdR1jqrO19dligxP1E7WCfrFMncmUaxtsbsmfLA7ZWTB9jWc=@vger.kernel.org
X-Gm-Message-State: AFuF++k7HSeL/hUhtk8SR/iBfhjoGxL/m0MtHZvUoYa7ZSylHrYv3lEU
	vvQq3a70vq0cs9MHtl81T3heGYyxHbGK7R8xetSXDgl9qiYtukRYNlpnoXVSJx+Bm4EK/LobmfV
	TFIpFjhesrJJwkU0/2ZI/a/UbrFocglrAP9mdnCnqs6fXyvbToYOZucLYbSw=
X-Gm-Gg: AYBFou2+WeE7RYnK8v8W/M3bvHDt6meMf8dRwkhoAg/2EfHUNP80CjzGFmvCF4uuryW
	D/SIW0w6al1ojg+OaSw+PsMtg2ScLQzetYc41kmQk+er4lC5uAPP193x4VqvJxvHvlkdwcFrS/6
	/9U0KrsEsFb1Q94XIiTiGn+q02HGD1HuW/L4G+dTPJsnoUEmS35nslnqVhw7WOXAmqpIcRncR9d
	r2bjZDl/OVfSjxqhBZh5NBa66oNtLYV2Lb4nBfziDi2ks4EoxbCzZ+AJco96cczzLDwkpCjzRuT
	gs2lFC/7LM5sIn9n1cbrPr+hddY2+rEGXeBHH4IYB3j9NgnfAJPI91W29R+lIyifmUrZlbdSeaY
	DGCbIYZtqxNRuWw==
X-Received: by 2002:a05:620a:462a:b0:939:3b56:c416 with SMTP id af79cd13be357-93bf5523983mr486567385a.8.1789893588244;
        Sun, 20 Sep 2026 01:39:48 -0700 (PDT)
X-Received: by 2002:a05:620a:462a:b0:939:3b56:c416 with SMTP id af79cd13be357-93bf5523983mr486564585a.8.1789893587744;
        Sun, 20 Sep 2026 01:39:47 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fc52a5b6esm94919145e9.4.2026.09.20.01.39.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2026 01:39:46 -0700 (PDT)
Date: Sun, 20 Sep 2026 10:39:46 +0200
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
To: Coia Prant <coiaprant@gmail.com>
Cc: Heiko Stuebner <heiko@sntech.de>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        netdev@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: ethernet: stmmac: dwmac-rk: fix bulk clock leak
 when the PHY clock fails
Message-ID: <aq-b0sgCy6ILmWSc@lore-desk>
References: <20260919174223.2356964-1-coiaprant@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="lLE8aJHE80lsFHy5"
Content-Disposition: inline
In-Reply-To: <20260919174223.2356964-1-coiaprant@gmail.com>
X-Proofpoint-ORIG-GUID: Ukhno6gS9bh-kChLCBxJYt7dYJEA_5bx
X-Proofpoint-GUID: Ukhno6gS9bh-kChLCBxJYt7dYJEA_5bx
X-Authority-Analysis: v=2.4 cv=DtfDa2/+ c=1 sm=1 tr=0 ts=6aaf9bd5 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=pGLkceISAAAA:8
 a=EUspDBNiAAAA:8 a=xsftiwRyr5-5OFJR58EA:9 a=CjuIK1q_8ugA:10
 a=zIhQHG-rzOcrLlsejY0A:9 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIwMDEyNCBTYWx0ZWRfX0vUIJsN7kVYB
 YhXoKku2DZfiJwxs1cudFhQ5hYpi4Wy/H7crkKWvTdOrAPnHUU0ppVtRovWHOAD+r+cdWQmBE9x
 hsO27ixDL8G+7Pz6bRDQnTq4J7RwcUTHBcBEY/WDnXSJDI2XOzCBUtdRfCic2eZjfkdDri0+943
 +aH0unATbeNozj/qaWO0V0unBjOYSARIOi0bSETjJr4X+Qt6oZjGdxzr0uu1qRD+OBPGj4CNCa2
 /vZMDhmO/WDaEyGRozZeqsKhDwwx96dfd+ESm/dievnNiETA1ptfzf/52hz88PdfJhs9KtSDnUJ
 zUanQazKEZHNg4YYvRAKY0tTmM+UCCHub2vv0bTFFG5IaTbDiMBJzHMI7qR814WVOJXmyqEW3Y9
 MVGmMCiIkPsNLQ6P/Fgvq/Nnd49jLWWkaVtblwc6/IeNnDg9YMchkynz+jb28DrPSCsxdvLlqX2
 tWltMpe1I7DREXtOpBQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIwMDEyNCBTYWx0ZWRfXxX+Xsyno1R6M
 WCLnIKVlU+iBgUE59nRh1iFAAiEDETElb+tuPA9dAWVJNVvtdu+vfRGCpqu3whjc3LTw15bT3mR
 vLqMMNsqzqlc4u458a3uli/E/VTT9ak=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-20_03,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 adultscore=0 spamscore=0
 suspectscore=0 clxscore=1015 phishscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609200124

--lLE8aJHE80lsFHy5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> gmac_clk_enable() enables the bulk clocks first and then the optional
> PHY clock. If clk_prepare_enable() on the PHY clock fails, the function
> returns without rolling back the bulk clocks, and bsp_priv->clk_enabled
> stays false, so the later gmac_clk_enable(bsp_priv, false) becomes a
> no-op and the bulk clock references are leaked.
>=20
> Add the missing clk_bulk_disable_unprepare() on that failure path.
>=20
> Fixes: ea449f7fa0bf ("net: ethernet: stmmac: dwmac-rk: rework optional cl=
ock handling")
> Signed-off-by: Coia Prant <coiaprant@gmail.com>

Acked-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>

> ---
>  drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c b/drivers/net=
/ethernet/stmicro/stmmac/dwmac-rk.c
> index 8d7042e689261..f3a98bd9d6ead 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
> @@ -1163,7 +1163,10 @@ static int gmac_clk_enable(struct rk_priv_data *bs=
p_priv, bool enable)
> =20
>  			ret =3D clk_prepare_enable(bsp_priv->clk_phy);
>  			if (ret)
> +				clk_bulk_disable_unprepare(bsp_priv->num_clks,
> +							   bsp_priv->clks);
>  				return ret;
> +			}
> =20
>  			rk_configure_io_clksel(bsp_priv);
>  			rk_ungate_rmii_clock(bsp_priv);
> --=20
> 2.47.3
>=20
>=20

--lLE8aJHE80lsFHy5
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaq+b0gAKCRA6cBh0uS2t
rCAUAQCj0yfpPfa6URfV93oy7BQLAm5/S0I5F+E5Bxs9H7YvqwEA0d7mRWgJU5W3
57K2prdD0OU/F5c69mDQ0MLisskqwAs=
=MXlj
-----END PGP SIGNATURE-----

--lLE8aJHE80lsFHy5--
