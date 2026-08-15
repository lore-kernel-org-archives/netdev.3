Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7537F31986C
	for <netdev@vger.kernel.org>; Sat, 15 Aug 2026 01:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786756110; cv=none; b=aggF5gK3SIfEf7SVE5HfYe9n3qecvqbkrB1fqHOS/cDFAcjA/2dAJsdIYtcuvqgpK8WRHx0gqowxSVVchsy3abqSFIKx5+dKNjtJKZBOhRIgHoW6FH9W2+5CGOEEkyrUhGomfU2jqE0oQ4Q5FOrmNMYpjMYNMeTZBGb0kuEQf1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786756110; c=relaxed/simple;
	bh=Aa3x4hIztegYvcTbIqhvp4D7IHwChEh3gYm0aBgAdNQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QJ8ZYiwUR1oZiP3OBefF85TrIXklIkqG85YufV5IsCbPVsDPeT6EqsH3VHuiOfavYBtNHQ30b1TGV+hem7SDHzZGGHyxeAldkTL70Q3/5avrZTkvO0mDF5B2PYxOBa8RQspD5EHXYqTAhyUWWckk0G6fkJRsMzN6EWGAjMtEhnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KuXqthXG; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KuXqthXG"
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-7eb1dc6bd53so1209182a34.2
        for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 18:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786756107; x=1787360907; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=2WaeFHY8Amefx+z0iRX7zRmJGE/YSFA3BET5wf4LK6c=;
        b=KuXqthXGWEPfbZWOWQETcI7FaVEIB02EYmxoospc8KemE9adbEEZy4YbZO1D7Vxu8q
         5zXPM91QzU6VkpJxMsxAfeoxi0vpqAnHST59G1bLgoKCT7W2FyEMBxjSaduG9G2QQuYf
         QZ7+bC7KrD3ObFc0wK15/FgBjNFEbMyuRHUOK8WBgCuV1igpGCNzUy1ItK3vMQnJogV4
         LyRQ0wH3mavqlq+dUUBc1WXjtdI0m1VERvcgTqJbyrnS6yBuieDfvGT/01ZDH/zWx+lX
         J63HcYH6WerZ52IN5Y2lrXSLnvf4EP4N3KYH38223UhZLcX/Hq/Zf7TeL9FnEcQxhF3P
         KRuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786756107; x=1787360907;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2WaeFHY8Amefx+z0iRX7zRmJGE/YSFA3BET5wf4LK6c=;
        b=kPr5+nEs61kp/8im+Ovlseb2rT/mqbNHI+mEavKQ3GcC2IuA67uoHv3priJyKJJpSu
         gXjposCzJmABqiItfbx5nqu9EJUvUgWeGySqKxRcpOXRjXeWcszVfOko47bgcSBc+cRl
         z3lM8d8pW4ZEGYBVzefD5baWGh38CA6Gmm9K/MsDV5UFzfjw6icwQYrxdW09udj2muGZ
         uUDfsoq+zCVTix3iaKlMvrRJLCa7g22oxBdd737Fp0bR7nmbmz1QTl34YKpVn3X5lTzP
         Z4rpbMTyNyI0/Ie5Siq71pVy/8SuVpeZVcse7SHFTAsP9uwPAoje73k281Cs0rZf7/K5
         etjw==
X-Gm-Message-State: AOJu0YwhQ+WfEvibkBD9ne+W3XkmszV/O1oaeaoPQtVg7P3UgItgM7J+
	qptrOG7HBSexITdch/+u2tAHsBHNPLJz+LkcUv7CKSi2q5auLLELpIpq
X-Gm-Gg: AR+sD130QtBtueZBzSolLNvP85swTEE82uqDfERLYkRAwEpyWQwbccvxwlUwKsmK18M
	W/FQPt/do9CW4kWZu9uFElodo//ojLrusV5yGhcxC1ELemsNPbZaYFLyK/L0ovH1dxCMdy/n9Cv
	g/BKfh/5S7pokd7mRjXTd2OVfjUwCjHBsXhpmdwGgVjoQ6N6g/7BD0zJW/Lpj9l+Riv3CjvVWAb
	mAQPDJg0SukQD3qVDul+3plNjARNZ8Lx3ktswIwrWS/PjQtDChglx+zm1skrfQR/lw0FUXAdqKQ
	7oxplJSeICYi0ekM8utu1KhnDJ5KMeCHHo5IoeIcA7nrrXKihWREZCWuo64fSiOtv2VMBYx0bNu
	D6X5yfDLJ3F/BRqJf4e/EbzwAdqU2bfx1xpb01BHO4XnJHW6gn3Q3daihAbo0LFDZFRt/LKl0Tu
	TPCj7hsFKy/BR5I75oscqfZvCR8TXo6ztyq/oz3ncjI0xkqQeGbAevYG8ixDRWlTP4ypwQwRBVm
	FIh0K6QH+GKsyu/2Qa6/hJJHu2sTgg=
X-Received: by 2002:a05:6830:3813:b0:7e9:d3aa:e391 with SMTP id 46e09a7af769-7f3de4ea83dmr9379236a34.6.1786756107331;
        Fri, 14 Aug 2026 18:08:27 -0700 (PDT)
Received: from shiv-machina.. (174-16-201-18.hlrn.qwest.net. [174.16.201.18])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f3e869f65fsm2320947a34.26.2026.08.14.18.08.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 18:08:26 -0700 (PDT)
From: Shivani Gupta <shivani07g@gmail.com>
To: intel-wired-lan@lists.osuosl.org,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Alessio Igor Bogani <alessio.bogani@elettra.eu>
Subject: [PATCH iwl-net] igb: Reject hwtstamp requests when PTP is unavailable
Date: Sat, 15 Aug 2026 01:08:15 +0000
Message-Id: <20260815010815.91898-1-shivani07g@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

IGB depends on PTP_1588_CLOCK_OPTIONAL, so ptp_clock_register() can
return NULL when PTP is compiled out and can fail at runtime.

Commit b888c510f7b3 ("igb: Avoid starting unnecessary workqueues")
moved the PTP locks, work items, timestamp configuration, and clock
reset behind successful clock registration. The netdev is already
registered when igb_ptp_init() runs, however, and the hwtstamp entry
points were not gated on registration. On 82576 a TX timestamp request
can therefore schedule a never-initialized ptp_tx_work.

Initialize the passive PTP state and hardware clock before registering
the PHC. INIT_WORK() and INIT_DELAYED_WORK() do not queue any work; the
overflow work is started only after registration succeeds. This also
ensures that PHC callbacks and the netdev timestamping paths never
observe partially initialized state.

Reject hwtstamp get and set requests with -EOPNOTSUPP while no PTP clock
is registered, and advertise software timestamping only in that state.
Successful registration retains the existing behavior on 82576, 82580,
i350, i354, i210, and i211. On 82575, an OFF request that was previously
accepted as a no-op now reports that hardware timestamping is
unsupported.

Reproduced with CONFIG_IGB=y and CONFIG_PTP_1588_CLOCK=n on the QEMU
82576 model: SIOCSHWTSTAMP(HWTSTAMP_TX_ON) followed by a hardware
timestamp request warned in __queue_work() before this change and
returns EOPNOTSUPP afterwards.

Fixes: b888c510f7b3 ("igb: Avoid starting unnecessary workqueues")
Signed-off-by: Shivani Gupta <shivani07g@gmail.com>
---
 drivers/net/ethernet/intel/igb/igb_ethtool.c |  9 +++++
 drivers/net/ethernet/intel/igb/igb_ptp.c     | 40 ++++++++++++++------
 2 files changed, 38 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_ethtool.c b/drivers/net/ethernet/intel/igb/igb_ethtool.c
index f7938c1da835..4ebd447117cc 100644
--- a/drivers/net/ethernet/intel/igb/igb_ethtool.c
+++ b/drivers/net/ethernet/intel/igb/igb_ethtool.c
@@ -2396,6 +2396,15 @@ static int igb_get_ts_info(struct net_device *dev,
 	case e1000_i354:
 	case e1000_i210:
 	case e1000_i211:
+		/* No PTP clock, no hardware timestamping. Advertise what
+		 * igb_ptp_hwtstamp_set() will actually accept.
+		 */
+		if (!(adapter->ptp_flags & IGB_PTP_ENABLED)) {
+			info->so_timestamping =
+				SOF_TIMESTAMPING_TX_SOFTWARE;
+			return 0;
+		}
+
 		info->so_timestamping =
 			SOF_TIMESTAMPING_TX_SOFTWARE |
 			SOF_TIMESTAMPING_TX_HARDWARE |
diff --git a/drivers/net/ethernet/intel/igb/igb_ptp.c b/drivers/net/ethernet/intel/igb/igb_ptp.c
index 638d8242b66b..01992a73b37b 100644
--- a/drivers/net/ethernet/intel/igb/igb_ptp.c
+++ b/drivers/net/ethernet/intel/igb/igb_ptp.c
@@ -1104,6 +1104,9 @@ int igb_ptp_hwtstamp_get(struct net_device *netdev,
 {
 	struct igb_adapter *adapter = netdev_priv(netdev);
 
+	if (!(adapter->ptp_flags & IGB_PTP_ENABLED))
+		return -EOPNOTSUPP;
+
 	*config = adapter->tstamp_config;
 
 	return 0;
@@ -1285,6 +1288,9 @@ int igb_ptp_hwtstamp_set(struct net_device *netdev,
 	struct igb_adapter *adapter = netdev_priv(netdev);
 	int err;
 
+	if (!(adapter->ptp_flags & IGB_PTP_ENABLED))
+		return -EOPNOTSUPP;
+
 	err = igb_ptp_set_timestamp_mode(adapter, config);
 	if (err)
 		return err;
@@ -1378,6 +1384,25 @@ void igb_ptp_init(struct igb_adapter *adapter)
 		return;
 	}
 
+	/* Initialize all state used by the PHC and timestamping paths before
+	 * registering either interface. INIT_WORK() only initializes the work
+	 * item; no work is queued until timestamping is enabled.
+	 */
+	spin_lock_init(&adapter->tmreg_lock);
+	INIT_WORK(&adapter->ptp_tx_work, igb_ptp_tx_work);
+
+	if (adapter->ptp_flags & IGB_PTP_OVERFLOW_CHECK)
+		INIT_DELAYED_WORK(&adapter->ptp_overflow_work,
+				  igb_ptp_overflow_check);
+
+	adapter->tstamp_config.rx_filter = HWTSTAMP_FILTER_NONE;
+	adapter->tstamp_config.tx_type = HWTSTAMP_TX_OFF;
+
+	/* Initialize the hardware clock before ptp_clock_register() makes its
+	 * callbacks visible. The overflow work is started after registration.
+	 */
+	igb_ptp_reset(adapter);
+
 	adapter->ptp_clock = ptp_clock_register(&adapter->ptp_caps,
 						&adapter->pdev->dev);
 	if (IS_ERR(adapter->ptp_clock)) {
@@ -1388,17 +1413,9 @@ void igb_ptp_init(struct igb_adapter *adapter)
 			 adapter->netdev->name);
 		adapter->ptp_flags |= IGB_PTP_ENABLED;
 
-		spin_lock_init(&adapter->tmreg_lock);
-		INIT_WORK(&adapter->ptp_tx_work, igb_ptp_tx_work);
-
 		if (adapter->ptp_flags & IGB_PTP_OVERFLOW_CHECK)
-			INIT_DELAYED_WORK(&adapter->ptp_overflow_work,
-					  igb_ptp_overflow_check);
-
-		adapter->tstamp_config.rx_filter = HWTSTAMP_FILTER_NONE;
-		adapter->tstamp_config.tx_type = HWTSTAMP_TX_OFF;
-
-		igb_ptp_reset(adapter);
+			schedule_delayed_work(&adapter->ptp_overflow_work,
+					      IGB_SYSTIM_OVERFLOW_PERIOD);
 	}
 }
 
@@ -1513,7 +1530,8 @@ void igb_ptp_reset(struct igb_adapter *adapter)
 
 	wrfl();
 
-	if (adapter->ptp_flags & IGB_PTP_OVERFLOW_CHECK)
+	if ((adapter->ptp_flags & IGB_PTP_ENABLED) &&
+	    (adapter->ptp_flags & IGB_PTP_OVERFLOW_CHECK))
 		schedule_delayed_work(&adapter->ptp_overflow_work,
 				      IGB_SYSTIM_OVERFLOW_PERIOD);
 }
