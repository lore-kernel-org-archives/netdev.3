Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.135
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794560490;
	b=ZeGGOt9vpZD8nLAblmmlcrxj/m4n6cVFJOcntD7BfbIX7KOEbohYPn+/lWoTGkXuCBCC
	 VW2BV1JWR6g0VLCHJ9aLu6+luRmxSopzk/3UoDhUGhLIEoMmlsJfggIjkNXnTbwyHu5Kf
	 vtpsCr8ipqSg/cHkdZ7hU1BpUBBPGGo98A6iTQxdOIRLHRkgzCiJJHK1Irj1wDMN94itK
	 F8QS7jXYKCi9VjzdI4pti+MlvsT/juyHgTall1R9cMQtsd9dGxYAMKUALE2GE9J0qUBJb
	 Umd6MT4KpzCBAZKEtf0hunvtXEsuySN3mTYItoMkQoRMQ7pcJUDWaSeKEaoDFnDSpfw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794560490;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=FQCbRlPwcdgGqjavqN5PuhdDIKeapOrS6kVQSOGe7JU=;
	b=iu6lFP8IKhaRk5SA7LLIzp8J62HBzcSclk5aqYpulY3WpDz+FUBnSgGCIcvv2p+IdvLa
	 aLw4xqtk2wrM5gSWDUwX8CplZMff8fCXx3JWKEhnAHUG+WK0BlT+dr42uBrAtNWtbS4Mw
	 +tzH3/vGSh4INamdDroxHmokrwPfsJZiGKbjWlnUXzb8XJX2tZoXCInGvvR/BF3PJGaVZ
	 jTP7e+h7tJ6orgxxfqSQp47pOR+avnw1CVHxzNAIY0L9N7QbMMWkcaTMj78tmLN3zEZhE
	 hl5eYauNZgFvN/D8C5nXVcN8qfu9lA9tTJKy3W/MpNePhx4ep5fPqzrY9jTI8iOZFSA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=XCGb7FJl;
	arc=none smtp.remote-ip=111.22.67.135
Received: from cmccmta2.chinamobile.com (cmccmta2.chinamobile.com [111.22.67.135])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD5A8606A33A;
	Fri, 13 Nov 2026 09:01:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BD5A8606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=XCGb7FJl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=XCGb7FJllbslpYYu9bYY/WMjlvLUqDIGRaBkHy0vubCxTl8Yo0kw/dlI4zYLd6Yqk5izKUBbEXq34
	 HhedsFnfsjZES6wyRRRlbpdiGAA8XEWm/Gm9RlhPNsWcR/u/m1Ugl8AqmTzUNCQ+YGJl0nTCreZDJM
	 vaAOfGtZXOWmdEqs=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app03-12003 (RichMail) with SMTP id 2ee36af6d1e40d7-b6ab7;
	Fri, 13 Nov 2026 17:01:25 +0800 (CST)
X-RM-TRANSID:2ee36af6d1e40d7-b6ab7
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.net (unknown[223.64.115.200])
	by rmsmtp-syy-appsvr01-12001 (RichMail) with SMTP id 2ee16af6d1e30e4-1f973;
	Fri, 13 Nov 2026 17:01:25 +0800 (CST)
X-RM-TRANSID:2ee16af6d1e30e4-1f973
From: Wenbo Sun <sunwenbo@cmss.chinamobile.com>
To: Jiri Pirko <jiri@resnulli.us>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Hangbin Liu <hangbin.liu@linux.dev>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sunwenbo@cmss.chinamobile.com,
	1342116488@qq.com
Subject: [PATCH net v3] team: validate the length of U32 and S32 option data
Date: Fri, 13 Nov 2026 17:01:08 +0800
Message-Id: <20261113090108.175889-1-sunwenbo@cmss.chinamobile.com>
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

In team_nl_options_set_doit(), the policy for TEAM_ATTR_OPTION_DATA in
team_attr_option_nl_policy is NLA_BINARY because the payload layout
varies with the option type.

For TEAM_OPTION_TYPE_U32 and TEAM_OPTION_TYPE_S32, the payload is
read directly with nla_get_u32(attr_data) and nla_get_s32(attr_data)
without checking its attribute length. When userspace supplies a
truncated attribute (0 to 3 bytes), nla_get_u32() or nla_get_s32()
performs an out-of-bounds read past the attribute buffer. Conversely,
oversized payloads (> 4 bytes) would also have trailing bytes
silently ignored instead of being rejected as invalid input.

Validate that nla_len(attr_data) equals sizeof(u32) or sizeof(s32)
for TEAM_OPTION_TYPE_U32 and TEAM_OPTION_TYPE_S32 respectively, and
return -EINVAL otherwise, consistent with how NLA_U32/NLA_S32
attributes are validated and similar to commit 5bef3ac184b5 ("team:
better TEAM_OPTION_TYPE_STRING validation").

This issue was identified with the assistance of an LLM-based code
review of Netlink option handlers in the team driver, confirmed by
sending malformed U32 (notify_peers_count) and S32 (priority) option
attributes on a UML kernel, and verified after the patch that
invalid lengths (0..3, 5, and 8 bytes) are rejected with -EINVAL while
valid 4-byte options still work as expected.

Built with W=1 on UML, x86_64 allmodconfig, and x86_64 allyesconfig with
zero new warnings or errors.

Fixes: 3d249d4ca7d0 ("net: introduce ethernet teaming device")
Fixes: 69821638b274 ("team: add signed 32-bit team option type")
Signed-off-by: Wenbo Sun <sunwenbo@cmss.chinamobile.com>
---

Changes in v3:
- Add Fixes: 69821638b274 ("team: add signed 32-bit team option type") for
  the TEAM_OPTION_TYPE_S32 check, as suggested by Hangbin Liu.
- Rebase onto latest mainline (7e1392a42ea2) with no functional code
  changes.
- Link to v2: https://lore.kernel.org/r/20261112090030.172342-1-sunwenbo@cmss.chinamobile.com

Changes in v2:
- Check exact length (!= sizeof(u32) / != sizeof(s32)) instead of
  only rejecting truncated payloads (<), as suggested by Hangbin Liu.
- Extended the UML test to also cover oversized option payloads.
- Link to v1: https://lore.kernel.org/r/20261111085924.360720-1-sunwenbo@cmss.chinamobile.com

 drivers/net/team/team_core.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/team/team_core.c b/drivers/net/team/team_core.c
index cfb833c307c1..65ac25e97ae3 100644
--- a/drivers/net/team/team_core.c
+++ b/drivers/net/team/team_core.c
@@ -2834,6 +2834,10 @@ int team_nl_options_set_doit(struct sk_buff *skb, struct genl_info *info)
 			ctx.info = opt_inst_info;
 			switch (opt_type) {
 			case TEAM_OPTION_TYPE_U32:
+				if (nla_len(attr_data) != sizeof(u32)) {
+					err = -EINVAL;
+					goto team_put;
+				}
 				ctx.data.u32_val = nla_get_u32(attr_data);
 				break;
 			case TEAM_OPTION_TYPE_STRING:
@@ -2853,6 +2857,10 @@ int team_nl_options_set_doit(struct sk_buff *skb, struct genl_info *info)
 				ctx.data.bool_val = attr_data ? true : false;
 				break;
 			case TEAM_OPTION_TYPE_S32:
+				if (nla_len(attr_data) != sizeof(s32)) {
+					err = -EINVAL;
+					goto team_put;
+				}
 				ctx.data.s32_val = nla_get_s32(attr_data);
 				break;
 			default:
-- 
2.33.0



