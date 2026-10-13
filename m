Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 799C63EB108
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 10:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791886891; cv=none; b=WxM1rSQEj1TGd/0hz7hjhE8t5vn0ef9JxCB+eiwqwGefzy7tqPYeqW6As6kf9UaM/Lu7517WA4nSWV69XfJYEpmi3yZQRiyM/bbQDihtiabFeddOmZGJEpbvEz5jZ2jui8mTqqFLUjGTR51ByLqQI/BFt1HQbd8dr74cXRJH29I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791886891; c=relaxed/simple;
	bh=0+01/GuXvaTyv65OnSeXlaqqcPH0CfF2wjoMFOfcaSI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SwrnOdpwsM7SKdzZ5lKv6Q9DwxCU5L3DQpqOzsRMNczST93X5/b4geIhJzkffVlcbPU5JnN68Ka6ujSMXpg3B5BJFPAmdHrRaLZkJxF4Pmu5R0AVeao//afIGWDUT4DW9CTRAMEeR/g9V5qV0bna/oA9rCAsbx48RN8o+T54/Bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pV2t7TWb; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Xwb4cjda; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pV2t7TWb";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Xwb4cjda"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69D6YrQS3208361
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 10:21:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=StYE4hJraQDU2YIRE83lf6jH
	ixx8TulQpMYbG0l+io8=; b=pV2t7TWbzuNN5VlkPLxmPzTGGfp7YWOvMoYWM6oU
	E41nuwQe9OrCcoAZdoRqKqtlg49yW+yvUvRTlAdEMqCnJ9wtbpd+kgpLt9Whdfue
	pfAI26pebQBfMUI03n3W9G4nYtkT0Fln4GMkLf+Q4PU7MpTec7FNajVbOPnVw9JO
	VXaYaR6DsHhU4NjtTGHhltiJyPAxZlqyrch2skR6aqSD9O6bnvW7FXd0bgQv4x2Z
	jR9pngW0cTZISiWSowzdQwbiofiVFwFVnFaH9MyLfIDdgbOgwpzfi13PmOy777th
	C+8KSlJyjbwY5ZIaL7YSt59VoEWU0Dt6/JTnckZfSVCi8w==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h9fgjgxb8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 10:21:28 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-91b875639ceso28442556d6.1
        for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 03:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791886888; x=1792491688; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=StYE4hJraQDU2YIRE83lf6jHixx8TulQpMYbG0l+io8=;
        b=Xwb4cjdaJHXRqt9TcVl3COW4TKzLb6utmAFcxxbhtnU1GE2OppKFSXTWKppC1324/j
         3dp7IPCDaXQladQ1mksI1c1fLw4yBGrnx7K4aAwFQhOysa7bCuqMN5MBeem7W2qTVsv5
         I9+Kk3Gbl3uVdU5yKKLgbhkv9HYlBaQ4YJDn8+WoREuVlZMiyu87mG6uD8PlMmRhxCqd
         2PatyV3VB1p8prIwUhgScw9NG8mZ83SqPd/f1JRi2GfJYuuIZ8SRYRqJhucM14ric7GT
         ZIYXU/DR/zmGQgu8IfGvUUVReBZ/VvXam3/dVav9eeVJgm7E8CAQhspQcFk2iq1Zj2Do
         2LDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791886888; x=1792491688;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=StYE4hJraQDU2YIRE83lf6jHixx8TulQpMYbG0l+io8=;
        b=zsMoXzKySh6CFNErRiUieu5sOe7Gb1Ye9NEYMGO3tiPYmnHuMGe0USM0N6zit8KJ5s
         p5XRC2Ipkq+U3EJhS3cwkXpBosUzN2l6bHuJ1Csusq/AaCed3bdjl5ohqbGgJwIS1+fF
         UR1RmOKw7g2vRZdLxeGq9Kd75wsYBIxndGiPjRsRJ9f9hDCLL1rqMQ2822R5wGZ/dTcn
         DwlcJyCR1qCF1QSOQM4/GVKYdmLdOndRFsvlNr8oWbjgZ8r0x7Fl3/102xhq1RuBuJOh
         uyI36WSPc+i8MTpuSAz2Vqff56wnoRKVdJqt5foZ5sv76k9lTioeljzmhsViK8q93g74
         5BEw==
X-Forwarded-Encrypted: i=1; AKwUvBx9GfB+WlJeJQJYnOFnLsbXPjk3kEo0D7A5FVBUg/+iy/u7b+0Y75E78SJbEANLALq+UVPRlXQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYIg5klxXmSFBcAj34mtxOllhjQGfs1Mk/zKHdtTWVDfoDlkvPgt
	rDcskTkYXqi/9c3h1wgkDK+LaFZPwHVRBX01dVD3ebxvffAcYsq22s8c6L1dq8ughimKWau8sY5
	TKipOXT1/eEwVPnI9QPXdPXvoeGVii1UPWK0Q2MO4IIX4pjJF0cqyK9+aFsk=
X-Gm-Gg: AYBFou1EbGCR0762XEWNgE56IdB6K81jVsbSA++E8DQefwAyxjykLSxfiFlIluZiD5X
	UZtn9/4+LET2Xiv1k8tKJNvusImo/41RDhgrWJOHRMO+6QmbPAasA/0RMhZSrYwGVthp6u/FXVI
	Z7Ff4gpdv71zc2PPaPW7tSnbz0+nonu05HRoaS7HZoWfB4WCRkSLt23NszPufW/E43qztI9CbEF
	GufoUpZHQptG0I5VVKvZGHrn5ryr7P5j9kbi+f2bp97dZ9xqgxmNAUUomiZeBUtom8ExqSWB1RJ
	bBySn7I/wEpsDPL2krmpwUz5cHvuF84jpdCCZN49ARAy7q4HCE0O46ztwPdH0MilxCqnsY/QMWo
	k+lyX8f1Au1qL5w==
X-Received: by 2002:a05:620a:19a8:b0:93e:74e5:2b1a with SMTP id af79cd13be357-93ebd0e4407mr1905669185a.10.1791886887642;
        Tue, 13 Oct 2026 03:21:27 -0700 (PDT)
X-Received: by 2002:a05:620a:19a8:b0:93e:74e5:2b1a with SMTP id af79cd13be357-93ebd0e4407mr1905666085a.10.1791886887043;
        Tue, 13 Oct 2026 03:21:27 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48de0ac4fd7sm4331907f8f.40.2026.10.13.03.21.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 03:21:26 -0700 (PDT)
Date: Tue, 13 Oct 2026 12:21:25 +0200
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
Message-ID: <as4GJdF8oD_8FsGI@lore-desk>
References: <20261012-stmmac-mqprio-cbs-combo-v1-1-831e323eb4ef@oss.qualcomm.com>
 <20261013101031.42ilxihghwsivccm@DEN-DL-M70577.microsemi.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="kEZubP9inIt+EcXY"
Content-Disposition: inline
In-Reply-To: <20261013101031.42ilxihghwsivccm@DEN-DL-M70577.microsemi.net>
X-Proofpoint-GUID: ZCkoBLyo4lWP5fPUCNyezl48ZVuBt3Ii
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDA0MSBTYWx0ZWRfX7+1RiSFgBAP5
 G5LiO8McQP5fZvyzb4o3zGVy1AZbygewTt9/cvnn+GYgmwf1rsvpNhi9a199MdDnvv19OvG8hSQ
 tQ4eDm7/McU0YvMyZK36U7t7RL5DwhgKYDE71CnWvVK96Xjk3DBfHUFDsd354btiWk794XN5Gjf
 jjUvl9Un472b0ncOmataH6Xg713qAqQGHbTyzKNXG/dWOIGiG6QciMRIFs7KcpZFRna9gujW1T5
 bXRnQlakcm/fdmpVvF0+AiEbiHxVVHu4PWS9Lom9crJGdpNXzpB3lN6GSzCbj0zPn83xaMfbHY6
 AH7XrQAelYNI/BA3ac+JwnjvrND6cxIGXmG0BC31EiVs94FFp+sXPOB6EdVrMtQ15fJ98KOYWlN
 ES5HqoKAuELv8Dgop6LRc5FAXlt3dnzDL8O7WAJk1Zi9Dd5/rSZI0KtVQEAqNf4R/J/xf72voCD
 BB3lvRQ5mc4DhyvVy+w==
X-Proofpoint-ORIG-GUID: ZCkoBLyo4lWP5fPUCNyezl48ZVuBt3Ii
X-Authority-Analysis: v=2.4 cv=PedqFShd c=1 sm=1 tr=0 ts=6ace0628 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=ee_2aqc6AAAA:8
 a=EUspDBNiAAAA:8 a=sKW1L16I2tC2GuKI_P0A:9 a=CjuIK1q_8ugA:10
 a=shb_a47hcL9woofGVGcA:9 a=iYH6xdkBrDN1Jqds4HTS:22 a=VOpmJXOdbJOWo2YY3GeN:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDA0MSBTYWx0ZWRfX3I1jzgwGvYVd
 +gB4U92zvXVzFmozzMR4O/h+xfZkZNnPeZoef50js/UuTlUUmUy6H64IYtMi3VfYmd5tCB6l9+m
 phlh6HmE906jh+nr6G8njwuNHaqU9bQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 spamscore=0 priorityscore=1501 clxscore=1015
 adultscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610130041

--kEZubP9inIt+EcXY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Oct 13, Daniel Machon wrote:
> Hi Lorenzo,
>=20
> Just a question:
>=20
> > The channel-mode mqprio offload and the CBS offload can currently not be
> > enabled at the same time. tc_mqprio_validate_chan_mode() refuses the
> > mqprio offload as soon as any TX queue is configured in AVB mode, and
> > tc_setup_cbs() refuses to enable CBS while the strict-priority scheduler
> > is active. As a result the combination is rejected whichever order the
> > two are configured in.
> >=20
> > The strict-priority scheduler selected by the channel-mode mqprio
> > offload and the per-queue CBS shaper are independent MTL settings and do
> > not conflict, so drop the checks and let the combination be offloaded.
> > The following configuration, which was previously refused, now works:
>=20
> Looks to me like these checks are shared by multiple cores. Are the MTL s=
ettings
> independent on all of them?

Can you please explain what you mean?
What I mean with this patch is we can have a given queue (e.g. queue X)
configured in MTL_QUEUE_AVB mode and another one (e.g. queue Y) configured
in MTL_QUEUE_DCB mode.

Regards,
Lorenzo

>=20
> >=20
> >   $ tc qdisc replace dev eth0 handle 100 parent root mqprio num_tc 4 \
> >         map  0  0  0  0  0  1  2  3  0  0  0  0  0  0  0  0 \
> >         queues 1@0 1@1 1@2 1@3 mode channel hw 1
> >   $ tc qdisc replace dev eth0 parent 100:2 handle 102: cbs \
> >         idleslope 800000 sendslope -1700000 hicredit 494 locredit -1049=
 offload 0
> >   $ tc qdisc replace dev eth0 parent 100:3 handle 103: cbs \
> >         idleslope 400000 sendslope -2100000 hicredit 247 locredit -1296=
 offload 1
> >   $ tc qdisc replace dev eth0 parent 100:4 handle 104: cbs \
> >         idleslope 200000 sendslope -2300000 hicredit 124 locredit -1419=
 offload 1
> >=20
> > Fixes: 47891d501e34 ("net: stmmac: add tc mqprio hw queue priority offl=
oad")
> > Tested-by: Daniel Thompson <daniel@riscstar.com>
> > Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
> > ---
> >  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c |  8 --------
> >  drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c   | 16 ----------------
> >  2 files changed, 24 deletions(-)
> >=20
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/driver=
s/net/ethernet/stmicro/stmmac/stmmac_main.c
> > index 56d89a696272..51d502930219 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > @@ -7740,14 +7740,6 @@ int stmmac_reinit_queues(struct net_device *dev,=
 u8 rx_cnt, u8 tx_cnt)
> >  	    tx_cnt < priv->xmit_qdisc.num_tx_queues)
> >  		return -EINVAL;
> > =20
> > -	if (priv->xmit_qdisc.prio_offload) {
> > -		for (i =3D priv->plat->tx_queues_to_use; i < tx_cnt; i++) {
> > -			if (priv->plat->tx_queues_cfg[i].mode_to_use =3D=3D
> > -			    MTL_QUEUE_AVB)
> > -				return -EINVAL;
> > -		}
> > -	}
> > -
> >  	if (netif_running(dev))
> >  		stmmac_release(dev);
> > =20
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c b/drivers/=
net/ethernet/stmicro/stmmac/stmmac_tc.c
> > index ea1f97d6f0bd..175236ba379d 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
> > +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
> > @@ -346,9 +346,6 @@ static int tc_setup_cbs(struct stmmac_priv *priv,
> >  	if (!priv->dma_cap.av)
> >  		return -EOPNOTSUPP;
> > =20
> > -	if (qopt->enable && priv->xmit_qdisc.prio_offload)
> > -		return -EOPNOTSUPP;
> > -
> >  	port_transmit_rate_kbps =3D qopt->idleslope - qopt->sendslope;
> > =20
> >  	if (qopt->enable) {
> > @@ -1340,7 +1337,6 @@ static void tc_mqprio_config_queue_prio(struct st=
mmac_priv *priv,
> >  static int tc_mqprio_validate_chan_mode(struct stmmac_priv *priv,
> >  					struct tc_mqprio_qopt_offload *mqprio)
> >  {
> > -	struct plat_stmmacenet_data *pdata =3D priv->plat;
> >  	struct tc_mqprio_qopt *qopt =3D &mqprio->qopt;
> >  	int i;
> > =20
> > @@ -1350,18 +1346,6 @@ static int tc_mqprio_validate_chan_mode(struct s=
tmmac_priv *priv,
> >  		return -EOPNOTSUPP;
> >  	}
> > =20
> > -	/* Forcing strict priority conflicts with the CBS algorithm
> > -	 * of AVB queues, so reject the offload when any queue is
> > -	 * configured as AVB.
> > -	 */
> > -	for (i =3D 0; i < pdata->tx_queues_to_use; i++) {
> > -		if (pdata->tx_queues_cfg[i].mode_to_use =3D=3D MTL_QUEUE_AVB) {
> > -			NL_SET_ERR_MSG_MOD(mqprio->extack,
> > -					   "SP conflicts with AVB queues");
> > -			return -EOPNOTSUPP;
> > -		}
> > -	}
> > -
> >  	for (i =3D 0; i < qopt->num_tc; i++) {
> >  		/* The offload switches the MTL scheduler to strict
> >  		 * priority, which only supports a 1:1 TC to TX queue
> >=20
> > ---
> > base-commit: d0bd617658ddfa5a115e64d1ab687bf155f6331f
> > change-id: 20261012-stmmac-mqprio-cbs-combo-341f12749ce2
> >=20
> > Best regards,
> > --=20
> > Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
> >=20
>=20
> /Daniel

--kEZubP9inIt+EcXY
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCas4GJQAKCRA6cBh0uS2t
rL5PAP96OeU3WRJ+TomdoC9LeM8yGVHFcEqblfYZI9SX0VBt0wEAjcs9EIgh1j6f
yQB9U+DWjdpb/AWwTIFJgUtAxr5M3Qk=
=VGRf
-----END PGP SIGNATURE-----

--kEZubP9inIt+EcXY--
