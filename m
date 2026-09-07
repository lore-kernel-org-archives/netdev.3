Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F63F4503EA
	for <netdev@vger.kernel.org>; Mon,  7 Sep 2026 09:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788774709; cv=none; b=gOGx/Lf503uRQxwqZYepL8Wje5pjKKNNIKier8b7qmyr9xhxypQf+5tPm0iM51C7BTisz1MPssW+xN0FU3pE6tvMrLD6FvYG4BNTaspifY9mnYfJf0b7pSdCoMdR+y9e8rZA+LAqCgsOd6lK1AYFdf0uLGOKLtSywA9Rsl1xHXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788774709; c=relaxed/simple;
	bh=sjxhVCH/bhx/nKVoP1DpZX/8EknekeeK+5x7U2iDC3M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WiBzK4qwDAAFc8RqRRSIw40JYFS4XQZkEFGW0iCiIdBdtMRrMU5OBWzEEIMODTf9mlhZgYH30sUVudJKo6gBHioAIoUPgW/xVVtSCeBInJHfauDDy0Mg2H1U0ZBAaOrXxByRnCGjedQanXynga0WfvtfMTSZ/Mfn+Lvm7i2/kz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U7Er3Pi8; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U7Er3Pi8"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-8525efa7274so2136483b3a.2
        for <netdev@vger.kernel.org>; Mon, 07 Sep 2026 02:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788774699; x=1789379499; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Ozc5aGre8dkihgDZN0g60I/nIm2ja/LB6Gh/3swjSPo=;
        b=U7Er3Pi8zvnzDom6yqTrzUtWmIv/3wHaumifRG4ZU5vUsgavYrnB++F1VuGbld94LR
         W+QxBSIZ76Xvd7tkHiTH951As/27mF9vtg+uc6Zfxok5u9sERVvPjLGPLeb09qU5huzN
         dH1MOMpkHEhqa2LV4p49upUuCWdx5D2IrBY6r0h57Owf6C5nHp985mdkWymtHpouBNa1
         i3gOcYHAmCmjVqR/HzQGcg3wo4vUJm22UFeLphOAr6eZxpbqimI3uRUwBM/XE1Y7qu1D
         tCUhzq20T9tNA9lSsJcQ7297Iqro9HRd/9hxyH59rfILT2+Pj0Iq5rTH6lNIaKEJxHBp
         cj5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788774699; x=1789379499;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ozc5aGre8dkihgDZN0g60I/nIm2ja/LB6Gh/3swjSPo=;
        b=BXNh78ZBdG/PHVAgGxl3qnGaJuf/p9XNHCRlYikMFoKzWgpjZsY5mv9y/N33Kg+t0c
         1TshVJDQMu84dqJJ1h9POMTU8uyRSY1ntoorYoA3IjKy3cLoHYADt18no7ttPVw3K7qI
         Vom/Dd5Okd+pgYNO6bGkzpDgKsdGfOjnkb8YckwQtYuRam3mfY9FZ2qlTyqTFX5VxlBq
         ie09yo3hnE4Bwd8jyBCtMi9h/GVj32qI8ElFWLA0rbmX23jc1kTb8f0IITzhB/y83mrA
         VpPtj+EH7V7W8cHglUPaoyBWNDrAwWzaF4Eq5TQORVCb0gXaRm9QgXkHuz3ZoilbqkD7
         I4Aw==
X-Forwarded-Encrypted: i=1; AKwUvBx8DlG8TXPnqjZ1JSiiqj7B56rfHNOsOcQ5RHyy2uB2irVSYha65SpL7cTFi01JSSeVG87rScc=@vger.kernel.org
X-Gm-Message-State: AFuF++mJbyhd9zk1D2y/Jpd+KMuCy8AjSRQ8XKI5tn0LPYMNqF5apxZK
	m7cT7WA3QgsmeGIUtlL/zV0Qt+WS/8UBlw/5fouxGD65gEBD1yUoFEKR
X-Gm-Gg: AYBFou0jhZzUJ8ASv7HysnbWzPoGS1Cr6NizLs+oULNjmrVDuDRYVHxJhyMOQJ7pKqw
	STsO+rAvPbqbWBMxXZtc0tKloF7TFDNVlFijzke3gwlpk3KBjP+UqS2p6c31Db3ZqtK8jaOwxQ+
	JubGQOMSo4tvK5TwgfIhqGBiRRCvJl54c+GhMh6ugI0azQd3SEPGH2QASFTjMGXPUHBVNPYqjin
	s5Mw7BOZe8nH24mqQQmqHBsFVJFdPp1HU0PPC/Y/jOmXoPV38xE72pjh2bMC7mJ/3jWQEqj5PN/
	S6Z0CeJBdXruUaUVcQ9s5nIp3Id2KLJ67QbVmESIy10xaXmSU6H1ULCOQlDAbTugFVak0qTzY4g
	3Sv8tG4K5Nu2XuvUSowyHXRX1AQjnHqilIPtOfOfU8GaiJHEZ6LIA3nukpcsmALQvfYuGWFNTce
	0iqEZvCDiMlKI5sC4qcjgPbFLDcwDMyBj21archsNICiRQRRE4IZyMzrr/OyCALinwvnVGDGXSt
	oZaks+8ylwDdFAxHfZFe/vF
X-Received: by 2002:a05:6a21:6487:b0:3d4:52bd:b89d with SMTP id adf61e73a8af0-3da3a0b2671mr30540627637.23.1788774699211;
        Mon, 07 Sep 2026 02:51:39 -0700 (PDT)
Received: from volcano9f6e-hostos.amd.com ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339885ca07sm30049167eec.1.2026.09.07.02.51.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 02:51:38 -0700 (PDT)
From: Hemanth Selam <hemanth.selam@gmail.com>
To: Alexander Aring <alex.aring@gmail.com>,
	Stefan Schmidt <stefan@datenfreihafen.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: linux-wpan@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH wpan-next v2 0/2] ieee802154: fix typos in comments
Date: Mon,  7 Sep 2026 15:21:30 +0530
Message-ID: <20260907095132.21244-1-hemanth.selam@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Two comment typos under 802.15.4, split per component.  Found with scripts/checkpatch.pl using the
misspelling list in scripts/spelling.txt.  Comments only, no code
changes.

v1 went out with a bare [PATCH] and a "net:" subject prefix.  As
maintainer-netdev.rst asks, v2 designates the patches to a tree, and
each subject now names the component it touches instead of "net:".  The
series is rebased onto that tree; the diff is unchanged.

v1: https://lore.kernel.org/all/20260907064346.3288-1-hemanth.selam@gmail.com/


Hemanth Selam (2):
  ieee802154: at86rf230: fix typo "upto" in comment
  mac802154: fix typo "substract" in comment

 drivers/net/ieee802154/at86rf230.c | 2 +-
 net/mac802154/iface.c              | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

