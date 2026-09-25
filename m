Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7599E48BD46
	for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 10:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790331507; cv=none; b=KnvfiqHD28otiyM/YZCI+jrd/++HXWgzk0M3J2vo6PmLZgQx40o/oTN42M2y0kMnwxnH3L/w1r1jeEggWUC0T4u3/mzCixz+yPs6CxivPTx96L+nTH6sZqlEjphLeOlsn+Qz5rq0HjB/5lefgAo+FgZsp6mBGv0tNDMjdmXleX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790331507; c=relaxed/simple;
	bh=P+ZvzAbH408uTQVCwc/h6NORlD2/5QClPjEDYo4N9/A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=da10mNDV5CYWO3U8CK/WakTuDfgzcLSE52KDk66dpsqwQ3+/tH/pW2ciYYf1E1qOuU82vAefCiZlKpcFnhO7hC86aVMDdvWEfYm3jFEeQxNriQERubZANv/zQsNcPUe+PxXi+gUmA2YjQXKuEls2Qsdod9/BEgGxFR6Hda0/ST0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QP7QfJOD; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LilzrfCR; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QP7QfJOD";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LilzrfCR"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68P5JFJC757087
	for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 10:18:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=WX1zivK0KSD/gWgo1/AwVsWk
	fLoq+U/soHtU47sdNPs=; b=QP7QfJODydv+3Qh1M/eJR4PAhRRAN9jIVADfmb4w
	OQgRudD7Gz1c/1TFLct8axFYVFanCr2dTvdmFZ16B+P9v3ri+cE7TmZFL+KRdGX6
	z/zj3W9VzXRlmhXjZ0AvncdqwEfdE6C2XJdn9HwAi8msy5jWbzkaPISeEpH696EP
	BJqQCYTMTi51IkNaK9dsKlQfV5Czm73QBYtrvjwyc/up1coCANlIdwFFu+iN68+O
	4DKkxmsjdlAC1XrWhHCNW15lmtFJ/UJFXf5lTGKmYOukemfvr36jpmmJHWhp9Ts2
	pOeh3LJRnJ77+BTdJznqkfoT+ASf2brYCaajbszKZoX4VA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gwjq08wby-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 10:18:25 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93a1de6d5c3so167393985a.3
        for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 03:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790331504; x=1790936304; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WX1zivK0KSD/gWgo1/AwVsWkfLoq+U/soHtU47sdNPs=;
        b=LilzrfCRKOvcCqfURALH3AlFZdqKSn3wycB1uqmV6aBLETUFXfrh1XAq2Mhh07BXuA
         eEKbQcKrwvsGEg4MDK5jzallnUnuZ09Gi9B3aOFLJJik2w38ct+9heEr4nLnZShDfZ3R
         jq8WgPtvglXnfnzO0sgT39i79mxnYU68xiOFFYPdLHcrS59bVYoW2ebhz3uCl4rxiiT6
         d+Bk1ERlr6fEKs/Jecxfgy9KvFk0pQRnkf5E7ROQTQImWmojPmlCRpoaWGM47Hm7ivpL
         VQeb7iX6aNZy4BHxrVyUtKs1MBomB7hb4Y+0pKuXeqGb//mdaw3Xwfbrs/wa4WepamOn
         1dgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790331504; x=1790936304;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WX1zivK0KSD/gWgo1/AwVsWkfLoq+U/soHtU47sdNPs=;
        b=tZONhrDYG7/QBYzdPMYL/W6KUbbAVu8kTjYAa+VOWVRr8gqsmUoloOh0juF3HgSYFZ
         969SKacOKnjkG2A8gsx9y3lfhP8exc2aztDwkj8ge8HLDPzy8bHJMVJ7SUgBIEj5NMkr
         HcklB9Km1tmUkPgW7XDUTrqz6ZQlvkJEoL8f7tpMMzRa/rtl5lCqvd3/UgKEGOxqmilR
         vMOvknuHfbV/Lt9CkgGIdH/2X98GxRVWfXf1YI82oULvY2dn4vAvU9AuPMMc1mWc4Gtt
         Xdc5Y+g7CGC+KJLJZridYRnEGxhFhs6e9YATQzDlZqoQMw7d6rsFWpBvmyCNPNqQ4yRG
         oPKA==
X-Forwarded-Encrypted: i=1; AKwUvBzXFqnfRfMqp3SAnslUp80645O1ONJNMeYU1z2+WAPcOQ8w6CNUGo3RIDN8u+6lQudkfWaCasE=@vger.kernel.org
X-Gm-Message-State: AFuF++n5jymfI2tMhJfELpeJgqR/ZcBl5V0xVEzLQ4e8uwcNz7yQJyXU
	HsQNwmajZOD+q9WPUw70aYKnouKkrs4O6PuMsuTi0zF4DpdwW2ud3/hPI5mv0MQUlNXCj9DeXdj
	4qPjw2oZAhIbvZep6frWxbgylCb9NuSPVF2GuDFkPZKiGy0VRo8o+ZuBglrw=
X-Gm-Gg: AYBFou2a7Z+7WRFAxHKRP5BrUhpEu65cRq6hzXFOSNTJTm+CKmHFCnPLO76I5t/yQ3u
	V35EWV6xO3kGAvgJz9pChgcrIdkw1tCPqrit/JZ1wBcKrMkPDSfRGN/X+MoFV3ydJHcEgEsNMcN
	cK8n65ptfeVJgwI68kA7oRU0Iu4zWApqYPE9fZQxPSDLs+ET2BjqP3Wi7OyhvPHnq+zTUru03nF
	GR4VneWeRMnklBz+5hkpHScOy9OYSwyg7ob+reM8q0QMB5rme/+ytzxRpMsCgYauCrfOxNZScWP
	wWj4G5lp68QIII9O7IHY5I8GxMv0ybV5imQacUFzKcR39mq4B6rfRlCpG64WZquZbVXkjs68AfF
	Z8iCoXIzWzhn1bw==
X-Received: by 2002:a05:620a:3185:b0:93b:ce00:72f4 with SMTP id af79cd13be357-93c43cc5681mr337033885a.11.1790331504514;
        Fri, 25 Sep 2026 03:18:24 -0700 (PDT)
X-Received: by 2002:a05:620a:3185:b0:93b:ce00:72f4 with SMTP id af79cd13be357-93c43cc5681mr337026385a.11.1790331503673;
        Fri, 25 Sep 2026 03:18:23 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49ff06b6108sm58203965e9.8.2026.09.25.03.18.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 03:18:22 -0700 (PDT)
Date: Fri, 25 Sep 2026 12:18:21 +0200
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
To: Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Serge Semin <fancer.lancer@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Richard Cochran <richardcochran@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        Shawn Guo <shengchao.guo@oss.qualcomm.com>,
        Zhangfei Gao <zhangfei.gao@oss.qualcomm.com>,
        Jitendra Vegiraju <jitendra.vegiraju@broadcom.com>
Subject: Re: [PATCH RFC net-next 3/9] net: pcs: xpcs: add custom platform
 register accessors
Message-ID: <arZKbbCcUG5FgQWi@lore-desk>
References: <20260923-qcom_xpcs_nord_emac-v1-0-4b1c682af70f@oss.qualcomm.com>
 <20260923-qcom_xpcs_nord_emac-v1-3-4b1c682af70f@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="+RQ9w07xn/7cmLLc"
Content-Disposition: inline
In-Reply-To: <20260923-qcom_xpcs_nord_emac-v1-3-4b1c682af70f@oss.qualcomm.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDA0MCBTYWx0ZWRfX4v4NwPS6ibGz
 +Y7VWe653q85I2eIJIarL/V9FYXt9+HHqahc9N/GPOvvPzeCc0E+FGX2vHUMoutgH5XL7yFZdCh
 gMogxeJRjnXrgyVASA1Qv2HDfdg7fCw=
X-Proofpoint-GUID: ITkOa_cN1WZ3Jq2xx978JlwZEBYtILmo
X-Proofpoint-ORIG-GUID: ITkOa_cN1WZ3Jq2xx978JlwZEBYtILmo
X-Authority-Analysis: v=2.4 cv=LNPz05W9 c=1 sm=1 tr=0 ts=6ab64a71 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=cNto7lqNzDuyVZoFmAcA:9 a=+jEqtf1s3R9VXZ0wqowq2kgwd+I=:19 a=CjuIK1q_8ugA:10
 a=TGcz8d0ICyKSqoSmTxMA:9 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDA0MCBTYWx0ZWRfX2BkxeyOcbyS/
 /yZYDU/+s9g4SMf8hW5BkPqmOVNaE7mw7C2LW+UFh+9/vTy7VgWB/Ls1PRknghznukUb3oWlCkh
 N581gRqLXGt+AQVINZ2mfwqb6AZ0F/2Nt3S1HQV/mpypurIkcLIajMm0e7PV793wxKboiwuynWb
 cU31QEUpc8Dg9rCgwEYht9wf0/k80cgRAXVOukBTIIfosCL+QuOdSBuRGozfhYMdZF9hJ0nSUbD
 +HKsl9YNSvgpUyje8WE4xSfcAgU9XUJalWgbUkv8FqCxfr562xwN/DUZMiCKNaIMTJ3qWzdVnHL
 I9+RXRK+KiL20q9QZNC7jNq85mBumOWr0UAq4dGc6EGvOakNK6elLrNT8agzRmLCSPqWVuZBImQ
 ZK0CW6zzqZYqLbEL83ziCLDo7KYy+OHayZKeOVaik297mtYF7B41OBvaM1auzpbogoedUHE6UWH
 yyvUD8zZhLOXgJawGfw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 suspectscore=0 impostorscore=0 malwarescore=0
 adultscore=0 priorityscore=1501 clxscore=1015 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609250040

--+RQ9w07xn/7cmLLc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Some XPCS integrations do not expose the standard direct or indirect
> register layout. Allow the platform driver to use optional register read
> and write callbacks for both Clause 22 and Clause 45 accesses, while
> retaining the existing access paths when no callbacks are supplied.
>=20
> Signed-off-by: Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>
> ---
>  drivers/net/pcs/pcs-xpcs-plat.c | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>=20
> diff --git a/drivers/net/pcs/pcs-xpcs-plat.c b/drivers/net/pcs/pcs-xpcs-p=
lat.c
> index e669a7b248ac4677aeb5cd1874108f5c87f837d2..e78a233fb198d940951064a71=
e8597c6c666bc9d 100644
> --- a/drivers/net/pcs/pcs-xpcs-plat.c
> +++ b/drivers/net/pcs/pcs-xpcs-plat.c
> @@ -24,8 +24,16 @@
>  /* Page select register for the indirect MMIO CSRs access */
>  #define DW_VR_CSR_VIEWPORT		0xff
> =20
> +struct dw_xpcs_plat_ops {
> +	int (*reg_read)(struct platform_device *pdev, void __iomem *reg_base,
> +			int dev, int reg);
> +	int (*reg_write)(struct platform_device *pdev, void __iomem *reg_base,
> +			 int dev, int reg, u16 val);

I guess here we can use the same signature used in
xpcs_mmio_read_reg_{direct,indirect}()/xpcs_mmio_write_reg_{direct,indirect=
}().
Doing so we can probably have a generic platform ops the driver can set dur=
ing
probe. What do you think?

Regards,
Lorenzo

> +};
> +
>  struct dw_xpcs_plat {
>  	struct platform_device *pdev;
> +	const struct dw_xpcs_plat_ops *ops;
>  	struct mii_bus *bus;
>  	bool reg_indir;
>  	int reg_width;
> @@ -169,6 +177,10 @@ static int xpcs_mmio_read_c22(struct mii_bus *bus, i=
nt addr, int reg)
>  	if (addr !=3D 0)
>  		return -ENODEV;
> =20
> +	if (pxpcs->ops)
> +		return pxpcs->ops->reg_read(pxpcs->pdev, pxpcs->reg_base,
> +					    MDIO_MMD_VEND2, reg);
> +
>  	if (pxpcs->reg_indir)
>  		return xpcs_mmio_read_reg_indirect(pxpcs, MDIO_MMD_VEND2, reg);
>  	else
> @@ -182,6 +194,10 @@ static int xpcs_mmio_write_c22(struct mii_bus *bus, =
int addr, int reg, u16 val)
>  	if (addr !=3D 0)
>  		return -ENODEV;
> =20
> +	if (pxpcs->ops)
> +		return pxpcs->ops->reg_write(pxpcs->pdev, pxpcs->reg_base,
> +					     MDIO_MMD_VEND2, reg, val);
> +
>  	if (pxpcs->reg_indir)
>  		return xpcs_mmio_write_reg_indirect(pxpcs, MDIO_MMD_VEND2, reg, val);
>  	else
> @@ -195,6 +211,10 @@ static int xpcs_mmio_read_c45(struct mii_bus *bus, i=
nt addr, int dev, int reg)
>  	if (addr !=3D 0)
>  		return -ENODEV;
> =20
> +	if (pxpcs->ops)
> +		return pxpcs->ops->reg_read(pxpcs->pdev, pxpcs->reg_base,
> +					    dev, reg);
> +
>  	if (pxpcs->reg_indir)
>  		return xpcs_mmio_read_reg_indirect(pxpcs, dev, reg);
>  	else
> @@ -209,6 +229,10 @@ static int xpcs_mmio_write_c45(struct mii_bus *bus, =
int addr, int dev,
>  	if (addr !=3D 0)
>  		return -ENODEV;
> =20
> +	if (pxpcs->ops)
> +		return pxpcs->ops->reg_write(pxpcs->pdev, pxpcs->reg_base,
> +					     dev, reg, val);
> +
>  	if (pxpcs->reg_indir)
>  		return xpcs_mmio_write_reg_indirect(pxpcs, dev, reg, val);
>  	else
>=20
> --=20
> 2.34.1
>=20

--+RQ9w07xn/7cmLLc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCarZKbQAKCRA6cBh0uS2t
rJ2pAP4sM6uACZtauXlAHma3Iy2D2u2SCYHtgVPuBzVAUjSMZAEAv+u2+f2JmW/b
9fEdEMskwqkblVO/hcT8oQAkaehV4QU=
=N0j3
-----END PGP SIGNATURE-----

--+RQ9w07xn/7cmLLc--
