Received: from us.padl.com (us.padl.com [216.154.215.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63FBEF507;
	Sun, 19 Jul 2026 05:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.154.215.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784439072; cv=none; b=nj/PChQac53YIPxYaEuQkWrMc7yD719q54WW0GqTcW5lBRc0iLE8TmfRcJozPEalBjC8uwlL0P8Ea0PhIiwu4ipwojOC7TdXTrUpwyn6x38MTlpYAT3mcvzvXsKKexu+V/aNy/81K+3WYFYQbPGM7IXj/xlAxiQ8tarK3z7ryXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784439072; c=relaxed/simple;
	bh=74Ta/6nEhore7Kwqadk/GftMHAXzcpkXzJ7gRrgYFZ8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=RDM3jXcQn7FqrwArVjE8oRf99xnDKSTD17Ip77898u3ZeFbEJ6PJ4bfp/TDZJ1ftvAJ20HuWXt/1PpSioBmJ0liIW7SFDa88mbT6xhTyhTMFb8Po6nionWxTuwJ3fuDtZa3NwiDgISbDKKvTHhtVDfyd8+kLZa6cbjDwL2YB4pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com; spf=pass smtp.mailfrom=padl.com; dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b=mCW+Bep0; arc=none smtp.client-ip=216.154.215.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=padl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b="mCW+Bep0"
Received: from [127.0.1.1] (border.lukktone.com [139.130.100.52])
	by us.padl.com (Postfix) with ESMTPSA id 519AC60964;
	Sun, 19 Jul 2026 01:30:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=padl.com; s=default;
	t=1784439061; bh=VbNjJWOELwDXRusSac93JMFJkz4DfGpRe8PbdaO1BGw=;
	h=From:Subject:Date:To:Cc:From;
	b=mCW+Bep00oqum4wHOJiXv+KsCGQf6S8FscwmibuaGh+Va1o9JcolaowwDnx3q6VHZ
	 K5ikAHtl8D4egugZqkGHPA1freRzrqfu640jqGftw0W6n6CdLg/amK94X1XjEw1uVJ
	 O0Bt540rBqNzVmFkNhgf4wxFWZZIDqwTqFhe/dVH0QlQnnOkayvrjKEtSdBlMeb8Pu
	 KuvRjeL68JcUzhvYMdchL4wLsBSh3gDoNkv/OwFXubxpM4Edg6lDDeWjQYZgI7an4p
	 sJNHtt8iPz2xi9s0+f2oIcdVWKEKNgBg4aVX2QYAKfEUmRpdzP7uM/5jI0H4w4IQSv
	 5tzwsBoVEFe7g==
From: Luke Howard <lukeh@padl.com>
Subject: [PATCH net-next v3 0/3] net: dsa: mv88e6xxx: various hwstamp fixes
Date: Sun, 19 Jul 2026 15:30:52 +1000
Message-Id: <20260719-mv88e6xxx-ptp-fixes-v3-0-161386ac8a62@padl.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAxhXGoC/22Oyw6CMBREf4V0bU0fQi+u/A/jgsdFaqQQWpsaw
 r9b6oYFy8nMnJmFWJw1WnLNFjKj11aPJgp5ykjTV+aJVLdRE8FEwQrJ6OABsAgh0MlNtNMBLeV
 KilyxGkCUJDanGZMRi3di0FGDwZHH37Gf+oWN26BbttfWjfM3HfA8NdKWYvJwy3PKKOMScuAAZ
 VXepqp9n5txSANe7BD8+K4XEVF1pWoktJ24qB1iXdcfTgeZIBQBAAA=
X-Change-ID: 20260630-mv88e6xxx-ptp-fixes-1732570b8829
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784439056; l=1995;
 i=lukeh@padl.com; s=20260701; h=from:subject:message-id;
 bh=74Ta/6nEhore7Kwqadk/GftMHAXzcpkXzJ7gRrgYFZ8=;
 b=DrIVWkBQgvanG5aw06jwUYCCCYDVb5KUSXk2WibpLHs+SybkmtdggU5CUGYRajaSpI0w+QSo6
 jvBjKMUH5meApgw4PuEqD5G9uKMoOwViZZ5BtGy3vWUlBBao+VEtB2/
X-Developer-Key: i=lukeh@padl.com; a=ed25519;
 pk=D6YgUnH9/OzSZsduYm9XDbvXn1IHDwKwI1hLTsKNRLw=

Three fixes for improving the reliably of hardware timestamp acquisition
on Marvell switches. In our tests this eliminated missed timestamps in
ptp4l, whilst also preserving PTP event and general message ordering on
switches that support embedded timestamps.

Note: squashing the two embedded timestamp patches into a single commit
may be desirable.

Signed-off-by: Luke Howard <lukeh@padl.com>
---
Changes in v3:
- Unset UDP checksum on all embedded timestamp cases
- Handle embedded PTP arrival times without worker dispatch
- Link to v2: https://patch.msgid.link/20260710-mv88e6xxx-ptp-fixes-v2-0-af97c38df247@padl.com

Changes in v2:
- Lineraize SKBs before retrieving embedded timestamp
- Hoist driver register lock out of per-frame loop
- Link to v1: https://patch.msgid.link/20260703-mv88e6xxx-ptp-fixes-v1-0-0138581889a9@padl.com

To: Andrew Lunn <andrew@lunn.ch>
To: Vladimir Oltean <olteanv@gmail.com>
To: "David S. Miller" <davem@davemloft.net>
To: Eric Dumazet <edumazet@google.com>
To: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
To: Richard Cochran <richardcochran@gmail.com>
Cc: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

---
Luke Howard (3):
      net: dsa: mv88e6xxx: use ARRIVAL1 counter for all peer delay messages
      net: dsa: mv88e6xxx: embedded PTP timestamp support
      net: dsa: mv88e6xxx: apply embedded PTP arrival times inline

 drivers/net/dsa/mv88e6xxx/chip.c     |   4 ++
 drivers/net/dsa/mv88e6xxx/chip.h     |  15 +++-
 drivers/net/dsa/mv88e6xxx/hwtstamp.c | 134 +++++++++++++++++++++++++++++------
 drivers/net/dsa/mv88e6xxx/hwtstamp.h |  14 ++++
 drivers/net/dsa/mv88e6xxx/ptp.c      |  65 ++++++++++++++---
 drivers/net/dsa/mv88e6xxx/ptp.h      |   1 +
 6 files changed, 202 insertions(+), 31 deletions(-)
---
base-commit: f6f3b36c15ed44de1fbb44e645e4fae8c4a4453e
change-id: 20260630-mv88e6xxx-ptp-fixes-1732570b8829

Best regards,
--  
Luke Howard <lukeh@padl.com>

