Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66AB722A4EE
	for <netdev@vger.kernel.org>; Tue,  6 Oct 2026 06:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791269859; cv=none; b=WE/jXA2DzsOvYUxmm9yW0FJyf3YUMwsP/VyoP/mjHsSv/R4SJymJs2/1RZDoxUWop/0Jz3WtYYYB3+O+fqIb/fOWAZoUWYD7vh6ltmQMnm5O2jOFBAc02JpHXBBgXv1BcotzUjYGeIionWlssvGuOUQP8RtVZvMVdL+1dDBMIWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791269859; c=relaxed/simple;
	bh=WpBOPrCBscmwMLTado5FsVSPyEjrU6Em7zODPmM4myU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cAU76lDnDE1SiJSJcmX6uD3HR0BltfDpucpK/WX5ellTjvqDYl/7sC+7HQ9Z849DqquKEvvP0VFKfUlCHrGzYTtL+NDUZht724DbZkD75MQcCtOLwekcqA+FKkRG84aXmiOBXrXnqklfsDgmMcAoUPnuf5EaszAH8z0GszkGdZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZRh0DRua; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dgsdoxgG; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZRh0DRua";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dgsdoxgG"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6966dse5094584
	for <netdev@vger.kernel.org>; Tue, 6 Oct 2026 06:57:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=QHKD0TCiV5FgOYF1uVO9X3gA
	7dIJfpFlI7tnzN7DHOc=; b=ZRh0DRuagu10jXsr/2CwnPuZzfrGoEcM7LrYOcqw
	RAEVUKsozM+B54RLojLSAaEM9QBuQOSlf3oF6ZUqg4ATlgw3RXjKKy/OCF5h9LaH
	nu6K8m4RIPv1DW+Cg2RMZ77OXRmwQT3GytBKQgHTW/oDZUY5Mkjow6GfB22YlAWA
	2XPSOUT2TBl1L+S+ORW+wKhb1jv6CPHUSHAAQyogjVVFSPrTF03vwTQ4jkSdgd/h
	v5jzvAYquZdZXdB15aiJ5kurpDESGaf9qplvKnl2KPagAzp9AWfl1dIsoTpYFewU
	ElSzbrywPLZgW3mfATZGFqC8mvsJF6ncM+RbRc/WEEJ3JQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h4gr3jdtm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 06 Oct 2026 06:57:37 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93a082c014aso481804485a.0
        for <netdev@vger.kernel.org>; Mon, 05 Oct 2026 23:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791269856; x=1791874656; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QHKD0TCiV5FgOYF1uVO9X3gA7dIJfpFlI7tnzN7DHOc=;
        b=dgsdoxgGGytbkynnsFHyCvXqmW6tiTuGS04mDK6+0GuEFCZx/pfBaemf7dUjnOazY6
         6Uwr1FPDGOBkRNnnhbOHhPMQYfMWFh+FtTub6ANbAooyEQTKWiy3I7e5KVATn87k66Kf
         C6zSkJpqBsdD/EiTIijZVCqByGfoTVcdCVV/lRpjuOp7WSHVdoLgNnGnioZWHyKZDP2X
         i6BF1Rln0QIAWwgA1yeOGHf5DgdbchUl5ombG5yTM3XTmt++SNVZ5J5yBZ4LwnARY7zm
         XRZFVOhrHujMB9Hblx9Rlpz8m6DDDJC6i6ks5CmJclvYikkjlm5OTrpx2+oqVInxxU9x
         vG4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791269856; x=1791874656;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QHKD0TCiV5FgOYF1uVO9X3gA7dIJfpFlI7tnzN7DHOc=;
        b=k/NbbOhH3LS/fNzIWxWCKzosbuYsNPCXmaprwx4qkE9YwAYtdEqovxBsUnIg6o33dI
         WoJnkxPbR8uTMt2KNMRskpG7QEKKMg73Ei1Shaf89Q7jl4vBP2J5xXjFh+QjvfUFyNzI
         sOSN2aGnWILCsETBLOScmwhAZxCZUl0SNV/pAyLwK2MP+kf49cZr1LqKLx37SpoYZCmm
         XbSUIC6lMAzh0YWTcllnTQSM5nJJJQuuBLtTkDt0FrAGLNVO/jijpzidhitGznfL6tuR
         eigyPX21fliM5yv1De2RXwGUCcGiX078dn6F9+hXLNFf5EEUf9orZfiEPpIGDmKZSQ0A
         b4gg==
X-Forwarded-Encrypted: i=1; AKwUvBzUtmGA0qWXiS4TBcD7dddEiYWVzRMoiIVnBxEPW/FtWDcl5cZocH2azSgMcOOiJYG9gNjGRJE=@vger.kernel.org
X-Gm-Message-State: AFuF++nPgxRxxzawmwSksmhHZzLVgF+JXpDs4zGtPlIGMkDOLhvA8Qwf
	ty+A+IQG+S0aFtMxxxmGdwOyTjrBZG4BF5p4Ap/0Vect7ZRvxpVsjJfDB7UXCFXPMlLLcfqAnfG
	lXnZ88uBNbvH/EUuawHBPNmhPY+YLtrrHn1hIne2HHksOq1JxCpHghg9Bce/Ks+mTHnk=
X-Gm-Gg: AYBFou0xKqExor625+BKYi/438jRVOASZyXDMce5WPunj7MjZJ6GYtLeaj8omG9Ydfc
	XJ2J5c59eZUCT89fmO0kARsbLMLLLbaYSqSY2TMFj8QlXECCxNf8BuSfd6XEVfjpP9lOBrhCdbH
	lKrjDtivIcVVtUbmzkDkOIrkgXW6scPVJYs45MhrFpymgGDkMb6YigVuhqhHIss2ZG3ZNJ5yB2F
	+YxcdZQf0WwV7z0sCB7Kava4dY0uSQ6KU01lC8R56g+9JhQ5WEsF1LwIl/vsIJ3lAZ3Kb/GZGet
	8CPe6PKZJ3Nwy+lQNWj8eIEe7Zx+binJeRcC2uytRH5KBlVoLRPX8icp7Ui/EMsDKjV7xVp6iXI
	i/evCzcQtVpWEWg==
X-Received: by 2002:a05:620a:618a:b0:93c:6450:9cec with SMTP id af79cd13be357-93e85ff3d0emr344087085a.5.1791269855966;
        Mon, 05 Oct 2026 23:57:35 -0700 (PDT)
X-Received: by 2002:a05:620a:618a:b0:93c:6450:9cec with SMTP id af79cd13be357-93e85ff3d0emr344084485a.5.1791269855325;
        Mon, 05 Oct 2026 23:57:35 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48c6308481dsm9551366f8f.3.2026.10.05.23.57.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 23:57:34 -0700 (PDT)
Date: Tue, 6 Oct 2026 08:57:33 +0200
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
To: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Jose Abreu <Jose.Abreu@synopsys.com>, netdev@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        Drew Fustini <fustini@kernel.org>, Jisheng Zhang <jszhang@kernel.org>,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH net v3] net: stmmac: propagate PTP addend and system time
 programming errors
Message-ID: <asSb3RNcityVg6ia@lore-desk>
References: <20260929-stmmac-ptp-added-systime-error-v3-1-ddd6afe936b4@oss.qualcomm.com>
 <dy5xfj3754wnp3gh2kpoyf3vpx3vfsfhblgbwbwsgts27xqxga@dzb33gt3zgca>
 <asQcQIh56MV1OJur@lore-desk>
 <CAEev2e8+fr1tJnSErD+2TtLDw5fGJbQOMcM5eefMnLyFUR+m7w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="PY9H+lOa39O6BaT9"
Content-Disposition: inline
In-Reply-To: <CAEev2e8+fr1tJnSErD+2TtLDw5fGJbQOMcM5eefMnLyFUR+m7w@mail.gmail.com>
X-Proofpoint-ORIG-GUID: 4eudK20JIqIEJqAEGmVOUy2pfbl99Wca
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA2MDAyNyBTYWx0ZWRfXz/akn0eHUtk4
 Z/y4sjoyMsdpObJZhgpE/cJlfHsedUsbDEOLr3PgwcLwi2n74a+tYKd5ohqIpyqy6bTcPKo4Z8G
 pkSUe5dtp8sidT0Mxt342jW9lD5pSdU=
X-Authority-Analysis: v=2.4 cv=PNWaavqC c=1 sm=1 tr=0 ts=6ac49be1 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=7Ag77JHl3iOYbQ2bdk4A:9 a=QEXdDO2ut3YA:10
 a=7pNlf7y_wykQaJU8uk8A:9 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA2MDAyNyBTYWx0ZWRfX2prNFKYTcUvH
 2zyxhKQY30ST0TENtX/wC4JeUDqaeGd8YIDV0LcPaSJfiIEJmht3QjjkjdDOCZLlBptrNm/Xt51
 t+FiwDYAu1r9/n8La9fzikoZh0AwThpi/DqJkGX6XGVgzV8HDHwZgdCGW7EFHScpe5i0Emb/5HB
 ETN34Mb6qbpGPyWlPlr7YSyuu64QSvidHpcmEfQR8kVjlVWyk9XkJ15uDJOPsA69BMKU+0ROQVK
 0vxKuB8K758J1tDf2/J51/4+BBUqFHiU8PU0MFbO7LdwKsSUK7ovzxv/3x8CIxJaZZgLwsEGPho
 U5s0YlSaqF2d6EefIMy6LqglsQtHomVNnt1CnxBGEyFb3zE7oTehDXHytJRsVHSamo7K00k+FCT
 tdM6vxUw/KUK813O/kEYUJo+c1WXl701UkFDItfYbIl+tVBK8Pf18Bc08PCgiGawAoxFitXMxbO
 h19I1EDJqLM5sYCqr4g==
X-Proofpoint-GUID: 4eudK20JIqIEJqAEGmVOUy2pfbl99Wca
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-06_02,2026-10-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 phishscore=0 clxscore=1015 adultscore=0
 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610060027

--PY9H+lOa39O6BaT9
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Hi Lorenzo,
>=20
> On Mon, Oct 5, 2026 at 4:53=E2=80=AFPM Lorenzo Bianconi
> <lorenzo.bianconi@oss.qualcomm.com> wrote:
> >
> > > On Tue, Sep 29, 2026 at 03:10:11PM +0200, Lorenzo Bianconi wrote:
> > > > stmmac_update_subsecond_increment() ignores the error returned by
> > > > stmmac_config_addend(), and stmmac_init_tstamp_counter() discards t=
he
> > > > addend and system time programming errors, always returning success=
=2E A
> > > > failure to program the addend (PTP_TCR_TSADDREG) or to initialize t=
he
> > > > system time counter (PTP_TCR_TSINIT) is therefore silently swallowe=
d,
> > > > leaving the hardware timestamp counter in a non-running or partially
> > > > configured state while the driver keeps operating as if timestamping
> > > > were up. This matters for TAPRIO/EST offloading, which derives the =
gate
> > > > base time from the hardware timestamp counter.
> > > >
> > > > The same hooks are also called from the PHC callbacks: settime64 and
> > > > adjfine drop the error and report success to clock_settime() and
> > > > clock_adjtime(), so a dead PTP reference clock goes unnoticed by
> > > > ptp4l/phc2sys.
> > > >
> > > > Return error codes from stmmac_update_subsecond_increment(),
> > > > stmmac_init_tstamp_counter(), stmmac_dl_ts_coarse_set() and the
> > > > settime64/adjfine callbacks instead of silently returning success. =
On
> > > > failure, roll back the partially applied configuration so the hardw=
are
> > > > and the driver bookkeeping stay consistent, and report the reason
> > > > through the devlink extack. Also guard against a zero sub-second
> > > > increment, which would otherwise divide by zero when computing the
> > > > addend.
> > > >
> > > > Reset the persistent timestamping state (hwts_tx_en, hwts_rx_en,
> > > > tstamp_config, systime_flags and tsfupdt_coarse) when (re)initializ=
ing
> > > > timestamping, so a failed init does not leave TX/RX timestamping
> > > > enabled on a counter that never started.
> > > >
> > > > Fixes: cc4c9001ce31 ("net: stmmac: Switch stmmac_hwtimestamp to gen=
eric HW Interface Helpers")
> > > > Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
> > > > ---
> > > > Changes in v3:
> > > > - Do not run stmmac_config_addend() in
> > > >   stmmac_update_subsecond_increment() error path.
> > > > - Return error from stmmac_adjust_freq() and stmmac_set_time().
> > > > - Reset hw ts configuration in stmmac_init_timestamping().
> > > > - Link to v2: https://lore.kernel.org/r/20260924-stmmac-ptp-added-s=
ystime-error-v2-1-beb2a6b5f866@oss.qualcomm.com
> > > >
> > > > Changes in v2:
> > > > - Initialize sec_inc to 0 in stmmac_restore_subsecond_increment()
> > > >   routine.
> > > > - Link to v1: https://lore.kernel.org/r/20260920-stmmac-ptp-added-s=
ystime-error-v1-1-8ac9e7a3fce2@oss.qualcomm.com
> > > > ---
> > > >  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 106 ++++++++++=
++++++------
> > > >  drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c  |  10 +-
> > > >  2 files changed, 84 insertions(+), 32 deletions(-)
> > >
> > > Hello, I'm noticing that after this patch was merged into linux-next,
> > > boot seems to hang when ip=3Ddhcp is used because ethernet isn't work=
ing
> > > on the TH1520 Lichee Pi 4a. These lines get printed in a loop over and
> > > over
> > >
> > > IP-Config: end0 hardware address 72:ca:a8:eb:27:[   24.872982] thead-=
dwmac ffe7070000.ethernet end0: Register MEM_TYPE_PAGE_POOL RxQ-0
> > > f2 mtu 1500 DHCP
> > > [   24.900412] thead-dwmac ffe7070000.ethernet end0: PHY [stmmac-0:01=
] driver [RTL8211F Gigabit Ethernet] (irq=3DPOLL)
> > > [   24.912780] dwmac1000: Master AXI performs any burst length
> > > [   24.912801] thead-dwmac ffe7070000.ethernet end0: No Safety Featur=
es support found
> > > [   25.010229] thead-dwmac ffe7070000.ethernet end0: PTP init failed
> > > SIOCSIFFLAGS: Connection timed out
> >
> > Hi Anirudh,
> >
> > based on the reported error, stmmac_init_tstamp_counter() fails with
> > -ETIMEDOUT. In particular this can occurs if:
> >
> > stmmac_init_tstamp_counter()
> >  -> stmmac_update_subsecond_increment() -> stmmac_config_addend() -> -E=
TIMEDOUT
> >  -> stmmac_init_systime() -> -ETIMEDOUT
> >
> > I guess we should understand which one is failing and why it is failing.
>=20
> It seems like both are timing out, both config_addend
> (PTP_TCR_TSADDREG) and init_systime (PTP_TCR_TSINIT).

It seems hw timestamping has never worked on this board, it was just
undiscovered since stmmac_init_tstamp_counter() was not reporting any
error before (this is exactly the goal of this patch).

What are the output for:
- IEEE 1588-2002 Time Stamp
- IEEE 1588-2008 Advanced Time Stamp

root@rb3-gen2:~# grep 'Time Stamp' /sys/kernel/debug/stmmaceth/eth0/dma_cap
IEEE 1588-2002 Time Stamp: N
IEEE 1588-2008 Advanced Time Stamp: Y

Regards,
Lorenzo

>=20
> Regards
> Anirudh Srinivasan

--PY9H+lOa39O6BaT9
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCasSb3QAKCRA6cBh0uS2t
rCKbAQCmJebvx52SDrck5zSXUdLfieTjYBeBL6g808K3mRR84AD/aSk0GzNPwVbF
/lg8BlYmykmbAcOk/AZYVZ286hVsugE=
=Gf8I
-----END PGP SIGNATURE-----

--PY9H+lOa39O6BaT9--
