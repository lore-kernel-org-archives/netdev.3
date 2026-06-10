Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [13.75.44.102])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DDDB306B08
	for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 16:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.75.44.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781108347; cv=none; b=SDlP3CnBz6Tpi+/ys2D81tytGircUBZXXLrPmI+kdtwTvkIy4xj8gtc7gPSG78zFP/7Y6YeacS0Uw8KldwkGmN/Gfw1ZBDi7iHfiOBedjgQynbyvnmKHKvKI681L1eYxdSLYGotDiZLzn94mVlGDoq2epq89MbyGbBCd229TJv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781108347; c=relaxed/simple;
	bh=K6ZofjL03BA8CZvMc6y/6obeY6FFf6rEC5hfrcfuLR8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BooYxQJAkmpnkoNWpyZZcwoT7cr/CARTh+a1HK3Yiq99YQ2a1SeVvPS4ov8bsT037OLP/+QHTxFhvPWQUt3pOr4QrpuImZNK5IpcPB+1bIwq/2rpuonBoFMjX/w4I88P4NbeoiFkL8W2aBudoaswrGYDNtob3xNCBYhkngUJG2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lzu.edu.cn; spf=pass smtp.mailfrom=lzu.edu.cn; arc=none smtp.client-ip=13.75.44.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lzu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lzu.edu.cn
Received: from enjou-Legion-Y7000P-2019 (unknown [172.23.56.36])
	by app3 (Coremail) with SMTP id ywmowAB3tv5ajilqTEIfAA--.36361S3;
	Thu, 11 Jun 2026 00:18:39 +0800 (CST)
From: Ren Wei <n05ec@lzu.edu.cn>
To: netdev@vger.kernel.org
Cc: edumazet@google.com,
	pabeni@redhat.com,
	kuba@kernel.org,
	chia-yu.chang@nokia-bell-labs.com,
	ij@kernel.org,
	fmancera@suse.de,
	yuuchihsu@gmail.com,
	idosch@nvidia.com,
	herbert@gondor.apana.org.au,
	yuantan098@gmail.com,
	zcliangcn@gmail.com,
	bird@lzu.edu.cn,
	bronzed_45_vested@icloud.com,
	n05ec@lzu.edu.cn
Subject: [PATCH net 1/1] net: ipv4: bound TCP reordering sysctl writes
Date: Thu, 11 Jun 2026 00:18:23 +0800
Message-ID: <42cd30856907350e1b3834a3338364f9828a307b.1780979031.git.bronzed_45_vested@icloud.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1780979031.git.bronzed_45_vested@icloud.com>
References: <cover.1780979031.git.bronzed_45_vested@icloud.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:ywmowAB3tv5ajilqTEIfAA--.36361S3
X-Coremail-Antispam: 1UD129KBjvJXoWxJF47CFy8Kr1rCFW3CF1xXwb_yoW5urWDpF
	W5t3y5Kry5G34fK3s3AFWjvr1SyF4kJw13CwnrGr1SkwsrKr97CFyFqrWa9F1j9rW2kryU
	JF1qvFyDWw4qyFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUB01xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
	w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
	IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2
	jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x0267AKxVW8JVW8Jr1le2I262IYc4CY6c
	8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_
	Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwI
	xGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAa
	w2AFwI0_Jw0_GFylc2xSY4AK6svPMxAIw28IcxkI7VAKI48JMxAIw28IcVCjz48v1sIEY2
	0_Gr4l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
	jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2I
	x0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK
	8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I
	0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUonmRUUUUU
X-CM-SenderInfo: zqqvvuo6o23hxhgxhubq/1tbiAQsOCWopHlEI9gAAs-

From: Wyatt Feng <bronzed_45_vested@icloud.com>

Reject invalid `net.ipv4.tcp_reordering` values before they reach TCP
socket state. The sysctl is stored as an `int` but copied into the
`u32` `tp->reordering` field for new sockets, so negative writes wrap
to large values.

With `tcp_mtu_probing=2`, the wrapped value can overflow the
`tcp_mtu_probe()` size calculation and drive the MTU probing path into
an out-of-bounds read. Route `tcp_reordering` writes through
`proc_dointvec_minmax()` and clamp them to the per-netns range
`[1, tcp_max_reordering]`.

Apply the matching cross-check to `tcp_max_reordering` so the existing
invariant `tcp_max_reordering >= tcp_reordering` is preserved. This
keeps the fix at the sysctl boundary and avoids changing the TCP fast
path.

Fixes: 91cc17c0e5e5 ("[TCP]: MTUprobe: receiver window & data available checks fixed")
Cc: stable@vger.kernel.org
Reported-by: Yuan Tan <yuantan098@gmail.com>
Reported-by: Zhengchuan Liang <zcliangcn@gmail.com>
Reported-by: Xin Liu <bird@lzu.edu.cn>
Assisted-by: Codex:GPT-5.4
Signed-off-by: Wyatt Feng <bronzed_45_vested@icloud.com>
Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
---
 net/ipv4/sysctl_net_ipv4.c | 38 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 36 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/sysctl_net_ipv4.c b/net/ipv4/sysctl_net_ipv4.c
index c0e85cc171ae..c44afb9c321d 100644
--- a/net/ipv4/sysctl_net_ipv4.c
+++ b/net/ipv4/sysctl_net_ipv4.c
@@ -215,6 +215,40 @@ static int ipv4_fwd_update_priority(const struct ctl_table *table, int write,
 	return ret;
 }
 
+static int proc_tcp_reordering(const struct ctl_table *table, int write,
+			       void *buffer, size_t *lenp, loff_t *ppos)
+{
+	struct ctl_table tmp = {
+		.data		= table->data,
+		.maxlen		= table->maxlen,
+		.mode		= table->mode,
+		.extra1		= SYSCTL_ONE,
+	};
+	struct net *net;
+
+	net = container_of(table->data, struct net, ipv4.sysctl_tcp_reordering);
+	tmp.extra2 = &net->ipv4.sysctl_tcp_max_reordering;
+
+	return proc_dointvec_minmax(&tmp, write, buffer, lenp, ppos);
+}
+
+static int proc_tcp_max_reordering(const struct ctl_table *table, int write,
+				   void *buffer, size_t *lenp, loff_t *ppos)
+{
+	struct ctl_table tmp = {
+		.data		= table->data,
+		.maxlen		= table->maxlen,
+		.mode		= table->mode,
+	};
+	struct net *net;
+
+	net = container_of(table->data, struct net,
+			   ipv4.sysctl_tcp_max_reordering);
+	tmp.extra1 = &net->ipv4.sysctl_tcp_reordering;
+
+	return proc_dointvec_minmax(&tmp, write, buffer, lenp, ppos);
+}
+
 static int proc_tcp_congestion_control(const struct ctl_table *ctl, int write,
 				       void *buffer, size_t *lenp, loff_t *ppos)
 {
@@ -1058,7 +1092,7 @@ static struct ctl_table ipv4_net_table[] = {
 		.data		= &init_net.ipv4.sysctl_tcp_reordering,
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec
+		.proc_handler	= proc_tcp_reordering
 	},
 	{
 		.procname	= "tcp_retries1",
@@ -1293,7 +1327,7 @@ static struct ctl_table ipv4_net_table[] = {
 		.data		= &init_net.ipv4.sysctl_tcp_max_reordering,
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec
+		.proc_handler	= proc_tcp_max_reordering
 	},
 	{
 		.procname	= "tcp_dsack",
-- 
2.47.3

