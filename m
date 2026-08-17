Received: from mta0.migadu.com (out-129.mta0.migadu.com [91.218.175.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7E6B3290DB
	for <netdev@vger.kernel.org>; Mon, 17 Aug 2026 08:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786955616; cv=none; b=ehMo9EJ502kEb4NV0zV77QVc93yr/OnN2o4ZRZ/+RPC7XoxUwUhk4WLgeo5YHStSlX9NmqbXew9RCgdBa1mWGnBrL7msgFVzASL0cxeBQGk1u9C+mzOzPVVwP8Zt7/xHFK5Rc0PnH39LwvY5NKK8+cdBoH440KlihFxSL4NU3Qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786955616; c=relaxed/simple;
	bh=Me9mOV+BwEv4PJ9PCsw9WW3c6SO6Hiy+WMiXP3LnMno=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=J+rEeLpZ5i1s2QqPrOGH4Jj+gFClukQ3qXKpBXGq+zwfJ54S0uBLDxlbm3kJhh4aC3q8bGOmKldap86E8ixvegXvbuQgIJm3USzoYucon0rwrm0pwOs8qJbRa5ljFCnmsZM509EvCIoo3LNJE6qe0ujIL3vlHpAPFqeIpHNVYEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=BoIlukUQ; arc=none smtp.client-ip=91.218.175.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="BoIlukUQ"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=Me9mOV+BwEv4PJ9PCsw9WW3c6SO6Hiy+WMiXP3LnMno=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786955613; v=1; x=1787560413;
 b=BoIlukUQxdsvfzWtlOkyHE1aZf6ktZYuKWETukRiqzltUMRri2SA277uc8E0CpdmivsqdgWE
 6TXcObjm2jAivBVzOGguBlgO6pzSitW2PYtXVdSJMrWJ3pH/eehACW5RiTKLHy/BYBaVcpUq++X
 o5ms2PDqHUikLzvoAxqRbHis=
X-Envelope-To: netdev@vger.kernel.org
Received: from [192.168.110.119] (216.236.36.150)
	by smtp.migadu.com with ESMTPS id 7fb4c39416823aba;
	Mon, 17 Aug 2026 08:33:32 +0000
X-Migadu-Flow: FLOW_OUT
From: Hangbin Liu <hangbin.liu@linux.dev>
Date: Mon, 17 Aug 2026 16:32:37 +0800
Subject: [PATCH 2/2] bonding: 3ad: use RCU_INIT_POINTER for rcu pointer
 initialization
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260817-bond_rcu-v1-2-acf067cf45fe@kylinos.cn>
References: <20260817-bond_rcu-v1-0-acf067cf45fe@kylinos.cn>
In-Reply-To: <20260817-bond_rcu-v1-0-acf067cf45fe@kylinos.cn>
To: Jay Vosburgh <jv@jvosburgh.net>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Hangbin Liu <liuhangbin@gmail.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Hangbin Liu <liuhangbin@kylinos.cn>
X-Mailer: b4 0.14.3

From: Hangbin Liu <liuhangbin@kylinos.cn>

Use RCU_INIT_POINTER() for initializing port->aggregator to NULL.

Fixes: c4f050ce06c5 ("bonding: 3ad: implement proper RCU rules for port->aggregator")
Signed-off-by: Hangbin Liu <liuhangbin@kylinos.cn>
---
 drivers/net/bonding/bond_3ad.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/bonding/bond_3ad.c b/drivers/net/bonding/bond_3ad.c
index 196830fca4a4..c4dfcafcff26 100644
--- a/drivers/net/bonding/bond_3ad.c
+++ b/drivers/net/bonding/bond_3ad.c
@@ -2075,7 +2075,7 @@ static void ad_initialize_port(struct port *port, const struct bond_params *bond
 		port->sm_mux_state = 0;
 		port->sm_mux_timer_counter = 0;
 		port->sm_tx_state = 0;
-		port->aggregator = NULL;
+		RCU_INIT_POINTER(port->aggregator, NULL);
 		port->next_port_in_aggregator = NULL;
 		port->transaction_id = 0;
 

-- 
2.55.0

