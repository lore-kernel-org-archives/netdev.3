Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7275933A6F2
	for <netdev@vger.kernel.org>; Wed,  7 Oct 2026 01:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791336443; cv=pass; b=VP3OSV60N+89XYXhjkhMru9eTbK4z2zO24OHxblzkq92CyG6kGnSrwxQW8T6LyGL95uPGwF0cu13BFNUqtCSodVwqwwvSuWSQjm8wOdvgoz1yPeIU6q19Dg/FFhShzrwDPJkRCWbyqUwG8CUDq7QVPp9YAjZViSmyIA/wp6o7xs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791336443; c=relaxed/simple;
	bh=7MOrpFUI0yckyiOPON8pTUAfvIKDuzYSqvY32rPk8Fs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dR/mZK6f1cGOkw3uTASFhiDwdtxe9sH8jH8b/tErh2Ylh6uhFKY/cWT/uXqxAgX20Aj5o81aOm8xgFSoKPaS1W2cwKbhAvk8mGnSrs7wwP18VEsh+0uN8Q1lmwu0oDQZV6mjDWFmSqM5cxCtffAXj9s1AYpRehnuqO8qEGS+w4M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LUH1XHms; arc=pass smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LUH1XHms"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6a9e5ba741aso1878900a12.3
        for <netdev@vger.kernel.org>; Tue, 06 Oct 2026 18:27:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791336438; cv=none;
        d=google.com; s=arc-20260327;
        b=D4Z6U/VWN2xEafHrzarS8yxrPixOrlt8Z19D1GA5PgKZ1iMIWlX5550sRsh8CfGoDq
         sIlunhAiNpL+QUug6ZKGCf83h45nQu3/35xmYjVbgAo/tOhpOpRV8qrSkP8XNnXEzy4E
         tesYf1h3EuDqV+BTrtVOfcyqlV4kixNiYJzPvVoXW1k+CGxoWcD5Hcnx9NDLfJCbGq1E
         HLF0mu8M+6h1aAB/j8dG19HxxMQRAnwwki9lKMKnHodYJ4Ejr6Z5cH9hF63Or0xytTWJ
         2gP4TFOlBk+UtSxul58mXYQHzfGPwk12Xdbe/tZSfgZFbjVmQgVm091nklHQCpe/eNJJ
         PxgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+s8nYi5HbtoA87tSkC1RWmRECsh/ju1fYhQ7RJquM8k=;
        fh=gSv28TSCYMm3dEB8hWnb0CECTz4v3U0e0IMULd53xNg=;
        b=gFtXV0ZQdlqlR76oOG4Bkxh21NNCRhN7JeqdPC9Vw9PVrP0PKTEis4WEM2oC3dThD8
         +6JIJKY4QbSYHTyCKU4gkw9tw0BIDac/KEN0hVp4XWi7mKJFfbaqCgbk9quMORNSJsNr
         rHsja+8iVlsXrbleK+LS+vqZsvz1ClJzK/P2H/IEBdFlpL7LET9fhrvblw1dG7cBzlkf
         QAnX7Hz/MTHlW93iPLHmVICTDWdACmQpB2TN3zDynnZMiqNg1m+HkC8nDo63niot9ulC
         Ogf8wWckNdD442lwt/XWgW/H2OttlqR6XT7Jd5caBIRxKcumMnpe9rWE1/b7V00wZy+M
         RsBA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791336438; x=1791941238; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+s8nYi5HbtoA87tSkC1RWmRECsh/ju1fYhQ7RJquM8k=;
        b=LUH1XHmsWPem2jDHzrMp0/M/6IgzSDR/VidFy8dA1AmiOQ2jF3zerV2BPmC3fPoYBM
         iyhFaQ4JhkjG8BBO0c+3aMh6f6KKSSH4icLBkzhQmCtB5g2okBuHA9YFaWvHLWCbyVqL
         Md8qjCxk5skemAPeLGyZfpFFlb1w6lkgFgD03ksMORXL5SqML8JDlH8mg6mWnzSAOamm
         parhQOoqtyXyROQ/A006lItxbr18qQmNlEyWr4BMjky9k3X7HhWfQ282tzBi/4eg4uWc
         QDEwMbKqiHvFqzh62Jj+909pKxQxY1HASQ8ys/c8BpkbeUp8w+84XmasPXfFn2yz1cAh
         1qSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791336438; x=1791941238;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+s8nYi5HbtoA87tSkC1RWmRECsh/ju1fYhQ7RJquM8k=;
        b=cUYLB3Th3XalNFFQfjkEFpUcF6Pm8kQhlWIX8gXrRmj9kPGGcTMAkbRFMRWPasRJkn
         hwL7BmwZC1J/MSv/ttGcipezc4KlatX22/5rWpVlQmUL4A+6vLk4Cyh9RxmfFt8cV/EB
         6NVjPmwOu64LNjZaeAqjnEg1DKxCV7ifaeMFC7O7kfPuxgHlw5Ms+t/njc5qp2xpTWGY
         abY+fMsc7Nms8JtnEHHZyf50JLjS1iFE0RGbS4BBa6IsToQDLRAmRDq8RksZHsygSKL3
         aIPNP/ZoG7baz9rkCNkiG7HNuMlC9BqA1ArxrE5cHVtZgQL7pjnRvvNpFw/77p7Wh2F0
         qpMA==
X-Forwarded-Encrypted: i=1; AKwUvBy3fX5a2tfcP3DlWUePJ7p+lW5mVsJvJEmDGEaDNBrV/Jx1DgYOm4HEiwTygxAg1DdbRzPNhr8=@vger.kernel.org
X-Gm-Message-State: AFq9FYICwbjktKPjcCEaEij6taOnGHLJDKzCbyCMHVod00KLV4wHdU1S
	Zv2AHw5z+lphG9gzwb1rUnSm11VlCD5k8MYW2og5GLwiCjMxI49x5Gc5b3jbvXTqIKJZwTxMme1
	KsiK1DUVbxknikVkO01MhIfdgdb0wL9krjC4I
X-Gm-Gg: AYBFou1gCcTOYG6+yeros7TNnjb3E3Mn4IqGf9WuDOLJXZcYHPtrRGo0yLv/DCK8T5l
	hCfuckk4r+e/7RA6Ik3xqLxtuYeePk7yO0JxHtYMsjNQg5FBwsLYCTieqxX+/fuzic2ehz5SMKQ
	iY6Bcn5LP7yejTC2jJ12kb1WoaSrfWTl+7uj9utlXsY18Uv9uhvq5N4xeDX3zgmRb+i/Xtwgxr6
	hr7cWP4+6MDmBeUnSCty8Vy8Doi5KwgiQKvxqacdXODVKfaQgF4o8CuKJS2KIeLVcLwyr29+GAO
	n6VG97G010TC2ekKa3y7hIW/FW5gQz5UJ0zJ7OSAi/BWKuKw2ihA1tWg89phDaj0sel2xp27Ysn
	/usdSqIdHO5VGMBQJGKEmXFBvwQeIiRAQW7q5u0zbOCgOERnjfowb4R7WRNHlCOJ9gzp7kSDQLW
	c+TbivmFgCRPG6u0/nI2MdNmxG3rQNO834JycL1vAlm+S4tHmGl6B36pqa
X-Received: by 2002:a05:6402:254a:b0:6ab:eb3e:ef50 with SMTP id
 4fb4d7f45d1cf-6aff47a5eb9mr641273a12.36.1791336438162; Tue, 06 Oct 2026
 18:27:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261006-stmmac-irq-unwind-v2-1-194591c87460@gmail.com>
 <179127056620.2231598.8882282421523696709@kernel.org> <CADvTj4orth=RYtb78ND1rdiYh2yb6d+TjZt5ohK_-+1mnVpqfQ@mail.gmail.com>
 <20261006155214.63c5cb5b@kernel.org> <CADvTj4obBNgR4w3BW4-gCU-=LUxesQdTRN=EdWTcx7VznFi4kA@mail.gmail.com>
 <e7fea95d-1ce2-4c5a-891d-5e5899931329@lunn.ch>
In-Reply-To: <e7fea95d-1ce2-4c5a-891d-5e5899931329@lunn.ch>
From: James Hilliard <james.hilliard1@gmail.com>
Date: Tue, 6 Oct 2026 19:27:05 -0600
X-Gm-Features: AclHuK9lGFJ50frV5XOEspPFhQU0WOI40P-vsRfzEyGW1xtdFw_gLuYmcCzp9Es
Message-ID: <CADvTj4pm8fbgGDiyXVHubnM93qOey7o18O+MDU68MSisXVvHtw@mail.gmail.com>
Subject: Re: [PATCH net v2] net: stmmac: unwind the WoL IRQ after a safety IRQ
 request failure
To: Andrew Lunn <andrew@lunn.ch>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev-bot+sinfo@kernel.org, netdev@vger.kernel.org, 
	Paolo Abeni <pabeni@redhat.com>, Maxime Chevallier <maxime.chevallier@bootlin.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@kernel.org>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Serge Semin <fancer.lancer@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Nicolai Buchwitz <nb@tipi-net.de>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 6, 2026 at 6:57=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Tue, Oct 06, 2026 at 05:17:20PM -0600, James Hilliard wrote:
> > On Tue, Oct 6, 2026 at 4:52=E2=80=AFPM Jakub Kicinski <kuba@kernel.org>=
 wrote:
> > >
> > > On Tue, 6 Oct 2026 01:14:52 -0600 James Hilliard wrote:
> > > > > Please do not repost the series just to address the above. Instea=
d,
> > > > > reply to this email with the missing information, so that reviewe=
rs
> > > > > can take it into account. If the series needs another revision fo=
r
> > > > > other reasons, please include the information in the commit messa=
ges
> > > > > then.
> > >
> > > Please make sure you read this paragraph, to the end.
> >
> > How much detail should I be including?
>
> We want to decide should the patch go to net, because it is a real
> problem which bothers somebody. Or is it a theoretical problem which
> will never happen, so we might want net-next, or maybe /dev/null.

I mean, it's in an error handling pathway that could be hit if there's
an -ENOMEM error on an IRQ-action allocation. So it's probably
mostly a theoretical issue but I wouldn't go as far as to claim it could
never happen either as there does appear to be a plausible way to
hit it.

>
> Sometimes it is really obvious, things like a:
>
> Reported-by:
> Tested-by:
>
> from the same person, makes it clear it should go to net, and it
> probably is correct.
>
> If not, a statement like:
>
> Tested on real hardware, regression solved, no other regressions
> found.
>
> or
>
> amd64 Compile tested only, probably broken, RFT.
>
> or
>
> New feature tested on real hardware.
>
> Put yourself in our position. You are the Maintainer, what would you
> want to read to know it is going to the correct tree.

Do theoretical but still potentially reachable bug fixes go in net or net-n=
ext
generally when they haven't been reproduced on real hardware without
an artificial test harness?

I had assumed that since the commit message made it clear that this was
a bug fix and not a new feature then that would be sufficient info to know
which branch it would go in, but I guess it's not quite that simple?

>
>      Andrew
>
>
