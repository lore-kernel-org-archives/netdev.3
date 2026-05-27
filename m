Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DCF1282F15
	for <netdev@vger.kernel.org>; Wed, 27 May 2026 00:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779840612; cv=none; b=LHnSzSKRPT9+0wMT9+Ephf/DO9lCh6+BKUbt6Xw6ySeS+mkfwlqqmbCBsrnw6d+60vDc+sEBY+RMdzaty1WizLaxkti28mHlIzRQjT+txnUtP21JZjIafcb6PRPY/+FaRvXW3IEX+5U2D1xvOR4+xAVkjdbe21/o+9FHWULJy/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779840612; c=relaxed/simple;
	bh=+D03VDpfvWODRYGI0m+Hm1VI0GkpXTy4UoJ16Gjb3/4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LH4GHDZhPBQ1gGWrThDS7THTwCs9PasDczkNWAHlW9O1GVyYmeD2k0uAei7wUSe/Rqilkxq26/6I3Svc7szSGwBa5SC7+fHCdwxv7EsrxGgWIs62K+4Ii3HESpd4MDYlIJUzF561XU/7x8Vw5s7dmFHbrLF+ZwaPP11qhYF9A2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UB2VQyEe; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UB2VQyEe"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-914bfa75911so500007985a.1
        for <netdev@vger.kernel.org>; Tue, 26 May 2026 17:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779840601; x=1780445401; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=M5E4s8sQakLl7SX5ylw/D0nAlq/cQUgG+ZoYhA/jCFQ=;
        b=UB2VQyEeqQ7Z+i46ned1ZBTyExkfX0Z6OYE7WftAPklHOOjYJIAkIRg9U2QjBLDIw9
         5M4lsoOx8SHBxnuFofJEKn0o2HhvvreMeBHLxxXmHE3YQ7N6j1TPmcZfIzJuXf6Gpgwk
         ASvTTkB+RSxMpJ9bT+x5lt5NYGIYpiLc/QNTFjLEAXUjmplTHiC3z8ltz/3DLlvNJ+Lq
         WV5Z2UfiuRsor6peMYFMmTyBnVCoXGg7p81aXYZ38I6ONb2AU47yTT2ID1yqSd/Gf5cW
         cm9dNEfdXvY62mwNcImWGFlbMiFDcf+PFRZLnZpo79/PJLLax1YP/9UyotHYAYbeLwoP
         yAEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779840601; x=1780445401;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M5E4s8sQakLl7SX5ylw/D0nAlq/cQUgG+ZoYhA/jCFQ=;
        b=ZbYzuV6mVbpeNb4pXAMAuN4CBlxivqZViwOPneWwyan4PoNRm42OaJRvrHzzkPIVw3
         oG026k2OEpgh+1ii+1qHFiP88b4D0WkQIVChGoQtaB4GgCm4YpGBR70hDpfnjD6KiMZO
         MGSz6s8oj/ujHe1L1j+e4wGX0yK96oVrrIBbuesrA/8G51Md/KWPfE0pIjfMqUCLT5Qz
         pe6zpvVKMO3fPx4BGIlCSlrjwd/Gq0GEjKlCHuGaGSSpmLm+xzlwapX2RAk+IvKuYciM
         6QIJkaOooDPoYcSQ9DmTmf7yDvTuwc+QSE4SF1Reafi076dqcur/hZ594poTW9dv2zsd
         IDRA==
X-Forwarded-Encrypted: i=1; AFNElJ8/Ybn/Hg3SbvuTZ5qmYuYD52Q+H8XB/U+VOmbyfmniQ2MIFQJ5IQbUMJBQiQ+u3lSUvoi6c9A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5i134vrIbO2Qy65Mu5tUxufJJITTMHa2kmkHgQLmCFnukJqe6
	O2k4LpV697if7h8pRc89fTVD4EAH+t1Qbv/E+vOP8njA6SnP++OW5oFv
X-Gm-Gg: Acq92OHumrjeECjcPkphC6xrYeooVld0L6+UdLFzIITyfL8myGP//ule0SKC+HMRxT2
	S5wMxsHvJa1z1jblWSSMxK9QuFuW9tS6sRckJKYpSwzjoaasnqY92SP1ex3ArGronMxm8BLwAHb
	PqYjxqPJVHURC3FiSwRWpaIJK5syAj+yyPW2nusrb5I5sazXWc1fWFm/CSrt1jsL39hDc17+9Fe
	mYwi1ljROSbEoxpFeM9IcxW5kzOVEar6Lgt6g4rjbIl50Gm5rtZOYZ4PfLB+dRHKRNT1pKru7YA
	EypVNWd8USkZkbCVZt2yKXYBd+1yyLhuhmtozcKDZxu4O7Wd+554nmYwfx/vjbXrfCT2KfZZ8Ri
	mK/MhvYAYI4FP3N9XJfTfaeoG2OJ10lkPDkmW2uLUvtH2aXSh8nS00pXHtYldPegjeyBghpNvNU
	Xbv2dtTcm6KrYY58Pz5jx9jYe9aXhPTQfaMvTiXmvSirU/xq/X+ikcJm7CE0p0jBxDon4=
X-Received: by 2002:a05:620a:45a5:b0:913:dcd2:f117 with SMTP id af79cd13be357-914b5121dadmr2454205485a.24.1779840600490;
        Tue, 26 May 2026 17:10:00 -0700 (PDT)
Received: from PF5YBGDS.localdomain ([163.114.130.4])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-914f87fc449sm363803585a.35.2026.05.26.17.09.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 17:09:59 -0700 (PDT)
From: mike.marciniszyn@gmail.com
To: Alexander Duyck <alexanderduyck@fb.com>,
	Jakub Kicinski <kuba@kernel.org>,
	kernel-team@meta.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Jiawen Wu <jiawenwu@trustnetic.com>,
	Mengyuan Lou <mengyuanlou@net-swift.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Mohsin Bashir <mohsin.bashr@gmail.com>,
	Kees Cook <kees@kernel.org>,
	Andrew Lunn <andrew@lunn.ch>
Cc: mike.marciniszyn@gmail.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v3 0/4] second series for xpcs based rsfec configuratio
Date: Tue, 26 May 2026 20:09:54 -0400
Message-ID: <20260527000958.81108-1-mike.marciniszyn@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Mike Marciniszyn (Meta)" <mike.marciniszyn@gmail.com>

This series adds to xpcs to add the necessary configuration steps
for the DW PCS/rsfec for high speed interfaces.

v3 - adds an alternate xpcs creation that allows for specifying multiple addr
     values for creating xpcs
   - remove probing in favor of new xpcs create call
v2 - probe mdio bus and use phy_find* to isolate mdio address
v1 - initial version

Mike Marciniszyn (Meta) (4):
  net: pcs: xpcs: Expand mdiodev member as an array
  net: pcs: xpcs: Allow for multiple addr in creation
  net: pcs: xpcs: Add hooks for xpcs configuration of rsfec
  net: pcs: xpcs: Add handling for 4 channel rsfec device

 .../net/ethernet/meta/fbnic/fbnic_phylink.c   |   4 +-
 drivers/net/pcs/pcs-xpcs-wx.c                 |   4 +-
 drivers/net/pcs/pcs-xpcs.c                    | 320 ++++++++++++++++--
 drivers/net/pcs/pcs-xpcs.h                    |  37 +-
 include/linux/pcs/pcs-xpcs.h                  |   5 +-
 include/uapi/linux/mdio.h                     |   3 +
 6 files changed, 332 insertions(+), 41 deletions(-)

-- 
2.43.0

