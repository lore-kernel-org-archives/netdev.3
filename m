Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D25C49F117
	for <netdev@vger.kernel.org>; Mon, 14 Sep 2026 21:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789420206; cv=none; b=qOgwIBV6FMmS0IFmqaUyEsx/Wl5CfIFjNKr0cZotsIDgPfiIBVbWe7dyJZQ7ivm1sn488TuXcsSUYsczVBfrHWdQQyQXpsHYfKr+gHRQ/SzzI68sx9sDzCsdqSQR8qdWULLhH2aGbQGLepnCYQa0fT1uhDc12ovrqJITnGd3sAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789420206; c=relaxed/simple;
	bh=6kcwNHAEgJiVBOqsWW/sYEomLpZOEfAEH6B2kVQA07g=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YqBrImaoVP77TAOOOGNvrzArICDAh0S7nhhdEY3FXYMEXtcPzYt0VJsJ1c3/Qv1DL6RdEApDUgqG+Hx8Ot9QODjYdwt2/YqeTo6ctSzyNSwaH7onXDy7SL1uldLrWdwObiwIcYBQ5A8PqQkSLanCxKQcyvdEYQHUpzD7Pr+makw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oLMWD8xR; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oLMWD8xR"
Received: by mail-pz2-f12.google.com with SMTP id 41be03b00d2f7-cc1cebad4aeso2279727a12.2
        for <netdev@vger.kernel.org>; Mon, 14 Sep 2026 14:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789420199; x=1790024999; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:user-agent
         :references:in-reply-to:message-id:date:cc:to:from:subject:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=mIhlMgUOo6mtSLB5bQfkwKIcWs6/DWIg7f7Q5MfPfXM=;
        b=oLMWD8xRy0Mf+m6lD6U0vU3c/JPfOPeAjBGImT5GX81sIjUk148LmuGb7DgChI7tg8
         WMlG81if5aPum8r088RadE85fuGOHqrp+de8EjzNUrKCkQtHwrr9Bbur8YSuCMn1XwVO
         43kiW7yYlFdJnkgC/aAcEbsYpFBOJSZ5cRAUVxnGXIhyoYZ/1EkmpbHCiYwlQrCvx395
         pmp2Nbcp5IpEzO/L9NpmJNu82TMwLHhLzco7l2iwxsSbbUJ6Q36NvVUgklBFoBIerxxA
         RvGLSy97mW3swPt86MUVbw3jldrvOD8NC0aopauIdzv5tJrZPAQ6MO9M4Vb6xpS3xgF4
         LH1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789420199; x=1790024999;
        h=content-transfer-encoding:content-type:mime-version:user-agent
         :references:in-reply-to:message-id:date:cc:to:from:subject:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mIhlMgUOo6mtSLB5bQfkwKIcWs6/DWIg7f7Q5MfPfXM=;
        b=fOY38Rlf3sXWfTK3pRkGTBqe4a64nxzRxaHfp6ZPokXjVU0N9AEUB8fe8FtXmwd+iQ
         UTYynvqSB6FF/lHAJFPcxRLy80nSM+3HRfcUJt5HROPkKvdXdDQ0CJdOyyahPniv7mzA
         zhW7eZGyuheETBujCmt8/9PzfweIS6DO+JnsEEoxAanO2zctEy7Yw2qjB4ZGmhJi4SlY
         6QUKUYrUJe0pkqVohGPUa8Sfu9H9PAiAFhTWoQo4nKrYQY2A2misxOhn/wyEDnsaepid
         8V1mUQV7HAidxBF9SJ7uid8fS4U/CPomUMp7+/KgcIDEHkRVU0xrjlOYnZRu6zhIh+kB
         gL7Q==
X-Gm-Message-State: AFuF++msOolnGR5W/FJJpwMKDiQkZrgbUHmp/yKz8YXEiQl+s72vs7TH
	spdHlbBnu7nGTWHEwbAqJVEl9k4HPLCd6PVuth+0/nNurhU9Ttl3CiyU
X-Gm-Gg: AYBFou3gSWbylINO/TjzZXhezT4sFJPDvBnmD7PgnMw9j5Xjb4C5A5c94hf4O8ufdg9
	MpqCpMEQNqoYibRPALYSev2Hf+D/qPdjbr8hVCX/5Rk8zGuo4LA6n4tffL/aaMVt4y8epkXOjOv
	MpzizXqZaz5ZR5ypEaUWOwYf5zLtLmGGt7//8FhLcAsONBDJ5/Xhj+ZqzBFi/wvD+9w1ayq2jp5
	lUE3h7DSsArhwp5hHnmnQowHZIvIoWnByxca8wLL/m9+BKb+Js1dYIDsg/Pt5EAmuy4o2tfTyAi
	zTbFsU5bcpZex476mIkaRkq3pf39h1Tn4G0YUo0xjhZxuJKzug7r0YM603yKZOH4ebkNSwhWm3U
	4SiHMhbTYVX7/GnktOvThKqrVnR5090XumlZw706xok75P+dW5EUj/nQKnHTnDdc6gGsMaB643C
	MvOELH6BROsw3i1So126iF6iNZN91iXFW/ue30zus6/hivAub0m6dWNI0JPGqV7aO8x3BJjs3fi
	d8Ul8yT7A4Bdt+KcBkrqqPKbJv2yBBUZ0egLOXY2UwgKQsPVsQFA1vYkBMh+oIbMRdPbsIRwQhY
	UIAavULOsERQ+jzmQBk=
X-Received: by 2002:a17:90b:3c07:b0:39d:efb1:cadc with SMTP id 98e67ed59e1d1-39defb1d256mr8689781a91.2.1789420199370;
        Mon, 14 Sep 2026 14:09:59 -0700 (PDT)
Received: from ahduyck-xeon-server.home.arpa ([2605:59c8:829:4c00:d680:cb2f:f831:8497])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39dfdacba6bsm1163064a91.14.2026.09.14.14.09.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 14:09:58 -0700 (PDT)
Subject: [net PATCH v2 1/6] net: ethtool: keep rtnl_lock for the ioctl self
 test
From: Alexander Duyck <alexander.duyck@gmail.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 kernel-team@meta.com, Simon Horman <horms@kernel.org>
Date: Mon, 14 Sep 2026 14:09:57 -0700
Message-ID: 
 <178942019771.7700.338431553546884773.stgit@ahduyck-xeon-server.home.arpa>
In-Reply-To: 
 <178941996343.7700.9376081102002673062.stgit@ahduyck-xeon-server.home.arpa>
References: 
 <178941996343.7700.9376081102002673062.stgit@ahduyck-xeon-server.home.arpa>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Alexander Duyck <alexanderduyck@fb.com>

An offline self test that brings the interface down and back up with
netif_close() / netif_open() requires rtnl_lock for both. Since the
ethtool IOCTL path became rtnl-optional for ops-locked drivers, the
ETHTOOL_TEST ioctl runs holding only the netdev instance lock, so on an
ops-locked driver the self test now tears the device down without
rtnl_lock.

With lockdep this reproduces deterministically on every offline self
test on such a driver; note the sole lock held is the instance lock, not
rtnl:

  WARNING: suspicious RCU usage
  net/core/netpoll.c:207 suspicious rcu_dereference_protected() usage!
  1 lock held by ethtool/107:
   #0: (&dev->lock){+.+.}, at: dev_ethtool
  Call Trace:
   netpoll_poll_disable
   __dev_close_many
   netif_close_many
   netif_close
   fbnic_self_test
   dev_ethtool_locked
   dev_ethtool
   dev_ioctl
   sock_ioctl
   __x64_sys_ioctl

Without lockdep the same condition trips ASSERT_RTNL() in
__dev_close_many() / __dev_open(); that check only samples the global
rtnl state, so it can be masked by a concurrent rtnl holder, but the
device is still being reconfigured without the lock it requires.

The ethtool self_test is a legacy ioctl-only command, so an ETHTOOL_TEST
case is only needed on the ioctl path. Add an opt-in bit for drivers whose
self test needs rtnl_lock and set it on the ops-locked drivers whose
offline self test tears the interface down and up:

  - fbnic (ops-locked via queue_mgmt_ops): fbnic_self_test() offline path
    uses netif_close() / netif_open().
  - bnxt (ops-locked via queue_mgmt_ops): bnxt_self_test() offline path
    goes through bnxt_close_nic() / bnxt_half_open_nic() /
    bnxt_half_close_nic() / bnxt_open_nic(), which close and reopen the
    device.

Fixes: f994752b1127 ("net: ethtool: optionally skip rtnl_lock on IOCTL path")
Signed-off-by: Alexander Duyck <alexanderduyck@fb.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c |    3 ++-
 drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c   |    3 ++-
 include/linux/ethtool.h                           |    2 ++
 net/ethtool/common.h                              |    2 ++
 4 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
index 62bc9cae613c..622e89587e5d 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
@@ -5733,7 +5733,8 @@ const struct ethtool_ops bnxt_ethtool_ops = {
 	.op_needs_rtnl			= ETHTOOL_OP_NEEDS_RTNL_SCHANNELS |
 					  ETHTOOL_OP_NEEDS_RTNL_SRINGPARAM |
 					  ETHTOOL_OP_NEEDS_RTNL_SCOALESCE |
-					  ETHTOOL_OP_NEEDS_RTNL_RSS,
+					  ETHTOOL_OP_NEEDS_RTNL_RSS |
+					  ETHTOOL_OP_NEEDS_RTNL_TEST,
 	.supported_coalesce_params = ETHTOOL_COALESCE_USECS |
 				     ETHTOOL_COALESCE_MAX_FRAMES |
 				     ETHTOOL_COALESCE_USECS_IRQ |
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c b/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
index 0e47088ec44b..423f179c9d47 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
@@ -2025,7 +2025,8 @@ static const struct ethtool_ops fbnic_ethtool_ops = {
 					  ETHTOOL_OP_NEEDS_RTNL_SPAUSEPARAM |
 					  ETHTOOL_OP_NEEDS_RTNL_SCHANNELS |
 					  ETHTOOL_OP_NEEDS_RTNL_SRINGPARAM |
-					  ETHTOOL_OP_NEEDS_RTNL_GLINK,
+					  ETHTOOL_OP_NEEDS_RTNL_GLINK |
+					  ETHTOOL_OP_NEEDS_RTNL_TEST,
 	.get_drvinfo			= fbnic_get_drvinfo,
 	.get_regs_len			= fbnic_get_regs_len,
 	.get_regs			= fbnic_get_regs,
diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
index 253600c0eccd..c4c9ce038611 100644
--- a/include/linux/ethtool.h
+++ b/include/linux/ethtool.h
@@ -944,6 +944,7 @@ struct kernel_ethtool_ts_info {
 #define ETHTOOL_OP_NEEDS_RTNL_SPAUSEPARAM	BIT(6)
 #define ETHTOOL_OP_NEEDS_RTNL_RSS		BIT(7)
 #define ETHTOOL_OP_NEEDS_RTNL_GLINK		BIT(8)
+#define ETHTOOL_OP_NEEDS_RTNL_TEST		BIT(9)
 
 /**
  * struct ethtool_ops - optional netdev operations
@@ -981,6 +982,7 @@ struct kernel_ethtool_ts_info {
  *	 - netdev_update_features()
  *	 - netif_set_real_num_tx_queues()
  *	 - ethtool_op_get_link() (syncs link watch under rtnl_lock)
+ *	 - netif_open() / netif_close() (used by @self_test)
  *
  * @get_drvinfo: Report driver/device information. Modern drivers no
  *	longer have to implement this callback. Most fields are
diff --git a/net/ethtool/common.h b/net/ethtool/common.h
index 4e5356e26f40..ae32e7fdb563 100644
--- a/net/ethtool/common.h
+++ b/net/ethtool/common.h
@@ -163,6 +163,8 @@ ethtool_ioctl_needs_rtnl(const struct net_device *dev, u32 ethcmd)
 		return ops->op_needs_rtnl & ETHTOOL_OP_NEEDS_RTNL_RSS;
 	case ETHTOOL_GLINK:
 		return ops->op_needs_rtnl & ETHTOOL_OP_NEEDS_RTNL_GLINK;
+	case ETHTOOL_TEST:
+		return ops->op_needs_rtnl & ETHTOOL_OP_NEEDS_RTNL_TEST;
 	}
 	return false;
 }


