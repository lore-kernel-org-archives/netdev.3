Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFBE63BB10E
	for <netdev@vger.kernel.org>; Tue,  6 Oct 2026 15:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791299550; cv=pass; b=HDMro6ueR6cF+WmhwJGZR5790lGholhQ06OH3gEPpdAQY0xeKR2LUC54/guXCYRwKAye/+p2SGgEevGCK3tTO0A8+x+IirqHwSgDqGz2PA0L/E4X/Z8S6dzIz9It/D2sHg3HAvA2Vl/qYbkSBTQbcZ/u9m6t6bbONo3GZMVnl7o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791299550; c=relaxed/simple;
	bh=C8Yds9gbuLzmPQa6hFceI6DVhk20rZC2n1YeQTNXGfQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sC+xeWd0YauLr+anpephYZA1spE3OayGlM39hlq8sPLPeX5UDd+t08e/ScrLZn/P5uSvU0fzbUjFnPiIsVjPlsZujQqZc3vprhBExRlNRx1gYpZdT/1QehJF+RIA5wOeSjlaZ3FCdCeUjNaKSRtWF+EFUVq1WprAcl+lYwc0MfA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.tenstorrent.com; spf=pass smtp.mailfrom=tenstorrent.com; dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b=QjqViDQw; arc=pass smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.tenstorrent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tenstorrent.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b="QjqViDQw"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-87ab6e5f91eso8089437b3.2
        for <netdev@vger.kernel.org>; Tue, 06 Oct 2026 08:12:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791299548; cv=none;
        d=google.com; s=arc-20260327;
        b=TGmgoMp3kNdvfStBZ/GoMz3OqmUf/KDqEhgI9ocyEi7lloJi3pFZ0BJb//je6A5oda
         oIdwZ/m/7KEFNihUCTIUjkE/kA31VQt9vJ675ovHsPuBOSltuM4tJ+x6+lhqdOS6M1BI
         LEcqD3kRApJYOOQWbDsWbBd7ct+SPVItnjW5apPGWKxhTfWjEUY/XM9QFNiCknpw2l14
         sV3jl1RqOGk1WYo9HsAHqhOD3jCP7OZz2Y8zEZGT4vB35wsFzHiA+ziVztyhHVMj55+g
         DiF+gylvd5SOhTgke566LKT+PP0JpC0kx4a+OSOAgwt6hEsQe4W8/dIirj27sgijyWE6
         tl8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mtMVlOhfl7dVywIUmoTG/iwD9ZKg/EsOsz1i8lgIOSU=;
        fh=T43C1OPPvstWnDBEvtcou4eKUGImbJe+ZUiqzkp2bYU=;
        b=ZdqQOMRZgkYvsjbn4UaDUiBebo31HVENhmjtbuYQIZ2C4JFIvkXbblSK7zCrkI0GHr
         wiMbWymjaeccNdK/z4Doh2Rki3IcCw6bSL513vtWSvLF4O6v2vlDE3lWagcKXW/o7HKa
         ZH8o5MKaHNd8jJuY+sbz3SAQXWAamMMvcKd7uHwQzUq43EhArU69cDK0Z/cPs0M7bXWo
         A5Jt2iseydZFbj2rohy/GYf1dbnLX3fjMj7Ylf4mODbxBKN9uyb78cGVB1XG9wHZzdhU
         qf6gZ7AewcK5vb1Agau360OL/Efptqr6izlfTWzYvh65drZLT9/fHYRapQ86dttWRhpP
         IHyg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tenstorrent.com; s=google; t=1791299548; x=1791904348; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mtMVlOhfl7dVywIUmoTG/iwD9ZKg/EsOsz1i8lgIOSU=;
        b=QjqViDQwtpLuj0JzyMFCucB6rdmyGf1wQLQ0RFFYHLi3Ejepw3DCSFYyColtfprR2n
         bVcMuzHzyTb3iPnogZMX4jYeX5rIBbONrXFd6vEbgoXOAuL2zvhmRJv/6xIhSwZGkRwf
         dQ/dNfPB38HqHqcERusfQ6RQuKTlly6EtATz+cJG7D203cNwBJEWAlNmhNzdSZahiBES
         2vyxp+V6TewRSJyuoGfK7aqivFTeOCin3Us1HCBlSJfc0EvX91/TbSkethLVjm+9g/sj
         6SIWTRtS5Ki/P4GdZJEcAFhKELcYHT/BuN8VseH2dTx7DVCFd3rcVXdLqv0Vh0xVCilH
         EYjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791299548; x=1791904348;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mtMVlOhfl7dVywIUmoTG/iwD9ZKg/EsOsz1i8lgIOSU=;
        b=teo41poWLICqsGCCtjgn8qEaxBIlFwaKNsAEcD96asFfL0YUUoNpEtoE8TWuVr0Bl7
         KaEkehvL9hTL6hNCfNOO4tlQld7d2Jv1izGE2LJJ3J16XyvH/2BEXissMKGycQ34Jnfy
         rZJg2PZ12Gqa6LoOkzz/MLEb44JNOH7iucEActGulXGcdVtrJq4QnqCRuVyjG4ttS2nj
         UrlLF371nXekLjluc3a6STcfa1Wx3ip5A5SWKJPOIiA5h+c5nMQOTogxS0jil4QWdHOs
         pcyEfcN0Fkr9CJ+u5Wd9Q4Y8yxa87td0IgBpWadBnQ6Eh0tLk7FX5au2JRH2jxlOh9KU
         YkEQ==
X-Forwarded-Encrypted: i=1; AKwUvBzwFHrs/TGDDb2N7eZQa5jR730jUqNPjoZMSXK4zDw6FreGwxYobr+jw7b90H+EteFWMULaUf8=@vger.kernel.org
X-Gm-Message-State: AFq9FYKT6aPzclOFw+ygCKL2UHHsPrfgdeLdJKT2fpjc+hlibS1qw258
	k+kIAQJvY4mnf03lZ1tVjHbGc0Odp2X0LFw0OcFQO0Oi17vJ1dKX5h0tIKUcpeL3fkIFV+SSzIp
	a/sPBzHt0kA/xUVNuJWgpCb+ncdbAKJveWDS0yvKpJA==
X-Gm-Gg: AYBFou0/LIDSrSiwQNsO97sK6x4GexmWOkggYYJiKwlqO7CjiU9rt/IEducZhL1KT7J
	B331s1F8SpAMWhOb6VYK7g6IgXu6UxiGhMVZPZ4Eo3RoywPD8XxHjIP9OzGyOcHBboWIj1leeIz
	ILqzzh5S08If3WO3y3JS0W2jQmd3Bf0puGDu6GIwL1H0YCKfqteAVW3X+hg1dxR0qep9cEpK3z+
	5ntBvcK8KF+lWArv0nxg2vEWitaJhKS6NK8gBCdzi6NvtB/qc7yhkGjuISWw/hRR5JPsOyYbZYl
	WB6nNuZQ/lUeRS4p3/FWX0Zb3d9kub09tfJsul32qdiWJAkOcFSudM952rnprKXxCHoXNZk4CMH
	eeejsu2m9aF82/AslqUG1
X-Received: by 2002:a05:690c:85:b0:883:768:7432 with SMTP id
 00721157ae682-8b04f441f91mr9459587b3.49.1791299547459; Tue, 06 Oct 2026
 08:12:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260929-stmmac-ptp-added-systime-error-v3-1-ddd6afe936b4@oss.qualcomm.com>
 <dy5xfj3754wnp3gh2kpoyf3vpx3vfsfhblgbwbwsgts27xqxga@dzb33gt3zgca>
 <asQcQIh56MV1OJur@lore-desk> <CAEev2e8+fr1tJnSErD+2TtLDw5fGJbQOMcM5eefMnLyFUR+m7w@mail.gmail.com>
 <asSb3RNcityVg6ia@lore-desk> <CAEev2e8c6hZQQom6NV-URgdSoWiafCcRR3BtA6yxxqy7T-me8g@mail.gmail.com>
 <asUGoxyJWVcsYBWG@lore-desk>
In-Reply-To: <asUGoxyJWVcsYBWG@lore-desk>
From: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
Date: Tue, 6 Oct 2026 10:12:16 -0500
X-Gm-Features: AclHuK-RCm43_jlNT_lFUhdrwLSuRNyZQs6NCda3layOtVwA4kmc3GhgcBuqpZ4
Message-ID: <CAEev2e_+Dcj60Rj2+_UD=3_kNQxLK4rmWTGK-dr-Ve9mGJBARg@mail.gmail.com>
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

Helo Lorenzo,

On Tue, Oct 6, 2026 at 9:33=E2=80=AFAM Lorenzo Bianconi
<lorenzo.bianconi@oss.qualcomm.com> wrote:
>
> On Oct 06, Anirudh Srinivasan wrote:
> > Hi Lorenzo,
> >
> > On Tue, Oct 6, 2026 at 1:57=E2=80=AFAM Lorenzo Bianconi
> > <lorenzo.bianconi@oss.qualcomm.com> wrote:
> > >
> > > > Hi Lorenzo,
> > > >
> > > > On Mon, Oct 5, 2026 at 4:53=E2=80=AFPM Lorenzo Bianconi
> > > > <lorenzo.bianconi@oss.qualcomm.com> wrote:
> > > > >
> > > > > > On Tue, Sep 29, 2026 at 03:10:11PM +0200, Lorenzo Bianconi wrot=
e:
> > > > > > > stmmac_update_subsecond_increment() ignores the error returne=
d by
> > > > > > > stmmac_config_addend(), and stmmac_init_tstamp_counter() disc=
ards the
> > > > > > > addend and system time programming errors, always returning s=
uccess. A
> > > > > > > failure to program the addend (PTP_TCR_TSADDREG) or to initia=
lize the
> > > > > > > system time counter (PTP_TCR_TSINIT) is therefore silently sw=
allowed,
> > > > > > > leaving the hardware timestamp counter in a non-running or pa=
rtially
> > > > > > > configured state while the driver keeps operating as if times=
tamping
> > > > > > > were up. This matters for TAPRIO/EST offloading, which derive=
s the gate
> > > > > > > base time from the hardware timestamp counter.
> > > > > > >
> > > > > > > The same hooks are also called from the PHC callbacks: settim=
e64 and
> > > > > > > adjfine drop the error and report success to clock_settime() =
and
> > > > > > > clock_adjtime(), so a dead PTP reference clock goes unnoticed=
 by
> > > > > > > ptp4l/phc2sys.
> > > > > > >
> > > > > > > Return error codes from stmmac_update_subsecond_increment(),
> > > > > > > stmmac_init_tstamp_counter(), stmmac_dl_ts_coarse_set() and t=
he
> > > > > > > settime64/adjfine callbacks instead of silently returning suc=
cess. On
> > > > > > > failure, roll back the partially applied configuration so the=
 hardware
> > > > > > > and the driver bookkeeping stay consistent, and report the re=
ason
> > > > > > > through the devlink extack. Also guard against a zero sub-sec=
ond
> > > > > > > increment, which would otherwise divide by zero when computin=
g the
> > > > > > > addend.
> > > > > > >
> > > > > > > Reset the persistent timestamping state (hwts_tx_en, hwts_rx_=
en,
> > > > > > > tstamp_config, systime_flags and tsfupdt_coarse) when (re)ini=
tializing
> > > > > > > timestamping, so a failed init does not leave TX/RX timestamp=
ing
> > > > > > > enabled on a counter that never started.
> > > > > > >
> > > > > > > Fixes: cc4c9001ce31 ("net: stmmac: Switch stmmac_hwtimestamp =
to generic HW Interface Helpers")
> > > > > > > Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcom=
m.com>
> > > > > > > ---
> > > > > > > Changes in v3:
> > > > > > > - Do not run stmmac_config_addend() in
> > > > > > >   stmmac_update_subsecond_increment() error path.
> > > > > > > - Return error from stmmac_adjust_freq() and stmmac_set_time(=
).
> > > > > > > - Reset hw ts configuration in stmmac_init_timestamping().
> > > > > > > - Link to v2: https://lore.kernel.org/r/20260924-stmmac-ptp-a=
dded-systime-error-v2-1-beb2a6b5f866@oss.qualcomm.com
> > > > > > >
> > > > > > > Changes in v2:
> > > > > > > - Initialize sec_inc to 0 in stmmac_restore_subsecond_increme=
nt()
> > > > > > >   routine.
> > > > > > > - Link to v1: https://lore.kernel.org/r/20260920-stmmac-ptp-a=
dded-systime-error-v1-1-8ac9e7a3fce2@oss.qualcomm.com
> > > > > > > ---
> > > > > > >  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 106 ++++=
++++++++++++------
> > > > > > >  drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c  |  10 +-
> > > > > > >  2 files changed, 84 insertions(+), 32 deletions(-)
> > > > > >
> > > > > > Hello, I'm noticing that after this patch was merged into linux=
-next,
> > > > > > boot seems to hang when ip=3Ddhcp is used because ethernet isn'=
t working
> > > > > > on the TH1520 Lichee Pi 4a. These lines get printed in a loop o=
ver and
> > > > > > over
> > > > > >
> > > > > > IP-Config: end0 hardware address 72:ca:a8:eb:27:[   24.872982] =
thead-dwmac ffe7070000.ethernet end0: Register MEM_TYPE_PAGE_POOL RxQ-0
> > > > > > f2 mtu 1500 DHCP
> > > > > > [   24.900412] thead-dwmac ffe7070000.ethernet end0: PHY [stmma=
c-0:01] driver [RTL8211F Gigabit Ethernet] (irq=3DPOLL)
> > > > > > [   24.912780] dwmac1000: Master AXI performs any burst length
> > > > > > [   24.912801] thead-dwmac ffe7070000.ethernet end0: No Safety =
Features support found
> > > > > > [   25.010229] thead-dwmac ffe7070000.ethernet end0: PTP init f=
ailed
> > > > > > SIOCSIFFLAGS: Connection timed out
> > > > >
> > > > > Hi Anirudh,
> > > > >
> > > > > based on the reported error, stmmac_init_tstamp_counter() fails w=
ith
> > > > > -ETIMEDOUT. In particular this can occurs if:
> > > > >
> > > > > stmmac_init_tstamp_counter()
> > > > >  -> stmmac_update_subsecond_increment() -> stmmac_config_addend()=
 -> -ETIMEDOUT
> > > > >  -> stmmac_init_systime() -> -ETIMEDOUT
> > > > >
> > > > > I guess we should understand which one is failing and why it is f=
ailing.
> > > >
> > > > It seems like both are timing out, both config_addend
> > > > (PTP_TCR_TSADDREG) and init_systime (PTP_TCR_TSINIT).
> > >
> > > It seems hw timestamping has never worked on this board, it was just
> > > undiscovered since stmmac_init_tstamp_counter() was not reporting any
> > > error before (this is exactly the goal of this patch).
> > >
> > > What are the output for:
> > > - IEEE 1588-2002 Time Stamp
> > > - IEEE 1588-2008 Advanced Time Stamp
> > >
> > > root@rb3-gen2:~# grep 'Time Stamp' /sys/kernel/debug/stmmaceth/eth0/d=
ma_cap
> > > IEEE 1588-2002 Time Stamp: N
> > > IEEE 1588-2008 Advanced Time Stamp: Y
> >
> > This is what I see
> >
> > root@debian-trixie-riscv64:/# grep 'Time Stamp'
> > /sys/kernel/debug/stmmaceth/end0/dma_cap
> > IEEE 1588-2002 Time Stamp: N
> > IEEE 1588-2008 Advanced Time Stamp: Y
>
> Unfortunately I do not have this board for debugging. The first idea
> I got is maybe 100ms is too small for this SoC? Can you please try to
> increase it to like 500ms?

That doesn't help either.

Maybe someone more familiar with this board/has used PTP on it before
can help out understanding why this is happening. Maybe this is some
issue to do with clocks.

Regards
Anirudh
