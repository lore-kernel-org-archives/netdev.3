Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793095086;
	b=s3XaJt9dZKhi1Gq8+/FKyr5FNv3HXU4vzqGy5EzAUsbNilFATXYWY5qsL63MAxttCo9R
	 hpnp1YsAJT6NR10gDIiMzjb+IXWsg7vmgDHDf32veVGnW/+SzZVZEPo4bG3Y7NNmIbw64
	 aOHImhyA+jy7sX/wPMAEu6kJXqwjE+pFDsdTbQ0IefQ8CFCrMvSZlKGBuzNs4ZOKRnj+V
	 o4d8gSOQZsKGoYhZFh/KQJO6ZrmNrIUtHcit4MjyJkZRvfbOc4Q5JkxWCXXOdJjlqBOmy
	 yuZawbfaGHsnhcs+zoVAWZYyPt0PD0o7M2T/WE73lTYXB2dLeF0g+706g5CjQxG4GaA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793095086;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=1VJL2AW5tEYY+m1I9bXvobzMC6WHbBSBecMUivpnRRA=;
	b=QJWK9T8Ty0iRaW3tRnBfkmqqzR3MmkytVWqbG8p24phx0gJW8I+d8G4a8CcatVoZo46+
	 TWjZS5H46cP521GsOHdEOJvkRnqcQL1JjNai0dH/qFKdj2DQ9HXw4k6Syz72ubOAM/voo
	 YejHK8p15aVWN09sTtN10bVwbdBtYWwhGdzmzMkS+sCdF83j6HjXVqAC1pbi+I3yWZy74
	 7rmAPfMQFLcoGpHvu+Ky2MaDUi4VSwL3eywT3MWRYPaShOmpvzNkg449IG7ColEKlauoR
	 BGUuwEQtY0uIZ7xXh8VfJf+RRu4fugMf7zsAJ7utcgnajBAk+9sWZVInXych9Jut3/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ePxgzWzH;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=gsHZVFxp;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89BF7606A31B
	for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 09:58:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 89BF7606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ePxgzWzH;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=gsHZVFxp
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69R8gRxE168797
	for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 09:58:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=1VJL2AW5tEYY+m1I9bXvobzM
	C6WHbBSBecMUivpnRRA=; b=ePxgzWzHzVG/nr5f+N0120PhARbZZVo63Gbfw4YA
	C6CRZZV7ql7Dc7I2rlH07USA8wIAwGL2EIVDiuCjrNLocNMtxe/4sHv1mZc4oOwu
	f9QRLnUp0F1dmeGMvOnXhQjnM29QO9YEHZgmBdUn3PXo7NjoHgse4Nl713r4zFA1
	eCFsURzP566XTnJ/S5l5pg28Xchs1onSpgR4BLmE3SJCMnX2H4wryyPRXvHkcrOd
	uaD1zvC/VEpbcRX5Lvvf8K8o8EXnJ78kQnTFMGcIg0H9OgzEVfbxY0H5vRa/ZYNE
	ujyEHNjWtNTDK2ebrvrGN6nrxVAAwPI6Cm6TuF8Xld3SmQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hjb54k6ss-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 09:58:04 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-9308eafb465so921821085a.2
        for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 02:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793095083; x=1793699883; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1VJL2AW5tEYY+m1I9bXvobzMC6WHbBSBecMUivpnRRA=;
        b=gsHZVFxp5Ky1sS3kCcjTsHELx8vnGLn+xM6hwvns47ScXY/l5Vfxlnm1jti41xBb/x
         I4xESvzJqfXrucKZtAb/wPegNbSe6a2tkBkjl158POn1wrUiKJsDR2yu95ONIGgDaZ+M
         jINH+ymmk18K+9LSJ8T/sLqGTQY+HOPQ0Sm4IRJMAMRDJKC5/RuftmGEozUJC1nteFtm
         FzpLt3Ow431ed4V6wp0LkcpAKaHT4DZb8+hpwFfj+YFAhCMlkHnxxBebwdw2XtHoupoR
         H6Is6uIobX07D9RtGY4jBCElWsnafhGD9YFZ+5/SqHHh6WETijeDCkgzCWq7OLfM26Hh
         cC5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793095083; x=1793699883;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1VJL2AW5tEYY+m1I9bXvobzMC6WHbBSBecMUivpnRRA=;
        b=nL0Rj2/EvhvWyDyV5D5mbXsCz0g630gVN7bUXAysgSxTL+6XZxfbgPZWmZlgEgFbmh
         Ib4gzbFj6DV8YEuYa+p89ewtmo9olEDAFpECJiZkEXM+cbbO6l7+wWOCn5LYOXcxgN8M
         /PwahHmhgOd/rrlUp2GtnRuHHbR/cPPoyEuEU6QWjOAg/dy134sFVYuapBZJrgxzPiid
         HZj0HFSnV664WwF+iKjFTyquRyXieJVqR5s15nPplGEc/0IDfpeyC0BcuPJCC5bHKszO
         UvEjTFCuC7bEZ4kAHh+xpJsB3p677hbBo3qBIlbplQ/l7yZNiADXjoinjGDYtCWWFsnF
         yg/A==
X-Forwarded-Encrypted: i=1; AKwUvByp1QcnrrK8mtYePI0snbQphHTFahECDGYBqmDBFLiJkJsk4be3ci57b22UQ7ddzl1GfOhdn6g=@vger.kernel.org
X-Gm-Message-State: AFq9FYITWK3ujG3KfuK6q6ulW/3UoxSu8CkliNEJFcqw5WYY5HWWF3do
	c+Fz30WbCKXLyOshV4wMNr7bJPLeaCeNU73mArm5tdY+TQzOi4MIOF9FVsXMKxXv0g2n7/l7wsG
	0aK3Tk7DrivOnDzdo4DVLWZA/XosHtwEHEXuuCkj/vqRJmVu8ee9Sw2hgR54=
X-Gm-Gg: AYBFou33Jt2jsuuU820SY4wuGtL1mn853svy2igTT3DQ1HH2TFUmQlhMSJCkQ8nwiCt
	6F9EmiwH5WjsBEYoAy2oAo7SFIxYinUO3tvnpK5knbGYNyxGu5iueAyiTPATkRwySONoKYK1Pii
	2vknZUJdFWmVm0KNtDfYKc+Vkk2Z4m+UWM+zWEDFj9s0yPrlY9qBiDYEHnH8psd1fOeP4UJL6f8
	SBXcLc+CEL75SSv7YdPOujBBQZtW89zEIF2smoh7rsLncABiwiFh8O2LoD0yecqb+EMI+BnVx2x
	8yEu91V+5fAne6IQbSaNNtYIBNjYxtwVYVP5XmfDaXR9xTlKWtMcoZ1BZAbPo81tNEXoFXIs8VJ
	1/yq5qkWzGYIVAMChrSnXjCOKQbV8nLszqC2nwM8kJCvYEkJ3
X-Received: by 2002:a05:620a:178d:b0:93e:9171:b83 with SMTP id af79cd13be357-940ef8f06b1mr1489271585a.43.1793095083274;
        Tue, 27 Oct 2026 02:58:03 -0700 (PDT)
X-Received: by 2002:a05:620a:178d:b0:93e:9171:b83 with SMTP id af79cd13be357-940ef8f06b1mr1489267385a.43.1793095082599;
        Tue, 27 Oct 2026 02:58:02 -0700 (PDT)
Received: from localhost (net-93-144-6-81.cust.dsl.teletu.it. [93.144.6.81])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a359f3e00asm441911695e9.0.2026.10.27.02.58.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 02:58:01 -0700 (PDT)
Date: Tue, 27 Oct 2026 10:58:00 +0100
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
Subject: Re: [PATCH net 1/6] net: stmmac: take ownership of saved RX state at
 poll entry
Message-ID: <auB1qL6FE7-vTMOB@lore-desk>
References: <20261023-stmmac-xdp-fixes-v1-1-efb37e19f5bd@oss.qualcomm.com>
 <179309225078.3134.4254254722485703329@kernel.org>
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
	protocol="application/pgp-signature"; boundary="4GXi3iNJ7oQknk1+"
Content-Disposition: inline
In-Reply-To: <179309225078.3134.4254254722485703329@kernel.org>
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDAzOSBTYWx0ZWRfX8XzkAASBripR
 ++uCO9kpQe25xtlG5msOzOipIe2HWoVW1VXINkc/jVTsFdLCRbGgLpy0P+8rBqzzGBI/H/IU21W
 G9yvu2Pm1VJSHdg9KntnzQpIgsKanxo=
X-Authority-Analysis: v=2.4 cv=bsnZl0ai c=1 sm=1 tr=0 ts=6ae075ac cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=7fYLNvKHbgS61GKHX+yayQ==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=9R54UkLUAAAA:8
 a=EUspDBNiAAAA:8 a=rhP4PL_XV0zjteUE_lwA:9 a=QEXdDO2ut3YA:10
 a=NadisKNWRbbon45ccpAA:9 a=bTQJ7kPSJx9SKPbeHEYW:22 a=YTcpBFlVQWkNscrzJ_Dz:22
X-Proofpoint-ORIG-GUID: Y9P5BsIV-OTc7Ora9yMmPY7JpJCLf9ku
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDAzOSBTYWx0ZWRfX0jnoRVKOns6i
 HtBdwVSBNCUXIGX1oayVhYhjBqLzcvF96RdDqfyUfqbEBOAR/CbPNLAqOqchYSNNDp2WtsJb0wI
 6NGu/piEqkE7013Pze9c7Usx3hDts8RjkFoKjHKrDBsg4MM1ut6U6l6A+BtPSm9FA5UCWPBmDVh
 iyaym+4yt5fPcw/cMnL0SV4L5hruxwGqiLEopa4BYrKtEHge+Tz9chE8Fp4zhqsqHtAwAwJitp8
 gTHS0zAAKAJXV5lpjoIGTlYy4mSA5Q6055Zzk7H5spOFyFRc3c7pJIyJICrKJh5J/LSZtjCYopB
 8+DiLplPZdhphxFJnDEI/jIdApz8gGlt1EqCQvHFkjoHyuE5Yq9EGLR3cw6bLfLCJVMpR/TxTG9
 taKTC2y0mOqK2rIgmXLwmWCT4jdBJIF8ap/FeH/HWTxxSJ58NWvRBxsufYXrlb5P4KrkULO2pZL
 7BEPUbgcreyEMQJ7PsA==
X-Proofpoint-GUID: Y9P5BsIV-OTc7Ora9yMmPY7JpJCLf9ku
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 spamscore=0 malwarescore=0
 lowpriorityscore=0 clxscore=1015 phishscore=0 suspectscore=0 adultscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610270039

--4GXi3iNJ7oQknk1+
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider.
>=20
> Critical: 0 =C2=B7 High: 1 =C2=B7 Medium: 0 (1) =C2=B7 Low: 0
>=20
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
>=20
> - [High] The commit message says that on resume a saved partial frame
>   would be resumed "with descriptors from the freshly initialized ring",=
=E2=80=A6
>=20
> Pre-existing issues:
> - [Medium] In stmmac_rx()
>   (drivers/net/ethernet/stmicro/stmmac/stmmac_main.c), the=E2=80=A6
>=20
> --
>=20
> net: stmmac: take ownership of saved RX state at poll entry
>=20
> The saved partial-frame RX state is now taken and cleared at the start of
> stmmac_rx() and stmmac_rx_zc(). It is saved again only if the frame is
> still incomplete when the poll ends. The saved skb is also dropped in
> stmmac_reset_rx_queue() and __free_dma_rx_desc_resources().
>=20
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/driver=
s/net/ethernet/stmicro/stmmac/stmmac_main.c
> > index b20e5038eeadd..fba21599a5e15 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
>=20
> [ ... ]
>=20
> > @@ -6032,10 +6042,8 @@ static int stmmac_rx(struct stmmac_priv *priv, i=
nt limit, u32 queue)
> >  		/* Remove FCS if needed */
> >  		if (!fcs_stripped && pskb_trim(skb, len)) {
> >  			dev_kfree_skb_any(skb);
> > -			skb =3D NULL;
> >  			rx_dropped++;
> > -			count++;
> > -			continue;
> > +			goto next;
> >  		}
>=20
> [Severity: Medium]
> This isn't a bug introduced by this patch, but can a multi-descriptor
> frame reach the stack as a truncated fragment when napi_build_skb() fails
> on a descriptor that is not the last one?

This issue has not been introduced in this patch and it needs to be fixed w=
ith
a dedicated patch.

>=20
> The allocation failure path in stmmac_rx() does not set error:
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
>=20
> When status & rx_not_ls is set, drain_data jumps back to read_again. At
> that point skb =3D=3D NULL and error =3D=3D 0, and len still holds the by=
tes of
> the dropped prefix.
>=20
> With no XDP program attached, stmmac_xdp_run_prog() returns NULL. The next
> descriptor of the same frame then builds a new skb from a mid-frame
> buffer.
>=20
> On the last descriptor, len still includes the dropped prefix. So
> pskb_trim() does nothing, because len is not smaller than skb->len:
>=20
> 	return (len < skb->len) ? __pskb_trim(skb, len) : 0;
>=20
> Wouldn't that pass a mid-payload fragment, with its FCS still attached,
> to napi_gro_receive()? Its ip_summed would come from the status of the
> whole frame, and rx_bytes would be counted with the full-frame len.
>=20
> The same thing seems to happen across a poll boundary. In that case
> in_progress saves skb =3D=3D NULL, error =3D=3D 0 and len.
>=20
> The old status & rx_not_ls save condition behaved the same way. Later in
> the series, "net: stmmac: drop multi-buffer frames in XDP mode" sets
> error for rx_not_ls when XDP is enabled. The non-XDP path is unchanged.
>=20
> [ ... ]
>=20
> > @@ -8412,6 +8421,9 @@ static void stmmac_reset_rx_queue(struct stmmac_p=
riv *priv, u32 queue)
> >  {
> >  	struct stmmac_rx_queue *rx_q =3D &priv->dma_conf.rx_queue[queue];
> > =20
> > +	dev_kfree_skb_any(rx_q->state.skb);
> > +	rx_q->state.skb =3D NULL;
> > +	rx_q->state_saved =3D false;
> >  	rx_q->cur_rx =3D 0;
> >  	rx_q->dirty_rx =3D 0;
> >  }
>=20
> [Severity: High]
> The commit message says that without this drain, a partial frame saved
> before suspend would be resumed "with descriptors from the freshly
> initialized ring". Is the ring actually freshly initialized on the
> stmmac_resume() path?
>=20
> stmmac_resume() does:
>=20
> 	stmmac_reset_queues_param(priv);
>=20
> 	stmmac_free_tx_skbufs(priv);
> 	stmmac_clear_descriptors(priv, &priv->dma_conf);
>=20
> 	ret =3D stmmac_hw_setup(ndev);
>=20
> stmmac_clear_rx_descriptors() calls stmmac_init_rx_desc() on every RX
> descriptor, and that only sets ownership bits:
>=20
> - dwmac4_rd_init_rx_desc() and dwxgmac2_init_rx_desc() OR OWN|BUF1V into
>   des3.
> - enh_desc_init_rx_desc() and ndesc_init_rx_desc() OR RDES0_OWN into
>   des0.
>=20
> Buffer addresses are never reprogrammed and empty slots are not refilled.
> stmmac_init_dma_engine() then sets the RX tail pointer to buf_alloc_num,
> which gives every descriptor back to the DMA.
>=20
> Suppose page_pool_alloc_pages() failed in stmmac_rx_refill() for the
> slots used by the saved partial frame. The loop then breaks before
> stmmac_set_desc_addr():
>=20
> 	if (!buf->page) {
> 		buf->page =3D page_pool_alloc_pages(rx_q->page_pool, gfp);
> 		if (!buf->page)
> 			break;
> 	}
>=20
> Those descriptors keep the DMA addresses of pages that state.skb now
> owns, and buf->page =3D=3D NULL.
>=20
> With this change, stmmac_reset_rx_queue() returns those pages to the
> page_pool through dev_kfree_skb_any(). The same descriptors are then
> re-armed and the DMA is restarted.
>=20
> Can the device then DMA into pages that have already been recycled or
> freed?
>=20
> There is a separate problem on dwmac4 and xgmac. A descriptor that was
> written back but not refilled before suspend still holds write-back data
> in des0/des1. For example, dwmac4_wrback_get_rx_vlan_tci() reads the VLAN
> tag from des0. Re-arming that descriptor would make the DMA treat the
> write-back data as a buffer address.
>=20
> The re-arm-without-refill behaviour predates this patch: an earlier
> upstream re-init on resume was reverted. Before this patch, the stale skb
> would also have been completed and freed on the first poll after resume,
> while those descriptors were still armed. So this change frees the pages
> earlier rather than creating the problem.
>=20
> Since the resume handling depends on the ring being freshly initialized,
> should the commit message be corrected? And should the resume path refill
> and reprogram the RX descriptors before the DMA is restarted?

I will rework the commit message in v2 but the reported issue has not been
introduced by this patch and it needs to be fixed with a dedicated patch.

Regards,
Lorenzo

>=20
> --=20
> Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#/patch=
set/20261023-stmmac-xdp-fixes-v1-0-efb37e19f5bd%40oss.qualcomm.com

--4GXi3iNJ7oQknk1+
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCauB1qAAKCRA6cBh0uS2t
rDzOAQDNEQEZb+doM2iGYJUGbk3wZTR1pCww4pSuhScfzs8jlgD/SXvg0KYcSAG/
5cZMIL8eDEQYqSVsmD7+0Dudt/kZ4QU=
=3GMY
-----END PGP SIGNATURE-----

--4GXi3iNJ7oQknk1+--
