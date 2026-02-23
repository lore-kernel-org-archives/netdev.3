Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1358346FA5
	for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 07:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771832539; cv=none; b=exvSFPG7EFEENaZa9V0pjf2OOrw7Z7MLSBZ8bq9mTSTM4tB6htWCh3DKZp/+rs2WXvCnT8Ab9hRAOcClKm80FVFJXxuIYQpiMEZ+xK7zDCbpzpXIw39HskwCkdoGgS2ClR8boCLhqmc9sHCAC63omhvYV3Q5KiYvr+WUXKMwt1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771832539; c=relaxed/simple;
	bh=MnUpCavpfI8BAF4yPsWkE96nO8uaSSIGdRS5zLGhAKo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=B1FU6c9vgiZxlLtG8v8lRSGhubSL5w4VEeROJfOdBGJV4nlKEUPpG1FDd03MM2bfB5EYdor2c3johlxpZT13BervHqq60VvU5HKyalo1ow5K2oqrR260lBn+Mj5ERMlRcWBEPuC8wMhdENVi1tdWZDYQhcqZclvCYsRbLR/TDpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Nr3bro9V; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Nr3bro9V"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1771832535;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=PIKNM+rAOHSJeO0ca6Imav7F4Thd8LQwy9dytbmdIf4=;
	b=Nr3bro9VEC7Acaq2fFWVptzkmySYBxmoN1Y2v77IqhiHl0uebWAIu3Cz70LymOEci5UMQA
	XLnDkeZwQnA8Es8CCpvr+w3k3X4zgxIaDjW5w3soTkYuK1YBuXk5asltAyHfXmCgROYfl1
	/5gD1bNF9iNMgBgFp1jakuZYGGTwvo0=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next] net: l2tp_eth: Replace deprecated strcpy with strscpy in l2tp_eth_create
Date: Mon, 23 Feb 2026 08:41:34 +0100
Message-ID: <20260223074137.321862-1-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

strcpy() has been deprecated [1] because it performs no bounds checking
on the destination buffer, which can lead to buffer overflows. Replace
it with the safer strscpy().  Use the two-argument version of strscpy()
to copy 'cfg->ifname'.

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strcpy [1]
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 net/l2tp/l2tp_eth.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/l2tp/l2tp_eth.c b/net/l2tp/l2tp_eth.c
index cf0b66f4fb29..a4956ef9574c 100644
--- a/net/l2tp/l2tp_eth.c
+++ b/net/l2tp/l2tp_eth.c
@@ -14,6 +14,7 @@
 #include <linux/in.h>
 #include <linux/etherdevice.h>
 #include <linux/spinlock.h>
+#include <linux/string.h>
 #include <net/sock.h>
 #include <net/ip.h>
 #include <net/icmp.h>
@@ -235,10 +236,10 @@ static int l2tp_eth_create(struct net *net, struct l2tp_tunnel *tunnel,
 	int rc;
 
 	if (cfg->ifname) {
-		strscpy(name, cfg->ifname, IFNAMSIZ);
+		strscpy(name, cfg->ifname);
 		name_assign_type = NET_NAME_USER;
 	} else {
-		strcpy(name, L2TP_ETH_DEV_NAME);
+		strscpy(name, L2TP_ETH_DEV_NAME);
 		name_assign_type = NET_NAME_ENUM;
 	}
 
-- 
Thorsten Blum <thorsten.blum@linux.dev>
GPG: 1D60 735E 8AEF 3BE4 73B6  9D84 7336 78FD 8DFE EAD4

