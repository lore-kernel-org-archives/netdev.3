Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D72B4AF9C7
	for <netdev@vger.kernel.org>; Wed,  2 Sep 2026 22:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788388344; cv=none; b=mv36ClbaZip2/FLls3Zx916OvbLDat91v7UikoOulnLw/1wzzlWCuCqGB249SXOJsWbizJD4+WDtQ17n338+tddARkQxpzbjzX+bc3OvcrQf/o3iZ6XL8dtQe1KCK1+lDkq3bSdHUIHBC59/IzOZeJ7DEeTKbnAAx5jYbBQ/aiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788388344; c=relaxed/simple;
	bh=g7v61cYNglVI6PxT1TNFOwhuT6dpNFg4mcEbNyCk/2g=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HXMb/hHJ13dbCIeeOoPx4OHH4eL7nTxSTO5q6cKpzR3LsWk7yoXmK6y0DYgF4KbQACSQPB3h2sEX+ahyFyu5fYgJUFYUBnwvkbh0BaUJb3a3iOsLVNCD4jIWOOkbSAQd+JV+OtxNOEAK/KwQ8NIs0dUUEakrxfAZqlzpZG3SoDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gwd/IWxd; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gwd/IWxd"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-851cbd64814so736019b3a.1
        for <netdev@vger.kernel.org>; Wed, 02 Sep 2026 15:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788388335; x=1788993135; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:user-agent
         :references:in-reply-to:message-id:date:cc:to:from:subject:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=4KyHCIy6qzejDHZIIAwKQalccbipR8g9qW9GaHyw94k=;
        b=Gwd/IWxdhqnusGMEkpu0sQCHe++O9l8AI4Q0kIsmR2nTyQJNNkqGSoCx4fo3E14uLM
         nC2KrRM9XBjemr7DBVKuMV5naVCRdGBaHj5xkrvjlSZW2exSOQv/BJRvXTh+mX2QcH6P
         12h7OkNcPX2pNxlumVCnWpTnYtMIDUWx9XJ/my24rtf9ZPs2C3dG5jUc7vEsOSo5P+jP
         ISR/goul7hwoqcoWLOQL7/RzXEHeU9z2anq6YqgpdlaqCeaZ73mlq64qq5F/nmJcqGFO
         PjpGE0Fw05TZuKIrJ6s9izFsJGaYfsLfj+gWGxDnYlRURLdj/CXyKtkHgYdPyo6i2OcF
         6liA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788388335; x=1788993135;
        h=content-transfer-encoding:content-type:mime-version:user-agent
         :references:in-reply-to:message-id:date:cc:to:from:subject:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4KyHCIy6qzejDHZIIAwKQalccbipR8g9qW9GaHyw94k=;
        b=AFSX69v/XxDBcslYGoWQ/vVKyyi/isO2Ej0iu8bd/ZB9xmDLAqjeJoOkHqSK/SHD7p
         j52l5cuxhqyJZTi5sa0Xs3G0Hj7kGOIHlyjbdArbYJMy/U0M+sPa1evhg4Nly9s+ZnVC
         L1T0ArPub3+QakFsuZv5eQyF8zTbJk3lkAfhzBGt4RdlIdm6bDttYqS4TP4MKnIvJFH0
         M/FsD8Vcpn3dhOfyCcjBNCv8Lt4eKsrNymF+BOFX8afX3FzX2CFRiBrGXdmfetFUxPAM
         nnLPOtmJQ4kOIrXIJY+ccO9Eu2pHsBKkFMWZTYdcl4v56OQ4NyZTk86aZD+z83u92PH1
         w/XA==
X-Gm-Message-State: AFuF++lEGyKqPKLk6UwdFiOVISQc3QoBxZy0rdxkcEqNSpHcx+wbF5tn
	KdlQ1BySE/138RzLK17bkMR9JqIOwUOWyFBPqZS+2PXqS9o8gN6xX+oatmIShA==
X-Gm-Gg: AYBFou0r/Lgp3CjXouh6NKXWeQSlN5OXJ2bVXVFbnFz3ZZTMr6IOkMcZc2+gp059ogJ
	5uor8Vs06+JIIgJlFXvv5DV3LQ7F58B4Q/JB0/kUBrKpah/X3TM8ObcH1vtVJDgLJ8CzP1sKpF7
	HsJtkrjWK63dg294JaX85NaHywYbbwfqjCfkcCSMw5eDnK5kA25IJOAwyUnOPYQW2VYQTfbPRSc
	M2BJTd/l6OhvzVY+908Tjthk2IkN+q+S89SedXjs8VoV+IeH/nQl6YszRjwhORIjusKU6cD8EyO
	3XXjmoklrEMqeyKNxyHeRvZ1uBRI9HfI+rfMlbs6tH/ZQ7dsbXIDEgZFb5XRhDDNNCBZYqIlyph
	NMeewT1Yi84Na4YTU2lUR87dulVzi5LwwEmnkFzBboPC46QrOWnsR3Uvd+l9FCEzUbPXhJa1Nw0
	IL0nMbSoHmwkaUpfjCuNBA3e2vtXFcyfsyEAmF0f5rJETKUOGNXkK0JiRZK7Z1GnS5ttpckLQj9
	v5hMyvyu2cOVBgs8vHsJmqQLEaMGza2xbNaRSkWaZ1MpYCKAVdbTtYAJefYDkPWmDoU8KDI/QuL
	7mJJyKm/K5eubmRnD68P
X-Received: by 2002:a05:6a00:e08:b0:82f:2b0:2809 with SMTP id d2e1a72fcca58-85ed7158030mr12113625b3a.1.1788388334797;
        Wed, 02 Sep 2026 15:32:14 -0700 (PDT)
Received: from ahduyck-xeon-server.home.arpa ([2605:59c8:829:4c00:4db7:e37c:a6be:f5bf])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-85dc0e01472sm1908634b3a.55.2026.09.02.15.32.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 15:32:14 -0700 (PDT)
Subject: [net PATCH 4/4] net: ethtool: keep rtnl_lock for the ioctl self test
From: Alexander Duyck <alexander.duyck@gmail.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 kernel-team@meta.com, Simon Horman <horms@kernel.org>
Date: Wed, 02 Sep 2026 15:32:12 -0700
Message-ID: 
 <178838833261.11136.11073590401658206367.stgit@ahduyck-xeon-server.home.arpa>
In-Reply-To: 
 <178838795612.11136.15512516427273655916.stgit@ahduyck-xeon-server.home.arpa>
References: 
 <178838795612.11136.15512516427273655916.stgit@ahduyck-xeon-server.home.arpa>
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

fbnic's offline self test brings the interface down and back up with
netif_close() / netif_open(), both of which require rtnl_lock. Since the
ethtool IOCTL path became rtnl-optional for ops-locked drivers, the
ETHTOOL_TEST ioctl runs holding only the netdev instance lock, so on an
ops-locked driver (fbnic is ops-locked via queue_mgmt_ops) the self test
now tears the device down without rtnl_lock.

With lockdep this reproduces deterministically on every offline self
test; note the sole lock held is the instance lock, not rtnl:

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

self_test is a legacy ioctl-only command, so an ETHTOOL_TEST case is
only needed on the ioctl path. Add an opt-in bit for drivers whose
self test needs rtnl_lock and set it on fbnic.

Fixes: f994752b1127 ("net: ethtool: optionally skip rtnl_lock on IOCTL path")
Signed-off-by: Alexander Duyck <alexanderduyck@fb.com>
---
 drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c |    3 ++-
 include/linux/ethtool.h                         |    2 ++
 net/ethtool/common.h                            |    2 ++
 3 files changed, 6 insertions(+), 1 deletion(-)

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
index 12683b5d125e..97a1adbd9eae 100644
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


