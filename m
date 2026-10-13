Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 049FE3438A1
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 12:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791896309; cv=none; b=eGCjKvttFHxHbsHrQUHr78HIbd8TTZLQJAvkHh5ZrPu2oFay5RGDIOcdRB1vglbnocwJtw+IHffxpU9buahkRoTFAm2E53ynTvsyXBSA+Q7srCD+m0ZNPE7ivvvKgRnZlTBteR7eq7pCxlDdOarl3CHOIx6fju3mz9Cuq2xMlD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791896309; c=relaxed/simple;
	bh=nW6EhicHcaTdMrKJ+/qFrulCRQ+C3EnmQeetchv5glo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PJ21YaxAumBAlHkjkW17aH0qSZcTURdACxtossy81yTUG3jtqTFR89GDgoVjn7jY7P2e/Tt4RpAgy00u1Vmr/XM/tI9FSe4qdApQ4r7kVv5tpWZ6cXqlgYu9z+mJvHxNCCGmk67LgUJP7VnhJxiBOtGWmRYZDZMXGTZ4IXir3PU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=erkos6L4; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XMdu9U4D; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="erkos6L4";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XMdu9U4D"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69D8PItT302832
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 12:58:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=mFzjd6YbC+KAMyI2VTUeJzof
	NspedIzXsvMGwkc/7Fw=; b=erkos6L4U0XFJ/AouL3SYpm8ldk/5eETa7iYauNr
	eEXlDhHtL5XUALokU7tceMWJ301gYwy9poDac/qJiEB1hcdveykU+yPibrSbR0Fm
	h5OzxjAkvI2Ua4cvVj1kxQBI4mkgSEL2wVjSEfhlPYhrQE5TcmQ79u2D8euELGCw
	lrOdC02dFhY+SZFB8K745Zt+FIGlTHHN3ZKCGGLYfe9aTvX7wYvEf/QSaTYZpbCG
	3bbRF0ruP758Jb5I9/VHnTO5XjXY/aEPveNWpFnFoD1R0in6GxSGHHP3r795O0ob
	INxCknuqzFnpZQE8esHoB8I9fRhPI6Uxxs9hApntbAM8og==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h98sqayq3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 12:58:26 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-93cc359d9easo499450185a.3
        for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 05:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791896306; x=1792501106; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mFzjd6YbC+KAMyI2VTUeJzofNspedIzXsvMGwkc/7Fw=;
        b=XMdu9U4D3r/f9WUC8hxei0vxpwtzb8PgyuzJxum35X1yqn6TTiEmt+MXb3x+1nkXUF
         fcPfKm3sqcAd4HP4/AdI6SV26VPG2LwcI5Eqx+95xVAYjv5f1baocC529KEmpLW34WMA
         o2YPVwc1GE2cJtk3lcBtm6HCRmSQn5vVk5CBGR56hBc34e2LsAexC9UIh73J8C/sDftq
         sfmp/I/PY1Kf9ytkPC2660mpmQReY8IhSFWrIEz9zbUR8Xc7eLjbTYnHW4/pI+1/TcZp
         Cj2NvsC7XE8dcPY9aan6ysx6ltzZyl6Bw4x3v8dEcIBs/IA7SicOz0WJyxwnsrDAAWt7
         zu0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791896306; x=1792501106;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mFzjd6YbC+KAMyI2VTUeJzofNspedIzXsvMGwkc/7Fw=;
        b=x7i7h1qVNBdl6uS+/jrokYhLpwxZ3Qt7F7jgDYUfNAP9xgq8GxgK/PqsckWnSjFowb
         oN3sznp63qkM9GDlabhlnkkX6Qi987bqXM3OzthZGpAmWXG/WDC8JCwPN3aRDKjuUhLq
         r/u/wYU0n3UCp3kLuzO9MdqwHd6lJznCgKm0tx5ztumBONYd8+8a/Ntz2dRCkoR36iXa
         dosj/egoKpiCQOLtaSfQgxu6L6U68r2eIGc9CwVLowjFUuV06qrfwwgFDehuxYpaUf6x
         OtUd2daeYU3S3dAsC7vxr3FhsWbaRMBlcRPRrvE6btSbHv07RinwrLF4s7BG8G8N0qPw
         2CTQ==
X-Gm-Message-State: AFq9FYIimN1h+v1u6HysUUs+G4FASTCpP6JPEtQ3LSsP8EWQeZjb7GqI
	qcKHlyvNCWTzAD6Bwb/A0pZBXgy6VPVgJU62KahpvP6BaRB5dbRboZlSle75G26GRthmkO+3lEL
	7dw1z3cUBiU+AyPm9wwcr2oMAh/kNaqPiDf9mP0iSQMkKQ/myT0z9TN9GHpg=
X-Gm-Gg: AYBFou1VG9dU+Q9ujKEyxPCzyY7U2V0zzmKwfdkzVuQismoM4LJrirpxMmAh4pC2wZR
	qCj4T5mErGzQhy9UO0OGJfyVKO2cM7tGBKMD3RP6XDL0qwgkSYOUm8zC7c98ZefHJyxEGL552jW
	yXfg2z/SosvISBkqerqaztkPgV8/HjzvN05dzyh0D7pvfpc7vAy6Gc5dB79tylvZcxr21j5JzVn
	8tTXsiRy+mrRGvrvcy5EW0yvohz4d9YY9HaMA6YixvpDaI5b7AieRm/dxyv8iCNNkl7ABkOW0iR
	vArlKoQShmP48cog5kjFplK7uC43Z28U3KfLF1ehmC25bhKSiGncGSY74ne8kc1P7MXyuoNGjSD
	kL/sZxW1U3ocRuA==
X-Received: by 2002:a05:620a:231a:10b0:93e:c12c:9dd1 with SMTP id af79cd13be357-93ec12ca09fmr1279109985a.81.1791896305554;
        Tue, 13 Oct 2026 05:58:25 -0700 (PDT)
X-Received: by 2002:a05:620a:231a:10b0:93e:c12c:9dd1 with SMTP id af79cd13be357-93ec12ca09fmr1279098985a.81.1791896303489;
        Tue, 13 Oct 2026 05:58:23 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48de0ab5262sm5110268f8f.22.2026.10.13.05.58.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 05:58:22 -0700 (PDT)
Date: Tue, 13 Oct 2026 14:58:21 +0200
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Toshiaki Makita <toshiaki.makita1@gmail.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] veth: clear rx queue hint in veth_xmit
Message-ID: <as4q7ZgxevukdF6B@lore-desk>
References: <20261009040412.14571-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ZYiwhR3rWNqnyspi"
Content-Disposition: inline
In-Reply-To: <20261009040412.14571-1-jiayuan.chen@linux.dev>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDA1MSBTYWx0ZWRfXwCW4mdR2vQzZ
 iWRa0g4xoSL9Prrk6UaVVVdLM59xSPpmcHwqXbk1u1TAIkz6el7J6254CTCHOYqT/9cd/jEjZGe
 ezAAFK2/p7OrQkh7qWKI8PP3/w79IHyei//sW0bi+iJU3CN5j+Kf8E/yElZXK+/VBsobcBqD947
 jeW8kWqPer1t2LXdBMsz3jwOMtyeDmQM2wpUCQNFdGTFvm+lwJNmk5nhtNvak1gTNlDr3wff/6J
 mGuiCMzEoVYILQsaaHmKaRBDcsufDfISt0Xuez1BV2LNYN4UIUBFXlDcjQ4kyCz+8AuPfPwtNhR
 69FV87q4ese4LR9mUpb3M8uzdk3LIc0gFEsf2OU29u7Ocad5RTuUmL1CW13QTLBFBpy0gTbb2dw
 uq8rTMelHf11v6Vp9FqCX5fByIsyd07ZMaSoohYAbncKy9ohYZIqsuBVTgbrfrnx8gygeNFOe1y
 tMN/4GMPIIfnnIEpCrQ==
X-Authority-Analysis: v=2.4 cv=JN+uIMKb c=1 sm=1 tr=0 ts=6ace2af2 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=xpCzFD7d2F_Re3rwPKQA:9 a=CjuIK1q_8ugA:10
 a=FLm-uE9K4O1K4dAmY2kA:9 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDA1MSBTYWx0ZWRfX31Ik+qeGAqKP
 cSLoOsHDwCu/mHGui+GwbuAmi9UvxHEV9nue4icfzqOTmHjKvtxXP2JI5A4Dv7THpuMW3vJX41+
 /IunXGKmrbl6DipLqCyvNJ3ivUcwm4Y=
X-Proofpoint-ORIG-GUID: -sM516LLOfAdSIHsPmb4q5--yI8kq2zZ
X-Proofpoint-GUID: -sM516LLOfAdSIHsPmb4q5--yI8kq2zZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 priorityscore=1501 adultscore=0 suspectscore=0
 phishscore=0 impostorscore=0 lowpriorityscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610130051

--ZYiwhR3rWNqnyspi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> With more tx queues on one end of a veth pair than rx queues on the
> other, and RPS or generic XDP enabled on the receiving end, we get:
>=20
>     veth1 received packet on queue 2, but number of RX queues is 2
>     WARNING: net/core/dev.c:5212 at get_rps_cpu+0x560/0x1360
>     Call Trace:
>      <TASK>
>      netif_rx_internal+0x1af/0x4c0
>      __netif_rx+0x99/0x350
>      veth_xmit+0x713/0xca0
>      dev_hard_start_xmit+0x166/0x5f0
>      __dev_queue_xmit+0x1797/0x42d0
>      ip_finish_output2+0xa34/0x1f40
>      __ip_finish_output+0x510/0x7e0
>      ip_finish_output+0x2f/0x320
>      ip_output+0x17a/0x3f0
>      ip_send_skb+0x1bc/0x220
>      ......
>=20
> Easy to hit with "ethtool -L veth0 tx 4", "ethtool -L veth1 rx 2",
> rps_cpus set on veth1 and a few flows sent over the pair [1].
>=20
> veth_xmit() uses skb->queue_mapping to pick the peer rq, but never
> clears it before veth_forward_skb(), so the rx side still sees the tx
> queue index. Everything on the rx side that goes through
> skb_get_rx_queue(), like get_rps_cpu() and netif_get_rxqueue() for
> generic XDP, takes it as a recorded rx queue and warns once it is out
> of range.
>=20
> Clear it before handing the skb to the peer:
>=20
> - It is the tx queue index of this device, it says nothing about the
>   rx queue of the peer.
>=20
> - The two sides don't even agree on the encoding. The tx side stores
>   the index as is, the rx side stores index + 1 so that 0 can mean
>   "not recorded". So tx queue k is read back as rx queue k - 1, and
>   tx queue 0 as "not recorded".
>=20
> - Commit 710ad98c363a ("veth: Do not record rx queue hint in
>   veth_xmit") already decided that veth should not pass any queue
>   hint to the peer. There is no tx->rx queue mapping to preserve, so
>   nothing is lost by clearing it.
>=20
> On NETDEV_TX_BUSY the skb goes back to the qdisc, which looks up the
> txq from skb->queue_mapping to decide when to retry, so restore it
> there, next to the existing __skb_push().
>=20
> [1]: https://lore.kernel.org/netdev/156834bb-8e40-496e-9443-9d515fa18eab@=
linux.dev/
>=20
> Fixes: 710ad98c363a ("veth: Do not record rx queue hint in veth_xmit")
> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>

Reviewed-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>

> ---
> Target net-next since it is moderate.
> Full reproducer, veth1 lives in netns ns1:
>=20
>   ip netns add ns1
>   ip link add veth0 type veth peer name veth1
>   ip link set veth1 netns ns1
>   ethtool -L veth0  tx 4
>   ip netns exec ns1 ethtool -L veth1 rx 2
>   ip netns exec ns1 sh -c  'echo f > /sys/class/net/veth1/queues/rx-0/rps=
_cpus'
>   ip addr add 10.9.9.1/24 dev veth0
>   ip link set veth0 up
>   ip netns exec ns1 ip addr add 10.9.9.2/24 dev veth1
>   ip netns exec ns1 ip link set veth1 up
>   for i in $(seq 200); do echo hi > /dev/udp/10.9.9.2/9999; done
> ---
>  drivers/net/veth.c | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/drivers/net/veth.c b/drivers/net/veth.c
> index 71227d0389aa..7d181c5e387b 100644
> --- a/drivers/net/veth.c
> +++ b/drivers/net/veth.c
> @@ -377,6 +377,9 @@ static netdev_tx_t veth_xmit(struct sk_buff *skb, str=
uct net_device *dev)
> =20
>  	skb_tx_timestamp(skb);
> =20
> +	/* tx queue index of this device, meaningless as rx queue of the peer */
> +	skb_set_queue_mapping(skb, 0);
> +
>  	ret =3D veth_forward_skb(rcv, skb, rq, use_napi);
>  	switch (ret) {
>  	case NET_RX_SUCCESS: /* same as NETDEV_TX_OK */
> @@ -397,6 +400,8 @@ static netdev_tx_t veth_xmit(struct sk_buff *skb, str=
uct net_device *dev)
>  		}
>  		/* Restore Eth hdr pulled by dev_forward_skb/eth_type_trans */
>  		__skb_push(skb, ETH_HLEN);
> +		/* qdisc requeues the skb on the txq it points to */
> +		skb_set_queue_mapping(skb, rxq);
>  		netif_tx_stop_queue(txq);
>  		/* Makes sure NAPI peer consumer runs. Consumer is responsible
>  		 * for starting txq again, until then ndo_start_xmit (this
> --=20
> 2.43.0
>=20
>=20

--ZYiwhR3rWNqnyspi
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCas4q7QAKCRA6cBh0uS2t
rGZdAQDVS+tfGtzDsf6AQRIRMeVwXBBfUv79N/nDjTXjlDL75gD9HAYHbH399bfM
iVEQrY4yQfzOShcoYiOvTPqavTs40wg=
=kmE9
-----END PGP SIGNATURE-----

--ZYiwhR3rWNqnyspi--
