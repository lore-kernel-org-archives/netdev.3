Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E667231839
	for <netdev@vger.kernel.org>; Mon,  5 Oct 2026 05:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791179214; cv=none; b=pzfjC0b1FGDIkla6lZI3cbcYzVuIXT+W7Ztislle9246wL/zsO5BVPeScyOsGlgQKFpQn0eR8VayywN6m1Av8SvcskYeefuE20e2huCTAjlrlBrfiIw20YM8LFD4sRGzgjzuMhw56pf7Oyr6BwwMSVhoiF5sWJXDtjM9NnbKbjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791179214; c=relaxed/simple;
	bh=iODhbM8nj9frQ077TmvTm5XGAMOmcJO3Ic6B9mRTG1A=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=LF0yVwm3zrnLSU8M20WxYlmyEiFE6ng35wPsqiZE/XskYg/JK25D2oyxdqBGH0qBnTtS7zXTo9IYObG/1q/vPMWNmz4z9feTTs+/f8I0fHbE2E8qLGqdbsA5tgc8rd1iFQJF96F66ZSrmwoaHYuJ/uJl2I/S6bvx/YoGsSGMWbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MmpHgHq6; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Tt0IIPUg; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MmpHgHq6";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Tt0IIPUg"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 695118if4062533
	for <netdev@vger.kernel.org>; Mon, 5 Oct 2026 05:46:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	IQkqDDZQn6LUNMvxtUceN59vYwoJfsLnxi8dfPO0+Nk=; b=MmpHgHq6SjX0u5cN
	0lyvl77wylPw2mgEvMkfoXzrkgXGX0qphBGP4C7cKES7DYsVsR9e1QiAWYDeeHT1
	uWl+uoWIJ3loSEjndBb09rvaJiqgrChEGTjoSDQoaIqO0nj8ROVsQb1niB+zGKW8
	ZPC6aXZHjmJencwAYOoQujPycZLNmlAwDY0UWqky/68fKQmTH12fcur4HnVwDwN8
	2pqWn2kSrJbju04x5ScviXdyPjdsLuRLEvGE6dxWqqikt2YT8gGX0uxszvgbGweb
	ucxJrc20oOxsKMbT7zFSCBORzLJC//q9WOg4QAYcNUF9fz9IfBHS2TuQN+EBO05F
	DquaMQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h41gn8jpm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 05 Oct 2026 05:46:51 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2cec4226c70so11923645ad.1
        for <netdev@vger.kernel.org>; Sun, 04 Oct 2026 22:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791179210; x=1791784010; darn=vger.kernel.org;
        h=content-language:thread-index:content-transfer-encoding
         :content-type:mime-version:message-id:date:subject:in-reply-to
         :references:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IQkqDDZQn6LUNMvxtUceN59vYwoJfsLnxi8dfPO0+Nk=;
        b=Tt0IIPUgGihrBopOINxDRWHmNULKooAaMHGK5lXNMNz+61J64AN5W+6OJ5nLP+kTI+
         UYlatqMdfE8ytd+WR630LDBz0W8EAt/ZCrl+ceLfzjnYA7RjhZ1vaGnC3mpDaaorvwhl
         qspZuoP6YuybZ5PYMvuauztaXwTzJiebzJ8X6OI09CIxf/pZNPGm5sSM6gzAZP7UFHqL
         pT+IxSEtfFPmP79MWBL1X6W35T1HYFGy9JDM7CQBRjkD7O9XVU6E5WbMaWxbAL0X6zzX
         ZJ8HRhp7/rIkoK4o5e8jcW4xPMAtw4XokNwFor9aMa6UJshXSApNznI8pKyxOZ06snZc
         ykyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791179210; x=1791784010;
        h=content-language:thread-index:content-transfer-encoding
         :content-type:mime-version:message-id:date:subject:in-reply-to
         :references:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=IQkqDDZQn6LUNMvxtUceN59vYwoJfsLnxi8dfPO0+Nk=;
        b=Q1ZllPqb7tBZ+GgeOBGGskgEghf63GfVbVfdkHxDjRFPggHizWwN0HgmcB2cKdWjNO
         JTjnvyM5soV5AK4hAWQply4IbVCZ5j7bm/toiDfbh0swk9p6doCgoTjG8S6422at0xeZ
         Oasmz00OcoIk4PS7e6X8US+N6a43b/H9KgSoQLfg9BZLKIDVdFZx64he49ayUiLCpO63
         kq6crWLef31JU8IL+AhgwNY0FVUH0nqs25p0so0DbsrmUwTYHgB4pMAZ+cWX098YJx1I
         zIulIrdAtTn3rsTKz+3qidBrZfodQ5QKKkGIxn5+BC1CIdPMrLEfGTVAmhitPG58+wAF
         WpcQ==
X-Gm-Message-State: AFq9FYIXvJKHNUYvf9TCxJwzNLHdH4+zVC6b65thRCDiN0HFJ0LS10WQ
	3P4s3BEuH47oVbLi+pNbTOa4wv+aFTFbP3fg45syZOP4ynJ81z6HwZCvOgUyxjN3o7whNEARGX6
	JNDx369+Pr3xKHE4XN1q5CFglh/pu5/ANVOWVMg0/lLRwi61PFHB3MQ5Xj6k=
X-Gm-Gg: AYBFou0qnhSOMVXTOHs2IgKnTPor+KHOaXKtSXawSHadAChSiMLvKRKcYlvO70N/acj
	ksdf/newP8QTB03WUyQIvolrf+wHLdl9/L/1gX3PuLZN89stmHXsHvo2k2zdG9wVCod9DjNAFoO
	JXOC+GYuHnia5imSYjf7/4b2romEB64AqgNMs7rAu/gr/idmEvqPJjXxn8qm9K1dKhuUR0GKscG
	7BT891jj+utere3yDYr8Gl2RndISTpbjcj8I0jXICr4p6jA08wdC20N5GHkBhVwnXCeKcsoTU4g
	MuwnIM/fcVVKJP1/yw/7Uj3AZPStNBsKCOntsYmXPNacqGjSS7RIZj8arHkhrIs9WzDi85ItU5W
	U8rQVP2GpSZg9oa2HnoFLVSNSJAK/NZRwAuLUc7IKVxPX4+CSbtf+0o7LTYiWAVNYYvUKOr4MQR
	6Tm79KlSPZ
X-Received: by 2002:a17:90a:dfc5:b0:3a0:e243:28fc with SMTP id 98e67ed59e1d1-3a6ce7c58f3mr3422943a91.35.1791179210525;
        Sun, 04 Oct 2026 22:46:50 -0700 (PDT)
X-Received: by 2002:a17:90a:dfc5:b0:3a0:e243:28fc with SMTP id 98e67ed59e1d1-3a6ce7c58f3mr3422939a91.35.1791179210018;
        Sun, 04 Oct 2026 22:46:50 -0700 (PDT)
Received: from QCOMk1gASIiYhG (66-33-8-210.colorado.intrepidfiber.us. [66.33.8.210])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a78daef465sm10022451a91.1.2026.10.04.22.46.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 04 Oct 2026 22:46:49 -0700 (PDT)
From: <subash.a.kasiviswanathan@oss.qualcomm.com>
To: =?utf-8?Q?'J=C3=A9r=C3=A9my_Jean'?= <Jeremy.Jean@oss.cyber.gouv.fr>,
        "'Sean Tranchetti'" <sean.tranchetti@oss.qualcomm.com>
Cc: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <stable@vger.kernel.org>
References: <20261004203149.3042491-2-Jeremy.Jean@oss.cyber.gouv.fr>
In-Reply-To: <20261004203149.3042491-2-Jeremy.Jean@oss.cyber.gouv.fr>
Subject: RE: [PATCH net v2] net: qualcomm: rmnet: require real-netns admin for bridging
Date: Sun, 4 Oct 2026 23:46:47 -0600
Message-ID: <000a01dd548c$ea3417a0$be9c46e0$@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQGOEhXtUTbF+SS34JnqmCUEU5IcWLeM9VDA
Content-Language: en-us
X-Proofpoint-ORIG-GUID: 7ankc_o1d6zOsjpko0_3dmfyylR6yNIn
X-Proofpoint-GUID: 7ankc_o1d6zOsjpko0_3dmfyylR6yNIn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA1MDAyMiBTYWx0ZWRfX4cYJkIpSpFEI
 /0+xaQ3XlfkkQFHWFMfAA44nmXU2wGw6IemJYcX+6RW3mvtDzyWUOynKouhds652vD52Nn482hC
 8nJ84/FPzHt9racei0f+4NvPEsb5MtDPYkPy/A1WLgduD2dO/W2OYY2AL/zHIV2B0XnF8CaewWJ
 PptpC87eDQt67WD/lgQpULjp2csaT8asY9yDUjMQ2F11IHfY+hYx9QFV9HLpJTSCLLiLHu2etfx
 lDyqs1N1to7a0GzfaleT0TAXVFwRaloXaA1TPQhO60mWrmowL+zafbZRLh38snGxo0Up+1aLX4I
 +hnsz0gxM2dP8HptC9r1lxSNdXgovvxOOwoawnLvnPom9VGWR8PJl4YaLVEtLaCgtgdkl37BzyR
 +H6+JhhqdHMnb3WD9FhxqWE1yFDpdbJRJMOzNNUHuGyU+OGJyMMZltTR8wq120LdFmVynQwxDpZ
 RTgpNazg8FVBt4hxS5Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA1MDAyMiBTYWx0ZWRfX4pV7V/loUKgD
 X4KkVuu5fSNe3oOvASthOVZ7pqXCPpRJRO1iS361SKnyo/OQzCdAecxe3E518Ku51MIG66ycKvh
 Hy0YZJXKf4qEqEI81JxH1NUPYlE8ZMA=
X-Authority-Analysis: v=2.4 cv=P9WvFSAu c=1 sm=1 tr=0 ts=6ac339cb cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=OltkOWFNRHEXGe+8VJKHzA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=AD6CraKjvDkRJrihdKEA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-05_01,2026-10-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 clxscore=1015 spamscore=0 priorityscore=1501
 lowpriorityscore=0 adultscore=0 suspectscore=0 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610050022

> -----Original Message-----
> From: J=C3=A9r=C3=A9my Jean <Jeremy.Jean@oss.cyber.gouv.fr>
> Sent: Sunday, October 4, 2026 2:32 PM
> To: Subash Abhinov Kasiviswanathan
> <subash.a.kasiviswanathan@oss.qualcomm.com>; Sean Tranchetti
> <sean.tranchetti@oss.qualcomm.com>
> Cc: netdev@vger.kernel.org; linux-kernel@vger.kernel.org; =
J=C3=A9r=C3=A9my Jean
> <Jeremy.Jean@oss.cyber.gouv.fr>; stable@vger.kernel.org
> Subject: [PATCH net v2] net: qualcomm: rmnet: require real-netns admin =
for
> bridging
>=20
> An rmnet device keeps its link to the real device when moved to =
another
> network namespace. The bridge callbacks change the real port, but =
rtnetlink
> only checks CAP_NET_ADMIN in the slave device's namespace.
>=20
> Require CAP_NET_ADMIN in the real device's namespace before adding or
> removing a bridge. Use the slave device's namespace for the =
comparison, since
> that is the namespace rtnetlink authorized.
>=20
> Fixes: 60d58f971c10 ("net: qualcomm: rmnet: Implement bridge mode")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: J=C3=A9r=C3=A9my Jean <Jeremy.Jean@oss.cyber.gouv.fr>
> ---
>=20
> Changes in v2, after Subash Abhinov's review:
> - Add the teardown check and use slave_dev for both capability checks.
>=20
> v1: https://lore.kernel.org/all/20260821202845.4053530-2-
> Jeremy.Jean@oss.cyber.gouv.fr/
>=20
>  .../ethernet/qualcomm/rmnet/rmnet_config.c    | 20
> ++++++++++++++++++-
>  1 file changed, 19 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c
> b/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c
> index bed6f63facf2..62d7acb13e0c 100644
> --- a/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c
> +++ b/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c
> @@ -441,6 +441,13 @@ int rmnet_add_bridge(struct net_device
> *rmnet_dev,
>  	struct rmnet_port *port, *slave_port;
>  	int err;
>=20
> +	/* The rtnl path only checks CAP_NET_ADMIN against
> dev_net(slave_dev),
> +	 * but bridge mode below controls real_dev, which may live in =
another
> +	 * netns.
> +	 */
> +	if (!rtnl_dev_link_net_capable(slave_dev, dev_net(real_dev)))
> +		return -EPERM;
> +
>  	port =3D rmnet_get_port_rtnl(real_dev);
>=20
>  	/* If there is more than one rmnet dev attached, its probably being
> @@ -489,7 +496,18 @@ int rmnet_add_bridge(struct net_device
> *rmnet_dev,  int rmnet_del_bridge(struct net_device *rmnet_dev,
>  		     struct net_device *slave_dev)
>  {
> -	struct rmnet_port *port =3D rmnet_get_port_rtnl(slave_dev);
> +	struct rmnet_priv *priv =3D netdev_priv(rmnet_dev);
> +	struct net_device *real_dev =3D priv->real_dev;
> +	struct rmnet_port *port;
> +
> +	/* The rtnl path only checks CAP_NET_ADMIN against
> dev_net(slave_dev),
> +	 * but bridge teardown also updates real_dev, which may live in
> another
> +	 * netns.
> +	 */
> +	if (!rtnl_dev_link_net_capable(slave_dev, dev_net(real_dev)))
> +		return -EPERM;
> +
> +	port =3D rmnet_get_port_rtnl(slave_dev);
>=20
>  	rmnet_unregister_bridge(port);
>=20

A similar patch was committed recently in net-next. Please refer to =
https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/commi=
t/?id=3D26ee8cd69d46a14b37ba5e512084fe80d730127a

