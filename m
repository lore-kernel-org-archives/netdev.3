Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 315B53101D4
	for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 22:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789167273; cv=none; b=Dt9/Cg90rL8IphqcWAVp5gP96bCrraiI4AboyAckpGrlBUvYQ1OrOY44uKVgFXGEI0ePorwvc07aaCe7YxrA1WQtzuPJO9dOa+ZaIy4WJcpILae34SkI1/M5D37nu9i6gjsW4gUMtpOZJwC8ZEzxxurcDu8PwiDGKwN4pbqfCws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789167273; c=relaxed/simple;
	bh=RcdkqwCaqrqB4PrJT0V5De4eUJteVGmiJK0MozbyblM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=RshET+PwvdUC9kDRht/TAO2c5xZMrFB0YFY4yG7dZvYSN2aB5EMqVfuAhbaMbS0Or63QLEURbyqEEXIEsuPVBlASljpgnoKHJoYHDps+EyQYEY+Ret2s0FBGaFJJxIo3AZ9NVs4lPs/jCRf52lWITDBrHgEXj5uMsGFYK2/VndY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fEPJX7pa; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fEPJX7pa"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-49d05d51553so13899745e9.2
        for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 15:54:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789167269; x=1789772069; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=OySb4jsNqd6N3Z5V3MEkuv9+v4volOuvOSRkKAj68bc=;
        b=fEPJX7paXTcFtO8vEXqIOdtBNwxLHnmlrYmQTvDppNZXLpmqO3GAPXTkPnENQ2KVcS
         5Jnp1mSzhqjUyO1F6nZeUcQfsSJMa8fixKDDjZQLzmeLzj8P+lUG5cmgtrnkcGSI0RQj
         PikdhlAQO5Et07FVCaQtHRsPWaJbIeIQAs+rv/82RwdmdDmipumbnrkiHY4utdJrEbpe
         d16hgecFJquFl4WGnVKl1Tnw2YCxzBubqitsOfh5VM2gWgL1sfY+Mu/mtK3+224tfHMU
         vE71tjxrrJKRWYXIdvrjM5ttP1ycw5qf8HywIXK/l/HV8H2dAkVFgtjWWAOALndCmul7
         3hKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789167269; x=1789772069;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=OySb4jsNqd6N3Z5V3MEkuv9+v4volOuvOSRkKAj68bc=;
        b=pzIGJW6azqVX2jIp9E5pJxs9CX6L+Nf9hyOf2Ibezv/0cUQVg4SRZG68XyEf6oYjgQ
         hN+s83K6Bz+rdV9KT9j9NHem94IipTxpIsDt0cpMYBmUtMDvKN3LUq8CjEa7dA7D6FeX
         SMUw5S3d1nApR8X25+kT2fIyLCP68qlUgwLFJ9dc7CBl2SylkNr5Pc8He9qbNbUWTWK7
         SHqVEP0P6d8JtZEBqcUfX12WBytGm4ruUXYWPZkCq9/YE3/gNVMDwXStQOpHojz505nY
         PGntzxTA3ua/3AV6Vm9w10Qg2uspLeaNroAcpiTj+E+xr6hbtj4FDz/Q3obgASxjfju7
         1ssg==
X-Forwarded-Encrypted: i=1; AKwUvByBBK/h193XidBRed0orLuTkwGt3LytnKC1cKYxLyvtB2+6JCmwdJ2aEx18ebLgMPhunjX4MIM=@vger.kernel.org
X-Gm-Message-State: AFuF++nKST1vD7RsZdGo5eHVwkYe+VR5sjKhCPb4KS7tsbH0DeJfZYCP
	1Xcbtqf0KorsOOC44jm3FBDWpY4MMHbllt1G8jM55qF/0hWbgMOpV4pw
X-Gm-Gg: AYBFou3MnNZRpm2xaOzPFhoDJazAeJkZv3VVUDDsmTP30r2YuHzNL3gMLJJMwXTfbsE
	VSDMvE4V/rYgFZ7tmxuHapC/mFpWZ8gBUKOTvinqIXNHKcaBYLzx5vmJtFPhhVG6QmEoMHUB99B
	Wlx3+3MCARMBPOZNrwXOwkY5YwfkUxhgP/XXpVVPxgMSoJ6scK0yBDllHWVCdbonIBIRQOX/9u3
	xTszONQ5WBP1/RH6a0+HjQk1nPHnHLVVAQ3PtbAUEg63AZ8JO6toqzgWP/qVI9IaoF6kpGX1ope
	eIxdRJS179pbwlPUpTiUXGaPX5X5uxxxA6FyOi6g2oD72mDrqjU9dD5MRXmYeXB1e1uQL7/AJYN
	40IusqBVyj4kuCjDbccGueKXNTNeJCM/796DyoKz3slZ2uVtBDxWOteEmFeXOL4lJU/DNA/fHh1
	i4dQ1PbJu5IUvlQ1moKiLaQIG06zSHrooPWKoQ05zQE03/QYO2WD18YHU2dOUUY7zdxBa99NNE6
	PH7GmP9E474ZTzk/prd3IJl/ECaGEXOs8wnWxGYbJGMa+95PbzrfED08sx8MBE=
X-Received: by 2002:a05:600c:3b27:b0:49c:fc6e:a3d8 with SMTP id 5b1f17b1804b1-49e619cc2aemr77451305e9.23.1789167269060;
        Fri, 11 Sep 2026 15:54:29 -0700 (PDT)
Received: from Ansuel-XPS24.localdomain (host-79-26-252-140.retail.telecomitalia.it. [79.26.252.140])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-49e6221ffb0sm77593685e9.3.2026.09.11.15.54.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 15:54:28 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Christian Marangi <ansuelsmth@gmail.com>,
	Lee Jones <lee@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"Chester A. Unal" <chester.a.unal@arinc9.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Simon Horman <horms@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	netdev@vger.kernel.org,
	mfd@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v21 0/9] net: dsa: Add Airoha AN8855 support
Date: Sat, 12 Sep 2026 00:53:24 +0200
Message-ID: <20260911225414.225980-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series add the initial support for the Airoha AN8855 Switch.

It's a 5 port Gigabit Switch with SGMII/HSGMII upstream port.

This is starting to get in the wild and there are already some router
having this switch chip.

MT7530 is generalized with reg fields to a shared library to
reduce code duplication and reuse all the logic for AN8855.

There is this special thing where PHY needs to be calibrated with values
from the switch efuse. (the thing have a whole cpu timer and MCU)

Given the double usage of PHY and Switch accessor, a special handling
is used with registering a mdio-regmap bus for each internal PHY.

From v8 Driver is now evaluated with Kernel selftest scripts for DSA:

Additional info about the test bridge_vlan_aware.sh.

It was discovered that the Airoha Switch (and probably the Mediatek one
that produce the same test results) hardcode checking for 802.1ad when
the port is configured in VLAN-Aware mode (aka Security mode).

In such mode, both 802.1q and 802.1ad TPID are checked, hence the
bridge_vlan_aware.sh test fails as packets with 802.1ad TPID are rejected
(in the case where a wrong VLAN ID is forwarded)

This was confirmed by Airoha and multiple try were done to try to
workaround this problem. No solution were found to this as ACL mechanism
can't work on receiving packets and the Switch doesn't support turning off
this.

The current driver is in use from 4 month on OpenWrt with all kind of
scenario confirming working in VLAN bridge. By tweaking the
bridge_vlan_aware.sh test with setting the TPID to 0x9100, the test
correctly pass as packets gets classified as untagged and the default PVID
applied. It's also confirmed that switch correctly parse the 802.1ad tag
and make the packet pass only when allowed by VLAN table rules.

Output local_termination.sh
TEST: lan2: Unicast IPv4 to primary MAC address                     [ OK ]
TEST: lan2: Unicast IPv4 to macvlan MAC address                     [ OK ]
TEST: lan2: Unicast IPv4 to unknown MAC address                     [ OK ]
TEST: lan2: Unicast IPv4 to unknown MAC address, promisc            [ OK ]
TEST: lan2: Unicast IPv4 to unknown MAC address, allmulti           [ OK ]
TEST: lan2: Multicast IPv4 to joined group                          [ OK ]
TEST: lan2: Multicast IPv4 to unknown group                         [XFAIL]
        reception succeeded, but should have failed
TEST: lan2: Multicast IPv4 to unknown group, promisc                [ OK ]
TEST: lan2: Multicast IPv4 to unknown group, allmulti               [ OK ]
TEST: lan2: Multicast IPv6 to joined group                          [ OK ]
TEST: lan2: Multicast IPv6 to unknown group                         [XFAIL]
        reception succeeded, but should have failed
TEST: lan2: Multicast IPv6 to unknown group, promisc                [ OK ]
TEST: lan2: Multicast IPv6 to unknown group, allmulti               [ OK ]
TEST: lan2: 1588v2 over L2 transport, Sync                          [ OK ]
TEST: lan2: 1588v2 over L2 transport, Follow-Up                     [ OK ]
TEST: lan2: 1588v2 over L2 transport, Peer Delay Request            [ OK ]
TEST: lan2: 1588v2 over IPv4, Sync                                  [FAIL]
        reception failed
TEST: lan2: 1588v2 over IPv4, Follow-Up                             [FAIL]
        reception failed
TEST: lan2: 1588v2 over IPv4, Peer Delay Request                    [FAIL]
        reception failed
TEST: lan2: 1588v2 over IPv6, Sync                                  [FAIL]
        reception failed
TEST: lan2: 1588v2 over IPv6, Follow-Up                             [FAIL]
        reception failed
TEST: lan2: 1588v2 over IPv6, Peer Delay Request                    [FAIL]
        reception failed
TEST: vlan_filtering=0 bridge: Unicast IPv4 to primary MAC address   [ OK ]
TEST: vlan_filtering=0 bridge: Unicast IPv4 to macvlan MAC address   [ OK ]
TEST: vlan_filtering=0 bridge: Unicast IPv4 to unknown MAC address   [ OK ]
TEST: vlan_filtering=0 bridge: Unicast IPv4 to unknown MAC address, promisc   [ OK ]
TEST: vlan_filtering=0 bridge: Unicast IPv4 to unknown MAC address, allmulti   [ OK ]
TEST: vlan_filtering=0 bridge: Multicast IPv4 to joined group       [ OK ]
TEST: vlan_filtering=0 bridge: Multicast IPv4 to unknown group      [XFAIL]
        reception succeeded, but should have failed
TEST: vlan_filtering=0 bridge: Multicast IPv4 to unknown group, promisc   [ OK ]
TEST: vlan_filtering=0 bridge: Multicast IPv4 to unknown group, allmulti   [ OK ]
TEST: vlan_filtering=0 bridge: Multicast IPv6 to joined group       [ OK ]
TEST: vlan_filtering=0 bridge: Multicast IPv6 to unknown group      [XFAIL]
        reception succeeded, but should have failed
TEST: vlan_filtering=0 bridge: Multicast IPv6 to unknown group, promisc   [ OK ]
TEST: vlan_filtering=0 bridge: Multicast IPv6 to unknown group, allmulti   [ OK ]
TEST: vlan_filtering=1 bridge: Unicast IPv4 to primary MAC address   [ OK ]
TEST: vlan_filtering=1 bridge: Unicast IPv4 to macvlan MAC address   [ OK ]
TEST: vlan_filtering=1 bridge: Unicast IPv4 to unknown MAC address   [ OK ]
TEST: vlan_filtering=1 bridge: Unicast IPv4 to unknown MAC address, promisc   [ OK ]
TEST: vlan_filtering=1 bridge: Unicast IPv4 to unknown MAC address, allmulti   [ OK ]
TEST: vlan_filtering=1 bridge: Multicast IPv4 to joined group       [ OK ]
TEST: vlan_filtering=1 bridge: Multicast IPv4 to unknown group      [XFAIL]
        reception succeeded, but should have failed
TEST: vlan_filtering=1 bridge: Multicast IPv4 to unknown group, promisc   [ OK ]
TEST: vlan_filtering=1 bridge: Multicast IPv4 to unknown group, allmulti   [ OK ]
TEST: vlan_filtering=1 bridge: Multicast IPv6 to joined group       [ OK ]
TEST: vlan_filtering=1 bridge: Multicast IPv6 to unknown group      [XFAIL]
        reception succeeded, but should have failed
TEST: vlan_filtering=1 bridge: Multicast IPv6 to unknown group, promisc   [ OK ]
TEST: vlan_filtering=1 bridge: Multicast IPv6 to unknown group, allmulti   [ OK ]
TEST: VLAN upper: Unicast IPv4 to primary MAC address               [ OK ]
TEST: VLAN upper: Unicast IPv4 to macvlan MAC address               [ OK ]
TEST: VLAN upper: Unicast IPv4 to unknown MAC address               [ OK ]
TEST: VLAN upper: Unicast IPv4 to unknown MAC address, promisc      [ OK ]
TEST: VLAN upper: Unicast IPv4 to unknown MAC address, allmulti     [ OK ]
TEST: VLAN upper: Multicast IPv4 to joined group                    [ OK ]
TEST: VLAN upper: Multicast IPv4 to unknown group                   [XFAIL]
        reception succeeded, but should have failed
TEST: VLAN upper: Multicast IPv4 to unknown group, promisc          [ OK ]
TEST: VLAN upper: Multicast IPv4 to unknown group, allmulti         [ OK ]
TEST: VLAN upper: Multicast IPv6 to joined group                    [ OK ]
TEST: VLAN upper: Multicast IPv6 to unknown group                   [XFAIL]
        reception succeeded, but should have failed
TEST: VLAN upper: Multicast IPv6 to unknown group, promisc          [ OK ]
TEST: VLAN upper: Multicast IPv6 to unknown group, allmulti         [ OK ]
TEST: VLAN upper: 1588v2 over L2 transport, Sync                    [ OK ]
TEST: VLAN upper: 1588v2 over L2 transport, Follow-Up               [FAIL]
        reception failed
TEST: VLAN upper: 1588v2 over L2 transport, Peer Delay Request      [ OK ]
TEST: VLAN upper: 1588v2 over IPv4, Sync                            [FAIL]
        reception failed
;TEST: VLAN upper: 1588v2 over IPv4, Follow-Up                       [FAIL]
        reception failed
TEST: VLAN upper: 1588v2 over IPv4, Peer Delay Request              [FAIL]
        reception failed
TEST: VLAN upper: 1588v2 over IPv6, Sync                            [FAIL]
        reception failed
TEST: VLAN upper: 1588v2 over IPv6, Follow-Up                       [FAIL]
        reception failed
TEST: VLAN upper: 1588v2 over IPv6, Peer Delay Request              [FAIL]
        reception failed
TEST: VLAN over vlan_filtering=0 bridged port: Unicast IPv4 to primary MAC address   [ OK ]
TEST: VLAN over vlan_filtering=0 bridged port: Unicast IPv4 to macvlan MAC address   [ OK ]
TEST: VLAN over vlan_filtering=0 bridged port: Unicast IPv4 to unknown MAC address   [ OK ]
TEST: VLAN over vlan_filtering=0 bridged port: Unicast IPv4 to unknown MAC address, promisc   [ OK ]
TEST: VLAN over vlan_filtering=0 bridged port: Unicast IPv4 to unknown MAC address, allmulti   [ OK ]
TEST: VLAN over vlan_filtering=0 bridged port: Multicast IPv4 to joined group   [ OK ]
TEST: VLAN over vlan_filtering=0 bridged port: Multicast IPv4 to unknown group   [XFAIL]
        reception succeeded, but should have failed
TEST: VLAN over vlan_filtering=0 bridged port: Multicast IPv4 to unknown group, promisc   [ OK ]
TEST: VLAN over vlan_filtering=0 bridged port: Multicast IPv4 to unknown group, allmulti   [ OK ]
TEST: VLAN over vlan_filtering=0 bridged port: Multicast IPv6 to joined group   [ OK ]
TEST: VLAN over vlan_filtering=0 bridged port: Multicast IPv6 to unknown group   [XFAIL]
        reception succeeded, but should have failed
TEST: VLAN over vlan_filtering=0 bridged port: Multicast IPv6 to unknown group, promisc   [ OK ]
TEST: VLAN over vlan_filtering=0 bridged port: Multicast IPv6 to unknown group, allmulti   [ OK ]
TEST: VLAN over vlan_filtering=0 bridged port: 1588v2 over L2 transport, Sync   [ OK ]
TEST: VLAN over vlan_filtering=0 bridged port: 1588v2 over L2 transport, Follow-Up   [ OK ]
TEST: VLAN over vlan_filtering=0 bridged port: 1588v2 over L2 transport, Peer Delay Request   [ OK ]
TEST: VLAN over vlan_filtering=0 bridged port: 1588v2 over IPv4, Sync   [FAIL]
        reception failed
TEST: VLAN over vlan_filtering=0 bridged port: 1588v2 over IPv4, Follow-Up   [FAIL]
        reception failed
TEST: VLAN over vlan_filtering=0 bridged port: 1588v2 over IPv4, Peer Delay Request   [FAIL]
        reception failed
TEST: VLAN over vlan_filtering=0 bridged port: 1588v2 over IPv6, Sync   [FAIL]
        reception failed
TEST: VLAN over vlan_filtering=0 bridged port: 1588v2 over IPv6, Follow-Up   [FAIL]
        reception failed
TEST: VLAN over vlan_filtering=0 bridged port: 1588v2 over IPv6, Peer Delay Request   [FAIL]
        reception failed
TEST: VLAN over vlan_filtering=1 bridged port: Unicast IPv4 to primary MAC address   [ OK ]
TEST: VLAN over vlan_filtering=1 bridged port: Unicast IPv4 to macvlan MAC address   [ OK ]
TEST: VLAN over vlan_filtering=1 bridged port: Unicast IPv4 to unknown MAC address   [FAIL]
        reception succeeded, but should have failed
TEST: VLAN over vlan_filtering=1 bridged port: Unicast IPv4 to unknown MAC address, promisc   [ OK ]
TEST: VLAN over vlan_filtering=1 bridged port: Unicast IPv4 to unknown MAC address, allmulti   [FAIL]
        reception succeeded, but should have failed
TEST: VLAN over vlan_filtering=1 bridged port: Multicast IPv4 to joined group   [ OK ]
TEST: VLAN over vlan_filtering=1 bridged port: Multicast IPv4 to unknown group   [XFAIL]
        reception succeeded, but should have failed
TEST: VLAN over vlan_filtering=1 bridged port: Multicast IPv4 to unknown group, promisc   [ OK ]
TEST: VLAN over vlan_filtering=1 bridged port: Multicast IPv4 to unknown group, allmulti   [ OK ]
TEST: VLAN over vlan_filtering=1 bridged port: Multicast IPv6 to joined group   [ OK ]
TEST: VLAN over vlan_filtering=1 bridged port: Multicast IPv6 to unknown group   [XFAIL]
        reception succeeded, but should have failed
TEST: VLAN over vlan_filtering=1 bridged port: Multicast IPv6 to unknown group, promisc   [ OK ]
TEST: VLAN over vlan_filtering=1 bridged port: Multicast IPv6 to unknown group, allmulti   [ OK ]
TEST: VLAN over vlan_filtering=1 bridged port: 1588v2 over L2 transport, Sync   [ OK ]
TEST: VLAN over vlan_filtering=1 bridged port: 1588v2 over L2 transport, Follow-Up   [ OK ]
TEST: VLAN over vlan_filtering=1 bridged port: 1588v2 over L2 transport, Peer Delay Request   [ OK ]
TEST: VLAN over vlan_filtering=1 bridged port: 1588v2 over IPv4, Sync   [FAIL]
        reception failed
TEST: VLAN over vlan_filtering=1 bridged port: 1588v2 over IPv4, Follow-Up   [FAIL]
        reception failed
TEST: VLAN over vlan_filtering=1 bridged port: 1588v2 over IPv4, Peer Delay Request   [FAIL]
        reception failed
TEST: VLAN over vlan_filtering=1 bridged port: 1588v2 over IPv6, Sync   [FAIL]
        reception failed
TEST: VLAN over vlan_filtering=1 bridged port: 1588v2 over IPv6, Follow-Up   [FAIL]
        reception failed
TEST: VLAN over vlan_filtering=1 bridged port: 1588v2 over IPv6, Peer Delay Request   [FAIL]
        reception failed
TEST: VLAN over vlan_filtering=0 bridge: Unicast IPv4 to primary MAC address   [ OK ]
TEST: VLAN over vlan_filtering=0 bridge: Unicast IPv4 to macvlan MAC address   [ OK ]
TEST: VLAN over vlan_filtering=0 bridge: Unicast IPv4 to unknown MAC address   [ OK ]
TEST: VLAN over vlan_filtering=0 bridge: Unicast IPv4 to unknown MAC address, promisc   [ OK ]
TEST: VLAN over vlan_filtering=0 bridge: Unicast IPv4 to unknown MAC address, allmulti   [ OK ]
TEST: VLAN over vlan_filtering=0 bridge: Multicast IPv4 to joined group   [ OK ]
TEST: VLAN over vlan_filtering=0 bridge: Multicast IPv4 to unknown group   [XFAIL]
        reception succeeded, but should have failed
TEST: VLAN over vlan_filtering=0 bridge: Multicast IPv4 to unknown group, promisc   [ OK ]
TEST: VLAN over vlan_filtering=0 bridge: Multicast IPv4 to unknown group, allmulti   [ OK ]
TEST: VLAN over vlan_filtering=0 bridge: Multicast IPv6 to joined group   [ OK ]
TEST: VLAN over vlan_filtering=0 bridge: Multicast IPv6 to unknown group   [XFAIL]
        reception succeeded, but should have failed
TEST: VLAN over vlan_filtering=0 bridge: Multicast IPv6 to unknown group, promisc   [ OK ]
TEST: VLAN over vlan_filtering=0 bridge: Multicast IPv6 to unknown group, allmulti   [ OK ]
TEST: VLAN over vlan_filtering=1 bridge: Unicast IPv4 to primary MAC address   [ OK ]
TEST: VLAN over vlan_filtering=1 bridge: Unicast IPv4 to macvlan MAC address   [ OK ]
TEST: VLAN over vlan_filtering=1 bridge: Unicast IPv4 to unknown MAC address   [ OK ]
TEST: VLAN over vlan_filtering=1 bridge: Unicast IPv4 to unknown MAC address, promisc   [ OK ]
TEST: VLAN over vlan_filtering=1 bridge: Unicast IPv4 to unknown MAC address, allmulti   [ OK ]
TEST: VLAN over vlan_filtering=1 bridge: Multicast IPv4 to joined group   [ OK ]
TEST: VLAN over vlan_filtering=1 bridge: Multicast IPv4 to unknown group   [XFAIL]
        reception succeeded, but should have failed
TEST: VLAN over vlan_filtering=1 bridge: Multicast IPv4 to unknown group, promisc   [ OK ]
TEST: VLAN over vlan_filtering=1 bridge: Multicast IPv4 to unknown group, allmulti   [ OK ]
TEST: VLAN over vlan_filtering=1 bridge: Multicast IPv6 to joined group   [ OK ]
TEST: VLAN over vlan_filtering=1 bridge: Multicast IPv6 to unknown group   [XFAIL]
        reception succeeded, but should have failed
TEST: VLAN over vlan_filtering=1 bridge: Multicast IPv6 to unknown group, promisc   [ OK ]
TEST: VLAN over vlan_filtering=1 bridge: Multicast IPv6 to unknown group, allmulti   [ OK ]

Output bridge_vlan_unaware.sh
TEST: ping                                                          [ OK ]
TEST: ping6                                                         [ OK ]
TEST: FDB learning                                                  [ OK ]
TEST: Unknown unicast flood                                         [ OK ]
TEST: Unregistered multicast flood                                  [ OK ]

Output bridge_vlan_aware.sh
TEST: ping                                                          [ OK ]
TEST: ping6                                                         [ OK ]
TEST: FDB learning                                                  [ OK ]
TEST: Unknown unicast flood                                         [ OK ]
TEST: Unregistered multicast flood                                  [ OK ]
INFO: Add and delete a VLAN on bridge port lan2
TEST: ping                                                          [ OK ]
TEST: ping6                                                         [ OK ]
TEST: Externally learned FDB entry - ageing & roaming               [ OK ]
TEST: FDB entry in PVID for VLAN-tagged with other TPID             [FAIL]
        FDB entry was not learned when it should
TEST: Reception of VLAN with other TPID as untagged                 [FAIL]
        Packet was not forwarded when it should
TEST: Reception of VLAN with other TPID as untagged (no PVID)       [FAIL]
        Packet was forwarded when should not

Changes v21:
- Rebase on top of net-next
- Drop megred patch from Daniel
- Address suggestion reported by bot for MFD driver
- Drop reset for MFD driver
- Reset FDB and VLAN data on writing
- Fix not correct PCR matrix in port enable
- Add ID_EN7528 fields
- Fix MAC address learning SA_DIS
- Fix MAC address FDB read swapped
- Fix mib reset logic
- Fix AN8855 missing regfiled
- Fix AN8855 ethtool stats access
- Improve tx lpi timer for AN8855
- Improve MFD Documentation patch
Changes v20:
- Address all the typo pointed out by bot
- Make documentation schema more consistent
- Address some concern for the mfd driver from bot
- Fix some conversion problem for the generalization patch
Changes v19:
- Rebase on top of net-next
- Rework with shared function from mt7530 driver
- Add dependency for mt7530 lock
- Fix some define typo for AN8855
Changes v18:
- Fix configurting typo
- Init ret in MFD driver
Changes v17:
- Drop nvmem patch (subset merged and present in linux-next)
- Fix wrong Documentation patch for MFD
- Address reviews for MFD driver
- Rework MTK tag to slipt for Airoha name
Changes v16:
- Rebase on top of net-next
- Drop PBUS implementation (Airoha said that it's not OK to use it)
- Convert to simple mdio-regmap and split regmap
- Fix typo for some define (AND8855 -> AN8855)
Changes v15:
- Rebase on top of net-next
- Drop regmap MDIO patch (in favor of PBUS)
- Implement MDIO PBUS and rework MDIO driver/MFD
- Reimplement EEE support
- Add some check for regmap from MFD
- Move to single regmap and add comments with all findings
Changes v14:
- Move MAITAINERS entry to dedicated commit (make it easier for cross
  subsystem merge)
- Pack variables in trap function
- Add additional patch for reported difference from MTK tag
Changes v13:
- Reimplement tx_lpi OPs
- Rework mdio-regmap to internally encode/decode address
- Fix error in Documentation
- Drop ext-surge property (assume calibration with declared nvmem cell)
- Fix comments from Lee on MFD driver
- Improve print error and drop extra space in DSA driver
Changes v12:
- Update on top of net-next
- Add additional info on conver-letter about slefttests and HW limitation
- Introduce mdio-regmap generalization for multiple address
- Drop dev flags and define PHY calibration in PHY node directly
Changes v11:
- Address reviews from Christophe (spell mistake + dev_err_probe)
- Fix kconfig dependency for MFD driver (depends on MDIO_DEVICE instead of MDIO)
  (indirectly fix link error for mdio APIs)
- Fix copy-paste error for MFD driver of_table
- Fix compilation error for PHY (move NVMEM to .config)
- Drop unneeded NVMEM node from MDIO example schema (from Andrew)
- Adapt MFD example schema to MDIO reg property restrictions
Changes v10:
- Entire rework to MFD + split to MDIO, EFUSE, SWITCH separate drivers
- Drop EEE OPs (while Russell finish RFC for EEE changes)
- Use new pcs_inpand OPs
- Drop AN restart function and move to pcs_config
- Enable assisted_learning and disable CPU learn (preparation for fdb_isolation)
- Move EFUSE read in Internal PHY driver to .config to handle EPROBE_DEFER
  (needed now that NVMEM driver is register externally instead of internally to switch
   node)
Changes v9:
- Error out on using 5G speed as currently not supported
- Add missing MAC_2500FD in phylink mac_capabilities
- Add comment and improve if condition for an8855_phylink_mac_config
Changes v8:
- Add port Fast Age support
- Add support for Port Isolation
- Use correct register for Learning Disable
- Add support for Ageing Time OP
- Set default PVID to 0 by default
- Add mdb OPs
- Add port change MTU
- Fix support for Upper VLAN
Changes v7:
- Fix devm_dsa_register_switch wrong export symbol
Changes v6:
- Drop standard MIB and handle with ethtool OPs (as requested by Jakub)
- Cosmetic: use bool instead of 0 or 1
Changes v5:
- Add devm_dsa_register_switch() patch
- Add Reviewed-by tag for DT patch
Changes v4:
- Set regmap readable_table static (mute compilation warning)
- Add support for port_bridge flags (LEARNING, FLOOD)
- Reset fdb struct in fdb_dump
- Drop support_asym_pause in port_enable
- Add define for get_phy_flags
- Fix bug for port not inititially part of a bridge
  (in an8855_setup the port matrix was always cleared but
   the CPU port was never initially added)
- Disable learning and flood for user port by default
- Set CPU port to flood and learning by default
- Correctly AND force duplex and flow control in an8855_phylink_mac_link_up
- Drop RGMII from pcs_config
- Check ret in "Disable AN if not in autoneg"
- Use devm_mutex_init
- Fix typo for AN8855_PORT_CHECK_MODE
- Better define AN8855_STP_LISTENING = AN8855_STP_BLOCKING
- Fix typo in AN8855_PHY_EN_DOWN_SHIFT
- Use paged helper for PHY
- Skip calibration in config_init if priv not defined
Changes v3:
- Out of RFC
- Switch PHY code to select_page API
- Better describe masks and bits in PHY driver for ADC register
- Drop raw values and use define for mii read/write
- Switch to absolute PHY address
- Replace raw values with mask and bits for pcs_config
- Fix typo for ext-surge property name
- Drop support for relocating Switch base PHY address on the bus
Changes v2:
- Drop mutex guard patch
- Drop guard usage in DSA driver
- Use __mdiobus_write/read
- Check return condition and return errors for mii read/write
- Fix wrong logic for EEE
- Fix link_down (don't force link down with autoneg)
- Fix forcing speed on sgmii autoneg
- Better document link speed for sgmii reg
- Use standard define for sgmii reg
- Imlement nvmem support to expose switch EFUSE
- Rework PHY calibration with the use of NVMEM producer/consumer
- Update DT with new NVMEM property
- Move aneg validation for 2500-basex in pcs_config
- Move r50Ohm table and function to PHY driver

Christian Marangi (9):
  dt-bindings: net: dsa: Document support for Airoha AN8855 DSA Switch
  dt-bindings: net: Document support for AN8855 Switch Internal PHY
  dt-bindings: mfd: Document support for Airoha AN8855 Switch SoC
  mfd: an8855: Add support for Airoha AN8855 Switch
  net: phy: Add Airoha AN8855 Internal Switch Gigabit PHY
  net: dsa: tag_mtk: add Airoha variant usage of this TAG
  MAINTAINERS: add myself as maintainer for Airoha AN8855 Switch
  net: dsa: mt7530: generalize and move common function to lib module
  net: dsa: Add Airoha AN8855 5-Port Gigabit DSA Switch driver

 .../bindings/mfd/airoha,an8855.yaml           |  176 ++
 .../bindings/net/airoha,an8855-phy.yaml       |   83 +
 .../net/dsa/airoha,an8855-switch.yaml         |   86 +
 MAINTAINERS                                   |   16 +
 drivers/mfd/Kconfig                           |   13 +
 drivers/mfd/Makefile                          |    1 +
 drivers/mfd/airoha-an8855.c                   |  528 +++++
 drivers/net/dsa/Kconfig                       |   13 +
 drivers/net/dsa/Makefile                      |    2 +
 drivers/net/dsa/an8855.c                      | 1738 +++++++++++++++++
 drivers/net/dsa/an8855.h                      |  755 +++++++
 drivers/net/dsa/mt7530-lib.c                  | 1155 +++++++++++
 drivers/net/dsa/mt7530-lib.h                  |  413 ++++
 drivers/net/dsa/mt7530-mdio.c                 |    4 +
 drivers/net/dsa/mt7530-mmio.c                 |    4 +
 drivers/net/dsa/mt7530.c                      | 1368 +++----------
 drivers/net/dsa/mt7530.h                      |  256 +--
 drivers/net/phy/Kconfig                       |    6 +
 drivers/net/phy/Makefile                      |    1 +
 drivers/net/phy/air_an8855.c                  |  275 +++
 include/net/dsa.h                             |    2 +
 net/dsa/Kconfig                               |   11 +
 net/dsa/Makefile                              |    2 +-
 net/dsa/tag_mtk.c                             |   36 +-
 24 files changed, 5697 insertions(+), 1247 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mfd/airoha,an8855.yaml
 create mode 100644 Documentation/devicetree/bindings/net/airoha,an8855-phy.yaml
 create mode 100644 Documentation/devicetree/bindings/net/dsa/airoha,an8855-switch.yaml
 create mode 100644 drivers/mfd/airoha-an8855.c
 create mode 100644 drivers/net/dsa/an8855.c
 create mode 100644 drivers/net/dsa/an8855.h
 create mode 100644 drivers/net/dsa/mt7530-lib.c
 create mode 100644 drivers/net/dsa/mt7530-lib.h
 create mode 100644 drivers/net/phy/air_an8855.c

-- 
2.53.0

