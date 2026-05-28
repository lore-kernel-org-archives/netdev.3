Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22B033403F5;
	Thu, 28 May 2026 07:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779953798; cv=none; b=VQRqMwobS8B0fqJnf5MFT4l8bNeRhhkJ9aITwZVP4/ztNZiVEUQYvt5DqKZZdRAdMw4z3sBChK3bmjlNzPYnkepP3wyxapy8pIZXOJyVxCgrzlt6bW6WWD9dJ4NLATYdYlwXZJPCyxp5X2rzIueouq0eCDf4G68tt2r27F2c2sE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779953798; c=relaxed/simple;
	bh=G+0SBHPfajvCnZMGxHvYX09QmzjENo0xCYn8VkdJW7M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GM9gAJRk91uTctv8q/Rr7ZUyt98WS5Tyvo9t0Zmq7KB7vV1M5Xsl9PJsUPArJhULMfJrvZxSo2iNTP0qzItdiWg4g6xBYUQepqHdhjb7GV43OW5grfhYpAqxoDFxhM8HcOuvILyN54vAfxxsl0m1wcrjGfoBwbMNDRceWnlBf3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-03 (Coremail) with SMTP id rQCowACXsdh78BdqsP6tEg--.9382S2;
	Thu, 28 May 2026 15:36:27 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Kees Cook <kees@kernel.org>,
	Feng Yang <yangfeng@kylinos.cn>,
	Wentao Liang <vulab@iscas.ac.cn>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] netlink: fix skb refcount leak when dump start fails
Date: Thu, 28 May 2026 07:36:14 +0000
Message-Id: <20260528073614.1169858-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowACXsdh78BdqsP6tEg--.9382S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Ww4UCF4UJr4xCw1fGFW7Arb_yoW8JFWxpF
	W5KrW5trW5trWIqanrAF4rXFy7Z3WYqr45GryFkan7Ar1rG34jyF48uFZIvr43ZrZ5Kwnr
	XFnrKF4Y9rs8ZFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9j14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r106r15McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr
	1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxa
	n2IY04v7MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4
	AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE
	17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMI
	IF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4l
	IxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvf
	C2KfnxnUUI43ZEXa7VUbHa0JUUUUU==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiCREBA2oXzkBytQAAsu

__netlink_dump_start() takes an extra reference on the received skb
via refcount_inc(&skb->users) before storing it in cb->skb for the
dump callback to consume. If the subsequent netlink_dump() call fails
(line 2440), the dump was never started so the completion callback
that would normally release cb->skb will never be invoked.

In this case, the function returns the error directly without calling
kfree_skb(skb) to release the extra reference taken at entry.

Add kfree_skb(skb) before returning when netlink_dump() fails, so the
skb reference is properly released.

Fixes: b44d211e166b ("netlink: handle errors from netlink_dump()")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 net/netlink/af_netlink.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
index 2aeb0680807d..d904c1aad35d 100644
--- a/net/netlink/af_netlink.c
+++ b/net/netlink/af_netlink.c
@@ -2441,8 +2441,10 @@ int __netlink_dump_start(struct sock *ssk, struct sk_buff *skb,
 
 	sock_put(sk);
 
-	if (ret)
+	if (ret) {
+		kfree_skb(skb);
 		return ret;
+	}
 
 	/* We successfully started a dump, by returning -EINTR we
 	 * signal not to send ACK even if it was requested.
-- 
2.34.1

