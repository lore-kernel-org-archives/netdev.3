Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0C1F3C09E5
	for <netdev@vger.kernel.org>; Thu, 10 Sep 2026 06:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789021358; cv=pass; b=u+HwzNGwfifWjCy7x7ga8IULP0R1QZm0HpTIoL4X/O/U7DDzdAEmIQ7bE12oqKKnhVjnayjzJ7afgvEk4Eqw8CNLEJ9ARqog0LrAkVDy92u/VpcZlpbAckyrH6dqU4IiuHkPb0QubW4ZMgIhxjzqUO9J1ai6F1DSMu/mOAS93yg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789021358; c=relaxed/simple;
	bh=Npr5xBNM8mmEGyjVYurTS1oA81vQ9Wr3AxigeB1wQ6U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BpmoTq7HsAVmAMjXWLwUarnOhUBpEwXNQ3B+mS0g3sYMdyWKp2X1MSQH+TL4wS7NyyLCPbeqpkCpz0KUQ715f3WEOwyGzrYM7NEdPj0Cd+k0+E2SfX+4+AOzW0igjgSi0piRuO46hZfux6ZrfqqKrMz5znU8AY580zHnEbs4g0w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X/evHftU; arc=pass smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X/evHftU"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-396ccafb751so1824517a91.2
        for <netdev@vger.kernel.org>; Wed, 09 Sep 2026 23:22:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789021356; cv=none;
        d=google.com; s=arc-20260327;
        b=my5klv1PitWvQBWxWMcsmIxzhT93ZjedSFQjfS7t3KwJZ6VSI2tCDWaTDE2TEKwgpO
         /KemQj8OLiY64ZU1IrT2v36ZcGpqIWkI22QRYy7k9PBxkjdk0pfcgwI4/ZU8bur4rhWE
         mEzmEEeRLOf1WP4Nq8s+5F973FeyJMonbsEqJDn1rSfFkysk4/i7f7UFiSic+JkRx9en
         xREBoW99IHriHBXB+QN6tcwZ075mzJ4xdXJ1uiBxuHEOhJ2FyCx4JVWYNmKuHcWfDCXL
         c9VSaAu9tlI+fSPbxg3ubmP/vaZK5tMKGZ/aQ+vYNpj424CG3JJTVVv3QoBB2WAvBCiv
         /UIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GUPsHgAchWrRVDG9iW20v8U6ksxTr54/BuEyiaNJv1s=;
        fh=0xysBb76qrofSu2SWkxuHvcRISzLmPQYz4jSIonxvl0=;
        b=KXlZmAD1dcSA+3XLBLBzYTHypqvRKrSJmcocvr0HoECfIVAJqrjXtAKdTwLi351KtV
         xk17aqh2rVbQd6hTZOFs14fVA/C6Juc+XTStjXE+mBCnZky73nqWgpP6lUcyXJh2zf4C
         mElrtwvYjS8HGUlCl6BDcgEv1/SUsfbT+iD3UypvSbhz75foS5I5L1KbUKWX52peytRK
         WMfVAXBJxmCClTa+VBNyjTasWcrwc/PBOTj/1ZrEVymx6OhGStVqmSfIQv99WaIJk1Jy
         Aj97Br3lgD48FjO8AZtv+YasxjpTrVEnAyyFItfuGRyF5X7cIREdt3arlTVVrtUttqNv
         mI+A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789021356; x=1789626156; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GUPsHgAchWrRVDG9iW20v8U6ksxTr54/BuEyiaNJv1s=;
        b=X/evHftUcINrM4xrnadCEoxkWPgRt5zQDH/tNdl4gwc7GSdc73njxrLKRUsTudNLDE
         lbofoZDHl+LM7TEKwUgsbpK+Nphet30Pm7E+PeZzIFHnkdd2GJnpzOzE9RBZHSuhOwX/
         ZhZvPT+KSO56YeQ7EXmGFvjfG4DNmSJF8ETYri9C12tzXhwtU81Z0Uk7FB3Iw965V2OP
         XZCgLI3vAf/LnKgYyf1FOCTZGODz2V3FD5mAZVH/ZdUa2rkeS5e5jgvj3t5iheO0u1pd
         FbFR6KliNdX4stJ8IICe14Rt1Ts43CFRSH1ympP7rNdCmDXl7qwpTlM8unfNtyXEYrgf
         bLXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789021356; x=1789626156;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GUPsHgAchWrRVDG9iW20v8U6ksxTr54/BuEyiaNJv1s=;
        b=WUNOxTWJJ9o92OnJTMcBCPsvhUMEnSZzKkRXR0GRp5+IcDwSEr8klSUaWg70VWT+bU
         wewZODBLCSdSZFMuExdceg2eW1ySETXd+Esd8gls2Q1AIszk7V5ys3b1/BIgMpLxKHSB
         eHdKQd98JPEFoYMxeeI7VwiSgmYF+eOp6nfvKETMJoVcHTb1GsOUOkdENDVjlMxfuvbc
         sp0KqyipT2afmkDYjeOx+hdDNtPQolfjE4vpxs+pe5Zv56zu+9S1cZPvsQP0lj9ZDn40
         YNR6YxUiWksaWswp/dbk1RRSZCbGr2/kbi4SiN5jc7dO2qKtkWmKLDIJseGYecp7XXAA
         WJ/g==
X-Forwarded-Encrypted: i=1; AKwUvBzVLhIfN2gotB/+SK4FxGmyNTe9Pws3Wc6UdXjDwIMYap8q9yeSS2QcWGHK7bYpjvPeKapJEkw=@vger.kernel.org
X-Gm-Message-State: AFuF++nAkidABKTzM0yzt+j7tZzPE4vCswKtr539Gg8InYqAP9czQEWY
	ZJ0EsPjrKysQW9dxgYPMw1IHVqgyAQSgn9mN5jBvSSVSpZFgGX8XyIph8q1PjZl5vPJYGuh16fD
	2BhPc4RAt571sl3e2U8mcohjigMdaN48=
X-Gm-Gg: AYBFou0b4x5ZC1jW43yW731ndDmPetSrmhcoeGSh5SslpcSmZ0/MKMjtn8jiAWp5tjc
	lD9S20CZ515YLxXrsqeNLA8R2lVxgbynCNm15EKT3iDf3m8eHmJzpLIxkvAEq79O3YfGQkLQSjz
	PVy4BhOH/uY04cCdvTi8Ma1ofkTvdynD7RUSdYs5timvkQq3Be5Ah8Sr2oP3vdRUub2csfrwmFt
	miDLpZCemK0coTp4cuT6b/2910QQl9feKOcA8U4wxPxOjpA6jRiPvcdV1YLxVMFDo2j91GUmK+1
	CxtShrZFN553A8MDFNbsgIvNT7GUQPhxs3lWxjz1Dd3PP6dDexRZj4viiLq/yNp567GaTnN+Ikk
	gYv60CQZVzOmXMMHUUHw+XXgPY7/EcDBqDrq68dP8lPBfGg85zhMkJu9Wolf5thPsDFE=
X-Received: by 2002:a17:90b:520e:b0:398:9be8:ea65 with SMTP id
 98e67ed59e1d1-39bac3c452dmr16420821a91.18.1789021355888; Wed, 09 Sep 2026
 23:22:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260909045450.16176-4-phucduc.bui@gmail.com> <178901787314.219967.14642070814356568514@kernel.org>
In-Reply-To: <178901787314.219967.14642070814356568514@kernel.org>
From: Bui Duc Phuc <phucduc.bui@gmail.com>
Date: Thu, 10 Sep 2026 13:22:24 +0700
X-Gm-Features: AcwNN1WuPv7sSiyeJm2_sYNBm74wkTy0S0_3POKTQUNGnsRp5EnocmR5Vn7LaC0
Message-ID: <CAABR9nEGBohTLYGh9N7z5u2hMAwY3ZpU+zTpxi4_imLat8PgBA@mail.gmail.com>
Subject: Re: [PATCH net-next v6 3/3] net: xilinx: axienet: Fix IRQ error handling
To: netdev-bot+sashiko@kernel.org
Cc: radhey.shyam.pandey@amd.com, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, michal.simek@amd.com, 
	horms@kernel.org, netdev@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

>
> Critical: 0 =C2=B7 High: 0 =C2=B7 Medium: 1 (2) =C2=B7 Low: 0
>
> - [Medium] Understated impact / missing Fixes: tag.
>

I've seen different opinions regarding the use of Fixes: tags in some
of my patches,
so I left the tag out to avoid unnecessary discussion.
In fact, some of my other patches did not have a Fixes: tag but were
still picked up for stable later.

So I think this is ultimately up to the maintainer's assessment.

> Pre-existing issues:
> - [Medium] DT binding and driver disagree on the ethernet-node
>   `interrupts` list.
> - [Medium] IRQ mapping leaked on probe error paths.
>

This is a pre-existing issue, unrelated to this patch. I'll keep this
patch's scope as is.
