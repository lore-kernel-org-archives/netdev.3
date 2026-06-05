Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C135383C94
	for <netdev@vger.kernel.org>; Fri,  5 Jun 2026 18:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780682969; cv=pass; b=iLGDQkB7fo8osWEcVTBcHB+bjoQ73Jk+0AGAzHuVWNC+YLFGSA85cofzXth6x9aM2DoaTTsBg9EFWvyT6QRruEu2URH4qzIKxnr4EWh17/+8DmghvuxXx9231DoizBPvz7pWEnLmFQTvndXf7PZx6jElwSjH/SqglhM5JWzRMLA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780682969; c=relaxed/simple;
	bh=+tGN2Gbd5XNQv6kqDrk16jTZ7vSM1i8VmXiPpbOw1tQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gPBUiHCFRqcQoYTo+/beaUhs0fgDduNs98Dtx9ID0/T+IxHxdpNu4GDM4rPFTHi+t/B4fno6rxZ7IYqhUTf4KkMF29KxBzNuNyPrMHRsFm+gzdySXZvI1uVutx7uNPfF03eBGtS8Ys2iEczmquOTkX+RrUvygeAH/2SAidwVqLQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SVnPf/tv; arc=pass smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SVnPf/tv"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-7e053987001so30031107b3.0
        for <netdev@vger.kernel.org>; Fri, 05 Jun 2026 11:09:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780682967; cv=none;
        d=google.com; s=arc-20240605;
        b=kPGchwF2/v2QoB5Y/obdsjr2fdTXqNCVEgckxnkpXcQ6kDqAWveZ2zL+RDVk/X8jqP
         BR0kIf/0UunV834lsTLBP3swXwPCQsacti4fYcLfen2tD/alRq2kYAm2qX4eRwYPxQwm
         ZtfRJDcQuKipaSkyZw2xJ7nNsNwAcKlM4KDuGNLo9lOEnMJkYvf455ovFNT6eB7aRxPa
         uExKmPyUepVBgLrnzhU3OzasDHnBQonx5jUAGuJZ7fTxbm2bEANyfFXQkiClW2MTEd/9
         RCln9QK8x/UbmIVgjj7aehMpo/3i7VBw9ekvrPojE/CwgNtTQ4s1tRw91VJmwiubPMnF
         vVkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+tGN2Gbd5XNQv6kqDrk16jTZ7vSM1i8VmXiPpbOw1tQ=;
        fh=aiyPmISDRM7kJzEsv6lIj4g2hcA18CX0DTaYKkS3J90=;
        b=MQco5rkw2IICxim2lkPUyzVc3+IvcbRWozcUtdT8cvfbTurHwhhwrl0Ux9keS473wO
         Z+mljILMlDetHrryzME1319/ohaKp9DjZUYFjDgLUMH9sTuclbAp5N2s638RyEDbOhuB
         wcCH93hsITU4N0FMToWnip/eG6Y/MxKy/J4Ceg0jTUIbrwZu4kh43KMw7g2Yr4crypEC
         S7dArgYadLeevT1dfQR45FFRDarM2pmYlyrmPvmys982sKFtmQEaUapfAQXwgBSehv/Q
         iEsLmioPMjt1uY1fwj3cnhvEMU41EwRjWolSZVlFHIEEppm3VN3+zd32c00bP+mWlA4R
         qWsQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780682967; x=1781287767; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+tGN2Gbd5XNQv6kqDrk16jTZ7vSM1i8VmXiPpbOw1tQ=;
        b=SVnPf/tvPQYmQaWHp4ty5uYXx7IgrDg2mOyurFfQq/I697476IlxV0eP/F+qvoTfnY
         DN6wl4sR/Y9FEOotH5CeCCZShfsvXIgqoSZ2U17PFAkP46IaDFJejh06WNLu5p7iPKp3
         K5i1TX3saHtRBdKsGLvH+VXjSFo2nX0PN4KsUwcerPcOlxG3wif6xF/ByKU58gjd+qBe
         CFMukAsd8PlrU5YdeMsMZMWye02yTHQCNhe8K+0R1OFckOTgK/s9kG48tqmUQIJtbT0x
         Nuodrq8t53RBlYPm9mpG7yL5UM79JimsCj+i6z60SUZVaVXJ9Qx0LXmN55fig8zV+u47
         3+lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780682967; x=1781287767;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+tGN2Gbd5XNQv6kqDrk16jTZ7vSM1i8VmXiPpbOw1tQ=;
        b=GWUF8fajy67b/34Oyqh//z5k2R/E1ql5vGjQwva6iBUNoMZ2TawDEBg04BSFO3xuFr
         iA9uJK2U20o9dXI8EcCD92P9OMbHj9IncEyoeKh56dTFfDaQeY6UQiTsXICg3K7UiC3R
         YNw9WUqvRfBUcKLeyhFMKFlwGeOIhUNlc54KzqkyrJ7jA/J5n1lXZR+Fl0/JWD55mIsX
         3gWe7hMmZLrijhTIY2LRD4dBOZoLJ+v8mouZxQ6gUwRNTsSWKCwkcFB0QePAloU1kxw2
         E1+b8T6kPXC8EZOYSCNZRjc2CbUf2GSqlUWfVxJhYzbXYIocjLrGL1wQN1Bjps9UkjuT
         Z+8A==
X-Forwarded-Encrypted: i=1; AFNElJ/B47LzomNTzqRpY4QlKA4Mifo2IIPXgmuHGyIYRiChGkDYc/fcmveg0qGwIocnAhy9aW0wcYc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSSA+Gqwi+37GKArEv8/ZtUEHTjdcBgk35Z2yGAG1/FgGAm7ke
	jLGfVmolGTLrB/DAnpRB+lzEzDHsfzFp1AwhiaZB0yeUxPG3gWlIVo7ukwxQcg5DZl7WvqhY3Nd
	TeoYzBwuWLDxNeydyTj8qMGJ2M7Ai17I=
X-Gm-Gg: Acq92OGVpNszVTMrAdIye4kQa2Qb2bAUDmjtOAbV29nKX6zsskkJud+VwNZbAjnoN9K
	2pAE321gwGahXQXn8LBIxVVD1StProQ+uuih4XbBIZIIXtA/Ylu3Q5uG2PxaAfCW49KFGw7KPfF
	knfFwlVb9DGEkUmhJpuA2kwp5VeEZPtnYR9f4SNJif6oYg1Ln803WMU9v1WbnriySsAIapgQwip
	545jqx9kiqxnwaVIikc/bU/HVmRwlrjPPxpCtCAvpes0h+BzV4ULDs1iSsqYlIAoWkELbQ3zV0Q
	gn+sDM8/cHlfNm4pQcqqpNYdfPi0y34uIgo1dCZEOEjx
X-Received: by 2002:a05:690c:600f:b0:7bd:a6ea:c50c with SMTP id
 00721157ae682-7ed516400b7mr27415387b3.15.1780682967473; Fri, 05 Jun 2026
 11:09:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260604220904.1032145-3-ameryhung@gmail.com> <a5988106169c7350f39a4d07b36b679a5fb39cda49ca371cb79c23da7b63971d@mail.kernel.org>
 <b4302a13ccae77b304a09b47c58565c8ff1970c2.camel@gmail.com>
 <CAMB2axPLpxk8fh-Qp2sGwtsZBCE42DLo+h8pB+ObffLifP9aZg@mail.gmail.com>
 <CAMB2axOOG3ptDkWvTDpGut+EmDeroe3GPR3obb-Br_Dg1aGmgw@mail.gmail.com> <6d86c2fae9be63eb110ebd5b3fc19bc4cf1de2dc.camel@gmail.com>
In-Reply-To: <6d86c2fae9be63eb110ebd5b3fc19bc4cf1de2dc.camel@gmail.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Fri, 5 Jun 2026 11:09:16 -0700
X-Gm-Features: AVHnY4J3-fQZb3RAbqdWeoIKN6ciyIVNP6qjMWxwAp_5IUqS_2V4BVceYK8dAzc
Message-ID: <CAMB2axN3phpufSt5SFj60Q19w=1NWpOks4ykgZ2Q1zS_5K300Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 2/3] bpf: Compare parent_id in refsafe() for REF_TYPE_PTR
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bot+bpf-ci@kernel.org, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	alexei.starovoitov@gmail.com, andrii@kernel.org, daniel@iogearbox.net, 
	memxor@gmail.com, martin.lau@kernel.org, mykyta.yatsenko5@gmail.com, 
	kernel-team@meta.com, ast@kernel.org, yonghong.song@linux.dev, clm@meta.com, 
	ihor.solodrai@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 5, 2026 at 11:04=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Fri, 2026-06-05 at 10:57 -0700, Amery Hung wrote:
>
> [...]
>
> > Actually, looking at it a bit more. I think I would hold on changing
> > check_ids().
> >
> > This patch should not increase idmap usage. parent_id refers to id and
> > therefore check_ids(parent_id) will reuse an existing slot.
> >
> > The id_map is indeed more likely to be triggered since there is also
> > an intermediate reference for reference dynptr introduce during the
> > refactor, but that should still be very unlikely under normal usage.
> > check_ids() also already fails in this scenario by returning false. So
> > overall, I am not sure if we need to change it.
> >
> > WDYT?
>
> I agree that it should be fine to just return false from check_ids()
> if there is no space in the idmap. However, since not all ids
> correspond to register/stack slots anymore, I think that
> WARN_ON_ONCE(1) should be removed.

Ack. I will drop WARN_ON_ONCE(1).
