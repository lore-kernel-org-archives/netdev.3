Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E8FE38C402
	for <netdev@vger.kernel.org>; Thu, 10 Sep 2026 15:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789054692; cv=none; b=X328zym96BjXKI8Aqkhx0Pnst7QOlYqWjEQbo5KQ1oDGH+nhHax3HvZtLSscru3Di7xAFNwPPB+UMDU+bOXbQ1Xd4lE+wwUMXMGJGFKPc6fHMDh43Mke94D5dpI/3EevdJtSaPXvp0fSimqD0FxUdX6aGsbi3yB5oT0s2hf8tXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789054692; c=relaxed/simple;
	bh=xzgmU+3eO8YII0oYWVrjp5IxxZ4falecarjMuKf3Ipo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kDpDrTbs7bh09fO6r/xs7D5Y1HuEWXFFHX5pkNEN8LVDVhoEa8FmBWemNmSyCRBa9iVL96sMK/uwV/5zE3Ty3mPiWE7T5+EmYDCeNhzgaE2FJibib7Wio/osVLYuGkWCTUpGRXnNWnGuDh6Sju9irpsPBTPLUgq1397zqhnh/hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la; spf=pass smtp.mailfrom=lex.la; dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b=g37y6Ceq; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lex.la
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b="g37y6Ceq"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-4834977ae75so1369683f8f.3
        for <netdev@vger.kernel.org>; Thu, 10 Sep 2026 08:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lex.la; s=google; t=1789054687; x=1789659487; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=sTVSMjfFwifuGhbOPl5kVMZz0VGT2RwpXS+yJiNYpds=;
        b=g37y6CeqAw3TwRRgzu9TkSvXZI3soAHL6VoqrAzGCP3vrsTpft8XHcSeMCQtbl33qP
         CE3dtvcFu7wNW6WdsPWVYL0ZNtu0VFODGlVwY30O+wCT6wFLZdLveFydPKarofHR/ViI
         Nlalo/v9AV2Sa+LykR5foAE41A2qLuyd7blaOkzCyW01L3VZC5PdMREGdzIzlSqOPnIx
         6bx25Y6XWnswBN6jMvI7CRl6knAluqWf2sKVHlDmIpJe8WTSASY/3D/oJnTy2lw95dOP
         kd7U5IYHnIrdQvPQcAc6DNEg9N1C75rqWySuUj8IwEvrNgjVOv9bDh500mXq9lN6ymqI
         U3TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789054687; x=1789659487;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sTVSMjfFwifuGhbOPl5kVMZz0VGT2RwpXS+yJiNYpds=;
        b=bYSl+sRIuHoFH22xL/2xTyzU/Li60RlwDzGm8p5+0CPAj0OsHTmmo/Cv6HQ+JXpNTK
         X6US5DiP9CvqCymxCcAfzl48rxbP+x2FvDi0aOg1/KZijgxnbY1ptc7yjIXuUfJ2ag/8
         1cGYrr5wApBqp7tXWfSOKttwE2/S0eh06wTNSYdu+5MnSltdhToITVGxjA9ElndMRTdU
         3V8FQz7P/FXcnbqOOwv5MQQp6VjCSIARC7ztRAdIc9oz/R6i4iz2CVPMWfpUPoBglOiw
         sPEJYB2smuuQKTQWdqZEndwrAxnCfsBgpPmJoW0BbYtHn3QM4mu8OVkuYPx/CmrepkCn
         ROjg==
X-Forwarded-Encrypted: i=1; AKwUvBxfANIPVblRZY8iuHJVK7kV7u93JFikib36eB3ZxHJstLC9SRI2l6ZRFMZcKsTYckPPRRR8Kno=@vger.kernel.org
X-Gm-Message-State: AFuF++nKJVq8mgbOIj3ZVrO+YaUwb1u/0uMdqMJk7dzZUYZGG2aRjuHQ
	OqR2cq/jls5xZz4tCQN8XlMedmBNlkl9XKJbO20Fph7O8VenHgZWEoNDBoeemKG8CjA=
X-Gm-Gg: AYBFou0qHeYE4TMU/X3eZZP+JuaX9c4e0VVe/eD7yiqU1vsG8lJsHsmvejlgfr0DYoX
	6NBcG0LiD9X8r37ggcChEwiVesXPIkxDtqwqwxHa1C1cEENk7inq+xpn2JneV1LMXrHrYHJEHJ9
	6k19ZqV6C6urzCc5Sbm0wwVv6Oe5u5xv6YFny7qmB9qytX0F1Dictv6uMmA3NOWK++nESk3unNU
	7co9aZgDhy51d7+GR7hjrvMB1YeI5O3FwC5ZD37iUcc8MXEsJpstOewgRkSyuy/wsErgsLOEAT1
	0eFIe08nHRwVTJfU4wQLXA9/nenXo3Mj9a1TQsEi8AA54CeVFlb/jiY79CqXhtggXi7gRPRDKqV
	VUjmE8fPeoEYVpt9kd++fsTHqyGCOB1LHv/TG0fr1swGGC3NoTZXy/K9+AgJ/Egc3sjK16zor+j
	SZaPeFaz65O9+oyY0QKrczc7RfCPY/REP0jaXGybKsZqJj6FSLNCkoprtOKWVo
X-Received: by 2002:a05:600c:698c:b0:49c:edfe:d525 with SMTP id 5b1f17b1804b1-49d1f35366fmr293842895e9.10.1789054686605;
        Thu, 10 Sep 2026 08:38:06 -0700 (PDT)
Received: from remote-01 ([84.17.55.229])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4858d2693e8sm50753677f8f.3.2026.09.10.08.38.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 08:38:06 -0700 (PDT)
From: Aleksei Sviridkin <f@lex.la>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Aleksei Sviridkin <f@lex.la>,
	andrew+netdev@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	ericwouds@gmail.com,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH net-next v2 0/7] net: mdio: an MDIO device driver for the Airoha EN8811H
Date: Thu, 10 Sep 2026 15:38:00 +0000
Message-ID: <20260910153800.777902-1-f@lex.la>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <44f163ed-8362-4aad-99c9-f8709dfbed76@lunn.ch>
References: <20260908155707.4164559-1-f@lex.la> <44f163ed-8362-4aad-99c9-f8709dfbed76@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Wed, Sep 09, 2026 at 09:01:14PM +0200, Andrew Lunn wrote:
> I think because you are sending this as RFC, the AI bots are ignoring
> it. I also think it is not getting build testing etc.

Next round goes without the tag. One bot did answer 7/7, but by private
mail only, so that side is not consistent either. The build testing is
what I want back.

> One way to argue it is that the MDIO bus it connected to the MCU. The
> MCU, once booted, forwards the MDIO bus through to the PHY part of the
> package.

That is the argument the binding was missing. It will say that, instead
of describing a driver model choice.

> Consider a normal setup, what happens when you remove the MDIO
> controller when the PHY is directly connected?  And look at what MDIO
> mux drivers do, which is not so different a use case.

It faults. On this board a bus going away under an attached PHY ends in
a NULL phydev->drv out of phy_stop(), directly connected or not.
mdio_mux_uninit_children() unregisters each child bus and frees it,
which is what this driver does. So nothing new to invent here; the hole
is in phylib.

> It is fine. I would also add a select or depends on the PHY driver
> Kconfig stanza to link it to the MDIO_AIROHA_EN8811H driver.

Will do.

> Prose is enough. And C code to catch DT authors who get it wrong. But
> you also need to be careful to not break backwards compatibility when
> the PHY driver is used alone.

The child bus will refuse an address that is not the parent's and name
the node that got it wrong. Boards that describe the chip as a plain PHY
keep working through the PHY driver as before.

> The location is fine. MAINTAINERS need to list it. What you might want
> to do is list it twice, once in the PHY driver MAINTAINERS record, and
> again in the MDIO driver section.

Both records then.
