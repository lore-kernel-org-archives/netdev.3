Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83B403E0094
	for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 19:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790796091; cv=none; b=mDa1leXHff283g0n81arKScDs6aZTvwnByY3R13VkbgxGWGXuW6PcrJX2FK3uZTh0dNyML4FF108mnImy3FcxGubbhEyFFOOzD/uxpAcqtmREhzCgdZ0dMOVhzVy4dNXjPU1DAE6Plle+M9WpHy2oJAB1jM36IIBjA6yy2Z8QDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790796091; c=relaxed/simple;
	bh=uZKo3LvjIw/jQo2DcJhlrJtg2qwhUGJRKYHVpUos/Og=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rXfjEiNUJOtOB/ftyUhS7EmZB5PZBM2fdwGQaWaTwH0wCGOYQX+Pf32JL4q1HeMnWysiAJku+65ZpFaLXGvYxU6RgpaVeNjhSbvY6OVul/A+QN7rhwu4pshgEr+72INeZeWJ60ycO+y1fhrm3pFywyuiDH9NVTBR0Sid3AwCsPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hqnxm1dA; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hqnxm1dA"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49fff6f0f87so29636935e9.3
        for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 12:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790796088; x=1791400888; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SbYiN1Bd29zaEpgdDuLGxrhXKVFH4VSvfh3sFDNw4+w=;
        b=Hqnxm1dAEAEa677uYh+YJ43K0Mn++1DKoDK4qXLcbbuWcS+jlZ/m34iUXIFccGiZjt
         4j5yeLbpr66Aga2ReLQa/nI+9X/B26YpfT9z/Xn7C6NZ64HlzNmrl8S3rHC6X7Lc6cop
         HGeOYc46AGQFIDS+2dmMz4pQ+r1T7jx+RSCfLLLvTN+Bgj4lbOON8xXqPTg1fxkrvpOg
         7U8c2QAYD7eljHuCtkTfb/mqarM4XloSEt9uxNr4ctl0xYZ4Sn7orXfa/QIgFOnlbFCH
         2TyrlOmmO4NWytRCCaS/dd4dAmhRGY7Vjker+yAxZ+lo6GQAdA96Yr1AxgfKd8Mbr3sU
         e/DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790796088; x=1791400888;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=SbYiN1Bd29zaEpgdDuLGxrhXKVFH4VSvfh3sFDNw4+w=;
        b=VtUCDa0gGCYK+H0mFP/+c0LCmSXY7FEDVMHRTqCvVyhbNdjpw5rHNpcYOcSiNXcHCO
         6rdEJys1bxZkUjOssb5wH1ngy83hUdjaL/CdiWT2zvL4Pu989bmXY48SOIG6Z/b8CafY
         BL1NuWE2ScRAZGXIGHOgKaUVKm/NVC0GjGL0ndKQxo3qlnqnKxwlR+F8Mlgcis+dVTML
         VtlNcbMwDcK1RAYYo8eSV3v09oH2AMnrQkMSRNBcMypI7JZMrY03k+N0LS7zZLreFKZl
         G82Xxpdn2zE0fikbwFhDZHQa8VZmT1pBbOw6RSgvUU18/tW8HxQfdgvwGnSiyPREplGL
         avzQ==
X-Gm-Message-State: AFuF++mKCyb0POgvafWRPQ5UdExMqb5thB8Q9R4S14/cQG4srVief+jv
	pZX9Sjyc9J+JbHudFy0wtq+lWVIhnA+8jfWD0TWQJ0higCiJ0pbn5BEsKWPtp2PE
X-Gm-Gg: AYBFou2DnUSCwxegn3/IJ1Q22gFhsWfrwhb0gHlltSgwtGXVyFSESGZDVl7IMbG+z2p
	yCOq5NBrXTLE2DJ1U3jfizu293VeaJQL8WYWbxSEykJkj+s01NBnkBo3gzR9VuYIzrsL5efKbjH
	44s78ANCqcYjZU5TRCltq98RV9eQYTR1oPzwI5FbpF6V5rXFk2RzSA0IBcfIJfFRI79MqpI3SiM
	3xyj/zIYODH60oW9DPEXqkdEoY4FVHjhfB139xy1e83x7V0foUB80qWh6hPj1gwN6O3bwJvi/h+
	/xDMwmcXqZzgDq1Ck32FeMBab/oFXdqZnlCuam/3gbC2bFk2kzARfsfJV6fXtV+Lpd9+UnNjMBr
	RIlPaN7aunZovpvG5H4qoMgCaL1wTl9AgLfw2DjK+EyVXhjS5r0fJiVc5KArGYuYj83OSkcUjVM
	osbd6wF9caDio0BnIAVeeQiMqhRCsnOOpmoF59g/sr824HniluMMRCAbRSw6FT+xXIk48NF8u44
	OZW+vpY+sdXc3Ptnb9UK9KXdxMNaHAA3mVvZMIJbOh+QnP1oBkNg/OOPpe+wHPIIlVG1BpcMXUh
	1iRBCNEiNdw7PcX+bGviqWL1VS8qYlBazHZaEu+QzxkcThMtu0EMUbs5TZz2uEvWKjzqQkfX134
	B
X-Received: by 2002:a05:600c:4687:b0:4a0:3a3:33e2 with SMTP id 5b1f17b1804b1-4a01adde08dmr42117895e9.5.1790796087622;
        Wed, 30 Sep 2026 12:21:27 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-b2b3-0101-b51c-a607-3dcc-3979.310.pool.telefonica.de. [2a02:3100:b2b3:101:b51c:a607:3dcc:3979])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a01f9248ccsm3513165e9.3.2026.09.30.12.21.26
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 30 Sep 2026 12:21:26 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: netdev@vger.kernel.org
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Stephen Hemminger <stephen@networkplumber.org>,
	Arend van Spriel <arend.vanspriel@broadcom.com>,
	linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	stable@vger.kernel.org
Subject: [PATCH net v2 2/2] netpoll: avoid blocking on the transmit lock in queue_process
Date: Wed, 30 Sep 2026 21:21:03 +0200
Message-Id: <20260930192103.62973-3-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260928064239.32456-1-kmehltretter@gmail.com>
References: <20260928064239.32456-1-kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

queue_process() disables interrupts before taking the device transmit
lock with HARD_TX_LOCK(). The lock may sleep on PREEMPT_RT:

  BUG: sleeping function called from invalid context
  in_atomic(): 0, irqs_disabled(): 1, non_block: 0
  Workqueue: events queue_process
  rt_spin_lock
  queue_process
  process_one_work

Use HARD_TX_TRYLOCK() instead. If another CPU owns the lock, put the skb
back at the head of the deferred queue, restore interrupts and retry on
the next tick. Keep the longer HZ / 10 backoff for a stopped transmit
queue or a driver which returns busy.

Fixes: 3640543df26f ("[PATCH] netpoll: fix netpoll lockup")
Cc: stable@vger.kernel.org # 6.12+
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 net/core/netpoll.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/net/core/netpoll.c b/net/core/netpoll.c
index e0cfcb05468e2..8d8e3c33cfdfe 100644
--- a/net/core/netpoll.c
+++ b/net/core/netpoll.c
@@ -166,7 +166,13 @@ static void queue_process(struct work_struct *work)
 			skb_set_queue_mapping(skb, q_index);
 		}
 		txq = netdev_get_tx_queue(dev, q_index);
-		HARD_TX_LOCK(dev, txq, smp_processor_id());
+		if (!HARD_TX_TRYLOCK(dev, txq)) {
+			netpoll_txq_queue_head(npinfo, skb);
+			local_irq_restore(flags);
+
+			schedule_delayed_work(&npinfo->tx_work, 1);
+			return;
+		}
 		if (netif_xmit_frozen_or_stopped(txq) ||
 		    !dev_xmit_complete(netpoll_start_xmit(skb, dev, txq))) {
 			netpoll_txq_queue_head(npinfo, skb);
-- 
2.53.0
