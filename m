Received: from mail-108-mta188.mxroute.com (mail-108-mta188.mxroute.com [136.175.108.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC1091DD0EF
	for <netdev@vger.kernel.org>; Wed, 26 Aug 2026 04:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.175.108.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787718920; cv=none; b=BhLb8ifyVWiMjHCx8fl9Qnx9WZNwPz/gjf6b1w/IUMRRz4zhZDbRo8m618FUWzyefLBXECHrRENc3D6oC4/0yU3I3bhVjW+trQSsV/IslYOJqH60cw7/qgkBpDbSbImOgAHVIQoaDxO4e8RTMTwHjBiYQjYiqJJVPuTS2mQ8TaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787718920; c=relaxed/simple;
	bh=ppjWMvWnwpjjCHsGiT3ie3GSioJ8Mxg4di63loirzbc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DUNJpkVnuLXeJK7Fpin9kxTL9Lnleta/sYKZ9mWBYwvjgzYo9+M6uk1Zv4k62HLgbIgM3aBY6HGXIUPTvP2zJrmvEBOky8sD+W4+WXn27ku9UU9JGtcAfQ0Ay6AwUxGkRYkWGxUk05JlF/r0fYoj9aJTe8e2bxwuB1K615++DJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wii.dev; spf=pass smtp.mailfrom=wii.dev; dkim=pass (2048-bit key) header.d=wii.dev header.i=@wii.dev header.b=aaxr33zF; arc=none smtp.client-ip=136.175.108.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wii.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wii.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wii.dev header.i=@wii.dev header.b="aaxr33zF"
Received: from filter006.mxroute.com ([136.175.111.3] filter006.mxroute.com)
 (Authenticated sender: mN4UYu2MZsgR)
 by mail-108-mta188.mxroute.com (ZoneMTA) with ESMTPSA id 1a03c5522b30001089.007
 for <netdev@vger.kernel.org>
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Wed, 26 Aug 2026 04:30:07 +0000
X-Zone-Loop: b50bbaafc5351d3ae6d7cdd7106a33d0eef56fd46e7a
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=wii.dev;
	s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:
	From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
	List-Owner:List-Archive; bh=khyyse4THAMrfiJRYpQVeWwsft6Ni//0zfK96H9UO4U=; b=a
	axr33zFtWtUmm0quhnZC5lWoMk1ZKi+1Jb5ygeGzljxLms8lvAsXMSFohnb2xUicarLvgnr3xhMwQ
	WsU+KvOxvLlNK43Q++XrEGVa0Zp44oenQIlrouboUde0GyCwvzpVWJv4mVrQtVgOl4Ow2CIhOXjHd
	b8dp31F0iq2RnfP7L8qgan8U0lxYmqugcbFTOUzkY9R3wII+zAEJpgAtnGyu23C5yiZJvTwRvoEiz
	Fkttx2pEBxpcIC2ljtlJwzr0/FGd2cU1I8Jm7tAh+Tp8p9K6MfXxQqh6X8ZlA2t1kCAGJWvjH42UC
	16L794EWpYUlh5fmIge8EOqBP1IJXx35w==;
From: Richard Patel <ripatel@wii.dev>
To: intel-wired-lan@lists.osuosl.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Steve Douthit <stephend@silicom-usa.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Richard Patel <ripatel@wii.dev>
Subject: [PATCH] ixgbe: fix MDIO bus leak when rejecting SFP module
Date: Wed, 26 Aug 2026 04:29:45 +0000
Message-ID: <20260826042945.2344686-1-ripatel@wii.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Id: ripatel@wii.dev

Plugging in an unsupported SFP module caused ixgbe NICs to get
wedged permanently.

ixgbe unregisters the netdev when rejecting an SFP transceiver as
unsupported.

  ixgbe 0000:3b:00.0: failed to initialize because an unsupported SFP+ module type was detected.
  ixgbe 0000:3b:00.0: Reload the driver after installing a supported module.
  ixgbe 0000:3b:00.0: removed PHC on enp59s0

This code path failed to unregister an MDIO bus owned by that
netdev, so when unregister_netdev() tries to tear it down
(via device_del() -> devres_release_all() -> mdiobus_free()),
it trips over the leaked registration.

  ixgbe-mdio-0000:3b:00.0: not in UNREGISTERED state
  WARNING: drivers/net/phy/mdio_bus_provider.c:711 at mdiobus_free+0x3d/0x50, CPU#21: kworker/u128:0/12

This prevents ixgbe from reloading, even after PCIe remove/rescan:

  sysfs: cannot create duplicate filename '/class/mdio_bus/ixgbe-mdio-0000:3b:00.0'

Call mdiobus_unregister() before unregistering the netdev,
like ixgbe_service_task() does after a firmware error.

Fixes: 8fa10ef01260 ("ixgbe: register a mdiobus")
Signed-off-by: Richard Patel <ripatel@wii.dev>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index f91856498eb2..fca57749218b 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -8470,6 +8470,10 @@ static void ixgbe_sfp_detection_subtask(struct ixgbe_adapter *adapter)
 			  "SFP+ module type was detected.\n");
 		e_dev_err("Reload the driver after installing a "
 			  "supported module.\n");
+		if (adapter->mii_bus) {
+			mdiobus_unregister(adapter->mii_bus);
+			adapter->mii_bus = NULL;
+		}
 		unregister_netdev(adapter->netdev);
 	}
 }
-- 
2.52.0

