Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C79C332EBB
	for <netdev@vger.kernel.org>; Fri,  4 Sep 2026 23:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788564303; cv=none; b=nVKBmPA7NnKrvWa/TmwnKyDQb/R3toJ/iuNvSEPPEaEHRt4pqis9y8k6auqrogLhSDW1V4VYKK47W25A8qhrFwUG9eB7PuJnh/1TR7mQu05zhUocYug5AIMM/r9wVYlZfoWpKKN9E95NZwqLYdix//4Er5dmuwUuCaNGXgcfGl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788564303; c=relaxed/simple;
	bh=K1s3LaP7Jy4m4cGgbuRjp7GOXlBBFK1CH2OoNIQ1nqo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HxEiYNRTkDKniyvlI2+6bczzeAta3Cq6grc0dyb2DCqgBHReVJ5Tyl8lhPWtX0/gfs29wucqEZm/SGHUTEJdsiQHVIsqqFQOAUnpfpeMXAunws7GNkdFoMqNeFbQtOJnkmCD40w1aeXyzN6X7zCiJcON6nT38kop8STCDKuzBHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la; spf=pass smtp.mailfrom=lex.la; dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b=N3zRa16v; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lex.la
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b="N3zRa16v"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-47de0093c42so1335326f8f.3
        for <netdev@vger.kernel.org>; Fri, 04 Sep 2026 16:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lex.la; s=google; t=1788564300; x=1789169100; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=K1s3LaP7Jy4m4cGgbuRjp7GOXlBBFK1CH2OoNIQ1nqo=;
        b=N3zRa16v+cz43pk6LTT/24nkrJRqiMgJf7RCCzI6PVa08F9SXLe+Ob5E/XCQq5FlT4
         iDf6+Ho7SC/QcxGAhSyPnuLHM5qu9yBRNloHTlYpjpdk/4pWwEj2URKMWghwV9aOAcHw
         PnDBhxys2tLUovBqn0OjbUDXXANcPRHmr0bOa761CzNBW/WIjNC0qh7zmbMVXBaATLYI
         m6OPzMN8ft/kR/nEYz9x1f6aflYc2iM3RPyTz6wFXesanNukdGJXSPqPl9vvIgT3e46d
         WEBh2xi2AT9D1jjoQI+GT0hV3TLD+NQm7SvDthJr/mLHf0P+KVl+tU2t+0bUO7kdaozv
         ZaIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788564300; x=1789169100;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=K1s3LaP7Jy4m4cGgbuRjp7GOXlBBFK1CH2OoNIQ1nqo=;
        b=RIblzvlbSDDhemknvqxb5K8+c3NC4Gt0MHQSAn6j+EgNFEhEASzXWOqsyS+fJ1gfCM
         YalF9VtqWP7FTqlZiIoPcvmcNHSjmaknLbf8SsS0MRixtggckQ/0HIUpc69k+GuWQFyw
         Hi6jv/62Akwl6Y3XQV092RRSNm7NUuAkB4Kr8BWhFlPNgM33vPNARMEiHeN4BEevEQ6r
         YZs97TWEyZBPHKovdI7vxRb347B5F20KXjBGFG+elXYsfz4Lm8DHlFqcJkuG0r8YNVnT
         kNF+guuFKLaedz/XUMAh/C9pT6TtQs0kNquDdOVJ4UIIWUbgYcwP11stY6JxapACZGUy
         AJrw==
X-Forwarded-Encrypted: i=1; AKwUvBwifwAXkV5A6eoeAOhz6ofXqVc7g54AnQn/S3f3XF7+91m54O8TEL2VT0sMEe28iSh54hPBgkM=@vger.kernel.org
X-Gm-Message-State: AFuF++lBPBqxpK80N7eJKj/jrRsjr8szfRc4MoxKdNIlB4Sz8cG3XW4w
	HTzvjjZlZKZ1mSKNky2/A3BHKYVHy10zGAsxAYGODZsDzVGeeqa9uc/Z1JC8nS6ahKY=
X-Gm-Gg: AYBFou20cjTHvyWb2jQFfhBsBqyn69oDrEVdJDpbzVs2Wxb+qnE/AKPW4hllnTvnT93
	WECloWN5+cSj4YmXoJSblT9cQREjF/CMVFK4C5jU3xR1yJhZhJlKbmG7v1oMhhdGR/Y44ftWL4g
	cz6VpMjeGoEuVuaDI6STf73qC05N3xczs6LpSOc9QCoXC7LYTQfmMOAGJ1gMLdOHNulj6wJn6tP
	uQ11mKidYr6igo42E7jWa8mG0fHoZ7kmQ+79ZbxkNzqUC+4AUwpqJsm1PJqy2bTzxGEHHFvzonq
	rFrUgQ6aBxBrGKjGBNGO14IAgHe/sx2/04AsDoPR+Ck9FnMAMP6XPhYHQ4lhn9d8vtnLDN8NbKj
	mzDx6sjUed70Mje0J6x5ulTIAjTA3yIKKJj7SYsI5gkLDpeI/z7eQ6xOBG3mo6zovKhjYkCqEra
	9kAuKIFwDQVdA6xmXZjdUAK6Lax0eFg+u/WEb/6+8=
X-Received: by 2002:a05:6000:2508:b0:485:8c16:5ee5 with SMTP id ffacd0b85a97d-4858e8bd21dmr3475598f8f.31.1788564300124;
        Fri, 04 Sep 2026 16:25:00 -0700 (PDT)
Received: from remote-01 ([84.17.55.227])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4859207c28fsm461764f8f.5.2026.09.04.16.24.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 16:24:59 -0700 (PDT)
From: Aleksei Sviridkin <f@lex.la>
To: Aleksander Jan Bajkowski <olek2@wp.pl>
Cc: Vladislav Karmanov <vladislav.karmanov.dev@gmail.com>,
	chester.a.unal@arinc9.com,
	daniel@makrotopia.org,
	andrew@lunn.ch,
	olteanv@gmail.com,
	nbd@nbd.name,
	lorenzo@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux@armlinux.org.uk,
	dqfext@gmail.com,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net v5 1/2] net: dsa: mt7530: populate lpi_interfaces to fix EEE support
Date: Fri,  4 Sep 2026 23:24:54 +0000
Message-ID: <20260904232454.391138-1-f@lex.la>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <780c9e93-ca6d-4481-8709-c8e5058f0073@wp.pl>
References: <20260903123644.23800-1-f@lex.la> <20260903123644.23800-2-f@lex.la> <780c9e93-ca6d-4481-8709-c8e5058f0073@wp.pl>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, 5 Sep 2026 01:10:33 +0200, Aleksander Jan Bajkowski wrote:
> I'm a little confused by this patch. At the same time, there are patches
> floating around mailing list to disable EEE on the MT7530 PHY[1]. Does
> the EEE work, or is it broken?

Both, at different layers, and the two patches don't collide.

The MT7530 internal GE PHY really does have broken EEE, and Vladislav's
patch fixes that in the PHY driver where it belongs. Mine is on the MAC
side: since the phylink managed EEE conversion, lpi_interfaces was left
empty for every mt753x port, so phylink never saw the MAC as EEE capable
and ethtool answered "Not supported" everywhere, including on boards
whose PHY is fine.

They compose, and the PHY wins. phy_disable_eee() clears
eee_cfg.tx_lpi_enabled and fills eee_disabled_modes, phy.c:1027 builds
phydev->enable_tx_lpi from that flag, phylink copies it into
pl->phy_enable_tx_lpi at phylink.c:1997, and phylink_activate_lpi() is
gated on (pl->mac_supports_eee && pl->phy_enable_tx_lpi) at
phylink.c:1583. A PHY that disabled EEE keeps LPI off no matter what the
MAC declares.

So with both applied, boards with the broken MT7530 PHY stay EEE off
through the PHY driver, and boards with a working PHY get back the
ability to turn it on. Mine doesn't enable anything by itself, LPI stays
off until userspace asks.
