Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9C7534C130;
	Mon, 13 Jul 2026 20:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783975811; cv=none; b=mDDyT+k9+eRa74/M8Gjl1k5F98dRCm50mIkqWa8bd4QOu29LH2KJ3iFHFW4SUYh16XVAUalC6c5c7r1O18IXQeZp55t4lka21fhewmB77lXrfBz470cSW/lHGuae/w5ozrnnV8szEBF4kaioICaDaZ13YVcd1wLxmpGq3P0h7w4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783975811; c=relaxed/simple;
	bh=i1iEAiqrUdbG8CyFpQrCLW2MFv2jhnIDhdf8cSUn30Q=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=g+3oNAMeKE0KjA89k8prAKwoZiqQiSmn+71/2aDheTi2cXPRjEFBRV8+3QmD00+CTfx0/dxvNvxqvA5IOjI5npSe51xj6YztLZmNf7mmmKT4fbGHF9pBWxNGzCqIIwe878sLX6udxA9RCDSxRIWMGRrpMqQObjKldyfy9g5y668=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=WOMs+cwP; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="WOMs+cwP"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=Xz9IXJfxhr0HmZxi9NYVssLZeOyP4+AtpS2DA76RSAo=; b=WOMs+cwPL5JrHcmJQ1CCR3g9kC
	lpJ7u7M5DGE6raFlRwDA9B1uIIzjATcQFE2WuZSYuZWmyjKkuWFfxhvnxT07GcDSBvBPYrq67MAoS
	pOkrDNl65HcUTyzFsyG/Dzioet8P7szNp3Wbc/LSDlpa1PqBCA9G9U4sgJUx9indcZCzkNt2AYhQ1
	OiH9PVjJs9ZfQMB9V4FaN+fZFb4K6MtfIjGrFE6ffA4rADDj2NCmoTT/4tPbLFUCLLq9f3si6UkSZ
	12TxFoKJXkM/NSCTw4BRePwelpuaCsWreXASx2u2bQnEg6Oj7CP8IDa0AqGdcHx49cLnleJwHak+A
	YvLISVRg==;
Received: from [179.96.247.152] (helo=toolbx)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1wjNb6-00Efjc-Dw; Mon, 13 Jul 2026 22:49:53 +0200
From: Helen Koike <koike@igalia.com>
To: jmaloy@redhat.com,
	davem@davemloft.net,
	erik.hugne@ericsson.com,
	ying.xue@windriver.com,
	netdev@vger.kernel.org,
	tipc-discussion@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	koike@igalia.com,
	kernel-dev@igalia.com
Subject: [PATCH net] tipc: fix infinite loop in __tipc_nl_compat_dumpit
Date: Mon, 13 Jul 2026 17:49:35 -0300
Message-ID: <20260713204940.647668-1-koike@igalia.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

cmd->dumpit callback can return a negative errno, causing an infinite
loop due to the while(len) condition. As the loop never terminates,
genl_mutex is never released, and other tasks waiting on it starve in D
state.

Check dumpit's return value, propagate it and jump to err_out on error.

Reported-by: syzbot+85d0bec020d805014a3a@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=85d0bec020d805014a3a
Fixes: d0796d1ef63d ("tipc: convert legacy nl bearer dump to nl compat")
Signed-off-by: Helen Koike <koike@igalia.com>
---

Tested locally using syzbot reproducer.
---
 net/tipc/netlink_compat.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/tipc/netlink_compat.c b/net/tipc/netlink_compat.c
index 2a786c56c8c5..d9a4f94ea2d4 100644
--- a/net/tipc/netlink_compat.c
+++ b/net/tipc/netlink_compat.c
@@ -221,6 +221,10 @@ static int __tipc_nl_compat_dumpit(struct tipc_nl_compat_cmd_dump *cmd,
 		int rem;
 
 		len = (*cmd->dumpit)(buf, &cb);
+		if (len < 0) {
+			err = len;
+			goto err_out;
+		}
 
 		nlmsg_for_each_msg(nlmsg, nlmsg_hdr(buf), len, rem) {
 			err = nlmsg_parse_deprecated(nlmsg, GENL_HDRLEN,
-- 
2.54.0

