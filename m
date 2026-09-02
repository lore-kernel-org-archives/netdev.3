Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E615E3F0A90
	for <netdev@vger.kernel.org>; Wed,  2 Sep 2026 22:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788388325; cv=none; b=MFs9ydh9eOq5XEz4exXwG/KCfpThTU7AmC/YebtuNZOUXx8zPnT52cZnguHDikdY8lb+yuI8hD/wQ982bFatYNZZhHeFbiFbc17S2kw3LY9RmvQD+WNrgkE8YEJgzg483N3D3x+fTjdUYlCYU7aio1ul40MbhjyAGFLAOtiOick=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788388325; c=relaxed/simple;
	bh=ZAVbycGPoGS6oTWU2cxFjNfVmlm/CvFHFmp4I1ouxeA=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bodyOjX8R8bYXJmTjzxDgjZ3wK8oiCXb4FRLSia6EY6Ddfu49MbfCbFi3eS+F3pyvTJdxsvuok/dVrXAPPnz+auyQ3Wr6ghIFIyZJM6wsOo1VI5hO/qDMCb3iWF7e0gnrqyjnbKXRDAjbYi6Smh0gz1lItw6oHqZcnVzco/Gc6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NXZxfJsh; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NXZxfJsh"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-39675172593so1630253a91.2
        for <netdev@vger.kernel.org>; Wed, 02 Sep 2026 15:31:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788388313; x=1788993113; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:user-agent
         :references:in-reply-to:message-id:date:cc:to:from:subject:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=2a4ijTAp/3eyCNXduNdrvSeH88w8TAOtQ1wv+qYnBl4=;
        b=NXZxfJshbMXiw8gDUrHeaukf4+OW55NxyZ/jrinKtH7kZeRdy0Nma/Agr2a/uTvhzV
         7DQUjjHLgOekGX+hHboCcFzcHOlh+LmQFZj1Mo5cK47ZxyL4QnpXW7xUyKUQEbm1rH0w
         5yQ4UyfuvXg8ykN9sU0+7Fza4uil2LAcS1WrV8YdqueZc72ueIfLqzh+bc/kf5IB1mVP
         1i0xEmy/3UYBa1OGBRDhpETlJsQaI4W9nyPKLK70A11R/xsr8WJhT/1D4j2Gh11XrD1k
         L7dq6YD8ljZEefJS/voJnmTJtcwsBKgxd0CO1yALWHJlaMb8RgT+g9nJuKvSvV3DFCtX
         qnQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788388313; x=1788993113;
        h=content-transfer-encoding:content-type:mime-version:user-agent
         :references:in-reply-to:message-id:date:cc:to:from:subject:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2a4ijTAp/3eyCNXduNdrvSeH88w8TAOtQ1wv+qYnBl4=;
        b=RihDxZztRmY1nT29jH/rroDSkBvr9m8mYsg6smPyOp3qSrZAMzW74os+gSyLA2O6hl
         iUaQYvkeirofYXIOMtVv+Jtzq/WViyy1SVANTAeoy98EqFy9tqcTlOOeFKF3fm14sFsB
         lkvoTMn+PpRegH/Gfh7MDw6WvNp2blgWqyjnKB2lobEliAMyjB8zN7Z1CF6Hb4F/wSCi
         C3Wa3RJ+rByPI46+fs75LlnP5skv2786JKykEcPbPcZvdooDGY2mZa2qg2zeQvn0gAiY
         eloeXLPoNCQd89KRZ45SpGh64ZDaf0TnU3HVP+u3rGVl3P7b8FSDT1Mum3i/x7q9va0C
         g0vQ==
X-Gm-Message-State: AFuF++kuyGJovKtgCj4f+PWVZ82fPM+ElIkjSGD1+bptXGvXyNYhPmUZ
	LUBnw7thgnUaQyUP7IDMBw5QelTMkbnnZGSqSKQq3wBPArRkkKZCwnhE
X-Gm-Gg: AYBFou2rEMx8zdHfVq8A5NW27Q99ZeQNdoCPI85Q/+o2T6QVivF30WyVW4P8FREtW9E
	ZYIkooE+spFrdV7fOaO5zhJsnTog2v3NeZZRhbOtnmPh1j4Dji0TQr9M2YfwHYSk1iT/RRLrDpv
	6X5IpU2ujs42rCsGyTEV01K73SZU6SBirFkygo5W0e3QKSAzZb5qi/1yOoOXMjrG61JuPX4xthZ
	CBMPm1/NUrgo3m1wk9Ug9QAXxy7IiRTGx1fBJcDN0KaoxEUVJCfIHKnql5cKTRAOAjX6aNP9YwT
	yZJMq2UXAShCtPB7qFiRQaBxyDtqGAPCdDDz1NzPAWT717sWvQqNx0JLz9iX7PkUheI+khrucih
	G3V4ruEEFokyUYcEWaEzzapG+PItf4xE6p5qUx9pXKWSda1yG3CrLAphCjM+OzOZBVTwcXg0l/3
	Qcdvce3khg7+sAuA5jQB8BMlkVfY8LM+KiUjak5ubysMk18PS/LEsjTLj8/t2CwMGl/y1P7pT3z
	hWbAkAQeQbbh85Q3m/GMSKnJ2/RRAcUUgbL2ggxxmvqutnFUFoeTdv5jP8VmuwenYsbrzhTOD08
	zoxoi0BD
X-Received: by 2002:a17:90b:4b0f:b0:38f:dec8:f7e9 with SMTP id 98e67ed59e1d1-39aee152d1cmr10949343a91.12.1788388313052;
        Wed, 02 Sep 2026 15:31:53 -0700 (PDT)
Received: from ahduyck-xeon-server.home.arpa ([2605:59c8:829:4c00:4db7:e37c:a6be:f5bf])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b083f0565sm1416498a91.7.2026.09.02.15.31.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 15:31:52 -0700 (PDT)
Subject: [net PATCH 1/4] fbnic: reset num_napi when the IRQ vectors are freed
From: Alexander Duyck <alexander.duyck@gmail.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 kernel-team@meta.com, Simon Horman <horms@kernel.org>
Date: Wed, 02 Sep 2026 15:31:50 -0700
Message-ID: 
 <178838831069.11136.15113954049469090479.stgit@ahduyck-xeon-server.home.arpa>
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

fbn->num_napi is the count of live napi vectors, each of which owns an
IRQ.  The PM path frees the IRQs and vectors without clearing the count.
It must do this to avoid leaving too many IRQs active which could overwhelm
CPU 0 on some systems and end up in the suspend failing. See b980c0634fe5
("i40e: shutdown all IRQs and disable MSI-X when suspended") for more info.

fbnic_pm_suspend() tears the datapath down via ndo_stop() and frees the
IRQs, but leaves netif_running() true so resume knows to re-open.  Resume
rebuilds the datapath in __fbnic_pm_resume() and fbnic_reset_queues()
overwrites num_napi and __fbnic_open() re-allocates the vectors.

When the datapath is torn down but never rebuilt, num_napi is left
pointing at freed vectors. Two cases that can trigger this are:

 - A PCIe error recovery that fails (fbnic_err_slot_reset() ->
   __fbnic_pm_resume() returns an error -> PCI_ERS_RESULT_DISCONNECT), so
   .resume never runs
 - An __fbnic_open() that fails partway on resume and unwinds, freeing
   the vectors after fbnic_reset_queues() has already set num_napi.

The netdev is then running with num_napi > 0 but napi[] freed, and the
eventual remove/unbind close re-enters fbnic_down() -> fbnic_dbg_down()
and dereferences the freed vectors:

  BUG: kernel NULL pointer dereference, address: 0000000000000210
  RIP: fbnic_dbg_down+0x28

Clear num_napi when the vectors in the suspend are torn down (a good resume
re-establishes it before __fbnic_open()) and clear it on a resume open
failure. A redundant ndo_stop() then walks an empty napi[].  The normal
ndo_stop() down/up cycle is untouched and retains num_napi for the next
ndo_open().

Fixes: bc6107771bb4 ("eth: fbnic: Allocate a netdevice and napi vectors with queues")
Signed-off-by: Alexander Duyck <alexanderduyck@fb.com>
---
 drivers/net/ethernet/meta/fbnic/fbnic_pci.c |   18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_pci.c b/drivers/net/ethernet/meta/fbnic/fbnic_pci.c
index 8b9bc9e8ea56..c6698e3002a1 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_pci.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_pci.c
@@ -434,6 +434,7 @@ static int fbnic_pm_suspend(struct device *dev)
 {
 	struct fbnic_dev *fbd = dev_get_drvdata(dev);
 	struct net_device *netdev = fbd->netdev;
+	struct fbnic_net *fbn;
 
 	if (fbnic_init_failure(fbd))
 		goto null_uc_addr;
@@ -441,11 +442,16 @@ static int fbnic_pm_suspend(struct device *dev)
 	rtnl_lock();
 	netdev_lock(netdev);
 
+	fbn = netdev_priv(netdev);
+
 	netif_device_detach(netdev);
 
 	if (netif_running(netdev))
 		netdev->netdev_ops->ndo_stop(netdev);
 
+	/* The IRQs are about to be freed, so drop the napi vector count */
+	fbn->num_napi = 0;
+
 	netdev_unlock(netdev);
 	rtnl_unlock();
 
@@ -508,16 +514,20 @@ static int __fbnic_pm_resume(struct device *dev)
 	if (fbnic_init_failure(fbd))
 		return 0;
 
+	rtnl_lock();
+	netdev_lock(netdev);
+
 	fbn = netdev_priv(netdev);
 
 	/* Reset the queues if needed */
 	fbnic_reset_queues(fbn, fbn->num_tx_queues, fbn->num_rx_queues);
 
-	rtnl_lock();
-	netdev_lock(netdev);
-
-	if (netif_running(netdev))
+	if (netif_running(netdev)) {
 		err = __fbnic_open(fbn);
+		/* On failure the vectors are freed, so drop the count */
+		if (err)
+			fbn->num_napi = 0;
+	}
 
 	netdev_unlock(netdev);
 	rtnl_unlock();


