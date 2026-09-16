Received: from mail-qv2-f12.google.com (mail-qv2-f12.google.com [74.125.230.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4461944781E
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 07:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789545506; cv=pass; b=J2SiabdTldLIRZvlzg/ti839aaQng84KhbKjY6GklBjVx8EeIz/BMK499oy30RMcZgQd5ObfguWo4mnetMxAxEXHK8c0IB6eXEYlNEbZhB750xJ9d4aicA+UGosCgPr8ViMuqIp7KYsB64OSh/CGAiA+2LpdE6EEtfyOGAfjcv4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789545506; c=relaxed/simple;
	bh=svRabBI6UvEUHfQROC2aHOHZq1v1cZekXErBpB21yyI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oj2qxouR9PttO6+wU1Td75Vvyc01/eMFOaTA6Fqg6UNn4mpue6h02eTf8eLUlTNsO9RVnXVpV6nR3Fglg7kGlwi70IIBYSOjXUmIDB42YVjST+eTLFebAdqjzd214MiMBBt1Vq7bYm1YWQZ/Fj0vn3MOSGhF2WmxFF3J1/rKVAk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aNT4XKqZ; arc=pass smtp.client-ip=74.125.230.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aNT4XKqZ"
Received: by mail-qv2-f12.google.com with SMTP id 6a1803df08f44-90cdfbd3208so5953126d6.2
        for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 00:58:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789545497; cv=none;
        d=google.com; s=arc-20260327;
        b=KlIOH/BHzNga8+n1DCM4s3A0XcijN5Jn6J+38zQSjhJOq7A21RNMvxHWTw/FJFisPS
         MO065tgGsJHlh4qv7/XDodhPBJwRFTRXzzOgiOIm4bZLslK+uwXWSt1Dio/DATd2VL+k
         6E/FCmxKmfq86E3fMgcBjOuGcohaD+fZqnBy5AR4epvFdttivy35RcJyGH9gg6KalrXq
         43ptWML0cLNHXBAyBo8xRR1mzGGmm33rw7VNkQ3i7GOYyCGeMedaYo0vek0ARLataEZA
         ZlT+BxehQ16QCbHh++ado5kQWTH8e8b6swVs65iy9HTYP6MY185TomvCCu2a9hfToESd
         RMrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=uIu1t/2657EaB+VrCIFp6sfHSKgjEaSX/eWEjXMGplk=;
        fh=LBfSfT+onrh26b1gMDzEWwGb4Wg7xtBpBKUezdmlgCc=;
        b=KWIllSF5G/uHnvqsd9hASkHAvFVKExttd/RxQaPef3CNu3Je5ymqnhZ2XuPry8HFoA
         5GQ425fUsw6yPkzMWrJOf5GDSKpmX1iTDTORuil6+yq6nOvUZxaOi0ahMkErRHpFm4hd
         UvTxfiR8UFbrDgc6SQKfs1G1/bNli7dqssvQcBSizQ+BA3/Qbu/4XbNw2J/r4G97SppV
         SLoG6jL2jpEutk0Mm2aS3CO+CVT2jZzP8FnTGS+Jg+LUcxOeItVBetf9MLDW228B+L4h
         zAf/MKeDZuqcydNBmBbHsjfdY7bPpZAzEfWrxClYIO/Lm7N70TLVCnGbYkh5JjjtUJED
         neDg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789545497; x=1790150297; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=uIu1t/2657EaB+VrCIFp6sfHSKgjEaSX/eWEjXMGplk=;
        b=aNT4XKqZB0K9qo2J3S3i27iKOsie7t3M3yXNoO0rVXkCChBtTPpOInN7KaEdRN+GS/
         Kq7VpsfXGOfPEmJ67gO0EhnuLMv6LB4+CFebT6s7LdIO4CH7+zwbIMlMM9F4hi+jC1Sf
         8Q5PHW6UYoSRiqTiP4FQ3u5x9jZfOd2KkJ8e6oXG4fAKs2FU3BU+ldQYNPXPx6D0gkiY
         u6IqN8AJUNWVfC5peZHsl1VYE0cBcGCB7yyW/0Si5jl9LWvjz3LE7f9SFDXbkmQ3sNLm
         jD/+lRVN+0AjPzzf8AcN8b2U8823en92uTZYoUe8IUXBZKonL5SYSuhGbcd3HTwIIICo
         4Aqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789545497; x=1790150297;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uIu1t/2657EaB+VrCIFp6sfHSKgjEaSX/eWEjXMGplk=;
        b=UmsdYEm0kYdMwzTdWfpflvwuPStf0ik6Jt1wn3ND64DAp6nMWh+stsEn+Ama7wXlyq
         yAv+RCFgAM9YcWrodq44XvWMUJI/eUtisoWL6xvZdCbOrDo4ch2l3YdjQ3AkeP6SkTRE
         2xSRLP+NMjOy+G6jeZBcc5YKP7HL84NOFuUlyj6t6/8Zbkb0KI4Cqa8eE4c5RLIkRILr
         2jrISwUGYCO7O2Cqn3KFMGvcLqjXfkwHeew08t3Tnq3btI98fDBQQKhTK/+wO4n+E1pF
         OIwf8QoEwW/8oKNyzGz31u34Uwx6Py1fHeSqvbFvig5DnvUqdv9CcUmBylFBsSCQetez
         4hcQ==
X-Forwarded-Encrypted: i=1; AKwUvBzqmLNSXMNOuQEc9aUyFFIYhIJ1VzBIg6dkpI3U9krbrTW+tLgw0Pcm7hhk7hSXAczz6CB0cQ0=@vger.kernel.org
X-Gm-Message-State: AFuF++liYzZfF+JTrlXNJmNZm0iC28HM7yZxKAja+UmzqYBll8iSTxei
	9HpWVDF+THJfL7nXbw0M83TzBysaCN6lrigCCwebsL98xDOX5GDEc4rEC+NJmyU9ZrIHiDZlBxq
	jXyTuVcWOSeSZAh4xPpR0/y8c2jnRL84=
X-Gm-Gg: AYBFou0vu+m2LTop+p0tOjCFcKMNz718UfkKDRCBqeCFHKbGyB6J/Yhd7Mo0Ui5jz+r
	qf/whwCyzi02jTfD7aqIZR0DUhEAFyahADp7XgAQLnDBh+FajcN0sr5MRkZRjZRTcyQaSP9gauN
	zCYw1bk6ggVA5Wc4i/gNaO/8emIwrnA4o342dO5J495KlgIc93EOEVhp/dUw02j3Dt0c/0apV2Y
	8Gn0AXF1IeqhurKlSRz+BvZxGRf7VyBvFHuTLKOvf9qzJJP3+7H22hgMGTxnp67cZMwmZJuOmhI
	5nIkeDGEyiO9ASiHcXbBmF2JyWvn9VfZmifZ9ESsZJkaUfIqjXVZo89XO8ftXGnPfQ==
X-Received: by 2002:a05:6214:5012:b0:910:39f5:3747 with SMTP id
 6a1803df08f44-9123d723fbfmr31420176d6.2.1789545497533; Wed, 16 Sep 2026
 00:58:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260910081020.86227-2-zxyan0222@gmail.com> <20260915014931.873912-2-kuba@kernel.org>
In-Reply-To: <20260915014931.873912-2-kuba@kernel.org>
From: zhu xin <zxyan0222@gmail.com>
Date: Wed, 16 Sep 2026 15:58:05 +0800
X-Gm-Features: AcwNN1XVGxCGbHGoiSEmykI50OQOFMqMRNNP8SCOpWGmQIGcYGxB4Ix5qBxjtfk
Message-ID: <CAP7veT+QX9ytS3umMg8HOafpoYYyQz43oBwOLZ5Xmorv+JuvpA@mail.gmail.com>
Subject: Re: [PATCH net-next v5 1/2] net: stmmac: dwmac-socfpga: complete
 cross-timestamp on ATSNS
To: Jakub Kicinski <kuba@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	pabeni@redhat.com, mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com, 
	richardcochran@gmail.com, maxime.chevallier@bootlin.com, 
	muhammad.nazim.amirul.nazle.asmade@altera.com, rohan.g.thomas@altera.com, 
	netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 15, 2026 at 9:49=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> ---
> net: stmmac: dwmac-socfpga: complete cross-timestamp on ATSNS
>
> This changes the Agilex5 smtg_crosststamp() handler so that it waits for
> the PTP_ACR_ATSFC FIFO clear to finish, then polls the ATSNS count in
> XGMAC_TIMESTAMP_STATUS instead of the transient TSIS bit in
> XGMAC_INT_STATUS.  The snapshot count used for the FIFO pop loop is now
> taken from the value the poll read back rather than from a fresh register
> read.
>
> A few questions below.
>
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c b/driv=
ers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
> > index 1d7f0a57d2889..ee6f28637878a 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
> > +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
> > @@ -340,6 +340,18 @@ static int smtg_crosststamp(ktime_t *device, struc=
t system_counterval_t *system,
> >       /* Release the mutex */
> >       mutex_unlock(&priv->aux_ts_lock);
> >
> > +     /* Wait for the FIFO clear to complete so a stale ATSNS count fro=
m
> > +      * a previous snapshot cannot satisfy the poll below before the n=
ew
> > +      * snapshot is latched.
> > +      */
> > +     ret =3D readl_poll_timeout(ptpaddr + PTP_ACR, acr_value,
> > +                              !(acr_value & PTP_ACR_ATSFC), 10, 10000)=
;
> > +     if (ret) {
> > +             netdev_err(priv->dev, "%s: Failed to clear snapshot FIFO\=
n",
> > +                        __func__);
> > +             return ret;
> > +     }
> > +
> >       /* Trigger Internal snapshot signal. Create a rising edge by just=
 toggle
> >        * the GPO0 to low and back to high.
> >        */
> > @@ -349,9 +361,17 @@ static int smtg_crosststamp(ktime_t *device, struc=
t system_counterval_t *system,
> >       gpio_value |=3D XGMAC_GPIO_GPO0;
> >       writel(gpio_value, ioaddr + XGMAC_GPIO_STATUS);
> >
> > -     /* Poll for time sync operation done */
> > -     ret =3D readl_poll_timeout(priv->ioaddr + XGMAC_INT_STATUS, v,
> > -                              (v & XGMAC_INT_TSIS), 100, 10000);
> > +     /* Wait for the auxiliary snapshot to be latched.  TSIS is a
> > +      * transient status bit that is set by any MAC timestamp event an=
d
> > +      * cleared by reading XGMAC_TIMESTAMP_STATUS, so it is not a
> > +      * reliable completion condition.  Poll the persistent ATSNS coun=
t
> > +      * instead: it is cleared only by setting PTP_ACR_ATSFC, so
> > +      * nothing can clear it while we wait, and it reflects exactly th=
e
> > +      * snapshot latched by this trigger.
> > +      */
>
> [Severity: Low]
> Is the "cleared only by setting PTP_ACR_ATSFC" part of this comment (and
> the matching "ATSNS is cleared only when the FIFO clear bit
> (PTP_ACR_ATSFC) is set" in the commit message) accurate?
>
> ATSNS is the auxiliary snapshot FIFO fill level, and popping the FIFO
> decrements it.  get_ptptime() in stmmac_hwtstamp.c does the pop:
>
>         ns =3D readl(ptpaddr + PTP_ATNR);
>         ns +=3D (u64)readl(ptpaddr + PTP_ATSR) * NSEC_PER_SEC;
>
> That is also why both timestamp_interrupt() and the loop just below in
> smtg_crosststamp() iterate exactly num_snapshot times:
>
>         /* Repeat until the timestamps are from the FIFO last segment */
>         for (i =3D 0; i < num_snapshot; i++) {
>                 read_lock_irqsave(&priv->ptp_lock, flags);
>                 stmmac_get_ptptime(priv, ptpaddr, &ptp_time);
>
> Would it be more precise to say only that ATSNS is not cleared by reading
> XGMAC_TIMESTAMP_STATUS, rather than that nothing can clear it while the
> poll runs?
>
> > +     ret =3D readl_poll_timeout(ioaddr + XGMAC_TIMESTAMP_STATUS, v,
> > +                              FIELD_GET(XGMAC_TIMESTAMP_ATSNS_MASK, v)=
,
> > +                              100, 10000);
> >       if (ret) {
> >               netdev_err(priv->dev, "%s: Wait for time sync operation t=
imeout\n",
> >                          __func__);
> > @@ -364,8 +384,7 @@ static int smtg_crosststamp(ktime_t *device, struct=
 system_counterval_t *system,
> >               .use_nsecs =3D false,
> >       };
> >
> > -     num_snapshot =3D FIELD_GET(XGMAC_TIMESTAMP_ATSNS_MASK,
> > -                              readl(ioaddr + XGMAC_TIMESTAMP_STATUS));
> > +     num_snapshot =3D FIELD_GET(XGMAC_TIMESTAMP_ATSNS_MASK, v);
> >
> >       /* Repeat until the timestamps are from the FIFO last segment */
> >       for (i =3D 0; i < num_snapshot; i++) {
>
Agreed, the wording was wrong: ATSNS is the aux snapshot FIFO level,
so popping the FIFO via get_ptptime() decrements it as well.
v6 rewords the comment and the commit message accordingly.

> [Severity: Medium]
> Can this reuse of the polled value hand a fabricated timestamp back to
> userspace?
>
> Everything from the ATSFC-clear wait through the GPO0 trigger, the ATSNS
> poll and this pop loop runs after aux_ts_lock has been dropped:
>
>         /* Release the mutex */
>         mutex_unlock(&priv->aux_ts_lock);
>
> The STMMAC_FLAG_EXT_SNAPSHOT_EN test at the top of smtg_crosststamp():
>
>         if (priv->plat->flags & STMMAC_FLAG_EXT_SNAPSHOT_EN)
>                 return -EBUSY;
>
> is done without that mutex, while stmmac_enable() in stmmac_ptp.c sets th=
e
> flag and writes PTP_ACR under it:
>
>         priv->plat->flags |=3D STMMAC_FLAG_EXT_SNAPSHOT_EN;
>
>         /* Enable External snapshot trigger */
>         acr_value |=3D PTP_ACR_ATSEN(rq->extts.index);
>         acr_value |=3D PTP_ACR_ATSFC;
>
> The PTP core does not serialize the callback either:
>
> drivers/ptp/ptp_chardev.c:ptp_ioctl() {
>         ...
>         case PTP_SYS_OFFSET_PRECISE:
>         case PTP_SYS_OFFSET_PRECISE2:
>                 return ptp_sys_offset_precise(ptp, argptr,
>                                               ptp->info->getcrosststamp);
>         ...
> }
>
> So after the poll observes ATSNS =3D N, a PTP_CLK_REQ_EXTTS enable or a
> second concurrent smtg_crosststamp() can set PTP_ACR_ATSFC and flush the
> FIFO, or drain it itself.  The loop then still runs N iterations against =
an
> empty FIFO, sets *device from whatever those reads return, and returns 0.
>
> Note the read_lock_irqsave(&priv->ptp_lock, flags) inside the loop is a
> reader lock, so two concurrent drains can interleave pops of the same
> FIFO.
>
> Before this patch the count was re-read immediately before the loop, so t=
he
> same race produced num_snapshot =3D=3D 0 and a skipped loop, i.e. a detec=
table
> failure rather than a stale value.  Given that, does the commit message
> claim hold?
>
>         "derive the count for the FIFO pop loop from the value the poll r=
ead
>         back so it is guaranteed non-zero on the success path"
>
> Would holding aux_ts_lock (or another writer-exclusive lock) across the
> ATSFC wait, the trigger, the poll and the drain, and re-checking the coun=
t
> at drain time, be needed to make that guarantee real?

Agreed.  v6 drops the "guaranteed non-zero" claim and instead holds
aux_ts_lock across the whole sequence: the ATSFC clear wait, the GPO0
trigger, the ATSNS poll and the drain loop all run under the mutex,
and it is only released on the way out.

v6 will be posted shortly.

Best regards,
Zxyan
