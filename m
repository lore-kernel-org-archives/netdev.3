Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 352393E558C
	for <netdev@vger.kernel.org>; Tue,  6 Oct 2026 14:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791297194; cv=none; b=h/oZF2EDBOLLEd2S/gt60XZEFhzFVwge/r7RpuLFG+UUwW1RyCVOv2uulDz/U1ErxoFv+/iIIFsj4286szUdFWDFeLcw2kQn2lDhhDw7udBkiaD5U5vBzgyYwVQ7SiiJ5qWzzZ10vu0EZ9n5Voxd5sYd0khXugYPyM1dkshDOps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791297194; c=relaxed/simple;
	bh=y4Ko5fembKGgtg0YRPGaYrsl0T1PQufBr1UaaBIBy7k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ge+0NppkEWh/CZiP/Tbnl0bhXHhiS0+Yxi5dIQGzgFvWII3Yd2OObdD4hZwlQSJxerOiaBzbM/Ep2nXZKJsArrLwoFNbxxyapb6GBmmDMlpQ5WE8ezf4hTlctqOZ5qtZw91xJqltBBOekn28bdqH6VmfZCDoCl2kp9l1T4nWcLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IWriEdRh; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=gIDxPrRL; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IWriEdRh";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gIDxPrRL"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 696EAvii053548
	for <netdev@vger.kernel.org>; Tue, 6 Oct 2026 14:33:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=dwpyPsnmPPkVa/yP5kcpaqW3
	Q1SBP+pZeLwP1dVZabo=; b=IWriEdRh39rHY7p1hhtRxbqDd01KEH081nPJB4A4
	xXUmZrixe5vjX20pP2Z+v4GhRaMrlDiyQsYKaKQ3i+G7XXPLYhd73j6baEb80vKv
	uHGQyn/R7M28jkPMncyOYxryqUF8aV367lZusPyZViJSDJIw6XApkvhQTp0R6kgP
	GCmnDZzCoilfAWSPxeQKbpHHc+ktHzHeptxx2B1fG9wEWsd8hmnYMtYw+v1TnauV
	cZ2+EIMvuFR3VsXVim37xbabn7gHktVfC9T+VoNt1HXb+7WnhlYn9/3xwTu3y/sV
	6lmPDPeQBiFcjQunXIp+10Uaj56U2kl0epKLFGH5niMgAw==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com [209.85.217.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h4fkumbkk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 06 Oct 2026 14:33:11 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id ada2fe7eead31-7bf71bbf197so2621620137.2
        for <netdev@vger.kernel.org>; Tue, 06 Oct 2026 07:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791297191; x=1791901991; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dwpyPsnmPPkVa/yP5kcpaqW3Q1SBP+pZeLwP1dVZabo=;
        b=gIDxPrRLFAfHPsMbHwy1JkG6ne4fCaqTFh5bwmAlPphYBbip9nznWW1Rn8/0UW1gon
         JAnTN8g3aFMmD2/GEwQ53DfrZvemH0rBB8bQIfz0WrFrNYte28SK8kQqE5PR1a3+2rpW
         CesLEn9xf9PmhIB9oOiWQ1b9KSM1EdNDWnSHH9+t4xEa/oz79/D0y1mH2nCaf+fxWCjF
         ZBfaJIDbY1Zqb6hfac3typjW8pWlIcWMrvF1BAdRQ0iB94QHlkrLne9zCttKzIptUxRq
         b4PfYtJIMn9l3A73FxQ3S0/Z0Uw5VsJPzrqoSTc8uDlwqnoLWu78HmMBHuoGq3ag7Elc
         0B8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791297191; x=1791901991;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dwpyPsnmPPkVa/yP5kcpaqW3Q1SBP+pZeLwP1dVZabo=;
        b=sCrOyP9+nCvQ8be6EQevzS8Rfflc+vDRpi8va5GudHRSPvIl3HH8/Ub0Cg+lRk2gZO
         zxmMMlP0VSaRMxW2IcIeIA6DfMgKjIYzCR8M7D9re7kRmgd2O4AI711ErHFuhVmyTaIy
         C7MTrNQdL1YoDWi4lZe3rhii0OeE7gWmJIVp4NCg8B1VXRooCveRvKmTeYKivVz+Bsus
         YI0QdKMwSbA3E5TE3sFZhMcwln5rhPnh0ZgKUSPGwjLOtFmalvDSBgoEmx6kqOebGcP1
         /5J8FKRBFhZkuvMYxiseTYS532/eqPKkvHT0QqdhNibt4HcXRTA8NDtTR8LgZwn/cWZD
         j4ug==
X-Forwarded-Encrypted: i=1; AKwUvBwZE46fmVnZ4uLfx8IKjMxNcig9Se9vdf248FYCaDfbhslbyzNzTgEu9DQT7h3raPPv759yybo=@vger.kernel.org
X-Gm-Message-State: AFq9FYLoK9R8/CxIEnr8391NUzBfA74X/53sDshD46Elx/6T0GYcBu+s
	YVzN35iW8PtGnL0niDdz8P7Pg6IX//4rIXvS5LnV+F4iKPNqGEgfrDzuz69Ya2MXRMMBdWsOkk8
	30XVG5ygQVlkQhHyAfyQv47kFt0af9GQ1taZMFZ4wFtDcabQzF3KP7ByizGs=
X-Gm-Gg: AYBFou2Xj21BdtN8W7YUCYjfY20VWnU6xVpQ62kj34JR0ZtCBnufkPdZseMYI41IQYP
	9twynAUl4PQrjP5rSyMo86+rjvQ9MFyRzNUddCMHkfTPTacbmwLV808ZMGb0WcNVQAUqalatnsY
	38cETIkg72ObgKdr7akqEgfvRo7sScx7FZXpbZa3nRrBxAnMdp3bpDFTwBG/104XoE83PUuU9FI
	1hAn/sq71KJ8EDudVvb1Vg1VoCXMioRosUy5P2OFz/ybGnd1neKbYfduro+UYNIedvUBPai73Sw
	7QDji6u+GiGcZ2cZjIzxzVDm5FxI6hq/Qjlr2M1kcPzTkw5dmTYcCo9POYn9VU72aeMguyjg9AY
	ctcjyLYy1nMQduQ==
X-Received: by 2002:a05:6102:390e:b0:7be:3606:2248 with SMTP id ada2fe7eead31-7c87c802aedmr557204137.34.1791297190897;
        Tue, 06 Oct 2026 07:33:10 -0700 (PDT)
X-Received: by 2002:a05:6102:390e:b0:7be:3606:2248 with SMTP id ada2fe7eead31-7c87c802aedmr557146137.34.1791297189508;
        Tue, 06 Oct 2026 07:33:09 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48c622d282esm10051964f8f.33.2026.10.06.07.33.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 07:33:08 -0700 (PDT)
Date: Tue, 6 Oct 2026 16:33:07 +0200
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
Message-ID: <asUGoxyJWVcsYBWG@lore-desk>
References: <20260929-stmmac-ptp-added-systime-error-v3-1-ddd6afe936b4@oss.qualcomm.com>
 <dy5xfj3754wnp3gh2kpoyf3vpx3vfsfhblgbwbwsgts27xqxga@dzb33gt3zgca>
 <asQcQIh56MV1OJur@lore-desk>
 <CAEev2e8+fr1tJnSErD+2TtLDw5fGJbQOMcM5eefMnLyFUR+m7w@mail.gmail.com>
 <asSb3RNcityVg6ia@lore-desk>
 <CAEev2e8c6hZQQom6NV-URgdSoWiafCcRR3BtA6yxxqy7T-me8g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vsD1I/wWF+wv5J+3"
Content-Disposition: inline
In-Reply-To: <CAEev2e8c6hZQQom6NV-URgdSoWiafCcRR3BtA6yxxqy7T-me8g@mail.gmail.com>
X-Authority-Analysis: v=2.4 cv=HtPjiETS c=1 sm=1 tr=0 ts=6ac506a8 cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=Khk5uQurOxoZPgiQn0kA:9 a=QEXdDO2ut3YA:10
 a=oLeseYo1r3XBFyQ01TcA:9 a=crWF4MFLhNY0qMRaF8an:22
X-Proofpoint-GUID: FcC1ddAZKCPx-Uo7Ex7Jh42WfBjrlWm6
X-Proofpoint-ORIG-GUID: FcC1ddAZKCPx-Uo7Ex7Jh42WfBjrlWm6
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA2MDA1NyBTYWx0ZWRfX90D6wRow0MyN
 mYsQ6IwOE0xToqyc/E24ups3gbyfv5zjPbwvANCRgQWueqxDix891PO3gItjMqhIXhH26NSAa4p
 CzOvZmsFR5bvHy6KLASpCCsV4O+hevw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA2MDA1NyBTYWx0ZWRfX6uMd54t5gG2Q
 mX77fxn+dbQ5+4dxY/2LHU/uqoDnMyoO6NeFrH0rcCcFzhK1y8E2Uw1YDvuXtKRN3MF7HKEOom1
 vBXggIMuQKXjIZnyy8E3YNXK+pZW+5aeBMoqzWUPpg7d8dRYeWHuJthMeuPQrcxuS4ewG0Q/eP2
 NnfxpB90dFYqOUY1Os4QWoLnQN683f/O6l0xf9UV86PXMJaf4Q+MG1itbaSoJzUlG1rEqUxi/3Y
 6ZgGA2TwrmSAoNAAT3uiC3iTGpWxzBFZj2pvg3KZV4aPj72i1dz3LV2nz8viV5Jc2R86vDFM1I8
 x+ccpojdU6OKUIeAQitAixLgjc287PdyE/L59KCodH2mTLw6h5uzxXpd7fchWXTXqpTpjrc2aDC
 vWBLvOX53kUrlM7Z09KNxJ1cGQzUbv3dfb1+SqG8qvDbDjWASpTa7w8jPnOn2jXhyZpgrFOweJv
 a7Hal4bA941G69mhuXQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-06_04,2026-10-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 malwarescore=0 clxscore=1015 phishscore=0
 spamscore=0 priorityscore=1501 bulkscore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610060057

--vsD1I/wWF+wv5J+3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Oct 06, Anirudh Srinivasan wrote:
> Hi Lorenzo,
>=20
> On Tue, Oct 6, 2026 at 1:57=E2=80=AFAM Lorenzo Bianconi
> <lorenzo.bianconi@oss.qualcomm.com> wrote:
> >
> > > Hi Lorenzo,
> > >
> > > On Mon, Oct 5, 2026 at 4:53=E2=80=AFPM Lorenzo Bianconi
> > > <lorenzo.bianconi@oss.qualcomm.com> wrote:
> > > >
> > > > > On Tue, Sep 29, 2026 at 03:10:11PM +0200, Lorenzo Bianconi wrote:
> > > > > > stmmac_update_subsecond_increment() ignores the error returned =
by
> > > > > > stmmac_config_addend(), and stmmac_init_tstamp_counter() discar=
ds the
> > > > > > addend and system time programming errors, always returning suc=
cess. A
> > > > > > failure to program the addend (PTP_TCR_TSADDREG) or to initiali=
ze the
> > > > > > system time counter (PTP_TCR_TSINIT) is therefore silently swal=
lowed,
> > > > > > leaving the hardware timestamp counter in a non-running or part=
ially
> > > > > > configured state while the driver keeps operating as if timesta=
mping
> > > > > > were up. This matters for TAPRIO/EST offloading, which derives =
the gate
> > > > > > base time from the hardware timestamp counter.
> > > > > >
> > > > > > The same hooks are also called from the PHC callbacks: settime6=
4 and
> > > > > > adjfine drop the error and report success to clock_settime() and
> > > > > > clock_adjtime(), so a dead PTP reference clock goes unnoticed by
> > > > > > ptp4l/phc2sys.
> > > > > >
> > > > > > Return error codes from stmmac_update_subsecond_increment(),
> > > > > > stmmac_init_tstamp_counter(), stmmac_dl_ts_coarse_set() and the
> > > > > > settime64/adjfine callbacks instead of silently returning succe=
ss. On
> > > > > > failure, roll back the partially applied configuration so the h=
ardware
> > > > > > and the driver bookkeeping stay consistent, and report the reas=
on
> > > > > > through the devlink extack. Also guard against a zero sub-second
> > > > > > increment, which would otherwise divide by zero when computing =
the
> > > > > > addend.
> > > > > >
> > > > > > Reset the persistent timestamping state (hwts_tx_en, hwts_rx_en,
> > > > > > tstamp_config, systime_flags and tsfupdt_coarse) when (re)initi=
alizing
> > > > > > timestamping, so a failed init does not leave TX/RX timestamping
> > > > > > enabled on a counter that never started.
> > > > > >
> > > > > > Fixes: cc4c9001ce31 ("net: stmmac: Switch stmmac_hwtimestamp to=
 generic HW Interface Helpers")
> > > > > > Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.=
com>
> > > > > > ---
> > > > > > Changes in v3:
> > > > > > - Do not run stmmac_config_addend() in
> > > > > >   stmmac_update_subsecond_increment() error path.
> > > > > > - Return error from stmmac_adjust_freq() and stmmac_set_time().
> > > > > > - Reset hw ts configuration in stmmac_init_timestamping().
> > > > > > - Link to v2: https://lore.kernel.org/r/20260924-stmmac-ptp-add=
ed-systime-error-v2-1-beb2a6b5f866@oss.qualcomm.com
> > > > > >
> > > > > > Changes in v2:
> > > > > > - Initialize sec_inc to 0 in stmmac_restore_subsecond_increment=
()
> > > > > >   routine.
> > > > > > - Link to v1: https://lore.kernel.org/r/20260920-stmmac-ptp-add=
ed-systime-error-v1-1-8ac9e7a3fce2@oss.qualcomm.com
> > > > > > ---
> > > > > >  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 106 ++++++=
++++++++++------
> > > > > >  drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c  |  10 +-
> > > > > >  2 files changed, 84 insertions(+), 32 deletions(-)
> > > > >
> > > > > Hello, I'm noticing that after this patch was merged into linux-n=
ext,
> > > > > boot seems to hang when ip=3Ddhcp is used because ethernet isn't =
working
> > > > > on the TH1520 Lichee Pi 4a. These lines get printed in a loop ove=
r and
> > > > > over
> > > > >
> > > > > IP-Config: end0 hardware address 72:ca:a8:eb:27:[   24.872982] th=
ead-dwmac ffe7070000.ethernet end0: Register MEM_TYPE_PAGE_POOL RxQ-0
> > > > > f2 mtu 1500 DHCP
> > > > > [   24.900412] thead-dwmac ffe7070000.ethernet end0: PHY [stmmac-=
0:01] driver [RTL8211F Gigabit Ethernet] (irq=3DPOLL)
> > > > > [   24.912780] dwmac1000: Master AXI performs any burst length
> > > > > [   24.912801] thead-dwmac ffe7070000.ethernet end0: No Safety Fe=
atures support found
> > > > > [   25.010229] thead-dwmac ffe7070000.ethernet end0: PTP init fai=
led
> > > > > SIOCSIFFLAGS: Connection timed out
> > > >
> > > > Hi Anirudh,
> > > >
> > > > based on the reported error, stmmac_init_tstamp_counter() fails with
> > > > -ETIMEDOUT. In particular this can occurs if:
> > > >
> > > > stmmac_init_tstamp_counter()
> > > >  -> stmmac_update_subsecond_increment() -> stmmac_config_addend() -=
> -ETIMEDOUT
> > > >  -> stmmac_init_systime() -> -ETIMEDOUT
> > > >
> > > > I guess we should understand which one is failing and why it is fai=
ling.
> > >
> > > It seems like both are timing out, both config_addend
> > > (PTP_TCR_TSADDREG) and init_systime (PTP_TCR_TSINIT).
> >
> > It seems hw timestamping has never worked on this board, it was just
> > undiscovered since stmmac_init_tstamp_counter() was not reporting any
> > error before (this is exactly the goal of this patch).
> >
> > What are the output for:
> > - IEEE 1588-2002 Time Stamp
> > - IEEE 1588-2008 Advanced Time Stamp
> >
> > root@rb3-gen2:~# grep 'Time Stamp' /sys/kernel/debug/stmmaceth/eth0/dma=
_cap
> > IEEE 1588-2002 Time Stamp: N
> > IEEE 1588-2008 Advanced Time Stamp: Y
>=20
> This is what I see
>=20
> root@debian-trixie-riscv64:/# grep 'Time Stamp'
> /sys/kernel/debug/stmmaceth/end0/dma_cap
> IEEE 1588-2002 Time Stamp: N
> IEEE 1588-2008 Advanced Time Stamp: Y

Unfortunately I do not have this board for debugging. The first idea
I got is maybe 100ms is too small for this SoC? Can you please try to
increase it to like 500ms?

Regards,
Lorenzo
=20

--vsD1I/wWF+wv5J+3
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCasUGowAKCRA6cBh0uS2t
rEqIAQD7DDlqWNVBPDIEAFYspmZfjvl0guPYJxd27F+u9+vZNAEAp3QY2fc2UJEX
9JJNT60hpgKxLeuzm+DCJ0ZdtVJbggs=
=6W7J
-----END PGP SIGNATURE-----

--vsD1I/wWF+wv5J+3--
