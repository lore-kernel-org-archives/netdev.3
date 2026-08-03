Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C6AA3C3C0E
	for <netdev@vger.kernel.org>; Mon,  3 Aug 2026 17:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785776762; cv=none; b=ETsm77cWk3w3QDe9OSx4mNxaQe6q4FZ4K9h9/NvP2Mp+BO+A+1fYf0IYVBnnRsw0V0i2avIt9jsLXupHR1kRrqmbgExQ/RjDiSN5pwxRn/ZPB6afg/nPJNvGUVjcaHf9CqQqKaIUD7xKNba/NNAuhUoRyRb+NlznjM6xJZju5O4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785776762; c=relaxed/simple;
	bh=ptxOntIFwPlljFAuNIhhXdjtH2CSVaiI5tnXedt+VNk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JHUqd+C6kPTKntr8JL4XRHT5SXj0FtlO/pObbpMUS8iMUC8V+TP5Z3bSatVhy7Jkams3doamiRVfYwv9AejzDyXl9/StoRZlIRpdtdNui5GJRbDi9mCiqbYjMMGEfxEyiy5lzU86bmyugWwVVWbMrrzt+sJ+Dk1F8dTQTWvgOhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dHIdLIBv; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dHIdLIBv"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-47fde295992so88387f8f.0
        for <netdev@vger.kernel.org>; Mon, 03 Aug 2026 10:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785776759; x=1786381559; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5Bba4gcbhmr4SK0bvCYEbGznO8O2RUuHHW+hHe/3QmM=;
        b=dHIdLIBvZtaQSbMfG6pZZYxSxtO6XbFqzpRyIH7LCjS6OmAcHY7WkODA0I7q5GQdZ/
         g5YQ6Ce7tQRAJ0GvW2Dh5Xhj8j4w1MUKPqm3WGcruolHjnqXtw4BE9AVVBHZqr1Ej9EA
         N1IU7vvoKLmUuJNYayK5w2rV+1pt8QGmLgjnCwAOHh3tBWQvU4N4C9oMHaMwkyi3FWSV
         5a62W3SEUiwoaQMMObWCiLdZOD8r8KRa3XFDF+eTiuz6TYgO+qOVw+lzwJLmhoFIt7Zj
         hw8n/2XfDJZPPQYatINmRDnSlfMWRNqkzEt55BBqZhLpJG4gR+P42brFekQIu85xv4jQ
         4biw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785776759; x=1786381559;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5Bba4gcbhmr4SK0bvCYEbGznO8O2RUuHHW+hHe/3QmM=;
        b=KZyHm2FArulSaJBdlxBT5hHImPgVnQGWp5ec4hxqaoDNwZ3iLHj8qrzrCdWm7Nia2l
         7HyhAtMiUYwLoG/GFWuiQ0y1KF5/epGiUfcIJ4grlFtDjZHg1P8WTd4eNQwZQyCbDA1o
         ucvBpVZizF3sOsgTmSaiWsxpZjQQOypSc/vlc0CZ+zKrN1q90lEx5ib/+6LM2b1/nKJ9
         jx2mgcpVxkAG8InsihnmAl6I7QGCBq2hatIizr6n3DDlInycVPE2OCdtS4lDk9BXaMdU
         qQzcCjkjL1Jct+hNaCc9zFvUcZO75bjsGCrC4hCj44k4kp6njsMP8itrqy+r4QIJCSiL
         +3vA==
X-Forwarded-Encrypted: i=1; AHgh+RrCkia/TNb38jNVG5PyXJuHFiO2UAvhV3qhLptATfVukjdiqadok4MZxOFapCQCfaUHeP+UG4M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiHblM1QwuQl0D1IKqDdei1DOhuis8RCXCdNmqP1QNiLaKHBCG
	n+WoKNLMRE/uMYsST4JJHT/GYlasoc9ohDq9Ps0v1EgdcfZeGOkX+uw+
X-Gm-Gg: AR+sD11ifY/AYrYG7vM6U+dIg0ZHhaRrp4gH4IGx+L9dKysNzou+7OMwTsPnJ7zdrAl
	IDiFN5bHwEYYUGdz4PB/kg7wD7BG1S3gbOF2ifV0XLSA/JXETTLhNLGUAaoZUBXuf74bET2APSs
	92D3lw4FD2AF7wbwolZPcq1Pgn1049x5aPSnzIykItANhds43lwPb4tK8Eb4Tkc8nHN8F4Tkjoh
	ENC8nAazPZM1V0xnfp9UKAfbtqZoJGMjM7cdCLmShmmyU8svhruJ9LyEIjLQke/CPOaMqZGICMX
	uEs3E37kxpFU+BK+Bdd7Z60UJ3+b803v/keZQtG/TEDsSmd94y3KwbAaldmtlgF1aqwgUB5S/wY
	q5B1LOzm7QLQNbt32RjxbOG7qtuk7MyzSXHlQXNshuG6/5/nsPeUalDdExLRRDPMi/QhwO9AsXR
	i1yDw5eIA64necQrrbUN3rrsCtFhNVhpgxJ8WDR+L1CIpID/cEfLfPGmRwDT61QBuWqLmqnuM=
X-Received: by 2002:a05:6000:310a:b0:45e:dd32:92fa with SMTP id ffacd0b85a97d-47fe81cb7ccmr577898f8f.12.1785776759310;
        Mon, 03 Aug 2026 10:05:59 -0700 (PDT)
Received: from metepc ([46.197.185.197])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fd456a6cbsm30855921f8f.23.2026.08.03.10.05.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 10:05:58 -0700 (PDT)
From: =?UTF-8?q?=C3=96mer=20Mete=20Kaya?= <omermetekaya0@gmail.com>
To: Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?=C3=96mer=20Mete=20Kaya?= <omermetekaya0@gmail.com>,
	syzbot+d3bc2f2eb498a0175940@syzkaller.appspotmail.com
Subject: [PATCH] xfrm: fix suspicious RCU usage in xfrm_nlmsg_multicast
Date: Mon,  3 Aug 2026 20:05:25 +0300
Message-ID: <20260803170525.1767734-1-omermetekaya0@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

xfrm_nlmsg_multicast() dereferences net->xfrm.nlsk via
rcu_dereference() and is documented as requiring the RCU read
lock, but 11 of its 12 call sites in this file do not hold it.

Move the RCU read-side critical section inside
xfrm_nlmsg_multicast() itself instead of adding it to each call
site individually. This is safe: xfrm_get_translator() takes its
own nested RCU read lock internally, and nlmsg_multicast() is
called with GFP_ATOMIC, whose only conditional yield() in
netlink_broadcast_filtered() is gated on blocking being allowed,
which GFP_ATOMIC never permits.

The redundant rcu_read_lock()/rcu_read_unlock() pair in
xfrm_notify_userpolicy(), the one caller that already took the
lock, is removed accordingly.

Reported-by: syzbot+d3bc2f2eb498a0175940@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=d3bc2f2eb498a0175940
Signed-off-by: Ömer Mete Kaya <omermetekaya0@gmail.com>
---
This patch intentionally centralizes the RCU read-side critical
section in xfrm_nlmsg_multicast() rather than adding
rcu_read_lock()/rcu_read_unlock() to each of the 11 affected call
sites, since every caller has the same requirement.

If keeping the locking at each call site better matches the
subsystem's conventions, I'm happy to rework the patch accordingly.

Reproduced and verified on a locally built upstream kernel
(v7.2.0-rc5) under QEMU/KVM, using the syzbot-provided .config and
C reproducer: the warning triggered on every run before this patch,
and did not trigger over 30+ runs after. xfrm_notify_userpolicy()
(exercised via "ip xfrm policy getdefault") was also verified to
still work correctly after removing its now-redundant RCU lock pair.

 net/xfrm/xfrm_user.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
index d6db63304..1f683516f 100644
--- a/net/xfrm/xfrm_user.c
+++ b/net/xfrm/xfrm_user.c
@@ -1622,31 +1622,35 @@ static struct sk_buff *xfrm_state_netlink(struct sk_buff *in_skb,
 }
 
 /* A wrapper for nlmsg_multicast() checking that nlsk is still available.
- * Must be called with RCU read lock.
+ * Takes the RCU read lock internally around the multicast.
  */
 static inline int xfrm_nlmsg_multicast(struct net *net, struct sk_buff *skb,
-				       u32 pid, unsigned int group)
+				      u32 pid, unsigned int group)
 {
-	struct sock *nlsk = rcu_dereference(net->xfrm.nlsk);
+	struct sock *nlsk;
 	struct xfrm_translator *xtr;
+	int err;
 
+	rcu_read_lock();
+	nlsk = rcu_dereference(net->xfrm.nlsk);
 	if (!nlsk) {
+		rcu_read_unlock();
 		kfree_skb(skb);
 		return -EPIPE;
 	}
-
 	xtr = xfrm_get_translator();
 	if (xtr) {
-		int err = xtr->alloc_compat(skb, nlmsg_hdr(skb));
-
+		err = xtr->alloc_compat(skb, nlmsg_hdr(skb));
 		xfrm_put_translator(xtr);
 		if (err) {
+			rcu_read_unlock();
 			kfree_skb(skb);
 			return err;
 		}
 	}
-
-	return nlmsg_multicast(nlsk, skb, pid, group, GFP_ATOMIC);
+	err = nlmsg_multicast(nlsk, skb, pid, group, GFP_ATOMIC);
+	rcu_read_unlock();
+	return err;
 }
 
 static inline unsigned int xfrm_spdinfo_msgsize(void)
@@ -2536,9 +2540,7 @@ static int xfrm_notify_userpolicy(struct net *net)
 
 	nlmsg_end(skb, nlh);
 
-	rcu_read_lock();
 	err = xfrm_nlmsg_multicast(net, skb, 0, XFRMNLGRP_POLICY);
-	rcu_read_unlock();
 
 	return err;
 }
-- 
2.55.0

