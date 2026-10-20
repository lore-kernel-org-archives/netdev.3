Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792503159;
	b=ARae9sYK60kHARnAyLKxh7jP93Wuu9fRK9xTitLn+gbxCJYbzxgU53cZ6HCmpSb3WXzs
	 CPdqKYCCejiPu4vBALrOeJDBNkXjUyvIPIhQYAD7KQGX4JGZr9Y1r1XEMyqQ7I5/KApQz
	 W6iyOFz/vFXdM5gdiwR80rOs4yklJbZu2lXBUIJC6HFG2gbPF12/sX3B+kSKeKOlhHAOm
	 YThm5v2cYoiudVYyJ/I7Lz/t5Zv0uY3f09WZyXD+XNtUCrtTU3mwkH1QFAjGCXAYxqh6h
	 D7vO5EbXmYFwtTC8u6FZhOPSJ2oM39s9Z2rMH1jqaPpC0L9NYhCfqGvdz+VtIZsEMIw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792503159;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=9rYgdYA07tDFKT0QV8zsUnpaX9mBg/UUlKx4RXntknU=;
	b=wblsB/8A0Mx8bO03m2Bf8r0nB9B2fJaz3TpSfFbja9oLZbTbPEzOKAc3Ub1dVRw4jnIC
	 AdQ2E+6oLUmUBGSOHlSGGCouZLdOuCfd6Xk3qgsIvsBAncGnQSvDUqZO9hHkFQyFemgy8
	 E0+bSVEXwR7NiLIIcIF1xXo1G+xEn62WuHA0K2uW0YBcwQGs3WaZBayeRr56x4r/xiP0X
	 kSEnc6cdgO9zko9Q/O0KBWfPGc7S0NodfgjNVkkxd0wwUsRTwilsGIV45wHA1wpXQR/d+
	 S76kRNTz6umbBYEJHqyBjsxIsYKLOCiTIQk7+wYAVixTW/Yu+ZYDcBT5pFL5D84D73A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b="epr/s/Cd";
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=j12WkUqC;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8B87606A319
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 13:32:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D8B87606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=epr/s/Cd;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=j12WkUqC
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69KDAEwN702654
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 13:32:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=9rYgdYA07tDFKT0QV8zsUnpa
	X9mBg/UUlKx4RXntknU=; b=epr/s/Cds/ILc886vHtBe9bGm2yyAq3CisHeyjlZ
	4/7HMFkuDOzCYcNT4+Vdww5koRjHpJT/s+JVT0SVVt5vCEbAqn7+/OHucr/hCCol
	DgXv5te+YS94PBEOC/w4ggu+zubdYXw0VwJNj46uZkpDs7RLqsQAKcg6JctOBviC
	zrBER8zadEEV8oR71XHTdF33g0UM7Q2ZfFjO+kn5NN3AKE7GA/gpDY84/+h0fswZ
	jZgbFmJOuqmK4yIOX5WZE/wN+xhxYHaNl5UrJXeshZUN2JT94cWmc68GmWz56ErB
	f8Vt0BgjPm9E+3abBPkuNwzi6KTD+9BQluvYdyIcCEQLEw==
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com [209.85.222.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdw5stmf1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 13:32:37 +0000 (GMT)
Received: by mail-ua1-f70.google.com with SMTP id a1e0cc1a2514c-9806e283b0eso2565105241.3
        for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 06:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792503157; x=1793107957; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9rYgdYA07tDFKT0QV8zsUnpaX9mBg/UUlKx4RXntknU=;
        b=j12WkUqCLzzcvX0XXA8n9cXrzAwhP/H8ISzjN9YjIqzBLyCNURBNc6zMqLH7OKdHKQ
         zAKNkn9Av0q5MfHX2VX1S9PvrrBqliWKe1j/32sd4H3kCGqwkvfPOqFCvL6FwN6mPJsS
         62fRcDYvbmM8aenzn3WuVv2Ow/AC+9nH8hvePMWxoSHWvb3O5+MDbLw5Xl/W7REr8ARl
         cg7uGT46XrKl9+uEpPCap+54zugUV0CtCAcgfl186EhEYr6YWwJnijfy8a3fBYihvLZV
         3hElqLE78oJcPGJJqj+N2mWSTGkPwDz0/Vn/cvd914dphwKOkkaviVrZf/S7oWF2ppy+
         8ZnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792503157; x=1793107957;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9rYgdYA07tDFKT0QV8zsUnpaX9mBg/UUlKx4RXntknU=;
        b=zdpVEpnxgHKT13BXih05PbVSw5K2z2YsgKstPiXM3w0PtGZlnCHMpXtdca+4PnyJi2
         Emd00WCLt/4xNgszJ46adC8De7WXFZJcl3+CadQkeGUMnvdM4oez7TlZGtSXWflu5BAP
         jNsgr1VAeRJ3uit1AETrU7j0u7iV3MiFq8Lgj+yK4xmRbNtd2IcQ33uXGuG/wttKfAjq
         DXxmbD1GuNSDdffa6Qjlgop1gon43Rz/Zf9sunOEDLKtwKHM36P+KHXAImAb2n8u5k7f
         86QtVydG0/rdmhzrMi2/UE+j74BNxOQdgyMvh66STciX2TcMQZ4V+4NhVXMpjqLHVKEy
         Y7Tw==
X-Forwarded-Encrypted: i=1; AKwUvBwatUwG8HZFhE9GlsiiJreSl9cbTQoDWcUE8gkNbOgGd7vQUUOXMlubGCBov9Wn0MEiRMK8i5c=@vger.kernel.org
X-Gm-Message-State: AFq9FYJyKscm/o8q6dVkZdZbf0DKYAPMfefuXep6+5PfKgbNe+vKSEUf
	zJEU5V+8f5mH9AM+3q6CgatuCakmpKgZHeJbwnXO80CUjxUxIXcpXdFoVztSXdnX0MgYEMoOPfa
	U9QU2CU+LUHPp4RqTFCVbUUbJij+L/QEKXz5SxNseAdowB8Okw4XmGKbS2oc=
X-Gm-Gg: AYBFou0Br+2Yl+56CMy97mWks87F4H7LxdGWdI2WfLZsVyWMDoitqZSQ5RoO8Bo4jTY
	RYyOiIiDKmaBwZqeV/1GYn98f/HOKoOh59zarC4d9CmbODdiAuCxBKPWvVKhme4AUAYQlDN8fq+
	wpETuEbzqVMI4ABYBtC12N7vUhF9i3PYqxrmRxpzdcv5xnk4m3ggpFnlDOR0HifSLW1id4JpBvN
	UmcMBe5O9cSWj9xOpExs8VNaLpErVVYiCmlSvKwowedjP2EPXOe98UaIo1ZJHlpQZP5tugOE844
	do4OnV85Dd5/HxLfVZMJ2JaLtCJMgok9uaafIc4+9DCtHV9ts1NCbqDv1MsiedAvncFpbzFcKsG
	mx7ar9YcQTGUAQg==
X-Received: by 2002:a05:6102:509f:b0:7c0:cdd9:31c1 with SMTP id ada2fe7eead31-7cc3691e07emr3385064137.12.1792503156823;
        Tue, 20 Oct 2026 06:32:36 -0700 (PDT)
X-Received: by 2002:a05:6102:509f:b0:7c0:cdd9:31c1 with SMTP id ada2fe7eead31-7cc3691e07emr3385044137.12.1792503155962;
        Tue, 20 Oct 2026 06:32:35 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1f2ca3666sm75084605e9.1.2026.10.20.06.32.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 06:32:33 -0700 (PDT)
Date: Tue, 20 Oct 2026 15:32:33 +0200
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
To: netdev-bot+sashiko@kernel.org
Cc: maxime.chevallier@bootlin.com, andrew+netdev@lunn.ch, davem@davemloft.net,
        edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
        ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
        john.fastabend@gmail.com, sdf@fomichev.me, Jose.Abreu@synopsys.com,
        boon.leong.ong@intel.com, netdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org
Subject: Re: [PATCH net-next v8 5/5] net: stmmac: rework stmmac_rx to support
 XDP rx multi-buff
Message-ID: <atdtcD1o6N--LRpl@lore-desk>
References: <20261018-stmmac-rx-mb-v8-5-5f58c0b25849@oss.qualcomm.com>
 <179243152020.3135.588086716583719127@kernel.org>
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
	protocol="application/pgp-signature"; boundary="lJZGZmpUiB07xMUc"
Content-Disposition: inline
In-Reply-To: <179243152020.3135.588086716583719127@kernel.org>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIwMDA1MyBTYWx0ZWRfXyx2GnP9nXRNS
 NqRdyB1FpNoUWWbIH7oX1bC5TvITt7yLfMHPwfcEM7ekl0FwpcjRHt5CS05pODWMmYYYT0vcg0L
 nxk5BpmdjSvhl1ySg54FHqLVbZ/b6vowO/jZ1oKnQfMic/L45jqq8LIAMlsJH6uOYMPoVwD6meV
 ahR05/R11MqXu/lDf6Bri6DiuFuf2jnx9GY7mdaQetOWtnj3fUDidKfeS94Sx4SZ26BBbUz+fdI
 nU7AAoxCAoABF7f1yQdh1ivOhSsAEpBxmfYhRet21KmJ2/MrNRqfaZoYyIkOdXLG5a7s9PrafKX
 3AcMjC+C/EoYgEoOiCZ0iiIIkWkJMyFsPdrrcIJ/4hRpN/7IwCE3ZAe4yScX9+beaK1eC2A8MdU
 Ntn1fqTLqLF2T3RuHgLzCNLh/XT+pdjb9igAcQv+dzsQip0F036RZmclrhC8VCqjiDGiiIuPr3U
 Fqb23PCw/6IFYoLiz1A==
X-Authority-Analysis: v=2.4 cv=fIusTpae c=1 sm=1 tr=0 ts=6ad76d75 cx=c_pps
 a=R6oCqFB+Yf/t2GF8e0/dFg==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=9R54UkLUAAAA:8
 a=EUspDBNiAAAA:8 a=AAtxJrX6kwZzT1o8YZAA:9 a=QEXdDO2ut3YA:10
 a=gBTJZmOXgchuYORFWpUA:9 a=TD8TdBvy0hsOASGTdmB-:22 a=YTcpBFlVQWkNscrzJ_Dz:22
X-Proofpoint-GUID: 0CPvvc_pLv9P_xS32o7i9YnYjKarycTc
X-Proofpoint-ORIG-GUID: 0CPvvc_pLv9P_xS32o7i9YnYjKarycTc
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIwMDA1MyBTYWx0ZWRfX8QtxzkLqKcwn
 h1kM5m330C9dgPEzl6xRDun04DMo/QO7UARniWe7tPrNEOy6a+8ooTBVEhZ1VWUtHMoOA9WhC2X
 qs0ehikQ0FymYnS59c3YdAc7fKYowt8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-20_02,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 spamscore=0 malwarescore=0 suspectscore=0
 clxscore=1015 priorityscore=1501 adultscore=0 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610200053

--lJZGZmpUiB07xMUc
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Thank you for your contribution! Sashiko AI review found 3 potential
> issue(s) to consider.
>=20
> Critical: 0 =C2=B7 High: 0 (1) =C2=B7 Medium: 2 (1) =C2=B7 Low: 1
>=20
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
>=20
> - [Medium] The patch fixes a DMA under-sync on the XDP drop path but does
>   not say so.
> - [Medium] Fragment truesize is undercounted when num_pages is not a
>   power of two.
> - [Low] The patch advertises NETDEV_XDP_ACT_RX_SG (line 8189) and now
>   runs frags-aware programs on multi-buffer xdp_buffs=E2=80=A6
>=20
> Pre-existing issues:
> - [High] XDP_TX completions are recycled into the RX page_pool's lockless
>   alloc cache from a different NAPI context.
> - [Medium] The AF_XDP zero-copy XDP_PASS path reports XDP metadata whose
>   bytes it never copies.
>=20
> --
>=20
> net: stmmac: rework stmmac_rx to support XDP rx multi-buff
>=20
> This reworks stmmac_rx() to collect every descriptor of a frame in an
> xdp_buff, so the XDP program runs on the whole frame, including any
> fragments. The skb is then built from the xdp_buff with napi_build_skb()
> and xdp_update_skb_frags_info(). The in-progress xdp_buff is saved in
> rx_q->state across NAPI polls, and NETDEV_XDP_ACT_RX_SG is advertised.
>=20
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/driver=
s/net/ethernet/stmicro/stmmac/stmmac_main.c
> > index 04dc6dcaa435d..e9c61524fc740 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
>=20
> [ ... ]
>=20
> > @@ -5806,6 +5812,119 @@ static int stmmac_rx_zc(struct stmmac_priv *pri=
v, int limit, u32 queue)
>=20
> [ ... ]
>=20
> > +static struct sk_buff *stmmac_build_skb(struct xdp_buff *xdp)
> > +{
> > +	struct skb_shared_info *sinfo =3D xdp_get_shared_info_from_buff(xdp);
> > +	u32 metasize =3D xdp->data - xdp->data_meta;
>=20
> [ ... ]
>=20
> > +	skb_mark_for_recycle(skb);
> > +	skb_reserve(skb, xdp->data - xdp->data_hard_start);
> > +	skb_put(skb, xdp->data_end - xdp->data);
> > +	if (metasize)
> > +		skb_metadata_set(skb, metasize);
>=20
> [Severity: Medium]
> This isn't a bug introduced by this patch. Now that the page_pool path
> keeps the metadata, though, the AF_XDP zero-copy XDP_PASS path no longer
> matches it. Does stmmac_construct_skb_zc() pass stale headroom bytes to
> TC/BPF as metadata?

Since this issue has not been introduced by this patch I guess we can fix it
with a dedicated patch.
>=20
> stmmac_construct_skb_zc() {
>     ...
> 	skb_reserve(skb, xdp->data - xdp->data_hard_start);
> 	memcpy(__skb_put(skb, datasize), xdp->data, datasize);
> 	if (metasize)
> 		skb_metadata_set(skb, metasize);
>     ...
> }
>=20
> Only [data, data_end) is copied into the new skb, but the metasize bytes
> in front of skb->data are still marked as metadata. A TC/BPF program that
> reads data_meta on frames from stmmac_rx_zc()->stmmac_dispatch_skb_zc()
> would see leftover bytes from the napi_alloc_skb() headroom instead of
> what the XDP program wrote.
>=20
> Other zero-copy drivers copy metasize + datasize bytes starting at
> xdp->data_meta and then call __skb_pull(skb, metasize). Would the same
> approach work here?
>=20
> > +
> > +	if (unlikely(xdp_buff_has_frags(xdp)))
> > +		xdp_update_skb_frags_info(skb, num_frags, sinfo->xdp_frags_size,
> > +					  sinfo->xdp_frags_truesize,
> > +					  xdp_buff_get_skb_flags(xdp));
> > +	return skb;
> > +}
> > +
> > +static bool stmmac_build_xdp_frags(struct stmmac_priv *priv,
> > +				   struct stmmac_rx_queue *rx_q,
> > +				   unsigned int len, struct page *page,
> > +				   unsigned int offset,
> > +				   enum dma_data_direction dma_dir,
> > +				   struct xdp_buff *xdp)
> > +{
> > +	dma_addr_t dma_addr =3D page_pool_get_dma_addr(page) + offset;
> > +
> > +	dma_sync_single_for_cpu(priv->device, dma_addr, len, dma_dir);
> > +	if (!xdp_buff_add_frag(xdp, page_to_netmem(page), offset, len,
> > +			       xdp->frame_sz)) {
>=20
> [Severity: Medium]
> The commit message says:
>=20
>   charge fragments the whole page_pool page size (xdp->frame_sz) as
>   truesize instead of the old dma_buf_sz
>=20
> Is xdp->frame_sz the page_pool page size in every configuration?
>=20
> frame_sz comes from bufsz =3D rx_q->napi_skb_frag_size in stmmac_rx(). Th=
at
> value is set in __alloc_dma_rx_desc_resources():
>=20
> 	rx_q->napi_skb_frag_size =3D num_pages * PAGE_SIZE;
> 	...
> 	pp_params.order =3D order_base_2(num_pages);
>=20
> When num_pages is not a power of two, each page_pool buffer is
> PAGE_SIZE << order, which is larger than napi_skb_frag_size. Two examples
> with 4K pages and no XDP:
>=20
> - dma_buf_sz of 8KiB: num_pages =3D 3, order 2, so each 16K page is charg=
ed
>   as 12K.
> - dma_buf_sz of 16KiB: num_pages =3D 5, order 3, so each 32K page is char=
ged
>   as 20K.
>=20
> stmmac_xdp_shrink_tail() subtracts the same xdp->frame_sz. Then
> stmmac_build_skb() adds sinfo->xdp_frags_truesize to skb->truesize
> through xdp_update_skb_frags_info(). As a result, skb->truesize is lower
> than the memory the fragments actually pin.
>=20
> Could the fragment truesize use PAGE_SIZE << pp_params.order instead? Or
> could num_pages be rounded up to a power of two?

I will fix it in the next iteration.

>=20
> [ ... ]
>=20
> > @@ -5927,129 +6039,89 @@ static int stmmac_rx(struct stmmac_priv *priv,=
 int limit, u32 queue)
>=20
> [ ... ]
>=20
> > +		pre_len =3D ctx.xdp.data_end - ctx.xdp.data_hard_start;
> > +
> > +		ctx.desc =3D p;
> > +		ctx.ndesc =3D np;
> > +
> > +		skb =3D stmmac_xdp_run_prog(priv, &ctx.xdp);
> > +		/* Due xdp_adjust_tail: DMA sync for_device
> > +		 * cover max len CPU touch
> > +		 */
> > +		sync_len =3D ctx.xdp.data_end - ctx.xdp.data_hard_start;
> > +		sync_len =3D max(sync_len, pre_len);
>=20
> [Severity: Medium]
> The old pre_len and sync_len subtracted buf->page_offset:
>=20
> 	sync_len =3D ctx.xdp.data_end - ctx.xdp.data_hard_start -
> 		   buf->page_offset;
>=20
> The new ones don't. This looks like a separate DMA sync fix, and the
> commit message doesn't mention it.
>=20
> Commit 88095728511e ("net: stmmac: fix rx Scatter-Gather support") set
> pp_params.offset =3D 0, and __page_pool_dma_sync_for_device() syncs from
> dma_addr + pool->p.offset. So with the old formula, the XDP_CONSUMED path
> synced [0, L) for an L-byte frame at XDP_PACKET_HEADROOM. The bytes the
> CPU had touched were at [256, 256 + L).
>=20
> Take a non-coherent platform and an XDP program that writes the packet,
> grows the tail or writes metadata, and then returns XDP_DROP or
> XDP_ABORTED, or fails a redirect. Could that leave dirty cache lines in
> the recycled page? Those lines could later be written back over a frame
> the device has DMA'd into the page.
>=20
> The new formula looks like the correct one. Stable kernels that picked up
> 88095728511e would keep the under-sync. Could this go out as a separate
> net fix with:
>=20
> Fixes: 88095728511e ("net: stmmac: fix rx Scatter-Gather support")
>=20
> or at least be described in the commit message?

I will post a dedicated patch to fix it.

>=20
> > +
> > +		/* For Not XDP_PASS verdict */
> > +		if (IS_ERR(skb)) {
> > +			unsigned int xdp_res =3D -PTR_ERR(skb);
> > +
> > +			if (xdp_res & STMMAC_XDP_CONSUMED) {
> > +				stmmac_xdp_put_buff(rx_q, &ctx.xdp, sync_len,
> > +						    true);
> > +				rx_dropped++;
> > +			} else if (xdp_res & (STMMAC_XDP_TX |
> > +					      STMMAC_XDP_REDIRECT)) {
> > +				xdp_status |=3D xdp_res;
> > +			}
>=20
> [Severity: High]
> This is a pre-existing issue, but this patch sends fragment pages down the
> same path. Is it safe for tx_napi to recycle XDP_TX completions directly
> into this RX queue's page_pool?

Since this issue has not been introduced by this patch I guess we can fix it
with a dedicated patch.

>=20
> stmmac_tx_clean() runs from ch->tx_napi and does:
>=20
> 	if (xdpf &&
> 	    tx_q->tx_skbuff_dma[entry].buf_type =3D=3D STMMAC_TXBUF_T_XDP_TX) {
> 		xdp_return_frame_rx_napi(xdpf);
> 		tx_q->xdpf[entry] =3D NULL;
> 	}
>=20
> That call ends up here:
>=20
> xdp_return_frame_rx_napi()
>   __xdp_return(..., napi_direct=3Dtrue)
>     page_pool_put_full_netmem(pp, netmem, true)
>       page_pool_recycle_in_cache()
>         pool->alloc.cache[pool->alloc.count++] =3D netmem;
>=20
> The page_pool belongs to ch->rx_napi, which is a separate napi_struct.
> stmmac_xdp_get_tx_queue() picks the XDP_TX queue by CPU. tx_napi can also
> be scheduled on another CPU by stmmac_tx_timer() or by a per-channel TX
> MSI vector. stmmac does not set pp_params.napi, so page_pool cannot catch
> this.
>=20
> At the same time, stmmac_rx() on rx_napi uses the same alloc cache. It
> does so through stmmac_rx_refill() and through the new allow_direct=3Dtrue
> puts in stmmac_xdp_put_buff(), stmmac_build_xdp_frags() and
> stmmac_xdp_shrink_tail().
>=20
> Can these two contexts race on alloc.count and the cache slots? That
> could lose a page, or cache the same page twice so that it gets handed to
> two RX descriptors.
>=20
> With multi-buffer frames, xdp_return_frame_rx_napi() now also returns
> every fragment page with napi_direct=3Dtrue, so more pages go through this
> race.
>=20
> [ ... ]
>=20
> > @@ -8106,6 +8186,7 @@ static int __stmmac_dvr_probe(struct device *devi=
ce,
> >  	ndev->hw_features =3D NETIF_F_SG | NETIF_F_IP_CSUM | NETIF_F_IPV6_CSU=
M |
> >  			    NETIF_F_RXCSUM;
> >  	ndev->xdp_features =3D NETDEV_XDP_ACT_BASIC | NETDEV_XDP_ACT_REDIRECT=
 |
> > +			     NETDEV_XDP_ACT_RX_SG |
> >  			     NETDEV_XDP_ACT_XSK_ZEROCOPY;
>=20
> [Severity: Low]
> With NETDEV_XDP_ACT_RX_SG advertised, frags-aware programs now see
> multi-buffer frames. However, __alloc_dma_rx_desc_resources() still
> registers the rxq with:
>=20
> 	ret =3D xdp_rxq_info_reg(&rx_q->xdp_rxq, priv->dev, queue, napi_id);
>=20
> That leaves frag_size at 0, so bpf_xdp_frags_increase_tail() always
> returns early:
>=20
> 	if (!rxq->frag_size || rxq->frag_size > xdp->frame_sz)
> 		return -EOPNOTSUPP;
>=20
> Is it intended that a positive bpf_xdp_adjust_tail() on a multi-buffer
> stmmac frame always fails, even when the last fragment page has room?
> Other RX_SG drivers such as bnxt behave the same way, so this may just be
> a limitation. Would registering with __xdp_rxq_info_reg() and a real
> frag_size be worth considering?

I will fix it in the next revision.

Regards,
Lorenzo

>=20
> --=20
> Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#/patch=
set/20261018-stmmac-rx-mb-v8-0-5f58c0b25849%40oss.qualcomm.com

--lJZGZmpUiB07xMUc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCatdtcAAKCRA6cBh0uS2t
rATLAQCSvZ33CM/2uk7SiugoyWVQyTLcX4+EuDn+8YQzsGZdZwEA5TNtIM50LdiW
eMNXxEqYgA/WRnQ0sRpIoSDa8/M01QQ=
=LdD9
-----END PGP SIGNATURE-----

--lJZGZmpUiB07xMUc--
