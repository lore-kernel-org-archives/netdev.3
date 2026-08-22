Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E31143C454E
	for <netdev@vger.kernel.org>; Sat, 22 Aug 2026 15:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787413991; cv=none; b=HNk0vlqi6SNA2mx0ZqnzFq/o/fX3PZTlOkxYLcNNPuJkTytLdYfOU0n6cu0pDf/uRmWJZZeoIgEUG+KcVGGbKxwCvz4EsFvdTjeE+DfzAQu9fxQUjp0S7+BOQdgIJ22Hd2mEOAxwoS3L1n0DoObBIa4LLZNJILBFicZi7N93mk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787413991; c=relaxed/simple;
	bh=T29vQSW/QHENQ809Ln3UnsVeNkX6mY9PFld3z99VIoA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BCthaHQjfpaMwYTg1s2zrVFQVPFjvQE9hitUVFLjUSReC6x+3RL07fdWsTyS52GQL42CJski7TCPHdaAu/EyEzl9thmVP3L4GAmv7Dt5DKdFDImyj+xhKaXs8awqSNGyt2p2JGYk9PcDsQs9QWW8yczvsR+42wyDdY/hvp3DFSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la; spf=pass smtp.mailfrom=lex.la; dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b=FP0XPmSZ; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lex.la
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b="FP0XPmSZ"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6a374bea882so4071219a12.1
        for <netdev@vger.kernel.org>; Sat, 22 Aug 2026 08:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lex.la; s=google; t=1787413988; x=1788018788; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=SsY4kNeedScXtOEr+uFYJGSPWyovaLUZEQHHFrnCwNU=;
        b=FP0XPmSZZ2GJFF/6zP+oXjquHBHeQgeURjHHKE2709SfOyqj8kJojNYe++iYWHsWLp
         1oW+AT7zJOXqabNyppMUdP0mLloKQx29zRm9fzyMI09ukPu1GvW2Aw3MYpCPztuFl9Hi
         mhXD4NEBj9yuNRlkTShMzADPPXASJEUdveAVe8yiKYw+dzN/77seIvbvCr9Pl7nR+wzR
         DLg60GKSz+wtmwFP98QvL2lmwagYj693JAyrse3gm8yGgH15uSQUfEfojaE0puP8Qfqa
         qt8MNF1xRA/sqt4rEI8t8lehRYBAj5DduTK0y/ODoTlPHGzRfrX9XgVveXI5xNKd3iVu
         B5ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787413988; x=1788018788;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SsY4kNeedScXtOEr+uFYJGSPWyovaLUZEQHHFrnCwNU=;
        b=EljXKbI8NJd2SDXFqePpruQUZ/087GIi7VDz+3q6hE7Se82lMV7kzKZOz8EFxCEHsE
         jzIbcdkn7VJN9JHQ1/qlrKR5/Du0AgHIVTdmOhYcWiDNZDVGFHfVLxK1b059aAjxnNhC
         20xSrrRokx/fwaHz70n/U0/sTB1pfjqN94JZPX7zpsM9RykkXxPVZtysnvDxCjWXEr4V
         24hWRS1H2unBtwnq4SCu5A6S8+irfj3jkXDILDb+dF9gCVpzA1+synUUBDZ5/0dXOYfz
         GmixrPO3cQ25BetQ2v3mLF6+u/ksq5vdg6cADqc6eaLyqgxWddZqzkCshfQP3hi4vr+D
         drwQ==
X-Forwarded-Encrypted: i=1; AHgh+RoLHeKvIBdzrd2Y2WUwE98vU0OXsv1Ke03RmlLMmiH9UvF1vB0ZdiR1ZCP1TRklw3+Nctwt1cI=@vger.kernel.org
X-Gm-Message-State: AFuF++lNOj/aN8yffi44MK9hR8WQ4gca+efd1tdXrnHdJXdq1E9MqeZp
	x7d3n5CSvwQ+beH9WF2pmyvLirpD2aPus2WekaTd+xVVJT83qIY5kL0rtji0DezeEQQ=
X-Gm-Gg: AR+sD10SDY2IF4+/jUZj7G4oyGOuX4/FxQyoB024G3sJ0V9GlS7AgOZ4rWosLqH//9k
	21W/Ak9Eky6kLBEf+lFmPzLjuJUSmGv4ZUAd8jZHCbE4XSj4LXzgeM5LEFYlk8i8ETBrZ4d9Lbe
	c9+IsQpLUGQrJ+f5dwDhrgzjZEYY9XaxydXO56YFN3xwWq5zkLa4LCeN1t6vRbtLbJhRgYxpxPm
	DZ0b2JZFG3PWdUm+DwU0Cjp1/cc78rA0C7y/AVfQ8DCiYN2gRWYZ6yoKs+0gy/4S0QMY3CMw9+5
	ES5bASlymuDo6PIuxK3mCPpH+V6EHcJbXb7dTkp0W87vhKIwlWBMple4/2eXP6OziEpffBEgLX6
	BEwn6p9b9ohpPguCVpiBOIifkt5C++5BDdzt3THwxjpiuht6zQJepMShnPN3963xDskfskSPE7A
	Dx7HxiD9mFxxdLFFL9f9XlecrDaZedYjIYVO2KqFgrfLf51TJ645y4KfsgNlvbU/xnTax9vQ==
X-Received: by 2002:a05:6402:4588:b0:699:fbe4:16d5 with SMTP id 4fb4d7f45d1cf-6a42f13c47dmr17517952a12.1.1787413987598;
        Sat, 22 Aug 2026 08:53:07 -0700 (PDT)
Received: from ownbook.home.lex.la ([84.17.55.225])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a3ff16c546sm12396250a12.21.2026.08.22.08.53.05
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 22 Aug 2026 08:53:07 -0700 (PDT)
From: Aleksei Sviridkin <f@lex.la>
To: Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Aleksei Sviridkin <f@lex.la>
Subject: [PATCH net-next 0/3] net: survive a PHY whose driver arrives after the switch probes
Date: Sat, 22 Aug 2026 18:52:56 +0300
Message-ID: <20260822155259.87146-1-f@lex.la>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A PHY that loads firmware at probe keeps its driver in a module on the
rootfs: built in, request_firmware_direct() fails against a rootfs that
is not mounted yet and the error comes straight out of probe. A DSA
switch probes long before that module can load, and three things go
wrong, one per layer.

phylink can fail its PHY bringup after it has already recorded the PHY
in pl->phydev, leaving a pointer to a PHY that phy_detach() has since
released. Depending on the caller that is either a permanent -EBUSY or
a stale pointer handed to phy_disconnect() later, which detaches the
same PHY twice (patch 1). Keeping a port across a failed connect makes
that window reachable, so it comes first.

phylib binds the generic driver during the attach, and once the failed
connect unwinds, the interrupt the firmware node declared is gone:
phy_probe() parked the PHY in polling mode and nothing after MDIO bus
registration ever brings the irq back (patch 2).

DSA drops the user port when the connect at setup fails, so the port
never exists, no matter that the driver shows up seconds later
(patch 3).

With the series applied the port survives setup and connects its PHY on
the first ifup after the module loads, with the interrupt the device
tree declares.

Tested on an MT7981B board (mt7530 switch, Airoha EN8811H with its
INT_B line in the device tree) running a 6.18 backport of everything
here except the retry in patch 3: the attach line reports a real
interrupt instead of irq=POLL, the EINT is claimed and its counter
advances on link changes forced from the link partner, and the port
passes traffic. On net-next all three files are compile-tested; the
board runs an OpenWrt 6.18 kernel.

Aleksei Sviridkin (3):
  net: phylink: unwind the PHY binding when bringup fails late
  net: phy: restore the interrupt after a generic-driver bind cycle
  net: dsa: connect a late-arriving PHY at ifup

 drivers/net/phy/phy_device.c | 13 +++++
 drivers/net/phy/phylink.c    | 12 +++++
 include/linux/phy.h          |  6 +++
 net/dsa/user.c               | 98 ++++++++++++++++++++++++++++++++++++
 4 files changed, 129 insertions(+)

-- 
2.43.0

