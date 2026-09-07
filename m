Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20CCC4FB9AA
	for <netdev@vger.kernel.org>; Mon,  7 Sep 2026 13:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788786120; cv=none; b=aEeqiilSo3jqc+c0ZQVqu/xZ0OokfBSf2gg6b7S92jWUC9p7h4jNIEEH4noA28ef7cPtfWHuDlOYMvZljqceZULpqxFm01SIJc1pWTxsGgQKxo2CQkZbgdenbk7HJzW8P1A6at9c4SyIFPKHALpwBekmge/uDaKt+vBmivoRcHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788786120; c=relaxed/simple;
	bh=bNcPE4d80Gxy5cS89Y+3V1N439yyXbVYrATwIjTrfSw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BwN3VtSX8gHFfBxx+NQd/Ue/z2z55ei7r/8jo6WVUWZojGXBN1awpBazb0aFaJqZnYqX8o2aAzSAZ2qf3868VB1OATNDbRcRI3jOd962q3lEbmCp1G52yKCGNhSMU1kTZqJfS7li3rH6RZOw/Zwubp/HwZfnLHlN1tm+aTd9Md0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=auQhS9CM; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=NI7o56Pt; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="auQhS9CM";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NI7o56Pt"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 687AnYPL3777945
	for <netdev@vger.kernel.org>; Mon, 7 Sep 2026 13:01:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=2NNY2sCMnzAYhlwQb0R3zps+
	B9ydMKNeJsWWama3DMc=; b=auQhS9CM9vPNij9puddQSDqjW58lZkaaxC2VDOQ8
	TCzmlLEX5Sq3aD4+e/Y33mER0IA9dRCiZGZtEwZFC1KCSTDaCiJU/YFdR7F6Pgkw
	VSqz4u4Wcfv74GcQp2g/4MJtYfySiEPHozPJur3iQoyQi+C6Izi5YU32nyqGs/El
	GFxcRkbJkCUYwO+unzf5ZFhXYjTXxtFMNWCfgtl1H7kQh+pZCBOz/iWMvdHaXi3P
	FKdBxTO1CDGG/5MZ5GVHoM7g5DBzZmB9w8A+ZhCuhSwKjUEhCLWTwg4HQXza7KRm
	pPZ8W/cNgs5iEBj4DfrrqwGrOWwe27F8sQ0FBAcz5A5jaw==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com [209.85.217.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ghsfyh5u6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 07 Sep 2026 13:01:49 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id ada2fe7eead31-78a5a291af3so2456608137.0
        for <netdev@vger.kernel.org>; Mon, 07 Sep 2026 06:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788786108; x=1789390908; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2NNY2sCMnzAYhlwQb0R3zps+B9ydMKNeJsWWama3DMc=;
        b=NI7o56PtxvV8yi+izkVS0L0VMSq0L+J8f9D01ZGWk/G5gXkrgaiWLUCbFAKLFn9qdC
         gsnBUH6Az1B17xbvpALQLLE4wxqZFG3HU+DBKVlIH35CZd4TH+SJbA6ngGK/CleA35x9
         4fkgwAZN6nRiBqEidlGijL+6yMMgescnXUQVQI5fm3dok5zLiCG+NzR2Q9ILH6OmnVz5
         fjLI0XDNPonl3Yn/lzI0yBiUsxD0edz5F3h2pyiIPk7hJkUt+ARwU0mg+/oSALABwvIg
         +UIaRKU76HZF9uy8DEmNHeV9j/W+fRehRvw3EI+c9B7pY+eujVNviO458QEAXXTvKipe
         PPGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788786108; x=1789390908;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2NNY2sCMnzAYhlwQb0R3zps+B9ydMKNeJsWWama3DMc=;
        b=mPHaZM5Mw3yPonPbIEHwuB95Sthw39Drffwt9YThP57aqHjxceylW3zcuj12/SbFKx
         7CiOPenksJ/3iEl/xneX4FDPzZUrimAGoPzPw8pWAAdNnY6yxQw/h0VTYWtx3+5v7bYe
         kQzCKwWq52Jb9wLQ2OwZz154MCLnfNz1FRcEMDf1xy1MrT9i59uUJ1zDHacz7k2CX8Q+
         h8biaL7g57ZUUfQCtQ9fDGt/RbtI5l8pWOgAMFaApakIxZRrk/8toF8boGUHVgMGNZn8
         YUfxq48l8eorJQavAX5KP8wfwIrODzQzU1YsjA5Uvb2V+bRjH4hTkPUXcIJCm8fr/wgS
         FWGw==
X-Forwarded-Encrypted: i=1; AKwUvBwgW5tMOBJkXjQW+WImzuzwVcd5JowQrf157QeEqxexKa7sXG6hWDXWBGthucQSsIWEi7rFWAk=@vger.kernel.org
X-Gm-Message-State: AFuF++nEG6beWwNhdeZ0xAs9cWb35aG1Mu97lJxxMgV8+JP9eS+h6FC8
	083qede+iDaW/ab3IQ61y6qK+vfmPpTkMsit+/VnINptddJfQLauqGVil2ifNHHyTgHh6yGMkDT
	0wrs8r0HnAL1fC9FrBMxR4PbMTZ5xe2vUI9IYxmapkAnqhb3AQNrVl2tMT9Q=
X-Gm-Gg: AYBFou2uWiNIwHCcUX1KDTL2izVlf6tW6TVmhdCXZPzIj+MGzHdD7KMp8Rgqrtma6mY
	VqW4Pzbz5j11DJsbbJrr7/bh42trxsg5lWp8TJ0SzE3goP2gLvzqkeVwi1zoC/yh7dV+w4lexiP
	iFAcU7U+lxiBlaVexhtF7fbuHw6uNvo1ddS/cEKwO4si8ZxzOVanhY3mLGqHK/pXR5dNKu4H0bZ
	AfTdM1K0NR+VQg0bnj9rTAMqQxEoRH/9RLon9bQ1wllNT/ahT8yZtuQo7z9l0Jc21FUw99mvYfU
	s0gbSzR+pAwfzunxz6LX7RV7AAllTREH6xT3JzYBQ72sNpSxYVrTJUuXTC4rniV93bb9xpE3z/M
	pjtjQpUPS4tfUzg==
X-Received: by 2002:a05:6102:3ed1:b0:786:dfa:c5ea with SMTP id ada2fe7eead31-78a4a6be41bmr8841260137.5.1788786106860;
        Mon, 07 Sep 2026 06:01:46 -0700 (PDT)
X-Received: by 2002:a05:6102:3ed1:b0:786:dfa:c5ea with SMTP id ada2fe7eead31-78a4a6be41bmr8841216137.5.1788786106354;
        Mon, 07 Sep 2026 06:01:46 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-485883a9234sm28202171f8f.14.2026.09.07.06.01.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 06:01:45 -0700 (PDT)
Date: Mon, 7 Sep 2026 15:01:44 +0200
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Andrew Lunn <andrew+netdev@lunn.ch>, Ido Schimmel <idosch@nvidia.com>,
        Kuniyuki Iwashima <kuniyu@google.com>,
        Artem Lytkin <iprintercanon@gmail.com>, netdev@vger.kernel.org,
        eric.dumazet@gmail.com
Subject: Re: [PATCH net-next 6/9] sit: implement ipip6_get_iflink()
Message-ID: <ap61uODT6nyW_1YS@lore-desk>
References: <20260907075846.2913645-1-edumazet@google.com>
 <20260907075846.2913645-7-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="x6y67TWbQpfbEDWL"
Content-Disposition: inline
In-Reply-To: <20260907075846.2913645-7-edumazet@google.com>
X-Proofpoint-ORIG-GUID: tf7vnp7n3yh13w03Rtq8S_jajwNxL-am
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA3MDE0NCBTYWx0ZWRfX0MiAB5K7K+Rp
 OOvjyxd3XJzUrdrCzdBTCj9r6TYTkwci8wAX3/ea4Yjqv2AqUA+xiLXe6j4iR8Nxj89K3qRzJ44
 xsIrwZbEiHgAjgFWNWiaS86BS7tDWDnvD1sRtqZcgl40EEscYlL0aEGp4uzsYtldaHTrzjjOwaw
 sBaTK8r+Y7uzYaknHqawK7/rlh3wR7Ejl+C8BudFG1GsnIc9UcJcVtxJsD565dVdfR9amsJWjHJ
 FgBHxhEOyWUvVloxPwerfToOAhAAtOrohIsH/5YkH8vObkunOxxghqUGs+vrUxpqp0f5PzdS3FJ
 oV044Hw6/j7prjS56gqYiB6eHzQmE/bi8p71hBtiBGSbPjWkPtZOn2+iJZoQeTnruMtRM89e9GX
 USFXLSeVWUfcgJE08Q+uLPdkBoPhis5WOLTeQzA+YhQzvpHAMn28f59hFmmK85DWYC+J3f9OOdO
 YpbLVHvJ4aFji0lYzQg==
X-Proofpoint-GUID: tf7vnp7n3yh13w03Rtq8S_jajwNxL-am
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA3MDE0NCBTYWx0ZWRfXxzn4uzt4uimq
 42IiJ8gWZOmrMmUkDCfhBzme3NjjZABMoK41iaNs44xwmvqA3bVubjwBX+/Jny6XUnNGFBATnvS
 9NKM1LAknPAU6HxYWf1tqsJ966K/1sg=
X-Authority-Analysis: v=2.4 cv=AduB2XXG c=1 sm=1 tr=0 ts=6a9eb5bd cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=1XWaLZrsAAAA:8
 a=EUspDBNiAAAA:8 a=ej0_xTtne37M0IgiwpoA:9 a=CjuIK1q_8ugA:10
 a=eL08O1ceQC0rgGZN9rgA:9 a=crWF4MFLhNY0qMRaF8an:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-07_03,2026-09-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0 adultscore=0
 phishscore=0 clxscore=1015 suspectscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609070144

--x6y67TWbQpfbEDWL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> SIT currently uses ip_tunnel_get_iflink() which reads tunnel->parms.link.
> In order to decouple SIT parameter handling from ip_tunnel, implement
> its own ndo_get_iflink callback.
>=20
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Acked-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>

> ---
>  net/ipv6/sit.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>=20
> diff --git a/net/ipv6/sit.c b/net/ipv6/sit.c
> index 7cabcd3afbc4f06d9a08374e6d8df2fb1bfb9676..35c6695909014a2c335f1de7a=
fb48f07b7c91c39 100644
> --- a/net/ipv6/sit.c
> +++ b/net/ipv6/sit.c
> @@ -1444,12 +1444,19 @@ ipip6_tunnel_siocdevprivate(struct net_device *de=
v, struct ifreq *ifr,
>  	}
>  }
> =20
> +static int ipip6_get_iflink(const struct net_device *dev)
> +{
> +	struct ip_tunnel *tunnel =3D netdev_priv(dev);
> +
> +	return READ_ONCE(tunnel->parms.link);
> +}
> +
>  static const struct net_device_ops ipip6_netdev_ops =3D {
>  	.ndo_init	=3D ipip6_tunnel_init,
>  	.ndo_uninit	=3D ipip6_tunnel_uninit,
>  	.ndo_start_xmit	=3D sit_tunnel_xmit,
>  	.ndo_siocdevprivate =3D ipip6_tunnel_siocdevprivate,
> -	.ndo_get_iflink =3D ip_tunnel_get_iflink,
> +	.ndo_get_iflink =3D ipip6_get_iflink,
>  	.ndo_tunnel_ctl =3D ipip6_tunnel_ctl,
>  };
> =20
> --=20
> 2.55.0.979.g7e5102b832-goog
>=20

--x6y67TWbQpfbEDWL
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCap61uAAKCRA6cBh0uS2t
rDPUAP4u82DzucRlYQN9EmdyLqVdC5Y+ra1Bqc3cQUYX3L/IFQEAgT2fgqjUWdML
laucY3WQRd/e2ZYZAJtPc7kJ9886gQw=
=JGWL
-----END PGP SIGNATURE-----

--x6y67TWbQpfbEDWL--
