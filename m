Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793096630;
	b=I6O//IqPHsRHs0WyTQuQmL5sPzusBK6rGZ2+2OmU4kJOEzz4Vin3e9hzMTyvQnkKbMTp
	 XBdZy59UkMQg0pN9b4wfqNVlS3ci9S9T0iuUShu+T1GGb0g62KDwgwRu8ZKxJ4JCdh+Gp
	 3w5RI2zJnn7fxRHfHz1AAzl9+Eb6tHI0JUJmJcyzBOqtigoMR3yjhpK1URkVMj+vV8OMN
	 ouxLRCvXs+/VJ9bHV4YHqCSpld1puSxv9jv8B7SmYeAWgLAhmJDRbUGtgQjLPFlt4XmFg
	 gj+FNlAWr3n171/lqdbb4xaF4ahiVMx457EukLDkDbvBLKbQQbmYciYpRm1HayEH0ww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793096630;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Authority-Analysis:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=a4T8o8lcbxoyypTHmDp1YkCbVY4+5IakuPZVq/QfrgQ=;
	b=v1/HNAShvvvX62k2ATU+7/HQhOWiB8B8a1syU/7fP+1hqag7PTvmOewXT0752a66NfHb
	 C4TdFSQ5jdQPWw8Nzxm3Hthx0TNAhoKbC77aUL2wTjBY7KZB6mvrheK7NoPBJbVRg/EUi
	 9ttBXnAdo1DOICsLGfwS/v7gQq0bQhJ7TVvElfG8JlYO/LJU4fhgheJTm9BreADx92Rci
	 d4O/YvMUTdqJjy/wGeSGof4GnBc2G4NBCG3x8RPxMD/qx6S0i75qg83vFLub+K9xZ5Wx1
	 X/RwHUVAqQfN9d72dvWMJCudTb3NAELHTCTmKa8hJE7jdVHpZe2f4nzETtAki48fZdg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=YjpegIad;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=HbwCnHug;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97FBD606A31A
	for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 10:23:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 97FBD606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=YjpegIad;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=HbwCnHug
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69R8fqMp796163
	for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 10:23:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=a4T8o8lcbxoyypTHmDp1YkCb
	VY4+5IakuPZVq/QfrgQ=; b=YjpegIadJSgRxIqFTcYLHmbCIlzlxa7FGhNLIyNj
	bQMz0SBO/BMYs9I5fxyO2UECFWWw7udcihltI0Nt1niz9ckrIt0meZeeNf41S6ln
	CmTshAsPcPYYapQQzgzmJ0stiQtlx7T4LTQNZx7FjtH+jSAtAv2BixrNMl2YkSmK
	051DPu/RM04hFt0HpkcOxpb3iI73SwzklYjkKCpezfjTWefDEcohU10jPnEbDgr9
	/6aZKZtK6nqpTezBOzV0fExJx5WQuXqztlof9f4YKbu8JO7QFEvNolIWsZmMmawF
	KhE71tlYvlM67kQmanHrnjtczoaBWjWhU1Mi/AaKiyn5Og==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hjp2t9196-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 10:23:48 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-93f13c143c8so732769785a.3
        for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 03:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793096628; x=1793701428; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=a4T8o8lcbxoyypTHmDp1YkCbVY4+5IakuPZVq/QfrgQ=;
        b=HbwCnHug4vM9RZTSjvfMZnjuMJw4pN99uG43iFEnx39e2VgUlPUZMwfKVKIejv2Vje
         /zvFtu6P8e6l90Rci7iWSRpJxO27lVJ4qEPnzIvbvE8T/glHFjCLne1+qEShfzirBJkQ
         Xfm+B6Hm+fzVAPzDQdL94jq224I7azT0ppcgG90VOK3NS+U7hngdcCAeyzBv0fqAmSs8
         a93T1w5aGwU8wRO61j9IrtVA1gzhQ++V+6r6B6+FvwSOa8DEuovVTTrl9JpAUumg1M7N
         hqo3Enin18kXZxIXY+61m3AK3TlsdNzRM3JPjoO7CYvkNd8rvCcfdhS8QriBukg4zPnw
         5XOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793096628; x=1793701428;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=a4T8o8lcbxoyypTHmDp1YkCbVY4+5IakuPZVq/QfrgQ=;
        b=ygRzMha3xeZAoIC+89dfz1qG43RbkcJoQNyGGI9EJpDGuoWzk5dgbUVJEOytb3AU2x
         Y21lKGYZhmhomVUtBmrNUJH5tUiovyL4UzrNKoIBhiAjzq+sEyt45vz7evqIbs95LN6L
         7uOw2n0rGh6TU07c5MUSr217WoPwzxglj6NCvV2kPnf6xRQv/H9oYeS1GBcoyVrQ2p0t
         hcIEQ3jFNFJwFfM88qWsfbhfyq7d8HU3OefnG9vWRMFEH4JScS4xIxJu+zOpo8uAJTw5
         URAKu1E2HzJFXhq+EOOcryINnanBKhbvuPFaiIbgWJ0eVmBX5qz0lJgHA3uCw5VWeQ6t
         egww==
X-Forwarded-Encrypted: i=1; AKwUvBwFtlsyrFWfzoBVbG71gFnhnYHdFiD7oHRDqEO+wi3UlCERIO4h7JE21nYLYjHbCDU60QHrYjw=@vger.kernel.org
X-Gm-Message-State: AFq9FYL4nDo/bRK9H6syyBp+adYMW+OTDtOKaBiXBsdQd3hPVQGRPX0V
	G4C0D9ItSVVG3tc444sHRpNpEuwdkadFPIUkXbRkMxd7/GU/1A6YztiBehh9nAzVPqm2zEzySsf
	OBkrVIy5hsX/hcoP32IFqpMIUbgrAvo77Hr6AOIU0c7vvjoSgDJNmsIeIsB4=
X-Gm-Gg: AYBFou1MxJbI9WSB+2c+xHOA/cefRNdDrjinmSzKUsJymgDpcPne650Xep0RAFzzgKr
	6UsTLJLy5EVKZkRkh7bHY7ubl4SHGt/y13ieOStxC9Sh5N1eTu7NEcXp5cteMGN8YbIHBiIF3R2
	4Kw1Glmvqq9fWuQzpR3rXnGKM9wvRguVV9vxq7EkuTOvMs++GgXsVo7UOu80VPLcOe0IfZ+fgQH
	ao6EaItBnDXZqnMmJWhKrVhhRuUXzAPNFASBRnmLs4/KTTfW7yOxIEAXZtnHfi84v2YxfAxPxhB
	jtTOHyiBmBUMNRHteBXOw5I1HLdHxjJ2/lt7T4nrIayt6qGdlJQ1pDQMs/nNa8cNj7g2NpGsz7A
	89nS6SVtQ1dn4ZrMLRETEzp4phuQUK7ge75BY7vm4n47BBdmb
X-Received: by 2002:a05:620a:4592:b0:93f:38c7:70f9 with SMTP id af79cd13be357-940ef901c2emr1592814785a.14.1793096627463;
        Tue, 27 Oct 2026 03:23:47 -0700 (PDT)
X-Received: by 2002:a05:620a:4592:b0:93f:38c7:70f9 with SMTP id af79cd13be357-940ef901c2emr1592811785a.14.1793096626877;
        Tue, 27 Oct 2026 03:23:46 -0700 (PDT)
Received: from localhost (net-93-144-6-81.cust.dsl.teletu.it. [93.144.6.81])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ebd4bc5sm22130417f8f.34.2026.10.27.03.23.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 03:23:45 -0700 (PDT)
Date: Tue, 27 Oct 2026 11:23:45 +0100
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
To: netdev-bot+sashiko@kernel.org
Cc: maxime.chevallier@bootlin.com, andrew+netdev@lunn.ch, davem@davemloft.net,
        edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
        ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
        john.fastabend@gmail.com, sdf@fomichev.me, Jose.Abreu@synopsys.com,
        boon.leong.ong@intel.com, o.rempel@pengutronix.de,
        netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        bpf@vger.kernel.org
Subject: Re: [PATCH net 3/6] net: stmmac: drop multi-buffer frames in XDP mode
Message-ID: <auB7sd5hmULjDdHW@lore-desk>
References: <20261023-stmmac-xdp-fixes-v1-3-efb37e19f5bd@oss.qualcomm.com>
 <179309225404.3134.13890305235467768199@kernel.org>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6H5iQYhV4nbLml5a"
Content-Disposition: inline
In-Reply-To: <179309225404.3134.13890305235467768199@kernel.org>
X-Authority-Analysis: v=2.4 cv=AJjzCM5L c=1 sm=1 tr=0 ts=6ae07bb4 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=7fYLNvKHbgS61GKHX+yayQ==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=9R54UkLUAAAA:8
 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=S0Y5g3arb0KNKT7adY0A:9 a=QEXdDO2ut3YA:10
 a=b300ueoQ1PtkQ76yJf0A:9 a=IoWCM6iH3mJn3m4BftBB:22 a=YTcpBFlVQWkNscrzJ_Dz:22
X-Proofpoint-GUID: CXbD5I5yBaFxJ7ATbYQ0DLPm_UYGtqww
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDA0MSBTYWx0ZWRfX/TtrGKgpb5uP
 MeJux1s0OHpH+vIox21gidbrvVTqraLQKVPZt18rHKWraq8Yq+dpBFERLTTnbqZWHVeU/9bVbh8
 ebiw2JFne1goeeHeDCcKiwVIG/jl8i0=
X-Proofpoint-ORIG-GUID: CXbD5I5yBaFxJ7ATbYQ0DLPm_UYGtqww
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA0MSBTYWx0ZWRfX/uA8eUZt/l8l
 oOJ5xijyVx3P6uumShfGn0F3N7eNIg+OyFL1YbCou/jI4Yl1Q3aUciJvbuRVJmykayLoDcxRmVi
 410vnMTRSK2x2X2Vbpw2iMDfN6e554if8IqzUOTAa0ufzRVHjsB/z1zLyNfT17zqM43J/2ZAeIk
 L/RRcMzruKL1igfohoDkIdB/cFhVxAd3HX3TOYWaFjqV8G2Za6J2lfbXeB13MWi32zFRQ7Mbt7y
 GMw4Og6qyOv7fShnQHFGdCtKfDne40snn2rkKIfJ9naQiRTLxNTL+ZIi/A5BTHNn/mLwMxwgMPU
 Pp6PERrhxoIQaQdzT+GRPEEz6wKEcuGNm0jYjMQWZhSlawm0vdCM+v0f7hZh96E56a3ae6R/dGy
 aPTCf40ovlCy3+vspSoKxN4V8pNLO+TpL87JchwJ4QoyQrn/di82lac19VOoQIOIONRqq3w5OZ8
 D6TpWauFtFtpEQQ+kjg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 bulkscore=0 malwarescore=0 spamscore=0
 clxscore=1015 priorityscore=1501 adultscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610270041

--6H5iQYhV4nbLml5a
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Oct 27, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found more severe
> issue(s) in other patches of this series. This mail is only an FYI, in ca=
se
> you want to address the nit picks below when you respin.
>=20
> Low priority / nit picks for your consideration:
>=20
> - [Low] The patch cites only `Fixes: 5fabb01207a2` ("net: stmmac: Add
>   initial XDP support").
>=20
> Pre-existing issues:
> - [High] Without an XDP program, stmmac_rx() still re-parses the rest of
>   a frame as a new frame when napi_build_skb() fails on a non-last=E2=80=
=A6
> - [Medium] stmmac_rx() adds its per-poll local counters to the device-
>   wide `priv->xstats.rx_dropped` and `priv->xstats.rx_errors` (plain=E2=
=80=A6
>=20
> --
>=20
> net: stmmac: drop multi-buffer frames in XDP mode
>=20
> This patch makes stmmac_rx() drop frames that span more than one
> descriptor, or that use the second buffer of a descriptor, while an XDP
> program is attached. Discarded buffers are no longer returned to the page
> pool, so stmmac_rx_refill() can reuse them in place. The re-parse of the
> remaining descriptors after an XDP_CONSUMED verdict is also removed.
>=20
> > Fixes: 5fabb01207a2 ("net: stmmac: Add initial XDP support")
>=20
> [Severity: Low]
> Should this also carry a Fixes tag for 88095728511e ("net: stmmac: fix rx
> Scatter-Gather support")? Two of the failures described in the commit
> message seem to come from that commit, not from the initial XDP support.
>=20
> First, the buf1_len underflow. Before 88095728511e, stmmac_rx_buf1_len()
> returned min_t(unsigned int, dma_buf_sz, plen) for the last descriptor. A
> tail re-parsed after XDP_CONSUMED therefore got dma_buf_sz bytes.
>=20
> 88095728511e changed the return to:
>=20
> 	return min_t(unsigned int, priv->dma_conf.dma_buf_sz, plen - len);
>=20
> It also moved the XDP-mode FCS strip into the if (!skb) block:
>=20
> 	if (stmmac_xdp_is_enabled(priv) && !buf2_len) {
> 		buf1_len -=3D ETH_FCS_LEN;
>=20
> Together, these two changes let a 0-3 byte buf1_len underflow.
>=20
> Second, the second-buffer case. Before 88095728511e, stmmac_rx_buf2_len()
> started with:
>=20
> 	if (!priv->sph_active)
> 		return 0;
>=20
> stmmac_xdp_set_prog() clears sph_active while XDP is enabled, so buf2_len
> was always 0 in XDP mode. That check is now:
>=20
> 	if (!stmmac_rx_check_buf2_cap(priv))
> 		return 0;
>=20
> So "GMAC4/XGMAC always provide a second data buffer per descriptor" has
> only been true since 88095728511e. The new buf2_len drop fixes a condition
> that commit introduced.
>=20
> The last patch in this series ("net: stmmac: fix XDP RX buffer DMA sync
> length") already carries Fixes: 88095728511e.

ack, I will fix the commit message in v2

>=20
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/driver=
s/net/ethernet/stmicro/stmmac/stmmac_main.c
> > index 3fa2c15222d88..30a2774d722b7 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > @@ -5903,18 +5903,23 @@ static int stmmac_rx(struct stmmac_priv *priv, =
int limit, u32 queue)
>=20
> [ ... ]
>=20
> > -		if (unlikely(error && (status & rx_not_ls)))
> > -			goto read_again;
> > +		/* We do not support SG in XDP mode */
> > +		if (unlikely(!error && (status & rx_not_ls) &&
> > +			     stmmac_xdp_is_enabled(priv))) {
> > +			rx_dropped++;
> > +			error =3D 1;
> > +		}
> > =20
> >  		if (unlikely(error)) {
> > +			if (status & rx_not_ls)
> > +				goto read_again;
> > +
> >  			dev_kfree_skb(skb);
> >  			goto next;
> >  		}
>=20
> [Severity: High]
> This is a pre-existing issue, and this patch did not introduce it. The new
> error-and-drain handling only runs when stmmac_xdp_is_enabled() is true.
> Without an XDP program, can the same re-parse still happen when
> napi_build_skb() fails on a non-last descriptor?

This issue has not been introduced in this patch and it needs to be fixed w=
ith
a dedicated patch.

>=20
> The failure branch in stmmac_rx() leaves skb =3D=3D NULL and error =3D=3D=
 0:
>=20
> 	skb =3D napi_build_skb(page_address(buf->page),
> 			     rx_q->napi_skb_frag_size);
> 	if (!skb) {
> 		page_pool_recycle_direct(rx_q->page_pool,
> 					 buf->page);
> 		buf->page =3D NULL;
> 		rx_dropped++;
> 		count++;
> 		goto drain_data;
> 	}
> 	...
> drain_data:
> 	if (likely(status & rx_not_ls))
> 		goto read_again;
>=20
> The next descriptor of the same hardware frame then passes the error check
> and is handled as the start of a new frame.
>=20
> SPH is active by default on SPH-capable GMAC4/XGMAC when no XDP program is
> attached. In that case stmmac_rx_buf1_len() returns 0 for this descriptor:
>=20
> 	if (priv->sph_active && len)
> 		return 0;
>=20
> napi_build_skb() then builds an skb with an empty linear area, and the
> payload is only in a buf2 frag. pskb_trim(skb, len) does nothing, because
> the stale len is larger than skb->len.
>=20
> With the default hw_vlan_en, nothing pulls the header into the linear area
> before this call chain:
>=20
> 	eth_type_trans()
> 	  eth_skb_pull_mac()
> 	    skb_pull_inline(skb, ETH_HLEN)
> 	      __skb_pull()
> 	        BUG()
>=20
> Under memory pressure, could an on-link peer panic the machine this way by
> sending a frame larger than one buffer? GMAC_CONFIG_JE is set in
> GMAC_CORE_INIT, so such frames are accepted even at MTU 1500.
>=20
> Without SPH, the stack instead gets a frame whose Ethernet header comes
> from the middle of the peer's payload.
>=20
> This path is still unchanged at the end of the series. The VLAN rework in
> "net: stmmac: fix VLAN tag stripping on short and non-linear RX frames"
> adds pskb_may_pull() only to the software stmmac_rx_vlan() path.
>=20
> Would it drain the frame correctly to set error =3D 1 in the
> napi_build_skb() failure branch, as this patch does for XDP mode?
>=20
> > @@ -5926,6 +5931,14 @@ static int stmmac_rx(struct stmmac_priv *priv, i=
nt limit, u32 queue)
> >  		buf2_len =3D stmmac_rx_buf2_len(priv, p, status, len);
> >  		len +=3D buf2_len;
> > =20
> > +		/* Drop the packet if it is split over buf1 and buf2 on a
> > +		 * single descriptor if the interface is running in XDP mode.
> > +		 */
> > +		if (unlikely(stmmac_xdp_is_enabled(priv) && buf2_len)) {
> > +			rx_dropped++;
> > +			goto next;
> > +		}
>=20
> [Severity: Medium]
> This isn't a bug introduced by this patch. The new drop paths add to
> rx_dropped, which stmmac_rx() folds into a device-wide counter at the end:
>=20
> 	priv->xstats.rx_dropped +=3D rx_dropped;
> 	priv->xstats.rx_errors +=3D rx_errors;

This issue has not been introduced in this patch and it needs to be fixed w=
ith
a dedicated patch.

Regards,
Lorenzo

>=20
> These are plain unsigned long fields in struct stmmac_extra_stats. They
> are updated with a non-atomic read-modify-write, and no shared lock is
> held.
>=20
> Each RX queue has its own NAPI instance. Can two queues polled on
> different CPUs lose each other's increments here? The napi_syncp section
> just before this only protects the per-queue rxq_stats.
>=20
> The race goes back to 133466c3bbe171 ("net: stmmac: use per-queue 64 bit
> statistics where necessary").
>=20
> [ ... ]
>=20
> --=20
> Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#/patch=
set/20261023-stmmac-xdp-fixes-v1-0-efb37e19f5bd%40oss.qualcomm.com

--6H5iQYhV4nbLml5a
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCauB7sQAKCRA6cBh0uS2t
rONnAQCDfR2LW22R0qwMYN7+KVy2cajIhy1x0rDeASn9b7lyKQD8DSfJFgaqLr/z
OtdSrJLjuXxDVOlLq4nSLiv2yabsSw4=
=FdEM
-----END PGP SIGNATURE-----

--6H5iQYhV4nbLml5a--
