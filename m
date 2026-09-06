Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B34522E2EEE
	for <netdev@vger.kernel.org>; Sun,  6 Sep 2026 17:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788716221; cv=none; b=hJCduwXi9kBOKpTne+5USm2gjm8dUNv43MhFANSlfE1qXUCzPCMLGB6u6DuLpXKLkq79pu5tiM80qYXd1rAcjLN+2WmmG5PsDDHbf+KdQRzZocJJ7284bMairWiVINQeUDbk5Ho9rKKqEpX1Le+CzYOvGN6gIAgzSsrAQn9Ikjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788716221; c=relaxed/simple;
	bh=jEAjKAprW49FuLp+uW6WDFYcRYxohywLdFKifo/CH0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SLphPm2YjJQ5D4EdBzaH1LcN/ETya0x2ymnGAS3NFiXhDDxXLDWQ/NDuwQwvIwJGGzREp6PX5gd2Zii6B/wen0KnOUqYWfYpUOPpqIQiFQHMbLYqeBXDKhdg2j0Om/AGvsuLihQ1thhCk7aXw9QclAhX8QC4Q1lszkSxa8EObpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=boUN3CMv; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=DItr78fK; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="boUN3CMv";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DItr78fK"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 686EWltf1301394
	for <netdev@vger.kernel.org>; Sun, 6 Sep 2026 17:36:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=NNyWJkHCyIpLbg0Yf199LEoK
	feIaby0BO4TsA7+gw/0=; b=boUN3CMv5HjLxFMIariADe3e74p4khxdB4IKWMq1
	71QmqZgIXw+7nhqby9Ds+cqSkt3zNsJEv2wtVcPmVwb4ue4VWOezO1KM/6qAB4M/
	PWFxSYBdEEnHgCqHawtoT7QUXYHPjvz06lhw9Hz3m8IP4CLFzWGxRnESC+lzEy8F
	7bMgLZ2dqaeSACAfqh09wWRxUmxRF5/d0PD9Vj4H+IchN+9MPyJRvItUmgv5UalK
	G+8pzUntMBLVCJwG9WIBFsiVGnQnO5S0qQqCiZvXontU9z7H/DrgwfTyAt8ZEN8B
	chpU8TD19OukKUcFN3SbtBN4cv3wiiVpbaRSu+zflGUqRg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ggba3kx4e-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Sun, 06 Sep 2026 17:36:53 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-9375d92d8cdso565031385a.2
        for <netdev@vger.kernel.org>; Sun, 06 Sep 2026 10:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788716213; x=1789321013; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NNyWJkHCyIpLbg0Yf199LEoKfeIaby0BO4TsA7+gw/0=;
        b=DItr78fKJjCmeo+3YcYuYa2zgOQnf2m4hYr+vgG1SQGaXMCWc2CplO8rIVLfRknWYo
         Rsxk3MHQuPFMYOjmrXSn63lhnAEm6b9DfXVi4YijE7Dj70U2rMPTewm45rgkURy6u4Gf
         wssJqMaLZjkahisE5+phHGxL09ZRMOaGOxcjCp7WdYhM8U345omYhL9pQjCkrVm+5af/
         cI27nyJKnmgpTwHwDv8MC9VZQD4lC5lLUBuP2m5cy3dfOC9y5891d5RzgB9lpLs70RQK
         WhZWctN0c955pwM/ORX/W+ffcd0CQRnn6c8ek6GbrSQzvuHC8vZtgDxK3L3/KtdkqeUD
         fu+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788716213; x=1789321013;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NNyWJkHCyIpLbg0Yf199LEoKfeIaby0BO4TsA7+gw/0=;
        b=eCTEouSOfFdDqutAjrSzXYbpBTn4OWQmHFaj7kUOtnWGrwghv8vwN+yAsX39R/9HYZ
         Sz9jfDw0i3VM71eV2fJFE6ajfCTT4NARZ08EkEOUKSPJssS0TyWTApt3p6OEEGo1RG/b
         h6/1TaWN98lIDh4Er138VZuRd8nQQoHcmUNv+rSQHEr1rxgceh7E2SEQhYDNaAHmYw7x
         kRafxMHxtEohQb/5/7rN/0Cvp7wJg+Gfz08VLaIvR1LWWKa+Fp6jbGs5F8XPmML1w5rT
         LTglZF20FjXBkhx6aLjoES1I+d8zF5albxHXVV+3XRG14JKgtK0MnZUZLjR29tMaHJ/v
         v9UA==
X-Forwarded-Encrypted: i=1; AKwUvByvK1Dfe8nR7Op6s6GemfYJZ4aoWh8LcFjpCCgEoNc9meHUGvgxT0tMBeK9XzN2BrQLNfD62T8=@vger.kernel.org
X-Gm-Message-State: AFuF++lE/PQ2TF2f6kEQSHkMzIfru3l59CeX3cDjFl0cq6updnUUMRRM
	ouCJL5vwbt9DO1y9ya1vWA6Os4nupIe//afcNeLPQE6OzjG4Ydaihn97rprzyYAoyRWSt5zitJi
	YWWwYRAZ82f8KlGNmdGSNxCmKUjnyF95r21I7yGcCfJ64Cmi6iHW9AayIEzw=
X-Gm-Gg: AYBFou1wg/DLcG9/NEfCKB5hQsmtG8JzZ/AG7ONQyxqbdEpvYMAbi7pmIRkiT1w32XH
	JDk7LECVoJWoLsyohzCQATj6xe7L3fbXH/msAp0rLGtP3d6o3vPWPztCXGQIra88SNiPR+mR5sw
	xFBkiPGBnBQGNiC5nyc7TK/xF/ZHTMudcVlZlysYiHw2VZ0tvworK9QiL5/oM6hJM3kmL0QKIIu
	ktLqFGB3xE8pqh+wyPNWkZ8nk56+9tnrII9sbhdam5zLZyJtwaU1vZTJOrz4cKOgDfrt7B4oyho
	8TJoTbXCwYU1DfJx6xqLFrqfshCq+MfUpOTtL/5JjB/ngVfL2q2ySdB6wypx8Xq0MLFkaHgsLAo
	nF5fwL75V2VlXOw==
X-Received: by 2002:a05:620a:261e:b0:936:eeab:307e with SMTP id af79cd13be357-9398059c8b4mr1879892385a.9.1788716212644;
        Sun, 06 Sep 2026 10:36:52 -0700 (PDT)
X-Received: by 2002:a05:620a:261e:b0:936:eeab:307e with SMTP id af79cd13be357-9398059c8b4mr1879887785a.9.1788716212164;
        Sun, 06 Sep 2026 10:36:52 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-485883959f0sm24437018f8f.10.2026.09.06.10.36.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2026 10:36:50 -0700 (PDT)
Date: Sun, 6 Sep 2026 19:36:50 +0200
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
To: Ren Wei <weir@nebusec.ai>
Cc: idosch@nvidia.com, netdev@vger.kernel.org, dsahern@kernel.org,
        iprintercanon@gmail.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
        tom@herbertland.com, vega@nebusec.ai, petalzu987@gmail.com
Subject: Re: [PATCH net v4 1/1] ip6_tunnel: snapshot encap in xmit
Message-ID: <ap2ksmdL1FFulLnF@lore-desk>
References: <cover.1788262122.git.petalzu987@gmail.com>
 <2ce8f3e4bbed6060afb0aee33dc4e1d9ae021280.1788262122.git.petalzu987@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cITQjqMjX9o6+OXd"
Content-Disposition: inline
In-Reply-To: <2ce8f3e4bbed6060afb0aee33dc4e1d9ae021280.1788262122.git.petalzu987@gmail.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA2MDE5NiBTYWx0ZWRfXwVBJXZVyplse
 aVELlVq0yVKoWPxgRFqVG/cNZKAeurLKSy1T58dpw5VorG4fhoSyD1kv5arqoz8mJpq5JpYrkB1
 LVozAydTrRbcIbj8SEav5vkY13fvSfbKh5HNOXlG5n0c1W9os9fNiJyT3cWAzPLJi35ZM8EigRP
 uNsxq6HldOQWjEoqtE++0u8C+sVzveb5TYcxMsEhG2bqlXf2Andr8JZitbfnOIRB35+o+7TSgH5
 29/gM3rVEMtUpdlEZouomL15LFtBl8jJp5kRIPqHnZcNNVkL7UZqSaWyyg/xDn1WiEBLAYjuVO6
 nP2LpiJdzBE+sHFYKhg4SZEet05N1VSe+dlfJpqhdtkdT4r4du0qH9bQdUoKOx71hfzzLlmQb59
 xyJBs92BveItMJWAKFpZpI1OxCRBXwHLyQKCw6HQOk07ylOv7QOumoPlHLnjtHXygOAXqyC6ogj
 9xFzna9b+v2qDAd/h4A==
X-Proofpoint-ORIG-GUID: blDmhkm-DVNtXYO2eWh0Jj2Hqq-t9WVv
X-Proofpoint-GUID: blDmhkm-DVNtXYO2eWh0Jj2Hqq-t9WVv
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA2MDE5NiBTYWx0ZWRfXy2hWsm6lYomZ
 Dhd176BuiK20iOcPSUPaBj5rqmfyRwLijTYLAG4AnU9hXteZ5kYv/SbchpWGAoV577IN7UO2vw2
 HzHKRgWQ4U61hgWzL9OSM5ODEPVNTeU=
X-Authority-Analysis: v=2.4 cv=Tf2mcxQh c=1 sm=1 tr=0 ts=6a9da4b5 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=pGLkceISAAAA:8
 a=VwQbUJbxAAAA:8 a=17Ogpx7Ge2VHjdCXMskA:9 a=CjuIK1q_8ugA:10
 a=nASmkU_yoCCGntK6NWwA:9 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-06_01,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 phishscore=0 clxscore=1015 spamscore=0 malwarescore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609060196

--cITQjqMjX9o6+OXd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> From: Zixuan Chai <petalzu987@gmail.com>
>=20
> ip6_tnl_changelink() can update encapsulation parameters while the
> netdevice is transmitting packets. ip6_tnl_xmit() can calculate packet
> headroom with t->encap_hlen and later build an encapsulation header from
> the live t->encap. A concurrent update can change the encapsulation
> header between these accesses and make skb_push() underflow the skb head.
>=20
> Take a local snapshot of t->encap before calculating the encapsulation
> header length. Use that same snapshot for headroom accounting, metadata
> validation, and build_header(). This keeps all encapsulation decisions
> for an skb consistent even if changelink updates the live configuration.
>=20
> Fixes: b3a27b519b22 ("ip6_tunnel: Add support for fou/gue encapsulation")
> Cc: stable@vger.kernel.org
> Reported-by: Vega <vega@nebusec.ai>
> Assisted-by: LLM
> Signed-off-by: Zixuan Chai <petalzu987@gmail.com>
> Signed-off-by: Ren Wei <weir@nebusec.ai>

Hi Ren and Zixuan,

I agree this is a real issue, but I guess this patch is fixing just a
small part of more extended problem. In particular, there are multiple
parameters that are updated in ip6_tnl_update()/ip6_tnl_change() that are
accessed concurrently in ip6_tnl_xmit() or in ip6_tnl_fill_forward_path().
I guess we should try to find a general fix for the extended issue.
What do you think? We have probably the same issue in the IPv4 counterpart.

Regards,
Lorenzo

> ---
>  include/net/ip6_tunnel.h | 10 +++++-----
>  include/net/ip_tunnels.h | 10 ++++++++++
>  net/ipv6/ip6_tunnel.c    | 18 ++++++++++++++----
>  3 files changed, 29 insertions(+), 9 deletions(-)
>=20
> diff --git a/include/net/ip6_tunnel.h b/include/net/ip6_tunnel.h
> index b99805ee2fd1..6e76e50a4406 100644
> --- a/include/net/ip6_tunnel.h
> +++ b/include/net/ip6_tunnel.h
> @@ -106,22 +106,22 @@ static inline int ip6_encap_hlen(struct ip_tunnel_e=
ncap *e)
>  	return hlen;
>  }
> =20
> -static inline int ip6_tnl_encap(struct sk_buff *skb, struct ip6_tnl *t,
> +static inline int ip6_tnl_encap(struct sk_buff *skb, struct ip_tunnel_en=
cap *e,
>  				u8 *protocol, struct flowi6 *fl6)
>  {
>  	const struct ip6_tnl_encap_ops *ops;
>  	int ret =3D -EINVAL;
> =20
> -	if (t->encap.type =3D=3D TUNNEL_ENCAP_NONE)
> +	if (e->type =3D=3D TUNNEL_ENCAP_NONE)
>  		return 0;
> =20
> -	if (t->encap.type >=3D MAX_IPTUN_ENCAP_OPS)
> +	if (e->type >=3D MAX_IPTUN_ENCAP_OPS)
>  		return -EINVAL;
> =20
>  	rcu_read_lock();
> -	ops =3D rcu_dereference(ip6tun_encaps[t->encap.type]);
> +	ops =3D rcu_dereference(ip6tun_encaps[e->type]);
>  	if (likely(ops && ops->build_header))
> -		ret =3D ops->build_header(skb, &t->encap, protocol, fl6);
> +		ret =3D ops->build_header(skb, e, protocol, fl6);
>  	rcu_read_unlock();
> =20
>  	return ret;
> diff --git a/include/net/ip_tunnels.h b/include/net/ip_tunnels.h
> index 7c9aadfe8fe3..ab217ddbeb20 100644
> --- a/include/net/ip_tunnels.h
> +++ b/include/net/ip_tunnels.h
> @@ -522,6 +522,16 @@ skb_vlan_inet_prepare(struct sk_buff *skb, bool inne=
r_proto_inherit)
>  	return SKB_NOT_DROPPED_YET;
>  }
> =20
> +static inline void
> +ip_tunnel_encap_snapshot(struct ip_tunnel_encap *dst,
> +			 const struct ip_tunnel_encap *src)
> +{
> +	dst->type =3D READ_ONCE(src->type);
> +	dst->flags =3D READ_ONCE(src->flags);
> +	dst->sport =3D READ_ONCE(src->sport);
> +	dst->dport =3D READ_ONCE(src->dport);
> +}
> +
>  static inline int ip_encap_hlen(struct ip_tunnel_encap *e)
>  {
>  	const struct ip_tunnel_encap_ops *ops;
> diff --git a/net/ipv6/ip6_tunnel.c b/net/ipv6/ip6_tunnel.c
> index d5ff50a2ac01..6ca373d6205a 100644
> --- a/net/ipv6/ip6_tunnel.c
> +++ b/net/ipv6/ip6_tunnel.c
> @@ -1102,6 +1102,7 @@ int ip6_tnl_xmit(struct sk_buff *skb, struct net_de=
vice *dev, __u8 dsfield,
>  		 __u8 proto)
>  {
>  	struct ip6_tnl *t =3D netdev_priv(dev);
> +	struct ip_tunnel_encap ipencap;
>  	struct net *net =3D t->net;
>  	struct ipv6hdr *ipv6h;
>  	struct ipv6_tel_txoption opt;
> @@ -1109,10 +1110,11 @@ int ip6_tnl_xmit(struct sk_buff *skb, struct net_=
device *dev, __u8 dsfield,
>  	struct net_device *tdev;
>  	int err_count, mtu;
>  	unsigned int eth_hlen =3D t->dev->type =3D=3D ARPHRD_ETHER ? ETH_HLEN :=
 0;
> -	unsigned int psh_hlen =3D sizeof(struct ipv6hdr) + t->encap_hlen;
> -	unsigned int max_headroom =3D psh_hlen;
> +	unsigned int max_headroom;
>  	__be16 payload_protocol;
>  	bool use_cache =3D false;
> +	unsigned int psh_hlen;
> +	int encap_hlen;
>  	u8 hop_limit;
>  	int err =3D -1;
> =20
> @@ -1202,6 +1204,14 @@ int ip6_tnl_xmit(struct sk_buff *skb, struct net_d=
evice *dev, __u8 dsfield,
>  				     t->parms.name);
>  		goto tx_err_dst_release;
>  	}
> +
> +	ip_tunnel_encap_snapshot(&ipencap, &t->encap);
> +	encap_hlen =3D ip6_encap_hlen(&ipencap);
> +	if (unlikely(encap_hlen < 0))
> +		goto tx_err_dst_release;
> +	psh_hlen =3D sizeof(struct ipv6hdr) + encap_hlen;
> +	max_headroom =3D psh_hlen;
> +
>  	mtu =3D dst6_mtu(dst) - eth_hlen - psh_hlen - t->tun_hlen;
>  	if (encap_limit >=3D 0) {
>  		max_headroom +=3D 8;
> @@ -1240,7 +1250,7 @@ int ip6_tnl_xmit(struct sk_buff *skb, struct net_de=
vice *dev, __u8 dsfield,
>  		goto tx_err_dst_release;
> =20
>  	if (t->parms.collect_md) {
> -		if (t->encap.type !=3D TUNNEL_ENCAP_NONE)
> +		if (ipencap.type !=3D TUNNEL_ENCAP_NONE)
>  			goto tx_err_dst_release;
>  	} else {
>  		if (use_cache && ndst)
> @@ -1264,7 +1274,7 @@ int ip6_tnl_xmit(struct sk_buff *skb, struct net_de=
vice *dev, __u8 dsfield,
>  			+ dst->header_len + t->hlen;
>  	ip_tunnel_adj_headroom(dev, max_headroom);
> =20
> -	err =3D ip6_tnl_encap(skb, t, &proto, fl6);
> +	err =3D ip6_tnl_encap(skb, &ipencap, &proto, fl6);
>  	if (err)
>  		return err;
> =20
> --=20
> 2.34.1
>=20

--cITQjqMjX9o6+OXd
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCap2ksgAKCRA6cBh0uS2t
rLaHAP9yifbjUw66H1wWsQYcnEX83pVpNHB5sHpKfqG3+TTZDAD+O4sV7RAZe8aA
N+PoeF9SZxXcVrBcCTvuTIQm5EHAWAc=
=j9Cz
-----END PGP SIGNATURE-----

--cITQjqMjX9o6+OXd--
