Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792502213;
	b=p7X/08GdOXNShecTT1h4lOsM20Fo2QlUz9HhHxcI5gZ9azeMgyts/aV9lsgnG7rqDVI9
	 DWsj/7hEiHKOvkO7AoCXmkve2B+fzZD/EX6alk4G33BBS81SEfGk6EbH9BZfL+VDS8Irq
	 FgZ1/7v8+9LIxYZt4MeuwhdDWWutSa2mLo4RdVLxW6qOomDW6xhLmWcQ9b5BCPHm8R/Ek
	 WRi3k9V/Zv6hC8YTi1qjeR1dQXjyrwUZByjXVit1GI+UA0LFWzL1oizu5zHOuqsvp6y5V
	 fIb+TYZhelKukUmEMWz84V/VmcSdjrpjnH3wro9PMF/4mFzsgGbIorgf4QX32lf9VYg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792502213;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=3lr7ieTrcyple3oJEv/wP9VlYTXentXfrpGTCLa6BCU=;
	b=G2FhiepoBM6A7a6frUGqicGt6Ji6mrvCterUtPqchhRSyqjfFzIPABXKQxsU44pE6siu
	 p141cFyuLvYD6M80mfPs8nYkKmpBhjcgozYKzGXpIU+a5QV504lmArmIqtY+iDLIS1Sib
	 pNFWna4xOgHd8k0Fwbju1o0cQpYYLkWcKI/VXg1u/hqrIldXJzQ5xjLozWIvbNIutLxu2
	 DfX3syQyZ2/so1caSXC/siskgSdkKM3KL5vnImqKGSFE46knKrrZHvHdm39Dian7VgQjn
	 JD0pIQBM9kXvncv9dX3od8X5pIlpUHjyPUFFFZMAYK9Y3lXvFpC+K67GphO6K+4yUpg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=cYSeA1t5;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=XcT+nEgc;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91C8D606A31D
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 13:16:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 91C8D606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=cYSeA1t5;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=XcT+nEgc
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69KDAGVt1575949
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 13:16:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=3lr7ieTrcyple3oJEv/wP9Vl
	YTXentXfrpGTCLa6BCU=; b=cYSeA1t5hXejILz6jvWAz+7FyfJtYYRBR+9pKqd7
	G94J9hsTDSi9XtBM3cfZJLdKjrrc5ApXdQiJ/hL+ybiWCCbBfiZEIL+2ykACF0sW
	DfLDVwXXil/VNSivso4ewm5B5j4GX6UbzbtM8CqLdOWhM4vCwNie9PiE+cXJJ98U
	aZ0uM0TlLgRvStKSM5Wi05JhArygcQrvQutaalffY+DsznG2L89bjgFQIqSsignT
	smYg9yXdwnNB5oxZjhn0/Y5jUDxdXNY5sfhucJMAVpD4AsDs6fsKf/6ZULJCgEmG
	9xu54cWTppmN3FHQYtCchxUurEZlKCfkogLvCy1saO67EQ==
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com [209.85.222.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdw5n2m6j-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 13:16:51 +0000 (GMT)
Received: by mail-ua1-f70.google.com with SMTP id a1e0cc1a2514c-9902e6f65dbso366571241.3
        for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 06:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792502211; x=1793107011; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3lr7ieTrcyple3oJEv/wP9VlYTXentXfrpGTCLa6BCU=;
        b=XcT+nEgc5aK4080W1Bb8t/bARrUCB6hPwZpqjXWAUL8itIxoWzBKfbewglHrSTe50v
         R+3wp8k/jujObnrKr08Egqsmvr/JIaf6dIpV7qLPF9Tz3j8nDKp7y3Jt68rmb2EkNAE5
         +A+Gn0Ew9LCHrrm24xGvJliOKxdXY3+8z2k1x/oaCE4nXmCQwXAi5JmKXmV78BUFjkA0
         KEXooTi5oDKBgia58gMrfTWGFDog8uiPJMufhcIS7tKyCD9qcD4q8rJU6qI4WqbiNmF5
         sNeGlq7cqKpZ3TxNhiUkL9oJmR6iWaUePGANwvixIhMFyakVSJU1R5vAOgPq2GjmBiAU
         XcZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792502211; x=1793107011;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3lr7ieTrcyple3oJEv/wP9VlYTXentXfrpGTCLa6BCU=;
        b=qBakY8yyY39TL5AYo3B8tJkik2dZPQupEO6QFb2e/2p9qbFa7bnZ+vHy84UbNw9llA
         bMlI5cCsd06yVfAdmRrB8FoNwkCqt1jeWr6hkobWwV8sRgblxo8RhI1vmNaSYzkDc38v
         Qoe7EF2Zw6fi70ZhoXMIFJ3A5h4KQ6EdN2TZdByK1u0qRSocXslaUJfOGUkGEcGwVwOF
         DQa3/uuuVDheE4BJKDR1fA0vBh53YjO5RNIxftOm4CgrTLy/7M4dTit2+rrvKUvleZaK
         aNxrGYKkYdjZeaESCDFa87XisnwqUWZUeLuImmzSDHb1m2umRnxk5SuP76sxIwwM3U5x
         xELA==
X-Forwarded-Encrypted: i=1; AKwUvBzidogt7QlhhBYZTlIr291OLAm4595Gn7IPxSeJONLThkKJM1akNvL7agb0tSXNQv1E6jE5V9M=@vger.kernel.org
X-Gm-Message-State: AFq9FYJW2XEq/rDURIhm8Y0biVCBWumEF3mzH3b3kDyvXu9evNOgv57w
	gOgsgTcz7yFOwu3rk/I/TBff0mWcV7qAT7GP/67FxxjxhpWgFSLMTwMXOdaGuCHIUDFqth8ll5s
	Pb/fMdC6xmyYBQsFtSkm5VChki8tk4XPsBGUNSlyz8hsi2ZCyo8WzucBTLapGknU3SZQ=
X-Gm-Gg: AYBFou0bE0qi8APPPV6ruFeruMdLSDMXZtOfpfgJKiOKy7wB/akojqd3O5guQ/4BgS7
	fI5TOW4SoIPMbEQrZ78hkostFT5BBFh29fP1Oytslr9lKkQHU8FJUflsXrQc8/VCyqWVzPBgw4G
	dEaIFhlCvYRxJhve2bxG0K0SVEIg5kaB9w6OCF0MmAeTT04ZX4B6Y5hZxpeRZo4aN8ECrg7VgG8
	6hrpre37mVQ94ExnVe3kX1+xoy6jMxIqGHQIhBC/55RWwP/W3rKJTePBCAlrDjI+XCm6OfjFJu2
	5qb2W3h2iBi5c3U9B70gOcRZxutLbq34OKMCzG9s0PmkJTjmfgP32EOLJNW2PwiqmuxTIozvpl4
	k0HwP7yo2I+fOsQ==
X-Received: by 2002:a05:6102:5346:b0:7c1:b55d:373c with SMTP id ada2fe7eead31-7cc36b04d29mr2259999137.31.1792502210611;
        Tue, 20 Oct 2026 06:16:50 -0700 (PDT)
X-Received: by 2002:a05:6102:5346:b0:7c1:b55d:373c with SMTP id ada2fe7eead31-7cc36b04d29mr2259987137.31.1792502209897;
        Tue, 20 Oct 2026 06:16:49 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e1d8208b1sm6391505f8f.33.2026.10.20.06.16.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 06:16:48 -0700 (PDT)
Date: Tue, 20 Oct 2026 15:16:48 +0200
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
To: netdev-bot+sashiko@kernel.org
Cc: maxime.chevallier@bootlin.com, andrew+netdev@lunn.ch, davem@davemloft.net,
        edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
        ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
        john.fastabend@gmail.com, sdf@fomichev.me, Jose.Abreu@synopsys.com,
        boon.leong.ong@intel.com, netdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org
Subject: Re: [PATCH net-next v8 1/5] net: stmmac: take ownership of saved RX
 state at poll entry
Message-ID: <atdpwITVxsWcDIWG@lore-desk>
References: <20261018-stmmac-rx-mb-v8-1-5f58c0b25849@oss.qualcomm.com>
 <179243151310.3135.16032115262445521338@kernel.org>
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
	protocol="application/pgp-signature"; boundary="NxY+HFPlk8WKRDAH"
Content-Disposition: inline
In-Reply-To: <179243151310.3135.16032115262445521338@kernel.org>
X-Proofpoint-GUID: 0wgJaHWZ5uUxV8941FqM5tUDoUrEwurU
X-Proofpoint-ORIG-GUID: 0wgJaHWZ5uUxV8941FqM5tUDoUrEwurU
X-Authority-Analysis: v=2.4 cv=L7qI0OT8 c=1 sm=1 tr=0 ts=6ad769c3 cx=c_pps
 a=R6oCqFB+Yf/t2GF8e0/dFg==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=9R54UkLUAAAA:8
 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8 a=PemzsjJJBjkDWbXggMwA:9 a=wPNLvfGTeEIA:10
 a=uEPnGdNO0VHfa3VMbwkA:9 a=TD8TdBvy0hsOASGTdmB-:22 a=YTcpBFlVQWkNscrzJ_Dz:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIwMDA1MiBTYWx0ZWRfX5VaXaqrxrthg
 M1bY1TPKMc1xPHVY7G0xSer146UMkRxVIq3MTR4s1VJ3K0SunvBCxttxTFaRlNeFxoiQZrtosLq
 OknvGBEYEoqCbmFLZPY2heQ3mwt++xtMhjQNivyNKzMKEQaFpI7+iabh3ljU5D3ZIxCVtUKL3ra
 khMCjF+ZIO62+dOh1McL9OB7ZPHUVXUoH+ZIm5U7t37oUObn98503+UFC194B+gwyui38Aiz11H
 6QSQOzFgw4QyuJYyI+GEJmGSwr7i3kQLStrTLEvoyPTgRQM2hBXsFyUHk6O7QiX2RguwW5df+c+
 F2mlSS9diDQt0C857axFjOrpay1wRBxQvOG3SBGjf/8UeeVAvzNnGV34/yPAdU7szg0OOQX5vv8
 S6HwNFsnQ2i+DM6G2+aj38uqcnYfSSnYDd6zIpPH4JmZVFQQ1OTjR0lbUBovvz4aSgrEBv5Z87N
 uqRL5IyDrwATdVfhV5A==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIwMDA1MiBTYWx0ZWRfX4wsKfaaNj7Z3
 Gem7cyrhjDhzQCNwcfnKGwo274wUAWccyOZBMfHRPzNhog52tDkHmkO43ztRRx/BmYIYgz/EsdF
 yjXFgS2Ouwkaxa8VNLZW7zFGhYsa5ow=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-20_02,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 adultscore=0 phishscore=0
 priorityscore=1501 bulkscore=0 malwarescore=0 suspectscore=0 spamscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610200052

--NxY+HFPlk8WKRDAH
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
> - [Low] The authorship and Signed-off-by chain disagree.
>=20
> Pre-existing issues:
> - [High] At this commit, stmmac_rx() still uses `skb =3D=3D NULL` to deci=
de
>   that a descriptor starts a new frame.
> - [High] This problem wasn't introduced by this patch, but the commit
>   message relies on it being absent.
>=20
> --
>=20
> net: stmmac: take ownership of saved RX state at poll entry
>=20
> This commit makes stmmac_rx() and stmmac_rx_zc() take the saved
> partial-frame state at poll entry. A new in_progress flag tracks whether
> a frame is still incomplete, and the state is saved again only in that
> case. It also frees the saved skb in stmmac_reset_rx_queue() and in
> __free_dma_rx_desc_resources().
>=20
> > Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> > Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>
> > Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
>=20
> [Severity: Low]
> This isn't a bug, but the author field and the Signed-off-by chain don't
> match. The commit author is Lorenzo Bianconi. The first Signed-off-by is
> James Hilliard, and there is no Co-developed-by tag.

I will fix in the next revision.

>=20
> If James wrote the patch, should it carry a "From: James Hilliard
> <james.hilliard1@gmail.com>" line so git credits him as the author? If
> Lorenzo is the author, does James's sign-off need a matching
> Co-developed-by tag?
>=20
> The other patches in the series carry only Lorenzo's sign-off. That
> suggests this patch was written by James and picked into the series.
>=20
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/driver=
s/net/ethernet/stmicro/stmmac/stmmac_main.c
> > index 53782ab55e125..8fd2acb25fb60 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
>=20
> [ ... ]
>=20
> > @@ -5958,9 +5970,7 @@ static int stmmac_rx(struct stmmac_priv *priv, in=
t limit, u32 queue)
> >  						      STMMAC_XDP_REDIRECT)) {
> >  					xdp_status |=3D xdp_res;
> >  					buf->page =3D NULL;
> > -					skb =3D NULL;
> > -					count++;
> > -					continue;
> > +					goto next;
> >  				}
> >  			}
> >  		}
>=20
> [Severity: High]
> This is a pre-existing issue, and this patch doesn't change how it
> behaves. What happens here when the XDP verdict is taken on a descriptor
> that still has rx_not_ls set?

Since this issue has not been introduced by this patch I guess we can fix it
with a dedicated patch.

>=20
> stmmac_rx() uses skb =3D=3D NULL to mean a new frame is starting. The goto
> next now also clears in_progress, and error stays 0. The remaining
> descriptors of the same hardware frame would then each be handled as the
> first descriptor of a new frame.
>=20
> The XDP_CONSUMED branch just above has the same shape:
>=20
> 	skb =3D NULL;
>=20
> 	if (unlikely((status & rx_not_ls)))
> 		goto read_again;
>=20
> So does the napi_build_skb() failure path:
>=20
> 	if (!skb) {
> 		page_pool_recycle_direct(rx_q->page_pool,
> 					 buf->page);
> 		buf->page =3D NULL;
> 		rx_dropped++;
> 		count++;
> 		goto drain_data;
> 	}
>=20
> In each of these three cases, could the middle and tail descriptors be
> passed to XDP and built into an skb with a stale or zero len? Could
> buf1_len then underflow and produce an skb length near 4G?
>=20
> An on-link peer can reach this by sending a frame that spans several
> descriptors while an XDP program returns a non-PASS verdict. A
> napi_build_skb() failure on such a frame reaches it too.
>=20
> Later patches in this series seem to fix it. "net: stmmac: drop
> multi-buffer frames in XDP mode" sets error on non-last descriptors when
> XDP is attached. "net: stmmac: rework stmmac_rx to support XDP rx
> multi-buff" runs XDP and stmmac_build_skb() only on the last descriptor
> and sends build failures to error_free_frag.
>=20
> [ ... ]
>=20
> > @@ -8399,6 +8408,9 @@ static void stmmac_reset_rx_queue(struct stmmac_p=
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
> This isn't a bug introduced by this patch, but the commit message says
> that, without this change, the first poll "resumes that stale skb with
> descriptors from the freshly initialized ring". Is the ring actually
> re-initialized on the stmmac_resume() path?

Since this issue has not been introduced by this patch I guess we can fix it
with a dedicated patch.

Regards,
Lorenzo

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
> None of these calls refills buf_pool or rewrites the descriptor buffer
> addresses. stmmac_clear_rx_descriptors() calls stmmac_init_rx_desc() on
> every entry. On dwmac4 that only sets the owner bits:
>=20
> static void dwmac4_rd_init_rx_desc(struct dma_desc *p, int disable_rx_ic,
> 				   u8 descriptor_mode, int end, int bfsize)
> {
> 	dwmac4_set_rx_owner(p, disable_rx_ic);
> }
>=20
> Suppose stmmac_rx_refill() hit a page_pool allocation failure before
> suspend:
>=20
> 		if (!buf->page) {
> 			buf->page =3D page_pool_alloc_pages(rx_q->page_pool, gfp);
> 			if (!buf->page)
> 				break;
> 		}
>=20
> Then the entries between dirty_rx and cur_rx still have buf->page =3D=3D
> NULL. On resume, cur_rx and dirty_rx are reset to 0 and every descriptor
> goes back to the DMA. When one of those entries completes, can
> stmmac_rx() call page_address(buf->page) and napi_build_skb() on a NULL
> page?
>=20
> There is a similar problem on dwmac4/xgmac. Descriptors that the hardware
> writes back between napi_disable() in stmmac_suspend() and
> stmmac_stop_all_dma() have RDES0/RDES1 overwritten with status words.
> If those descriptors are given back to the DMA, would it write to a
> bogus buffer address?
>=20
> The resume sequence is the same at the end of the series.
>=20
> --=20
> Sashiko AI review =B7 https://netdev-ai.bots.linux.dev/sashiko/#/patchset=
/20261018-stmmac-rx-mb-v8-0-5f58c0b25849%40oss.qualcomm.com

--NxY+HFPlk8WKRDAH
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCatdpwAAKCRA6cBh0uS2t
rK/rAP9eeUWDw5jEkLXbZGZjD44MWM5eQ7vU1AdbT4Lc6/gFZAD9HjzeJTtHr8HQ
TZlUcSBRhfUzqQDfqiP15dZDUnPK4gw=
=ieLd
-----END PGP SIGNATURE-----

--NxY+HFPlk8WKRDAH--
