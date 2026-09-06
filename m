Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80AFB382F0C
	for <netdev@vger.kernel.org>; Sun,  6 Sep 2026 18:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788717713; cv=none; b=hvfmfeM8JP0ZTVCZAqvC3ycfFYJ7eoe3T5BbJmUTsyfWbIQeBVn/05tb66PPkM1xQ82bVbDoehKbgX1t0O6ZLe7JDtZAmuCNg6r/GPaxlso20Dh56mVAiFY+TuUw10FR9aDVvpPbcJ+JpNFtTuQ46c1cMy9cb/KOzDndCkx6wN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788717713; c=relaxed/simple;
	bh=GUTPmQhrCP9yvcidN1Fin9zSiN1YDAsDej6CraxZ1uw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HRyT32cy/qhkYP1Dw+EYQkXHgQ2EGNA/pLo88BPrICheK31Q67sWnEK6ueCHLbRe67QJqJJ6+inwKvclY9edTsQxUi8kAccBpxgkidTHyOy0zPxqe9B0jmwRF1OfW+IPqPH4wqvl+1Wc/jmfMaIhgv0cvM+cbvqDKOMbzATWwQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=F3chIfGV; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=N8zkB3MR; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="F3chIfGV";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="N8zkB3MR"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 686HmOL01170761
	for <netdev@vger.kernel.org>; Sun, 6 Sep 2026 18:01:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=tSD1AQ8YNJcxrDRm1u9U/EB9
	4J/kvvGewRpxLnEWee4=; b=F3chIfGVxRE5LbEUbXTJnqpJ4f9bihyTrVXHE+AK
	pqNRsEChNzSHP6Z4iQC9YpRkY8TtmOnl7wOUBt/JtKo+Uf3T7btBrZmG2S9doGSh
	6dKpVnaUYfuvPnePtUlSRQE/UVH8ygcikWX+6XCDT1dhgX7g1ZVawcnRx2EXi4nh
	0ZkEbqQbbrmcl5LSqU36/9hwTmaVNCzqTqZ9pnJgGQS1uCj5+R8RIZiFmDSOuCyB
	Z3EsbTG+zHFmBgPrOyq0V0awIVx+KQnAl5C9kZ1DHLyvBF9hOR8PDwZL1lhbU62k
	Ns98LYUkx0lT7nJUzVD8xSy6kwnb6LiG9hYX3X1wK/cJZw==
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com [209.85.221.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ggbuekywn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Sun, 06 Sep 2026 18:01:47 +0000 (GMT)
Received: by mail-vk1-f197.google.com with SMTP id 71dfb90a1353d-5c7ab4af214so753531e0c.1
        for <netdev@vger.kernel.org>; Sun, 06 Sep 2026 11:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788717706; x=1789322506; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=tSD1AQ8YNJcxrDRm1u9U/EB94J/kvvGewRpxLnEWee4=;
        b=N8zkB3MRkwzDUiYLvXIJ2MBDI7+gZxe/R6lUyygc3SxMSNxprKgNgKettHnirTwUQI
         KRYqcYvtHVxo9zGweEbsBclarbOA3H60X1c3Q5ESFHMN782SpsuQ55ZEx7KICxN39wX2
         tRDqZggeTM9bTXJWZrTZ2Z7dd7U71YYbEIBOXibVl1fpltsb4OqdzDB3SsYesqgXFhPU
         QWmsK+sxCXox+UTGJCdI/XQ+uHoM0/M7QXQu6IItlk3sUoat+Vz/fivlRfCK636nvcDn
         NCX5zEJS18QjrU/UZmjHPpQTilqjrYwMECrIrMMXsI7uuzCMiMOPE9YPFyIPzzdKfFDb
         46Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788717706; x=1789322506;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tSD1AQ8YNJcxrDRm1u9U/EB94J/kvvGewRpxLnEWee4=;
        b=Ej4F1IBQOcuzmyFbkOQU1ODLoDnZ/Ppxj+wNuSsHHlEI/Lna2n6glOxbQeu6y/Tem8
         9p9amaznlht3eMLKfDIrapQgNySmFJJMOLvIk7xAcIrt40gC//fmmnUfi5cLQ13iESGe
         LmX6sblFJFDBfXzZq/mIHjlosxlTA4yyD75uKJFdj1+9Gcy7f+6S4GFe9QOd4iiUbM1b
         N3GfwSjir+JqL5f9JPDYYNGAHrq+WTcPhbO563vWM7OO68WYr1JdQwfg5qS2blA8nup6
         7+UWpYtCk4mI4VgRc165TcJE/pe49lkRxoDr7nNvJLxViY63khsCbF/NlB9aTLq5a6bF
         4CNw==
X-Forwarded-Encrypted: i=1; AKwUvBwCd1WSOnIXt2oN+TT/eY2lirF6huQfUGHY45FeGtil4fc46hiQH0PaZ2fZ1RidozdJ7YrV3Ac=@vger.kernel.org
X-Gm-Message-State: AFuF++nPk4141QRFwBUx4LiB/E5+ZKtvHd1FykRRWSZiBqpqO/3U5oKJ
	1u6yEg1sa/DeQwZQcUQH+Sayv2ahPcqIyldGzsf0S9nEcIQjgA2aVkcUbMZzirGsAt4AOrX2zMO
	YUBlo3rHCj0CZd8HpJ9zU2s6OfK5VhCZwsswJmVaqux21TLDuzevRcWi3b+Y=
X-Gm-Gg: AYBFou0YctGztAXKTT2sd/rHNcjxdB/5l2sD5kHGb/ItxJy+InSwMPeh/4OygqKZViH
	OL9yyl/6tRTylj6nqVyU8Jlp4LuLg5hqBCjbCwkMMM4r5fkE2zT6yb0Mr+K4nn9yipdLnrIMzLX
	c9wCUY+o6Zj6SGJlilZ6Zrxirqm0bafAcY0JR4xXz4a1KLVrHnHvhWeXdqqwwdxaNDkWNyThgyS
	SeFmUOee+OWnLWBpdEqnJPbGFLZKxxHmVBILp35bUEDEkQ94q7vTVBio2kRoKMUQLiDfQ+Lf5Qj
	VflcbGYL5IbDTYce35JybJremJlomJ55QA0MHcIRXJZ8HAJeZo0oZ6ChfZOr7X2J89j/5OAxEX3
	G/sQQJ6YSYvTLDw==
X-Received: by 2002:a05:6102:41a9:b0:784:4d38:ef58 with SMTP id ada2fe7eead31-78a4a57f683mr5696890137.0.1788717706350;
        Sun, 06 Sep 2026 11:01:46 -0700 (PDT)
X-Received: by 2002:a05:6102:41a9:b0:784:4d38:ef58 with SMTP id ada2fe7eead31-78a4a57f683mr5696869137.0.1788717705780;
        Sun, 06 Sep 2026 11:01:45 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4858bc74298sm19933452f8f.6.2026.09.06.11.01.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2026 11:01:44 -0700 (PDT)
Date: Sun, 6 Sep 2026 20:01:44 +0200
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
To: Eric Dumazet <edumazet@google.com>
Cc: Ren Wei <weir@nebusec.ai>, idosch@nvidia.com, netdev@vger.kernel.org,
        dsahern@kernel.org, iprintercanon@gmail.com, davem@davemloft.net,
        kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
        tom@herbertland.com, vega@nebusec.ai, petalzu987@gmail.com
Subject: Re: [PATCH net v4 1/1] ip6_tunnel: snapshot encap in xmit
Message-ID: <ap2qiIS2cQZB8D0h@lore-desk>
References: <cover.1788262122.git.petalzu987@gmail.com>
 <2ce8f3e4bbed6060afb0aee33dc4e1d9ae021280.1788262122.git.petalzu987@gmail.com>
 <ap2ksmdL1FFulLnF@lore-desk>
 <CANn89iKeNgRxhkUvxeMmyAJGcT+3hpbWaM+VubQ2sBVGSDeouw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="FFrCH4JkhHLzpD2B"
Content-Disposition: inline
In-Reply-To: <CANn89iKeNgRxhkUvxeMmyAJGcT+3hpbWaM+VubQ2sBVGSDeouw@mail.gmail.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA2MDIwMSBTYWx0ZWRfXzo79TwhGSqCX
 0eGx8HLIAajLIrRRwzSFEwyeDeYv6k4uTgvUFdKFgRa3jH/3T9JeE4T7U6rldfr7svl2S5MYIVZ
 zI4bLsueNuEQ29QUyCaGojZY+RFe62+Dsy6SkqteB0sfmKM/+yW+jnqcj5aoFfKVMfUM068kbi9
 8kI1tvSexHEyGb6idq0WHWU94y94YdQsIWcmYR46sovdiHX+nLeHPvhYIf3JfSUGQLrmy5B2mH7
 AKou7iUydZ7TcMGbBi0HfCYk4iNTKe5MPgAur6cB2sDkuQAT6voW14IaeOEGbcNMYMeKZTQGpMN
 bhe/bDRJ6lRDg1QjTIQz7ASSV1K2qqFJ+DMlhoQQXz4T5BHoqH7/i+rjZMGyL666/yp76GGX2Zz
 FooLTQ18iI3AjReOkLg9sj5SjeCB4rY4SSfkzWTSMsNUObKYjTfo0c//IAev/YGbNA8jCPq8MwM
 AJfBWB47gE7+CBA/IXA==
X-Authority-Analysis: v=2.4 cv=P8AKQCAu c=1 sm=1 tr=0 ts=6a9daa8b cx=c_pps
 a=JIY1xp/sjQ9K5JH4t62bdg==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8 a=eODW3LopGc6cI9Ebo2MA:9 a=QEXdDO2ut3YA:10
 a=npIZgxzow1Zca20qZ2kA:9 a=tNoRWFLymzeba-QzToBc:22
X-Proofpoint-GUID: SsItUnP3Y1cfkrWgg6jYioMTi85CXvDv
X-Proofpoint-ORIG-GUID: SsItUnP3Y1cfkrWgg6jYioMTi85CXvDv
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA2MDIwMSBTYWx0ZWRfX1k/dp43eAT03
 x7nSQA7HxKMh4mmxL+LC5QY+fz152OUOvlqp1XGWTjRf+o0t+bpeVvDIUbrBlH5xb9v7mlL12Gz
 ZVN243WMNIBeGxNhHCnHI5DNDOyYr7U=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-06_02,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 bulkscore=0 clxscore=1015 adultscore=0
 spamscore=0 lowpriorityscore=0 suspectscore=0 priorityscore=1501
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609060201

--FFrCH4JkhHLzpD2B
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Sun, Sep 6, 2026 at 7:36=E2=80=AFPM Lorenzo Bianconi
> <lorenzo.bianconi@oss.qualcomm.com> wrote:
> >
> > > From: Zixuan Chai <petalzu987@gmail.com>
> > >
> > > ip6_tnl_changelink() can update encapsulation parameters while the
> > > netdevice is transmitting packets. ip6_tnl_xmit() can calculate packet
> > > headroom with t->encap_hlen and later build an encapsulation header f=
rom
> > > the live t->encap. A concurrent update can change the encapsulation
> > > header between these accesses and make skb_push() underflow the skb h=
ead.
> > >
> > > Take a local snapshot of t->encap before calculating the encapsulation
> > > header length. Use that same snapshot for headroom accounting, metada=
ta
> > > validation, and build_header(). This keeps all encapsulation decisions
> > > for an skb consistent even if changelink updates the live configurati=
on.
> > >
> > > Fixes: b3a27b519b22 ("ip6_tunnel: Add support for fou/gue encapsulati=
on")
> > > Cc: stable@vger.kernel.org
> > > Reported-by: Vega <vega@nebusec.ai>
> > > Assisted-by: LLM
> > > Signed-off-by: Zixuan Chai <petalzu987@gmail.com>
> > > Signed-off-by: Ren Wei <weir@nebusec.ai>
> >
> > Hi Ren and Zixuan,
> >
> > I agree this is a real issue, but I guess this patch is fixing just a
> > small part of more extended problem. In particular, there are multiple
> > parameters that are updated in ip6_tnl_update()/ip6_tnl_change() that a=
re
> > accessed concurrently in ip6_tnl_xmit() or in ip6_tnl_fill_forward_path=
().
> > I guess we should try to find a general fix for the extended issue.
> > What do you think? We have probably the same issue in the IPv4 counterp=
art.
>=20
> The general answer is : convert tunnels to RCU based configuration.
>=20
> In my quest for RTNL-less ip link dumps, I converted SIT tunnels to
> RCU configuration.
> I was holding the series because the net-next queue is huge, my vxlan
> series was not merged yet.
>=20
> <cover letter>
>=20
> SIT (IPv6-in-IPv4) tunnel configuration and status reporting have
> historically relied on the RTNL lock for synchronization. Consequently,
> netlink dumps via ipip6_fill_info() had to run with RTNL held, adding
> contention during network device dumps.
>=20
> At the same time, the transmit path (dev->lltx =3D=3D true), tunnel looku=
ps,
> and error handling run locklessly and can race with configuration
> updates. This can result in torn reads of multi-word fields (such as the
> 128-bit 6RD IPv6 prefix) or transiently zeroed encapsulation parameters.
>=20
> Furthermore, ipip6_tunnel_update() currently unhashes, re-hashes, and
> calls synchronize_net() unconditionally, even when the tunnel endpoint
> addresses (saddr and daddr) have not changed.
>=20
> This patch series modernizes SIT parameter management to use RCU
> protection, fixes existing race conditions, optimizes tunnel updates,
> and removes the RTNL requirement from ipip6_fill_info():
>=20
> - Patch 1 fixes a pre-existing UAF in PRL (Potential Router List)
>   deletion where call_rcu() was invoked before unlinking t->prl.
> - Patch 2 removes the unsafe in-place memset() in ip_tunnel_encap_setup()
>   and uses WRITE_ONCE() to prevent lockless readers from observing
>   transiently zeroed or torn fields.
> - Patch 3 annotates data races on tunnel->fwmark with READ_ONCE() and
>   WRITE_ONCE().
> - Patch 4 converts 6RD configuration (tunnel->ip6rd) to an RCU-protected
>   pointer, preventing torn reads on the 128-bit IPv6 prefix.
> - Patch 5 implements a dedicated ipip6_get_iflink() callback to decouple
>   SIT parameter handling from generic ip_tunnel.
> - Patch 6 dynamically allocates struct ip_tunnel_parm_kern (sit_parms)
>   as a preparatory step.
> - Patch 7 converts tunnel->sit_parms to full RCU protection. Updates
>   publish new parameters via rcu_assign_pointer() and free the old ones
>   via kfree_rcu(). When saddr and daddr do not change, unhashing,
>   re-hashing, and synchronize_net() are completely bypassed.
> - Patch 8 wraps attribute serialization in ipip6_fill_info() under
>   rcu_read_lock(), eliminating the reliance on the RTNL lock.

ack, nice. This is exactly I meant :)

Regards,
Lorenzo

>=20
> Eric Dumazet (8):
>       sit: fix UAF in ipip6_tunnel_del_prl()
>       ip_tunnel: use WRITE_ONCE in ip_tunnel_encap_setup
>       sit: annotate data-races around tunnel->fwmark
>       sit: convert 6RD configuration to RCU protection
>       sit: implement ipip6_get_iflink()
>       sit: dynamically allocate struct ip_tunnel_parm_kern
>       sit: convert configuration to RCU protection
>       sit: no longer rely on RTNL in ipip6_fill_info()
>=20
>  include/net/ip_tunnels.h |   5 +-
>  net/ipv4/ip_tunnel.c     |  14 +-
>  net/ipv6/sit.c           | 475 ++++++++++++++++++++++++++++++++---------=
------
>  3 files changed, 338 insertions(+), 156 deletions(-)

--FFrCH4JkhHLzpD2B
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCap2qiAAKCRA6cBh0uS2t
rEquAQCWE6dSaR4tjveaMuQdXJqsSCMIiojVFV+OV98Wq+CROQD/eshncuHAQyIT
T5GsdkCVoLYxuBPjkgtBhzzNFLrTsAs=
=sj/E
-----END PGP SIGNATURE-----

--FFrCH4JkhHLzpD2B--
