Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=203.205.221.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794572688;
	b=qLnuQCQqMJLQXn22TyXQJ5cf4dtkjiGWT4KEI/onhBQG64El4E7RiT4VFHtIsS/X8o63
	 8DTA7fpPDGoIy9aGIvgtO3zv1bHZSsNllZKtbi03AlrILPswnxtSPrDv2kC/szamZtxHE
	 PbOxGymSRQ+BCa4qHYETZMWTAgvJdyDUhSMfgJC4GswqoWSycSrX5n/MC5rmqlJW74I+i
	 1xf+j3WolWBvw7RZoEQuiY13L37RZaPWfGk4tzrn+Rm6eNBYyKy26VN2+LQdN00FZcVyH
	 jZ94ZV9cm4GOn2XK2o+9oJ35IIEuFMT63l89hLDMCycIj63J90evxYfRb0zljbnBOcg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794572688;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=1/xGQFJzRlf+R2dUsEBhYB/5ASb9U6Kk4vCgR9M14zg=;
	b=lKywkHCTVx4yYHfbt7B6f4GtEsOfyg9MsMjRvgo4xQQyuQCvrlxRmhAPsG6/2AhuRnxY
	 tZ4sV0sqBRiVW6eExQ5CugwpVSX4Hk/irDSaMTvEL+slVL1agWCCEniYK1allTMw7DB9f
	 CI6rjE9H511c5+v9TqW0LDjIOsWI6B5JX70/7WonkdS5NOLdvTV+VR5hiLM3cJnOGei8U
	 iqhZr290u2Jt+eoGW4M1bW3ouTxLyJKam7qnzYU1bIHQJKo6KteqEr1Rh426kxayi6xNH
	 VTWB31/8LFb0e7/b6d0vYoJrSbadgsnkqvyPKAagcHcJKGsstLF1Zjyogn9RBxUvhMg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=foxmail.com;
	spf=pass smtp.mailfrom=foxmail.com;
	dkim=pass header.d=foxmail.com header.i=@foxmail.com header.a=rsa-sha256 header.s=s201512 header.b=PAC7R8yT;
	arc=none smtp.remote-ip=203.205.221.173
Received: from out203-205-221-173.mail.qq.com (out203-205-221-173.mail.qq.com [203.205.221.173])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58AFE606A8BF
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 12:24:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 58AFE606A8BF
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=foxmail.com header.i=@foxmail.com header.a=rsa-sha256 header.s=s201512 header.b=PAC7R8yT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1794572685;
	bh=1/xGQFJzRlf+R2dUsEBhYB/5ASb9U6Kk4vCgR9M14zg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PAC7R8yTApwrwKrGDDyhSYOw0k4Y/42HZW71VYTYstQnE7Io+rBOv8dQ6JUnxTfEt
	 yaYy4d0FHOPQ62Q+cqGzcv8j3bQFWC/wdEWNENp7yO5Y2UpZFrzwBuuNwM49hqsAO1
	 L1eQafeOWeomg91Y3sQOSGsCqKSfYemR4JPiI/iQ=
Received: from localhost.localdomain ([240e:3bb:3033:7d41:3d43:876a:14ed:84bb])
	by newxmesmtplogicsvrsza53-0.qq.com (NewEsmtp) with SMTP
	id 6280BA3F; Fri, 13 Nov 2026 20:24:40 +0800
X-QQ-mid: xmsmtpt1794572683tqu1yh0qb
Message-ID: <tencent_76692FA5A375ED2DD8652E064B0A6BA09007@qq.com>
X-QQ-XMAILINFO: MOnz+xTS1+9iC/1dk0H+1Ga/44N3UWCQpZctIZcJOItdm+k9lKelz40IEl4EZA
	 byQPkv6XdMFTnoJVGEX1rJjvx3/Q6u4tbLxkDHP1RVQJzk9KHIEtYy0EnCWU+0HQQxDRA4C/kEAS
	 71jsMSLWPg5s4ScfZax7my8OMuw6tXm0Qm+cWUktALkoPo4hDWrPqDBMtKzIHmiqoS8R3X2kdsdk
	 CgxzlZ4Ztbw5vCfuEhS5lxU4ZbQArNOw1sY55Ckv2gLI+kuVo2ElxLDw4QlSR/yPumPdc1JB6aJJ
	 5bDYe9lba+bMvJ6H7bOu44H59cTmmF7ip0BmkcYbu5NQRAw3DtZNBftuGM+mko2dCL8k1EoWiDjq
	 kXrHw/vcCZnLQv/EeFw1Hrjr5It6NDL61K3vGiQJ3ckFFGWGnEnj7ih/hE82qSAgwkkh591vkzFu
	 43/eCTDMkuZpGToKzvs2H661IB+0r6R2P+2jlv/Cr+BZ2BRyqZnTHEJloSm8qXJ+vfAdCrhZ+iCd
	 hQr3wbvCjFt1etfDr4tZDXVEE8ZLSsGlDNG2ahAGLwi7+VhcqLorC9kF0RHObg0umuQtIp9OpHkX
	 aMeSBtN3CeJsv2yCII/vsuFQCDl1gVG39fQn+515M+dYqFZmhWIuwmxnH8uHv0d9t8YZLIDjp6LZ
	 y+qEJ0/N9ZQx/Y0Vbed3LJL605zwlCiMO+ZHF2YAoIyFrdiy/S6OzwyUSW1vmjMrHT3HxkGiQZ2N
	 dTnK1sDg/7Og6bz6vvvMbQe6PZDTECKAmScN2q2213K8oBmQ5jA8Nva1j5GtlpLLQ1pr/j3EHf2z
	 qa0AohxbaQc1ZHWCFJg7uKTora8+yWBGA1+Dx9dDhbcbJ/9EEFna7jcGzKxEZovNWFqcd6w/E2Sw
	 ehiSiw38IJavDcbVJ8D1HJhXZbGRKyu+f1i8lUVEp3P+4jvjwRN/u51vSjbAZPaswmdLZa+zvQ4Q
	 3GvH5Y7SoES8NYO9QwJk4EGx4fJ0hGDnf+EU1wXtLYQrE2BperpI5SlQO1zEpt2y8tbGvefmKh/+
	 Cir6esg337FbyuUW/hvgOp6DhlS+62eCyKJU03KYNXKGPdc4Xb/8dE/YSiC+ZPv6U3lIjXwYqN3r
	 P+iyot
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
From: memoriaru@foxmail.com
To: netdev@vger.kernel.org,
	daniel.machon@microchip.com
Cc: Steen.Hegelund@microchip.com,
	UNGLinuxDriver@microchip.com,
	memoriaru@foxmail.com
Subject: [PATCH net v4 1/2] net: sparx5: fix RX ring stall on frames from inactive ports
Date: Fri, 13 Nov 2026 20:24:38 +0800
X-OQ-MSGID: <20261113122439.26292-2-memoriaru@foxmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20261113122439.26292-1-memoriaru@foxmail.com>
References: <20261110105239.5olhrlwa3mck74f4@DEN-DL-M70577>
 <20261113122439.26292-1-memoriaru@foxmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zhang Hewei <memoriaru@foxmail.com>

When the FDMA RX path receives a frame whose source port does not map
to an active netdev, sparx5_fdma_rx_get_frame() logs an error, flushes
the extraction FIFO and returns false - without advancing the FDMA
software cursor and without releasing the skb, which has already been
extended with skb_put().

The DCB for this frame still carries its hardware DONE bit, so the next
NAPI poll picks up the same DCB, takes the same inactive-port branch and
returns false again. The software cursor never moves past this DCB, so
RX traffic on all ports stalls until the module is reloaded.

Treat a bogus frame as consumed: free the skb, clear its slot in the
rx->skb[][] array and return true, so the NAPI loop advances past the
DB the same way it does for any other received frame. The slot is
refilled by sparx5_fdma_rx_dataptr_cb() when the DCB is recycled. The
extraction FIFO flush is dropped since the frame is already consumed
into the DB, and the error is ratelimited.

Found by code inspection; the stall needs the hardware to emit a frame
with an invalid source port, which cannot be triggered without hardware.

Fixes: 10615907e9b5 ("net: sparx5: switchdev: adding frame DMA functionality")
Signed-off-by: Zhang Hewei <memoriaru@foxmail.com>
---
 drivers/net/ethernet/microchip/sparx5/sparx5_fdma.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_fdma.c b/drivers/net/ethernet/microchip/sparx5/sparx5_fdma.c
index 15ec9b0..e35ef0e 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_fdma.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_fdma.c
@@ -157,9 +157,11 @@ static bool sparx5_fdma_rx_get_frame(struct sparx5 *sparx5, struct sparx5_rx *rx
 		       sparx5->ports[fi.src_port] :
 		       NULL;
 	if (!port || !port->ndev) {
-		dev_err(sparx5->dev, "Data on inactive port %d\n", fi.src_port);
-		sparx5_xtr_flush(sparx5, XTR_QUEUE);
-		return false;
+		dev_err_ratelimited(sparx5->dev, "Data on inactive port %d\n",
+				    fi.src_port);
+		dev_kfree_skb_any(skb);
+		rx->skb[fdma->dcb_index][fdma->db_index] = NULL;
+		return true;
 	}
 	skb->dev = port->ndev;
 	skb_pull(skb, IFH_LEN * sizeof(u32));
-- 
2.39.5 (Apple Git-154)

