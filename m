Received: from mail-wr2-f34.google.com (mail-wr2-f34.google.com [74.125.225.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 569A336A022
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 18:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790618478; cv=none; b=JrCl8Hz3GyIvG5hREuuZF++oXwRCdEk4whrBTd8ZkKzYBljZ/O2pY52m36jzB//Ap1E8UQr/U6+g/TY1G8Q4qxqDv3qwzP97sra8F++4hfiiYqmekBq3Sz+5GJ4TFxtUcLbZ9qs1gA39SFHm7gPPYMexIdk8z6oemOBVDZhWz0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790618478; c=relaxed/simple;
	bh=V19N/8O0C40MZ4z+aeCO5wsjib+tdxPhTdrZCeAA7J8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=a+sEUxZhmLiFcb5ZF60C8/fgoplFQFZaJgjbtfy6dhLZ3Q8ehT5bKcPcyDfAHQbdD+zZ8uVzb4zTGl5r1CMYOADSm/wpeqQEYw85jCowluG9dbSr+4Z5lroUxJQ0uBhPo2s2fHY9/Gc0iUMxrFkWEj0WDak6GARuy1FWjBf3Kh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C8BjK5ZR; arc=none smtp.client-ip=74.125.225.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C8BjK5ZR"
Received: by mail-wr2-f34.google.com with SMTP id ffacd0b85a97d-48af0753c56so19221f8f.0
        for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 11:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790618474; x=1791223274; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fM70ruQDLDPWJkBQ4QIaKuZLG0MEnM9WE3Ur/EG+81g=;
        b=C8BjK5ZRzMyWF8K8ojRdJb+6GWf6JiIoOdNuj3MiOgBOekzEMg4RuEhSm4IemMwd82
         A5JRDsuMsNP/UzfJri/5kVR1DHwb/qjoFFYzxSjO7/b4DxsLHJbEc2K5amka7xO2eEMR
         PNWYP6JHQJqI1zzDJ4l/SQc3aSa+Q2ecnLWX/aJmGDQB2cwO92XQbtl+Kb4vlIq+7867
         MdpdUeE3zBco6+7BUH/CT9BTU7nozB2HE4j5Yz7M+ODTCX/sV0jo9tGZq2Mf3N30CUFC
         kBqajB7tCFop1TnxEGo1t5MG2KGzYcHAXzXkFCcyxbSRuxLqHIXD1ffYJkaWKVAyzZgd
         FiEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790618474; x=1791223274;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fM70ruQDLDPWJkBQ4QIaKuZLG0MEnM9WE3Ur/EG+81g=;
        b=jcGWCatf+1fnvCg9stHLgwfsRDVlex5lz6IUbDM2HGe0ghxPyzGHJRI+D+tQRiq/Kq
         JeW7Q6LmlC8GLcgBol6ISFRYXLBH6l6mMNtDuXM6O8IX6mIdGiKIwbcAs8NI1LQJN7oS
         Zd2NYOg7LIDJBPcAUwJcyeOCS23q1/fD7EKCmHIjqYH/+X86ZHBzN3sUFH7WsBGylLsz
         5SmtqBoyO2LVO99WUGhqYZYRuQyT0v4mdhzMEig4v5YO5CZOJimU4ELenZH19VsrnNHR
         yuBcVuplyipXqKbDOH86f2VBC/mu07zKjNmLbn0BXNwtec/O76IbWzUV8d5a4TzozLwK
         yJhA==
X-Gm-Message-State: AFuF++lqGPIubbDSQT4B2HCHOOEPUxrbYNDuRGPDhtsZg6lrhlRPG9xn
	tKrb4zZPCWXI8hY7mCCmIr9I5zxiKDfImWW1xwug+q/dMJoT4eT9a6d8
X-Gm-Gg: AYBFou3tGQPV2+xniZhGSKgSkWBHNWjCNrFHcYoiutv/kJNDoVcMtW8D0j/Db+cyduF
	fQfxWECIUELRfMuWkBRRdIFTMw9ToS7s8ykfzFBMOZcd45CwKKbBhETedS7aDkJ9qVN+/txZ9lf
	PpuY585qm2rgjpAD452PShgkTUnMdrnU2cKq0BUjPIUQ/qK60Rx0ZqSTKNv4Exa9m0kjG+q7snO
	ubGnseSbWqoZjjRXeTfNYODBilP0NSzmcfewXEQ963fia/nLBkrIbIig0fowAKj75AxOwCzoy01
	fszWu9woCOOMmIspPabOGpJecd21VZSteMHBIRkcfPWtY8fNN7ceDnTIKKG5dvUszn2iEOfAbFj
	KC156ik6JGI71Eoma4XHj/D0tCoM0jGZna6SzH8k6qXwbcIz+/3fKKnZOAhecHiaI4yoT0moWdU
	BGwtT9Bq3vg8g8kx7FCObbEaF1gFKyx5TfBn2TRrbTiqF4qt5fhKxzRZ5I2R34GJg=
X-Received: by 2002:a05:600c:6819:b0:49e:6806:5712 with SMTP id 5b1f17b1804b1-49feddcb5dcmr185608755e9.2.1790618474174;
        Mon, 28 Sep 2026 11:01:14 -0700 (PDT)
Received: from localhost ([2620:10d:c092:500::5:c231])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a00cf9dfdbsm15758645e9.1.2026.09.28.11.01.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 11:01:13 -0700 (PDT)
From: Gustavo Luiz Duarte <gustavold@gmail.com>
Date: Mon, 28 Sep 2026 19:00:06 +0100
Subject: [PATCH net-next 4/4] netconsole: remove unnecessary target
 refcounting from the netdev notifier
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260928-netcons-fixes-v1-4-bb5ffe5e698a@gmail.com>
References: <20260928-netcons-fixes-v1-0-bb5ffe5e698a@gmail.com>
In-Reply-To: <20260928-netcons-fixes-v1-0-bb5ffe5e698a@gmail.com>
To: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Matt Mackall <mpm@selenic.com>, 
 =?utf-8?q?Bruno_Pr=C3=A9mont?= <bonbons@linux-vserver.org>, 
 Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Gustavo Luiz Duarte <gustavold@gmail.com>
X-Mailer: b4 0.15.2

Since netconsole_netdev_event() holds target_list_lock, there is no need
to also protect each target with netconsole_target_get/put()
refcounting. There is no way a target reachable from the target_list
would go away while we hold target_list_lock.

This is similar to commit a6d403ac9689 ("netconsole: remove unnecessary
netconsole_target_get/out() from write_msg()").

Since this is the only remaining user of netconsole_target_get/put(),
remove those helpers as well.

Signed-off-by: Gustavo Luiz Duarte <gustavold@gmail.com>
---
 drivers/net/netconsole.c | 31 -------------------------------
 1 file changed, 31 deletions(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index 627475f16383..6c938e37b2f3 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -262,23 +262,6 @@ static void __exit dynamic_netconsole_exit(void)
 	configfs_unregister_subsystem(&netconsole_subsys);
 }
 
-/*
- * Targets that were created by parsing the boot/module option string
- * do not exist in the configfs hierarchy (and have NULL names) and will
- * never go away, so make these a no-op for them.
- */
-static void netconsole_target_get(struct netconsole_target *nt)
-{
-	if (config_item_name(&nt->group.cg_item))
-		config_group_get(&nt->group);
-}
-
-static void netconsole_target_put(struct netconsole_target *nt)
-{
-	if (config_item_name(&nt->group.cg_item))
-		config_group_put(&nt->group);
-}
-
 static void dynamic_netconsole_mutex_lock(void)
 {
 	mutex_lock(&dynamic_netconsole_mutex);
@@ -300,18 +283,6 @@ static void __exit dynamic_netconsole_exit(void)
 {
 }
 
-/*
- * No danger of targets going away from under us when dynamic
- * reconfigurability is off.
- */
-static void netconsole_target_get(struct netconsole_target *nt)
-{
-}
-
-static void netconsole_target_put(struct netconsole_target *nt)
-{
-}
-
 static void populate_configfs_item(struct netconsole_target *nt,
 				   int cmdline_count)
 {
@@ -1982,7 +1953,6 @@ static int netconsole_netdev_event(struct notifier_block *this,
 	mutex_lock(&target_cleanup_list_lock);
 	spin_lock_irqsave(&target_list_lock, flags);
 	list_for_each_entry_safe(nt, tmp, &target_list, list) {
-		netconsole_target_get(nt);
 		if (nt->np.dev == dev) {
 			switch (event) {
 			case NETDEV_CHANGENAME:
@@ -2012,7 +1982,6 @@ static int netconsole_netdev_event(struct notifier_block *this,
 			 * notifier.
 			 */
 			queue_work(netconsole_wq, &nt->resume_wq);
-		netconsole_target_put(nt);
 	}
 	spin_unlock_irqrestore(&target_list_lock, flags);
 	mutex_unlock(&target_cleanup_list_lock);

-- 
2.55.0

