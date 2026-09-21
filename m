Received: from rcdn-iport-5.cisco.com (rcdn-iport-5.cisco.com [173.37.86.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25F9D3D88F5;
	Mon, 21 Sep 2026 20:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.37.86.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790020891; cv=none; b=polN/J6df6TbPoWZ3bUJLGaNSzsmA4Gc+KNY0em7SyVQVnMsvTgMuFIylULWLcKUESSuZ7xeMcxR/0vaNuwBXyLAx4w5aIELnteZlcwRw8o+8xMTNSEpi/fffAwX/95U2ZDE8K7jh8AAMSg5qVyEfllaMUjZvgXKEbEafBbSdrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790020891; c=relaxed/simple;
	bh=1IbCnn5ExMs1u3paqE8e5LFnVmYSitrHG+7sl4Bq+3E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MpRBixnGrZLh0ZG7MI99goTahqTdYKyUCvj0W4jaoq+wSWTtGiAiFJtrlOFgFmSy4exVsOtmlGgOcEcOppA3xTigWxtYxJx7YMJeUrPvBiZTMOy9PU3LodzedrG83vZU8YSu5FS4liTRq0FLLGt8u6XNR5wwNdQdhQ6gJaO5zAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (2048-bit key) header.d=cisco.com header.i=@cisco.com header.b=b8w/w7uk; arc=none smtp.client-ip=173.37.86.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cisco.com header.i=@cisco.com header.b="b8w/w7uk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=2408; q=dns/txt;
  s=iport01; t=1790020890; x=1791230490;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=J8PIC4Sls3ICIho+s3ExQIvvAHAm1YM1y599LQa8IOM=;
  b=b8w/w7ukpSMM2Mg/DSjEgYILribwA5cSBK5vCaZqesTtKGXn/HsVMLI7
   e/26h6sd7dmiyycabn69kcFZu2AvIEpTglDvxBoYpBe3WWeYlBgWK53Dk
   3lw9ccuA5lRQKGllMmpHO69dE86Wil0W4eUspGIDDCBQ3YA0r2HuQF1uw
   sCVd8QXnQ4cm12pDdVqIIDAo76j+1lWMbxdRwfHJKEvmICcaJ5L2SjBo/
   woU+93nm69Yqn+KDlSmboCrIvMeoim0Ctp2jLflSIKcxn1OPCmH2mKADX
   LoAYKNvJL7kpIrZRH5Ao5nyc4we1OZC/iKkSnAhFNFx10D7Bb40aQ/eMp
   Q==;
X-CSE-ConnectionGUID: ZPVFOrqYRziyUxsXGou5Rw==
X-CSE-MsgGUID: F8oFZYD7RYCIAnMbFh33Hg==
X-IPAS-Result: =?us-ascii?q?A0BGAgCvi7Fq/47/Ja1aglmCGD+BVUNJhFePUoIhmECFX?=
 =?us-ascii?q?hSBag8BAQEPUQQBAYUFAo4HAiY0CQ4BAgQDAgMBAQEBAQEBAQEBAQEKAQEFA?=
 =?us-ascii?q?QEBAgEHBYEOE4ZckBMCAQMjVhAlAiYCAkYQBgESgwKCdQPFeHqBMoEBhH7ZS?=
 =?us-ascii?q?oFoAQsUAYEKLoVxgm0BgXCECDuEQScbgUlEgRWDaYQqg3SCagSDHBKUWgk/g?=
 =?us-ascii?q?QIcA1ksAVUTDQoLBwVhUjMDIAoLEhIYFQIUHRIPBBYyHXAMJxIsFy9YGwYFg?=
 =?us-ascii?q?R18FAQTghojGTZ6gQlegSspYAEQF4EHgggCglSBfwIBSUMOB0VTCSdBChJHK?=
 =?us-ascii?q?SIIEgkBExowC4EnGA1IESw3Bg8ZBD0BbgePXh+CSgIQFnklWoEUHTiTHSWDW?=
 =?us-ascii?q?Y1fa4E1n1qEKIFmoBAzhASTY5MGLodmkHQjgjaiAYRpgWg8gVkzGggbFYMiU?=
 =?us-ascii?q?xkPji4WgRQBAZIHAbx7JzI+AQcCBw8CgXORfgEB?=
IronPort-Data: A9a23:8wrAL6BfFTKcTRVW//viw5YqxClBgxIJ4kV8jS/XYbTApDtxgjJUx
 2MfXG2Pb/qJM2H2fdtxPNm+o01VvMCEm9BrOVdlrnsFo1CmBibm6XV1Cm+qYkt+++WaFBoPA
 /02M4eGcYZsCCCM/n9BC5C5xVFkz6aEW7HgP+DNPyF1VGdMRTwo4f5Zs7ZRbrVA357jXGthh
 fuo+5eBYA7/gmYuWo4pw/vrRC1H7ayaVAww5jTSVdgT1HfCmn8cCo4oJK3ZBxPQXolOE+emc
 P3Ixbe/83mx109F5gSNy+uTnuUiG9Y+DCDW4pZkc/HKbitq+kTe5p0G2M80Mi+7vdkmc+dZk
 72hvbToIesg0zaldO41C3G0GAkmVUFKFSOuzXWX6aSuI0P6n3TE8c1QImYsJLwi6OdmPHFVx
 dMfNW03cUXW7w626OrTpuhEnM8vKozveYgYoHwllWyfBvc9SpeFSKLPjTNa9G5v3YYVQrCEO
 pdfMGY1BPjDS0Un1lM/E5sinfyohXnXeDxDo1XTrq0yi4TW5FErjuGyb4uPJrRmQ+17zkG2l
 FPqoF7IKTAzMvmV5zreqVKj07qncSTTHdh6+KeD3vJjnlCW7mAaFhATUVy1vb+/h1LWc99TN
 kkd6Ccyhac180OvQ5/2WBjQiH6DpBsHc9ldCes37EeK0KW8ywWEDGEsTTNbbtEi8sgsSlQC3
 1mFhd72RjpirLGYV1qZ67GS6ziyUQANJGUPYy4sVwYJ49D/5oo0i3rnStdlDb7wjdDvHzz06
 y6FoTJ4hLgJi8MPkaKh8jjvhT+wqpXXZhA66x+RXW+/6A59Iom/aOSVBUPz9/1MKsOdC1KGp
 nVBw5XY5+EVBpbLnyuIKAkQIIyUCz++GGW0qTZS81MJrlxBJ1bLkVhs3QxD
IronPort-HdrOrdr: A9a23:drM86K+IjT8L6CPw1Yhuk+AuI+orL9Y04lQ7vn2ZhyYlFvBw8P
 rOoB1773HJYVkqNU3I9errBEDEewK/yXcX2+Ys1MmZPDUO0VHAROpfBMnZsl7d8kbFmtK1u5
 0QFpRWOZncAUd3iMDi7BL9MdoxqeP3iZyAtKPyw2hgSAdyZ7ol1Qd2DQ6HDlZ7LTM2Y6bRbK
 DsgfZvln6HZWkdaNi9Cz0uWujOoMCOqbfdCCR2fyLOLGK1/EmVAHmQKWni4isj
X-Talos-CUID: 9a23:MQZRam2Qef3QEi2OPszOCbxfKPgbXFrH1UbqMU6pNHZyeJKSVAKq5/Yx
X-Talos-MUID: 9a23:RrdaNQqyb7M+W/XLh2cezx8yM+la0ojxMnEmsLwAnsOqNXcrGzjI2Q==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.27,115,1787011200"; 
   d="scan'208";a="526177924"
Received: from rcdn-l-core-05.cisco.com ([173.37.255.142])
  by rcdn-iport-5.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 21 Sep 2026 20:00:22 +0000
Received: from [127.0.0.1] (unknown [10.25.128.208])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by rcdn-l-core-05.cisco.com (Postfix) with ESMTPS id 76FC11800035F;
	Mon, 21 Sep 2026 20:00:21 +0000 (GMT)
From: Satish Kharat <satishkh@cisco.com>
Date: Mon, 21 Sep 2026 12:59:44 -0700
Subject: [PATCH net-next 1/6] net: add netif_rx_mode_schedule_fresh()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260921-b4-enic-sriov-v2-vf-receive-control-v1-1-67a0a6e08d43@cisco.com>
References: <20260921-b4-enic-sriov-v2-vf-receive-control-v1-0-67a0a6e08d43@cisco.com>
In-Reply-To: <20260921-b4-enic-sriov-v2-vf-receive-control-v1-0-67a0a6e08d43@cisco.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Satish Kharat <satishkh@cisco.com>, sebaddel@cisco.com
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790020820; l=2414;
 i=satishkh@cisco.com; h=from:subject:message-id;
 bh=1IbCnn5ExMs1u3paqE8e5LFnVmYSitrHG+7sl4Bq+3E=;
 b=Zsix0xTJfOEQYoG315riWlX/NJUX1udCnr14VobgzN6SamnTdKThKS72mVMdlR9GkpchBIiU0
 1x1rPmfqTB8DJsUdS13NLZmGF9K/lGkCkJ/DLijj+ZlbCjbF5egogk3
X-Developer-Key: i=satishkh@cisco.com; a=ed25519;
 pk=4BxbLoCGvHeIMH/PbpiNVx8/2IcTjFvqcr0AD8K6WLY=
X-Outbound-Client-TLS: ANONYMOUS;unknown [10.25.128.208];TLSv1.3;TLS_AES_256_GCM_SHA384;256
X-Outbound-SMTP-Client: 10.25.128.208, [10.25.128.208]
X-Outbound-Node: rcdn-l-core-05.cisco.com

Add a receive-mode scheduling helper for callers that need to replay
the complete configuration after a state transition.

Cancel a pending retry before queueing the immediate update
so stale retry timers cannot consume the new operation's retry
budget. Resetting the backoff also gives the fresh replay its full
bounded retry sequence.

Assisted-by: LLM
Signed-off-by: Satish Kharat <satishkh@cisco.com>
---
 include/linux/netdevice.h |  1 +
 net/core/dev_addr_lists.c | 21 +++++++++++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 5d16737167ee..2246be72d811 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -5197,6 +5197,7 @@ static inline void __dev_mc_unsync(struct net_device *dev,
 
 /* Functions used for secondary unicast and multicast support */
 void dev_set_rx_mode(struct net_device *dev);
+void netif_rx_mode_schedule_fresh(struct net_device *dev);
 void netif_rx_mode_schedule_retry(struct net_device *dev);
 int netif_set_promiscuity(struct net_device *dev, int inc);
 int dev_set_promiscuity(struct net_device *dev, int inc);
diff --git a/net/core/dev_addr_lists.c b/net/core/dev_addr_lists.c
index 08528ca0a8b3..4ae0510ce91f 100644
--- a/net/core/dev_addr_lists.c
+++ b/net/core/dev_addr_lists.c
@@ -1337,6 +1337,27 @@ static void netif_rx_mode_queue(struct net_device *dev)
 	__netdev_work_core_sched(dev, NETDEV_WORK_RX_MODE);
 }
 
+/**
+ * netif_rx_mode_schedule_fresh() - schedule a fresh receive-mode update
+ * @dev: network device
+ *
+ * Cancel any pending retry and reset its backoff budget before scheduling an
+ * immediate receive-mode update. Callers use this after a state transition
+ * which requires the complete receive configuration to be replayed, rather
+ * than after a failed update (which uses netif_rx_mode_schedule_retry()).
+ *
+ * Context: sleepable. The caller must hold the device operations lock, or
+ * RTNL for a device which still uses RTNL-compatible operations.
+ */
+void netif_rx_mode_schedule_fresh(struct net_device *dev)
+{
+	might_sleep();
+	netdev_assert_locked_ops_compat(dev);
+	netif_rx_mode_cancel_retry(dev);
+	netif_rx_mode_queue(dev);
+}
+EXPORT_SYMBOL_GPL(netif_rx_mode_schedule_fresh);
+
 static void netif_rx_mode_retry(struct timer_list *t)
 {
 	struct net_device *dev =

-- 
2.43.0

