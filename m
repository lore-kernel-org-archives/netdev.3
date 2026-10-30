Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793350136;
	b=4KJ2ehjdIbUxEIz2QvshDYDt4rYVnvQ4JgAaq+hY4Eg5tvGmroiwjah6H4FBf+3Frwj6
	 u3D0iuZuZhsraTyC6JY70HZdJ9kB7wi0KFtg2cZ5qni9YThU/11gkG9Lhxvr/GSw035BA
	 1zQQOkYJvqVVrdT/M7LAqUtd1rHlJGPgE7QD9Iv4FYGnkFu9f2/+mCa+AlZKh/mw4CAo6
	 JUMtBIDN/Zv0YJyXS/87YyKGUuZo1XJLygX4f6o5UQ+mO7k7sAmUVjuesMlAoeALbbp1w
	 4geO3ppQaXk/bIzDKsHXEXZk4BvTVSzQEZQ/oxZKVotjEru7sKNgJLizAkTMCicI2Fw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793350136;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=d2olyE8nkwfIZoPiTmTgfbY9lInYL1sWn+D/JJOh5/4=;
	b=sAY6THPZz8cR0hZWh8afeIlGVMc1/tyM41eQ++sXmBNr1UQ5dnKOkMFhF0brhXKGkrqh
	 lMdnnrypd9t0GkhOgxJGz/L2w9/0suoG3Ze4+w1smeuvsiGxNNFufki9YmoO7VjOFt//i
	 RWF632JTGVSHAsgxlB1g07Hsar89z4s4bnvblt5FuX5jOl1/dvk/IY1+euSue8vlyzXGG
	 cVZt/ovH/+/ZOw9CY9DtG96rcJ1Mx2Qz/FQdEDG9NN0tDcequmgkuVUilsysp/wXKN/3V
	 rjra0WeB5lQwvVwnZabJtviYsLQ1PtATAgHlQ2oZMBNwCh+J8y9+wt1qeI+u3+tD9Og==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=YvVna+u5;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Q+svJH8N;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A16C606A321
	for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 08:48:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3A16C606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=YvVna+u5;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Q+svJH8N
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69U8F9km2374148
	for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 08:48:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=d2olyE8nkwfIZoPiTmTgfbY9
	lInYL1sWn+D/JJOh5/4=; b=YvVna+u5ZUvrfMKUUOJEHq3TIudxwxpc2vWcdbS9
	GOVXFvI2WINW2F5/40Yu/QSaPn86s/5MXDI+BrNR+ESUT+AebPhpLJSTePNiPQjE
	+4F8S/WfzATpeRcnOwRNWBTZjGWD9i3Gw7+5Q/teSjPQwwerRtXgUKg2Y5CFHpD3
	+kP8jsxprtoFugP+PzLHsiiJUVi6dOeCBV6Bv2DJNipFxZYHYBGpZyjdi9ZAmK1d
	7S5NyjcwHhgka9878N1BFEm/SEpxsYLTVsZx3DlaDCHjC4qUkDbDyE+Qa8jm5TmT
	bXLQxw5Cgx/uYSjapZx7sc0w0os4zbiIYDVhG3gpFpZJkQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hme6qj2c5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 08:48:54 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93f13c143c8so73906385a.3
        for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 01:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793350134; x=1793954934; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=d2olyE8nkwfIZoPiTmTgfbY9lInYL1sWn+D/JJOh5/4=;
        b=Q+svJH8Nan89G5dAXm7FvWPDq3ksXZyzsmjjBOao9DAVf1kyYVAL9MVB8qwgxHh7hL
         WiVlTqZ44ovwis/icJ3xF/qbGwjwY8j2qShjMAwokYTSaqnf3V2dFXnPUTAROcQWW2JP
         awIm4xdG7z9HeVD2Wc10SpLoyxyNBzkTSseV2DkSyQwIJ7p+x52yZ9ahUGT/nP6vhvLc
         NJPCgOWClH9gYJdAMCpvzZAH6pyzAoBG/5KAQ1PX5gSCk76NZpD9ZAPk7VOTYxwyEi5U
         2WG3ob2ElHkarys7r1/W2aipzwmHcJdvji8Ihq+amCmUhXUOFHk7V/gBkrAQqG9EpyKv
         mWkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793350134; x=1793954934;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=d2olyE8nkwfIZoPiTmTgfbY9lInYL1sWn+D/JJOh5/4=;
        b=gbH/r0zQ9JqS7PlmjdYCM2ZPoLjtIHoUXkGX1Wa5GqHEKdVt0Gr0vzkXSnsFGE4VK8
         vxmp4UmfICbWyU4+7J213wTiGeI54KAQO8nCec9rJQCRR1dMmdDZG7KFmr6kvNa0MFLJ
         6RxmAQ1UpZSHSkeoq5av9toR6fSP3+ju1AyP3RK3Onp9aRgyHPN10IGbSvonC5e8dv1e
         g5YPPcoLWXDlz5oTkiAFEXtI6TZBU/oNeoZ6a4lIcGd3WXY6NWpIZMT4F00If1A4on1Y
         YYoHu3sJiSxqTf1i8LttajMg/l4kCNBxBPYlH/wKikZy0ATF2Q8tuB/VTatvisxrF1su
         l+MA==
X-Forwarded-Encrypted: i=1; AKwUvBwp/k3dW0S/tb61fvNH8RTp7sLZUuHjTNolH/hBYIln2J7oEcGIx807kiold5duL162C7yb8JY=@vger.kernel.org
X-Gm-Message-State: AFq9FYICCAzmGVR+mCMjgjk/qB3xUfR67k7K/S+0zQhuLpYU9ayuNrhp
	BijBT5FvY1nwclOcbmtNv7mhgEM4++U3rcNinxyX+Tm/qtVI/mLo+WJJHYcqwOD7p5DOdPA+pjJ
	fhSQB8f9y43BbMfIBFyh0D4CrxVoS79TasWiV6pTiZDSblmv9c3iWNOfy04U=
X-Gm-Gg: AYBFou22xR/4JrFMgEcXLrnvK6l3/uGXBXVjbxTliwrVdsXLgQhLAdr9KzKEb2grwNl
	hdQh6//1Y/WnbCSrfyayA3T5ODbFH7E87vbN0NhfKmr6ZaZXMrywsJIvlIywEJfusmG+HMLtk5F
	1gSNaUHcNgMlj2aUNhz7jzCyrjXpebJdwdfUD2LC+WzzaRFVEH9AMBfxpM8K7WKCZR7FVuaamcm
	awXgUc3WL0d4XeA+ur2CP+H82Z0eCeN8AWGYeK6YLDip2VK7LjWQFzCSa+oETMp+vcz3en+As2m
	dvTezRQWoKYoxSFuE+RYtSGCuVDZ25B06W65vHTLQOkJCNIM86D3FnkoQFUbSxKNTQHPNFFWIqG
	NNrCLzV6d73qXcc5/yG3raiOCsvoNUfgvRqt8l5FPRl1xl/x7QgqsKk9rSzFFJE2lOilIqr3yIi
	zAFnn3w7bUvu3VgwLW9OhQCg==
X-Received: by 2002:a05:620a:1712:b0:93e:fa30:f1dc with SMTP id af79cd13be357-944217ebd9fmr275561785a.72.1793350133081;
        Fri, 30 Oct 2026 01:48:53 -0700 (PDT)
X-Received: by 2002:a05:620a:1712:b0:93e:fa30:f1dc with SMTP id af79cd13be357-944217ebd9fmr275558885a.72.1793350132551;
        Fri, 30 Oct 2026 01:48:52 -0700 (PDT)
Received: from localhost (net-93-144-6-81.cust.dsl.teletu.it. [93.144.6.81])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4abf6c76507sm47152495e9.10.2026.10.30.01.48.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 01:48:51 -0700 (PDT)
Date: Fri, 30 Oct 2026 09:48:51 +0100
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
Subject: Re: [PATCH net v2 4/6] net: stmmac: copy XDP metadata in AF_XDP
 zero-copy RX
Message-ID: <auRZ8qGf-6smpZNo@lore-desk>
References: <20261027-stmmac-xdp-fixes-v2-4-10eae8a093a8@oss.qualcomm.com>
 <179334662537.3134.7910783540285829149@kernel.org>
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
	protocol="application/pgp-signature"; boundary="uOk9qAS7xtVWcgde"
Content-Disposition: inline
In-Reply-To: <179334662537.3134.7910783540285829149@kernel.org>
X-Authority-Analysis: v=2.4 cv=KsrYSmWN c=1 sm=1 tr=0 ts=6ae459f6 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=7fYLNvKHbgS61GKHX+yayQ==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=9R54UkLUAAAA:8
 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=MXY1n-zC4wgOH_4sE1YA:9 a=QEXdDO2ut3YA:10
 a=O8hF6Hzn-FEA:10 a=7PUuv8MLwXOgIG9yGv4A:9 a=bTQJ7kPSJx9SKPbeHEYW:22
 a=YTcpBFlVQWkNscrzJ_Dz:22
X-Proofpoint-ORIG-GUID: 9FzGgQigncwGX1OQBg1NKBs0Y6It1BWI
X-Proofpoint-GUID: 9FzGgQigncwGX1OQBg1NKBs0Y6It1BWI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDAzNCBTYWx0ZWRfX7G0hw/G9uPJs
 l/8RBUevnl6BK/4tX6SDMrvqe8bXZ6WnpAO39IfRXpsE7+noGzLr8ComNX4le6VXm+/cdtDv9ZM
 tgsWfTtMhJPoVql3vY5eRJkMvJzRbh3qICi2PCdnLn3P00YYZrATg/WyH7Md5b1xKsiG/gZOdhM
 QySH0w4wd3OJM4xhEJicPu4E6InEotIynn5VFrcZfk5GVDXiFuiCYdmKlBznpzCKJIMRihAQQBe
 2aK+eKozQrODhx7QI0ySZ+dCMiSjXONaej6QqgBqMLYayeeQ8+fBUbYsI1q2pbyyk3PNBcpgOaY
 nawxDMmf4+ey7iZEaoXI/4V2zwOnhJZdkcBrmXzCqICpO2/wyMfaUmTGqazySbt9r6iPhuDvvEt
 r3dutYYQ1Dgeip3sfeHtwCvKFZ1J+ZGXAU8Bp1MzRXzHArynauCOYTRgA+kaHCqxPfXKxq5ulXA
 mXDttjLT0df11Z3YEGQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDAzNCBTYWx0ZWRfX0T/fUEwUSHo6
 oAzc6pwbCf63igvsXlN/jTonFETetj8m6n0p5AExH1WTNxviU6l/3arGcaFqA6KlyFySoFhqdBe
 TESHMfPNiOOLw0tI1Vm6aTsR2izhdhY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 priorityscore=1501 malwarescore=0 suspectscore=0
 lowpriorityscore=0 impostorscore=0 bulkscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610300034

--uOk9qAS7xtVWcgde
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Oct 30, netdev-bot+sashiko@kernel.org wrote:
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
> - [Medium] In this patch, stmmac_construct_skb_zc()
>   (drivers/net/ethernet/stmicro/stmmac/stmmac_main.c:5521-5525) copies=E2=
=80=A6
>=20
> --
>=20
> net: stmmac: copy XDP metadata in AF_XDP zero-copy RX
>=20
> This patch changes stmmac_construct_skb_zc() to copy the XDP metadata in
> [xdp->data_meta, xdp->data) into the new skb together with the packet
> data. The metadata sits right before skb->data, and its length is recorded
> with skb_metadata_set().
>=20
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/driver=
s/net/ethernet/stmicro/stmmac/stmmac_main.c
> > index 71858af6fd66d..d9fc2464a160a 100644
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
> Does the metadata stay valid for VLAN tagged frames that are stripped in
> software?
>=20
> The commit message says:
>=20
>   This keeps data_meta valid for the stack and TC BPF after eth_type_tran=
s()
>   anchors mac_header.
>=20
> When priv->hw->hw_vlan_en is false, stmmac_dispatch_skb_zc() calls
> stmmac_rx_vlan() after the skb is built and before eth_type_trans() runs:
>=20
> stmmac_dispatch_skb_zc() {
>     skb =3D stmmac_construct_skb_zc(ch, xdp);
>     ...
>     else
>         /* Driver level stripping. */
>         stmmac_rx_vlan(priv->dev, skb);
>     skb->protocol =3D eth_type_trans(skb, priv->dev);
>     ...
> }
>=20
> For an 802.1Q frame with NETIF_F_HW_VLAN_CTAG_RX set (or 802.1AD with
> NETIF_F_HW_VLAN_STAG_RX), stmmac_rx_vlan() moves only the MAC addresses
> and then pulls the tag:
>=20
> stmmac_rx_vlan() {
>     ...
>     memmove(skb->data + VLAN_HLEN, veth, ETH_ALEN * 2);
>     skb_pull(skb, VLAN_HLEN);
>     ...
> }
>=20
> The metadata stays at [D - metasize, D), where D is the original frame
> start. eth_type_trans() then sets mac_header to D + VLAN_HLEN. Since
> skb_metadata_end() is skb_mac_header(), TC BPF and the stack would see
> the window [D + 4 - metasize, D + 4).
>=20
> Wouldn't that window lose the first 4 bytes of metadata and end with 4
> stale destination MAC bytes?
>=20
> This can happen with AF_XDP zero-copy, an XDP program that calls
> bpf_xdp_adjust_meta() and returns XDP_PASS, and a VLAN tagged frame on a
> core where hw_vlan_en is false. stmmac_dvr_probe() sets
> NETIF_F_HW_VLAN_CTAG_RX for all cores but only sets hw_vlan_en for xmac
> cores, so dwmac100/dwmac1000 use software stripping by default.
>=20
> Before this patch the metadata was not copied at all, so this does not
> make things worse than they were. A later patch in the same series, "net:
> stmmac: fix VLAN tag stripping on short and non-linear RX frames", changes
> stmmac_rx_vlan() to move meta_len + ETH_ALEN * 2 bytes starting at
> skb->data - meta_len before skb_pull(), which fixes this case.
>=20
> Could the commit message mention that the VLAN stripping path is fixed
> separately, or could the two patches be reordered?

I guess the reported issue is fixed in the following patch: "net: stmmac: f=
ix
VLAN tag stripping on short and non-linear RX frames".

Regards,
Lorenzo

>=20
> --=20
> Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#/patch=
set/20261027-stmmac-xdp-fixes-v2-0-10eae8a093a8%40oss.qualcomm.com

--uOk9qAS7xtVWcgde
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCauRZ8wAKCRA6cBh0uS2t
rEMSAP0ckjQt67ODqSh/d4rEEdTXd68ufBiuZPEyUP2VIVyEVgD8D/oK/777QoIE
JtSmhynYGNYRxd5J04Emj7z0LderAAg=
=zAho
-----END PGP SIGNATURE-----

--uOk9qAS7xtVWcgde--
