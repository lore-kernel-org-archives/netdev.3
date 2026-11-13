Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794602517;
	b=ODg/VV7MwNpfWrSv3PN/WfKbo00xWYwFcbwMn3HcImZRJkKo1tsUIRy861ztc0yB6eGH
	 sBmOefSdiOpX5PMPHfoWBkPNsJFrfLTPb44yRFo4ZKUBLJhpuV8F119bYt+HV8jNbUgaX
	 jdEoXJSZcQcWO1aGmrzLnFDDMLlBZHhcAaSUlmvgop8cptiMhzz//QIKSCWLF+C2BDwze
	 bCTjBcOsOswe0lL9R30Ui20/5gP6vKnyvQ5nOZW1Mc1KN9Im50SiBRZJODEYc4MiS33cm
	 MUn7UqfMll71fopUoGDIFVRXWwRDP1RvwLGWXP4x9ggwjCWpdevX7OJ+SyfnJWPF8Hw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794602517;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Subject:From:To:Cc:
	 Date:Message-ID:In-Reply-To:References:User-Agent:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=+ycpCc/+WGN6IE3EdqBfw73uboGNGqUXn9gFvgoGme4=;
	b=q+JuTEXLPw2lxAszfoJLEOlnr6fJK8gdNMii4YmBTERt9bcSUgQ6MsVsE2eHaFnQT4Js
	 XYEueJYtcxzV3lp4PHTG0jdoDpOV6oE+BDKgubhqtInbL01K1wkm7SL1mt00+E73+yNdb
	 H43t347ZXXj6+hpZsS2vQ5g8HqAkXHSk497kBoHi2RhgsQTk39BvjM2ZDxHX0rXFK/aAv
	 ZxuFHrN7WfYNLDC+uP6bWyax8MVj4QnPoAZg1ATwHqSmtvQqVyasoPBRkMAcEiF0d3NQi
	 ldAHigAVO7QiXgyJQx68PUpXTDi1xnh29VJcfI7FyxeZcEa6+TR+okSL/1GYwAYKxeA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aFOJlyh7;
	arc=none smtp.remote-ip=209.85.216.44
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01B90606A323
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 20:41:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 01B90606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aFOJlyh7
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3b0ae87069dso1109232a91.2
        for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 12:41:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794602516; x=1795207316; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:user-agent
         :references:in-reply-to:message-id:date:cc:to:from:subject:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=+ycpCc/+WGN6IE3EdqBfw73uboGNGqUXn9gFvgoGme4=;
        b=aFOJlyh74pZHwu95GwtsPU7WypFP+qeSwJKfMbjUQbX0c0Rr87t3WniX7rn3ZpI6Y3
         xo9a2Cn3U4cvEolJVl9iuaW0sF3tfbMQNudf11oyO5IITcQLhYOpkVYuYl4wzLfuRpN+
         Zl7cr+xMbgLVaXLRHDzEPEh2Fi4VUPkKgsy30fpIn5iGw/A+rm1xBZIJpZk1Vh2k2WNB
         AxpevnsLIgISGatVRSkDQWe1ddssVrbCtFZ4JVj6lLouJ3L7oOXdWfgrmicqUGYofwAO
         B5cC0MoiwiUrPJXpaooFm/jc2d17H993JO7aMGqxh+e5guZBxZWfvTo/ZACI5g7TsfhM
         8ctg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794602516; x=1795207316;
        h=content-transfer-encoding:content-type:mime-version:user-agent
         :references:in-reply-to:message-id:date:cc:to:from:subject:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+ycpCc/+WGN6IE3EdqBfw73uboGNGqUXn9gFvgoGme4=;
        b=FZMcaezzbcNj3lro+4VuPlPTNJt0chOgn+B0pC2MMCA9nZ7Tc4vGsRraDRN9eZrWoZ
         gySJumf2Kk533/mixUo8h4RVDM21KCLx4OwvrjdlGHnsBly5YU7iBZzi2SCf9c/X3LM5
         jIGAERHNINs5Tp9R1O7DqTLo/S8ix+DTOZemPjS33xtxwyscUdsA1L6z0SlML0lhN66i
         jCQktuTlD1uv6dsosQ67rpHv2VhzMJgnxj4UjbvmNALArHDhCexnzSv87as8XBQ0i7hj
         kTN9xMU6rPaN/Uw9r8+8vLBMb3U5guTuHYfbatSI3kZEJVD7KHEyd+VSs7FMDjqgy488
         8ftA==
X-Gm-Message-State: APuU4Z+Cn3sMLOMJjFI8EqL0Pm8ZF0Q2cYzY/IE/hjEZSJqeRvl5GlS4
	9yvjPa2K5FbxwbCSxYSEr4OCwGrHwb+i4qXfxhrmpMk0DlIo2WCu3EFu
X-Gm-Gg: AYBFou1DsQMpF7J706ibnzp0G10RyBvIhEhASW7dhR5z+FOZFfWL3AMGoidkjTmvc0I
	lU4z5HrbC5eJ0IbEds/iiHQY9fuqJ3/s4AbnkXyOPA369+Sd3DFr6aCjdgtORLraWSiE1MOu7GQ
	dtoSjZPD+XmfXUk2tOLVdy2bQiYhI21shHE36sYZ26nWruqBWYNDh+k2gjIwYUi2/CTxkBRPSZR
	HsfOs+hu4tEoV9yBEYJDd3dy2rVEgICjB4yUNqAmWkpI7bQbsS7bDJPtCWjeDaxwjklnGVHzV81
	kJ9gs0hK8qeFgPFrsGqYpqPQtMNDHKdMSQRUrviyBwGIUNONPNAmDMVyM1FZQDM0ct4aBQa5TzI
	k+DxIiq3DQcKwsHaok3GHhwlPepNtaqHjvGB5TM9ZHKeC1+GOm65YpEZQIZ2+FKibpjQIwnGAkI
	eA4rEbZjiXq/XXTK5/57DzcSl1PHPjNotvaWDdDf5Geh73j74AimpRwlOgiyHc6ob25cE/Jo/8s
	N7JLl637W3gPDSKpzFi1HxPpTmr3TL78IZKNKYQAlnlqZHJ+PJQ9/3+HGKuR3b8lrWLujLNs3vn
	3ev9KB9Y0oIZGihJWBIvoPNKjsI6xpvJ1tm+IRNyddNoHcNSY8avZfgwJbyTTgtW5ffw3YttNVh
	mx4W8Rko4tqvY15+C9XuO3Gau6XE2IVLwuVbkrSmY8Gg8WA==
X-Received: by 2002:a17:90b:33cc:b0:3b0:92b2:2e74 with SMTP id 98e67ed59e1d1-3b1b0b5e516mr3035403a91.62.1794602516311;
        Fri, 13 Nov 2026 12:41:56 -0800 (PST)
Received: from ahduyck-xeon-server.home.arpa ([2605:59c1:38c:400:22f5:2de:b9c3:f27c])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cddc160a17esm1943316a12.3.2026.11.13.12.41.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 12:41:54 -0800 (PST)
Subject: [net PATCH 4/6] fbnic: Initialize and reset the HW stats before they
 can be read
From: Alexander Duyck <alexander.duyck@gmail.com>
To: netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 horms@kernel.org, kernel-team@meta.com, kuba@kernel.org, pabeni@redhat.com
Date: Fri, 13 Nov 2026 12:41:52 -0800
Message-ID: 
 <179460251204.8819.12233374584808838528.stgit@ahduyck-xeon-server.home.arpa>
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

The HW stats are kept as running totals that advance by the difference
between each counter and the value last read, so the last values have
to be captured before the first read, and rebased whenever the hardware
counters are reset. Three paths get the ordering wrong.

The fbnic_probe function creates the debugfs directory, including the
pcie_stats file, before it calls the fbnic_init_hw_stats function. A
read in that window takes the stats lock before it has been initialized,
and accumulates deltas against baselines that have not been captured.

On resume, the __fbnic_pm_attach function rebases the stats only after
it has returned early for a device in init failure mode, though such a
device still exposes the PCIe stats through debugfs. And during PCI
error recovery it runs from the resume callback, after the
__fbnic_pm_resume function has already restored MMIO access from the
slot_reset callback, so a debugfs read in between takes its delta
against the values from before the reset and the totals jump by close
to the full width of each counter.

Initialize the stats before the debugfs directory and the devlink
instance are registered. Rebase them in the __fbnic_pm_resume function,
in the same stats lock section that restores MMIO access, so no read can
see the reset counters first, ahead of its init failure check.

The issue was found by code review, and the recovery case confirmed by
hardware testing with forced AER/DPC recovery.

Fixes: 25ba596d137d ("eth: fbnic: add PCIe hardware statistics")
Fixes: 9f61eb2d185b ("eth: fbnic: add locking support for hw stats")
Fixes: 05ec5504ff69 ("fbnic: Fix service task races with ndo_stop and PM suspend")
Signed-off-by: Alexander Duyck <alexanderduyck@fb.com>
---
 drivers/net/ethernet/meta/fbnic/fbnic_hw_stats.c |   11 +++++++++--
 drivers/net/ethernet/meta/fbnic/fbnic_hw_stats.h |    1 +
 drivers/net/ethernet/meta/fbnic/fbnic_pci.c      |   16 ++++++++++------
 3 files changed, 20 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_hw_stats.c b/drivers/net/ethernet/meta/fbnic/fbnic_hw_stats.c
index 307d5e737848..966c2d0fb27a 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_hw_stats.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_hw_stats.c
@@ -547,9 +547,10 @@ static void fbnic_reset_hw_mac_stats(struct fbnic_dev *fbd,
 	mac->get_rmon_stats(fbd, true, &mac_stats->rmon);
 }
 
-void fbnic_reset_hw_stats(struct fbnic_dev *fbd)
+void __fbnic_reset_hw_stats(struct fbnic_dev *fbd)
 {
-	spin_lock(&fbd->hw_stats.lock);
+	lockdep_assert_held(&fbd->hw_stats.lock);
+
 	fbnic_reset_phy_stats(fbd, &fbd->hw_stats.phy);
 	fbnic_reset_tmi_stats(fbd, &fbd->hw_stats.tmi);
 	fbnic_reset_tti_stats(fbd, &fbd->hw_stats.tti);
@@ -558,6 +559,12 @@ void fbnic_reset_hw_stats(struct fbnic_dev *fbd)
 	fbnic_reset_hw_rxq_stats(fbd, fbd->hw_stats.hw_q);
 	fbnic_reset_pcie_stats_asic(fbd, &fbd->hw_stats.pcie);
 	fbnic_reset_hw_mac_stats(fbd, &fbd->hw_stats.mac);
+}
+
+void fbnic_reset_hw_stats(struct fbnic_dev *fbd)
+{
+	spin_lock(&fbd->hw_stats.lock);
+	__fbnic_reset_hw_stats(fbd);
 	spin_unlock(&fbd->hw_stats.lock);
 }
 
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_hw_stats.h b/drivers/net/ethernet/meta/fbnic/fbnic_hw_stats.h
index caea4be46762..5eb1e8b29ef9 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_hw_stats.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_hw_stats.h
@@ -154,6 +154,7 @@ struct fbnic_hw_stats {
 
 u64 fbnic_stat_rd64(struct fbnic_dev *fbd, u32 reg, u32 offset);
 
+void __fbnic_reset_hw_stats(struct fbnic_dev *fbd);
 void fbnic_reset_hw_stats(struct fbnic_dev *fbd);
 void fbnic_init_hw_stats(struct fbnic_dev *fbd);
 void fbnic_get_hw_q_stats(struct fbnic_dev *fbd,
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_pci.c b/drivers/net/ethernet/meta/fbnic/fbnic_pci.c
index 09ae797b1f0d..cb0191b65204 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_pci.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_pci.c
@@ -350,13 +350,13 @@ static int fbnic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	 */
 	fbnic_fw_log_enable(fbd, true);
 
+	/* Capture snapshot of hardware stats so netdev can calculate delta */
+	fbnic_init_hw_stats(fbd);
+
 	fbnic_devlink_register(fbd);
 	fbnic_devlink_otp_check(fbd, "error detected during probe");
 	fbnic_dbg_fbd_init(fbd);
 
-	/* Capture snapshot of hardware stats so netdev can calculate delta */
-	fbnic_init_hw_stats(fbd);
-
 	fbnic_hwmon_register(fbd);
 
 	if (!fbd->dsn) {
@@ -498,10 +498,16 @@ static int __fbnic_pm_resume(struct device *dev)
 	struct fbnic_net *fbn;
 	int err;
 
-	/* Restore MMIO access */
+	/* Restore MMIO access and rebase the HW stats in one step, so that
+	 * no stats read can take its delta from counters the reset cleared
+	 * against the values read before it.
+	 */
 	iomap_table = pcim_iomap_table(to_pci_dev(dev));
+	spin_lock(&fbd->hw_stats.lock);
 	fbd->uc_addr0 = iomap_table[0];
 	fbd->uc_addr4 = iomap_table[4];
+	__fbnic_reset_hw_stats(fbd);
+	spin_unlock(&fbd->hw_stats.lock);
 
 	/* Rerequest the IRQs */
 	err = fbnic_alloc_irqs(fbd);
@@ -582,8 +588,6 @@ static void __fbnic_pm_attach(struct device *dev)
 	rtnl_lock();
 	netdev_lock(netdev);
 
-	fbnic_reset_hw_stats(fbd);
-
 	if (netif_running(netdev))
 		fbnic_up(fbn);
 


