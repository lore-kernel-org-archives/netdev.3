Received: from zg8tmja2lje4os4yms4ymjma.icoremail.net (zg8tmja2lje4os4yms4ymjma.icoremail.net [206.189.21.223])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03F4C47ECDE
	for <netdev@vger.kernel.org>; Wed,  6 May 2026 14:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=206.189.21.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778076531; cv=none; b=FOx/f3FI0aqlu6kVKT9URVj/8IthYlDkLD+d4SmkAUqizDWOgalL55+B2rcGiYQ64ZBWE/VO9bqAHBYD9yh6x9Yki/q8bnr0NyClcoou0l4cYqPeIHIK8YsJax918yb7YmXmEVQoNd9DS/g4BxjuZ61r0kjPie0Ukoqy72UR/Yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778076531; c=relaxed/simple;
	bh=ROOk0w9SKEEAK9ff07zoJzjD3NY6bKpCEg+mSClqRwI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SSBy9BMIHr/20PCj9s1oTSlc4aEjzLjU49e6mMADfHa0JByOywY1P3ACOXEJsRGn99gKnyfPQf1ZUZPkM/jco5C67k97Hn7J4hiNbS6zC0aXXzChP6EjNDNpYNNYfRvEPFUJHzL2VyDsFcXP6bvOrBH23bRHRJa4Bljcv/heZSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lzu.edu.cn; spf=pass smtp.mailfrom=lzu.edu.cn; arc=none smtp.client-ip=206.189.21.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lzu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lzu.edu.cn
Received: from enjou-Legion-Y7000P-2019.coin-barley.ts.net (unknown [172.23.56.36])
	by app1 (Coremail) with SMTP id ygmowADHO_xZS_tpFV36AA--.1198S2;
	Wed, 06 May 2026 22:08:26 +0800 (CST)
From: Ren Wei <n05ec@lzu.edu.cn>
To: netdev@vger.kernel.org
Cc: kuniyu@google.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	rao.shoaib@oracle.com,
	yuantan098@gmail.com,
	yifanwucs@gmail.com,
	tomapufckgml@gmail.com,
	bird@lzu.edu.cn,
	wangjiexun2025@gmail.com,
	n05ec@lzu.edu.cn
Subject: [PATCH net v3] af_unix: Reject SIOCATMARK on non-stream sockets
Date: Wed,  6 May 2026 22:08:23 +0800
Message-ID: <20260506140825.2987635-1-n05ec@lzu.edu.cn>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:ygmowADHO_xZS_tpFV36AA--.1198S2
X-Coremail-Antispam: 1UD129KBjvJXoW7AF1fAw18Gw43Gw45JFW8Zwb_yoW8Cr1Upa
	yak3WqyrZ0yr40v3ykta4F9r43JFs7GrWxK3s7Gas5ZF4qgw43XasYgF1DZr1DXFWDGFW8
	XrnF9F4qvw4DZrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBj1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
	w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
	IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2
	jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52
	x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWU
	GwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI4
	8JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kK
	e7AKxVWUtVW8ZwCY02Avz4vE-syl42xK82IYc2Ij64vIr41l42xK82IY6x8ErcxFaVAv8V
	W8GwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480
	Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7
	IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k2
	6cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUd-B_UUUUU=
X-CM-SenderInfo: zqqvvuo6o23hxhgxhubq/1tbiAQETCWn7AGQGuQABsS

From: Jiexun Wang <wangjiexun2025@gmail.com>

SIOCATMARK reports whether the receive queue is at the urgent mark for
MSG_OOB.

In AF_UNIX, MSG_OOB is supported only for SOCK_STREAM sockets.
SOCK_DGRAM and SOCK_SEQPACKET reject MSG_OOB in sendmsg() and recvmsg(),
so they should not support SIOCATMARK either.

Return -EOPNOTSUPP for non-stream sockets before checking the receive
queue.

Fixes: 314001f0bf92 ("af_unix: Add OOB support")
Cc: stable@kernel.org
Reported-by: Yuan Tan <yuantan098@gmail.com>
Reported-by: Yifan Wu <yifanwucs@gmail.com>
Reported-by: Juefei Pu <tomapufckgml@gmail.com>
Reported-by: Xin Liu <bird@lzu.edu.cn>
Suggested-by: Kuniyuki Iwashima <kuniyu@google.com>
Signed-off-by: Jiexun Wang <wangjiexun2025@gmail.com>
Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
---
Changes in v3:
- Update trailers.
- v2 Link: https://lore.kernel.org/all/20260413122916.1479959-1-n05ec@lzu.edu.cn/

Changes in v2:
- Rework the fix based on maintainer feedback.
- Drop the receive-queue locking approach and reject SIOCATMARK on
  non-stream sockets instead, since it is only meaningful for MSG_OOB.
- v1 Link: https://lore.kernel.org/netdev/f6cbbc8da90e95584847b5ceb60aae830d1631c2.1775731983.git.wangjiexun2025@gmail.com/

 net/unix/af_unix.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index e2d787ca3e74..1cbf36ea043b 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -3323,6 +3323,9 @@ static int unix_ioctl(struct socket *sock, unsigned int cmd, unsigned long arg)
 			struct sk_buff *skb;
 			int answ = 0;
 
+			if (sk->sk_type != SOCK_STREAM)
+				return -EOPNOTSUPP;
+
 			mutex_lock(&u->iolock);
 
 			skb = skb_peek(&sk->sk_receive_queue);
-- 
2.34.1

