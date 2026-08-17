Received: from mta0.migadu.com (out-125.mta0.migadu.com [91.218.175.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 450F332AABA
	for <netdev@vger.kernel.org>; Mon, 17 Aug 2026 08:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.125
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786955607; cv=none; b=aFDMrzj7mTMn/Qa5Qj8Sr6lVirljEWa+K8jDEo633KT06mXdv1J9c2ohPwvbIiChkDxgPTEDef9i3e5/Ony+cB8it1nshCk2OhHf5zVpGm5H2HUKnKimJotJ3ao5MGradqqG8/j+sRIFyhxoM8+guzfExa97G4pYZKWTpV4sbOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786955607; c=relaxed/simple;
	bh=ko7PXWqMcrRP4/P2+KkGqXsnI2xugaZyuPnhK3xtdNE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eWHPw51cMmIZT9u81V106mP2zgTiiaQtZLZF0r1kXXDQiHgHPFujVdv6xPnpclHp29yG87QVWW6vImNNShglOQR+ZlRmxmDeDzkor9yoiULIPGg4pJaVM+6npC1Z3zkzoucjVpLszKuAiUbQY2RYM7nkQHP4/VsqwHZzCj3C6pM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=eNPj/Yrr; arc=none smtp.client-ip=91.218.175.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="eNPj/Yrr"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=ko7PXWqMcrRP4/P2+KkGqXsnI2xugaZyuPnhK3xtdNE=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786955604; v=1; x=1787560404;
 b=eNPj/Yrr4K8yECwQkBIspQmkJnGfDFZwvRshPJWWdf+AOvqCPVUYzmGhTgas+2+Mid0GQa/6
 dn5St+WNUEGB6AFGsQcjOnV/RY6gQB8yvFeNssgkMk+7YYCRwCnNKtwqbqQBywID/+0UwdPC+lE
 bs5fn2JnQG7eaJ/e8R0LaNrw=
X-Envelope-To: netdev@vger.kernel.org
Received: from [192.168.110.119] (216.236.36.150)
	by smtp.migadu.com with ESMTPS id 1a03b180869e9275;
	Mon, 17 Aug 2026 08:33:24 +0000
X-Migadu-Flow: FLOW_OUT
From: Hangbin Liu <hangbin.liu@linux.dev>
Date: Mon, 17 Aug 2026 16:32:36 +0800
Subject: [PATCH 1/2] bonding: 3ad: fix NULL pointer dereference in
 ad_mux_machine()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260817-bond_rcu-v1-1-acf067cf45fe@kylinos.cn>
References: <20260817-bond_rcu-v1-0-acf067cf45fe@kylinos.cn>
In-Reply-To: <20260817-bond_rcu-v1-0-acf067cf45fe@kylinos.cn>
To: Jay Vosburgh <jv@jvosburgh.net>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Hangbin Liu <liuhangbin@gmail.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Hangbin Liu <liuhangbin@kylinos.cn>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.3

From: Hangbin Liu <liuhangbin@kylinos.cn>

In bond_3ad_state_machine_handler(), ad_port_selection_logic() runs
before ad_mux_machine() for each port. When ad_port_selection_logic()
detaches a port from its current aggregator but fails to find a
suitable replacement, it returns early, leaving port->aggregator as
NULL. The subsequent call to ad_mux_machine() then dereferences the
NULL aggregator in multiple switch branches, triggering a kernel oops.

Add a NULL check for the aggregator at the top of ad_mux_machine() and
return early. This avoids needing null guards in later branches.

Detected by AI code review.

Fixes: c4f050ce06c5 ("bonding: 3ad: implement proper RCU rules for port->aggregator")
Cc: stable@vger.kernel.org
Signed-off-by: Hangbin Liu <liuhangbin@kylinos.cn>
---
 drivers/net/bonding/bond_3ad.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/bonding/bond_3ad.c b/drivers/net/bonding/bond_3ad.c
index acbba08dbdfa..196830fca4a4 100644
--- a/drivers/net/bonding/bond_3ad.c
+++ b/drivers/net/bonding/bond_3ad.c
@@ -1053,6 +1053,9 @@ static void ad_mux_machine(struct port *port, bool *update_slave_arr)
 	last_state = port->sm_mux_state;
 
 	aggregator = rcu_dereference(port->aggregator);
+	if (!aggregator)
+		return;
+
 	if (port->sm_vars & AD_PORT_BEGIN) {
 		port->sm_mux_state = AD_MUX_DETACHED;
 	} else {

-- 
2.55.0

