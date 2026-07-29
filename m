Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 871C643F4B7
	for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 09:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785316144; cv=none; b=haLiO0kS2baxagj0NZH+H+P9/xrGK8RrQverux707kq4HoY7D0I8PkSfXyfIuK9so+0s7W1g5ONxptoeLSQ/GfeZ1Yh4ObXSNDJriwUKeNMrcr89sniCUQJhO2AzV6aMwdQ/CzpwEIHLIgPb4G6tgGs6I+7sptzbnNar/c/eMoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785316144; c=relaxed/simple;
	bh=1YLiDFtSZF1xPfbk4LclfDsaFH5y15PBohDTcoKaMes=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HerjqCbcXcPgEFfOwVjEgzL6hE4bZvtrCjlODyfiCecvv9IVMrnvEjXpLDq16oJoA2Iu4qlOMFkncy+JUY+1Xd2lgez67GImYFU6M7fv4HHl9UA11Xqt4moI1GXKR90m83BWV2qRtPMzWTBz4/ZhqCghz7HF38Oc8phakas0oPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GCYghacT; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GCYghacT"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-493b966dd74so4276775e9.3
        for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 02:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785316141; x=1785920941; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZJH3L/LkkKN9qxK/5ZZMLYwTlfYIlG18ul0LnWqIOCw=;
        b=GCYghacT8TPory1IcOlkFxw72hpwvGdrxGO9Auu8JRspOR9SE0KM/UVc4jEZ0UxcGp
         9zgqidopsIEYs2tpw+dP6NtJ4zqqarBuzim2JQspv/0dkCPUkDFV/Car5dMGG2FbPEwF
         VFv4HrkqwDUHsDBWU13o4adP4FeuXuM8Uq7ORvh74yAuhmnzK3UZVNA6/3ZrHkcRfSpw
         EL7TP2BjulGTC7W5fvLJQ6yyX0WaigVwqREGeC9qHMdlUbgmSokf38qHqJfr+7VQd9Om
         ZwwVEMq0yQXKdL7f3O/xgoLKcr7kfY3oShvAzSZrVIqfBcAFLntrGNfJZOmHF8h14gyW
         c5AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785316141; x=1785920941;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZJH3L/LkkKN9qxK/5ZZMLYwTlfYIlG18ul0LnWqIOCw=;
        b=U2gLacUBqKpYmsSka1wAfqHKTXma20Ffxgfl1Tq/aBtRVOP36/YyY3FcWhGHwEANl9
         ncAQAbdMQvF3gj5HUUqhh1Z7Pp13Wfm57QJMcIwvDEjbjT1hQXca/5Ou+0KnTwxnacFT
         iuvMAyaDAafFlUglc888ILLzSr6Frxb0GzalRynYUAs320L5gKUrYCrpNvzn8d9WD4qF
         8VgkApwDGWgFALkPYMB4Xv8Ybyjj3yXZxkqwdnoy1hdY3/hhf+tOwrOLMrMgZXTcg9Zo
         3jsIY6WNhOhCEKbzP56AHb/s2KqpB27YAPjUetRyFk7BjYKAK8urm6CU0NdecStlopvb
         vAhw==
X-Forwarded-Encrypted: i=1; AHgh+RqKQ+bUW72zmzKewNG5Jma5/yemzybfdSci7SMvjdJrR524PwLRCJV5guwpVpIbontqijfu6Z0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzblGkgAwJfMS4ifUpgeOz8ZH+w1bvDpU92fAJtqLWVt/lyWdtW
	VYl+amzgiNkbX/Ui5WwjesT6Io8GIgbjU6FgGM63+vCjetRSoTyDyAtN
X-Gm-Gg: AR+sD1158vU/kk4/HBlz1QZikvnPGkmrgma+NSuKPNQwfA0GRO1db+1h1w9UjCdsCog
	yb1cEkfVQUwqjm3VDe7RJc4npid+VpGttuPmP5uIEFxQ00Ee7Su1wAMhViUb5RkciZByzqeJTti
	YsfX4QBEyBP6mjB8bNFzLPIpYZDO1xIR4ewo2/VZQGcHSjajH/rczAOcN7zsM1RTnIK7uzT/OZZ
	Ddehj+i4OAFB9oDPErnTgZ2bPGISRmYNwXXePrQMBn9r6G9Ak5+CfNegxRTVyIghiJlacHkb8rD
	Aeq9y9jsE7mdEI92/jPWDKxx5npQEIREEMKDnCpUWHt0wSpcWaYR+TDv3tkSjS8fG1MIAuWHdXz
	fFDzxljlrUK6N99JkCDnjIxRQHpBykkX7W4uqgxJ3s2vDOBWS2ytqZOXq7dGCG3+BWW/bQjpp+9
	qrGoBtZy0UwVgSylQEP5/aNwyHzWDdnhIQfhCojh9YqE32JB/5TRIXHtM845VTnvGw1mM=
X-Received: by 2002:a05:600c:630d:b0:495:6134:6d61 with SMTP id 5b1f17b1804b1-496c6568d4bmr72588225e9.19.1785316140544;
        Wed, 29 Jul 2026 02:09:00 -0700 (PDT)
Received: from grower.astralinux.ru ([81.9.21.4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-496e8e15a52sm29802675e9.0.2026.07.29.02.08.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 02:09:00 -0700 (PDT)
From: Alexander Martyniuk <alexevgmart@gmail.com>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alexander Martyniuk <alexevgmart@gmail.com>,
	lvc-project@linuxtesting.org,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jaehee Park <jhpark1013@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Xiang Mei <xmei5@asu.edu>,
	Weiming Shi <bestswngs@gmail.com>,
	Jiayuan Chen <jiayuan.chen@linux.dev>
Subject: [PATCH 6.6] ipv6: ndisc: fix NULL deref in accept_untracked_na()
Date: Wed, 29 Jul 2026 12:08:56 +0300
Message-ID: <20260729090857.76269-1-alexevgmart@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Weiming Shi <bestswngs@gmail.com>

commit d186e942365acece7c56d39da05dd63bf95b280a upstream.

accept_untracked_na() re-fetches the inet6_dev with __in6_dev_get(dev)
and dereferences idev->cnf.accept_untracked_na without a NULL check,
even though its only caller ndisc_recv_na() already fetched and
NULL-checked idev for the same device.

Both reads of dev->ip6_ptr run in the same RCU read-side critical
section, but a concurrent addrconf_ifdown() can clear dev->ip6_ptr
between them: lowering the MTU below IPV6_MIN_MTU calls addrconf_ifdown()
without the synchronize_net() that orders the unregister path, so the
re-fetch returns NULL and oopses:

 BUG: KASAN: null-ptr-deref in ndisc_recv_na (net/ipv6/ndisc.c:974)
 Read of size 4 at addr 0000000000000364
 Call Trace:
  <IRQ>
  ndisc_recv_na (net/ipv6/ndisc.c:974)
  icmpv6_rcv (net/ipv6/icmp.c:1193)
  ip6_protocol_deliver_rcu (net/ipv6/ip6_input.c:479)
  ip6_input_finish (net/ipv6/ip6_input.c:534)
  ip6_input (net/ipv6/ip6_input.c:545)
  ip6_mc_input (net/ipv6/ip6_input.c:635)
  ipv6_rcv (net/ipv6/ip6_input.c:351)
  </IRQ>

It is reachable by an unprivileged user via a network namespace.

Pass the caller's already validated idev instead of re-fetching it; the
idev stays alive for the whole RCU critical section, so it is safe even
after dev->ip6_ptr has been cleared.

Fixes: aaa5f515b16b ("net: ipv6: new accept_untracked_na option to accept na only if in-network")
Reported-by: Xiang Mei <xmei5@asu.edu>
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
Reviewed-by: Jiayuan Chen <jiayuan.chen@linux.dev>
Link: https://patch.msgid.link/20260617065512.2529757-2-bestswngs@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Alexander Martyniuk <alexevgmart@gmail.com>
---
Backport fix for CVE-2026-64542
 net/ipv6/ndisc.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/net/ipv6/ndisc.c b/net/ipv6/ndisc.c
index ee34831f5621..342e7066f765 100644
--- a/net/ipv6/ndisc.c
+++ b/net/ipv6/ndisc.c
@@ -973,10 +973,8 @@ static enum skb_drop_reason ndisc_recv_ns(struct sk_buff *skb)
 	return reason;
 }
 
-static int accept_untracked_na(struct net_device *dev, struct in6_addr *saddr)
+static int accept_untracked_na(struct inet6_dev *idev, struct in6_addr *saddr)
 {
-	struct inet6_dev *idev = __in6_dev_get(dev);
-
 	switch (READ_ONCE(idev->cnf.accept_untracked_na)) {
 	case 0: /* Don't accept untracked na (absent in neighbor cache) */
 		return 0;
@@ -986,7 +984,7 @@ static int accept_untracked_na(struct net_device *dev, struct in6_addr *saddr)
 		 * same subnet as an address configured on the interface that
 		 * received the na
 		 */
-		return !!ipv6_chk_prefix(saddr, dev);
+		return !!ipv6_chk_prefix(saddr, idev->dev);
 	default:
 		return 0;
 	}
@@ -1085,7 +1083,7 @@ static enum skb_drop_reason ndisc_recv_na(struct sk_buff *skb)
 	 */
 	new_state = msg->icmph.icmp6_solicited ? NUD_REACHABLE : NUD_STALE;
 	if (!neigh && lladdr && idev && idev->cnf.forwarding) {
-		if (accept_untracked_na(dev, saddr)) {
+		if (accept_untracked_na(idev, saddr)) {
 			neigh = neigh_create(&nd_tbl, &msg->target, dev);
 			new_state = NUD_STALE;
 		}
-- 
2.43.0

