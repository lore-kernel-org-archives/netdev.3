Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E8BA3515E5
	for <netdev@vger.kernel.org>; Sat,  5 Sep 2026 06:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788588994; cv=none; b=jk2nu2HM+dbYePAMUCG5BmNTdjXTuBuP6cigUQ7q6SUd8TbLtJF8I7j0YqOJdalnj4nK03HuwEFfvEZcKCf/tse4ZJwX5LwwZWXp+++vtGqJwURqKy8xKKtgbcwvg0Zw3MV+odw3fbH85Vep4JRKIIhEB96etRV5fkzpmKuUXfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788588994; c=relaxed/simple;
	bh=v8k24rcZ1MFIPM+pYRzI1CI7mZhPk99bCXlQjm/5kBc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KgNbNAG3zxOWBIT4QZl6DVnTDWIXytPkfBn/0k2+glkggTXXJBkkb92UoWKx3o9VYpAmUQPVq0DHv8oGTOLxMFPK4h62ggKqrBHTFWtrN+a8NcMKGY9oZ4R89meD+YwcrpPoCeqxS48bFLubtTwVLCbKI1Xnc/Bhbt7GCE6jVs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eG6Yau/S; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eG6Yau/S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DA7F1F00ADE
	for <netdev@vger.kernel.org>; Sat,  5 Sep 2026 06:16:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788588992;
	bh=wroX+IXZ78hb2aQP5LUDjSlqEruTGuDIlApEgq/LO60=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=eG6Yau/SZQyADBf7WEKKvoXO5elZ/bvCf/rLi+iKt3NTLV7xty74rhFfmCtOpPiim
	 KsAmLG9Gn+z3shv/KSeuw44rHL9DtjgoqL/rXuxlacLkIVZF2+hqWRGRtWUTXi/qmJ
	 kZl5s4svuLfbc9Q0nHCHcueEtH3KiRVj1uiGBF/HJ7S7HftHqGrPtY0Sno1Rhjpz4S
	 r4ZM1gDlCVp9/4jsn5pfGOohCmBT4WDB98quAjGdOyMWd9pF1NAdOgRtz+4BlRvGeN
	 E8KPCW/IB9VA/PTkef8GQF62ljNlTZ7dJCjGnGxIPtOxwhbNeoezclLf0Kn6pu8kjd
	 1SF3HTI8TDArw==
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5b523efb0bfso551582e87.3
        for <netdev@vger.kernel.org>; Fri, 04 Sep 2026 23:16:32 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBzUBnUFohNXzQ1R2QOKIDz0wdqLr6rE0UqOaYUGUln/LvyaAqQDKUEeqI4EgayU76i75zme46Y=@vger.kernel.org
X-Gm-Message-State: AFuF++mlqQkKEwWquFYiG63Q41fFiOKvBnBedwDKq6sCrxTX3SVihvlM
	Ih/y0CfPRTpu/mZmYpG0dfZaEJmIUggoR+f0+PmbcadGCTfoDbCSPwMlQfFWAMjO1k6oNyjOE+T
	ip3rVH+E8ornETocReOMfyPmSzREJgZ8=
X-Received: by 2002:a05:6512:2c0c:b0:5b4:74a2:cf2e with SMTP id
 2adb3069b0e04-5b616f235cemr3181239e87.21.1788588991087; Fri, 04 Sep 2026
 23:16:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260831082335.1184605-1-wei.fang@oss.nxp.com> <20260831082335.1184605-9-wei.fang@oss.nxp.com>
In-Reply-To: <20260831082335.1184605-9-wei.fang@oss.nxp.com>
From: Linus Walleij <linusw@kernel.org>
Date: Sat, 5 Sep 2026 08:16:19 +0200
X-Gmail-Original-Message-ID: <CAD++jLk+DMHzHiJoX6LMY5wUGMOWm3DN_yAHUUSvFKLKgFwJZw@mail.gmail.com>
X-Gm-Features: AcwNN1VLKzpVVc3BcKIIuwpH2P20ZdeitB0o0lFGwyQdTkbcdnQSy6KPeNWVBSI
Message-ID: <CAD++jLk+DMHzHiJoX6LMY5wUGMOWm3DN_yAHUUSvFKLKgFwJZw@mail.gmail.com>
Subject: Re: [PATCH v3 net-next 8/8] net: dsa: netc: add PTP one-step
 timestamping support
To: wei.fang@oss.nxp.com
Cc: xiaoning.wang@nxp.com, andrew@lunn.ch, olteanv@gmail.com, 
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	richardcochran@gmail.com, wei.fang@nxp.com, imx@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Wei,

thanks for your patch!

On Mon, Aug 31, 2026 at 10:24=E2=80=AFAM <wei.fang@oss.nxp.com> wrote:

> From: Wei Fang <wei.fang@nxp.com>
>
> The NETC switch supports one-step TX timestamping for PTP Sync frames.
> When transmitting a Sync frame, the driver reads the current PTP time
> and writes it into the frame's originTimestamp field, and inserts a
> To_Port subtype 1 tag carrying the low 30 bits of that same PTP time.
> As the frame leaves the wire, the MAC captures the SFD transmit time
> and derives the residence time from the timestamp in the tag. It then
> reads the correction field at the offset given by
> PM_SINGLE_STEP[OFFSET], adds the residence time to it, and writes the
> result back.
>
> PM_SINGLE_STEP is a per-port register that can describe only one
> in-flight frame at a time, and programming it requires reading the
> current PTP time, which may sleep. Both constraints rule out handling
> one-step Sync on the xmit path.
>
> Instead, defer transmission to a per-port process-context work. The
> xmit path classifies the frame in netc_port_txtstamp(): a genuine
> one-step Sync (twoStepFlag cleared) has its PTP header offsets cached
> in the skb control block; frames that cannot be handled as one-step
> fall back to the two-step path or are sent as normal frames. netc_xmit()
> hands the classified frame to the switch driver via the
> onestep_sync_enqueue tagger callback, which queues it and kicks the work
> if no frame is currently in flight.
>
> The work dequeues one frame at a time, reads a fresh PTP time, programs
> PM_SINGLE_STEP, updates the originTimestamp field, and transmits the
> frame directly to the conduit via the onestep_sync_xmit tagger callback,
> bypassing dsa_user_xmit() to avoid double-counting TX stats. Only one
> frame is in flight at a time: the frame carries a TX-completion
> destructor that reschedules the work when the conduit frees the skb,
> keeping PM_SINGLE_STEP always matched to the frame being transmitted.
>
> The one-step context is reference-counted and its lifetime is decoupled
> from the devm-allocated netc_port. In-flight skbs hold a reference via
> their destructor, so the context outlives port disable until the conduit
> frees the last in-flight skb. Port disable clears onestep->active under
> work_lock; a work that runs afterwards observes active cleared will
> purge the onestep->queue and return without touching the freed port
> resources.
>
> Assisted-by: Wchat:claude-opus-4-8
> Signed-off-by: Wei Fang <wei.fang@nxp.com>

You agent produces "dostoyevsky commits" with too much verbiage.

Tell you agent to "be terse and to the point" in your AGENTS.md.

> +
> +               /* dsa_tree_teardown() calls dsa_tree_teardown_ports() be=
fore
> +                * dsa_tree_teardown_switches(), so netc_port_disable() i=
s
> +                * executed before netc_teardown() and onestep->active is=
 set
> +                * to false. In-flight one-step skbs still hold reference=
s via
> +                * the destructor; the context (and its work) is freed on=
ly
> +                * after the conduit frees the last in-flight skb. By the=
n np
> +                * may be gone, but the work no longer dereferences np be=
cause
> +                * onestep->active has been cleared. And onestep->queue w=
ill be
> +                * cleared by netc_onestep_work()/netc_onestep_destroy_wo=
rk().
> +                */
> +               netc_onestep_put(np->onestep);
> +               np->onestep =3D NULL;

This type of stuff is over-commenting and is considered AI slop.
Tell you agent to be very restrictive with inserting comments, essentially
it should only do that when you explicitly tell it to, such as when you
yourself feel it is really necessary or you got a review comment that
this is needed.

Yours,
Linus Walleij
