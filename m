Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DD8E4FECD6
	for <netdev@vger.kernel.org>; Mon,  7 Sep 2026 15:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788793474; cv=none; b=rv6EuDwkbPs3aDnExAGUPvx70SjPo52SPvWUIZQOmksjcF8MmkRb80vpH/ts0mIPUP7GKvtPd7qkmtCUVl/DoXwYyMoELKbQnwo0V0IiNHzCfswsw15bulIWE83uAulEPa4mmuWsDNRaJ/sxQR/cEELjoJ6oYw0RY7Ma7d+PHds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788793474; c=relaxed/simple;
	bh=tTeDYnboQd9ff0YGKre1AqOWDKO1QMT5A3ipJ1Xvft0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T1tAmtBQMZ/iN6msQiQSL95pDycRWQkpGWynEcMtl/nHqHxslwX/uoJyyDcx0ZY51jUECtfI0A9Sg9ZAQONBd7oueQSMmg3NGlSlAMFSoAlQNl9hQReXKhCS50iyItnS72QliD3IM62thtAZZP9E1QhMOPXLBZ7iw0f0F2PgtQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Su7htJcP; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=e5z/RhGQ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Su7htJcP";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="e5z/RhGQ"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 687DeHOU3607031
	for <netdev@vger.kernel.org>; Mon, 7 Sep 2026 15:04:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=Dl76v291nMdDCIwDf7jFTiU9
	Pc0bjSzUJiRawPU3Qyk=; b=Su7htJcPl5gkq17Tea6IVMJ4HyK2mogZIAIogCjp
	vFDfIqwZjGw5zJdoEllXGRhpFXgxI7e7XoQrfSnVyfiLqscrnq8JiEDcoGwAM6qj
	j8iWGoclJozziR1xzjZ5wDUy0U4bwRMbdtHc5LvK7mDT2qB9b/AFPdhXddgf94Qv
	fYV6e3+fIl7i0VDQRcj7p06ZgY3kxWCP6dsXjsGRoLLTP830FpvdpZLrd3yjcGzw
	BGPWwLQPg1Q9QpgJpt72xo231VJoe4OFgkfGTXeVFN2TdC0k1gO967lSQlSi+wqx
	YHwdGs/IpqKm6lwufVCzV8erpVHI+MfJ1SLcjF6q3s3TXA==
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com [209.85.221.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ghfxku7jr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 07 Sep 2026 15:04:31 +0000 (GMT)
Received: by mail-vk1-f199.google.com with SMTP id 71dfb90a1353d-5c7c0d2b0aaso1393418e0c.1
        for <netdev@vger.kernel.org>; Mon, 07 Sep 2026 08:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788793470; x=1789398270; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Dl76v291nMdDCIwDf7jFTiU9Pc0bjSzUJiRawPU3Qyk=;
        b=e5z/RhGQY7c8Xry0YEPnFqKKQIrmij9mdW32uRLpPuOFLFL5+IgB59J4uLBrOK0mLh
         schLU3Xqrapwl30t+VaClHTNTcid7aQGPYkOntkZRSfpS/Hxe0d2SSpSSE/Nsz1FhTNF
         2AyQfnAq4USwDrbV83BOcSjWY7C409rBTpJWm3kyKuYgpt25piTsrUAFFhTSF/EYspEe
         B7DTnNYw8giriBOqvKTPhfnWH1YBfBUdJlz2JZfCbWlTYqiVGtTNzSbXExZ+rLdcKzIk
         pFdmz+g+fLIXvgmT28rd/ISxVWp8fDkfwh6VS2bRgaasGP0JAzGfJxv2j4zWN1ZCsOxZ
         PjJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788793470; x=1789398270;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Dl76v291nMdDCIwDf7jFTiU9Pc0bjSzUJiRawPU3Qyk=;
        b=cKo9rWkYkzlKBsdI4cY626iAMJA0tOrAw1cUUs3tslzylRrFRolcmCvOMJMKgMFC7B
         wtiWutQqMxBECkEqLA92g+oKWYicB0Aqsk3VfQIm8x76BiyRutNrwd3VSnri8BMh2XGZ
         itU8A0CW/AVRo+bk+2URQ2zS90EBHV3obDjO4KMnQhSnkEORLlp48erd85NGukD6dKLb
         PvCyaag4qfORulFkMHrmnitP/KKTL49YqVhQHqW2Mz/bDaHq6keIh4ie6+W8JLltXClm
         bP3E5OiCTq3vU39zKLunZXmzO8mNMHGu8RpXUITm4BwvP3lDKBjSO6besh21dF/kdhoR
         sTPQ==
X-Forwarded-Encrypted: i=1; AKwUvBwKoHjeCKiggl0sPTvxRtHRhEA80nzbJ/NX+K8dq4QGzqmkYaBigwltgF3sjUZOtNXSaLJNU4Y=@vger.kernel.org
X-Gm-Message-State: AFuF++lmB3S+3VxB5VQ0I92D4CBuWAjlwbV4EICvMNCU/ilBwTxsQ5Lv
	2mr+MhJSgntHR0iclqb3xJ2HgY1rUU+zWzvthqJ881QdEnUFPDTvIHdMkUlz/ArmUwc9MnuRHjZ
	IjMACiWIArV4VF6R36T9m4BO6dyVN4By02ULOCrYLgwIvqGPxuEJqKUHp2m4=
X-Gm-Gg: AYBFou1LGZemXn1uxW42DEH87u6uOqAkTyXZiwMZ/zTSPnrb2Eo9Ty4fWUbi/huhmcU
	zAFJLzqxK9XEZ4E+KyAtJoAzKkriWctcBU1EB/hYM6CfjdmnKoRKWVwu5fUNOjfM37FUIsQtBQ9
	n1LPGpi3wf7rufjd8PrUr7pOJuHW/Rjpb7BnklteoVNoGzvpRwcarHIwOnqsK+Wd/J6+4WklhmQ
	18udDbjjIZjmL0QiUOh51UNt/fJ38KVtAPL2XNA7lWMsM20UaH1WLHh+jdb9C443ozm9a4mo5XM
	KZ6dwri5XsrLuFikedFrE8zHsNOHxpk2r2bla9Zjli+yqnkwkIMkJt1rcOuOpzd/K2Hkunsrj8R
	Qy9S2MGhyitQPog==
X-Received: by 2002:a05:6122:3128:b0:5bd:71b1:d5c6 with SMTP id 71dfb90a1353d-5c7ed3c7515mr9800197e0c.4.1788793470295;
        Mon, 07 Sep 2026 08:04:30 -0700 (PDT)
X-Received: by 2002:a05:6122:3128:b0:5bd:71b1:d5c6 with SMTP id 71dfb90a1353d-5c7ed3c7515mr9800112e0c.4.1788793469848;
        Mon, 07 Sep 2026 08:04:29 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cee6023edsm389594975e9.7.2026.09.07.08.04.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 08:04:28 -0700 (PDT)
Date: Mon, 7 Sep 2026 17:04:27 +0200
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Andrew Lunn <andrew+netdev@lunn.ch>, Ido Schimmel <idosch@nvidia.com>,
        Kuniyuki Iwashima <kuniyu@google.com>,
        Artem Lytkin <iprintercanon@gmail.com>, netdev@vger.kernel.org,
        eric.dumazet@gmail.com
Subject: Re: [PATCH net-next 9/9] sit: no longer rely on RTNL in
 ipip6_fill_info()
Message-ID: <ap7Se3B9QZPGbcO_@lore-desk>
References: <20260907075846.2913645-1-edumazet@google.com>
 <20260907075846.2913645-10-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="V9jRWV6RMc7fHcHr"
Content-Disposition: inline
In-Reply-To: <20260907075846.2913645-10-edumazet@google.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA3MDE2NyBTYWx0ZWRfX+qzp28vh4Lwg
 CYNICRLES6F3CwwsUhmZQeQBYRBKbM8cCTOPv7XxrWyRjDKXtUZ1R1PQISAY+vQBHrkkPEVmyN/
 DTNq0h0KAloAS+E0pi8H/XlXr+TLEo14k1VvrfBsQ/ObpcSi1GqGp8QOFGJqbaCK7XZP0xFLuih
 kpROFKWpGynvgsV/4iThXmiNmSDeVfe/nQFSNterIQlwprFJNdo6T7CRh/hoZGL/QTbG3wNjlh2
 m6XQSoYhGOwfza9hdStL0LdBJyGMVrEmrUf9zKIGszjsX6AjX7OpfFrvb+AKoXok82k+UZ4qgN/
 Jy1WfKn4qL7mSrNrG6VEOH7cKQJeasGcbvuXH+QyBllFofuLIahol2SCxdiZDeRHXKzg7WXGXWB
 6P+BvH+fDms0iOn6+Xb9dRXQyn9XWhzy6QOeMsbUhFj1KkJXS8GR6W6Qgv2Runl5Pq6SsAaPAZf
 rHN5pNjxjrO/BpdA3Ng==
X-Proofpoint-GUID: wYm0xHGPuxwLv26czYXYvqeoBFZCqCU9
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA3MDE2NyBTYWx0ZWRfX9dj2+iBVdnJr
 HCGhuNDfpn8fNVCvK8h6BjgxVCOYe5MRTZYdENwIwwiI1al8zzbMAnUqTXhyn00hIc95KHr2Waq
 3T2/WWV0zi1DcglMLPwX4//rQUuwxec=
X-Authority-Analysis: v=2.4 cv=daOwG3Xe c=1 sm=1 tr=0 ts=6a9ed27f cx=c_pps
 a=+D9SDfe9YZWTjADjLiQY5g==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=1XWaLZrsAAAA:8 a=UHAJRQsx9zW7mf1_YtUA:9 a=CjuIK1q_8ugA:10
 a=lytMAWgozIGceCEePWAA:9 a=vmgOmaN-Xu0dpDh8OwbV:22
X-Proofpoint-ORIG-GUID: wYm0xHGPuxwLv26czYXYvqeoBFZCqCU9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-07_04,2026-09-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 bulkscore=0 spamscore=0 phishscore=0
 lowpriorityscore=0 adultscore=0 malwarescore=0 impostorscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609070167

--V9jRWV6RMc7fHcHr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Now that SIT parameters and 6RD parameters are RCU-protected,
> and fwmark/encap are annotated with READ_ONCE()/WRITE_ONCE(),
> ipip6_fill_info() no longer requires RTNL to be held.
>=20
> Wrap the attribute serialization in rcu_read_lock() and rcu_read_unlock().

Acked-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>

>=20
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  net/ipv6/sit.c | 21 +++++++++++++++------
>  1 file changed, 15 insertions(+), 6 deletions(-)
>=20
> diff --git a/net/ipv6/sit.c b/net/ipv6/sit.c
> index c9049ab87e010eed5f53a342460ed10006083cd7..14ba3cfb304a83ee37e3be5b0=
9a57c371f1977c3 100644
> --- a/net/ipv6/sit.c
> +++ b/net/ipv6/sit.c
> @@ -1846,11 +1846,18 @@ static size_t ipip6_get_size(const struct net_dev=
ice *dev)
>  static int ipip6_fill_info(struct sk_buff *skb, const struct net_device =
*dev)
>  {
>  	struct ip_tunnel *tunnel =3D netdev_priv(dev);
> -	const struct ip_tunnel_parm_kern *parm =3D rtnl_dereference(tunnel->sit=
_parms);
> +	const struct ip_tunnel_parm_kern *parm;
>  #ifdef CONFIG_IPV6_SIT_6RD
>  	const struct ip_tunnel_6rd_parm *ip6rd;
>  #endif
> =20
> +	rcu_read_lock();
> +	parm =3D rcu_dereference(tunnel->sit_parms);
> +	if (!parm) {
> +		rcu_read_unlock();
> +		return -ENODEV;
> +	}
> +
>  	if (nla_put_u32(skb, IFLA_IPTUN_LINK, parm->link) ||
>  	    nla_put_in_addr(skb, IFLA_IPTUN_LOCAL, parm->iph.saddr) ||
>  	    nla_put_in_addr(skb, IFLA_IPTUN_REMOTE, parm->iph.daddr) ||
> @@ -1865,7 +1872,7 @@ static int ipip6_fill_info(struct sk_buff *skb, con=
st struct net_device *dev)
>  		goto nla_put_failure;
> =20
>  #ifdef CONFIG_IPV6_SIT_6RD
> -	ip6rd =3D rcu_dereference_rtnl(tunnel->ip6rd);
> +	ip6rd =3D rcu_dereference(tunnel->ip6rd);
>  	if (ip6rd &&
>  	    (nla_put_in6_addr(skb, IFLA_IPTUN_6RD_PREFIX,
>  			      &ip6rd->prefix) ||
> @@ -1879,18 +1886,20 @@ static int ipip6_fill_info(struct sk_buff *skb, c=
onst struct net_device *dev)
>  #endif
> =20
>  	if (nla_put_u16(skb, IFLA_IPTUN_ENCAP_TYPE,
> -			tunnel->encap.type) ||
> +			READ_ONCE(tunnel->encap.type)) ||
>  	    nla_put_be16(skb, IFLA_IPTUN_ENCAP_SPORT,
> -			tunnel->encap.sport) ||
> +			 READ_ONCE(tunnel->encap.sport)) ||
>  	    nla_put_be16(skb, IFLA_IPTUN_ENCAP_DPORT,
> -			tunnel->encap.dport) ||
> +			 READ_ONCE(tunnel->encap.dport)) ||
>  	    nla_put_u16(skb, IFLA_IPTUN_ENCAP_FLAGS,
> -			tunnel->encap.flags))
> +			READ_ONCE(tunnel->encap.flags)))
>  		goto nla_put_failure;
> =20
> +	rcu_read_unlock();
>  	return 0;
> =20
>  nla_put_failure:
> +	rcu_read_unlock();
>  	return -EMSGSIZE;
>  }
> =20
> --=20
> 2.55.0.979.g7e5102b832-goog
>=20

--V9jRWV6RMc7fHcHr
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCap7SewAKCRA6cBh0uS2t
rIydAP47PzCuddB+ZniajDTHqVdKFxLQXDHSHU6JA/51HKg+HQEA0CntkI9B1m+f
+2gazSgHVmhU31m7qfJbYeUfN3ZCew0=
=G2dV
-----END PGP SIGNATURE-----

--V9jRWV6RMc7fHcHr--
