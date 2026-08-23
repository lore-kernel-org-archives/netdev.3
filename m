Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 858561DFF0
	for <netdev@vger.kernel.org>; Sun, 23 Aug 2026 00:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787443554; cv=none; b=j+rZsRZfOIvP2DAnemxckC5DCX2WyElTeSkCXbFPuN74FVK6/U+TCVuM+jlk5P1viQgKzUZrUPKmbfVHwNp/HnhstfNpF8a7/H8PpMukNev/hbUsUYAoeXoobKg0uJHxTiVTVwvbfBkU5a4aeGGsSeQrDDJX9SvsYApSk+V/GUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787443554; c=relaxed/simple;
	bh=aZhme+fPtNRc4Hp5eZBvER/rDdLrQ2TdabO+HmWc3ho=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cqJfCvTcMROKNfdozpfGwdERh6JPEL2euf0NSK/UXKoLIA7k+r8j+ZhZNQQPC7voB98YqIQUu7YUuwwPJiu5Aq6yAyRvQ97GiC5bxMsXYoBlC4T0uilNITBq1Smqptfv+ZWjL20gn2kLW8lZ+ZaRBvl15L7RA60HvDV9Y5Tg1Sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la; spf=pass smtp.mailfrom=lex.la; dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b=OF9i+Gwa; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lex.la
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b="OF9i+Gwa"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-c214321dc32so440415766b.0
        for <netdev@vger.kernel.org>; Sat, 22 Aug 2026 17:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lex.la; s=google; t=1787443552; x=1788048352; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aZhme+fPtNRc4Hp5eZBvER/rDdLrQ2TdabO+HmWc3ho=;
        b=OF9i+Gwa6gIwvVESgm6EA0ZAECIUCylJzd25w56Ghw6eVXcG1lbO18VAgbHIGDzMKY
         fkHwioOuFguTOheG5TZ3qJeCc1PAyDnyglrN3+Kg18LYzhQqsVQaeuaEFTBEP/jr+Vx+
         dKO/C4gDqeZ+bStM3GHDIu65klkO97jqnX8AN2Sgnay0T3yqx7C8a7c0T0dVWLXCXjIi
         /kfG/WMAyFkKgZu7wuaS35ft3Ca7bwVnk3AD1FMDzfCgmHKIrWqYwavRIfezHXExLayd
         H3YVHqbG5UzFVygulHAMfDERlajlbwuiVVT7DTOCQeznnC1nodjfs/ZI6JyIVTJEKogJ
         m1xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787443552; x=1788048352;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=aZhme+fPtNRc4Hp5eZBvER/rDdLrQ2TdabO+HmWc3ho=;
        b=IOtF7gxB2qTV3dnr/RdbIvjIe3ROcYreypNwQc5lY10vz3VM3GXCpxqHAaqYGzgJWo
         U5T9i1fp/0e5Jp2mM3qK32uKRgEc6gI76TLV9aK7XitwtYuXrFC/ysBru8O/+kCB8uWa
         kYDu8+dxl7VRzq+qIaleCWzesTLXG0iU4WCBl3tvCUwjHJvL/ST0s11rspvlgy2vkjge
         CZgQF10uI46Gea4bdEgBpyyciyJpW8vdbUNmLsKfmRVSuHLkDZ+eAQOWgU5puIR/IcK9
         RJkaP1kNXZEQPJV20/gAVMbR+pJ7MW3om9PEBix4Do73HHdg+2+WsE3YtSVO329LiGat
         BeXg==
X-Forwarded-Encrypted: i=1; AHgh+RoZnPK0UiTAbpzImgxQn9KbptUtyLFsfG8CeeqkajY5SWrBx7nEibDsAGUC04babLj+wmab3PE=@vger.kernel.org
X-Gm-Message-State: AFuF++lMjVVOy+fQ38izIXU3V5ONQomYtWNURAdUs8VT5QfL64OrMlrH
	IfTsCvfszcApz+qfFxJVOPFEx1MYjA9tstbGjHfbFkc4Wg5OrNQrYS8S9nEtLqah3T0=
X-Gm-Gg: AR+sD12vBflEy5nClaG2zkNYsxRss+AdqxJT49wQdY6Ff016sq/a0xUck/4t4p/oUpw
	KcDB0X4QQ+uUntOPWObuKpBV2fZ2rnkg27PJZJWH06KyH2r4Yf5YL9x+9/7Ew08jfb0qoFQ78ux
	6Hhk/hYRPNLpF3jV6rj19/G/0XtAOe4y1qn8b6s52GUCQ43xmiPVLiRdeRqddCPeasky87RgmjD
	0+grYYJxtALfScFuILhpkghQNhTRlFcZmRvavI7PigeAuW14+IGbVxMDT/DhpNAgHFUlW92ZYaH
	Q4gtoPh3PtmAdeYY4X8+afRSe/KpOEGHCyADZEIiZ6szUZwWHSeN/+xaCIeahxkNW9Yx3hAnCUG
	mJij2XJRtXpZWxAO5HN0ILWYm0i273DBblWVu0juWYoqOdvRFdi2zVwJMnhJbOJlk2fP16voqnL
	QeD5gUIffqJEJ7qLl3oJkMkk5nQaqlwnV8y7YOd/e72z/rLedTQ3gkqRKrVAjP3E5SO5yZE7UXd
	q6pMbEO
X-Received: by 2002:a17:907:930a:b0:c1c:6f0d:5b22 with SMTP id a640c23a62f3a-c246a654342mr1941819866b.11.1787443551459;
        Sat, 22 Aug 2026 17:05:51 -0700 (PDT)
Received: from ownbook.home.lex.la ([84.17.55.225])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c24966f6adfsm504267866b.31.2026.08.22.17.05.50
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 22 Aug 2026 17:05:51 -0700 (PDT)
From: Aleksei Sviridkin <f@lex.la>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Vladimir Oltean <olteanv@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Aleksei Sviridkin <f@lex.la>
Subject: Re: [PATCH net-next 3/3] net: dsa: connect a late-arriving PHY at ifup
Date: Sun, 23 Aug 2026 03:05:49 +0300
Message-ID: <20260823000549.6095-1-f@lex.la>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <9557daed-f039-434a-ae64-ac849b9860be@lunn.ch>
References: <20260822155259.87146-1-f@lex.la> <20260822155259.87146-4-f@lex.la> <9557daed-f039-434a-ae64-ac849b9860be@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> The problem is, this is not guaranteed to work. The driver might still
> not be loaded, or it is still downloading firmware to the PHY.

These are two separate halves, and the driver can only reach one of
them. When the firmware is late, your scheme works, and I want to do it
as a follow-up. When the module itself is still on an unmounted rootfs,
there is no probe to return success from, so the connect at switch
setup still gets the genphy fallback and the port is gone for good.
This patch is for that half, and it is the half the board in the
commit message hits: the driver is a module on the rootfs.

> Think about the case of NFS root. The kernel will open() the interface
> as soon as netdev_register() is called.

With NFS root the module and the firmware sit behind the network they
are supposed to bring up, so that setup already requires building them
in or an initramfs. With those in place the connect at setup succeeds
and this patch stays out of the way. Without them, today's kernel drops
the port at setup and NFS root is just as dead, so this does not
regress it.

> I think you need to look at the PHY driver. Make its probe function
> return success, but start a thread downloading the firmware. While
> firmware is downloading, either soft_reset() or config_init() needs to
> block.

I would rather not block: config_init runs inside phy_attach_direct, so
on a DSA switch the blocked port holds up the whole switch probe and
every other port with it. For the follow-up I want to attach with the
real driver's features immediately and keep the link down until the
firmware lands, then trigger aneg, the way an SFP port sits linkless
without a module. aquantia and mscc load firmware from probe too, so a
phylib helper for this would have three users.

If the async firmware part should come first and this patch second, I
can reorder.
