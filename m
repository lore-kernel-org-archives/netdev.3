Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A7A5463B94
	for <netdev@vger.kernel.org>; Mon,  7 Sep 2026 14:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788791585; cv=none; b=Sxa3PqgVi+9Orb367gUe38c+8SzfUXCCN4Wlo1/BMnfdzaIqo4/4BwzoAi4EK5B4Iiy6X80QknIpLOYWgnzWoYXYGuMysU6ck4SJvaXGwkD3pD//b9rtITf9H0nNSNrB8jNtVGdihdgD+pzQfzQrKv7DGWNmp+PtVlcqE0aGFRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788791585; c=relaxed/simple;
	bh=SPoJVQSzr8KOIAS2pjws3y4bw0Ia196I11Fa38iOuCg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V969QvkZKW0wtnnWsVHDbNrJTk1ONBaamVYY4URgN1KwZfHli+bhUFXaCDqGYXhQeHG2tYs9jt/gE0XSdNIqIu4DL7LZOz4At3kRYYMBeME6S1uT6G3HcwcTMplVkqGHWCQgdCao8tzEcWpERfFbvUEQ/GdDbd2238o1MPFuWGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MN4TGTR6; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=bF/FJeEe; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MN4TGTR6";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bF/FJeEe"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 687DdIvb243975
	for <netdev@vger.kernel.org>; Mon, 7 Sep 2026 14:32:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=2TCMyP8XrMQc0r/BjKYDu98J
	rCpBSHffI+633XaNKHA=; b=MN4TGTR6EfdTBGiaAQKVJIztksTwNw8IR2sONsHK
	Hqbf8NfNXQdzIEp2YzyHqoCjMrdTkzXGg5UZ1ljlORuh6QPfi+7wQDJmi8atlRAH
	w8qjG57oo3PJya6WWh1GZUGt6QBJdbNQZ8j99xVe3c35CAZWN96/D01vtwD54+nt
	+fv4WndyZ3DpQhzreEPoRFM0B/JWZRc5qQ1Wgaf57dLObdf9DitpaGlD7HgdDTQ8
	4XfWWQQa72u78b9Ifqk/Vvxwkt0IAD0Dph/ERhA4HNrqVtybJEL4JS698sDyeBvG
	NWVUAkxgGJ8icOfb7yxczEMUK/mRsVsOyljZ9gUUestdHA==
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com [209.85.217.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ghs86skvw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 07 Sep 2026 14:32:59 +0000 (GMT)
Received: by mail-vs1-f72.google.com with SMTP id ada2fe7eead31-7800607543dso3187516137.0
        for <netdev@vger.kernel.org>; Mon, 07 Sep 2026 07:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788791579; x=1789396379; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2TCMyP8XrMQc0r/BjKYDu98JrCpBSHffI+633XaNKHA=;
        b=bF/FJeEe+3XIwWKgd6VXPZZ0zXJ5+3qE5UmA95R1F46yuNX0F3ugUZrrz06x1yZ6Qz
         n9nJX0UYPBl2CwxrLNPOK4XkrE2gdt/DvylAxjMEHAcF4w6O+ugXO0VOvZXuWdRolXQK
         ykBNkQ6L5V/WXziGk2KBAuUTuAVE1NQcYU4p0T3rxP62Q3BIQSwFEtusIds/xLgw3uEi
         c2ceL1EVGX4BZcSh2INDbAnbYxUmvF7FsZQNJ6WEO3QuDJcz+3OnkNS71rRb2Lh3lLhm
         GmWax90WpTBsMDvpYM5rtHrGhTw4HeoRVDWOK3CmvpZImygbAvlcPj9wvAPDcIr0fVHB
         g1IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788791579; x=1789396379;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2TCMyP8XrMQc0r/BjKYDu98JrCpBSHffI+633XaNKHA=;
        b=H9ejkaONpHmlV1hAR1AuV1AGhjEQGTBrhWHQUvtMYFW16zBH4jcJxX6VhnDLuhwDfY
         rpNvnrEgu3DLIZzIsyJmSFx9ac13T4HF1/mNgCoynpgj72PCw3YZBuYAcmsvHggqmy63
         bx6UOe+a0OHVO+jIEjnyJFFWkmOOF++BklQMF094Up5mg3XQVfDZUR8kwCrdNCSOPY2O
         yicbUHlDoCxeNYe+vLYFTjKYvolvaIRT8XQC/dr/LmyjI4HTP8vBRvD4enY7k+YkP6IG
         EoOs/VMj8hJyfIUpS3Mu6G/RFc1HKriSD3Fup0mcNIYrkswsryr6zvONCxoBTA7RJnPp
         fuYw==
X-Forwarded-Encrypted: i=1; AKwUvByq9cEU8L6L9U8ABNhF5xgpoAs8+TZ1vB89bdVE5Gf6p+EKovEgxrBaouK+QGBjWQNWrW2kIbI=@vger.kernel.org
X-Gm-Message-State: AFuF++n//tPb73vKgAMztdPnU75Y9dAPv4bQ1J9HMObjDq3mWsHnoCPL
	n5bbKeUJgPcJOB9BXm9GUg8IqLOG+M3N+BX9kOPc1umvRMN4Rr/JlIF2fJlzy6JuSOh0hilzy40
	rAqUbcslc2UjCrbblyr9wUy5RoN0zq8MhIM8Ac7DnapkBRm+TT7dqO33u7hhYppoX5AM=
X-Gm-Gg: AYBFou0OY7q2W6aJCdXLxzXVFCz8XkplagaEtUA4YrSOXnZxcuDQRHzTSwGuA8tqWpx
	cufyxG0f1lvkNPJR4Y1w5Dj31IffC5OZkqeLB2b+VVuHl/Kp+Mr4xmFLnhQZk88KT4CmmVSOK6E
	f/RGBlazqdX2PvL7Wbql6ABA94pXUHCKOWaiQCUiVvkjaTjqCxlNL9ePX7GD7SUbfqtx/suabYN
	VUmAmZonJX8gSrfT3KXHJPnJ6XzqZHVEwHVJZZBfo9lBybT0xajloWiBrh3ZMkX6NwSkqLcR7Pi
	YyBnlyynddIWw506mYnJRN69UjJ6BqthPhgfNHDGxb0s7fYN+cmfnb00htcpipn3BzYp/TLiyIH
	AC97QzQcOgQgQxQ==
X-Received: by 2002:a05:6102:91a:b0:784:ed9:1a1c with SMTP id ada2fe7eead31-78a4ab66791mr10485875137.12.1788791578393;
        Mon, 07 Sep 2026 07:32:58 -0700 (PDT)
X-Received: by 2002:a05:6102:91a:b0:784:ed9:1a1c with SMTP id ada2fe7eead31-78a4ab66791mr10485805137.12.1788791576959;
        Mon, 07 Sep 2026 07:32:56 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-485885bbb51sm30172479f8f.30.2026.09.07.07.32.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 07:32:55 -0700 (PDT)
Date: Mon, 7 Sep 2026 16:32:54 +0200
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Andrew Lunn <andrew+netdev@lunn.ch>, Ido Schimmel <idosch@nvidia.com>,
        Kuniyuki Iwashima <kuniyu@google.com>,
        Artem Lytkin <iprintercanon@gmail.com>, netdev@vger.kernel.org,
        eric.dumazet@gmail.com
Subject: Re: [PATCH net-next 8/9] sit: convert configuration to RCU protection
Message-ID: <ap7LFmE1Ykohf-eM@lore-desk>
References: <20260907075846.2913645-1-edumazet@google.com>
 <20260907075846.2913645-9-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bpS6I/NS8N2E4Fgr"
Content-Disposition: inline
In-Reply-To: <20260907075846.2913645-9-edumazet@google.com>
X-Proofpoint-GUID: SoF_facFCZHQkc5-N_1XtzK6cm0Zy-hk
X-Proofpoint-ORIG-GUID: SoF_facFCZHQkc5-N_1XtzK6cm0Zy-hk
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA3MDE2MCBTYWx0ZWRfXyjmymee1xVLT
 WA6wmGdCjAxrz2RkVLFoai+ZQ1d6Rxcy3o2cWxqhLi9OxPA/ulpcrBcKpY5UWWUC/W/2DgDwl5U
 JQYWXAvtmy9ck5U3h4K1mCi0X+mHw+s=
X-Authority-Analysis: v=2.4 cv=LseiDHdc c=1 sm=1 tr=0 ts=6a9ecb1b cx=c_pps
 a=DUEm7b3gzWu7BqY5nP7+9g==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=1XWaLZrsAAAA:8 a=3ijybJMfUtJ9iVks4hkA:9 a=CjuIK1q_8ugA:10
 a=anrp6ebET3r52cRZTBYA:9 a=-aSRE8QhW-JAV6biHavz:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA3MDE2MCBTYWx0ZWRfX19L0k/Fsza2M
 R+dYo/kPfplQLISPveFffeutCcQNL1lQ9p2ht8Z3iuWPNJPLAcmirQOOINgZ5zFcOgjKBMuHSnk
 E5vdJuhi+slGgRy5QfbsrN1z7aj4SAxhZ6IJ2/EQ6JvQt7JRIyf5mVXFIf2ri/I0CnjWEBfhp+v
 AWvzB5plqE2Y0EArRR9Qj+xUaE9/ycjso4O44iClV0pPIF10ojXUNI6o3d0KdLCQFMgVsgbgH8j
 AVx/jIsyfFAEg0nsWik88HtAPAlxLaPIn7iTqAmrLY5IOVyFovU7lSno6SWB5G5y7TTs4RNjv+Q
 itAw3Kp/UYz6AmoJ21uPyb/qpIFB+T95QMpV8JsxmnT4rQ+Cqjy5bD/KfAX27FFLOBw6rxqGhCa
 wRS5cRCzOa1YstPyGHN05xWxnP5fDBxgPqtoTEgHV+F5a/W0GFIbkP8TFXNiYrxxWv0hGQ1EGpn
 PDdb5T9oYt4lsnZvP7A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-07_04,2026-09-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0
 adultscore=0 bulkscore=0 malwarescore=0 priorityscore=1501 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609070160

--bpS6I/NS8N2E4Fgr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Now that SIT parameters are dynamically allocated, convert
> tunnel->sit_parms to an RCU-protected pointer.
>=20
> Updates in ipip6_tunnel_update() allocate a new parameter block,
> publish it using rcu_assign_pointer(), and free the old one
> via kfree_rcu().
>=20
> We only need to unlink and re-link the tunnel in the hash table
> if either saddr or daddr changed. When neither address changes,
> the unhash/re-hash and synchronize_net() can be completely skipped.
>=20
> Readers in ipip6_tunnel_lookup(), ipip6_tunnel_xmit(), ipip6_err(),
> and ipip6_rcv() now safely dereference tunnel->sit_parms under RCU.

I think this patch is fine, I am just wondering if we can use more generic =
name
with respect to 'sit_parms' since I guess we have the same issue for IPIP a=
nd
IP6IP6 tunnels. Do you prefer to have dedicated pointers for them?

Acked-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>

Regards,
Lorenzo

>=20
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  include/net/ip_tunnels.h |   3 +-
>  net/ipv6/sit.c           | 245 +++++++++++++++++++++++++--------------
>  2 files changed, 157 insertions(+), 91 deletions(-)
>=20
> diff --git a/include/net/ip_tunnels.h b/include/net/ip_tunnels.h
> index f464c4480edaf35f9ace1c5081c564ce51fed636..be4cc10f88ed64114cebac7f2=
e01bea21f5419da 100644
> --- a/include/net/ip_tunnels.h
> +++ b/include/net/ip_tunnels.h
> @@ -149,6 +149,7 @@ struct ip_tunnel_parm_kern {
>  	__be32			o_key;
>  	int			link;
>  	struct iphdr		iph;
> +	struct rcu_head		rcu;
>  };
> =20
>  struct ip_tunnel {
> @@ -190,7 +191,7 @@ struct ip_tunnel {
>  #endif
>  	struct ip_tunnel_prl_entry __rcu *prl;	/* potential router list */
>  	unsigned int		prl_count;	/* # of entries in PRL */
> -	struct ip_tunnel_parm_kern *sit_parms;
> +	struct ip_tunnel_parm_kern __rcu *sit_parms;
>  	unsigned int		ip_tnl_net_id;
>  	struct gro_cells	gro_cells;
>  	__u32			fwmark;
> diff --git a/net/ipv6/sit.c b/net/ipv6/sit.c
> index dc37c7109af5324f2ced0301b289e7622dd1a55f..c9049ab87e010eed5f53a3424=
60ed10006083cd7 100644
> --- a/net/ipv6/sit.c
> +++ b/net/ipv6/sit.c
> @@ -108,24 +108,33 @@ static struct ip_tunnel *ipip6_tunnel_lookup(struct=
 net *net,
>  	int ifindex =3D dev ? dev->ifindex : 0;
> =20
>  	for_each_ip_tunnel_rcu(t, sitn->tunnels_r_l[h0 ^ h1]) {
> -		if (local =3D=3D t->sit_parms->iph.saddr &&
> -		    remote =3D=3D t->sit_parms->iph.daddr &&
> -		    (!dev || !t->sit_parms->link || ifindex =3D=3D t->sit_parms->link =
||
> -		     sifindex =3D=3D t->sit_parms->link) &&
> +		const struct ip_tunnel_parm_kern *parms;
> +
> +		parms =3D rcu_dereference(t->sit_parms);
> +		if (local =3D=3D parms->iph.saddr &&
> +		    remote =3D=3D parms->iph.daddr &&
> +		    (!dev || !parms->link || ifindex =3D=3D parms->link ||
> +		     sifindex =3D=3D parms->link) &&
>  		    (t->dev->flags & IFF_UP))
>  			return t;
>  	}
>  	for_each_ip_tunnel_rcu(t, sitn->tunnels_r[h0]) {
> -		if (remote =3D=3D t->sit_parms->iph.daddr &&
> -		    (!dev || !t->sit_parms->link || ifindex =3D=3D t->sit_parms->link =
||
> -		     sifindex =3D=3D t->sit_parms->link) &&
> +		const struct ip_tunnel_parm_kern *parms;
> +
> +		parms =3D rcu_dereference(t->sit_parms);
> +		if (remote =3D=3D parms->iph.daddr &&
> +		    (!dev || !parms->link || ifindex =3D=3D parms->link ||
> +		     sifindex =3D=3D parms->link) &&
>  		    (t->dev->flags & IFF_UP))
>  			return t;
>  	}
>  	for_each_ip_tunnel_rcu(t, sitn->tunnels_l[h1]) {
> -		if (local =3D=3D t->sit_parms->iph.saddr &&
> -		    (!dev || !t->sit_parms->link || ifindex =3D=3D t->sit_parms->link =
||
> -		     sifindex =3D=3D t->sit_parms->link) &&
> +		const struct ip_tunnel_parm_kern *parms;
> +
> +		parms =3D rcu_dereference(t->sit_parms);
> +		if (local =3D=3D parms->iph.saddr &&
> +		    (!dev || !parms->link || ifindex =3D=3D parms->link ||
> +		     sifindex =3D=3D parms->link) &&
>  		    (t->dev->flags & IFF_UP))
>  			return t;
>  	}
> @@ -157,7 +166,7 @@ __ipip6_bucket(struct sit_net *sitn, struct ip_tunnel=
_parm_kern *parms)
>  static inline struct ip_tunnel __rcu **ipip6_bucket(struct sit_net *sitn,
>  		struct ip_tunnel *t)
>  {
> -	return __ipip6_bucket(sitn, t->sit_parms);
> +	return __ipip6_bucket(sitn, rtnl_dereference(t->sit_parms));
>  }
> =20
>  static void ipip6_tunnel_unlink(struct sit_net *sitn, struct ip_tunnel *=
t)
> @@ -230,17 +239,19 @@ static int ipip6_tunnel_create(struct net_device *d=
ev)
>  {
>  	struct ip_tunnel *t =3D netdev_priv(dev);
>  	struct sit_net *sitn =3D net_generic(t->net, sit_net_id);
> +	struct ip_tunnel_parm_kern *parms;
>  	int err;
> =20
>  	err =3D ipip6_tunnel_clone_6rd(dev, sitn);
>  	if (err < 0)
>  		goto out;
> =20
> -	t->parms =3D *t->sit_parms;
> -	__dev_addr_set(dev, &t->sit_parms->iph.saddr, 4);
> -	memcpy(dev->broadcast, &t->sit_parms->iph.daddr, 4);
> +	parms =3D rtnl_dereference(t->sit_parms);
> +	t->parms =3D *parms;
> +	__dev_addr_set(dev, &parms->iph.saddr, 4);
> +	memcpy(dev->broadcast, &parms->iph.daddr, 4);
> =20
> -	if (test_bit(IP_TUNNEL_SIT_ISATAP_BIT, t->sit_parms->i_flags))
> +	if (test_bit(IP_TUNNEL_SIT_ISATAP_BIT, parms->i_flags))
>  		dev->priv_flags |=3D IFF_ISATAP;
> =20
>  	dev->rtnl_link_ops =3D &sit_link_ops;
> @@ -264,6 +275,7 @@ static struct ip_tunnel *ipip6_tunnel_locate(struct n=
et *net,
>  	__be32 local =3D parms->iph.saddr;
>  	struct ip_tunnel *t, *nt;
>  	struct ip_tunnel __rcu **tp;
> +	struct ip_tunnel_parm_kern *nt_parms;
>  	struct net_device *dev;
>  	char name[IFNAMSIZ];
>  	struct sit_net *sitn =3D net_generic(net, sit_net_id);
> @@ -271,9 +283,12 @@ static struct ip_tunnel *ipip6_tunnel_locate(struct =
net *net,
>  	for (tp =3D __ipip6_bucket(sitn, parms);
>  	    (t =3D rtnl_dereference(*tp)) !=3D NULL;
>  	     tp =3D &t->next) {
> -		if (local =3D=3D t->sit_parms->iph.saddr &&
> -		    remote =3D=3D t->sit_parms->iph.daddr &&
> -		    parms->link =3D=3D t->sit_parms->link) {
> +		const struct ip_tunnel_parm_kern *tparms;
> +
> +		tparms =3D rtnl_dereference(t->sit_parms);
> +		if (local =3D=3D tparms->iph.saddr &&
> +		    remote =3D=3D tparms->iph.daddr &&
> +		    parms->link =3D=3D tparms->link) {
>  			if (create)
>  				return NULL;
>  			else
> @@ -300,10 +315,11 @@ static struct ip_tunnel *ipip6_tunnel_locate(struct=
 net *net,
>  	nt =3D netdev_priv(dev);
> =20
>  	nt->net =3D net;
> -	nt->sit_parms =3D kmalloc_obj(*nt->sit_parms);
> -	if (!nt->sit_parms)
> +	nt_parms =3D kmalloc_obj(*nt_parms);
> +	if (!nt_parms)
>  		goto failed_free;
> -	*nt->sit_parms =3D *parms;
> +	*nt_parms =3D *parms;
> +	rcu_assign_pointer(nt->sit_parms, nt_parms);
>  	if (ipip6_tunnel_create(dev) < 0)
>  		goto failed_free;
> =20
> @@ -599,41 +615,45 @@ static int ipip6_err(struct sk_buff *skb, u32 info)
>  	err =3D -ENOENT;
> =20
>  	sifindex =3D netif_is_l3_master(skb->dev) ? IPCB(skb)->iif : 0;
> +	rcu_read_lock();
>  	t =3D ipip6_tunnel_lookup(dev_net(skb->dev), skb->dev,
>  				iph->daddr, iph->saddr, sifindex);
> -	if (!t)
> -		goto out;
> +	if (t) {
> +		const struct ip_tunnel_parm_kern *parms;
> =20
> -	if (type =3D=3D ICMP_DEST_UNREACH && code =3D=3D ICMP_FRAG_NEEDED) {
> -		ipv4_update_pmtu(skb, dev_net(skb->dev), info,
> -				 t->sit_parms->link, iph->protocol);
> -		err =3D 0;
> -		goto out;
> -	}
> -	if (type =3D=3D ICMP_REDIRECT) {
> -		ipv4_redirect(skb, dev_net(skb->dev), t->sit_parms->link,
> -			      iph->protocol);
> -		err =3D 0;
> -		goto out;
> -	}
> +		parms =3D rcu_dereference(t->sit_parms);
> +		if (type =3D=3D ICMP_DEST_UNREACH && code =3D=3D ICMP_FRAG_NEEDED) {
> +			ipv4_update_pmtu(skb, dev_net(skb->dev), info,
> +					 parms->link, iph->protocol);
> +			err =3D 0;
> +			goto out;
> +		}
> +		if (type =3D=3D ICMP_REDIRECT) {
> +			ipv4_redirect(skb, dev_net(skb->dev), parms->link,
> +				      iph->protocol);
> +			err =3D 0;
> +			goto out;
> +		}
> =20
> -	err =3D 0;
> -	if (__in6_dev_get(skb->dev) &&
> -	    !ip6_err_gen_icmpv6_unreach(skb, iph->ihl * 4, type, data_len))
> -		goto out;
> +		err =3D 0;
> +		if (__in6_dev_get(skb->dev) &&
> +		    !ip6_err_gen_icmpv6_unreach(skb, iph->ihl * 4, type, data_len))
> +			goto out;
> =20
> -	if (t->sit_parms->iph.daddr =3D=3D 0)
> -		goto out;
> +		if (parms->iph.daddr =3D=3D 0)
> +			goto out;
> =20
> -	if (t->sit_parms->iph.ttl =3D=3D 0 && type =3D=3D ICMP_TIME_EXCEEDED)
> -		goto out;
> +		if (parms->iph.ttl =3D=3D 0 && type =3D=3D ICMP_TIME_EXCEEDED)
> +			goto out;
> =20
> -	if (time_before(jiffies, READ_ONCE(t->err_time) + IPTUNNEL_ERR_TIMEO))
> -		WRITE_ONCE(t->err_count, READ_ONCE(t->err_count) + 1);
> -	else
> -		WRITE_ONCE(t->err_count, 1);
> -	WRITE_ONCE(t->err_time, jiffies);
> +		if (time_before(jiffies, READ_ONCE(t->err_time) + IPTUNNEL_ERR_TIMEO))
> +			WRITE_ONCE(t->err_count, READ_ONCE(t->err_count) + 1);
> +		else
> +			WRITE_ONCE(t->err_count, 1);
> +		WRITE_ONCE(t->err_time, jiffies);
> +	}
>  out:
> +	rcu_read_unlock();
>  	return err;
>  }
> =20
> @@ -726,8 +746,11 @@ static int ipip6_rcv(struct sk_buff *skb)
>  	tunnel =3D ipip6_tunnel_lookup(dev_net(skb->dev), skb->dev,
>  				     iph->saddr, iph->daddr, sifindex);
>  	if (tunnel) {
> -		if (tunnel->sit_parms->iph.protocol !=3D IPPROTO_IPV6 &&
> -		    tunnel->sit_parms->iph.protocol !=3D 0)
> +		const struct ip_tunnel_parm_kern *parms;
> +
> +		parms =3D rcu_dereference(tunnel->sit_parms);
> +		if (parms->iph.protocol !=3D IPPROTO_IPV6 &&
> +		    parms->iph.protocol !=3D 0)
>  			goto out;
> =20
>  		skb->mac_header =3D skb->network_header;
> @@ -800,10 +823,12 @@ static int sit_tunnel_rcv(struct sk_buff *skb, u8 i=
pproto)
>  	tunnel =3D ipip6_tunnel_lookup(dev_net(skb->dev), skb->dev,
>  				     iph->saddr, iph->daddr, sifindex);
>  	if (tunnel) {
> +		const struct ip_tunnel_parm_kern *parms;
>  		const struct tnl_ptk_info *tpi;
> =20
> -		if (tunnel->sit_parms->iph.protocol !=3D ipproto &&
> -		    tunnel->sit_parms->iph.protocol !=3D 0)
> +		parms =3D rcu_dereference(tunnel->sit_parms);
> +		if (parms->iph.protocol !=3D ipproto &&
> +		    parms->iph.protocol !=3D 0)
>  			goto drop;
> =20
>  		if (!xfrm4_policy_check(NULL, XFRM_POLICY_IN, skb))
> @@ -942,20 +967,27 @@ static netdev_tx_t ipip6_tunnel_xmit(struct sk_buff=
 *skb,
>  				     struct net_device *dev)
>  {
>  	struct ip_tunnel *tunnel =3D netdev_priv(dev);
> -	const struct iphdr  *tiph =3D &tunnel->sit_parms->iph;
> +	const struct ip_tunnel_parm_kern *parms;
> +	const struct iphdr  *tiph;
>  	const struct ipv6hdr *iph6 =3D ipv6_hdr(skb);
> -	u8     tos =3D tunnel->sit_parms->iph.tos;
> -	__be16 df =3D tiph->frag_off;
> +	u8     tos;
> +	__be16 df;
>  	struct rtable *rt;		/* Route to the other host */
>  	struct net_device *tdev;	/* Device to other host */
>  	unsigned int max_headroom;	/* The extra header space needed */
> -	__be32 dst =3D tiph->daddr;
> +	__be32 dst;
>  	int err_count, mtu;
>  	struct flowi4 fl4;
>  	u8 ttl;
>  	u8 protocol =3D IPPROTO_IPV6;
>  	int t_hlen =3D tunnel->hlen + sizeof(struct iphdr);
> =20
> +	parms =3D rcu_dereference(tunnel->sit_parms);
> +	tiph =3D &parms->iph;
> +	tos =3D parms->iph.tos;
> +	df =3D tiph->frag_off;
> +	dst =3D tiph->daddr;
> +
>  	if (tos =3D=3D 1)
>  		tos =3D ipv6_get_dsfield(iph6);
> =20
> @@ -970,7 +1002,7 @@ static netdev_tx_t ipip6_tunnel_xmit(struct sk_buff =
*skb,
>  	if (!dst && !ipip6_tunnel_dst_find(skb, &dst, false))
>  		goto tx_error;
> =20
> -	flowi4_init_output(&fl4, tunnel->sit_parms->link, READ_ONCE(tunnel->fwm=
ark),
> +	flowi4_init_output(&fl4, parms->link, READ_ONCE(tunnel->fwmark),
>  			   tos & INET_DSCP_MASK, RT_SCOPE_UNIVERSE,
>  			   IPPROTO_IPV6, 0, dst, tiph->saddr, 0, 0,
>  			   sock_net_uid(tunnel->net, NULL));
> @@ -1018,7 +1050,7 @@ static netdev_tx_t ipip6_tunnel_xmit(struct sk_buff=
 *skb,
>  			df =3D 0;
>  		}
> =20
> -		if (tunnel->sit_parms->iph.daddr)
> +		if (parms->iph.daddr)
>  			skb_dst_update_pmtu_no_confirm(skb, mtu);
> =20
>  		if (skb->len > mtu && !skb_is_gso(skb)) {
> @@ -1087,13 +1119,17 @@ static netdev_tx_t sit_tunnel_xmit__(struct sk_bu=
ff *skb,
>  				     struct net_device *dev, u8 ipproto)
>  {
>  	struct ip_tunnel *tunnel =3D netdev_priv(dev);
> -	const struct iphdr  *tiph =3D &tunnel->sit_parms->iph;
> +	const struct ip_tunnel_parm_kern *parms;
> +	const struct iphdr  *tiph;
> =20
>  	if (iptunnel_handle_offloads(skb, SKB_GSO_IPXIP4))
>  		goto tx_error;
> =20
>  	skb_set_inner_ipproto(skb, ipproto);
> =20
> +	parms =3D rcu_dereference(tunnel->sit_parms);
> +	tiph =3D &parms->iph;
> +
>  	ip_tunnel_xmit(skb, dev, tiph, ipproto);
>  	return NETDEV_TX_OK;
>  tx_error:
> @@ -1108,6 +1144,7 @@ static netdev_tx_t sit_tunnel_xmit(struct sk_buff *=
skb,
>  	if (!pskb_inet_may_pull(skb))
>  		goto tx_err;
> =20
> +	rcu_read_lock();
>  	switch (skb->protocol) {
>  	case htons(ETH_P_IP):
>  		sit_tunnel_xmit__(skb, dev, IPPROTO_IPIP);
> @@ -1121,8 +1158,10 @@ static netdev_tx_t sit_tunnel_xmit(struct sk_buff =
*skb,
>  		break;
>  #endif
>  	default:
> +		rcu_read_unlock();
>  		goto tx_err;
>  	}
> +	rcu_read_unlock();
> =20
>  	return NETDEV_TX_OK;
> =20
> @@ -1130,19 +1169,20 @@ static netdev_tx_t sit_tunnel_xmit(struct sk_buff=
 *skb,
>  	DEV_STATS_INC(dev, tx_errors);
>  	kfree_skb(skb);
>  	return NETDEV_TX_OK;
> -
>  }
> =20
>  static void ipip6_tunnel_bind_dev(struct net_device *dev)
>  {
>  	struct ip_tunnel *tunnel =3D netdev_priv(dev);
>  	int t_hlen =3D tunnel->hlen + sizeof(struct iphdr);
> +	const struct ip_tunnel_parm_kern *parms;
>  	struct net_device *tdev =3D NULL;
>  	int hlen =3D LL_MAX_HEADER;
>  	const struct iphdr *iph;
>  	struct flowi4 fl4;
> =20
> -	iph =3D &tunnel->sit_parms->iph;
> +	parms =3D rtnl_dereference(tunnel->sit_parms);
> +	iph =3D &parms->iph;
> =20
>  	if (iph->daddr) {
>  		struct rtable *rt =3D ip_route_output_ports(tunnel->net, &fl4,
> @@ -1151,7 +1191,7 @@ static void ipip6_tunnel_bind_dev(struct net_device=
 *dev)
>  							  0, 0,
>  							  IPPROTO_IPV6,
>  							  iph->tos & INET_DSCP_MASK,
> -							  tunnel->sit_parms->link);
> +							  parms->link);
> =20
>  		if (!IS_ERR(rt)) {
>  			tdev =3D rt->dst.dev;
> @@ -1160,8 +1200,8 @@ static void ipip6_tunnel_bind_dev(struct net_device=
 *dev)
>  		dev->flags |=3D IFF_POINTOPOINT;
>  	}
> =20
> -	if (!tdev && tunnel->sit_parms->link)
> -		tdev =3D __dev_get_by_index(tunnel->net, tunnel->sit_parms->link);
> +	if (!tdev && parms->link)
> +		tdev =3D __dev_get_by_index(tunnel->net, parms->link);
> =20
>  	if (tdev && !netif_is_l3_master(tdev)) {
>  		int mtu;
> @@ -1182,8 +1222,9 @@ static int ipip6_tunnel_update(struct ip_tunnel *t,
>  	struct net *net =3D t->net;
>  	struct sit_net *sitn =3D net_generic(net, sit_net_id);
>  	struct ip_tunnel_parm_kern *new_p, *old_p;
> +	bool move;
> =20
> -	old_p =3D t->sit_parms;
> +	old_p =3D rtnl_dereference(t->sit_parms);
>  	new_p =3D kmalloc_obj(*new_p);
>  	if (!new_p)
>  		return -ENOMEM;
> @@ -1194,21 +1235,29 @@ static int ipip6_tunnel_update(struct ip_tunnel *=
t,
>  	new_p->iph.tos =3D p->iph.tos;
>  	new_p->iph.frag_off =3D p->iph.frag_off;
>  	new_p->link =3D p->link;
> -	ipip6_tunnel_unlink(sitn, t);
> -	synchronize_net();
> -	t->sit_parms =3D new_p;
> +	move =3D old_p->iph.saddr !=3D p->iph.saddr ||
> +	       old_p->iph.daddr !=3D p->iph.daddr;
> +
> +	if (move)
> +		ipip6_tunnel_unlink(sitn, t);
> +
>  	t->parms.iph =3D new_p->iph;
>  	WRITE_ONCE(t->parms.link, new_p->link);
> -	__dev_addr_set(t->dev, &p->iph.saddr, 4);
> -	memcpy(t->dev->broadcast, &p->iph.daddr, 4);
> -	ipip6_tunnel_link(sitn, t);
> +	rcu_assign_pointer(t->sit_parms, new_p);
> +
> +	if (move) {
> +		synchronize_net();
> +		__dev_addr_set(t->dev, &p->iph.saddr, 4);
> +		memcpy(t->dev->broadcast, &p->iph.daddr, 4);
> +		ipip6_tunnel_link(sitn, t);
> +	}
>  	if (old_p->link !=3D p->link || t->fwmark !=3D fwmark) {
>  		WRITE_ONCE(t->fwmark, fwmark);
>  		ipip6_tunnel_bind_dev(t->dev);
>  	}
>  	dst_cache_reset(&t->dst_cache);
>  	netdev_state_change(t->dev);
> -	kfree(old_p);
> +	kfree_rcu(old_p, rcu);
>  	return 0;
>  }
> =20
> @@ -1336,12 +1385,14 @@ static int
>  ipip6_tunnel_get(struct net_device *dev, struct ip_tunnel_parm_kern *p)
>  {
>  	struct ip_tunnel *t =3D netdev_priv(dev);
> +	const struct ip_tunnel_parm_kern *parms;
> =20
>  	if (dev =3D=3D dev_to_sit_net(dev)->fb_tunnel_dev)
>  		t =3D ipip6_tunnel_locate(t->net, p, 0);
>  	if (!t)
>  		t =3D netdev_priv(dev);
> -	memcpy(p, t->sit_parms, sizeof(*p));
> +	parms =3D rtnl_dereference(t->sit_parms);
> +	memcpy(p, parms, sizeof(*p));
>  	return 0;
>  }
> =20
> @@ -1464,8 +1515,15 @@ ipip6_tunnel_siocdevprivate(struct net_device *dev=
, struct ifreq *ifr,
>  static int ipip6_get_iflink(const struct net_device *dev)
>  {
>  	struct ip_tunnel *tunnel =3D netdev_priv(dev);
> +	const struct ip_tunnel_parm_kern *parms;
> +	int link;
> =20
> -	return READ_ONCE(tunnel->sit_parms->link);
> +	rcu_read_lock();
> +	parms =3D rcu_dereference(tunnel->sit_parms);
> +	link =3D parms ? parms->link : 0;
> +	rcu_read_unlock();
> +
> +	return link;
>  }
> =20
>  static const struct net_device_ops ipip6_netdev_ops =3D {
> @@ -1480,6 +1538,7 @@ static const struct net_device_ops ipip6_netdev_ops=
 =3D {
>  static void ipip6_dev_free(struct net_device *dev)
>  {
>  	struct ip_tunnel *tunnel =3D netdev_priv(dev);
> +	struct ip_tunnel_parm_kern *parms;
>  #ifdef CONFIG_IPV6_SIT_6RD
>  	struct ip_tunnel_6rd_parm *ip6rd;
> =20
> @@ -1487,8 +1546,9 @@ static void ipip6_dev_free(struct net_device *dev)
>  	RCU_INIT_POINTER(tunnel->ip6rd, NULL);
>  	kfree(ip6rd);
>  #endif
> -	kfree(tunnel->sit_parms);
> -	tunnel->sit_parms =3D NULL;
> +	parms =3D rcu_dereference_protected(tunnel->sit_parms, 1);
> +	RCU_INIT_POINTER(tunnel->sit_parms, NULL);
> +	kfree(parms);
>  	if (tunnel->dst_cache.cache) {
>  		dst_cache_destroy(&tunnel->dst_cache);
>  		tunnel->dst_cache.cache =3D NULL;
> @@ -1528,10 +1588,12 @@ static void ipip6_tunnel_setup(struct net_device =
*dev)
>  static int ipip6_tunnel_init(struct net_device *dev)
>  {
>  	struct ip_tunnel *tunnel =3D netdev_priv(dev);
> +	struct ip_tunnel_parm_kern *parms;
>  	int err;
> =20
>  	tunnel->dev =3D dev;
> -	strscpy(tunnel->sit_parms->name, dev->name);
> +	parms =3D rtnl_dereference(tunnel->sit_parms);
> +	strscpy(parms->name, dev->name);
> =20
>  	ipip6_tunnel_bind_dev(dev);
> =20
> @@ -1549,7 +1611,6 @@ static void __net_init ipip6_fb_tunnel_init(struct =
net_device *dev)
>  	struct ip_tunnel *tunnel =3D netdev_priv(dev);
>  	struct net *net =3D dev_net(dev);
>  	struct sit_net *sitn =3D net_generic(net, sit_net_id);
> -
>  	rcu_assign_pointer(sitn->tunnels_wc[0], tunnel);
>  }
> =20
> @@ -1636,6 +1697,7 @@ static int ipip6_newlink(struct net_device *dev,
>  #ifdef CONFIG_IPV6_SIT_6RD
>  	struct ip_tunnel_6rd ip6rd;
>  #endif
> +	struct ip_tunnel_parm_kern *nt_parms;
>  	struct ip_tunnel_parm_kern p;
>  	struct net *net;
>  	int err;
> @@ -1655,10 +1717,11 @@ static int ipip6_newlink(struct net_device *dev,
>  	if (ipip6_tunnel_locate(net, &p, 0))
>  		return -EEXIST;
> =20
> -	nt->sit_parms =3D kmalloc_obj(*nt->sit_parms);
> -	if (!nt->sit_parms)
> +	nt_parms =3D kmalloc_obj(*nt_parms);
> +	if (!nt_parms)
>  		return -ENOMEM;
> -	*nt->sit_parms =3D p;
> +	*nt_parms =3D p;
> +	rcu_assign_pointer(nt->sit_parms, nt_parms);
> =20
>  	err =3D ipip6_tunnel_create(dev);
>  	if (err < 0) {
> @@ -1783,7 +1846,7 @@ static size_t ipip6_get_size(const struct net_devic=
e *dev)
>  static int ipip6_fill_info(struct sk_buff *skb, const struct net_device =
*dev)
>  {
>  	struct ip_tunnel *tunnel =3D netdev_priv(dev);
> -	struct ip_tunnel_parm_kern *parm =3D tunnel->sit_parms;
> +	const struct ip_tunnel_parm_kern *parm =3D rtnl_dereference(tunnel->sit=
_parms);
>  #ifdef CONFIG_IPV6_SIT_6RD
>  	const struct ip_tunnel_6rd_parm *ip6rd;
>  #endif
> @@ -1929,6 +1992,7 @@ static void __net_exit sit_exit_rtnl_net(struct net=
 *net, struct list_head *head
>  static int __net_init sit_init_net(struct net *net)
>  {
>  	struct sit_net *sitn =3D net_generic(net, sit_net_id);
> +	struct ip_tunnel_parm_kern *nt_parms;
>  	struct ip_tunnel *t;
>  	int err;
> =20
> @@ -1956,17 +2020,18 @@ static int __net_init sit_init_net(struct net *ne=
t)
> =20
>  	t =3D netdev_priv(sitn->fb_tunnel_dev);
>  	t->net =3D net;
> -	t->sit_parms =3D kzalloc_obj(*t->sit_parms);
> -	if (!t->sit_parms) {
> +	nt_parms =3D kzalloc_obj(*nt_parms);
> +	if (!nt_parms) {
>  		err =3D -ENOMEM;
>  		goto err_reg_dev;
>  	}
> -	t->sit_parms->iph.version	=3D 4;
> -	t->sit_parms->iph.protocol	=3D IPPROTO_IPV6;
> -	t->sit_parms->iph.ihl		=3D 5;
> -	t->sit_parms->iph.ttl		=3D 64;
> -	strscpy(t->sit_parms->name, sitn->fb_tunnel_dev->name);
> -	t->parms =3D *t->sit_parms;
> +	nt_parms->iph.version	=3D 4;
> +	nt_parms->iph.protocol	=3D IPPROTO_IPV6;
> +	nt_parms->iph.ihl	=3D 5;
> +	nt_parms->iph.ttl	=3D 64;
> +	strscpy(nt_parms->name, sitn->fb_tunnel_dev->name);
> +	t->parms =3D *nt_parms;
> +	rcu_assign_pointer(t->sit_parms, nt_parms);
> =20
>  	err =3D ipip6_tunnel_clone_6rd(sitn->fb_tunnel_dev, sitn);
>  	if (err < 0)
> --=20
> 2.55.0.979.g7e5102b832-goog
>=20

--bpS6I/NS8N2E4Fgr
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCap7LFgAKCRA6cBh0uS2t
rD5fAP9NymkXcAD9Lj0I3S/EwqlFwj+28/ptFcmkAHZBNMjfPwD/WY1QqrQME4Ze
24aiyyMrCx3Xd5ZcP3yihGjVND9lFAA=
=9n4c
-----END PGP SIGNATURE-----

--bpS6I/NS8N2E4Fgr--
