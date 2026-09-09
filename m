Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52E363AFCF8
	for <netdev@vger.kernel.org>; Wed,  9 Sep 2026 19:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788981104; cv=none; b=QHZ31HQcHHf+96SBoGbX7FyRjPRGoc4HT/LvXgW65BVMGF7zlQaiJkxOx04p8pnlVeabGR/aXaJxb95bTtcPXw6Kf/ndrqLM/bkk3WqyVXqT4VxOpLsZ6MTN/clzGAECeE3+GHxzsBJX14TPvB81g20/HafCiyHbh7DzJ5cXBjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788981104; c=relaxed/simple;
	bh=OLqZ4XpsDKfL+rYQCWWILVLCJUhEXvHE/LDQG4VAFDY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=AeAxC8xTwwBS3RI6XewxR7zEFkWaaJ/Zs2QB1xJ3O0HCOEbmUIia/KBejPdVUJbA10FdhvnA4r+JTuzoI5DCzIPDM40jSCkxPY2gB2+jdwJHJG58wX6EIcsl/flipEZ6tYEcsn8jj4Er4Bs5CTp2URySlQsBNOaKL0FxiZ+3jOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uZAOa8jH; arc=none smtp.client-ip=209.85.215.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uZAOa8jH"
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cc4ac5feaa4so515275a12.1
        for <netdev@vger.kernel.org>; Wed, 09 Sep 2026 12:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788981101; x=1789585901; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=C8GvnE9AyTB5PxOdeDn+W37MXQjUGp/yhAttw8TGSh0=;
        b=uZAOa8jHCvc1tse49hTInJfbTDEn66XYHHrQYmqO02Yy30Jb+aSjjR5VHJlRh7d7gv
         nESdMxXTtYljKeNFJy9AwGNgwOsJidoE76v5lf7rzPL8wTtvYIWZlxo+vUfF6ZKHHz74
         nzCYRUTgQ3K/ipafRGBypm9UVJj0xFEzo5MYs47eCkDmxu1H3v2kZtZyZV3kEz9rJt25
         8HHp3C1P4AJIFJKYell10922v91IegAYZiFVNxpIOqtwtXIT1qOdVjuBJE5+D7KP88Mb
         zkZHbaBXx6ZIIp8pw9uqRhrLLIfsR3Fi4hyVRhf1ImUIR4r7vdv4eiKE9NZv4VWrDSmA
         U7+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788981101; x=1789585901;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=C8GvnE9AyTB5PxOdeDn+W37MXQjUGp/yhAttw8TGSh0=;
        b=ngfpC5gCNTIE24fUUYKDQ1U8DQOVrLKXRwlqOT91zaGfTofhrDqVKC9qOXfBvKwg8+
         2oZUsGcZSL5yrXXU16Ft46xgZ+TTxvZCYggjbiL5yPzGoP0RDJxVSP8LNcz8Lq7uWzIa
         RUAKtl8JoP2jX77jCfy81FS7aG1iWlnUqfJc5jKaJdVYWp2Ev6NE1i9aP0xCMuwTZM52
         q+OXEyK/t6IunQqJ7tqhtRbwoDYlJIVP8nec4683rf/J3tZ8pixKobn2tY9JfAig1i2D
         w5kKkHK3CZzgvUrDfpGDlEluxLaF+adB+pEt9Xj9XDWgyPHbZCFcC8bhOW68RNUsa1f3
         JmVw==
X-Gm-Message-State: AFuF++ms7Oor3rpizs2kq5ZvdJXnE1KHuBJmHNYdIto0LClHCZMYVrQk
	tprvUE2KrSdizDZqQD48H8fPzo/BtY2xGzth5he6nFa5MFyz/SJSRZsHtm42fuhr+YQrbUwVs/s
	X2SY9H898tsv3qbJ+zthSx3IKO+9//CQgEZcCBanXe6q9VVuyOtmV7tHUCTr+AQhd7eAN8PhZB+
	ozsGs+O6cldaEUngnLKVFl0MWTEfnpK7xSFGd8jKm3mtYcuERD38oufy/36HDPwwE=
X-Received: from pghf4.prod.google.com ([2002:a63:e304:0:b0:cc4:56ea:7ae7])
 (user=hramamurthy job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:339a:b0:3d3:adad:f171 with SMTP id adf61e73a8af0-3dabb2435bbmr13084975637.19.1788981100707;
 Wed, 09 Sep 2026 12:11:40 -0700 (PDT)
Date: Wed,  9 Sep 2026 19:11:27 +0000
In-Reply-To: <20260909191136.3811892-1-hramamurthy@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260909191136.3811892-1-hramamurthy@google.com>
X-Mailer: git-send-email 2.55.0.1003.g10538fe699-goog
Message-ID: <20260909191136.3811892-5-hramamurthy@google.com>
Subject: [PATCH net-next v6 04/12] gve: introduce gve_adminq_get_device_properties()
From: Harshitha Ramamurthy <hramamurthy@google.com>
To: netdev@vger.kernel.org
Cc: joshwash@google.com, hramamurthy@google.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org, 
	john.fastabend@gmail.com, sdf@fomichev.me, jordanrhee@google.com, 
	willemb@google.com, nktgrg@google.com, maolson@google.com, thostet@google.com, 
	jacob.e.keller@intel.com, debarghyak@google.com, kees@kernel.org, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	przemyslaw.kitszel@intel.com
Content-Type: text/plain; charset="UTF-8"

Introduce gve_adminq_get_device_properties() which executes the first
two Adminq commands: VERIFY_DRIVER_COMPATIBILITY and DESCRIBE_DEVICE
so that this can be called during initialization.

Move these to Adminq specific files. This is just code movement, no
functional change.

Reviewed-by: Willem de Bruijn <willemb@google.com>
Reviewed-by: Jordan Rhee <jordanrhee@google.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Harshitha Ramamurthy <hramamurthy@google.com>
---
v5:
- Place the utsname.h and version.h header files only where needed
- drop uneccessary __maybe_unused (Sashiko)

v3:
- move patch down so that the function is introduced just before usage
- mark function as maybe_unused
- update commit message

 drivers/net/ethernet/google/gve/gve_adminq.c | 68 ++++++++++++++++++--
 drivers/net/ethernet/google/gve/gve_adminq.h |  5 +-
 drivers/net/ethernet/google/gve/gve_main.c   | 47 +-------------
 3 files changed, 65 insertions(+), 55 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve_adminq.c b/drivers/net/ethernet/google/gve/gve_adminq.c
index 046155ae7d66..f420a8e1dd3d 100644
--- a/drivers/net/ethernet/google/gve/gve_adminq.c
+++ b/drivers/net/ethernet/google/gve/gve_adminq.c
@@ -6,6 +6,8 @@
 
 #include <linux/etherdevice.h>
 #include <linux/pci.h>
+#include <linux/utsname.h>
+#include <linux/version.h>
 #include "gve.h"
 #include "gve_adminq.h"
 #include "gve_register.h"
@@ -1143,6 +1145,27 @@ int gve_adminq_describe_device(struct gve_priv *priv)
 	return err;
 }
 
+int gve_adminq_get_device_properties(struct gve_priv *priv)
+{
+	int err;
+
+	err = gve_adminq_verify_driver_compatibility(priv);
+	if (err) {
+		dev_err(&priv->pdev->dev,
+			"Could not verify driver compatibility: err=%d\n", err);
+		return err;
+	}
+
+	/* Get the initial information we need from the device */
+	err = gve_adminq_describe_device(priv);
+	if (err) {
+		dev_err(&priv->pdev->dev,
+			"Could not get device information: err=%d\n", err);
+		return err;
+	}
+	return 0;
+}
+
 int gve_adminq_register_page_list(struct gve_priv *priv,
 				  struct gve_queue_page_list *qpl)
 {
@@ -1205,20 +1228,53 @@ int gve_adminq_report_stats(struct gve_priv *priv, u64 stats_report_len,
 	return gve_adminq_execute_cmd(priv, &cmd);
 }
 
-int gve_adminq_verify_driver_compatibility(struct gve_priv *priv,
-					   u64 driver_info_len,
-					   dma_addr_t driver_info_addr)
+int gve_adminq_verify_driver_compatibility(struct gve_priv *priv)
 {
+	struct gve_driver_info *driver_info;
 	union gve_adminq_command cmd;
+	dma_addr_t driver_info_bus;
+	int err;
+
+	driver_info = dma_alloc_coherent(&priv->pdev->dev,
+					 sizeof(struct gve_driver_info),
+					 &driver_info_bus, GFP_KERNEL);
+	if (!driver_info)
+		return -ENOMEM;
+
+	*driver_info = (struct gve_driver_info) {
+		.os_type = 1, /* Linux */
+		.os_version_major = cpu_to_be32(LINUX_VERSION_MAJOR),
+		.os_version_minor = cpu_to_be32(LINUX_VERSION_SUBLEVEL),
+		.os_version_sub = cpu_to_be32(LINUX_VERSION_PATCHLEVEL),
+		.driver_capability_flags = {
+			cpu_to_be64(GVE_DRIVER_CAPABILITY_FLAGS1),
+			cpu_to_be64(GVE_DRIVER_CAPABILITY_FLAGS2),
+			cpu_to_be64(GVE_DRIVER_CAPABILITY_FLAGS3),
+			cpu_to_be64(GVE_DRIVER_CAPABILITY_FLAGS4),
+		},
+	};
+	strscpy(driver_info->os_version_str1, utsname()->release,
+		sizeof(driver_info->os_version_str1));
+	strscpy(driver_info->os_version_str2, utsname()->version,
+		sizeof(driver_info->os_version_str2));
 
 	memset(&cmd, 0, sizeof(cmd));
 	cmd.opcode = cpu_to_be32(GVE_ADMINQ_VERIFY_DRIVER_COMPATIBILITY);
 	cmd.verify_driver_compatibility = (struct gve_adminq_verify_driver_compatibility) {
-		.driver_info_len = cpu_to_be64(driver_info_len),
-		.driver_info_addr = cpu_to_be64(driver_info_addr),
+		.driver_info_len = cpu_to_be64(sizeof(struct gve_driver_info)),
+		.driver_info_addr = cpu_to_be64(driver_info_bus),
 	};
 
-	return gve_adminq_execute_cmd(priv, &cmd);
+	err = gve_adminq_execute_cmd(priv, &cmd);
+
+	/* It's ok if the device doesn't support this */
+	if (err == -EOPNOTSUPP)
+		err = 0;
+
+	dma_free_coherent(&priv->pdev->dev,
+			  sizeof(struct gve_driver_info),
+			  driver_info, driver_info_bus);
+	return err;
 }
 
 int gve_adminq_report_link_speed(struct gve_priv *priv)
diff --git a/drivers/net/ethernet/google/gve/gve_adminq.h b/drivers/net/ethernet/google/gve/gve_adminq.h
index ed3504853908..2ab68c822e22 100644
--- a/drivers/net/ethernet/google/gve/gve_adminq.h
+++ b/drivers/net/ethernet/google/gve/gve_adminq.h
@@ -640,9 +640,8 @@ int gve_adminq_register_page_list(struct gve_priv *priv,
 int gve_adminq_unregister_page_list(struct gve_priv *priv, u32 page_list_id);
 int gve_adminq_report_stats(struct gve_priv *priv, u64 stats_report_len,
 			    dma_addr_t stats_report_addr, u64 interval);
-int gve_adminq_verify_driver_compatibility(struct gve_priv *priv,
-					   u64 driver_info_len,
-					   dma_addr_t driver_info_addr);
+int gve_adminq_verify_driver_compatibility(struct gve_priv *priv);
+int gve_adminq_get_device_properties(struct gve_priv *priv);
 int gve_adminq_report_link_speed(struct gve_priv *priv);
 int gve_adminq_add_flow_rule(struct gve_priv *priv, struct gve_adminq_flow_rule *rule, u32 loc);
 int gve_adminq_del_flow_rule(struct gve_priv *priv, u32 loc);
diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
index da53c1fb6afb..addfd8dc1a1a 100644
--- a/drivers/net/ethernet/google/gve/gve_main.c
+++ b/drivers/net/ethernet/google/gve/gve_main.c
@@ -17,8 +17,6 @@
 #include <linux/sched.h>
 #include <linux/timer.h>
 #include <linux/workqueue.h>
-#include <linux/utsname.h>
-#include <linux/version.h>
 #include <net/netdev_queues.h>
 #include <net/sch_generic.h>
 #include <net/xdp_sock_drv.h>
@@ -41,49 +39,6 @@ char gve_driver_name[] = "gve";
 const char gve_version_str[] = GVE_VERSION;
 static const char gve_version_prefix[] = GVE_VERSION_PREFIX;
 
-static int gve_verify_driver_compatibility(struct gve_priv *priv)
-{
-	int err;
-	struct gve_driver_info *driver_info;
-	dma_addr_t driver_info_bus;
-
-	driver_info = dma_alloc_coherent(&priv->pdev->dev,
-					 sizeof(struct gve_driver_info),
-					 &driver_info_bus, GFP_KERNEL);
-	if (!driver_info)
-		return -ENOMEM;
-
-	*driver_info = (struct gve_driver_info) {
-		.os_type = 1, /* Linux */
-		.os_version_major = cpu_to_be32(LINUX_VERSION_MAJOR),
-		.os_version_minor = cpu_to_be32(LINUX_VERSION_SUBLEVEL),
-		.os_version_sub = cpu_to_be32(LINUX_VERSION_PATCHLEVEL),
-		.driver_capability_flags = {
-			cpu_to_be64(GVE_DRIVER_CAPABILITY_FLAGS1),
-			cpu_to_be64(GVE_DRIVER_CAPABILITY_FLAGS2),
-			cpu_to_be64(GVE_DRIVER_CAPABILITY_FLAGS3),
-			cpu_to_be64(GVE_DRIVER_CAPABILITY_FLAGS4),
-		},
-	};
-	strscpy(driver_info->os_version_str1, utsname()->release,
-		sizeof(driver_info->os_version_str1));
-	strscpy(driver_info->os_version_str2, utsname()->version,
-		sizeof(driver_info->os_version_str2));
-
-	err = gve_adminq_verify_driver_compatibility(priv,
-						     sizeof(struct gve_driver_info),
-						     driver_info_bus);
-
-	/* It's ok if the device doesn't support this */
-	if (err == -EOPNOTSUPP)
-		err = 0;
-
-	dma_free_coherent(&priv->pdev->dev,
-			  sizeof(struct gve_driver_info),
-			  driver_info, driver_info_bus);
-	return err;
-}
-
 static netdev_features_t gve_features_check(struct sk_buff *skb,
 					    struct net_device *dev,
 					    netdev_features_t features)
@@ -2480,7 +2435,7 @@ static int gve_init_priv(struct gve_priv *priv, bool skip_describe_device)
 		return err;
 	}
 
-	err = gve_verify_driver_compatibility(priv);
+	err = gve_adminq_verify_driver_compatibility(priv);
 	if (err) {
 		dev_err(&priv->pdev->dev,
 			"Could not verify driver compatibility: err=%d\n", err);
-- 
2.55.0.979.g7e5102b832-goog

