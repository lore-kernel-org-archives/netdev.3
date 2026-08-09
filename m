Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8C3D4086A
	for <netdev@vger.kernel.org>; Sun,  9 Aug 2026 00:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786233973; cv=none; b=AsY2e3cMOsM5aT7LPK4evmi3IvBepwdMq+Jr44R78F8rcQdBGp16jpvDv5XAsNJ67E5fr2WlljwVODAmrefHbUpujG7Ow3ckpAVd7jIKCDTy8bDSluMA7NtpluqCybH/OIBs0XllHutZ+0BNnI66UmZc0Z+GTxUiMyZep/8XnvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786233973; c=relaxed/simple;
	bh=Z/FzZ4L0F8BqUxkGbjWJODKbRukyxvXzQddO3i0urPk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MwO/ArfV2V43H3Lkr3ca4/W3/1pH6CxoTPZNyaGgfKHikNzHWR24co8JirqPVRP10tAhWBpPb2InYSYAI37eyekKipsOKIcwgcAkE6CnYqD3JCLlaJGTBLixlY3+51urX3X8J+0yMUfKeWbfLEPwTdn7PPQYTyeNJfZ1U8V+wmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mji4yloP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mji4yloP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 057641F000E9;
	Sun,  9 Aug 2026 00:06:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786233971;
	bh=Nepj6aKr33jFOCdV7m2ViB38Onj2VFoEyCinADsffbo=;
	h=From:To:Cc:Subject:Date;
	b=Mji4yloPD5YKYFn1QlUturbhRD0xEX6htYFSfctcedSGRPiCT5YsuHilbaLImMAzL
	 BFR7C2xNtgsFu1GTnKC726VnKJfDU8Qy4nxH6Ly1Lr4EbFVqilq7e7pFtOH3Ml0sjB
	 fImGoA7Lm/SvpBJaKGJwVVc5rbFi0+1EhZZiLyG4HWAjcv8EI6e0INp6/I3EepdgTg
	 u1PdKTGJYvNyCRtVUuNzPHjUomYSkX/CAD7PJ9Zn6FWMybwDsipAL9Y+YTHrv2QA5r
	 2EJK0mSprl1o2SReCW+4VmldU2sGkL+o3dR3Ubut3NTimuHkr4JKxtTcQH8E+Hr985
	 1vkNrtK6wvwCQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	daniel@iogearbox.net,
	bobbyeshleman@gmail.com,
	joe@dama.to,
	razor@blackwall.org,
	sdf@fomichev.me,
	dw@davidwei.uk
Subject: [PATCH net-next] netdev: check for nla_put_u32() failures
Date: Sat,  8 Aug 2026 17:06:09 -0700
Message-ID: <20260809000609.327659-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make sure we check if nla_put_u32(id) was successful after creating
objects. This is theoretical today, the skbs are large enough to
always fit the ID.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
v2:
 - don't handle, just WARN
v1: https://lore.kernel.org/20260609190804.1137085-2-kuba@kernel.org

CC: daniel@iogearbox.net
CC: bobbyeshleman@gmail.com
CC: joe@dama.to
CC: razor@blackwall.org
CC: sdf@fomichev.me
CC: dw@davidwei.uk
---
 net/core/netdev-genl.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
index c0a86f3ae33b..fa9edfdb32c2 100644
--- a/net/core/netdev-genl.c
+++ b/net/core/netdev-genl.c
@@ -1119,7 +1119,9 @@ int netdev_nl_bind_rx_doit(struct sk_buff *skb, struct genl_info *info)
 			goto err_unbind;
 	}
 
-	nla_put_u32(rsp, NETDEV_A_DMABUF_ID, binding->id);
+	/* rsp was allocated large enough */
+	WARN_ON_ONCE(nla_put_u32(rsp, NETDEV_A_DMABUF_ID, binding->id));
+
 	genlmsg_end(rsp, hdr);
 
 	err = genlmsg_reply(rsp, info);
@@ -1253,7 +1255,9 @@ int netdev_nl_bind_tx_doit(struct sk_buff *skb, struct genl_info *info)
 		goto err_unlock_bind_dev;
 	}
 
-	nla_put_u32(rsp, NETDEV_A_DMABUF_ID, binding->id);
+	/* rsp was allocated large enough */
+	WARN_ON_ONCE(nla_put_u32(rsp, NETDEV_A_DMABUF_ID, binding->id));
+
 	genlmsg_end(rsp, hdr);
 
 	if (bind_dev != netdev)
@@ -1420,7 +1424,9 @@ int netdev_nl_queue_create_doit(struct sk_buff *skb, struct genl_info *info)
 
 	netdev_rx_queue_lease(rxq, rxq_lease);
 
-	nla_put_u32(rsp, NETDEV_A_QUEUE_ID, queue_id);
+	/* rsp was allocated large enough */
+	WARN_ON_ONCE(nla_put_u32(rsp, NETDEV_A_QUEUE_ID, queue_id));
+
 	genlmsg_end(rsp, hdr);
 
 	netdev_unlock(dev_lease);
-- 
2.55.0

