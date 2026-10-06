Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAB5E282F1C
	for <netdev@vger.kernel.org>; Tue,  6 Oct 2026 04:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791261343; cv=pass; b=g3567FPiXs7LcEWS/o3VPJmajmPqCOI6VDtpuDEv1QlsOqcyN5K3hM5ovFQxSLgHsfdp8wxKacDrU8VS6Yu22Bm7CCUx4U1GSLC4xu9yKAJgI4Xs9XNgq0CG8DJXvUXDqrrv9lvapp9DibUaM6ixGNZ6htGWuOIefx6PQc3nnw8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791261343; c=relaxed/simple;
	bh=ikcCgtkLCv2+6FCT8NFz7Sepc4WRT9n+r6/7HxB/YnQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V2tpC0G+5QG9NhCDwveBZb+WEE3tK0DDxUNNA2XNLjvkFoU+5vH4kR0yEH/W57WtjQtXJ6U9F14o9dGrR6zN+OgIVk3XYow/8E+REQ8IUVgbNL4zl4heikSEZ/3QL3wUvGNzy7xNk7mZTVbL8ujb195RNwkacKxQpWIONqWox10=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rv42wXaR; arc=pass smtp.client-ip=209.85.217.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rv42wXaR"
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-7c3b6e8225dso1237339137.2
        for <netdev@vger.kernel.org>; Mon, 05 Oct 2026 21:35:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791261340; cv=none;
        d=google.com; s=arc-20260327;
        b=B+ampzyiGKM03SlS6hRoucczFARbDXmoTQdSQ/KidBA7KyRKjPSub6yWHShmcltiGU
         ef8gUQSRbj9evf46mY99Gu6o53lJuXbVpfhxfmdm3i4wMmA43Z1T2dNyk1pDMft4+9/w
         GYWvbNQ039vdTqioW0Q/lQ4M0P9ptqyls1VOMmH1F34gC87AHPMYciD+Ca4InKug6bM4
         bTVesA9fY/0m/aBJcUW4OiQeNE14ngVRuW19Gxv+N3R5tr6eOb2a9GtbXBxP54gNtkaw
         Tdrc3pbdbvdRc4aT8EPjcH7l9Co6jiSKfByOXJucsAPl9JaYRdUaISk+J5vs+0Ie5vLZ
         v2dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=IMq9dXA5XsGxNSHE0kH6VYFgrogckOSvLKdxRS+D8OM=;
        fh=iayuzgbmaDHCGRdEqrjelne3ms6MecXj176CEytX9Cc=;
        b=bsUpNl43oKRmz1q5apF83ONEgV96rRL2HYQAaS4DOVC5DDu7JVWfZofMawdfOg4/RW
         xVwgLP48nA7pCiJnrDLk1VufCUS9dhrr4eanb88V6V6b67lDrd8P5A9nxyk58Voaa97N
         WEUo7iPcs27IVceLlPen8dtIPM3cuU678IHUQlmCPen4p6vC/8npeA16HNpO7gbbRyjk
         Tp4hf6JrIjdRhuzr683xS7lkMjFxVZf/BeuuQx/SsO3qutse0rcwuwofICRp043hNlzn
         dMYlXzOf+UIhsHkb4dDgbrCBwICvIeMyxROv61C1ffBgbZH43WlfudGhbWtNhu/Jslk9
         XczA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791261340; x=1791866140; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=IMq9dXA5XsGxNSHE0kH6VYFgrogckOSvLKdxRS+D8OM=;
        b=rv42wXaRFbgb7ybmEwyzlySiOIhbEEWnt2BFA2yqH4Mld1e+qPxdVw5RJ6qnY8+yq3
         wt8q3OtBXX6TBN1COS0ctQ58Sn7sFhfAKX17cTngqrOtVScljP0zb9GDhmhcrPQofq6A
         oJT5Qxr79I9/mCbGESSj9REGJvzO+wmRIjIRaSoIuRRlQKzLDFsMjVD4iAhA2XO8gqU5
         1UjFlUYE7v9N6teCfKXatSJy78dBkLvrGIte1Vq3P5+EF0rYm8G2n5azXby0W5pBKKdi
         mEendfnZuUZy2dHe/l80jEe+lGOAQFps6Fzk72kgZS59WoOaP8IrIsxoJTWPKA14KfaW
         tlHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791261340; x=1791866140;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IMq9dXA5XsGxNSHE0kH6VYFgrogckOSvLKdxRS+D8OM=;
        b=LpE2u7RDdkXrMzcZdJ7WVJYjtK893WokdCJQ8LixbHu18LoSlC1LmUWOJ8HddrprXj
         wvwiW/iOsnvJ9UB+f8ahwhmIB92mzQ09420L4gUrvEAxZ3nQVAha2VA19t3ebtMXudkC
         89qSvyfu0F99QQ0AqH/NfmPhYiRgqexV+cJUsrnH9/x49tNb8Ufxrs3Zey4B8agVcquY
         Q11fpYZb9CT9mj+WnrzYo/QlesLR5jBnulFP7tD5n5tSMM+VcJJDGFGxAMNqIHCjDZ5/
         jcTQks2ctgX+n//2OHt56Aeo17+8511wb+HUNAuDXyoyx5WWz3wJrX0Ko37FOqOFO6f9
         L1pA==
X-Gm-Message-State: AFq9FYJ47hGKuEEPUCzHKMbGo5HHEkyZGp8lRLrdw7551K6Gf9J1sCc0
	6rNlIW3sHeGuVg8PFxgTnVBnKKlsh/EsCGfzMf5xJKbIRA418KKSKwSdT0KiNTITT+eAYEfFLe1
	k9rDSUVW+uHXJV7eAT81BBLXGbZeyq28=
X-Gm-Gg: AYBFou1HIIYupJFefKGPEoXJtVWh0wXgqeO+KnVM1ibPyB1xA/ukXPnFKCF1/p3KJJA
	TExufVqERrE5RDhOYNm2ayU1pADHwtmY5ysca8Y5n17SBCq6yFd+t59a8zgYA4W3ULmQioDfTP6
	DGaKgAw5EZYpZsVlZyJOhkcGTP1whhpZ4FihuApP88Vrq3T/H/IbZnLmeR7k+tnWFsG9w4sA+w/
	hFLrqLADGRwOT+Q/gIrfkoOrSm9NNClRXFiRfrGcD0uonAi29+nnwc+XF3zKDa1JxuSOB9BRANw
	Eu+CsXilo3rVGAbG/lgTUbjmlChS7xTh4NeDpupbZsqHAQ0E534NzCia7fIv+LE76aKKUcE6bc7
	Jyf64p8G7l5sDsQGCLFgI/8zRPpTTpTpZneQMDUNDPItP7g0inDbMfi8ui/VhGreKRgCzI+M1m0
	8My3EqIgikUZ28C/++9Rg/kC84oEmIQWXKQ43UP+W3S5oMYQ==
X-Received: by 2002:a67:c797:0:b0:7c3:b15:a982 with SMTP id
 ada2fe7eead31-7c30b15f25cmr1646552137.31.1791261340552; Mon, 05 Oct 2026
 21:35:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260930-stmmac-rx-state-v1-1-c286c43813c1@gmail.com> <179083074323.31693.13810000342248985832@kernel.org>
In-Reply-To: <179083074323.31693.13810000342248985832@kernel.org>
From: James Hilliard <james.hilliard1@gmail.com>
Date: Mon, 5 Oct 2026 22:35:29 -0600
X-Gm-Features: AclHuK_5yosJZXY-86dv_CDJAmAQ89oJW45GT0FAUDHPxv4gaBrZRXrpU3JuWvM
Message-ID: <CADvTj4r7KEO9KbGiMJTOKXRR4J_A0QMHUcpMeYaxnftzSbLtsA@mail.gmail.com>
Subject: Re: [PATCH net] net: stmmac: take ownership of saved RX state at poll entry
To: netdev-bot+sinfo@kernel.org
Cc: netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>, 
	Jakub Kicinski <kuba@kernel.org>, Maxime Chevallier <maxime.chevallier@bootlin.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@kernel.org>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Jose Abreu <Jose.Abreu@synopsys.com>, "David S. Miller" <davem@davemloft.net>, 
	linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 30, 2026 at 10:59=E2=80=AFPM <netdev-bot+sinfo@kernel.org> wrot=
e:
>
> Hi!
>
> This is an automated message. This series looks like a fix, but its
> commit messages seem to be missing some information:
>
>  - How the issue was discovered, e.g. hit in production, hit during
>    development, syzbot report, manual code inspection, LLM or static
>    analysis tool scan.

Found by source review of RX ownership and teardown while working on
the larger stmmac MTU/resume recovery series.

>  - Whether the issue was actually triggered, or is only theoretical
>    (e.g. found by code inspection). If it was triggered please include
>    the symptoms, like the stack trace or error messages.

The stale ownership was reproduced in host tests of the RX code, not
as a physical-hardware use-after-free.

>  - What hardware the change was tested on. For driver fixes please
>    mention the device (and if relevant firmware version) used for
>    testing, or say that the change was not tested on real hardware.

The changes were included in earlier integration testing on Allwinner
H616 hardware with sun8i EMAC1 and an AC300 PHY.

> Please do not repost the series just to address the above. Instead,
> reply to this email with the missing information, so that reviewers
> can take it into account. If the series needs another revision for
> other reasons, please include the information in the commit messages
> then.
>
> The evaluation is done by an LLM so it may be wrong, if you think
> that is the case please reply and explain.
