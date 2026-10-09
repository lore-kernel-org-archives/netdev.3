Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 912E249DBB9
	for <netdev@vger.kernel.org>; Fri,  9 Oct 2026 10:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791541816; cv=none; b=s7OjAR6As4Qk0nScpADcNBHE4HOhBjGzMSqOprZmXxQftzKUy0B6DHplVm2HZiz7gFc2Muz5YR0+crmzZIE5qIKJmGoAYKMydfCNKC5zUQ9PR2GyF75Me3EOJHqtFrwiygKDl5RKpi4J28MaOmY0TfQ86u9XbxnSUiOSWysC1tI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791541816; c=relaxed/simple;
	bh=1lXUr4WIy2+N71VuzaN+tojkq98xBegTiKarMt8wm8o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vqd+E0YVA0PkvMxGrFsoD1yxX2Zsr/whwS3jeWrMJ1zQoWDj5MnopUaQjkYghPYq575sDI5mAlNUTENrxYA0VaOPKfmVxtQ2zVpHsYe0pMSdMOP4B1igTZc1zjcFCJVHOw7qgsbBrkOope21BMOZxk1obO76j784iKENYpAY8Qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=a7AUX2to; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Sj7e2hdn; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="a7AUX2to";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Sj7e2hdn"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6998KI63230945
	for <netdev@vger.kernel.org>; Fri, 9 Oct 2026 10:30:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=NgcRvQ8TaWMkNOqOe2pfYdXq
	Lm8BXmdUD+Z1gEAZJbs=; b=a7AUX2togmSo52xyBK+4RlrWQzV2B2+VWqeCb6Gi
	FWz3p69gFWF2psgrpUKCzkand4b9LRPtXvDHUHsyFMVW+2zecGgsDBnaPG+D9a53
	VjHvkFaJfQFJzBh7bju+56GWvTsmn1LvxzSzN+u09OHaFM+c0YnspQvgs9iCM5Wn
	kHW38v06aVaCg6N1hKt3fdy49q6VH7372T222fge3lm8KbWO95k0PDSgsKTnvInB
	GNnT0CzzIAuPJtwO+HQoyXGxUujyek3AdZOAQhivjVPtixaVzbcjvXjBlHGhnVnu
	PKLNoETNARzr96ChMO+hWJByR6N6bk+Wj9OXNvWQvcphJg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h6fxu33ty-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Fri, 09 Oct 2026 10:30:14 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-53514fbd4a3so138385511cf.3
        for <netdev@vger.kernel.org>; Fri, 09 Oct 2026 03:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791541813; x=1792146613; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NgcRvQ8TaWMkNOqOe2pfYdXqLm8BXmdUD+Z1gEAZJbs=;
        b=Sj7e2hdnt8AN2xgryJkulKzVnxodJX7VtjpaZ3i8ddvz/eGzY/Sop6A9lD7wUJkuXJ
         mNWr8EjZ2GqWHT3ZJuRRKHc0+OPrNo0/mNfT3ViY/Huy+ZoaY9Dbka6bZTtpeO1b/l9g
         ljp9Z9KUZSdW/6TstujY6Iztip9QonpEH7JI6hirpKGXMREZFG2Xy8ktSErN0AkMJa5S
         Tlq2IZzIvobQC1vEJWU0cJAgboahiGdm4y1lSqWTPwTl3zPfdPzeeVuoVe+sJqRKi2il
         EWzblp72NJ1DY/oh0C/kXtL2ryED2tSUwqGJHgBYhdep6vmIkzXe2OGxRdAUhR/RPuW0
         OXUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791541813; x=1792146613;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NgcRvQ8TaWMkNOqOe2pfYdXqLm8BXmdUD+Z1gEAZJbs=;
        b=Q244QDBcUm6bTySZ02IZzrws5u3nWMZQcbOpyqo4VEb4gqc0qZSdJp0FnmQkuJpeVR
         hEZY/qfy8IYpo+8cxsy8VMCQMZJnQ92ln4qxPfo3KLdLhYFdY/I7MyQeGrUtEzmYwNi5
         tLKkrYAauMBVKoHZy45V25vvuGbmKEq3VnQRBFtDx21wMaMXenubDkfJSjRJh017DYBZ
         gqxcM/2bd4UqEnnZazaJq9D5ZwU4eXvgDQZ5o3IPXRfwL62ZDllsh1eSasteFRRg5V/7
         wbtGpLcxG7DI8Ha81v9ZNPi5Trmxe+YaugmN5+JsMIiE71tngDgov+jrvoICu/R7LXRh
         7ymg==
X-Gm-Message-State: AFuF++lzGY6kds8D5H+vYARg8q+3Zd3vnwSs697CB2VEXrJQWtEsh5TD
	lZz4emVSi7YFJloZ60DGJptUnnQlTFlwcMptsQByuqWiQZ2jTPAlBhq4hnHT6T81gvB3owSnb9r
	WSphON2E8T6MulKbjrhUL3mAC3wvgOkiPyDi6u3oJd66Fmah3MB4ubMWIKOc=
X-Gm-Gg: AYBFou2yuHaDZjx4tHqkX32NpqExHtKkZ0VG2nw+xjTWOjaRNruShMJytU+9xspdl/m
	z4qYIkrsho+FI2GVYgnkbwALR0dFbZyGMshc93wLmYNFmbeRzQ8Y6JlEW8ptn5Qa71YPGklraah
	9D/phWZdgj9SoA9ruWpH821TOHgh6KcWxI30G3hNal7v80mtpq8GPX2q5NaBLKCp+BafIt1hoB6
	/FTvZxEvXMQZEsl/cMRJsGOSzLohmD0m3UWHpwnpMaHvkByFTVFaiqjqVVjJNNi+Lw1uZJzzaFT
	k73J+2z/CDXVpXLmH58XwdEY8ls+tWLqZ4zZZkvhJ/y7tBDTf0oseV2G5nXF6r0MTe0OeL/2jvP
	VdIpvPIq5mXFW3Q==
X-Received: by 2002:a05:620a:8905:b0:93b:d7a3:45d7 with SMTP id af79cd13be357-93ebd2ab621mr200232185a.64.1791541813374;
        Fri, 09 Oct 2026 03:30:13 -0700 (PDT)
X-Received: by 2002:a05:620a:8905:b0:93b:d7a3:45d7 with SMTP id af79cd13be357-93ebd2ab621mr200224085a.64.1791541812787;
        Fri, 09 Oct 2026 03:30:12 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a18eb4485dsm71173225e9.2.2026.10.09.03.30.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 03:30:10 -0700 (PDT)
Date: Fri, 9 Oct 2026 12:30:10 +0200
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Stanislav Fomichev <sdf@fomichev.me>,
        Jose Abreu <Jose.Abreu@synopsys.com>,
        Ong Boon Leong <boon.leong.ong@intel.com>
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org,
        James Hilliard <james.hilliard1@gmail.com>
Subject: Re: [PATCH net-next v4 0/2] net: stmmac: introduce XDP rx multi-buff
 support
Message-ID: <asjCMltF_qO8-mIv@lore-desk>
References: <20261006-stmmac-rx-mb-v4-0-efa4ca974e3d@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wgndA7NxLnWRH+t1"
Content-Disposition: inline
In-Reply-To: <20261006-stmmac-rx-mb-v4-0-efa4ca974e3d@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDA0MSBTYWx0ZWRfX/71zD29azxi0
 /sD117jx7sVsnePfy4C3UQt9YOTHaEB4XlbWb8dOD96Fla1ckvs0r/D7V/DQFYgDaXf+Jdj7pdF
 vDJfzztRoWS+w51k3Jy72WkWwAOrSWiU2ASoA4N9hqNp3G69Z8Ih7A1p5CVSSFQsyea7JMqylUt
 3PEGXSAhSrS0eLgt33YivkFXLBUJz5GTzZ4xkzH3sor+tdr2EVd/cehIu0mI4+fmjdcbzs2MYVv
 2WI3Qp2TEc7Jsadm5MXZzjC30Yl4Ge4cJaOfhfxFZQj+/7wTJOcYxdYVJsfzvF++pk3Pm5YxosA
 7hlLcURBWJuRPdPttMjRCBlXTN/FkiFuuJIDUzhgXgLhGa0ATqoNtqtd8gly3/8MYztJN9H5dZe
 kRf5h5Sldj18aWZJY7cHfvXiQFsqq2KqOMTZBP5uaPLWYVHS7+HndBXq9P6jtojfI1mZieG+JmX
 DYVraY9GNjuCeDdYFXw==
X-Authority-Analysis: v=2.4 cv=QbjzLcbv c=1 sm=1 tr=0 ts=6ac8c236 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=w_4PuGcMj9oXbp2957IA:9 a=CjuIK1q_8ugA:10
 a=iAawtVTI3XspOHW-ZK8A:9 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-GUID: IwgYdvsL_I6u4S_y2dXnkKejMKgEjWra
X-Proofpoint-ORIG-GUID: IwgYdvsL_I6u4S_y2dXnkKejMKgEjWra
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDA0MSBTYWx0ZWRfX/mrSQKITfMtz
 YmodqrPXXs7ET5n/7FaYpQ8hZc7pt3eRgjjYwY0WTiIzCbKjMy14wqw5Q1BZrKHizUKLoX4QdJJ
 pWqpbkkvnr+wNBixRg5TN4pjYZwQgTU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_03,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 bulkscore=0 phishscore=0 impostorscore=0 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610090041

--wgndA7NxLnWRH+t1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Rework stmmac_rx() to build the xdp_buff from all the descriptors that ma=
ke
> up a frame, so the XDP program runs on the whole (possibly fragmented)
> packet instead of the first buffer only. Fix possible rx_q state leaks
> when closing/opening the interface.
>=20
> Note that an XDP program still cannot be attached with an MTU larger than
> ETH_DATA_LEN and SPH is disabled while XDP is enabled, so an ordinary
> frame fits in a single buffer. The multi-buffer path is exercised by
> frames that do span several descriptors (for example jumbo frames the MAC
> admits through its jumbo-enable bit) and is groundwork for extending XDP
> to jumbo/SPH; it does not enable XDP jumbo support by itself.

I will fix issues reported by sashiko in v5.

Regards,
Lorenzo

>=20
> ---
> Changes in v4:
> - Reset in_progress flag when the packet is fully consumed.
> - Advetise NETDEV_XDP_ACT_RX_SG capability.
> - Link to v3: https://lore.kernel.org/r/20261004-stmmac-rx-mb-v3-0-50fa17=
1af9ec@oss.qualcomm.com
>=20
> Changes in v3:
> - Return secondary page in case of error.
> - Introduce stmmac_xdp_shrink_tail() to remove the ethernet FCS.
> - Add patch 'net: stmmac: take ownership of saved RX state at poll
>   entry' from James.
> - Link to v2: https://lore.kernel.org/r/20260921-stmmac-rx-mb-v2-1-6e826e=
1ff306@oss.qualcomm.com
>=20
> Changes in v2:
> - Rely on xdp_buff_add_frag() to create xdp fragments
> - Fix bugs in rx_q state recording
> - Fix the corner case where we receive more than MAX_SKB_FRAGS fragments
> - Cosmetics
> - Link to v1: https://lore.kernel.org/r/20260918-stmmac-rx-mb-v1-1-0b4517=
d404af@oss.qualcomm.com
>=20
> ---
> James Hilliard (1):
>       net: stmmac: take ownership of saved RX state at poll entry
>=20
> Lorenzo Bianconi (1):
>       net: stmmac: rework stmmac_rx to support XDP rx multi-buff
>=20
>  drivers/net/ethernet/stmicro/stmmac/stmmac.h      |   3 +-
>  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 390 ++++++++++++++--=
------
>  2 files changed, 250 insertions(+), 143 deletions(-)
> ---
> base-commit: a5e7d8e446af9803e37a3b6a4d416fb41178348f
> change-id: 20260918-stmmac-rx-mb-16469a2714ea
>=20
> Best regards,
> --=20
> Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
>=20

--wgndA7NxLnWRH+t1
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCasjCMgAKCRA6cBh0uS2t
rG50AQCJYxpyUnrWTKBC3SmBXC/JWh1W3xsif267HbbxwknqiAD9HAjk7mvQ9cxN
BvH8j35NkTDGkCOs7eHeKweP/asd7As=
=5yYK
-----END PGP SIGNATURE-----

--wgndA7NxLnWRH+t1--
