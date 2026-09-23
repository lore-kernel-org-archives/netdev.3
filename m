Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5406244CAE4;
	Wed, 23 Sep 2026 09:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790154807; cv=none; b=exZMlFqD04iloEh1oxCWFVIHkjZvDBseinb+9anza+XEiTi9DZCWGvMXFxztIVo7CL8hRjI+2+XotbTaRuUpgeGdRLCv3M5YjKWWq0Z21aQC+Vkg0l1biHtDQ1zvoSfKFGherZKWff6I/GBKqZdqYClSOlj6OnHC1dkB9Zd1P8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790154807; c=relaxed/simple;
	bh=Q+uqszN6bHLsWyywZim/j02cJONFOD6N5+Iw0UrUCe0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=baaj7zpObDHzzwCsxBLMUkGvMn5qJ0Zg0vTcViVg6yIpnry5BvGWqqKkysGwta+IpDBb1ApZ6Joh8f8lP1GXc26fOWEYW7bx0ZEMQfFWETn22raWtvOQgkZIAGPGnSHbtFSNeF4bxJ2F2H7oYA2JSCMWK2mobMbv64bQH92XJ6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lXZ2Z0mP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lXZ2Z0mP"
Received: by smtp.kernel.org (Postfix) with ESMTPS id E5EC9C2BCF5;
	Wed, 23 Sep 2026 09:13:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1790154807;
	bh=Q+uqszN6bHLsWyywZim/j02cJONFOD6N5+Iw0UrUCe0=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=lXZ2Z0mPzTaL/Zmrxmrz9Dtpm6o6tGmEJwiXqVJZq/umVJMVyiLpuazzMCfxjzWH6
	 D+wzJAmZ5/Gobz4TN6KwNmyyVFH10DIWufTJkCEka2OZm3oCMbMqHq11TVVfIKv0s6
	 9GAPXw9Ryo3fxyC1MGRyX6cSsFnBF+n2ONzO77RbkmebRXsYlQ+Qwq6yqInM8MjKNL
	 HHJvmD1HlYu7TlccSC1mLx+LeihdnYgpW6ZjTq0EyV/14QKtwb5SysGPKTxrJ+b4Ok
	 PiD68NrjH+1usFUsi0zo+8SM6K6j9Gfg4fZSCwGFNmRo1xjKolmL5UG7Kduu8OhHj4
	 AmWfhiIWb/a3w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDC51C98307;
	Wed, 23 Sep 2026 09:13:26 +0000 (UTC)
From: Kim Wooseok via B4 Relay <devnull+5mghybrid.khu.ac.kr@kernel.org>
Subject: [PATCH net-next v2 0/3] net: macb: Rework hardware timestamp
 configuration
Date: Wed, 23 Sep 2026 18:13:24 +0900
Message-Id: <20260923-macb-hwtstamp-rework-v2-0-75c909b2676d@khu.ac.kr>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/12Oyw6CMBBFf8XM2lGoSoIr/8OwmJbRVkJL2vIwh
 n+XYmKiyztz7uMFgb3hAOfNCzwPJhhnFyG2G1Ca7J3R1IsGkYkiK4XAlpREPcYQqe3Q8+h8g+J
 E8kiCC1keYbF2nm9mWmOvYDmi5SlC9fmEXj5YxZSaWEmBUXqySqeTcjVP+9+WhCRUmxCdf65jh
 3wN/+5afX/rlqbWRBxyzLCsc5JEp4Moi0uj+x2pXeOhmuf5Da69/7UFAQAA
X-Change-ID: 20260922-macb-hwtstamp-rework-25ab4a2e6b94
To: netdev@vger.kernel.org, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>, 
 Rafal Ozieblo <rafalo@cadence.com>
Cc: Conor Dooley <conor.dooley@microchip.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Nicolai Buchwitz <nb@tipi-net.de>, linux-kernel@vger.kernel.org, 
 Kim Wooseok <5mghybrid@khu.ac.kr>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790154804; l=2844;
 i=5mghybrid@khu.ac.kr; s=kernel-20260913; h=from:subject:message-id;
 bh=Q+uqszN6bHLsWyywZim/j02cJONFOD6N5+Iw0UrUCe0=;
 b=RmETYOfb5kImrjTdbxpSIwITAlSUtVyvOOxXFxz9W9qFhnzUj7Lnw4VZbUcd62wWElptcH46L
 FDYtEWNnmRxCRQp+56D1U0zpTUAhe8yMXA3Tk6kQVITdwVJWFE7WroI
X-Developer-Key: i=5mghybrid@khu.ac.kr; a=ed25519;
 pk=1az/6lC8Tmd6BcvyarPc8FWoSxsV/WRr5NLs1v+kjlE=
X-Endpoint-Received: by B4 Relay for 5mghybrid@khu.ac.kr/kernel-20260913
 with auth_id=1028
X-Original-From: Kim Wooseok <5mghybrid@khu.ac.kr>
Reply-To: 5mghybrid@khu.ac.kr

This started with two problems I found while using PTP hardware
timestamping on a Raspberry Pi 5. A rejected RX filter could still
change the TX one-step setting, and the PTPv1 Sync and Delay_Req filters
returned success without enabling RX timestamps.

This series reworks gem_set_hwtst() to validate the whole request before
programming the hardware. It calculates the settings locally, then
updates the registers and saved configuration under bp->lock. With the
register writes now in the setter, the two helpers are no longer needed.

The remaining patches use the existing ALL fallback for the specific
PTPv1 filters and clear SRTSM when switching away from a PTPv2 filter.
Each change is kept in its own patch.

For v1, I compared the old and new behavior on the Pi 5. When I
requested a TX mode change together with an invalid RX filter, the
patched driver rejected the request without changing the saved settings
or NCR. I also checked transitions between PTPv2 RX and the other
receive filters. SRTSM followed the selected RX filter without changing
unrelated NCR bits.

For the PTPv1 filters, I checked the effect by sending Sync and Delay_Req
packets over Ethernet. Before the change, the packets arrived without
hardware timestamps. With the patches, the driver returned ALL and I
could read the hardware timestamps from the received packets. PTPv2
multicast reception continued to provide hardware timestamps, and
selecting NONE disabled timestamping. I ran these tests with the changes
backported to the Pi's existing Linux 6.18.46 RT kernel.

On net-next, I built v1 with ARM64 allyesconfig and allmodconfig,
both with W=1. Sparse reported no diagnostics in macb_ptp.c.
For v2, I rebuilt macb_ptp.o with W=1.

Assisted-by: GPT-6 Astra
Signed-off-by: Kim Wooseok <5mghybrid@khu.ac.kr>
---
Changes in v2:
- Drop v1 patch 3/4 and retain the existing TX_OFF handling.
- Rebase the SRTSM cleanup onto the remaining patches, preserving
  its RX behavior.
- Reorder local variables to follow reverse Christmas tree ordering
  and handle each TX mode explicitly instead of using fallthrough.
- Add Reviewed-by and Tested-by tags.
- No other functional changes.
- Link to v1: https://patch.msgid.link/20260922-codex-macb-hwtstamp-submit-v1-0-9d1abaa53296@khu.ac.kr

---
Kim Wooseok (3):
      net: macb: Preserve timestamp settings on rejected requests
      net: macb: Enable RX timestamping for specific PTPv1 filters
      net: macb: Clear SRTSM outside PTPv2 receive filters

 drivers/net/ethernet/cadence/macb_ptp.c | 62 +++++++++++++--------------------
 1 file changed, 24 insertions(+), 38 deletions(-)
---
base-commit: 8830e65ed46de41f849eefb8ba227d4852c460f6
change-id: 20260922-macb-hwtstamp-rework-25ab4a2e6b94

Best regards,
--  
Kim Wooseok <5mghybrid@khu.ac.kr>


