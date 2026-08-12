Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3E642ED141
	for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 12:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786537891; cv=none; b=UiQKIsGAybLNbkyjZm0rwpNif7eQSGdfgsHG7q6ivMOlwMKnZMsKA3mzfnZnrV43l8UPbYLvEary9uFoK6Sv2BQ08SVH1bFCOmbbNY+KuCVnTp6EQjePnFEhuVzeZgZcqtKrTVCtEl0fKqmtv8f/7jvjWuxvlNz9LJ4eTe1fK5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786537891; c=relaxed/simple;
	bh=YrU1jeDpX2NjESFWweG/w5+KE90Ha92gmRuTxTZPEDQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nUz/6zT+fd3SMTdaH2AUrHOdEHS61nC4ETV8ZZ+Dh/pdiJthU+K6xRHvz+rC71T2uGAbftkp2XShOTCn4e9oT2sxZvbkpDF+by69aNQq6kN3qZffuZhPnPaj66VlTU2C3GOICNqbZXAGw+/W/xNFSCNXseJKtSGJ6a1dtube7m0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=smartx.com; spf=none smtp.mailfrom=smartx.com; dkim=pass (2048-bit key) header.d=smartx-com.20251104.gappssmtp.com header.i=@smartx-com.20251104.gappssmtp.com header.b=z/C8uPmt; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=smartx.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=smartx.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=smartx-com.20251104.gappssmtp.com header.i=@smartx-com.20251104.gappssmtp.com header.b="z/C8uPmt"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-38e58034d05so808295a91.2
        for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 05:31:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smartx-com.20251104.gappssmtp.com; s=20251104; t=1786537888; x=1787142688; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=llAZHY98bwUGOPpKH+Oy9y9i0REEG5pFeVFVn022z+4=;
        b=z/C8uPmtzSLCGFe4pzdEvcl9iWq5fA0Xb8oCUiXrOn67vgqof211Qs6RkHWhEfpHBZ
         VOJECV1V0behceyHMvE58HWajB4yvDieNjz/RhUwxw2dbgi1HjlIDApr+fmCaw8HQ76t
         WXZKLQEo1ukKEncjhY9pKzw21E1fPBuUfHUazxtYbGjOlsmshT3vT1wx8IPr1iDzWNJY
         0+z3kQmnRXJRMBgPI5/2VkBrNbVsvRrkU0HYQdaK199voHD7rqUsIO7srbQtJTO81hyB
         74gRiQ/5vnZamv8u65Q5Syq5WkzBfmLnUWQTVH9gslmT2nI3fI4MjH2wJ/cAWIVVdlBJ
         /ttw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786537888; x=1787142688;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=llAZHY98bwUGOPpKH+Oy9y9i0REEG5pFeVFVn022z+4=;
        b=iMEvPg5raztcv1q5EZJxhr0hj2rCgCLu+FgbX0poA9Kvf1krZert1aytITE1QQKDKI
         jB8kPHO+Y5IRw0wezEnQY7DHpxuCDTMX9pIUXqx0B+yG2J4sHu/sOPoD5UpNxaVO8Ni1
         ODYoWin70SIuI96Nvg7W1UaSqQCifsck9Vw1ROaXWtBnsoXmL77IplDGo0LOtBbcoY0R
         /H23nvDQTcX5JHFh3HldBzz5p4i4R2Dn7xJ17MDhf/cYZgef3BrfUudrvdq3VdHKA9Rw
         sxYhGxxv11eaJ/4vPDb59hqDjB+EKMT1UFhSB0bA82PzXBP70BBz94oodBw4T5A8TLZY
         n2BA==
X-Forwarded-Encrypted: i=1; AHgh+RpsxFsf3bhMqqaccanv8D5K/FAW78IFLkYnr3thzVO+iEhKPpHYoKixa97DK+ExNv+Uc58QIk4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWS1gs/AWpWdbZ2eStiHiAaLwz6A2XJjtxsGLxne2lXr/f6sA4
	OQw8FZGA7GcwSpekEKn8hXuTYvKVccTszmTA3HVrY87Ot8TjEX8d4D4oYFMH3ywDB5lV5nHBzw/
	itwmC6e+ZmzeSZ3xYVmbiT8H0I4e+oRZkNyU862cVf1IkJNsaZW8=
X-Gm-Gg: AR+sD10l7dUehlM9FBYRdhQ4qllF8iU0Q3atVwl6ReAiQsnRjnuCu+Q729gAJ7n1ZpZ
	+Mme+2vPOr6pH6WZd2utb+or7qhP9mpLExPTcaJXLY2m41xhmn81XYvXHL/pyan0ylP388/6Ptx
	4TnSl/YY2ThmjV0BQiNa58sSA5H6DLAGZdshf2Gvp5XidSGDGEESIiDpQrmd4yWz2IjEsVH4Mm3
	qW2+qTDpr3FVPeLm4XHtvD0s4sgn6HQyKIjKLkj8H7Csvmo9E8r0tpiEIbPyv9+sfafhoTbswmH
	sEex+HOBjy6tY8icQ3mdfGhGEmuJUKTfIP5muF2rfUeOZaUN06uduafX5uCkte4LorBNKnbHQTm
	kUf7oeDj6ox2eLb9ApZE8squtDWEuKg8yJ4xs0BjsRWcDg1GjAatD1Q8cis/hKFJdOOnZz5mHdH
	b0tjSeAi1IHh3aQfwMyTtlfDJDcwKE7BMOsmjupfrbLFQWOpKhLzcg70lNIbgdrSslg0VaiUG/V
	w==
X-Received: by 2002:a17:90b:2b45:b0:380:873:49cb with SMTP id 98e67ed59e1d1-39301834f69mr5641996a91.21.1786537882078;
        Wed, 12 Aug 2026 05:31:22 -0700 (PDT)
Received: from localhost.localdomain ([174.136.204.24])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14124451180sm8831608c88.1.2026.08.12.05.31.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 05:31:21 -0700 (PDT)
From: Wang Zhan <wang.zhan@smartx.com>
To: Aaron Conole <aconole@redhat.com>,
	Eelco Chaudron <echaudro@redhat.com>,
	Ilya Maximets <i.maximets@ovn.org>
Cc: keyong.sun@smartx.com,
	netdev@vger.kernel.org,
	dev@openvswitch.org,
	linux-kernel@vger.kernel.org,
	Wang Zhan <wang.zhan@smartx.com>
Subject: [PATCH net-next] openvswitch: enable ops lock for internal ports
Date: Wed, 12 Aug 2026 20:30:03 +0800
Message-ID: <20260812123003.3634034-1-wang.zhan@smartx.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Open vSwitch internal ports currently use RTNL as their ops compatibility
lock. Opt them in to netdev instance locking so eligible control operations
can be serialized per device instead of contending on the global RTNL lock.

The internal port ethtool operations implement get_drvinfo and get_link.
The latter uses ethtool_op_get_link(), which synchronizes linkwatch state
and requires RTNL. Allow get_drvinfo to run under the instance lock, but
set ETHTOOL_OP_NEEDS_RTNL_GLINK to retain RTNL for get_link.

Feature synchronization can acquire a lower device's ops lock while holding
an internal port's lock. Assign these software upper devices a distinct
lockdep class to describe the nesting.

Signed-off-by: Wang Zhan <wang.zhan@smartx.com>
---
 net/openvswitch/vport-internal_dev.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/net/openvswitch/vport-internal_dev.c b/net/openvswitch/vport-internal_dev.c
index 125d310871e93..eb2e83a3e16f1 100644
--- a/net/openvswitch/vport-internal_dev.c
+++ b/net/openvswitch/vport-internal_dev.c
@@ -11,6 +11,7 @@
 #include <linux/skbuff.h>
 
 #include <net/dst.h>
+#include <net/netdev_lock.h>
 #include <net/xfrm.h>
 #include <net/rtnetlink.h>
 
@@ -29,6 +30,12 @@ static struct internal_dev *internal_dev_priv(struct net_device *netdev)
 	return netdev_priv(netdev);
 }
 
+static int internal_dev_init(struct net_device *netdev)
+{
+	netdev_lockdep_set_classes(netdev);
+	return 0;
+}
+
 /* Called with rcu_read_lock_bh. */
 static netdev_tx_t
 internal_dev_xmit(struct sk_buff *skb, struct net_device *netdev)
@@ -69,6 +76,7 @@ static void internal_dev_getinfo(struct net_device *netdev,
 }
 
 static const struct ethtool_ops internal_dev_ethtool_ops = {
+	.op_needs_rtnl	= ETHTOOL_OP_NEEDS_RTNL_GLINK,
 	.get_drvinfo	= internal_dev_getinfo,
 	.get_link	= ethtool_op_get_link,
 };
@@ -81,6 +89,7 @@ static void internal_dev_destructor(struct net_device *dev)
 }
 
 static const struct net_device_ops internal_dev_netdev_ops = {
+	.ndo_init = internal_dev_init,
 	.ndo_open = internal_dev_open,
 	.ndo_stop = internal_dev_stop,
 	.ndo_start_xmit = internal_dev_xmit,
@@ -106,6 +115,7 @@ static void do_setup(struct net_device *netdev)
 	netdev->needs_free_netdev = true;
 	netdev->priv_destructor = NULL;
 	netdev->ethtool_ops = &internal_dev_ethtool_ops;
+	netdev->request_ops_lock = true;
 	netdev->rtnl_link_ops = &internal_dev_link_ops;
 
 	netdev->features = NETIF_F_SG | NETIF_F_FRAGLIST | NETIF_F_HIGHDMA |

base-commit: ac155a26750a595703e7dadff84735456d75a479
-- 
2.47.3

