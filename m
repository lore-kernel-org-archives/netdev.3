Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 230B535D5E2;
	Mon, 27 Jul 2026 02:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785119237; cv=none; b=oDeEwG1VPlwAfC7Hkw0U2ckECZdofzdUmnXuTVsf2Sr5FB5unAjzkNCnrWWMGlsw+dgKxpcpFNlXUFnTdcNU8Ay1L4xrGsNMqNaYjuErvkNdJ+k2A4H25+2UbT1Be8+CqHE0/ZcTm9AoWFWPbAdE2XrlPyrqI3KlmR55L1yatgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785119237; c=relaxed/simple;
	bh=jbXHZ1YK6vxtJx+06KkfXVJE0IEEB+3Sy+Su0phe7kA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fea9sfW9YsK2e8fuoSTwJQPsAm3NuK/gxLxPiGbXGN+9QE30PBDOxB0IMs8HCIfID2JAZPdOG6iDFcpk4nnxtnFfP3vSp/YwPWfoZspx8kxJ7XhBLKHy/filtmguhMWwdcYarw8Qgf+AEAva0hvZuXa82HMd3aS2GIapFx7/FSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=NGJhlAIg; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="NGJhlAIg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=1K
	kQUhSnnOiVOoQePrBplbGayjYmYScNGVsUs8MyXkI=; b=NGJhlAIgQTc2PwbfW8
	S4rdXad8BUj8GXhfifGX1Ptrto4kSwh+vYgncRvSxYYXXXQ5wqTiIl71PlWy0H2f
	CGdSYwl9KwH/49/L8f4710c2PFdE6BodDjz5quMoGFBklYI9ognZibZRuBiiPlD+
	ZklGUfRyLpM58IMpA4Z+SN2tE=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wD3PzPMwWZqSh_lMA--.2029S2;
	Mon, 27 Jul 2026 10:26:21 +0800 (CST)
From: luoqing <l1138897701@163.com>
To: dsahern@kernel.org,
	idosch@nvidia.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] net/ipv4: fix NULL pointer deref in nh_valid_get_del_req()
Date: Mon, 27 Jul 2026 10:26:19 +0800
Message-Id: <20260727022619.198914-1-l1138897701@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3PzPMwWZqSh_lMA--.2029S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7ZFyxJFWDKFy5Gr43Kr4xXrb_yoW5JryUpa
	yrGrykGFZ5JrW5JF47JF4DZa4j9w1DCa13WrZ0kw1Syrn8J348Wa45Kr92kr1SkryrJ398
	Jr1jvw45ta45CaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jjtC7UUUUU=
X-CM-SenderInfo: jorrjmiyzxliqr6rljoofrz/xtbC3g7XHGpmwc401AAA34

From: Qing Luo <luoqing@kylinos.cn>

rtm_del_nexthop() and nh_valid_get_bucket_req() declare their nlattr
tb arrays sized to ARRAY_SIZE(rtm_nh_policy_del) and
ARRAY_SIZE(rtm_nh_policy_get_bucket) respectively.  Both policies lack
an entry for NHA_OP_FLAGS, so the tb arrays are smaller than what
nh_valid_get_del_req() accesses via tb[NHA_OP_FLAGS].

This causes an out-of-bounds stack read.  The garbage pointer value
read from beyond the tb array is then dereferenced in nla_get_u32(),
triggering a NULL pointer dereference panic.

The bug was introduced when commit 8682b7dd4f6c ("nexthop: Fix
out-of-bounds access during attribute validation") shrank the tb
arrays from NHA_MAX+1 to ARRAY_SIZE(policy), but the policies were
not updated to include NHA_OP_FLAGS even though nh_valid_get_del_req()
already accessed that attribute.

Add [NHA_OP_FLAGS] entries to rtm_nh_policy_del and
rtm_nh_policy_get_bucket so the tb arrays are large enough.

[  647.535111] BUG: kernel NULL pointer dereference, address: 000000000000000a
[  647.542066] #PF: supervisor read access in kernel mode
[  647.547197] #PF: error_code(0x0000) - not-present page
[  647.559218] CPU: 0 PID: 42929 Comm: ip Not tainted 6.6.144 #1
[  647.579548] RIP: 0010:nh_valid_get_del_req+0x38/0xc0
[  647.998839] Kernel panic - not syncing: Fatal exception

Fixes: d8a21070b6e1 ("nexthop: Fix out-of-bounds access during attribute validation")
Signed-off-by: Qing Luo <luoqing@kylinos.cn>
---
 net/ipv4/nexthop.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/ipv4/nexthop.c b/net/ipv4/nexthop.c
index 44fe75004cac..ee1d22e59c00 100644
--- a/net/ipv4/nexthop.c
+++ b/net/ipv4/nexthop.c
@@ -51,6 +51,8 @@ static const struct nla_policy rtm_nh_policy_get[] = {
 
 static const struct nla_policy rtm_nh_policy_del[] = {
 	[NHA_ID]		= { .type = NLA_U32 },
+	[NHA_OP_FLAGS]		= NLA_POLICY_MASK(NLA_U32,
+						  NHA_OP_FLAGS_DUMP_ALL),
 };
 
 static const struct nla_policy rtm_nh_policy_dump[] = {
@@ -82,6 +84,8 @@ static const struct nla_policy rtm_nh_res_bucket_policy_dump[] = {
 static const struct nla_policy rtm_nh_policy_get_bucket[] = {
 	[NHA_ID]		= { .type = NLA_U32 },
 	[NHA_RES_BUCKET]	= { .type = NLA_NESTED },
+	[NHA_OP_FLAGS]		= NLA_POLICY_MASK(NLA_U32,
+						  NHA_OP_FLAGS_DUMP_ALL),
 };
 
 static const struct nla_policy rtm_nh_res_bucket_policy_get[] = {
-- 
2.25.1

