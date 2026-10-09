Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6470041DED5
	for <netdev@vger.kernel.org>; Fri,  9 Oct 2026 06:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791525607; cv=none; b=rmfPNrJldX7rSYkflf9qa8/394B4aBRofne4ywzX6aTwPSZ3SN1g2ccRoCCk8FcF36czpWkvuOoRhT2xpOChLsSri6sulmq01fBVgF3z4A1vzmsQgMkBgNdminzc+FsYXPz2jDSqDp/zP1KFPYu3kxoqYMMVIBOy02P5hqi+Pvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791525607; c=relaxed/simple;
	bh=is4gJLoi2ipJmooXAfray6TyXKGcAgJe47D+iW9qPlA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u+mCjzXWrA5PBHeyosCr+/yZ9z0zb9XSvaZgmrHftuRWDXMh/uMac3VvFMBXLL/6J26Y6aqDtXQCAv/hlvggDMW30chGImp5LApUjS7wX+7Y6RznSh5XazWx2pG3eE5/sRqkynLNV7VraWNugr/KVFcYOo6tiid6LHnEVoPZ6pU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-8ab3aaf416dso37614927b3.2
        for <netdev@vger.kernel.org>; Thu, 08 Oct 2026 23:00:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791525604; x=1792130404;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tWTuV8nTat+7Ise5DAVZrckoXbB3rEEMphlZwWdvIzs=;
        b=zL1Mu0bWyImN//AA/7lA0OqJv0P4adon28QGZcv8FulbyGI4xj8a3Nc4Dxf9oKjI5y
         glO3YhMbanyEyaRgOqf041q4C0NGrO1zMWwlCJrIvQrF5c984vltZjbEHyCZFpV3PnFM
         DPoaFaE63a6u4LdLRK76X0NMttaG78I+pga8YxM489aOrda4fmJ+bjTyXuF1ejgGRwDw
         JZ4ZeRGrHRrHX4x6pgfddTFze77XCQCOktNk+2iWKFfH9GOYcZBbVFY1wFFIHiMb7Lhc
         ZGKR8GXR7i4yLD7QI8c8n5D+g74VybcTxPBsJQNEW95qxCRcBwYDBlrYMVmXaZj/CbHH
         FPjQ==
X-Forwarded-Encrypted: i=1; AKwUvBzSrShNCnmAIr05cZyEy30Efq4D+UKHteXS47RAL/Y/UgnRmr/xEaC8N85BiNe5Dq6uM4yidII=@vger.kernel.org
X-Gm-Message-State: AFq9FYLIy494mMS1Zdvi/AJHqyD/qsNc1rDlJG7EZgkiVsF3MCk+RdjO
	LPKNEhIm0gyQDFVFBZfhDhTyJHlO97hd5dogeNDIGVUkbhZyZWCJWzmUc9zCmMnEneQ=
X-Gm-Gg: AYBFou2KTqM9VovrpPKQy6ad5lxAb+w5SBvUDHNWdKpFrIz7gBS/5AdavUA7SjAjtIb
	msryGDbwHHOR1RpFy3I4AsWLWRU5UjriV5N3Y0QpNsmwBs87qMP38Ne9DSsMiwzNmD1KgcVFtaO
	MwH5pd+CR5VK2xUlcZT60CHjuKDBJXbXniSnpeAWrz7OwV//RAVdpX/rWZg2c5zza38zDkGM5fZ
	HRBsbKb/qIzDoPSvXecQG0YbOm+O/6JYhxeeg2PrRDJgrtbWO+Xg3EGrmnO8bwlkWU632K6YHmO
	KEBN7ZJwfTHAnGSVKaGtUWhOZGTuZo9XQ2UbRs8KtGVkJ8iJv4MJ9xc5Bt/ylz8ne006riu2fIj
	a2DOvxgTboLEN8hXzMkOBr+cRA2vL5vUSygG2wfaOCUof91AsyyZCWcbDcoT70bu2ttIi+7PwyT
	wf9qpDtJHhyfkWeUbM4hPNL3N3JkKd2qXpMFMJFM1ZP9jno+iu8/W3QbtQCxOCk/gVt7O7rOnKa
	3wGl6kHDOu2+iOMmXWLAwB7Fyp0uIQs8Jr12Kw4THc/iBbqJPTvLtttku7Cw8+K/Tgl9BnLzWkp
	L4I=
X-Received: by 2002:a05:690c:e654:b0:893:44af:ceaa with SMTP id 00721157ae682-8b07ebf99b7mr1880737b3.5.1791525604272;
        Thu, 08 Oct 2026 23:00:04 -0700 (PDT)
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com. [209.85.128.172])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b07ed0b54asm3759197b3.0.2026.10.08.23.00.00
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Oct 2026 23:00:01 -0700 (PDT)
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-8ab38a051aaso38545467b3.3
        for <netdev@vger.kernel.org>; Thu, 08 Oct 2026 23:00:00 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBzEe0WvB3WCk3qHWDIvhCws62XEcMheVB3ZLBEgY9RYrjmvQF2l2UqspTyUu3kgqSLk2O5xmXA=@vger.kernel.org
X-Received: by 2002:a05:690c:ec4:b0:8ae:8d28:77ca with SMTP id
 00721157ae682-8b07edfbad7mr3120487b3.33.1791525600619; Thu, 08 Oct 2026
 23:00:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261007082627.63807-1-tanure@linux.com> <d23dfdf3-5837-459f-afd6-6c198a05c13c@lunn.ch>
In-Reply-To: <d23dfdf3-5837-459f-afd6-6c198a05c13c@lunn.ch>
Reply-To: tanure@linux.com
From: Lucas Tanure <tanure@linux.com>
Date: Fri, 9 Oct 2026 06:59:49 +0100
X-Gmail-Original-Message-ID: <CAJX_Q+2au4x99kj=UBqn4joQCM3-D2kbaJ0zro9Y4RXka7ePvQ@mail.gmail.com>
X-Gm-Features: AclHuK8Z8XHB904erYGkjWemp1Y2Gn2Ya3i9_K0CjW0XJN3l42AYcMZ32Srg4dI
Message-ID: <CAJX_Q+2au4x99kj=UBqn4joQCM3-D2kbaJ0zro9Y4RXka7ePvQ@mail.gmail.com>
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

On Wed, Oct 7, 2026 at 2:01=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Wed, Oct 07, 2026 at 09:26:20AM +0100, Lucas Tanure wrote:
> > The T7 pairs a Synopsys gigabit MAC with the same glue registers the
> > G12A has, but nothing described it. This adds the binding, the driver
> > support and the device tree nodes, and enables the port on the Khadas
> > VIM4.
> >
> > Unlike the G12A, the controller reaches DRAM through a pipeline stage
> > with a gate of its own, sys_ampipe_eth. Nothing else claims it, so
> > clk_disable_unused switches it off and transfers stop.
> >
> > v2 changes the RGMII delays, after review. phy-mode describes the
> > board, not which chip adds the delay, so this board is rgmii-id.
> > dwmac-meson8b did the opposite, and ignored the *-internal-delay-ps
> > properties. Patch 1 fixes that. The VIM4 needs it because the RTL8211F
> > transmit delay does not work here.
>
> What is special about the RTL8211F?
Maybe nothing, it may be this board. I cannot tell from here.

The RTL8211F does add the delays, the driver sets both bits and the
chip takes them. But when the RTL8211F adds the transmit delay, this
board gets no working link.

I measured the receive side by sweeping the MAC delay against the CRC
counter, with the PHY delay off and then on. The window moves by
about 2200ps, so the PHY receive delay is right.

Transmit is the problem. With the PHY doing TX the peer sees nothing
we send. With the MAC doing TX it runs at 935Mbit/s both ways with no
errors.

I asked Khadas about the board, no answer yet.
>
>      Andrew
