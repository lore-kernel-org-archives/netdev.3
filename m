Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE9E21C695
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 07:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791876248; cv=pass; b=dk++h7nRYllt3QHrayHRjgYsuFN4GDWDA49GpCGkTsxxoMoJt3Rq6raNqvhAscRjbWFoYwRwb/lMrRLac9MpDQl76RSivTwuyw4oaVfB6s4EaSD18/mQq9lDFVCDRUbp1gsC8LhG5u1mtCD/2ADI5B5vLEZHAVmvJ3B4A79vBjs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791876248; c=relaxed/simple;
	bh=8c8qzrIDua9rdsslWbYNQac15oquSC2GLafIVv4uncA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZTJzhXMnl61Ac673gW8y9untxp9wFCIm9qCvxeAWj8N7a0emk+47NG8O9lcgAvvUJp7M6n+gVpCLf1ksV4wG5z9x3LCEXGMUcRQCpB+lZ1lG4omfKlmIb6FniwSsqwx0RjAl5eeDY4e2cRfLiLCl88AFTsT5q6U+tqD80LJS+po=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=M7JPM+47; arc=pass smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="M7JPM+47"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6ae14eecc64so3469221a12.1
        for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 00:24:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791876245; cv=none;
        d=google.com; s=arc-20260327;
        b=lLCBir3ivF6uxn1CYmMzFolUuuH11/bQB2biso9KMFcK18ofXAn3PcW28HU1Iz2l+o
         41voNvF2nsX4cs6JLhY2E9XxAwJZVLdjBagj77PKSqZWfzbQVb4PUTmFQ1pQRjsrbUAz
         uhOO6qLThnAOGymFI6qI2GKtoxucvpAo1nLo1OgdV34+/gZE2bzHKZ23xEucGI1Tdnfn
         WxCMPns8D5angsjqWkZXNMBRa/R2WENFLkuXR4be/s8/MS94T27ahnWtrfn8hBWmuHP1
         jHq2UcMt9x/TpC6m/YSBRkbzlK28s93FeiCVADpRryzdL57//cvthOv6PGuZPR3WRwo8
         eOgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=O1lANuLy0aZ+Adig45dLI6SKNG46/rOFHE6t5T71VGg=;
        fh=bgzUZUwUG7uz65+IhV9GI6JQvGYD8Rd1dsdnlxlECeo=;
        b=fNDIGWGVNTTBQq9MCNBMJtFJh6zLOYwXEOzSMKXnEf/Iz+v/D7RLmVo/7XDVvtcUtB
         rF2VBcc0cKsXAOYNvkmnzE6fSgW5Ge+FeTn2iLon1NLjDvCQBMYE3uP14q/AFUDTJRPx
         QzH3TnViWnkyzSCstivwVF/n4Yp4EyeKrSUDQiml6pvirTdoaOeC7DPzLwCNrWud5KyI
         DYMc7mernsjTwKxppnj6Z0PHcw4KQE1ZCNJ+ueYZEsBeLmElyugPQ0UYzXQCF/YOTJPA
         +XmsC1C5+Sp+q0VrNRoONF+t5wbQNkCxv1sbOXJtOHUhmDWwS2bMXq2+zbQV25J8O14P
         eQbg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791876245; x=1792481045; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=O1lANuLy0aZ+Adig45dLI6SKNG46/rOFHE6t5T71VGg=;
        b=M7JPM+47XTRG/E+/UBMp8PDuVH3f5s6o5qTK4MU811Os+L4tldKVFeg+SdgPRC+OX6
         H2MdiidwqmvibTeGM+Pi6CzBIr1my2Qs0ynTdX8sEq4MxO0NU4Fpj442CjecCHQbQxsc
         AskChIMqvigbDBwfu4Exbc7O/1EMKR9ab4HoQ/sVvbK+UtB/IQRJiwE/W3e+/Fye6RBe
         96438cJIR/7eIvkHjykozQJm54A1ip4WTRRP3ApQPxydoqafLGgJJgwxcuLhVftmNLNF
         g/q60JnnwYcG5aXWNdb6aUklG7OtjZJUMZRM0ckZ94JctbI+rP+DrfM7gSURvrV1zS89
         P6EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791876245; x=1792481045;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=O1lANuLy0aZ+Adig45dLI6SKNG46/rOFHE6t5T71VGg=;
        b=1mQTDWdOMqDzP8gbUEXBzvBF5pzT5daUGyh+mywSRCYuQB0qp5f1unjW46Wif5/eZa
         vp2NFne+SxLIjFM9FQ7ww6mTrWfKJBtynmgSYSUQlbAfQ7gSjEjLAKMzdeHSGP5OZp2k
         LSpitdjOTPMM1CvYl9QVqMtpSirN6vGOtcPLXg3eSA6Mwk/X42rjxxLD5LVYy+AuUUlX
         AYsZE2AYgsXN3Pc0KS4sTaGrMkYFti/TGGQb9awX8a6TG7OMzYBIGJfzUSLlPgaE5Pbl
         h/DSWU0JVrBM0W9Gtmi0VlHsDPV2R20gl7das8cUZH6+uqDiOFB4BrrO4lHR4Z34ncOt
         DpqA==
X-Forwarded-Encrypted: i=1; AKwUvBzblQBNedwx0Oh8/AyL01QxhwBHQ2NkQabwM9nEgDqpwCNuhKufAxkFfePZtcgYHab3PT5UrUE=@vger.kernel.org
X-Gm-Message-State: AFq9FYKBRrfJLqS0CZecsJrRbtJeumHzK1PxvCVG7beRWvL2X6WAj1cU
	01rXrAQH/hKryM3OW1cU1ZsKiGBqiLdwsVrbWAUa4wnG/8AWg0o4vGkDNVTXEDoUnP/PRI+JAVj
	+D00dQvrGM7ZeRhAUGCo4KxG0Yz7F5hmvKCfX42ac
X-Gm-Gg: AYBFou0KRFMHBAEigG9AtbUGcCE1S0ff+Usz0RDsvip7d4wvqjwPW+wjpHc1JIgNPe2
	hX8m06cgV8I6bqmef7GoKcTUCCKSm0toQZ3p9pf1Z6+h3qjh9WtXZCDQtnnN0hF/fF+jIqukpeL
	p1rbKDUNRVoLdacuzTiDeFmMADyHpr0YWfR+9Kb+issrrSthW0B074TBUFSbB9yXMm+h6NEBLVw
	pYIEpknXDxUpoHxCM7bRtcWB14QrNpz/Y9+e4jHuL0c7El9D2nHHthobIzgXqNs3tbjjhhkr7M3
	swTTiE3Sm+xWuV6dNDFvBvKP1y4fdEBBmK4EWcYTAaqtUecBs5d4036A+8/6Qq9A+SHPrjFlQRE
	qT6uqvN9Lx/VYG3yzlHU+vPNII8UHVotCwXdLh85QOo8Rmv0nHCm4cj2h9W1+vSA/9MjcObqafr
	E6QLLyRSUdp9rApxYWbu2WfWFy
X-Received: by 2002:a05:6402:44c1:b0:6b1:cd52:5798 with SMTP id
 4fb4d7f45d1cf-6b1cd5261f0mr2213672a12.42.1791876244521; Tue, 13 Oct 2026
 00:24:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261012194530.3751034-1-kuniyu@google.com> <20261013070033.GA852441@shredder>
In-Reply-To: <20261013070033.GA852441@shredder>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 13 Oct 2026 00:23:50 -0700
X-Gm-Features: AclHuK97Rz7Zmcv93I77QGLFVSeOX2xWsdIVO3dEkhdUYusB74ALweemIgKIblw
Message-ID: <CAAVpQUA+0E=YXk7bG5hQhYnYhsW6QA4owJy4Z9o8VcFQmX21AQ@mail.gmail.com>
Subject: Re: [PATCH v1 net-next 0/4] neighbour: Misc follow-ups on per-netns
 neigh_table series.
To: Ido Schimmel <idosch@nvidia.com>
Cc: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, 
	Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 13, 2026 at 12:00=E2=80=AFAM Ido Schimmel <idosch@nvidia.com> w=
rote:
>
> On Mon, Oct 12, 2026 at 07:44:55PM +0000, Kuniyuki Iwashima wrote:
> > Patch 1 updates the switchdev doc, s/arp_tbl/arp_table(net)/.
> >
> > Patch 2 updates a selftest for per-netns sysctl knobs, though this
> > is not an actual issue since the test does not hit gc_thresh by
> > default.
> >
> > Patches 3 & 4 are based on a suggestion by Ido Schimmel to make
> > neigh_managed_work CPU-friendly:
> >
> >   https://lore.kernel.org/netdev/20260902143023.GA3966681@shredder/
>
> Thanks for the follow-up, but I think you missed my first point...

Oops, sorry I seem to have been sidetracked by 6d79b223ec44 series...

> My
> comment was about the GC work that doesn't have a floor at all. An
> unprivileged user can set the base reachable time to 0 and
> neigh_periodic_work() will hog the CPU.

I'll add the max(HZ, ...) change in patch 5.

---
pw-bot: cr



>
> >
> > Given it's rc7, I'll defer RTNL removal to the next cycle.
> >
> >
> > Kuniyuki Iwashima (4):
> >   Documentation: networking: switchdev: Replace arp_tbl with
> >     arp_table(net).
> >   selftests: netfilter: Set gc_thresh[123] for gw netns in
> >     nft_nat_zones.sh.
> >   neighbour: Schedule neigh_managed_work only when needed.
> >   neighbour: Floor INTERVAL_PROBE_TIME_MS at 1000.
> >
> >  Documentation/netlink/specs/rt-neigh.yaml     |  2 +-
> >  Documentation/networking/ip-sysctl.rst        |  2 +-
> >  Documentation/networking/switchdev.rst        | 11 +++---
> >  net/core/neighbour.c                          | 26 ++++++++++----
> >  .../selftests/net/netfilter/nft_nat_zones.sh  | 34 +++++--------------
> >  5 files changed, 35 insertions(+), 40 deletions(-)
> >
> > --
> > 2.56.0.385.gd3acb90ef8-goog
> >
