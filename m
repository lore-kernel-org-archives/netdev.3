Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793946764;
	b=oyJhPTD03SKBLLd6WYUdiTOh0530C20ixibb9PN2MN0wfmtuVskfHFIOWRFTiMNbRTXI
	 GKQQEskBPhgztbx+olAbD7dkhVPFU44hVk92p/A4xTqtA6aD98pt9rFr0A7nagp6/khOr
	 KsmGZ2ZRi8rFIz3zuk5hj3UdYntLEKBYfs3SuP85WIjIpq/NUqVV418StiaWO1NopkDcf
	 +iXcSOZW7o/kb1TviCIFK8tRJf036AW8vkBReKMeXZvsTC/YwIKaFlGFusxUvskvuUOpE
	 9KDG0kq3NLnAhoAUtAsdQnh/j8O5hsLidgeyeNXWuuKklcQ9qQmiCo+U75r1sbpqVKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793946764;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:Sender:X-CM-SenderInfo;
	bh=1Tsmwk+I5UWTMEeAt29TWBBpjf3klwLmGA8oOUh0Rws=;
	b=1Rs2tMDDsMOnmiKkw1dGevygjXX/wInNUIePtHMvoDccaIHcWEC4MRc36kO8xZcM3zyk
	 bI/YUh++D6p4j0875LQoeyrOGJAqMq2pzkSobrxfTarF/yCtJZ5ia8flRFcwACzchZoRf
	 YnTuZJvKeEAb2w90Z6tiHgpcuJ9lP7Bx+kOTyh6oJQmZ6aheXw2/OG9o9FnpRNAjC5uit
	 EZ4ebGLTdTU/vdgcZSFFRUSoHrcTZn5fcJK/Tj24sEtnOi9Wt4RSbGetSzMnQ0dpYwIBD
	 5FPfe2mlf8KIp/h878BRM4jkJVGo/ecpJHAIqg4XZ7bWmtudZW3L5CmGDjhAFwGZ6pw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kylinos.cn;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=KBRaFesM;
	arc=none smtp.remote-ip=220.197.31.5
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DC94606A329;
	Fri,  6 Nov 2026 06:32:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0DC94606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=KBRaFesM
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=1T
	smwk+I5UWTMEeAt29TWBBpjf3klwLmGA8oOUh0Rws=; b=KBRaFesMwOK3t5W0gg
	nuwxEECK+AuEaUt0MI0Aw0xfADG2NENZF32mwAOtpX87ewzjC9c6GKCkb6ymxuG/
	rUnW++apbv6zWLLSnVOeoTaaPF1DHSXepzqglSNcVaQnEnme5GmZBjnj6TgfHJv+
	k5rbPEUv5p//dN3+2IAHyDWeQ=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id _____wBnj5lmdO1qFrM5FA--.46456S2;
	Fri, 06 Nov 2026 14:32:08 +0800 (CST)
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
Subject: [PATCH net-next v2] net/sched: cls_fw: allow filter replace without re-specifying mask
Date: Fri,  6 Nov 2026 14:31:33 +0800
Message-Id: <20261106063133.98515-1-taowei@kylinos.cn>
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
X-CM-TRANSID:_____wBnj5lmdO1qFrM5FA--.46456S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxZF1kXF1xXry8Cw4DArWxtFb_yoWrAw1UpF
	s5K3WUGr4DtFyjgrZ7Jw1kt3Wa9rs7JFyxuF10kry5AFZagF4FqrWI93y7W3yUGrZ7C3W2
	qF4Yq3yDGasrAFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jA-B_UUUUU=
Sender: cs_taowei@163.com
X-CM-SenderInfo: xfvb3tprzhxqqrwthudrp/xtbC4QhNjmrtdGhgTwAA3e

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

When reviewing commit b72e025ac556 ("net/sched: cls_route: reject
change with no routing attribute") and its parent commit 41e85e54e564
("net/sched: cls_route: Fix in-place replace"), I noticed that the
series separates the create and replace paths in cls_route: a new
filter must use a handle that matches the value built from its
attributes, while a replace is not allowed to change the handle without
specifying routing attributes. Then I analyzed the cls_fw code with
an LLM.

Tested on aarch64:

  # tc qdisc add dev lo clsact
  # tc filter add dev lo ingress prio 1 handle 1/0xffff fw classid 1:10
  # tc filter replace dev lo ingress prio 1 handle 1 fw classid 1:20
  # tc filter show dev lo ingress | cut -d' ' -f9-
  handle 0x1/0xffff classid 1:20

  # tc filter change dev lo ingress prio 1 handle 1 fw classid 1:30
  # tc filter show dev lo ingress | cut -d' ' -f9-
  handle 0x1/0xffff classid 1:30

  # tc filter add dev lo ingress prio 1 handle 2 fw classid 1:40
  Error: Mask must be provided for new filter.

Signed-off-by: Wei Tao <taowei@kylinos.cn>
---
v2: https://lore.kernel.org/netdev/20261014024548.37874-1-taowei@kylinos.cn/
  - drop the Fixes tag: this is not a regression fix
  - describe how the issue was found and add the tested commands
 net/sched/cls_fw.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/net/sched/cls_fw.c b/net/sched/cls_fw.c
index 0f731595f839..3ca0598560c4 100644
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
 

base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
-- 
2.25.1

