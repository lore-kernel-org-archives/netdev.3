Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792502745;
	b=yFolAwSNNzoX0B5Ii5WpGnkz9LSkLUE/TwvD7Vccx6e56K/veijgnMTDVte3dcaTdy5+
	 J15Ytx//4exyM05tfe72Wol0mMi2H4Rv6KwdKSszeE+nbkfL1zn45YfQN86S6O3N/Qkkg
	 nN21gmSftT7AwsU9xqEXXdJfbrTbb7EnOf1lj03oKHcpjQ4xCCGb1KrJZ4wZz6v6dtxrB
	 6dp2wIsxjkfh8neJdDKINHVo9eOKNKBNtRfD9Drodgqu3u4RvhfUaNuGbP3YEMWuu0hNW
	 uLjVafkFf1pQwD1ygJ3u4zFu3soMljU1Ps8DvRDLfq9HxmZrtozCblxLwTsEFJuTGlg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792502745;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=TqphKuuzdQfZj8vC8DGTuD4kcrG3fghciLwkO9jLrUc=;
	b=lIaZ0p52PihEzlwFJlDr61ran9Y3i94ecvyLcFtUIoHIhWFH2WBF0EAMqm0WpeJWQr61
	 jRe9GGIk0vPhardUKhqiWBmEYwf62ymC84sddvkiEUrqRWc58Mhfq0z5dm1YWh6j4cPrK
	 AenINR+Laya2wB14T//8qlgIH7y1jgO+8VrRYPbIfbUTpC1hHBuIQY2fuWDQRnI0Hs6Uy
	 76DG4MD4vf8l9Sm7i8BuIN/oUh7suwMbt0oDJYVstDA+JGd1LAfuwUsNzSAq/mk+2D8DR
	 409vuDLAleiF3m767v2fnWXoSEiWPOaY1ZrI2c3VTkjigGr6zOjglwpDjt15rzfbtIA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=TZ+1xYDT;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Q6jagHkf;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B8B9606A31D
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 13:25:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1B8B9606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=TZ+1xYDT;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Q6jagHkf
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69KDA79Z1782303
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 13:25:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=TqphKuuzdQfZj8vC8DGTuD4k
	crG3fghciLwkO9jLrUc=; b=TZ+1xYDTCOweYc3NVCBnbpA4EmccBikSPN8shBC2
	VjAI1tyaEqOSGl47xUIIyarYRg7jlIl2vudoYbHxUovAvAlSsRMZCKThdeQyFx9X
	ONH/iujzpXDo7m37t5nXJ3OjX2reb8OjSRzIiQ6wrq8ReruE1osHFRdBbksDes0x
	WDQHXYQqm+/+/UcTjxit7A4hgy2OprFLb76OD+uHB8K1qkXR6Zxi3kJHN7rit+bv
	DjOi9rL1CcEbmWaaEyunuxcFMoG5oy03tGVaAM0jusEaqWartsb0LNucDwwAbOdT
	SvugRnLjVOL7Up/JBfmX7j8gUHDLHj5Av25RIHlWpbYTwA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4he7h28ccn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 13:25:44 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-93cb93c874bso129981185a.0
        for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 06:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792502743; x=1793107543; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=TqphKuuzdQfZj8vC8DGTuD4kcrG3fghciLwkO9jLrUc=;
        b=Q6jagHkfkxsIACtjtGRotLMqYoKxBfoKMxc/a/jZiqSHZw5S7cWB6RjZjFz0X2GPMU
         8cM4+gF1oQycZIIiWf8VYipv/tcEhQo5K8WHCN+1l65SaRR5zze4kH5P+4COxsEB8WbN
         TIO8lKHm+xVNa8g3Va+2iuKlvaB7sQEOjVmsRfjmiKrlPN5Q6FUF0zh6V83rcsBQqV1d
         G+LCvSeEXiNpJM37twQrCKOCjngUslEIZUkCwYUCLpq8Abj0HSEdEMe6RDUjEmvqujAS
         H/yxeyS+h6xSkY6ID+VhsFDVto8evlI3LTxKe2V0rMMhXYApBspxcmq7i5bTT6hy3cR4
         1A5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792502743; x=1793107543;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TqphKuuzdQfZj8vC8DGTuD4kcrG3fghciLwkO9jLrUc=;
        b=NPzgi6D4M0WT5DpWyAH6TBAnWkQpaASRLqi+uCEAnR2RiudVOmrbJp9thYT86rPlML
         gF6h9icf4iR1Du23IvztFaI9p9oqIpaUUXV6k8QQQ2pD5wwSkcu2u9V0XA21eKW3NbRc
         o5lF4s7hnP56u7GOzAeQmCzYV0ymvkuZIOpYjz6QvjsaY3ShAYAJyWonCPIMPJo+9CCn
         6t4QLU0YlCQ9IhzqQIPXLr3ck0cSVtAhHwF4DafV0SxAypIEQSG8+XPEJ1pJ2eNFduEr
         zrheZd7LAw38I+x/YxHplrzQiP0UtFuGETKSrsK63eOevZ/OpT1kUTs19vx/Owjr5gLJ
         mGhg==
X-Forwarded-Encrypted: i=1; AKwUvBw8zDjVmyEBWVu7hJiMCrQ3yzDs2Wtb708pg8c/RYTTw84fwq+RKWMtWGMLto4QGRIBVwE3hOI=@vger.kernel.org
X-Gm-Message-State: AFq9FYKAR/SOMrNMfjW1G/hopseVNdaIZMMJfUrm1ivRQ10rGFf01/4h
	3aFyAo+9uzLQZEC9VUBzdSQ0j/m/RCbutjh7pTfEfnnVdCzd8O6THMX3oi2omM5CA5UVNOF/qmm
	JvG/fppKucnRuwQ2JyCmGqZJ5e+ksqFLr7/eLOO9V06BQ6+QiWpf2IMLAku4=
X-Gm-Gg: AYBFou10mk2wNxHZKbOrfXGHzx3InDTNhvsqEUVVlwpQ+OfvCTligpx+EA3s6UNxL/z
	Be+eBAylL/d90fMbYUqTTwCULrIChUG4lVNDqd1FqaBw3vPrEsdUVG68g4dM+q5qcOeqrqTxFYZ
	ZkJF6FqrMdRiMvUQ0p8APECDm2QACRJJw1FeZ+Nci/Bjb/XcAVcmXegqPLQRPAoFT9fUWsYKhx6
	dfOYAT2zz2JlGFXx53sODn22GFRKSTWynJ5ubQqUiHM3Mxm+roYk391lof4+1bF0Czc4NTbffmN
	n8VDYZS0+o0eg0DtHd3CLdKRoIH1CTJBZYrYAK1ziNhL2FUUfSZxkRl9Ciqni0bHZP+CjCGnjyn
	F+JOpYODfEeOz6w==
X-Received: by 2002:a05:620a:294a:b0:93f:3834:31f9 with SMTP id af79cd13be357-93f4c54760amr297016685a.12.1792502742995;
        Tue, 20 Oct 2026 06:25:42 -0700 (PDT)
X-Received: by 2002:a05:620a:294a:b0:93f:3834:31f9 with SMTP id af79cd13be357-93f4c54760amr297010885a.12.1792502742352;
        Tue, 20 Oct 2026 06:25:42 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e1d82456asm6766343f8f.42.2026.10.20.06.25.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 06:25:40 -0700 (PDT)
Date: Tue, 20 Oct 2026 15:25:40 +0200
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
To: netdev-bot+sashiko@kernel.org
Cc: maxime.chevallier@bootlin.com, andrew+netdev@lunn.ch, davem@davemloft.net,
        edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
        ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
        john.fastabend@gmail.com, sdf@fomichev.me, Jose.Abreu@synopsys.com,
        boon.leong.ong@intel.com, netdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org
Subject: Re: [PATCH net-next v8 3/5] net: stmmac: drop multi-buffer frames in
 XDP mode
Message-ID: <atdr1N29Z3X0V2hR@lore-desk>
References: <20261018-stmmac-rx-mb-v8-3-5f58c0b25849@oss.qualcomm.com>
 <179243151663.3135.5003290847659035107@kernel.org>
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
	protocol="application/pgp-signature"; boundary="vxBQXxJ5vVdF3FzZ"
Content-Disposition: inline
In-Reply-To: <179243151663.3135.5003290847659035107@kernel.org>
X-Proofpoint-GUID: PAonqhyGxOjSpol-TswMZ6fBUYC1MHEh
X-Proofpoint-ORIG-GUID: PAonqhyGxOjSpol-TswMZ6fBUYC1MHEh
X-Authority-Analysis: v=2.4 cv=EuJHPicA c=1 sm=1 tr=0 ts=6ad76bd8 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=9R54UkLUAAAA:8
 a=EUspDBNiAAAA:8 a=TDT_cie5QS2Ta5137pIA:9 a=wPNLvfGTeEIA:10
 a=JLkvtGKUs3jDVbLDuzwA:9 a=IoWCM6iH3mJn3m4BftBB:22 a=YTcpBFlVQWkNscrzJ_Dz:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIwMDA1MyBTYWx0ZWRfX2uyVUrGA3YM5
 Uk17mWPJPrJgSBJH7OJC/HMV4cZs2cTifOuzSFgvaBl0wjBJVG30CzMN4rgfiaUA5u2+OCQ4Cts
 XOarombCYQPN1jvDSSEKS5rfVdWwJkI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIwMDA1MyBTYWx0ZWRfX6+J/5D8ja0Uz
 UXYOYwI5f8rtxV9vDXqoZG+cCg4dVaXXurhF2y1BqSIfKa9lQvTaB2vyUO+5hFxNw3P5meP4zR+
 U478XRladVoumDIZIyaZBiyt5t0J0UVS3+fFbhRQYdtsmTnYCj95A0MDRloCMAh80AVQNPKggu6
 Zd8rhJmxFTfJ0nGHhBadzbZ+V50mowylAzO6S0aiVJU+aVf81pALrqxVQQ02psez3SI1DxTokj3
 1W1Q87RrBaLOJdQQooof37GeI6EF18INv1oAiNUmzLmP/SwLB9ZdPxCqyU/ZW1zSBsbjgARxShS
 5qiTIbnPwE8VAwP6uFTGEAImOun9XZMdsSZxpE3nMF+/zlc42NMOvGHSmLT5tBzSosNO7avhZJh
 zNUimat1Aml3HnCEriEfDs8P3ILS8/rtZlzJgLCmAAGb3rqVnr6D0xHmVXgdJXuBS0hmJ0P1SYV
 heVrUORIJGOH8esCOfg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-20_02,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 clxscore=1015 spamscore=0 adultscore=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610200053

--vxBQXxJ5vVdF3FzZ
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Thank you for your contribution! Sashiko AI review found more severe
> issue(s) in other patches of this series. This mail is only an FYI, in ca=
se
> you want to address the nit picks below when you respin.
>=20
> Low priority / nit picks for your consideration:
>=20
> - [Low] The commit message does not describe what the patch actually
>   does, and it hides changes to the non-XDP RX path.
>=20
> --
>=20
> net: stmmac: drop multi-buffer frames in XDP mode
>=20
> When an XDP program is attached, stmmac_rx() now drops any frame that
> spans more than one descriptor, or that uses the second buffer of a
> descriptor. This prevents the XDP program from running on partial
> frames. Both XDP_CONSUMED and XDP_TX/XDP_REDIRECT now finish the packet
> via next instead of re-parsing the following descriptor.
>=20
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/driver=
s/net/ethernet/stmicro/stmmac/stmmac_main.c
> > index efa88cd359dac..e929cc0f23125 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > @@ -5888,18 +5888,23 @@ static int stmmac_rx(struct stmmac_priv *priv, =
int limit, u32 queue)
> >  		if (priv->extend_desc)
> >  			stmmac_rx_extended_status(priv, &priv->xstats, rx_q->dma_erx + entr=
y);
> > =20
> > -		if (unlikely(status & discard_frame)) {
> > -			page_pool_put_page(rx_q->page_pool, buf->page, 0, true);
> > -			buf->page =3D NULL;
> > +		if (unlikely(!error && (status & discard_frame))) {
> >  			error =3D 1;
> >  			if (!priv->hwts_rx_en)
> >  				rx_errors++;
> >  		}
>=20
> [Severity: Low]
> The commit message says the patch will:
>=20
>   "mark it as errored as soon as a non-last descriptor, or a descriptor
>   using its second buffer, is seen while an XDP program is attached,
>   drain and release every descriptor - including the last."
>=20
> Is this description accurate? This hunk removes the only
> page_pool_put_page() call on the error path in stmmac_rx(). After the
> patch, none of the drop paths returns a page to the page_pool. That
> covers the hardware discard_frame drop, the new XDP SG drop and the new
> buf2 drop.

I will fix it in the next iteration.

Regards,
Lorenzo

>=20
> The dropped buffers stay in rx_q->buf_pool[], and stmmac_rx_refill()
> reuses them in place because it only allocates when the slot is empty:
>=20
> stmmac_rx_refill() {
>     ...
> 		if (!buf->page) {
> 			buf->page =3D page_pool_alloc_pages(rx_q->page_pool, gfp);
>     ...
> }
>=20
> The reuse itself looks safe. All three drop checks run before any
> dma_sync_single_for_cpu() or net_prefetch() on the buffer.
>=20
> The new !error guard also changes rx_errors from once per descriptor
> carrying discard_frame to once per frame. Both changes apply whether or
> not an XDP program is attached, but the subject says "in XDP mode".
>=20
> On dwmac100/dwmac1000, the previous patch in this series makes non-last
> descriptors report discard_frame | rx_not_ls. So an errored frame
> spread over N descriptors used to add N-1 or N to rx_errors, and now
> adds 1.
>=20
> Separately, the new buf2 drop in the later hunk doesn't set error, even
> though the message says the frame is marked as errored:
>=20
> 	if (unlikely(stmmac_xdp_is_enabled(priv) && buf2_len)) {
> 		rx_dropped++;
> 		goto next;
> 	}
>=20
> It only behaves the same way because, in XDP mode, that descriptor is
> always the last one.
>=20
> This patch carries a Fixes: tag for net/stable. Could the commit message
> describe the in-place buffer reuse and the rx_errors accounting change
> for the non-XDP path? The later "net: stmmac: rework stmmac_rx to
> support XDP rx multi-buff" patch keeps both the !error guard and the
> in-place reuse, so it doesn't change the picture here.
>=20
> > -		if (unlikely(error && (status & rx_not_ls)))
> > -			goto read_again;
> > +		/* We do not support SG in XDP mode */
> > +		if (unlikely(!error && (status & rx_not_ls) &&
> > +			     stmmac_xdp_is_enabled(priv))) {
> > +			rx_dropped++;
> > +			error =3D 1;
> > +		}
>=20
> [ ... ]
>=20
> --=20
> Sashiko AI review =B7 https://netdev-ai.bots.linux.dev/sashiko/#/patchset=
/20261018-stmmac-rx-mb-v8-0-5f58c0b25849%40oss.qualcomm.com

--vxBQXxJ5vVdF3FzZ
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCatdr1AAKCRA6cBh0uS2t
rN3jAQCaiApD3+2JS+qQm+aR4BOcf3d7wVouCDJRsCQXljaJFwEAj5TJnQHUlrQ5
XvtiDdwp2G+QPXu/Ke2Mxtl5AN4IGgs=
=bcEw
-----END PGP SIGNATURE-----

--vxBQXxJ5vVdF3FzZ--
