Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2093743F4A6
	for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 09:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785316111; cv=none; b=CwcBlCzwYRQHtfayFCR0ZCSdTy61CuJQu5jKsWVaPGuUBCq9pgoUhfhTvp3B2yjOZ1pSDDILUUEUQ174ixDbUfFw354imLpv1ZDDMPJopcesJ2LKSgsRDJXvkcw4F8lrRawsEKaphBl8iXKchuY5f+MPLRMBmDDl+kbBW4QUC+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785316111; c=relaxed/simple;
	bh=bIItaHqYW24nK/xRimTkPYGOZEAW0zpj0X9RyzqKtUg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eHnlyPyDAekyJnp0C88DRwxbTq2Unm5iecdwAPwjibusIBwzvr+/VRE9rDm0fddBxxiDEifelYMWMeR72HMim7OlcSNC7qXNRkkdzNxAHBKrHYsmRsRd9NPa1hUYFWeMHtLTxqDBK3pSMu/BbHzVdqaWr9mqIJxLIipGIXMfFl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BFu39sCG; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BFu39sCG"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4957eefd361so4976155e9.1
        for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 02:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785316108; x=1785920908; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=GHDM64FW0s/e76WnDR5ucgvsJnpJjxSSemWTfxAmKNM=;
        b=BFu39sCGzn4SF9hMejhnmgdSH6Yn0OQX1tJ0cfGShyW6TQ2n4yd9Ql8fyPRZnj444G
         yAEBc/XL4os7cMCILdVZE4oOLNBJ/8Vnv1r9NCSVCiWLj4ji5MQ53cgcA6hnitQq2GCN
         PPNgZEVQXVQN/g95K/DXe83CXEGcHLjQGZOOq4mP6AAToiPm3CZALMpohVNvzwLd/S4D
         QrOW9SYnlLK7F39YF5uCGkMuvB42aGlRMhySX/wa/zYCiJmM5WY8ntbpe2I2tLPdmaBs
         gbTmbPbGToIbdqV/Qw70EQTuSpm+DdXHJpLnhYSf5kZNi6ruCbQ//8toNne1QR9Q5Dp8
         /Dhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785316108; x=1785920908;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GHDM64FW0s/e76WnDR5ucgvsJnpJjxSSemWTfxAmKNM=;
        b=NggQ0XXBYw3pCFfagsQuCkAKi79S3NN8nqiCKGXhRQFaPCqqcc2vBjx7gBy95MWmSB
         oXSmHdHFQ0eeJ0xO243gmBvaPvKsA5+DHTtvOZ0doHFWTyxOF1o12U2bXAodM/dolyjb
         dvowKfXGGxrB3aE/Rrl3dhU04D67kGIMoKAx4DUmP+DkGCUc+gtv4ahjYXaN4RAMc49M
         fgiukMgJDQOFgtRwxwsFZ9RZ//V4LTr8LOU3DIA7/fgb91TbC5OAXkCKQNDhUVheKbNE
         tk85U3rHaCOt9K6BS7p0R1rF6dABbA1sKgJoi0ZduRHOEfbWPKndeR1k4e6Yf4vPQsAf
         Gg0w==
X-Forwarded-Encrypted: i=1; AHgh+Rri9bby1BL6u+1VCbDHGX+uraH2/ThSjEsq98SbarZlBEwz35TACMJsOJ0qoy3n6R2YECanrpI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2L8UczmCiiaCykO+4O8rMQ1bAQCMxQ6Dku9IvEfmYtI1CKhwz
	lDZ9Rc3Q79YZPQEaZnCDmpsdMzk1MhYSD0TfuA11gupD773f/IcRMT9p
X-Gm-Gg: AR+sD12oMQFhhkO2xvk7dVChbh2MdFa3ZxsJ/FKOvKmkGFh1S8uc2pH6qEPho25WgRP
	fzSQ1urHBR0Hw/fvXF5eyF/rii8Jhc3G7HtnZVqUp46m9/s+ZU1kgaNyHr01JHvFNgxw7PPo/tD
	+go+3rZTsxrdoL8QY1ocHlf1dTUSRJPgQhqr5Fs8x06yAGBpFYNKZyenLaixCP/mr73dH+YWhSM
	SZMUxSlpFzULyH3dNGXrfxM/te/qy/heU3UTY7jCY7XC1IB7SmzZtKcIflwO4Vge36fPfk7EwWk
	tT23V/H5vAYeiKjoKaoJexKD4ouQGBbuGsuGKuXQwtoK6hs5O56EzD2WD8/Svss4GBSWwouoaiP
	gz4B0pNkk4EAOJGioKz6xSoDJJtzlAZuWqcccopp7gDhC08ayKZkmKjscDFCd9ZZlEwXPJWodaX
	rsg3zFOATFGO0yS8xVPKktHby49bptXikOOAxM5fBabt5/ak2hVatvTw7ch8sV1F13gouLAWowJ
	64RoQ==
X-Received: by 2002:a05:600c:4452:b0:493:e79e:da98 with SMTP id 5b1f17b1804b1-496c65c6d3amr57371055e9.39.1785316108100;
        Wed, 29 Jul 2026 02:08:28 -0700 (PDT)
Received: from grower.astralinux.ru ([81.9.21.4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-496c44af22dsm130105565e9.1.2026.07.29.02.08.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 02:08:27 -0700 (PDT)
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
Subject: [PATCH 6.1] ipv6: ndisc: fix NULL deref in accept_untracked_na()
Date: Wed, 29 Jul 2026 12:08:08 +0300
Message-ID: <20260729090809.76178-1-alexevgmart@gmail.com>
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
index f1c4c4dbefb0..85f7798d3e55 100644
--- a/net/ipv6/ndisc.c
+++ b/net/ipv6/ndisc.c
@@ -972,10 +972,8 @@ static void ndisc_recv_ns(struct sk_buff *skb)
 		in6_dev_put(idev);
 }
 
-static int accept_untracked_na(struct net_device *dev, struct in6_addr *saddr)
+static int accept_untracked_na(struct inet6_dev *idev, struct in6_addr *saddr)
 {
-	struct inet6_dev *idev = __in6_dev_get(dev);
-
 	switch (idev->cnf.accept_untracked_na) {
 	case 0: /* Don't accept untracked na (absent in neighbor cache) */
 		return 0;
@@ -985,7 +983,7 @@ static int accept_untracked_na(struct net_device *dev, struct in6_addr *saddr)
 		 * same subnet as an address configured on the interface that
 		 * received the na
 		 */
-		return !!ipv6_chk_prefix(saddr, dev);
+		return !!ipv6_chk_prefix(saddr, idev->dev);
 	default:
 		return 0;
 	}
@@ -1086,7 +1084,7 @@ static void ndisc_recv_na(struct sk_buff *skb)
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

