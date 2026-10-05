Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52E913812F0
	for <netdev@vger.kernel.org>; Mon,  5 Oct 2026 21:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791237191; cv=none; b=QJizjIHF2iWwAslMaQn/o6UsgD78w1hy4TqZXpRczMhzk4ZzMn/99oBTNjYTREUBZD87JSRLS4x/2TpmIWeH89K6NWJw/iRCi7LC1cz3ZvLvTdik8PnOP27XGSiGsFVpmXwPapmbX+oNgFPzmB++5lliFUcnOQnMlssLomvdWmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791237191; c=relaxed/simple;
	bh=6CtDt42TEgaf8Rvfer3blhUEYg8b5IfAV68jShlSuzo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sx+jr2WrVABog8IBWF8/IwdE+FTuSFSMaSB3rR8VaLEVu9E1YLv4nDJpOVj54Jr5FQQVKcrUQXuNySCkxsW/sYnIv5eCEd5cGwthnH8H+urOhlTYMnYG3HpBR0205FIA2JaYjnEi6DJlBLXGmU+vw6OiovI6KZ8dtlsBSiC1D8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BrkX9Aa1; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=CGYzJZwC; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BrkX9Aa1";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CGYzJZwC"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 695KNEIm2955296
	for <netdev@vger.kernel.org>; Mon, 5 Oct 2026 21:53:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=BPwGOfHuRmccjFU/atXErY9t
	YKZ5sXf3uOO2o/Gtvso=; b=BrkX9Aa1fletisXMHiJLw4Si9yfWjvX9yH6+MB+n
	DonFfKslUhYTQ0+6+lBUcL+fxsmVfFTHbLlNhsUX3CvLwhxT1fhfNs6ucRA5f7xL
	BsVSwIe7O3Pix2Xpq6sL+Q0umddYigJZYkU15LomuEls9g8P2X5ndeBzKDGsFj1c
	a7HEuFSoUqGeRiJHzlpZG9IcTOqCbof1DZI7mDtZZps0+jeOfPq2N7WSp/uO2jSS
	w2Ttyv6lBj8NRKIRKOj5HiXf+CsawhoAtTGdrm7b1XE4t9tGNtUJwnGyioY6DtX9
	WSYYa79uA/W4ysMd3IqLrrvQZ5aYgisM15XbdKC7fOortQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h4cj62077-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 05 Oct 2026 21:53:07 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-92e82060977so352400285a.1
        for <netdev@vger.kernel.org>; Mon, 05 Oct 2026 14:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791237187; x=1791841987; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BPwGOfHuRmccjFU/atXErY9tYKZ5sXf3uOO2o/Gtvso=;
        b=CGYzJZwCZJzJ5osdUzqdUJFBjNfmkbgE35vilHP/a7acK1kgLUUjUX/vr5o5hEbT5t
         756b9tz1LFYikGB6UpHj2mcYObiKmWxb+T2jKh8IT3p1aYagIp9Hl/o9Zcy/M6eypoz6
         Ahx7h0QhjYLTvKEFtAQ22rDQ8/1nkPc2mxwv9mw+htPUz17Yvws8O93EP3QzG0dFE9FS
         p0eEk72+j0CALD1AGEGRhW3M569ft8+Q11jin8otfpl/1c/nWjuJLSJ6yHWuhmDq7KKD
         tES/BXv5RmnNJYel6N1xTAfBxiEVVoI6aTwBdceKv2mWjmJu4/ID+tp+4N8DDr/8CNA7
         Mcaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791237187; x=1791841987;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BPwGOfHuRmccjFU/atXErY9tYKZ5sXf3uOO2o/Gtvso=;
        b=mwcB5il7MVCAUAcGq79E0W5MWTapXv4IveRbNAeoD+CIsPoOMrDTkMb4XPqIwqKqCU
         NKy3n/u0gYCVTlrMpmiTpnxw8egyscSXheBOhcQYVVwiOZDGujiIh6kDCsAng6MdGsda
         0TWdh/Qop9QuGlVjKwJlJ9oMUz5Y2FefpanejG1sM48XbQGlDcMvFkUgwLwDVKR64rzY
         J08645IMRiJooOX6yee17iWByRMBv0py8A/x0lPX/gv9LJZwzVPPsDSiKUMo7uUliBSI
         vnSmSVCFODm+WPUGkLPts+ppH/WmqOs8B6ctBelW6uPjr1sqjCNbFD+4Fi3InIAqUI1+
         6P9g==
X-Forwarded-Encrypted: i=1; AKwUvBxp9KyB9G4n+DJOmccP80Ob2qGonIlvx60DWtL6r2adf56xgRIq4rwR152fF3mgyEvDg2vnx9Q=@vger.kernel.org
X-Gm-Message-State: AFuF++kLWm5XsWPhlbDncjI1OjnybwJ3UPYgMWcU1a8s2W72ECGVqnpn
	OHsO98pJUms0PUCgKpdCZqvNplq9Kllxy/PiEOsjTMiWePiBlu5P+R/tG0WC6YAVqFBxl/MnJ/M
	EvtZPfjaIHhn30vzgRJPNaho3F6PyrXaBosnjBZS/q/FTSBCkwnpjEmVEfUY=
X-Gm-Gg: AYBFou27RuoXT00AWdhbLcjBrxx0r11FeVXVgZHLhgwqJIM8Zoj805EdojQnQ43NGHk
	pGIHKaH/yjqTl34AF0IO+MymqYljBLBLxocReZx9fMenbjzkRhTZ9KLisFeQuiEqUkJLmAiAW0p
	1u5eQiTpmaQ4Y2D5RsIMD6SDB73UaPVn4qr7v1fa/Gz7VKDj90yYGnp7GOpY35A+8f4mk3Lrhyo
	xTrVuB8kT2TyNZfL6KK0+81HSrkCnfjz6SRoRtT+htksAmuf+RGSYclx/c7s/qP7opxki2HzJUZ
	AlTKhG2q/PSg9T2HlQUhasytkscPm7KPNxihluEunu5ypND683pAuuMx90Jm2A+24ft1dy191mq
	fgSIj6eylodkkIA==
X-Received: by 2002:a05:620a:711c:b0:93c:ab5e:2314 with SMTP id af79cd13be357-93e85ff6e47mr169815885a.7.1791237186636;
        Mon, 05 Oct 2026 14:53:06 -0700 (PDT)
X-Received: by 2002:a05:620a:711c:b0:93c:ab5e:2314 with SMTP id af79cd13be357-93e85ff6e47mr169811885a.7.1791237185973;
        Mon, 05 Oct 2026 14:53:05 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a178db04edsm21801155e9.11.2026.10.05.14.53.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 14:53:04 -0700 (PDT)
Date: Mon, 5 Oct 2026 23:53:04 +0200
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
Message-ID: <asQcQIh56MV1OJur@lore-desk>
References: <20260929-stmmac-ptp-added-systime-error-v3-1-ddd6afe936b4@oss.qualcomm.com>
 <dy5xfj3754wnp3gh2kpoyf3vpx3vfsfhblgbwbwsgts27xqxga@dzb33gt3zgca>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="p7q6TE+CPzeC67kd"
Content-Disposition: inline
In-Reply-To: <dy5xfj3754wnp3gh2kpoyf3vpx3vfsfhblgbwbwsgts27xqxga@dzb33gt3zgca>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA1MDA4NiBTYWx0ZWRfX7UsWlyXRSyj7
 t+VxRr/anDc3HxiYuFzRlkKe7uFlG1G5cJF/gvO4dnOqlRd6wNdG73apHhaaYtXkQHpFaXLvc3g
 ONUWjLbGn6XzTzYZaSApi2cH7yJyZs7mfncP6ryuYRyoHSRKXI91+cshNxi7UZiVIVme29OoQT2
 BbY2op4tbrkGgqvTBDWVMB8mIB4xQLpNvJekW9G5KVu2/mxCtMhZaQbrQQqSCETq8yfpQSVq1Su
 /XK9e3+7JYEcgSSO6B8HRczvhMezRSNq66HrHAWVdOJCobosvl+9130AWPD93CZJYQM+JL0txz0
 m4IdOoLQR3k2HDZUf+BBJAfqawR0AJhWafE+OUEOsJhP4kxeSbMo0ciUUhMjJWEkzmHBxF7fDOh
 hYZ5kQCMn4deyAWBDwwVorakCLyJtbHasu63j5iXl2bHgd1PAmMYiDhYoU9/Aywy/fFrlrRN+HO
 QLoWoMsTTJIwUgAN7EA==
X-Proofpoint-GUID: ozXQalSiNUh5yM-V5LhFV4jjmGqfX54h
X-Proofpoint-ORIG-GUID: ozXQalSiNUh5yM-V5LhFV4jjmGqfX54h
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA1MDA4NiBTYWx0ZWRfX+m3ZpJGY87or
 HGd3ntnBr72/ktXfDVja9pJGSVDROePpGw0+bwFWqTA7K4pWzC6gohPjM8BAa5s93v+qP6aOG62
 eovQkRoz0oyLXMf1WAZJPD3U1+dnzYM=
X-Authority-Analysis: v=2.4 cv=bpTZl0ai c=1 sm=1 tr=0 ts=6ac41c43 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=KWoxivdfoX57CmOC0t0A:9 a=CjuIK1q_8ugA:10
 a=HCU4Ot6V5InO-uz2qO0A:9 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-05_05,2026-10-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0
 clxscore=1015 adultscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2610050086

--p7q6TE+CPzeC67kd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Tue, Sep 29, 2026 at 03:10:11PM +0200, Lorenzo Bianconi wrote:
> > stmmac_update_subsecond_increment() ignores the error returned by
> > stmmac_config_addend(), and stmmac_init_tstamp_counter() discards the
> > addend and system time programming errors, always returning success. A
> > failure to program the addend (PTP_TCR_TSADDREG) or to initialize the
> > system time counter (PTP_TCR_TSINIT) is therefore silently swallowed,
> > leaving the hardware timestamp counter in a non-running or partially
> > configured state while the driver keeps operating as if timestamping
> > were up. This matters for TAPRIO/EST offloading, which derives the gate
> > base time from the hardware timestamp counter.
> >=20
> > The same hooks are also called from the PHC callbacks: settime64 and
> > adjfine drop the error and report success to clock_settime() and
> > clock_adjtime(), so a dead PTP reference clock goes unnoticed by
> > ptp4l/phc2sys.
> >=20
> > Return error codes from stmmac_update_subsecond_increment(),
> > stmmac_init_tstamp_counter(), stmmac_dl_ts_coarse_set() and the
> > settime64/adjfine callbacks instead of silently returning success. On
> > failure, roll back the partially applied configuration so the hardware
> > and the driver bookkeeping stay consistent, and report the reason
> > through the devlink extack. Also guard against a zero sub-second
> > increment, which would otherwise divide by zero when computing the
> > addend.
> >=20
> > Reset the persistent timestamping state (hwts_tx_en, hwts_rx_en,
> > tstamp_config, systime_flags and tsfupdt_coarse) when (re)initializing
> > timestamping, so a failed init does not leave TX/RX timestamping
> > enabled on a counter that never started.
> >=20
> > Fixes: cc4c9001ce31 ("net: stmmac: Switch stmmac_hwtimestamp to generic=
 HW Interface Helpers")
> > Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
> > ---
> > Changes in v3:
> > - Do not run stmmac_config_addend() in
> >   stmmac_update_subsecond_increment() error path.
> > - Return error from stmmac_adjust_freq() and stmmac_set_time().
> > - Reset hw ts configuration in stmmac_init_timestamping().
> > - Link to v2: https://lore.kernel.org/r/20260924-stmmac-ptp-added-systi=
me-error-v2-1-beb2a6b5f866@oss.qualcomm.com
> >=20
> > Changes in v2:
> > - Initialize sec_inc to 0 in stmmac_restore_subsecond_increment()
> >   routine.
> > - Link to v1: https://lore.kernel.org/r/20260920-stmmac-ptp-added-systi=
me-error-v1-1-8ac9e7a3fce2@oss.qualcomm.com
> > ---
> >  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 106 ++++++++++++++=
++------
> >  drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c  |  10 +-
> >  2 files changed, 84 insertions(+), 32 deletions(-)
>=20
> Hello, I'm noticing that after this patch was merged into linux-next,
> boot seems to hang when ip=3Ddhcp is used because ethernet isn't working
> on the TH1520 Lichee Pi 4a. These lines get printed in a loop over and
> over
>=20
> IP-Config: end0 hardware address 72:ca:a8:eb:27:[   24.872982] thead-dwma=
c ffe7070000.ethernet end0: Register MEM_TYPE_PAGE_POOL RxQ-0
> f2 mtu 1500 DHCP
> [   24.900412] thead-dwmac ffe7070000.ethernet end0: PHY [stmmac-0:01] dr=
iver [RTL8211F Gigabit Ethernet] (irq=3DPOLL)
> [   24.912780] dwmac1000: Master AXI performs any burst length
> [   24.912801] thead-dwmac ffe7070000.ethernet end0: No Safety Features s=
upport found
> [   25.010229] thead-dwmac ffe7070000.ethernet end0: PTP init failed
> SIOCSIFFLAGS: Connection timed out

Hi Anirudh,

based on the reported error, stmmac_init_tstamp_counter() fails with
-ETIMEDOUT. In particular this can occurs if:

stmmac_init_tstamp_counter()
 -> stmmac_update_subsecond_increment() -> stmmac_config_addend() -> -ETIME=
DOUT
 -> stmmac_init_systime() -> -ETIMEDOUT

I guess we should understand which one is failing and why it is failing.

Regards,
Lorenzo

>=20
> I suspect that this has something to do with the error codes being
> discarded in your patch/some particular quirk of this hardware where it
> doesn't support these PTP related bits.
>=20
> I've CC'ed the linux-riscv list, in case anyone here is more familiar
> with this particular board and knows why this is happening.
>=20
> Regards
> Anirudh Srinivasan

--p7q6TE+CPzeC67kd
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCasQcQAAKCRA6cBh0uS2t
rFnAAQDcxY180c8JdzZhXUdZiy4mLTHzGsUdBEmqQNWb/IZ3RAD9EiDEtq7DZiW6
fsK9fLcyL82F5PdP0FH5ODJSMtdl0QU=
=KEwD
-----END PGP SIGNATURE-----

--p7q6TE+CPzeC67kd--
