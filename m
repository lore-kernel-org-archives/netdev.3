Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F10233C1974
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 08:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790064963; cv=none; b=NbAUNMLBEDiiAIEJ+FPeKwfxFJ7uF0gRJU+p1lz+f5kzM2oJbAnkPiQUxTOcOyymu0/MmEfk7+ZMOmUGTqOwICU6bhEC/afr+AKRvH56AyrF/8d8fHX3XfrV4qNWWXxOLXocDkBxUKtTYTszUeqZnLoFV0xaDapgNnA44EkrFEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790064963; c=relaxed/simple;
	bh=2vxbM7tPDJsSYHWzZeCi14MlUc8L6n7SqbqtOin0qVQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ejJspoNSW4YqXbcMwGm8wZCXahSo1tNmqxjVf4oowdnEZWyB4Q5cbxewE4MvprjIDmzPhGtYBOnkiIi9uj0I+aR59qiykIls4WisNLBLTr/TRbDHWqbD9cbzed3IyB7HvShtj7zrEihyXvaKLovFXpE0SIJoA5Tctv1tIT1k3Ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TPMh2/uf; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=N3ZkRPsE; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TPMh2/uf";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="N3ZkRPsE"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68M4MuSb3383563
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 08:15:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=GoG1axqiW7GSzo7JL49Rru+X
	2FH8bH4THAcHQLUbhIM=; b=TPMh2/ufSQdrKpQI7CtbbyaqenspdgjbOubvvNwH
	nipujmpyFSmceek5gA5NnO594tYTTx5p2eurAErDO+V091J7llTtp6neHQKQyLLG
	/HJ9bl4YUyfaur7FJMJ/50m4C14B0z80NzJ4+Mss9LvSyQv8X6wqTjhSbULOVhJb
	CHSngyP3pZbRj3VNesFN+Sfp1Ub10kXTRJQbiFZGhWQvMdxXrf0CBw4eMPZTHTGD
	SZAg/cO99LRurcCfhnenHVKbO0KCf62/MRLYvR0LQPgtHAy2H+CrHZ+B5ijqKJqh
	wRU2dgcy7mYhaxfBmrlkEU+hdeMfjtUPr920fZe7t2j+DQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gujkj8uxb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 08:15:56 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-93a0312937eso494505685a.1
        for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 01:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790064956; x=1790669756; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GoG1axqiW7GSzo7JL49Rru+X2FH8bH4THAcHQLUbhIM=;
        b=N3ZkRPsEesURhd4/4V1xl7sEFxszaNkGzLocAzX9UdfzMhx45UvITmwAlqflFlipA3
         yu5H8ErJQSU5tQPp+zFGIekOm4q0ajoeWGoMnnqpMlqyxM5g2xTiwFoEv7Z73D3kWRUP
         vR38axnyJi55EkZCiUlTPOjq8er3eIpoNgjGKEHy1uliI9IbRrtUC6vp19NUO31tpy3f
         ONhOI3J/2ovY61eShpnlONJBjrlHpOU35WQj1oq8brxCnIDK5Ag0YD2dOvlqyYDH72GH
         rMiKRSixT0ZgNCqLOOKSca5oyjSB88nB5+vmsenUg/QGWsAZQd6EGsGa/gNC56d+BIJT
         LjRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790064956; x=1790669756;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GoG1axqiW7GSzo7JL49Rru+X2FH8bH4THAcHQLUbhIM=;
        b=BR1WfGTLv/dEAn66QGmxZUNXZ29xMdLvuyjdsMN6xJv83bS6WLa5c0hpX/Q5YFnPF1
         sCCLjDV60wm+zJyVPyO3jc17VrDqHpVjpMRFEVYizPV04POXoKfYxL7BItXozAzYOG9K
         8g1S+6ZOa/LCzHCamVRpeEhHo0C3TReJybWWGy/j81jr0qgwzFZEPzTiCdBX/KeCoHyn
         l/MkcNZj7EPsplc6fbVYSgb7Ly2LKuDeTi6lfYNT95F7uNJjqczj5ag2JfTqJMjE4sUh
         9MQ1le1l/4cglW176vAJpqjH+B2H+64IAFh3r4wWWR4noluO1zLblY1hjxGBhfWZgHkt
         eDuw==
X-Forwarded-Encrypted: i=1; AKwUvByuzt6im/a8Z8TCU+lyhQrDZXvB1uLD5OePZpXfFfBdYxHcFJMZK5cTqT7lMWKxt+86i2Q6UyY=@vger.kernel.org
X-Gm-Message-State: AFuF++k4i09y53ALmFzBlmZbBX3PCJtY8Y73eDsHJrwLId+dg2OBmN7x
	DB8tPAbe2JhAy8BcDqxCQ4meDc5N8mLpHuFsM7NwYMou1yZAt9DjonHcJ2fHDDcbkiPjDKvwksI
	It0mdcMwcV3/4sJQ28nRcVQYI+5bJhep5O/UVLTynqJWSPOWNmxKxyuVyzMg=
X-Gm-Gg: AYBFou2FMfKpUiRaCu0iBR64c4r7d5i+g99BChUX+1vavK2+Qou64Be+a1IyDH/4GnL
	O4GaCn7DVObmFVnzE6ja3iQ6phblog+Vpd2jfZf98CLsiS6gR3Ek7OaaPKlVhTbwINcaZlP2kXO
	taj9r0iMDZ4NtSZYvrzOjrYy0JVONRtFmrbRhLeQSX44T3EvxuiuSdrSp9Wa68s6kYB3nQzTpf0
	OIAJxY75+4rWONA5Ixt12mP20KHxH+AHYm07CVv7Ts3VUxKCgykEOv2K3qlFHQxZbHwn+nKYJ6C
	DuMG/2TKtA/SSX2+XrNkxO0lERuXb8MX0mWYkb2tJ8H93FOYUtG6aieIlNDmTXvVlckNFpx6wIO
	mzGwEv3z3Q4tEJw==
X-Received: by 2002:a05:620a:838d:b0:93b:d7a2:dd39 with SMTP id af79cd13be357-93c15ed080cmr404178085a.73.1790064955550;
        Tue, 22 Sep 2026 01:15:55 -0700 (PDT)
X-Received: by 2002:a05:620a:838d:b0:93b:d7a2:dd39 with SMTP id af79cd13be357-93c15ed080cmr404175985a.73.1790064955001;
        Tue, 22 Sep 2026 01:15:55 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2a9c5e7850sm45992066b.42.2026.09.22.01.15.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 01:15:53 -0700 (PDT)
Date: Tue, 22 Sep 2026 10:15:52 +0200
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
To: Myeonghun Pak <mhun512@gmail.com>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Ijae Kim <ae878000@gmail.com>
Subject: Re: [PATCH net] net: airoha: npu: cancel wdt_work after releasing
 the WDT IRQ
Message-ID: <arI5OD8X2Eoz_Ojd@lore-desk>
References: <20260922000914.542068-1-mhun512@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="T9inMwS7qgqrO+Sd"
Content-Disposition: inline
In-Reply-To: <20260922000914.542068-1-mhun512@gmail.com>
X-Proofpoint-GUID: gwi7_8gGGYvINEJq5k61y93j4zWVx0bA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIyMDExOCBTYWx0ZWRfX2mIZAOFFEaaO
 2kCnmhWhPdciFD+HUt1D+G3rgx4j3CWQZCaNtvwHjqXahQruvgk/FAGlefF4WUc5Tx+Sucq2lM0
 cvHiqUH+X5yz6hayrLQ6zHGfHCf7i/X58m2hx6NRgy0DrfAadrIJRC/ekzdXqNmpgfbv78yDcKG
 2LZfp+nSFGnxHMAVrmFxL1JFW8EdS6MyDz8qw9+a19P0lKkavwDr2Tjsj3CSJbr9Y4r7uL3Q4KO
 it5iBGe+4KMqGE947ycBY1ShWl2FxCUPh6hxBT7ZQJObFG5h3dhAMVGdEUo/UYQShkYDPICmG0M
 One3R4ggAQU2uiVRMDDVPGqab4WPvqKb3hpvD73IHZj5VMj5wD8uLzXIzej3Q20TyERQKahOwPw
 vTxuHUosKDVXh89O37BMD/ZAmpGuRATCt/Q0tacSdKGrqvZnA2WB9Ig6bSvBjUKozJZxPyKCa3Y
 U5CAUVOcgZxKLJgOFkA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIyMDExOCBTYWx0ZWRfXzLRjrWHg1SUa
 YFsTUHtKk2vckqamMv9bxIsXJm9SIum1MRIsHBoqmV9nplIyG/ygErWdA1+bwoHX5XqAzwTjhne
 jwtSBsa3i4rhUeOHIXInV3zL5hL5AxM=
X-Authority-Analysis: v=2.4 cv=SuAFe/O0 c=1 sm=1 tr=0 ts=6ab2393c cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=VwQbUJbxAAAA:8
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=4MF4sh17vRPpCNt1FVoA:9 a=CjuIK1q_8ugA:10
 a=TFMy8jt120Iq-BnFKmgA:9 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-ORIG-GUID: gwi7_8gGGYvINEJq5k61y93j4zWVx0bA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_07,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 suspectscore=0 spamscore=0 phishscore=0
 malwarescore=0 priorityscore=1501 adultscore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609220118

--T9inMwS7qgqrO+Sd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> airoha_npu_remove() calls cancel_work_sync() on each core's wdt_work,
> but the watchdog IRQ that queues it is requested with devm_request_irq()
> and is freed only after .remove() returns.  airoha_npu_wdt_handler() can
> therefore schedule_work() again once the cancel has returned.  struct
> airoha_npu, which contains the work, is devm_kzalloc()'d and is freed in
> that same unwind, so the late work dereferences freed memory.
>=20
> Register the work with devm_work_autocancel() before devm_request_irq()
> and drop .remove().  Devres runs in reverse order, so the IRQ is freed
> before cancel_work_sync(), including when probe fails.  A cancel left in
> .remove() cannot get that order.  Initializing the work first also stops
> a pending watchdog interrupt from queuing an uninitialized work item.
> Probe currently calls INIT_WORK() only after devm_request_irq().
>=20
> This issue was identified during our ongoing static-analysis research
> while reviewing kernel code.
>=20
> Fixes: 23290c7bc190 ("net: airoha: Introduce Airoha NPU support")
> Cc: stable@vger.kernel.org # 6.15+
> Assisted-by: LLM
> Co-developed-by: Ijae Kim <ae878000@gmail.com>
> Signed-off-by: Ijae Kim <ae878000@gmail.com>
> Signed-off-by: Myeonghun Pak <mhun512@gmail.com>

I guess this is net-next material, it is just an optimization, not a real f=
ix.
Anyway:

Acked-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>

> ---
>  drivers/net/ethernet/airoha/airoha_npu.c | 18 ++++++------------
>  1 file changed, 6 insertions(+), 12 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/airoha/airoha_npu.c b/drivers/net/ether=
net/airoha/airoha_npu.c
> index 5bb4817a898d..4d3195eb00f7 100644
> --- a/drivers/net/ethernet/airoha/airoha_npu.c
> +++ b/drivers/net/ethernet/airoha/airoha_npu.c
> @@ -5,6 +5,7 @@
>   */
> =20
>  #include <linux/devcoredump.h>
> +#include <linux/devm-helpers.h>
>  #include <linux/firmware.h>
>  #include <linux/platform_device.h>
>  #include <linux/of_net.h>
> @@ -751,12 +752,15 @@ static int airoha_npu_probe(struct platform_device =
*pdev)
>  		if (irq < 0)
>  			return irq;
> =20
> +		err =3D devm_work_autocancel(dev, &core->wdt_work,
> +					   airoha_npu_wdt_work);
> +		if (err)
> +			return err;
> +
>  		err =3D devm_request_irq(dev, irq, airoha_npu_wdt_handler,
>  				       IRQF_SHARED, "airoha-npu-wdt", core);
>  		if (err)
>  			return err;
> -
> -		INIT_WORK(&core->wdt_work, airoha_npu_wdt_work);
>  	}
> =20
>  	/* wlan IRQ lines */
> @@ -803,18 +807,8 @@ static int airoha_npu_probe(struct platform_device *=
pdev)
>  	return 0;
>  }
> =20
> -static void airoha_npu_remove(struct platform_device *pdev)
> -{
> -	struct airoha_npu *npu =3D platform_get_drvdata(pdev);
> -	int i;
> -
> -	for (i =3D 0; i < ARRAY_SIZE(npu->cores); i++)
> -		cancel_work_sync(&npu->cores[i].wdt_work);
> -}
> -
>  static struct platform_driver airoha_npu_driver =3D {
>  	.probe =3D airoha_npu_probe,
> -	.remove =3D airoha_npu_remove,
>  	.driver =3D {
>  		.name =3D "airoha-npu",
>  		.of_match_table =3D of_airoha_npu_match,
>=20
> base-commit: 238650ef6c7c7cca08e032527329424c9fbd70e5
> --=20
> 2.53.0
>=20

--T9inMwS7qgqrO+Sd
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCarI5OAAKCRA6cBh0uS2t
rI4fAP98jcpyP9Tldx0CU7Z1EVA2UQeRcOvya5TXQ8iPwJToBwD/c4p6RNL7m3/J
s/bHKE3R7bhNQpjQhHDpmb8HLe2IXAQ=
=zZw8
-----END PGP SIGNATURE-----

--T9inMwS7qgqrO+Sd--
