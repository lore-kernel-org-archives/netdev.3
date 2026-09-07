Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63EEA4FC8FD
	for <netdev@vger.kernel.org>; Mon,  7 Sep 2026 15:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788793944; cv=none; b=I1ySi7gml+YSF31ieZCO138qAFMQmFh8nV3eRNMIwIipuqtHDM7KuR/swmnL1n+yLYO1WeFDWgBENH2TND7KxdrSK6du7zKkF/dYRlBX1FAwZ+R7qp+x4FFKt8tQ10cpoovZiN26NwPkIVrK+uG7+jCj3dr7YGtnWqp7qPhrwbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788793944; c=relaxed/simple;
	bh=p5HrLjAbS9pyQFQHSDJl1m9afLnHH0GIeqrTQGVrTsE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hebPeX3z+T25sMMnq8VNo7R8EWJHiBVIA2QPfxgr4mRyJ+DMhiZzujmiWNe9URiFFZI6+if/tl6457CupMOVDtUOowXslioc7mVPBxtz9aQhxeekXf8+CSgS6ipVnslNOHjkEudzBmDfBEd8IZh/yZ++sYIVlCq6AsOPO82dlpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bGY2cfz/; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=J1ENCgyO; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bGY2cfz/";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="J1ENCgyO"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 687DdV3X4149434
	for <netdev@vger.kernel.org>; Mon, 7 Sep 2026 15:12:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=dQfbt5E3PW/rgIYa3X2UcABF
	D5ozfueKchjDS7aBosI=; b=bGY2cfz/6a2sYfi1MIipyiQtryLE/i3inu49QNaT
	CUeNN8t0171Qt3B9HzY7vSx7e/OT/CWnIC377wHHyE8sPbTDZQVSJIk3ia9sfjU1
	Kvw/gfbLgZm/wh3vm/atbrqPh0Ffh+Y9YaIOeUoulyDP0qVKKzZeLPOUFX5GAQ2u
	5u0IfWbjbYpfHPvaxpi+1BCTvtvTXSmjoxt0UMlySBaU7ZYKRDE4WL/oeKywIxtc
	cpzmsfHyc3ObJQVWFgPRal7czwQ7GRQz3pFKnYTn/2NVOA+8a201f1XShmZM7+yA
	6oJ4KyfyJSY+vMt7GEO+mm1nvsby9HK0fWIMmNDYM0WK0w==
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com [209.85.222.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ghsfyhmm3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 07 Sep 2026 15:12:22 +0000 (GMT)
Received: by mail-ua1-f72.google.com with SMTP id a1e0cc1a2514c-9806535f8ffso3559780241.1
        for <netdev@vger.kernel.org>; Mon, 07 Sep 2026 08:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788793941; x=1789398741; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dQfbt5E3PW/rgIYa3X2UcABFD5ozfueKchjDS7aBosI=;
        b=J1ENCgyO1FauUGXe5LgrML4PLkGDApJoShDuL1Fscp+8uJ/uI/VUIgHk6e5UJepYPE
         7hHez2SMAB6Uo9aoRukDb/5E2HCyUmmsDP7MjtMk6gE/HCBnC/f92t/YMGTWaVWsGfSi
         hAetcvDeJgpy4maBBJPc2FVfVK4zwVbS8KfNNuN3RcC4k/LSGTr4SDuK4MgtPPmdr+DA
         10Gh9ree7DGWKHXybrgb6/5jyKpfs4ZhgtBly5RdjeVzucGhK6pOKhiat5G76rbWdUGN
         21Ets+X5QM+0CUGMqWGKPrTpj/JJRDG3dHS2bDnWF1WZL9OkiiYEnBuOmr75ZhFHGwRj
         oQkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788793941; x=1789398741;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dQfbt5E3PW/rgIYa3X2UcABFD5ozfueKchjDS7aBosI=;
        b=nXf411ddt9+397DbFAEZz8VnLTymBOLxUsutFKs9zEAR/xjs8ZhUClrRTp0TIA+0Ap
         eIwm7w2OmEa9D12uXufCjlgXzDf3uUyz2rvuMM5TKKKHWig6ar6yUoF4klx7vVtDbCLb
         ZWrEOdZoTbCGadoeI/7cOYjWlnl5+tulq5+oI/caV6A811RI5EU14X4CM5S8MwUsreDJ
         s/30ZvXHThnx1c6DUqz92lZLosoNYQXs7ylxa5gPZHj1NNO8QhtRIGD87qx9o44vbO73
         NulExse4G2E3WLuvzauWukr0o14l8BBGr4MMbANm9Y7obhPkYz6RErXmDxKpoG0vGiLO
         l3Lg==
X-Forwarded-Encrypted: i=1; AKwUvBzuOXAKMdPoDmZSz2XzmXGNyqgoFrDecTKIm/vblPeHRzAGdpHRXoEiYHUtCH2ea33A0HtQlcw=@vger.kernel.org
X-Gm-Message-State: AFuF++mvUfhaYgBImpPxD/X4UEQgz+DApeyjSUsPv+G4tz8EhzR9hFJI
	XknyPyV7Vy0mr8olG+IGxryKvM4DW/2yU81Swb5ug4sCHZGKzLm4+PNTztC1H4NGQGIq9hkXcB3
	H88O3QEuR8UZhe3vq6YxrFzPf2PIWgUcv+FNbzZIQTFDnRgcm9Reyyq8xvyg=
X-Gm-Gg: AYBFou13j1IuZQRVBvYfI5nMW2YfUgQ+Kyzll5ojnubTffmStRXKH3p4Mn2otkFMvrF
	S7iZTWiK83fmu4ndZBk3fCNLaYRo0K97uqQUfCvuuDRxNFU4/BU9s5IpE8n1lIG1fFg/9GirpYR
	U3a6oX6eOZ+bayqAW8vCX47kwlq9a+J02wpFwbPDy+v31zSY6SZxYEOvx+gZAdETe3mEdR8/pcA
	GZLQOL5wC+VAL86xd8m5b7soDQmOmkGCX6yQRrye3OejVxRujfUGnEbBQZQqxV0s0qDFnuucVs4
	ZdCCAjcUPW39qgazefK8msZW1WmES4RPbSEbI23oe75QtoolQvl3a2FEcjEP5OEwGm3U0Duv3Vs
	0TBJFXDTYiDHwyw==
X-Received: by 2002:a05:6102:6495:10b0:734:54fa:971d with SMTP id ada2fe7eead31-78a2ee06a31mr5629424137.7.1788793936257;
        Mon, 07 Sep 2026 08:12:16 -0700 (PDT)
X-Received: by 2002:a05:6102:6495:10b0:734:54fa:971d with SMTP id ada2fe7eead31-78a2ee06a31mr5629415137.7.1788793935793;
        Mon, 07 Sep 2026 08:12:15 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49d00031c95sm279833285e9.11.2026.09.07.08.12.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 08:12:14 -0700 (PDT)
Date: Mon, 7 Sep 2026 17:12:13 +0200
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Andrew Lunn <andrew+netdev@lunn.ch>, Ido Schimmel <idosch@nvidia.com>,
        Kuniyuki Iwashima <kuniyu@google.com>,
        Artem Lytkin <iprintercanon@gmail.com>, netdev@vger.kernel.org,
        eric.dumazet@gmail.com
Subject: Re: [PATCH net-next 3/9] ip_tunnel: use WRITE_ONCE in
 ip_tunnel_encap_setup
Message-ID: <ap7UTSat1dLjamcQ@lore-desk>
References: <20260907075846.2913645-1-edumazet@google.com>
 <20260907075846.2913645-4-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="kwHWy4Oslr/sHH9R"
Content-Disposition: inline
In-Reply-To: <20260907075846.2913645-4-edumazet@google.com>
X-Proofpoint-ORIG-GUID: RZk1zqNdUzjDb3O79nWBlvCM-AZacsAV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA3MDE2OSBTYWx0ZWRfX8jYsL3dt7RYU
 NOLNkfbucketv5BA+F9HimV8EWDOj0hRktEDTWVndjEllu2sH5AOXh1Ve3JjRTJNsMsEmZ8AVFi
 RjbXrAgTEKwWHer3FOB8U5CgcjHik48tc4d9PQXkXnozCb+bvbsL0nvmnrkFQhjdFf04bvte0nD
 aeD8lcLZ+8NKHLbXNlEjPewI+DRxKgkZjL3GJFnxVOqhkttN5J7ThYFpBUaWdMZdZPmFurgE7KM
 gUEZHFCbILSoa1ADh5yUqYaz0tIWfNVUgWVRAJCW5PvMd/xrrd/Lj3wnIEzgbN5DmrTUYj5PR5/
 TLE7kuWHcgBnjKGkvLdt17IZFio7lT5f5GdUL50Kq9l/zrWFE6SVAHqxNj1Lh0oPIKuQjSd4XGF
 e935l7ZI+llTOmt3rmWgQSEvPEXs1U70rnzL99JGUYg0RgtOQizJVP1C1lBH2AIlwg937hbXgDd
 62lqM4EnThQBm1ucjGQ==
X-Proofpoint-GUID: RZk1zqNdUzjDb3O79nWBlvCM-AZacsAV
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA3MDE2OSBTYWx0ZWRfX3hw1+LwiONAz
 qThs+cGty2qOhw7qkLxeB3QrwK5f0dZTgtfcXzscbF5vS+MkBRLynoLyVCKMPBty7F8S9lgPOTV
 91SHSI4BGcjP+PsbBFRxVfYF5tOSo7A=
X-Authority-Analysis: v=2.4 cv=AduB2XXG c=1 sm=1 tr=0 ts=6a9ed456 cx=c_pps
 a=ULNsgckmlI/WJG3HAyAuOQ==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=1XWaLZrsAAAA:8
 a=EUspDBNiAAAA:8 a=f6_07Eijtlnzn1mTpbQA:9 a=CjuIK1q_8ugA:10
 a=h5nB1vRh8GYPN8VtIYEA:9 a=1WsBpfsz9X-RYQiigVTh:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-07_04,2026-09-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0 adultscore=0
 phishscore=0 clxscore=1015 suspectscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609070169

--kwHWy4Oslr/sHH9R
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Update ip_tunnel_encap_setup() to use WRITE_ONCE() when writing
> to encap fields (type, sport, dport, flags) and hlen fields.
> This ensures that concurrent lockless readers (like fill_info)
> do not see torn writes.
>=20
> Also remove the unsafe memset() on t->encap which could cause
> concurrent readers to transiently see zeroed fields.
> Removing it also fixes a bug where t->encap was left cleared
> even if ip_encap_hlen() failed, resulting in partial configuration.
>=20
> Fixes: 56328486539d ("net: Changes to ip_tunnel to support foo-over-udp e=
ncapsulation")
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Acked-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>

> ---
>  net/ipv4/ip_tunnel.c | 14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)
>=20
> diff --git a/net/ipv4/ip_tunnel.c b/net/ipv4/ip_tunnel.c
> index e6bcf01411d0bcd12cc9a88e449d9283c4a83c64..13b5e35e8790b13ed4c87f28d=
46aa2bafc9ad72c 100644
> --- a/net/ipv4/ip_tunnel.c
> +++ b/net/ipv4/ip_tunnel.c
> @@ -491,19 +491,17 @@ int ip_tunnel_encap_setup(struct ip_tunnel *t,
>  {
>  	int hlen;
> =20
> -	memset(&t->encap, 0, sizeof(t->encap));
> -
>  	hlen =3D ip_encap_hlen(ipencap);
>  	if (hlen < 0)
>  		return hlen;
> =20
> -	t->encap.type =3D ipencap->type;
> -	t->encap.sport =3D ipencap->sport;
> -	t->encap.dport =3D ipencap->dport;
> -	t->encap.flags =3D ipencap->flags;
> +	WRITE_ONCE(t->encap.type, ipencap->type);
> +	WRITE_ONCE(t->encap.sport, ipencap->sport);
> +	WRITE_ONCE(t->encap.dport, ipencap->dport);
> +	WRITE_ONCE(t->encap.flags, ipencap->flags);
> =20
> -	t->encap_hlen =3D hlen;
> -	t->hlen =3D t->encap_hlen + t->tun_hlen;
> +	WRITE_ONCE(t->encap_hlen, hlen);
> +	WRITE_ONCE(t->hlen, hlen + t->tun_hlen);
> =20
>  	return 0;
>  }
> --=20
> 2.55.0.979.g7e5102b832-goog
>=20

--kwHWy4Oslr/sHH9R
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCap7UTQAKCRA6cBh0uS2t
rN92AQDM7fHzvbLLgghuBWHvpF8QW4Jb7mnSLoWitZ5vjubSjQD/dyjjNvoGj5oY
N7qHDxw9W6nh0t9IjN+ZGxUqVQ1pwQ4=
=ztjR
-----END PGP SIGNATURE-----

--kwHWy4Oslr/sHH9R--
