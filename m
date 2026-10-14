Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B2281E5018;
	Wed, 14 Oct 2026 02:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791946051; cv=none; b=qpEoGN8s0IyL1S/pWOkU9SzFgJ1dGglqh3U45rN2ARHW8Ov8YxBGnjhd4wjujMPstdJywJmqcpDHbjDopiol+XLhNqdxZThiK9G/hcSH3CkYFtXwbnNFyjfVCEhUW51FdNocipkQCHfBBnZH9G4NXxAXkC98IXeRyKFRVN9eR4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791946051; c=relaxed/simple;
	bh=bU47t5azK/M7N5ZkIsA0t+/wEEAt4+XV8/3+W4p/3YA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dZZwSSAerckaZjDMj3xgzYu/c0tk00uJoKH+mWNoRV+HpnevMIkDxcnXwme4lrmXADAwU3cGXD578+LyvFhu0XHFTMtAgDy4Vl8hK80bxcxplEmoi4NjL4IiQCDDhWTBOR+USKjh+EiaEK+zlZuC6GKVP/7zMU/yBee3r4eOW3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Gs0Y6MT6; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Gs0Y6MT6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=an
	ruDG1Od+mlES8g/2ElYftNeL5m7dyUazrMLwBBX3k=; b=Gs0Y6MT6RlGL46T4xo
	K8eEJMiHOcQ/qm9YQsBvs6V1y6MMqBMxUZB5WG0GGO1MklNCQHS0kBDAHzuUYeEJ
	6qO2ei0JJfbCFhK5WOU1jOMv46mvJry7wSM/HwNbanyadK5VmYBe1i5L585o3Ao0
	kYfxApcEpp2/rNYB3sEGq5JXM=
Received: from localhost.localdomain (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PygvCgDHX1YS7c5qceXuEQ--.32271S2;
	Wed, 14 Oct 2026 10:46:44 +0800 (CST)
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
Subject: [PATCH net] net/sched: cls_fw: allow filter replace without re-specifying mask
Date: Wed, 14 Oct 2026 10:45:48 +0800
Message-Id: <20261014024548.37874-1-taowei@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PygvCgDHX1YS7c5qceXuEQ--.32271S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxZF1kXF1xXry8Cw4DArWxtFb_yoW5Cr1DpF
	1rK3WUGFsrtFyjgrWkJw1kK34a9rs3JryxuF10k34SyrZIgF4FqrWI9ayfW3yUGFZ7Ca42
	qFs0q3y5W39rArJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jtGYdUUUUU=
Sender: cs_taowei@163.com
X-CM-SenderInfo: xfvb3tprzhxqqrwthudrp/xtbC4RTOEGrO7RQCgAAA30

The fw classifier keeps the fwmark mask in the fw_head shared by all
filters of a tcf_proto instance, so the mask is a property of the head
and not of the individual filter: it is set when the head is created
and cannot be changed by a filter that is being replaced.  Nevertheless
fw_set_parms() rejects such a replace with -EINVAL whenever the head
mask is not the default 0xFFFFFFFF and the mask is not repeated on the
command line:

  # tc qdisc add dev lo clsact
  # tc filter add dev lo ingress prio 1 handle 1/0xffff fw classid 1:10
  # tc filter replace dev lo ingress prio 1 handle 1 fw classid 1:20
  RTNETLINK answers: Invalid argument

The same happens for tc filter change, which calls fw_set_parms() on the
existing filter as well.

The check only makes sense for a newly created filter, where the mask
has to be spelled out so that a filter cannot silently match on a
non-default mask inherited from the existing head.  A filter that is
being replaced already shares the head mask and inherits it unchanged,
so the check can be skipped for it.

Tell the two cases apart with a new "new_filter" argument to
fw_set_parms(), which fw_change() sets only when it creates a filter,
and report the error through extack instead of failing silently.

Fixes: b4e9b520ca5d ("[NET_SCHED]: Add mask support to fwmark classifier")
Signed-off-by: Wei Tao <taowei@kylinos.cn>
---
 net/sched/cls_fw.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/net/sched/cls_fw.c b/net/sched/cls_fw.c
index a462b262719c..f1b648a11e7c 100644
--- a/net/sched/cls_fw.c
+++ b/net/sched/cls_fw.c
@@ -204,7 +204,8 @@ static const struct nla_policy fw_policy[TCA_FW_MAX + 1] = {
 
 static int fw_set_parms(struct net *net, struct tcf_proto *tp,
 			struct fw_filter *f, struct nlattr **tb,
-			struct nlattr **tca, unsigned long base, u32 flags,
+			struct nlattr **tca, unsigned long base,
+			bool new_filter, u32 flags,
 			struct netlink_ext_ack *extack)
 {
 	struct fw_head *head = rtnl_dereference(tp->root);
@@ -229,8 +230,10 @@ static int fw_set_parms(struct net *net, struct tcf_proto *tp,
 		mask = nla_get_u32(tb[TCA_FW_MASK]);
 		if (mask != head->mask)
 			return err;
-	} else if (head->mask != 0xFFFFFFFF)
+	} else if (head->mask != 0xFFFFFFFF && new_filter) {
+		NL_SET_ERR_MSG(extack, "Mask must be provided for new filter");
 		return err;
+	}
 
 	if (tb[TCA_FW_CLASSID]) {
 		f->res.classid = nla_get_u32(tb[TCA_FW_CLASSID]);
@@ -291,7 +294,8 @@ static int fw_change(struct net *net, struct sk_buff *in_skb,
 			return err;
 		}
 
-		err = fw_set_parms(net, tp, fnew, tb, tca, base, flags, extack);
+		err = fw_set_parms(net, tp, fnew, tb, tca, base, false,
+				   flags, extack);
 		if (err < 0) {
 			tcf_exts_destroy(&fnew->exts);
 			kfree(fnew);
@@ -340,7 +344,7 @@ static int fw_change(struct net *net, struct sk_buff *in_skb,
 	f->id = handle;
 	f->tp = tp;
 
-	err = fw_set_parms(net, tp, f, tb, tca, base, flags, extack);
+	err = fw_set_parms(net, tp, f, tb, tca, base, true, flags, extack);
 	if (err < 0)
 		goto errout;
 
-- 
2.33.0

