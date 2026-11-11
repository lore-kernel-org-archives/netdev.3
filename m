Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.139
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794387585;
	b=AgmODHfAn4qBREWH8VzY6sGx224aPg+y/Re+yhLZvZ5WHZ9bpuquBbtamBfzOKMo1z32
	 D7iuKn+OGm5fWD6StlWDNhT4ET6G8ngtbU3lYHBLXCUaVOmufLxjwoz/HB3V/dd6eTE1Z
	 9rFDNQaON6aZC4sY+B6PV68GP1+KH4qWIGg4K9halmhfdYmmpYvbq+QHzovJisE9EX2/3
	 /ZercDIb/RYH+eQfoMjhzXyys+FP+TeiM9c5r29vOf865hTj12si8rVpUrqEqNuLY/Gil
	 DPbX4o/XgQS3PO59YA0rIPgO3w4/qpe7YkAra9ymurPx1UjIRifUQfy9eW+OL+XBSIA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794387585;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=8reTPqAv/HMHrkP9uAWId+/q6jL4L2PpJVCKg3Q/rmA=;
	b=IdCiEnHX7d60wcLl6vnpzwzjazabD582Boh4cnSARMaWdJXe559u1VpYzHnznM4U5xPJ
	 LmFWy3tolnQ7z4yJ9JOc64QNJxsgTrunTsFMdtAVTjW5+bMWYN0GT94Y10IVZ3fuHBhOy
	 D08126d9FaJvVtH+fd4u91Ftx/t/rJHRCEAMcbsKI0NayOFdiJZRSQZO1v3PzeF5uwGJp
	 EG4iAkK+6oU7uLG8pTS+jEXFPoxaocCtTQqoUh/4XKj2jNMSkoo4nywXlbomiUzQmRXOd
	 LTwAP/DUuuZhLcmJeGJkySaGlhlUget5HIY1EVLOscGhBpeOO7HNUiR+D9e0MO2vzoA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=RshZOywD;
	arc=none smtp.remote-ip=111.22.67.139
Received: from cmccmta6.chinamobile.com (cmccmta6.chinamobile.com [111.22.67.139])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2E1D606A326;
	Wed, 11 Nov 2026 08:59:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D2E1D606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=RshZOywD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=RshZOywDJBzjLlLST0gPvThT/lg+DhF2ZAZA54eo0c8iQZ4xUkMZF7Clii+j7h8kc8i5ofEUsDZ/H
	 PJqHePAmoMXmUnlK9xVpSrrIoS3y9K6VatteS1tRLizDG3ePfMyJn7IqXTgM+5oXHBndVD78JKln7H
	 YGVMPPi+x6b20c7s=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app01-12001 (RichMail) with SMTP id 2ee16af42e7ba71-b2f41;
	Wed, 11 Nov 2026 16:59:42 +0800 (CST)
X-RM-TRANSID:2ee16af42e7ba71-b2f41
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.net (unknown[223.64.115.200])
	by rmsmtp-syy-appsvr10-12010 (RichMail) with SMTP id 2eea6af42e7dc68-d5e99;
	Wed, 11 Nov 2026 16:59:42 +0800 (CST)
X-RM-TRANSID:2eea6af42e7dc68-d5e99
From: Wenbo Sun <sunwenbo@cmss.chinamobile.com>
To: Jiri Pirko <jiri@resnulli.us>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sunwenbo@cmss.chinamobile.com,
	1342116488@qq.com
Subject: [PATCH net] team: validate the length of U32 and S32 option data
Date: Wed, 11 Nov 2026 16:59:24 +0800
Message-Id: <20261111085924.360720-1-sunwenbo@cmss.chinamobile.com>
X-Mailer: git-send-email 2.33.0
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

In team_nl_options_set_doit(), TEAM_ATTR_OPTION_DATA attribute policy is
NLA_BINARY in team_attr_option_nl_policy because the option data format
depends on the option type.

When setting an option of type TEAM_OPTION_TYPE_U32 or
TEAM_OPTION_TYPE_S32, ctx.data.u32_val or ctx.data.s32_val is retrieved via
nla_get_u32(attr_data) or nla_get_s32(attr_data) without validating that
the attribute payload is at least sizeof(u32) or sizeof(s32). If userspace
supplies truncated option data (e.g. 0 to 3 bytes), nla_get_u32() or
nla_get_s32() will perform an out-of-bounds read past the attribute data
buffer.

This issue was identified during a code audit of Netlink option handlers
in the team driver. The bug was confirmed and reproduced on a UML kernel:
passing truncated option data for notify_peers_count (U32) or priority
(S32) succeeded on an unpatched kernel instead of failing validation.

Add explicit length checks for TEAM_OPTION_TYPE_U32 and
TEAM_OPTION_TYPE_S32 in team_nl_options_set_doit() to reject truncated
attributes with -EINVAL, similar to commit 5bef3ac184b5 ("team: better
TEAM_OPTION_TYPE_STRING validation").

Tested:
- In UML, verified that sending truncated U32 and S32 option data (0 to 3
  bytes) is rejected with -EINVAL on a patched kernel, while valid U32 and
  S32 option settings succeed.
- Built with W=1 on UML, x86_64 allmodconfig, and x86_64 allyesconfig with
  zero new warnings or errors.

Fixes: 3d249d4ca7d0 ("net: introduce ethernet teaming device")
Signed-off-by: Wenbo Sun <sunwenbo@cmss.chinamobile.com>
---
 drivers/net/team/team_core.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/team/team_core.c b/drivers/net/team/team_core.c
index 957cc7885d2f..617f13e1620c 100644
--- a/drivers/net/team/team_core.c
+++ b/drivers/net/team/team_core.c
@@ -2833,6 +2833,10 @@ int team_nl_options_set_doit(struct sk_buff *skb, struct genl_info *info)
 			ctx.info = opt_inst_info;
 			switch (opt_type) {
 			case TEAM_OPTION_TYPE_U32:
+				if (nla_len(attr_data) < sizeof(u32)) {
+					err = -EINVAL;
+					goto team_put;
+				}
 				ctx.data.u32_val = nla_get_u32(attr_data);
 				break;
 			case TEAM_OPTION_TYPE_STRING:
@@ -2852,6 +2856,10 @@ int team_nl_options_set_doit(struct sk_buff *skb, struct genl_info *info)
 				ctx.data.bool_val = attr_data ? true : false;
 				break;
 			case TEAM_OPTION_TYPE_S32:
+				if (nla_len(attr_data) < sizeof(s32)) {
+					err = -EINVAL;
+					goto team_put;
+				}
 				ctx.data.s32_val = nla_get_s32(attr_data);
 				break;
 			default:
-- 
2.33.0



