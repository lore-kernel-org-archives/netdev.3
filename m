Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1301E38A714
	for <netdev@vger.kernel.org>; Fri,  9 Oct 2026 15:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791561569; cv=none; b=ALTh9FAj/e2+Ey2359PLIegrJGrTMVnyVanG264Newt+R59/C/JCr8nvjVoB9orSguLQ+/1x70quovHvO6mRBe/4Y+W6DtPfGyZFmyNFWBlCJz2k5vjn/aWfEYqFoycnlZWbGVNntjzRR1CsdMLe7hWDzE7DJ3sLKZ3FXSx6VPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791561569; c=relaxed/simple;
	bh=SApc59YzCwRilPxJtVxaVU48pNYGd4aJq+B9jaBhg34=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=u3jFyt4bVQXv+J3HmvagPEq5C1jIG+Jf+bUqwnc/PmrOYfOGT6enI5M9w4g3mCMeLNLlUNp+Ds+dI2NY36+GRmsF9mFltlOzNbPpioNdCYvBQaenFHsMRO2pZ9j9rciBRaXB4miAZNpkFY2O1hdWll1PfaeOKbCa0u0O//JZKGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ryl+Db6V; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ryl+Db6V"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-381b831d535so6676329a91.0
        for <netdev@vger.kernel.org>; Fri, 09 Oct 2026 08:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791561564; x=1792166364; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:content-type:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MnbNTDMKnQ+cc7snapZC6GmnCPJe6LWB9TFzXVxs9Bw=;
        b=ryl+Db6Vhd4pBW/YEGuUM5radpTxfz1Ls2kQYJ3tokNUXNcZNWofh7V2O0gQazmETt
         6/5yBS3vTzV3DonlfZ8jGkEckzkF7i34SEfbZscHzaHjogXEZUTtr2pPolcKMwCltKbW
         Zp55fASBkLCATTqAtnK7ex1B8Yfm1Ux7aFcqYNb4s+FQQDrXB9g72ZnfJzAksIisut0w
         b+hSXbwYJfQ1PpXyYz/mS//x6tz4QmPGfbocnxnTssJ7+pxDJ13lEdhZtHMnXREqjuM8
         n0NiXljuc0noD6bA05wmkOnqj4G3mOumSC3f787G3mFdR3VPQzOZ/spDujKn3I1KiYm7
         A50Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791561564; x=1792166364;
        h=mime-version:content-transfer-encoding:content-type:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MnbNTDMKnQ+cc7snapZC6GmnCPJe6LWB9TFzXVxs9Bw=;
        b=n8gf84UUCJC9zIIJlR1rVu2EDVEXkKu9OtwybDnODvcIrAXd2kiLyyXz7G90bhKJ5I
         67N0Rju6FNaCrHAV9C1BiVVvA3Vcg6VdRT2a3MmYsANdGc/M5wswsTnqs/hCgGxDwkD9
         KmWM+fOj0Y/QIVOM/LJ8Xj+bYlr6Jyi5KSpO/mHRyBZPZDr/BWmJtS8OfndA0lc0z514
         v4SkPkpjSL1Gvzfpg/TgwvfwklsNWr6GiO9nITRvbF7oTHd4yOpgTeHuz6fDjeLX/Icc
         BmtKaCnuZvX4DMnGraAaE56mYXYdr9JMMnfqFCQo9kVpbQ30XfYGQtfIG4n+JXibvqNR
         Urfg==
X-Forwarded-Encrypted: i=1; AKwUvBw1j1CGBVafTsnwWYgs/rLcCYT9zCHmcDDXcMi57gZ3ydGWdSFm62UndUG1JwTxDmCr9/n8oBg=@vger.kernel.org
X-Gm-Message-State: AFq9FYKu34Hpt7rrgmGV7T6y419mPI5rrBEbgJDaqIbqmexS/szs4Vyv
	BNagjC94r3Pe6+QH0CdVH5uU28Lop64vtMGD3f/0S07RqVLDAQC83yvJ
X-Gm-Gg: AYBFou3+wAE1pobOqVjBZdITjsx/PRGolzSjaHG/m1ioopxQgDTDaYAzm6ChJHgRmVo
	mutC9YwHtoxxfeI+l/vGPWs/LJZudbHerW5Sp52Tocrebrxj437yQ9YWqvo17qFHjVUbRMFMdk8
	hYNZjh35av9pKl7KkKi4TKSxv7hIYCdQckQshF5628lNPGZTm8AEnkPxo8oZ9fUbxgyEV0Dmx2q
	R0hKk921XOF7fKOtRaRbZ8qF5Ww5qh+MdmOjb6O9d5UBrUiO8DC7JZfhyG0kTbWsyHhyCNUwSQu
	J8n4sCZIuxXVQ4aRxGLyv7XckAgzs4IYaAOZRb1KrrQiWwHKsUb/mnhyTnXC0U87cqjaJSSScTZ
	2JNdwqbHwHS/FZi5Oa1Pbim/fX729XwsL5ZBNkCSh4DjLZfg9Od7EhV067TJ96Dx/Ka9G+tQkNo
	qcX/Mm5fwREiQbD9eG9hFXPsZcbkuv+5SD9vxXF13HNNdaB2t5sJwI92Ndv1wSuWKEYFV86Ta8r
	QhqKQcHffNwAvOZXz2QMr9DBWHaIPPU+Gcim6yCE1Bo3ZVBsKMXcMofZrjcqfYRmiftI7Qf4el8
	MwfpnRB+yQwF4yEP2VDmLQ0Y/5/rEac8lZ1yq4XhRrV5ZeRU0upsB/do4+vH2Q==
X-Received: by 2002:a17:90b:3b84:b0:3ab:1b19:78f4 with SMTP id 98e67ed59e1d1-3ab3a3a11a1mr2243151a91.6.1791561564260;
        Fri, 09 Oct 2026 08:59:24 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([2804:7f0:b100:655c:c59b:456c:2d4d:2359])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ab38ff0d34sm4440420a91.14.2026.10.09.08.59.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 08:59:23 -0700 (PDT)
From: Joas Antonio dos Santos <joasantonio108@gmail.com>
To: Paul Moore <paul@paul-moore.com>
Cc: Eric Dumazet <edumazet@kernel.org>, Wang Zhan <wang.zhan@smartx.com>,
 David S. Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, linux-security-module@vger.kernel.org,
 Alice Mikityanska <alice.kernel@fastmail.im>
Subject:
 [PATCH net v2] calipso: keep BIG TCP payload_len in calipso_skbuff_setattr()
Date: Fri, 09 Oct 2026 12:59:19 -0300
Message-ID: <179156155963.36253.400481753322266658@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

calipso_skbuff_setattr() adjusts payload_len by the length of the
option it inserts or resizes:

	payload = ntohs(ip6_hdr->payload_len);
	ip6_hdr->payload_len = htons(payload + len_delta);

GRO can build BIG TCP packets larger than IPV6_MAXPLEN, and stores
payload_len == 0 for them; ipv6_payload_len() then falls back to
skb->len.  For such a packet forwarded to a destination mapped to
CALIPSO, the code above writes len_delta (or 65536 + len_delta when
shrinking) into payload_len, and ipv6_payload_len() no longer falls
back to skb->len.  nf_tables, conntrack and sch_cake rely on it.

The same arithmetic also wraps when a packet grows past IPV6_MAXPLEN,
and a BIG TCP packet that shrinks below IPV6_MAXPLEN should get its
real length back.

Set payload_len from the skb length with ipv6_set_payload_len(), which
stores 0 above IPV6_MAXPLEN and the real length otherwise, as
ipv6_gro_complete() does.  The network header was just reset to
skb->data, so skb->len - sizeof(*ip6_hdr) is the payload length.

Tested on one kernel (arm64, QEMU) with SELinux permissive, a minimal
mdp-generated policy (network_peer_controls=1), "netlabelctl calipso
add pass doi:16" and a NetLabel mapping of fd00:2::/64 to CALIPSO
DOI 16.  calipso_skbuff_setattr() was called through
netlbl_skbuff_setattr() from a test-only debugfs hook (not part of
this patch) adding a level-only label; payload_len after the call:

  case                         before fix   after fix   real length
  1000, unlabeled                    1016        1016          1016
  70000 GSO, payload_len 0             16           0         70016
  65530 GSO, grows past MAXPLEN        10           0         65546
  65540 GSO with a 24 byte hop
  header, shrinks below MAXPLEN     65528       65532         65532
  1000 with a 24 byte hop header      992         992           992

(0 means ipv6_payload_len() returns the real length.)  On the forward
path, with a client injecting unlabeled UDP through a router to a
server, the router adds the CALIPSO option and the server delivers all
datagrams (Udp6InDatagrams 5, Ip6InTruncatedPkts 0) with this patch.

Fixes: 81fbc812132c ("ipv6/gro: insert temporary HBH/jumbo header")
Suggested-by: Eric Dumazet <edumazet@kernel.org>
Suggested-by: Wang Zhan <wang.zhan@smartx.com>
Signed-off-by: Joas Antonio dos Santos <joasantonio108@gmail.com>
Assisted-by: Claude:claude-opus-5-5
---
Changes in v2:
- Use ipv6_set_payload_len(ip6_hdr, skb->len - sizeof(*ip6_hdr)) instead
  of skipping payload_len == 0, so that growing past IPV6_MAXPLEN and
  shrinking below it are handled too (Wang Zhan).
- Test the boundary cases; table in the changelog.

Test-only debugfs hook used above (built in with obj-y in
net/netlabel/Makefile, triggered with
"echo 1 > /sys/kernel/debug/calipso_selftest"):

  // SPDX-License-Identifier: GPL-2.0
  /* TEST ONLY, not for submission: drive calipso_skbuff_setattr() through
   * netlbl_skbuff_setattr() around IPV6_MAXPLEN.  Needs a NetLabel mapping
   * of fd00:2::/64 to CALIPSO (netlabelctl).
   * Trigger: echo 1 > /sys/kernel/debug/calipso_selftest
   */
  #include <linux/debugfs.h>
  #include <linux/ipv6.h>
  #include <linux/module.h>
  #include <linux/skbuff.h>
  #include <net/ipv6.h>
  #include <net/netlabel.h>

  /* hop-by-hop header carrying a CALIPSO option with 8 category bytes,
   * 24 bytes in total, so that a level-only label shrinks it by 8 */
  static const u8 big_hop[24] = {
  	IPPROTO_TCP, 2,				/* next header, 3 x 8 bytes */
  	0x07, 16, 0, 0, 0, 16, 2, 0, 0, 0,	/* CALIPSO, DOI 16, 2 cat words */
  	0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
  	1, 2, 0, 0,				/* PadN */
  };

  static void run_one(const char *name, unsigned int payload, bool labeled,
  		    bool gso)
  {
  	struct netlbl_lsm_secattr secattr;
  	struct ipv6hdr *ip6;
  	struct sk_buff *skb;
  	int rc;

  	skb = alloc_skb(LL_MAX_HEADER + 512 + sizeof(*ip6) + payload, GFP_KERNEL);
  	if (!skb)
  		return;
  	skb_reserve(skb, LL_MAX_HEADER + 512);
  	skb_reset_network_header(skb);
  	ip6 = skb_put_zero(skb, sizeof(*ip6) + payload);
  	ip6->version = 6;
  	ip6->hop_limit = 64;
  	if (labeled) {
  		ip6->nexthdr = NEXTHDR_HOP;
  		memcpy(ip6 + 1, big_hop, sizeof(big_hop));
  	} else {
  		ip6->nexthdr = IPPROTO_TCP;
  	}
  	ipv6_set_payload_len(ip6, payload);
  	ipv6_addr_set(&ip6->saddr, htonl(0xfd000001), 0, 0, htonl(2));
  	ipv6_addr_set(&ip6->daddr, htonl(0xfd000002), 0, 0, htonl(2));
  	skb->protocol = htons(ETH_P_IPV6);
  	if (gso) {
  		skb_shinfo(skb)->gso_type = SKB_GSO_TCPV6;
  		skb_shinfo(skb)->gso_size = 1400;
  	}

  	netlbl_secattr_init(&secattr);
  	secattr.flags = NETLBL_SECATTR_MLS_LVL;
  	secattr.attr.mls.lvl = 0;

  	pr_info("CALSELFTEST %-12s before: payload_len=%u ipv6_payload_len=%u\n",
  		name, ntohs(ipv6_hdr(skb)->payload_len),
  		ipv6_payload_len(skb, ipv6_hdr(skb)));
  	rc = netlbl_skbuff_setattr(skb, AF_INET6, &secattr);
  	pr_info("CALSELFTEST %-12s after:  rc=%d payload_len=%u ipv6_payload_len=%u real=%u\n",
  		name, rc, ntohs(ipv6_hdr(skb)->payload_len),
  		ipv6_payload_len(skb, ipv6_hdr(skb)),
  		skb->len - (unsigned int)sizeof(struct ipv6hdr));

  	netlbl_secattr_destroy(&secattr);
  	kfree_skb(skb);
  }

  static ssize_t trigger(struct file *f, const char __user *buf, size_t len,
  		       loff_t *pos)
  {
  	run_one("grow-normal", 1000, false, false);	/* 1000 -> 1016 */
  	run_one("grow-bigtcp", 70000, false, true);	/* 70000 -> 70016 */
  	run_one("grow-past", 65530, false, true);	/* 65530 -> 65546 */
  	run_one("shrink-below", 65540, true, true);	/* 65540 -> 65532 */
  	run_one("shrink-normal", 1000, true, false);	/* 1000 -> 992 */
  	return len;
  }

  static const struct file_operations fops = { .write = trigger };

  static int __init calipso_selftest_init(void)
  {
  	debugfs_create_file("calipso_selftest", 0200, NULL, NULL, &fops);
  	return 0;
  }
  late_initcall(calipso_selftest_init);

 net/ipv6/calipso.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/ipv6/calipso.c b/net/ipv6/calipso.c
index c6a34334e..a0192b4fe 100644
--- a/net/ipv6/calipso.c
+++ b/net/ipv6/calipso.c
@@ -1318,7 +1318,7 @@ static int calipso_skbuff_setattr(struct sk_buff *skb,
 	struct ipv6hdr *ip6_hdr;
 	struct ipv6_opt_hdr *hop;
 	unsigned char buf[CALIPSO_MAX_BUFFER];
-	int len_delta, new_end, pad, payload;
+	int len_delta, new_end, pad;
 	unsigned int start, end;
 
 	ip6_hdr = ipv6_hdr(skb);
@@ -1357,8 +1357,8 @@ static int calipso_skbuff_setattr(struct sk_buff *skb,
 			sizeof(*ip6_hdr) + start);
 		skb_reset_network_header(skb);
 		ip6_hdr = ipv6_hdr(skb);
-		payload = ntohs(ip6_hdr->payload_len);
-		ip6_hdr->payload_len = htons(payload + len_delta);
+		/* 0 above IPV6_MAXPLEN (BIG TCP), the real length otherwise */
+		ipv6_set_payload_len(ip6_hdr, skb->len - sizeof(*ip6_hdr));
 	}
 
 	hop = (struct ipv6_opt_hdr *)(ip6_hdr + 1);
-- 
2.43.0

