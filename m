Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E7854ACC8B
	for <netdev@vger.kernel.org>; Tue,  8 Sep 2026 10:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788862369; cv=none; b=Edie6XpSsMEIs2QxxGVjT0SrnfXgVQyXGOvG1Lgmqbtw/Bl62kCPCAcjmqRswjjlJM/ugtSYrAn+MLG7IkkY0CJYjznB19svsQPuDtLkx4ca3MuG3K5ZtdT3ws1PAXjKN4SlwJXc62V5NkGn9YZaAuwENgG7+GGEC0cVnxuN35g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788862369; c=relaxed/simple;
	bh=Wmo3leSbBny+u2JoCXkU4dutDeqHjC+nNrVKkZvXb+I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gi4DCm6kPhWVWdH77uMrPaT9DEX/vaVs9BOoBFnbQJ6ZzK1ADdNJyigKmtJp8/QRCutDXFSEymxYKlcnbbIaf9ZlUCchkbnl+OqlR0ny6hQHZ56kzSVrl1gmhZT1dmirOsADWHGLW0/0ZeQumxmJjadnB25/S+/IJtISZNksKlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=os7W4rRu; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=AK74/lag; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="os7W4rRu";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="AK74/lag"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6886Liwe950259
	for <netdev@vger.kernel.org>; Tue, 8 Sep 2026 10:12:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=rAJn8InQv+5Y+4q6ntzM1FDW
	ItX8dqMOLTxUt0EDKqw=; b=os7W4rRuc0UTmDLEQkvgtwJKDXfKLwDDXB2hUCI6
	fqA3XAUlE+qBNWSwfq6gFTXFAJZbfCfIHLGhaCAoxglQPjacn/ZhOq7uiA4vD19A
	csTW3CroTsKpk4/RrkwrMpPcwo/biHn2LtB58i9XGsQeToAxZ2PBAansYdMzQ2rN
	AUFdk/gEJnCMjjenff0wR8KY2cI2sTKEJd4jWru3jutvBWgWp6ZiEgEQyn4Eb6KW
	e+HaquCEPGBWnE6SsGI1kvESvblXbdGH2Xs9h5j7fPvcNi4q18nKXv3adj93g8T4
	tc6+xuPIuUy0WFnoPElSv1S5NNnCHu6ZcbmxkzauEW+ymg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gjcrp90mu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 08 Sep 2026 10:12:47 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-939062ecda9so534493285a.1
        for <netdev@vger.kernel.org>; Tue, 08 Sep 2026 03:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788862366; x=1789467166; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rAJn8InQv+5Y+4q6ntzM1FDWItX8dqMOLTxUt0EDKqw=;
        b=AK74/lagXh8GgiUR2SjiuCDfZukATsjPrE/Li5GuIQDmG/kveOgUxMU2kgobTPXAk2
         THuw/5C+vK/YAGevfRlTIIBmn+q1VTJ8CubDTcEfCEuhgikRdC4NqoptAN34rVZ1w3QL
         zOp/kwWXALE3Ra2E1JTFAZIaZHZzE1xzb3iJ0YeM+ZGpqqfS7p22VXq4tMe1gU+qeOzh
         t/PmAEz8bylMWhE8+UA0Gddi0a7Aq5TRT5v7OmdJR7kc1dMbL+2cdY8Hh9L4gFMLwYp8
         wGLZ3NitDYKmOjHqoVbE3EAjjZnlTkuFIHSgW7YLThlRXMuqcwWFrNNXRRrAEKHNUUFm
         BKWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788862366; x=1789467166;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rAJn8InQv+5Y+4q6ntzM1FDWItX8dqMOLTxUt0EDKqw=;
        b=P2CTcnwJCBAEfBknayPBQuSr+ROMqL1QFs8CS88cJSPaM/hydsFl4zrZMdjf5dGZIM
         85JtFjwOG3Lgryno8cZOz7B+PifWLHl2o1Eia36A5XjoJBAKjPu14132lvvHoWql0D6H
         NtgWRHhck9X5g/QSJYOiRwMwprAgv37JdKT+jJcem6N+SIFts1aIqp+pj/sEXFMO/Tjd
         +Lwic26EwNUBPh9nH2T2hfUV/YnEpIzpp8QUEJ7NX4YEuGo9ZLTxUWzi9ISNjdNuOPxb
         LhPsGZDcHOM5LfSlrAr8S2vKpZKsLInPVug1vu4nRNsfacfRzIZxY+G348QsV4nFBPmf
         dHHQ==
X-Forwarded-Encrypted: i=1; AKwUvBw8ow7OCrS0Wl9pLfhQFXkOe1egXvwxiXN/wX6b7uabHiYEOTYT5oqSwUCeoZuOlVV5i9tauus=@vger.kernel.org
X-Gm-Message-State: AFuF++m9T+aTrID/XXYiW341+Oa/S4uVLJVxMt2SzY6n83AKK2tmAbZX
	A+dwxtpZ0+GpnbBrnO9aeVctk2+qbFGWvdvtcSlPtx8Fwqg151z3f2qRNdcJaoyP56eGrlxfSoU
	EhYTMwa72X+XLGSWChDRTmFjhT9gCDqvfagH4hoT6Cun2jUVaXqfdy7Nx8cQ=
X-Gm-Gg: AYBFou2LuZIZdmfEyb8NCmpDEwAz+foL5R5toWl3kCIMJumA5XMIle2o8TtGL0n9hgo
	FY+0rtcrryu1nNa3QvitUp4RNGPnzmPGofmQvKHbxn6c8wPZftAoPxg12eiDk4fvE/NtxpbHxa3
	wH880NsRNtU/z7dsGZqEbpJP9ijVUzZy+VG91z4Q7zeYvby9Bb7o+CEzWFsCk2GojLkGyIEzEuw
	Oj48B7xPiARC5SpxaOxS3LEGRtSODZ9Px3OXElAyvxSLef3EjXcxzEuYPaV4hcUqNDycoYsmlpz
	VYZS7RNMV3b6KllZfuy+MKKECGTRHjuzl1i9dhDcX7LG1+/wV7klSFmozsvGAMabwDdLQiujCNX
	9OvSAUUiF6Ou2ag==
X-Received: by 2002:a05:620a:370e:b0:939:5f4d:67b0 with SMTP id af79cd13be357-939803292a1mr3004428485a.8.1788862366026;
        Tue, 08 Sep 2026 03:12:46 -0700 (PDT)
X-Received: by 2002:a05:620a:370e:b0:939:5f4d:67b0 with SMTP id af79cd13be357-939803292a1mr3004422485a.8.1788862365511;
        Tue, 08 Sep 2026 03:12:45 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c28e9eb4d38sm291683966b.41.2026.09.08.03.12.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 03:12:44 -0700 (PDT)
Date: Tue, 8 Sep 2026 12:12:43 +0200
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
To: netdev-bot+sashiko@kernel.org
Cc: maxime.chevallier@bootlin.com, andrew+netdev@lunn.ch, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
        0x1207@gmail.com, olteanv@gmail.com, netdev@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net] net: stmmac: preserve real_num_tx_queues on mqprio
 setup failure
Message-ID: <ap_fm9S7zSAbGSKq@lore-desk>
References: <178885859069.219967.17905742130775758644@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zha47Yv+EyU8m3To"
Content-Disposition: inline
In-Reply-To: <178885859069.219967.17905742130775758644@kernel.org>
X-Authority-Analysis: v=2.4 cv=UfRhjqSN c=1 sm=1 tr=0 ts=6a9fdf9f cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=9R54UkLUAAAA:8
 a=EUspDBNiAAAA:8 a=Xy7cffxmSr3xhYrA3wsA:9 a=QEXdDO2ut3YA:10
 a=A9K5AMd-i6aA7Fx2OoQA:9 a=bTQJ7kPSJx9SKPbeHEYW:22 a=YTcpBFlVQWkNscrzJ_Dz:22
X-Proofpoint-ORIG-GUID: bDwyHv06smdgXbCY533bel5Beb36G45g
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA4MDEwNyBTYWx0ZWRfX8pxI8kOwSlBl
 t+t+PP6GF3IxKsjTAUfyfvqdsT5Puih4u966+v5vjq0h3c14ezhrCc2dieZl6H0yGdxkNFo7Cui
 b+Pv0DLmTbokOjcdCCaUECkzKLbT2mWLvLdRuPssOTcy8ZJpiMWIe08DqtYY5fWb+/ZPRNhoTF3
 22NkU9A+anI7Oxa7L7z9OXKHt6/4i2zeyTvKEOkJdOrMdD5HUKoMrLkdEA2dSnXNxR71PQbEutj
 hwBrFJfyQSJ2MsnHkd7SB0BOEACrLe96X5OI9RyQGdoFnfp84Ww5DycJA6zVvLqwcOzw9YUYtQ3
 S5pZtzn72SeRq3BVyE9aHhAqhePzp66sMjV8ktr9CEpJpQIMrha/aRvUzM37XIqwayHM8Hg6iIt
 cGHOiT/j8SfRDAPBMtLfnoyg99N1xuVReyjfS3wpKYZPk/O4zK/3Pgmk2XsiBdmD5nxkKv6+EcE
 gJP6QnbSI+SPLVL+jZQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA4MDEwNyBTYWx0ZWRfX3ZK7m7mCDblM
 8jKSUOBjoAo7KijHUgFgQe8dP7NKH8X9IpvFduhAGLzKH08Wn0o7ukmliwH9qmAOGyKlEHI1xwV
 s78Cl7TsZ55bk0uT88i2uBxaGmnX4nU=
X-Proofpoint-GUID: bDwyHv06smdgXbCY533bel5Beb36G45g
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_01,2026-09-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 phishscore=0 suspectscore=0
 spamscore=0 bulkscore=0 malwarescore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609080107

--zha47Yv+EyU8m3To
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Thank you for your contribution! Sashiko AI review found 2 potential
> issue(s) to consider:
>=20
> Critical: 0 =C2=B7 High: 1 =C2=B7 Medium: 1 =C2=B7 Low: 0
>=20
> - [High] The patch silently changes the semantics of the shared dispatch
>   macro stmmac_fpe_map_preemption_class() in hwif.h from=E2=80=A6
> - [Medium] The TC state that the new error path saves and restores
>   (num_tc via stmmac_set_ndev_tcs(), plus prio_tc_map) is immediately=E2=
=80=A6
>=20
> --
>=20
> net: stmmac: preserve real_num_tx_queues on mqprio setup failure
>=20
> This reworks tc_setup_dwmac510_mqprio() so that the previous num_tc,
> tc_to_txq and prio_tc_map values are saved and restored on failure instead
> of calling stmmac_reset_tc_mqprio(), and adds a stmmac_set_ndev_tcs()
> helper.  It also switches the stmmac_fpe_map_preemption_class() dispatch
> macro from stmmac_do_void_callback() to stmmac_do_callback().
>=20
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/hwif.h b/drivers/net/e=
thernet/stmicro/stmmac/hwif.h
> > index 04dafec021b4..9314bcb85c22 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/hwif.h
> > +++ b/drivers/net/ethernet/stmicro/stmmac/hwif.h
> > @@ -494,7 +494,7 @@ struct stmmac_ops {
> >  #define stmmac_set_arp_offload(__priv, __args...) \
> >  	stmmac_do_void_callback(__priv, mac, set_arp_offload, __args)
> >  #define stmmac_fpe_map_preemption_class(__priv, __args...) \
> > -	stmmac_do_void_callback(__priv, mac, fpe_map_preemption_class, __args)
> > +	stmmac_do_callback(__priv, mac, fpe_map_preemption_class, __args)
>=20
> [Severity: High]
> Should this macro conversion be called out in the commit message, and
> possibly split into its own patch?  It changes the semantics of a shared
> dispatch macro for all of its users, not only for the mqprio path.

I do not think so since this patch adds the only place where the
stmmac_fpe_map_preemption_class() return value is honored, all the other
stmmac_fpe_map_preemption_class() calls discard the error value.


[...]

>=20
> Second, the same macro is used by tc_taprio_configure():
>=20
> drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c:tc_taprio_configure() {
> 	...
> 	ret =3D stmmac_fpe_map_preemption_class(priv, priv->dev, extack,
> 					      qopt->mqprio.preemptible_tcs);
> 	if (ret)
> 		goto disable;
> 	...
> }
>=20
> That "if (ret)" was dead code and becomes live here.  In
> dwmac5_fpe_map_preemption_class():
>=20
> drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.c {
> 	...
> 		if (priv->plat->tx_sched_algorithm =3D=3D MTL_TX_ALGORITHM_SP) {
> 			NL_SET_ERR_MSG_MOD(extack, ALG_ERR_MSG);
> 			return -EINVAL;
> 		}
> 	...
> }
>=20
> tx_sched_algorithm defaults to MTL_TX_ALGORITHM_SP for DT platforms in
> stmmac_platform.c, and the default per-queue weights differ (0x10 + queue=
),
> so a taprio or mqprio configuration with a preemptible TC owning more than
> one TXQ now gets -EINVAL where it previously returned success with the
> preemption-class register left unprogrammed.

I think it is better to return an error if the hw is not programmed properly
since otherwise the NIC is silently not working fine. The user can check and
understand what is the wrong configuration.

>=20
> For taprio, the new error also takes the disable label, which clears
> priv->est->enable and reprograms EST, so the schedule that was just
> installed is torn down.  Is that intended for configurations that used to=
 be
> accepted, for example:
>=20
>   tc qdisc replace dev eth0 root taprio ... queues 2@0 2@2 ... fp E P
>=20
> Also, the two remaining users that still ignore the now meaningful return
> value, the taprio disable path and stmmac_reset_tc_mqprio(), were not
> updated.  Should they be?
>=20

[...]

>=20
> [Severity: Medium]
> Can this restore of num_tc, tc_to_txq and prio_tc_map ever be observed?
>=20
> tc_setup_dwmac510_mqprio() with num_tc !=3D 0 is only reached from
> mqprio_enable_offload() inside mqprio_init(), and the error is returned
> before hw_offload is recorded:
>=20
> net/sched/sch_mqprio.c:mqprio_enable_offload() {
> 	err =3D dev->netdev_ops->ndo_setup_tc(dev, TC_SETUP_QDISC_MQPRIO,
> 					    &mqprio);
> 	if (err)
> 		return err;
>=20
> 	priv->hw_offload =3D mqprio.qopt.hw;
> }
>=20
> qdisc_create() then always runs ops->destroy() on init failure:
>=20
> net/sched/sch_api.c:qdisc_create() {
> 	if (ops->init) {
> 		err =3D ops->init(sch, tca[TCA_OPTIONS], extack);
> 		if (err !=3D 0)
> 			goto err_out4;
> 	}
> ...
> err_out4:
> 	if (ops->destroy)
> 		ops->destroy(sch);
> }
>=20
> and with hw_offload still 0 the else branch is taken:
>=20
> net/sched/sch_mqprio.c:mqprio_destroy() {
> 	if (priv->hw_offload && dev->netdev_ops->ndo_setup_tc)
> 		mqprio_disable_offload(sch);
> 	else
> 		netdev_set_num_tc(dev, 0);
> }
>=20
> So dev->num_tc goes back to 0 immediately after the driver restored it, a=
nd
> skb_tx_hash() ignores tc_to_txq and prio_tc_map when num_tc is 0.  On a
> failing "tc qdisc replace" over an already offloaded mqprio, does the sti=
ll
> grafted old qdisc lose its priority classification anyway?

I think in a error condition, the driver is supposed to restore the previous
overwritten values, then it is up to qdisc layer to manage the error condit=
ion.

Regards,
Lorenzo

>=20
> If so, should the commit message text
>=20
>   "the TC-to-queue and priority-to-TC mappings are restored to the
>    previously saved values"
>=20
> be adjusted, since only the real_num_tx_queues part of the rollback appea=
rs
> to survive?
>=20
> --=20
> Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#/patch=
set/20260903-stmmac-tc_setup_dwmac510_mqprio-error-path-v1-1-eb171bdd340a%4=
0oss.qualcomm.com

--zha47Yv+EyU8m3To
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCap/fmwAKCRA6cBh0uS2t
rO1zAQDPOlQwk5kO3Lgc1cD7iaODG7Yivww9VgHBRP/kmUlbIQEA/nudYGh8e2Y2
LxT9Gq66y34ttjegg0hkFYRpemfIiQQ=
=TiM/
-----END PGP SIGNATURE-----

--zha47Yv+EyU8m3To--
