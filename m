Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 609BE472F61
	for <netdev@vger.kernel.org>; Mon,  7 Sep 2026 12:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788784105; cv=none; b=ppZk5mYOsdpNMHL4JH0OEAcycJJlPfOSiXGk8ChIBjYXmAsPtpC2q2kSiRsaM3maMpTtGd5GiFGipKEURwwtyl643B/JGJM6rvE1UxOeCVZczXPXoKXs/L5UHLllu7QDqpu2JgiXvNesTTFMddot5iRxtBZt9npKSk/TOrc4ivg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788784105; c=relaxed/simple;
	bh=KqU+TgTV8oAimwDxhHISwaLRSSt6xtwrzt8qVSSkgqY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jt3o9BwtMgKn6yCObVb9s7C5qbKJTNdRFLAxUUAO9+EAU15VOlBOs9Fz5QGiXNOTj0yS0v23JS5dB7qIjK33+l/HrR+9e+atkmy4RzLuyPcbZuW5MY+LeKi8ASlfyuBwAkWrPcgrsNoyBnvANx43g3MTaK+TBC79rM7cXgyOQTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hRCa/wjU; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=AiQn/3Cd; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hRCa/wjU";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="AiQn/3Cd"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 687An1i53230457
	for <netdev@vger.kernel.org>; Mon, 7 Sep 2026 12:28:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=vUmkvUApPkHOud0hZ6FNBSXO
	DiyX+2WLWvJaoTOVyhA=; b=hRCa/wjUqrgPJH9b6JQT7tjjHAJdxGMsj2MvGQ60
	5XLIX3zEcDavlaHHTsWcxaJUVH7qlT01WUvlwIZ7YD+spKFbWYuJYpN9gaBfJTKa
	XEby8GFHNyfxLUyKOperxsHXWU0qEhWU1tH3NgfbPI2pXZTz7nDTOtUwq4jpPYxD
	wQ7WnjvVVzgJXazSXG5+u+TSQEYYF9ylgmi3kolwWPTZtpmrtSDSjWAjJagScmlK
	gK97l1onn0R3lzwKPR4mKsKhyNj/Ptt3r0Z/uGLJQ+iok11lDdpscu4DdFHkBwbt
	2ObtFY9uCympQDZDdK+IEs4y6GjJQwMr9fPhPIEk4M74xQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ghfxktpd9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 07 Sep 2026 12:28:23 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-9375d92d8cdso697160885a.2
        for <netdev@vger.kernel.org>; Mon, 07 Sep 2026 05:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788784102; x=1789388902; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vUmkvUApPkHOud0hZ6FNBSXODiyX+2WLWvJaoTOVyhA=;
        b=AiQn/3Cd0zSAD03u+nqa79ZbFiyQEt5HIBMgXy4fhJZuGJ+Ue2PqIgKolXk3L3HRnv
         AYPJjdAnobxfkHDU2FX/RWt19Y2tvrnSYTNQToCpO8kuVHnLjH9fGNaxciSCUZorH92b
         cpFYN8v7Clx9DQGZNncHf2JolZ9phrSwCMqNLlne82VzkUP3KewEsLAKS60zrQPO0Hf/
         yioOwTXdpxJYU37DxPccahRxJgY2trNI94Q/lN6bvH+KSnppMcgCAP3o/RMJ0KMsunOI
         H+HbcqKuIckZvcV4Dh/EcA0Y3Nc8QY0voDaxHhx14afdMIK9usxetq/PD4PyeAM1UuLC
         HIrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788784102; x=1789388902;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vUmkvUApPkHOud0hZ6FNBSXODiyX+2WLWvJaoTOVyhA=;
        b=kl2zPbDKV+qEj1iPtk7ZqgyKLrSbCJBBN3WQMhMHzrMqKt1m9QwYYAmWHj/p3/ObAz
         WzbpXl3qKM1pzQ0lNosv61KxF7v1/SCjoQnik7k3WKSO+H5uZ01T1C7P1vpjjtgN100Z
         VRxct9N2a4R1EieK4zuBE15jyGMeUGH1IFNRA65VhubrRLln2equruWyESzRT0CBnukE
         0wwGuYAweXSJ2HRjX7f223sRWn0BOLWDQ9/zR+6XDUENufoq4TS5vZ3E9CRwshNeI3N5
         prwIEaeCDjN4URLnJtMcs22918ARrVYa8n0y9DIgk1Em48jAGQkItKNwq7/zPDi9pIgs
         O3ZQ==
X-Forwarded-Encrypted: i=1; AKwUvBwnrOmIGnFoRx2RAE181kLxecntArr9s1gg77P61aXoiWigxIuYadATJPgSEJlPFm15Uca0KZc=@vger.kernel.org
X-Gm-Message-State: AFuF++lKHG99+StqR/2AyAZ/MPRaLDLV0QOkrGAiD/IZVmjo9nHIMOpi
	u1CewOV8/fHXQ/mYXHc3Kb2UkXLghI52op/ecD2+D/rK8TSAVIsHpQbvoyu5znTH0LUw96LGoCg
	yY1KxXCg+zVAl45Qk5xYxksGoYEsWY1GAYe8+qDxRWG8zrMpSJ7e+HX5z0DA=
X-Gm-Gg: AYBFou1WSVnop0v4ULK3+46g+q3LBNzXUY1YLa/bJlZRqUqk0La8+wZkpXpBcUU1Rn1
	KJ1XL3jDLWO2AWgg7Mz+8otYbTAe4VBEABNUH2VtLK/7LVElHiFiH7U78afvqY7clWgzkmKQvLg
	w7T1QrCImqNJF3qmBxwVn0r+9pf0PCLiRtlRPk1hQnim22sr6/K06BILaX5UFl2S1a+N8h3Jyb5
	7NL90RwNMxpBgCWKrF+MLcgBlSfYMyK6CXaiW0iA2Y7YT+FvKjFKdqOJkjStR64OIyK8GwbqxAi
	JNG/0+z5F6grgd9dM4bdPVSIlXwfBv8BEZkCGsAP/mPS+aCB+JpXgf58eAmWZJbWhjSu8heuPZc
	kE906Qw7ofV7kYw==
X-Received: by 2002:a05:620a:f0b:b0:939:a1cc:f234 with SMTP id af79cd13be357-939a1ccf31fmr884638185a.5.1788784102519;
        Mon, 07 Sep 2026 05:28:22 -0700 (PDT)
X-Received: by 2002:a05:620a:f0b:b0:939:a1cc:f234 with SMTP id af79cd13be357-939a1ccf31fmr884632185a.5.1788784102039;
        Mon, 07 Sep 2026 05:28:22 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cfd3f8192sm268111755e9.3.2026.09.07.05.28.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 05:28:21 -0700 (PDT)
Date: Mon, 7 Sep 2026 14:28:20 +0200
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Andrew Lunn <andrew+netdev@lunn.ch>, Ido Schimmel <idosch@nvidia.com>,
        Kuniyuki Iwashima <kuniyu@google.com>,
        Artem Lytkin <iprintercanon@gmail.com>, netdev@vger.kernel.org,
        eric.dumazet@gmail.com
Subject: Re: [PATCH net-next 1/9] sit: fix UAF in ipip6_tunnel_del_prl()
Message-ID: <ap6t5Pgk5KEtBF0f@lore-desk>
References: <20260907075846.2913645-1-edumazet@google.com>
 <20260907075846.2913645-2-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="RmTdQj5EPbtw1PE/"
Content-Disposition: inline
In-Reply-To: <20260907075846.2913645-2-edumazet@google.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA3MDEzOCBTYWx0ZWRfX+Y0ureg/usyk
 LPWmbAd3g6Xm0MbeGCrtlyWNc51qE1+YXbLWh4mGYq9A83r54FryHW04atYHcQOD4XJpBCKF9Ay
 BVSi/XCjES32CDKz1tYnF01A7DwykYY7mBAbsTp7ewsy9S5+nLVvKX/PvbAvMoPDwIYTJBnaYiH
 rim6E+Jx/eR0TKJrnupQ1Wolmr8d+g6SA2eAt5ytIOt+x4CSjMNGAzDCRRsc6Hwye+bjyqSG1qd
 p1xehcOxLNoo5aIhU1FLKnCxw7vw9rnWpgUVeq+NKZ1V1Ik0vpT0x+rzTwmxf5aEE47hHkfcBjq
 6Y9sd2d2fzcUgHeafPvePUhtrsPpmPAonNP3M9WyUU9swLIf61EKcV7vzXjI5feX0UBXt3ri8DE
 u1erQ4u1xiCjyLWRkoGsWT6zkcJRDDZu40v2AaUJwCvHbNzryYoZ/WwsHmJtNdoa2lsMWyZ7xhA
 vZtcpiZs8yVTUxyjIRw==
X-Proofpoint-GUID: -ExvzyCERtfgTO9iIMysz0D2yF6pEh8T
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA3MDEzOCBTYWx0ZWRfX9+f4im2Sglad
 qtWWkX8JlxMOmX2EQjsNAM834DtNyxFRHYCA9n3Gy4JOYy/JF5zIomGDqUldhiZZzEW4U+233DZ
 Id4Yj/CLYlTN/11OV3a24tJwrybmS4s=
X-Authority-Analysis: v=2.4 cv=daOwG3Xe c=1 sm=1 tr=0 ts=6a9eade7 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=1XWaLZrsAAAA:8
 a=EUspDBNiAAAA:8 a=NcTIorB6OzSWt4v00c0A:9 a=CjuIK1q_8ugA:10
 a=VwW73pJWzh3Psy31ouwA:9 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-ORIG-GUID: -ExvzyCERtfgTO9iIMysz0D2yF6pEh8T
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-07_03,2026-09-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 bulkscore=0 spamscore=0 phishscore=0
 lowpriorityscore=0 adultscore=0 malwarescore=0 impostorscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609070138

--RmTdQj5EPbtw1PE/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> When flushing all potential router list (PRL) entries,
> ipip6_tunnel_del_prl() called call_rcu(&x->rcu_head, prl_list_destroy_rcu)
> before clearing t->prl.
>=20
> A concurrent reader in isatap_chksrc() could enter an RCU read-side
> critical section after call_rcu() but before t->prl is set to NULL,
> allowing prl_list_destroy_rcu() to free nodes while the reader traverses
> them.
>=20
> Clear t->prl using RCU_INIT_POINTER() before invoking call_rcu().
> Also use rcu_assign_pointer() when unlinking individual entries.
>=20
> Fixes: ef9a9d1183b3 ("ipv6 sit: RCU conversion phase I")
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Acked-by Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>

> ---
>  net/ipv6/sit.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/net/ipv6/sit.c b/net/ipv6/sit.c
> index 19b7fa8d1a2a07991a00b250c5ae58819d104e79..4438b2472b28764f813b9162b=
db9f6b6dee5a007 100644
> --- a/net/ipv6/sit.c
> +++ b/net/ipv6/sit.c
> @@ -436,7 +436,7 @@ ipip6_tunnel_del_prl(struct ip_tunnel *t, struct ip_t=
unnel_prl *a)
>  		     (x =3D rtnl_dereference(*p)) !=3D NULL;
>  		     p =3D &x->next) {
>  			if (x->addr =3D=3D a->addr) {
> -				*p =3D x->next;
> +				rcu_assign_pointer(*p, rtnl_dereference(x->next));
>  				kfree_rcu(x, rcu_head);
>  				t->prl_count--;
>  				goto out;
> @@ -447,8 +447,8 @@ ipip6_tunnel_del_prl(struct ip_tunnel *t, struct ip_t=
unnel_prl *a)
>  		x =3D rtnl_dereference(t->prl);
>  		if (x) {
>  			t->prl_count =3D 0;
> +			RCU_INIT_POINTER(t->prl, NULL);
>  			call_rcu(&x->rcu_head, prl_list_destroy_rcu);
> -			t->prl =3D NULL;
>  		}
>  	}
>  out:
> --=20
> 2.55.0.979.g7e5102b832-goog
>=20

--RmTdQj5EPbtw1PE/
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCap6t5AAKCRA6cBh0uS2t
rBrsAP9WJWEuqIYrQwAe1wVKcfAFJM3fzXmq9I0qH2Sl3nB0KwD/UC0R1Ut9WRx/
B6aw7nx54xDPejtUhRU9zWrXJKGepAs=
=HPV5
-----END PGP SIGNATURE-----

--RmTdQj5EPbtw1PE/--
