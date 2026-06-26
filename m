Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [13.76.78.106])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 009533DCD97
	for <netdev@vger.kernel.org>; Fri, 26 Jun 2026 08:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.76.78.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782462758; cv=none; b=F7fp6+GMpvuNkNVuo8Z3AD/v/zENubrsEokpCNUm8tuVUhRtPQo/bHhbRlZxxX5oclggRZJZ/VfHgEBJBhAa7sGhGfjo0/9wZcXc6Myd/+lC4PwBBoX1SPJZ0OpaFhL13zt6utrYK1AVEqnQ1GMoMI/ViThKtqb3sCXyEhlCmFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782462758; c=relaxed/simple;
	bh=8d8KaIrSD1KGU1nWo5XUDQ8dNqbRwBhwQYmpOtneAZg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VBE7J/wCv0Ux5D/8BSfrs3h2cjMbP5pTZUjGDpb0OwxkWITsZcwXZtrtWA5LGrMdGnhZGwhp6fy2eFnt8nyfCP2qAUjqhlxw+s77QID7kBbnWlSo6trc8Jzn/dfBUt0p53ceMY2rP64Z+7eMkOvmIA/IhmJQ3QlCdiC73a4kxxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lzu.edu.cn; spf=pass smtp.mailfrom=lzu.edu.cn; arc=none smtp.client-ip=13.76.78.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lzu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lzu.edu.cn
Received: from enjou-Legion-Y7000P-2019 (unknown [172.23.56.36])
	by app2 (Coremail) with SMTP id zQmowAC3UwsKOT5quAM5AA--.2706S2;
	Fri, 26 Jun 2026 16:32:11 +0800 (CST)
From: Ren Wei <n05ec@lzu.edu.cn>
To: netdev@vger.kernel.org
Cc: jhs@mojatatu.com,
	jiri@resnulli.us,
	davem@davemloft.net,
	petrm@mellanox.com,
	yuantan098@gmail.com,
	yifanwucs@gmail.com,
	tomapufckgml@gmail.com,
	zcliangcn@gmail.com,
	bird@lzu.edu.cn,
	bronzed_45_vested@icloud.com,
	n05ec@lzu.edu.cn
Subject: [PATCH net v2 1/1] net: sched: ets: avoid deficit wrap and bound empty dequeue  rounds
Date: Fri, 26 Jun 2026 16:32:00 +0800
Message-ID: <0e17a0309061300d31036a6a4c139919192f6373.1782379460.git.bronzed_45_vested@icloud.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQmowAC3UwsKOT5quAM5AA--.2706S2
X-Coremail-Antispam: 1UD129KBjvJXoWxJF1kGFWDtF4kKr45try7Wrg_yoW5Gr1kpF
	97JFZrKFZ7Wr1xX3W0krW7u3y3CwsrGw17Grs5t3s0qrs8Wa1Fq34jga4a9rs8KrZ5Cay2
	yF12q3sF9a1UAFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBY1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
	w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
	IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2
	z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcV
	Aq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j
	6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64
	vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0E
	n4kS14v26r1q6r43MxkIecxEwVCm-wCF04k20xvY0x0EwIxGrwCF04k20xvE74AGY7Cv6c
	x26r48MxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCj
	r7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6x
	IIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAI
	w20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x
	0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbGQ6JUUUUU==
X-CM-SenderInfo: zqqvvuo6o23hxhgxhubq/1tbiAQsKCWo+NlQASgAAs1

From: Wyatt Feng <bronzed_45_vested@icloud.com>

ETS keeps each DRR-style deficit in a u32 and replenishes it with
the configured quantum whenever the head packet is too large. Both
the quantum and qdisc_pkt_len() are user-controlled inputs: a large
quantum can wrap the deficit counter, while a tiny quantum combined
with an inflated qdisc_pkt_len() can force billions of iterations in
softirq context before any packet becomes eligible.

Store the deficit in u64 so replenishment cannot wrap the counter.
This keeps the existing dequeue logic unchanged while fixing the
overflow condition.

Bound one dequeue attempt to at most nbands * 2 ETS rotations, as
suggested in review. This avoids the livelock without adding heavier
logic to the fast path.

Fixes: dcc68b4d8084 ("net: sch_ets: Add a new Qdisc")
Cc: stable@vger.kernel.org
Reported-by: Yuan Tan <yuantan098@gmail.com>
Reported-by: Yifan Wu <yifanwucs@gmail.com>
Reported-by: Juefei Pu <tomapufckgml@gmail.com>
Reported-by: Zhengchuan Liang <zcliangcn@gmail.com>
Reported-by: Xin Liu <bird@lzu.edu.cn>
Suggested-by: Jamal Hadi Salim <jhs@mojatatu.com>
Assisted-by: Codex:GPT-5.4
Signed-off-by: Wyatt Feng <bronzed_45_vested@icloud.com>
Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
---
changes in v2:
  - Instead of doing a div() in the fast path, simply bound the loop per
    dequeue
  - v1 Link: https://lore.kernel.org/all/20260615103759.2404228-2-n05ec@lzu.edu.cn/


 net/sched/sch_ets.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/sched/sch_ets.c b/net/sched/sch_ets.c
index cb8cf437ce87..12a156ccb0a6 100644
--- a/net/sched/sch_ets.c
+++ b/net/sched/sch_ets.c
@@ -40,7 +40,7 @@ struct ets_class {
 	struct list_head alist; /* In struct ets_sched.active. */
 	struct Qdisc *qdisc;
 	u32 quantum;
-	u32 deficit;
+	u64 deficit;
 	struct gnet_stats_basic_sync bstats;
 	struct gnet_stats_queue qstats;
 };
@@ -463,6 +463,8 @@ ets_qdisc_dequeue_skb(struct Qdisc *sch, struct sk_buff *skb)
 static struct sk_buff *ets_qdisc_dequeue(struct Qdisc *sch)
 {
 	struct ets_sched *q = qdisc_priv(sch);
+	unsigned int max_loops = READ_ONCE(q->nbands) * 2;
+	unsigned int loops = 0;
 	struct ets_class *cl;
 	struct sk_buff *skb;
 	unsigned int band;
@@ -499,6 +501,8 @@ static struct sk_buff *ets_qdisc_dequeue(struct Qdisc *sch)
 
 		cl->deficit += READ_ONCE(cl->quantum);
 		list_move_tail(&cl->alist, &q->active);
+		if (++loops > max_loops)
+			goto out;
 	}
 out:
 	return NULL;
-- 
2.47.3

