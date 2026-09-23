Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58E763B2FF6
	for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 16:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790182491; cv=none; b=de+URXwWNaXNBHlsn45f3Lm7IFfrj7+557wZmRkQGaKSGmhHMvmxWVhdCe62jhI4dzZyTqPMWswdHnJB2wXchO8YT3gqXRP3cqKMPH/zntqOqX3m77H1gtkdOCzo3WduHyZ9yuhwWaa7U2muLqhRwjkciVrx6biqjvFCm+yXo10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790182491; c=relaxed/simple;
	bh=so0EMIgB5jqb33sCUiagEkAxHOTtBkA1/bQ/642LuBM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eNK8FTaxDMTAh0LUncGLf9FNKOQhPex76Poe8Q1EzcEhiqQu3PvGIk7cN3qFBiharwpWpmiyJ9qAz5XmmDxi4WksYscZg3dL+VjtlrASIPelKA2xgpppxksiyDSekMTWav/TIwufqFLrTPamh4GPNDc84Q0/RtODoiSVstao+Kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JB7Bk+tP; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=SvHq+mwT; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JB7Bk+tP";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SvHq+mwT"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68NGTdY4595974
	for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 16:54:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=cgm5NFHqYXkg144kqbNoAYFW
	FIwyGnhsthXLy1bxeRs=; b=JB7Bk+tPqbx8wI6y6I4xceWAxEUI5tdBIpbG6LUS
	qnTJPQ0s8T/ia7LT25o+Zw74PAYjZcIuvt0oKLyWf7Zh3gutlCQE8EDBV+TT3h/P
	ofuyJbprNzCeK8j7Rzyty1gnFN7B+dLThZ1J7t+U+vYCau++n42vGwz+MtRKs38x
	xkKJzY6UB2SrjPsqlzjv6fy0fDvUt+De+rP3KvWAgsNP/WMl24Ums4H+oQ0PLuD6
	MRSyxHNvDWWr9yDRLzr72B3lvNs5kMbH0knhWZvb12+UksgtAqivO/127Bmizp8V
	NUkwr7wwty3b7omfXX//uoQ4j7ieXN8voQjcUEpxZGzP8g==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com [209.85.217.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gvfjxs00n-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 16:54:48 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id ada2fe7eead31-78fb9f59781so1108910137.1
        for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 09:54:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790182485; x=1790787285; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=cgm5NFHqYXkg144kqbNoAYFWFIwyGnhsthXLy1bxeRs=;
        b=SvHq+mwT6QwcxyJy9d57KhtEfAhciRDiCaay+EsW1ex1mmTjekj/U8UmqaYn0v4Tg4
         6XBFJGPVG7/nGL4VzA6mVUSphZ4HMWcK7VPtPilv7sg/byENkklpGfRWVONfBVW2V1u6
         vmN3Tf6kF/UBrE84HyrkfCXDw5dQcaTHM17IpHCyYLQc2j4CYrRKITtjjuZc/lQCdN7M
         9/y7sxqGAGHZbjWh2+HcaOdWU/b7E2rmZg62db+S4VADD8Bon2B2pfEBE2rhYr24/zLh
         50JojkNl3IrY/8+dm2yVpuc4k79kfes00VfP5ZihPS4sroS9jFtdq8bHXPNrOkt0vIE0
         Ov7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790182485; x=1790787285;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cgm5NFHqYXkg144kqbNoAYFWFIwyGnhsthXLy1bxeRs=;
        b=U8OizLibutaI3r+5pzFPSoD8gD8TACl+BAsE0KJfNYZQHySnBvsTu3D6UvxOaUX36p
         hSyj3lkvBgpMnBDvkZfMRMO9ZQcImBD8eQE3m3P5VEb+5bjAqIOJHaxomd8EKRpkRkq2
         MJiqWbiGYB8cUThbVcG62ceAKRlD4tYLk6baumFxOeHLNXCo28VluFbfYfKNwfSFOHng
         bCQyhtJzuhUIBdTOerdO/n5mWoJUUK0ut+r+Sj1Gf0o5O86XeGmEJ8sKil+t4g1FoAGP
         OSzdSI/5jaEKIWF+bHhjvistj5l4V5kxlApu4ICL/r5sewhJfG5KAm/FmZ4d8i7uB9GJ
         pFEg==
X-Forwarded-Encrypted: i=1; AKwUvBy79HswCKMXAIlWbvf0cgq/YN5T3axe//HB13arrs1+RJV4xltizEU66enLLpRBWtxGiPfzNhw=@vger.kernel.org
X-Gm-Message-State: AFuF++ky4oJkifIZJDbgPmqdmbGgFQBYlTF7bZieSOZb1xqxmQ1YLD2F
	cu1+eNW2wwLweu4c1y76dSHOoevYwWC4MlFC2FEYukcdJ4Oo8gElwBMJHxsYZA/GA5iTL2Dtum3
	wgVdEMFop073xmJ6KAlJYPBgaRX3W/1xDulohmY1W+ujUYMHafZy+2/Q79UM=
X-Gm-Gg: AYBFou0ozKyBo3Z+O8YJHw33INlYMrpkASn+ykYOx6R8WYOjz12+9g8IpvOsYhTcWse
	G8wBeNpZ3ZDxKHM/CQD0EHPO3fQ91KEWuFJrUQgkym+BYxnUR6x2qVpYIN4DJ2HQv6cPumhVFrN
	KAbBOqSmGTqYJJ6aSFEovLOY71F/N0pLOsiCxGLMboCgn8jP5tQvW+Bu9l+5si/aHpq7uO6n0pC
	S4YSFMku2MnJMTsDzt0MDVykD5GqGv/mA+4YOGxwxHAI1Y3JuLCog/PYRmQQmiyVlX1zhFmmJxZ
	9JaGtd19J2qOtncef1g5OpGRH3wbtUhZ/zfqJ4Mk2Tf5XR1+oGspH3/QszhhzIERkt+wxdxlukM
	7OByhGresMt1R2A==
X-Received: by 2002:a05:6102:91c:b0:79d:cfe4:7202 with SMTP id ada2fe7eead31-7ac1ba35a39mr3062716137.11.1790182484836;
        Wed, 23 Sep 2026 09:54:44 -0700 (PDT)
X-Received: by 2002:a05:6102:91c:b0:79d:cfe4:7202 with SMTP id ada2fe7eead31-7ac1ba35a39mr3062679137.11.1790182484074;
        Wed, 23 Sep 2026 09:54:44 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fdf3541aesm48575795e9.0.2026.09.23.09.54.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 09:54:41 -0700 (PDT)
Date: Wed, 23 Sep 2026 18:54:40 +0200
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
To: netdev-bot+sashiko@kernel.org
Cc: maxime.chevallier@bootlin.com, andrew+netdev@lunn.ch, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
        daniel@riscstar.com, netdev@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, dcaratti@redhat.com
Subject: Re: [PATCH net-next] net: stmmac: add tc-mqprio qdisc offload
Message-ID: <arQEUBOpXLhLt_Ln@lore-desk>
References: <20260918-stmmac-mqprio-prio-offload-v1-1-5328157fcb58@oss.qualcomm.com>
 <179007733391.2160803.15760096543003194202@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="WpfnQHKyq4r32x1m"
Content-Disposition: inline
In-Reply-To: <179007733391.2160803.15760096543003194202@kernel.org>
X-Proofpoint-ORIG-GUID: IOVZzfQsJFR3NrcsvCRHcooL5Noum6YI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDA2NyBTYWx0ZWRfX9QBHrlRW6dtg
 /df/eou1nHUqMDv4GVEBQfzMFQUwd61ZcculKE8+y28FWTXqODh6jXQsT4NL/WmpFcSvSk3YEuX
 azTwWwtUoJ8f+diyht0h8Hjt80y1K5XwXLzDd3gagKDUYsuDggAxoLoxXRiuxR9sRxRNWrCHeb3
 dkjqGQxOP89Rwp+vffgscJkUrb2flOQCOxAcPbhak63ealybL38WxHIY3GRJYPnAUhPmKnsg/Bn
 c1Irm8l+q/RJ1QKZ4wfxy9AIXrc6RwpVMhGDD1q4SRpNnsCoxozmKGpSBqBC/qVlg0Dgh3ndNnH
 3K4UGefjUpgkOALsnrEN/AEOcYJLBaDEfs6IIfWCa/nNdf1fSWzIpr/qI/4plIAmG48eYkQ2JSJ
 6QOWAGFIOoSQEsjcvtGyqqjtpPDFKj46XWxhQsSXVOkNg47uAxZ1bgDJpGO02Rar1x1zGGh0m/K
 Haj7UEbZHKVaRRo8xHg==
X-Proofpoint-GUID: IOVZzfQsJFR3NrcsvCRHcooL5Noum6YI
X-Authority-Analysis: v=2.4 cv=NLpAaE6g c=1 sm=1 tr=0 ts=6ab40458 cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=9R54UkLUAAAA:8 a=pkLZZMQQ3BSHkK4QGzoA:9 a=QEXdDO2ut3YA:10
 a=W19mYM53yjTqTNZOIewA:9 a=ODZdjJIeia2B_SHc_B0f:22 a=YTcpBFlVQWkNscrzJ_Dz:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDA2NyBTYWx0ZWRfX8bNSmRc/OI2N
 cwoQP8ghcLjy+3L9nsputWMs0H0ScYFAY5qAHzUM98RkgLLYZK7Z1cpwgvRCZDHLtIrzYUqKp4z
 X/fqT/n7wA1iAc7ygeOc9vCpwGNY+9U=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-23_06,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 adultscore=0 suspectscore=0 priorityscore=1501
 impostorscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609230067

--WpfnQHKyq4r32x1m
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Thank you for your contribution! Sashiko AI review found 6 potential
> issue(s) to consider.
>=20
> Critical: 0 =C2=B7 High: 0 =C2=B7 Medium: 6 (1) =C2=B7 Low: 0
>=20
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
>=20
> - [Medium] One-directional AVB/CBS rejection: tc_setup_dwmac510_mqprio()
>   rejects the mqprio offload if any TX queue is already MTL_QUEUE_AVB=E2=
=80=A6
> - [Medium] The patch narrows an mqprio offload that already existed,
>   breaking configurations the driver accepted before, and the commit=E2=
=80=A6
> - [Medium] The new per-TC offset validation bounds qopt->offset[i]
>   against qopt->num_tc (stmmac_tc.c:1340-1343, extack 'TX queue range=E2=
=80=A6
> - [Medium] Replacing an offloaded mqprio qdisc makes the old qdisc's
>   teardown wipe the replacement's just-installed hardware state.
> - [Medium] The new mqprio setup and teardown paths perform read-modify-
>   write MMIO from ndo_setup_tc without a runtime-PM reference and=E2=80=A6
> - [Medium] XGMAC index mismatch: the loop at stmmac_tc.c:1367-1390
>   resolves, for each TX queue index i, the traffic class j that owns=E2=
=80=A6
>=20
> Pre-existing issues:
> - [Medium] The mqprio offload accepts TC_MQPRIO_MODE_CHANNEL with
>   TC_MQPRIO_SHAPER_BW_RATE and returns success while ignoring=E2=80=A6
>=20
> --
>=20
> net: stmmac: add tc-mqprio qdisc offload
>=20
> The patch implements tc-mqprio offload in stmmac by switching the MTL TX
> scheduler to strict priority and programming each TX queue's PSTQX/PSTC
> priority bitmask from qopt->prio_tc_map. The per-queue masks and the
> scheduling algorithm are cached in the new priv->xmit_qdisc so they can be
> re-applied on reopen, and teardown restores the devicetree configuration.
>=20
> A few questions below about the new validation and register programming.
>=20
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.c b/drivers=
/net/ethernet/stmicro/stmmac/stmmac_fpe.c
> > index c889204a7aa5..b6b5ef7c8fc4 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.c
> > +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.c
> > @@ -230,7 +230,7 @@ int dwmac5_fpe_map_preemption_class(struct net_devi=
ce *ndev,
> >  		if (count =3D=3D 1)
> >  			continue;
> > =20
> > -		if (priv->plat->tx_sched_algorithm =3D=3D MTL_TX_ALGORITHM_SP) {
> > +		if (priv->xmit_qdisc.algo =3D=3D MTL_TX_ALGORITHM_SP) {
> >  			NL_SET_ERR_MSG_MOD(extack, ALG_ERR_MSG);
> >  			return -EINVAL;
> >  		}
>=20
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/driver=
s/net/ethernet/stmicro/stmmac/stmmac_main.c
> > index bf9e7e4cb1c3..0c9083f8846e 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
>=20
> [ ... ]
>=20
> > @@ -3604,7 +3598,7 @@ static void stmmac_mtl_configuration(struct stmma=
c_priv *priv)
> >  	/* Configure MTL TX algorithms */
> >  	if (tx_queues_count > 1)
> >  		stmmac_prog_mtl_tx_algorithms(priv, priv->hw,
> > -				priv->plat->tx_sched_algorithm);
> > +					      priv->xmit_qdisc.algo);
> > =20
> >  	/* Configure CBS in AVB TX queues */
> >  	if (tx_queues_count > 1)
>=20
> [ ... ]
>=20
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c b/drivers/=
net/ethernet/stmicro/stmmac/stmmac_tc.c
> > index 42a00446e9b4..a2a9680da5c0 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
> > +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
> > @@ -1265,6 +1265,23 @@ static int stmmac_reset_tc_mqprio(struct net_dev=
ice *ndev,
> >  				  struct netlink_ext_ack *extack)
> >  {
> >  	struct stmmac_priv *priv =3D netdev_priv(ndev);
> > +	int i;
> > +
> > +	for (i =3D 0; i < priv->plat->tx_queues_to_use; i++) {
> > +		u32 prio;
> > +
> > +		if (priv->plat->tx_queues_cfg[i].use_prio)
> > +			prio =3D priv->plat->tx_queues_cfg[i].prio;
> > +		else
> > +			prio =3D 0;
> > +
> > +		stmmac_tx_queue_prio(priv, priv->hw, prio, i);
> > +		priv->xmit_qdisc.prio[i] =3D prio;
> > +	}
> > +
> > +	stmmac_prog_mtl_tx_algorithms(priv, priv->hw,
> > +				      priv->plat->tx_sched_algorithm);
> > +	priv->xmit_qdisc.algo =3D priv->plat->tx_sched_algorithm;
> > =20
> >  	netdev_reset_tc(ndev);
> >  	netif_set_real_num_tx_queues(ndev, priv->plat->tx_queues_to_use);
>=20
> [Severity: Medium]
> Can a qdisc replace end up undoing the offload that was just installed?
>=20
> For "tc qdisc replace dev X root mqprio ... hw 1" on top of an already
> offloaded mqprio, the core creates and offloads the new qdisc first, and
> only then destroys the old one:
>=20
> net/sched/sch_api.c:qdisc_graft() {
> 	...
> 	notify_and_destroy(net, skb, n, classid, old, new, extack);
>=20
> 	if (new && new->ops->attach)
> 		new->ops->attach(new);
> }
>=20
> qdisc_put(old) -> mqprio_destroy() -> mqprio_disable_offload() issues
> num_tc =3D=3D 0, which tc_setup_dwmac510_mqprio() forwards to
> stmmac_reset_tc_mqprio().  That now rewrites the PSTQX priorities and the
> MTL scheduling algorithm back to the devicetree values, and also resets
> priv->xmit_qdisc, while mqprio_attach() does not re-apply the offload.
>=20
> The result looks like the replacement qdisc reporting hw offload while the
> MAC is back on the devicetree scheduler and priorities, and the stale
> cached state is re-applied on the next open.  Should the reset path check
> whether an offloaded mqprio is still installed before reprogramming?

I guess this issue is already present and it has not been introduced by
this patch. I think the problem should be fixed with a dedicated patch.
Moreover, the fix would require to change sch_mqprio in order to provide=20
the handle of the offloaded qdisc.

>=20
> [Severity: Medium]
> Is it safe to touch these registers from ndo_setup_tc without a runtime PM
> reference?
>=20
> stmmac_reset_tc_mqprio() and the setup path both call
> stmmac_tx_queue_prio() and stmmac_prog_mtl_tx_algorithms() unconditionall=
y,
> and those are read-modify-write accesses, e.g.:
>=20
> drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c:dwmac4_tx_queue_priorit=
y() {
> 	value =3D readl(ioaddr + base_register);
>=20
> 	value &=3D ~GMAC_TXQCTRL_PSTQX_MASK(queue);
> 	value |=3D (prio << GMAC_TXQCTRL_PSTQX_SHIFT(queue)) & ...;
>=20
> 	writel(value, ioaddr + base_register);
> }
>=20
> The driver drops its PM reference at the end of probe and in
> stmmac_release(), and stmmac_runtime_suspend() gates the bus/CSR clocks v=
ia
> stmmac_bus_clks_config(priv, false).  Adding or deleting an mqprio qdisc =
on
> a down interface therefore reaches these accesses with the MAC clock
> gated, where the readl can return an undefined value that is then written
> back over the other queues' PSTQ fields and the other MTL_Operation_Mode
> bits.

I think this issue is not introduce by this patch and it is already present=
 (so
it needs to be fixed with a dedicated patch). There is already a patch upst=
ream
to resolve the problem:
https://lore.kernel.org/netdev/20260827-stmmac-setup-tc-enable-pm-v2-1-a9b8=
a5948f41@oss.qualcomm.com/

>=20
> Other stmmac control paths that touch registers outside open (set_mac_add=
ress,
> VLAN add/del) wrap the access in pm_runtime_get_sync()/pm_runtime_put().
> Would a similar guard, or a netif_running() check, be appropriate here?
> These writes also look redundant while the device is down, since
> stmmac_mtl_configuration() re-applies priv->xmit_qdisc on the next open.
>=20
> > @@ -1290,6 +1308,17 @@ static int tc_setup_dwmac510_mqprio(struct stmma=
c_priv *priv,
> >  	if (qopt->num_tc > ARRAY_SIZE(tc_to_txq))
> >  		return -EINVAL;
> > =20
> > +	if (!priv->dma_cap.dcben)
> > +		return -EOPNOTSUPP;
> > +
>=20
> [Severity: Medium]
> This is a pre-existing issue and not introduced by this patch, but since
> the entry validation is being extended here: should mqprio->mode,
> mqprio->shaper, mqprio->min_rate[] and mqprio->max_rate[] be rejected?

As pointed out by sashiko, this issue is already preset and it should be fi=
xed
with a dedicated patch.

>=20
> net/sched/sch_mqprio.c:mqprio_enable_offload() copies those into
> tc_mqprio_qopt_offload for TC_MQPRIO_MODE_CHANNEL and relies on the driver
> to refuse what it cannot do:
>=20
> 	case TC_MQPRIO_MODE_CHANNEL:
> 		mqprio.flags =3D priv->flags;
> 		...
> 		if (priv->flags & TC_MQPRIO_F_MAX_RATE)
> 			for (i =3D 0; i < mqprio.qopt.num_tc; i++)
> 				mqprio.max_rate[i] =3D priv->max_rate[i];
>=20
> tc_setup_dwmac510_mqprio() only consumes qopt and preemptible_tcs, so
> "mode channel shaper bw_rlimit max_rate ... hw 1" returns success and the
> rate limits are echoed back to userspace without any shaping being
> programmed.
>=20
> [Severity: Medium]
> Does this narrow an offload that already worked?
>=20
> The baseline tc_setup_dwmac510_mqprio() validated only num_tc =3D=3D 0 and
> num_tc > ARRAY_SIZE(tc_to_txq).  The new !priv->dma_cap.dcben check, the
> AVB-queue check below, and the count[i] > 1 check make configurations that
> previously succeeded return -EOPNOTSUPP, including the FPE preemptible-TC
> mapping part of the offload which is unrelated to the new priority
> programming.
>=20
> The count > 1 case looks like it was intentionally supported:
>=20
> drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.c:dwmac5_fpe_map_preemptio=
n_class() {
> 	...
> 		if (count =3D=3D 1)
> 			continue;
>=20
> 		if (priv->xmit_qdisc.algo =3D=3D MTL_TX_ALGORITHM_SP) {
> 			NL_SET_ERR_MSG_MOD(extack, ALG_ERR_MSG);
> 			return -EINVAL;
> 		}
>=20
> 		queue_weight =3D priv->plat->tx_queues_cfg[offset].weight;
> 	...
> }
>=20
> That weight-checking branch becomes unreachable from the mqprio path now
> that the algorithm is forced to SP before it runs.  Configurations such as
> "mqprio ... queues 2@0 2@2 fp E P hw 1" lose the offload.

I think the new sanity checks are required in order to properly support SP
priority offloading based on the hw capabilities. There were not necessary
before since this hw capability was not available.

>=20
> Additionally, forcing MTL_TX_ALGORITHM_SP overrides the devicetree
> tx-sched-algorithm and the devicetree per-queue priority masks for every
> mqprio user that is still accepted.  Should the commit message mention
> these behaviour changes for existing users rather than describing them on=
ly
> as offload requirements?
>=20
> > +	/* Forcing strict priority conflicts with the CBS algorithm of AVB
> > +	 * queues, so reject the offload when any queue is configured as AVB.
> > +	 */
> > +	for (i =3D 0; i < pdata->tx_queues_to_use; i++) {
> > +		if (pdata->tx_queues_cfg[i].mode_to_use =3D=3D MTL_QUEUE_AVB)
> > +			return -EOPNOTSUPP;
> > +	}
> > +
>=20
> [Severity: Medium]
> Is this rejection effective in only one direction?
>=20
> tc_setup_cbs() in the same file has no reciprocal check.  It validates the
> queue index, priv->dma_cap.av and the slope parameters, then converts a D=
CB
> queue into an AVB queue and programs the shaper:
>=20
> 	mode_to_use =3D priv->plat->tx_queues_cfg[queue].mode_to_use;
> 	if (mode_to_use =3D=3D MTL_QUEUE_DCB && qopt->enable) {
> 		ret =3D stmmac_dma_qmode(priv, priv->ioaddr, queue, MTL_QUEUE_AVB);
> 		...
> 		priv->plat->tx_queues_cfg[queue].mode_to_use =3D MTL_QUEUE_AVB;
>=20
> Nothing there consults priv->xmit_qdisc.algo or netdev_get_num_tc(), so t=
he
> usual TSN order
>=20
>   tc qdisc add dev X root mqprio ... hw 1
>   tc qdisc replace dev X parent <mqprio child> cbs ... offload 1
>=20
> succeeds and leaves the MAC in strict priority with a CBS/AVB queue, which
> is the combination this new check and the commit message declare
> unsupported.
>=20
> The mismatch also survives a reopen, since stmmac_mtl_configuration()
> programs the cached SP algorithm and then re-applies CBS:
>=20
> 	stmmac_prog_mtl_tx_algorithms(priv, priv->hw, priv->xmit_qdisc.algo);
> 	/* Configure CBS in AVB TX queues */
> 	if (tx_queues_count > 1)
> 		stmmac_configure_cbs(priv);
>=20
> Should tc_setup_cbs() carry the symmetric check on priv->xmit_qdisc.algo,
> or is the mqprio-side rejection not needed?

I think even this one is an issue already present since the user can provide
queue priorities via device tree and at the same time create a cbs qdisc
offloaded in hw. I think we should provide a fix that needs to be backported
here.

>=20
> > @@ -1299,6 +1328,20 @@ static int tc_setup_dwmac510_mqprio(struct stmma=
c_priv *priv,
> >  		ndev_prio_tc_map[i] =3D READ_ONCE(ndev->prio_tc_map[i]);
> > =20
> >  	for (i =3D 0; i < qopt->num_tc; i++) {
> > +		/* The offload switches the MTL scheduler to strict priority,
> > +		 * which only supports a 1:1 TC to TX queue mapping.
> > +		 */
> > +		if (qopt->count[i] > 1) {
> > +			NL_SET_ERR_MSG_MOD(extack,
> > +					   "SP sched requires 1:1 TXQ map");
> > +			return -EOPNOTSUPP;
> > +		}
> > +
> > +		if (qopt->offset[i] >=3D qopt->num_tc) {
> > +			NL_SET_ERR_MSG_MOD(extack, "TX queue range exceeded");
> > +			return -EINVAL;
> > +		}
> > +
>=20
> [Severity: Medium]
> Should this bound be priv->plat->tx_queues_to_use rather than
> qopt->num_tc?
>=20
> num_tc is only limited by ARRAY_SIZE(tc_to_txq) here and by the core:
>=20
> net/sched/sch_mqprio_lib.c:mqprio_validate_queue_counts() {
> 	...
> 		if (qopt->offset[i] >=3D dev->real_num_tx_queues ||
> 		    last > dev->real_num_tx_queues) {
> 	...
> }
>=20
> stmmac allocates the netdev with MTL_MAX_TX_QUEUES queues and only clamps
> real_num_tx_queues to plat->tx_queues_to_use in stmmac_hw_setup(), so
> before the first open a request like "mqprio num_tc 4 ... queues 1@0 1@1
> 1@2 1@3 hw 1" on a device with tx_queues_to_use =3D=3D 2 passes both chec=
ks.
>=20
> The priority programming loop below is bounded by pdata->tx_queues_to_use,
> so the TCs with offset >=3D tx_queues_to_use never get a PSTQX/PSTC mask
> while the offload still returns success, and netif_setup_tc() remaps those
> priorities to TC0 at the next open.
>=20
> The same check also rejects a sparse but otherwise legal map, e.g.
> num_tc 2 with "queues 1@0 1@2".  Is that intentional?

As the previous ones, even this issue is reachable even without this patch
applied. I think we should address it in net with a proper fixes tag.

>=20
> > @@ -1315,14 +1358,44 @@ static int tc_setup_dwmac510_mqprio(struct stmm=
ac_priv *priv,
> >  	if (err)
> >  		goto error_reset_tc;
> > =20
> > +	priv->xmit_qdisc.algo =3D MTL_TX_ALGORITHM_SP;
> >  	err =3D stmmac_fpe_map_preemption_class(priv, ndev, extack,
> >  					      mqprio->preemptible_tcs);
> >  	if (err)
> > -		goto error_reset_num_tx_queues;
> > +		goto error_reset_xmit_algo;
> > +
> > +	for (i =3D 0; i < pdata->tx_queues_to_use; i++) {
> > +		u32 prio =3D 0;
> > +		int j;
> > +
> > +		for (j =3D 0; j < qopt->num_tc; j++) {
> > +			int p;
> > +
> > +			if (qopt->offset[j] !=3D i)
> > +				continue;
> > +
> > +			/* The PSTQX/PSTC priority map is 8 bits wide, so only
> > +			 * priorities 0-7 can be represented in hardware.
> > +			 * Priorities 8-15 are handled in software by the
> > +			 * kernel through the netdev prio_tc_map.
> > +			 */
> > +			for (p =3D 0; p < 8; p++) {
> > +				if (qopt->prio_tc_map[p] =3D=3D j)
> > +					prio |=3D BIT(p);
> > +			}
> > +			break;
> > +		}
> > +
> > +		stmmac_tx_queue_prio(priv, priv->hw, prio, i);
>=20
> [Severity: Medium]
> Is the last argument the right index on XGMAC?
>=20
> The mask computed here belongs to traffic class j, but the index passed to
> stmmac_tx_queue_prio() is the queue index i.  For XGMAC the callback is:
>=20
> drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c:dwxgmac2_tx_queue_pri=
o() {
> 	reg =3D (queue < 4) ? XGMAC_TC_PRTY_MAP0 : XGMAC_TC_PRTY_MAP1;
> 	...
> 	value &=3D ~XGMAC_PSTC(queue);
> 	value |=3D (prio << XGMAC_PSTC_SHIFT(queue)) & XGMAC_PSTC(queue);
> }
>=20
> XGMAC_PSTC() selects a traffic-class field in MTL_TC_Prty_Map0/1, while t=
he
> queue to TC association is programmed separately in XGMAC_Q2TCMAP:
>=20
> drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.c:dwxgmac3_fpe_map_preempt=
ion_class() {
> 	for (u32 i =3D 0; i < count; i++) {
> 		val =3D readl(priv->ioaddr + XGMAC_MTL_TXQ_OPMODE(offset + i));
> 		writel(u32_replace_bits(val, tc, XGMAC_Q2TCMAP), ...);
> }
>=20
> Both dwxgmac210 and dwxlgmac2 use dwmac510_tc_ops, and a permuted map such
> as "mqprio num_tc 2 map ... queues 1@1 1@0 hw 1" passes both
> intervals_overlap() in the core and the new offset < num_tc check.  In th=
at
> case TC0's mask would be written into the PSTC field of TC1 and vice vers=
a.
> Should the XGMAC path program PSTC using the TC index, or should
> non-identity offsets be rejected?

I think the issue is real since in dwmac4_tx_queue_priority(, queue) queue
index is the real hw queue, while in dwxgmac2_tx_queue_prio(, queue) queue
index is actually a tc index (even if it called queue).
Moreover, the dts path just assumes the tc index is equal to queue index.
I guess we should just forbid this configuration in order to keep dts and tc
paths aligned. What do you think?

Regards,
Lorenzo

>=20
> > +		priv->xmit_qdisc.prio[i] =3D prio;
> > +	}
> > +
> > +	stmmac_prog_mtl_tx_algorithms(priv, priv->hw, MTL_TX_ALGORITHM_SP);
> > =20
> >  	return 0;
> > =20
> > -error_reset_num_tx_queues:
> > +error_reset_xmit_algo:
> > +	priv->xmit_qdisc.algo =3D priv->plat->tx_sched_algorithm;
> >  	if (netif_set_real_num_tx_queues(ndev, ndev_num_tx_queues))
> >  		netdev_warn(ndev, "Failed to restore %u TX queues\n",
> >  			    ndev_num_tx_queues);
>=20
> --=20
> Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#/patch=
set/20260918-stmmac-mqprio-prio-offload-v1-1-5328157fcb58%40oss.qualcomm.com

--WpfnQHKyq4r32x1m
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCarQEUAAKCRA6cBh0uS2t
rJV8AP9Fg83NQyJdd9mNLAxLhU7g4IQZHXshvIviFA+gIDf7gQEA89cfehWg/yYV
Y5UZOGHBjb4tQ+LK4HO59s6NmMvtlAI=
=SY4Z
-----END PGP SIGNATURE-----

--WpfnQHKyq4r32x1m--
