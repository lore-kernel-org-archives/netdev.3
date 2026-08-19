Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ECFB332EC8
	for <netdev@vger.kernel.org>; Wed, 19 Aug 2026 20:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787170236; cv=pass; b=ptH3zYwkWoJMFjU/JwdmClfC3watVE4YC9qrxXQG/IpvFaIjIDiswOXwLqvRMuYr2RbQ6oAcMT2Db1YwgModZG6p3nCu07tycVASbsTLI6Sh7P18xEkjwGUouQJ6Ap+z4mO0TE2tlpqEKIgIw5agXZcAr9UA0ExszIPQC2miQA4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787170236; c=relaxed/simple;
	bh=m/I5/nhUCkBaUTFPEeaS3Aw1BSBZvrmXMka6Jo2bwl4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q9gMg2tVFdHEqEtCYb64I9X742Bong4R9CETZ3y5E46ralnsaGUeGskX4sNRva+fy4pZBQV3h0Y0TAMQOVpr9m1R99FL8asd20OOt4QOkXKeS2KO+T1brFJdyiKBBg4+ePm6oP4TI2Jn75hiCevtqMysw+tuF3GaHtCOWZBNzos=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hf20IIcM; arc=pass smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hf20IIcM"
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-4a451915d8aso1051508b6e.2
        for <netdev@vger.kernel.org>; Wed, 19 Aug 2026 13:10:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787170232; cv=none;
        d=google.com; s=arc-20260327;
        b=WgnbrYNc98uAXYel+z3ctKmSVtA+v1aMdU3J+euY1XSbchlXzLvUnAsMWYLIgmkIGj
         jhlc/2lmRNs/Kq1LXgm/5wwk2Oy7iB6IEBBBj5DrCdiOHbdUOtkI9sZH7UryVHhl9X7F
         NBODEOi4/Crz/0UdzRFYdjxplA54Uz40pI5m+wFlFX8H0kVJS/uHlpE55LmFDAzxDxte
         neexWcV2F6PFx7mX/wYZy1PEkjuM1hpAgjFysPi1Siv6T5D3wUpIKHkW7SCJF9E4qnw7
         NE/Nd1huImmgos9sAfq4ajqc4BzBZbA81mWTsz8+uVFLgSrVAt8fqhVmSwJ7m+8wtcdA
         vphw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=N/GaQztkFIctJG6rZXOiIdCznGCsGLT2qU095hUM3D4=;
        fh=zD9W+mVNL8o1i3IWy9PCzxLV5x06VFZf498JS4OljUA=;
        b=Zir2ehNRrQpRj34ZFesBnWVuUl9BMzIXjgi3B0EUNvi4DVvxnfPLjRNjfpNqn7VlPD
         E0qz4ISAJyMlZqT6L5nB43g3PbHSP58vlfMzaS6Yk+NTl9RW41XpCNWgu7eCWnLurnkn
         vSH+9udVUX+7stiSayAn1dttg7bwtVkbv2xC2KO+iI2lHq8+z3U7sAeUDGUkpEZk5yhq
         tY04VN46ah0J01VFUlpHfUDb+yg6GKawHZebHPgvtY0U2CknyJAFieG7NDyOiAs2j7L3
         WfRAs3Pt8brncC8WS6px4kjKiBhNrGgHRuxJViinrUNOZv0hIAdwn6zmi3UKWa3ezZo1
         XntQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787170232; x=1787775032; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=N/GaQztkFIctJG6rZXOiIdCznGCsGLT2qU095hUM3D4=;
        b=hf20IIcM3MhwzqtjUGOHorb1OESb1MGDw07Ftcqby3WC6YvxokAyDhxLAkv04PPm++
         Y5u38Lp3ez8zwdM2Khcr/7gHgYntUNkuW8E4lwyEfhdVPAuFl7xA6ncgicr9OtD3Cvbo
         jZh0iHR3pUq4WUuAqPkCZL3qjmv51eFIX+wjZuTKUkHn34lZFnriZdybmjJgraXPaQMA
         3GmHGmF2BNXNjwNtCVSYzTURyOejxCt1xip23ZxL2TRqF6nbZ9xeTQyYc3WruHt5iuOB
         N5Ojv5KtzKnkfjZVgb4BiZa8n5e+Pgbhe6srFtyUNS7T4AZguyep2LJZWFTC9sMlpAzF
         lSdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787170232; x=1787775032;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=N/GaQztkFIctJG6rZXOiIdCznGCsGLT2qU095hUM3D4=;
        b=b0rMwT6mCyzn3Fq4BacVHMcyTlvvlw6CMECWaKAwPAdbH0qS9DPqsnla2RSnTZhnUN
         uw4HM34FYPv7sbqxaBt9ncyfDy08n/U15YvhyoPlfSXya1oHZIeUEwQecVE5xrUfE06W
         baSnD3yf34uBjA0ueyJi4S2uhBzFQC/GGHHwU5jd9nXxyt3WzWL6PBSW3y2peVWRycBT
         aLDsU9vHiaU2lDs1FWg2g4MfuyZ0JOvYmWXwkLqSxS2khiABuaan8RkZqrvToy+tPHOn
         PJtf3pGTfsVLt/uDIF95RjOFcXEmmKh5UnvVlZHe3D8oNIoQy5ljqIFDjLE7DzAFC5FO
         zKog==
X-Gm-Message-State: AOJu0Yx0wlLRX21loZPi3Viu806hhQgV6HByeAGJz30aDYcqem4N8v2Y
	UkKZ20XDQ6T2pexKmzBwguO6JUTh/7Z2woRCbjGWm2N0Tdocz7FHCfA3zKCjzqs0NhkluGBII5l
	9MLI4MotcWrAp/CUX/Xefmjc1K/qw8MA=
X-Gm-Gg: AR+sD12Toa2z224TxUAtn68F0X5vEBdh/AuHjqF1M0K+ebmErj4p1mww8DYiamQMvb0
	8HoqKOngdpFzrp6TlTuGqr7ocH7muY/sToPhu6dcXAii2C9P2GXfAaiksCyjdymlbex4MvGoEY6
	fQFhOKWdwECLgE0g2LLRd2zSRGqsW0CA2PQtIYiVBIJvOuH2fXA90BcUlZmVVqhQar7YC5QPbZW
	kPZTtKmfY7BjOWc5oZv7e9N7C548njtDDbhxzw/pMlqsdp+JvfJqLMMURo9Gi85shc+/LZx8OgG
	Qdx7PaJuFtSEDwrQg40ViMwqlhrA1gqJw4kJmdcDDFpx70Yi7WVEx7FMYzm50MycQWNHreCHUR/
	cK5XNl2Y9dk30fE51Uw==
X-Received: by 2002:a05:6808:251a:b0:4b2:8e51:91fb with SMTP id
 5614622812f47-4b2bcaec6abmr6789732b6e.16.1787170232171; Wed, 19 Aug 2026
 13:10:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260816193905.218112-3-mmyangfl@gmail.com> <20260818171025.4020314-1-kuba@kernel.org>
In-Reply-To: <20260818171025.4020314-1-kuba@kernel.org>
From: David Yang <mmyangfl@gmail.com>
Date: Thu, 20 Aug 2026 04:09:54 +0800
X-Gm-Features: AcwNN1U5tqRWcuy6wmgE0xF4MddBd_MlBT3uHidirLc2Q0vd6RKoThrl_IJmR2g
Message-ID: <CAAXyoMMUWGjokvaDAkgbDM0=6SZQ_B0Vos-wNUF+dun6W_7qAw@mail.gmail.com>
Subject: Re: [PATCH net-next v10 2/4] net: dsa: motorcomm: Split SMI module
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, olteanv@gmail.com, 
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 19, 2026 at 1:10=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
> > diff --git a/drivers/net/dsa/motorcomm/smi.c b/drivers/net/dsa/motorcom=
m/smi.c
> > new file mode 100644
> > index 0000000000000..164c25ef494a1
> > --- /dev/null
> > +++ b/drivers/net/dsa/motorcomm/smi.c
> > @@ -0,0 +1,157 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> > +/*
> > + * Copyright (c) 2026 David Yang
> > + */
> > +
> > +#include <linux/iopoll.h>
> > +
> > +#include "chip.h"
> > +#include "smi.h"
> > +
> > +#define YT921X_POLL_SLEEP_US 10000
> > +#define YT921X_POLL_TIMEOUT_US       100000
> > +
> > +int yt921x_reg_read(struct yt921x_priv *priv, u32 reg, u32 *valp)
> > +{
> > +     WARN_ON(!mutex_is_locked(&priv->reg_lock));
> > +
> > +     return priv->reg_ops->read(priv->reg_ctx, reg, valp);
> > +}
> > +
> > +int yt921x_reg_write(struct yt921x_priv *priv, u32 reg, u32 val)
> > +{
> > +     WARN_ON(!mutex_is_locked(&priv->reg_lock));
> > +
> > +     return priv->reg_ops->write(priv->reg_ctx, reg, val);
> > +}
>
> [Severity: Low]
> This is a pre-existing issue and not introduced by this patch, since thes=
e
> two lines are moved verbatim out of chip.c.
>
> Now that yt921x_reg_read() and yt921x_reg_write() are a cross-file (and p=
er
> the commit message cross-module) API, would lockdep_assert_held() be the
> better assertion here?
>
> mutex_is_locked(&priv->reg_lock) only reports that some task owns the mut=
ex,
> not that the current one does, so a new caller that forgets to take
> priv->reg_lock passes the check whenever another thread happens to hold i=
t.
>
> Would WARN_ON_ONCE() also be preferable to WARN_ON() on a path that runs =
for
> every single register access?

It would be better to address it in another commit. Also it's the AI
who suggests not to include such changes.

>
> > +int
> > +yt921x_regs_update_bits(struct yt921x_priv *priv, u32 reg, const u32 *=
masks,
> > +                     const u32 *vals, unsigned int num_regs)
> > +{
> > +     bool changed =3D false;
> > +     u32 vs[4];
> > +     int res;
> > +
> > +     if (WARN_ON_ONCE(num_regs > ARRAY_SIZE(vs)))
> > +             return -EINVAL;
>
> [Severity: Low]
> The chip.c versions guarded the vs[4] stack buffer at compile time:
>
>         BUILD_BUG_ON(num_regs > ARRAY_SIZE(vs));
>
> and that becomes a runtime warning here and in yt921x_regs_clear_bits().
> Is the reason that num_regs is no longer a constant expression inside the
> callee once the function has external linkage?
>
> No overflow looks reachable today: the only callers go through the
> yt921x_reg64_*()/yt921x_reg96_*() wrappers in smi.h with a literal 2 or 3=
.
>
> Would it be worth naming this conversion in the commit message instead of
> just "Minor changes are applied to fix build errors"?  The lengths of the
> caller supplied masks[] and vals[] arrays also remain unchecked, which is
> worth a word since the helpers are now callable from other files.

It just isn't worth it to do fancy checks to these simple helpers with
tons of macro hacks.

> [ ... ]
>
> > diff --git a/drivers/net/dsa/motorcomm/smi.h b/drivers/net/dsa/motorcom=
m/smi.h
> > new file mode 100644
> > index 0000000000000..2995e91f3b3d1
> > --- /dev/null
> > +++ b/drivers/net/dsa/motorcomm/smi.h
> > @@ -0,0 +1,92 @@
> > +/* SPDX-License-Identifier: GPL-2.0-or-later */
> > +/*
> > + * Copyright (c) 2026 David Yang
> > + */
> > +
> > +#ifndef _YT_SMI_H
> > +#define _YT_SMI_H
>
> [Severity: Low]
> This isn't a bug, but the guard name here is _YT_SMI_H while the sibling
> private header in the same directory uses __YT921X_H.  Was the difference
> intended?

We are going to use the _YT prefix for guard macros instead.

>
> > +static inline void update_ctrls_unaligned(u32 *lo, u32 *hi, u64 mask, =
u64 val)
> > +{
> > +     *lo &=3D ~lower_32_bits(mask);
> > +     *hi &=3D ~upper_32_bits(mask);
> > +     *lo |=3D lower_32_bits(val);
> > +     *hi |=3D upper_32_bits(val);
> > +}
>
> [Severity: Low]
> Related to the above, and also not a bug: this helper is the only symbol =
in
> the header without the yt921x_ prefix that everything else uses, and it i=
s
> now visible to every file that includes smi.h.
>
> Its only users are the two METER control word calls in chip.c:
>
>         update_ctrls_unaligned(&ctrls[0], &ctrls[1],
>                                YT921X_METER_CTRLab_EBS_M, ...);
>
> so could it stay a file local static in chip.c, or get a yt921x_ prefix i=
f
> it really needs to move?

Irrelevant to this commit.
