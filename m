Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794602508;
	b=4S2Eur+5ixowjj7v8sq5YDFTq851ivMpY1tut89o1ueL6fSiR8KWDLzLZACHK7IZGuBS
	 ZbQdza3WZY17wZ4ygJux3Zs0v+g2HOUAfynKmjxKF/GvlKhNL1t7qA8aFeTl4tH3GFIb3
	 Ezf5aGnbEr+6KduemD7yd59va9yjQP9XuKJyhpYtfst2P0kc8GlIvqceJJI5qQ3SswU1m
	 FR8dpguB2SsvKzYvKtTLlVoDMezZvHuSybshlaTUXIvCXOyeSAmtkZwtISN5CHr9on+2j
	 3yyIbZ+C67iQNW86Gt9a5FdbNKJwtudA6uHjd9xjJEx6O7yjMhC28M3hHdLXiOaQi0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794602508;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Subject:From:To:Cc:
	 Date:Message-ID:In-Reply-To:References:User-Agent:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=XFYKcNYAKxl786+CJvE8W6uCAcdD35HszmgAQI+Ryxg=;
	b=Ez8MJm4r8HhLLh41I9JsL5yPJaXP4hxAGaNZTrF2uE0fILuaJiZAbn0Q7/pnhAaeUVgd
	 GMFobxkCC+u+OrrHHwcSgYDPP8jjcDGDP3d3eAFuvToR6ZSdK6tOCDjcX/6aVFPXGmmaw
	 FXUVp5kGBOzQgdn6HR5SP1mCgxQr1AIR60R88jcya6NoOzFH5NSXinxOQxYBCRhmMOUD1
	 GWBnS2OTUv8hAcoGtitEaoV8ReBLSprXG19BZevxdbIPxFp2V57wtdO4vYrl0GLx/Y7Gb
	 +NMUNT4fE5jlubM7rAcmhho2iH7z4G2tTDrcbqfwrcehJhHveIqGnFtji+Fw4WgJT1w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=svAmgVSK;
	arc=none smtp.remote-ip=209.85.214.174
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA1FF606A33E
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 20:41:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BA1FF606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=svAmgVSK
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2ed1b9e8f43so9401055ad.1
        for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 12:41:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794602507; x=1795207307; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:user-agent
         :references:in-reply-to:message-id:date:cc:to:from:subject:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=XFYKcNYAKxl786+CJvE8W6uCAcdD35HszmgAQI+Ryxg=;
        b=svAmgVSKDYPTjJNOcSImjNaIFivBvYoE6U8oTIOWfUzwN7w8ccH4aLQLr6xiS0cazs
         IEN0zN599WeSmYxsm+I7EaaeHpVCB9Zr1IyrhmDqidA9peAU4D8DydDSV45DYGjY1UZR
         yK84DP+WRBkamukqmO5IooA9YOny5LGidoBqOO2IDYEB17dnbx/ffNZmkBx+J9vxzyVy
         zKy0opDCCAi57tIqu9Be+jq+MjNFzxXGZK1QEdhUNsas+48j5o1QkGUDO7LOPv0PC7t0
         YoxXC0NvRTj2gs4X0XGLEKET5l7PK8UmkZUI5GM/4TMtB/zNePS6T/kWGvf+x+QK2dr7
         2KVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794602507; x=1795207307;
        h=content-transfer-encoding:content-type:mime-version:user-agent
         :references:in-reply-to:message-id:date:cc:to:from:subject:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XFYKcNYAKxl786+CJvE8W6uCAcdD35HszmgAQI+Ryxg=;
        b=rPLqNBVl29YUmYHrsi40OzrSokaPBTNGXoe+iCHDITXU6appRYp3zhLYAKk4C5SdrA
         de9Ryu+b5P5UJOpfzTLSdxf8CmuPdVWL6RpHp1htkVHoROshjfDfepTmGcR5GedSWXrx
         tZCcoWDArrNo4f+s6FeI+Tp4Ko2udgwmmBIIlpwIqK1DppoakpRQUK2OzzV17Ib0qqHt
         KNrXLBoMjkjb6xF1T2n5lnIncBJpYAwyUZjIzhHdMIi0zxv1F3ncw0xjSKn5juYuP47o
         M2iAIyfYKRfRUQ1a4pWX2MSUA6dyfkiQsxKStxIznENqI6AWq5sXzFbHZNWYSKbaDnoL
         k96Q==
X-Gm-Message-State: APuU4Z8UORwovhIBtXQfBiu5nnm/xTiOzazsdTi8TJBVXRap62PNWsGF
	Du2YxTawLzvcmxjIsQsz9F16Ao5Gwf6iqQcggHFB3NCd2Z1B6vLsiFjW
X-Gm-Gg: AYBFou2UnIGhwYbd1VaZHn2we9u87JXm9GiVMFXJb4mU6n4U/rDz2zVQnys5OkZKiIw
	zitRJkFaTNT51kjMBqm43YVecY8mqAEjXHEiti/GKY1tyblOZeduqYrJlErmNy8G3vp/X8aQ7Cf
	wZhOyFgsjVCWd9b8kJiqIXBlhpvLoElA9QpVJ/wmq3CmnODYimrJC0+hU+RIC9rDeNewnVvfViu
	yrKd9vq9rVTMEompdLhsIznSLoAEyk299gHpz7bRXm81nYp795ZzsgJRea5qeIji+955vA9C68g
	8oWRrLC2tz+Nr5nVSlIBynp/TDOz/JJg9djD3pwekwzMAwDYWH5DEqam9rhnFVKBzvMhB7a3OQt
	LKbcsLSHxuydm9WFC8JVUKP4/dLVTtLuZHbR56EL8IGeZmQRy5e15g/wypWZuhJVW9TudPu7l6L
	0t1KADXRof8pV5PHL4d4GT0KTqb29PA/fu2xtjsLcDxLE2J1wRp39N1cdWVb1KZ3OG0m/AQ4sWe
	XpyxCJrlS1bFbjxMovuodlkXLrwlf5IB+cq6RJTNgypTAnL5o8c0xCFRchR1LSMx/awXScms/FY
	FJO0uSb8rvr7VMDTYRynoTP4h5Mf1Le7pZHI84r0uOJtLJV/mqFF5uio8xDe6yyw/IKX68hDNCO
	MGpIKmrFImvLKAUY3jEBizwZHUlpodoDTBa7s/4PRhiHojg==
X-Received: by 2002:a17:902:db05:b0:2ed:18cc:d3b3 with SMTP id d9443c01a7336-2ee0da33623mr34132975ad.6.1794602506870;
        Fri, 13 Nov 2026 12:41:46 -0800 (PST)
Received: from ahduyck-xeon-server.home.arpa ([2605:59c1:38c:400:22f5:2de:b9c3:f27c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ee0f4ad50dsm15109905ad.7.2026.11.13.12.41.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 12:41:45 -0800 (PST)
Subject: [net PATCH 3/6] fbnic: Cover all of the HW stats with the stats lock
From: Alexander Duyck <alexander.duyck@gmail.com>
To: netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 horms@kernel.org, kernel-team@meta.com, kuba@kernel.org, pabeni@redhat.com
Date: Fri, 13 Nov 2026 12:41:43 -0800
Message-ID: 
 <179460250360.8819.2203630667210523871.stgit@ahduyck-xeon-server.home.arpa>
In-Reply-To: 
 <179460241885.8819.7179935130629202331.stgit@ahduyck-xeon-server.home.arpa>
References: 
 <179460241885.8819.7179935130629202331.stgit@ahduyck-xeon-server.home.arpa>
User-Agent: StGit/1.5
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Alexander Duyck <alexanderduyck@fb.com>

The hw_stats lock covers the PHY, TMI, TTI, RPC, RXB, queue and PCIe
stats, but the MAC stats are left to RTNL: the fbnic_reset_hw_stats
function resets them outside the lock and asserts RTNL, on the grounds
that the ethtool API is their only other user and holds RTNL. That is no
longer the case. ethtool only takes RTNL on the Netlink path for the
operations a driver lists in op_needs_rtnl, and fbnic lists only the
pause getter among the stats ones, so the eth-mac, eth-ctrl and rmon
getters update the MAC stats with only the netdev instance lock held,
racing each other and the reset.

Take the stats lock around the MAC stats updates in those getters and in
the reset, and drop the RTNL assertion. Take it in the pause getter as
well: it still runs under RTNL, but that no longer serializes it against
the reset once the reset does not rely on RTNL. The PCIe stats debugfs
read never needed RTNL, as the fbnic_get_hw_stats function updates those
stats under the stats lock, so drop it there too. The values are printed
from their 64-bit fields without the lock, as the counters keep changing
during the read anyway.

The issue was found by code review.

Fixes: 45079e00133e ("net: ethtool: optionally skip rtnl_lock on Netlink path for GET ops")
Signed-off-by: Alexander Duyck <alexanderduyck@fb.com>
---
 drivers/net/ethernet/meta/fbnic/fbnic_debugfs.c  |    3 ---
 drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c  |    8 ++++++++
 drivers/net/ethernet/meta/fbnic/fbnic_hw_stats.c |   13 +------------
 3 files changed, 9 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_debugfs.c b/drivers/net/ethernet/meta/fbnic/fbnic_debugfs.c
index f9e879be254d..65bea571c0cc 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_debugfs.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_debugfs.c
@@ -3,7 +3,6 @@
 
 #include <linux/debugfs.h>
 #include <linux/pci.h>
-#include <linux/rtnetlink.h>
 #include <linux/seq_file.h>
 
 #include "fbnic.h"
@@ -607,7 +606,6 @@ static int fbnic_dbg_pcie_stats_show(struct seq_file *s, void *v)
 {
 	struct fbnic_dev *fbd = s->private;
 
-	rtnl_lock();
 	fbnic_get_hw_stats(fbd);
 
 	seq_printf(s, "ob_rd_tlp: %llu\n", fbd->hw_stats.pcie.ob_rd_tlp.value);
@@ -626,7 +624,6 @@ static int fbnic_dbg_pcie_stats_show(struct seq_file *s, void *v)
 		   fbd->hw_stats.pcie.ob_rd_no_cpl_cred.value);
 	seq_printf(s, "ob_rd_no_np_cred: %llu\n",
 		   fbd->hw_stats.pcie.ob_rd_no_np_cred.value);
-	rtnl_unlock();
 
 	return 0;
 }
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c b/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
index e774740fcb5d..b300017b53d4 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
@@ -1867,12 +1867,14 @@ fbnic_get_pause_stats(struct net_device *netdev,
 
 	mac_stats = &fbd->hw_stats.mac;
 
+	spin_lock(&fbd->hw_stats.lock);
 	fbd->mac->get_pause_stats(fbd, false, &mac_stats->pause);
 
 	pause_stats->tx_pause_frames = mac_stats->pause.tx_pause_frames.value;
 	pause_stats->rx_pause_frames = mac_stats->pause.rx_pause_frames.value;
 	tx_ps_events = mac_stats->pause.tx_pause_storm_events.value;
 	pause_stats->tx_pause_storm_events = tx_ps_events;
+	spin_unlock(&fbd->hw_stats.lock);
 }
 
 static void
@@ -1928,6 +1930,7 @@ fbnic_get_eth_mac_stats(struct net_device *netdev,
 	mac_stats = &fbd->hw_stats.mac;
 	mac = fbd->mac;
 
+	spin_lock(&fbd->hw_stats.lock);
 	mac->get_eth_mac_stats(fbd, false, &mac_stats->eth_mac);
 
 	fbnic_set_counter(&eth_mac_stats->FramesTransmittedOK,
@@ -1956,6 +1959,7 @@ fbnic_get_eth_mac_stats(struct net_device *netdev,
 			  &mac_stats->eth_mac.BroadcastFramesReceivedOK);
 	fbnic_set_counter(&eth_mac_stats->FrameTooLongErrors,
 			  &mac_stats->eth_mac.FrameTooLongErrors);
+	spin_unlock(&fbd->hw_stats.lock);
 }
 
 static void
@@ -1968,12 +1972,14 @@ fbnic_get_eth_ctrl_stats(struct net_device *netdev,
 
 	mac_stats = &fbd->hw_stats.mac;
 
+	spin_lock(&fbd->hw_stats.lock);
 	fbd->mac->get_eth_ctrl_stats(fbd, false, &mac_stats->eth_ctrl);
 
 	eth_ctrl_stats->MACControlFramesReceived =
 		mac_stats->eth_ctrl.MACControlFramesReceived.value;
 	eth_ctrl_stats->MACControlFramesTransmitted =
 		mac_stats->eth_ctrl.MACControlFramesTransmitted.value;
+	spin_unlock(&fbd->hw_stats.lock);
 }
 
 static const struct ethtool_rmon_hist_range fbnic_rmon_ranges[] = {
@@ -2003,6 +2009,7 @@ fbnic_get_rmon_stats(struct net_device *netdev,
 
 	mac_stats = &fbd->hw_stats.mac;
 
+	spin_lock(&fbd->hw_stats.lock);
 	fbd->mac->get_rmon_stats(fbd, false, &mac_stats->rmon);
 
 	rmon_stats->undersize_pkts =
@@ -2018,6 +2025,7 @@ fbnic_get_rmon_stats(struct net_device *netdev,
 		rmon_stats->hist[i] = mac_stats->rmon.hist[i].value;
 		rmon_stats->hist_tx[i] = mac_stats->rmon.hist_tx[i].value;
 	}
+	spin_unlock(&fbd->hw_stats.lock);
 
 	*ranges = fbnic_rmon_ranges;
 }
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_hw_stats.c b/drivers/net/ethernet/meta/fbnic/fbnic_hw_stats.c
index 8084a63dd807..307d5e737848 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_hw_stats.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_hw_stats.c
@@ -1,8 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (c) Meta Platforms, Inc. and affiliates. */
 
-#include <linux/rtnetlink.h>
-
 #include "fbnic.h"
 
 static void fbnic_hw_stat_rst32(struct fbnic_dev *fbd, u32 reg,
@@ -559,17 +557,8 @@ void fbnic_reset_hw_stats(struct fbnic_dev *fbd)
 	fbnic_reset_rxb_stats(fbd, &fbd->hw_stats.rxb);
 	fbnic_reset_hw_rxq_stats(fbd, fbd->hw_stats.hw_q);
 	fbnic_reset_pcie_stats_asic(fbd, &fbd->hw_stats.pcie);
-	spin_unlock(&fbd->hw_stats.lock);
-
-	/* Once registered, the only other access to MAC stats is via the
-	 * ethtool API which is protected by the rtnl_lock. The call to
-	 * fbnic_reset_hw_stats() during PCI recovery is also protected
-	 * by the rtnl_lock hence, we don't need the spinlock to access
-	 * the MAC stats.
-	 */
-	if (fbd->netdev)
-		ASSERT_RTNL();
 	fbnic_reset_hw_mac_stats(fbd, &fbd->hw_stats.mac);
+	spin_unlock(&fbd->hw_stats.lock);
 }
 
 void fbnic_init_hw_stats(struct fbnic_dev *fbd)


