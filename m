Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E329D4A35;
	Thu,  6 Aug 2026 02:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785983576; cv=none; b=cMD6Xl4qMNWuNTTa1mJpvwNU4egO5ks05qaYT8kXVkoGdkVYRAZNVGbhx9O66NFAluQlS3TRxmIwBoJLKcB38ePgSgiR6du1KDs5CRZoAxkfB+bn0STkrm5kZGgMTmfXYUdl4iLcCSlkmXlZytHPsK1pua/d54cz37qk70195Po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785983576; c=relaxed/simple;
	bh=Lf7bl1412E1olnFaIYOsqmdsxii6Np6afoo3+y94IsI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RSfAUmbQyHFeseqX2aw3iwHiR44vfTroPS+mYj/F3NL3wwhmWj91hmvoFfQAz3nS25b+2uPY51FGHFdsSpLc0l+iG1jMCOT1wHh9/VFeo0vnvs8QR+pltnEP3V3a3TDpRmImhqcmpBaQOEdWDmuk7d6tW/ZTHWH8cdXPlbqFqxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=UZfy4h39; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=WSukOrje; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="UZfy4h39";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="WSukOrje"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4hFrsv347jzKw1f;
	Thu, 06 Aug 2026 04:32:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1785983571;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Qo1VPNC8nOFBalRWhK8gOF/0DtEf6ZBynh0WN/8gQK8=;
	b=UZfy4h395YHckDKIMymvTZQO1CDUOURRgWwsT/Wt5tx5ob2iFRKr+/OAL4YXe+OhLfoxKh
	lNNTFJ3wLaIe/BtshbXyz6jPCVpbQuJpRHpvTMqepw/9b4xgzCsPzmS6zU2aSYRHnyDMk9
	gMy72N/PlpokRuoOZMBuShZ7ga5ARXZ4gvWN/NjPO5cPVCduv0AS1DR8h+S30enjhEhlFj
	Qy53EdxnBO3ZvZqIncJjcHNhbrREKL49ayo6BuCWjTqoHmqg0BbsBjNFia2m9YREmi7ivE
	g/w37YAD2aQI/4oI9pEE77vk5n4UI4VC2L0Bz5IBqvoxZIvZHF+6fj9qb3EHJg==
From: Qing Ming <a0yami@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1785983569;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Qo1VPNC8nOFBalRWhK8gOF/0DtEf6ZBynh0WN/8gQK8=;
	b=WSukOrjen0TIhArFA7dvDyi7KKxxRVqhiONeSoT/FNmEVsBw4TTg2nFwJzxacwJRzb1B/u
	QiRtehO+BMdJZdw+Yei/lFhg6LLC7LYycYWk5fqgMmjICOU5d5QUWBhJ1krZuH4bItP72h
	YvTupHTCr3j6cMSQ4uTW8ICrN7c3x6GHKEWU/Poi7r5pr90npq2Wexbw5DOLHjzYj2TQNN
	YAbm8mC2WnEIWa0jIekBAOAvqEIIUvKP1DEiw466H/EMLUQ+PY8Mtt8LSeZXpbr3gNXv+g
	57Yl7sMepwAWztZ3d7TCwdvIozWDW2YoU8Bzl1W7aU9tGEHkLIU5k3Df6gZW2Q==
To: Pablo Neira Ayuso <pablo@netfilter.org>,
	Harald Welte <laforge@gnumonks.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	osmocom-net-gprs@lists.osmocom.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Qing Ming <a0yami@mailbox.org>
Subject: [PATCH net] gtp: serialize PDP deletion with link teardown
Date: Thu,  6 Aug 2026 10:32:26 +0800
Message-ID: <20260806023226.5537-1-a0yami@mailbox.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 68ff676b1b821b9e2ca
X-MBO-RS-META: s5i3z167nf5pejy3osfsya8mhci6sean

PDP contexts can be deleted through GTP_CMD_DELPDP or while the GTP
network device is being unregistered. The latter is serialized by RTNL,
but the generic-netlink delete path only holds RCU.

Running both paths concurrently can therefore make both paths delete the
same PDP context. On a KASAN-enabled kernel, a reproducer racing DELPDP
against RTM_DELLINK triggered:

  Oops: general protection fault, probably for non-canonical address
  KASAN: maybe wild-memory-access in range 
         [0xdead000000000120-0xdead000000000127]
  RIP: gtp_genl_del_pdp+0x1c1/0x420 [gtp]
  RBP: dead000000000122

The second deletion dereferenced the poisoned hlist pprev pointer.

Take RTNL around the DELPDP lookup and deletion so that PDP creation,
generic-netlink deletion and link teardown use the same serialization
domain.

Fixes: 459aa660eb1d ("gtp: add initial driver for datapath of GPRS Tunneling Protocol (GTP-U)")
Signed-off-by: Qing Ming <a0yami@mailbox.org>
---
 drivers/net/gtp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/gtp.c b/drivers/net/gtp.c
index 427b91aca50d..7c4a99e2fd52 100644
--- a/drivers/net/gtp.c
+++ b/drivers/net/gtp.c
@@ -2127,6 +2127,8 @@ static int gtp_genl_del_pdp(struct sk_buff *skb, struct genl_info *info)
 	if (!info->attrs[GTPA_VERSION])
 		return -EINVAL;
 
+	rtnl_lock();
+
 	rcu_read_lock();
 
 	pctx = gtp_find_pdp(sock_net(skb->sk), info->attrs);
@@ -2147,6 +2149,7 @@ static int gtp_genl_del_pdp(struct sk_buff *skb, struct genl_info *info)
 
 out_unlock:
 	rcu_read_unlock();
+	rtnl_unlock();
 	return err;
 }
 
-- 
2.53.0

