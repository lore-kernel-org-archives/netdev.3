Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793947145;
	b=O8lVNCXF6em/o3aNLQYNUz2Nr1371ZkGeH6A+1PKJunrIEH6CVrHX1mODLalkSKExaZw
	 IVgen9UtPNDVT5BFKYCmX+JD6X5pd/8ptJZ8GEN9Rc6jTBrVf0CdTYPXKwam5uKy6LZ2y
	 jwKmK7jsap3mv5/wnYhCZ8uJKLZ0eb1fgblVI0WW4BAag/D+Y+qwvxzVCR8yWwfAwhPYa
	 AnG0TgaiHwwGYEwYO55jdDb5UzrduqMH1TfZsP7U25M+n8JphE2GKHqs+8r1yFgWu22Q0
	 y7GEamdxMEkYzElFXS3I+oK9wQHXhbIf9fAFjlCQTnPPWLnJbsj/zMTkR218YGEAYog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793947145;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:Sender:X-CM-SenderInfo;
	bh=7QFuBjv5ldosuAup+vJ03lRJS3eCcTcm45Vjx2AsFBA=;
	b=JqUY7LIpuaaH8bvA079LuhaccFpv0lgG8QCx79dePC9J2Ds4pGeU8kPWTodWBM/6CAHR
	 GWDi9iWKNzXTXrtT2Mhf5NaTupOeJNBjotdWyHqCbBNrBD+U7n+IkPAxWsxcTM2RVRv3G
	 o0oluARjJwJPgX7mnsOyI/GCVRwd9OlWN01d0e3zqYRLW6oiskNMt1Ymo3HCSYvDPsJ4V
	 LljmCL20fMpC+qT+ExhoRXajSdQhQcT44qfBWkpGvGh6i8UZwTXPz9slAdC3KuI4SnaLX
	 k0iJ21Ur1+U70xPJxBS4KgBcCFbyFQmwB4o1K2dOCfX0cZ3B4S/uuUEUI/ylXJklzcw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kylinos.cn;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=RvWji0Qe;
	arc=none smtp.remote-ip=117.135.210.5
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E18E1606A326;
	Fri,  6 Nov 2026 06:39:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E18E1606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=RvWji0Qe
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=7Q
	FuBjv5ldosuAup+vJ03lRJS3eCcTcm45Vjx2AsFBA=; b=RvWji0QeoP4YWwZsBe
	/yXgWGYhN5wIQ1he6cDc3TGUbZCg+o1exnLra1LffNP9U/d2TJDLDNp1v1L39aeX
	iZ/XQ+vMNGAP1lPpiaT34ufUtaCGpHXyYj+wc/RwNzpvgLFK8flFPsqSa95HSfda
	43Kd4DVuM9lQqRm16st7Gay2o=
Received: from localhost.localdomain (unknown [])
	by gzsmtp1 (Coremail) with SMTP id PCgvCgBn7+bide1q0tZXDw--.54265S2;
	Fri, 06 Nov 2026 14:38:26 +0800 (CST)
From: Wei Tao <taowei@kylinos.cn>
To: jhs@mojatatu.com,
	jiri@resnulli.us,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wei Tao <taowei@kylinos.cn>
Subject: [PATCH net-next v2] net/sched: cls_flow: avoid integer overflow in perturb_period
Date: Fri,  6 Nov 2026 14:38:23 +0800
Message-Id: <20261106063823.99731-1-taowei@kylinos.cn>
X-Mailer: git-send-email 2.25.1
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PCgvCgBn7+bide1q0tZXDw--.54265S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxWr17JF4rJFykXrW8WF4fAFb_yoWrJr1rpF
	9xJa1ktw4kXFy7Gw4kCr1kW3W3Ww4xJFy8uF42k3y5AasrGFyvka10g34SgFsrCr4rAayS
	qF1Ygw40vF1qyFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jWWlkUUUUU=
Sender: cs_taowei@163.com
X-CM-SenderInfo: xfvb3tprzhxqqrwthudrp/xtbC-QOr7GrtdeNdXAAA3p

flow_change() calculates perturb_period by directly multiplying
nla_get_u32(tb[TCA_FLOW_PERTURB]) by HZ, without any overflow
protection. Since perturb_period is a u32, the multiplication
overflows when the value from netlink exceeds UINT_MAX / HZ.
The result can be an unexpectedly short period or even zero.

  # tc qdisc add dev lo clsact
  # tc filter add dev lo ingress protocol ip pref 1 handle 1 flow \
        hash keys src perturb 42949673 baseclass 1:10

With HZ=100, 42949673*100=4294967300, but UINT_MAX is 4294967295,
so the product wraps to 4 jiffies.

Both the filter-modify and filter-create paths in flow_change()
are affected.

Since perturb_period is ultimately fed to mod_timer(), and
calc_wheel_index() internally casts delta to signed long for
comparison, reject values greater than INT_MAX / HZ. Besides
preventing the u32 multiplication from wrapping, this also
keeps the relative timeout within the signed-long range on
32-bit systems.

The missing check was noticed while reviewing commit 7ca52541c05c
("net_sched: sch_sfq: reject invalid perturb period"). An
LLM-assisted analysis of the same pattern then showed that cls_flow
performs the same unchecked seconds-to-jiffies conversion in both
its create and change paths, and needs the same range check.

Tested on aarch64 with CONFIG_HZ=100:

  # tc qdisc add dev lo clsact
  # tc filter add dev lo ingress protocol ip pref 1 handle 1 flow \
        hash keys src perturb 42949673 baseclass 1:10
  Error: cls_flow: invalid perturb period.

  # tc filter add dev lo ingress protocol ip pref 1 handle 1 flow \
        hash keys src perturb 100 baseclass 1:10
  # tc filter show dev lo ingress | cut -d' ' -f9-
  handle 0x1 hash keys src baseclass 1:10 perturb 100sec

  # tc filter change dev lo ingress protocol ip pref 1 handle 1 flow \
        hash keys src perturb 42949673 baseclass 1:10
  Error: cls_flow: invalid perturb period.
  # tc filter show dev lo ingress | cut -d' ' -f9-
  handle 0x1 hash keys src baseclass 1:10 perturb 100sec

Signed-off-by: Wei Tao <taowei@kylinos.cn>
---
v2: https://lore.kernel.org/netdev/20261016040330.59041-1-taowei@kylinos.cn/
  - drop the Fixes and Cc: stable tags: this is hardening
  - describe how the issue was found and add the tested commands
 net/sched/cls_flow.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/net/sched/cls_flow.c b/net/sched/cls_flow.c
index 2ef449706638..4f2d63722e16 100644
--- a/net/sched/cls_flow.c
+++ b/net/sched/cls_flow.c
@@ -408,6 +408,7 @@ static int flow_change(struct net *net, struct sk_buff *in_skb,
 	u32 keymask = 0;
 	u32 mode;
 	int err;
+	u32 val;
 
 	if (opt == NULL)
 		return -EINVAL;
@@ -486,7 +487,13 @@ static int flow_change(struct net *net, struct sk_buff *in_skb,
 		if (tb[TCA_FLOW_PERTURB]) {
 			if (mode != FLOW_MODE_HASH)
 				goto err2;
-			perturb_period = nla_get_u32(tb[TCA_FLOW_PERTURB]) * HZ;
+			val = nla_get_u32(tb[TCA_FLOW_PERTURB]);
+			if (val > INT_MAX / HZ) {
+				NL_SET_ERR_MSG_MOD(extack, "invalid perturb period");
+				err = -EINVAL;
+				goto err2;
+			}
+			perturb_period = val * HZ;
 		}
 	} else {
 		err = -EINVAL;
@@ -504,7 +511,13 @@ static int flow_change(struct net *net, struct sk_buff *in_skb,
 		if (tb[TCA_FLOW_PERTURB]) {
 			if (mode != FLOW_MODE_HASH)
 				goto err2;
-			perturb_period = nla_get_u32(tb[TCA_FLOW_PERTURB]) * HZ;
+			val = nla_get_u32(tb[TCA_FLOW_PERTURB]);
+			if (val > INT_MAX / HZ) {
+				NL_SET_ERR_MSG_MOD(extack, "invalid perturb period");
+				err = -EINVAL;
+				goto err2;
+			}
+			perturb_period = val * HZ;
 		}
 
 		if (TC_H_MAJ(baseclass) == 0) {

base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
-- 
2.25.1

