Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CA5646A5FE
	for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 12:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790338940; cv=none; b=HwhvhhVsM6QFEkQ6rh/y0Ib/RXmpdHOVB6qQriqvtcvkU17xLYaXwQeu0/y7Eu/RxHprqgOj3EUtK/i89ZmaliNYs0U0x/xkn8ztb0YgAVNsCIawOdNttrUcdqJHOQbtqkgyjsbvxOqpDFix96uaSpLrKnhNBlqfKBH3rYWBMOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790338940; c=relaxed/simple;
	bh=h8c24bsbnZ+tC7EDNXnhwXth/0kaoaYpE7QfPd2zxc8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KyIqcAcKcsN4hjUVWeevYv5XZWTPnX9MLMYHc4pcMqA9KQzV/3NVQlPOSa6dy7/ldFDwctHbiwKaFkEPn8XbBrBoxd1roi65SG0DD+1Zr5Mnx0kOqEVhFUKlCRz/THpKjChx41cHjX5OOwsI+TuNr3mQpQRDvhIpv/Bt/Au1W7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GZ6Q4fOS; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=koV1j8Wz; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GZ6Q4fOS";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="koV1j8Wz"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68P5JEju3627535
	for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 12:22:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=zfsUfzcig7yfBM94pZXSIQXk
	83oCnL5wRGZezD+XxoM=; b=GZ6Q4fOSSSB/iHY5oo9Eh5PugiJUjhUjUxRNbejD
	kaX1+Uz9IEHJ3r098vlSSnDbkcvlqlFHgZOc8WhRFRb2rdnlN/x8D+yhyMQPGgc5
	LoFfQGieDKqCkrZWZEC5pv7SmjUefsJufjgOsvpcLGS7wYWgwavl2D07BvgDuSUP
	djLbmGEz3gPITwiGBQU4Vec7dPfhTGToZBJ4c2PyBqonAcHJK3X0XtAaYCxDo6as
	XJ3hXJSOMc952hEkLewOQqSdcwtOgkHcLrPDYx+IDIpvaWDF0tP4NnG+XjrMJvMi
	O6Zspl4VMwNqHYDvooJy5UU4nb39wraA24IkYMwXNdmR3w==
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com [209.85.221.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gwjq399su-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 12:22:16 +0000 (GMT)
Received: by mail-vk1-f199.google.com with SMTP id 71dfb90a1353d-5ccec2500c0so419523e0c.3
        for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 05:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790338935; x=1790943735; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zfsUfzcig7yfBM94pZXSIQXk83oCnL5wRGZezD+XxoM=;
        b=koV1j8WzDbT/fp5UAQL1H2akI55z1Tht3hgq+cjJNedPXHElBruB1tGC7iD2sF3Xo/
         XMQqTZeOBL8UbYCq+BTa2XWNQgCFL+WEtdcl22RxgfODRyxaHy0ryGks7rKN9tyhAkJ0
         s3FXzuTOfdpVFlUURNNnc7gNdKeTLBjzKrg3r/iDZjWtAvCM2o2B+V2akzAjaKPEvGyy
         0U4yeOZ/ZiaRIL8ByWB3vG8QH047yyjSk4Vy6IW2jlzwvnYWa0x+X/0rLV1x+9UVeBsc
         ZjE5I2/PN8WngA4yzhTlhoESM439oqR37b76anKlqBBfBZQW03erWQ/nwZdQ7GAzWOi/
         v67w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790338935; x=1790943735;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zfsUfzcig7yfBM94pZXSIQXk83oCnL5wRGZezD+XxoM=;
        b=IA+ST09+cMNmeq87Vq4VqaxWbvBOBug/qg+zL4ncXFWD7uj/9BQocWe40ILHMjqDDM
         GRfftQ92/FmTgsBbxRzETgP3AptKeoy8ZEs7Jhod2rVsSev7IOkJul/XQ3AF8GAjdqzp
         OLwFz7YTjgkpwqaLY8m8got4xpd4FDn5agYQnuW49ECGUkf8n0Ej46hV3CxgGD2ux8e7
         QPcsRP5wsXe/+6n8GOVt2HVTUqorID/zeGfOKkoppZn5qLCcRmHpxWZnfstlPtLfEYsm
         d+fOIqnFkCjq9Q6fB/m2AYVoqVtFOdXrYDtgzcuf9ctNu5vAohJ68cSV7KoMWQ1gTxHf
         utZQ==
X-Forwarded-Encrypted: i=1; AKwUvBwZlCffnUFWtjn+YHpMOUO/7ANNuVEdFO9+bvM3aDLvLdK7YRo957phUQyOY7cp4yCuF74UEIc=@vger.kernel.org
X-Gm-Message-State: AFuF++mAgkziCAXOHd0bmWY1Zf0GTnewfdmYCqP8ayohM319hu2iAfEU
	p/Q4c0Vj85odLWH/Tk0mhUPcX51SCDHDcreqd4TDdAXR2rvEGnYyYPcI+bX0w7HQ0StFWD+k+XG
	blgYf5HeouPx0B43uGObsomqP5KhAzZy6qxZxF9nASVK/63kAJxj605kkSgk=
X-Gm-Gg: AYBFou2H/VgD+c4XW3OErxoFW9ZAe/9Azfh8yY7JE3eZbXULIQMIfa+CXCvEKuxRwkQ
	mvxGNNN02DdHu/tJ9Rq/khWidbmLXHGtBbESvXhCPpe5Ffa2vkdQ+y4b4hB5E6gilbgDhV6PxNA
	L3LUNc8jT0S+x97FdRYH4CDbICZoOe1iLDMuWVxRmRNlR18H4/Ec2SVfxnkrqVEKXlgJ8dGAELx
	QjCRUtH0VbD/2Xa1PRqS1O5+rqP49UIMHolNKDsVicT++ErOGyhAyGCv+ZyI72v0+/z9Fg6onVL
	A4y3IokYNVYQ8yg1DiKvpgx3Go+oNm/t/pmwMsX2ch4PAHGzOqpxsoj9wAhOSnrg+6Ed6NYSa6t
	1hdFoXTf6MP2Kqg==
X-Received: by 2002:a05:6102:f9a:b0:7a0:3902:52d7 with SMTP id ada2fe7eead31-7af197379b8mr2719690137.0.1790338934876;
        Fri, 25 Sep 2026 05:22:14 -0700 (PDT)
X-Received: by 2002:a05:6102:f9a:b0:7a0:3902:52d7 with SMTP id ada2fe7eead31-7af197379b8mr2719646137.0.1790338934005;
        Fri, 25 Sep 2026 05:22:14 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49ff044422asm54551135e9.2.2026.09.25.05.22.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 05:22:12 -0700 (PDT)
Date: Fri, 25 Sep 2026 14:22:12 +0200
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
Subject: Re: [PATCH RFC net-next 7/9] net: stmmac: support custom XGMAC
 register layouts
Message-ID: <arZnc5AWGz7xuQCq@lore-desk>
References: <20260923-qcom_xpcs_nord_emac-v1-0-4b1c682af70f@oss.qualcomm.com>
 <20260923-qcom_xpcs_nord_emac-v1-7-4b1c682af70f@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="oxEAJo3w1MoBSAJF"
Content-Disposition: inline
In-Reply-To: <20260923-qcom_xpcs_nord_emac-v1-7-4b1c682af70f@oss.qualcomm.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDA0OSBTYWx0ZWRfX/Dib/lwxHCQ0
 SBKBO8VdPHq95HtVdIA45XbMu2AyrWx4rR17ha+OLr8G/7+5J5MHzLKRxy7kjMwt7fGw/j/TDiq
 DolkHgLxzRxvqFtE3T5EjNMNe4jvxq4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDA0OSBTYWx0ZWRfX9y8ZQIunXWB/
 OCvZx7ZgKkNmwOA+S2hSah0XhgLRj3dgsZprnul2+JFB9mIQmtvZcKGJ/Ipb5dX/NNurpZCEuXj
 qi036jY7mepnO5RM3QXQ25zntfnc+twdv0W0fbT2lDlMfZA/8EBUxLYxEZr65W3DcRBzngnNgpV
 toAm+Zawy5RqVF9M/fEeflamZXq3dt52Rkip2R6WQUFwYvd6NYnCOMb5GmiDfBDN8UMKz1o0O2F
 COEU2dCA+gA1+nv7WcC+oRJE3xAe8cuApmJxWcmT0ZyrCzjK6GtLdRt9Q01Gdq8xyG9gj265yO/
 l4OBkxUzFhwZivVSGFSLnAzC+YZd69XqG5BNvDBZxwb6vqdU+jklIjurAuH8/XoGgkW1g3x00+o
 wkv62axcpOh7qhr2nB7H18ua4lf+S5HObsp7MxNa0A3eJvmjvdLDV6pWoewOjiekA63FfUqmUj1
 P933cZCQJCkZKZiZtHA==
X-Authority-Analysis: v=2.4 cv=VuO2kO2n c=1 sm=1 tr=0 ts=6ab66778 cx=c_pps
 a=+D9SDfe9YZWTjADjLiQY5g==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=XQy_6h2IXkJFvW4MDu4A:9 a=QEXdDO2ut3YA:10 a=TnSKH1PiVO0JbxzvU98A:9
 a=vmgOmaN-Xu0dpDh8OwbV:22
X-Proofpoint-GUID: XkszXdEJaYKWu-Xhey9bAxZbK0yCwRDC
X-Proofpoint-ORIG-GUID: XkszXdEJaYKWu-Xhey9bAxZbK0yCwRDC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 spamscore=0 malwarescore=0 bulkscore=0
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609250049

--oxEAJo3w1MoBSAJF
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Some XGMAC integrations place their MTL queues and DMA channels at
> different offsets from the standard register layout. Allow platform
> data to override these addresses while retaining the standard layout by
> default.
>=20
> This follows the approach used by commit 33719b57f52e ("net: stmmac:
> dwmac4: Allow platforms to specify some DMA/MTL offsets"). Qualcomm
> XGMAC hardware similarly uses differently aligned queue and channel
> registers.
>=20
> Also allow platforms to override the timestamp register base.
>=20
> Signed-off-by: Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>

Hi Mohd,

Some nits inline.

Regards,
Lorenzo

> ---
>  drivers/net/ethernet/stmicro/stmmac/common.h       |   1 +
>  .../net/ethernet/stmicro/stmmac/dwmac-socfpga.c    |   2 +-
>  drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h     |  94 ++++++++++-----
>  .../net/ethernet/stmicro/stmmac/dwxgmac2_core.c    |  34 +++---
>  drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c | 128 +++++++++++++--=
------
>  drivers/net/ethernet/stmicro/stmmac/hwif.c         |   5 +-
>  .../net/ethernet/stmicro/stmmac/stmmac_ethtool.c   |   5 +-
>  drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.c   |  15 ++-
>  include/linux/stmmac.h                             |  11 ++
>  9 files changed, 193 insertions(+), 102 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/stmicro/stmmac/common.h b/drivers/net/e=
thernet/stmicro/stmmac/common.h
> index 1729fb29ece3853584bc27ed541413bcba88c695..c6387cecaf5d93ef10c45475a=
533bf1d0a4e0b45 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/common.h
> +++ b/drivers/net/ethernet/stmicro/stmmac/common.h
> @@ -622,6 +622,7 @@ struct mac_device_info {
>  	const struct stmmac_mmc_ops *mmc;
>  	const struct stmmac_est_ops *est;
>  	const struct stmmac_vlan_ops *vlan;
> +	const struct dwxgmac_addrs *dwxgmac_addrs;
>  	struct dw_xpcs *xpcs;
>  	struct phylink_pcs *phylink_pcs;
>  	struct mii_regs mii;	/* MII register Addresses */
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c b/driver=
s/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
> index 1d7f0a57d28897005cdc1c5dcbd3c2f737a6c967..331ba38abae66f03b69c383b3=
0762c9a09735a37 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
> @@ -365,7 +365,7 @@ static int smtg_crosststamp(ktime_t *device, struct s=
ystem_counterval_t *system,
>  	};
> =20
>  	num_snapshot =3D FIELD_GET(XGMAC_TIMESTAMP_ATSNS_MASK,
> -				 readl(ioaddr + XGMAC_TIMESTAMP_STATUS));
> +				 readl(ioaddr + XGMAC_TIMESTAMP_STATUS(NULL)));
> =20
>  	/* Repeat until the timestamps are from the FIFO last segment */
>  	for (i =3D 0; i < num_snapshot; i++) {
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h b/drivers/net=
/ethernet/stmicro/stmmac/dwxgmac2.h
> index f8ab347f7b5b9e1b2df662785bb25cf875456088..22b476358a2028de862186c3d=
38295b2d48d87d6 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
> @@ -220,12 +220,21 @@
>  #define XGMAC_CT			BIT(1)
>  #define XGMAC_OB			BIT(0)
>  #define XGMAC_RSS_DATA			0x00000c8c
> -#define XGMAC_TIMESTAMP_STATUS		0x00000d20
> +
> +/* Timestamp registers */
> +#define XGMAC_TIMESTAMP_BASE_ADDR	0x00000d00
> +
> +static inline u32 xgmac_timestamp_base_addr(const struct dwxgmac_addrs *=
addrs)
> +{
> +	return addrs ? addrs->timestamp_base : XGMAC_TIMESTAMP_BASE_ADDR;
> +}
> +
> +#define XGMAC_TIMESTAMP_STATUS(a)	(xgmac_timestamp_base_addr(a) + 0x20)
>  #define XGMAC_TIMESTAMP_ATSNS_MASK	GENMASK(29, 25)
>  #define XGMAC_TXTSC			BIT(15)
> -#define XGMAC_TXTIMESTAMP_NSEC		0x00000d30
> +#define XGMAC_TXTIMESTAMP_NSEC(a)	(xgmac_timestamp_base_addr(a) + 0x30)
>  #define XGMAC_TXTSSTSLO			GENMASK(30, 0)
> -#define XGMAC_TXTIMESTAMP_SEC		0x00000d34
> +#define XGMAC_TXTIMESTAMP_SEC(a)	(xgmac_timestamp_base_addr(a) + 0x34)
>  #define XGMAC_PPS_CONTROL		0x00000d70
>  #define XGMAC_PPS_MAXIDX(x)		((((x) + 1) * 8) - 1)
>  #define XGMAC_PPS_MINIDX(x)		((x) * 8)
> @@ -285,37 +294,49 @@
>  #define XGMAC_MTL_ECC_INT_STATUS	0x000010cc
>  #define XGMAC_MTL_DPP_CONTROL		0x000010e0
>  #define XGMAC_DPP_DISABLE		BIT(0)
> -#define XGMAC_MTL_TXQ_OPMODE(x)		(0x00001100 + (0x80 * (x)))
> +
> +/* MTL per-queue registers */
> +#define XGMAC_MTL_CHAN_BASE_ADDR	0x00001100
> +#define XGMAC_MTL_CHAN_OFFSET		0x80
> +
> +static inline u32
> +xgmac_mtl_chanx_base_addr(const struct dwxgmac_addrs *addrs, u32 x)
> +{
> +	return addrs ? addrs->mtl_chan_base + x * addrs->mtl_chan_offset
> +		     : XGMAC_MTL_CHAN_BASE_ADDR + x * XGMAC_MTL_CHAN_OFFSET;
> +}

I think if we introduce a dma map even for default case these functions wil=
l be more
readable. What do you think?

> +
> +#define XGMAC_MTL_TXQ_OPMODE(a, x)		xgmac_mtl_chanx_base_addr(a, x)
>  #define XGMAC_TQS			GENMASK(25, 16)
>  #define XGMAC_Q2TCMAP			GENMASK(10, 8)
>  #define XGMAC_TTC			GENMASK(6, 4)
>  #define XGMAC_TXQEN			GENMASK(3, 2)
>  #define XGMAC_TSF			BIT(1)
> -#define XGMAC_MTL_TCx_ETS_CONTROL(x)	(0x00001110 + (0x80 * (x)))
> -#define XGMAC_MTL_TCx_QUANTUM_WEIGHT(x)	(0x00001118 + (0x80 * (x)))
> -#define XGMAC_MTL_TCx_SENDSLOPE(x)	(0x0000111c + (0x80 * (x)))
> -#define XGMAC_MTL_TCx_HICREDIT(x)	(0x00001120 + (0x80 * (x)))
> -#define XGMAC_MTL_TCx_LOCREDIT(x)	(0x00001124 + (0x80 * (x)))
> +#define XGMAC_MTL_TCx_ETS_CONTROL(a, x)	(xgmac_mtl_chanx_base_addr(a, x)=
 + 0x10)
> +#define XGMAC_MTL_TCx_QUANTUM_WEIGHT(a, x)	(xgmac_mtl_chanx_base_addr(a,=
 x) + 0x18)
> +#define XGMAC_MTL_TCx_SENDSLOPE(a, x)		(xgmac_mtl_chanx_base_addr(a, x) =
+ 0x1c)
> +#define XGMAC_MTL_TCx_HICREDIT(a, x)		(xgmac_mtl_chanx_base_addr(a, x) +=
 0x20)
> +#define XGMAC_MTL_TCx_LOCREDIT(a, x)		(xgmac_mtl_chanx_base_addr(a, x) +=
 0x24)
>  #define XGMAC_CC			BIT(3)
>  #define XGMAC_TSA			GENMASK(1, 0)
>  #define XGMAC_SP			(0x0 << 0)
>  #define XGMAC_CBS			(0x1 << 0)
>  #define XGMAC_ETS			(0x2 << 0)
> -#define XGMAC_MTL_RXQ_OPMODE(x)		(0x00001140 + (0x80 * (x)))
> +#define XGMAC_MTL_RXQ_OPMODE(a, x)		(xgmac_mtl_chanx_base_addr(a, x) + 0=
x40)
>  #define XGMAC_RQS			GENMASK(25, 16)
>  #define XGMAC_EHFC			BIT(7)
>  #define XGMAC_RSF			BIT(5)
>  #define XGMAC_RTC			GENMASK(1, 0)
> -#define XGMAC_MTL_RXQ_FLOW_CONTROL(x)	(0x00001150 + (0x80 * (x)))
> +#define XGMAC_MTL_RXQ_FLOW_CONTROL(a, x)	(xgmac_mtl_chanx_base_addr(a, x=
) + 0x50)
>  #define XGMAC_RFD			GENMASK(31, 17)
>  #define XGMAC_RFA			GENMASK(15, 1)
> -#define XGMAC_MTL_QINTEN(x)		(0x00001170 + (0x80 * (x)))
> +#define XGMAC_MTL_QINTEN(a, x)			(xgmac_mtl_chanx_base_addr(a, x) + 0x70)
>  #define XGMAC_RXOIE			BIT(16)
> -#define XGMAC_MTL_QINT_STATUS(x)	(0x00001174 + (0x80 * (x)))
> +#define XGMAC_MTL_QINT_STATUS(a, x)		(xgmac_mtl_chanx_base_addr(a, x) + =
0x74)
>  #define XGMAC_RXOVFIS			BIT(16)
>  #define XGMAC_ABPSIS			BIT(1)
>  #define XGMAC_TXUNFIS			BIT(0)
> -#define XGMAC_MAC_REGSIZE		(XGMAC_MTL_QINT_STATUS(15) / 4)
> +#define XGMAC_MAC_REGSIZE(a)		(XGMAC_MTL_QINT_STATUS(a, 15) / 4)
> =20
>  /* DMA Registers */
>  #define XGMAC_DMA_MODE			0x00003000
> @@ -353,28 +374,43 @@
>  #define XGMAC_TCEIE			BIT(0)
>  #define XGMAC_DMA_ECC_INT_STATUS	0x0000306c
>  #define XGMAC_DMA_DPP_INT_STATUS	0x00003074
> -#define XGMAC_DMA_CH_CONTROL(x)		(0x00003100 + (0x80 * (x)))
> +
> +/* DMA per-channel registers */
> +#define XGMAC_DMA_CHAN_BASE_ADDR	0x00003100
> +#define XGMAC_DMA_CHAN_OFFSET		0x80
> +
> +static inline u32
> +xgmac_dma_chanx_base_addr(const struct dwxgmac_addrs *addrs, u32 x)
> +{
> +	if (addrs && (x & 1))
> +		return addrs->dma_odd_chan_base + x * addrs->dma_chan_offset;
> +	if (addrs)
> +		return addrs->dma_even_chan_base + x * addrs->dma_chan_offset;
> +	return XGMAC_DMA_CHAN_BASE_ADDR + x * XGMAC_DMA_CHAN_OFFSET;
> +}
> +
> +#define XGMAC_DMA_CH_CONTROL(a, x)		(xgmac_dma_chanx_base_addr(a, x))
>  #define XGMAC_SPH			BIT(24)
>  #define XGMAC_PBLx8			BIT(16)
> -#define XGMAC_DMA_CH_TX_CONTROL(x)	(0x00003104 + (0x80 * (x)))
> +#define XGMAC_DMA_CH_TX_CONTROL(a, x)		(xgmac_dma_chanx_base_addr(a, x) =
+ 0x04)
>  #define XGMAC_EDSE			BIT(28)
>  #define XGMAC_TxPBL			GENMASK(21, 16)
>  #define XGMAC_TSE			BIT(12)
>  #define XGMAC_OSP			BIT(4)
>  #define XGMAC_TXST			BIT(0)
> -#define XGMAC_DMA_CH_RX_CONTROL(x)	(0x00003108 + (0x80 * (x)))
> +#define XGMAC_DMA_CH_RX_CONTROL(a, x)		(xgmac_dma_chanx_base_addr(a, x) =
+ 0x08)
>  #define XGMAC_RxPBL			GENMASK(21, 16)
>  #define XGMAC_RBSZ			GENMASK(14, 1)
>  #define XGMAC_RXST			BIT(0)
> -#define XGMAC_DMA_CH_TxDESC_HADDR(x)	(0x00003110 + (0x80 * (x)))
> -#define XGMAC_DMA_CH_TxDESC_LADDR(x)	(0x00003114 + (0x80 * (x)))
> -#define XGMAC_DMA_CH_RxDESC_HADDR(x)	(0x00003118 + (0x80 * (x)))
> -#define XGMAC_DMA_CH_RxDESC_LADDR(x)	(0x0000311c + (0x80 * (x)))
> -#define XGMAC_DMA_CH_TxDESC_TAIL_LPTR(x)	(0x00003124 + (0x80 * (x)))
> -#define XGMAC_DMA_CH_RxDESC_TAIL_LPTR(x)	(0x0000312c + (0x80 * (x)))
> -#define XGMAC_DMA_CH_TxDESC_RING_LEN(x)		(0x00003130 + (0x80 * (x)))
> -#define XGMAC_DMA_CH_RxDESC_RING_LEN(x)		(0x00003134 + (0x80 * (x)))
> -#define XGMAC_DMA_CH_INT_EN(x)		(0x00003138 + (0x80 * (x)))
> +#define XGMAC_DMA_CH_TxDESC_HADDR(a, x)	(xgmac_dma_chanx_base_addr(a, x)=
 + 0x10)
> +#define XGMAC_DMA_CH_TxDESC_LADDR(a, x)	(xgmac_dma_chanx_base_addr(a, x)=
 + 0x14)
> +#define XGMAC_DMA_CH_RxDESC_HADDR(a, x)	(xgmac_dma_chanx_base_addr(a, x)=
 + 0x18)
> +#define XGMAC_DMA_CH_RxDESC_LADDR(a, x)	(xgmac_dma_chanx_base_addr(a, x)=
 + 0x1c)
> +#define XGMAC_DMA_CH_TxDESC_TAIL_LPTR(a, x)	(xgmac_dma_chanx_base_addr(a=
, x) + 0x24)
> +#define XGMAC_DMA_CH_RxDESC_TAIL_LPTR(a, x)	(xgmac_dma_chanx_base_addr(a=
, x) + 0x2c)
> +#define XGMAC_DMA_CH_TxDESC_RING_LEN(a, x)	(xgmac_dma_chanx_base_addr(a,=
 x) + 0x30)
> +#define XGMAC_DMA_CH_RxDESC_RING_LEN(a, x)	(xgmac_dma_chanx_base_addr(a,=
 x) + 0x34)
> +#define XGMAC_DMA_CH_INT_EN(a, x)		(xgmac_dma_chanx_base_addr(a, x) + 0x=
38)
>  #define XGMAC_NIE			BIT(15)
>  #define XGMAC_AIE			BIT(14)
>  #define XGMAC_RBUE			BIT(7)
> @@ -385,9 +421,9 @@
>  					XGMAC_RIE | XGMAC_TIE)
>  #define XGMAC_DMA_INT_DEFAULT_RX	(XGMAC_RIE)
>  #define XGMAC_DMA_INT_DEFAULT_TX	(XGMAC_TIE)
> -#define XGMAC_DMA_CH_Rx_WATCHDOG(x)	(0x0000313c + (0x80 * (x)))
> +#define XGMAC_DMA_CH_Rx_WATCHDOG(a, x)		(xgmac_dma_chanx_base_addr(a, x)=
 + 0x3c)
>  #define XGMAC_RWT			GENMASK(7, 0)
> -#define XGMAC_DMA_CH_STATUS(x)		(0x00003160 + (0x80 * (x)))
> +#define XGMAC_DMA_CH_STATUS(a, x)		(xgmac_dma_chanx_base_addr(a, x) + 0x=
60)
>  #define XGMAC_NIS			BIT(15)
>  #define XGMAC_AIS			BIT(14)
>  #define XGMAC_FBE			BIT(12)
> @@ -396,7 +432,7 @@
>  #define XGMAC_TBU			BIT(2)
>  #define XGMAC_TPS			BIT(1)
>  #define XGMAC_TI			BIT(0)
> -#define XGMAC_REGSIZE			((0x0000317c + (0x80 * 15)) / 4)
> +#define XGMAC_REGSIZE(a)		((xgmac_dma_chanx_base_addr(a, 15) + 0x7c) / 4)
> =20
>  #define XGMAC_DMA_STATUS_MSK_COMMON	(XGMAC_NIS | XGMAC_AIS | XGMAC_FBE)
>  #define XGMAC_DMA_STATUS_MSK_RX		(XGMAC_RBU | XGMAC_RI | \
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c b/driver=
s/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
> index 1a88cbaed70ca18bbb714681569ede863f7130e5..d1099a1cf9ea56661e2beceea=
a3f1938e51dfb3c 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
> @@ -234,11 +234,11 @@ static void dwxgmac2_prog_mtl_tx_algorithms(struct =
mac_device_info *hw,
> =20
>  	/* Set ETS if desired */
>  	for (i =3D 0; i < MTL_MAX_TX_QUEUES; i++) {
> -		value =3D readl(ioaddr + XGMAC_MTL_TCx_ETS_CONTROL(i));
> +		value =3D readl(ioaddr + XGMAC_MTL_TCx_ETS_CONTROL(hw->dwxgmac_addrs, =
i));
>  		value &=3D ~XGMAC_TSA;
>  		if (ets)
>  			value |=3D XGMAC_ETS;
> -		writel(value, ioaddr + XGMAC_MTL_TCx_ETS_CONTROL(i));
> +		writel(value, ioaddr + XGMAC_MTL_TCx_ETS_CONTROL(hw->dwxgmac_addrs, i)=
);
>  	}
>  }
> =20
> @@ -246,9 +246,10 @@ static void dwxgmac2_set_mtl_tx_queue_weight(struct =
stmmac_priv *priv,
>  					     struct mac_device_info *hw,
>  					     u32 weight, u32 queue)
>  {
> +	const struct dwxgmac_addrs *addrs =3D priv->plat->dwxgmac_addrs;
>  	void __iomem *ioaddr =3D hw->pcsr;
> =20
> -	writel(weight, ioaddr + XGMAC_MTL_TCx_QUANTUM_WEIGHT(queue));
> +	writel(weight, ioaddr + XGMAC_MTL_TCx_QUANTUM_WEIGHT(addrs, queue));
>  }
> =20
>  static void dwxgmac2_map_mtl_to_dma(struct mac_device_info *hw, u32 queu=
e,
> @@ -273,18 +274,19 @@ static void dwxgmac2_config_cbs(struct stmmac_priv =
*priv,
>  				u32 send_slope, u32 idle_slope,
>  				u32 high_credit, u32 low_credit, u32 queue)
>  {
> +	const struct dwxgmac_addrs *addrs =3D priv->plat->dwxgmac_addrs;
>  	void __iomem *ioaddr =3D hw->pcsr;
>  	u32 value;
> =20
> -	writel(send_slope, ioaddr + XGMAC_MTL_TCx_SENDSLOPE(queue));
> -	writel(idle_slope, ioaddr + XGMAC_MTL_TCx_QUANTUM_WEIGHT(queue));
> -	writel(high_credit, ioaddr + XGMAC_MTL_TCx_HICREDIT(queue));
> -	writel(low_credit, ioaddr + XGMAC_MTL_TCx_LOCREDIT(queue));
> +	writel(send_slope, ioaddr + XGMAC_MTL_TCx_SENDSLOPE(addrs, queue));
> +	writel(idle_slope, ioaddr + XGMAC_MTL_TCx_QUANTUM_WEIGHT(addrs, queue));
> +	writel(high_credit, ioaddr + XGMAC_MTL_TCx_HICREDIT(addrs, queue));
> +	writel(low_credit, ioaddr + XGMAC_MTL_TCx_LOCREDIT(addrs, queue));
> =20
> -	value =3D readl(ioaddr + XGMAC_MTL_TCx_ETS_CONTROL(queue));
> +	value =3D readl(ioaddr + XGMAC_MTL_TCx_ETS_CONTROL(addrs, queue));
>  	value &=3D ~XGMAC_TSA;
>  	value |=3D XGMAC_CC | XGMAC_CBS;
> -	writel(value, ioaddr + XGMAC_MTL_TCx_ETS_CONTROL(queue));
> +	writel(value, ioaddr + XGMAC_MTL_TCx_ETS_CONTROL(addrs, queue));
>  }
> =20
>  static void dwxgmac2_dump_regs(struct mac_device_info *hw, u32 *reg_spac=
e)
> @@ -292,7 +294,7 @@ static void dwxgmac2_dump_regs(struct mac_device_info=
 *hw, u32 *reg_space)
>  	void __iomem *ioaddr =3D hw->pcsr;
>  	int i;
> =20
> -	for (i =3D 0; i < XGMAC_MAC_REGSIZE; i++)
> +	for (i =3D 0; i < XGMAC_MAC_REGSIZE(hw->dwxgmac_addrs); i++)
>  		reg_space[i] =3D readl(ioaddr + i * 4);
>  }
> =20
> @@ -336,18 +338,19 @@ static int dwxgmac2_host_irq_status(struct stmmac_p=
riv *priv,
>  static int dwxgmac2_host_mtl_irq_status(struct stmmac_priv *priv,
>  					struct mac_device_info *hw, u32 chan)
>  {
> +	const struct dwxgmac_addrs *addrs =3D priv->plat->dwxgmac_addrs;
>  	void __iomem *ioaddr =3D hw->pcsr;
>  	int ret =3D 0;
>  	u32 status;
> =20
>  	status =3D readl(ioaddr + XGMAC_MTL_INT_STATUS);
>  	if (status & BIT(chan)) {
> -		u32 chan_status =3D readl(ioaddr + XGMAC_MTL_QINT_STATUS(chan));
> +		u32 chan_status =3D readl(ioaddr + XGMAC_MTL_QINT_STATUS(addrs, chan));
> =20
>  		if (chan_status & XGMAC_RXOVFIS)
>  			ret |=3D CORE_IRQ_MTL_RX_OVERFLOW;
> =20
> -		writel(~0x0, ioaddr + XGMAC_MTL_QINT_STATUS(chan));
> +		writel(~0x0, ioaddr + XGMAC_MTL_QINT_STATUS(addrs, chan));
>  	}
> =20
>  	return ret;
> @@ -1143,14 +1146,15 @@ static int dwxgmac3_rxp_config(void __iomem *ioad=
dr,
>  static int dwxgmac2_get_mac_tx_timestamp(struct mac_device_info *hw, u64=
 *ts)
>  {
>  	void __iomem *ioaddr =3D hw->pcsr;
> +	const struct dwxgmac_addrs *addrs =3D hw->dwxgmac_addrs;
>  	u32 value;
> =20
> -	if (readl_poll_timeout_atomic(ioaddr + XGMAC_TIMESTAMP_STATUS,
> +	if (readl_poll_timeout_atomic(ioaddr + XGMAC_TIMESTAMP_STATUS(addrs),
>  				      value, value & XGMAC_TXTSC, 100, 10000))
>  		return -EBUSY;
> =20
> -	*ts =3D readl(ioaddr + XGMAC_TXTIMESTAMP_NSEC) & XGMAC_TXTSSTSLO;
> -	*ts +=3D readl(ioaddr + XGMAC_TXTIMESTAMP_SEC) * 1000000000ULL;
> +	*ts =3D readl(ioaddr + XGMAC_TXTIMESTAMP_NSEC(addrs)) & XGMAC_TXTSSTSLO;
> +	*ts +=3D readl(ioaddr + XGMAC_TXTIMESTAMP_SEC(addrs)) * 1000000000ULL;
>  	return 0;
>  }
> =20
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c b/drivers=
/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
> index ff83858ebc1f33aa8092a2d83018bd5f96b7eead..65d5e2a828076563a1c736812=
4ddda226bfffc7a 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
> @@ -47,13 +47,14 @@ static void dwxgmac2_dma_init_chan(struct stmmac_priv=
 *priv,
>  				   void __iomem *ioaddr,
>  				   struct stmmac_dma_cfg *dma_cfg, u32 chan)
>  {
> -	u32 value =3D readl(ioaddr + XGMAC_DMA_CH_CONTROL(chan));
> +	const struct dwxgmac_addrs *addrs =3D priv->plat->dwxgmac_addrs;
> +	u32 value =3D readl(ioaddr + XGMAC_DMA_CH_CONTROL(addrs, chan));
> =20
>  	if (dma_cfg->pblx8)
>  		value |=3D XGMAC_PBLx8;
> =20
> -	writel(value, ioaddr + XGMAC_DMA_CH_CONTROL(chan));
> -	writel(XGMAC_DMA_INT_DEFAULT_EN, ioaddr + XGMAC_DMA_CH_INT_EN(chan));
> +	writel(value, ioaddr + XGMAC_DMA_CH_CONTROL(addrs, chan));
> +	writel(XGMAC_DMA_INT_DEFAULT_EN, ioaddr + XGMAC_DMA_CH_INT_EN(addrs, ch=
an));
>  }
> =20
>  static void dwxgmac2_dma_init_rx_chan(struct stmmac_priv *priv,
> @@ -61,15 +62,16 @@ static void dwxgmac2_dma_init_rx_chan(struct stmmac_p=
riv *priv,
>  				      struct stmmac_dma_cfg *dma_cfg,
>  				      dma_addr_t phy, u32 chan)
>  {
> +	const struct dwxgmac_addrs *addrs =3D priv->plat->dwxgmac_addrs;
>  	u32 rxpbl =3D dma_cfg->rxpbl ?: dma_cfg->pbl;
>  	u32 value;
> =20
> -	value =3D readl(ioaddr + XGMAC_DMA_CH_RX_CONTROL(chan));
> +	value =3D readl(ioaddr + XGMAC_DMA_CH_RX_CONTROL(addrs, chan));
>  	value =3D u32_replace_bits(value, rxpbl, XGMAC_RxPBL);
> -	writel(value, ioaddr + XGMAC_DMA_CH_RX_CONTROL(chan));
> +	writel(value, ioaddr + XGMAC_DMA_CH_RX_CONTROL(addrs, chan));
> =20
> -	writel(upper_32_bits(phy), ioaddr + XGMAC_DMA_CH_RxDESC_HADDR(chan));
> -	writel(lower_32_bits(phy), ioaddr + XGMAC_DMA_CH_RxDESC_LADDR(chan));
> +	writel(upper_32_bits(phy), ioaddr + XGMAC_DMA_CH_RxDESC_HADDR(addrs, ch=
an));
> +	writel(lower_32_bits(phy), ioaddr + XGMAC_DMA_CH_RxDESC_LADDR(addrs, ch=
an));
>  }
> =20
>  static void dwxgmac2_dma_init_tx_chan(struct stmmac_priv *priv,
> @@ -77,15 +79,16 @@ static void dwxgmac2_dma_init_tx_chan(struct stmmac_p=
riv *priv,
>  				      struct stmmac_dma_cfg *dma_cfg,
>  				      dma_addr_t phy, u32 chan)
>  {
> +	const struct dwxgmac_addrs *addrs =3D priv->plat->dwxgmac_addrs;
>  	u32 txpbl =3D dma_cfg->txpbl ?: dma_cfg->pbl;
>  	u32 value;
> =20
> -	value =3D readl(ioaddr + XGMAC_DMA_CH_TX_CONTROL(chan));
> +	value =3D readl(ioaddr + XGMAC_DMA_CH_TX_CONTROL(addrs, chan));
>  	value =3D u32_replace_bits(value, txpbl, XGMAC_TxPBL);
> -	writel(value, ioaddr + XGMAC_DMA_CH_TX_CONTROL(chan));
> +	writel(value, ioaddr + XGMAC_DMA_CH_TX_CONTROL(addrs, chan));
> =20
> -	writel(upper_32_bits(phy), ioaddr + XGMAC_DMA_CH_TxDESC_HADDR(chan));
> -	writel(lower_32_bits(phy), ioaddr + XGMAC_DMA_CH_TxDESC_LADDR(chan));
> +	writel(upper_32_bits(phy), ioaddr + XGMAC_DMA_CH_TxDESC_HADDR(addrs, ch=
an));
> +	writel(lower_32_bits(phy), ioaddr + XGMAC_DMA_CH_TxDESC_LADDR(addrs, ch=
an));
>  }
> =20
>  static void dwxgmac2_dma_axi(void __iomem *ioaddr, struct stmmac_axi *ax=
i)
> @@ -118,16 +121,18 @@ static void dwxgmac2_dma_axi(void __iomem *ioaddr, =
struct stmmac_axi *axi)
>  static void dwxgmac2_dma_dump_regs(struct stmmac_priv *priv,
>  				   void __iomem *ioaddr, u32 *reg_space)
>  {
> +	const struct dwxgmac_addrs *addrs =3D priv->plat->dwxgmac_addrs;
>  	int i;
> =20
> -	for (i =3D (XGMAC_DMA_MODE / 4); i < XGMAC_REGSIZE; i++)
> +	for (i =3D (XGMAC_DMA_MODE / 4); i < XGMAC_REGSIZE(addrs); i++)
>  		reg_space[i] =3D readl(ioaddr + i * 4);
>  }
> =20
>  static void dwxgmac2_dma_rx_mode(struct stmmac_priv *priv, void __iomem =
*ioaddr,
>  				 int mode, u32 channel, int fifosz, u8 qmode)
>  {
> -	u32 value =3D readl(ioaddr + XGMAC_MTL_RXQ_OPMODE(channel));
> +	const struct dwxgmac_addrs *addrs =3D priv->plat->dwxgmac_addrs;
> +	u32 value =3D readl(ioaddr + XGMAC_MTL_RXQ_OPMODE(addrs, channel));
>  	unsigned int rqs =3D fifosz / 256 - 1;
>  	unsigned int rtc;
> =20
> @@ -149,7 +154,7 @@ static void dwxgmac2_dma_rx_mode(struct stmmac_priv *=
priv, void __iomem *ioaddr,
>  	value =3D u32_replace_bits(value, rqs, XGMAC_RQS);
> =20
>  	if ((fifosz >=3D 4096) && (qmode !=3D MTL_QUEUE_AVB)) {
> -		u32 flow =3D readl(ioaddr + XGMAC_MTL_RXQ_FLOW_CONTROL(channel));
> +		u32 flow =3D readl(ioaddr + XGMAC_MTL_RXQ_FLOW_CONTROL(addrs, channel)=
);
>  		unsigned int rfd, rfa;
> =20
>  		value |=3D XGMAC_EHFC;
> @@ -178,16 +183,17 @@ static void dwxgmac2_dma_rx_mode(struct stmmac_priv=
 *priv, void __iomem *ioaddr,
>  		flow =3D u32_replace_bits(flow, rfd, XGMAC_RFD);
>  		flow =3D u32_replace_bits(flow, rfa, XGMAC_RFA);
> =20
> -		writel(flow, ioaddr + XGMAC_MTL_RXQ_FLOW_CONTROL(channel));
> +		writel(flow, ioaddr + XGMAC_MTL_RXQ_FLOW_CONTROL(addrs, channel));
>  	}
> =20
> -	writel(value, ioaddr + XGMAC_MTL_RXQ_OPMODE(channel));
> +	writel(value, ioaddr + XGMAC_MTL_RXQ_OPMODE(addrs, channel));
>  }
> =20
>  static void dwxgmac2_dma_tx_mode(struct stmmac_priv *priv, void __iomem =
*ioaddr,
>  				 int mode, u32 channel, int fifosz, u8 qmode)
>  {
> -	u32 value =3D readl(ioaddr + XGMAC_MTL_TXQ_OPMODE(channel));
> +	const struct dwxgmac_addrs *addrs =3D priv->plat->dwxgmac_addrs;
> +	u32 value =3D readl(ioaddr + XGMAC_MTL_TXQ_OPMODE(addrs, channel));
>  	unsigned int tqs =3D fifosz / 256 - 1;
>  	unsigned int ttc, txqen;
> =20
> @@ -225,45 +231,48 @@ static void dwxgmac2_dma_tx_mode(struct stmmac_priv=
 *priv, void __iomem *ioaddr,
>  	value =3D u32_replace_bits(value, txqen, XGMAC_TXQEN);
>  	value =3D u32_replace_bits(value, tqs, XGMAC_TQS);
> =20
> -	writel(value, ioaddr +  XGMAC_MTL_TXQ_OPMODE(channel));
> +	writel(value, ioaddr +  XGMAC_MTL_TXQ_OPMODE(addrs, channel));
>  }
> =20
>  static void dwxgmac2_enable_dma_irq(struct stmmac_priv *priv,
>  				    void __iomem *ioaddr, u32 chan,
>  				    bool rx, bool tx)
>  {
> -	u32 value =3D readl(ioaddr + XGMAC_DMA_CH_INT_EN(chan));
> +	const struct dwxgmac_addrs *addrs =3D priv->plat->dwxgmac_addrs;
> +	u32 value =3D readl(ioaddr + XGMAC_DMA_CH_INT_EN(addrs, chan));
> =20
>  	if (rx)
>  		value |=3D XGMAC_DMA_INT_DEFAULT_RX;
>  	if (tx)
>  		value |=3D XGMAC_DMA_INT_DEFAULT_TX;
> =20
> -	writel(value, ioaddr + XGMAC_DMA_CH_INT_EN(chan));
> +	writel(value, ioaddr + XGMAC_DMA_CH_INT_EN(addrs, chan));
>  }
> =20
>  static void dwxgmac2_disable_dma_irq(struct stmmac_priv *priv,
>  				     void __iomem *ioaddr, u32 chan,
>  				     bool rx, bool tx)
>  {
> -	u32 value =3D readl(ioaddr + XGMAC_DMA_CH_INT_EN(chan));
> +	const struct dwxgmac_addrs *addrs =3D priv->plat->dwxgmac_addrs;
> +	u32 value =3D readl(ioaddr + XGMAC_DMA_CH_INT_EN(addrs, chan));
> =20
>  	if (rx)
>  		value &=3D ~XGMAC_DMA_INT_DEFAULT_RX;
>  	if (tx)
>  		value &=3D ~XGMAC_DMA_INT_DEFAULT_TX;
> =20
> -	writel(value, ioaddr + XGMAC_DMA_CH_INT_EN(chan));
> +	writel(value, ioaddr + XGMAC_DMA_CH_INT_EN(addrs, chan));
>  }
> =20
>  static void dwxgmac2_dma_start_tx(struct stmmac_priv *priv,
>  				  void __iomem *ioaddr, u32 chan)
>  {
> +	const struct dwxgmac_addrs *addrs =3D priv->plat->dwxgmac_addrs;
>  	u32 value;
> =20
> -	value =3D readl(ioaddr + XGMAC_DMA_CH_TX_CONTROL(chan));
> +	value =3D readl(ioaddr + XGMAC_DMA_CH_TX_CONTROL(addrs, chan));
>  	value |=3D XGMAC_TXST;
> -	writel(value, ioaddr + XGMAC_DMA_CH_TX_CONTROL(chan));
> +	writel(value, ioaddr + XGMAC_DMA_CH_TX_CONTROL(addrs, chan));
> =20
>  	value =3D readl(ioaddr + XGMAC_TX_CONFIG);
>  	value |=3D XGMAC_CONFIG_TE;
> @@ -273,11 +282,12 @@ static void dwxgmac2_dma_start_tx(struct stmmac_pri=
v *priv,
>  static void dwxgmac2_dma_stop_tx(struct stmmac_priv *priv, void __iomem =
*ioaddr,
>  				 u32 chan)
>  {
> +	const struct dwxgmac_addrs *addrs =3D priv->plat->dwxgmac_addrs;
>  	u32 value;
> =20
> -	value =3D readl(ioaddr + XGMAC_DMA_CH_TX_CONTROL(chan));
> +	value =3D readl(ioaddr + XGMAC_DMA_CH_TX_CONTROL(addrs, chan));
>  	value &=3D ~XGMAC_TXST;
> -	writel(value, ioaddr + XGMAC_DMA_CH_TX_CONTROL(chan));
> +	writel(value, ioaddr + XGMAC_DMA_CH_TX_CONTROL(addrs, chan));
> =20
>  	value =3D readl(ioaddr + XGMAC_TX_CONFIG);
>  	value &=3D ~XGMAC_CONFIG_TE;
> @@ -287,11 +297,12 @@ static void dwxgmac2_dma_stop_tx(struct stmmac_priv=
 *priv, void __iomem *ioaddr,
>  static void dwxgmac2_dma_start_rx(struct stmmac_priv *priv,
>  				  void __iomem *ioaddr, u32 chan)
>  {
> +	const struct dwxgmac_addrs *addrs =3D priv->plat->dwxgmac_addrs;
>  	u32 value;
> =20
> -	value =3D readl(ioaddr + XGMAC_DMA_CH_RX_CONTROL(chan));
> +	value =3D readl(ioaddr + XGMAC_DMA_CH_RX_CONTROL(addrs, chan));
>  	value |=3D XGMAC_RXST;
> -	writel(value, ioaddr + XGMAC_DMA_CH_RX_CONTROL(chan));
> +	writel(value, ioaddr + XGMAC_DMA_CH_RX_CONTROL(addrs, chan));
> =20
>  	value =3D readl(ioaddr + XGMAC_RX_CONFIG);
>  	value |=3D XGMAC_CONFIG_RE;
> @@ -301,11 +312,12 @@ static void dwxgmac2_dma_start_rx(struct stmmac_pri=
v *priv,
>  static void dwxgmac2_dma_stop_rx(struct stmmac_priv *priv, void __iomem =
*ioaddr,
>  				 u32 chan)
>  {
> +	const struct dwxgmac_addrs *addrs =3D priv->plat->dwxgmac_addrs;
>  	u32 value;
> =20
> -	value =3D readl(ioaddr + XGMAC_DMA_CH_RX_CONTROL(chan));
> +	value =3D readl(ioaddr + XGMAC_DMA_CH_RX_CONTROL(addrs, chan));
>  	value &=3D ~XGMAC_RXST;
> -	writel(value, ioaddr + XGMAC_DMA_CH_RX_CONTROL(chan));
> +	writel(value, ioaddr + XGMAC_DMA_CH_RX_CONTROL(addrs, chan));
>  }
> =20
>  static int dwxgmac2_dma_interrupt(struct stmmac_priv *priv,
> @@ -314,8 +326,9 @@ static int dwxgmac2_dma_interrupt(struct stmmac_priv =
*priv,
>  				  u32 dir)
>  {
>  	struct stmmac_pcpu_stats *stats =3D this_cpu_ptr(priv->xstats.pcpu_stat=
s);
> -	u32 intr_status =3D readl(ioaddr + XGMAC_DMA_CH_STATUS(chan));
> -	u32 intr_en =3D readl(ioaddr + XGMAC_DMA_CH_INT_EN(chan));
> +	const struct dwxgmac_addrs *addrs =3D priv->plat->dwxgmac_addrs;
> +	u32 intr_status =3D readl(ioaddr + XGMAC_DMA_CH_STATUS(addrs, chan));
> +	u32 intr_en =3D readl(ioaddr + XGMAC_DMA_CH_INT_EN(addrs, chan));
>  	int ret =3D 0;
> =20
>  	if (dir =3D=3D DMA_DIR_RX)
> @@ -354,7 +367,7 @@ static int dwxgmac2_dma_interrupt(struct stmmac_priv =
*priv,
>  	}
> =20
>  	/* Clear interrupts */
> -	writel(intr_en & intr_status, ioaddr + XGMAC_DMA_CH_STATUS(chan));
> +	writel(intr_en & intr_status, ioaddr + XGMAC_DMA_CH_STATUS(addrs, chan)=
);
> =20
>  	return ret;
>  }
> @@ -483,105 +496,120 @@ static int dwxgmac2_get_hw_feature(void __iomem *=
ioaddr,
>  static void dwxgmac2_rx_watchdog(struct stmmac_priv *priv, void __iomem =
*ioaddr,
>  				 u32 riwt, u32 queue)
>  {
> -	writel(riwt & XGMAC_RWT, ioaddr + XGMAC_DMA_CH_Rx_WATCHDOG(queue));
> +	const struct dwxgmac_addrs *addrs =3D priv->plat->dwxgmac_addrs;
> +
> +	writel(riwt & XGMAC_RWT, ioaddr + XGMAC_DMA_CH_Rx_WATCHDOG(addrs, queue=
));
>  }
> =20
>  static void dwxgmac2_set_rx_ring_len(struct stmmac_priv *priv,
>  				     void __iomem *ioaddr, u32 len, u32 chan)
>  {
> -	writel(len, ioaddr + XGMAC_DMA_CH_RxDESC_RING_LEN(chan));
> +	const struct dwxgmac_addrs *addrs =3D priv->plat->dwxgmac_addrs;
> +
> +	writel(len, ioaddr + XGMAC_DMA_CH_RxDESC_RING_LEN(addrs, chan));
>  }
> =20
>  static void dwxgmac2_set_tx_ring_len(struct stmmac_priv *priv,
>  				     void __iomem *ioaddr, u32 len, u32 chan)
>  {
> -	writel(len, ioaddr + XGMAC_DMA_CH_TxDESC_RING_LEN(chan));
> +	const struct dwxgmac_addrs *addrs =3D priv->plat->dwxgmac_addrs;
> +
> +	writel(len, ioaddr + XGMAC_DMA_CH_TxDESC_RING_LEN(addrs, chan));
>  }
> =20
>  static void dwxgmac2_set_rx_tail_ptr(struct stmmac_priv *priv,
>  				     void __iomem *ioaddr, u32 ptr, u32 chan)
>  {
> -	writel(ptr, ioaddr + XGMAC_DMA_CH_RxDESC_TAIL_LPTR(chan));
> +	const struct dwxgmac_addrs *addrs =3D priv->plat->dwxgmac_addrs;
> +
> +	writel(ptr, ioaddr + XGMAC_DMA_CH_RxDESC_TAIL_LPTR(addrs, chan));
>  }
> =20
>  static void dwxgmac2_set_tx_tail_ptr(struct stmmac_priv *priv,
>  				     void __iomem *ioaddr, u32 ptr, u32 chan)
>  {
> -	writel(ptr, ioaddr + XGMAC_DMA_CH_TxDESC_TAIL_LPTR(chan));
> +	const struct dwxgmac_addrs *addrs =3D priv->plat->dwxgmac_addrs;
> +
> +	writel(ptr, ioaddr + XGMAC_DMA_CH_TxDESC_TAIL_LPTR(addrs, chan));
>  }
> =20
>  static void dwxgmac2_enable_tso(struct stmmac_priv *priv, void __iomem *=
ioaddr,
>  				bool en, u32 chan)
>  {
> -	u32 value =3D readl(ioaddr + XGMAC_DMA_CH_TX_CONTROL(chan));
> +	const struct dwxgmac_addrs *addrs =3D priv->plat->dwxgmac_addrs;
> +	u32 value =3D readl(ioaddr + XGMAC_DMA_CH_TX_CONTROL(addrs, chan));
> =20
>  	if (en)
>  		value |=3D XGMAC_TSE;
>  	else
>  		value &=3D ~XGMAC_TSE;
> =20
> -	writel(value, ioaddr + XGMAC_DMA_CH_TX_CONTROL(chan));
> +	writel(value, ioaddr + XGMAC_DMA_CH_TX_CONTROL(addrs, chan));
>  }
> =20
>  static void dwxgmac2_qmode(struct stmmac_priv *priv, void __iomem *ioadd=
r,
>  			   u32 channel, u8 qmode)
>  {
> -	u32 value =3D readl(ioaddr + XGMAC_MTL_TXQ_OPMODE(channel));
> +	const struct dwxgmac_addrs *addrs =3D priv->plat->dwxgmac_addrs;
> +	u32 value =3D readl(ioaddr + XGMAC_MTL_TXQ_OPMODE(addrs, channel));
>  	u32 flow =3D readl(ioaddr + XGMAC_RX_FLOW_CTRL);
>  	unsigned int txqen;
> =20
>  	if (qmode !=3D MTL_QUEUE_AVB) {
>  		txqen =3D 0x2;
> -		writel(0, ioaddr + XGMAC_MTL_TCx_ETS_CONTROL(channel));
> +		writel(0, ioaddr + XGMAC_MTL_TCx_ETS_CONTROL(addrs, channel));
>  	} else {
>  		txqen =3D 0x1;
>  		writel(flow & (~XGMAC_RFE), ioaddr + XGMAC_RX_FLOW_CTRL);
>  	}
> =20
>  	value =3D u32_replace_bits(value, txqen, XGMAC_TXQEN);
> -	writel(value, ioaddr +  XGMAC_MTL_TXQ_OPMODE(channel));
> +	writel(value, ioaddr +  XGMAC_MTL_TXQ_OPMODE(addrs, channel));
>  }
> =20
>  static void dwxgmac2_set_bfsize(struct stmmac_priv *priv, void __iomem *=
ioaddr,
>  				int bfsize, u32 chan)
>  {
> +	const struct dwxgmac_addrs *addrs =3D priv->plat->dwxgmac_addrs;
>  	u32 value;
> =20
> -	value =3D readl(ioaddr + XGMAC_DMA_CH_RX_CONTROL(chan));
> +	value =3D readl(ioaddr + XGMAC_DMA_CH_RX_CONTROL(addrs, chan));
>  	value =3D u32_replace_bits(value, bfsize, XGMAC_RBSZ);
> -	writel(value, ioaddr + XGMAC_DMA_CH_RX_CONTROL(chan));
> +	writel(value, ioaddr + XGMAC_DMA_CH_RX_CONTROL(addrs, chan));
>  }
> =20
>  static void dwxgmac2_enable_sph(struct stmmac_priv *priv, void __iomem *=
ioaddr,
>  				bool en, u32 chan)
>  {
> +	const struct dwxgmac_addrs *addrs =3D priv->plat->dwxgmac_addrs;
>  	u32 value =3D readl(ioaddr + XGMAC_RX_CONFIG);
> =20
>  	value &=3D ~XGMAC_CONFIG_HDSMS;
>  	value |=3D XGMAC_CONFIG_HDSMS_256; /* Segment max 256 bytes */
>  	writel(value, ioaddr + XGMAC_RX_CONFIG);
> =20
> -	value =3D readl(ioaddr + XGMAC_DMA_CH_CONTROL(chan));
> +	value =3D readl(ioaddr + XGMAC_DMA_CH_CONTROL(addrs, chan));
>  	if (en)
>  		value |=3D XGMAC_SPH;
>  	else
>  		value &=3D ~XGMAC_SPH;
> -	writel(value, ioaddr + XGMAC_DMA_CH_CONTROL(chan));
> +	writel(value, ioaddr + XGMAC_DMA_CH_CONTROL(addrs, chan));
>  }
> =20
>  static int dwxgmac2_enable_tbs(struct stmmac_priv *priv, void __iomem *i=
oaddr,
>  			       bool en, u32 chan)
>  {
> -	u32 value =3D readl(ioaddr + XGMAC_DMA_CH_TX_CONTROL(chan));
> +	const struct dwxgmac_addrs *addrs =3D priv->plat->dwxgmac_addrs;
> +	u32 value =3D readl(ioaddr + XGMAC_DMA_CH_TX_CONTROL(addrs, chan));
> =20
>  	if (en)
>  		value |=3D XGMAC_EDSE;
>  	else
>  		value &=3D ~XGMAC_EDSE;
> =20
> -	writel(value, ioaddr + XGMAC_DMA_CH_TX_CONTROL(chan));
> +	writel(value, ioaddr + XGMAC_DMA_CH_TX_CONTROL(addrs, chan));
> =20
> -	value =3D readl(ioaddr + XGMAC_DMA_CH_TX_CONTROL(chan)) & XGMAC_EDSE;
> +	value =3D readl(ioaddr + XGMAC_DMA_CH_TX_CONTROL(addrs, chan)) & XGMAC_=
EDSE;
>  	if (en && !value)
>  		return -EIO;
> =20
> diff --git a/drivers/net/ethernet/stmicro/stmmac/hwif.c b/drivers/net/eth=
ernet/stmicro/stmmac/hwif.c
> index 265671170bf6e3856263fdcf99afbf3eac79a211..fdae241e5cf49a8d7a15aadb6=
7d40700ab5b4429 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/hwif.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/hwif.c
> @@ -368,8 +368,11 @@ int stmmac_hwif_init(struct stmmac_priv *priv)
>  	mac->vlan =3D mac->vlan ? : entry->vlan;
> =20
>  	priv->hw =3D mac;
> +	mac->dwxgmac_addrs =3D priv->plat->dwxgmac_addrs;
>  	priv->fpe_cfg.reg =3D entry->regs.fpe_reg;
> -	priv->ptpaddr =3D priv->ioaddr + entry->regs.ptp_off;
> +	priv->ptpaddr =3D priv->ioaddr +
> +		(priv->plat->dwxgmac_addrs ?
> +		 priv->plat->dwxgmac_addrs->timestamp_base : entry->regs.ptp_off);
>  	priv->mmcaddr =3D priv->ioaddr + entry->regs.mmc_off;
>  	memcpy(&priv->ptp_clock_ops, entry->ptp,
>  	       sizeof(struct ptp_clock_info));
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c b/drive=
rs/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
> index 1cf0f8820b337a0d7a9aa23c7d9b34e3f5616dad..82ce81fb6a18b66f2028a5a77=
84f0a3b9317b9bc 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
> @@ -351,8 +351,9 @@ static int stmmac_ethtool_get_regs_len(struct net_dev=
ice *dev)
>  {
>  	struct stmmac_priv *priv =3D netdev_priv(dev);
> =20
> -	if (priv->plat->core_type =3D=3D DWMAC_CORE_XGMAC)
> -		return XGMAC_REGSIZE * 4;
> +	if (priv->plat->core_type =3D=3D DWMAC_CORE_XGMAC ||
> +	    priv->plat->core_type =3D=3D DWMAC_CORE_25GMAC)

I guess the DWMAC_CORE_25GMAC is never defined, in fact I have the following
compilation error:

drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c:355:38: error: =E2=80=
=98DWMAC_CORE_25GMAC=E2=80=99 undeclared (first use in this function); did =
you mean =E2=80=98DWMAC_CORE_XGMAC=E2=80=99?


> +		return XGMAC_REGSIZE(priv->plat->dwxgmac_addrs) * 4;
>  	else if (priv->plat->core_type =3D=3D DWMAC_CORE_GMAC4)
>  		return GMAC4_REG_SPACE_SIZE;
>  	return REG_SPACE_SIZE;
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.c b/drivers/n=
et/ethernet/stmicro/stmmac/stmmac_fpe.c
> index c889204a7aa5d2e74f7834ed1a22252e6c51ca36..1190b8854132915905773796f=
07503a9bf1446a0 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.c
> @@ -265,9 +265,12 @@ int dwxgmac3_fpe_map_preemption_class(struct net_dev=
ice *ndev,
>  	if (!num_tc) {
>  		/* Restore default TC:Queue mapping */
>  		for (u32 i =3D 0; i < priv->plat->tx_queues_to_use; i++) {
> -			val =3D readl(priv->ioaddr + XGMAC_MTL_TXQ_OPMODE(i));
> +			val =3D readl(priv->ioaddr +
> +				    XGMAC_MTL_TXQ_OPMODE(priv->plat->dwxgmac_addrs,
> +							 i));
>  			writel(u32_replace_bits(val, i, XGMAC_Q2TCMAP),
> -			       priv->ioaddr + XGMAC_MTL_TXQ_OPMODE(i));
> +			       priv->ioaddr +
> +			       XGMAC_MTL_TXQ_OPMODE(priv->plat->dwxgmac_addrs, i));
>  		}
>  	}
> =20
> @@ -288,9 +291,13 @@ int dwxgmac3_fpe_map_preemption_class(struct net_dev=
ice *ndev,
>  			preemptible_txqs |=3D GENMASK(offset + count - 1, offset);
> =20
>  		for (u32 i =3D 0; i < count; i++) {
> -			val =3D readl(priv->ioaddr + XGMAC_MTL_TXQ_OPMODE(offset + i));
> +			val =3D readl(priv->ioaddr +
> +				    XGMAC_MTL_TXQ_OPMODE(priv->plat->dwxgmac_addrs,
> +							 offset + i));
>  			writel(u32_replace_bits(val, tc, XGMAC_Q2TCMAP),
> -			       priv->ioaddr + XGMAC_MTL_TXQ_OPMODE(offset + i));
> +			       priv->ioaddr +
> +			       XGMAC_MTL_TXQ_OPMODE(priv->plat->dwxgmac_addrs,
> +						    offset + i));
>  		}
>  	}
> =20
> diff --git a/include/linux/stmmac.h b/include/linux/stmmac.h
> index 00be2df63d2206a5865bd29333f2f3ba3442962a..5bb904030ef99ac91f66fabaa=
6c2159da1ec8811 100644
> --- a/include/linux/stmmac.h
> +++ b/include/linux/stmmac.h
> @@ -188,6 +188,16 @@ struct dwmac4_addrs {
>  	u32 mtl_low_cred_offset;
>  };
> =20
> +/* Address layout for XGMAC MTL, DMA, and timestamp registers */
> +struct dwxgmac_addrs {
> +	u32 dma_even_chan_base;
> +	u32 dma_odd_chan_base;
> +	u32 dma_chan_offset;
> +	u32 mtl_chan_base;
> +	u32 mtl_chan_offset;
> +	u32 timestamp_base;
> +};
> +
>  enum dwmac_core_type {
>  	DWMAC_CORE_MAC100,
>  	DWMAC_CORE_GMAC,
> @@ -358,6 +368,7 @@ struct plat_stmmacenet_data {
>  	int msi_rx_base_vec;
>  	int msi_tx_base_vec;
>  	const struct dwmac4_addrs *dwmac4_addrs;
> +	const struct dwxgmac_addrs *dwxgmac_addrs;

nit: what about union here?

>  	unsigned int flags;
>  	struct stmmac_dma_cfg __dma_cfg;
>  };
>=20
> --=20
> 2.34.1
>=20

--oxEAJo3w1MoBSAJF
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCarZncwAKCRA6cBh0uS2t
rGCkAP4lPvbe+4Mew0fV5ysaHJipUYUmJVJVod4LBC3SG+zK0QEA522gb0gUUTC1
aOyAo5xBHOk1WIQ9OxFe9zQCxbGK7wI=
=vvtD
-----END PGP SIGNATURE-----

--oxEAJo3w1MoBSAJF--
