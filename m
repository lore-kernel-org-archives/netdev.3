Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793098109;
	b=ALDqaW/dUIVOVcHgOYoaoxzcd0FnJEGWt58LuFTfhUyOdGRHjH+VY8aJqOzcWlDf1vbf
	 iZUj5M1ikrnnGu4roMTWPRqzmBOAy7xAF91z97SDxkzEPCmhOdBTBGAerkIkE9B0/6l4V
	 ChV7BflJeuL2MDcEaDd1/uUSs+3nDG/aIiBFkBqiHEhjRUI6tUf+mRqF4KdoEQVrss13K
	 FL695Ee6uQDnnS88LMgUvWQEPhBKzKGymTe4WJBaBn/8MkUX+yeWUc/U55+NkkHejMTNL
	 6rWn18mdJu4o17uWIm+nw788DShN2xh+3pbWu6F25jXk8pP2SaDh76JL9x0E+v+n2Rw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793098109;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=NtM3FpsdWMM2ex3dyoN58f+ry/GhVNNeuVgTFC4ju0Q=;
	b=z6gIjCuKUupLpGNlAhlsik0zNHviqKZYxOl/X4TrZZl7OXZRaTFsnAbtHjEjMVVVjHcw
	 MbjOlJC3+6bJaH3La13iZLLOkW+dp1CVW1R5wYpkv1YB2IzIZuPmCohGuXKrQw8IGPYO7
	 nZ64GCN3MVPW5/t2RvWUbJ2qoFRp8/uyj9CFdmMroG7/joO+H9dTbmnjGBkZDnPKxVADF
	 ZTb8N+yNH7q3aSXtWpmHwPirKj9u0WW7ANI51wcAxNMOi9igRW2rsuINwCLoNfYvIF/ZF
	 wSMwQ3n0H+psYGR8xKlzzbdRvFiePWjLom3PLUijska2P3Z57IiGXcR1KOU7hwOMlIg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=CHT51Hzq;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Fni6g+co;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDA41606A31A
	for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 10:48:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EDA41606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=CHT51Hzq;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Fni6g+co
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69RAerbl1938145
	for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 10:48:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=NtM3FpsdWMM2ex3dyoN58f+r
	y/GhVNNeuVgTFC4ju0Q=; b=CHT51HzqShdbJtFgjVyQFsZRW7T0CI7k449+EDJy
	djLFMda+ACDhAeRkl3jjvJ7bznfI3wxIJ15K4MB6K7K50Rtouao38q/BOl/1/Erl
	y4hmklHZ4WLoJUWOBRGybluGv24l9OD23KLgzPnOLyEI74DAQMA3sSQotc4KgAP5
	OsKqVFnjXzeo2QR2AR9vJUGXCkOUTgaR/sw91wn1+hqyWo89YwrYejRTfhH8yuQo
	XbTvKr+fvv4OzyP25CeTHJgGWIrF3ncuiKlpSaHOON0oHpmfCkuUkRP9mma6nntT
	JFk21HD56yBefG+/fuEkmdtNaNIqb3QXesGDyX6t5m/AVw==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hjfavteby-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 10:48:27 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-91c70349f65so13904166d6.3
        for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 03:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793098107; x=1793702907; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NtM3FpsdWMM2ex3dyoN58f+ry/GhVNNeuVgTFC4ju0Q=;
        b=Fni6g+coQdSIsN4QqlixhxHNADhDudi9BOHUgolHSb5b+cKBqizyiTvYeiFAmi6TEq
         OHUV0PyjllzodmQ3NPyXg7dD+0Kt0/ifrZorc88MT6LPLWj3g0BxX8SzYwXpSd4uKZhI
         EjE39iNDtZVW8ZXGwitP5u81jkc5pwkB2bOo+g1y3NwVR8a6eWozWzkdGLgW6IFRx9pL
         hJvLA+x1fgN5P92RAtwhhpH3leia4SBy8ZcGqgVt5XzXek808/8rkkUUH6QUKIRXQJKW
         urOBLS0OLDG8gphIHL6Np92DwR3EtwWNlArtArMRxvz2Ly5I5MV+PV4I7c9xYgOoNZ2R
         C2OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793098107; x=1793702907;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NtM3FpsdWMM2ex3dyoN58f+ry/GhVNNeuVgTFC4ju0Q=;
        b=Rax/BQKhY/T2KMX+fA1CsBGU8uCIFwTc5MU6MO5YBf44/m5H224MtQ0wllV0FkCrB5
         hQG/j2z30Etpb/faFpoZ//kqiJHOXWkF0FZHGXN0a7cPfz9NrAffbNmZsZEQS94pSZHW
         +Rm5wszM6DgMYeO/5w9lrfw1YZkzgilp6ZvZufl1Cpa3q1fYG+5e5N5rKt9tjPUdSn0Z
         dP60UURmbWLzyyMTSBdZorvnMSN1URcXg4qzsEfcj4ta/f/yZg2hsqV0JuqvU4TCLik7
         H7J77GSwgj5nOWMsuZE8yf12hesxOlnE4+9AT6FL3hcXCi1IliRkyhOhw+myaDJaH89b
         E9Xw==
X-Forwarded-Encrypted: i=1; AKwUvBzAPcP/xFNQHqBsXYKG0jXGfXQKlAR3MxGj6A+0QydDBA+pqBLLqAZBntnzNidlI+L1nlVqKe8=@vger.kernel.org
X-Gm-Message-State: AFq9FYI22OR1fGW9tO2zcOqGBLjxZ2fMtVVpO5V4OvxHH//+4u/Qurul
	nQJTDf99sNWcbBMZ1iJXOskwzL3MxGXlvZqnoQiiQTAsCRs1l4Ry6b1nMr0ktvGlPk+dO8e1aiG
	O2NrU7XtuA2VmjoEfRaS3II9hd3wI51qTpMBbUjXvxy4TUd4VjcIVZ90WfDY=
X-Gm-Gg: AYBFou0BQLXnpKUE5B6UOMEc5ZS6R/m7F2Semvrl2uiZskfid+L0BF7F6z2z+lQJiDC
	kvVBCdz3xVLx2d6e7+VConbtDpKgH5enhVx7GylQqe2o/u3j1N13CqChw3Cz3KO+EzfiSu5Nwnu
	KTZ8PWxx8CQzrqjL/5o9v0aPoBhzYB80wFTcT3wJg3EcGJWTlO3sOW5uPCV/I7P/FAKuLCXJXCK
	Lpf6zvNfjbwKqgsgZ4ibDEq/R4DMfAbfxRiZcARQ0/2sw9HnVKa8IaZNYdGgFz6Oyd+sGXGMy9a
	UBygyJRFK17neRGVUYkelYlqlXQ+rNDgd1VGOoLjAmmftLTM+vApcySdFbgxO4B8enfLbeQZkZB
	ptZlxG2+55wJiWYVjS8WmNmepfozRV1GCt4DwgBldKPkBHZd3
X-Received: by 2002:a05:620a:4728:b0:93f:2236:a61 with SMTP id af79cd13be357-940ef996db1mr1431341585a.61.1793098106753;
        Tue, 27 Oct 2026 03:48:26 -0700 (PDT)
X-Received: by 2002:a05:620a:4728:b0:93f:2236:a61 with SMTP id af79cd13be357-940ef996db1mr1431339185a.61.1793098106087;
        Tue, 27 Oct 2026 03:48:26 -0700 (PDT)
Received: from localhost (net-93-144-6-81.cust.dsl.teletu.it. [93.144.6.81])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ecdd5b3sm21894250f8f.53.2026.10.27.03.48.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 03:48:25 -0700 (PDT)
Date: Tue, 27 Oct 2026 11:48:24 +0100
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
Subject: Re: [PATCH net 4/6] net: stmmac: copy XDP metadata in AF_XDP
 zero-copy RX
Message-ID: <auCBeIMVn0hpbkE_@lore-desk>
References: <20261023-stmmac-xdp-fixes-v1-4-efb37e19f5bd@oss.qualcomm.com>
 <179309225560.3134.9863766306670060785@kernel.org>
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
	protocol="application/pgp-signature"; boundary="5opCz2OYcNfKa8l0"
Content-Disposition: inline
In-Reply-To: <179309225560.3134.9863766306670060785@kernel.org>
X-Proofpoint-GUID: 9s5j_iA0xmkcO_YRmQa-AntyxMnYsGCv
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDA0MiBTYWx0ZWRfXxfpbO9NSQIk9
 QdPVNITaaskAVRLWnRAeySYzX7Fsw857HtRmdMukTv0kIZKB4iIGUfVRew6fzfC0P5TMOgeajUP
 uOeFoScuGQLh5n48XN/nPw/bOFTkNOI=
X-Authority-Analysis: v=2.4 cv=EIeTQFZC c=1 sm=1 tr=0 ts=6ae0817b cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=7fYLNvKHbgS61GKHX+yayQ==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=9R54UkLUAAAA:8
 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=xcHvD7ZGWmBKKSWBBH8A:9 a=QEXdDO2ut3YA:10
 a=f-25XZo990EjwU-OyTIA:9 a=pJ04lnu7RYOZP9TFuWaZ:22 a=YTcpBFlVQWkNscrzJ_Dz:22
X-Proofpoint-ORIG-GUID: 9s5j_iA0xmkcO_YRmQa-AntyxMnYsGCv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA0MiBTYWx0ZWRfX/NO5UpfO3P8B
 CqnuENRiDAcIHMxxJqqpnC5MsFdcp66TOrC4hno/ZJFpBV+uGkijNrQMD9JarDC4eDBFlTTAwin
 5Ewji9eTLcW2/wrPGSd2JKKgrSAE6rsE07R0E030uwjyX3mvM0HFWBYpSoHiM2IJwt4XgY+fmE/
 aDtU3nnGEJJuMrkgGrhHf1faZZJkFgI16uMThTqjXal9YeI89tuvhIz0B8ej/4DfgyZxbkxjw3d
 iypS09NimjftdD7Vmfr08WU9KBCxmnwvZHS3RQ76taozWURM0O9Jn0OFJFChMW41ixys5nowIPR
 ud8x34SUGhUOHF4gVnqCgAIeZJJj9NBTA/irLyjx9xTTcEvyWx2Itib1OnYqnL/VfMb+/0mw+KB
 yHpUYXX8fvqAcsAD1JOM0/sRnhctiGFrTmS4cPqiWLzDTVoFiaIvM+HfbMoVokBCZ06rz9OpDDo
 HjjZimrByccB5PgXQYw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 suspectscore=0 spamscore=0 phishscore=0
 bulkscore=0 malwarescore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610270042

--5opCz2OYcNfKa8l0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Oct 27, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider.
>=20
> Critical: 0 =C2=B7 High: 0 =C2=B7 Medium: 1 =C2=B7 Low: 0
>=20
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
>=20
> - [Medium] At this commit, the commit message says
>   stmmac_construct_skb_zc() 'keeps the metadata aligned when=E2=80=A6
>=20
> --
>=20
> net: stmmac: copy XDP metadata in AF_XDP zero-copy RX
>=20
> This commit changes stmmac_construct_skb_zc() so that it copies the XDP
> metadata in [xdp->data_meta, xdp->data) into the new skb together with
> the packet data. The metadata ends up right before skb->data, and
> meta_len is recorded with skb_metadata_set().
>=20
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/driver=
s/net/ethernet/stmicro/stmmac/stmmac_main.c
> > index 30a2774d722b7..8a2faf50d6957 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > @@ -5519,7 +5519,8 @@ static struct sk_buff *stmmac_construct_skb_zc(st=
ruct stmmac_channel *ch,
> >  		return NULL;
> > =20
> >  	skb_reserve(skb, xdp->data - xdp->data_hard_start);
> > -	memcpy(__skb_put(skb, datasize), xdp->data, datasize);
> > +	__skb_put(skb, datasize);
> > +	memcpy(skb->data - metasize, xdp->data_meta, datasize + metasize);
> >  	if (metasize)
> >  		skb_metadata_set(skb, metasize);
>=20
> [Severity: Medium]
> The commit message says this change:
>=20
>   "keeps the metadata aligned when stmmac_rx_vlan() relocates it with the
>   MAC header while stripping a tag."
>=20
> Is that true at this commit? Here, stmmac_rx_vlan() still moves only the
> two MAC addresses:
>=20
> drivers/net/ethernet/stmicro/stmmac/stmmac_main.c:stmmac_rx_vlan() {
>     ...
> 		vlanid =3D ntohs(veth->h_vlan_TCI);
> 		memmove(skb->data + VLAN_HLEN, veth, ETH_ALEN * 2);
> 		skb_pull(skb, VLAN_HLEN);
>     ...
> }
>=20
> The software pop path runs when hw_vlan_en is false, CTAG or STAG RX
> offload is enabled, and a tagged frame arrives. In that case,
> stmmac_dispatch_skb_zc() calls stmmac_rx_vlan() before eth_type_trans():
>=20
>     stmmac_rx_vlan(priv->dev, skb);
>     skb->protocol =3D eth_type_trans(skb, priv->dev);
>=20
> The metadata stays at [old_data - metasize, old_data), but mac_header is
> set to old_data + VLAN_HLEN. skb_metadata_end() returns skb_mac_header(),
> so the metadata window seen by TC BPF and the stack is shifted by 4
> bytes.
>=20
> Wouldn't that drop the first 4 bytes the XDP program wrote, and return
> the first 4 bytes of the destination MAC as the last 4 bytes of
> metadata?
>=20
> The next patch in the series, "net: stmmac: fix VLAN tag stripping on
> short and non-linear RX frames", changes stmmac_rx_vlan() to move
> meta_len + ETH_ALEN * 2 bytes starting at skb->data - meta_len. That
> fixes this by the end of the series.
>=20
> Until then, this commit is a bisection window. A stable backport that
> takes this patch without the next one would also have the problem.
> Would it make sense to reorder the two patches? Another option is to
> reword the commit message so it doesn't depend on a change that hasn't
> landed yet.

I agree, I will reword the commit message in v2.

Regards,
Lorenzo

>=20
> --=20
> Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#/patch=
set/20261023-stmmac-xdp-fixes-v1-0-efb37e19f5bd%40oss.qualcomm.com

--5opCz2OYcNfKa8l0
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHQEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCauCBeAAKCRA6cBh0uS2t
rPBBAPiEAH8oMDUQ8SayzxLOzJ7edL15RXc9f5uijlSyy1ptAP4pI+XvzoOSj4uZ
rSo3qSD8cfOQWK8YtpZHTEBCIcvjAw==
=nrVc
-----END PGP SIGNATURE-----

--5opCz2OYcNfKa8l0--
