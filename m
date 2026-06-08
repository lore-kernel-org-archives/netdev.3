Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [52.229.168.213])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35D6A38644F
	for <netdev@vger.kernel.org>; Mon,  8 Jun 2026 07:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.229.168.213
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780904904; cv=none; b=J7pxfJ/AGJdUZwOx4g+VUM2Xt9ulbLFBfmofb5mVz0Y2H7DWbNn6IGM12fhMClhZTqd8dcemvZ9OHandSVft36Z4cgdYoSo/fp86lMfQuuUiYijRQbr32zSlC1dh5ptik29k5P2/eGUkGv9IXpEhu7zU1l2i/QP+vWMjS27kxFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780904904; c=relaxed/simple;
	bh=Qj7s07iFcTLS2uOH/T7a9sE9e+uxOBRsWDCWj3+mg2k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D4ToUAXI1vhKPe8Pa2v5f7+b6ZRZa6T1VRWH3r4Qr1WcySOIZuupLufbyrAJ0S8DtiOyQJguq5wK554qkNT+uzQIppuxmMcuyp6oOG9PSq5wzozd1lRFOc6MZPSEKh3Wee+hhnikecLO8YbrVoJgzuSqS+lBo14yfcgtWp/MGnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lzu.edu.cn; spf=pass smtp.mailfrom=lzu.edu.cn; arc=none smtp.client-ip=52.229.168.213
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lzu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lzu.edu.cn
Received: from enjou-Legion-Y7000P-2019 (unknown [172.23.56.36])
	by app1 (Coremail) with SMTP id ygmowACnycOncyZqzbRrAA--.51350S3;
	Mon, 08 Jun 2026 15:48:14 +0800 (CST)
From: Ren Wei <n05ec@lzu.edu.cn>
To: netdev@vger.kernel.org
Cc: yuantan098@gmail.com,
	yifanwucs@gmail.com,
	tomapufckgml@gmail.com,
	bird@lzu.edu.cn,
	zcliangcn@gmail.com,
	n05ec@lzu.edu.cn
Subject: [PATCH net v2 2/2] llc: conn: publish OUT_OF_SVC before draining timers
Date: Mon,  8 Jun 2026 15:46:54 +0800
Message-ID: <57032b976770880663b57b4ac5459d23e1b130a9.1780850934.git.zcliangcn@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <86c82b564186dd085fae59984ea481493341b823.1780850934.git.zcliangcn@gmail.com>
References: <86c82b564186dd085fae59984ea481493341b823.1780850934.git.zcliangcn@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:ygmowACnycOncyZqzbRrAA--.51350S3
X-Coremail-Antispam: 1UD129KBjvJXoW7KF17uFyfury5GF4kAw1xAFb_yoW8tF4fpr
	Zxur13KFZrWr9xAF9rJFWvqr4rXan5Gr17A3s8C3Z7uan7Xr1jk3yF9FZF9Fs0kr40kFWa
	yF4vqr1rCw4UArDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvG1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
	w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
	IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E
	87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c
	8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_
	Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwI
	xGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_JF0_Jw1lc2xSY4AK6svP
	MxAIw28IcxkI7VAKI48JMxAIw28IcVCjz48v1sIEY20_Gr4l4I8I3I0E4IkC6x0Yz7v_Jr
	0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY
	17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcV
	C0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY
	6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa
	73UjIFyTuYvjfUYCJmUUUUU
X-CM-SenderInfo: zqqvvuo6o23hxhgxhubq/1tbiAQwMCWolKdAPigAAs7

From: Zhengchuan Liang <zcliangcn@gmail.com>

llc_ui_release() drops the socket lock with release_sock() before it
calls llc_sk_free(). In that window, llc_conn_handler() can still take
bh_lock_sock() on the same socket and run the LLC state machine.

If teardown only deletes timers at the end of llc_sk_free(), that
concurrent packet path can still arm a timer again after teardown has
started. timer_delete_sync() only drains timer callbacks; it does not
wait for packet processing that races through llc_conn_handler().

Publish LLC_CONN_OUT_OF_SVC under sk->sk_lock.slock with bottom halves
disabled before synchronously deleting timers. bh_lock_sock() takes
that same lock, so teardown-time RX or timer work serialized there sees
the closed state and stops instead of rearming timers, which closes the
teardown window that can keep stale sockets active.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Reported-by: Yuan Tan <yuantan098@gmail.com>
Reported-by: Yifan Wu <yifanwucs@gmail.com>
Reported-by: Juefei Pu <tomapufckgml@gmail.com>
Reported-by: Xin Liu <bird@lzu.edu.cn>
Assisted-by: Codex:GPT-5.4
Signed-off-by: Zhengchuan Liang <zcliangcn@gmail.com>
Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
---
  - New in v2 to address the teardown timer race raised in review.
  - Publish LLC_CONN_OUT_OF_SVC before draining timers.
  - v1 link: https://lore.kernel.org/all/5f646c530f4a0820060499054c46b8dbecebd7be.1778638129.git.zlian064@ucr.edu/


 net/llc/llc_conn.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/llc/llc_conn.c b/net/llc/llc_conn.c
index 9602183d09d8..dba114929bdd 100644
--- a/net/llc/llc_conn.c
+++ b/net/llc/llc_conn.c
@@ -978,8 +978,9 @@ void llc_sk_free(struct sock *sk)
 {
 	struct llc_sock *llc = llc_sk(sk);
 
-	llc->state = LLC_CONN_OUT_OF_SVC;
-	/* Stop all (possibly) running timers */
+	spin_lock_bh(&sk->sk_lock.slock);
+	WRITE_ONCE(llc->state, LLC_CONN_OUT_OF_SVC);
+	spin_unlock_bh(&sk->sk_lock.slock);
 	llc_sk_stop_all_timers(sk, true);
 #ifdef DEBUG_LLC_CONN_ALLOC
 	printk(KERN_INFO "%s: unackq=%d, txq=%d\n", __func__,
-- 
2.47.3

