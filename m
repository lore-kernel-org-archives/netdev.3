Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [4.193.249.245])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FE6C1A3029
	for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 02:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.193.249.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782701226; cv=none; b=tfiadPAj1Olb0qOMfbAPiB/hE4+cYa1oUSJ9K5A98rrCQWkE48t1g+b2bynSFJZf0yglW6mtO261vFiSg7aNVbLOZEzQLYrLZLrkiPouviY3E9Kg30ROOmv+c0uObJkjuCPIEMOJZCJwXuEkqTLO3kGwnJT0tTLL2ShT/6mTQJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782701226; c=relaxed/simple;
	bh=/akT817bRHgq9XHuX/qUE5uCkdu/0KK7dS+40ojAiCo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JrPyIyF3n6muXrw0bsWmG8Y2srHsfhATQ7J/9FxV+b3AO2CidLIoYq8SXGKCGcE3+wbFmVf91F3vJsY0JApH73F8xdPgVmwxcJMRaYOg8hjGm7y+XslTLQqFTmMdHTsOCYfqWX/R5ZOANiOBH+q1IRPERaJ3EQ36rV8gSzSkygI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lzu.edu.cn; spf=pass smtp.mailfrom=lzu.edu.cn; arc=none smtp.client-ip=4.193.249.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lzu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lzu.edu.cn
Received: from enjou-Legion-Y7000P-2019 (unknown [117.157.85.28])
	by app1 (Coremail) with SMTP id ygmowAD3E7593EFqD3XCAA--.7547S4;
	Mon, 29 Jun 2026 10:46:36 +0800 (CST)
From: Ren Wei <n05ec@lzu.edu.cn>
To: netdev@vger.kernel.org
Cc: jhs@mojatatu.com,
	jiri@resnulli.us,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	cong.wang@bytedance.com,
	peilin.ye@bytedance.com,
	gnault@redhat.com,
	yuantan098@gmail.com,
	yifanwucs@gmail.com,
	tomapufckgml@gmail.com,
	zcliangcn@gmail.com,
	bird@lzu.edu.cn,
	bronzed_45_vested@icloud.com,
	n05ec@lzu.edu.cn
Subject: [PATCH net 2/2] net/sched: act_vlan: skip pop_eth on non-Ethernet devices
Date: Mon, 29 Jun 2026 10:46:04 +0800
Message-ID: <40fe2d7dfce13411bfbe9271c0f7c54fb7e88e3b.1782548651.git.bronzed_45_vested@icloud.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1782548651.git.bronzed_45_vested@icloud.com>
References: <cover.1782548651.git.bronzed_45_vested@icloud.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:ygmowAD3E7593EFqD3XCAA--.7547S4
X-Coremail-Antispam: 1UD129KBjvJXoW7tF13CF45uw15Ary8ZFWxCrg_yoW8AF47pF
	ZxurWDKFZ7Jr17Gr1kC3WUAr4jgr4DGrsxKr95K34UZw1xKrn5Kr90ganI9r1kArWYkay5
	Ary29rn8Ga1qvrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBI1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
	w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
	IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2
	z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcV
	Aq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j
	6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64
	vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0E
	n4kS14v26r4a6rW5MxkIecxEwVAFwVW8JwCF04k20xvY0x0EwIxGrwCF04k20xvE74AGY7
	Cv6cx26r4rMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2Iq
	xVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42
	IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY
	6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aV
	CY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7sRiCJPtUUUUU==
X-CM-SenderInfo: zqqvvuo6o23hxhgxhubq/1tbiAQENCWpA2VUKzAAAsk

From: Wyatt Feng <bronzed_45_vested@icloud.com>

TCA_VLAN_ACT_POP_ETH removes a base Ethernet header, but tcf_vlan_act()
currently runs it on any device type.

On non-Ethernet devices such as loopback, this can strip the linear
ETH_HLEN bytes from an skb that later reaches code paths which still
expect an Ethernet header, leading to a BUG in __skb_pull(). This is a
short-packet handling bug caused by applying an Ethernet-only transform
to a non-Ethernet skb.

Treat POP_ETH as an Ethernet-only action and leave non-Ethernet packets
unchanged.

Fixes: 19fbcb36a39e ("net/sched: act_vlan: Add {POP,PUSH}_ETH actions")
Cc: stable@vger.kernel.org
Reported-by: Yuan Tan <yuantan098@gmail.com>
Reported-by: Yifan Wu <yifanwucs@gmail.com>
Reported-by: Juefei Pu <tomapufckgml@gmail.com>
Reported-by: Zhengchuan Liang <zcliangcn@gmail.com>
Reported-by: Xin Liu <bird@lzu.edu.cn>
Assisted-by: Codex:GPT-5.4
Signed-off-by: Wyatt Feng <bronzed_45_vested@icloud.com>
Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
---
 net/sched/act_vlan.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/sched/act_vlan.c b/net/sched/act_vlan.c
index 6a375fdc63dd..b77f649ae204 100644
--- a/net/sched/act_vlan.c
+++ b/net/sched/act_vlan.c
@@ -4,6 +4,7 @@
  */
 
 #include <linux/module.h>
+#include <linux/if_arp.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/skbuff.h>
@@ -76,6 +77,9 @@ TC_INDIRECT_SCOPE int tcf_vlan_act(struct sk_buff *skb,
 		__vlan_hwaccel_put_tag(skb, p->tcfv_push_proto, tci);
 		break;
 	case TCA_VLAN_ACT_POP_ETH:
+		if (!skb->dev || skb->dev->type != ARPHRD_ETHER)
+			goto out;
+
 		err = skb_eth_pop(skb);
 		if (err)
 			goto drop;
-- 
2.47.3

