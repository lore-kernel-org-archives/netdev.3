Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 909453D9547
	for <netdev@vger.kernel.org>; Fri,  9 Oct 2026 20:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791579179; cv=none; b=YO4AbzhBHa06ShOhx9YWQ8SEvj1jfWEr3f99fQf6IqUo91od5yx/eE5LqnW2B3qeBeJdeKJ17IoVQ2MgBTTjqbrV01JLP9tH0f5UhPjHAxlrSQ8r41Rh9m3ZpRbjVCsnvZqzx7j29mycWD2N27WOSXcwqK7WraQ5+8cnZc1niM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791579179; c=relaxed/simple;
	bh=3le5P+h/KiA8eq2M8tVprosyJ+rYeh5W5GrP/Ck16/4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KXeBkNsHrIdFvNZYG67QbG56SpvSZJerLiT/6KxJTHENHLO7vUgLXgiLsXebGCtxlctImo0FimtxlpsN1K1v1oegUS16IgQqOiDWtG/LmQV1uH2v7RICH5sWY3NHr20U4xdGkbXLqpTJqYlbzW/B6KWcfb/U22BK7NuIo5rgs+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-8ab395abf79so828107b3.0
        for <netdev@vger.kernel.org>; Fri, 09 Oct 2026 13:52:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791579176; x=1792183976;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CRIIxOajP0yzIY23BtbyoAhj2PBRdU9IpmRdYvRMNJ4=;
        b=YwlvD6R3efvyiSdQ8LhggPdduk7AzwrqJjzcc8j/H7XV/tjIW8Do2UPNeJAynZRykd
         Nz7bOZTHbYavLo4ZS8lOMbOWBggNbvzpwQo/yC+J2qy+U9AnGwYY55kBPNb869MblevD
         MkgEcEW93q8kNTz6npNnHcnL9BIaPWzZk7E9/G3oAnHxXusKo+4xrs7Ez62mR2U6SmFs
         XcVOvy7ufDtOr1iOb5TVBiG+DhnquRVW7QAMxyw0heMpY5ZzK47vqke/mJ3bG8Ijwdw0
         VnwFawJ6l3xNhByk+G6zUFi4t9+qsBuJppDGRoheBE3OTWhHMnuF3x5yf49eSP9KQH9Y
         Idog==
X-Forwarded-Encrypted: i=1; AKwUvBxhJXmBp206VGjdW0QCY8ymdZds3NS2SwuXg9ZuNIur3pVig6VFCiJtDiCLVISfJdVxKXFDP1g=@vger.kernel.org
X-Gm-Message-State: AFq9FYKbsg4kabInmdp8sL3PoBt4GOBzBloAvDo4Y3Uj0wT8RvSQKHbe
	R3zBu3Zz2SO+CjzcqExZFOvOGnC0gOfyEnnVz2LkdmCKI5UmTEitQlnNqvHQrmxsqoc=
X-Gm-Gg: AYBFou2E8oqe2SDUFMoiR7lTlb7pE5OT4TCEPVE5lWfPZ6uhhW/p/D9iTHOpLCaUZyi
	EZ30zuTPncNcVJOagPoZvX/vBs9TARz4CZ29B/hrA8OmdZYpHF5Y9mtf4S+7GgLUOO/InFl3YNa
	vrA43/xJf8JQR+RhrBpwCWz06RtYralT3eBhvqb60NSy7/RB7Am7WKm4LLNqCij9W2bvXAk77bU
	j+abD0k+R0zYhfGfRLKIYE39GgEIdgWfItuUwbIvpsXeBWOY5+QYsXIajT630D1D5ghb7AY0JHe
	ruKnir23UK50cMgyz5y0TpdNMHJi83JQqZF2uP55fPRbJJbfj7ZiuEAUpAOFZl/2cuFGlJu5nD9
	SOkbqV0+py66UTEkK6IkM2NaXsibNBvhCn8fge8kyuKQFnAOv14tK8RHMuZw3lUlBPSWDxCJXTt
	PcqHQ0SpcmmU7VYjbPuvEEBLFp8FdbE9vNlNFTOHNlanBgMLbv9vgcX0sFDwCGOnl2rDDGRuAe/
	nXTyn8gk1HPULGDSPVoNC8JHihQA4J5xldBMtJCs8XY0ckxajrMY2yH/UcLB2I=
X-Received: by 2002:a05:690c:ec4:b0:8ae:dfee:cd12 with SMTP id 00721157ae682-8b07ee0699emr14331567b3.22.1791579176440;
        Fri, 09 Oct 2026 13:52:56 -0700 (PDT)
Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com. [74.125.224.54])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b07f1b7483sm12013027b3.11.2026.10.09.13.52.53
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Oct 2026 13:52:53 -0700 (PDT)
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-6768403e9bbso95688d50.1
        for <netdev@vger.kernel.org>; Fri, 09 Oct 2026 13:52:53 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBx6WCQYFWajR3cxmQ7CpKAbaMKE0lEuAI12acdkGKOBiM6+/bZljJKa0r9FgLaVIpWltqosfDk=@vger.kernel.org
X-Received: by 2002:a05:690e:440f:b0:677:d3d8:990 with SMTP id
 956f58d0204a3-67936768725mr589216d50.6.1791579173056; Fri, 09 Oct 2026
 13:52:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261007082627.63807-1-tanure@linux.com> <d23dfdf3-5837-459f-afd6-6c198a05c13c@lunn.ch>
 <CAJX_Q+2au4x99kj=UBqn4joQCM3-D2kbaJ0zro9Y4RXka7ePvQ@mail.gmail.com> <3a037c87-e4c5-4a4e-9522-cf505e1c6399@lunn.ch>
In-Reply-To: <3a037c87-e4c5-4a4e-9522-cf505e1c6399@lunn.ch>
Reply-To: tanure@linux.com
From: Lucas Tanure <tanure@linux.com>
Date: Fri, 9 Oct 2026 21:52:41 +0100
X-Gmail-Original-Message-ID: <CAJX_Q+22tckoRKsEt9_oakAsN=+cwHdX+WPcaGWR9_3EMqM5ow@mail.gmail.com>
X-Gm-Features: AclHuK_m9bgs2ZxoWfD-m6qDBIuQp5RI_xHW6gmLTuflU7vtLwdOlVbkLA0qUf0
Message-ID: <CAJX_Q+22tckoRKsEt9_oakAsN=+cwHdX+WPcaGWR9_3EMqM5ow@mail.gmail.com>
Subject: Re: [RFC PATCH v2 0/7] Add ethernet support for the Amlogic T7
To: Andrew Lunn <andrew@lunn.ch>
Cc: xianwei.zhao@amlogic.com, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Kevin Hilman <khilman@baylibre.com>, 
	Jerome Brunet <jbrunet@baylibre.com>, 
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
	Maxime Chevallier <maxime.chevallier@bootlin.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, netdev@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 9, 2026 at 1:13=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Fri, Oct 09, 2026 at 06:59:49AM +0100, Lucas Tanure wrote:
> > On Wed, Oct 7, 2026 at 2:01=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wro=
te:
> > >
> > > On Wed, Oct 07, 2026 at 09:26:20AM +0100, Lucas Tanure wrote:
> > > > The T7 pairs a Synopsys gigabit MAC with the same glue registers th=
e
> > > > G12A has, but nothing described it. This adds the binding, the driv=
er
> > > > support and the device tree nodes, and enables the port on the Khad=
as
> > > > VIM4.
> > > >
> > > > Unlike the G12A, the controller reaches DRAM through a pipeline sta=
ge
> > > > with a gate of its own, sys_ampipe_eth. Nothing else claims it, so
> > > > clk_disable_unused switches it off and transfers stop.
> > > >
> > > > v2 changes the RGMII delays, after review. phy-mode describes the
> > > > board, not which chip adds the delay, so this board is rgmii-id.
> > > > dwmac-meson8b did the opposite, and ignored the *-internal-delay-ps
> > > > properties. Patch 1 fixes that. The VIM4 needs it because the RTL82=
11F
> > > > transmit delay does not work here.
> > >
> > > What is special about the RTL8211F?
> > Maybe nothing, it may be this board. I cannot tell from here.
>
> Yes, look at my other reply. The RTL8211F is very likely correct. It
> is the MAC drivers handling of delays which is broken. You get to fix
> it for this new device.
>
>    Andrew

Doing exactly that. v3 leaves the existing delay code alone and adds a
path used only by the T7 compatible, built on Maxime's
phy_fix_phy_mode_for_mac_delays(). Testing it now, then I will send
it.

Thanks,
Lucas
