Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69EAE36998A
	for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 16:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788194524; cv=none; b=iT3h8JpqzUCAivJ1kQb40eZ3pYrMDNrZlQQudnWhnjaCB7HIiFHk9eACzhffw21ofhuD8hyeDWUjkLce7E1sYOtujcI6f5T21CX2q6hUjG7JFSXdk3Tgj4YTtl0ThxGehohB0w8Ohyb+aphcuG+vdSt4LtHEfquPUQ/8vz6RlSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788194524; c=relaxed/simple;
	bh=ZHxdPB77HJoFppqg9tBlZO6OY0fwSECK4LYKpXiNHTo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sa5aYVjBYRcO63Pe8GcCA2nAoaAN+1DxnS7POxMtuVN9pTXnEyAF6mhd96YB6wFERwcwsB+pHfOknhvIGTNjBUoPOm0ZyHSkcbpygKEaNunM7C6Ai/3exfRGSBhudvljUHL+3KBPLn3NiiVURDpXQyoW27QTGb9v/e/X8RPBvUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XvRNSrYg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XvRNSrYg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF8251F0155A;
	Mon, 31 Aug 2026 16:42:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788194523;
	bh=UWYF7gDBznC4viCAnvhe2rtIdP73x4brwALy4/OreGQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XvRNSrYgxfuZqsp2s8vDFIj43syp14aeOjy/8zFh16fFE3+K1KIJeS/okv/QHu28L
	 /Zn0ohqFmelnes2e7XbUU06bEXyrH2ifBgPCfI85j2owxk3zBrPa44uxnvDmQiaW6e
	 RYvMHCWB4goR6/0juK03YLuJlZiaGxhahEUTUHnEYMspxXzAkzWzIyRxR99B74E1Ki
	 Kaug9Xwl2eECW7IXkaBzDBo3p/kbjcKcMgw/Igq0fRztBBRFPMhAlzE7uB09sIY99S
	 0v9rPK0cJRdYJCAj4ER+IpMwCvf1S2eEFStA3I9IulcFQnPpZ8uCm2Ucx73O1xkCSl
	 bnTJSBK7Utdcw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	daniel@iogearbox.net,
	razor@blackwall.org,
	bobbyeshleman@meta.com,
	sdf@fomichev.me,
	Jakub Kicinski <kuba@kernel.org>,
	Joe Damato <joe@dama.to>
Subject: [PATCH net-next v2 3/3] netdev: don't use dev->flags for IFF_UP
Date: Mon, 31 Aug 2026 09:41:58 -0700
Message-ID: <20260831164159.1124679-4-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260831164159.1124679-1-kuba@kernel.org>
References: <20260831164159.1124679-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

dev->flags are not technically ops lock protected. The IFF_UP flag
will not change when dev->lock is held, but other flags may change
so KCSAN would probably not be impressed. Because of this we added
a dedicated dev->up which is safe to read under dev->lock.

qstats want to make sure device is up, use dev->up.

Reviewed-by: Bobby Eshleman <bobbyeshleman@meta.com>
Reviewed-by: Joe Damato <joe@dama.to>
Acked-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 net/core/netdev-genl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
index e427bab4c4d2..fa9edfdb32c2 100644
--- a/net/core/netdev-genl.c
+++ b/net/core/netdev-genl.c
@@ -775,7 +775,7 @@ netdev_nl_stats_by_queue(struct net_device *netdev, struct sk_buff *rsp,
 	const struct netdev_stat_ops *ops = netdev->stat_ops;
 	int i, err;
 
-	if (!(netdev->flags & IFF_UP))
+	if (!netdev->up)
 		return 0;
 
 	i = ctx->rxq_idx;
-- 
2.55.0

