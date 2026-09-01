Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F7EA472064;
	Tue,  1 Sep 2026 13:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788268864; cv=pass; b=utcStwI13OsdXl+juRflq+j7vZQq6uO2SSQp9o0uqp555S6mO2MSjTRtyvHXJIO9sRSpO9w6WMeOBMXTF0PKpyLDBemSZ11w3pzkPZwj5UVytzh0HofRkg4l6s6SD3GobzMriynEnZRokql6V5MfE+nPLMNyPoMoDG0i5yBlLJQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788268864; c=relaxed/simple;
	bh=ePdcpjW/kLvFZnLJetnASTkIonTXjx3cf8nqDnz7rQY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FVWVhgDjeuJOvd/P3xk73hd2iHs69OayLHfjESfrYNsbLFekf9qwcHxUMXufHrbBHsQpVq7O5iVEgtskgm8B98knM70nxLaeDoBRtBXKZyCllH5RclYRq8B4Y+YQB5icjAOMzHWCBvD39RZB8lA1lXxjL2zBVTzfXWhw/yEUFB4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=s1So/mBE; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="s1So/mBE"
Received: from mandelbrot.. (xdsl-83-150-90-33.nebulazone.fi [83.150.90.33])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jmtilli)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4hZ61j26Xfz49QF7;
	Tue, 01 Sep 2026 16:20:57 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1788268857;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v6GkYk0HZBFKkX376VoqF+8xKuVMeoSo1m24bvpn9Wg=;
	b=s1So/mBEfFktHgEtlbB2K6AiVetMyEPXW0DnkIe48kmKj8/iNOD71jVbv7taUrcHsfRpN1
	8JTQsF2ICx7G9v6sDLKBkxnR6rpT8TZ8odwJjH8ZSE2zRcsEaZqRLScZK3ecN4VdPfme1F
	OS6/RXxguApV0X9raxaROWU7rghZTgXXuyX+iYwiMt9lSqu/mJgQU4c8KqSyIQ1R9fsC95
	stRydWO2NHGNg89RAjlE5rBt7anxqjYbPLUPbYSXW91jngNbYQ13qydWpRC37CWy4+3Bfm
	cQb5Y/I4JAaSPO5O8XTwjXzAe/ZMdBIdAdt3nrHgdoJhcL8FMQxLW6vwfqe9+A==
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=lahtoruutu; cv=none; t=1788268857;
	b=eVuCaLrzOVuLtdsu0obT1pky+hLKnSn5sxnVkUFJt6YL5ZbOEgLyHen+CG880kKZmBUqe4
	Hm+VYakdsPwdmPf4TYVXKSaafEee0M0RgIqiFOh+Dfix/e4r/zVSGkPDJKn7bB6WpleD2h
	lcwtGt8P7cbcmq75qblFxQ9RxfSNiaKTLka0N85dj6+Hp5JLVfTiNAaR8/PLn6kDT3y19z
	2gYNiIUH1K7YLTLrAAVqnS6MJasw/huupVFqz3TWpgmuFTcfjMQzdPrbL7PQvXVS9aKCxV
	W4mKRnld5rgF4lvlenBP414vAezTORlbTqNckImkF78ZbmHt3XCGW9ixS1N1Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1788268857;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v6GkYk0HZBFKkX376VoqF+8xKuVMeoSo1m24bvpn9Wg=;
	b=cuScf6M7zWVdcAGGyB/sxa0Vaqx0RiQfqoOvKPiCUoO5WdhnDoY3AihE+nXIIG+RLjYo9Q
	BCRhWxG0ITW5ClY832T3KWwlYTwXpvDWNBtzTMXOJ/DUB0kSEwYzPnQgo6bt6f4FpX0Nkd
	44zJFgmq9W8zeQLJ8t42skQ6uRqT9SSCvsxkRadZ+ruR/0CX80j6L4vNX3TK9D2DeypX5C
	kVieTAT05GCbgtjguvTjebgykN7lgtsPt5V9M8Qhd6YXaiUPJgLZoPBGeYGsqQLRQlcOvb
	17HjuK8g93d6LEpwJ/6EkOhiwR3VSdldgANZOxupqHrcLD/KF/siRUEUfKYzGA==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=jmtilli smtp.mailfrom=juha-matti.tilli@iki.fi
From: Juha-Matti Tilli <juha-matti.tilli@iki.fi>
To: linux-arm-msm@vger.kernel.org,
	Manivannan Sadhasivam <mani@kernel.org>
Cc: Eric Dumazet <edumazet@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Willem de Bruijn <willemb@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Marcel Holtmann <marcel@holtmann.org>,
	Andy Gross <agross@kernel.org>,
	Mihai Moldovan <ionic@ionic.de>,
	Denis Kenzior <denkenz@gmail.com>,
	Juha-Matti Tilli <juha-matti.tilli@iki.fi>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH v6 04/15] net: qrtr: use only low 16 bits of node/port in 32-bit systems
Date: Tue,  1 Sep 2026 16:19:23 +0300
Message-Id: <20260901131934.225991-5-juha-matti.tilli@iki.fi>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260901131934.225991-1-juha-matti.tilli@iki.fi>
References: <20260901131934.225991-1-juha-matti.tilli@iki.fi>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The node id is generally a single fixed value hardcoded into device
firmware. If it happens to be larger than 16 bits on a 32-bit system,
using the value modulo 65536 is enough. It is not necessary to check it
for being in range. Evidence of this is a prior implementation that fit
node_id (u32) and port (u32) into unsigned long in 32-bit systems, in a
manner that completely discarded all bits of node_id. Do the same for
port: don't check for it being in range.

This arguably creates a bug where node_id could clash with a node_id
that has the same low-order 16 bits, or a port could clash with a port
that has the same low-order 16 bits. But it's probably better than
discarding all bits of node and using only bits from port. It's probably
also better than failing if either node or port is out-of-range.

Signed-off-by: Juha-Matti Tilli <juha-matti.tilli@iki.fi>
---
 net/qrtr/af_qrtr.c | 22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/net/qrtr/af_qrtr.c b/net/qrtr/af_qrtr.c
index f2edbd2e9dea9..b2cb05f2480e0 100644
--- a/net/qrtr/af_qrtr.c
+++ b/net/qrtr/af_qrtr.c
@@ -252,9 +252,9 @@ static int qrtr_tx_resume(struct qrtr_node *node, struct sk_buff *skb)
 	struct qrtr_tx_flow *flow;
 	unsigned long key = 0;
 
-	if (remote_node > QRTR_INDEX_HALF_UNSIGNED_MAX ||
-	    remote_port > QRTR_INDEX_HALF_UNSIGNED_MAX)
-		return -EINVAL;
+	/* Don't check node/port for the valid range, use only low
+	 * 16 bits on 32-bit architectures.
+	 */
 
 	key = ((unsigned long)(remote_node) << QRTR_INDEX_HALF_BITS) |
 	      ((unsigned long)(remote_port) & QRTR_INDEX_HALF_UNSIGNED_MAX);
@@ -295,11 +295,9 @@ static int qrtr_tx_wait(struct qrtr_node *node, int dest_node, int dest_port,
 	int confirm_rx = 0;
 	int ret;
 
-	if (dest_node < QRTR_INDEX_HALF_SIGNED_MIN ||
-	    dest_node > QRTR_INDEX_HALF_SIGNED_MAX ||
-	    dest_port < QRTR_INDEX_HALF_SIGNED_MIN ||
-	    dest_port > QRTR_INDEX_HALF_SIGNED_MAX)
-		return -EINVAL;
+	/* Don't check node/port for the valid range, use only low
+	 * 16 bits on 32-bit architectures.
+	 */
 
 	key = ((unsigned long)(dest_node) << QRTR_INDEX_HALF_BITS) |
 	      ((unsigned long)(dest_port) & QRTR_INDEX_HALF_UNSIGNED_MAX);
@@ -369,11 +367,9 @@ static int qrtr_tx_flow_failed(struct qrtr_node *node, int dest_node,
 	unsigned long key = 0;
 	struct qrtr_tx_flow *flow;
 
-	if (dest_node < QRTR_INDEX_HALF_SIGNED_MIN ||
-	    dest_node > QRTR_INDEX_HALF_SIGNED_MAX ||
-	    dest_port < QRTR_INDEX_HALF_SIGNED_MIN ||
-	    dest_port > QRTR_INDEX_HALF_SIGNED_MAX)
-		return -EINVAL;
+	/* Don't check node/port for the valid range, use only low
+	 * 16 bits on 32-bit architectures.
+	 */
 
 	key = ((unsigned long)(dest_node) << QRTR_INDEX_HALF_BITS) |
 	      ((unsigned long)(dest_port) & QRTR_INDEX_HALF_UNSIGNED_MAX);
-- 
2.34.1

