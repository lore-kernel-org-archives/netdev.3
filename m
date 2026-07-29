Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE9114119E6;
	Wed, 29 Jul 2026 16:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785343070; cv=none; b=jn4jMZ3RwQQIX6B8gNorUfExR0HiBtWCTmVF81aVCtJwd2rUS9XXjcQSQGi4ZYovvQM6Td63xY7tGZoRNrdyru9jiCgVQrh3REk7DtYFNQplhmC3wbZyIVM95znPpq6wjguYM4HwGRLcn6xLsfBguYlM3mLmH3GCynKyPKYzrZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785343070; c=relaxed/simple;
	bh=Z1w5WIvbNQo9Zn50jFBwKMQf8kI7lW0aM+16Dh/V7qY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=sUkuoSQgQgeAmk80jLHZ/Qkl2fdN9rqWZO8OuZCQxxhk+BQltiyGQQiva4dq+r3OfiO57mnFC6DxG+fMKoo+4fencLoRhIeoiBw7QnwM5TMdVWmicX/Gqq6tg0OJSPSiqv5EdsC+xqxpURo0Cp0PJnt5uvXQ7QSGrrA7RENv8CE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Rigbcil8; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JWSoiNys; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Rigbcil8";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JWSoiNys"
From: Vasilij Strassheim <v.strassheim@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1785343064;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=LtRaNxgRbpO/FK7lN9MVibch0eWYBHUpJXlU+vO4/rQ=;
	b=Rigbcil8PytSssH8pyA1XNmp7ZqzLaaYaDjedBFfrRypeDeB39SAGfNSjmlkIEh6ADklE1
	AxggnuCAxcq5RGJySBZA45hiVIwdzwPL+z1S1bgv8lFc0MXCO/QM5TWGTnwFN/ACd5SBpM
	gwb79nsu/zlQAGd0c2NqH8SFPw2oCdQiRWIFzKKKVmU2m8ftMrnaPILlxWEM65v9yLiCzG
	0a46+rjus2TXEM7t3Kr9EAtbt3XS3p5oHkTUp+0nwbRakuKPv9BsfbxwPDO0G9AeQKcaeu
	ciYpcXKB8h5fcdjAr67q0m1KRxTBm5PGeeCUmj6fwv4Buo57ZxgWebzSlKGF0A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1785343064;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=LtRaNxgRbpO/FK7lN9MVibch0eWYBHUpJXlU+vO4/rQ=;
	b=JWSoiNys9q2nq89H6sf17ra8TjUP0dlH2vr1+9ZHbOnj0vZ7gH0ckbe9+aEGRodS5buSQ9
	a6nIKMvU8jBMZzAw==
Subject: [PATCH 0/4] net: dsa: Add SoC-e DSA driver
Date: Wed, 29 Jul 2026 18:36:53 +0200
Message-Id: <20260729-devel-vstrassheim-soce-dsa-ml-v1-0-be569dae1b20@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACUsamoC/yXMTQrCMBAG0KuUWTsQI9bqVaSLafJpR/ojmRqE0
 rsbdfk2byVDUhhdqpUSsprOU8F+V1HoZbqDNRaTd752J3/miIyBsy1JzHroyDYHcDThcWDvYi1
 HiV1zaKgcz4Sbvn//tf3bXt0DYfmmtG0fj5iUPoEAAAA=
X-Change-ID: 20260729-devel-vstrassheim-soce-dsa-ml-20d6a5adb838
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>, 
 Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Russell King <linux@armlinux.org.uk>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, Martin Kaistra <martin.kaistra@linutronix.de>, 
 Vasilij Strassheim <v.strassheim@linutronix.de>

Add initial support for the DSA driver for SoC-e FPGA-based (IP core)
Ethernet switches.

This first functional driver baseline is kept focused on Managed
Redundant Switch (MRS) which is also runtime-tested (25.01 IP using
24.01 layout) on ZynqMP hardware. It includes basic support for
networking (STP, FDB and Phylink), but not the IEEE 802.1Q VLAN tagging.
This will likely be added in the future.

This work is based on non-publicly available SoC-e DSA driver code, with
permission from the company to contribute it under different authorship.
There are different variants of the SoC-e switch IP, which can be
additionally configured at runtime with proprietary userspace software.
All variants share the same DSA features with a few differences in
register layout. Additional SoC-e switch variants might be introduced
later in separate patch series. 

Signed-off-by: Vasilij Strassheim <v.strassheim@linutronix.de>
---
Vasilij Strassheim (4):
      dt-bindings: vendor-prefixes: Add soce
      dt-bindings: net: dsa: Add SoC-e switch IP and DSA bindings
      net: dsa: Add support for SoC-e SDSA tags
      net: dsa: soce: Add initial driver support for MRS switches

 .../bindings/net/dsa/soce,switch-dsa.yaml          | 195 +++++++++++
 .../bindings/net/dsa/soce,switch-ip.yaml           |  54 +++
 .../devicetree/bindings/vendor-prefixes.yaml       |   2 +
 drivers/net/dsa/Kconfig                            |   2 +
 drivers/net/dsa/Makefile                           |   1 +
 drivers/net/dsa/soce/Kconfig                       |  12 +
 drivers/net/dsa/soce/Makefile                      |   6 +
 drivers/net/dsa/soce/soce_common.c                 | 159 +++++++++
 drivers/net/dsa/soce/soce_common.h                 |  36 ++
 drivers/net/dsa/soce/soce_dsa.h                    |  41 +++
 drivers/net/dsa/soce/soce_dsa_core.c               | 354 +++++++++++++++++++
 drivers/net/dsa/soce/soce_mdio.c                   | 381 +++++++++++++++++++++
 drivers/net/dsa/soce/soce_mdio.h                   |  40 +++
 drivers/net/dsa/soce/soce_mrs.h                    |  21 ++
 include/net/dsa.h                                  |   2 +
 net/dsa/Kconfig                                    |   6 +
 net/dsa/Makefile                                   |   1 +
 net/dsa/tag_sdsa.c                                 | 102 ++++++
 18 files changed, 1415 insertions(+)
---
base-commit: 9fb3b84c9577707db14e633ea3c57048380bf822
change-id: 20260729-devel-vstrassheim-soce-dsa-ml-20d6a5adb838

Best regards,
--  
Vasilij Strassheim <v.strassheim@linutronix.de>

