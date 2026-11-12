Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.137
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794474056;
	b=HaA5/68Ca1XmV4qZR8fJiXE+0V8s5787BNIzl5Yx10DR9/ZHL8Vm1Mi8L/MCDYLme1ZL
	 PdgmQyjw30uFZVhxd78/rL0xquHUbMDTGZkHFrPPHqDDWezwkwZhGM3Ye5G0gBGff/Xvc
	 VNvjat16FRlmF2mqGBkhewgne0MHKJTtbGGkLP3N4ElH3if1RJnjO0LtMIQnt4Ko4qPlq
	 YIMV67fqJ6Z4sr2kdDCJAJ6mwhsKhEDXZ7NKZn7HNdxs2OtNY0d1e8NU5Wj/W10rXF6OV
	 A8ejQjhzdBjNT/7T8k4z0Thlyb/lRrmpywM6GarKQv35ibPOdfDegdUXAncB/PuAGLQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794474056;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=DP15FYKEHXO6xoDhi4j3CgcS1prpD18B+3vZ34NHmTc=;
	b=aPeOTTXTBsGAklXGVuVCx8BFJiTbf6Npo7Ev357rqqOr6yk/yLLFlOezdhmpz5VGBLgF
	 x8dUb/g5Ay3Anh5ImsGwqrWpPjH5AfE5dpbxFlMMsiXH38jIBPoUBxZhc8Zydzw2REFJE
	 gyt+AwG0hNFbFMejpP3Hj7nJX3KL2oh3uy96imqZ3zkUUZnd3WlCK9vNOGVun1+smWsVj
	 KEuqy4lFx+sNvImvZ6CXVex3ibt7yM4rJHJn10JXQZatzGxIYiR2cllt0B7L81vIKFTTC
	 N1CQP4sGLP5moaSdxXuH7vq4YhNaCdKlzebuA8h/G/i6HSAVytiGWZtODKTe9xV4efA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=tB3cVqC9;
	arc=none smtp.remote-ip=111.22.67.137
Received: from cmccmta4.chinamobile.com (cmccmta4.chinamobile.com [111.22.67.137])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9996D606A31C;
	Thu, 12 Nov 2026 09:00:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9996D606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=tB3cVqC9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=tB3cVqC9ntwAcc0M/0QQfzsjhVr7ZZAICDPR44mCA9SC6MF4eWYA2+g4ipgOfmOwUc2AO5UbhuNri
	 tn+GwT+cSBxFOypU4H+CHUqZNy02/VrIYbZORFvD+b5SPuffZvcxPKxTfHDqMOVsJurug/dl+B55tf
	 nLfFR5bNn/tFfcFg=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app04-12004 (RichMail) with SMTP id 2ee46af58043ad8-80ab4;
	Thu, 12 Nov 2026 17:00:51 +0800 (CST)
X-RM-TRANSID:2ee46af58043ad8-80ab4
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.net (unknown[112.23.105.204])
	by rmsmtp-syy-appsvr04-12004 (RichMail) with SMTP id 2ee46af58041f7d-fa36d;
	Thu, 12 Nov 2026 17:00:51 +0800 (CST)
X-RM-TRANSID:2ee46af58041f7d-fa36d
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
Subject: [PATCH net v2] team: validate the length of U32 and S32 option data
Date: Thu, 12 Nov 2026 17:00:30 +0800
Message-Id: <20261112090030.172342-1-sunwenbo@cmss.chinamobile.com>
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
Signed-off-by: Wenbo Sun <sunwenbo@cmss.chinamobile.com>
---

Changes in v2:
- Check exact length (!= sizeof(u32) / != sizeof(s32)) instead of
  only rejecting truncated payloads (<), as suggested by Hangbin Liu.
- Extended the UML test to also cover oversized option payloads.

 drivers/net/team/team_core.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/team/team_core.c b/drivers/net/team/team_core.c
index 957cc7885d2f..8fa05c489b99 100644
--- a/drivers/net/team/team_core.c
+++ b/drivers/net/team/team_core.c
@@ -2833,6 +2833,10 @@ int team_nl_options_set_doit(struct sk_buff *skb, struct genl_info *info)
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
@@ -2852,6 +2856,10 @@ int team_nl_options_set_doit(struct sk_buff *skb, struct genl_info *info)
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



