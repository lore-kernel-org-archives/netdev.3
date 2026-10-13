Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F05C4A9D5D
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 12:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791894291; cv=none; b=Rj2kmfanv1jd6z4o5X0vYChyT1v/+HdPYweNZNNY8ZvfI7i/7nz6Dh2MM1uR/48nxFPDy9IcGbn1vmFDE7rarxJdTaddJDz6b1HyvdHR/jMUD0OHODSlySF7lJ67ZPNFx9J7kQvm7ue1wc9jm4MfIkmIMe1eBaWXhlTxCReINDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791894291; c=relaxed/simple;
	bh=GVQZowUfco0G7PueuWg32xkveNZEDJU3gjpR9tlVIsY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t2F3YUhcI+qpSXhlABonkMJ4AJOOA+eGCPeoHOQvTXF0/eTGU4uvrC/H/pbKlmEY7PfaSGAo6k5cNieSR3GDLALHvL8Wb2nWPY1GiUhZscevYs4N6yF/QY0horKrs6+NyTZz3AbkRCLzub8o4U+og0+4dloZGd3meH4ztQcF7nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=O2FX/R+r; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Nda5pKd1; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="O2FX/R+r";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Nda5pKd1"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69D9tR0M3475857
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 12:24:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=IRXEqBHq37FSBtlagdCvVWvm
	8N5YQgQEDV8TIW7L8YE=; b=O2FX/R+rNuwSriKaWhZwScVOSraOEOM1+uep+0m/
	vX7QTlwFlOy0F3SdAwG4RngAGoEGcu9PsPvkAk4kPbt4d9zS7Brj17zPkFI03hMt
	o7wLPJJNv8xTmZHCPKRFLCuh3Fhfp56NXSw72LWOgDfzn7t4e12B6azMTtcWpCTT
	ibZEVKdYzNTT5wn8JrhF8bxV4+AeivWU2ZyxjsCZ7T8+y1PRXQS9weZIZX1etZ93
	gcXnhF+xaNpa+SGFa/gQmZMpcTQgdlTDP/0ZeZL7Gq1T/RslizUpt5emjJU7yTlY
	CmYZ1X2JCWRxYCzaTFpV/P7rdpcDbKEKDEzAuSWMKnL8HA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h9d7ja0ke-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 12:24:49 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-93cc7a6e4e1so932205785a.1
        for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 05:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791894288; x=1792499088; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=IRXEqBHq37FSBtlagdCvVWvm8N5YQgQEDV8TIW7L8YE=;
        b=Nda5pKd1Rsmis+HoFztLSYEohE62ltCqD2zzR9HSPp+aZryJGX0e/n3u52w+iaRrYI
         kHQ/wE9tDBNIyU9B8kcDoGqm165umc06FKCs/anmT9wmLJTDV8C8V6HPk8p/0UXF0w1h
         /zGoW6sOTCXyCCeJZiunH04HKUweRgzb3ykYK7drzQgqv224jMYk0hEjdr27RL5RDQwZ
         VyH5t2SRpGq2Sb+S31hajE/bQkblelUgOnC8rjz4AHTAG0i/pJSCMaL0+/4WJci5FNvc
         94Q/xzdKwlcow0Ly32z7di3TpskKMlERopZOUDzDKLilGWpo3wntghIBfR7B9dt7EC6j
         YtaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791894288; x=1792499088;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IRXEqBHq37FSBtlagdCvVWvm8N5YQgQEDV8TIW7L8YE=;
        b=WeQYt6t/MofIk50ov+fF8xN7uNZC8iCysNfqNNy1OM46ZiHJL64B1NYN6xde6WKU7G
         x3kGHBhkEM27arVgMX2iXVpruUlyd6jkfrT9G5XolL06dPFYM+yz9xZLf4SM2xoTSDHZ
         ges+W14+eCAVMHWgJCBn2astQHlqsjV/1Pg7En34PQV07MppACSTGaWGFyFueoVU35qf
         D6OxSV22M37Zjl1JlRtGtXWqTFZDx33lbnKhjVlHvRUX/X+0PRVfh0mFVwrmIRpqihVf
         yJ2yym/eBijVpiO49ZIQD+XzdBhRkqKz4/d0srok+ZFq/LCukPnyx4n3U2mJK2sb8kQ8
         nfuA==
X-Forwarded-Encrypted: i=1; AKwUvBwNXwdJ65VtNkbxiyzvV7HE9gt46Y/INTTokBoVvGQtXhdqDj75IW7sG8s32wg30l+EJBm4/m0=@vger.kernel.org
X-Gm-Message-State: AFq9FYKLF/MM+lQnBsgKXICI4sYaRor5Tp1fKYScwSorr9NqAD9L05zp
	wCB4ZlgOHaEn2uZr8LBh7qdVAIx6Jua7FSoLDa5bZ+BLHBlu4MfkhTncSbfeq0FLpQytsPaYFxx
	Rg6kIfZ5GD2WRGoMfgfo8FAWcBUdZ6jbHobd2mEQQQLvOy7aDhUnHZDQdbIbVlDMSH1asqg==
X-Gm-Gg: AYBFou3fW44Q1N8x4ZGHAIneLGEuKu10q7TVGYMsXi6IMlAl6kQRK7vf6lYTQBJYguS
	GcUwttzU8Vuf68DyyEQ1zsG39HoB3WZhOxFLRhixTSDM46EQUHH4xnFGRc/puFmhV0uhQ61Xn/N
	CM4EcKZAEw6prYUPyKtS8g/HVgfuhLYskcjnXuYdIwIpyxDoXV53Ssxk3VT+jJXjQJ1oOH+b5Hk
	VMk2wFl7aY9pXTeeSncStJIyLxtEtCUNZnJHV62zdt8A3bFQUAnndf2onhQOq6eNiEfMduHlMSd
	9KfduMIsj56Y524KwkKRYpDIkPXMzJ4xQgjZE7aEqvk1ANqEnWvfSWcclZXIqlT1Fe6f0atHtED
	zyTaGPahQRuvT3Q==
X-Received: by 2002:a05:620a:19a1:b0:93e:653e:698b with SMTP id af79cd13be357-93ebd27d873mr1906815285a.55.1791894288221;
        Tue, 13 Oct 2026 05:24:48 -0700 (PDT)
X-Received: by 2002:a05:620a:19a1:b0:93e:653e:698b with SMTP id af79cd13be357-93ebd27d873mr1906809785a.55.1791894287489;
        Tue, 13 Oct 2026 05:24:47 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a18beabbd0sm414511335e9.12.2026.10.13.05.24.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 05:24:46 -0700 (PDT)
Date: Tue, 13 Oct 2026 14:24:45 +0200
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
To: Daniel Machon <daniel.machon@microchip.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Davide Caratti <dcaratti@redhat.com>, netdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Daniel Thompson <daniel@riscstar.com>
Subject: Re: [PATCH net-next] net: stmmac: fix mqprio and cbs combination
Message-ID: <as4jDfpsvIfsZp_M@lore-desk>
References: <20261012-stmmac-mqprio-cbs-combo-v1-1-831e323eb4ef@oss.qualcomm.com>
 <20261013101031.42ilxihghwsivccm@DEN-DL-M70577.microsemi.net>
 <as4GJdF8oD_8FsGI@lore-desk>
 <20261013104325.j526p5yurc5zmzhn@DEN-DL-M70577.microsemi.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="N9isKUosey8taFli"
Content-Disposition: inline
In-Reply-To: <20261013104325.j526p5yurc5zmzhn@DEN-DL-M70577.microsemi.net>
X-Proofpoint-GUID: 8OjVPdfJI_Cya6_4MViZf9_RF1RG19z8
X-Proofpoint-ORIG-GUID: 8OjVPdfJI_Cya6_4MViZf9_RF1RG19z8
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDA0OSBTYWx0ZWRfX5yHYUXbpxanB
 15GNN5HrpGbL0ZHq1j6s3bGyco9qNSrOtBfwQRIINr8qmWg4GlxMM524icZ1WufrTDR/ycC6y3x
 mMSjCYQGzGJi8znnIk9kxIZ0JKSBG4U=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDA0OSBTYWx0ZWRfX6PcWFDb0YuQ6
 A1raOT9XmY+npCr3uMpTXy3G1kbbJ35UDJICA8D1p71xeUAhWAb8alMCaqAxqGQGM1JYpyk5cGk
 t7n7T7NGpU2NgEwSGboJ1+UFcXm/ZSzFZibYKdv4MCPW3pUBacbbREqyo2mfIFfTcneleq4vJwK
 +3PK9ebLoCEj0Zq7rFbTX4vj51MfDDZgNsPaI21Hyd10MuLEaS2BTMBFsDSmA/E3esriW5xPCwg
 JJ1ARZL0oW9Eowe4NSn0SvKgrU9s7Rd24KUu1IYkEu6S2IyTnWj7l338cPactuy1gXs8YZwU+zI
 lUysBwYHnA2UNqx9hU5Li/oxDLkcYG+4mejFXWJY3Dj5q9FIuqlE/gxWaZq4CyYUiyoUDQLtbX8
 1oKp6i2PP08Jk7KnBFTkp0L4OhOUSRmcY02FoIcTglCMPk8iKS8kF5okkxazdrI71pWU2r57UPk
 I3U66Fnnp2wznDuj06g==
X-Authority-Analysis: v=2.4 cv=PMGaavqC c=1 sm=1 tr=0 ts=6ace2311 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=ee_2aqc6AAAA:8
 a=EUspDBNiAAAA:8 a=PfZZTzpaSJvV7ojCNxEA:9 a=CjuIK1q_8ugA:10
 a=KlyeCCL51scEqKYOWpwA:9 a=IoWCM6iH3mJn3m4BftBB:22 a=VOpmJXOdbJOWo2YY3GeN:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 impostorscore=0 malwarescore=0
 lowpriorityscore=0 clxscore=1015 adultscore=0 spamscore=0 phishscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610130049

--N9isKUosey8taFli
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> > On Oct 13, Daniel Machon wrote:
> > > Hi Lorenzo,
> > >=20
> > > Just a question:
> > >=20
> > > > The channel-mode mqprio offload and the CBS offload can currently n=
ot be
> > > > enabled at the same time. tc_mqprio_validate_chan_mode() refuses the
> > > > mqprio offload as soon as any TX queue is configured in AVB mode, a=
nd
> > > > tc_setup_cbs() refuses to enable CBS while the strict-priority sche=
duler
> > > > is active. As a result the combination is rejected whichever order =
the
> > > > two are configured in.
> > > >=20
> > > > The strict-priority scheduler selected by the channel-mode mqprio
> > > > offload and the per-queue CBS shaper are independent MTL settings a=
nd do
> > > > not conflict, so drop the checks and let the combination be offload=
ed.
> > > > The following configuration, which was previously refused, now work=
s:
> > >=20
> > > Looks to me like these checks are shared by multiple cores. Are the M=
TL settings
> > > independent on all of them?
> >=20
> > Can you please explain what you mean?
> > What I mean with this patch is we can have a given queue (e.g. queue X)
> > configured in MTL_QUEUE_AVB mode and another one (e.g. queue Y) configu=
red
> > in MTL_QUEUE_DCB mode.
>=20
> Sorry for being vague. I meant the MAC cores. So, dwmac510_tc_ops is bein=
g used
> by GMAC, XGMAC, XLGMAC. My question was whether the claim that the commit
> description gives (per-queue CBS shaper are independent MTL settings) app=
ly to
> all of these 3?

Yes, according to my understanding. MTL_QUEUE_AVB and MTL_QUEUE_DCB are
mutually exclusive for a specific queue, but there is no restriction on two
different hw queues (MTL_QUEUE_AVB and MTL_QUEUE_DCB can be mixed).

Regards,
Lorenzo

>=20
> >=20
> > Regards,
> > Lorenzo
> >=20
> > >=20
> > > >=20
> > > >   $ tc qdisc replace dev eth0 handle 100 parent root mqprio num_tc =
4 \
> > > >         map  0  0  0  0  0  1  2  3  0  0  0  0  0  0  0  0 \
> > > >         queues 1@0 1@1 1@2 1@3 mode channel hw 1
> > > >   $ tc qdisc replace dev eth0 parent 100:2 handle 102: cbs \
> > > >         idleslope 800000 sendslope -1700000 hicredit 494 locredit -=
1049 offload 0
> > > >   $ tc qdisc replace dev eth0 parent 100:3 handle 103: cbs \
> > > >         idleslope 400000 sendslope -2100000 hicredit 247 locredit -=
1296 offload 1
> > > >   $ tc qdisc replace dev eth0 parent 100:4 handle 104: cbs \
> > > >         idleslope 200000 sendslope -2300000 hicredit 124 locredit -=
1419 offload 1
> > > >=20
> > > > Fixes: 47891d501e34 ("net: stmmac: add tc mqprio hw queue priority =
offload")
> > > > Tested-by: Daniel Thompson <daniel@riscstar.com>
> > > > Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
> > > > ---
> > > >  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c |  8 --------
> > > >  drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c   | 16 -----------=
-----
> > > >  2 files changed, 24 deletions(-)
> > > >=20
> > > > diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/dr=
ivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > > > index 56d89a696272..51d502930219 100644
> > > > --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > > > +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > > > @@ -7740,14 +7740,6 @@ int stmmac_reinit_queues(struct net_device *=
dev, u8 rx_cnt, u8 tx_cnt)
> > > >  	    tx_cnt < priv->xmit_qdisc.num_tx_queues)
> > > >  		return -EINVAL;
> > > > =20
> > > > -	if (priv->xmit_qdisc.prio_offload) {
> > > > -		for (i =3D priv->plat->tx_queues_to_use; i < tx_cnt; i++) {
> > > > -			if (priv->plat->tx_queues_cfg[i].mode_to_use =3D=3D
> > > > -			    MTL_QUEUE_AVB)
> > > > -				return -EINVAL;
> > > > -		}
> > > > -	}
> > > > -
> > > >  	if (netif_running(dev))
> > > >  		stmmac_release(dev);
> > > > =20
> > > > diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c b/driv=
ers/net/ethernet/stmicro/stmmac/stmmac_tc.c
> > > > index ea1f97d6f0bd..175236ba379d 100644
> > > > --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
> > > > +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
> > > > @@ -346,9 +346,6 @@ static int tc_setup_cbs(struct stmmac_priv *pri=
v,
> > > >  	if (!priv->dma_cap.av)
> > > >  		return -EOPNOTSUPP;
> > > > =20
> > > > -	if (qopt->enable && priv->xmit_qdisc.prio_offload)
> > > > -		return -EOPNOTSUPP;
> > > > -
> > > >  	port_transmit_rate_kbps =3D qopt->idleslope - qopt->sendslope;
> > > > =20
> > > >  	if (qopt->enable) {
> > > > @@ -1340,7 +1337,6 @@ static void tc_mqprio_config_queue_prio(struc=
t stmmac_priv *priv,
> > > >  static int tc_mqprio_validate_chan_mode(struct stmmac_priv *priv,
> > > >  					struct tc_mqprio_qopt_offload *mqprio)
> > > >  {
> > > > -	struct plat_stmmacenet_data *pdata =3D priv->plat;
> > > >  	struct tc_mqprio_qopt *qopt =3D &mqprio->qopt;
> > > >  	int i;
> > > > =20
> > > > @@ -1350,18 +1346,6 @@ static int tc_mqprio_validate_chan_mode(stru=
ct stmmac_priv *priv,
> > > >  		return -EOPNOTSUPP;
> > > >  	}
> > > > =20
> > > > -	/* Forcing strict priority conflicts with the CBS algorithm
> > > > -	 * of AVB queues, so reject the offload when any queue is
> > > > -	 * configured as AVB.
> > > > -	 */
> > > > -	for (i =3D 0; i < pdata->tx_queues_to_use; i++) {
> > > > -		if (pdata->tx_queues_cfg[i].mode_to_use =3D=3D MTL_QUEUE_AVB) {
> > > > -			NL_SET_ERR_MSG_MOD(mqprio->extack,
> > > > -					   "SP conflicts with AVB queues");
> > > > -			return -EOPNOTSUPP;
> > > > -		}
> > > > -	}
> > > > -
> > > >  	for (i =3D 0; i < qopt->num_tc; i++) {
> > > >  		/* The offload switches the MTL scheduler to strict
> > > >  		 * priority, which only supports a 1:1 TC to TX queue
> > > >=20
> > > > ---
> > > > base-commit: d0bd617658ddfa5a115e64d1ab687bf155f6331f
> > > > change-id: 20261012-stmmac-mqprio-cbs-combo-341f12749ce2
> > > >=20
> > > > Best regards,
> > > > --=20
> > > > Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
> > > >=20
> > >=20
> > > /Daniel
>=20
>=20

--N9isKUosey8taFli
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCas4jDQAKCRA6cBh0uS2t
rCkRAP45m7SIjwOdxBQYPN15+CQ4puHY3w4+MjjuXw34i24K6AD8DaivhbgUtFls
WzPW9+mrIyv8adf5/ND4CeqMcwXH4Q8=
=HtK7
-----END PGP SIGNATURE-----

--N9isKUosey8taFli--
