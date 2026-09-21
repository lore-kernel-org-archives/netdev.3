Received: from out28-50.mail.aliyun.com (out28-50.mail.aliyun.com [115.124.28.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA1BB494817
	for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 12:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789995296; cv=none; b=C/WXrzmq94/H/Sdsg4JHWFmoy7wcrxHYZK1VVRmA9mm3gHruTDVKek7/F43J/9EdSpKLYcV8q4DhNcRmsuY+6pLcaf9q7U/3MJZRiXf6kC8pdbgD1iJyOVYv9BdR4XWSm72PWAB5MEQkNDFj7HwC3hp+r9nMT3GhFb4oyCTsqEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789995296; c=relaxed/simple;
	bh=8JJDfPlUnywI+9Ks+Wzk8unG7nzb3MR9RAgZfoLn6UE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KOm5bc5Tu0pvbCAmYv/YdywkPyhy1Ofzaj+Xp0OciTCzFk61IqqmVppd/m3ouysh5Y+kzMn2cjwwATApSCQ1KqcGEkM6PJfvon5+2KlxKwMA/EXhDZ6qa8dGRB73LvIsAZZj5vKlm1oDUyV7jR7fi10NhPxmwuS/LPdcswQ9Q08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com; spf=pass smtp.mailfrom=xiaopeng.com; dkim=pass (1024-bit key) header.d=xiaopeng.com header.i=@xiaopeng.com header.b=Z/JLS79k; arc=none smtp.client-ip=115.124.28.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xiaopeng.com header.i=@xiaopeng.com header.b="Z/JLS79k"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xiaopeng.com; s=default;
	t=1789995284; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=yVHrKVj2/nOyoE916yITBj/gHgU80Qab4efrA3aW2g0=;
	b=Z/JLS79kEndMNfMCF4BP0lWv66/f8NDIsJFOr4d4eLahp1hHTFokF4IMzSaEy6h8LuGOJvNmyIryBAOiWCVrOqmgHaXs7fVQeWMyZEhXdFxuHwaddgZB3UoLu6qO3fJ3w6e6MB/cyj4N9/NagMyEN7f+u3hXJ8K4GVeJJSdgZkk=
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.04438785|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0460115-0.00113364-0.952855;FP=13445336479053908080|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037028158;MF=fangxy@xiaopeng.com;NM=1;PH=DS;RN=9;RT=9;SR=0;TI=SMTPD_---.jJ3uDqN_1789995282;
Received: from localhost.localdomain(mailfrom:fangxy@xiaopeng.com fp:SMTPD_---.jJ3uDqN_1789995282 cluster:ay29)
          by smtp.aliyun-inc.com;
          Mon, 21 Sep 2026 20:54:43 +0800
From: Fang Xieyan <fangxy@xiaopeng.com>
To: netdev@vger.kernel.org,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	Cong Wang <xiyou.wangcong@gmail.com>
Subject: [PATCH net v2] net/sched: act_ife: validate metadata length before decoding
Date: Mon, 21 Sep 2026 20:54:41 +0800
Message-ID: <20260921125441.81459-1-fangxy@xiaopeng.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

skbmark_decode(), skbprio_decode() and skbtcindex_decode() read fixed-size
values from the TLV payload without validating its length.

A malformed IFE frame can declare a shorter payload, causing the decoders
to consume bytes beyond the declared metadata value:

[TLV type=IFE_META_SKBMARK len=4]
-> dlen == 0, but decode reads 4 bytes

The decoder may therefore set skb metadata from unintended input.

Validate the payload length before decoding and return -EINVAL for
invalid lengths. Read the values with get_unaligned_be32() and
get_unaligned_be16(), as TLV payloads are not guaranteed to be
aligned. Teach tcf_ife_decode() to log a decoder error separately
from an unknown metaid; both are counted as overlimits and decoding
continues with the remaining metadata.

The metadata length issue was found by an automated audit of the IFE
decode path at v6.18-rc7 and reproduced with a userspace sanitizer
model of the decode path. Compile-tested on x86_64 with defconfig and
NET_ACT_IFE=y: act_ife.o and the three act_meta_*.o build
warning-free.

Fixes: 084e2f6566d2 ("Support to encoding decoding skb mark on IFE action")
Fixes: 200e10f46936 ("Support to encoding decoding skb prio on IFE action")
Fixes: 408fbc22ef1e ("net sched ife action: Introduce skb tcindex metadata encap decap")
Assisted-by: Hawkeye:GLM-5.3-flash
Assisted-by: Qoder:Qwen3.8-Max
Signed-off-by: Fang Xieyan <fangxy@xiaopeng.com>
---

v1 -> v2:
- Read metadata values with get_unaligned_be32()/get_unaligned_be16()
  to avoid misaligned loads on strict-alignment architectures
  (Sashiko review).
- Count all undecodable metadata as overlimits in one place and log
  decoder errors separately from unknown metaids, printing the errno
  so future error types need no caller change (Sashiko review).
- Move the discovery and testing description into the commit message,
  per netdev-bot guidance.

v1: https://lore.kernel.org/all/20260920074245.79965-1-fangxy@xiaopeng.com/

 net/sched/act_ife.c             | 17 ++++++++++++-----
 net/sched/act_meta_mark.c       |  6 ++++--
 net/sched/act_meta_skbprio.c    |  6 ++++--
 net/sched/act_meta_skbtcindex.c |  6 ++++--
 4 files changed, 24 insertions(+), 11 deletions(-)

diff --git a/net/sched/act_ife.c b/net/sched/act_ife.c
index 9cea71fc1db3..2afd68983ece 100644
--- a/net/sched/act_ife.c
+++ b/net/sched/act_ife.c
@@ -737,6 +737,7 @@ static int tcf_ife_decode(struct sk_buff *skb, const struct tc_action *a,
 		u8 *curr_data;
 		u16 mtype;
 		u16 dlen;
+		int ret;
 
 		curr_data = ife_tlv_meta_decode(tlv_data, ifehdr_end, &mtype,
 						&dlen, NULL);
@@ -745,13 +746,19 @@ static int tcf_ife_decode(struct sk_buff *skb, const struct tc_action *a,
 			return TC_ACT_SHOT;
 		}
 
-		if (find_decode_metaid(skb, p, mtype, dlen, curr_data)) {
-			/* abuse overlimits to count when we receive metadata
-			 * but dont have an ops for it
+		ret = find_decode_metaid(skb, p, mtype, dlen, curr_data);
+		if (ret < 0) {
+			/* abuse overlimits to count metadata we cannot
+			 * decode: no ops for it, or the decoder rejected it
 			 */
-			pr_info_ratelimited("Unknown metaid %d dlen %d\n",
-					    mtype, dlen);
 			qstats_cpu_overlimit_inc(ife->common.cpu_qstats);
+
+			if (ret == -ENOENT)
+				pr_info_ratelimited("Unknown metaid %d dlen %d\n",
+						    mtype, dlen);
+			else
+				pr_info_ratelimited("Failed to decode metaid %d dlen %d err %d\n",
+						    mtype, dlen, ret);
 		}
 	}
 
diff --git a/net/sched/act_meta_mark.c b/net/sched/act_meta_mark.c
index ea0573cb8b2d..e2f61b22bf0f 100644
--- a/net/sched/act_meta_mark.c
+++ b/net/sched/act_meta_mark.c
@@ -10,6 +10,7 @@
 #include <linux/string.h>
 #include <linux/errno.h>
 #include <linux/skbuff.h>
+#include <linux/unaligned.h>
 #include <linux/rtnetlink.h>
 #include <linux/module.h>
 #include <linux/init.h>
@@ -28,9 +29,10 @@ static int skbmark_encode(struct sk_buff *skb, void *skbdata,
 
 static int skbmark_decode(struct sk_buff *skb, void *data, u16 len)
 {
-	u32 ifemark = *(u32 *)data;
+	if (len != sizeof(u32))
+		return -EINVAL;
 
-	skb->mark = ntohl(ifemark);
+	skb->mark = get_unaligned_be32(data);
 	return 0;
 }
 
diff --git a/net/sched/act_meta_skbprio.c b/net/sched/act_meta_skbprio.c
index 2df3133ce5ad..5cdb57931eab 100644
--- a/net/sched/act_meta_skbprio.c
+++ b/net/sched/act_meta_skbprio.c
@@ -10,6 +10,7 @@
 #include <linux/string.h>
 #include <linux/errno.h>
 #include <linux/skbuff.h>
+#include <linux/unaligned.h>
 #include <linux/rtnetlink.h>
 #include <linux/module.h>
 #include <linux/init.h>
@@ -33,9 +34,10 @@ static int skbprio_encode(struct sk_buff *skb, void *skbdata,
 
 static int skbprio_decode(struct sk_buff *skb, void *data, u16 len)
 {
-	u32 ifeprio = *(u32 *)data;
+	if (len != sizeof(u32))
+		return -EINVAL;
 
-	skb->priority = ntohl(ifeprio);
+	skb->priority = get_unaligned_be32(data);
 	return 0;
 }
 
diff --git a/net/sched/act_meta_skbtcindex.c b/net/sched/act_meta_skbtcindex.c
index 44547caead46..8803710c0905 100644
--- a/net/sched/act_meta_skbtcindex.c
+++ b/net/sched/act_meta_skbtcindex.c
@@ -10,6 +10,7 @@
 #include <linux/string.h>
 #include <linux/errno.h>
 #include <linux/skbuff.h>
+#include <linux/unaligned.h>
 #include <linux/rtnetlink.h>
 #include <linux/module.h>
 #include <linux/init.h>
@@ -28,9 +29,10 @@ static int skbtcindex_encode(struct sk_buff *skb, void *skbdata,
 
 static int skbtcindex_decode(struct sk_buff *skb, void *data, u16 len)
 {
-	u16 ifetc_index = *(u16 *)data;
+	if (len != sizeof(u16))
+		return -EINVAL;
 
-	skb->tc_index = ntohs(ifetc_index);
+	skb->tc_index = get_unaligned_be16(data);
 	return 0;
 }
 
-- 
2.50.1

