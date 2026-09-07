Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A1E24CB8A8
	for <netdev@vger.kernel.org>; Mon,  7 Sep 2026 13:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788787020; cv=none; b=D533bMuhCF+JsJb+OvvH7Q3REjlFFPMq6Ibw3d41mKq/7HdzBA7rXLtum7m5X3CjN3vg5mluU6EvtyYgU90Azd7n45I4aM2VYuIMokCZ2o3pZSGmhQMPuUqKONuA6SD/4VzNgGpPGo4z/+xeQH6ZH2NOekE/k3G1e2Nc2SGGF9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788787020; c=relaxed/simple;
	bh=fNZNUYsPLpY1yyczMHi5cp5pwGaxLWVPNj2W+le9gHw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h73KWR6P7dLsy6Cc8fLj/pM8y3VnK1CUnGR6dJP1vKT2AxRRqfUd4/pDkGZzPqRJ4B6F2fI5c+1SROL/xvIjJoQfLZVPI1XByxjITARjngnPFHRYt9Tgv5OhoTGhLBNiQ39Tyjf9rs5bD0glwOJ1gj4JFy6paIevOFZm1vyrJ6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cROf9ivF; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=cotIBXBA; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cROf9ivF";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cotIBXBA"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 687Amu3l3349019
	for <netdev@vger.kernel.org>; Mon, 7 Sep 2026 13:16:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=7cxYnp1/fdPbmcLVBKj59bRa
	KaL44ltFhbBncqJaBqI=; b=cROf9ivFhAqUJ2+jEDqpf5HzDJ30/0b+wHvRNkiV
	SRAv57q9IlYIxeV76hIvhIxPLEHqRJ+Y156JfQ7r2/hqpP6KIMAVJ5jBC+BTSo/R
	WNY2uxJ8rXo9pIOH7iJD3Rm8dzlDZMCboCS2AQXg+a18GSZ3sJNZPfioZSHPfUWz
	fRfZu1AqzNhUqxeMAB/aQrPYVGGptRMMEyR3R8M6tqfOGxvFODfIcJK7cijiMPPY
	r1rEFhUjQNV+R8n53y/4UjzEoidsNV8nl2xmRH/QTQlMWINnY/IqRmOK7yC2yYnT
	jTCWCTua0YzFi9SqeieQbVrb/bQQ6T9U82IW4a5/nMtbxg==
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com [209.85.217.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ghtfx0wu5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 07 Sep 2026 13:16:54 +0000 (GMT)
Received: by mail-vs1-f72.google.com with SMTP id ada2fe7eead31-74748e3a5b6so3941796137.1
        for <netdev@vger.kernel.org>; Mon, 07 Sep 2026 06:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788787013; x=1789391813; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7cxYnp1/fdPbmcLVBKj59bRaKaL44ltFhbBncqJaBqI=;
        b=cotIBXBAUa7dYsOyIqR1zsgq+6n6dWt2UiNoBlImkHB2kn0tS0j//2rCUDE9GzrU2b
         jNCgzyI8wr4XbnFYPMoX+kJllFcS+zKx13CKIpIS1Lhdvn4FsOKXfhI44+28KtgUj+ZR
         d959vao8QQk/yCGyuVOgEPxU4OId6OL5gg6aG6G5520EVPJPmyhBo+gpNJQafg42EA98
         21/Bs2tUjehWkLdHXa6sIfYDMWZdP2e8OsoxWU1aWRxO1xSeEofF1bFsTftwt+umByLa
         9Qq4QE7QavaaOnwOXKsQMEKrlnrt9ePKqMUTdX5E1MqRGL5QnTOrhd+G1EaIP0iXrFZc
         7RDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788787013; x=1789391813;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7cxYnp1/fdPbmcLVBKj59bRaKaL44ltFhbBncqJaBqI=;
        b=Ge7Vz4Ruzmop1TLNYEqCkofGCYW2/HyeyTVeWIL9hzC7f8FsAVXFz5qM1nVYAIbKcV
         sL6yxgFiANl6+ExbZTIqCxlVmaH3em0p23uv/WQrBw9k8hRXKGeCAiyLv5/4WPw/FCrH
         kukDDOOxpDCEMGy5x38abDAr4DHZ7S5bNIX9Wfnxd/w3TrbcIWxEp/X42TULdwIrPdKv
         YYOBeQluBozqaUMBaIR+PX82OYPIEH0fa/PNWG1bSdZmWGz2WoQF2PtsOigW3yncm49L
         oOEfc7lVBkT8DAzogMv1vLd8cM3sQYOrj69lymbGQH40UbGCqcAQ6O2Ygg2hhP5IG9Jl
         QuYA==
X-Forwarded-Encrypted: i=1; AKwUvBwdmsy3V8lZfmStco7HKUhUcjBgCb2colNWprnlYAkR6KyzckSQs375UMnAMQTp1BztsVNmKrk=@vger.kernel.org
X-Gm-Message-State: AFuF++kTKnwm6jkXze0VqZgopEsEXc8rSeOhDMxiwOeuDnpCyOm5XNXt
	I8I8pa1uVvyedeBqPdfvVGOXdeum9rJ5aOag1Pq89vro3wpvdux+giuN/8CJMDywaWpg9p1F6Ne
	xorRmCVPGaHLlLyDntvMxLuLQOysigeV+C1VrtpwKsNYz30fyPyNV+VJ1A4w=
X-Gm-Gg: AYBFou19aX0MlGb0I+6HXz5weI23ww84bWVQfimKIQRkyaLcqkrPjK4ET0HOGAW7new
	3LFQf/sjSlY8lHFU5QgtV/Y0X3tN9XrC9PHYA2REyFoMwsXV9JhEIsZ/DiXHtb46lOQ8eNQLukI
	dc21LnAVxYKt4Ovm8NCqpV4rZ7MRhqw+8xm3cwAD6RLHlRHLgYkIL8lMCb5fSJs1WGze53UWTO1
	cPtCa6BtxZN0V4L94oM2gkC0u7F005h8zNnJSKf+1inf4v5XR6OoOg4rCLzsqsudEKug2OpWFcK
	5/1fiub8gP/PaZzBHxqfCVoM3jd2NqqUxfGmzuGinbQz99MuD+sCZb9sQVhU1TqzW3y/qG1MAIx
	7VLdoA90Jy/V0WA==
X-Received: by 2002:a67:fe50:0:b0:78a:5bc0:4b7b with SMTP id ada2fe7eead31-78a5bc06bd8mr3195394137.21.1788787012893;
        Mon, 07 Sep 2026 06:16:52 -0700 (PDT)
X-Received: by 2002:a67:fe50:0:b0:78a:5bc0:4b7b with SMTP id ada2fe7eead31-78a5bc06bd8mr3195384137.21.1788787012350;
        Mon, 07 Sep 2026 06:16:52 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c260d55b306sm476593166b.36.2026.09.07.06.16.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 06:16:51 -0700 (PDT)
Date: Mon, 7 Sep 2026 15:16:50 +0200
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Andrew Lunn <andrew+netdev@lunn.ch>, Ido Schimmel <idosch@nvidia.com>,
        Kuniyuki Iwashima <kuniyu@google.com>,
        Artem Lytkin <iprintercanon@gmail.com>, netdev@vger.kernel.org,
        eric.dumazet@gmail.com
Subject: Re: [PATCH net-next 7/9] sit: dynamically allocate struct
 ip_tunnel_parm_kern
Message-ID: <ap65QjcEcJH5WzM-@lore-desk>
References: <20260907075846.2913645-1-edumazet@google.com>
 <20260907075846.2913645-8-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3WoZ257kpkKD8uGg"
Content-Disposition: inline
In-Reply-To: <20260907075846.2913645-8-edumazet@google.com>
X-Authority-Analysis: v=2.4 cv=Weg8rUhX c=1 sm=1 tr=0 ts=6a9eb946 cx=c_pps
 a=DUEm7b3gzWu7BqY5nP7+9g==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=1XWaLZrsAAAA:8
 a=EUspDBNiAAAA:8 a=L2lgOi-PmCkVlpEUzxsA:9 a=CjuIK1q_8ugA:10
 a=ea47RRLtzFubEdNBzVQA:9 a=-aSRE8QhW-JAV6biHavz:22
X-Proofpoint-GUID: dHyBsxvzqlzCmG_u3JncbfGW75XSsGId
X-Proofpoint-ORIG-GUID: dHyBsxvzqlzCmG_u3JncbfGW75XSsGId
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA3MDE0NiBTYWx0ZWRfX5DiXB1mtSA4Q
 oSilvauUJlBSe5J0WHVZHRLvsdX6EnGaCc9pOLwpEcesRTurUMt5t0mfamrWGzDotUX6+19vDN+
 RR8EeyXG0Lab2FJoFN2DAk6ocLpv5ts=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA3MDE0NiBTYWx0ZWRfX9GvsXZhC4cri
 FMTpuKdg9yrILUWq+vE2saPd9SQT7G89fTSwYBr5ifg5HAlf25PfEbq8lsUl/u04d+Tb/197u4J
 5Fl56qTPT7j4r3L2foGWUfdkH8SxC3SGK4HsuZdZ9jRVgouIHdaOpdDH1c5nAJIFDiYMJUDFCuc
 7X3xvU0KsgjFwbXlVlGP1sD/tBIvQKF+MMoH7k4dhdYea6krN/Bd348CgM9iyxN2Y9mDDoHaEZ3
 fbPhYlo4N2qv3k26J3FRJXfPr9ZAkjf3053XbVwrcht+rgHIQLV4k4tKIxpabwHsrf66y/paISm
 l7mt8KKZsOM6EmHtGD2ebYJMnvB01J9L6MeKwocCoyL+EGDljQyyxxJDUsuoqHAE5KrR7IZ9rn3
 GAIGbX5HcCKfIFyk/AOWHSnmGF68yTvSAYXJjxRI9o5uQDwkugM6sIy5jQ5n9kEVQJQiyQ52b9C
 d5h5SjlQEgx2Jzoq0hA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-07_03,2026-09-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 suspectscore=0 phishscore=0
 bulkscore=0 spamscore=0 adultscore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609070146

--3WoZ257kpkKD8uGg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> In preparation for converting SIT configuration parameters to RCU,
> dynamically allocate struct ip_tunnel_parm_kern as sit_parms in
> struct ip_tunnel.
>=20
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Acked-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>

> ---
>  include/net/ip_tunnels.h |   1 +
>  net/ipv6/sit.c           | 152 +++++++++++++++++++++++----------------
>  2 files changed, 92 insertions(+), 61 deletions(-)
>=20
> diff --git a/include/net/ip_tunnels.h b/include/net/ip_tunnels.h
> index 7fff59bab53b682ac0d1efd1f47082ba7d633fd2..f464c4480edaf35f9ace1c508=
1c564ce51fed636 100644
> --- a/include/net/ip_tunnels.h
> +++ b/include/net/ip_tunnels.h
> @@ -190,6 +190,7 @@ struct ip_tunnel {
>  #endif
>  	struct ip_tunnel_prl_entry __rcu *prl;	/* potential router list */
>  	unsigned int		prl_count;	/* # of entries in PRL */
> +	struct ip_tunnel_parm_kern *sit_parms;
>  	unsigned int		ip_tnl_net_id;
>  	struct gro_cells	gro_cells;
>  	__u32			fwmark;
> diff --git a/net/ipv6/sit.c b/net/ipv6/sit.c
> index 35c6695909014a2c335f1de7afb48f07b7c91c39..dc37c7109af5324f2ced0301b=
289e7622dd1a55f 100644
> --- a/net/ipv6/sit.c
> +++ b/net/ipv6/sit.c
> @@ -108,24 +108,24 @@ static struct ip_tunnel *ipip6_tunnel_lookup(struct=
 net *net,
>  	int ifindex =3D dev ? dev->ifindex : 0;
> =20
>  	for_each_ip_tunnel_rcu(t, sitn->tunnels_r_l[h0 ^ h1]) {
> -		if (local =3D=3D t->parms.iph.saddr &&
> -		    remote =3D=3D t->parms.iph.daddr &&
> -		    (!dev || !t->parms.link || ifindex =3D=3D t->parms.link ||
> -		     sifindex =3D=3D t->parms.link) &&
> +		if (local =3D=3D t->sit_parms->iph.saddr &&
> +		    remote =3D=3D t->sit_parms->iph.daddr &&
> +		    (!dev || !t->sit_parms->link || ifindex =3D=3D t->sit_parms->link =
||
> +		     sifindex =3D=3D t->sit_parms->link) &&
>  		    (t->dev->flags & IFF_UP))
>  			return t;
>  	}
>  	for_each_ip_tunnel_rcu(t, sitn->tunnels_r[h0]) {
> -		if (remote =3D=3D t->parms.iph.daddr &&
> -		    (!dev || !t->parms.link || ifindex =3D=3D t->parms.link ||
> -		     sifindex =3D=3D t->parms.link) &&
> +		if (remote =3D=3D t->sit_parms->iph.daddr &&
> +		    (!dev || !t->sit_parms->link || ifindex =3D=3D t->sit_parms->link =
||
> +		     sifindex =3D=3D t->sit_parms->link) &&
>  		    (t->dev->flags & IFF_UP))
>  			return t;
>  	}
>  	for_each_ip_tunnel_rcu(t, sitn->tunnels_l[h1]) {
> -		if (local =3D=3D t->parms.iph.saddr &&
> -		    (!dev || !t->parms.link || ifindex =3D=3D t->parms.link ||
> -		     sifindex =3D=3D t->parms.link) &&
> +		if (local =3D=3D t->sit_parms->iph.saddr &&
> +		    (!dev || !t->sit_parms->link || ifindex =3D=3D t->sit_parms->link =
||
> +		     sifindex =3D=3D t->sit_parms->link) &&
>  		    (t->dev->flags & IFF_UP))
>  			return t;
>  	}
> @@ -157,7 +157,7 @@ __ipip6_bucket(struct sit_net *sitn, struct ip_tunnel=
_parm_kern *parms)
>  static inline struct ip_tunnel __rcu **ipip6_bucket(struct sit_net *sitn,
>  		struct ip_tunnel *t)
>  {
> -	return __ipip6_bucket(sitn, &t->parms);
> +	return __ipip6_bucket(sitn, t->sit_parms);
>  }
> =20
>  static void ipip6_tunnel_unlink(struct sit_net *sitn, struct ip_tunnel *=
t)
> @@ -236,10 +236,11 @@ static int ipip6_tunnel_create(struct net_device *d=
ev)
>  	if (err < 0)
>  		goto out;
> =20
> -	__dev_addr_set(dev, &t->parms.iph.saddr, 4);
> -	memcpy(dev->broadcast, &t->parms.iph.daddr, 4);
> +	t->parms =3D *t->sit_parms;
> +	__dev_addr_set(dev, &t->sit_parms->iph.saddr, 4);
> +	memcpy(dev->broadcast, &t->sit_parms->iph.daddr, 4);
> =20
> -	if (test_bit(IP_TUNNEL_SIT_ISATAP_BIT, t->parms.i_flags))
> +	if (test_bit(IP_TUNNEL_SIT_ISATAP_BIT, t->sit_parms->i_flags))
>  		dev->priv_flags |=3D IFF_ISATAP;
> =20
>  	dev->rtnl_link_ops =3D &sit_link_ops;
> @@ -270,9 +271,9 @@ static struct ip_tunnel *ipip6_tunnel_locate(struct n=
et *net,
>  	for (tp =3D __ipip6_bucket(sitn, parms);
>  	    (t =3D rtnl_dereference(*tp)) !=3D NULL;
>  	     tp =3D &t->next) {
> -		if (local =3D=3D t->parms.iph.saddr &&
> -		    remote =3D=3D t->parms.iph.daddr &&
> -		    parms->link =3D=3D t->parms.link) {
> +		if (local =3D=3D t->sit_parms->iph.saddr &&
> +		    remote =3D=3D t->sit_parms->iph.daddr &&
> +		    parms->link =3D=3D t->sit_parms->link) {
>  			if (create)
>  				return NULL;
>  			else
> @@ -299,7 +300,10 @@ static struct ip_tunnel *ipip6_tunnel_locate(struct =
net *net,
>  	nt =3D netdev_priv(dev);
> =20
>  	nt->net =3D net;
> -	nt->parms =3D *parms;
> +	nt->sit_parms =3D kmalloc_obj(*nt->sit_parms);
> +	if (!nt->sit_parms)
> +		goto failed_free;
> +	*nt->sit_parms =3D *parms;
>  	if (ipip6_tunnel_create(dev) < 0)
>  		goto failed_free;
> =20
> @@ -602,12 +606,12 @@ static int ipip6_err(struct sk_buff *skb, u32 info)
> =20
>  	if (type =3D=3D ICMP_DEST_UNREACH && code =3D=3D ICMP_FRAG_NEEDED) {
>  		ipv4_update_pmtu(skb, dev_net(skb->dev), info,
> -				 t->parms.link, iph->protocol);
> +				 t->sit_parms->link, iph->protocol);
>  		err =3D 0;
>  		goto out;
>  	}
>  	if (type =3D=3D ICMP_REDIRECT) {
> -		ipv4_redirect(skb, dev_net(skb->dev), t->parms.link,
> +		ipv4_redirect(skb, dev_net(skb->dev), t->sit_parms->link,
>  			      iph->protocol);
>  		err =3D 0;
>  		goto out;
> @@ -618,10 +622,10 @@ static int ipip6_err(struct sk_buff *skb, u32 info)
>  	    !ip6_err_gen_icmpv6_unreach(skb, iph->ihl * 4, type, data_len))
>  		goto out;
> =20
> -	if (t->parms.iph.daddr =3D=3D 0)
> +	if (t->sit_parms->iph.daddr =3D=3D 0)
>  		goto out;
> =20
> -	if (t->parms.iph.ttl =3D=3D 0 && type =3D=3D ICMP_TIME_EXCEEDED)
> +	if (t->sit_parms->iph.ttl =3D=3D 0 && type =3D=3D ICMP_TIME_EXCEEDED)
>  		goto out;
> =20
>  	if (time_before(jiffies, READ_ONCE(t->err_time) + IPTUNNEL_ERR_TIMEO))
> @@ -722,8 +726,8 @@ static int ipip6_rcv(struct sk_buff *skb)
>  	tunnel =3D ipip6_tunnel_lookup(dev_net(skb->dev), skb->dev,
>  				     iph->saddr, iph->daddr, sifindex);
>  	if (tunnel) {
> -		if (tunnel->parms.iph.protocol !=3D IPPROTO_IPV6 &&
> -		    tunnel->parms.iph.protocol !=3D 0)
> +		if (tunnel->sit_parms->iph.protocol !=3D IPPROTO_IPV6 &&
> +		    tunnel->sit_parms->iph.protocol !=3D 0)
>  			goto out;
> =20
>  		skb->mac_header =3D skb->network_header;
> @@ -798,8 +802,8 @@ static int sit_tunnel_rcv(struct sk_buff *skb, u8 ipp=
roto)
>  	if (tunnel) {
>  		const struct tnl_ptk_info *tpi;
> =20
> -		if (tunnel->parms.iph.protocol !=3D ipproto &&
> -		    tunnel->parms.iph.protocol !=3D 0)
> +		if (tunnel->sit_parms->iph.protocol !=3D ipproto &&
> +		    tunnel->sit_parms->iph.protocol !=3D 0)
>  			goto drop;
> =20
>  		if (!xfrm4_policy_check(NULL, XFRM_POLICY_IN, skb))
> @@ -938,9 +942,9 @@ static netdev_tx_t ipip6_tunnel_xmit(struct sk_buff *=
skb,
>  				     struct net_device *dev)
>  {
>  	struct ip_tunnel *tunnel =3D netdev_priv(dev);
> -	const struct iphdr  *tiph =3D &tunnel->parms.iph;
> +	const struct iphdr  *tiph =3D &tunnel->sit_parms->iph;
>  	const struct ipv6hdr *iph6 =3D ipv6_hdr(skb);
> -	u8     tos =3D tunnel->parms.iph.tos;
> +	u8     tos =3D tunnel->sit_parms->iph.tos;
>  	__be16 df =3D tiph->frag_off;
>  	struct rtable *rt;		/* Route to the other host */
>  	struct net_device *tdev;	/* Device to other host */
> @@ -966,7 +970,7 @@ static netdev_tx_t ipip6_tunnel_xmit(struct sk_buff *=
skb,
>  	if (!dst && !ipip6_tunnel_dst_find(skb, &dst, false))
>  		goto tx_error;
> =20
> -	flowi4_init_output(&fl4, tunnel->parms.link, READ_ONCE(tunnel->fwmark),
> +	flowi4_init_output(&fl4, tunnel->sit_parms->link, READ_ONCE(tunnel->fwm=
ark),
>  			   tos & INET_DSCP_MASK, RT_SCOPE_UNIVERSE,
>  			   IPPROTO_IPV6, 0, dst, tiph->saddr, 0, 0,
>  			   sock_net_uid(tunnel->net, NULL));
> @@ -1014,7 +1018,7 @@ static netdev_tx_t ipip6_tunnel_xmit(struct sk_buff=
 *skb,
>  			df =3D 0;
>  		}
> =20
> -		if (tunnel->parms.iph.daddr)
> +		if (tunnel->sit_parms->iph.daddr)
>  			skb_dst_update_pmtu_no_confirm(skb, mtu);
> =20
>  		if (skb->len > mtu && !skb_is_gso(skb)) {
> @@ -1083,7 +1087,7 @@ static netdev_tx_t sit_tunnel_xmit__(struct sk_buff=
 *skb,
>  				     struct net_device *dev, u8 ipproto)
>  {
>  	struct ip_tunnel *tunnel =3D netdev_priv(dev);
> -	const struct iphdr  *tiph =3D &tunnel->parms.iph;
> +	const struct iphdr  *tiph =3D &tunnel->sit_parms->iph;
> =20
>  	if (iptunnel_handle_offloads(skb, SKB_GSO_IPXIP4))
>  		goto tx_error;
> @@ -1138,7 +1142,7 @@ static void ipip6_tunnel_bind_dev(struct net_device=
 *dev)
>  	const struct iphdr *iph;
>  	struct flowi4 fl4;
> =20
> -	iph =3D &tunnel->parms.iph;
> +	iph =3D &tunnel->sit_parms->iph;
> =20
>  	if (iph->daddr) {
>  		struct rtable *rt =3D ip_route_output_ports(tunnel->net, &fl4,
> @@ -1147,7 +1151,7 @@ static void ipip6_tunnel_bind_dev(struct net_device=
 *dev)
>  							  0, 0,
>  							  IPPROTO_IPV6,
>  							  iph->tos & INET_DSCP_MASK,
> -							  tunnel->parms.link);
> +							  tunnel->sit_parms->link);
> =20
>  		if (!IS_ERR(rt)) {
>  			tdev =3D rt->dst.dev;
> @@ -1156,8 +1160,8 @@ static void ipip6_tunnel_bind_dev(struct net_device=
 *dev)
>  		dev->flags |=3D IFF_POINTOPOINT;
>  	}
> =20
> -	if (!tdev && tunnel->parms.link)
> -		tdev =3D __dev_get_by_index(tunnel->net, tunnel->parms.link);
> +	if (!tdev && tunnel->sit_parms->link)
> +		tdev =3D __dev_get_by_index(tunnel->net, tunnel->sit_parms->link);
> =20
>  	if (tdev && !netif_is_l3_master(tdev)) {
>  		int mtu;
> @@ -1171,30 +1175,41 @@ static void ipip6_tunnel_bind_dev(struct net_devi=
ce *dev)
>  	dev->needed_headroom =3D ip_tunnel_limit_headroom(t_hlen + hlen);
>  }
> =20
> -static void ipip6_tunnel_update(struct ip_tunnel *t,
> -				struct ip_tunnel_parm_kern *p,
> -				__u32 fwmark)
> +static int ipip6_tunnel_update(struct ip_tunnel *t,
> +			       struct ip_tunnel_parm_kern *p,
> +			       __u32 fwmark)
>  {
>  	struct net *net =3D t->net;
>  	struct sit_net *sitn =3D net_generic(net, sit_net_id);
> +	struct ip_tunnel_parm_kern *new_p, *old_p;
> =20
> +	old_p =3D t->sit_parms;
> +	new_p =3D kmalloc_obj(*new_p);
> +	if (!new_p)
> +		return -ENOMEM;
> +	*new_p =3D *old_p;
> +	new_p->iph.saddr =3D p->iph.saddr;
> +	new_p->iph.daddr =3D p->iph.daddr;
> +	new_p->iph.ttl =3D p->iph.ttl;
> +	new_p->iph.tos =3D p->iph.tos;
> +	new_p->iph.frag_off =3D p->iph.frag_off;
> +	new_p->link =3D p->link;
>  	ipip6_tunnel_unlink(sitn, t);
>  	synchronize_net();
> -	t->parms.iph.saddr =3D p->iph.saddr;
> -	t->parms.iph.daddr =3D p->iph.daddr;
> +	t->sit_parms =3D new_p;
> +	t->parms.iph =3D new_p->iph;
> +	WRITE_ONCE(t->parms.link, new_p->link);
>  	__dev_addr_set(t->dev, &p->iph.saddr, 4);
>  	memcpy(t->dev->broadcast, &p->iph.daddr, 4);
>  	ipip6_tunnel_link(sitn, t);
> -	t->parms.iph.ttl =3D p->iph.ttl;
> -	t->parms.iph.tos =3D p->iph.tos;
> -	t->parms.iph.frag_off =3D p->iph.frag_off;
> -	if (t->parms.link !=3D p->link || t->fwmark !=3D fwmark) {
> -		t->parms.link =3D p->link;
> +	if (old_p->link !=3D p->link || t->fwmark !=3D fwmark) {
>  		WRITE_ONCE(t->fwmark, fwmark);
>  		ipip6_tunnel_bind_dev(t->dev);
>  	}
>  	dst_cache_reset(&t->dst_cache);
>  	netdev_state_change(t->dev);
> +	kfree(old_p);
> +	return 0;
>  }
> =20
>  #ifdef CONFIG_IPV6_SIT_6RD
> @@ -1326,7 +1341,7 @@ ipip6_tunnel_get(struct net_device *dev, struct ip_=
tunnel_parm_kern *p)
>  		t =3D ipip6_tunnel_locate(t->net, p, 0);
>  	if (!t)
>  		t =3D netdev_priv(dev);
> -	memcpy(p, &t->parms, sizeof(*p));
> +	memcpy(p, t->sit_parms, sizeof(*p));
>  	return 0;
>  }
> =20
> @@ -1371,7 +1386,9 @@ ipip6_tunnel_change(struct net_device *dev, struct =
ip_tunnel_parm_kern *p)
>  			t =3D netdev_priv(dev);
>  		}
> =20
> -		ipip6_tunnel_update(t, p, t->fwmark);
> +		err =3D ipip6_tunnel_update(t, p, t->fwmark);
> +		if (err)
> +			return err;
>  	}
> =20
>  	return 0;
> @@ -1448,7 +1465,7 @@ static int ipip6_get_iflink(const struct net_device=
 *dev)
>  {
>  	struct ip_tunnel *tunnel =3D netdev_priv(dev);
> =20
> -	return READ_ONCE(tunnel->parms.link);
> +	return READ_ONCE(tunnel->sit_parms->link);
>  }
> =20
>  static const struct net_device_ops ipip6_netdev_ops =3D {
> @@ -1470,6 +1487,8 @@ static void ipip6_dev_free(struct net_device *dev)
>  	RCU_INIT_POINTER(tunnel->ip6rd, NULL);
>  	kfree(ip6rd);
>  #endif
> +	kfree(tunnel->sit_parms);
> +	tunnel->sit_parms =3D NULL;
>  	if (tunnel->dst_cache.cache) {
>  		dst_cache_destroy(&tunnel->dst_cache);
>  		tunnel->dst_cache.cache =3D NULL;
> @@ -1512,7 +1531,7 @@ static int ipip6_tunnel_init(struct net_device *dev)
>  	int err;
> =20
>  	tunnel->dev =3D dev;
> -	strscpy(tunnel->parms.name, dev->name);
> +	strscpy(tunnel->sit_parms->name, dev->name);
> =20
>  	ipip6_tunnel_bind_dev(dev);
> =20
> @@ -1528,15 +1547,9 @@ static int ipip6_tunnel_init(struct net_device *de=
v)
>  static void __net_init ipip6_fb_tunnel_init(struct net_device *dev)
>  {
>  	struct ip_tunnel *tunnel =3D netdev_priv(dev);
> -	struct iphdr *iph =3D &tunnel->parms.iph;
>  	struct net *net =3D dev_net(dev);
>  	struct sit_net *sitn =3D net_generic(net, sit_net_id);
> =20
> -	iph->version		=3D 4;
> -	iph->protocol		=3D IPPROTO_IPV6;
> -	iph->ihl		=3D 5;
> -	iph->ttl		=3D 64;
> -
>  	rcu_assign_pointer(sitn->tunnels_wc[0], tunnel);
>  }
> =20
> @@ -1623,6 +1636,7 @@ static int ipip6_newlink(struct net_device *dev,
>  #ifdef CONFIG_IPV6_SIT_6RD
>  	struct ip_tunnel_6rd ip6rd;
>  #endif
> +	struct ip_tunnel_parm_kern p;
>  	struct net *net;
>  	int err;
> =20
> @@ -1636,11 +1650,16 @@ static int ipip6_newlink(struct net_device *dev,
>  			return err;
>  	}
> =20
> -	ipip6_netlink_parms(data, &nt->parms, &nt->fwmark);
> +	ipip6_netlink_parms(data, &p, &nt->fwmark);
> =20
> -	if (ipip6_tunnel_locate(net, &nt->parms, 0))
> +	if (ipip6_tunnel_locate(net, &p, 0))
>  		return -EEXIST;
> =20
> +	nt->sit_parms =3D kmalloc_obj(*nt->sit_parms);
> +	if (!nt->sit_parms)
> +		return -ENOMEM;
> +	*nt->sit_parms =3D p;
> +
>  	err =3D ipip6_tunnel_create(dev);
>  	if (err < 0) {
>  		ipip6_dev_free(dev);
> @@ -1707,7 +1726,9 @@ static int ipip6_changelink(struct net_device *dev,=
 struct nlattr *tb[],
>  	} else
>  		t =3D netdev_priv(dev);
> =20
> -	ipip6_tunnel_update(t, &p, fwmark);
> +	err =3D ipip6_tunnel_update(t, &p, fwmark);
> +	if (err)
> +		return err;
> =20
>  #ifdef CONFIG_IPV6_SIT_6RD
>  	if (ipip6_netlink_6rd_parms(data, &ip6rd))
> @@ -1762,7 +1783,7 @@ static size_t ipip6_get_size(const struct net_devic=
e *dev)
>  static int ipip6_fill_info(struct sk_buff *skb, const struct net_device =
*dev)
>  {
>  	struct ip_tunnel *tunnel =3D netdev_priv(dev);
> -	struct ip_tunnel_parm_kern *parm =3D &tunnel->parms;
> +	struct ip_tunnel_parm_kern *parm =3D tunnel->sit_parms;
>  #ifdef CONFIG_IPV6_SIT_6RD
>  	const struct ip_tunnel_6rd_parm *ip6rd;
>  #endif
> @@ -1935,6 +1956,17 @@ static int __net_init sit_init_net(struct net *net)
> =20
>  	t =3D netdev_priv(sitn->fb_tunnel_dev);
>  	t->net =3D net;
> +	t->sit_parms =3D kzalloc_obj(*t->sit_parms);
> +	if (!t->sit_parms) {
> +		err =3D -ENOMEM;
> +		goto err_reg_dev;
> +	}
> +	t->sit_parms->iph.version	=3D 4;
> +	t->sit_parms->iph.protocol	=3D IPPROTO_IPV6;
> +	t->sit_parms->iph.ihl		=3D 5;
> +	t->sit_parms->iph.ttl		=3D 64;
> +	strscpy(t->sit_parms->name, sitn->fb_tunnel_dev->name);
> +	t->parms =3D *t->sit_parms;
> =20
>  	err =3D ipip6_tunnel_clone_6rd(sitn->fb_tunnel_dev, sitn);
>  	if (err < 0)
> @@ -1945,8 +1977,6 @@ static int __net_init sit_init_net(struct net *net)
>  		goto err_reg_dev;
> =20
>  	ipip6_fb_tunnel_init(sitn->fb_tunnel_dev);
> -
> -	strscpy(t->parms.name, sitn->fb_tunnel_dev->name);
>  	return 0;
> =20
>  err_reg_dev:
> --=20
> 2.55.0.979.g7e5102b832-goog
>=20

--3WoZ257kpkKD8uGg
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCap65QgAKCRA6cBh0uS2t
rDL7AP4nnA/zALORQpTGyLWFlxOJRpvt+t9SYeswuj3pTS+y8QEAyit4mQy189xx
5tQ8bz3K8Nyl5nWU49R00gf1LY3CYAI=
=vTo6
-----END PGP SIGNATURE-----

--3WoZ257kpkKD8uGg--
