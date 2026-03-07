Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7825D30AD00
	for <netdev@vger.kernel.org>; Sat,  7 Mar 2026 20:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772916270; cv=none; b=t4lw85hqlo49shxoIJg3SEdkC9MTvwFmMpCo8hS81CvjBLyWIq+qqEPcOGN193v8n3R2EgZZd59xU8lHmmAawICs99XcI/PQRany8qof7vwRmNhXaazgSc/LeMaRNATIg5zxKaPJibwdmFbRw2UlftO9aMH8zLROrzIAx5K9ql8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772916270; c=relaxed/simple;
	bh=JfC9wic2WKmNMXUmTol2ANaHl6GNYBb2VvE7mHN7PaM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VAQ0NyMrmeUOkWMNqGLOV0QcJWQHiPorZnbEL4lfilo3FvIvBst3As4TDQsUZin+xbMSrrYUCpnJ7CVkzIH1rTMemTp8PnHOKiym66JaC69k90ToBVSo7bqoCHowfwQMIDBhJFIeUZuXQGAlyjKdhG2iRsK4V6bgqLfQsFReL18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MkO4C6xu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MkO4C6xu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2B5DC19423;
	Sat,  7 Mar 2026 20:44:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772916270;
	bh=JfC9wic2WKmNMXUmTol2ANaHl6GNYBb2VvE7mHN7PaM=;
	h=From:To:Cc:Subject:Date:From;
	b=MkO4C6xu8zOjp7wbkQt14TmNCmmtGi0ZVTcDNRbyzP+dfYNfll23Fe9Kwm9NCqibL
	 ei+xrxJvGUvPXTsLXy60/P0Y2Ca3E1rjQ1EoU4HAbCTk4mU55Jf2ArH6iPLiDPvbiT
	 MaL1can6VwInev0Wnm/gwH6NRg/Pke0lKIEP4T888LHrzIExd+pNmH7FPaGE2YqKeW
	 XxH2Oi9nn+cPSnIoPnpzrPK+eOu017Ly3vg/ni4zjgQYUIzvKMLcGcHUyTmAa/tGdE
	 AoNubitXio15SpKKBgHppy0OnoF1zthAtZdkx0r30t7cHP8eM0RMcy5ml7wSytRoMd
	 VdD29YDYTWKVw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	kees@kernel.org,
	alok.a.tiwari@oracle.com
Subject: [PATCH net-next 1/2] genetlink: apply reject policy for split ops on the dispatch path
Date: Sat,  7 Mar 2026 12:44:24 -0800
Message-ID: <20260307204425.1900467-1-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 4fa86555d1cd ("genetlink: piggy back on resv_op to default to
a reject policy") added genl_policy_reject_all to ensure that ops
without an explicit policy reject all attributes rather than silently
accepting them. This change was applied to net.

When split ops were later introduced in net-next in
commit b8fd60c36a44 ("genetlink: allow families to use split ops directly"),
genl_op_fill_in_reject_policy_split() was added and called from
genl_op_from_split() (used for policy dumping and registration).
However, genl_get_cmd_split(), which is called for incoming messages,
copies split_ops entries as-is without applying the reject policy.
This means that split ops without policy accept all inputs.

This looks like an omission / mistake made when splitting the changes
between net and net-next. Let's try to re-introduce the checking.
Not considering this a fix given the regression potential.
If anyone reports issues we should probably fill in fake policies
for specific ops rather than reverting this.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: kees@kernel.org
CC: alok.a.tiwari@oracle.com
---
 net/netlink/genetlink.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/netlink/genetlink.c b/net/netlink/genetlink.c
index a23d4c51c089..656d32046147 100644
--- a/net/netlink/genetlink.c
+++ b/net/netlink/genetlink.c
@@ -250,6 +250,7 @@ genl_get_cmd_split(u32 cmd, u8 flag, const struct genl_family *family,
 		if (family->split_ops[i].cmd == cmd &&
 		    family->split_ops[i].flags & flag) {
 			*op = family->split_ops[i];
+			genl_op_fill_in_reject_policy_split(family, op);
 			return 0;
 		}
 
-- 
2.53.0

