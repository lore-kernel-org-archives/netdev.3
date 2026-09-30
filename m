Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F7402F8E93
	for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 07:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790752552; cv=none; b=NTFns2e0a+7FqVL5c7Klp5nXGyOkenR7vfEe82kIm0t8v5TA0Em+k/aJ1e6RJka8SZvenNgjrIvnIyrmF3h4HQqY9jHf9sXFu7ujrxzblg9gFLtT4djZJe/oJAqT0qtY5iP4F/igj27yKcAdnp9PWuuElY4GxadpNqDtsWK8a2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790752552; c=relaxed/simple;
	bh=Tu0bSpWYgnkCJme/Bet6w3BTZWJdEOppQ0mo1x1nCzk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Qtvw7gTkUSNTOsTjsAXrJKHXqJKEI27GFLm85orC4W8n91BbWfwvoAE3xsUCHP9yn8VnKC4dn088O7AkdEHWufGXCgZpDdQnXk76uY2Uk4RTjbrZ4AtwDUZ2mWo73TrSp9ByBThmXtCEpP9M/5XJT5fPZwG4r2TiWgDSU7vVo8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nQiGt3y6; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nQiGt3y6"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-485ac898fa4so3976601f8f.0
        for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 00:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790752541; x=1791357341; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=F/SbVhMvqYrGxK11cD/q4PA+nXETskb6eXmSE0ztKU4=;
        b=nQiGt3y6dBMTNY8pIEVf8YZK2MVhqOkpVRe2jVhcSvkyx3phPa4dnJcAB2VMguhDWi
         qwLJ3pAG4DvgnMZQteD0ZS1+4GQyBFkQTJomikukdFhJAHxK0WZHHVKaGEEfkWQ7Zqc2
         g6VdwSnMO9HHMhvktukQWOOIdZJ7p9tAmz9IMgtC4VYt56MvbVQkjbo2vofSyq8avoC7
         iI0FmBt0BK1P7RtXWh0ol72PoCMUgcN2gYo9ax+O7ojUih1R0uCrnZUn+4sTf/AAxX0W
         50T7cUS33mc51YHa/DABV6L1TPX28syIfBVbTQrwa2DQWoLh/3gf06Ej8ufRAM8kmz1v
         2bVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790752541; x=1791357341;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=F/SbVhMvqYrGxK11cD/q4PA+nXETskb6eXmSE0ztKU4=;
        b=mlsjiatf8RnhsFMlPkjJflVe0437mwhUTgQTc8hreKIeuVLk2xVL3JKWOUe6f1heH4
         wbHLGrg1aiQhaNoWDCuUdnSGzG0e+TfNeYiZAaPjT21VG/EC8U5QDth3x7WA1tt7FLKd
         vw/ER/Azz6MKBkzoQpxk7DQ/4PTOCuXaqaKqvLI1GtWz0lPN4G8y4GUWBJp52hRGgEhH
         MHxBuh5KKFl7ofJOWpehBeDBOSamdTJ7reqzq5TTZF3X3g5tt9lTaA/y5OPKcU5gfzVY
         b+T5BgTkylJqOZBDZsZiIFJiZGdWiAKym8DtK1MIa3kD1ykMjc85J34Py+YWcFPugwa2
         OS/A==
X-Gm-Message-State: AFq9FYJOGnZA4cqCEbKrLRsgiJfM2K2jpALpUwPyfEhJ+1ZroHZJMy4U
	qbIuOxCfSgbrct6Y99e6g8qjurOFhdZ+46FulmZITThROXASVbjigirl4EGYSpgl
X-Gm-Gg: AYBFou0s9G5AhQl2ZD+mNRs/+lrHVKAZJLjCa2fUdMqljEgMV9pY0RPjAqwUCBp0syZ
	AzY+Ea+8ZfyLDGqXvGbhRkjE4k7i47o9oM3+BW0nlwmWLzLLVOjCpDa03yTmXVXZIZwjTK215cU
	Up7AMSQswG8owM+Jo1H2yR0Lx5Tx0Ls0L3qsKATIooxrlH089sC3Afv3DVvGGYsPDs8ovvRCzzy
	uaIs82PmBtv0ikdzfH8tjfiE6JqdQ20TZwKxkvNGmo3SZ6YHQl9r4b+Ee3tJgbFQUH1bjbeS6VQ
	0OohOcJCGaV9VQGEXHIw90W3T9L1jqv1LXyA93CNKUduYgRTwxvXR8DVP4v98Iv0s2ODeTjeLRw
	KdjMtxh2+sAIRuJixUmukNyCt0Jhuhw6WBRjTcvR0eE1fv64znVJSQegIoHLJbU4ZsyQmhBBFUc
	pjtLtZNBqFPW2IhsH/c7XlIj/3+yCXfDw8eigNMPbc5mrvWBAJe+w32Nd6kvBQ2igbrSEe9+kPc
	0QUXKamFnLPPQe1Fy8nJ5M7k7Y+KJtm25OhbawY
X-Received: by 2002:a5d:6f1c:0:b0:487:489:7af0 with SMTP id ffacd0b85a97d-48b024bd025mr1059857f8f.17.1790752540836;
        Wed, 30 Sep 2026 00:15:40 -0700 (PDT)
Received: from fedora-tap.advaoptical.com ([82.166.23.19])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48b02e7b0d0sm735890f8f.14.2026.09.30.00.15.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 00:15:40 -0700 (PDT)
From: Sagi Maimon <maimon.sagi@gmail.com>
To: netdev@vger.kernel.org
Cc: pabeni@redhat.com,
	radhey.shyam.pandey@amd.com,
	michal.simek@amd.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	robert.hancock@calian.com,
	sean.anderson@linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Sagi Maimon <maimon.sagi@gmail.com>
Subject: [PATCH net v4] net: axienet: cap the TX poll return value at the NAPI budget
Date: Wed, 30 Sep 2026 10:15:36 +0300
Message-ID: <20260930071536.627964-1-maimon.sagi@gmail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

axienet_tx_poll() reclaims every completed TX descriptor in one pass:
it passes lp->tx_bd_num to axienet_free_tx_chain() as the descriptor
limit, and @budget is only used as the napi_consume_skb() bulk-free
hint.  It then returns the number of packets reclaimed, which is bounded
by the ring size rather than by the budget, so the poll can report more
work than it was given.  This was seen after TX completion interrupts
had not been taken for a while and a full ring was reclaimed at once:

  eth0: NAPI poll function axienet_tx_poll+0x0/0x180 [xilinx_emac]
        returned 96, exceeding its budget of 64.

netpoll is affected as well.  poll_one_napi() polls with a budget of 0
to reclaim the TX path only, and warns once if any work is reported.

Keep reclaiming the whole ring and cap only the value returned.
Documentation/networking/napi.rst allows a poll to process any number
of TX completions; it is the reported work that must stay within the
budget.  Stopping the reclaim at the budget instead would also leave
completed descriptors for a later poll, which does not come when
napi_disable() is pending.  When more than @budget packets were
reclaimed, returning @budget keeps the poll scheduled, and the next poll
completes NAPI and re-enables the interrupt as before.  A budget of 0
now yields 0.

Suggested-by: Paolo Abeni <pabeni@redhat.com>
Fixes: 5a6caa2cfabb ("net: xilinx: axienet: Fix packet counting")
Assisted-by: LLM sparse
Signed-off-by: Sagi Maimon <maimon.sagi@gmail.com>
---

Notes:
    Changes in v4:
    - Different approach, as Paolo Abeni and the review of v3 suggested:
      keep reclaiming the whole ring and cap only the value returned,
      instead of stopping the reclaim at the budget.  napi.rst allows any
      number of TX completions per poll, and stopping early could leave
      completed descriptors behind while napi_disable() is pending.
    - Subject changed to match; v1-v3 were "net: axienet: bound TX
      completion cleanup by the NAPI budget".
    - Fixes: now names 5a6caa2cfabb, which made the return value unbounded
      (review of v3).
    - Only axienet_tx_poll() and its kernel-doc change now.
    - Suggested-by: Paolo Abeni.
    - Build-tested only so far; v3 was tested on hardware, v4 not yet.
    - v3: https://lore.kernel.org/netdev/20260924135052.185129-1-maimon.sagi@gmail.com/
    
    Changes in v3:
    - Report no work for a budget of 0, so netpoll cannot trip the
      WARN_ONCE() in poll_one_napi().
    - Add the Assisted-by: tag that v1 and v2 omitted.
    - v2: https://lore.kernel.org/netdev/20260917115657.20697-1-maimon.sagi@gmail.com/
    
    Changes in v2:
    - Treat a budget of 0 as no limit, so that netpoll still drains the TX
      ring.
    - v1: https://lore.kernel.org/netdev/20260914114821.55503-1-maimon.sagi@gmail.com/

 drivers/net/ethernet/xilinx/xilinx_axienet_main.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
index 1722b7038f34..243b07fd5be8 100644
--- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
@@ -984,9 +984,9 @@ axienet_start_xmit_dmaengine(struct sk_buff *skb, struct net_device *ndev)
  * axienet_tx_poll - Invoked once a transmit is completed by the
  * Axi DMA Tx channel.
  * @napi:	Pointer to NAPI structure.
- * @budget:	Max number of TX packets to process.
+ * @budget:	NAPI budget, or 0 when polled by netpoll.
  *
- * Return: Number of TX packets processed.
+ * Return: Number of TX packets processed, capped at @budget.
  *
  * This function is invoked from the NAPI processing to notify the completion
  * of transmit operation. It clears fields in the corresponding Tx BDs and
@@ -1027,7 +1027,12 @@ static int axienet_tx_poll(struct napi_struct *napi, int budget)
 		axienet_dma_out32(lp, XAXIDMA_TX_CR_OFFSET, lp->tx_dma_cr);
 		spin_unlock_irq(&lp->tx_cr_lock);
 	}
-	return packets;
+
+	/* The whole ring was reclaimed above, which may be more than the
+	 * budget, but a poll must not report more work than it was given.
+	 * netpoll polls with a budget of 0 and expects no work reported.
+	 */
+	return min(packets, budget);
 }
 
 /**

base-commit: a7bfaba4823e3c165bb2004c74eff7c096672bc7
-- 
2.47.0

