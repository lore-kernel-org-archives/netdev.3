Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C54C630216D
	for <netdev@vger.kernel.org>; Sun,  5 Jul 2026 21:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783288698; cv=none; b=EbDwTYyB7e2QRnTwT4DIJuNCbMvUthlQEgEygoSjxCMAYe+5tqaoR9pCSZMTJoGmQ7bJunYIwm7D6YCyMBrQw1CyZTz9x9GXrvoknjkel7imFZ5wB6oprzdwBTJuov9N68VX3NqH4Wv3LjhnJ9TB9yCcJuvRpVDIMOIdh1MlaQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783288698; c=relaxed/simple;
	bh=fsLQWYx9S7rh9aWQvUIiOdoCnDPWNE+xTofZODHUeqM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UPDi8mF+w2XGgEy+JAQi1CC+uLL9/W/3LEIWqJ1p+27Ke9QRJdUO6A9l/mq9uCcgBkqRTdG+5ZoDqI7whtcp8oNTFWYWfyQldPmuM6jxDFpASoVy9b7PR5OQ+gA8O75JnCiUCzXhLxn+fuw8v/rAEWUnC6wxnKD6/n1Pil3Jh8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=kdxxNFdj; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="kdxxNFdj"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-36b9d265355so1610159a91.2
        for <netdev@vger.kernel.org>; Sun, 05 Jul 2026 14:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1783288696; x=1783893496; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=utKDtKTqMmc6gZ7doveiePDIjTFwLL4HY/v+gdcdSqY=;
        b=kdxxNFdjGl4a7Vvb8AuYYNCB/TPlsjNNg6+eklBHP7Ztv8g95kLJKYe+PgggYx8lVY
         7yohz/cm7Ojb3CoxSdpi5S0gvkNSE7IRKkMaPaFBSxuY72wWwyDcN1AmdSXlByhzCQqi
         yJ2mIA9AhkN6z3ODvWcI6Wc2YoWUBvqeJ2W87SFO9cBpN1IzRFYeSgtd6tLe/HHI6jlw
         t8CbpJBQL5iMSr3G+3YS7/e/ACWOeeeno3l7sPspgs66X6b+ygnGiu6NqIOig9NHoMQd
         TTrFIPTPZUWpQEa9ZCLlPYbaG5laus6LzBYUCGvFoF7k7xp0+GtcKU2lL2Fe08/N3CEk
         KG2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783288696; x=1783893496;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=utKDtKTqMmc6gZ7doveiePDIjTFwLL4HY/v+gdcdSqY=;
        b=Nk408IrYwQlykXrxwC+Ec2tR7TBdv58llu8wPDSMyTBX/K8co1y+Bm94SaqtJv/0sK
         uMA6PmZi6f6oSKSl04t5Z6b0t5NSnBLqYwizUE9IVnHMiaPUhazRjl5h+X2yE1gNE4SP
         WMi5AYVKsq1zt09dR0bDjYUozEI1HNV7Pl2SIAt/hEYhtD9lYFmZxLrcBsflMXRQFKti
         gCOSijWgDmuosoNlZcZQbOX5fY3CYK5jvhT4udt4Xswa4p8Ay2qlmczcF++R1hCMPt+x
         RXUajPaN5QQeM51lfT67ymEJq05o63SDrcl1N6MeVLEEWH0jV8GPgduISr+2AltgX/FL
         EhvA==
X-Forwarded-Encrypted: i=1; AHgh+Rrj07EF+epmnrTEPhy/voxinFQKCm8EvWBgO1Yh+AtRCLAFCQd6vMVUgv1uRKaQiyehxpm+7P8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsWmav0zuKne8qEZ65y5by+fgnKe4mtFLshchJ8jkKQLg8poJa
	oOeEnJ7o7Pg/XTIKZI8pPE7qVsx0BRiiG5qWRAgpPekIpiCGW9+cBmk4EUijUzcgZA==
X-Gm-Gg: AfdE7cnbiVlHjB2gHiQGY2tpBh2zs64CcNtVf0Vw4/UTZSa/MTPLTku5iEpOQ8aEBJ3
	72uLNkmM4rWJPTljxa0rPHOInwPmHKHMCc4v497+Q7vnbYzLih/GZRZmeuLDSMByiaadC4hxjjQ
	CnxCVOrCKo3jmVk+wsZyXXdIqdXmApijGCaRfi1JKvel3JyXWKl5yl5iIUq2H58l7NdZ3KDzAq1
	YWOUD7tELjXpq0sAiREeXzCw0WNkBeZ0pFom+mwyvWx9jipyAvbtvcANhkoqs/CMBf7Bl7Cfjk8
	gmLVwxZ4hFtHE/mrGT76I4UZ//N/z1/fpXm3SIG8SnTXmE0wpVIMyKicgCgQ2SQmt/7AoYuA6YP
	iPy7t0hes09pW9KZLmbpOSxoa+8VyiqkrTN/GH3qr8wygHREgjBSew/f95drsDo3qnNHUIS3o1O
	k1oFS86jXz
X-Received: by 2002:a17:90b:510e:b0:37f:133a:3e09 with SMTP id 98e67ed59e1d1-382803b483amr7241574a91.3.1783288696081;
        Sun, 05 Jul 2026 14:58:16 -0700 (PDT)
Received: from p1.. ([2607:fb91:152b:9c50:23c1:1e1c:319e:7007])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38097da1a0fsm3210495a91.2.2026.07.05.14.58.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jul 2026 14:58:15 -0700 (PDT)
From: Xiang Mei <xmei5@asu.edu>
To: Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	Phil Sutter <phil@nwl.cc>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	bridge@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Xiang Mei <xmei5@asu.edu>,
	Weiming Shi <bestswngs@gmail.com>
Subject: [PATCH nf] netfilter: ebtables: terminate table name before find_table_lock()
Date: Sun,  5 Jul 2026 14:58:00 -0700
Message-ID: <20260705215800.2223145-1-xmei5@asu.edu>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

update_counters() and compat_update_counters() forward a user-supplied
32-byte table name to find_table_lock() without NUL-terminating it. On a
lookup miss, find_inlist_lock() calls try_then_request_module(..., "%s%s",
"ebtable_", name), and vsnprintf() reads past the name field and the
stack object until it hits a zero byte.

  BUG: KASAN: stack-out-of-bounds in string (lib/vsprintf.c:648 lib/vsprintf.c:730)
  Read of size 1 at addr ffff8880119dfb20 by task exploit/147
  Call Trace:
  ...
   string (lib/vsprintf.c:648 lib/vsprintf.c:730)
   vsnprintf (lib/vsprintf.c:2945)
   __request_module (kernel/module/kmod.c:150)
   do_update_counters.isra.0 (net/bridge/netfilter/ebtables.c:371 net/bridge/netfilter/ebtables.c:380)
   update_counters (net/bridge/netfilter/ebtables.c:1440)
   do_ebt_set_ctl (net/bridge/netfilter/ebtables.c:2573)
   nf_setsockopt (net/netfilter/nf_sockopt.c:101)
   ip_setsockopt (net/ipv4/ip_sockglue.c:1424)
   raw_setsockopt (net/ipv4/raw.c:847)
   __sys_setsockopt (net/socket.c:2393)
  ...

compat_do_replace() shares the same unterminated name via
compat_copy_ebt_replace_from_user(); terminate it there too so all
find_table_lock() callers behave alike. The other callers already
terminate the name after the copy.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Fixes: 81e675c227ec ("netfilter: ebtables: add CONFIG_COMPAT support")
Reported-by: Weiming Shi <bestswngs@gmail.com>
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Xiang Mei <xmei5@asu.edu>
---
 net/bridge/netfilter/ebtables.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/bridge/netfilter/ebtables.c b/net/bridge/netfilter/ebtables.c
index f20c039e44c8..5b74ff827493 100644
--- a/net/bridge/netfilter/ebtables.c
+++ b/net/bridge/netfilter/ebtables.c
@@ -1434,6 +1434,8 @@ static int update_counters(struct net *net, sockptr_t arg, unsigned int len)
 	if (copy_from_sockptr(&hlp, arg, sizeof(hlp)))
 		return -EFAULT;
 
+	hlp.name[sizeof(hlp.name) - 1] = '\0';
+
 	if (len != sizeof(hlp) + hlp.num_counters * sizeof(struct ebt_counter))
 		return -EINVAL;
 
@@ -2273,6 +2275,8 @@ static int compat_copy_ebt_replace_from_user(struct ebt_replace *repl,
 
 	memcpy(repl, &tmp, offsetof(struct ebt_replace, hook_entry));
 
+	repl->name[sizeof(repl->name) - 1] = '\0';
+
 	/* starting with hook_entry, 32 vs. 64 bit structures are different */
 	for (i = 0; i < NF_BR_NUMHOOKS; i++)
 		repl->hook_entry[i] = compat_ptr(tmp.hook_entry[i]);
@@ -2395,6 +2399,8 @@ static int compat_update_counters(struct net *net, sockptr_t arg,
 	if (copy_from_sockptr(&hlp, arg, sizeof(hlp)))
 		return -EFAULT;
 
+	hlp.name[sizeof(hlp.name) - 1] = '\0';
+
 	/* try real handler in case userland supplied needed padding */
 	if (len != sizeof(hlp) + hlp.num_counters * sizeof(struct ebt_counter))
 		return update_counters(net, arg, len);
-- 
2.43.0

