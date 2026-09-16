Received: from mail-qv2-f12.google.com (mail-qv2-f12.google.com [74.125.230.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C176E35C6B0
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 08:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789546553; cv=pass; b=lkFoUs6j0sJ/Tb8JnHQbR7lv3siWOVAqPPiBo0sif04koduVfQdivyLCY0WrrywfC/4oRM5frqe1zTmMcpLKf0x/l0nbn0Gm59j0tsNabAcpipiOeFriOIBohAye/io5VVg7f2vAfvI2fZmBmaCgkuH4XES0pyYj2RXX2Mhm6iw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789546553; c=relaxed/simple;
	bh=EwJzYHYCoTwtMcJHMHQ72Oe6ydGOnQaQvxjfUDrtD6Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b+QYDEpHTBb7dJH/luggGuUE13KLbpX869AVJWWd2UKvBCS2P7Sf7XOqGBoyh9KgOjfjEsh+WNkZXxM0WDQer6AHiiz6yimTga41kDqaNoUdceNAPe0i42j4RQOUrr39lNXjEwImvONJ1pHIGkV5LW6uAco8CsADn6aMQyLuYv8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a7SJQWhE; arc=pass smtp.client-ip=74.125.230.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a7SJQWhE"
Received: by mail-qv2-f12.google.com with SMTP id 6a1803df08f44-91058dd77a2so8224186d6.3
        for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 01:15:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789546539; cv=none;
        d=google.com; s=arc-20260327;
        b=CBUdfEeRmB5MeCZ4WqPnGRbkyeJyCgyHl7JnsasUWWdvPafYMWW5Er2huKPlEdJ55N
         utb4p2vzFDlevejtOFfQ23YkOCE91B7//mCQ1Uvy+quhaJL317AzTHtkDhoaDm6OV1WI
         jT8z/u9Q5U8WyTCnx1H3m3LpBG/xSkgoB5H0+HgE+LczHuc0HgcKhmLwdhItS0SxtKom
         ovyAO3PTIrESGlgUjNYxp1iepb99SutsedRObX8Oh7Xd3EZfgPPByDB/Aw+gsqcLSYQs
         W87WzQ84BTbI0/S35t6snNzBUFwGoDs9gyqzuG2QXrv7MaLU1uMi8QBRE0wE/YHCH/Sd
         UXOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rYaO8mDdbZtpV5GllGX6xyulfw7aU/1OfiKxAE3iAUs=;
        fh=r7ITdPjCLm56uSf4HxzZ6hTMApixhPbdQemvTO73/r4=;
        b=Sk3YEPuTV5d3tSiq8QMA2osalpF9jl14t/VUEN8w/kwodjX6ctce+HlxqvrFHR+sxi
         FOHEEadlxqQ8sxTzVpROEwUaB06n1M9MbAuzjXAA5wuBtCv/6xB7ClBMNg+9EQLVfbKk
         CPgZterH9L5Lv1qvv2kKnfQA54W/KHfJ1bs6Ilj7idMiMDZ9ESxT0dBGd5O8zFSvl1fP
         f7Ewrpfgd6akJyNtF4gHCGlsQ+r3XVUz0j9BUXjFVnO1NS0pu7N8Y8qcujNd+rOXUNc+
         8ZR5fOtlXHbcHSiQq6OY+KUrlXdDlfQM5oETNvGS8HOot/R/RcLmOUdmGGWtp6467L/6
         vg6g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789546539; x=1790151339; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rYaO8mDdbZtpV5GllGX6xyulfw7aU/1OfiKxAE3iAUs=;
        b=a7SJQWhE34h+DgDTNvm5PE1ctJzv9sGqHCBfg27FRqompC8Mn5UVKZEbcafnLXktek
         Fh9luOR6LibqjE6DNaemRzJgXJVIXaQ0QdfRv+AVpFFKEyo38hnhQmw/g2Q7XceULlVc
         VUe/T3Zsbvujr9nqn9qe69B7oqhUC3oJJxSMC3RkQhyzvUVL3roBLfhvH+YOO3PVEzRy
         6/CX247ZpbGHSaq3uiWZ7iyKEX7KQ92XRpZuEkkJNgOg2W7CtyLXlGiHTv8o3kjR9J/X
         6xjY2DN8VFxatCLbnFNITgwtgLJvWr6yF3Gth6/tP+zzQP/xvBFnveZF8e0+rDe/eJ/X
         u6EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789546539; x=1790151339;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rYaO8mDdbZtpV5GllGX6xyulfw7aU/1OfiKxAE3iAUs=;
        b=f/dkpxRQGcISrfjTv1rwly66HzeyygRBubxOap5fXpLS1hCdX8untEECBDVtDFbp5h
         Mq7R6XTEHfP+zbZ+GjUrl+MunpNC2MyC3h6kiixkTqEQ7Ihp9Cy+Tz1SIpWUZijmbf5D
         J3+a5tbZksOrz7UmOmsl2xONRA49gPffDJu7djIcqivsSSNow1NtbdwDqLDBpSwQY82Q
         X4KkS5NRwztJky4EUu72lh5ajWY6b62s7sEy3rrEP/w6/X5dCSeq7s0+pKb3ObbfdDSI
         PftKnFeqWytdO4O4OGB5l+GDlpEJlAtK88ysdMd9JX7LKNplu6pr2iDqoIFFJ5JgrnAX
         US2Q==
X-Forwarded-Encrypted: i=1; AKwUvBw/cUnlQknrM+kUEHo0mBqxfw0eQCbsB32nSaHDT7UvHJWvr9BirmME+Ndw1YbYxyPVtPJm3+I=@vger.kernel.org
X-Gm-Message-State: AFuF++lqXfA/17oQPxxyuLnMtqw5I43xSr744/k4cMTZcc4YwZn8xns9
	UWqtfWBjfMxGjDhzf9s3fjm4/Rbt2rEVA9cCCfXVyqQQFWiWlAOiOk1FSooa9hrtyXR9jlgHS3d
	FAbJ57sRbc102Uas6wZxl/AlC8VSja20=
X-Gm-Gg: AYBFou0KXZ++Mw07xHzhNEQxNXcjcufPcfCpWgmuFFgoTKHBPzCc0jCTofeSlMGd3B1
	/7GsFNXlhj50xdOIYED3DXv1H030bvsR+1UKc2yaokj9BLGytDPop0kRefNiWVE3rTzsQ7WFMK8
	i7wHy3rdXUqV4/xy870FRWP2qI/Eyy6rvGxhfls9mzhVB0nXFkt9FLNt9MI04HVJ9BID+kIO0tw
	GmBOtzesX71ctLqy2QubZY5WuV5ATLyCmlqLxFGJJ680w1JBT5HX5BpUeKW6waQLwBNVAZHdKSU
	v5HMDNEjU7ns7gDwFTmLBA/PCMdZeJFriOHyHrUCUX3StxYhTJ9T+1WB
X-Received: by 2002:a05:6214:3f91:b0:910:1989:a61a with SMTP id
 6a1803df08f44-9123d72142cmr37234556d6.9.1789546538452; Wed, 16 Sep 2026
 01:15:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260910081020.86227-3-zxyan0222@gmail.com> <20260915070809.20575-1-pabeni@redhat.com>
In-Reply-To: <20260915070809.20575-1-pabeni@redhat.com>
From: zhu xin <zxyan0222@gmail.com>
Date: Wed, 16 Sep 2026 16:15:27 +0800
X-Gm-Features: AcwNN1XW3Th4N-W5bu9waNiAgddQemIgVo3ViKz9WsG2MGTyypVeX7yRdLJmTfo
Message-ID: <CAP7veTK59_sLEqmUyFrzxaCheXkrkQCioo2t-ouO162+WagTXQ@mail.gmail.com>
Subject: Re: [PATCH net-next v5 2/2] net: stmmac: dwxgmac2: add XGMAC
 timestamp interrupt support
To: Paolo Abeni <pabeni@redhat.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com, 
	richardcochran@gmail.com, maxime.chevallier@bootlin.com, 
	muhammad.nazim.amirul.nazle.asmade@altera.com, rohan.g.thomas@altera.com, 
	netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks.  The content matches the review Jakub forwarded earlier.
In short, v6:

  - arms XGMAC_TSIE on demand from the PTP_CLK_REQ_EXTTS path instead
    of adding it back to XGMAC_INT_DEFAULT_EN, addressing the
    30300d9f9150 revert concern and the missing disable counterpart;
  - rewrites the patch 2 commit message (drops the inaccurate
    config_hw_tstamping and AUXTSTRIG statements) and adds
    Fixes
  - adds a third patch that moves the !channel guard into the shared
    handler;

The one point I push back on is the suggestion to gate the handler's
status read on XGMAC_INT_TSIS: TSIS is aggregate and read-to-clear,
and the TX completion path polls the same register for TXTSC, which
clears TSIS before the handler can observe it while ATSNS still holds
the pending snapshots - a TSIS gate would silently drop real events.
TXTSC itself is cleared by reading XGMAC_TXTIMESTAMP_SEC, not
XGMAC_TIMESTAMP_STATUS, so there is no conflict with the TX timestamp.

v6 will be posted shortly.

Best regards,
Zxyan

On Tue, Sep 15, 2026 at 3:08=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> Full review at: https://netdev-ai.bots.linux.dev/sashiko/
> ---
> net: stmmac: dwxgmac2: add XGMAC timestamp interrupt support
>
> Adds a DWXGMAC2-specific timestamp interrupt handler that reads
> XGMAC_TIMESTAMP_STATUS instead of the dwmac4 offset, derives the pending
> auxiliary snapshot count from ATSNS and emits PTP_CLOCK_EXTTS events.  It
> also adds XGMAC_TSIE to XGMAC_INT_DEFAULT_EN and points the DWXGMAC2 and
> DWXLGMAC2 hwif entries at the new hwtimestamp ops.
>
> A few questions on the commit message and on the new handler.
>
> [Severity: Medium]
> The commit message says:
>
>   "used &stmmac_ptp, whose timestamp_interrupt callback read the wrong
>    register and whose config_hw_tstamping callback never enabled the
>    XGMAC timestamp interrupt (XGMAC_TSIE was not in XGMAC_INT_DEFAULT_EN)=
"
>
> Is the config_hw_tstamping part accurate?  The new ops struct installs th=
e
> very same function that stmmac_ptp uses:
>
>   const struct stmmac_hwtimestamp dwxgmac2_ptp =3D {
>         .config_hw_tstamping =3D config_hw_tstamping,
>
> and config_hw_tstamping() only does a read-modify-write of PTP_TCR; it ne=
ver
> touches XGMAC_INT_EN.  The single hunk that actually unmasks the interrup=
t is
> the XGMAC_INT_DEFAULT_EN change, which dwxgmac2_core_init() writes to
> XGMAC_INT_EN.
>
> The second bullet says the handler:
>
>   "- derives the pending auxiliary snapshot count from the persistent
>      ATSNS field instead of the transient AUXTSTRIG status bit"
>
> Is anything changing here?  The generic handler being replaced already us=
ed
> ATSNS:
>
>   num_snapshot =3D (ts_status & GMAC_TIMESTAMP_ATSNS_MASK) >>
>                  GMAC_TIMESTAMP_ATSNS_SHIFT;
>
> and no AUXTSTRIG bit is defined for XGMAC at all (only
> GMAC_TIMESTAMP_AUXTSTRIG in dwmac4.h).
>
> Could the message be reworded so it is clear which hunk is load-bearing? =
 As
> written, someone backporting could take the ops table and handler hunks
> without the XGMAC_INT_DEFAULT_EN hunk and still get no events.
>
> [Severity: Low]
> The body describes a user-visible failure:
>
>   "As a result, auxiliary snapshot events were never reported on XGMAC
>    platforms."
>
> stmmac_ptp_register() already advertises the channels on XGMAC:
>
>   n_ext_ts =3D priv->dma_cap.aux_snapshot_n;
>   if (n_ext_ts)
>           priv->ptp_clock_ops.n_ext_ts =3D n_ext_ts;
>
> and stmmac_enable() accepts PTP_CLK_REQ_EXTTS, so PTP_EXTTS_REQUEST succe=
eds
> today but no events arrive.  Should this carry a Fixes: tag, or should th=
e
> subject drop "add ... support" and state explicitly that EXTTS never work=
ed
> on this hardware?  Without either, it is hard to tell which trees are
> affected.
>
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h b/drivers/n=
et/ethernet/stmicro/stmmac/dwxgmac2.h
> > index f8ab347f7b5b9..03cbae326995b 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
> > +++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
> > @@ -87,7 +87,7 @@
> >  #define XGMAC_TSIE                   BIT(12)
> >  #define XGMAC_LPIIE                  BIT(5)
> >  #define XGMAC_PMTIE                  BIT(4)
> > -#define XGMAC_INT_DEFAULT_EN         (XGMAC_LPIIE | XGMAC_PMTIE)
> > +#define XGMAC_INT_DEFAULT_EN         (XGMAC_LPIIE | XGMAC_PMTIE | XGMA=
C_TSIE)
>
> [Severity: High]
> Does this revert commit 30300d9f9150 ("net: stmmac: xgmac: Disable the
> Timestamp interrupt by default")?  git blame on this line points at that
> commit, which removed exactly this bit with the reasoning that XGMAC only
> polls for timestamps in the current software implementation and that drop=
ping
> the interrupt "greatly reduces the system load by reducing the number of
> interrupts".  That commit carried a Fixes: tag.
>
> dwxgmac2_core_init() programs this unconditionally on every ifup:
>
>   writel(XGMAC_INT_DEFAULT_EN, ioaddr + XGMAC_INT_EN);
>
> with no check of PTP capability and no check that anything consumes
> auxiliary snapshots.  On platforms that never set
> STMMAC_FLAG_EXT_SNAPSHOT_EN the new handler returns immediately after one
> side-effecting register read, so every aux-snapshot trigger, target-time
> match, seconds overflow and TX timestamp capture becomes an interrupt wit=
h
> no consumer.
>
> Is there also a missing disable counterpart?  XGMAC_INT_EN has only two
> writers, dwxgmac2_core_init() and dwxgmac2_irq_modify(), and the latter i=
s
> used only for XGMAC_FPEIE and the PCS masks, so TSIE is never cleared.
> __stmmac_release() frees the IRQ lines before releasing PTP:
>
>   /* Free the IRQ lines */
>   stmmac_free_irq(dev, REQ_IRQ_ERR_ALL, 0);
>   ...
>   stmmac_release_ptp(priv);
>
> which leaves the MAC timestamp source armed with nobody left to read
> XGMAC_TIMESTAMP_STATUS and clear TSIS; on an IRQF_SHARED line that shows =
up
> as unhandled interrupts for the co-owner, and stmmac_interrupt() also ret=
urns
> early on STMMAC_DOWN without acknowledging the source.
>
> Would arming this on demand from the PTP_CLK_REQ_EXTTS path via
> dwxgmac2_irq_modify(), the way dwmac1000 does, avoid both problems?
>
> >  #define XGMAC_Qx_TX_FLOW_CTRL(x)     (0x00000070 + (x) * 4)
> >  #define XGMAC_PT                     GENMASK(31, 16)
> >  #define XGMAC_TFE                    BIT(1)
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c b/driv=
ers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
> > index 1a88cbaed70ca..891b7ceea2d45 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
> > +++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
> > @@ -1154,6 +1154,49 @@ static int dwxgmac2_get_mac_tx_timestamp(struct =
mac_device_info *hw, u64 *ts)
> >       return 0;
> >  }
> >
> > +void dwxgmac2_timestamp_interrupt(struct stmmac_priv *priv)
> > +{
> > +     u32 ts_status, pending_snapshots, acr_value, channel;
> > +     struct ptp_clock_event event;
> > +     unsigned long flags;
> > +     u64 ptp_time;
> > +     int i;
> > +
> > +     /* Read XGMAC_TIMESTAMP_STATUS to get the AUX snapshot
> > +      * count.  This read also clears the TSIS bit in
> > +      * XGMAC_INT_STATUS.
> > +      * TX timestamp polling may have already cleared TSIS
> > +      * and AUXTSTRIG, so rely on ATSNS instead.
> > +      * TXTSC is cleared by XGMAC_TXTIMESTAMP_SEC, not by
> > +      * this register, so there is no conflict.
> > +      */
> > +     ts_status =3D readl(priv->ioaddr + XGMAC_TIMESTAMP_STATUS);
>
> [Severity: High]
> Should this read be gated on the MAC interrupt status bit first?  The
> dwmac4 implementation of the same callback checks before touching the
> timestamp status register:
>
>   tsync_int =3D readl(priv->ioaddr + GMAC_INT_STATUS) & GMAC_INT_TSIE;
>
>   if (!tsync_int)
>           return;
>
> The XGMAC equivalent, XGMAC_INT_TSIS, is defined in dwxgmac2.h but after
> this series git grep XGMAC_INT_TSIS matches only its own definition, and
> dwxgmac2_host_irq_status() does not consume it either.
>
> Without that gate the clear-on-read register is read on every MAC host
> interrupt:
>
>   stmmac_interrupt()
>     stmmac_common_interrupt()
>       stmmac_timestamp_interrupt()
>         readl(priv->ioaddr + XGMAC_TIMESTAMP_STATUS)
>
> and in the legacy shared-IRQ configuration stmmac_common_interrupt() runs
> before stmmac_dma_interrupt(), so under traffic that read happens for eve=
ry
> RX/TX DMA, LPI, PMT, MTL and EST interrupt as well.
>
> The same register is polled from NAPI/softirq by the pre-existing
> dwxgmac2_get_mac_tx_timestamp():
>
>   if (readl_poll_timeout_atomic(ioaddr + XGMAC_TIMESTAMP_STATUS,
>                                 value, value & XGMAC_TXTSC, 100, 10000))
>           return -EBUSY;
>
> reached via stmmac_get_tx_hwtstamp() and stmmac_xsk_fill_timestamp(), wit=
h
> nothing serializing it against the hardirq read.
>
> The comment above also seems to argue both sides.  If reading
> XGMAC_TIMESTAMP_STATUS clears TSIS, as the comment states and as the sibl=
ing
> patch "net: stmmac: dwmac-socfpga: complete cross-timestamp on ATSNS"
> asserts, does the whole register not go read-clear, including TXTSC?  In =
that
> case the interrupt handler consumes the TX-timestamp-captured status befo=
re
> the TX clean path sees it, and readl_poll_timeout_atomic() spins its full
> 10 ms budget in atomic context and returns -EBUSY, losing the MAC level T=
X
> hardware timestamp.
>
> If instead TXTSC really is cleared only by reading XGMAC_TXTIMESTAMP_SEC =
as
> the comment claims, then nothing here drains it, so TSIS stays asserted
> whenever a MAC level TX timestamp is captured but never fetched (descript=
or
> level status in use, or hwts_tx_en turned off).  With XGMAC_TSIE now
> unmasked, would that not re-fire the level triggered MAC interrupt
> immediately?
>
> Could the comment be reconciled with the databook and the missing
> XGMAC_INT_TSIS check added?
>
> > +
> > +     if (!(priv->plat->flags & STMMAC_FLAG_EXT_SNAPSHOT_EN))
> > +             return;
> > +
> > +     pending_snapshots =3D FIELD_GET(XGMAC_TIMESTAMP_ATSNS_MASK, ts_st=
atus);
> > +     if (!pending_snapshots)
> > +             return;
> > +
> > +     acr_value =3D readl(priv->ptpaddr + PTP_ACR);
> > +     channel =3D FIELD_GET(PTP_ACR_MASK, acr_value);
> > +     if (!channel)
> > +             return;
> > +     channel =3D ilog2(channel);
>
> [Severity: Medium]
> Can this read of PTP_ACR see a half-programmed value?  stmmac_enable() do=
es
> its read-modify-write of PTP_ACR under priv->aux_ts_lock, and sets the fl=
ag
> before the register write:
>
>   priv->plat->flags |=3D STMMAC_FLAG_EXT_SNAPSHOT_EN;
>   ...
>   writel(acr_value, ptpaddr + PTP_ACR);
>
> priv->aux_ts_lock is a mutex ("Protects auxiliary snapshot registers from
> concurrent access." in stmmac.h), so a hardirq handler cannot take it.  A=
n
> interrupt landing in that window sees the flag set with a stale PTP_ACR a=
nd
> reports the snapshot with the wrong event.index; on the disable path it c=
an
> see the flag still set with the mask already cleared, take the
> if (!channel) return; exit and drop the pending ATSNS snapshots.
>
> priv->plat->flags itself is now a plain non-atomic |=3D / &=3D shared wit=
h a
> hardirq reader, with no READ_ONCE()/WRITE_ONCE() or barrier.  Is that
> intentional?
>
> [Severity: High]
> This isn't a bug introduced by this patch, but the guard added here is
> missing from the shared dwmac4 handler that this new code was modelled on=
.
> In timestamp_interrupt() in stmmac_hwtstamp.c:
>
>   channel =3D ilog2(FIELD_GET(PTP_ACR_MASK, acr_value));
>
> For a non-constant u32, ilog2() expands to __ilog2_u32(n) =3D fls(n) - 1,=
 so
> ilog2(0) is -1.  Stored into the u32 channel and then into event.index it
> becomes -1, and ptp_clock_event() uses it without range validation:
>
>   drivers/ptp/ptp_clock.c:ptp_clock_event() {
>           ...
>           if (test_bit((unsigned int)event->index, tsevq->mask))
>           ...
>   }
>
> tsevq->mask is bitmap_alloc(PTP_MAX_CHANNELS, ...), i.e. 2048 bits, so bi=
t
> index 0xFFFFFFFF is a read roughly 512 MB past a 256-byte allocation, tak=
en
> from hard IRQ context.
>
> The window is the same one described above: stmmac_enable() sets
> STMMAC_FLAG_EXT_SNAPSHOT_EN before writing PTP_ACR, and if a timestamp
> interrupt arrives with ATSNS non-zero (snapshots left in the FIFO from a
> previous session, since ATSNS is cleared only by PTP_ACR_ATSFC) the handl=
er
> sees flag set and mask zero.
>
> Would it make sense to move the if (!channel) return; check into the shar=
ed
> handler as part of this series, so dwmac4/dwmac410/dwmac510 get it too?
>
> > +
> > +     for (i =3D 0; i < pending_snapshots; i++) {
> > +             read_lock_irqsave(&priv->ptp_lock, flags);
> > +             stmmac_get_ptptime(priv, priv->ptpaddr, &ptp_time);
> > +             read_unlock_irqrestore(&priv->ptp_lock, flags);
>
> [Severity: Medium]
> Does the read side of priv->ptp_lock give any exclusion here?  This loop =
pops
> the auxiliary snapshot FIFO, and get_ptptime() is a two-register consumin=
g
> access:
>
>   ns =3D readl(ptpaddr + PTP_ATNR);
>   ns +=3D (u64)readl(ptpaddr + PTP_ATSR) * NSEC_PER_SEC;
>
> An rwlock read side does not exclude other readers, and on XGMAC there is=
 a
> second consumer of the same FIFO in process context, smtg_crosststamp() i=
n
> dwmac-socfpga.c:
>
>   for (i =3D 0; i < num_snapshot; i++) {
>           read_lock_irqsave(&priv->ptp_lock, flags);
>           stmmac_get_ptptime(priv, ptpaddr, &ptp_time);
>
> The only thing keeping the two apart appears to be an unlocked flag test =
on
> each side:
>
>   drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c:smtg_crosststamp() =
{
>           if (priv->plat->flags & STMMAC_FLAG_EXT_SNAPSHOT_EN)
>                   return -EBUSY;
>           ...
>   }
>
> Since that check happens well before the drain loop (with 10 ms
> readl_poll_timeout budgets in between), can a PTP_EXTTS_REQUEST arriving
> after the check arm the interrupt path while smtg_crosststamp() is still
> draining, letting both pop the same FIFO and interleave their PTP_ATNR /
> PTP_ATSR reads?
>
> > +
> > +             event.type =3D PTP_CLOCK_EXTTS;
> > +             event.index =3D channel;
>
> [Severity: Medium]
> This is a pre-existing issue, but it interacts with the new index
> derivation.  In stmmac_enable(), the PTP_CLK_REQ_EXTTS path clears the
> channel mask before testing it:
>
>   acr_value &=3D ~PTP_ACR_MASK;
>
>   if (on) {
>           if (FIELD_GET(PTP_ACR_MASK, acr_value)) {
>                   ... return -EBUSY;
>
> so the tested field is always zero and the -EBUSY rejection of a second
> active channel never fires.  Since stmmac_ptp_register() advertises
> dma_cap.aux_snapshot_n channels, a second PTP_EXTTS_REQUEST succeeds and
> silently replaces the channel that was enabled.
>
> With that, does the index computed here get attached to the wrong events?
> Snapshots latched while the first channel was armed would be reported und=
er
> the replacement channel's index.
>
> > +             event.timestamp =3D ptp_time;
> > +             ptp_clock_event(priv->ptp_clock, &event);
> > +     }
> > +}
> > +
>
> [ ... remaining hunks in hwif.c, hwif.h, stmmac_hwtstamp.c and
> stmmac_ptp.h snipped ... ]
> --
> This is an AI-generated review.
>
