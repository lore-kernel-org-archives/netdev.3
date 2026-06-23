Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 231DC23EA84
	for <netdev@vger.kernel.org>; Tue, 23 Jun 2026 06:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782196935; cv=none; b=HG5wUSMl9EWJbsWFdqhO94psUlx7t34/GqRtk4QI6aGU7v3HL0MEj2tXr8G0GDdlxhzC4FduVKibKshvcALK99Xko8BX1xOTlBGaHh7txfdtqurFKOmbjWIPYc0OSnPdk+YxI83Nb+2VvvsCUFR+5Cr5fGn2oc79+B2aN3bdILQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782196935; c=relaxed/simple;
	bh=vcz1qNnnGqmF7wP8cgvAUAQIctb1YOSTQsyCD3dfS40=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=i2bxaoMXhsH1UuHXK6cVIkyYPKsMUd2BYcr2IIiABQGgWSuckM879Do2rta/bVJgpejDLO8/B9Bykdnso0xeUr+HBqC9LDrXAE1D+7o97Y1IkPxOZCefTjKdJiLuT+/eUt2D4T/id5R8KIniyfNmVeLHqVpudNLDqqT2yyjU8y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RN0JphHi; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RN0JphHi"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2c7c684353dso4610185ad.2
        for <netdev@vger.kernel.org>; Mon, 22 Jun 2026 23:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782196933; x=1782801733; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=REeiWEzXJsG7DqV0Bw6mP/ft4dBk/VGKau57IND9SCI=;
        b=RN0JphHihF5pbn4RG/KFHVeH3158Gxh/bNXsd4U+6w68amk2kEYbp0kvxtN41y6PTZ
         WCBTeNtdTOY1zxMCvBTai/4+6Tk22Jrwa98FUt65+yqGocg7KXZMdI1JzmxbbjLUHxgT
         qypcFb71VQ9ZxLUIiHFVhOpdeLnt8HrfvMkK6CoLgwnVSCEeioYeU26KV5HNMEdW9byV
         yrPYZA3e4to0iaZ3IcEqzuklPf9xtmOsqETjplGK5oubNSwD86IaU6M1Ody2m1ZqxuV/
         Ux44ldUY79WV/1p3uD5G69V2Byrd7ZhugaJaNO9/pRASpodAVrBookscqoDOvfwVEPtt
         im6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782196933; x=1782801733;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=REeiWEzXJsG7DqV0Bw6mP/ft4dBk/VGKau57IND9SCI=;
        b=o4U1vgHCkW1pDc6NNXOfcUv+yUaR5tw2BdZgZ8zzdTlpdtOL2CBEvWd4HKCfHymPhM
         +/Rj85gHqKPB4ulWr1VCP0JogNev+B6/qvlDnTkLCpuEOHxA3g5zfoTDaCUv1pmsH0P7
         3Gr698WQxqEhgqEJ9v5EtaFZCd9Kbw0T8imQ1zBtX+Spzo8lkpaeoo3k+wAHnB/qwMyV
         aCkPbxha8WUqz89D2a3oMZ0f3xQaixsCEo2E7JUSLx3e/wADTVZRMfPutBRPCVOFlwm1
         qYAWjFW5p/indCscJ4UNMrV6F8qjeSZscsJb70KMzUySJPx1DYGFiaH2f2am5vQbrFfL
         R2yg==
X-Forwarded-Encrypted: i=1; AHgh+RqS8TeVtWahSUkdwa0qGIeR1wr59AU7kd5mt8T7LsEBYIpULFEWZfYTFfjJcv400KxJiMBxegg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzV3t/la/q4Ys2F+bChPyBUb9jRMUuSg0crBi0asEUv50kpFewm
	q3eI10FKFbKjI2GAyp3OI5eFVhFd6kikkMvX5+G+4bAXg7V9nGXGR4P6
X-Gm-Gg: AfdE7cmccl4yPqQMcBH5fYtQZpQRnnve6WS8drvf+Gs5KAW0GX4GoKTmHGhPAeICsLL
	ZNIxGChRfNePsfQaz9DCk+Xf89x7VxTFvnzGTyJvYIwG1e8rgU7+9DrnOPgCajvVPjfl4y4MrdI
	yv027Gt5QeV1NIH2J8vOSEYNrx7j0qnVyFy/vK/6ZaRgvf/KF2yRxQsbvg12RbaWhff6a4TMuup
	sgR0xP9b4v6g4PEqCEmqOhqvQ+4IvRaiIu+YczfbNrIjKk2e7BKQX8JpxqwdbUBdpGgMxZBdaQB
	/AKRSMZz9+RaoH2yMKmCdFKRrE/BPPlqrTa6tmyx7+lj7iDVsYbS/UJC8llxk45MCzKQEuQCRys
	ZpBYOf4bdjfCwXwQQzFBJvESpjyjFTlpElFjAlnvkY+H62Vy/6d2Vs/oD985WvyhBIJRC98bYwL
	Hc+2qxLtxDF3LzH7MwibFiuD3fFSeW7X7qg8nc7hHuHk3oH3phd9U=
X-Received: by 2002:a17:902:e803:b0:2c2:f675:32c5 with SMTP id d9443c01a7336-2c7c9a314c8mr11669575ad.29.1782196933437;
        Mon, 22 Jun 2026 23:42:13 -0700 (PDT)
Received: from localhost.localdomain ([115.110.225.242])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c7436af22bsm93689415ad.10.2026.06.22.23.42.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 23:42:13 -0700 (PDT)
From: Shitalkumar Gandhi <shital.gandhi45@gmail.com>
X-Google-Original-From: Shitalkumar Gandhi <shitalkumar.gandhi@cambiumnetworks.com>
To: Wells Lu <wellslutw@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>,
	Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shitalkumar Gandhi <shitalkumar.gandhi@cambiumnetworks.com>
Subject: [PATCH net v3 0/2] net: ethernet: sunplus: spl2sw: fix of_node refcount leaks
Date: Tue, 23 Jun 2026 12:11:41 +0530
Message-Id: <cover.1782195965.git.shitalkumar.gandhi@cambiumnetworks.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series fixes of_node refcount leaks in the Sunplus SP7021 ethernet
driver, found by inspection. Compile-tested only; no SP7021 hardware
available here.

Patch 1/2 fixes the phy_node leak in the remove path.
Patch 2/2 fixes multiple leaks in the probe path and depends on the
cleanup contract from patch 1/2.

Changes since v2:
  - Patch 2/2: replaced __free(device_node) scoped cleanup with
    explicit of_node_put() calls on each exit path (Jakub Kicinski).
  - Patch 1/2: no functional change.

Changes since v1:
  - Combined the two related fixes into a single series with cover
    letter, per netdev convention.
  - Added "Compile-tested only" note to both commit messages
    (Andrew Lunn).
  - Dropped Cc: stable@vger.kernel.org -- the leaks only manifest on
    driver unbind/rebind, which is not a path normally exercised on
    this SoC (Andrew Lunn).
  - Fix author email to match Signed-off-by (DCO).

v2: https://lore.kernel.org/netdev/cover.1781552725.git.shitalkumar.gandhi@cambiumnetworks.com/
v1: https://lore.kernel.org/netdev/20260607193029.589736-1-shitalkumar.gandhi@cambiumnetworks.com/
    https://lore.kernel.org/netdev/20260607193711.601544-1-shitalkumar.gandhi@cambiumnetworks.com/

Shitalkumar Gandhi (2):
  net: ethernet: sunplus: spl2sw: fix phy_node refcount leak in remove
  net: ethernet: sunplus: spl2sw: fix multiple of_node refcount leaks in
    probe

 drivers/net/ethernet/sunplus/spl2sw_driver.c | 23 +++++++++++++++++---
 drivers/net/ethernet/sunplus/spl2sw_phy.c    |  6 +++--
 2 files changed, 24 insertions(+), 5 deletions(-)

-- 
2.25.1

