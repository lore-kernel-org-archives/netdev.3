Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4510382866
	for <netdev@vger.kernel.org>; Fri, 22 May 2026 23:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779491224; cv=none; b=Hy7qCSTNNOsI/Uq6Kynt+UzzsNHhfiSrxZye/FSQpUuA/q9bAT/DWPQE0oBjNN/2MNUvYg5JRyEROJtZ9W6bDTUEWrYmA8tFnkWwZdRNML7hkYRsE1I9uHQk+omrGTcnO3DCv/Mjn7+96me4yS0Ru50T9LPbOVi/m7UY+4Qd2rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779491224; c=relaxed/simple;
	bh=bByBtITJ0CvKFHBvxRWfZQ2V9xHUTysGdPyT6ZLjZog=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZYsislBjdENmwWY188qNvef9qvAF6TlGcse7IL2SzpdM/RNRcD5wMTaYgffFmEZ4z1GqMn+Pa3SemldYbPH9laS62OHttQVC1Yj4W/aoiO4mSsfzF4wT8+SMC81sQeZDatHV+yWlNMCEKn03mtNnLwOJU5iaxMXzWpr978bNak0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VU2Xidto; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VU2Xidto"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB8E51F00A3D;
	Fri, 22 May 2026 23:07:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779491223;
	bh=ocU0C81LVhiuatd6m0R41vAaq7UqdSt2bU19xf+K+rY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VU2XidtonAejoxF6+rdNy1yauLohQRSfeGqyVRoN0NSzUV4nj3nvTY/EFYDrb6+i4
	 AX1uVTuWUlrxS2DkjDN8QfACHs6zIm1L3su3eVY0BVt0NfpJU+/Shj525QnY/z1Z1b
	 szIB2LNOMhcRpzv/XzVaCkGwSj8IyJC9W9/ns79jQFNu24iEG5nxaNj05hx6OBsN/v
	 6hpF9mHqiOrqOznqYCn1+MadAtK2FN6x2BYALf2iW2QAENJJjA0L73MO5QcyWndYFK
	 3Xg+uqANdn9ZP77nD/YkENwWe6CZn06lSPk7axjKTpvzJ/aa9c//sa0bJEQzuJgs26
	 q9a+P78rEwy5g==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	gal@nvidia.com,
	Jakub Kicinski <kuba@kernel.org>,
	andrew@lunn.ch
Subject: [PATCH net 1/6] ethtool: rss: avoid modifying the RSS context response
Date: Fri, 22 May 2026 16:06:42 -0700
Message-ID: <20260522230647.1705600-2-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260522230647.1705600-1-kuba@kernel.org>
References: <20260522230647.1705600-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Gemini says that we're modifying the RSS_CREATE response skb.
I think it's right, the comment says that unicast() should
unshare the skb but I'm not entirely sure what I meant there.
netlink_trim() does a copy but only if skb is not well sized
(it's at least 2x larger than necessary for the payload).

Fixes: a166ab7816c5 ("ethtool: rss: support creating contexts via Netlink")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: andrew@lunn.ch
CC: gal@nvidia.com
---
 net/ethtool/rss.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/net/ethtool/rss.c b/net/ethtool/rss.c
index 353110b862ab..8ffec9785efa 100644
--- a/net/ethtool/rss.c
+++ b/net/ethtool/rss.c
@@ -981,11 +981,17 @@ ethnl_rss_create_validate(struct net_device *dev, struct genl_info *info)
 }
 
 static void
-ethnl_rss_create_send_ntf(struct sk_buff *rsp, struct net_device *dev)
+ethnl_rss_create_send_ntf(const struct sk_buff *rsp, struct net_device *dev)
 {
-	struct nlmsghdr *nlh = (void *)rsp->data;
 	struct genlmsghdr *genl_hdr;
+	struct nlmsghdr *nlh;
+	struct sk_buff *ntf;
 
+	ntf = skb_copy_expand(rsp, 0, 0, GFP_KERNEL);
+	if (!ntf)
+		return;
+
+	nlh = nlmsg_hdr(ntf);
 	/* Convert the reply into a notification */
 	nlh->nlmsg_pid = 0;
 	nlh->nlmsg_seq = ethnl_bcast_seq_next();
@@ -993,7 +999,7 @@ ethnl_rss_create_send_ntf(struct sk_buff *rsp, struct net_device *dev)
 	genl_hdr = nlmsg_data(nlh);
 	genl_hdr->cmd =	ETHTOOL_MSG_RSS_CREATE_NTF;
 
-	ethnl_multicast(rsp, dev);
+	ethnl_multicast(ntf, dev);
 }
 
 int ethnl_rss_create_doit(struct sk_buff *skb, struct genl_info *info)
@@ -1104,12 +1110,8 @@ int ethnl_rss_create_doit(struct sk_buff *skb, struct genl_info *info)
 
 	genlmsg_end(rsp, hdr);
 
-	/* Use the same skb for the response and the notification,
-	 * genlmsg_reply() will copy the skb if it has elevated user count.
-	 */
-	skb_get(rsp);
-	ret = genlmsg_reply(rsp, info);
 	ethnl_rss_create_send_ntf(rsp, dev);
+	ret = genlmsg_reply(rsp, info);
 	rsp = NULL;
 
 exit_unlock:
-- 
2.54.0

