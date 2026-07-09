Received: from us.padl.com (us.padl.com [216.154.215.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EBF426E71F;
	Thu,  9 Jul 2026 23:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.154.215.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783639793; cv=none; b=lD2EnfySFF46RBYdFh+LdR3D0yArfKszI56VvwzYCDH2472YW9HrB9GSLnci3xglcr8UVoSfDog0SsW+UYcEaVGeZ5wZPNZ70OkyF1FX6Jfp8N3HQWCjGwdQE+2zAhe6t3NPcJrXFlJ4+kXfD64C3VMC8lyextqZDiHTgLSJs7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783639793; c=relaxed/simple;
	bh=NKLIZegGU8Y1LkKHqZPoBeWjAUFqhf97ghB1/LdcwzE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=UUZZdwPX/zxzQgWGbxRP83KfQFFHKY8M5PwoxhWIr/7t4ikvraU50x/gkgSzDlGS5Qeit2Oc/iIS12XDPPJ6udJpR7a/BOrgDDkZsjgaF0kB8IWGx1D1nFOGmZzaYAaaArk8CI0xj61AmZlQISfnQJDrsI+UZkbcyLp9bfeIp/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com; spf=pass smtp.mailfrom=padl.com; dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b=VS0IFjVT; arc=none smtp.client-ip=216.154.215.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=padl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b="VS0IFjVT"
Received: from [127.0.1.1] (border.lukktone.com [139.130.100.52])
	by us.padl.com (Postfix) with ESMTPSA id 3662560212;
	Thu,  9 Jul 2026 19:29:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=padl.com; s=default;
	t=1783639784; bh=2RZl0wE492oUg2uWq2VVSw1AcEFcPDIBHPyT93/L2pc=;
	h=From:Subject:Date:To:Cc:From;
	b=VS0IFjVTdwc+dOuQy5WhWFERhKky1dxXtAGwElenQWNk8rWItVMgscwKFmmLtP4mF
	 ilg/bZW5NmFPnf9Ks1iWMre3LbCRgNAUhUhDl6lfDd04DDDOUiqCBlt9IegWAyO/Ms
	 LwNC+b2u7VJpAqlnZ0I5DcCujc13iDa19jC6Rl/1q4TR7nr5DSKDWCVrdnCC6amcTL
	 Pzjf3SP0UGXhd3XX3Xmmm6WN9dVkBld47PsRstpW+2EiDR/oSiTT7vBAhUWB6XAOo3
	 dDmuZD8vhUQwPdH4phy7j2slTEI/BMsOwhQ/LKoapHc7+MRhUnAV6VeC6tHr6bqYUR
	 Q3zPzp6HTZ/yw==
From: Luke Howard <lukeh@padl.com>
Subject: [PATCH net v2 0/2] net: dsa: mv88e6xxx: 6141/6341 workarounds
Date: Fri, 10 Jul 2026 09:29:31 +1000
Message-Id: <20260710-mv88e6x41-fixes-v2-0-e23654c65aa0@padl.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANsuUGoC/2WNyxKCIBSGX8U562gAkbBV79G4UDgkTV4GjLFxf
 PeQli3/67dBQO8wwLXYwGN0wU1jEvxUgO7b8YHEmaSBUy6p5IIMUSmUq2DEuhUDMUIrYeuqwk5
 DWs0ec5BGdxhxgeZnhnf3RL0cX0etd2GZ/CdzI8vljLjQ8g8RGaHEdqZsWWdVLavb3JrXWU8DN
 Pu+fwHm3qArxAAAAA==
X-Change-ID: 20260624-mv88e6x41-fixes-d4c84f955ebc
To: Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Vivien Didelot <vivien.didelot@gmail.com>, 
 Gregory CLEMENT <gregory.clement@bootlin.com>, Andrew Lunn <andrew@lunn.ch>, 
 Richard Cochran <richardcochran@gmail.com>
Cc: Cedric Jehasse <cedric.jehasse@gmail.com>, 
 Kieran Tyrrell <kieran@sienda.com>, Max Holtmann <mh@rme-audio.de>, 
 Max Hunter <max@huntershome.org>, 
 Christoph Mellauner <christoph.mellauner@joyned.at>, 
 Simon Gapp <simon.gapp@gapp-audio.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Luke Howard <lukeh@padl.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783639779; l=1923;
 i=lukeh@padl.com; s=20260701; h=from:subject:message-id;
 bh=NKLIZegGU8Y1LkKHqZPoBeWjAUFqhf97ghB1/LdcwzE=;
 b=vgbdgJNOfqBigHAugTQAk0mfpV28x6tvoGtCwvwXt4eeM5MlRU8OIYepZvxIwJoyc1NK+n+FG
 zDDuKZ33ogJDcCErgAk6RkLyVVhJMW4D/AFmPVwx7Id9ZkCZq9Hh7sA
X-Developer-Key: i=lukeh@padl.com; a=ed25519;
 pk=D6YgUnH9/OzSZsduYm9XDbvXn1IHDwKwI1hLTsKNRLw=

This patch series addresses two issues I found with the 88E6341
switch, which likely also apply to the 88E6141 (which is the same
chip without AVB/TSN support).

The first was a genuine bug, which assumed the chip did not have
a dedicated ATU FID register (it does).

The other is an issue I noticed with hash collisions in the ATU
on the 6341 when using multiple FIDs. Different algorithms could
be selected using devlink, but the FDB was not flushed which
resulted in a corrupted FDB.

Signed-off-by: Luke Howard <lukeh@padl.com>
---
Changes in v2:
- Rather than special casing ATU hash algorithm for the 6341, simply
  ensure the ATU is flushed when changing it via devlink.
- Retartget net instead of net-next, as this is a bugfix
- Link to v1: https://patch.msgid.link/20260703-mv88e6x41-fixes-v1-0-fbd3a1bf8965@padl.com

To: Andrew Lunn <andrew@lunn.ch>
To: Vladimir Oltean <olteanv@gmail.com>
To: "David S. Miller" <davem@davemloft.net>
To: Eric Dumazet <edumazet@google.com>
To: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
To: Richard Cochran <richardcochran@gmail.com>
To: Vivien Didelot <vivien.didelot@gmail.com>
To: Gregory CLEMENT <gregory.clement@bootlin.com>
Cc: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

---
Luke Howard (2):
      net: dsa: mv88e6xxx: write the ATU FID register on 88E6141/88E6341
      net: dsa: mv88e6xxx: flush the ATU when the hash algorithm changes

 drivers/net/dsa/mv88e6xxx/chip.c        | 29 ++++++++++++++++++++++++++++-
 drivers/net/dsa/mv88e6xxx/chip.h        | 12 +++++++++---
 drivers/net/dsa/mv88e6xxx/devlink.c     |  6 ++++++
 drivers/net/dsa/mv88e6xxx/global1_atu.c |  4 ++--
 4 files changed, 45 insertions(+), 6 deletions(-)
---
base-commit: fe3e786ef4eb6e47d2901f568a27bd920477bbe9
change-id: 20260624-mv88e6x41-fixes-d4c84f955ebc

Best regards,
--  
Luke Howard <lukeh@padl.com>

