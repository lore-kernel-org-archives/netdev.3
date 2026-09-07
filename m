Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 805624CA78C
	for <netdev@vger.kernel.org>; Mon,  7 Sep 2026 13:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788786039; cv=none; b=l4I5KDRXfLKFgD+gWrXuqlckXqv6oMPmG7UjxoLjwuH5fbBZDcydPssr6vqKuOfN5lVNdvUMFTDpIdHNSvu+WYLC5GTCMt8+UGjV+tUgHy1pEU1TXxgFzKrWqPuwuMUYfP/nJ05uT7Z4+u9Esyjgc4+V1C0bpxp7oYuh7FH2aD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788786039; c=relaxed/simple;
	bh=uV/T222xyHYqFY8s2WZKlGfhLKeb8QaCatEz+hfZPtE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=arwOE2rLilZqB2TtwIVgxzHcUjKAbx0g9dkIRxHxf3O7uuR0RcFXbYWHwobQwPYGMOy1WgJTnVlknQ0LWFOAuP7Eo+GgsNKtLLvPM6NcJ6osTcrvTzSlOV6bfm6e4ZBbZzlagLBmBe3aEWhHKEGw4S+XB5EKwgVGdEg/nxam6AQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lijHa/yv; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Gt9sdWZQ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lijHa/yv";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Gt9sdWZQ"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 687AnX1F217830
	for <netdev@vger.kernel.org>; Mon, 7 Sep 2026 13:00:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=Z/vSMldP6/afltLGuyAhDK6u
	tLlSjsNlh8bw34br99U=; b=lijHa/yv8UqjNSNTeFN8dG5TYzEauE6LkP0rE+iN
	DGcU1slp7wLghp7tBV1MBjlLNdyxq0GKLq2giYeTehLi+wMCPOyphvZhGYFbBuuC
	f4z4+K5CyvmLB42SYD+hqeYfdOrC4SyWksXLRwbYngpVS15fZrVqks3cvzy/uPiv
	po7eA6xKpAsfALZgmbrsksChnU3oVhrbaSRk7Rewb9jp0PAZFgPIJU4BdIzGsID2
	8yEkjwjgfe/Afp+WlDgirzD1sRjCL8mFviAUsRLUttyH25cQ0ZAq/UrJ6ZOMuKwN
	hkiP9qd2RdMiupt4VOCYZ/M3uq/gZOczboxm7Nsiy7XaJQ==
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com [209.85.222.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ghtdqgvv3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 07 Sep 2026 13:00:24 +0000 (GMT)
Received: by mail-ua1-f71.google.com with SMTP id a1e0cc1a2514c-97e98448895so287680241.0
        for <netdev@vger.kernel.org>; Mon, 07 Sep 2026 06:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788786023; x=1789390823; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Z/vSMldP6/afltLGuyAhDK6utLlSjsNlh8bw34br99U=;
        b=Gt9sdWZQPdnnfzIWjolPhv0qgeNLLKu1uwusdRJ9iAjykIv0VeiR7xHOjJd4+JEuY3
         +/s37uzPgbcts1qHGS7KkfD+WP/MUEg+qymsaW2oLMIOgfnH7Pe6HVEPNfMuRPPMn8ZH
         JN8w71WbN72pwtxII3w9TBGqvoRLnstYw23JNhZArsJQ76SuEpKZEnneYU1BXt9k0Wf4
         fZovfpME/6QpJYMMH2RiIx8ovZzVhDH30Ziuo1S2MhJ9N11TdO2ZMzUTMWJovgfZoK6H
         km7hxYPlW+zG7uRrQqh2LRdOdof2iF7bjlwbISieQkNPl3SxUpqaqbsP9QFjaTj0N5nM
         0NZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788786023; x=1789390823;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Z/vSMldP6/afltLGuyAhDK6utLlSjsNlh8bw34br99U=;
        b=CTjPSh1bPimPLtEZWFdF7i/8Dm9fTKCjsD4ogFmFXEe4cSuxFvVYO1SQJ1bvK9K604
         Uk6UQZ2wofj+p6D/wCbPLKCdI49S4Dm8Su0FX5ETg+T66piaTUdURSDKYLagGxgNWtom
         U+TVpC31sBtiBDs51OEVSGBq6tWvsmazeI30kJBc9upsnrijzCPIjU/AWsOXK4a/+Mxr
         /gL0x2BB1/BXLh6nTY3G73PWRpDSHLWWiE8lBLmW6HUbJsyPapRcwRVte2uiPrcCM1SD
         2rX8eh5ZsOC1/z0vOJ25508qrkpfG0NeOypBRpf1Fr5FBGS+F3ZyDsglK1IxHcYSZXIW
         NFog==
X-Forwarded-Encrypted: i=1; AKwUvBy9pNSvGnTo0IvZmc4f6rRFk+OkAEOAlWHi7veCiPG1SCilu3KjO5uD2JME+T8nndEdkQzstsI=@vger.kernel.org
X-Gm-Message-State: AFuF++mIfupTB0jU0bahVVrNt9jMhomXsNc7JjZG1wMFq/pJ79gWqD3C
	H+xNm28/kmB6nvqyPB5EtGJOAg8JY70QUSTHBD2qfAXEAZOtlsa1hGArCGIj2/+5vR248L1eIdy
	uL1rjzX6u+2bnHakZC08qS9+/Kh8yLLrtdQWgpBOLRje0OdXzQkIf40nbAoo=
X-Gm-Gg: AYBFou3WHk+gJHaxz6E73nwbvQeT8yXzcEgjuyBIVwCASIFjTdFNoCXkcGObtkZvmSl
	Pc4CcxUOyF7oBjx2w8IDRReWN846evERRzZm3ngic85r/h4tL312btwKm4AB7ApvDGhuhjKcgOJ
	IP64aNL8cA3myfQzCtRFR+wzw6SptgTpBbYOVYI/47rz+CzttLLPa3di1SfdiYw6EjNU8S+Ws4N
	BSVxjJGUgcWman/S+O0s7Pbn8vzE92wHpVRuKldak+kbNi2wbfz2vulu8VUhCdngLYG7oP5Nza/
	RerZ5hzT4AAIuPYQ71UKOaMrvTiO3L84WTyiBbaOsWUHm/x0diPexGcnJeD1VTTsNJVh5d85FaJ
	ZQpoHJvxknMT9YQ==
X-Received: by 2002:a05:6102:3749:b0:785:39f2:d80c with SMTP id ada2fe7eead31-78a4a8bb3f4mr5644589137.1.1788786023357;
        Mon, 07 Sep 2026 06:00:23 -0700 (PDT)
X-Received: by 2002:a05:6102:3749:b0:785:39f2:d80c with SMTP id ada2fe7eead31-78a4a8bb3f4mr5644548137.1.1788786022707;
        Mon, 07 Sep 2026 06:00:22 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3a3705cd8d5sm27183971fa.37.2026.09.07.06.00.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 06:00:21 -0700 (PDT)
Date: Mon, 7 Sep 2026 15:00:20 +0200
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Andrew Lunn <andrew+netdev@lunn.ch>, Ido Schimmel <idosch@nvidia.com>,
        Kuniyuki Iwashima <kuniyu@google.com>,
        Artem Lytkin <iprintercanon@gmail.com>, netdev@vger.kernel.org,
        eric.dumazet@gmail.com
Subject: Re: [PATCH net-next 5/9] sit: convert 6RD configuration to RCU
 protection
Message-ID: <ap61ZOQyfReeUxG7@lore-desk>
References: <20260907075846.2913645-1-edumazet@google.com>
 <20260907075846.2913645-6-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gTduhO05Ktq7xxei"
Content-Disposition: inline
In-Reply-To: <20260907075846.2913645-6-edumazet@google.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA3MDE0MyBTYWx0ZWRfX019U972uYcSj
 RNic9LCKKrJVFTAR48D/gByT8U/MndRDrNlHU45PFH3T+jzQsAqBhbayr4ZVZF/+LhStM3fGFFA
 X4nb8C5FLYTOibN6LNOWwTnHH6A06eoudniIjMv47BaTTX3oDEyMinG2RWdPLsMV61FMysg18eH
 gbkJbi1z4NR3zYD9Eh6i5CXMsqSl/RnRJ4e3PHQX3xRPBXMSlqX4bcJ9YdpaKYpnkr5JQgBfFL0
 QsJyzTu/u4+SaFz0qIFOZUVhyMAII8qom51rfNlNAn9+b6FHkgm3NBYKECJaPDcgB70aoVMRDjk
 kJJMv2xB21xGHOz/LE1zMyzVGn0Zu4UQkH055yVakIue8Dkep0eQ7iIb18iuO8ic7JFtKLCFTGD
 EpWW7XRxJU7lImlomtW95oSXTwqS0cwKcrwCDBT0A9ft7cUNmxzgXcsRjtTRSqchB6bYQUOmBCW
 Ti/pAZUPCtAf9oToHSQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA3MDE0MyBTYWx0ZWRfX3g2uTH8RNG7k
 ViL8hKU7IjifzhKB9PalRcXaSwQlhc0+Q9h8EgcnJT+Vxenj/QXq5VOa+Isr9M/J/w4ewwxRt5e
 rOi3owP/5mESiXCEuAybBFuWLjc4zp0=
X-Proofpoint-ORIG-GUID: k99ZW0A0eR_TB8PnGSRLJrlAwyimdFQw
X-Authority-Analysis: v=2.4 cv=U6aiy+ru c=1 sm=1 tr=0 ts=6a9eb568 cx=c_pps
 a=KB4UBwrhAZV1kjiGHFQexw==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=1XWaLZrsAAAA:8
 a=EUspDBNiAAAA:8 a=aOBhWw8Kd3hFnX07ui8A:9 a=CjuIK1q_8ugA:10
 a=5rZ0nc4ELQA4AeqonDYA:9 a=o1xkdb1NAhiiM49bd1HK:22
X-Proofpoint-GUID: k99ZW0A0eR_TB8PnGSRLJrlAwyimdFQw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-07_03,2026-09-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 impostorscore=0 phishscore=0 clxscore=1015
 lowpriorityscore=0 malwarescore=0 priorityscore=1501 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609070143

--gTduhO05Ktq7xxei
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> In order to allow lockless readers in future patches, convert
> 'tunnel->ip6rd' to an RCU protected pointer.
>=20
> Updating 6RD configuration via ipip6_tunnel_update_6rd() or
> ipip6_tunnel_clone_6rd() now allocates a struct ip_tunnel_6rd_parm and
> uses rcu_assign_pointer() to publish it, freeing the previous
> parameters with kfree_rcu().
>=20
> Readers in check_6rd() and only_dnatted() use rcu_dereference() under
> existing RCU read lock, preventing torn reads on the 128-bit IPv6
> prefix.
>=20
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Hi Eric,

just few nits inline.

Acked-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>

Regards,
Lorenzo

> ---
>  include/net/ip_tunnels.h |   3 +-
>  net/ipv6/sit.c           | 160 ++++++++++++++++++++++++++++-----------
>  2 files changed, 117 insertions(+), 46 deletions(-)
>=20
> diff --git a/include/net/ip_tunnels.h b/include/net/ip_tunnels.h
> index 7c9aadfe8fe396da10a47e93499a97141ac04f4c..7fff59bab53b682ac0d1efd1f=
47082ba7d633fd2 100644
> --- a/include/net/ip_tunnels.h
> +++ b/include/net/ip_tunnels.h
> @@ -127,6 +127,7 @@ struct ip_tunnel_6rd_parm {
>  	__be32			relay_prefix;
>  	u16			prefixlen;
>  	u16			relay_prefixlen;
> +	struct rcu_head		rcu;
>  };
>  #endif
> =20
> @@ -185,7 +186,7 @@ struct ip_tunnel {
> =20
>  	/* for SIT */
>  #ifdef CONFIG_IPV6_SIT_6RD
> -	struct ip_tunnel_6rd_parm ip6rd;
> +	struct ip_tunnel_6rd_parm __rcu *ip6rd;
>  #endif
>  	struct ip_tunnel_prl_entry __rcu *prl;	/* potential router list */
>  	unsigned int		prl_count;	/* # of entries in PRL */
> diff --git a/net/ipv6/sit.c b/net/ipv6/sit.c
> index e85fa80e80d1ad2c593b860685b9f5bac21e66d9..7cabcd3afbc4f06d9a08374e6=
d8df2fb1bfb9676 100644
> --- a/net/ipv6/sit.c
> +++ b/net/ipv6/sit.c
> @@ -183,21 +183,47 @@ static void ipip6_tunnel_link(struct sit_net *sitn,=
 struct ip_tunnel *t)
>  	rcu_assign_pointer(*tp, t);
>  }
> =20
> -static void ipip6_tunnel_clone_6rd(struct net_device *dev, struct sit_ne=
t *sitn)
> +static int ipip6_tunnel_clone_6rd(struct net_device *dev, struct sit_net=
 *sitn)
>  {
>  #ifdef CONFIG_IPV6_SIT_6RD
>  	struct ip_tunnel *t =3D netdev_priv(dev);
> +	struct ip_tunnel_6rd_parm *new_6rd, *old_6rd;

RCT

> +
> +	new_6rd =3D kmalloc_obj(*new_6rd);

what about using kzalloc_obj() and get rid of the 0 initialization? This is
just control path, so I guess it is fine.

> +	if (!new_6rd)
> +		return -ENOMEM;
> =20
>  	if (dev =3D=3D sitn->fb_tunnel_dev || !sitn->fb_tunnel_dev) {
> -		ipv6_addr_set(&t->ip6rd.prefix, htonl(0x20020000), 0, 0, 0);
> -		t->ip6rd.relay_prefix =3D 0;
> -		t->ip6rd.prefixlen =3D 16;
> -		t->ip6rd.relay_prefixlen =3D 0;
> +		ipv6_addr_set(&new_6rd->prefix, htonl(0x20020000), 0, 0, 0);
> +		new_6rd->relay_prefix =3D 0;
> +		new_6rd->prefixlen =3D 16;
> +		new_6rd->relay_prefixlen =3D 0;
>  	} else {
>  		struct ip_tunnel *t0 =3D netdev_priv(sitn->fb_tunnel_dev);
> -		memcpy(&t->ip6rd, &t0->ip6rd, sizeof(t->ip6rd));
> +		struct ip_tunnel_6rd_parm *t0_6rd;
> +
> +		t0_6rd =3D rtnl_dereference(t0->ip6rd);
> +		if (t0_6rd) {
> +			*new_6rd =3D *t0_6rd;
> +		} else {
> +			ipv6_addr_set(&new_6rd->prefix, htonl(0x20020000), 0, 0, 0);
> +			new_6rd->relay_prefix =3D 0;
> +			new_6rd->prefixlen =3D 16;
> +			new_6rd->relay_prefixlen =3D 0;
> +		}
> +	}
> +
> +	old_6rd =3D rcu_dereference_protected(t->ip6rd,
> +					    lockdep_rtnl_is_held() ||
> +					    dev->reg_state =3D=3D NETREG_UNINITIALIZED);
> +	rcu_assign_pointer(t->ip6rd, new_6rd);

what about using rcu_replace_pointer()?

> +	if (old_6rd) {
> +		dst_cache_reset(&t->dst_cache);
> +		netdev_state_change(t->dev);
> +		kfree_rcu(old_6rd, rcu);
>  	}
>  #endif
> +	return 0;
>  }
> =20
>  static int ipip6_tunnel_create(struct net_device *dev)
> @@ -206,6 +232,10 @@ static int ipip6_tunnel_create(struct net_device *de=
v)
>  	struct sit_net *sitn =3D net_generic(t->net, sit_net_id);
>  	int err;
> =20
> +	err =3D ipip6_tunnel_clone_6rd(dev, sitn);
> +	if (err < 0)
> +		goto out;

I guess you can just return err here.

> +
>  	__dev_addr_set(dev, &t->parms.iph.saddr, 4);
>  	memcpy(dev->broadcast, &t->parms.iph.daddr, 4);
> =20
> @@ -218,8 +248,6 @@ static int ipip6_tunnel_create(struct net_device *dev)
>  	if (err < 0)
>  		goto out;
> =20
> -	ipip6_tunnel_clone_6rd(dev, sitn);
> -
>  	ipip6_tunnel_link(sitn, t);
>  	return 0;
> =20
> @@ -281,6 +309,7 @@ static struct ip_tunnel *ipip6_tunnel_locate(struct n=
et *net,
>  	return nt;
> =20
>  failed_free:
> +	ipip6_dev_free(dev);
>  	free_netdev(dev);
>  failed:
>  	return NULL;
> @@ -631,8 +660,13 @@ static bool only_dnatted(const struct ip_tunnel *tun=
nel,
>  	int prefix_len;
> =20
>  #ifdef CONFIG_IPV6_SIT_6RD
> -	prefix_len =3D tunnel->ip6rd.prefixlen + 32
> -		- tunnel->ip6rd.relay_prefixlen;
> +	const struct ip_tunnel_6rd_parm *ip6rd;
> +
> +	ip6rd =3D rcu_dereference(tunnel->ip6rd);
> +	if (ip6rd)
> +		prefix_len =3D ip6rd->prefixlen + 32 - ip6rd->relay_prefixlen;
> +	else
> +		prefix_len =3D 48;
>  #else
>  	prefix_len =3D 48;
>  #endif
> @@ -810,25 +844,28 @@ static bool check_6rd(struct ip_tunnel *tunnel, con=
st struct in6_addr *v6dst,
>  		      __be32 *v4dst)
>  {
>  #ifdef CONFIG_IPV6_SIT_6RD
> -	if (ipv6_prefix_equal(v6dst, &tunnel->ip6rd.prefix,
> -			      tunnel->ip6rd.prefixlen)) {
> +	const struct ip_tunnel_6rd_parm *ip6rd;
> +
> +	ip6rd =3D rcu_dereference(tunnel->ip6rd);
> +	if (ip6rd && ipv6_prefix_equal(v6dst, &ip6rd->prefix,
> +				       ip6rd->prefixlen)) {
>  		unsigned int pbw0, pbi0;
>  		int pbi1;
>  		u32 d;
> =20
> -		pbw0 =3D tunnel->ip6rd.prefixlen >> 5;
> -		pbi0 =3D tunnel->ip6rd.prefixlen & 0x1f;
> +		pbw0 =3D ip6rd->prefixlen >> 5;
> +		pbi0 =3D ip6rd->prefixlen & 0x1f;
> =20
> -		d =3D tunnel->ip6rd.relay_prefixlen < 32 ?
> +		d =3D ip6rd->relay_prefixlen < 32 ?
>  			(ntohl(v6dst->s6_addr32[pbw0]) << pbi0) >>
> -		    tunnel->ip6rd.relay_prefixlen : 0;
> +		    ip6rd->relay_prefixlen : 0;
> =20
> -		pbi1 =3D pbi0 - tunnel->ip6rd.relay_prefixlen;
> +		pbi1 =3D pbi0 - ip6rd->relay_prefixlen;
>  		if (pbi1 > 0)
>  			d |=3D ntohl(v6dst->s6_addr32[pbw0 + 1]) >>
>  			     (32 - pbi1);
> =20
> -		*v4dst =3D tunnel->ip6rd.relay_prefix | htonl(d);
> +		*v4dst =3D ip6rd->relay_prefix | htonl(d);
>  		return true;
>  	}
>  #else
> @@ -1164,6 +1201,7 @@ static void ipip6_tunnel_update(struct ip_tunnel *t,
>  static int ipip6_tunnel_update_6rd(struct ip_tunnel *t,
>  				   struct ip_tunnel_6rd *ip6rd)
>  {
> +	struct ip_tunnel_6rd_parm *new_6rd, *old_6rd;
>  	struct in6_addr prefix;
>  	__be32 relay_prefix;
> =20
> @@ -1183,10 +1221,20 @@ static int ipip6_tunnel_update_6rd(struct ip_tunn=
el *t,
>  	if (relay_prefix !=3D ip6rd->relay_prefix)
>  		return -EINVAL;
> =20
> -	t->ip6rd.prefix =3D prefix;
> -	t->ip6rd.relay_prefix =3D relay_prefix;
> -	t->ip6rd.prefixlen =3D ip6rd->prefixlen;
> -	t->ip6rd.relay_prefixlen =3D ip6rd->relay_prefixlen;
> +	new_6rd =3D kmalloc_obj(*new_6rd);
> +	if (!new_6rd)
> +		return -ENOMEM;
> +
> +	new_6rd->prefix =3D prefix;
> +	new_6rd->relay_prefix =3D relay_prefix;
> +	new_6rd->prefixlen =3D ip6rd->prefixlen;
> +	new_6rd->relay_prefixlen =3D ip6rd->relay_prefixlen;
> +
> +	old_6rd =3D rtnl_dereference(t->ip6rd);
> +	rcu_assign_pointer(t->ip6rd, new_6rd);

rcu_replace_pointer()?

> +	if (old_6rd)
> +		kfree_rcu(old_6rd, rcu);
> +
>  	dst_cache_reset(&t->dst_cache);
>  	netdev_state_change(t->dev);
>  	return 0;
> @@ -1195,6 +1243,7 @@ static int ipip6_tunnel_update_6rd(struct ip_tunnel=
 *t,
>  static int
>  ipip6_tunnel_get6rd(struct net_device *dev, struct ip_tunnel_parm __user=
 *data)
>  {
> +	const struct ip_tunnel_6rd_parm *ip6rd_parm;
>  	struct ip_tunnel *t =3D netdev_priv(dev);
>  	struct ip_tunnel_parm_kern p;
>  	struct ip_tunnel_6rd ip6rd;
> @@ -1207,10 +1256,15 @@ ipip6_tunnel_get6rd(struct net_device *dev, struc=
t ip_tunnel_parm __user *data)
>  	if (!t)
>  		t =3D netdev_priv(dev);
> =20
> -	ip6rd.prefix =3D t->ip6rd.prefix;
> -	ip6rd.relay_prefix =3D t->ip6rd.relay_prefix;
> -	ip6rd.prefixlen =3D t->ip6rd.prefixlen;
> -	ip6rd.relay_prefixlen =3D t->ip6rd.relay_prefixlen;
> +	ip6rd_parm =3D rtnl_dereference(t->ip6rd);
> +	if (ip6rd_parm) {
> +		ip6rd.prefix =3D ip6rd_parm->prefix;
> +		ip6rd.relay_prefix =3D ip6rd_parm->relay_prefix;
> +		ip6rd.prefixlen =3D ip6rd_parm->prefixlen;
> +		ip6rd.relay_prefixlen =3D ip6rd_parm->relay_prefixlen;
> +	} else {
> +		memset(&ip6rd, 0, sizeof(ip6rd));
> +	}
>  	if (copy_to_user(data, &ip6rd, sizeof(ip6rd)))
>  		return -EFAULT;
>  	return 0;
> @@ -1222,20 +1276,16 @@ ipip6_tunnel_6rdctl(struct net_device *dev, struc=
t ip_tunnel_6rd __user *data,
>  {
>  	struct ip_tunnel *t =3D netdev_priv(dev);
>  	struct ip_tunnel_6rd ip6rd;
> -	int err;
> =20
>  	if (!ns_capable(t->net->user_ns, CAP_NET_ADMIN))
>  		return -EPERM;
>  	if (copy_from_user(&ip6rd, data, sizeof(ip6rd)))
>  		return -EFAULT;
> =20
> -	if (cmd !=3D SIOCDEL6RD) {
> -		err =3D ipip6_tunnel_update_6rd(t, &ip6rd);
> -		if (err < 0)
> -			return err;
> -	} else
> -		ipip6_tunnel_clone_6rd(dev, dev_to_sit_net(dev));
> -	return 0;
> +	if (cmd !=3D SIOCDEL6RD)
> +		return ipip6_tunnel_update_6rd(t, &ip6rd);
> +
> +	return ipip6_tunnel_clone_6rd(dev, dev_to_sit_net(dev));
>  }
> =20
>  #endif /* CONFIG_IPV6_SIT_6RD */
> @@ -1406,8 +1456,17 @@ static const struct net_device_ops ipip6_netdev_op=
s =3D {
>  static void ipip6_dev_free(struct net_device *dev)
>  {
>  	struct ip_tunnel *tunnel =3D netdev_priv(dev);
> +#ifdef CONFIG_IPV6_SIT_6RD
> +	struct ip_tunnel_6rd_parm *ip6rd;
> =20
> -	dst_cache_destroy(&tunnel->dst_cache);
> +	ip6rd =3D rcu_dereference_protected(tunnel->ip6rd, 1);
> +	RCU_INIT_POINTER(tunnel->ip6rd, NULL);
> +	kfree(ip6rd);
> +#endif
> +	if (tunnel->dst_cache.cache) {
> +		dst_cache_destroy(&tunnel->dst_cache);
> +		tunnel->dst_cache.cache =3D NULL;
> +	}
>  }
> =20
>  #define SIT_FEATURES (NETIF_F_SG	   | \
> @@ -1576,8 +1635,10 @@ static int ipip6_newlink(struct net_device *dev,
>  		return -EEXIST;
> =20
>  	err =3D ipip6_tunnel_create(dev);
> -	if (err < 0)
> +	if (err < 0) {
> +		ipip6_dev_free(dev);
>  		return err;
> +	}
> =20
>  	if (tb[IFLA_MTU]) {
>  		u32 mtu =3D nla_get_u32(tb[IFLA_MTU]);
> @@ -1695,6 +1756,9 @@ static int ipip6_fill_info(struct sk_buff *skb, con=
st struct net_device *dev)
>  {
>  	struct ip_tunnel *tunnel =3D netdev_priv(dev);
>  	struct ip_tunnel_parm_kern *parm =3D &tunnel->parms;
> +#ifdef CONFIG_IPV6_SIT_6RD
> +	const struct ip_tunnel_6rd_parm *ip6rd;
> +#endif
> =20
>  	if (nla_put_u32(skb, IFLA_IPTUN_LINK, parm->link) ||
>  	    nla_put_in_addr(skb, IFLA_IPTUN_LOCAL, parm->iph.saddr) ||
> @@ -1710,14 +1774,16 @@ static int ipip6_fill_info(struct sk_buff *skb, c=
onst struct net_device *dev)
>  		goto nla_put_failure;
> =20
>  #ifdef CONFIG_IPV6_SIT_6RD
> -	if (nla_put_in6_addr(skb, IFLA_IPTUN_6RD_PREFIX,
> -			     &tunnel->ip6rd.prefix) ||
> -	    nla_put_in_addr(skb, IFLA_IPTUN_6RD_RELAY_PREFIX,
> -			    tunnel->ip6rd.relay_prefix) ||
> -	    nla_put_u16(skb, IFLA_IPTUN_6RD_PREFIXLEN,
> -			tunnel->ip6rd.prefixlen) ||
> -	    nla_put_u16(skb, IFLA_IPTUN_6RD_RELAY_PREFIXLEN,
> -			tunnel->ip6rd.relay_prefixlen))
> +	ip6rd =3D rcu_dereference_rtnl(tunnel->ip6rd);
> +	if (ip6rd &&
> +	    (nla_put_in6_addr(skb, IFLA_IPTUN_6RD_PREFIX,
> +			      &ip6rd->prefix) ||
> +	     nla_put_in_addr(skb, IFLA_IPTUN_6RD_RELAY_PREFIX,
> +			     ip6rd->relay_prefix) ||
> +	     nla_put_u16(skb, IFLA_IPTUN_6RD_PREFIXLEN,
> +			 ip6rd->prefixlen) ||
> +	     nla_put_u16(skb, IFLA_IPTUN_6RD_RELAY_PREFIXLEN,
> +			 ip6rd->relay_prefixlen)))
>  		goto nla_put_failure;
>  #endif
> =20
> @@ -1863,17 +1929,21 @@ static int __net_init sit_init_net(struct net *ne=
t)
>  	t =3D netdev_priv(sitn->fb_tunnel_dev);
>  	t->net =3D net;
> =20
> +	err =3D ipip6_tunnel_clone_6rd(sitn->fb_tunnel_dev, sitn);
> +	if (err < 0)
> +		goto err_reg_dev;
> +
>  	err =3D register_netdev(sitn->fb_tunnel_dev);
>  	if (err)
>  		goto err_reg_dev;
> =20
> -	ipip6_tunnel_clone_6rd(sitn->fb_tunnel_dev, sitn);
>  	ipip6_fb_tunnel_init(sitn->fb_tunnel_dev);
> =20
>  	strscpy(t->parms.name, sitn->fb_tunnel_dev->name);
>  	return 0;
> =20
>  err_reg_dev:
> +	ipip6_dev_free(sitn->fb_tunnel_dev);
>  	free_netdev(sitn->fb_tunnel_dev);
>  err_alloc_dev:
>  	return err;
> --=20
> 2.55.0.979.g7e5102b832-goog
>=20

--gTduhO05Ktq7xxei
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCap61ZAAKCRA6cBh0uS2t
rEvrAP9pUKzRkQTC5wG3VCM4XAEE4IucLwLEk+UyIdb3dO9YfgEA2bhpZgHkTHww
qVm2RHGqpwvREiH+I1wAP2hagTXzzgo=
=KRkf
-----END PGP SIGNATURE-----

--gTduhO05Ktq7xxei--
