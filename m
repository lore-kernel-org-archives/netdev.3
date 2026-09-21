Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31D7E42E8E6
	for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 08:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789977953; cv=none; b=mozzQ3xM8fGrt3EgI2eqXBan2X9YLIOabRe3fooPfNwNkq7atxZjuR4M2tOv36lUo4Au/6P8gsvd+EdJ+CMYWZwNpVaoQ8IqE8OGTFK0Sa4/PRXds3Ar6Kx9tXf8zsaveUMHk1RZSl8UU/gMwSCWPqz5rm1QZabosZaiNe13mgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789977953; c=relaxed/simple;
	bh=nwBEXJfGhZLA7eHpw0hCU7luYBy5IoCoOhaK6z49zWQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FJGUJ58x3cJzD/ijRzbtPLc7RgIJClEVbjwqqzNuAXyaQzBbxlagOk0ocGNXe6Hln58DNtKbrH6Gd/rIc0X/RQuK2Fi0saJ0A8uBxlhFQwFYXfHsNxXFRPcWFGxsqL1HpHZdkb6uS287GmO+qUCnQ+vNvb6zXBhnwpZkQjBxRbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=F/42jLtG; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ZD5sW16q; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="F/42jLtG";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZD5sW16q"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68L79uLN1096083
	for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 08:05:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=+Mjg/tCNPBZhheQ0n8yKQZmK
	A0XJJg6EpF0xjk8cvTM=; b=F/42jLtGZVHVPZrSgblDVkcw/e5msG++8fm/WtHt
	s/m0oaPsnyC9JRhxBqFSdS8eXfFRFZEOrFjT3bn6Ss7a9798ofRzzHXW3er72A6b
	fhuZk9GULIGPRK0h5gwUV1ZxeNQMLKbMLV8zQkZyUOTxVX9JB5WwmBo0uhP6FX5r
	x28YwHzN6THG9haCO2YbuvlBgPP7xdnn2veyBDq1iTdb86zgYwoRFNiZ5vT3yA25
	z37Xf/fxhbkhG9eUcdLWb+Edl7Ocwb0cdX1zFp+k9+LXlDVWzfh57I2l17pU1nrE
	f6a84u3WsfKeC3I8AhgDeZpkyefQ80z/YHou1A96xPsw9A==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gtysw090c-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 08:05:50 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93a082c014aso629137985a.0
        for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 01:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789977950; x=1790582750; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+Mjg/tCNPBZhheQ0n8yKQZmKA0XJJg6EpF0xjk8cvTM=;
        b=ZD5sW16q89xQF4VHt4VSnqWrddC1pPvlLR+J/G03cHtVtFso8pi03521dQWGWabRVW
         8nxdm2Y3TfzzApnZxS6yAUEdo+DhazB7US4Vyaf8sjzWucoW8VySk5NXRO+ZMRYzQLa8
         UQKkNwBjW2VRbqeboK+tQyHH4UhVAX39v6jyY/6I1S+f72M8VOlxV9PiNuoyYwLWTwRQ
         bv04xjIkGkYNlhIaYFbObOsguhkWON+qd5i80LYwuBalG1rBRq4jAvJG7UDOmD4dPC8E
         8dxfwTssGCYsCgm2e82Fel6xIPp/zqT+F0y0477pX91QrNUpcsH30gkXIC1+Gbaa18d1
         odRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789977950; x=1790582750;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+Mjg/tCNPBZhheQ0n8yKQZmKA0XJJg6EpF0xjk8cvTM=;
        b=sGlMDGRrc+30F25B9ZfXWzhQY6VYq9r6FAiNX8BZa9O6tL3EYdmAr4ek8H9qLa9sIa
         CoKVoXp5XrSTimgrq1mOrCjzNwoIcwfsNj1bSddI2zzhcm4kiEqAEdR2Iq4K02oATFAS
         KtvLDLHrTOV6cvVHcfyly4LbD5usuvb/iJtJnwHzo4m+BGWQ2fsRAHW3EaIHo+8XtTfX
         1OpUrylfnAJTiJHZ/0hD0vogSmgAzawYV83+8Mivg7lXT/9p5N9bEsm4I/0O4AW7e8yg
         ijEqqdc9vws0xBZ+aUZqzZM/4N9gFD2dnGGZjoQ1F1OfeknZCmpeTIboWansniaTA9qt
         YNJg==
X-Gm-Message-State: AFuF++ni38qgRYg79xaKn6sqAu4LCVHpe61kba20qdXa1Kc3UUknSxrj
	g9L3btINXu9wPGdc5IJclZjJ+8uet3bmwCp/Pm66j6Vh+DmAN3ffqCFT512FPoFqr8f4oviz7sg
	ufAuE/gfD3L0eufN4s55ieJa9OP0pXV0PHJAXG6q9bx5IWpEDVjtSebEgCWg=
X-Gm-Gg: AYBFou0UGD5i+m051H0k9/K1y3uFjzjEuFPRpo6/bZMe0dRMa7ay6n5sqJfVucCqHtk
	THA6MQFs9TyJ4a9gabSqnSqu0pQZVClZsX09GzAHln2SrXB8NxAJFEZqoxtrT2IvMgHzeJlKFJW
	8kttaMwC9OUNxjkHd2Ecx87GLARFo7YmXA2PneCXMaRdaJuAz1dW13SWaW/fFsJ8KfIrf79p5Cq
	m92GXW6/eu1YWGrnkqUs0w1AgVFoF2ZU88Gqsb1iREkIFB07HTayouK3SuFCaBMymdIF5n77EQQ
	FVYrYU2R1xAc/T1xjNyMeFo0w+CO4Dp8pd8qAw2x0b95di6XJfRNfwb+3cyyhPz0hmxWmX1YGQF
	KHCq2V+kc39TNsA==
X-Received: by 2002:a05:620a:1994:b0:939:f861:8836 with SMTP id af79cd13be357-93bf56e996emr820041885a.20.1789977949997;
        Mon, 21 Sep 2026 01:05:49 -0700 (PDT)
X-Received: by 2002:a05:620a:1994:b0:939:f861:8836 with SMTP id af79cd13be357-93bf56e996emr820038085a.20.1789977949460;
        Mon, 21 Sep 2026 01:05:49 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4872459c3e9sm19451100f8f.32.2026.09.21.01.05.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 01:05:48 -0700 (PDT)
Date: Mon, 21 Sep 2026 10:05:47 +0200
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
To: Til Kaiser <mail@tk154.de>
Cc: netdev@vger.kernel.org, lorenzo@kernel.org, andrew+netdev@lunn.ch,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 2/2] net: airoha: Add XDP statistics
Message-ID: <arDlW06TwVzc2wOH@lore-desk>
References: <20260920154329.161755-1-mail@tk154.de>
 <20260920154329.161755-3-mail@tk154.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fzdF/KmcyqickKS5"
Content-Disposition: inline
In-Reply-To: <20260920154329.161755-3-mail@tk154.de>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDExNSBTYWx0ZWRfX52JZkOA11vPy
 XUwtN8NPZj5fgvfUJvg/5XRDNv/m83X+yfC6fUdMXMmiESIXNxU9/8XOxGXTrIGumi04wg00J6f
 BYDd45/h5F5xR6iKvOmoRkUVVOceUlKrowGB1mtIT0OhDgpXN85AFeqeeObOu6EBhRtHV6KsLwd
 wMHNn1iJKvCd2Rwhv3VOOikbxXczuZqyE1V1wn1+E9NaIPZGAL68BpvjDtuSFQmKoc2iCQ0OUra
 Az6mTl1mqkzynTlJSAygLzG5uJsmhXjx1w4xyAvgQxBvCzbbKFda142t2itto9zHY5/LZWftxUq
 11c723MVDyLzx0syFu/h9OGZPZsQzeJXtfOvw5ieX1FGlvlII4TcBmqn50XFNtLJaSkdUr+rpyH
 XTM04P4QPAXuU4vgUQtmKWmYrWmVBQVOijpZlQWU10cn5srmLWj3jyWvLG76UmxwDIr9rw99uLt
 zEmmr7R+MqnzGVOAMaA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDExNSBTYWx0ZWRfX3TVjjF+dgpS8
 pBylBR/rruHgTsICfymw8WnN5hNLnjkh0GHyH2hjzvMEFIqrfcRIQOEN7NKH1lZ7IHQbYn1ftCb
 J/CQAi5IhqjjcNUa9zdzWW83gITh7fg=
X-Proofpoint-ORIG-GUID: wuICCMvnQvzHlsSuxwj2oV81XhKvejTE
X-Proofpoint-GUID: wuICCMvnQvzHlsSuxwj2oV81XhKvejTE
X-Authority-Analysis: v=2.4 cv=W7etxhWk c=1 sm=1 tr=0 ts=6ab0e55e cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=MsImHhn9_lhz5m8RdU0A:9
 a=CjuIK1q_8ugA:10 a=Plx7TgaRLYl5t2sQAAMA:9 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_03,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 malwarescore=0 suspectscore=0 bulkscore=0
 impostorscore=0 priorityscore=1501 phishscore=0 lowpriorityscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609210115

--fzdF/KmcyqickKS5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Track and expose per-device XDP statistics via ethtool, covering both
> the RX and TX sides of the XDP data path.
>=20
> A new struct airoha_xdp_stats is introduced and embedded in the existing
> struct airoha_hw_stats. It contains the following counters, all protected
> by the existing u64_stats_sync:
>=20
>   rx_xdp_pass            - frames passed to the networking stack
>   rx_xdp_aborted         - frames with XDP_ABORTED or unknown action
>   rx_xdp_drop            - frames dropped by the BPF program or on error
>   rx_xdp_tx              - frames sent back out via XDP_TX
>   rx_xdp_tx_errors       - XDP_TX failures
>   rx_xdp_redirect        - frames successfully redirected
>   rx_xdp_redirect_errors - XDP_REDIRECT failures
>   tx_xdp_xmit            - frames successfully submitted via ndo_xdp_xmit
>   tx_xdp_xmit_errors     - frames dropped in ndo_xdp_xmit
>=20
> The airoha_run_xdp() function is reworked to update the appropriate
> counter after each XDP action. The airoha_xdp_xmit() ndo_xdp_xmit handler
> is updated to record the number of successfully transmitted and dropped
> frames.
>=20
> The ethtool interface is extended with three new callbacks:
>=20
> - get_strings: emits the XDP counter names followed by the page pool
>   stat strings obtained from page_pool_ethtool_stats_get_strings().
> - get_sset_count: returns the combined count of XDP and page pool stats.
> - get_ethtool_stats: reads the XDP counters under the u64_stats_sync
>   seqcount and appends page pool stats collected from all active RX
>   queues via page_pool_get_stats().
>=20
> PAGE_POOL_STATS is selected in Kconfig to enable the page pool statistics
> infrastructure required by the ethtool callbacks.
>=20
> Signed-off-by: Til Kaiser <mail@tk154.de>
> ---
>  drivers/net/ethernet/airoha/Kconfig      |   1 +
>  drivers/net/ethernet/airoha/airoha_eth.c | 131 ++++++++++++++++++++---
>  drivers/net/ethernet/airoha/airoha_eth.h |  14 +++
>  3 files changed, 133 insertions(+), 13 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/airoha/Kconfig b/drivers/net/ethernet/a=
iroha/Kconfig
> index 1f6640a15fc9..3fa7683a79e9 100644
> --- a/drivers/net/ethernet/airoha/Kconfig
> +++ b/drivers/net/ethernet/airoha/Kconfig
> @@ -20,6 +20,7 @@ config NET_AIROHA
>  	depends on NET_DSA || !NET_DSA
>  	select NET_AIROHA_NPU
>  	select PAGE_POOL
> +	select PAGE_POOL_STATS
>  	help
>  	  This driver supports the gigabit ethernet MACs in the
>  	  Airoha SoC family.
> diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ether=
net/airoha/airoha_eth.c
> index 71b25f225a8a..29b837204842 100644
> --- a/drivers/net/ethernet/airoha/airoha_eth.c
> +++ b/drivers/net/ethernet/airoha/airoha_eth.c
> @@ -864,6 +864,11 @@ static int airoha_xdp_xmit(struct net_device *netdev=
, int n,
>  	spin_unlock(&q->lock);
>  	rcu_read_unlock();
> =20
> +	u64_stats_update_begin(&dev->stats.syncp);
> +	dev->stats.xdp_stats.tx_xdp_xmit +=3D n - drops;
> +	dev->stats.xdp_stats.tx_xdp_xmit_errors +=3D drops;
> +	u64_stats_update_end(&dev->stats.syncp);
> +
>  	return n - drops;
>  }
> =20
> @@ -871,40 +876,56 @@ static bool airoha_run_xdp(struct net_device *netde=
v, struct bpf_prog *prog,
>  			   struct xdp_buff *xdp, struct airoha_queue *q,
>  			   struct airoha_queue_entry *e, struct page *page)
>  {
> +	struct airoha_gdm_dev *dev =3D netdev_priv(netdev);
> +	struct airoha_hw_stats *hw_stats =3D &dev->stats;
>  	u32 act =3D bpf_prog_run_xdp(prog, xdp);
> +	u64 *count;
> =20
>  	switch (act) {
>  	case XDP_PASS:
> -		return false;
> +		count =3D &hw_stats->xdp_stats.rx_xdp_pass;
> +		goto update_stats;
>  	case XDP_TX:
>  		if (unlikely(airoha_xdp_xmit_back(netdev, xdp, q->qdma) < 0)) {
> +			count =3D &hw_stats->xdp_stats.rx_xdp_tx_errors;
>  			trace_xdp_exception(netdev, prog, act);
> -			page_pool_put_full_page(q->page_pool, page, true);
> -		} else {
> -			e->buf =3D NULL;
> +			break;
>  		}
> -		break;
> +
> +		e->buf =3D NULL;
> +		count =3D &hw_stats->xdp_stats.rx_xdp_tx;
> +		goto update_stats;
>  	case XDP_REDIRECT:
>  		if (unlikely(xdp_do_redirect(netdev, xdp, prog) < 0)) {
> +			count =3D &hw_stats->xdp_stats.rx_xdp_redirect_errors;
>  			trace_xdp_exception(netdev, prog, act);
> -			page_pool_put_full_page(q->page_pool, page, true);
> -		} else {
> -			q->xdp_flush =3D true;
> -			e->buf =3D NULL;
> +			break;
>  		}
> -		break;
> +
> +		e->buf =3D NULL;
> +		q->xdp_flush =3D true;
> +		count =3D &hw_stats->xdp_stats.rx_xdp_redirect;
> +		goto update_stats;
>  	default:
>  		bpf_warn_invalid_xdp_action(netdev, prog, act);
>  		fallthrough;
>  	case XDP_ABORTED:
> +		count =3D &hw_stats->xdp_stats.rx_xdp_aborted;
>  		trace_xdp_exception(netdev, prog, act);
> -		fallthrough;
> +		break;
>  	case XDP_DROP:
> -		page_pool_put_full_page(q->page_pool, page, true);
> +		count =3D &hw_stats->xdp_stats.rx_xdp_drop;
>  		break;
>  	}
> =20
> -	return true;
> +	page_pool_put_full_page(q->page_pool, page, true);
> +
> +update_stats:
> +	u64_stats_update_begin(&hw_stats->syncp);
> +	*count =3D *count + 1;
> +	u64_stats_update_end(&hw_stats->syncp);

Would it better if we update the stats in airoha_qdma_rx_process() passing a
airoha_xdp_stats struct to airoha_run_xdp(). I guess doing so we can even d=
rop
xdp_flush field in airoha_qdma_queue struct.

> +
> +	return act !=3D XDP_PASS;
>  }
> =20
>  static int airoha_qdma_rx_process(struct airoha_queue *q, int budget)
> @@ -3676,12 +3697,96 @@ static const struct net_device_ops airoha_netdev_=
ops =3D {
>  	.ndo_xdp_xmit		=3D airoha_xdp_xmit,
>  };
> =20
> +#define AIROHA_ETHTOOL_XDP_STAT(x) { #x, \
> +				  offsetof(struct airoha_hw_stats, xdp_stats.x) / \
> +				  sizeof(u64) }
> +
> +static const struct {
> +	const char name[ETH_GSTRING_LEN];
> +	u32 offset;
> +} airoha_ethtool_xdp_stats[] =3D {
> +	AIROHA_ETHTOOL_XDP_STAT(rx_xdp_redirect),
> +	AIROHA_ETHTOOL_XDP_STAT(rx_xdp_redirect_errors),
> +	AIROHA_ETHTOOL_XDP_STAT(rx_xdp_pass),
> +	AIROHA_ETHTOOL_XDP_STAT(rx_xdp_aborted),
> +	AIROHA_ETHTOOL_XDP_STAT(rx_xdp_drop),
> +	AIROHA_ETHTOOL_XDP_STAT(rx_xdp_tx),
> +	AIROHA_ETHTOOL_XDP_STAT(rx_xdp_tx_errors),
> +	AIROHA_ETHTOOL_XDP_STAT(tx_xdp_xmit),
> +	AIROHA_ETHTOOL_XDP_STAT(tx_xdp_xmit_errors),
> +};
> +
> +static void airoha_ethtool_get_strings(struct net_device *netdev, u32 st=
ringset, u8 *data)

nit I like old style :)

	static void airoha_ethtool_get_strings(struct net_device *netdev,
					       u32 stringset, u8 *data)
	{
		....
	}

> +{
> +	int i;
> +
> +	switch (stringset) {
> +	case ETH_SS_STATS:
> +		for (i =3D 0; i < ARRAY_SIZE(airoha_ethtool_xdp_stats); i++) {
> +			strscpy(data, airoha_ethtool_xdp_stats[i].name, ETH_GSTRING_LEN);
> +			data +=3D ETH_GSTRING_LEN;
> +		}
> +		page_pool_ethtool_stats_get_strings(data);
> +		break;
> +	}
> +}
> +
> +static int airoha_ethtool_get_sset_count(struct net_device *netdev, int =
stringset)
> +{
> +	switch (stringset) {
> +	case ETH_SS_STATS:
> +		return ARRAY_SIZE(airoha_ethtool_xdp_stats) + page_pool_ethtool_stats_=
get_count();

same here:
		return ARRAY_SIZE(airoha_ethtool_xdp_stats) +
		       page_pool_ethtool_stats_get_count();

> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +}
> +
> +static void airoha_ethtool_get_ethtool_stats(struct net_device *netdev,
> +					     struct ethtool_stats *stats,
> +					     u64 *data)
> +{
> +	struct airoha_gdm_dev *dev =3D netdev_priv(netdev);
> +	struct airoha_hw_stats *hw_stats =3D &dev->stats;
> +	u64 *hw_stats_base =3D (u64 *)hw_stats;
> +	struct page_pool_stats pp_stats =3D {};
> +	struct airoha_qdma *qdma;
> +	unsigned int start;
> +	int i;
> +
> +	if (netif_running(netdev))
> +		airoha_update_hw_stats(dev);
> +
> +	do {
> +		start =3D u64_stats_fetch_begin(&hw_stats->syncp);
> +		for (i =3D 0; i < ARRAY_SIZE(airoha_ethtool_xdp_stats); i++)
> +			data[i] =3D hw_stats_base[airoha_ethtool_xdp_stats[i].offset];
> +	} while (u64_stats_fetch_retry(&hw_stats->syncp, start));
> +
> +	rcu_read_lock();
> +	qdma =3D rcu_dereference(dev->qdma);

IIRC airoha_ethtool_get_ethtool_stats() is running under RTNL so you can ju=
st
use airoha_qdma_deref() here.

Regards,
Lorenzo

> +	if (qdma) {
> +		for (i =3D 0; i < ARRAY_SIZE(qdma->q_rx); i++) {
> +			struct airoha_queue *q =3D &qdma->q_rx[i];
> +
> +			if (q->page_pool)
> +				page_pool_get_stats(q->page_pool, &pp_stats);
> +		}
> +	}
> +	rcu_read_unlock();
> +
> +	page_pool_ethtool_stats_get(data + ARRAY_SIZE(airoha_ethtool_xdp_stats),
> +				    &pp_stats);
> +}
> +
>  static const struct ethtool_ops airoha_ethtool_ops =3D {
>  	.get_drvinfo		=3D airoha_ethtool_get_drvinfo,
>  	.get_eth_mac_stats      =3D airoha_ethtool_get_mac_stats,
>  	.get_rmon_stats		=3D airoha_ethtool_get_rmon_stats,
>  	.get_link_ksettings	=3D phy_ethtool_get_link_ksettings,
>  	.get_link		=3D ethtool_op_get_link,
> +	.get_strings		=3D airoha_ethtool_get_strings,
> +	.get_sset_count		=3D airoha_ethtool_get_sset_count,
> +	.get_ethtool_stats	=3D airoha_ethtool_get_ethtool_stats,
>  };
> =20
>  static int airoha_metadata_dst_alloc(struct airoha_gdm_port *port)
> diff --git a/drivers/net/ethernet/airoha/airoha_eth.h b/drivers/net/ether=
net/airoha/airoha_eth.h
> index cfbc0b8f5bf9..d2ac295c49e9 100644
> --- a/drivers/net/ethernet/airoha/airoha_eth.h
> +++ b/drivers/net/ethernet/airoha/airoha_eth.h
> @@ -236,6 +236,18 @@ struct airoha_tx_irq_queue {
>  	u32 *q;
>  };
> =20
> +struct airoha_xdp_stats {
> +	u64 rx_xdp_redirect;
> +	u64 rx_xdp_redirect_errors;
> +	u64 rx_xdp_pass;
> +	u64 rx_xdp_aborted;
> +	u64 rx_xdp_drop;
> +	u64 rx_xdp_tx;
> +	u64 rx_xdp_tx_errors;
> +	u64 tx_xdp_xmit;
> +	u64 tx_xdp_xmit_errors;
> +};
> +
>  struct airoha_hw_stats {
>  	struct u64_stats_sync syncp;
> =20
> @@ -259,6 +271,8 @@ struct airoha_hw_stats {
>  	u64 rx_jabber;
>  	u64 rx_len[7];
> =20
> +	struct airoha_xdp_stats xdp_stats;
> +
>  	struct {
>  		/* Previous HW register values for 32-bit counter delta
>  		 * tracking. Storing the last seen value and accumulating
> --=20
> 2.55.0
>=20
>=20

--fzdF/KmcyqickKS5
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCarDlWwAKCRA6cBh0uS2t
rMdDAQCEVNYBekytNaFST2RrMePP44SxkUqsKYfyVZJkKZXz6wEA6znuBk9d9ElA
BtQvlJ/vkXJsbxVEz4vP1pTYR87qGwo=
=T0BR
-----END PGP SIGNATURE-----

--fzdF/KmcyqickKS5--
