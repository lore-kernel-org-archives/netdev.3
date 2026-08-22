Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02EB53806D0
	for <netdev@vger.kernel.org>; Sat, 22 Aug 2026 21:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787434063; cv=none; b=BNc3JhGwTZTKZBAwIVIWSupzrQHy+/d8GIkzI/04o1L44fP2quHdbvzEb6xemDNRlXGMLNRxc1HhfsspoVm/LNsBaayJ3WotEQWrQzXfAEeCKgGe4yb6V7Zu+IPsncWx+gutf0pczideP8Nn72jvL0sD4sa5nWivF8JjFFAOAcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787434063; c=relaxed/simple;
	bh=KHTD1caALw6V0BqSg/W8Zp5mNmLkbtqeJba7JNF/7bY=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=k4Eh2KevMJm7WDrKNXWa/m/4xQ27n6u9SEXp4VbE6aWGGwgviSYzygLZcZmRKDsmYGrfA1uTX+bcpFd8neQnEk37Mc1GgO+Q1P69plkPX/+XTBgERvmQSb2dF/N8TzfClR/Wv7dA2Yge4W0bvr3TcfOcZe5aWmVFJ+GLmKtKzrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TbKA4v1q; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=YntqpJWI; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TbKA4v1q";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YntqpJWI"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67MKW8Oq2115811
	for <netdev@vger.kernel.org>; Sat, 22 Aug 2026 21:27:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3qTkSmgP4KdeYbIBStAHrmps5IEWYO1lVTKEUcn26ps=; b=TbKA4v1qrLNs45cD
	cerpe7+nipn12ErSTLR5sBHAoTwlc5A53meRZWDLLQU7dMqusjXyuc5K4QDVaSM0
	sYALsmAMQi6I0w9/p1VjctNS+LQ81z54pth4YPzSVjfDhv40RUEdeWYvro4nRVYv
	xz+YndDj1Vy3Uqep7/Ogw0bZHLxyS2+2jwMUzFOSavxcB2R6hRTleFdk1nfLec5b
	cowmOjYhbvR46AwfjGp/hOHynIMETqGiAbBOxjpOGiNG4ch9T2FBYnfPPzyQuJmV
	X768k3O19FWcE+fweY2UJgZxMkdAbmTNVElTHLi4L0nmwwG6LlONZCuK8LKFuRZb
	5RN24g==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g741qt4qx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Sat, 22 Aug 2026 21:27:34 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-84870e7f498so2108256b3a.3
        for <netdev@vger.kernel.org>; Sat, 22 Aug 2026 14:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787434054; x=1788038854; darn=vger.kernel.org;
        h=content-language:thread-index:content-transfer-encoding
         :content-type:mime-version:message-id:date:subject:in-reply-to
         :references:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3qTkSmgP4KdeYbIBStAHrmps5IEWYO1lVTKEUcn26ps=;
        b=YntqpJWIh2dRL3A8FfIdKMIje/7v4QYAEzeYvMgUyQjzCD9FjXD6m1H13Zsahv3xcU
         EDXUbacJPssCS5Jy0HvfTzxaOMWcvaCHfQoPJl4nqxH1u3CMmX8g/pqgsyH1MmZR1i1M
         xbW84CKz3WikGcS4oInJQUVe6V+PJxmX4qc2Rwb7bUd0E0UMwTRQA6cu8whAPquk4VMw
         Wo3zsGl4/1FZIt/hjUm/q2odM7zl6tgU2nepbgvQwFYSoWyymncux+vQoNjPWhYomURE
         oAwjAUa020c9XzQGdtJJ86b64Fvzb+bYAuX0bNWbbDz8Y4jLrMujZ7r3qmEzulM8KcuQ
         0U4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787434054; x=1788038854;
        h=content-language:thread-index:content-transfer-encoding
         :content-type:mime-version:message-id:date:subject:in-reply-to
         :references:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3qTkSmgP4KdeYbIBStAHrmps5IEWYO1lVTKEUcn26ps=;
        b=VIyZF7Xqh37EElvEYfULP+2uV8LkIpoTu7a3sin8GVy6GSlg5fWeW0OWicNPTnsQM9
         go75dIB4VxlQHEsvdP/zjxOEjknHM+EndmEW93C+gwFzcc0JJsN/dyWQIzgJp9zb8fsz
         CKkPMhHgjCHq5gFVjNx/uzGESt9p5Ajw4KP53fBSgGg9q5x/2sLv9fnMZJ0mziGFRtXR
         bVvCZB9l2QWoM5ovvQqd6svs0cBqCBO75grmTxGVZEhvM5GodCKOkbsKDPH/r5xzqYVy
         9VGmjNL8TE7LDcniPSLNwR6caIexAMXv/6eBXpwoECvq69qb1Ha0huR8O2fXiS26iMA9
         mvbw==
X-Gm-Message-State: AFuF++nmuwvcexFIVqC/AHK+2aT3WJkhHTgHbX2FaERnJSf31wptlUnS
	b60a6V62c4fQFN41cgE3cBh0TX0A4SqGSjmyP9aCUwmGzLpVO7bRM+KzeCvEr+M1ZOXM7aLi1ts
	WEBZS529PURByYWyVsvTmtKQTXCJhiVKkWJgHO0wIWVgujWSl8q5jSSyPHxI=
X-Gm-Gg: AR+sD13PNNrQECWXxVSgoVlvEsqhMpLEUkiQb5fFlAGzN8z5112gMDgy/hSySmlmVtm
	qqsOe+fso8Ay5UUr8NurupFQBpsNKfXt0yX+Fpj1D/6mKDIpmoVhxFAAJcLLyuuhd/y5OMHRMOH
	LtltV/QY5jKw56KZCuYbOrB/SaecJ+/TliOrUrP6/Nv/YJTwLw/rt80ufAz4PfsKBu3SKWVJrj9
	bf3SY9IyMy46A/nq1+D0AAHjRM3NBbznZqoxh+HK9M2xe9Cmk8ZzbJo8VhrhlJm0RuPZRzTxWmd
	XahduYvSIVzIKbkLBjZ7/Y4bluZgxq6Lyw/W9NaAlhJ1IyCGohG9UwZBtoGXY04IYcoPn/UKgfm
	phsf6op6aFD3dLgZQJyoxnjfroTKHk/qTr874PPeTNH/T2RnKuhW8oKcoON1irKXF1S/a+K1DhX
	86ylPwkqI2
X-Received: by 2002:a05:6a20:2d0b:b0:3cc:51ff:c2e7 with SMTP id adf61e73a8af0-3cd4bbdbd2emr14605882637.10.1787434053856;
        Sat, 22 Aug 2026 14:27:33 -0700 (PDT)
X-Received: by 2002:a05:6a20:2d0b:b0:3cc:51ff:c2e7 with SMTP id adf61e73a8af0-3cd4bbdbd2emr14605845637.10.1787434053415;
        Sat, 22 Aug 2026 14:27:33 -0700 (PDT)
Received: from QCOMk1gASIiYhG (66-33-8-210.colorado.intrepidfiber.us. [66.33.8.210])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-141860ef75esm10384048c88.7.2026.08.22.14.27.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 22 Aug 2026 14:27:32 -0700 (PDT)
From: <subash.a.kasiviswanathan@oss.qualcomm.com>
To: =?utf-8?Q?'J=C3=A9r=C3=A9my_Jean'?= <Jeremy.Jean@oss.cyber.gouv.fr>,
        "'Sean Tranchetti'" <sean.tranchetti@oss.qualcomm.com>
Cc: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20260821202845.4053530-2-Jeremy.Jean@oss.cyber.gouv.fr>
In-Reply-To: <20260821202845.4053530-2-Jeremy.Jean@oss.cyber.gouv.fr>
Subject: RE: [PATCH] net: qualcomm: rmnet: require real-netns admin for bridging
Date: Sat, 22 Aug 2026 15:27:32 -0600
Message-ID: <000601dd327d$0b076e00$21164a00$@oss.qualcomm.com>
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
Thread-Index: AQFsHWdoqs4K+aokN91SIeNs+ZCOHLeMvD2A
Content-Language: en-us
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIyMDE4MSBTYWx0ZWRfX3YcdobeSh6Ql
 xNl5qu9MF+05ZHJsUOBRvCVCLC1kHsw2IEb9JDa7Br0j5QHiIY35kuABIU52JS6sACzIREmejv7
 DQBr9wGOo9WdqEouyhWFBwPdkAXkp2YIxefy3V0TZlR08GAUAk8FoIXFaPXY98pxov2EDK0kz9G
 Gcmu1dBEXc2RqjG8t33FjWp6l3hwKcikGBIM7+0HQRHGEpoPlJQvztbp3q5Dzj4vEXBG7OhiW+D
 4FYtFctxC0SqTakkND0c8v5GsJ/ngAXCBQ7DJdOkF1dh/wdE7ccqUifcUIBFt07/bqVjceGAA0W
 Hu++UQuaXBtmSQH3wNw+ZsxDc0Y+XOa1zwtE37KERQdeebU6P4vS6tDrUaYggGpEAJKnfRgM+nz
 oPiHG4EOUV0evoLwRP5VHk+VL/kokMsEpZelVRsf74H3RVg6TQveWxVf9gDu4FdvvriTxstkM4R
 UTAgeF4bnSn8b5e3HwA==
X-Authority-Analysis: v=2.4 cv=GvNyPE1C c=1 sm=1 tr=0 ts=6a8a1446 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=OltkOWFNRHEXGe+8VJKHzA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=xGJ9mjwN66MZvpvwcm0A:9 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-ORIG-GUID: tvydA5yF3cLpdzvVAtA3yxGJUtB34qKC
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIyMDE4MSBTYWx0ZWRfX9uJl2TEa5M/F
 mo1UtdJyzcEqYSmDJhGevwP1aY+sWemEnIRhH0StZBrGqy0ZJ5wgM8nEQ9MRVoLnJEDukennwzI
 78ciMuSclhZlZZqb7Zz9auZ0Grs18mQ=
X-Proofpoint-GUID: tvydA5yF3cLpdzvVAtA3yxGJUtB34qKC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-22_07,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 adultscore=0 impostorscore=0 bulkscore=0 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608220181

> -----Original Message-----
> From: J=C3=A9r=C3=A9my Jean <Jeremy.Jean@oss.cyber.gouv.fr>
> Sent: Friday, August 21, 2026 2:29 PM
> To: Subash Abhinov Kasiviswanathan
> <subash.a.kasiviswanathan@oss.qualcomm.com>; Sean Tranchetti
> <sean.tranchetti@oss.qualcomm.com>
> Cc: netdev@vger.kernel.org; linux-kernel@vger.kernel.org; =
J=C3=A9r=C3=A9my Jean
> <Jeremy.Jean@oss.cyber.gouv.fr>
> Subject: [PATCH] net: qualcomm: rmnet: require real-netns admin for =
bridging
>=20
> An rmnet device remains linked to its real device after it is moved to =
a different
> network namespace. When it is used as a master, rmnet_add_bridge() =
follows
> that pointer and switches the real device's port to bridge mode.
>=20
> The rtnetlink master operation only requires CAP_NET_ADMIN in the
> namespace holding the visible rmnet and slave devices. A caller =
privileged only
> there can therefore bridge an attacker-controlled interface to the =
real device in
> another namespace, receiving and transmitting raw traffic across the
> namespace boundary.
>=20
> Require CAP_NET_ADMIN in the network namespace of the real device =
before
> configuring the bridge.
>=20
> Fixes: 60d58f971c10 ("net: qualcomm: rmnet: Implement bridge mode")
> Assisted-by: Codex:gpt-5
> Signed-off-by: J=C3=A9r=C3=A9my Jean <Jeremy.Jean@oss.cyber.gouv.fr>
> ---
>  drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>=20
> diff --git a/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c
> b/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c
> index bed6f63facf2..45e6c16a5a70 100644
> --- a/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c
> +++ b/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c
> @@ -441,6 +441,14 @@ int rmnet_add_bridge(struct net_device
> *rmnet_dev,
>  	struct rmnet_port *port, *slave_port;
>  	int err;
>=20
> +	/*
> +	 * The rtnl path only checks CAP_NET_ADMIN against
> dev_net(rmnet_dev),
> +	 * but bridge mode below controls real_dev, which may live in =
another
> +	 * netns.
> +	 */
> +	if (!rtnl_dev_link_net_capable(rmnet_dev, dev_net(real_dev)))
> +		return -EPERM;
> +
>  	port =3D rmnet_get_port_rtnl(real_dev);
>=20
>  	/* If there is more than one rmnet dev attached, its probably being

I believe the bridge tear down path might need a similar check. I've =
also added a minor update to account for the expected comment style.

diff --git a/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c =
b/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c
index bed6f63facf2..0f9734a40ed0 100644
--- a/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c
+++ b/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c
@@ -441,6 +441,13 @@ int rmnet_add_bridge(struct net_device *rmnet_dev,
        struct rmnet_port *port, *slave_port;
        int err;
=20
+       /* The rtnl path only checks CAP_NET_ADMIN against =
dev_net(rmnet_dev),
+        * but bridge mode below controls real_dev, which may live in =
another
+        * netns.
+        */
+       if (!rtnl_dev_link_net_capable(rmnet_dev, dev_net(real_dev)))
+               return -EPERM;
+
        port =3D rmnet_get_port_rtnl(real_dev);
=20
        /* If there is more than one rmnet dev attached, its probably =
being
@@ -489,7 +496,19 @@ int rmnet_add_bridge(struct net_device *rmnet_dev,
 int rmnet_del_bridge(struct net_device *rmnet_dev,
                     struct net_device *slave_dev)
 {
-       struct rmnet_port *port =3D rmnet_get_port_rtnl(slave_dev);
+       struct rmnet_priv *priv =3D netdev_priv(rmnet_dev);
+       struct net_device *real_dev =3D priv->real_dev;
+       struct rmnet_port *port;
+
+       /* Similar to rmnet_add_bridge(), the rtnl path only checks
+        * for CAP_NET_ADMIN against dev_net(slave_dev), but tearing
+        * down the bridge below updates the real_dev's port state,
+        * which may live in another netns.
+        */
+       if (!rtnl_dev_link_net_capable(rmnet_dev, dev_net(real_dev)))
+               return -EPERM;
+
+       port =3D rmnet_get_port_rtnl(slave_dev);
=20
        rmnet_unregister_bridge(port);

