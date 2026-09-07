Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFDF14EA394
	for <netdev@vger.kernel.org>; Mon,  7 Sep 2026 15:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788793986; cv=none; b=F1xi1xHWnblJXBiqWX65IEZCRCIxJ0UW1T3vq0yHdEhqcK0gud0Ze/RUVY9azA09ETej1XS6M2y0yGGVAsJYezLE/HWtB1kmIqK09prjAt3FxZFN4eR/1PY9PELI+BmzHkshrbh5dhvH5ej3jul5Pe1Y1Dkt4jLHBPz8nD0gogk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788793986; c=relaxed/simple;
	bh=/V48eag3ccSEQNmrxmHk2r6qYks68tCpuVQc0wgILYo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TOMZGffSKLqWjzoQUJBEwQ1s4LDn6TYWWksmJ2XlQf4qvCpFCdNhPfsrw0TMc39F2ouD+HFk8cEwaMBzJt32hH6Sc1Q/A5ead3NJL7N2JK9/WwBRqou57OkedVmLDs4YR8xNbcwdXay6S3xrTZuoav7ACiZQICcukXFviAs6HHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gdsm/gLt; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MHHuZRPF; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gdsm/gLt";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MHHuZRPF"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 687DdEv03554524
	for <netdev@vger.kernel.org>; Mon, 7 Sep 2026 15:13:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=TjKVqEnNHmbtuPmrrE1O9a6R
	otGpLKl8+wAE40AZOuY=; b=gdsm/gLtMTO1idZqVJduyJQUlbMTDBR2xBF4WNEj
	XmEQUuKMoGVnq+jsNQRzpjUnIUcoYt68Ktp+gmR5x3Ouo3ajRgqK47QzQnSwcW+f
	/OpY71C8QKc/t6SiLg3PMawviYDHHfZWSRL2sp24/anM3SxiySIzCNZyzZ6+CWj4
	88kpG+hxUZjn9QtLCUR2HngsGS6bFEbwL2TRVtt5R4+BvixKzJscgmtZ11j7ru60
	EDp8Yt/sj7nnCL6yDMqofQydyHUM0KvDXw5UwKcUEOP+j/bpyOzgOGwZrl9kfvkb
	orKeyEKe5c9CirqCUsTtqwfD2Gl42a0tw1kMmFQps4/S2w==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ghsw21h5c-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 07 Sep 2026 15:13:04 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-939062ecda9so445496985a.1
        for <netdev@vger.kernel.org>; Mon, 07 Sep 2026 08:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788793983; x=1789398783; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=TjKVqEnNHmbtuPmrrE1O9a6RotGpLKl8+wAE40AZOuY=;
        b=MHHuZRPFUq83JBGRmu9R5UhZvKooeG40Y1CyItN2bkWJ75hENDoRzvuZyPsRLBxoeH
         /lbXDS+aJ6DW8Ged2jwo9hKRXiioKXcv0I9iigDiks91nSvZsmwqrVcrq80JwGOKbpxa
         2yzs+2LVsk5RGRnAW40xdzSDpd1nUNy+Gm5u5b8c1/jS+DPVpFDS9JKcB38ohR8uzl1M
         a4EsowIPDGxpq+pYaRHHRxcuCRzdPqgRIqey4RbWWD9hYjD5C+JxsQ/1uSmw4QTgXcy8
         m/VvFg1i1r0jFo2BrDOlp22YFpZd9xhQwfMpaoBgMlO7q4EwWZu44G15C/Amh8pKuOYA
         3c5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788793983; x=1789398783;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TjKVqEnNHmbtuPmrrE1O9a6RotGpLKl8+wAE40AZOuY=;
        b=qtXuNtrr1t74C8y6brMZj/88tHUtYKjGgVfGG2sUZZHiozSJT/oMPVwr2nUK2p7ESI
         yxd6KkntiwT5lABMHz96YmVui/vizDb5bwx2albgas1xTQhXge9qJOtE+sFO/MrG73YT
         j5zVEzWFOY8om69PTECA8L7tRV0OiqTWp4hhxjGW9u4vFjbfCXL6s2AXmxONv1+m3xwj
         Sn2YtFjBRJY+ZHco1F3/vsB1MgFIVrPz4klm5tziLYEhnxlO5id6xy5ujvGKKRjSkYCZ
         j7mmcHboB+ieoI0PsX6E7hSYlWo2cyUrYrXY+4vDwa4hRIi6UffzrE9fxkwa4AV5snMJ
         oaxw==
X-Forwarded-Encrypted: i=1; AKwUvBzPNxhSW1bZb1TVxkV//FsEc91Bo2DBAG5bVF1RngO7a0WPszLsg03GknDt++EhvGmMe2fevnQ=@vger.kernel.org
X-Gm-Message-State: AFuF++mhUhhlKFRgODowLOQY1J19qUn+WbNHPPY0VSgCLsTUIiwAZuqr
	lwm/GwZF8mupi3RM3YOwR3bpj+Bx4sWs4U//UxQwy3kZPCh8/R+K7W57W97sTXQKHybO5TBv+yk
	wh7CzotXuwSdfx1BsINFaJhzznG22p9YGfixvOgIKfVvl8OVO0WpHklhUjtg=
X-Gm-Gg: AYBFou2C8k9B3JvzhGmqfIpWq9Je+zB2dQAk5XbzrnCXLqHVjs0rcTUL2Vv0NgLi//K
	gmN06S8nlVMoXkopt0Dx0KP3L165LZ3Z8YNnR/S4J35XZJOSD4jZpl3waO4emj2sYt4AkhygDW2
	rVDyqhw29g/TdFgzvC52wXSjYa8rj7OhCiKEQIGmd3w0K+CLuD3jUZfb4bJLCSxrv808yE1Id0T
	DwGmfu5YsKBLVIXVRlAwTrd37w+giPs+T8JmkfiUDOBkI+wAiDCB2v7jdMmTXomNlYE3X0VqqIE
	XF5J/qVL6P/Mjq4PZQBaF1KlRA9++PRsfRQSxX3aGJxQRaay++Jmnbf6xBBWcoTTN3ymxYBCgQu
	kwsVeyqJKqgyPow==
X-Received: by 2002:a05:620a:370e:b0:939:5f4d:67b0 with SMTP id af79cd13be357-939803292a1mr2456865485a.8.1788793978061;
        Mon, 07 Sep 2026 08:12:58 -0700 (PDT)
X-Received: by 2002:a05:620a:370e:b0:939:5f4d:67b0 with SMTP id af79cd13be357-939803292a1mr2456853785a.8.1788793977409;
        Mon, 07 Sep 2026 08:12:57 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49ce46696e8sm287803915e9.0.2026.09.07.08.12.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 08:12:56 -0700 (PDT)
Date: Mon, 7 Sep 2026 17:12:55 +0200
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Andrew Lunn <andrew+netdev@lunn.ch>, Ido Schimmel <idosch@nvidia.com>,
        Kuniyuki Iwashima <kuniyu@google.com>,
        Artem Lytkin <iprintercanon@gmail.com>, netdev@vger.kernel.org,
        eric.dumazet@gmail.com
Subject: Re: [PATCH net-next 4/9] sit: annotate data-races around
 tunnel->fwmark
Message-ID: <ap7Ud8XBdJKltjE9@lore-desk>
References: <20260907075846.2913645-1-edumazet@google.com>
 <20260907075846.2913645-5-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="std5CpnxhL/X3k7I"
Content-Disposition: inline
In-Reply-To: <20260907075846.2913645-5-edumazet@google.com>
X-Proofpoint-ORIG-GUID: ffYA4aFIT5Koi1igds_9WjNDJBX2aHa1
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA3MDE2OSBTYWx0ZWRfX6B+gO4511kx9
 AlOFX/9czOAdEkR+K62RVyoMhCNs8ED14R+I+h+RtvOrIkh8yMVapQEle2HT70S6HWn/AmrYI0E
 7RCZ/enl7IuY2tYHpr1XmAtJgZmVtPM=
X-Authority-Analysis: v=2.4 cv=eKwjSnp1 c=1 sm=1 tr=0 ts=6a9ed480 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=1XWaLZrsAAAA:8 a=Bt7LA-Ov3T-ct2ewHCsA:9 a=CjuIK1q_8ugA:10
 a=09yc2XUkTQroVQC7iVMA:9 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA3MDE2OSBTYWx0ZWRfX//vDOeFtDt5q
 U8sKCyLmRPb8L635nYPz0FrNz7t/Jsyug1cTL849ZmDG/kXP+rJLjcIf8oMM4EOgzKy7BRiyC2t
 DM5IIAtRXMmPvJZYjK4CEvDh593oCrm+h0fQIXai1cjxCMiTXqLBkjeTjMobHPpQnCoKaDaMPec
 hvd33jgjy40jADSDNByelhpub6M9Va6x0R0gEPa6IVQsFL1XFKZn/7xZmMcINdSc7u4kxr5IJrS
 t5GDBoGIp0Wtx48u+gn1tLmig2zDwqozpqT6Etf2nFzwycgg6MkezMRAeK/79Niq9dufe4hya+Z
 NQmat51Y6+p3+p0NBKg03gXLPZ7/bhlU9MJn6/qMeHrr7jgdYKv6oG6S2v/36Aa0FlqJ5uPqiFU
 JiIJPFOJ1AE8/k7wvz5y8RK+0EOZmPPuGJLl9fZKqV5IRpl2Id39mzve7CkxlJJPwt4EMQS5h4X
 0TfOVtBR2DZgoT2IBMg==
X-Proofpoint-GUID: ffYA4aFIT5Koi1igds_9WjNDJBX2aHa1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-07_04,2026-09-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 malwarescore=0 priorityscore=1501
 suspectscore=0 clxscore=1015 adultscore=0 spamscore=0 phishscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609070169

--std5CpnxhL/X3k7I
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> ipip6_tunnel_xmit() runs locklessly (dev->lltx =3D=3D true) and reads
> tunnel->fwmark.
>=20
> In preparation for converting ipip6_fill_info() to run without RTNL,
> add READ_ONCE() and WRITE_ONCE() annotations around tunnel->fwmark.

Acked-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>

>=20
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  net/ipv6/sit.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/net/ipv6/sit.c b/net/ipv6/sit.c
> index 9a2bbd76d3794849cd11c6530ba1303bf53fa388..e85fa80e80d1ad2c593b86068=
5b9f5bac21e66d9 100644
> --- a/net/ipv6/sit.c
> +++ b/net/ipv6/sit.c
> @@ -929,7 +929,7 @@ static netdev_tx_t ipip6_tunnel_xmit(struct sk_buff *=
skb,
>  	if (!dst && !ipip6_tunnel_dst_find(skb, &dst, false))
>  		goto tx_error;
> =20
> -	flowi4_init_output(&fl4, tunnel->parms.link, tunnel->fwmark,
> +	flowi4_init_output(&fl4, tunnel->parms.link, READ_ONCE(tunnel->fwmark),
>  			   tos & INET_DSCP_MASK, RT_SCOPE_UNIVERSE,
>  			   IPPROTO_IPV6, 0, dst, tiph->saddr, 0, 0,
>  			   sock_net_uid(tunnel->net, NULL));
> @@ -1153,7 +1153,7 @@ static void ipip6_tunnel_update(struct ip_tunnel *t,
>  	t->parms.iph.frag_off =3D p->iph.frag_off;
>  	if (t->parms.link !=3D p->link || t->fwmark !=3D fwmark) {
>  		t->parms.link =3D p->link;
> -		t->fwmark =3D fwmark;
> +		WRITE_ONCE(t->fwmark, fwmark);
>  		ipip6_tunnel_bind_dev(t->dev);
>  	}
>  	dst_cache_reset(&t->dst_cache);
> @@ -1706,7 +1706,7 @@ static int ipip6_fill_info(struct sk_buff *skb, con=
st struct net_device *dev)
>  	    nla_put_u8(skb, IFLA_IPTUN_PROTO, parm->iph.protocol) ||
>  	    nla_put_be16(skb, IFLA_IPTUN_FLAGS,
>  			 ip_tunnel_flags_to_be16(parm->i_flags)) ||
> -	    nla_put_u32(skb, IFLA_IPTUN_FWMARK, tunnel->fwmark))
> +	    nla_put_u32(skb, IFLA_IPTUN_FWMARK, READ_ONCE(tunnel->fwmark)))
>  		goto nla_put_failure;
> =20
>  #ifdef CONFIG_IPV6_SIT_6RD
> --=20
> 2.55.0.979.g7e5102b832-goog
>=20

--std5CpnxhL/X3k7I
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCap7UdwAKCRA6cBh0uS2t
rJPqAPwNROCGFZXSGrCWOuIQDAujYzFf9vqgSghzZ4BKmwM5NwD8DibtuYVZaAbs
HFLCQqdmmzd5CNqbGL+8BV8dKtGVtw4=
=iNdZ
-----END PGP SIGNATURE-----

--std5CpnxhL/X3k7I--
