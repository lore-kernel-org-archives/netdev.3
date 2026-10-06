Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB32D38423D
	for <netdev@vger.kernel.org>; Tue,  6 Oct 2026 14:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791295579; cv=pass; b=E6HuYUUM7f71ArTYO5gudL5Q3eTzuAwJQ8KoDUstnybCaFe8rNeR/H4cIyKvYGutmK3W1BsrTEJb1p3nWalI0omgmP6tWkrGXn1mPGOgFTv9NL5dH/1pclH3Nxy86mBHC9CxC6T60od0YLsO/pglpdj0MB6rsmuJvLjpp0t5GDk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791295579; c=relaxed/simple;
	bh=g16CZzUVbLwMDZ6NdRKo9moeVnecLhhEkbVXsli4nFc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DiYf/TM9opDAo3Zt8SS7+HOn+tTk9Ei8+oRQ87AsSYx5Dt+zNPqQSqwSmjBqWWO6Si4/hVVjmLuZ1HAGD73dmEZvQvHZewskiv6/rQr+VtMQ25MqiPf5+1skWwQOMgtRtJ8L/FIqD1+hMOYhVxj6SzDZ1HKYo2FFVcCeN5TF0tw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.tenstorrent.com; spf=pass smtp.mailfrom=tenstorrent.com; dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b=I57P3xy1; arc=pass smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.tenstorrent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tenstorrent.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b="I57P3xy1"
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-66c9995ca60so940331d50.1
        for <netdev@vger.kernel.org>; Tue, 06 Oct 2026 07:06:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791295576; cv=none;
        d=google.com; s=arc-20260327;
        b=ZHxnDbl+oQnrWqu5VIoMTgUVl3B5JnSimERe0Y9oLwlav9l6ncY0fj/jmQMfhLXOUj
         cQPKJQeu5TwnmjASUe/4Zxu/gtXVdTBCgl6Skya1y+rQQ2p8FFBRg2aQI1V1BXrFREyu
         DMnOD/+CyXvpKSAT4AXddqiMf4g0/N/3czvwH8UVe5/wTR8HEQ4J8ndIBFI3MwYsldBy
         V8ohxSurHNRD5Gr1CbMf4tv4bb3Xvu8H6eZd6AWJ3mE54ALjNtRuPZ1PqGwsSrbxoIEF
         kyifI/TVN/COrJXbJv43gBh97OdT+5z8lG/bxX0OjupCdpy0J98hwL0d7ty4B5fcoIF5
         /Iuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7eTRhpUdAPhibVitSf9ugYG/3fmwl3lSEUIJCeeRHDY=;
        fh=ktXSFf0yiUutOrwHm7jx2jK2F4Qf6p49aeBbI8DiTh8=;
        b=O3BOyM6fSwwxLcEcRLHd1ez4PPsOYlGM6KFwAv08OLZl176BQrFqi+h116cM9Cdfnb
         WC7cFcdtnOd96vXTIisVKKcbfs4iGswhkMdx4bJQlA/JQbF1dcBWf0syjgyfiA922ofR
         D36G87d3wSTjc7xuLlFjSqUIkSXpHA6FemBDlBrkdsI+oDf5PsXYs9aLfdRLdKJaQBy/
         9RwFsp4v5WrIh2fWorIsFxpmn3N8Wly8qr9sSKiUNquUaoFwHnp87GcIiASAslcNjxiv
         4B6QdBE8Y07z79nLeEDwcAfGMsE/SnhzxE/PteGYs2ixY1pOiYnqskKNHbnGtvoylb8r
         HNPw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tenstorrent.com; s=google; t=1791295576; x=1791900376; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7eTRhpUdAPhibVitSf9ugYG/3fmwl3lSEUIJCeeRHDY=;
        b=I57P3xy1yR4USE6qFSCPAAi1zk12w98CuBhI2ilfnaldEAkx5MTEZRdc0gc0o7kGpq
         a9NUq0ka72CJjMJ9VA1LVQ3X2E8eM/TeWrx7Os4tJAak8RwF4mc+nlDtNTMKT3xqtVy2
         CSrZ8h4bm3OmmzC+0FHFBMy7LpDCAczmJ8fGpG9k7X3isn1YY6exTyr/EeOH1RmHs+Ya
         OYfP4ebhaPGvGs3QgBTYdr2oKttLw0ED2nYnjjb3mUKP2q6Rc57az3sA4D3S99mxhDcl
         vaHzPu+7vRd5KGjIipZx0/5Jk2MOgAeS8ceW706d0B0e3V2NbnVrUBKdRYT7YGUvvtFq
         wiNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791295576; x=1791900376;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7eTRhpUdAPhibVitSf9ugYG/3fmwl3lSEUIJCeeRHDY=;
        b=wbkfPeY+ohor2PsxYKVg2tljShzjWqyLO+kub7tc/RF8jLXHIIUgLUDpW3tJNUbS3i
         kEIvBNv1TLcIafnbruumIM0BiGJaiQl2yQELr079jV2JTh82KNFJLXUz/R0d0kA7BrmE
         f0MwJHOFBqhv46aTBdINfyD6FlmKIkLp7XMldWRHMu1EsZ+rNkZP2cfvsvDR0XTbP8/o
         Pt2T1JM0Q4oocJPzAt8s3sqNkfwU9uotXn8wX1AhKTpLp0cb0EMfcr2a/NnZdXIa0F/o
         M7H4Gsat1uCFJ0I8aKg3SzM+Oarl+/wbmdJZNdsrtJQDXsjUK6gSu9gl2vR5wFrzL6AH
         xEOg==
X-Forwarded-Encrypted: i=1; AKwUvBzO0bJsKLeSVpYAmAdbWTn3f1aWYvtFJX2af4h/Ujsbtm6ynBBZJTiQKdwnFe7vRiuaqneDh4M=@vger.kernel.org
X-Gm-Message-State: AFq9FYLz+puWa1DF6hDb9pO3nrCNth072fPPQ3rSTJWW4Swzfop1jwYl
	G8+D/9q5wm8rAXZUnGZysT3fVg5onfcP4w6OxvC2osLxH4KedD3fXPbHiqLxPApmNLxaHWnP/rk
	YkNx6sGDnOEWu3eKAxy34sOO+Gb6c2sRIG0NkC2jevQ==
X-Gm-Gg: AYBFou2PWAv2f6JmnwTVXDAuMEFMlHCIiagZvAsQMetYmaQIScOrP3ipAbkSDTa8Kfu
	IxLRYO4KUphWBIjlFo/G0LEZGyeSC69ChP7BoI4w1HQp80x6SBYi5XNDn/rzhF20lKw03M6BBhU
	MlSifKgiHyQSAAvcc3fpw9w1UnglmUE0z7X+07E+fzkQGlpO2hKoXa0UfnzvJ7j5NWclhnvmROp
	k1mqEsNlSP+SwfTpWDUkcJ5o0JceOtq+IpJqYi+NH1QWaLlq+RzjvHWMCGkPt5xNiX5LSC09jw/
	QjDA/ctKrs3p7N28zbqp4vCsrCycIoVWnrqMAuHJ/c6gasC85NgU7P8PgAKsBjptDrWY8jnc0jA
	dMe8L4407gLc=
X-Received: by 2002:a05:690e:bc5:b0:66f:c1bc:4045 with SMTP id
 956f58d0204a3-678fcec34d3mr595987d50.38.1791295575798; Tue, 06 Oct 2026
 07:06:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260929-stmmac-ptp-added-systime-error-v3-1-ddd6afe936b4@oss.qualcomm.com>
 <dy5xfj3754wnp3gh2kpoyf3vpx3vfsfhblgbwbwsgts27xqxga@dzb33gt3zgca>
 <asQcQIh56MV1OJur@lore-desk> <CAEev2e8+fr1tJnSErD+2TtLDw5fGJbQOMcM5eefMnLyFUR+m7w@mail.gmail.com>
 <asSb3RNcityVg6ia@lore-desk>
In-Reply-To: <asSb3RNcityVg6ia@lore-desk>
From: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
Date: Tue, 6 Oct 2026 09:06:03 -0500
X-Gm-Features: AclHuK8FBU2I3CZudI7_swPmDfZGR4Ssa4TCnIVoMwFoQK6fIquDhT8Z6kXaqsg
Message-ID: <CAEev2e8c6hZQQom6NV-URgdSoWiafCcRR3BtA6yxxqy7T-me8g@mail.gmail.com>
Subject: Re: [PATCH net v3] net: stmmac: propagate PTP addend and system time
 programming errors
To: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Richard Cochran <richardcochran@gmail.com>, Jose Abreu <Jose.Abreu@synopsys.com>, 
	netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, Drew Fustini <fustini@kernel.org>, 
	Jisheng Zhang <jszhang@kernel.org>, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Lorenzo,

On Tue, Oct 6, 2026 at 1:57=E2=80=AFAM Lorenzo Bianconi
<lorenzo.bianconi@oss.qualcomm.com> wrote:
>
> > Hi Lorenzo,
> >
> > On Mon, Oct 5, 2026 at 4:53=E2=80=AFPM Lorenzo Bianconi
> > <lorenzo.bianconi@oss.qualcomm.com> wrote:
> > >
> > > > On Tue, Sep 29, 2026 at 03:10:11PM +0200, Lorenzo Bianconi wrote:
> > > > > stmmac_update_subsecond_increment() ignores the error returned by
> > > > > stmmac_config_addend(), and stmmac_init_tstamp_counter() discards=
 the
> > > > > addend and system time programming errors, always returning succe=
ss. A
> > > > > failure to program the addend (PTP_TCR_TSADDREG) or to initialize=
 the
> > > > > system time counter (PTP_TCR_TSINIT) is therefore silently swallo=
wed,
> > > > > leaving the hardware timestamp counter in a non-running or partia=
lly
> > > > > configured state while the driver keeps operating as if timestamp=
ing
> > > > > were up. This matters for TAPRIO/EST offloading, which derives th=
e gate
> > > > > base time from the hardware timestamp counter.
> > > > >
> > > > > The same hooks are also called from the PHC callbacks: settime64 =
and
> > > > > adjfine drop the error and report success to clock_settime() and
> > > > > clock_adjtime(), so a dead PTP reference clock goes unnoticed by
> > > > > ptp4l/phc2sys.
> > > > >
> > > > > Return error codes from stmmac_update_subsecond_increment(),
> > > > > stmmac_init_tstamp_counter(), stmmac_dl_ts_coarse_set() and the
> > > > > settime64/adjfine callbacks instead of silently returning success=
. On
> > > > > failure, roll back the partially applied configuration so the har=
dware
> > > > > and the driver bookkeeping stay consistent, and report the reason
> > > > > through the devlink extack. Also guard against a zero sub-second
> > > > > increment, which would otherwise divide by zero when computing th=
e
> > > > > addend.
> > > > >
> > > > > Reset the persistent timestamping state (hwts_tx_en, hwts_rx_en,
> > > > > tstamp_config, systime_flags and tsfupdt_coarse) when (re)initial=
izing
> > > > > timestamping, so a failed init does not leave TX/RX timestamping
> > > > > enabled on a counter that never started.
> > > > >
> > > > > Fixes: cc4c9001ce31 ("net: stmmac: Switch stmmac_hwtimestamp to g=
eneric HW Interface Helpers")
> > > > > Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.co=
m>
> > > > > ---
> > > > > Changes in v3:
> > > > > - Do not run stmmac_config_addend() in
> > > > >   stmmac_update_subsecond_increment() error path.
> > > > > - Return error from stmmac_adjust_freq() and stmmac_set_time().
> > > > > - Reset hw ts configuration in stmmac_init_timestamping().
> > > > > - Link to v2: https://lore.kernel.org/r/20260924-stmmac-ptp-added=
-systime-error-v2-1-beb2a6b5f866@oss.qualcomm.com
> > > > >
> > > > > Changes in v2:
> > > > > - Initialize sec_inc to 0 in stmmac_restore_subsecond_increment()
> > > > >   routine.
> > > > > - Link to v1: https://lore.kernel.org/r/20260920-stmmac-ptp-added=
-systime-error-v1-1-8ac9e7a3fce2@oss.qualcomm.com
> > > > > ---
> > > > >  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 106 ++++++++=
++++++++------
> > > > >  drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c  |  10 +-
> > > > >  2 files changed, 84 insertions(+), 32 deletions(-)
> > > >
> > > > Hello, I'm noticing that after this patch was merged into linux-nex=
t,
> > > > boot seems to hang when ip=3Ddhcp is used because ethernet isn't wo=
rking
> > > > on the TH1520 Lichee Pi 4a. These lines get printed in a loop over =
and
> > > > over
> > > >
> > > > IP-Config: end0 hardware address 72:ca:a8:eb:27:[   24.872982] thea=
d-dwmac ffe7070000.ethernet end0: Register MEM_TYPE_PAGE_POOL RxQ-0
> > > > f2 mtu 1500 DHCP
> > > > [   24.900412] thead-dwmac ffe7070000.ethernet end0: PHY [stmmac-0:=
01] driver [RTL8211F Gigabit Ethernet] (irq=3DPOLL)
> > > > [   24.912780] dwmac1000: Master AXI performs any burst length
> > > > [   24.912801] thead-dwmac ffe7070000.ethernet end0: No Safety Feat=
ures support found
> > > > [   25.010229] thead-dwmac ffe7070000.ethernet end0: PTP init faile=
d
> > > > SIOCSIFFLAGS: Connection timed out
> > >
> > > Hi Anirudh,
> > >
> > > based on the reported error, stmmac_init_tstamp_counter() fails with
> > > -ETIMEDOUT. In particular this can occurs if:
> > >
> > > stmmac_init_tstamp_counter()
> > >  -> stmmac_update_subsecond_increment() -> stmmac_config_addend() -> =
-ETIMEDOUT
> > >  -> stmmac_init_systime() -> -ETIMEDOUT
> > >
> > > I guess we should understand which one is failing and why it is faili=
ng.
> >
> > It seems like both are timing out, both config_addend
> > (PTP_TCR_TSADDREG) and init_systime (PTP_TCR_TSINIT).
>
> It seems hw timestamping has never worked on this board, it was just
> undiscovered since stmmac_init_tstamp_counter() was not reporting any
> error before (this is exactly the goal of this patch).
>
> What are the output for:
> - IEEE 1588-2002 Time Stamp
> - IEEE 1588-2008 Advanced Time Stamp
>
> root@rb3-gen2:~# grep 'Time Stamp' /sys/kernel/debug/stmmaceth/eth0/dma_c=
ap
> IEEE 1588-2002 Time Stamp: N
> IEEE 1588-2008 Advanced Time Stamp: Y

This is what I see

root@debian-trixie-riscv64:/# grep 'Time Stamp'
/sys/kernel/debug/stmmaceth/end0/dma_cap
IEEE 1588-2002 Time Stamp: N
IEEE 1588-2008 Advanced Time Stamp: Y
