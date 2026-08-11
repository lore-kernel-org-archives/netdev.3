Received: from out-189.mta1.migadu.com (mta1.migadu.com [37.59.57.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5C223438B0
	for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 03:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.59.57.117
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786420430; cv=none; b=Pa5tGHDSjiEDvHJJ2Zux5gCLxKHt7REskd3NvTxTHyww+9LFgaZiWORrGO28rFYn+nug/4zkyT2K2iySIrZ/L7QNUOz+ZiH9pioGmS/UN7Wvbf5WBtWErlO4pbj+X9EKeTSNi36X0nU0hRspCYWMOVzBMpGPxKauyZVIcxHNrek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786420430; c=relaxed/simple;
	bh=0rJzxZ1phuv+LKBNx9Cz/LPph5ZeOmzoZq8Zc6xJR/Y=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=ICDqMQqsyI/2mpau7TaJ9Q4L5uPwWLsR8WkWAVfS9XH9+864UWs1TIZCFjQSGL74ujfTI64sdPTEOj6XoeAIKwo/TEpCNHhIi+7mSklV/aFjuyYBBNiCAxGw6NjQzOcb+8ZHYdm3l2LitY2aJGRl1yUnk6kRm35hbmZhANEq81E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qMSsTmg/; arc=none smtp.client-ip=37.59.57.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qMSsTmg/"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1786420426;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=14z7dQLT2Hd319M0cDN957Ju2rIf1e7yxvZN9/rPaww=;
	b=qMSsTmg/sDCvNF9y94NGzGpaf8J7L7F0rv0KJ8+aai2HOdtK+ucQBoayQKo2kvCcuKDf2R
	qEKb/Y+Xmt3UnoPkHRx9rdGn+70vC9Q2t60EnFLxIR0U9V5y7nfDdHqo4w/U/a3TotQ6QF
	ry4lMaJmvPKGectkUbzVzBmqCm8Smdw=
From: Qingfang Deng <qingfang.deng@linux.dev>
To: =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
	linux-ppp@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Qingfang Deng <qingfang.deng@linux.dev>,
	Arnd Bergmann <arnd@arndb.de>,
	Guillaume Nault <gnault@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] pppox: drain queued packets on channel handoff
Date: Tue, 11 Aug 2026 11:53:10 +0800
Message-ID: <20260811035314.302878-1-qingfang.deng@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

PPPIOCGCHAN both returns the channel index and marks a PPPOX socket as
bound to generic PPP, despite its getter semantic. Packets received
before that transition are queued on sk_receive_queue, but a bound
socket is no longer readable. Such packets therefore remain queued until
the socket is destroyed.

After marking a socket bound, wait for receive paths that observed the
old state to finish queueing packets, and then drain the queue into
generic PPP.

Assisted-by: Codex:GPT-5.6
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Qingfang Deng <qingfang.deng@linux.dev>
---
 drivers/net/ppp/pppox.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/net/ppp/pppox.c b/drivers/net/ppp/pppox.c
index 5861a2f6ce3e..a6f72c813bef 100644
--- a/drivers/net/ppp/pppox.c
+++ b/drivers/net/ppp/pppox.c
@@ -74,7 +74,9 @@ int pppox_ioctl(struct socket *sock, unsigned int cmd, unsigned long arg)
 
 	switch (cmd) {
 	case PPPIOCGCHAN: {
+		struct sk_buff *skb;
 		int index;
+
 		rc = -ENOTCONN;
 		if (!(sk->sk_state & PPPOX_CONNECTED))
 			break;
@@ -85,7 +87,22 @@ int pppox_ioctl(struct socket *sock, unsigned int cmd, unsigned long arg)
 			break;
 
 		rc = 0;
+		/* PPPIOCGCHAN historically marks the userspace handoff to
+		 * generic PPP; pppd then attaches the returned channel to
+		 * /dev/ppp.
+		 */
 		sk->sk_state |= PPPOX_BOUND;
+		/* Let lockless receive paths finish queueing against the old
+		 * state.
+		 */
+		synchronize_net();
+		/* Drain packets queued before the handoff because a bound
+		 * socket is no longer readable.
+		 */
+		while ((skb = skb_dequeue(&sk->sk_receive_queue))) {
+			skb_orphan(skb);
+			ppp_input(&po->chan, skb);
+		}
 		break;
 	}
 	default:
-- 
2.43.0

