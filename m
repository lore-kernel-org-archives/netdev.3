Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20109352001
	for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 15:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792078830; cv=none; b=tOwORe11kWreftDdIoRjFyNz64hqCMjAQugrcFxpQ9+v2Nd5LCWKTtGjrN2Dy+iPfKrDS7a1tUOf5DgGjeE0EhCJLfTQoAWj/9hBi0zW+dPmz9jJFq8CS1YuzWF2ag8/OuPSvlYt6E3PNayYacAZ4UkmFlckqVub2bPNiRulDzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792078830; c=relaxed/simple;
	bh=7waXuublmZajWUNbYinRB2ryKPGa7T3b3CCFNbrGd80=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jvIAg1yUcR44WjR88Sh+bkKIzpr9LnWw9tRdrTPCl7teegnMDybsidMuD8POtHuvHdwPjLrjcJd8u9zwg75to6GGRdawzzy2NlRkRlDV+3fsyCrrM4vx8hxQEOtn7Eay+beSv9bzDF7VqMPvodiB9/PuLqBoxo1++c9r4HCZpO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PODb2EZL; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=R5UrO7vc; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PODb2EZL";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="R5UrO7vc"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69FAPePC4100219
	for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 15:40:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=cqdRJU05uzH+XiuWI55mrxFR
	oovj01QpFE8EN6FfoOo=; b=PODb2EZLY4lYyT1bdPySNowRhS8dvzAZF25lYEPy
	pxO50TWHJYP0+MuIsClLDdWET/6alPQ8eBsSu8o1K344ZQzn93U8176X9su4HWYf
	6Q6/U4olyI/EDyPUpEkbHj7qNsE0JWzWhhmsYSRnGhNO8J0bAX29zRKeS81C9IgA
	kvNixOgHivAsiohznxDw62JZtKSnU+xuOV/qk+ISHzNiEIr2CzmP+ycABRZ8PQjc
	TXwjvV/aS/0VKhygZyzHywoavy3Ywui8/TYzhBGCNcskZa+hVIxbFJ8mi9W8NpJB
	8HZOldGZEe+chwzC9Ui6NwJqXcIHxYV4rR7ZNOy9ZDTIyQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4haw2r985a-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 15:40:14 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-93ae8e7e546so1158088085a.1
        for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 08:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792078813; x=1792683613; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=cqdRJU05uzH+XiuWI55mrxFRoovj01QpFE8EN6FfoOo=;
        b=R5UrO7vcf5eHZQIdjxxA4L6BjuFXaXDn5xrJxE7C32o/4JYeI8QVNUnUcePs8eUUrh
         NftHe6InZV3PN9ZTk5ldVmFrg8h7MeYShXXL3+TYQEMARAaVsJoZS951iBF0H5u7qNON
         Zh1cW3yyrLpBtSZG9IvTpuA3gxxfgoyEujaIUI36QgGbRzKDGYoOZXgo5FfMVPtzNdyu
         cQSuZhn+PpfBX/08TyN/xGphONxDylwI5eX99Oy2YiZlwhW32b533sBH3BThEKtEUZtg
         69J1X4vgnBnu130FEUD/hEy2KYvL0Rb6C4Ijhbw3/rwnV82W2yArzOBnCQK+1JbpRdkp
         mDBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792078813; x=1792683613;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cqdRJU05uzH+XiuWI55mrxFRoovj01QpFE8EN6FfoOo=;
        b=0zqSyKibWzyC3OIN7Q44/WFBEiGx51Pp8zoQrLCn/b/f5i5j8dsAJ3M9Gqd+JGIVwv
         SK1+dTek4UnmHKImAGvPta523kaDKwZcCeqIh2kB81Lex9lFBfE678gxhldSLkagFBiA
         mMO2oeympMKZ8jJlhFgFVWDuiGhwy6O0oNRQ0TOI0ICEq7MSefm7dYuF0JGQPe4WQSqB
         XMFvae33KM+EX59K+qYraxu8swlavN5i4eNqBjMJhtRq11F8Us/LInOSbNsTntdA1iEC
         BDxOP5KoR8sGuxyivHm8BH6BaLmFWomRsGhBisk/KWczbVeMjMemSN3dpBJ0J5dF4SrG
         91rA==
X-Forwarded-Encrypted: i=1; AKwUvBwlYQTIlhK12FEUkqm7c9YCSZOctuya4kw6CGmgIxVWh5Zj8EcZa2Q2bYSlL8hHxN28sXsR7Z0=@vger.kernel.org
X-Gm-Message-State: AFq9FYIFiUzvJsLpyY99NtBkRaWlpiwgxqY95IutYyqLWTOwyQxMQ0qd
	3t9J+YivdqRtVmLEPjnGlbJRG0ga+lQVEGxI+8Qg5mXyWVCh8wGKyFqYkM6rKHRgf9flPXkUJnb
	pMtdhAXqSp60NI7KyQ9KRMHewf+XzSBbbAVDiBkIT6ml+rAtF+j8HOLlnGcY=
X-Gm-Gg: AYBFou2pz4T1GduRJje5iHw8cjv29gSMzcl+52P9HX06+fHEb+WgDz60xRsFgoQ/0lk
	wdbbLHHmxLkwr0rIlE2dNpk32IApj+b8lNJliLxgkja83mcQI4Djdhiu913Bf6P/YjsOcLStPEc
	YtUlV7bIlcbtPcuGskHHdXgqPcK2L0eXDPLw8nWdASPrnYcYk57hKEMp0BGGxSnx7asioHRechw
	10/SKQka+gR51WhhMla8X78R1LhUF+sTTbRejCfcjm7kTaWDYOGOge3GND02ahIkA+czK6/YkcL
	7XkWZJsOw0BoORix4rWwHygOcrkoHCk5KMP5F1a+ZsVs8WewRZlA5E4wh8JR+0yKzE8shwhXOnX
	U1GCqJPeeyv8otA==
X-Received: by 2002:a05:620a:2996:b0:93e:fc4e:c48d with SMTP id af79cd13be357-93efc4ee847mr1283326785a.61.1792078812849;
        Thu, 15 Oct 2026 08:40:12 -0700 (PDT)
X-Received: by 2002:a05:620a:2996:b0:93e:fc4e:c48d with SMTP id af79cd13be357-93efc4ee847mr1283320285a.61.1792078812212;
        Thu, 15 Oct 2026 08:40:12 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48de72c7e36sm13446936f8f.37.2026.10.15.08.40.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 08:40:11 -0700 (PDT)
Date: Thu, 15 Oct 2026 17:40:10 +0200
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
To: Alex Elder <elder@riscstar.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
        kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, hkallweit1@gmail.com,
        linux@armlinux.org.uk, Daniel Thompson <daniel@riscstar.com>,
        ansuelsmth@gmail.com, donggeunyoo.kernel@gmail.com,
        mohd.anwar@oss.qualcomm.com, devicetree@vger.kernel.org,
        netdev@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 2/2] net: phy: qcom: qca808x: Add regulator
 management
Message-ID: <atDz2hJ6xpA3p5y7@lore-desk>
References: <20261015143849.483339-1-elder@riscstar.com>
 <20261015143849.483339-3-elder@riscstar.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="c1VMVBPiTXwjJlRy"
Content-Disposition: inline
In-Reply-To: <20261015143849.483339-3-elder@riscstar.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDA2MiBTYWx0ZWRfX7/Rbm/P1AFfj
 vYFQ3Jp0Ey6/zCKQwJ1N47r3XEY0WWeZg0ZXFkkNZ0dGmejrnlXDTku1k+jT072/qjWP2dczPoZ
 yUQA5Kb/706J2OU0ovAGZVqMRZEygMI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDA2MiBTYWx0ZWRfXyy3eUkFUkjZM
 pRhpQrYCoDo8UbwEmBlhOUr1IOTD1WOYpq7IjWD/rscXnucoOUrjbgIGZ/SJ8bLhPIYR0thNskJ
 dGde7hHY552S4tUm469wl4Kd34i5MvWNyJACmUlj5p2qMy9859jBk7C2aHtCtus0+LETQUM0+zu
 QxLJcDr4VGmu0bUihqt1fmy8nNBLEd/0YigGBxtxHP4xmUgcLfuaVlaNMkgQRu6RqFAqAYS9UsA
 6amA1MNrt1BrQqQe4w77vhfZ3jW0S3b33e+na4UMqYu1I8pOl69o7+ZuG6NugRj58jr6ngiMWmp
 aW1AYD/QziEEHQAt1qtvUzi7i7Y/ptJi82jgxBSFuSWUXRWg8t2Rtaj4rQOWXhRBzb6UWgH2FT4
 e0EKv6Bo+BiwP/8p/hwclCbvE4KU3VyRfoxxebiUROlEod7OgUMYia6/4HoVlrA/YuqCWpx/OJj
 4CMqiL/q+/npaHvQFrg==
X-Authority-Analysis: v=2.4 cv=BNMmP1QG c=1 sm=1 tr=0 ts=6ad0f3de cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=ee_2aqc6AAAA:8
 a=npIIp4u2KQ0RR9fbO6MA:9 a=CjuIK1q_8ugA:10 a=GemZ_Bmu8yNwU_l5ZkMA:9
 a=PEH46H7Ffwr30OY-TuGO:22 a=VOpmJXOdbJOWo2YY3GeN:22
X-Proofpoint-GUID: vTaHKgnSr8WiDNgYfbJ9ZgIYIG042O-8
X-Proofpoint-ORIG-GUID: vTaHKgnSr8WiDNgYfbJ9ZgIYIG042O-8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-14_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 spamscore=0 clxscore=1015 lowpriorityscore=0
 priorityscore=1501 malwarescore=0 suspectscore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610150062

--c1VMVBPiTXwjJlRy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Oct 15, Alex Elder wrote:
> From: Daniel Thompson <daniel@riscstar.com>
>=20
> QCA8081 appears in embedded board designs paired with GPIO controlled
> regulators for its power rails. Add logic to allow these regulators to
> be turned on during a probe.
>=20
> In order to avoid the complexity of tracking state for suspend with and
> without WoL we take a tremendously simple "always-on" approach to
> regulator management, essentially relying on BMCR_PDOWN to conserve
> power when the phy device exists.
>=20
> Signed-off-by: Daniel Thompson <daniel@riscstar.com>
> Co-developed-by: Alex Elder <elder@riscstar.com>
> Signed-off-by: Alex Elder <elder@riscstar.com>
> ---
>  drivers/net/phy/qcom/qca808x.c | 29 +++++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
>=20
> diff --git a/drivers/net/phy/qcom/qca808x.c b/drivers/net/phy/qcom/qca808=
x.c
> index bab26e4c61408..4aba513b9a512 100644
> --- a/drivers/net/phy/qcom/qca808x.c
> +++ b/drivers/net/phy/qcom/qca808x.c
> @@ -1,6 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0+
> =20
>  #include <linux/phy.h>
> +#include <linux/regulator/consumer.h>
>  #include <linux/module.h>
> =20
>  #include "qcom.h"
> @@ -181,15 +182,43 @@ static void qca808x_fill_possible_interfaces(struct=
 phy_device *phydev)
>  		__set_bit(PHY_INTERFACE_MODE_2500BASEX, possible);
>  }
> =20
> +static int qca808x_power_on(struct phy_device *phydev)
> +{
> +	static const char * const regulator_names[] =3D {
> +		"avdd18", "vdd", "vdd18", "vdd125"
> +	};
> +	struct device *dev =3D &phydev->mdio.dev;
> +	u32 count =3D 0;
> +	int ret;
> +
> +	for (u32 i =3D 0; i < ARRAY_SIZE(regulator_names); i++) {
> +		ret =3D devm_regulator_get_enable_optional(dev, regulator_names[i]);
> +		if (!ret)
> +			count++;
> +		else if (ret !=3D -ENODEV)
> +			return ret;
> +	}
> +
> +	if (count)
> +		fsleep(phydev->mdio.reset_assert_delay);

nit: should we check reset_assert_delay field is actually set?

Regards,
Lorenzo

> +
> +	return 0;
> +}
> +
>  static int qca808x_probe(struct phy_device *phydev)
>  {
>  	struct device *dev =3D &phydev->mdio.dev;
>  	struct qca808x_priv *priv;
> +	int ret;
> =20
>  	priv =3D devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
>  	if (!priv)
>  		return -ENOMEM;
> =20
> +	ret =3D qca808x_power_on(phydev);
> +	if (ret)
> +		return ret;
> +
>  	priv->led_polarity_mode =3D QCA808X_PHY_LED_UNSET;
> =20
>  	phydev->priv =3D priv;
> --=20
> 2.53.0
>=20

--c1VMVBPiTXwjJlRy
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCatDz2gAKCRA6cBh0uS2t
rMBrAP9e2j5pZwV3vEVm+CSoksFWsgFOQkKeWH9BCeqk59VLxQD+OrYhknLcVRGw
bj0XGtqkWwhCO/bVeB9VeozfislTtQc=
=upuH
-----END PGP SIGNATURE-----

--c1VMVBPiTXwjJlRy--
