Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 821D13D9027
	for <netdev@vger.kernel.org>; Sun, 20 Sep 2026 08:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789892380; cv=none; b=VgSJo7fDL8G1290qZL/iOzgaOb+YtsEfIzwEJfSrt9Fd/7p6zCk+tbsEf+n2G6VIOc9d5XcQOOWELtY1P1/l4K5glmigMMPwqE6oxkMqqbT1w464r9ZXUg7JQIS9wLH0f5HzAJBfMQgXu0+4ncQlyWKBn9HOoIfiLP73Qwg0Aqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789892380; c=relaxed/simple;
	bh=BjneHlFoqL1wFeaUf6/92cx/QVIzjq+vH5GwZgLBfqw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qZoNRNv+azFt+nycw4ZuMKizDGNcX/NrEwptMs2EJMKsJEVz/uCc9WaGwb2EtuzwQ0ZcHTsfZfgLWlAJfT2O0C8pXnFTzuIrxhDnaYPa7inen6RKyDtHzRXPqtKdId9ykUTKisjLAXGKlwC42Itb5QG5uOX2jXrCsKjFRb+u/zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pfXP6JY4; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=NOt4X9BE; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pfXP6JY4";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NOt4X9BE"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68K55eFD827303
	for <netdev@vger.kernel.org>; Sun, 20 Sep 2026 08:19:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=tVuBfRM6hSH7bdNrYC43eEuM
	mYCLe63rDtFa+xag5MI=; b=pfXP6JY4DnCBiJRRqLLq4GC53wH/2llSz804NQdy
	Sj/pSvLWm1EEnGneNra/2PGP2EfR4mKBEnxGCArCsWVRowRB6jBkutthASeU7T1v
	npjATBwkOl+nVmTgWG+QQ+XVxaRmm89QEcPZFbW8jhG4tNbD9PEo8biBG1x2+5Ds
	wLzEfD1lD6KnIrNZlMCYHLCqUzuvL/4ubh/ugNZXqHMgSiPyB9qZ8A0Si8VZMNrY
	DanhYowD1V+3uTLZakUQ9ht5Q9avMbsSCIWvR3EbDgyrVaKHQe3Nar2TNmxcZC0a
	x+ew65F6cCM7sfoH1gOqHsRYDezvuO2Ozwb5w4YrRPXYsQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gsjs82gtq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Sun, 20 Sep 2026 08:19:37 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-939f3426a7cso437824385a.0
        for <netdev@vger.kernel.org>; Sun, 20 Sep 2026 01:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789892376; x=1790497176; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=tVuBfRM6hSH7bdNrYC43eEuMmYCLe63rDtFa+xag5MI=;
        b=NOt4X9BESsWSB9yc1cHxsNCgld466bSeBNXmmIHngmkFpTiNdXqfZAZSWFqVnoivdZ
         HtSNgbk9I9BLUUFr066ARYCrwwhbPczA6SSboxp+hVrFiatPziL95wZv3QLtwWTL5zT4
         AgBpgaXnDuLT7G5NWIhmMXyyFig7HgTGwjoYt7lLvykFCeHpl8nczGfxgUcfVnfuDFvB
         tZbdnppXry3pU9t8jxl7G7EeT0AR0mbwgP43FOQGLEGJm9EMu/RxqHThUdzCqCkuqY+W
         d2z1iKlRMnC3plIRfVEPw/JLwXhQLDclWGRDkp83f9n+QRWo+uiNPnMEE3ZjOgLMPkMa
         BFlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789892376; x=1790497176;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tVuBfRM6hSH7bdNrYC43eEuMmYCLe63rDtFa+xag5MI=;
        b=mvsHfZzXWS4LBd80rgMJ8+FWBGwGXeJ7MMZAboQOcSnK8MARCo1+QCyQmaGpFpcV0b
         47pHKvNNMTVE5WhoIA/eJKd/kxPt5C6Q+MsVnhCvqm/vSwYTmbsAyTIMG+TXVDus7q5j
         qcHrHeTAo14V8KqMnv6nB2P2WDbA/ekw9U0yXgP5f5cU6UPBT5Mnp74PjRXSS/nTdhoo
         tYJ027oyW6QlK34KNx97AS9ZyiIT9SMiWEuVkVqPp80l4AmREYLzgL7kqtdzBi45m1bU
         GVofRx96irJFd/SZVl3ePCvU3+6TdYbJ6yRg7j1Ji0yICgU/jmr8cfX82MB0sCX3UfS/
         k++w==
X-Forwarded-Encrypted: i=1; AKwUvBxC4lk9lyX3sqWQxX6156YS2ANrr3Qq3U/1if4eViTY/c/r44F5sp8gLS3nX8fbDYpqo9HcFjE=@vger.kernel.org
X-Gm-Message-State: AFuF++kH6aZ/ttVbEyozNMOrmYQUci6jW9g0AHm3by3Exl0zVe9bQThK
	dg1qF5mX/xUJhyIFooIg+8LDS8VGv7Lx5Gm/z1mOTkP0b9cGgWdcT7Ca6hAvhyVZy3FWlU27VfW
	dT9WezwQjbrmNDKynDLteCHk2uTH+bfGW/S8ToC4mqORntOqJdpyZJi5kQ4s=
X-Gm-Gg: AYBFou2g6j0yTzbGVDbM34JOouuXLBWRz2SXMMN/X45Ctm5CjrAaH8v4F/0uiTrPSdd
	uon/5f/IIhTgDaqSbf+SiKlPKUhlYS8J9aWJ4MbYEzQnwjkhUqpmS1JbQvdEaJ1fkciuKA/hxY9
	QMkTcncmH6ByUrWOUbi6Z1z5U3OCuAU+9LzuOSrUTgVp/lQwAs9l1y9Uz5U2vQ4HNVP7SnsiE9x
	MEoHX7yxtbmlN0i4vcFcT6niLsE1REckkp4K3FaTH3dbbv4Q25gEfvKZHWWQi/Fs3Dh2vO3a5RW
	zL38tA8rK3KAJPNhCP7XH1tMcOj2rFc4W0IjJ2aUEfQzNft+thAmPmfGbQ8jvs2l/r9JzvVl+6J
	ev3EzMQQmaYNCOw==
X-Received: by 2002:a05:620a:c47:b0:93b:c332:3d9e with SMTP id af79cd13be357-93bf560c669mr438972285a.30.1789892376489;
        Sun, 20 Sep 2026 01:19:36 -0700 (PDT)
X-Received: by 2002:a05:620a:c47:b0:93b:c332:3d9e with SMTP id af79cd13be357-93bf560c669mr438970585a.30.1789892375995;
        Sun, 20 Sep 2026 01:19:35 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4885a0549c3sm557784f8f.25.2026.09.20.01.19.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2026 01:19:34 -0700 (PDT)
Date: Sun, 20 Sep 2026 10:19:34 +0200
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
To: Linkui Xiao <xiaolinkui@126.com>
Cc: maxime.chevallier@bootlin.com, andrew+netdev@lunn.ch, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
        netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Linkui Xiao <xiaolinkui@kylinos.cn>, stable@vger.kernel.org
Subject: Re: [PATCH net v2] net: stmmac: do not cache the new TSO MSS before
 it reaches the DMA
Message-ID: <aq-XFrxqzeQvYEAn@lore-desk>
References: <20260920061609.1919876-1-xiaolinkui@126.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hdZmFPt14xPP7efX"
Content-Disposition: inline
In-Reply-To: <20260920061609.1919876-1-xiaolinkui@126.com>
X-Proofpoint-ORIG-GUID: YsY4jSTniQrnwgyOe2837iKuCrlIDQ9e
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIwMDExOSBTYWx0ZWRfX3YYj5zPAMG33
 Fv1p6eHdHsZ38v9qbpyHg8IleNDKC8Lsnqmb1zxXzhA8oOJmv8E2lTKP5Nh/9otW8jIJlWI12TS
 MxbOQKaWU0B4+r3VQgblgKUHseyjvaY=
X-Authority-Analysis: v=2.4 cv=YqWa1IYX c=1 sm=1 tr=0 ts=6aaf9719 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=IWBWnCfD7v3Vv49I:21 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=W4vQ8E46j4nzeUKewMYA:9 a=CjuIK1q_8ugA:10
 a=6340d-lrAPSOr5qSYlQA:9 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIwMDExOSBTYWx0ZWRfX2rw6SbqvSw0N
 FxFhSNpDBkoj4dgiZtoJd0V4YwrVNSzNMeXtwXJ2DyzXqCgqM2ATBMyPVpEATy7CXRqfGCUXEkM
 BHdXCaK1laSr5SCKuVmJiytdbRXWH6yJfdwB16cJ7hjG8W6O2j5r5LBY6mYgbXZK6yIXarvUsa7
 wAkzLed/O78xT4NOalskHElSAa3//eAg7FrXqdUU68R2bSVQO5gUfRwJSGaF1SZ1nAJc56SNWfl
 3JHZUzFu/V+Z9XLSEGODy03kg7irZW4bJRhihuR7dtlI5q7Z9EB1/DGO/x0VyGLWBFQFqMxv4mU
 0PEbDilH3MEs05rkAmhEbsrb8FSJeoMtrgzeiYDj43rLRm2ODNTCSR6CQrP5nFtgrxbiXnqGGnT
 nmVxYg7Bq5lmLQtZxQwi/F+eNSGcgrSEjhHJfUL4g+Sd3yga834CLZ8276nQk1ZFCYDEk1b4G4J
 lKhLNwJJQcbxNFakWcQ==
X-Proofpoint-GUID: YsY4jSTniQrnwgyOe2837iKuCrlIDQ9e
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-20_02,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 lowpriorityscore=0 spamscore=0 phishscore=0
 malwarescore=0 priorityscore=1501 bulkscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609200119

--hdZmFPt14xPP7efX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> From: Linkui Xiao <xiaolinkui@kylinos.cn>
>=20
> stmmac_tso_xmit() fills the MSS context descriptor and stores the new MSS
> in tx_q->mss right away, but the descriptor only gets its OWN bit much
> later, right before the frame is handed to the DMA. Every error path in
> between - the dma_map_single() of the linear part and the
> skb_frag_dma_map() of each fragment - returns with tx_q->mss already
> updated while the MAC is still programmed with the previous MSS; the
> abandoned context descriptor is later reclaimed by stmmac_tx_clean().
>=20
> The next skb carrying the same MSS then compares equal to the cached
> value, so no context descriptor is emitted and the hardware segments the
> TCP stream with a stale MSS, generating frames whose payload size does
> not match what the stack accounted for.
>=20
> Update tx_q->mss only once the context descriptor has been given to the
> DMA, so that the cached value always describes what the hardware is
> actually programmed with.
>=20
> The context descriptor is now handled like the data descriptors are:
> tx_q->cur_tx is not advanced while it is being filled. Whether the frame
> can be queued is only known after every dma_map_single() and
> skb_frag_dma_map() has succeeded, so the descriptor stays at the slot
> tx_q->cur_tx points to and the index moves past it later, together with
> the data descriptors. That also keeps the context descriptor outside the
> range stmmac_tx_clean() walks when the ring is cleaned after a failure,
> so the error paths have to release it explicitly.
>=20
> Fixes: f748be531d70 ("stmmac: support new GMAC4")
> Cc: stable@vger.kernel.org
> Signed-off-by: Linkui Xiao <xiaolinkui@kylinos.cn>

Acked-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>

> ---
> Changes in v2:
> - Do not advance tx_q->cur_tx while the context descriptor is filled, as
>   for the data descriptors, and release the context descriptor on the
>   error paths instead of leaving it to stmmac_tx_clean(). (Lorenzo Bianco=
ni)
>=20
>  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/=
net/ethernet/stmicro/stmmac/stmmac_main.c
> index af2d38a2bb3d..e2e680dd980c 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -4563,10 +4563,6 @@ static netdev_tx_t stmmac_tso_xmit(struct sk_buff =
*skb, struct net_device *dev)
>  			mss_desc =3D &tx_q->dma_tx[tx_q->cur_tx];
> =20
>  		stmmac_set_mss(priv, mss_desc, mss);
> -		tx_q->mss =3D mss;
> -		tx_q->cur_tx =3D STMMAC_NEXT_ENTRY(tx_q->cur_tx,
> -						priv->dma_conf.dma_tx_size);
> -		WARN_ON(tx_q->tx_skbuff[tx_q->cur_tx]);
>  	}
> =20
>  	if (netif_msg_tx_queued(priv)) {
> @@ -4577,6 +4573,9 @@ static netdev_tx_t stmmac_tso_xmit(struct sk_buff *=
skb, struct net_device *dev)
>  	}
> =20
>  	first_entry =3D tx_q->cur_tx;
> +	if (mss_desc)
> +		first_entry =3D STMMAC_NEXT_ENTRY(first_entry,
> +						priv->dma_conf.dma_tx_size);
>  	entry =3D first_entry;
> =20
>  	WARN_ON(tx_q->tx_skbuff[entry]);
> @@ -4714,6 +4713,7 @@ static netdev_tx_t stmmac_tso_xmit(struct sk_buff *=
skb, struct net_device *dev)
>  		 */
>  		dma_wmb();
>  		stmmac_set_tx_owner(priv, mss_desc);
> +		tx_q->mss =3D mss;
>  	}
> =20
>  	if (netif_msg_pktdata(priv)) {
> @@ -4745,6 +4745,9 @@ static netdev_tx_t stmmac_tso_xmit(struct sk_buff *=
skb, struct net_device *dev)
>  						priv->dma_conf.dma_tx_size);
>  	}
>  error:
> +	if (mss_desc)
> +		stmmac_release_tx_desc(priv, mss_desc, priv->descriptor_mode);
> +
>  	dev_err(priv->device, "Tx dma map failed\n");
>  	dev_kfree_skb(skb);
>  	priv->xstats.tx_dropped++;
> --=20
> 2.25.1
>=20
>=20

--hdZmFPt14xPP7efX
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaq+XFgAKCRA6cBh0uS2t
rKz0AQDQOKlvoWo/v6YdVyqg7wc3sX8gVj0oK+SpKbYYAjMZFQEAi+/NjQU08Sjg
F7zosScZjl1GSR20UvITwQJmXwNs+QY=
=Efwo
-----END PGP SIGNATURE-----

--hdZmFPt14xPP7efX--
