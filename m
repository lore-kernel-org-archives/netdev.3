Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 339032E7394
	for <netdev@vger.kernel.org>; Sat, 30 May 2026 05:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.164.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780118723; cv=none; b=mdHZzsabgecjbinNDojUsH6Sf2bIO2D6YN7ac+Kakd6mMGPYDtGhnB0d74hTzl/hVlh79y5w/fMuXpOPZdJM1zs38BaqHxjTyn9U4kWr2/ner6vh9eUTKWz391iVQfG1HJc/2wQ8ftvrzZKGVY8wACxw0v4hL6LwuH8KSsIKhF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780118723; c=relaxed/simple;
	bh=PXndydDzvMMxG/7LvtYcwjSlvFqVag+cmJs6/MAuFxw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cdk73kfAK1cjq7KCssi2/bUvO+sBNTS4Ua2K1lej5kVdFZ3NeHFy1J0Y7d+dEy8toqLY2hIXuyLGieB+vfwhcMvDpb7lR8aZ+rAkHzrWm26EjiZ9bTo8Ikew1COeRDbcgXIr1g52k2NDdgFLkK5EwbTgyvKiHsRAThYYVSL6ee4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lzu.edu.cn; spf=pass smtp.mailfrom=lzu.edu.cn; arc=none smtp.client-ip=162.243.164.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lzu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lzu.edu.cn
Received: from enjou-Legion-Y7000P-2019.coin-barley.ts.net (unknown [172.23.56.36])
	by app1 (Coremail) with SMTP id ygmowACHqMKsdBpqnfE_AA--.42025S3;
	Sat, 30 May 2026 13:25:03 +0800 (CST)
From: Ren Wei <n05ec@lzu.edu.cn>
To: netdev@vger.kernel.org
Cc: steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au,
	davem@davemloft.net,
	sd@queasysnail.net,
	yuantan098@gmail.com,
	yifanwucs@gmail.com,
	tomapufckgml@gmail.com,
	zcliangcn@gmail.com,
	bird@lzu.edu.cn,
	bronzed_45_vested@icloud.com,
	n05ec@lzu.edu.cn
Subject: [PATCH ipsec 1/1] xfrm: espintcp: wait for pending partial send before reuse
Date: Sat, 30 May 2026 13:24:55 +0800
Message-ID: <b05daae0607621114d3818722a46c543ab6ec6fb.1780040524.git.bronzed_45_vested@icloud.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1780040524.git.bronzed_45_vested@icloud.com>
References: <cover.1780040524.git.bronzed_45_vested@icloud.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:ygmowACHqMKsdBpqnfE_AA--.42025S3
X-Coremail-Antispam: 1UD129KBjvJXoW7tF13uw1fGrW5tFy3ury8Xwb_yoW8trW8pa
	4fWr9xKFyUtry29Fn7tF10vr4UGw4kXry7Xr9xtasrXr98Xr15ZFyvvF1avFn8uFZ7CrWY
	krsFva4qyw1UAa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBj1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
	w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
	IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2
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
X-CM-SenderInfo: zqqvvuo6o23hxhgxhubq/1tbiAQsDCWoZTE8LMQAAsK

From: Wyatt Feng <bronzed_45_vested@icloud.com>

espintcp keeps a single in-flight transmit in ctx->partial.  Before
building a new sk_msg, espintcp_sendmsg() first tries to flush that
state through espintcp_push_msgs().

For blocking callers, espintcp_push_msgs() may return success while the
previous partial send is still pending.  espintcp_sendmsg() then
reinitializes emsg->skmsg and reuses the same ctx->partial slot even
though the old send has not completed yet.

Wait for the pending partial send to drain before reusing ctx->partial.
Nonblocking callers keep the existing error handling, while blocking
callers sleep until the partial send can make progress.

This preserves the one-message-at-a-time design already used by the
espintcp transmit path and avoids overwriting an in-flight partial send.

Fixes: e27cca96cd68 ("xfrm: add espintcp (RFC 8229)")
Cc: stable@kernel.org
Reported-by: Yuan Tan <yuantan098@gmail.com>
Reported-by: Yifan Wu <yifanwucs@gmail.com>
Reported-by: Juefei Pu <tomapufckgml@gmail.com>
Reported-by: Zhengchuan Liang <zcliangcn@gmail.com>
Reported-by: Xin Liu <bird@lzu.edu.cn>
Assisted-by: Codex:GPT-5.4
Signed-off-by: Wyatt Feng <bronzed_45_vested@icloud.com>
Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
---
 net/xfrm/espintcp.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/net/xfrm/espintcp.c b/net/xfrm/espintcp.c
index a2756186e13a..f8513a19a3c8 100644
--- a/net/xfrm/espintcp.c
+++ b/net/xfrm/espintcp.c
@@ -340,11 +340,20 @@ static int espintcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t size)
 
 	lock_sock(sk);
 
-	err = espintcp_push_msgs(sk, msg->msg_flags & MSG_DONTWAIT);
-	if (err < 0) {
-		if (err != -EAGAIN || !(msg->msg_flags & MSG_DONTWAIT))
-			err = -ENOBUFS;
-		goto unlock;
+	while (emsg->len) {
+		err = espintcp_push_msgs(sk, msg->msg_flags & MSG_DONTWAIT);
+		if (err < 0) {
+			if (err != -EAGAIN || !(msg->msg_flags & MSG_DONTWAIT))
+				err = -ENOBUFS;
+			goto unlock;
+		}
+
+		if (!emsg->len)
+			break;
+
+		err = sk_stream_wait_memory(sk, &timeo);
+		if (err)
+			goto unlock;
 	}
 
 	sk_msg_init(&emsg->skmsg);
-- 
2.47.3

