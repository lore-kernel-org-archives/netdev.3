Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D2A54F052E
	for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 12:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791982195; cv=pass; b=Br46bJJeJhDjBD9d/dHGhKmu98rQrof/UB43swQlyhN3ZXXEMqOq1c4/TlrHetzTt4WoG7wrFFpbuHDbtbnmgTSN4sOqRDFcI/K5ctjK0hOH1eVlvrBgDusYvmg+NpQsjOyutwz9lRjs2oGwBcYQ6C6lH8mrW1ezzdQYhIncQZo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791982195; c=relaxed/simple;
	bh=IZ9udLZ8mKwkA9hOW2ysBBLxwdxCnM2/zSGJI/8e7aM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FYJcRbfAciXdLUrXg7NY4aUQ6ualO2WkkNU8eumiHhxKuyGqURkg9CBvBz5J2eoFi2dRvFHZFq86ivjW4c44ZH1vC8YkYk4uIxaOr4hF8jXsk8L8Vvgv96+pSFoiSSumPUuIVW4gG/tlDzvw6tYQGNDYL9GT4guCtDPfNHGLIpI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UMvGZzS9; arc=pass smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UMvGZzS9"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-918f75a68f0so66492186d6.1
        for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 05:49:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791982166; cv=none;
        d=google.com; s=arc-20260327;
        b=ZZW9mQDArIjXupTS9hl2+9l3Pr9qE6qh+dK/nn7LI+utCIzui+6PW2XOFsf3Zzcy7O
         mB6EDx08ajBPPd+hUadUEtP+pFOPIABEGv4xa1UyUya4XUZ/V5KD5OHZMbcTCt9byBGs
         B83EFmKTwly1NkVpbHQ46WJCg5xIPjcgTC/HX6mCGmR2OsIG1e/LiU8MKmXjaXvgACXH
         /o21mVHrsmLcswvsvS+5mGVQUGFp5KsQ9oSDbGTS9QaZeBeT8GIkL/7+KMaYQvKptywU
         Cenl1yyB6j8FOCZ8zHq2KVSrxP1MHi0lXIqHiTKWMBGjvmdUURLg0U1HTerhsR8semFJ
         o3nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tPbZXRRAUxUX9o7GeMQdJWsdAmSHTI7hSTaU+xQ7YBQ=;
        fh=sUI4CSNB1PRlv5JmvbE29GQ8Oz7HYPa2IW5svVv0/JA=;
        b=KnFk55w8Z6+FzMmJME3nfNncWGukV6KQ3rViFHkvgv6F6J1XC5hQ7OzAJ+wc0FIeQ5
         XtQcUMm61qN4PQbxVCnxIauCcmMm9JgPk2kbdCTrisS1ozMdlLY3+JuuMNmy/Bzc+m6V
         hiRV/QKa+5ABaa89Koais9snyFH5OQwmlOvoxYYaTeVQy9WOrGPmd3wczn8nPmi7hJhK
         GXD8mJODJUS4jOB1efEvVno+7AmZeRrtqNuAYkNSlxO/fxtdxtK7Fmn45AmckXIv9DOl
         TrqAoA/me8+0zezUlF2lFdPltcEMQ/mwLFM4tULmSdi6Xh5XB/wqtbysayw7Kd7gBjrj
         rdLg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791982166; x=1792586966; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=tPbZXRRAUxUX9o7GeMQdJWsdAmSHTI7hSTaU+xQ7YBQ=;
        b=UMvGZzS9mkwo7NWflQjblzQ2DrO5lExg8pVK95w+lOZkVOa0atVv+P8qDxl6CfNVw5
         mMmmz3pPXtWSS2O5HAvv+GgOt+iu0WbRNzELVr5rtpq7mPUeVmIYjvlt8gorv/27ma7m
         UYk8qLKB9dy7eE4GqAEhml0ebhwxlTrflZqSJ+X5DcEXM1R3/Uquf+QgKtVk8ANt9M+E
         AOA77FTC8asHQuv92MOgqsX63F1f79nYaZxMWp3Uovzf7f+/qavpm694HN+FqGaWyN7t
         JzsQxSHPmyeOZJulpMSd0FW5ibBI9YmGjz0l19ZGbDB82/dWBTFtTMP7bHCq+mhyLbPY
         1x+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791982166; x=1792586966;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tPbZXRRAUxUX9o7GeMQdJWsdAmSHTI7hSTaU+xQ7YBQ=;
        b=T9KtJzL9fJKOTumrwXXGNhlBCULEOwFVq6N2M9/YF0nwj9RXDtSpigGASRm5MUeez0
         evx4lgfyQNoaqHOh7Y79Iao7TzBNKqCIF8g22/c4hH3d6GO1MN31NA1+G9jd/SKwj76+
         F801v1YxFHCXoMYKDTDg1g6eDjqEDu1s8ixenoNY46vMFM5vyklILDKjkbqXsy+RNg1e
         u4K3uGwuzA2rpHrLCFXFowAbhbJClUU0e5Ukiu8ArOyoUN5+gtfNkUtD9HrzBwSxvHfi
         89x20G68G38ak1OBQ6HvvwisjhsQfSnOu6+29rhApemRxkVTewCKu/gHM1cKeLn5J5OB
         NwkQ==
X-Forwarded-Encrypted: i=1; AKwUvByuAWtRQxUW/vkY4xud8oN0WUom+PsPRVoZGByFci5jkqFwIsd8wEgAHfTcwgQ3gcCqKdRyF7U=@vger.kernel.org
X-Gm-Message-State: AFq9FYKAj9k1RkNBVJP1wLW2UDtELOTlZb+DCa8XzdTGVlhYirvdAtmt
	6L9ty8xBTyFD3T99j4NY0Mi6sezyvrg4aX/erJPP/lfXbLai9xKETrdQtBUZS6TlZVDHEzk+2rX
	qynDSScFgANtHASuzH5lTOCwed6ZRFm1GKyjPEqs=
X-Gm-Gg: AYBFou3FSyx4EumpUabUET5Y/W59zPiaEKljkysMVm3Cr6/DptDTMaylAYRfT5wwD1m
	GAVsVPHZRM4e2XEitIAxEtkKZWad9a7mHTWBC9Cn5mWGX/PgGwiC9fOT53uHbhB7kOkWLWtlCmw
	0wUtZ2q6M5G9ZYTOhZRvJDDfGLwXfGnCMYGKEmwPQE3FzWH07elqSiO9NVsyOOpENCz/hr15Mdv
	GzUsKzpmj1ULb5yq7GvRZLs67AoFIqu4/yD+MgeEn9gIyZrNirkN3IzkReUMPPs7BKTgzZqGhIM
	9T93jUdiVZtz1QPTBdEQ/gAv3IKed2ZbkBC1g9cPVnNCpPjj1lprkgQ=
X-Received: by 2002:a05:6214:410a:b0:91b:50f2:19 with SMTP id
 6a1803df08f44-91b55500fafmr253190856d6.27.1791982165875; Wed, 14 Oct 2026
 05:49:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261013033207.1684328-4-zxyan0222@gmail.com> <179195062971.434549.3907170504821168391@kernel.org>
In-Reply-To: <179195062971.434549.3907170504821168391@kernel.org>
From: zhu xin <zxyan0222@gmail.com>
Date: Wed, 14 Oct 2026 20:49:14 +0800
X-Gm-Features: AclHuK8qhpcxlM73roMHGevYw3SXsYzC0julmGtC_jghy21jeFP5jd9UKD2s614
Message-ID: <CAP7veTK6NQtrweDVXsYyiMuru_Svtir5XvY_ATM8a6GWO=cqKw@mail.gmail.com>
Subject: Re: [PATCH net-next v8 3/3] net: stmmac: dwxgmac2: add XGMAC
 timestamp interrupt support
To: netdev-bot+sashiko@kernel.org
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org, 
	kuba@kernel.org, pabeni@redhat.com, maxime.chevallier@bootlin.com, 
	mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com, 
	richardcochran@gmail.com, muhammad.nazim.amirul.nazle.asmade@altera.com, 
	rohan.g.thomas@altera.com, netdev@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Thanks for the review.

On Wed, Oct 14, 2026 at 12:03=E2=80=AFPM <netdev-bot+sashiko@kernel.org> wr=
ote:
>
> Thank you for your contribution! Sashiko AI review found 5 potential
> issue(s) to consider.
>
> Critical: 0 =C2=B7 High: 0 =C2=B7 Medium: 5 =C2=B7 Low: 0
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwor=
k
> know by including "pw-bot: cr" as a separate line at the end of your repl=
y
> (one such reply per series is enough).
>
> - [Medium] The commit message says dwxgmac2_timestamp_interrupt() cannot
>   race a FIFO flush because "PTP_ACR_ATSFC is only ever set while=E2=80=
=A6

Valid and will be fixed in the respin.

> - [Medium] In stmmac_enable(PTP_CLK_REQ_EXTTS), the 'already enabled'
>   -EBUSY check is dead.

Valid and will be fixed in the respin.

> - [Medium] smtg_crosststamp() (dwmac-socfpga) tests
>   STMMAC_FLAG_EXT_SNAPSHOT_EN before mutex_lock(&priv->aux_ts_lock), and=
=E2=80=A6

Valid and will be fixed in the respin.

> - [Medium] Two handler instances can drain the auxiliary timestamp FIFO
>   at the same time.

we would like to keep this as-is, for three reasons.

First, the hardware does not have two parallel lines for the
timestamp events: per the DWC_xgmac databook the timestamp
interrupt (TSIS) is only asserted on the common sbd_intr_o /
mci_intr_o line, while the separate pmt_intr_o output exists for
power-down mode, so the application clock can be stopped while
the MAC stays wakeable; its clear even crosses clock domains.
The concurrent-drain window therefore only arises from a
platform integration choice: wiring pmt_intr_o to its own GIC
line and describing it as "eth_wake_irq".

Second, the in-tree XGMAC platforms make that choice nowhere:
the dwxgmac users (Agilex5 etc.) list only "macirq" and the
per-queue lines, so the driver's fallback in
stmmac_platform.c assigns wol_irq =3D dev->irq, the second
request_irq() is skipped, and the handler is registered exactly
once.  The platforms that do wire a separate eth_wake_irq
(imx8mp, renesas r9a09, stm32mp13 ...) are GMAC4/EQOS designs
where the existing dwmac4 timestamp handler has the same
exposure and has never been serialized; this is a pre-existing
driver-wide property, not something this series introduces.

Third, fixing it properly (a single serviced line or an
in-handler lock for the timestamp path) affects every stmmac
handler and would be a series of its own; we would rather not
grow this one with it.

> - [Medium] The commit message says TSIS is a read-to-clear bit that the
>   TX timestamp completion path clears.

Correct and the consequence is a delay, not a lost event: reading
XGMAC_TIMESTAMP_STATUS does not affect the ATSNS count or the
FIFO contents, so the snapshots stay queued and are reported by
the next handler entry on any MAC interrupt (in single-IRQ mode
any DMA interrupt reaches it as well).  The handler deliberately
does not gate on TSIS for exactly this reason: TSIS is an
aggregate, read-to-clear bit that the TX timestamp completion
path (which polls the same register for TXTSC from NAPI) clears
before the handler can observe it.  A dwmac4-style TSIS gate
would turn this delay into a silent event drop, which is why
the commit message documents the trade-off.  The one-shot
"delayed indefinitely" scenario needs a completely quiet MAC
(no TX completion, no LPI, no PMT, no error interrupts) while an
EXTTS edge arrives; and if more events keep arriving the FIFO
level is reported by ATSNS, so nothing is overwritten silently.
We consider the residual delay acceptable for a one-shot input
relative to the alternative of dropping events.

>
> --
>
> net: stmmac: dwxgmac2: add XGMAC timestamp interrupt support
>
> This adds a DWXGMAC2 timestamp interrupt handler that drains the
> auxiliary snapshot FIFO and reports the entries as PTP_CLOCK_EXTTS
> events. XGMAC_TSIE is armed on demand from the EXTTS enable path through
> a new timestamp_interrupt_cfg() callback. The suspend/resume,
> unregister and socfpga cross-timestamp paths are updated to coordinate
> FIFO ownership under aux_ts_lock.
>
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c b/driv=
ers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
> > index ee79b74bf21b6..93c1092237fc6 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
> > +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
> > @@ -311,6 +311,18 @@ static int smtg_crosststamp(ktime_t *device, struc=
t system_counterval_t *system,
> >               return -EBUSY;
> >
> >       mutex_lock(&priv->aux_ts_lock);
> > +     /* Refuse to arm once the clock has been invalidated by
> > +      * unregister.
> > +      */
> > +     if (!priv->ptp_clock) {
> > +             mutex_unlock(&priv->aux_ts_lock);
> > +             return -ENODEV;
> > +     }
> > +     priv->plat->flags |=3D STMMAC_FLAG_INT_SNAPSHOT_EN;
>
> [Severity: Medium]
> The STMMAC_FLAG_EXT_SNAPSHOT_EN test that guards smtg_crosststamp() still
> runs before aux_ts_lock is taken. Under the lock, only ptp_clock is
> rechecked:
>
>     if (priv->plat->flags & STMMAC_FLAG_EXT_SNAPSHOT_EN)
>         return -EBUSY;
>
>     mutex_lock(&priv->aux_ts_lock);
>
> getcrosststamp doesn't take pincfg_mux. Can a concurrent
> PTP_EXTTS_REQUEST run its whole locked section inside that window?
>
> CPU1 (PTP_SYS_OFFSET_PRECISE)    CPU2 (PTP_EXTTS_REQUEST, on=3D1)
> smtg_crosststamp()
>   EXT_SNAPSHOT_EN not set
>                                  stmmac_enable()
>                                    sets EXT_SNAPSHOT_EN
>                                    writes ATSEN(index) | ATSFC
>                                    arms XGMAC_TSIE
>   mutex_lock(&priv->aux_ts_lock)
>   acr_value &=3D ~PTP_ACR_MASK;
>   sets ATSEN(int_snapshot_num)
>   ...
>   flags &=3D ~STMMAC_FLAG_INT_SNAPSHOT_EN
>
> Would that leave EXT_SNAPSHOT_EN set, TSIE armed and ext_snapshot_num
> naming the user's channel, while PTP_ACR enables only the internal
> snapshot channel?
>
> If so, the user's EXTTS channel would produce no more events, and every
> later smtg_crosststamp() would return -EBUSY. dwxgmac2_timestamp_interrup=
t()
> takes the reported index from the live PTP_ACR, so any events delivered
> in that state would carry the internal channel index. On resume,
> stmmac_rearm_timestamp_irq() would also program ext_snapshot_num, which
> no longer matches the hardware state.
>
> Could the EXT_SNAPSHOT_EN check move under aux_ts_lock, next to the new
> ptp_clock check?
>
> [ ... ]
>
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c b/driv=
ers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
> > index 1a88cbaed70ca..3b98cd82ec2d7 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
> > +++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
>
> [ ... ]
>
> > @@ -1154,6 +1160,59 @@ static int dwxgmac2_get_mac_tx_timestamp(struct =
mac_device_info *hw, u64 *ts)
> >       return 0;
> >  }
> >
> > +void dwxgmac2_timestamp_interrupt(struct stmmac_priv *priv)
> > +{
>
> [ ... ]
>
> > +     /* Reading XGMAC_TIMESTAMP_STATUS clears TSIS, so use the ATSNS
> > +      * count to see the pending snapshots.
> > +      */
> > +     ts_status =3D readl(priv->ioaddr + XGMAC_TIMESTAMP_STATUS);
>
> [Severity: Medium]
> The commit message says TSIS is read-to-clear and that the TX timestamp
> completion path clears it. On XGMAC that path runs for every TX
> timestamp. dwxgmac2_get_tx_timestamp_status() always returns 0, so
> stmmac_get_tx_hwtstamp() always falls back to
> dwxgmac2_get_mac_tx_timestamp(), which polls the same register from
> NAPI:
>
>     if (readl_poll_timeout_atomic(ioaddr + XGMAC_TIMESTAMP_STATUS,
>                                   value, value & XGMAC_TXTSC, 100, 10000)=
)
>
> Suppose that read lands after an auxiliary snapshot sets TSIS (with
> TSIE armed) but before the CPU takes the MAC interrupt. Can a
> level-triggered MAC IRQ then be deasserted, so the handler never runs
> for that snapshot?
>
> dwxgmac2_timestamp_interrupt() is the only consumer of the aux FIFO, and
> its only caller is stmmac_common_interrupt(). Skipping the TSIS gate
> only helps once the handler is already running.
>
> Would the snapshot then stay in the FIFO until an unrelated MAC
> interrupt arrives, or in single-IRQ mode the next DMA interrupt? In
> multi-MSI mode only MAC interrupts reach this handler. For a one-shot
> input the event could then be delayed indefinitely, or lost to FIFO
> overflow.
>
> > +
> > +     if (!(priv->plat->flags & STMMAC_FLAG_EXT_SNAPSHOT_EN) || !priv->=
ptp_clock)
> > +             return;
> > +
> > +     pending_snapshots =3D FIELD_GET(XGMAC_TIMESTAMP_ATSNS_MASK, ts_st=
atus);
> > +     if (!pending_snapshots)
> > +             return;
> > +
> > +     acr_value =3D readl(priv->ptpaddr + PTP_ACR);
> > +     /* Entries observed while the FIFO is being flushed are stale. */
> > +     if (acr_value & PTP_ACR_ATSFC)
> > +             return;
> > +     channel =3D FIELD_GET(PTP_ACR_MASK, acr_value);
> > +     if (!channel)
> > +             return;
> > +     channel =3D ilog2(channel);
> > +
> > +     for (i =3D 0; i < pending_snapshots; i++) {
> > +             read_lock_irqsave(&priv->ptp_lock, flags);
> > +             stmmac_get_ptptime(priv, priv->ptpaddr, &ptp_time);
> > +             read_unlock_irqrestore(&priv->ptp_lock, flags);
>
> [Severity: Medium]
> Can two instances of this loop drain the FIFO at the same time?
> stmmac_request_irq_single() registers stmmac_interrupt() on dev->irq and
> also on a separate wake line:
>
>     if (priv->wol_irq > 0 && priv->wol_irq !=3D dev->irq) {
>         ret =3D request_irq(priv->wol_irq, stmmac_interrupt,
>                           IRQF_SHARED, dev->name, dev);
>
> Both lines reach this handler through stmmac_common_interrupt(). The
> handler deliberately doesn't gate on TSIS, so two CPUs servicing the two
> lines could both read the same ATSNS=3DN and both loop N times.
>
> read_lock_irqsave() on ptp_lock admits both readers at once. Also,
> get_ptptime() consumes each entry with two separate reads:
>
>     ns =3D readl(ptpaddr + PTP_ATNR);
>     ns +=3D (u64)readl(ptpaddr + PTP_ATSR) * NSEC_PER_SEC;
>
> Would that pop 2N entries for N snapshots? Could one reported EXTTS
> timestamp combine the nanosecond and second halves of different entries?
>
> > +
> > +             event.type =3D PTP_CLOCK_EXTTS;
> > +             event.index =3D channel;
> > +             event.timestamp =3D ptp_time;
> > +             ptp_clock_event(priv->ptp_clock, &event);
> > +     }
> > +}
>
> [ ... ]
>
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c b/drivers=
/net/ethernet/stmicro/stmmac/stmmac_ptp.c
> > index 3bfcc9760dce7..f41988f5927ad 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
> > +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
>
> [ ... ]
>
> > @@ -239,22 +246,49 @@ static int stmmac_enable(struct ptp_clock_info *p=
tp,
> >                               return -EBUSY;
> >                       }
> >
> > +                     if (rq->extts.index >=3D PTP_ACR_ATSEN_NUM) {
> > +                             mutex_unlock(&priv->aux_ts_lock);
> > +                             return -EINVAL;
> > +                     }
> > +
> >                       priv->plat->flags |=3D STMMAC_FLAG_EXT_SNAPSHOT_E=
N;
> > +                     priv->plat->ext_snapshot_num =3D rq->extts.index;
> >
> >                       /* Enable External snapshot trigger */
> >                       acr_value |=3D PTP_ACR_ATSEN(rq->extts.index);
> >                       acr_value |=3D PTP_ACR_ATSFC;
> >               } else {
> >                       priv->plat->flags &=3D ~STMMAC_FLAG_EXT_SNAPSHOT_=
EN;
> > +                     priv->plat->ext_snapshot_num =3D -1;
> >               }
>
> [Severity: Medium]
> The "already enabled" check just above this hunk can never fire, because
> the mask is cleared before it is tested:
>
>     acr_value =3D readl(ptpaddr + PTP_ACR);
>     channel =3D ilog2(FIELD_GET(PTP_ACR_MASK, acr_value));
>     acr_value &=3D ~PTP_ACR_MASK;
>
>     if (on) {
>         if (FIELD_GET(PTP_ACR_MASK, acr_value)) {
>             ...
>             return -EBUSY;
>         }
>
> Before calling ops->enable(), ptp_extts_request() only checks
> req.extts.index >=3D ops->n_ext_ts. With the new single-slot
> ext_snapshot_num, what happens for the sequence enable(A), enable(B),
> disable(A)?
>
> enable(B) would clear ATSEN(A), set ATSEN(B) and overwrite
> ext_snapshot_num.
>
> disable(A) doesn't look at rq->extts.index. It clears EXT_SNAPSHOT_EN,
> sets ext_snapshot_num to -1, writes an empty ACR mask and disarms
> XGMAC_TSIE. That stops channel B while userspace still thinks it is
> enabled.
>
> The dead check predates this patch. However, the new ext_snapshot_num
> tracking, the resume rearm and the ATSFC/TSIE invariant in the commit
> message all assume only one channel is ever active.
>
> Should the busy test happen before the mask is cleared? And should the
> disable path check that rq->extts.index matches ext_snapshot_num?
>
> >               netdev_dbg(priv->dev, "Auxiliary Snapshot %d %s.\n",
> >                          rq->extts.index, on ? "enabled" : "disabled");
> >               writel(acr_value, ptpaddr + PTP_ACR);
> > -             mutex_unlock(&priv->aux_ts_lock);
> > -             /* wait for auxts fifo clear to finish */
> > +             /* Keep the lock across the FIFO clear so the arm below
> > +              * cannot interleave with a suspend.
> > +              */
> >               ret =3D readl_poll_timeout(ptpaddr + PTP_ACR, acr_value,
> >                                        !(acr_value & PTP_ACR_ATSFC),
> >                                        10, 10000);
>
> [ ... ]
>
> > +             /* Arm the timestamp interrupt only after the FIFO clear,
> > +              * so the handler cannot see a snapshot that is about to =
be
> > +              * discarded.
> > +              */
> > +             stmmac_mac_timestamp_interrupt_cfg(priv, on && !ret);
> > +             /* Drain an in-flight handler before the channel is freed=
. */
> > +             if (!on)
> > +                     stmmac_sync_timestamp_irq(priv);
> > +             mutex_unlock(&priv->aux_ts_lock);
>
> [Severity: Medium]
> The commit message says:
>
>   "PTP_ACR_ATSFC is only ever set while XGMAC_TSIE is disabled, so this
>   both keeps it off the FIFO on unrelated interrupts and stops it racing
>   a FIFO flush."
>
> Does that hold when a second PTP_CLK_REQ_EXTTS enable arrives while a
> channel is already enabled? This can come from the ioctl or from the
> extts_enable sysfs attribute.
>
> Because of the dead -EBUSY check above, the request gets through. The
> writel() above then sets ATSEN(new) | PTP_ACR_ATSFC while XGMAC_TSIE is
> still armed from the first enable. TSIE is not disarmed and
> stmmac_sync_timestamp_irq() is not called before the flush; the sync
> only happens for !on.
>
> dwxgmac2_timestamp_interrupt() runs on any MAC interrupt, or in
> single-IRQ mode any DMA interrupt. It shares no lock with this path, and
> it samples the FIFO level and the flush state at different times:
>
>     ts_status =3D readl(priv->ioaddr + XGMAC_TIMESTAMP_STATUS);
>     ...
>     acr_value =3D readl(priv->ptpaddr + PTP_ACR);
>     if (acr_value & PTP_ACR_ATSFC)
>         return;
>     ...
>     for (i =3D 0; i < pending_snapshots; i++) {
>         ...
>         stmmac_get_ptptime(priv, priv->ptpaddr, &ptp_time);
>
> If that PTP_ACR read happens before the ATSFC write, or after the
> self-clearing flush completes, ATSFC reads as 0.
>
> Could the handler then pop N entries from a FIFO that is being flushed
> or is already empty? It would report N stale or bogus PTP_CLOCK_EXTTS
> events, tagged with either the old or the new channel index.
>
> [ ... ]
>
> --
> Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#/patch=
set/20261013033207.1684328-1-zxyan0222%40gmail.com

pw-bot: cr
