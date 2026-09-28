Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5BB546F4AB
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 10:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790589803; cv=none; b=qEoZdZ+gEwYDEaXkK3JsgEo2/a7S9c1ct8Z4/fmRPI7xawL7jZmCpZxCXFdXb62hNsLsvKWYeCMgZSdwJSuDu1TvGKtSvin4DTYgO4CuR9NXATTuFO8H7vz5vLIcGZKDHuNRVEyiAjF2VJ2xJP/eDVq/JYlodEjPY7f/2FU7qMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790589803; c=relaxed/simple;
	bh=0IByJ4pacGA/3wIbCfcDgRrSsmyGPagW3VYRlIC4AKQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NwVs64jOEi/HZtIfKtdMPDQZ8zk3k/Xilqj4qJKTNCcSR/jkfLqh1ldDDUgF0bRpfx7y6Be8GBp4fGOqbDjrjNwVP9NKndSru6pEd+IytpLeWCgaQhq7xXwccZS0PZM+lD4GNPPhRjRf1OH1guMyRwuBr73oeXkR4xlTByszUb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=X/DVCSIu; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=gyPRx482; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="X/DVCSIu";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gyPRx482"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68S9MIJ3546988
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 10:03:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=lmcxBMWJs76vC4rB1IExCHHx
	Py3Iog0aQWSFoBFHf8k=; b=X/DVCSIueF2X45IOxPTr934ErF+c9Vykcq4UO/cK
	bRxmoyhJG9nCZuei9vZFzvFNsJS7TR6B3h+o6Xn1dnOpXQV04N1DuH75bPWMDOmq
	lkBhQVZSgjTo4l50BYVktttWVQs+lcs5UwYV70+Qjlu0uNF6mdMjHCpfH8TtRDJB
	eCIdTe4/80tTVat40QhMtyZ0CGbdHS7xdmq69x0tOVKE0TrfEOMxTtyLxyoFt4DA
	gvmjxgREqN3kWI5Cobict9ZG+ILbqienQVwpV+ffqH+5/5F7ETqqguYsU8/aUl8A
	yTw+Rq8IASxdjaqFDUA84/sAEFdMN8yXSRgqEX5iJ2hxyA==
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com [209.85.222.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gyav49xwu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 10:03:18 +0000 (GMT)
Received: by mail-ua1-f69.google.com with SMTP id a1e0cc1a2514c-9806756ea40so2213837241.1
        for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 03:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790589797; x=1791194597; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=lmcxBMWJs76vC4rB1IExCHHxPy3Iog0aQWSFoBFHf8k=;
        b=gyPRx482MTGvIOXnWSYM+4Bk63FRd/TGNKveu2D6riB2locQ7ziPYKCfkSsy7CjXDb
         9XqTZc9kmGv7KMcXMV4gHcVPJ6H1YWAHEwCEzdd3CjobudWII3Nbco9tYiQoL5FSJz1/
         jfi2aIT9aNH+9JaDDJ7OMfgQW9LfkK7LbsrYYv9QuE/fLsMdquWqW9ERZ7VMlKK1o/3I
         yEdEV8y5/k4l1vvBFNyyAYXSrBuTNhpZ+y2Ng2btjQ127tHUHlF6+knIuXMn3QSqN2K1
         DqeDVnTcu/iue0p0Sv/18zfrPlIuuRGBR79n4BT5JUWkeI0jlqBnCMFYzKNY1pNtHZvG
         o7pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790589797; x=1791194597;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lmcxBMWJs76vC4rB1IExCHHxPy3Iog0aQWSFoBFHf8k=;
        b=BfXG4d54mDyQDFwuOgqomfQc44PQVF2Y2prtH90ZCJTCXKnuQWdgfHRtdhHwphdIL7
         G0vj9tb5rlfugdiQraX7Irm+84cuzsncFxpsKXJvYDGqT3p8Tu7YFasH9D0xsBcfcUNB
         PUCfsw9g7MZR0J8BNPCCVKlJncVTZooQwSLV7EVPNyHzE9AL/0bDBe5aMrg8q01ku0t8
         gEoELgI82pK/GLEmSA+ihrKEuQprp3fGc+ZROINmCBJQnmp31Ooez51scRIlwTjGvP/v
         LGe+dQo7Kaw/Bhhauy8VGUrVLgS0WNofnYWCcKqmWsOx+VREdAd/toE+/fECAHgVtRpO
         XxIQ==
X-Forwarded-Encrypted: i=1; AKwUvBxYWlSxNR4eHuUWB0ZYDS3BcfaWmPdd7Mmknk38xDp/5Ko3fcihtL0zX4Tz1ZUSO1//qUV9MfM=@vger.kernel.org
X-Gm-Message-State: AFq9FYLUN9/hpjnXyhNLRsLy0ecSTIgbH7Q1Z9OVkmRS0eo3N4Qfeqsb
	xvFS4IBW3PnNVvhmvqiit91SAIpAeR+mBX6wxBGhXYvbaMiMoGWalxpP9bD8LJqxaWOzlL3JVXZ
	szufVOLCwMEGK/JdtDJ9Txqq9q3sDPHeIVz25FCYA4w6nTsd5cmm0QhhzjDA=
X-Gm-Gg: AYBFou0+VtwiSoyzic2wIJEK6s8RwveNZXMUybe8wMZUoXH0x2nc/xiZBrlr9qxqV6V
	+oSAfa2hd6mj05LsnxghNl3ioQgUQHBKC4XXgOpI3bmu/4A9bf82Y9TKaNOJtgBa9SZRFsdj8US
	Ex0hTHBOh+TCzSF6Btme6gPrrmUT4+0YLeZVh3FDP0OYwdOOSfnDIKryUQ2VlmoUQoXzXs8EGIc
	hhTqhfWXSUUqZCzBakOQQNiCgjGtG5iJMjzGCyrQWtfKbO6hqM5G6wzzxUWaxSz9PpF94zGC69L
	2kF7nPRwH0OH6XF0KuZmI2gMrLdRtShSKa0M7nDz3PAn6TDqXZHc+qpsS09brfGzruXf9QSHrJW
	vBe/YR68P8SUv3Q==
X-Received: by 2002:a05:6102:5111:b0:7a8:10eb:96ce with SMTP id ada2fe7eead31-7af1c58fab7mr4683045137.4.1790589796979;
        Mon, 28 Sep 2026 03:03:16 -0700 (PDT)
X-Received: by 2002:a05:6102:5111:b0:7a8:10eb:96ce with SMTP id ada2fe7eead31-7af1c58fab7mr4683024137.4.1790589796404;
        Mon, 28 Sep 2026 03:03:16 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fef60da94sm196538545e9.4.2026.09.28.03.03.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 03:03:15 -0700 (PDT)
Date: Mon, 28 Sep 2026 12:03:14 +0200
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
To: Sagar Cheluvegowda <sagar.cheluvegowda@oss.qualcomm.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        netdev@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Hongmei Xu <hongmei.xu@oss.qualcomm.com>,
        Abhishek Chauhan <abhishek.chauhan@oss.qualcomm.com>,
        Sarosh Hasan <sarosh.hasan@oss.qualcomm.com>
Subject: Re: [PATCH] net: stmmac: dwxgmac2: enable L2 split header support
Message-ID: <aro7Yijt_d-KRD0Y@lore-desk>
References: <20260922232116.889630-1-sagar.cheluvegowda@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="1fVf4XHFdNIN3iOa"
Content-Disposition: inline
In-Reply-To: <20260922232116.889630-1-sagar.cheluvegowda@oss.qualcomm.com>
X-Proofpoint-GUID: 93aQMXoQzZRKvRigQeliBnGIWAm-a1Dl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDAzOSBTYWx0ZWRfX08p4YgrjLm3Y
 RLmHWx4BBhqTO97xrHNURCHrIj0ejoXT49ZCj+LGFMSh7UC0Qz9CXgfg1wT+cJjb+8BNImkyH5y
 Ii0lKdltmo8Pw3XEjqo39i1nXIRhltoXYXxbCCFkwicHgyOiY0YNndlz0kKcCgQK32J/OPT7K23
 AT1moG7jBT/Iqc28jqZI5uooMdtsyp3kUZBVWLbDo+PjQ/KAz141It9RuwFyWzHlzeZ6RKKDD8J
 3LS71iklV1bTbmvOaRmva4l69CHvYYX1b89jwN4XP0Z9g27lVZ/frMcXAcnPX0zmcOyVLdm6xKJ
 OUaM4kEaI7BsPTI97Z7TQO4/7XUkcBKyAX8KXz9+dI10PJjEOkxc59n8DZZSGM5A/x+oUNGVpIV
 h03F4+IeeZkrqxs3gv2jyI8OEbBIQUKWHv+QToiCTCvXevdrV3AWKdBadmNnfkBIeqtnFjL3aQW
 fGFuMwQPsQ5cIBDX9Hg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDAzOSBTYWx0ZWRfX+pBjjPFl/V6x
 +Bj953mRcCCn6rGivpmxicXmkIOxWhv8ZCjBSzeuCeXRc5rUwkA1arF6meAqAqxiNAdrRJ6RiLD
 5FF8ifOLNiTpsk2Wf3EnJdDJUJ8dwbo=
X-Proofpoint-ORIG-GUID: 93aQMXoQzZRKvRigQeliBnGIWAm-a1Dl
X-Authority-Analysis: v=2.4 cv=MqLHeGae c=1 sm=1 tr=0 ts=6aba3b66 cx=c_pps
 a=UbhLPJ621ZpgOD2l3yZY1w==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=K8_CPFW8AYnmyr30bPQA:9 a=CjuIK1q_8ugA:10 a=TJw6oMfTIKYT8w6ryAkA:9
 a=TOPH6uDL9cOC6tEoww4z:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-28_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 suspectscore=0 impostorscore=0 phishscore=0
 adultscore=0 clxscore=1015 priorityscore=1501 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609280039

--1fVf4XHFdNIN3iOa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> XGMAC2 doesn't program the MAC extended configuration registers
> needed for L2 header splitting when split-header mode is enabled,
> so tagged AV packets can't use the split-header path. Configure
> split mode (SPLM) and header saving (SAVE_EN) in XGMAC_EXT_CFG1,
> extending the dwmac4 sequence added by commit d10f1a4e44c3 ("net:
> stmmac: Programming sequence for VLAN packets with split header")
> to XGMAC2.
>=20
> Also fix the RX header-length calculation for split-header
> descriptors. Per the XGMAC2 descriptor format, RDES3's L34T and
> L2T fields are only valid on the last descriptor (LD set); on a
> non-last descriptor they can hold stale write-back data from a
> previous packet. Read the header length from RDES2[9:0] directly
> for non-last descriptors, and only consult L34T/L2T on the last
> descriptor: RDES2[9:0] for IP packets (L34T set) and RDES2[9:2]
> for non-IP packets (L2T set).
>=20
> Finally, disable the variable-length preamble when L2 splitting
> is enabled. A variable-length preamble shifts the position of the
> Ethernet header, making the L2 split offset non-deterministic.

Hi Sagar,

are we missing to set dma_cap->sphen for dwxgmac2?

>=20
> Co-developed-by: Abhishek Chauhan <abhishek.chauhan@oss.qualcomm.com>
> Signed-off-by: Abhishek Chauhan <abhishek.chauhan@oss.qualcomm.com>
> Co-developed-by: Sarosh Hasan <sarosh.hasan@oss.qualcomm.com>
> Signed-off-by: Sarosh Hasan <sarosh.hasan@oss.qualcomm.com>
> Signed-off-by: Sagar Cheluvegowda <sagar.cheluvegowda@oss.qualcomm.com>
> ---
>  drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h       |  7 +++++++
>  drivers/net/ethernet/stmicro/stmmac/dwxgmac2_descs.c | 12 +++++++++++-
>  drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c   | 10 ++++++++++
>  3 files changed, 28 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h b/drivers/net=
/ethernet/stmicro/stmmac/dwxgmac2.h
> index f8ab347f7b5b..3ccd29ea7ab0 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
> @@ -167,6 +167,11 @@
>  #define XGMAC_HW_FEATURE4		0x0000012c
>  #define XGMAC_HWFEAT_EASP		BIT(4)
>  #define XGMAC_HWFEAT_PCSEL		GENMASK(1, 0)
> +#define XGMAC_EXT_CFG0			0x140
> +#define XGMAC_EXT_CFG0_VPRE		BIT(8)
> +#define XGMAC_EXT_CFG1			0x00000144
> +#define XGMAC_CONFIG1_SAVE_EN		BIT(24)
> +#define XGMAC_CONFIG1_SPLM(v)		FIELD_PREP(GENMASK(9, 8), v)

I guess it would be better to define a mask for XGMAC_CONFIG1_SPLM.

>  #define XGMAC_MAC_DPP_FSM_INT_STATUS	0x00000150
>  #define XGMAC_MAC_FSM_CONTROL		0x00000158
>  #define XGMAC_PRTYEN			BIT(1)
> @@ -434,6 +439,7 @@
>  #define XGMAC_RDES2_L4FM		BIT(28)
>  #define XGMAC_RDES2_L3FM		BIT(27)
>  #define XGMAC_RDES2_HL			GENMASK(9, 0)
> +#define XGMAC_RDES2_NONIPHL		GENMASK(9, 2)
>  #define XGMAC_RDES3_OWN			BIT(31)
>  #define XGMAC_RDES3_CTXT		BIT(30)
>  #define XGMAC_RDES3_IOC			BIT(30)
> @@ -441,6 +447,7 @@
>  #define XGMAC_RDES3_CDA			BIT(27)
>  #define XGMAC_RDES3_RSV			BIT(26)
>  #define XGMAC_RDES3_L34T		GENMASK(23, 20)
> +#define XGMAC_RDES3_L2T			GENMASK(19, 16)
>  #define XGMAC_RDES3_ET_LT		GENMASK(19, 16)
>  #define XGMAC_L34T_IP4TCP		0x1
>  #define XGMAC_L34T_IP4UDP		0x2
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_descs.c b/drive=
rs/net/ethernet/stmicro/stmmac/dwxgmac2_descs.c
> index 6719ac6e395b..65ac5403ec58 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_descs.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_descs.c
> @@ -292,8 +292,18 @@ static int dwxgmac2_get_rx_hash(struct dma_desc *p, =
u32 *hash,
> =20
>  static void dwxgmac2_get_rx_header_len(struct dma_desc *p, unsigned int =
*len)
>  {
> -	if (le32_to_cpu(p->des3) & XGMAC_RDES3_L34T)
> +	u32 rdes3 =3D le32_to_cpu(p->des3);
> +
> +	/* when FD=3D1 and LD=3D0, HL is RDES2[9:0] */
> +	if (!(rdes3 & XGMAC_RDES3_LD)) {
> +		*len =3D le32_to_cpu(p->des2) & XGMAC_RDES2_HL;

If XGMAC_RDES3_L34T is not defined on non-last descriptor, is it fine to us=
e it
here? IIUC XGMAC_RDES2_HL depends on XGMAC_RDES3_L34T, right?

Regards,
Lorenzo

> +		return;
> +	}
> +
> +	if (rdes3 & XGMAC_RDES3_L34T)
>  		*len =3D le32_to_cpu(p->des2) & XGMAC_RDES2_HL;
> +	else if (rdes3 & XGMAC_RDES3_L2T)
> +		*len =3D (le32_to_cpu(p->des2) & XGMAC_RDES2_NONIPHL) >> 2;
>  }
> =20
>  static void dwxgmac2_set_sec_addr(struct dma_desc *p, dma_addr_t addr, b=
ool is_valid)
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c b/drivers=
/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
> index ff83858ebc1f..0a9c787305a4 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
> @@ -561,6 +561,16 @@ static void dwxgmac2_enable_sph(struct stmmac_priv *=
priv, void __iomem *ioaddr,
>  	value |=3D XGMAC_CONFIG_HDSMS_256; /* Segment max 256 bytes */
>  	writel(value, ioaddr + XGMAC_RX_CONFIG);
> =20
> +	value =3D readl(ioaddr + XGMAC_EXT_CFG1);
> +	value |=3D XGMAC_CONFIG1_SPLM(1);
> +	value |=3D XGMAC_CONFIG1_SAVE_EN;
> +	writel(value, ioaddr + XGMAC_EXT_CFG1);
> +
> +	/* Disable variable preambles to keep the L2 split offset deterministic=
=2E */
> +	value =3D readl(ioaddr + XGMAC_EXT_CFG0);
> +	value &=3D ~XGMAC_EXT_CFG0_VPRE;
> +	writel(value, ioaddr + XGMAC_EXT_CFG0);
> +
>  	value =3D readl(ioaddr + XGMAC_DMA_CH_CONTROL(chan));
>  	if (en)
>  		value |=3D XGMAC_SPH;
> --=20
> 2.34.1
>=20

--1fVf4XHFdNIN3iOa
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaro7YgAKCRA6cBh0uS2t
rGapAQDF8c4yUG8tWu9uZdll6p/lHuMxVFLaEaWwC2q9s2iUYwD9FX9szV+sTCiG
qc7P6ESar2kzpaNwY/frERSXqNcCoAI=
=py7a
-----END PGP SIGNATURE-----

--1fVf4XHFdNIN3iOa--
