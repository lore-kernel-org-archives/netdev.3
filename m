Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 373354A3878
	for <netdev@vger.kernel.org>; Mon, 14 Sep 2026 21:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789420229; cv=none; b=ivrFbyChrjDiXmAa1rL1cIyscu3KrmcopElWPCY00bx+vvppNixGWo3eqgntS8LgdpovzYj9ysQl4OquIESlVmuTOzGQUXqN8u08YWzE69bhFZydf0DXRwz+jdaHl7A+6REJUQmlZiVZDIG7pawaliirm9bRdB8pHxew4qUNF2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789420229; c=relaxed/simple;
	bh=uBrAsYKarHZMCA7ScLrpFmTtUT29hgghtg56Mj7UQRs=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=vGswG5XW6n015oYjzuBHk5D+Gx1oFsBnjLi+Xbob7K6mXM5DLS0vb2LsLuBW1AuCIq9lh+zwQXOM+OGsys3dmyQpfCwpiWBhmehcCCOI35Tqqa9ic8+kHIvCpQ810nTgSBV2XBSxi4e92LeQLQ1R6fFsWhhAd+B2P2Fxb4wMS+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MRDCsjgu; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MRDCsjgu"
Received: by mail-pj2-f13.google.com with SMTP id d9443c01a7336-2d91c22d27dso13340255ad.1
        for <netdev@vger.kernel.org>; Mon, 14 Sep 2026 14:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789420221; x=1790025021; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:user-agent
         :references:in-reply-to:message-id:date:cc:to:from:subject:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=ny0Tfsv1w1nNPjvLY5c+bzcixMiVw0xrhcNyoWMoRMI=;
        b=MRDCsjguKV5/m030upbGfult/P19g3En8M6mplyLv1oJ7hDIotIsq7h/0l3BHwG2/f
         p8T6kQc5sQIiTZt6u+1D7QOAZVn1bihR294QjkJR30le3r4m1iM7JSSatOakZPLrXbRv
         jPFgkcTkaZC0OB8eVyz2dRMJVN9jEELO4Ptyls9L/XC6tFdGJSRjKkDGxF6GWEr/zp+U
         nRuriX5+dIDNb/mm2lERfbr4ZO5+8cnLhFy9n604xZQUIJwWMuAD1SRhJ53MQFO05oJk
         Wqh0Bvpv4HKA7A8loSBm+LjB52k8t9hlZ+aRUt+EIesPBiNf2qD7sHaKnzNVMK1EdWqs
         8h1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789420221; x=1790025021;
        h=content-transfer-encoding:content-type:mime-version:user-agent
         :references:in-reply-to:message-id:date:cc:to:from:subject:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ny0Tfsv1w1nNPjvLY5c+bzcixMiVw0xrhcNyoWMoRMI=;
        b=xgmM9nM53t9SJrdFcZLsHvS61hN7lao+SexJy4GZcF32EvaPxLv/jdqqlxbVgIn3/9
         p9o8NL4duTaIBDk3BF7D6aXuayoi0hmwbX9sD25ZKVM4AEMoU6pjxFj9bQ1UcmnmSu3G
         AHJL6NhKGL/zu/G8/drw/aBHqEkXZ63KbEIFZ6xgG73NGurR+1WjkYY+kuyBB6M4MakJ
         ESNu0WRL9NWAnfTmLrizTSTnalNJvijV0dm8QFDpVinC+LuiJelPIVW+kW7GcczQxgXF
         eyvABBFLxF5iTc6UYWsnqiXwG4nw4oz7yrMHZ7cPWNc5M/XrLUbOTRd+dABHyNJXMBf2
         zZKA==
X-Gm-Message-State: AFuF++ljq2EbhVgznUzffB3cZCX9vxqiqmJoDdRFgutta++ceozYmaHU
	NHlK+SqU9rYv95FRHfDE9N7bXAKaNmiDlsUN1W2EkgFOLLkkPK9V9eCkD1MWSg==
X-Gm-Gg: AYBFou3IU73g4AuhMPSm6yQknpUrGp9lC27cKJe5LAV4Wtafia85JSP9i8MV9FsWKRo
	KkrEp0Xt0AoP03tm9myK5EGsNjCaKkdp3Kd1vt0PVbFcgpZ6Uc/wtJtSJk7CGitoJgqJxArMmNR
	MnesY8FVbfo9R7oE0F+9c5judHm1EfB9MHOELHHzXnwzXrt/QWsUcCPa6JzXBNPsv7Ls6UwqA5C
	7v21dGak5GB528i6EOOI9xOgbjVTZysx1yoUzJ+C0nlC3wowJiVsAibQl35oLxx1MfqgLmsY4ej
	OgSBOk6KujDjfS3tm2wFFmFf0EjI+eiy03icOfVEQo4FoubauQba/8kqoCM5vC+jo9BsuanTekP
	N1k1iO/QzT81LnJL9dQVfrhLtKioaEpOqaB7i7Y2XTfMgQA+GazpKsZ3PQXOMSc2mydIY5ev5tT
	FNta1f++oiuWRKfbBPu9qhumdhh1+iyhnFRxZb7zmA/PusSYNpcTb8jF+KoD8IJrNcH2/3Ce7g3
	llnu5F/WB17MxCRtEJDc6oMaCoW22X/qL2ikXmdR2BU+ih8qx6KVJ85G762PeUKLbRTjSTeFcfg
	kgqXQVJ9EobVO9h5Hxw=
X-Received: by 2002:a17:903:fa4:b0:2dc:fcfc:bdeb with SMTP id d9443c01a7336-2dd6c7e2368mr100832835ad.22.1789420220581;
        Mon, 14 Sep 2026 14:10:20 -0700 (PDT)
Received: from ahduyck-xeon-server.home.arpa ([2605:59c8:829:4c00:d680:cb2f:f831:8497])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dd2cff6e80sm54893905ad.78.2026.09.14.14.10.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 14:10:20 -0700 (PDT)
Subject: [net PATCH v2 4/6] eth: fbnic: reset num_napi when the napi vectors
 are freed
From: Alexander Duyck <alexander.duyck@gmail.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 kernel-team@meta.com, Simon Horman <horms@kernel.org>
Date: Mon, 14 Sep 2026 14:10:18 -0700
Message-ID: 
 <178942021809.7700.10804028989308077839.stgit@ahduyck-xeon-server.home.arpa>
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

fbn->num_napi is the count of live napi vectors, each of which owns an
IRQ.  The PM path had freed them without clearing the count.
fbnic_pm_suspend() tears the datapath down via ndo_stop() and frees the
IRQs, but leaves netif_running() true so resume knows to re-open.  Resume
rebuilds the datapath in __fbnic_pm_resume() and fbnic_reset_queues() sets
num_napi and __fbnic_open() re-allocates the vectors.

When the datapath is torn down but never rebuilt, num_napi is left
pointing at freed vectors under 2 different scenarios:
 - a PCIe error recovery that fails (fbnic_err_slot_reset() ->
   __fbnic_pm_resume() returns an error -> PCI_ERS_RESULT_DISCONNECT), so
   .resume never runs; or
 - an __fbnic_open() that fails partway on resume and unwinds, freeing
   the vectors after fbnic_reset_queues() has already set num_napi.

The netdev is then running with num_napi > 0 but napi[] freed, and the
eventual remove/unbind close re-enters fbnic_down() -> fbnic_dbg_down()
and dereferences the freed vectors:
  BUG: kernel NULL pointer dereference, address: 0000000000000210
  RIP: fbnic_dbg_down+0x28

Clear num_napi when the vectors are freed: in the suspend teardown (a
good resume re-establishes it before __fbnic_open()) and on the resume
open failure.  A redundant ndo_stop() then walks an empty napi[].  The
normal ndo_stop() down/up cycle is untouched and keeps num_napi for the
next ndo_open().

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


