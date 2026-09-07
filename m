Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E963C4A8A3D
	for <netdev@vger.kernel.org>; Mon,  7 Sep 2026 12:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788784537; cv=none; b=XjMtxstlG00+hII97XlI4kwNSbEvLtxcXoYpxHfiEXCEeTqmL0fT7JUmVH+jOdLrFf958n/7CiA+g8L5sbIcPPRFR0Kj2w/IMUXdA2MJtabRzONb+QLhkDMxBWkexqaGgDtfP4gEL6oJinYrZfDdYNdeU7OUoRx0wb1ThVE94tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788784537; c=relaxed/simple;
	bh=owixjpBVblPVdjoIf+iso/fKmPSQAZTLQuulq2x4AOI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OOA4mT6cDuAMRIvgnIa0/TUvKai+TD+gwXlJ4Y2xwvudCk00940jDFWWHDb/V+phhvVaTQ0q0tXFYXK/y/0IK+ZsnsP05uhav3xbECKIMN78phLCDIH7OySS80OMwKi3a4GUR6wMZMRECcRXVvHL554vneqcVNWm0EHbCf9JvAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SXuWr46F; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=N/i3qyNA; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SXuWr46F";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="N/i3qyNA"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 687Amnxc809893
	for <netdev@vger.kernel.org>; Mon, 7 Sep 2026 12:35:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=JNzBiI9LrY+i99cLeJuIMI/Z
	qqyghhX6HaRMJGKRo4w=; b=SXuWr46F2D+bMpD3SmlACjVmbxhEYcyOq0JRZZR9
	T2dXYFybdgUAth6yD5ItORio8lQMDXH8xi+hgX3AghaiXoy/nCEvjZ5Hg1kD/yCe
	90hW5x3vclcfRKopfqr43YIUiMXjTjka8REVzbXxwmW/O4dMl549K711LKtc2MWX
	cECqRnodvsodvhS16R6OC7HCGokv/L8KUCVPreSaFwLhrPRhtHCm0rN2nbW4QVoM
	SXSalUr3nyyxawGC9iz+eBwiVnze0zkQ+4GoSCONi8EUSoIeecC8vETyw3rckHru
	FHcUUhauxs6SNVh3rGdffGLNbmgX3/c9FX6++dURF6kHvA==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com [209.85.217.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ghrua9d0u-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 07 Sep 2026 12:35:35 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id ada2fe7eead31-78a686d205cso1521986137.0
        for <netdev@vger.kernel.org>; Mon, 07 Sep 2026 05:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788784534; x=1789389334; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JNzBiI9LrY+i99cLeJuIMI/ZqqyghhX6HaRMJGKRo4w=;
        b=N/i3qyNAIbVIayiBuJvBRT1T37ftjpJTDx83gP/lfsoYMiMFOw4EJKz4XFsHoJfUEv
         YuYEki6Nmb+a3N8Pa8hBvLQ01Tk92KpmwnCqFyr/64O/cM87+upcT3Ywfr5yjriuBnlb
         LCBZMnGiLUqxwRgNqfndqFIhRlfEfNiOHzc3CEyPlZSlOLwuFi+Szm6/EDXi3xmcFToD
         Ft54LjpG6tLaGcH2kirsU1Tf2LaznWwb6eLfgr8acjESEkT4CkXye3Rc+hCcZyYr7mUk
         KG18pcPo40kB/VAugLXtPZ8SqHfJtRFuN68NcH+wdfos9wwJVJL0zYnaBJrqfdvyLm1O
         E2+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788784534; x=1789389334;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JNzBiI9LrY+i99cLeJuIMI/ZqqyghhX6HaRMJGKRo4w=;
        b=E0iNTGu7ryhZkHpJeDBJ0TGRBidX/usG/ezKW0ozZT3UCtei7V7XgCp11R8O9GoTn1
         H7IVCQW9EWPSYeUJX3giJgo8MOlKHlg0gkz3QDx/YiTPWdh3uAQ2K5mU2mRxCxpb19Pd
         c7XWy+J8nrbuzxvAGV0d/Wg0++qe1YwjVimrZl/TOFi7Hw1ZqnCOvuSE6mVmTn4+w9Mk
         KzYdhRJorFwu1w7ePI+loRX3KlDmqvCLnzddhtTndu/4eOzpiwpZ+vpHBPw9ltRD8LxL
         95/cC9F29qb/CLw8IQlTNlsWYmJlkw3kYYBREqie574NKZG9YtDHRpNRDgKu1bqhttOH
         L0Zw==
X-Forwarded-Encrypted: i=1; AKwUvBx6XH3x96H/K7Y5sxJQt292CSmGFejkFyb3Z2fT1/Bum1mflP6hfhAomxnZCA/1gaLcRf9lGqg=@vger.kernel.org
X-Gm-Message-State: AFuF++m8n973SJWxpfttyrSGUXtfAG8oiavBYAvawc4d+HX8O2NSmI3t
	kpo9qhn9tSJVz2qnfWXJ4qvw4xwW2xcLVO3ugrn3wyDLQkHz4yoJ5Rs5sR3krnzDCGS2Rna9IHt
	0SoANr66kNJN+h3t0b7qcTWaAAJxFdtQxcGwaN5LiPzqFqid1/wOFL7nzAhE=
X-Gm-Gg: AYBFou1gGuG5BUaheL7tLjPLhIVsj843VtmyfThzv0fzmMCCSOquGCpXLSnw4PF9e6T
	wQ5NwuwR1ZtbHaouLlufz8wVm5kzn/fboz88JTf3nUjS7qOKb9VAH/jZNWVU8NaonoPjJsy74AL
	dgOa2MvlO4+nGoRRXuzBOdWbBNeNoocykqNjh8MyAZDAwnE8/+VMR/rbI1HMSeCWu1AVx25j8t8
	Jc5Ja98SwhKn9DyDfiMuI4znq/1CCnefP9aKha6+WRM+fPvJ6sOHPevHJIn5VR6ZRva2TwX4G+b
	J6WC1VRnwFSTHhltIhazrum5nvRAltAkul3sof2X7/GOIrBjEZDwlZx7QUFvDOvgLBkDZH3F91y
	H9Sz5RF5w6VfblQ==
X-Received: by 2002:a05:6102:3749:b0:785:eb33:87aa with SMTP id ada2fe7eead31-78a4a8b86a5mr9135130137.5.1788784534006;
        Mon, 07 Sep 2026 05:35:34 -0700 (PDT)
X-Received: by 2002:a05:6102:3749:b0:785:eb33:87aa with SMTP id ada2fe7eead31-78a4a8b86a5mr9135112137.5.1788784533486;
        Mon, 07 Sep 2026 05:35:33 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49d057f4778sm205139635e9.8.2026.09.07.05.35.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 05:35:32 -0700 (PDT)
Date: Mon, 7 Sep 2026 14:35:32 +0200
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Andrew Lunn <andrew+netdev@lunn.ch>, Ido Schimmel <idosch@nvidia.com>,
        Kuniyuki Iwashima <kuniyu@google.com>,
        Artem Lytkin <iprintercanon@gmail.com>, netdev@vger.kernel.org,
        eric.dumazet@gmail.com
Subject: Re: [PATCH net-next 2/9] sit: charge ip_tunnel_prl_entry allocations
 to memcg
Message-ID: <ap6vlPdalYl1DxgW@lore-desk>
References: <20260907075846.2913645-1-edumazet@google.com>
 <20260907075846.2913645-3-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Eu+CdjuelrNg5o80"
Content-Disposition: inline
In-Reply-To: <20260907075846.2913645-3-edumazet@google.com>
X-Proofpoint-ORIG-GUID: ZyP0rOfNZ-V01HaUs2pLf1QLf3RVcDDP
X-Authority-Analysis: v=2.4 cv=U+aiy+ru c=1 sm=1 tr=0 ts=6a9eaf97 cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=1XWaLZrsAAAA:8
 a=EUspDBNiAAAA:8 a=78WUonyQSHCOxkIZ2uMA:9 a=CjuIK1q_8ugA:10
 a=z3hNq1dYyUfObSx0JTYA:9 a=ODZdjJIeia2B_SHc_B0f:22
X-Proofpoint-GUID: ZyP0rOfNZ-V01HaUs2pLf1QLf3RVcDDP
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA3MDEzOSBTYWx0ZWRfX1eXcFYjuH7Gu
 4HSaue1yAYXGBhqwS9mkSZ3q1W/vp61LHwWMx7B9TxGllwAMsY+3KTIFbUytWPO1DqAVHoW6pcw
 tyF8qlnfCL+JZFuH6wx7PtqwwDtn4Y4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA3MDEzOSBTYWx0ZWRfX1d9j564T+Gzu
 0GGPNCN5v4kVSrcLkbhrVisAYoXTNI0gqvkP97A0LgLn4A3YxHQwEx5vOpOXT+sbQkRxFC/KWPG
 efPZrqlFhdHjxyQqm6aYnQ/PwZIwW5itaavXYfaXrxxA5Ogcslog6UlphwYguaBGziNbLBqJzvZ
 bkhb/gXoCP6fUCl4eTO9VOla/KIJP68YMEu2O5/XwvKeQscbX64j2/UYNrXD5s2nGs+NMPBR864
 ooOcv6RWNbhXTIzOagbPO2NAphGcyKa9938SKR/XwJmXHtB/6GEA3gfrnW+QQny8O7pUTCIXOsE
 qBTe5z36s/PSN4KB3ikgoxQ31dh0NR/gLDPsl+wM9Qbi9P1p7EgW57GpKdy10wwwuf4eQhp2Dqf
 0NkQNait7KWMapI6YuLOKvo5RsDzewVuaV+I2Oipx+jJKmXHza7Lt2hR0WXJg+TLi5DHFiey7Et
 6b+1QocCfGdRFz8DVRA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-07_03,2026-09-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 priorityscore=1501 lowpriorityscore=0
 clxscore=1015 impostorscore=0 adultscore=0 bulkscore=0 spamscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609070139

--Eu+CdjuelrNg5o80
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> ipip6_tunnel_add_prl() allocates struct ip_tunnel_prl_entry for each
> potential router entry added via SIOCADDPRL.
> An unprivileged user with CAP_NET_ADMIN in a user namespace can add
> an unbounded number of entries, consuming uncharged kernel memory.
>=20
> Commit 1b51d8271973 ("memcg: ipv6/sit: account and don't WARN on
> ip_tunnel_prl structs allocation") added accounting to the temporary
> buffer in ipip6_tunnel_get_prl(), but missed the entry allocations
> in ipip6_tunnel_add_prl().
>=20
> Use GFP_KERNEL_ACCOUNT when allocating struct ip_tunnel_prl_entry.
>=20
> Fixes: 1b51d8271973 ("memcg: ipv6/sit: account and don't WARN on ip_tunne=
l_prl structs allocation")
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Acked-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>

> ---
>  net/ipv6/sit.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/net/ipv6/sit.c b/net/ipv6/sit.c
> index 4438b2472b28764f813b9162bdb9f6b6dee5a007..9a2bbd76d3794849cd11c6530=
ba1303bf53fa388 100644
> --- a/net/ipv6/sit.c
> +++ b/net/ipv6/sit.c
> @@ -395,7 +395,7 @@ ipip6_tunnel_add_prl(struct ip_tunnel *t, struct ip_t=
unnel_prl *a, int chg)
>  		goto out;
>  	}
> =20
> -	p =3D kzalloc_obj(struct ip_tunnel_prl_entry);
> +	p =3D kzalloc_obj(struct ip_tunnel_prl_entry, GFP_KERNEL_ACCOUNT);
>  	if (!p) {
>  		err =3D -ENOBUFS;
>  		goto out;
> --=20
> 2.55.0.979.g7e5102b832-goog
>=20

--Eu+CdjuelrNg5o80
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCap6vlAAKCRA6cBh0uS2t
rAQcAP9AN3u7jqvp5fmAaPJCYktrBmHEQPiDAJXz1T6sm5ymrwD9G5x2ijtqfdTB
L73D2kwLvPbMJ9UoE8zzvlWDOUIwUwg=
=+tJK
-----END PGP SIGNATURE-----

--Eu+CdjuelrNg5o80--
