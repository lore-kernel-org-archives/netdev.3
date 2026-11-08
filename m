Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=159.226.251.25
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794134091;
	b=dH/yIsKHfV1yIpaqoIBxh216hkx3Nj1Xbe197mTyoBRoVkKmeADRhq9/mefSJsKCNz0p
	 RRLcfuRP4E2WjTQVheWWfAqUUpDe9H4OqMLb2XTFWLeS780yM6RIQgXoR7sE+dHcg6tUO
	 rfX1Uc23sfTSAVG8qfrf84DxwuGY57/5fGMGPuj0ybvlR63Q9OSrGVhjbx4KObCUyPvpY
	 F7Q0DsewcY1Tfw1YO3c8CXTrn28tRsGKuRLYuYTzhJcW784D4gQTEU2O5rAXMum/KkX3O
	 qMuvgOy9hCJLnDSagvnpVSnfrsOO8ozED5QvAE7Sf9fIDFJs8MZEsU29GCa9LFR9big==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794134091;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo;
	bh=dx+VU+aV7WDRsPAOIw4cTsWt00OkUh2pxMvvkULPiOk=;
	b=YEcLlMAGaakGQ4SXJRcjGVTZL8w4TIEbTOTnyqgqCY2p9FWqXDm8JGNhCZdw5nufHvww
	 T0wMRxUQBEAulCB0/gQl5G/emV1o0wWOxgQ+1v3JGwbWGi0M41DjMhmCHkSlKUEv0sbi7
	 vcM+zi6BTyKWDP7+wtsIJgjsq5MMSzxlw2l8n/RG4VlHNPU84RDYqcv0oEms07mue2RSF
	 5Sf9o7w3i2D3GALxbjfLO3TyO029EaZlBuGk6erXjuMPQ/Xdo1n1ST/30HEyHNsT4ALdN
	 w/GKM54bFX7dfHSp5ZdWJAl2YQDo0Sm47wTwlkc4vpTpD7ZBnuoGW9vBQfgNxBr2/+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=iscas.ac.cn;
	spf=pass smtp.mailfrom=iscas.ac.cn;
	arc=none smtp.remote-ip=159.226.251.25
Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57D1A606A31C;
	Sun,  8 Nov 2026 10:34:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 57D1A606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from [172.100.0.8] (unknown [36.110.52.2])
	by APP-05 (Coremail) with SMTP id zQCowAAXtLlDUPBq1pKZAA--.18305S2;
	Sun, 08 Nov 2026 18:34:43 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
 vulab@iscas.ac.cn
Subject: [PATCH net v2] net: cxgb: Fix skb reference leak in ESPI workaround timers
Date: Sun, 08 Nov 2026 10:34:53 -0000
Message-ID: <20261108101200.2147806-1-vulab@iscas.ac.cn>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:zQCowAAXtLlDUPBq1pKZAA--.18305S2
X-Coremail-Antispam: 1UD129KBjvJXoWxJFyfWr18GF48GrW8Xr1UJrb_yoW5XF45pw
	4DWa47A3yDJrWIkayxAw4rXF9xua1ktFWrKFyfJw4rurn8Jr4jvryIqF1YgF4DAFZ3Wa4a
	yrs8Jan3Krs0yrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvS1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
	w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
	IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2
	jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c
	8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JF0_
	Jw1lYx0Ex4A2jsIE14v26F4UJVW0owAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr4
	1lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAK
	I48JMxAIw28IcVCjz48v1sIEY20_Gr43Wr1UJr1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2
	IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v2
	6r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2
	IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv
	67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43
	ZEXa7VU1K9aJUUUUU==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBggFA2rv4zKpNAABsA

From: Wentao Liang <vulab@iscas.ac.cn>
Date: Sun, 8 Nov 2026 10:09:23 +0000
Subject: [PATCH net v2] net: cxgb: Fix skb reference leak in ESPI workaround
 timers

espibug_workaround_t204() and espibug_workaround() take an extra
reference with skb_get() on the cached ARP skb before handing it to
t1_sge_tx(), so that the skb survives until the DMA has completed.

When the command queue is full, t1_sge_tx() returns NETDEV_TX_BUSY
without queueing the skb, and both callers ignore the return value, so
the extra reference is never dropped.

Drop the extra reference when t1_sge_tx() reports that it did not consume
the skb.

The candidate was found with static analysis tools; DeepSeek and GPT-6.1
Sol were used to audit it and to help prepare this fix.

Fixes: f1d3d38af757 ("[PATCH] chelsio: add support for other 10G boards")
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
Changes in v2:
- Also fix the same leaked reference in espibug_workaround(), the
  single-port T2 timer callback, which has the identical pattern.
- Apologies for the very late respin; v1 was sent in a batch that went
  well over the netdev posting limits.
- Dropped Cc: stable@vger.kernel.org. This only leaks a reference on an
  error path in an old driver, so I leave the backport decision to you.
- Rebased on current mainline (fa4ad798f6f6). Build-tested on x86_64
  with W=1 (CONFIG_CHELSIO_T1=m): the cxgb module builds without warnings
  and checkpatch.pl is clean. The NETDEV_TX_BUSY path was not exercised
  at runtime.
- Link to v1: https://lore.kernel.org/all/20260917105425.2147804-1-vulab@iscas.ac.cn/

 drivers/net/ethernet/chelsio/cxgb/sge.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/chelsio/cxgb/sge.c b/drivers/net/ethernet/chelsio/cxgb/sge.c
index d8fca697874a..87e6dbcc3ed7 100644
--- a/drivers/net/ethernet/chelsio/cxgb/sge.c
+++ b/drivers/net/ethernet/chelsio/cxgb/sge.c
@@ -2052,7 +2052,8 @@ static void espibug_workaround_t204(struct timer_list *t)
 			 * the skb once the DMA has completed.
 			 */
 			skb = skb_get(skb);
-			t1_sge_tx(skb, adapter, 0, adapter->port[i].dev);
+			if (t1_sge_tx(skb, adapter, 0, adapter->port[i].dev))
+				dev_kfree_skb_any(skb);
 		}
 	}
 	mod_timer(&sge->espibug_timer, jiffies + sge->espibug_timeout);
@@ -2084,7 +2085,8 @@ static void espibug_workaround(struct timer_list *t)
 	                 * skb once the DMA has completed.
 	                 */
 	                skb = skb_get(skb);
-	                t1_sge_tx(skb, adapter, 0, adapter->port[0].dev);
+			if (t1_sge_tx(skb, adapter, 0, adapter->port[0].dev))
+				dev_kfree_skb_any(skb);
 	        }
 	}
 	mod_timer(&sge->espibug_timer, jiffies + sge->espibug_timeout);
-- 
2.34.1


