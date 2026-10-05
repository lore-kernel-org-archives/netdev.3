Received: from mail-yx2-f12.google.com (mail-yx2-f12.google.com [74.125.224.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B6044156DF
	for <netdev@vger.kernel.org>; Mon,  5 Oct 2026 22:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791240056; cv=pass; b=smSvOlp9Aw+kOj0gAZJ51LWLHiVvb2UcVpZEBbA/rtLm9C/5ZCXB74d++3vVo7munfdb5Xmuo1rl4oE5B674za59HTJpRuj1Iyr8Je2JH9AY3PpnOxGHmuv9HuKE26JrivDss4R24rFCQjF4oBMIPg8xIKnoWdKKHPG1KyeOQdA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791240056; c=relaxed/simple;
	bh=KmsI2dBIoqRiFxPwJAsKHNEGBXgUCilBrLu9nl6hNws=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kba8A3lyI4CHf8+3rWjGZn8ayS+ywzBM3nYKQO8j929TL4igix+Bioq/8JMEYEohDe/aWyGkiU/jsqYwVkeviIJRZmNdg3MnAPFuuel/eIH6l+dNOWGRBC7csh9nabLWawv0JAiEGaiEwDzqlHx6k1Loktxmk943wYSyZQsfZmY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.tenstorrent.com; spf=pass smtp.mailfrom=tenstorrent.com; dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b=Ahs0S40T; arc=pass smtp.client-ip=74.125.224.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.tenstorrent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tenstorrent.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b="Ahs0S40T"
Received: by mail-yx2-f12.google.com with SMTP id 956f58d0204a3-66e4ab201ecso1883171d50.2
        for <netdev@vger.kernel.org>; Mon, 05 Oct 2026 15:40:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791240049; cv=none;
        d=google.com; s=arc-20260327;
        b=pIc+ThnmOI6sjlo/MroGdRJxEgexOE6G/IVodh0MfZOBZqRmaIdHdKHQGZqYA+lsBu
         0YpCdRjHzJ9jXaFip7ZCNIMeceFmsrxp8Fbwnrj2Ch9saqyMd13A1eUZowE5jXSzOh+q
         f5wT9O0IBjo9lOye1/AJgZnoTOxAU1Mp7v6Z9CXaaI/8OV4gWrAuHFsReumm8MV4HPah
         //lksVtdX46W5lJIwg2Eydvkqu6WDZiaNMesLt8eNIIXjtnTIfN6fY4Sc5UmiT7Ri5mF
         h4wX7knnKjIfoSl1zgF25/d17pIVk/4h1F5Yw+4r4WYsuoSoaf8CKRllAFCDu/Thwvs0
         TPOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Yoy4+gNGcQV5h8mXnlsNwLFsTZ1uQXaQDtjTnekUSzk=;
        fh=MvaAMKcyx4Ne15BqvkqWjHmApFBRTmoum68jfSoQGkk=;
        b=O7Ljz0bCEH+qnBXueWYFsw6t7VLgAjDrNc0/DAYxMEFMLWr/aIJpmG8MfouyuyOMlb
         y/ZA9nE6fRFjCpswyyAoS3/s3/0gtcWj/1a+nuspqvesfoJQqcLpZd3xIb4gmZUuAVvO
         Z+giJ/gxBS/l0+yK22s0zoPdr90y4UeV8N/XkF0Pui6EtZGTrsKMHQ/EUCDV38lon+1K
         f9kG7/eSftGAjeyLOOn06tY4IWwKb8Rl4hZZYBpQVOKX5jvG2Rc5PafSJ3yaqVzjx9pc
         oq3zkza9kpwEuW6IZDU6/AbH6pFcOZpv6tSxzpOkpLcqD4mPAuZOIR19I2M1b6NlI+C8
         sykg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tenstorrent.com; s=google; t=1791240049; x=1791844849; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Yoy4+gNGcQV5h8mXnlsNwLFsTZ1uQXaQDtjTnekUSzk=;
        b=Ahs0S40TngYLc8F+0sgZVOohDz4Q0ChJQeTeQBepwm1WZFbGA4jqGto/AX2Rrm9Mqt
         okkkGonaB8st0jebhCWQhpBj5tDMHhM96WG0jpc0G4EZvmTPXGy6lnOM7OJ9TIDMfOFM
         6d3o2vfNhLpo7W1FiqLcRynYgS1d135RT5a+J5mi9PWa3cG42x49CpPt4XFkSBt2T+8C
         kKWKA2Q673jiz8LF4PRjTdz+oTbgHllFh29DUpCHG+5/DcHqrfK4LrOGvrDNwzJZUbiN
         DqZclyAajMEWLTaq6I0hfdLBCxJKp+lOoWeILleN1ymjkCkqXUEeQvXEQvA55CaPZlJs
         pUBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791240049; x=1791844849;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Yoy4+gNGcQV5h8mXnlsNwLFsTZ1uQXaQDtjTnekUSzk=;
        b=EfLlhMKgZFKNGjbMwGdNYZPq/uhYGkyI+lpa1U0gFdUauBslo0T1w9JbU8VCfpH++f
         6issZX2rKZM5V5ClETQlBTPtR3I6f51gt1wOat1DFwN8K4q5J2N3DHk1sgMzr1yL7ELu
         aE4VA30cUxP7oO5pxLUgZNSaXvvkMtIPiQSV1cv4xgbnHZPA/Y4Rp2eH8jmL1iAQDXqn
         2qWxcnnKLO4M+wcxB/kdMf75P/ja7pxts0a4m7XSygAqq0xpgsXOKQSGRwDcASGCppPT
         ux12fSjdmqyUz7wtmcMGlmSwew5z8hz1hq9RM9438Dad6G1ZUqCuXeWaJfgNjGZXrUEv
         uXOw==
X-Forwarded-Encrypted: i=1; AKwUvBx9RFPCidZb4zzI4LOCVtQdV2mElrfFttDgvZ3dVhj6Wu7dUQyn5zU0OAc1z0BOzUqy5jlztZs=@vger.kernel.org
X-Gm-Message-State: AFq9FYITiVEO6j6Pa13sFkZx7eLtDTcMhRbznKqosUquiRSYqm2xJFIx
	8s4fdG/SH5B4D5GZ9Ng5E1LhniOiZHqRvtQfBWYQxBR6hTN7xWcH/k8uUEJ57htTmvdjMe0A+6z
	plYEZ6MmzHfOJkTyFVRXbzbSoTs0uaj5pWnC9DlImgA==
X-Gm-Gg: AYBFou3K+xdIChVKsJDEe7k/VxiSdYT6tlsY+QFua/MbTI72egnh2kdhrQ/MXy9fd2T
	UA8VyLdFa+iRJMVr8LH5suuS8MeGWofbS8kThkBjmvtVN/chqSDEexsdM1qX/qGCU0qqV4o3P0m
	iESa6L2nCYVg63oIVZDKqFb5xEJoiP00Qj2biuRQvmeFB6yHYXthDzwJOBsgdGSPN2WtIHu9Edw
	OuLum03MyVP9u6LWhtFK1saZGLxwa7Gk+C0nIh3e6Gu2RnjEP5eAUSuKvHkZw/adU/MoW9jhXJ4
	wP9aLpgJmX4P3Df5TrTe1YRu7J3/CRqRPEuqozM9Qqwo8FC1BjX5bexqJZv5C1Q8gLbnGZB2Sx4
	4vpmtfV7PPnE=
X-Received: by 2002:a53:eb86:0:b0:677:a004:4c3b with SMTP id
 956f58d0204a3-677ac155deemr3157728d50.127.1791240048910; Mon, 05 Oct 2026
 15:40:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260929-stmmac-ptp-added-systime-error-v3-1-ddd6afe936b4@oss.qualcomm.com>
 <dy5xfj3754wnp3gh2kpoyf3vpx3vfsfhblgbwbwsgts27xqxga@dzb33gt3zgca> <asQcQIh56MV1OJur@lore-desk>
In-Reply-To: <asQcQIh56MV1OJur@lore-desk>
From: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
Date: Mon, 5 Oct 2026 17:40:36 -0500
X-Gm-Features: AclHuK_waBcUE5jt710thOReYEcaNoXlOFQ7cNij63z-oA9tFI26Hbx-S3DtTtI
Message-ID: <CAEev2e8+fr1tJnSErD+2TtLDw5fGJbQOMcM5eefMnLyFUR+m7w@mail.gmail.com>
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

On Mon, Oct 5, 2026 at 4:53=E2=80=AFPM Lorenzo Bianconi
<lorenzo.bianconi@oss.qualcomm.com> wrote:
>
> > On Tue, Sep 29, 2026 at 03:10:11PM +0200, Lorenzo Bianconi wrote:
> > > stmmac_update_subsecond_increment() ignores the error returned by
> > > stmmac_config_addend(), and stmmac_init_tstamp_counter() discards the
> > > addend and system time programming errors, always returning success. =
A
> > > failure to program the addend (PTP_TCR_TSADDREG) or to initialize the
> > > system time counter (PTP_TCR_TSINIT) is therefore silently swallowed,
> > > leaving the hardware timestamp counter in a non-running or partially
> > > configured state while the driver keeps operating as if timestamping
> > > were up. This matters for TAPRIO/EST offloading, which derives the ga=
te
> > > base time from the hardware timestamp counter.
> > >
> > > The same hooks are also called from the PHC callbacks: settime64 and
> > > adjfine drop the error and report success to clock_settime() and
> > > clock_adjtime(), so a dead PTP reference clock goes unnoticed by
> > > ptp4l/phc2sys.
> > >
> > > Return error codes from stmmac_update_subsecond_increment(),
> > > stmmac_init_tstamp_counter(), stmmac_dl_ts_coarse_set() and the
> > > settime64/adjfine callbacks instead of silently returning success. On
> > > failure, roll back the partially applied configuration so the hardwar=
e
> > > and the driver bookkeeping stay consistent, and report the reason
> > > through the devlink extack. Also guard against a zero sub-second
> > > increment, which would otherwise divide by zero when computing the
> > > addend.
> > >
> > > Reset the persistent timestamping state (hwts_tx_en, hwts_rx_en,
> > > tstamp_config, systime_flags and tsfupdt_coarse) when (re)initializin=
g
> > > timestamping, so a failed init does not leave TX/RX timestamping
> > > enabled on a counter that never started.
> > >
> > > Fixes: cc4c9001ce31 ("net: stmmac: Switch stmmac_hwtimestamp to gener=
ic HW Interface Helpers")
> > > Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
> > > ---
> > > Changes in v3:
> > > - Do not run stmmac_config_addend() in
> > >   stmmac_update_subsecond_increment() error path.
> > > - Return error from stmmac_adjust_freq() and stmmac_set_time().
> > > - Reset hw ts configuration in stmmac_init_timestamping().
> > > - Link to v2: https://lore.kernel.org/r/20260924-stmmac-ptp-added-sys=
time-error-v2-1-beb2a6b5f866@oss.qualcomm.com
> > >
> > > Changes in v2:
> > > - Initialize sec_inc to 0 in stmmac_restore_subsecond_increment()
> > >   routine.
> > > - Link to v1: https://lore.kernel.org/r/20260920-stmmac-ptp-added-sys=
time-error-v1-1-8ac9e7a3fce2@oss.qualcomm.com
> > > ---
> > >  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 106 ++++++++++++=
++++------
> > >  drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c  |  10 +-
> > >  2 files changed, 84 insertions(+), 32 deletions(-)
> >
> > Hello, I'm noticing that after this patch was merged into linux-next,
> > boot seems to hang when ip=3Ddhcp is used because ethernet isn't workin=
g
> > on the TH1520 Lichee Pi 4a. These lines get printed in a loop over and
> > over
> >
> > IP-Config: end0 hardware address 72:ca:a8:eb:27:[   24.872982] thead-dw=
mac ffe7070000.ethernet end0: Register MEM_TYPE_PAGE_POOL RxQ-0
> > f2 mtu 1500 DHCP
> > [   24.900412] thead-dwmac ffe7070000.ethernet end0: PHY [stmmac-0:01] =
driver [RTL8211F Gigabit Ethernet] (irq=3DPOLL)
> > [   24.912780] dwmac1000: Master AXI performs any burst length
> > [   24.912801] thead-dwmac ffe7070000.ethernet end0: No Safety Features=
 support found
> > [   25.010229] thead-dwmac ffe7070000.ethernet end0: PTP init failed
> > SIOCSIFFLAGS: Connection timed out
>
> Hi Anirudh,
>
> based on the reported error, stmmac_init_tstamp_counter() fails with
> -ETIMEDOUT. In particular this can occurs if:
>
> stmmac_init_tstamp_counter()
>  -> stmmac_update_subsecond_increment() -> stmmac_config_addend() -> -ETI=
MEDOUT
>  -> stmmac_init_systime() -> -ETIMEDOUT
>
> I guess we should understand which one is failing and why it is failing.

It seems like both are timing out, both config_addend
(PTP_TCR_TSADDREG) and init_systime (PTP_TCR_TSINIT).

Regards
Anirudh Srinivasan
