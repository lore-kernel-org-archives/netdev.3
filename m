Received: from us.padl.com (us.padl.com [216.154.215.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E4D138B7D8;
	Mon, 27 Jul 2026 03:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.154.215.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785124777; cv=none; b=XTYnjOZZmPAc0V2ijzlXVKA7l9T9Bk9R6tVj459htC7QKtSxnylPVxqpuwYjjCEWnV5hu6lFyDEhHlizDuS8cpkxi44rVM5tRrYgn35KPE8cZbzb8eh44MQgvYvUJ3K1zC4ntTgf/QopAX6S5pmxPV7ORazVrkfQF7FR+q2XB74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785124777; c=relaxed/simple;
	bh=k9zLrp9MmB3Dr+Y3zc9vw+BoXjmlapbBKfmNFsGzd4A=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=BpRiR9FraxjIi4+IS0qEiOYONxtG7TOHmlixbPI5OF6HEPeWfyHLxThdlIHartfrgr1uo8hRTnR6rpB+S73b1Jwplibq+DflrUFJxg9XZwFAxf1SVtumlTM879UUVFHWMHpyoXWLltFjtTJH0ljop7EJfcwiNu8HKlyGlbXRSZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com; spf=pass smtp.mailfrom=padl.com; dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b=mIFDwrCv; arc=none smtp.client-ip=216.154.215.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=padl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b="mIFDwrCv"
Received: from [127.0.1.1] (border.lukktone.com [139.130.100.52])
	by us.padl.com (Postfix) with ESMTPSA id 1611060BED;
	Sun, 26 Jul 2026 23:59:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=padl.com; s=default;
	t=1785124766; bh=4956fsv5uYGOA9FuZPHf5/bYynuQBI7lKFU8KTwJuHE=;
	h=From:Subject:Date:To:Cc:From;
	b=mIFDwrCvVbQnIvwVXCrvtVMJHbvyUwIeFJbUJ8YJEUFn9sNrEHD7z8PdXaAlQqt32
	 pBh49SQYNF+f+A/2i0yJRW0eHx5ke9zw1xPijaQjAf2K89CMSBbCZZCTYkg4x5RdIz
	 yDzNh7kWsF5tVx83JGU1hRuG7vzJVHPQYPPhVde/Kk6jlzKrK9guQ/UD/NLKwK0dW9
	 sUee3/qkYE1kNSNegXvhSSlIEaBZeIneAbpDuOjqW4mJH9L++lryknw3azJ6FwZNIh
	 Fh6BmAjf3fJIusmA6HhhqT6qOA+XS1A+VEKttwa/CH/jp1KQIKEzHQdl9n8jD11/He
	 VAk5G15dkPOaA==
From: Luke Howard <lukeh@padl.com>
Subject: [PATCH net-next v4 0/5] net: dsa: mv88e6xxx: various hwstamp fixes
Date: Mon, 27 Jul 2026 13:59:11 +1000
Message-Id: <20260727-mv88e6xxx-ptp-fixes-v4-0-10b4020155fc@padl.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAI/XZmoC/22OTQ7CIBSEr2JYi+FH4eHKexgXSF8Vo21TkGBM7
 y7ipjFdTmbmm3mTgKPHQParNxkx+eD7rojtekXc1XYXpL4pmggmFFOS0UcCQJVzpkMcaOszBsq
 1FDvNzgDCkNIcRqxGKR5Jh5F2mCM5/ZzwPN/QxS/0m736EPvxVQ8kXht1SzO5uJU4ZZRxCTvgA
 Maaw2Cb+8b1jzqQxAzBl+8mURC2NdpJaFqx1X8IOUeYZYQsCK7KDWUdWCVmiGmaPpDrHGtXAQA
 A
X-Change-ID: 20260630-mv88e6xxx-ptp-fixes-1732570b8829
To: Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Vivien Didelot <vivien.didelot@gmail.com>, 
 Gregory CLEMENT <gregory.clement@bootlin.com>, Andrew Lunn <andrew@lunn.ch>, 
 Richard Cochran <richardcochran@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Florian Fainelli <f.fainelli@gmail.com>, 
 Simon Horman <horms@kernel.org>
Cc: Cedric Jehasse <cedric.jehasse@gmail.com>, 
 Kieran Tyrrell <kieran@sienda.com>, Max Holtmann <mh@rme-audio.de>, 
 Max Hunter <max@huntershome.org>, 
 Christoph Mellauner <christoph.mellauner@joyned.at>, 
 Simon Gapp <simon.gapp@gapp-audio.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Luke Howard <lukeh@padl.com>, 
 devicetree@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785124760; l=2763;
 i=lukeh@padl.com; s=20260701; h=from:subject:message-id;
 bh=k9zLrp9MmB3Dr+Y3zc9vw+BoXjmlapbBKfmNFsGzd4A=;
 b=j5x0HfixstEUxA3Y4BsaznCJGI/DUUtY5mmEcouoYsqKCmPIssE+mMfD6kih3mwHOSddb2qXt
 /Xg8WctHzaYDpTgQ+CqY/Zu+noNAQafxi229pCGCi5wNFbJExJ0mSj4
X-Developer-Key: i=lukeh@padl.com; a=ed25519;
 pk=D6YgUnH9/OzSZsduYm9XDbvXn1IHDwKwI1hLTsKNRLw=

Three fixes for improving the reliably of hardware timestamp acquisition
on Marvell switches. In our tests this eliminated missed timestamps in
ptp4l, whilst also preserving PTP event and general message ordering on
switches that support embedded timestamps.

Signed-off-by: Luke Howard <lukeh@padl.com>
---
Changes in v4:
- Gate embedded PTP arrival time support on new DSA protocol
- Only timestamp PTPv2 frames (Marvell switches do not support PTPv1)
- Link to v3: https://patch.msgid.link/20260719-mv88e6xxx-ptp-fixes-v3-0-161386ac8a62@padl.com

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
To: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>
To: Conor Dooley <conor+dt@kernel.org>
To: Florian Fainelli <f.fainelli@gmail.com>
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: devicetree@vger.kernel.org

---
Luke Howard (5):
      net: dsa: mv88e6xxx: only time stamp PTPv2 frames
      net: dsa: mv88e6xxx: use ARRIVAL1 counter for all peer delay messages
      net: dsa: mv88e6xxx: decouple the PTP timecounter from the register lock
      dt-bindings: net: dsa: add EDSA arrival-timestamp tag protocol
      net: dsa: mv88e6xxx: embedded PTP timestamp support

 .../devicetree/bindings/net/dsa/dsa-port.yaml      |   1 +
 drivers/net/dsa/mv88e6xxx/chip.c                   |  30 ++-
 drivers/net/dsa/mv88e6xxx/chip.h                   |  22 ++-
 drivers/net/dsa/mv88e6xxx/hwtstamp.c               | 218 ++++++++++++++++++---
 drivers/net/dsa/mv88e6xxx/hwtstamp.h               |  21 +-
 drivers/net/dsa/mv88e6xxx/ptp.c                    |  65 +++++-
 drivers/net/dsa/mv88e6xxx/ptp.h                    |   1 +
 include/net/dsa.h                                  |   2 +
 net/dsa/tag_dsa.c                                  |  18 ++
 9 files changed, 342 insertions(+), 36 deletions(-)
---
base-commit: ce6b4d3216b63f902bb8e9695ee6c10c83415f65
change-id: 20260630-mv88e6xxx-ptp-fixes-1732570b8829

Best regards,
--  
Luke Howard <lukeh@padl.com>

