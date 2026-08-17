Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3613D305E3B
	for <netdev@vger.kernel.org>; Mon, 17 Aug 2026 00:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786924838; cv=none; b=RkrL8jKHZItytBmvynUwCuo4Q210J5X/kA2KThxQIF/iX+wXblr5TR/gaUhZm9AACmseKyyrODd0c8hUpQqipAwBgOWK7TmoFI0fUIgylgu38yMwALGvR611XP2+C1rEZAGzvS0Fvz31EVCe1Ro1G/1XLwb/5YK53rDJyujn9pQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786924838; c=relaxed/simple;
	bh=6RTg5Hb6zZsRPnNpf0Q7IiOsATNXj9Nz9kJLXoBlFiQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=YWMdoWNvMXAvgYa88LXZvoZB2G6p2s9sn73g3flZ7OSktuUR0omyULMSerjde+tBKtg7kTEK8ea2MIxiEzX6hY6Ai1eAXqpVkPfNbUgRCtBa98kfAib5NdRF5jJdgxjcvdYvtk5FjAeAtuvrnoBVbORntbiNYsrQSu4jbrKwN/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f3p1YwAq; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f3p1YwAq"
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-4b21f09ea42so1724918b6e.2
        for <netdev@vger.kernel.org>; Sun, 16 Aug 2026 17:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786924835; x=1787529635; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=fvYmmH+KfQ7O1sgqmpdyWXqFOmmC2PQNerX16oNlWsU=;
        b=f3p1YwAqRPGZ9VqQpaklHUl/cBKDyYy6DrCSQ0Bcj15AyiIqc/rbB/OKqpsZri3fK/
         T/YObWsRNXHjsgLcxZPPhtqUNUKvWmemvbt/rvU5VRNgtRZLfgleMbi9/Kkv/vwGfizy
         xQ6o3NSThB8TC4CzoPBi4wRQXy+i8eHggY8DnleUJj/aVxNh2T+8NzVsrj8FgtHtCYFj
         nkfUx5sy0GwZ9HmtIcGyiYOPAvy6NNwKnnm84oWz4EzRpxVVKi+ECuugU7aAmSogXVif
         sgMprdty70OEFRGzpbKXNTPdtbAalxl4Izav7KADOsDIBw+p7PEYgENmvacqrZ5ogNlA
         VFvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786924835; x=1787529635;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=fvYmmH+KfQ7O1sgqmpdyWXqFOmmC2PQNerX16oNlWsU=;
        b=PuwRcuv6hneTrY4SzTzF9Af6ma5zaRgavq0Y+WGqzsX4pn1KPsoQu874R3IF72EVh8
         KDADUyWntme4azkG1KD9KHAIceO4L8J8OHuHCE5FxXbbno1G6zKrYyw9+63l32WmLGKq
         M2ERbv8u/V3nIueGaOTJKY8WzFYJXLMBVGZORgaH2unsZ0CYH4ImP5o27cEROyEOlVqq
         9Y1U/Ruz5jkqRFVvo1DO/37qPnnSE9bAq3AZIC4viGwolQz/u0W3RMGNKOqxJMgbF0JR
         2RekG2/gLUtZiepZGXvX6WNY64Mc1wSNQfd2C1X/gCAzbCadY4cAzIXD8PMXFP+xIO1F
         RjyA==
X-Forwarded-Encrypted: i=1; AHgh+RoFQnnHBnUnU9p6YIuc4m1p6NcsywcksMSzVHdrqO4z7rQ4NWZs/R1Wy8J3Q678PHJ7yHyA4Gk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXMBTIiKVlhawU7k2RSJUclu6ih10xgFFDr1Zve2stubADZSCv
	30nWOEJzimvRwzSnHQpi5+ILJb1IPUclsb6o3Q+coDlWqaUajcsxHXb9
X-Gm-Gg: AR+sD10OWGQJUpsuP0SkxMeHw8YDmcMRXjUNvfcBMwsOwNKp5TjGNzRruqjR00wlFGK
	KA+w50R75QEVUVFaUZQV5BjGL/jY8NfyIoyD0sRQzgxJ374NMMbBep1ol0tDUrQ8Up+ZVu99Nns
	aHYDk1gvvWsBc/URmv5+kxkiBKf+CQOTIZBYLcSeLNSxywrKLYNaDlqXfNfABxoco2n7romDmhr
	no8PPQnrQBvGTB1ye+lHk/ogsJAkc8AG4CI8+A1ioIUpZ5lTrmoDLQZ8VH9WJt2c+6557jMsx62
	WgeC8fBbwSiV1THtXemXTpAvSs3VSYwGy49HuPzfYX5RMWUb3Zseg5osntGXc5CMt0qsvfCkCXK
	MI4YNR/e+PZ0rFZpumxOXNh2FSHnY63XdMH6x0nCLE6JkwBIyu3vXh8102m6sNdmrjQlIz57jjI
	kw0nFIMurCORF33V27+scNSXM4oIT3xYy/77fXxJvBChArCWF0E/dTCffU/HgJZXoWSVVZN2Alz
	2EuPo9jpOnTJZq4WCEaGN1yxfLJqGYqc1HFGD60HwvV1UE9cfURfjhd8S+LkSXO6MOgf8Ab6w+h
	RhPBaJYTGH97iTJPogBH8iDBqdFCpBVvI+WWIeEdceuXUF4ma+nBLu9JlPm60MfvW/LtpN4HVHB
	GT4XrOR9X5RknRLKV
X-Received: by 2002:a05:6808:3082:b0:495:f85b:38c0 with SMTP id 5614622812f47-4b241b9d037mr21641094b6e.12.1786924834990;
        Sun, 16 Aug 2026 17:00:34 -0700 (PDT)
Received: from [127.0.1.1] (184-96-154-59.hlrn.qwest.net. [184.96.154.59])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4b2714dc18asm2556802b6e.17.2026.08.16.17.00.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Aug 2026 17:00:34 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Subject: [PATCH net-next v2 0/4] of: mdio: fix fw_devlink for Ethernet PHY
 packages
Date: Sun, 16 Aug 2026 18:00:27 -0600
Message-Id: <20260816-submit-phy-package-fwdevlink-v1-v2-0-23e55dd59fad@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/42OzQ6CMBCEX4Xs2ZpS/j35HoZDLVtYgUJoRQjh3
 S34AiZzmczsfLuBxYnQwi3YYMKZLA3GG3EJQDXS1Mio8h4EFynPw5jZ97Mnx8ZmZaNUrfQN/al
 w7si0bA5ZlspcF6gxiQrwK+OEmpaT8ACDjhlcHJS/xI+9ULkDcHQbsm6Y1vOZOTwv/uZ6cSais
 MjjWPMkk/e6l9Rd1dBDue/7F8mzNk3qAAAA
X-Change-ID: 20260814-submit-phy-package-fwdevlink-v1-76a8f9efe539
To: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
 Andrew Lunn <andrew@lunn.ch>, Christian Marangi <ansuelsmth@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 driver-core@lists.linux.dev, netdev@vger.kernel.org, 
 James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.15.2

Ethernet PHY package nodes describe resources shared by their member
PHYs, but the package node is a container rather than a struct device.
fw_devlink therefore represents those dependencies with temporary
sync-state-only links from the closest existing ancestor device to each
supplier.

For OF MDIO, that ancestor is the MDIO bus class device. The bus is
driverless, so its proxy links never reach the usual driver-bound
cleanup. They can remain after all member PHYs have probed and
indefinitely prevent suppliers from receiving sync_state().

Before fixing the proxy-link lifecycle, skip supplier links when a binding
cannot resolve its consumer node. This prevents malformed graph descriptions
from passing a NULL consumer to the fwnode-link core.

Fix both parts of the lifecycle. First, factor the sync-state-only
cleanup already performed by device_links_driver_bound() and expose it
to frameworks which populate children below driverless devices. Next,
treat each enabled member PHY as a consumer of suppliers referenced by
its package node. Finally, call the cleanup helper after successful OF
MDIO population. The real links from each member PHY retain dependency
and runtime-PM ordering.

This was found while validating an X-Powers AC300 package whose input
clock is supplied by PWM. Before the fix, the PWM driver reported that
sync_state() was pending due to stmmac-0 even after the PHY had probed.

The complete fix was tested on an Allwinner H616 board with an X-Powers
AC300 PHY package. All five real supplier links targeted the member PHY,
and no proxy link remained on the driverless MDIO bus. The PWM supplier
reached state_synced while continuing to generate the PHY clock. The PHY
negotiated a 100 Mbps full-duplex link, 8 MiB was transferred in each
direction, and 100 consecutive pings completed without loss.

Validation completed with:

  - arm64 defconfig object builds of driver core, OF property and OF MDIO
    with W=1;
  - strict per-patch checkpatch checks; and
  - the H616/AC300 hardware test described above.

Assisted-by: Codex:gpt-5.6-sol
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes in v2:
- Add a preparatory guard for malformed graph consumers (reported by Sashiko)
- Rebase on net-next/main
- Link to v1: https://patch.msgid.link/20260814-submit-phy-package-fwdevlink-v1-v1-0-2319844f057a@gmail.com

---
James Hilliard (4):
      of: property: skip links without a consumer node
      driver core: factor sync-state-only link cleanup
      of: property: link PHY package suppliers to member PHYs
      net: mdio: release fw_devlink proxies after population

 drivers/base/core.c        | 74 +++++++++++++++++++++++++++++++++++-----------
 drivers/net/mdio/of_mdio.c |  5 +++-
 drivers/of/property.c      | 18 ++++++++++-
 include/linux/device.h     |  1 +
 4 files changed, 79 insertions(+), 19 deletions(-)
---
base-commit: e6a5d573d24cd375e09d24f136523cb3cc85c9d3
change-id: 20260814-submit-phy-package-fwdevlink-v1-76a8f9efe539

Best regards,
--  
James Hilliard <james.hilliard1@gmail.com>

