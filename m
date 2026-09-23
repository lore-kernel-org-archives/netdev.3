Received: from mail-ua2-f33.google.com (mail-ua2-f33.google.com [74.125.226.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D41773C7691
	for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 14:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.226.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790174457; cv=none; b=L7nUn0Hj9JcR1RJZRUdJXaBJnb3yZs1LcwX6G0IcjZ4VG8kWfHNyPM0cgD23YnAQkBYuOmfUQe4DesZ3Gc0sebpqRe0toXPUwI3rYl3HUhzDfOUHsZOBjVSVMtxqvkNXCfeXkzCKkmpIOvATwTc4w4OsXpcwpZ9A0qwc19KlFR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790174457; c=relaxed/simple;
	bh=HAiG2uKeueum3NwR1fOOATsx3Nfb/2XuIB0lowPT5AE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JJDbYLoXbMkSmsQJHzmChfs0UwvI4Q3/wCd6ZG3pk+ORpZenEZfz6sgSsUZqIzNPGdXYQfGUwqmEVqAFIna5V4zw5RZkpu517lDFK6K3HeO+7MiRJNpMYRs/p5UxxQJsxixwCrMWZJwpqTSO3mBHPjXtAmsc84h3Oiw5mrFKLrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.226.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua2-f33.google.com with SMTP id a1e0cc1a2514c-982db8d3b79so325574241.1
        for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 07:40:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790174455; x=1790779255;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=3QXVYin3gKtafVdGEnWDbswOTPSZ/Xq4fs9pj7jQGAU=;
        b=mu6q2gAlbbqQ/Ud2QL0q79ilALrTkC5VArxUwtGjgeI1cJxAo9h0xEPFogxFuUN+n8
         KVUVmcB540p8W4FKw8bJ8o6XQzQvNajBXFurJjN9Mfkk0/rKQyH9+3mEBy00EVW+UKVG
         tU5wPdJxaO1lfZG0D28n7PY2WzELyPS0okKiUI96lqOXmLO738hU3JkzdpBVWtEyG+cq
         I3bLNKajqlN8ev2IGF1oUA7cNBlNhrrUuThSdT9uCyFsxpIREsKoh3x3Ir2EnTTL9mvj
         51j8zAqeZEFq++/tidEsE7nX6bPRjNJeR5jX2HN4vbPu6YB0g9eRVtUZLo7jX6Nee6qw
         7F4A==
X-Forwarded-Encrypted: i=1; AKwUvBwHkyfbZwk3QYUknEcxkCoDikC2CrnB7ukGXlHsJQ5PbADNJ6QMMAGtngfBE9lyv+gqCNPY3jo=@vger.kernel.org
X-Gm-Message-State: AFuF++krxpqUfWKAnrvZalRCScGmt8DHazo0Rivt6qV1Ib//JkrGi4xn
	LX6uIR3VA7I7C99x/0yGl1QbsDLt4JEYYRloP52eL7ia2+xy/wq0Z8oRlGXko0fsrAg=
X-Gm-Gg: AYBFou3vxOeNgTSBoTMouuKFsbbwSiZuu5ZGq+vQ/MtqsqdMQ760oG2PxWssfTGngkZ
	AryrmL2QnThVKd1TMZ/c1ePHnxnZwthDfp15iS5pSDndjjdwlUSUrMlSv7VGUDG+0gGs0kqtl+C
	82+YY47L5G7Ja8pPNmiakMFfq8LuxeIhwDE6FCaZYeGM3lBMfXyJP8TpZK7eYawezHdd3FIERQA
	l8OYfoHFMjbhc7lpPMlweREppAo/RwV3oWoqB18Vxl+QHtEUhH18VLR6eINY3ODxWnZLt/xQOU8
	zeojbgRMd8b6nFY9A+7wdjwJmVK99s5JWmriAjdA356K49EDG774TUF4diUARRCNDuIO5X28L1F
	HUIQqfxjVAJJk+FKiFp9E0sp058hcxQCm+wqwgMzBhjmQdho9s6hIkgNeQLz4vp9Vv9U7x4MqeS
	kVJ1cc6wtRjfTe6K/ORNeypw7/Kk4Hnen9Mjq5Syj9S09pTbcAV8/sOR1T1hkwDS8xaffFeNEHP
	v0ASoLYsQmK/ahRBhHCQHXuXgOSxsjmrksE7EMn0JKrUCPmu3NT4cEmEDg=
X-Received: by 2002:a05:6102:5808:b0:789:5f54:2367 with SMTP id ada2fe7eead31-7ac1b1fa129mr2414723137.4.1790174454698;
        Wed, 23 Sep 2026 07:40:54 -0700 (PDT)
Received: from mail-ua2-f12.google.com (mail-ua2-f12.google.com. [74.125.226.204])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-98516a6ffc7sm3517673241.8.2026.09.23.07.40.53
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Sep 2026 07:40:53 -0700 (PDT)
Received: by mail-ua2-f12.google.com with SMTP id a1e0cc1a2514c-97ea5bd53b4so365315241.0
        for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 07:40:53 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBynzWP6ZOX4s1rNcyCOm2XGmBLmuRZ41xyXASvbIm1BeuoNGYQ3z+w9JoBaTawmS82J57FQY3E=@vger.kernel.org
X-Received: by 2002:a05:6102:3711:b0:785:c643:a415 with SMTP id
 ada2fe7eead31-7ac1bb45468mr2431267137.12.1790174453060; Wed, 23 Sep 2026
 07:40:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260907134037.1855408-1-gerg@linux-m68k.org> <20260907134037.1855408-2-gerg@linux-m68k.org>
 <42ad1525-fceb-43d6-aa03-d17e844a9ad9@linux-m68k.org> <eb987eb9-f368-4d28-bdd0-c289c3039c3b@lunn.ch>
 <46246a5b-3e95-4ecb-bc52-e374dc136514@linux-m68k.org> <fe8a632a-80a8-45da-ba64-31158af7c987@lunn.ch>
In-Reply-To: <fe8a632a-80a8-45da-ba64-31158af7c987@lunn.ch>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 23 Sep 2026 16:40:40 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWrRmvaEVjs4Whncybn-zVCKStC4gOpvwsnT+XRtm9Hbg@mail.gmail.com>
X-Gm-Features: AclHuK8JOpxbtBL9eo2JZ21xOlmZ2HJ-Q_I8grURwALj-s_IRRLbJXlaWaj0iq8
Message-ID: <CAMuHMdWrRmvaEVjs4Whncybn-zVCKStC4gOpvwsnT+XRtm9Hbg@mail.gmail.com>
Subject: Re: [PATCHv3 1/3] net: fec: do not use readl()/writel() for ColdFire
To: Andrew Lunn <andrew@lunn.ch>
Cc: Greg Ungerer <gerg@linux-m68k.org>, linux-m68k@lists.linux-m68k.org, 
	linux-kernel@vger.kernel.org, arnd@kernel.org, wei.fang@nxp.com, 
	frank.li@nxp.com, shenwei.wang@nxp.com, imx@lists.linux.dev, 
	netdev@vger.kernel.org, nico@fluxnic.net, linux-can@vger.kernel.org, 
	linux-spi@vger.kernel.org, olteanv@gmail.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"

Hi Andrew,

On Wed, 23 Sept 2026 at 16:16, Andrew Lunn <andrew@lunn.ch> wrote:
> > The driver will always need to support big and little endian hardware, so I
> > am not sure how to avoid some abstraction like this.
>
> I was wondering if there is a linux standard set of macros which is
> supposed to handle this big/little difference, the macro knows the
> architecture and does the correct thing?

Unfortunately not.

Quoting Arnd:
   "fec is an exception to this because it happened to rely on the
    unusual macros: all the Arm SoCs using this hardware have little-endian
    registers (regardless of whether the CPU runs as BE or LE), while
    all the coldfire chips use big-endian registers (and don't support
    LE kernels). The powerpc variant of fec also uses big-endian registers
    but has a separate copy of the driver that hardcodes this. Other
    Freescale drivers already have a runtime endianess detection that
    is needed because they built both BE and LE variants of the hardware
    on Arm SoCs that could run the same kernel."

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
