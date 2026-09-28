Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4ECF4A4F13;
	Mon, 28 Sep 2026 11:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790594568; cv=none; b=broR3AP1nRSAB1U9N4BMMStzX0vWLGRF51erdowkQxHzejuAN5m43KeHDljmZacPqbMr0DpWrvXW+CtvsGCxsi6aGlUZWSwKqN/NGbF/yVU7h01MRxZqduPc3eArjLAqmphZ0NwaADGaET9HkPmW1bR22G2yWpIEhp8NuYPbvNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790594568; c=relaxed/simple;
	bh=xCEBZxchQjVFILRmecFCQyebxpysxGKyL9+c4VG7tX0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ft1KrlIK99hHODGL5YKXB2g7omSubvu56os8/B/TUMBpC6ah6FHCN2AmuZrcmypWGYnmSusUUOsW79Bavshonil4DnFTZ7EttSZV14r73tnEaQS8wd3JHb0QPZvJOQLc11UuwK/w+P6k6H3pWwVve8+uUNrjkyBrxo42JetMmqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YIaDX8N2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YIaDX8N2"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8B27BC2BCB3;
	Mon, 28 Sep 2026 11:22:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1790594568;
	bh=xCEBZxchQjVFILRmecFCQyebxpysxGKyL9+c4VG7tX0=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=YIaDX8N2ORGYQ4OF5MkdXT6S5LJjs70Mz5G2BWvBmed8/AvQv8A1s2GgRAgnLEgky
	 xMFZP9enqP4lPw3L/ijHcRAc5g5Upn3w4DEiKgZW3Uj/ajbFk38/mmctKX/NrR8ZmY
	 LCND9vHUe1duKm4NWSe5cYjE7aoUMYnM9gXO8vSnJkxGp08zFjETWtSi2kJBI8uRFI
	 XspLl+y7lavU15f78schE6rg4kmPbqOj1c9ltNG/ta+xQ10ErF/QxQdeoYxonsJSWc
	 d6yhGE2ocUSLNvOqHdag0H9jerNDEiau8c+l6UUx6Cr03V9LciQodmRHpMGybLUBYK
	 ysBlGkHpeSbxg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 672EBC9833F;
	Mon, 28 Sep 2026 11:22:48 +0000 (UTC)
From: Vincent Jardin via B4 Relay <devnull+vjardin.free.fr@kernel.org>
Subject: [PATCH net-next v2 0/2] dpaa2-eth: devlink port number from the
 DPMAC
Date: Mon, 28 Sep 2026 13:22:44 +0200
Message-Id: <20260928-for-upstream-dpaa2_ports-v2-0-1cda148530bf@free.fr>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAROumoC/4WNQQ6CMBBFr0Jm7ZhSBMGV9zDEtHQqXdg200owh
 LvbcAGXLy///Q0SsaMEt2oDpsUlF3wBeapgmpV/ETpTGKSQnRhkgzYwfmLKTOqNJiolnzFwTig
 uor/qptG6t1Dmkcm69Ug/wFNGT2uGsZjZpRz4e3wu9eH/55caBep2mPquJWOEuFsmOluGcd/3H
 /UUcKjIAAAA
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Ioana Ciornei <ioana.ciornei@nxp.com>, 
 Vladimir Oltean <vladimir.oltean@nxp.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Vincent Jardin <vjardin@free.fr>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790594566; l=1839;
 i=vjardin@free.fr; s=20260525; h=from:subject:message-id;
 bh=xCEBZxchQjVFILRmecFCQyebxpysxGKyL9+c4VG7tX0=;
 b=anevCG0fq2E1OsS4yQjzupJrwyi1aLLYS2gEodljMEEBnGmNDyElfsXfGiTGB9SDEvJ9GrI2X
 KEvulD1RzxUBrkJJlDq9pSEa5gmbAKB7RruotEy2XbjiUNVtPCRED5c
X-Developer-Key: i=vjardin@free.fr; a=ed25519;
 pk=hppgLeFpGpKOi7LNwGEZ4jOYofJCoGd4Jf1ltAabiLw=
X-Endpoint-Received: by B4 Relay for vjardin@free.fr/20260525 with
 auth_id=871
X-Original-From: Vincent Jardin <vjardin@free.fr>
Reply-To: vjardin@free.fr

dpaa2-eth registers every DPNI as a physical devlink port without a
port number, so all the DPAA2 interfaces report the same
phys_port_name "p0", including the DPNIs that have no DPMAC behind
them.

Patch 1 uses the DPMAC id as the physical port number. The attributes
of a registered devlink port cannot change, so when the DPNI endpoint
changes at runtime a warning says the number is stale until the DPNI
is rebound.

Patch 2 registers the DPNIs without a DPMAC as virtual ports. They
have no phys_port_name, so "p<dpmac id>" is unique.

With both patches, udev can name an interface using its DPMAC, for
instance:

  SUBSYSTEM=="net", ACTION=="add", DRIVERS=="fsl_dpaa2_eth", \
    ATTR{phys_port_name}=="p3", NAME="dpmac3"

Signed-off-by: Vincent Jardin <vjardin@free.fr>
---
Changes in v2:
- 1/2: shorter warning (Ioana Ciornei)
- 1/2: keep the registered port number in priv under mac_lock, so avoid
  IRQ race with the port registration at probe (Sashiko)
- 1/2: the port check moved to 1/2 from 2/2 (Ioana Ciornei)
- 2/2: new subject, commit log updates (Ioana Ciornei, Sashiko)
- rebased on net-next
- Link to v1: https://lore.kernel.org/r/20260923-for-upstream-dpaa2_ports-v1-0-b59c865edd00@free.fr

---
Vincent Jardin (2):
      dpaa2-eth: use the DPMAC id as the devlink physical port number
      dpaa2-eth: mark DPNIs without a DPMAC as virtual devlink ports

 .../ethernet/freescale/dpaa2/dpaa2-eth-devlink.c   | 45 +++++++++++++++++++++-
 drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c   |  2 +
 drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.h   |  3 ++
 3 files changed, 48 insertions(+), 2 deletions(-)
---
base-commit: 014d795c73837ea2339a4ea8e8f82c6e959b845d
change-id: 20260923-for-upstream-dpaa2_ports-04087b33bb8f

Best regards,
-- 
Vincent Jardin <vjardin@free.fr>


