Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 275FD3E1CED
	for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 09:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789118184; cv=none; b=fB8pHT7p7vRJYwIteXVbU0Y7MTcp7JzZiG2FPBCIavZlMiApNyEvZQGDIfUsWa4oJb8DJT9H6rjnMY8pc1ZimrrZbmJAKXYgU/i51uKt03xtsEURRt1FKaK3yUvB1t88WecxLzpyGKxJ0JawMs5Lf3iTGc66IHmJXNrxpKoKDdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789118184; c=relaxed/simple;
	bh=D5jJ91nCudZf9o91kNGPaDDhW8pCjVlCB4DHCfkEQ+k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a5p5U+oeHSwsL55DIVbhXpOQH8BlAnURgM0hiwP5IX/R9EcrlnkCeAeyDOSQ0STTUA6EGRRcUKbN8SYzGZ2gxN+poJc3E4jrTpkmH+GL9AnlSGu9jMeTfwn2cN5A5p3zmNOM5Y+7sP/cln4Xu4PiUi8hdQ4jK1AN3P2MxPlVTTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=euv2bv3j; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=T2/OByKN; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="euv2bv3j";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="T2/OByKN"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68B7kqdu3513962
	for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 09:16:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=8JoXukOi4j7ojhYQhmHbrb7d
	w6iEBpFdOmOhwd9rLH4=; b=euv2bv3jHocywpLwbkKkZMXkqc46csQz9SMgW392
	K9N1rhvWaPI/XMH3UlfyB1FxJPMrawCgZg3QyB/c5HJS/KGM6zRe2pcXZ+aPweE/
	eHNaZkgO+mP6IPxN+pyuZCan+ro/XHlhGvm00suh7da/U/gCE702f7m3OJ4B8oUw
	uqMBBe5bl0PuOCWb9FzgiEYouvmuocaoj/Zj+G/4Ugbe93xgpFljD3vblYSgpbZu
	GCLJ+eAH2QaR4Y6jqZIDZZ3TW7sXZqQadSUi5wvRapIFEeWHj4hF++G8K1sqUwVw
	rka64yNqIZbmB544WYj4v4qgwpGHpDC1TttEhPQjGi9+Vw==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gmbd50vjd-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 09:16:22 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-90e98e74535so11292376d6.1
        for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 02:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789118181; x=1789722981; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8JoXukOi4j7ojhYQhmHbrb7dw6iEBpFdOmOhwd9rLH4=;
        b=T2/OByKNy0vs9IkHV79ZrTGFpWnNwdzUOa07OXqCK5WPb+N29YH50/mixKIx9WK8Ub
         544Q+g2Pv5LOQPAqJNWsJ+MgfggaKEXe+679bssFRoRySjSGrycVQ+ptTJMjiVIGWILA
         dqHKd0Xji4mgf9zKh87MuxfggSGhabLz0BrANAZubLomAxGqUnUIb7b6siwCjpaCCUwt
         A4oAOojyKjLZbYq771cFywc92NSiGHzZhfcSKBb2vjtR7OvKIfmYB1pQYjxrEIrIjVZK
         LzMUJoI3E4VGiUX7+OxpjzigX4tvN6eRuKyqCv1DDOJEJh7FTwlmolWCgQ2X9aMZ1ikH
         v/MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789118181; x=1789722981;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8JoXukOi4j7ojhYQhmHbrb7dw6iEBpFdOmOhwd9rLH4=;
        b=PQ9uLjJnp0vAlhzlk/M364gcH/halIqg92ZyerSOxaIPxzLxH6AF3DzINyQ+XRA5Om
         Oeo2tm6DMdkv7KJuSsdreg26BDJeOn6p2ayNApw0PwAu69UaG0ZmbbEy8zpUNVSU7RfA
         W7RSeuhwk9JQtLlfwbIK9/krdk7J24DB+xstFkFbad/cWVnfiUEFrRGk5V1KOHFQjn/8
         kPOXO1v9h+zZa1dUrmuOS/+GujQYZY+iasWQ/E+1GYJRVH/mTW5FUjG92jC+Hr/9sX8/
         v18HyqS0Hb4DPKl9hp9NXNs9PCwl2GYXA861FDUkVN2QokoOeHjwzvRSlMQhz7be9jdI
         dMaQ==
X-Forwarded-Encrypted: i=1; AKwUvBxYnUiuHbHUoB4xuqI3m7Em2UvUZhhWp7TMdCYfmV9lUEYkGthPXTJwgDd0Xa5753kbKC4w+LE=@vger.kernel.org
X-Gm-Message-State: AFuF++m96HNJkO54iKK5wQpUFoRSItMFJ71GJHQ6w9Bq05vzehdb/L0n
	KpuHeKtu/tZlD3VwzMmmWQs0h00dp0+4Yj1l37ToHV1qX+zvgzsAA5l+blh2K6MJf1Fqz4XjyE+
	YydNg15dTOHuDJRoq5b3tEVZc8FqjRs81Iw+4Y9G7kiEOXA65vwIUc5MMMyM=
X-Gm-Gg: AYBFou22PYmFUuHr6KQNqDzsTIdJ/IwnJN4jaRreonVvjYhUq0BonLs36KN9074VcD3
	nNt+1PdAjKazGh4WLwYuzvMI4bO8Uu7h/zEtQti3vm2zlG9mb323o5QWE1LkFHqFEVEnguMIKpU
	+8p4OPI+jAp6tGSguIPntT3qP4RJFfAtuizlt+KHgH9dwKq3kzVUa5e2cc6z/FsCqrV50wICL2e
	uXgTjJqh1UrYjdJ+h5AdBmmN/CGt2cbvepBRCNLow0SjyFf+To3i2d4yvRU8xJJxOzCtTumbUrT
	cEPebI+JvVD13xqbC7D2k8QRb1kei2d6rEvuVSLnbk52W2YdO0H0Xs7uHMCvAxoGacipptc1upF
	Md3PGNDsJLpaJBw==
X-Received: by 2002:a05:620a:7117:b0:936:b923:4832 with SMTP id af79cd13be357-939ea16ba23mr400948785a.28.1789118180977;
        Fri, 11 Sep 2026 02:16:20 -0700 (PDT)
X-Received: by 2002:a05:620a:7117:b0:936:b923:4832 with SMTP id af79cd13be357-939ea16ba23mr400943385a.28.1789118180439;
        Fri, 11 Sep 2026 02:16:20 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-486eb34f1f7sm4509590f8f.24.2026.09.11.02.16.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 02:16:19 -0700 (PDT)
Date: Fri, 11 Sep 2026 11:16:18 +0200
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
To: ZhaoJinming <zhaojinming@uniontech.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <Jose.Abreu@synopsys.com>, netdev@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] net: stmmac: fix stale descriptors and DMA
 mapping leak on Tx map failure
Message-ID: <aqPG4rOjTo183F0u@lore-desk>
References: <20260911-stmmac-fix-vlan-desc-leak-v2-1-817a8a4d4a76@uniontech.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="URoTR0mdpRskH/Fi"
Content-Disposition: inline
In-Reply-To: <20260911-stmmac-fix-vlan-desc-leak-v2-1-817a8a4d4a76@uniontech.com>
X-Proofpoint-GUID: wvIKuIM0ewHjO7EhYbQAFbIDP01Z5ZpY
X-Proofpoint-ORIG-GUID: wvIKuIM0ewHjO7EhYbQAFbIDP01Z5ZpY
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTExMDEyOCBTYWx0ZWRfX2JmXTTCky/2v
 v867HRryMGyn3Dy6fAhcQ3ucmlc+edJDoAkMKSaXmC1KC8S7kmfi04gn+Ql2xc18EIj1rfvc9EU
 VYomLZTd/TSjO5yxPjWQGwmtDpyjzCM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTExMDEyOCBTYWx0ZWRfX2ZCtyyTMHtg4
 PuZ+Ww6U29MeVN34mcXH42Og9ZFQI+mM5kGfF2+s7lZEyewIBaVv3IqdLBh8HsUr7FpDBh3kZ9O
 2NRmKe/uFXWsuNb8183APsSMjtgPS8nITTox0LeuU+m+3EzEifijMegRIiDsMerPHYGs18prqU8
 brCba4w8R3s32KIVSYdBFpRqLJbXFyBdJ29VVJURN+4tHqrGlBPyt5v4osV4hPk9FVrR/EFK4ZF
 kO5wj374LYtoBIeEE8f2cPh/97dU98hlRsDG0LKcgiCDN53PKQ0IayGe3tfMD/wZkMJuNV+xi7B
 eYUdWaUbRig52v9VSybrgPFiSPZFdcWWugyJeFtmUVhqhUp5dL7yrMRTTL+pDPP3GkYGTmzdVhn
 V/f705lJUpc8AiZ7Auhuc4YA160ucS7vyZ/yW56w/XCIB3OUj2Yd1ezEntKzXSXBa/b5zWIMlIN
 1LhvWvICupQIG1q2JTw==
X-Authority-Analysis: v=2.4 cv=db0VTnXe c=1 sm=1 tr=0 ts=6aa3c6e6 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=VwQbUJbxAAAA:8
 a=iHwBjlyiAAAA:8 a=8dicsuV96g38EK64CfoA:9 a=CjuIK1q_8ugA:10
 a=rcQwPy2qHw7U_XsTIocA:9 a=iYH6xdkBrDN1Jqds4HTS:22 a=uNSKXYNwxGiU6LD0JREI:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-11_03,2026-09-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 adultscore=0 clxscore=1015 lowpriorityscore=0
 spamscore=0 impostorscore=0 priorityscore=1501 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609110128

--URoTR0mdpRskH/Fi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> In stmmac_xmit(), when the DMA mapping of the linear part or of a
> fragment fails, the error path only frees the skb.  This leaves behind
> the DMA mappings already created for the linear part and for the
> fragments mapped before the failure, which are never unmapped.
>=20
> The VLAN context descriptor programmed by stmmac_vlan_insert() is also
> left behind with its OWN bit set while tx_q->cur_tx has been advanced
> past it, so the DMA engine later consumes the orphaned descriptor and
> applies its stale VLAN tag to an unrelated frame.
>=20
> Release the descriptors and their DMA mappings in the dma_map_err path
> with stmmac_release_tx_desc() and stmmac_free_tx_buffer(), walking from
> first_entry to entry, then roll back tx_q->cur_tx and release the VLAN
> context descriptor.
>=20
> jumbo_frm() has the same issue: when the DMA mapping of a subsequent
> jumbo buffer fails, the buffers already mapped are never unmapped.
> Unmap them before returning an error in both ring and chain modes.
>=20
> Fixes: 30d932279dc2 ("net: stmmac: Add support for VLAN Insertion Offload=
")
> Signed-off-by: ZhaoJinming <zhaojinming@uniontech.com>

Hi ZhaoJinming,

some comments inline.

Regards,
Lorenzo

> ---
> Changes in v2:
> - Reorder stmmac_xmit() variable declarations in reverse xmas tree
>   order.
> - Unmap partially-mapped buffers in jumbo_frm() when a subsequent
>   buffer mapping fails (ring and chain modes).
> - Link to v1: https://lore.kernel.org/r/20260910-stmmac-fix-vlan-desc-lea=
k-v1-1-6b07dca5e5e8@uniontech.com
> ---
>  drivers/net/ethernet/stmicro/stmmac/chain_mode.c  | 19 +++++++++++++--
>  drivers/net/ethernet/stmicro/stmmac/ring_mode.c   | 10 +++++++-
>  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 29 +++++++++++++++++=
++----
>  3 files changed, 51 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/stmicro/stmmac/chain_mode.c b/drivers/n=
et/ethernet/stmicro/stmmac/chain_mode.c
> index 66025e2509e91f863571041f5b148d04e3708832..8415c740ee9eee32cd8b4c3e9=
b61517690b58f9d 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/chain_mode.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/chain_mode.c
> @@ -20,6 +20,7 @@ static int jumbo_frm(struct stmmac_tx_queue *tx_q, stru=
ct sk_buff *skb,
>  	unsigned int nopaged_len =3D skb_headlen(skb);
>  	struct stmmac_priv *priv =3D tx_q->priv_data;
>  	unsigned int entry =3D tx_q->cur_tx;
> +	unsigned int first_entry =3D entry;
>  	unsigned int bmax, buf_len;
>  	unsigned int i =3D 1, len;
>  	struct dma_desc *desc;
> @@ -57,7 +58,7 @@ static int jumbo_frm(struct stmmac_tx_queue *tx_q, stru=
ct sk_buff *skb,
>  					      bmax, DMA_TO_DEVICE);
>  			desc->des2 =3D cpu_to_le32(lower_32_bits(des2));
>  			if (dma_mapping_error(priv->device, des2))
> -				return -1;
> +				goto err_unmap;
>  			tx_q->tx_skbuff_dma[entry].buf =3D des2;
>  			tx_q->tx_skbuff_dma[entry].len =3D bmax;
>  			stmmac_prepare_tx_desc(priv, desc, 0, bmax, csum,
> @@ -70,7 +71,7 @@ static int jumbo_frm(struct stmmac_tx_queue *tx_q, stru=
ct sk_buff *skb,
>  					      DMA_TO_DEVICE);
>  			desc->des2 =3D cpu_to_le32(lower_32_bits(des2));
>  			if (dma_mapping_error(priv->device, des2))
> -				return -1;
> +				goto err_unmap;
>  			tx_q->tx_skbuff_dma[entry].buf =3D des2;
>  			tx_q->tx_skbuff_dma[entry].len =3D len;
>  			/* last descriptor can be set now */
> @@ -83,6 +84,20 @@ static int jumbo_frm(struct stmmac_tx_queue *tx_q, str=
uct sk_buff *skb,
>  	tx_q->cur_tx =3D entry;
> =20
>  	return entry;
> +
> +err_unmap:
> +	while (first_entry !=3D entry) {
> +		dma_unmap_single(priv->device,
> +				 tx_q->tx_skbuff_dma[first_entry].buf,
> +				 tx_q->tx_skbuff_dma[first_entry].len,
> +				 DMA_TO_DEVICE);
> +		tx_q->tx_skbuff_dma[first_entry].buf =3D 0;
> +		tx_q->tx_skbuff_dma[first_entry].len =3D 0;

are you missing stmmac_release_tx_desc() here?

> +		first_entry =3D STMMAC_NEXT_ENTRY(first_entry,
> +						priv->dma_conf.dma_tx_size);
> +	}
> +
> +	return -1;
>  }
> =20
>  static bool is_jumbo_frm(unsigned int len, bool enh_desc)
> diff --git a/drivers/net/ethernet/stmicro/stmmac/ring_mode.c b/drivers/ne=
t/ethernet/stmicro/stmmac/ring_mode.c
> index f7949419eb9fdca891a50ad0956f40e17f9b0967..4170c897bd1a8b5b757b57625=
0e82e5407cfa325 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/ring_mode.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/ring_mode.c
> @@ -37,6 +37,7 @@ static int jumbo_frm(struct stmmac_tx_queue *tx_q, stru=
ct sk_buff *skb,
>  	len =3D nopaged_len - bmax;
> =20
>  	if (nopaged_len > BUF_SIZE_8KiB) {
> +		unsigned int first_entry =3D entry;
> =20
>  		des2 =3D dma_map_single(priv->device, skb->data, bmax,
>  				      DMA_TO_DEVICE);
> @@ -62,8 +63,15 @@ static int jumbo_frm(struct stmmac_tx_queue *tx_q, str=
uct sk_buff *skb,
>  		des2 =3D dma_map_single(priv->device, skb->data + bmax, len,
>  				      DMA_TO_DEVICE);
>  		desc->des2 =3D cpu_to_le32(lower_32_bits(des2));
> -		if (dma_mapping_error(priv->device, des2))
> +		if (dma_mapping_error(priv->device, des2)) {
> +			dma_unmap_single(priv->device,
> +					 tx_q->tx_skbuff_dma[first_entry].buf,
> +					 bmax, DMA_TO_DEVICE);

are you missing stmmac_release_tx_desc() here?

> +			tx_q->tx_skbuff_dma[first_entry].buf =3D 0;
> +			tx_q->tx_skbuff_dma[first_entry].len =3D 0;
> +			tx_q->tx_skbuff_dma[first_entry].is_jumbo =3D false;
>  			return -1;
> +		}
>  		tx_q->tx_skbuff_dma[entry].buf =3D des2;
>  		tx_q->tx_skbuff_dma[entry].len =3D len;
>  		tx_q->tx_skbuff_dma[entry].is_jumbo =3D true;
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/=
net/ethernet/stmicro/stmmac/stmmac_main.c
> index 24656b35350b14454fb10deced6516eb89e2c0c9..9050611862108065dfa19c1a8=
0961bd78073df9a 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -4767,15 +4767,15 @@ static netdev_tx_t stmmac_xmit(struct sk_buff *sk=
b, struct net_device *dev)
>  	bool enh_desc, has_vlan, set_ic, is_jumbo =3D false;
>  	struct stmmac_priv *priv =3D netdev_priv(dev);
>  	unsigned int nopaged_len =3D skb_headlen(skb);
> +	unsigned int first_entry, entry, tx_packets;
>  	u32 queue =3D skb_get_queue_mapping(skb);
>  	int nfrags =3D skb_shinfo(skb)->nr_frags;
> -	unsigned int first_entry, tx_packets;
>  	struct stmmac_txq_stats *txq_stats;
>  	struct dma_desc *desc, *first_desc;
>  	struct stmmac_tx_queue *tx_q;
>  	int i, csum_insertion =3D 0;
> -	int entry, first_tx;
>  	dma_addr_t dma_addr;
> +	int first_tx, ret;
>  	u32 sdu_len;
> =20
>  	if (priv->tx_path_in_lpi_mode && priv->eee_sw_timer_en)
> @@ -4832,9 +4832,10 @@ static netdev_tx_t stmmac_xmit(struct sk_buff *skb=
, struct net_device *dev)
>  	csum_insertion =3D skb->ip_summed =3D=3D CHECKSUM_PARTIAL;
> =20
>  	if (unlikely(is_jumbo)) {
> -		entry =3D stmmac_jumbo_frm(priv, tx_q, skb, csum_insertion);
> -		if (unlikely(entry < 0) && (entry !=3D -EINVAL))
> +		ret =3D stmmac_jumbo_frm(priv, tx_q, skb, csum_insertion);
> +		if (unlikely(ret < 0) && (ret !=3D -EINVAL))

can ret be really -EINVAL ?

>  			goto dma_map_err;
> +		entry =3D ret;
>  	} else {
>  		bool last_segment =3D (nfrags =3D=3D 0);
> =20
> @@ -4984,6 +4985,26 @@ static netdev_tx_t stmmac_xmit(struct sk_buff *skb=
, struct net_device *dev)
> =20
>  dma_map_err:
>  	netdev_err(priv->dev, "Tx DMA map failed\n");
> +
> +	/* entry points one past the last descriptor written for this frame:
> +	 * on failure it is the descriptor whose DMA mapping failed, so walk
> +	 * from first_entry up to, but not including, entry.  Reset cur_tx
> +	 * unconditionally as both stmmac_vlan_insert() and stmmac_jumbo_frm()
> +	 * may have advanced it, and release the VLAN context descriptor.
> +	 */
> +	while (first_entry !=3D entry) {
> +		desc =3D stmmac_get_tx_desc(priv, tx_q, first_entry);
> +		stmmac_release_tx_desc(priv, desc, priv->descriptor_mode);
> +		stmmac_free_tx_buffer(priv, &priv->dma_conf, queue, first_entry);
> +		first_entry =3D STMMAC_NEXT_ENTRY(first_entry,
> +						priv->dma_conf.dma_tx_size);
> +	}
> +
> +	tx_q->cur_tx =3D first_tx;
> +	if (has_vlan) {
> +		desc =3D stmmac_get_tx_desc(priv, tx_q, first_tx);
> +		stmmac_release_tx_desc(priv, desc, priv->descriptor_mode);
> +	}
>  max_sdu_err:
>  	dev_kfree_skb(skb);
>  	priv->xstats.tx_dropped++;
>=20
> ---
> base-commit: 893e11787f78e43b534e252249ac3fff4d1333f8
> change-id: 20260909-stmmac-fix-vlan-desc-leak-f057bb061daa
>=20
> Best regards,
> --=20
> ZhaoJinming <zhaojinming@uniontech.com>
>=20
>=20

--URoTR0mdpRskH/Fi
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaqPG4gAKCRA6cBh0uS2t
rFQXAQCWThJJOSLg7UreCWMV0kdUwSdHg5NOrs++BTwRP9j+CQEAmDjGDfqPav+X
i2Z/pKV1EJ4AdSF/X91UiQNBsUFLFAU=
=Pbd+
-----END PGP SIGNATURE-----

--URoTR0mdpRskH/Fi--
