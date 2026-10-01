Received: from mail-vs2-f38.google.com (mail-vs2-f38.google.com [74.125.227.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BC6E3164B7
	for <netdev@vger.kernel.org>; Thu,  1 Oct 2026 08:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790843484; cv=pass; b=MypMkHOR2/wWdJPB0ZbHVVSPUWKSoYeQyhkZ8ng4fGCLhyPbMrI2mAAtcjPh60a1QslYQgyFngDYOl0c4ZUaDoQrDM6UDBhx07/18P22Vr84e96gQGaRfVhFpuZu9VoaXgh7kNE89Vo4Fg9adlC8dT5vf5pC76LVma+/pTeAw2g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790843484; c=relaxed/simple;
	bh=S6nhg02pIj+SO3ygvr7Yf/yjhAnAdUb1rhRonxomtvc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bYER/ahoCMSXgcKICi9HunNaXKLdORyDhRZvhgRl4X5HRA1EmSJkSVZEMx1JARo7Ielz+09yenIpS/uYZpC00pSCED9mfyKrc2rYcyslXVqRx4/uIAo0zg+m4q2f2VaLBxGKY05ZessnWBLUHS/cmJ8hqQM68Xnv1LeoK+1JhKI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ohBu2qHT; arc=pass smtp.client-ip=74.125.227.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ohBu2qHT"
Received: by mail-vs2-f38.google.com with SMTP id ada2fe7eead31-7c074c0a1dfso2838137.3
        for <netdev@vger.kernel.org>; Thu, 01 Oct 2026 01:31:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790843481; cv=none;
        d=google.com; s=arc-20260327;
        b=OZDwkuAVa6AZgeJ3hat55NLNCAevS/pk2ED5tkwW8jgkaZCyWY4aFPnHLxlqzgITzp
         pDEJMgh33s0hDZy5J6FdFzoXZUqtOgZtazXxDxDqzvtvTJ7D0vexupJn2INliKvBlsZB
         qf3yo2x4zfFJV1QwfVwwQH3F0rrRKOjb7J+/9o+rLh6I+Bp7qgz4N2/bFqyY1oMxDzrS
         Yiu/KheBDAErk5zHcQdWBkfxhvdsuzHHZUvSDEpJdUN2lotC/YE65sxxxulYc5d70Fue
         2sRfxH+3GKlykY7ZejtDqW20/r5lQyDEfl4NMljW03J7xa/HOT634RwjlNeEb+m4E2gv
         8hWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=EU0sYZ/FO/mx2+yJVtb2c4Or0T6adefpzzLzs+MHc/0=;
        fh=lJqbN3goz3OF5PiDsn0WL6U3PyUmkh/6OG0UmKMcruY=;
        b=BaFimcO6wHyySh3zWjXoNHZEyfpF/qb6/vgspXYUt4IWAaNq/rTYV60R1nbb/bbJQA
         bn4/uW7kquIXMCaMkdUDJvOevdLRlTaKdm1FA0dm74RY1QoII83VXtq2FDfqnixtuZn9
         AA0LQgikTOU2hgFftu7T7gpUAJyuCH5YgEK47OWeT0P2Nsc8SfgbghTk8IyUl7fPHyzC
         +khLUy4mPN8GI6Qn6oziJg5TejwDrxSRzmaKbxuSGHViUHy0ioocG4JHEHXNP8zIaqKw
         D+yYv8W/Yy+Zqj5MuPYuAD+oUmzuOLul9t9wY9uKLPKIFyWUfS5/MEasElbCU53UKgR3
         lkDw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790843481; x=1791448281; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=EU0sYZ/FO/mx2+yJVtb2c4Or0T6adefpzzLzs+MHc/0=;
        b=ohBu2qHToOlHPjPSbXJLKC+gn6Zo2CZFp4Ng/pfIBSC4Ix+hFL27JjLr+8cS8Gr3LW
         Z85cdsOzXelCiGihBZSv+rcLs/V3AN+Lcaw/bOi0pfF5RJDUODCMdv/TSyBtP1/MW4V4
         4r6TMtvgRuoIT3dpuxiaDWnxsqh4NS9sjJab8yAY9/XQpxR+adnoS1Mvw7sMsn1gWfoh
         skmnnp6mx2s0ylXBocAN5hm0clj9KRGl8aQAxLOOaOLNNforhcTJ2XK6FUVtmTgMDPBP
         wF8IjQhVKblCCiX7hVXi2d+V3U1Z5IgYW+H/9DANFyUxoawd8nFESwXzkOBcL7eJYZ3M
         raXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790843481; x=1791448281;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EU0sYZ/FO/mx2+yJVtb2c4Or0T6adefpzzLzs+MHc/0=;
        b=U/hbDkEUdVnb+rDFQKnuELQn9UWmC/fn75guPCGiV5dO5uP5U7CHFVnDmGrLjVeusU
         v1PciyC5tY+Tuixae4+g/Iz/D3dg6BNUYaBTTSA1b0D8SQvxRnYMXPbz6IwX5xIcL4b/
         m3XBkiI4PiAYy/OROzEqtmVwKaheuVLBg5jQLbl5QpKl+rpo42Qrg9NhTacIRMnKA1Ax
         KVVjx0tOZsfeT10s6IAity0NtquV+TULOxAI0t3Ps+xbdf7rdicp35g4DJhHX4Kh4O1J
         TmwJlcMgPuuFxb9GPr+a+qbIcGlZkML4QmSZg5j29WH/xut3w6ViLH3MLKhK9dOFB7Kq
         V5zw==
X-Gm-Message-State: AFq9FYKDdIcuDfqXMEdGJW3s6zy0Y8B3XeAe59jDjMzEmRh3k4ovda+J
	kDYunXbZNKY5hVo93KQBzwsccz4TevpjPSOSKw4pxMB1WTDzvTP5aal7K3jnUyZKEnbKI8XWONK
	+Ip/paaCreAYf/MjPu/wQbuWa+Pl6GTs=
X-Gm-Gg: AYBFou26xXKKbwHXYuTGvodklpPEzwjJYiXcsJV16LRxBWktrE8fP+u8+sXCMzTXw4h
	k3Q8dMrwq6y59eMCiKhOP3XK1neSsFlcqf+49uQlJ/dopTGambx02DlF4lD89FamjSTYUgKSxjd
	lydfZMcstFr+c/ImrNiVzvGmKDaDRLETkJncc2GHhDoLx6XSzg+6UpgSJOfxp27HKTlmPE1mYDD
	AlHpOKfNfuLrfn93bNDOlrfhaWdL1DbOcyQ6wvEnKR6GeS8oD9ylhKBzXMFNEAQQ3sJBqUdIMy7
	6yzMWn/sH4TIZlCiRgiGWpJfDTRlclfuide9M0x4PtXoGWm3MC73/bEdxQ7nQ8lKT9dieWliFS9
	NcFMkgvnN2QgdPl5eFb8dEU+9q74Bszt08xMKeM9b7qrNIG/Gz89XZokeGqmMT5rBBGEB6xgU3k
	jvVuGV9fTFln1YjsS8nZDtyT+T5NGQaTzVqeTSyoBdF1vg
X-Received: by 2002:a05:6102:3fa3:b0:7a7:198a:c2bf with SMTP id
 ada2fe7eead31-7be735975ffmr902214137.29.1790843481357; Thu, 01 Oct 2026
 01:31:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260930-stmmac-est-reapply-after-open-v4-0-9d4366587b73@gmail.com>
 <ar4QgHsclh1vWVHk@lore-desk>
In-Reply-To: <ar4QgHsclh1vWVHk@lore-desk>
From: James Hilliard <james.hilliard1@gmail.com>
Date: Thu, 1 Oct 2026 02:31:10 -0600
X-Gm-Features: AclHuK_sh2_y0gAgCI9ChdR_dvfCKXwH4PgjB21fl6342cXclcDVA9-LiyvPKRI
Message-ID: <CADvTj4rxCuL-BNq1P3KW=1m==0PDMvn7j1=J4WW1yZLJfw5DNw@mail.gmail.com>
Subject: Re: [PATCH net-next v4 0/4] net: stmmac: preserve and restore the
 installed EST schedule
To: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Cc: netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>, 
	Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Jose Abreu <Jose.Abreu@synopsys.com>, 
	Russell King <linux@armlinux.org.uk>, Eric Dumazet <edumazet@google.com>, 
	"David S. Miller" <davem@davemloft.net>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Serge Semin <fancer.lancer@gmail.com>, 
	Simon Horman <horms@kernel.org>, Maxime Chevallier <maxime.chevallier@bootlin.com>, 
	Richard Cochran <richardcochran@gmail.com>, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, Rayagond Kokatanur <rayagond@vayavyalabs.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 1, 2026 at 1:49=E2=80=AFAM Lorenzo Bianconi
<lorenzo.bianconi@oss.qualcomm.com> wrote:
>
> > Continue Lorenzo Bianconi's EST replay series with v4 of the unmerged w=
ork:
> > https://lore.kernel.org/r/20260902-stmmac-est-reapply-after-open-v3-0-e=
72a6df5a7ef@oss.qualcomm.com
>
> Hi James,
>
> My plan is to continue working on this series (the code is available in [=
0]),

I compared your b4/stmmac-est-reapply-after-open branch at
e7a2792034e0 with the EST v4 I posted. The first two patches
(embedding the EST state and passing an explicit enable argument)
are equivalent apart from the additional sign-off.

The substantive differences are:

1. Preserving the installed schedule on replacement failure

Both versions validate the gate list before modifying the installed
schedule, so both preserve it when an entry fails validation.

Your version then overwrites priv->est before programming hardware.
If EST programming or preemption mapping fails, it disables EST.
However, TAPRIO keeps its previous schedule when the driver rejects
the replacement, leaving the driver and qdisc with different state.

My version builds the complete replacement in a separate object and
publishes it only after programming and preemption mapping succeed.
On failure, it retains the old configuration and attempts to restore
it, advancing the old base time by whole cycles against the current
PHC time.

2. Restoring EST before starting DMA

Your version starts DMA inside stmmac_hw_setup(), before PTP setup
and EST replay.

Mine moves DMA startup into the open and resume paths, after those
steps succeed. This keeps DMA stopped if EST restoration fails. I
wouldn't claim the earlier ordering necessarily transmits an ungated
packet, but the later startup gives us a stronger initialization
invariant.

3. Serializing EST across a PHC time adjustment

Your adjtime path releases est_lock between disabling EST and
adjusting the clock, then reacquires it for replay. It also ignores
the disable, clock-adjustment and replay errors.

Mine holds est_lock across that entire sequence, so a concurrent
TAPRIO operation cannot replace or destroy the schedule partway
through it. It checks the errors and attempts replay even after a
failed clock adjustment, while preserving the first error.

4. PTP prerequisite version

My series uses the newer PTP error-propagation fix already merged
as 8181678a92f0. Your branch carries an earlier version below the EST
series. The merged version also tracks PTP enablement and handles
platforms without a configured PTP clock rate. This is your newer
upstream work, rather than an additional change in my EST patches.

One limitation of my version is that rollback remains best-effort:
if restoring the old schedule also fails, it logs the failure but
retains the old software configuration. Hardware can therefore
still differ from the cache. Neither version guarantees recovery
from that double failure.

I'd suggest retaining the candidate-schedule handling, later DMA
startup and adjtime serialization when consolidating the series.

> I am just waiting other patches to be merged upstream before reposting in=
 order
> to avoid any conflict. I guess it is correct to publicly ask before posti=
ng
> other people patches.

I guess I had assumed since it had been nearly a month since your
last series that you just hadn't gotten around to spinning a new one
and figured if you were still working on it then my changes might be
helpful either way since I had reworked a few things while working
on a series depends on these changes.

Feel free to take back over and incorporate my changes into your
next revision if/as appropriate.

> Moreover, this is thecnically a fix so this seires should targed net tree=
.

I think the fixes you may have been waiting on are in net-next, which
is the reason I did not target the net tree.

>
> Regards,
> Lorenzo
>
> [0] https://github.com/LorenzoBianconi/net-next/tree/b4/stmmac-est-reappl=
y-after-open
>
> >
> > The PTP initialization fix from that series is already in the base.
> > Carry the remaining embedded-state and explicit-enable preparations,
> > and restore the installed schedule after open and resume reset.
> >
> > Build TAPRIO replacements separately so rejected updates cannot
> > corrupt the installed schedule. Rebase the previous schedule against
> > the current PHC when rolling back a failed hardware update, and keep
> > DMA stopped until replay succeeds. These changes do not depend on
> > the later datapath recovery series.
> >
> > Changes in v4:
> > - Omit the merged PTP initialization patch and adapt the remaining
> >   changes to probe-time PTP locking and current TAPRIO error handling.
> > - Separate schedule validation/rollback from open and resume replay.
> > - Reuse the base-time helper for replacement, PHC adjustment and
> >   rollback; propagate errors while preserving the installed cache.
> > - Start DMA only after the installed schedule has been restored.
> > - Link to v3: https://lore.kernel.org/r/20260902-stmmac-est-reapply-aft=
er-open-v3-0-e72a6df5a7ef@oss.qualcomm.com
> >
> > Changes in v3:
> > - Guard priv->est.enable update using est_lock mutex.
> > - Embed stmmac_est in stmmac_priv struct.
> > - Rework locking in tc_taprio_configure().
> > - Fix possible divided by zero crash in tc_taprio_configure().
> > - Add missing reconfiguration during stmmac_resume().
> > - Honor ptp error code in __stmmac_open() and stmmac_resume().
> > - Link to v2: https://lore.kernel.org/r/20260829-stmmac-est-reapply-aft=
er-open-v2-1-5e5ccb185e92@oss.qualcomm.com
> >
> > Changes in v2:
> > - Rename stmmac_est_reconfigure() in stmmac_setup_est().
> > - Rely on stmmac_setup_est() in tc_taprio_configure().
> > - Link to v1: https://lore.kernel.org/r/20260825-stmmac-est-reapply-aft=
er-open-v1-1-dfa80735e0a1@oss.qualcomm.com
> >
> > Assisted-by: Codex:gpt-6-astra
> > Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> >
> > ---
> > James Hilliard (1):
> >       net: stmmac: preserve the installed EST schedule on errors
> >
> > Lorenzo Bianconi (3):
> >       net: stmmac: embed struct stmmac_est in stmmac_priv struct
> >       net: stmmac: pass the desired EST enable state to est_configure()
> >       net: stmmac: restore EST before starting DMA on open and resume
> >
> >  drivers/net/ethernet/stmicro/stmmac/hwif.h        |   2 +-
> >  drivers/net/ethernet/stmicro/stmmac/stmmac.h      |   2 +-
> >  drivers/net/ethernet/stmicro/stmmac/stmmac_est.c  |  47 ++++++-
> >  drivers/net/ethernet/stmicro/stmmac/stmmac_est.h  |  13 ++
> >  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c |  38 ++++--
> >  drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c  |  59 ++++-----
> >  drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c   | 142 +++++++++++---=
--------
> >  7 files changed, 176 insertions(+), 127 deletions(-)
> > ---
> > base-commit: 1631d79ae57dce2c5f88ad278307028638a8b4d9
> > change-id: 20260824-stmmac-est-reapply-after-open-181d70a15eb6
> >
> > Best regards,
> > --
> > James Hilliard <james.hilliard1@gmail.com>
> >
