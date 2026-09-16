Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1004E3DCD9C
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 13:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789565550; cv=none; b=mX3FJLAM9+zPJp4CzVa6f3mZw2G8lgBNCmkRoeIMKQ6y/Hh0noeoWbw21npKgmZ9mhucWR8xdqPNyG1026M+cDNRovH1sRWi2Hz46G9H0AEJsSURs5jUSWiznhzK+vmiiJZMWfL56QpOHwnOVOmYhecJ/Kry0AmZE3sVrOGA8aA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789565550; c=relaxed/simple;
	bh=TJOPU11RcMATtIJnIIx4zDB5egcNfZ0cNE8AjUBHtrU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EruDbnikANA5GVnFrSqO3CiVM/E4tiHue7cW/AWbFNmJAL/72+juE8eI5jELtA3GadLn3B3Uxknot1F/EpIs3qdtqP5ziG81lg0ZD9On4fdVKWb3Mg5W/Du9cjMp01YFS3sHH6VeAd9O7REQGjEWggWqzwJMBjq8UpV5/zLLkKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=V4GpXU/O; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=b55h1usZ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="V4GpXU/O";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="b55h1usZ"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68GCYSvx3843666
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 13:32:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=qe2S3srd1ujMpZtLOxTjpY2O
	me9X1N9uun2WLowXtZw=; b=V4GpXU/OUWzxUaYUHd0oGK1WYU1khlQr3aeBheGu
	Vv3Cx4I7CUuyPxFbA32OKSMiJU7JhlZyi55orQ4J4NSyPIYHzZeT6PauFLsVM4lu
	8LK0u2VWijNwpQsPNp1uExIkPU42Utwp3el5SAg4NtzhL4KVrKUWiS0LMeDUtM33
	EmtFpiH/KcYyGlxZLooIVT1B5piverXFjH0RYvFCPAc1LVodfh8+p/arUkEEo6lg
	CpWpDVv7357L/cW2MJkz334VEJjLtEoNWjzweFzYdO/T5IbaWXu+y5/RT5VXILSb
	odtFvMmbCseEAzIJLjvxprkFinMlqSGuXIWsgK8hatj0WQ==
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com [209.85.221.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gqefpbc7f-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 13:32:23 +0000 (GMT)
Received: by mail-vk1-f197.google.com with SMTP id 71dfb90a1353d-5c7d5444845so6716127e0c.2
        for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 06:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789565543; x=1790170343; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qe2S3srd1ujMpZtLOxTjpY2Ome9X1N9uun2WLowXtZw=;
        b=b55h1usZXfl+jEm1Z5yyAOK2RxKjbpWIcQZwEwE0P0HXy2V6U1WalYpR/kYLm2X2vp
         vUp38DUYZdqQJNTVcsqDrV27t7sNMyDE8NhWNE3weHsxVkwDdW0es5V2i1slCUI9kO5B
         xZVu//PQyZp/IW4Y4tA1QLeLJA7cynViDT54ZYssN8Swb1PnZbffMvzkQBSVl4wevj1o
         7jj6ZNuofnYs8a1vrN1/n8Zt20Myg42dBjlq6rNBACM6J/LUPlor8LDekjvSPB5VcXDg
         7QDxdAR8X1R/3KYmrxaXcyBzlztmpZ52qdgh8lIZpiylV/MfpVijwv565vI53MPaD9Ms
         754Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789565543; x=1790170343;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qe2S3srd1ujMpZtLOxTjpY2Ome9X1N9uun2WLowXtZw=;
        b=v5elX162FR6Y7Jc1LzSoEPVh7fGWX1/a68cvmS4izKCaH33L7hD97H8XTp1rkcEdbE
         6EX2f0iTolKSHo8M1HXCwYgyz0Q9FJjYgFEiVfVULNNdKDu03Ixpsc7ZyfX12eazfQyC
         ILqO0GEh6SLE8OWdtnIso5g2aBLB5vvHS6yLLKqPD5IEI6s9C5tu+iEGhrUwYtmwSmCc
         xhvTc5/z92iWCkrpoSHJ/aIJ6BxPR9CdYa117B+bZlnenTc5jJ6EoIIGGbTr0MPRzpOO
         i8ge2dud2eQRv4zpNM8gUEy/Yq4D0gvJhvnY/+xZcKc2l7IiJ5veU+8P2KD0l/VfLIaU
         crhg==
X-Gm-Message-State: AFuF++naMl7wuCao7yjKAp1WKT1uYBlJDqZ9rhoj06xp8JJJZ9hOzObL
	c+HrciS1MaRAysGkrt76SCaBJTiB+Ip9DTBBdaUH9sehZsjPx+AZ00Mcm9Pnd3QtCnskDDRzM/2
	9FN4K8UJScCyK07jF+DvvL2WmOFa3EggC+zK30WcD+yqtr/ZSQosJjf21RJg=
X-Gm-Gg: AYBFou3Ax41PprI/07HrLbo4ZDkED/joXTNb9rHiTsEu0WW5pfnobobHdrhTSYZQUcD
	MgSy4943R7slXILpTAKjrxIa1TOcMMxzgLwLvst2bZd1K+W0EDqxhDXxxYMGQHEOGxs7gNyygBM
	SF+h7w7hT+zOpesxa074Y6c40lMU8x+/+No6bMsfhPZu3c65KZ4Ckj3Ty5y2m6SLJ27agCtSkP9
	pGNez/otpwYWXfDuPTeTyZmFyoi2IBGKyeEh13l6X/COyBMqO/8RUoKAd1vCZcGaXsuk2vXyU/e
	h8wTMBnJBQ6JZTEKRhrI2+wygYFd1c4Nw3ZCc1s7VfM3WSpQ0SxZqQilmczvNvWpPrZBMQOvOV+
	4USRqqPBlxXc99A==
X-Received: by 2002:a05:6122:f05:b0:5c2:c0b2:9880 with SMTP id 71dfb90a1353d-5c99ab370dbmr3156540e0c.1.1789565542719;
        Wed, 16 Sep 2026 06:32:22 -0700 (PDT)
X-Received: by 2002:a05:6122:f05:b0:5c2:c0b2:9880 with SMTP id 71dfb90a1353d-5c99ab370dbmr3156428e0c.1.1789565542158;
        Wed, 16 Sep 2026 06:32:22 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4870bef7687sm8311975f8f.1.2026.09.16.06.32.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 06:32:20 -0700 (PDT)
Date: Wed, 16 Sep 2026 15:32:20 +0200
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
To: Sandeep Haemoon <sandeeph@loljews.com>
Cc: netdev@vger.kernel.org, Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo@kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH] net: ethernet: mtk_eth_soc: allocate dummy netdev before
 registering netdevs
Message-ID: <aqqaY4wvRf6LUKjZ@lore-desk>
References: <patch-12c1a57b1d914b28b89455f24de55ee4@loljews.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="++p2aDa+hzFcHMO0"
Content-Disposition: inline
In-Reply-To: <patch-12c1a57b1d914b28b89455f24de55ee4@loljews.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE2MDE4MSBTYWx0ZWRfX5DE7Jny6b/F2
 3k3o4twhKukBCrfbUKW2orKYXTfo11xBL+u8jS3EpXfV33wkwOXgz3u+dDHSorINDQUrA5zSYRD
 4gX7Me8mvduPOkJGHpjeJFsobAji/wA=
X-Authority-Analysis: v=2.4 cv=HrTjiETS c=1 sm=1 tr=0 ts=6aaa9a67 cx=c_pps
 a=JIY1xp/sjQ9K5JH4t62bdg==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=Q38KU-38AAAA:8 a=CJssPnnXo0ZNb1wB1VMA:9 a=CjuIK1q_8ugA:10
 a=0_Dvorhm3KXYGdzd8CsA:9 a=tNoRWFLymzeba-QzToBc:22 a=mpgw7_Rw23-bP-ukgNEv:22
X-Proofpoint-ORIG-GUID: eEvfm4ENBH7X3g2kI5O4iFcSsu2ZS1_l
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE2MDE4MSBTYWx0ZWRfX3tBSwgtZWgQc
 GvjFy7BGRGJF1LvC+9pjnpmnurF5VYgJWZ6I1Zc6/mJY3WDn+kSqsBSOOCFXmSYumT/k63z/I8w
 nYwafSpKGY+TStWzVtEHygca0StzYSref5Nap/eMNrKH8qfJ6GV+u8nrL7W04/LE+sQ88q3S29c
 OWXdTF/QG1ILGi1wgTV6xhDQMkt9xjSvqt1J+wjXBHKu5WIv5V85YnMqNywiSQB+1+E5kigDcUV
 /J09AaRtSOGqxvoY3x9m/WpsGrtkXOXgoO8ABwmao7+5+WJ4cvoEU87CXwfDtKGTt0BUc5Hll9P
 oq+nb8RLroNww9SeXcYEJewkOHuRXx64H72CD2+APdfDROTdIYJe6/kCHNzTNSos/EshxlDLQ5f
 F31m5IEQ/IjcDQt5SGC/4lqOxvebWlOM8li54ec5MHIxQGNg47Yis+g7G6y8QHMw2sr4As2/dmL
 5rhedavkTwPdbObeCRg==
X-Proofpoint-GUID: eEvfm4ENBH7X3g2kI5O4iFcSsu2ZS1_l
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-16_02,2026-09-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0 phishscore=0
 malwarescore=0 clxscore=1015 priorityscore=1501 spamscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609160181

--++p2aDa+hzFcHMO0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> From 0000000000000000000000000000000000000000 Mon Sep 17 00:00:00 2001
> From: Sandeep Haemoon <sandeeph@loljews.com>
> Date: Tue, 15 Sep 2026 22:00:00 +0300
> Subject: [PATCH] net: ethernet: mtk_eth_soc: allocate dummy netdev before=
 registering netdevs
>=20
> The DMA ring and NAPI are shared between the multiple MAC netdevs and are
> carried by an internal "dummy" netdev (eth->dummy_dev). mtk_probe() creat=
es
> that dummy device only after the MAC netdevs have been registered, so for=
 a
> brief window the netdevs are visible to the network core while
> eth->dummy_dev is still NULL.
>=20
> If anything brings the first netdev up during that window (e.g. netifd
> opening the WAN link the instant the interface is registered), mtk_open()
> takes the first-open path and runs mtk_start_dma() -> mtk_dma_init() ->
> mtk_rx_alloc(), which calls __xdp_rxq_info_reg() with eth->dummy_dev =3D=
=3D
> NULL. That triggers
>=20
>   WARNING: CPU: ... Missing net_device from driver
>=20
> in net/core/xdp.c and returns -ENODEV, so mtk_open() fails and the
> interface (e.g. the WAN port on MediaTek MT7988) stays down until it is
> manually brought up after probe has completed.
>=20
> Allocate the dummy netdev and add the shared tx/rx NAPI to it before
> registering the MAC netdevs, and free it from the probe error path instead
> of the now-unneeded err_unreg_netdev cleanup.

I think the Fix is right, but there is a preliminary bug to fix I guess.
Can you please rebase your patch on top of the following one? Thanks.

https://lore.kernel.org/netdev/20260916-mtk_eth_soc-netdev-fix-v1-1-5dac50e=
b65b1@oss.qualcomm.com/T/#u

Regards,
Lorenzo

>=20
> Signed-off-by: Sandeep Haemoon <sandeeph@loljews.com>
> ---
>  drivers/net/ethernet/mediatek/mtk_eth_soc.c | 31 ++++++++++++++--------
>  1 file changed, 18 insertions(+), 13 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/et=
hernet/mediatek/mtk_eth_soc.c
> index fd7a49a..ae6a19b 100644
> --- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
> +++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
> @@ -5337,6 +5337,22 @@ static int mtk_probe(struct platform_device *pdev)
>  		}
>  	}
> =20
> +	/* we run 2 devices on the same DMA ring so we need a dummy device
> +	 * for NAPI to work. Allocate it before registering the netdevs so a
> +	 * concurrent ndo_open (e.g. netifd bringing the first netdev up) never
> +	 * observes eth->dummy_dev =3D=3D NULL, which would make mtk_rx_alloc()=
 ->
> +	 * __xdp_rxq_info_reg() warn ("Missing net_device from driver",
> +	 * net/core/xdp.c) and leave the interface down on boot.
> +	 */
> +	eth->dummy_dev =3D alloc_netdev_dummy(0);
> +	if (!eth->dummy_dev) {
> +		err =3D -ENOMEM;
> +		dev_err(eth->dev, "failed to allocated dummy device\n");
> +		goto err_deinit_ppe;
> +	}
> +	netif_napi_add(eth->dummy_dev, &eth->tx_napi, mtk_napi_tx);
> +	netif_napi_add(eth->dummy_dev, &eth->rx_napi, mtk_napi_rx);
> +
>  	for (i =3D 0; i < MTK_MAX_DEVS; i++) {
>  		if (!eth->netdev[i])
>  			continue;
> @@ -5351,17 +5367,6 @@ static int mtk_probe(struct platform_device *pdev)
>  				   eth->netdev[i]->base_addr, eth->irq[MTK_FE_IRQ_SHARED]);
>  	}
> =20
> -	/* we run 2 devices on the same DMA ring so we need a dummy device
> -	 * for NAPI to work
> -	 */
> -	eth->dummy_dev =3D alloc_netdev_dummy(0);
> -	if (!eth->dummy_dev) {
> -		err =3D -ENOMEM;
> -		dev_err(eth->dev, "failed to allocated dummy device\n");
> -		goto err_unreg_netdev;
> -	}
> -	netif_napi_add(eth->dummy_dev, &eth->tx_napi, mtk_napi_tx);
> -	netif_napi_add(eth->dummy_dev, &eth->rx_napi, mtk_napi_rx);
> =20
>  	platform_set_drvdata(pdev, eth);
>  	schedule_delayed_work(&eth->reset.monitor_work,
> @@ -5369,9 +5374,9 @@ static int mtk_probe(struct platform_device *pdev)
> =20
>  	return 0;
> =20
> -err_unreg_netdev:
> -	mtk_unreg_dev(eth);
>  err_deinit_ppe:
> +	if (eth->dummy_dev)
> +		free_netdev(eth->dummy_dev);
>  	mtk_ppe_deinit(eth);
>  	mtk_mdio_cleanup(eth);
>  err_free_dev:
> --=20
> 2.39.2
>=20

--++p2aDa+hzFcHMO0
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaqqaZAAKCRA6cBh0uS2t
rDyMAQCpP+MkBalzQIvvwZsIzYa9milX/OFLY1JveQYVHbupGgEA69cv9IKlnBls
bOBGM86Ecpp4C2tr6Sw1mNhmwaA8sAQ=
=fg8Q
-----END PGP SIGNATURE-----

--++p2aDa+hzFcHMO0--
