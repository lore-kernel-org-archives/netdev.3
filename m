Received: from mail-lr2-f32.google.com (mail-lr2-f32.google.com [74.125.230.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1866C48987E
	for <netdev@vger.kernel.org>; Mon,  5 Oct 2026 13:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.96
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791206741; cv=pass; b=RO6H2KzHhODyd07ozNTvLrcuGStAoMP9Hg9I8FNmLWo+V6TOsNZ3CTbBCmmV9U/eRzCJ0EsOjzkvTHG8GlCtlRltQMOJ+HUP8/xgC1zt/iwt9rIbIwz788BQPAALiOL9kLKpZ87jZ7y+Q/cLDW5fOKqHiDtfhqrX2pz8+TRohUA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791206741; c=relaxed/simple;
	bh=wMm4+8IRfPPcvvBENvkGYtZvw+exf4jHBcuNGRKviqk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KepQBaDhib+t8fzw1S1Mzj/3BrsbpaC47KqJq6osHyKhCI9LihkExatdrJ+aBK4uOg4jrQoptjEzCynXOHPEA7nz0gTeEUIJVVivURuftoRDxn5rnL78lZ60S2CP+RI4nwGAkljmW/P6HFytuevnO/5yUFkJk1XvALky0WwbA2o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cellusys.com; spf=pass smtp.mailfrom=cellusys.com; dkim=pass (2048-bit key) header.d=cellusys.com header.i=@cellusys.com header.b=cFyvQCLj; arc=pass smtp.client-ip=74.125.230.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cellusys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cellusys.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cellusys.com header.i=@cellusys.com header.b="cFyvQCLj"
Received: by mail-lr2-f32.google.com with SMTP id 38308e7fff4ca-3a973a4670eso17159171fa.0
        for <netdev@vger.kernel.org>; Mon, 05 Oct 2026 06:24:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791206677; cv=none;
        d=google.com; s=arc-20260327;
        b=joApNKglu9bEIQC4MHhIPM5tZpXNsN35oqHRTDovF7BQUTmCiZnr525/QeUGml9XGG
         aejyWYDr3/+d7GDUPHKTUIMERBU5FJZPW6Zwpwvj5Xu0+GyYZoGgFiU0PAQUdg6L4NkV
         zl4ElGq6qJqf43Lr/mo6UO5iknOTaKL3JOhXHMsBELWniwcTchbyW7xe4DG3+6ViGyJ6
         wLFblffvzghn6je7q0moItnstlviurAz1ce0UsXQRIBPlCoEKGivFD4SDCcEQHDYY/0n
         JP0h6jCAETp28ar/JnW2ANE3LxVL23J4RJVR529ghOfuWtYs+1mjvGwn4Uh/Zu1hDA6l
         QwQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wMm4+8IRfPPcvvBENvkGYtZvw+exf4jHBcuNGRKviqk=;
        fh=8crkVTWfRs5+5gt0t1oO3xyNbQiLaaIUE4IbYfC5jTE=;
        b=SK433VRPIrYWpKD6HE8c99yWWgZUAlfE1kheITROwm8PqzISy0plSUTcFuW4PiM77k
         X2JJuHMBw/8AJN6GFldbnjuoPWG7s9nK8GkZK4IUmv53ttKSY5VEIoUAKHp8/3oVPIba
         PxfgJDNbH+CQBt475LCMS1byx2jj0urn5Hdfz4jIVuVTRDiN0uOC5I5UzL9AQMBzUfP6
         VQngXhp9aCeKYw/m1+NoVH13VT8x/KlDNmD2ZAtafGvrwMracBs0pexNtJOzMnPdVhzL
         oddp9cHI3ZR1cyjEp5FK7Md9+9iSqq6Vr0PtRkigXVRC/G+TCF8mAD7tBOf9VLNNg9Of
         gE4Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cellusys.com; s=google; t=1791206677; x=1791811477; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=wMm4+8IRfPPcvvBENvkGYtZvw+exf4jHBcuNGRKviqk=;
        b=cFyvQCLjUypgXcmsl0fZCDaFYajMu8sADXXu+TiJuRALLKmP4XgkIenuBaNzG9ZeDL
         Cf35oe1gO321Dr/V/lBNdtIAdmTyqHtDI8t7XResfKJXkfjV+Me+M0j04p2QzynGF22A
         g4oA0O4cbiH0QTEDQBonFdhxR9HibewcM7T7EGt6fv214ieZyYsm+GQa7UaglUXVrUmo
         4R1PoBuSsgeXkn0m3jH5X8Jnguywjz9NBKHuu6KKJElwZh6FUykY3jkz4d+jzR/ELplv
         Y9YdmJJ1r1W0uTBventWqIoWnGbkpW1DcewtD9fCvy5qUEBaRs7SWHj4j6dBwwS+YX66
         xdjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791206677; x=1791811477;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wMm4+8IRfPPcvvBENvkGYtZvw+exf4jHBcuNGRKviqk=;
        b=2nspjP6WiAWbnKw/R8INmyfBR5Z3AeKW35DCu4GgG1c+KorWkkZH88fx8tu/B2pv8T
         oyKSpYgAKPFR7g5SgEeCJ0PLHlP6BoT5RgNFC3yALA/y/YqhaV7sdYCGpJ36CeKYIfzp
         9thWQwT+71nPsdysJQIKl+UmrDLbFM+bZmk4Y62vYE1M6BEJLry4EgD3xHSEPQLBxN6O
         J+UGMBsDrBeT+3zAbZF74Fq7dG3drhe11SQuS6bryomz1xRx8AIfq79xvg5FgaQUWhlS
         WHtAcCthWOlq0fvGcNPDBQkbdo927rgMjrAT04q7B5RgwZtYO0wEYul7oiIH9DSMTeaZ
         Q5Sg==
X-Forwarded-Encrypted: i=1; AKwUvBwIBkIC/WgadgAIkUuEIlJ75wgGYw3wxYdNKpKsV9/j9MnAgTUjcZY3NzD9A+FHCwV2yBYdj7w=@vger.kernel.org
X-Gm-Message-State: AFq9FYJUXigAGqMRYYtIYwPww0YFwpvyHNqm4RodOJ5XYzQnzTdiOQu4
	T6PbJblNs8tn0O4FuuyjrbVpyuHeqk9fhQAgxEfFY8qc+OIuhu+XXCZ3LtW8QYeuDJm7Vpa3A7h
	tegkypNUugSSjgJ+uD/XLQZ7yhk2+U/LlZhdVAqvFyA==
X-Gm-Gg: AYBFou3KmDRYs8eA0tlWFXOlv0NFFJVsQxCEKSUAzR1Nd56r3ua5EIeKYa3ShtmTCGN
	Axz5ojyf2QDrRKxGyHt2R7Ag00xvPOuGzR+jUrjYctg62u3L50L4x8A+sci+lQ46ERd/Nk2BspL
	W5GhtmbutlVX2JhcYTGoYAOoq1YvLRjzPBKKcTFkrdygwBf43iWoEPocUu02+dLgYv6V2wIBm7G
	r8D0OR3GlmA+AOg9I9m7x1/8KiL4oee3gGP8ocBrL8DXDZjDe98ERFkyDK9QYvEamQ3ZluGQ314
	BnLgup677viqRnGMdiRpwtXjbwnjbpenDTnlcSyFP4vFgNL1So6a+rlkwMdPE+v6HQ==
X-Received: by 2002:a05:651c:15c1:10b0:3a9:8546:ee13 with SMTP id
 38308e7fff4ca-3a98546efc0mr6805921fa.19.1791206677180; Mon, 05 Oct 2026
 06:24:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260928190401.1641260-1-wbriggs@cellusys.com>
 <179083835206.434549.7959555054670908229@kernel.org> <CADvbK_fps4LrNX36j-MBpFmc-S5bQXhqkBgz+HC2RRuCvhdBXg@mail.gmail.com>
In-Reply-To: <CADvbK_fps4LrNX36j-MBpFmc-S5bQXhqkBgz+HC2RRuCvhdBXg@mail.gmail.com>
From: Warren Briggs <wbriggs@cellusys.com>
Date: Mon, 5 Oct 2026 09:24:26 -0400
X-Gm-Features: AclHuK8ql_DkcT0uZ-eQZibVFIA9uOYVqWoejjFf20pjZd3FIRsV8Zs4rsgIXHg
Message-ID: <CACjaXw61gk_5OFcaq4SxNCWqZJEx9j0U80_J7F83BAmHRxkD0A@mail.gmail.com>
Subject: Re: [PATCH net v4] sctp: carry peer capabilities across an INIT collision
To: Xin Long <lucien.xin@gmail.com>
Cc: netdev-bot+sashiko@kernel.org, marcelo.leitner@gmail.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	horms@kernel.org, linux-sctp@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Xin,

On Thu, 1 Oct 2026 at 12:11, Xin Long <lucien.xin@gmail.com> wrote:
>
> On Thu, Oct 1, 2026 at 3:05=E2=80=AFAM <netdev-bot+sashiko@kernel.org> wr=
ote:
> >
> > [Severity: Low]
> > The commit message describes this as an INIT collision fix, but doesn't
> > the same code also run on a peer restart?
> >
> > Could the commit message describe the restart path too, and could that
> > path be tested?

Yes. The commit message will cover both callers, the INIT collision
(dupcook_b) and the peer restart (dupcook_a). The v4 testing covered the
collision only; v5 will add a peer restart test, with ASCONF and
RE-CONFIG sent from the surviving association after the restart, and v4
run as the control. I may need a couple of weeks to get to this.

> > [Severity: Medium]
> > On the peer restart path (sctp_sf_do_dupcook_a()->sctp_assoc_update(),
> > state >=3D SCTP_STATE_ESTABLISHED), only the inbound counters are
> > re-derived here. Shouldn't the outbound counters asoc->addip_serial and
> > asoc->strreset_outseq be updated as well?
> >
> > Should the ESTABLISHED branch take addip_serial and strreset_outseq fro=
m
> > new, next to next_tsn?
> >
> This looks a legit one.
>
> Since asoc->peer.asconf_capable and asoc->peer.reconf_capable are updated=
,
> we should address it in the same patch.
>
> So please follow the report above to update addip_serial and strreset_out=
seq in
> the ESTABLISHED branch.

Agreed. v5 will take asoc->addip_serial and asoc->strreset_outseq from
new in the ESTABLISHED branch, next to next_tsn. On restart
sctp_tietags_populate() keeps our initial_tsn and sctp_unpack_cookie()
bases both counters on it, so new already holds the values the
restarted peer expects.

pw-bot: cr

Warren
