Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E973D3AA1BA
	for <netdev@vger.kernel.org>; Thu, 16 Apr 2026 11:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776339046; cv=none; b=PY+p2//XoVKmRN59x7gaNFUPSXCbqFLeCfUMgBIXFB5gJjOSg9PKPX4uFysxWQbtRM6yqGzsKc1/5deRWD7lNdxeom948QVKqrqY7bDKg5UsWcURZkz0uALj3C11NdWx2bqEhlI/4szyapNENtRt+v/osePSDyWOSgk7ezomDt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776339046; c=relaxed/simple;
	bh=5RcGmn3E6IkK/4PLTUVN24XJ2jAiV11BodM4t9S5uGE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f6qw9ZlQqlz+cVQKY7WsOmzj4/brJHXtG7mVwuWlAmYo2XaqhNyfALfAWpEVFC6z0e3/003KzOEhsfqv6RklxrmtFDIY9RyWAh1TQC0VH4UpKMIW6Y0wOxzcRCgc2rrnQadj1ot8oLUSH8Hu51re5hw3h8z/1c5GkKX2TVaJRgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-50de80b9567so38458581cf.0
        for <netdev@vger.kernel.org>; Thu, 16 Apr 2026 04:30:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776339044; x=1776943844;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I6jqlHRyBmHp78NPQbVn/INUSPCxYZ/sUXVIyq1nXfE=;
        b=RpvAu5qXPCMBZZeM+Zh8jE6VXS++mor8uV2m1XRwi+UbvvPeAwVZas+u47X4ly8G9x
         6lo2Fl9bXUJHP0jgEcZz4Pxe7/1VH/AKnfRN3BwtXRLbT4q/UbXrwW3c9jueXdPhhHSp
         wb95WY4FECseMSt8AlGGfJeNYYi/epcT8Q+MDyMHfvWPzbHoRTDvIFG1NHNR3g7YBvl/
         I2XnV15jOOzr9dZLTPOmO9KuW6lJ1s9VI4e9nyUOSOsCsCZk94YR1O7hWstAoAsB4Tvi
         lBLfW5l5KdKF49whVM75IyLEtivAEGSKi1SdtfxzcHIXHvSiPT9pfz9W2Dbc1CkeY+tz
         pQDA==
X-Forwarded-Encrypted: i=1; AFNElJ+RS4HpoSyFZAuZEIfg5YgPz1kCbcAA8YlYCUoR6/BCcnMHvv2XeSiX/KayOdcWiQcigufWsxo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxPgT4SbTZ6aPTLzn96ZIJOUbr05+ligzvFFeQ2R0+L4aDWint
	iSF1xhnimL7z8PyVq0iodFXHQK/5UOzCALfmVmBMxni6+tgdR+EiL4fiqtMCWgJK
X-Gm-Gg: AeBDieuuuuc9KxIGKLefPKb3N4lFuM+uSSX6XW0PP/dhVd94o5I1O+k2cMzRrW04geH
	FlR8bskEs3oE4d5J03ka3sAdm0H2fApCOfdxy/Hm2+aJxqDwbP0eQPAe/lzP2vxciW3XzgJzRzS
	3CmDt5swbD6TxQj5Wvpv5WAKh5VceqgCmJ8fDprB4avKbJnsfCNZRaHG1Te0SMK1Ud4XLzGgy3P
	a3E+v37IynjvQhnzjvCOHvoLf/hRBjU3pG6GDrq94rvUYnEBl/Adi+x+wHj+b7lv1nC4BDjEeEg
	6tE2cfLPrquyoGPLMq8Fz5z/CoGc4lMQSKvEhRF2mV0rLtpmeQesYvrz5cd21mT32CZ/05j0Sdj
	FZTFOXkQF8wM8fIXpF+gMZDiRfCHpNnHjSGQ9WIHAJNGTQoUBZu+pyw658ZQW5tLFN/+8E+ZzE4
	RNssBP0Q5iNfEAOBRiJf1lqzrrVeMJMJwK85gEq0LNXGPKExDkr4m+Te0OR6rHmR6VVt27a8U=
X-Received: by 2002:a05:622a:13cd:b0:50d:c0c9:c985 with SMTP id d75a77b69052e-50dd5b30efcmr380120121cf.2.1776339043235;
        Thu, 16 Apr 2026 04:30:43 -0700 (PDT)
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com. [209.85.219.43])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50e1afc1629sm46110621cf.23.2026.04.16.04.30.43
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Apr 2026 04:30:43 -0700 (PDT)
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-8a154cc6a48so92085876d6.0
        for <netdev@vger.kernel.org>; Thu, 16 Apr 2026 04:30:43 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9PNV7wPfHqf1d2ZItwtbeXPqgwmgmmEcEMWJb5JKs+iybf66Kpcx2oSHLExJQYLvBr78uE/UY=@vger.kernel.org
X-Received: by 2002:a05:6102:6044:b0:5ff:c64d:2283 with SMTP id
 ada2fe7eead31-60a0157295cmr11348128137.30.1776338547396; Thu, 16 Apr 2026
 04:22:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260410120044.031381086@kernel.org> <20260410120319.397219631@kernel.org>
In-Reply-To: <20260410120319.397219631@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 16 Apr 2026 13:22:16 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVoo_6i9=2oQj-=yjW7nK8eL4og08bdYvk_EGj=_cQvQA@mail.gmail.com>
X-Gm-Features: AQROBzCJ6rVnwwfhi99PI36wWXAFQ5DEgo1zw3RhVwYNSXoxkTYAcgIxt5Z0K1g
Message-ID: <CAMuHMdVoo_6i9=2oQj-=yjW7nK8eL4og08bdYvk_EGj=_cQvQA@mail.gmail.com>
Subject: Re: [patch 27/38] m68k: Select ARCH_HAS_RANDOM_ENTROPY
To: Thomas Gleixner <tglx@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-m68k@lists.linux-m68k.org, 
	Arnd Bergmann <arnd@arndb.de>, x86@kernel.org, Lu Baolu <baolu.lu@linux.intel.com>, 
	iommu@lists.linux.dev, Michael Grzeschik <m.grzeschik@pengutronix.de>, netdev@vger.kernel.org, 
	linux-wireless@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>, 
	linux-crypto@vger.kernel.org, Vlastimil Babka <vbabka@kernel.org>, linux-mm@kvack.org, 
	David Woodhouse <dwmw2@infradead.org>, Bernie Thompson <bernie@plugable.com>, linux-fbdev@vger.kernel.org, 
	Theodore Tso <tytso@mit.edu>, linux-ext4@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, Uladzislau Rezki <urezki@gmail.com>, 
	Marco Elver <elver@google.com>, Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com, 
	Andrey Ryabinin <ryabinin.a.a@gmail.com>, Thomas Sailer <t.sailer@alumni.ethz.ch>, 
	linux-hams@vger.kernel.org, "Jason A. Donenfeld" <Jason@zx2c4.com>, 
	Richard Henderson <richard.henderson@linaro.org>, linux-alpha@vger.kernel.org, 
	Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org, 
	Catalin Marinas <catalin.marinas@arm.com>, Huacai Chen <chenhuacai@kernel.org>, 
	loongarch@lists.linux.dev, Dinh Nguyen <dinguyen@kernel.org>, 
	Jonas Bonn <jonas@southpole.se>, linux-openrisc@vger.kernel.org, 
	Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org, 
	Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org, 
	Paul Walmsley <pjw@kernel.org>, linux-riscv@lists.infradead.org, 
	Heiko Carstens <hca@linux.ibm.com>, linux-s390@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 10 Apr 2026 at 14:20, Thomas Gleixner <tglx@kernel.org> wrote:
> The only remaining usage of get_cycles() is to provide
> random_get_entropy().
>
> Switch m68k over to the new scheme of selecting ARCH_HAS_RANDOM_ENTROPY and
> providing random_get_entropy() in asm/random.h.
>
> Remove asm/timex.h as it has no functionality anymore.
>
> Signed-off-by: Thomas Gleixner <tglx@kernel.org>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
