Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AA4D51DE1A;
	Wed, 23 Sep 2026 12:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790168288; cv=none; b=AFJ36r626I5OH2MkDBw1/6qbGsa7jqWJJ+42/Owaiv0zaBfmIYmZaJrCnRwUwvY5O9cYZN8YNal/fKbOiKZt/ugWeDW9NZmk5UJH1JW6dZ8nBJy74xKNYP7if/+PnmuTn7kg/n0mrHarTf/gsAEDBJ3h8zrDJVtzYIDu60wTnwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790168288; c=relaxed/simple;
	bh=5pNfbU4tVij2R4/+mEJuS3A2gb4SCB4DZw+rw+oOaCs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=GDLzj5uE3qLEF1BhSqvPU95XZyh6IHMAgg8jTR5qAfazKzdXxi87Y691Zy/yUZVGvsL6Mhjf35cH9ogcm1LHZ81PoXjF8JChXgh7V3GYiTNTcWSGDGdP6VjTcaIdwpijpfTC1UDVg3yZFU+cLX/2PLeBY5hR1+ApfF2HvPGmkO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UekTSj9V; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UekTSj9V"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 14D54C2BCC7;
	Wed, 23 Sep 2026 12:58:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1790168288;
	bh=5pNfbU4tVij2R4/+mEJuS3A2gb4SCB4DZw+rw+oOaCs=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=UekTSj9Vesej9oaIeJSSyIxw6WHzti/sDX1IvbgIZMJ+lhx5wu2Lh6wonREpocXUy
	 RG9NSTjZsOydhC5tNwBcBgap4T7uToHlA4Z1KLVyFW4fM7GXc36GRjmfSsC1ZrFbHh
	 sYswvdch06y6+7WSbg1xyYh7PdrbC8mIGNLl8fjnnM5WaGxoT4SaDZsFdE6246Fndn
	 uC7MOSGbrBnsmaee5eoLjCSa5Jk8OD6Vwe8GvN3dni3UDnnsrc9EklIIuChQQqsMuK
	 v8JCL8z4ouWWzB7m7rQKuTh3bThPE4yB6oKVffCbLzFzv9CrRos77DvFXDnQEpu6WE
	 qLYA0WVB6nXpA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E09E6C9830C;
	Wed, 23 Sep 2026 12:58:07 +0000 (UTC)
From: Vincent Jardin via B4 Relay <devnull+vjardin.free.fr@kernel.org>
Subject: [PATCH net-next 0/2] dpaa2-eth: devlink port number from the DPMAC
Date: Wed, 23 Sep 2026 14:57:59 +0200
Message-Id: <20260923-for-upstream-dpaa2_ports-v1-0-b59c865edd00@free.fr>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANfMs2oC/x3MQQqDMBBA0avIrDuQJqK2VymlJHWis2gSZtIii
 Hc3dPkW/++gJEwK924HoR8r59RwvXTwXn1aCHluBmvsYG7WYcyC36JVyH9wLt7bV8lSFU1vpjE
 4F8IUoeVFKPL2Xz8gUcVEW4XncZyrmw4TdAAAAA==
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Ioana Ciornei <ioana.ciornei@nxp.com>, 
 Vladimir Oltean <vladimir.oltean@nxp.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Vincent Jardin <vjardin@free.fr>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790168286; l=1396;
 i=vjardin@free.fr; s=20260525; h=from:subject:message-id;
 bh=5pNfbU4tVij2R4/+mEJuS3A2gb4SCB4DZw+rw+oOaCs=;
 b=NSSeihn4C6BNXOpN2tdySGlRBWLAWLBfPs/0a/WW6inrzYeEoFahCHQSv6CdoIp5QJRHWVMYo
 YFO3N5ya4cVDaLYkaVl7OFbKyUE7ebm0pbOQGAfiufzmSqLt3ccNF5t
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
Vincent Jardin (2):
      dpaa2-eth: use the DPMAC id as the devlink physical port number
      dpaa2-eth: DPNIs without a DPMAC should be virtual devlink ports

 .../ethernet/freescale/dpaa2/dpaa2-eth-devlink.c   | 35 +++++++++++++++++++++-
 drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c   |  2 ++
 drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.h   |  1 +
 3 files changed, 37 insertions(+), 1 deletion(-)
---
base-commit: 944ae66642b726bd6b25ae71b1e9ff88a0e0bdb0
change-id: 20260923-for-upstream-dpaa2_ports-04087b33bb8f

Best regards,
-- 
Vincent Jardin <vjardin@free.fr>


