Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793099462;
	b=ZEWWMyKGSM/gJ2EUL0d6Mi11s4gXk6YYakCGyt0ooxrhFr2MWvbQ8uJPq81ofaxNm1MB
	 0Ww3qVzfSs6U9W+NUB5qrUfAo6NxinAVrSLtc7UKoHj9A3CFJKY2GMYkRbLm0yN5iE6VS
	 uMlKwELsnBuSfbpxXPiRWvE+jLGXy0u/xswMqdLaiJBI0XEZnmxnTvR76guj8NrLCmbIy
	 MlB+AY91BF8DxVNyyWd6AXIG2yz1XMlC7sYQmW14eVuyiJS/fbDe84R7RbH//s242mCsU
	 J/NCWEZIuE9Ed2OTT5tg5052tO5GmCr7N2H4EwaT+rABc5iaGdxrSu7amRwcRstP05Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793099462;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=/CxXgblb1WraVgSV86I4VysbzdPhIpd24MIpyC6IrWA=;
	b=FerU+8+GY9MjgYsgu4J9Ef/QiHuF0LbzftM2ilbA4UVCwEkd66ds/Z98HveV3uzxNDLy
	 9x7lh4XLEA20SYVdEDH7Xkk9OlIGHsOfCyiwpwfwpB0DmysdhKKsUmL7mxuZq8Nahgijm
	 sJo0tkVixFGpx/l+pZ1V3zZosqQZGnyc7PKclxNOPfrMdZUxBlQJ+Izagn+yEkxFfYMc1
	 /YaI9pImqeo+vzPBR52BJFS26J5x9E189s4CRHxh6oQbgFchSsD5a6mW5jhgXtF90wUBP
	 4qO9lR8B9cAoEJbe68Oq7QnER0TwNmKGwBzPRRt8+CqjGXb6uv5uK4lD+wunV3+mhLA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Mr8GBc5N;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=kGkp2Hgu;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDA08606A31E
	for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 11:11:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CDA08606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Mr8GBc5N;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=kGkp2Hgu
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69RAeTfe1428070
	for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 11:11:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=/CxXgblb1WraVgSV86I4Vysb
	zdPhIpd24MIpyC6IrWA=; b=Mr8GBc5Nvz13YHEJS/SNjAEMNAZe4ggH45/KfNPi
	WIiZN+rwSxJBJ2WGukpie89sCuDtGdfba8u14PJBDbfKjvOhgM0+UpZsqrtUvZOj
	iAb/URiegWg7+7GZdMaGj8oN0qdrkvPS0ap5ATWbjGt7/oB21aRCxX0MnVY98Ewz
	KVYXjh56IM5fxCxfmrj3N5oKz9qOlRM7DKOvHBnxWYkvyq2vI6pbcYTXwoKk5wGs
	YLpHgWoiinnFcuJC8/DpOAvcfc+NCDhAVYp3MkKMPi2PzrBh0Fp8vjYdgO6Fv5pq
	u1/yV3D3qxJIX/ZW+Ci23ASQ0Jlfo+pWmnHwM+tDdJdvAg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hjbmmb96d-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 11:11:00 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93f322ef7d3so872976085a.0
        for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 04:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793099460; x=1793704260; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/CxXgblb1WraVgSV86I4VysbzdPhIpd24MIpyC6IrWA=;
        b=kGkp2HgubaX5SSpSOjL087ODbb1i8VjnarPjBsiqxYpto9LiKyABRoz/Rkr4TvdrNj
         JqzW3GkrKgrvG07mtlwfFsxhUN3hhA0UH6bWvi25/fT+h+qClkAzL8VIKKNpTlfjPIjd
         6EUvzVs0I2YYwniqn2W+k6B80VDAfSpDK9FWf06JmMmFlhmAs5pcfOmT1KWY3MjfBUFl
         uF72ozKrqKtEY0+udJ2ym5OrDGjIHBvzVflW+V9MCdmgxAMsJwpWOv9Bw71d2O5ouPdb
         cFqWfeAuzwHE8dLlnDJzBxzp1WFOjqSpsrmkEZH8mCgEZSl0c3rZWxXEIDmrGRTqaxJD
         /hkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793099460; x=1793704260;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/CxXgblb1WraVgSV86I4VysbzdPhIpd24MIpyC6IrWA=;
        b=2fm3AncPlVOxZEXQP9mRA0qyP7pVgUt7lUVApT6rSPcmGjI0iL1KimY0RAsigaaN/R
         fWhSiBGAftmG6QA0gPj7n0COmD9UZIkmyfWLPSiAB6VuidLotAlx2Jk1Cpb2AQjXkrYo
         +2ctbu8/TugiFXkgVRhcZGDHtVnforT3wdcRlSAFbT4vl30W4cWOWk3/333JYMpfscOg
         0pZewFkIO+sC2z5gg8VFKHV3YMEWBytjFcW7HVG+dYOkVQFzreQ+qwFalSYJcLVpGweY
         Tc/rukKW/0a9NziLYuI5kx9tIPrC2xbw/eigzWkXco5xL4WZcb5sa7fJ5l8lD9xp2ACX
         xS0w==
X-Forwarded-Encrypted: i=1; AKwUvBxLLhc7rLAaP1exZ/T2rwqkG9NjlbWaaf1M+ilb3fQpyr+SG7cHlLVoKfosdirwBu+GxvWeMPY=@vger.kernel.org
X-Gm-Message-State: AFq9FYL2ov5UWVHnpnMUa13POB67yTbXqQRlao0vCek6B9HoHjanHyF6
	noHUu+N/P8afo8kCNI3XW2JbAHlt257yWcxoT5NQ/yiDAavRSV4k0vqs5UtV905WByubJcwBYg0
	M+raCoYc0vKfTYX86Yz2QxdS81OBYpJu20V0p1QuZTY7gReshYL2+8iN1qH4=
X-Gm-Gg: AYBFou13rydYeMvlWYWkZA75kDMMyHrRiFzT5OGkqU9wH8+rK+MIOSn2M9vYSF0fBEX
	EXUf5Vj/VHajfsfbzvQOua07PDIsZ5PssUZTBNklP+xglBq9cEpKtjUX0uXn4xystw8PLNKW8gv
	rWFPFS9qUp4pKp3PbhrUK3++mrnxCI4XI39MJzmz9HJXVc1Bswos00xVCdOUm2cGUcpnVvLpkUB
	CX1lyJZzK58HOH8Uur0uOYKBOZ2O5JOETqMX7pfc1yY3rOXqZ8OHe95fP9QIVRIceQJQivu0C4Q
	aL+dzVaWRupcnjFgptIGvJTTzEK2P9oQRC3pjgIiLdV+s0Kwxm0VlDRz3Nm7sWV3gTNhaqJeK+p
	1bs+y+Y4VIHZ7SIOmXTjBDl1cSfQhTirY7EBEFEK07moWKH84
X-Received: by 2002:a05:620a:4482:b0:93e:c12c:9b73 with SMTP id af79cd13be357-940ef9dfbfemr1490757585a.78.1793099459582;
        Tue, 27 Oct 2026 04:10:59 -0700 (PDT)
X-Received: by 2002:a05:620a:4482:b0:93e:c12c:9b73 with SMTP id af79cd13be357-940ef9dfbfemr1490752985a.78.1793099458961;
        Tue, 27 Oct 2026 04:10:58 -0700 (PDT)
Received: from localhost (net-93-144-6-81.cust.dsl.teletu.it. [93.144.6.81])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a35a04ad39sm675152295e9.1.2026.10.27.04.10.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 04:10:57 -0700 (PDT)
Date: Tue, 27 Oct 2026 12:10:57 +0100
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
Subject: Re: [PATCH net 5/6] net: stmmac: fix VLAN tag stripping on short and
 non-linear RX frames
Message-ID: <auCGwWCHK6e9cbxk@lore-desk>
References: <20261023-stmmac-xdp-fixes-v1-5-efb37e19f5bd@oss.qualcomm.com>
 <179309225715.3134.11251912403308890296@kernel.org>
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
	protocol="application/pgp-signature"; boundary="cZrf2fHhcABm3x1K"
Content-Disposition: inline
In-Reply-To: <179309225715.3134.11251912403308890296@kernel.org>
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDA0NCBTYWx0ZWRfXyFMgREg6esv5
 OseCfMkG3wLyYLAyZpkPf/quAK4YoOrpDdsN71MT+QkK9EWPh5zSpUnRlwCtwLxVzVnJaFAAeny
 OFCkWN1obkJZ8MldJxNmeMHdMPtBC2o=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA0NCBTYWx0ZWRfX6qBrJxs4Euhj
 o5QStky5+rOIxtaLwM5M+rDkr0yrDlMWEW77xkkj9C8Kx5l79NxcXUHuChWMpuIJap2nblJZQo3
 iAJEqsEp6pVc7nYqh3lwJtwkuAQb8gwXHhOa6Gl9MKgJd+NK03llTCZPbyLxYU3At1u/8Vx8qmi
 tYE2ejENFHJiegqNA9G9iaO1lVWApnolGOswZNu44W2vKFgEap3fD6Hq7GULWKObQzGt+Y79vNJ
 HH2pNUlVaTKJ1JPrTTrymkeVvbn42UjYl74UZePtjI+pMlBquHF0flNue0W5DILHNWbIAQft/KV
 zGteZHBUh626mJXBzzLJt1NayWT2eBmGKym1OHhLkQZn+RrlY8uPucpd7qhHMp3lYGTz/vVvaYW
 PuuWknQIB0PgY4/pS6xNiJltTL0FbVa4kF59oTHha5AE6Mygx/tyeZEJd7OZf7PrEzkQSlOd/OG
 FxdYSRSD8pmxDBM0nzg==
X-Authority-Analysis: v=2.4 cv=PrkG/AM3 c=1 sm=1 tr=0 ts=6ae086c4 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=7fYLNvKHbgS61GKHX+yayQ==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=9R54UkLUAAAA:8
 a=EUspDBNiAAAA:8 a=kOcqg-R2egU1R50GgGQA:9 a=QEXdDO2ut3YA:10
 a=gJhHHGP7ekgXX11HjIMA:9 a=bTQJ7kPSJx9SKPbeHEYW:22 a=YTcpBFlVQWkNscrzJ_Dz:22
X-Proofpoint-ORIG-GUID: 1pyQAXzHybE2qq31JQiro1yqItOHHBzk
X-Proofpoint-GUID: 1pyQAXzHybE2qq31JQiro1yqItOHHBzk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 priorityscore=1501 phishscore=0 suspectscore=0
 impostorscore=0 clxscore=1015 adultscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610270044

--cZrf2fHhcABm3x1K
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Thank you for your contribution! Sashiko AI review found more severe
> issue(s) in other patches of this series. This mail is only an FYI, in ca=
se
> you want to address the nit picks below when you respin.
>=20
> Low priority / nit picks for your consideration:
>=20
> - [Low] In stmmac_rx_vlan()
>   (drivers/net/ethernet/stmicro/stmmac/stmmac_main.c), the patch adds an=
=E2=80=A6
>=20
> Pre-existing issues:
> - [Medium] Only one of the two stmmac RX paths that call stmmac_rx_vlan()
>   records XDP metadata in the skb.
> - [Medium] The new VLAN-error drop branch in stmmac_dispatch_skb_zc()
>   does a plain `priv->xstats.rx_dropped++` (line 5567).
>=20
> --
>=20
> net: stmmac: fix VLAN tag stripping on short and non-linear RX frames
>=20
> This patch changes stmmac_rx_vlan() so that it pulls ETH_HLEN before
> reading h_vlan_proto, and pulls VLAN_ETH_HLEN before reading the TCI. It
> returns an error so callers can drop frames that claim a VLAN tag but lack
> the full header. It also moves XDP metadata together with the MAC
> addresses when the tag is popped.
>=20
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/driver=
s/net/ethernet/stmicro/stmmac/stmmac_main.c
> > index 8a2faf50d6957..32b2c5834c340 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > @@ -5102,22 +5102,35 @@ static netdev_features_t stmmac_features_check(=
struct sk_buff *skb,
> >  	return vlan_features_check(skb, features);
> >  }
> > =20
> > -static void stmmac_rx_vlan(struct net_device *dev, struct sk_buff *skb)
> > +static int stmmac_rx_vlan(struct net_device *dev, struct sk_buff *skb)
> >  {
> > -	struct vlan_ethhdr *veth =3D skb_vlan_eth_hdr(skb);
> > -	__be16 vlan_proto =3D veth->h_vlan_proto;
> > -	u16 vlanid;
> > +	struct vlan_ethhdr *veth;
> > =20
> > -	if ((vlan_proto =3D=3D htons(ETH_P_8021Q) &&
> > +	if (!pskb_may_pull(skb, ETH_HLEN))
> > +		return -EINVAL;
>=20
> [Severity: Low]
> This pull happens before the h_vlan_proto and dev->features checks. A fra=
me
> shorter than ETH_HLEN is now freed and counted in rx_dropped by both
> stmmac_rx() and stmmac_dispatch_skb_zc(), even with CTAG/STAG RX stripping
> disabled. The hw_vlan_en branch in those callers has no matching check.
>=20
> Is that intended? The commit message says:
>=20
>     untagged frames, including short ones, are left untouched.
>=20
> That holds only for frames between ETH_HLEN and VLAN_ETH_HLEN in length.
>=20
> XDP doesn't seem able to reach this case, because bpf_xdp_adjust_head()
> and bpf_xdp_adjust_tail() both refuse to go below ETH_HLEN. Dropping such
> a runt is also arguably safer than handing it to eth_type_trans().
>=20
> Could the commit message mention that frames shorter than ETH_HLEN are now
> dropped?

ack, I will fix the commit message in v2.

>=20
> > +
> > +	veth =3D skb_vlan_eth_hdr(skb);
> > +	if ((veth->h_vlan_proto =3D=3D htons(ETH_P_8021Q) &&
> >  	     dev->features & NETIF_F_HW_VLAN_CTAG_RX) ||
> > -	    (vlan_proto =3D=3D htons(ETH_P_8021AD) &&
> > +	    (veth->h_vlan_proto =3D=3D htons(ETH_P_8021AD) &&
> >  	     dev->features & NETIF_F_HW_VLAN_STAG_RX)) {
> > +		__be16 vlan_proto =3D veth->h_vlan_proto;
> > +		u8 meta_len =3D skb_metadata_len(skb);
> > +		u16 vlanid;
> > +
> >  		/* pop the vlan tag */
> > +		if (!pskb_may_pull(skb, VLAN_ETH_HLEN))
> > +			return -EINVAL;
> > +
> > +		veth =3D skb_vlan_eth_hdr(skb);
> >  		vlanid =3D ntohs(veth->h_vlan_TCI);
> > -		memmove(skb->data + VLAN_HLEN, veth, ETH_ALEN * 2);
> > +		memmove(skb->data - meta_len + VLAN_HLEN,
> > +			skb->data - meta_len, meta_len + ETH_ALEN * 2);
>=20
> [Severity: Medium]
> This isn't a bug introduced by this patch, but skb_metadata_len() can only
> be non-zero for skbs built by stmmac_construct_skb_zc() on the AF_XDP
> zero-copy path:

This issue has not been introduced in this patch and it needs to be fixed w=
ith
a dedicated patch.

>=20
> stmmac_construct_skb_zc() {
>     ...
> 	memcpy(skb->data - metasize, xdp->data_meta, datasize + metasize);
> 	if (metasize)
> 		skb_metadata_set(skb, metasize);
>     ...
> }
>=20
> On the page_pool path, stmmac_rx() calls xdp_prepare_buff() with
> meta_valid set to true, so bpf_xdp_adjust_meta() succeeds there. The
> XDP_PASS skb is then built without recording the metadata length:
>=20
> stmmac_rx() {
>     ...
> 			/* XDP program may adjust header */
> 			head_pad_len =3D ctx.xdp.data - ctx.xdp.data_hard_start;
> 			skb_reserve(skb, head_pad_len);
> 			skb_put(skb, buf1_len);
> 			skb_mark_for_recycle(skb);
>     ...
> }
>=20
> So skb_shinfo(skb)->meta_len stays 0 for these skbs. Doesn't that mean
> metadata written by a non-ZC XDP program is lost before tc BPF can see it?
> It would also mean this memmove only moves metadata for zero-copy skbs.
>=20
> Should stmmac_rx() also call skb_metadata_set() with
> ctx.xdp.data - ctx.xdp.data_meta?
>=20
> This patch's own claim still holds on that path, since meta_len is 0
> there and data_meta cannot end up pointing at the wrong bytes.
>=20
> >  		skb_pull(skb, VLAN_HLEN);
> >  		__vlan_hwaccel_put_tag(skb, vlan_proto, vlanid);
> >  	}
> > +
> > +	return 0;
> >  }
>=20
> [ ... ]
>=20
> > @@ -5546,12 +5559,15 @@ static void stmmac_dispatch_skb_zc(struct stmma=
c_priv *priv, u32 queue,
> >  	}
> > =20
> >  	stmmac_get_rx_hwtstamp(priv, p, np, skb);
> > -	if (priv->hw->hw_vlan_en)
> > +	if (priv->hw->hw_vlan_en) {
> >  		/* MAC level stripping. */
> >  		stmmac_rx_hw_vlan(priv, priv->hw, p, skb);
> > -	else
> > -		/* Driver level stripping. */
> > -		stmmac_rx_vlan(priv->dev, skb);
> > +	} else if (stmmac_rx_vlan(priv->dev, skb)) {
> > +		dev_kfree_skb_any(skb);
> > +		priv->xstats.rx_dropped++;
>=20
> [Severity: Medium]
> This is a pre-existing issue, but priv->xstats.rx_dropped is one
> device-wide unsigned long in struct stmmac_extra_stats. Every channel's
> NAPI poll updates it with a plain read-modify-write:

This issue has not been introduced in this patch and it needs to be fixed w=
ith
a dedicated patch.

Regards,
Lorenzo

>=20
> stmmac_dispatch_skb_zc()
>     priv->xstats.rx_dropped++;
>=20
> stmmac_rx_zc() and stmmac_rx()
>     priv->xstats.rx_dropped +=3D rx_dropped;
>=20
> stmmac_napi_add() registers a separate rx_napi/rxtx_napi for each channel,
> so these polls can run at the same time on different CPUs. No lock, atomic
> or u64_stats_sync protects the counter.
>=20
> Can drop increments be lost this way? stmmac_get_stats64() also reads the
> field without READ_ONCE().
>=20
> This patch only adds one more site that follows the existing pattern.
>=20
> > +		return;
> > +	}
> > +
> >  	skb->protocol =3D eth_type_trans(skb, priv->dev);
>=20
> [ ... ]
>=20
> --=20
> Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#/patch=
set/20261023-stmmac-xdp-fixes-v1-0-efb37e19f5bd%40oss.qualcomm.com

--cZrf2fHhcABm3x1K
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCauCGwQAKCRA6cBh0uS2t
rNS8AP9vDBU1B16g84NKTu+DGkJz4a9j4jXoPXayJlU+Ccd4hwD/UxCB1EnTG7St
rJuvmD5GPjc+BNjLxoEiuLLIwhYbjQg=
=511R
-----END PGP SIGNATURE-----

--cZrf2fHhcABm3x1K--
