Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E857F3ACA43
	for <netdev@vger.kernel.org>; Tue, 18 Aug 2026 03:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787024288; cv=pass; b=upBaGoCZjaOBTvHocqStwmNWF8fTfzkR43MJhWMHIfpTlmCwQPiVkzIolOZvozH/LYIu2a94bzoDbG30Lds6QFNz8fSZQbELzts+Fon39QXpRMwm0fF5XlMm7SR6PfNSYwihf4FFFWRAMMf4Ai1DD9HLdL9WHAY24Ijht/Ex7aM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787024288; c=relaxed/simple;
	bh=FrZuTfE19Htd0TtXyXNUqtd2FLHH2q966v0WxSfGD18=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZoJ6ek0TgU1FxdcNS0hXQYS49VVsry6gIBDzSBdu8ho2ScKxnrhQD8OIFb1L3LAiue1KSuflUt5htn/DonbI7VxnUmQCV+a/4j7g3tnvI3JqBFc3gS+X9Y7oGiIcHEwZYzaZkonx83ircr1PG/izFLkI5S1apXJFSecnQnUEQ64=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FCIH+W70; arc=pass smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FCIH+W70"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-9063b380982so43353976d6.0
        for <netdev@vger.kernel.org>; Mon, 17 Aug 2026 20:38:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787024286; cv=none;
        d=google.com; s=arc-20260327;
        b=g9ZGTlsQO2HMjbTdvr465IycWEu8Iefv5D0XYp2p2avk6gM4EHf3tGVN45T0sUBOy7
         NTYCrMadFpRIqydQh+6aPQK/xzeiqgax8fVp1it6tFFx9qL1XqzJRHz97zZVztsC6e7P
         0smr50mHA1Kw+1afuoF3X9/g0StegCIbcKI/xistjNtIHGddRT6yNUYzimxVOxez8igj
         R/+aNx//WPdT814ULoDCz8JdMXBxzL9BJIuMfxC/L4KBgFQD4cSLf5W9b5PBtoj0LAdG
         XTvb+CzGRKbrTaHgJ+JOY1qjGxowkvTvFvnR4eLrpzL72NoprlXpzh76n7uEPGop/yUV
         Vg1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6z7AN0CVMZUcd1/jA69i+08hLmV+o5WRzCn3iir7Mhc=;
        fh=fuWaoxha+qoft9aqgmNAP6H4StsGruH82588cH80/QY=;
        b=Ed4wqkG2sqc0U2yjE17VVyS0y47ZgDipq/2i+gENe7NON3zyiwdnurS3ABSBnr5/Kw
         uYBvFK8HNb2TCuxxo/2ikQnQ+y9gHbY4yidz3zFTqJ8AXTcfX9T3v8tLWkxhyXFDZgg2
         i91OCJKcAHarjF7jLtG1nI47ZxWrqlR3jkB+P5Sv/mLgK2CuEWruyYIoZkiFP880lQI+
         dxyki+8gasGFJ5IkO9RRH7AxsKXHtzUOIx7nfd87yJ+c6JGa8lnNpUjXnqgJwurEM+rq
         i/tLnnZ94gDuqjjVKgRL7RMUX9gop3fE1+lLA/WYsjE7ut48NN2gl6cn9w94TDqiWOR9
         f/zQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787024286; x=1787629086; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6z7AN0CVMZUcd1/jA69i+08hLmV+o5WRzCn3iir7Mhc=;
        b=FCIH+W70VddX6JhLAQY08Dl4NU4OGTV/xXllOQZWHbjErqur3u+Ruzdh858vdugwTb
         XsgDiuI6ovKs/3TfXaDR+QstIVv3apusBjU8KvvhD/CSPrKd1IkSUepqGrR0cRDDuJO8
         D/YBELJGtdywPiFZq5YOU5poISToOhLOWHu1An74Ff57dqiGt7g+LZRqcnZYZ9hZ/c9j
         dHWODZ+HYkQUavNYSImGPg/MpWVLctPNt82LrZq83dWksAvMsM8UsJYY+g5L44LL2HqW
         Bj/QYoVLC2dIH9gg5PXBCp9WP/MmkamoD59P8RvqZTUsWc7qgUQcA9Z2v2cmeUBbvC04
         mSQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787024286; x=1787629086;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6z7AN0CVMZUcd1/jA69i+08hLmV+o5WRzCn3iir7Mhc=;
        b=nEZiPJ+Y2isHHHbEwxM6bKL+qs+ppF8IwGMMLpACaUTinJECHyh4c4grMuSopGfPAi
         PldCzm0+mPW5a+5KeuhQuvTmKnkrReAP7hRH5BQLb627x1lQpAjGrOCEDdK+NSIRKkuu
         KuQXus/raAXsAE9PW3bm/dsdNcdzlWZiheUbp1xL/uDJUe8W/APNPgsZ5kOOTdpY9zWJ
         WVIaka2cJ4LsdIqUHX+0VB27v+VOov7cEyTWvGP7SlbJUsaOS3M6Yq6+viwGJ1DF7hnH
         E8BmRoVHwi0c9vgD/BnbglgfFtm0tkm+LGUWbC/RvAzhHt9CmpmUhVUBdnx26VFp2Wq0
         qGpQ==
X-Forwarded-Encrypted: i=1; AHgh+RoZdS6Np6IqqE8XZ/HK2u8cvFS4D3wAIb7G4Ab6WxUY0Z11mFrcn2adB0HakEYqJzY1zeQtPcU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyf1UOYU8hkRNS7C9CN+zXoF5qhQAVePVYu3qYgGcu3sIznh37b
	qaWZHrDSU3iO7I8nFOYr7gyCZkGakC/mOJvIbD7/svqLOggDzATgC21GfHQjDzRGUTIy3+Gl9lK
	H/q3BhwFMCMbMIPLQILZCWu2T6NZqlsc=
X-Gm-Gg: AR+sD1095EUOSgUmsN0/2D/XL0IPd7MUSxfW4bzNDNGV3+/OJPZydcTyyHfuSAwBOT5
	7LletreHhZYabsMEDFgj7Iuo5nsuUzHPmbFSwRQknczn12ipRgYt7cD+omrdvgnZI9lMl5NUest
	bzS8kSipiMy6gl4bbrhDw7Kg1zaFubbgl6/zyrcgP+g2oHGCliWXcFwkOE+PCrSTHgOfXd192Df
	9UpPmmbGzksFJwBwvsI6VRQGXUG5r6EvXreJZ1JbAzfcKGQyat4yUAOWraiOB8/IOvhmvx/ngJN
	FpszA/4APybvzzDlS6g/mu6SXfMAJS5VNYphDdniig0n
X-Received: by 2002:ad4:5d42:0:b0:8f3:9586:c179 with SMTP id
 6a1803df08f44-90a91de382amr341852056d6.17.1787024285657; Mon, 17 Aug 2026
 20:38:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260810100221.9166-1-zxyan0222@gmail.com> <b3d90606-781a-4055-8529-e68e22a45ce9@bootlin.com>
 <20260812202027.976@gmail.com> <96146485-03f4-4c82-bb4b-9338b6591b2f@bootlin.com>
 <CAP7veT+fufSoBZBOQg+MQoGeedfzQBRtFrRPz8si2DJSJJ7NtQ@mail.gmail.com> <f18dfd79-c252-4e78-b37b-e5aaf1bffecc@altera.com>
In-Reply-To: <f18dfd79-c252-4e78-b37b-e5aaf1bffecc@altera.com>
From: zhu xin <zxyan0222@gmail.com>
Date: Tue, 18 Aug 2026 11:37:54 +0800
X-Gm-Features: AcwNN1XGO3m5hEy0080m-Rkxdx5-kto7s9Z8yeSqOkdDrn2BCbYYWjpP3EgTyrg
Message-ID: <CAP7veTJdt=iONp5RauCeUz6q2g6RpdAcTRCrK6A35hw9xX+YaQ@mail.gmail.com>
Subject: Re: [PATCH net-next v2] net: stmmac: dwxgmac2: add XGMAC timestamp
 interrupt support
To: "Nazle Asmade, Muhammad Nazim Amirul" <muhammad.nazim.amirul.nazle.asmade@altera.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>, 
	"mcoquelin.stm32@gmail.com" <mcoquelin.stm32@gmail.com>, 
	"alexandre.torgue@foss.st.com" <alexandre.torgue@foss.st.com>, 
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, 
	"richardcochran@gmail.com" <richardcochran@gmail.com>, "davem@davemloft.net" <davem@davemloft.net>, 
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>, 
	"pabeni@redhat.com" <pabeni@redhat.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"linux-stm32@st-md-mailman.stormreply.com" <linux-stm32@st-md-mailman.stormreply.com>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 17, 2026 at 11:11=E2=80=AFAM Nazle Asmade, Muhammad Nazim Amiru=
l
<muhammad.nazim.amirul.nazle.asmade@altera.com> wrote:
>
> On 13/8/2026 2:50 pm, zhu xin wrote:
> > [You don't often get email from zxyan0222@gmail.com. Learn why this is =
important at https://aka.ms/LearnAboutSenderIdentification ]
> >
> > Hi Maxime,
> >
> > On Wed, Aug 12, 2026 at 10:08=E2=80=AFPM Maxime Chevallier
> > <maxime.chevallier@bootlin.com> wrote:
> >>
> >> +Nazim
> >>
> >> On 8/12/26 14:59, Zxyan Zhu wrote:
> >>> Hi Maxime,
> >>>
> >>> On 8/12/26 5:10 PM, Maxime Chevallier wrote:
> >>>> If there's an interrupt storm, then this should probably be a fix fo=
r -net
> >>>> with a Fixes tag.
> >>>
> >>> There is no interrupt storm. XGMAC_TSIE was never enabled before this
> >>> patch (XGMAC_INT_DEFAULT_EN was LPIIE | PMTIE only), and
> >>> dwxgmac2_host_irq_status() masks the status with the enable mask, so
> >>> XGMAC_INT_TSIS could never fire. The actual symptom is that
> >>> auxiliary-snapshot extts events were never reported -- a feature that
> >>> was never wired up, not a live interrupt storm.
> >>
> >> Ah indeed, quite the opposite then.
> >>
> >>>
> >>> So I'd like to keep this on net-next as a new feature rather than
> >>> retarget it to net.
> >>
> >> Yes makes sense indeed.
> >>
> >> Can you take a look at the sashiko-reported issues, it spots that this
> >> could interfere with the timestamping on agilex5 (another XGMAC platfo=
rm) :
> >>
> >> https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260810100221.916=
6-1-zxyan0222%40gmail.com
> >>
> >> Maybe there's some stuff that could be made more generic by moving the=
m out
> >> of the socfpga code and putting it in the more generic timestamping co=
de ?
> >
> > Thanks for the pointer. I looked at the sashiko v2 review and the
> > Agilex5 concern is real. On Agilex5, smtg_crosststamp() polls
> > XGMAC_INT_STATUS for TSIS in process context as its only completion
> > signal. The patch enables XGMAC_TSIE in XGMAC_INT_DEFAULT_EN, so the
> > new hardirq handler now runs on every timestamp event and clears TSIS
> > by reading XGMAC_TIMESTAMP_STATUS -- that read can win against the
> > poll loop, and getcrosststamp() then times out with "Wait for time
> > sync operation timeout".
> >
> > On moving socfpga bits to the generic timestamping code: the
> > crosststamp path splits into a generic half (pick ATSENx, set ATSFC,
> > poll TSIS, read ATSNS, pop ATNR/ATSR) and an Agilex5-specific half
> > (GPO0 rising-edge trigger + SMTG MDIO system counter). Only the
> > generic half is worth lifting, and the platform-specific trigger
> > belongs in plat->crosststamp. That's a useful cleanup but may be
> > orthogonal to this race.
> >
> > For the race itself I'd like your view on the fix below. The simplest
> > option I found is to mask XGMAC_TSIE around the cross-timestamp so the
> > hardirq handler cannot steal TSIS while smtg_crosststamp() owns the
> > snapshot FIFO:
> >
> >    static int smtg_crosststamp(ktime_t *device,
> >                                struct system_counterval_t *system,
> >                                void *ctx)
> >    {
> >        ...
> >        if (priv->plat->flags & STMMAC_FLAG_EXT_SNAPSHOT_EN)
> >            return -EBUSY;
> >
> >        /* mask TSIE so the hardirq dwxgmac2_timestamp_interrupt() can't
> >         * clear TSIS via reading XGMAC_TIMESTAMP_STATUS while we poll i=
t
> >         */
> >        stmmac_mac_irq_modify(priv, XGMAC_TSIE, 0);
> >
> >        ... arm ATSENx, ATSFC, toggle GPO0 ...
> >
> >        ret =3D readl_poll_timeout(ioaddr + XGMAC_INT_STATUS, v,
> >                                 (v & XGMAC_INT_TSIS), 100, 10000);
> >        if (ret) {
> >            ...
> >            stmmac_mac_irq_modify(priv, 0, XGMAC_TSIE);
> >            return ret;
> >        }
> >
> >        ... read ATSNS, pop FIFO, get_smtgtime() ...
> >
> >        stmmac_mac_irq_modify(priv, 0, XGMAC_TSIE);
> >        return 0;
> >    }
> >
> >    /* every return path, including the -EINVAL default of the
> >     * int_snapshot_num switch, restores XGMAC_TSIE */
> >
> >    static void dwxgmac2_timestamp_interrupt(struct stmmac_priv *priv)
> >    {
> >        u32 ts_status =3D readl(priv->ioaddr + XGMAC_TIMESTAMP_STATUS);
> >
> >        if (!(priv->plat->flags & STMMAC_FLAG_EXT_SNAPSHOT_EN))
> >            return;
> >        ...
> >    }
> >
> > This keeps the extts handler unchanged and just makes "who owns TSIS"
> > explicit on the crosststamp side.
> >
> > An alternative I considered:
> >    - making socfpga set STMMAC_FLAG_INT_SNAPSHOT_EN and wait on
> >      tstamp_busy_wait like intel: cleaner long-term, but a bigger
> >      rewrite than fixing the regression warrants here.
> >
> > One worry: I'd like to confirm masking TSIE for the ~poll window is
> > acceptable on this platform -- extts snapshots taken during the window
> > still latch TSIS (just don't raise an interrupt) and are reported after
> > TSIE is restored, so they are delayed rather than lost. Does that match
> > your expectations?
> >
> >>
> >> I don't have any xgmac boards to verify sashiko's claim though.
> >>
> >
> > I don't have Agilex5 hardware to validate the crosststamp path either,
> > so I'm relying on the code analysis above. If this approach looks
> > reasonable I'll send it as a v3 with this as a second patch.
> Hi Zxyan,
>
> Let me know what kind of test needed, I can help to verify on my end
>
> BR,
> Nazim> Thanks,
> > Zxyan
>

Hi Nazim,

That would be great, thanks. The concern is that patch enables
XGMAC_TSIE in XGMAC_INT_DEFAULT_EN, so the new hardirq timestamp handler
runs on every XGMAC timestamp event and clears TSIS by reading
XGMAC_TIMESTAMP_STATUS.  On Agilex5, smtg_crosststamp() polls
XGMAC_INT_STATUS for TSIS in process context as its only completion
signal, so the hardirq read can win the race and getcrosststamp() times
out with "Wait for time sync operation timeout".

If you are able to verify on your Agilex5 board using the v2 patch
(which enables XGMAC_TSIE but has no socfpga fix yet), I would like to
confirm the following two points, to check whether the Agilex5
cross-timestamp regression that sashiko flagged actually reproduces:

1. Does smtg_crosststamp() time out -- that is, does the error "Wait
   for time sync operation timeout" appear in dmesg?
2. Is the cross-timestamp obtained correctly?

Anything else you'd normally run for the crosststamp path is welcome --
you know the board far better than I do.

If the issue does exist, I will send v3 with the fix.  The specific
approach still needs input from both Maxime and you; the options I see
are:

  1. Isolate the interrupt using stmmac_mac_irq_modify within
     smtg_crosststamp -- the minimal fix.
  2. Making socfpga set STMMAC_FLAG_INT_SNAPSHOT_EN and wait on
     tstamp_busy_wait like intel -- cleaner long-term, but a bigger
     rewrite.

Best regards,
Zxyan Zhu
