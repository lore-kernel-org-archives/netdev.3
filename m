Received: from out28-217.mail.aliyun.com (out28-217.mail.aliyun.com [115.124.28.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA8A733557D
	for <netdev@vger.kernel.org>; Sun, 20 Sep 2026 07:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789890179; cv=none; b=RPu7VCATrBlPIeJwEDyLm/l3InVMmnRmUlmM3ymyHI0IKqRO3Y1UdaMZzEPTN5oAwodPAuzVhpmTbY79YlN7ebwFXpxgDa1TlwdDKW1XPtj2jAcvCm332wdyB2TIDvp91J9dZoRnuT5VKv9m79ZzVxVds2GTvlR8ugvfapjEAHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789890179; c=relaxed/simple;
	bh=TeR/SPfjdxcP6WVL+nTBzCnu7nNJ7Lnzpml+TCVQWtk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=vBWjyK6tb28JBj3LW+Jp6/oK2rw8udfYQxfMb+j/zW+vqD9ebli7MiW0VkkeLGfUClhzWTQlmCp9AcagWFoUg+XUAHdJHCSxXiFtBRP92zXjw4vRG357+WMOa/OBPDzHS5IRhPeLQIsLFwSbpsmO8GKJatqScfANHtPzM0pWEE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com; spf=pass smtp.mailfrom=xiaopeng.com; dkim=pass (1024-bit key) header.d=xiaopeng.com header.i=@xiaopeng.com header.b=XJmwYyUg; arc=none smtp.client-ip=115.124.28.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xiaopeng.com header.i=@xiaopeng.com header.b="XJmwYyUg"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xiaopeng.com; s=default;
	t=1789890167; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=6ClCO1rikCE+xXSYx0XHhuqUuxt3KRHtViZyWkQmCMI=;
	b=XJmwYyUg11y9aF/oJ8iNjHA4jHMV0zcCxaivbYFTOsk0rVF5xYch0J0yd/8ZTwKMrlOPJn5x0VRtSBLLKHEyBxu893skIFrmyHhJ5JyZ8w+0+SJ+xv6wYk3nNLqp4KIG149kUpd0qFsSdqVbbpUK6yvUvdrr/7joVFHE5lkYvX0=
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.04898971|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0407612-0.000434714-0.958804;FP=11444322088015112353|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033045213054;MF=fangxy@xiaopeng.com;NM=1;PH=DS;RN=9;RT=9;SR=0;TI=SMTPD_---.jHw1VNB_1789890165;
Received: from localhost.localdomain(mailfrom:fangxy@xiaopeng.com fp:SMTPD_---.jHw1VNB_1789890165 cluster:ay29)
          by smtp.aliyun-inc.com;
          Sun, 20 Sep 2026 15:42:47 +0800
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
Subject: [PATCH net] net/sched: act_ife: validate metadata length before decoding
Date: Sun, 20 Sep 2026 15:42:45 +0800
Message-ID: <20260920074245.79965-1-fangxy@xiaopeng.com>
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
invalid lengths. The caller treats decoder failures as per-TLV errors
and continues decoding the remaining metadata.

Fixes: 084e2f6566d2 ("Support to encoding decoding skb mark on IFE action")
Fixes: 200e10f46936 ("Support to encoding decoding skb prio on IFE action")
Fixes: 408fbc22ef1e ("net sched ife action: Introduce skb tcindex metadata encap decap")
Assisted-by: Hawkeye:GLM-5.3-flash
Assisted-by: Qoder:Qwen3.8-Max
Signed-off-by: Fang Xieyan <fangxy@xiaopeng.com>
---

Found by auditing the IFE decode path at v6.18-rc7. The malformed
metadata cases were reproduced with a userspace sanitizer model of
the decode path, which reported reads of size 4/2 for dlen values
smaller than the expected metadata size.

Compile-tested on x86_64 with defconfig and NET_ACT_IFE=y: act_ife.o
and the three act_meta_*.o build warning-free.

 net/sched/act_meta_mark.c       | 6 +++++-
 net/sched/act_meta_skbprio.c    | 6 +++++-
 net/sched/act_meta_skbtcindex.c | 6 +++++-
 3 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/net/sched/act_meta_mark.c b/net/sched/act_meta_mark.c
index ea0573cb8b2d..3a7d568df0da 100644
--- a/net/sched/act_meta_mark.c
+++ b/net/sched/act_meta_mark.c
@@ -28,8 +28,12 @@ static int skbmark_encode(struct sk_buff *skb, void *skbdata,
 
 static int skbmark_decode(struct sk_buff *skb, void *data, u16 len)
 {
-	u32 ifemark = *(u32 *)data;
+	u32 ifemark;
 
+	if (len != sizeof(ifemark))
+		return -EINVAL;
+
+	ifemark = *(u32 *)data;
 	skb->mark = ntohl(ifemark);
 	return 0;
 }
diff --git a/net/sched/act_meta_skbprio.c b/net/sched/act_meta_skbprio.c
index 2df3133ce5ad..fa4ba4269ca0 100644
--- a/net/sched/act_meta_skbprio.c
+++ b/net/sched/act_meta_skbprio.c
@@ -33,8 +33,12 @@ static int skbprio_encode(struct sk_buff *skb, void *skbdata,
 
 static int skbprio_decode(struct sk_buff *skb, void *data, u16 len)
 {
-	u32 ifeprio = *(u32 *)data;
+	u32 ifeprio;
 
+	if (len != sizeof(ifeprio))
+		return -EINVAL;
+
+	ifeprio = *(u32 *)data;
 	skb->priority = ntohl(ifeprio);
 	return 0;
 }
diff --git a/net/sched/act_meta_skbtcindex.c b/net/sched/act_meta_skbtcindex.c
index 44547caead46..48f001ada8f6 100644
--- a/net/sched/act_meta_skbtcindex.c
+++ b/net/sched/act_meta_skbtcindex.c
@@ -28,8 +28,12 @@ static int skbtcindex_encode(struct sk_buff *skb, void *skbdata,
 
 static int skbtcindex_decode(struct sk_buff *skb, void *data, u16 len)
 {
-	u16 ifetc_index = *(u16 *)data;
+	u16 ifetc_index;
 
+	if (len != sizeof(ifetc_index))
+		return -EINVAL;
+
+	ifetc_index = *(u16 *)data;
 	skb->tc_index = ntohs(ifetc_index);
 	return 0;
 }
-- 
2.50.1

