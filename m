Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2BC836194A
	for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 19:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786478048; cv=none; b=U/lweVGWLrjsrBN/MBljNfBcBqpAq+7bIthPL6toRDWyWMIo5sIeleslH9Do0Me5uAbJUVNSgqINjp2puta3qMDZUwlut6UB4fjEkfrAdW0E/1RFW3J8+ZgqJf0RNgCTJk+5dDuYXdmSoKSsGV9oBRe4x35dcvyfMQ1lmPAb1f8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786478048; c=relaxed/simple;
	bh=uv5bJTiywtvIjoIAxnUMtZ+nXypc0LrMQnCrdgTaIFU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Pxc5EIKqpAU0dGZ5dimxee1C+PjRqXhKot4sYlTdslglIdCWVjE5TVWVYlsvyYXh1giCydNY9Za61GoRF4m2faTs9WgAdC10WPSnE1x209/Wys455xsKUbRmbcfmd2xOiTPo9rjpW6A1kHUUNPFAieNS9T5VsxX8UEEakCjKzpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YVVdd7kr; arc=none smtp.client-ip=209.85.215.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YVVdd7kr"
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cbedf42f199so161553a12.2
        for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 12:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786478046; x=1787082846; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=JgAFNW26nQ+7bGg4Sj1IWeLiDHNMoP2ck4YKWQasXjk=;
        b=YVVdd7krUV5hhI0dcvHJdVWj5mJoTp9ZKnE9cat0P2iYdXKLhEsGe7SvL1LEJW7xBV
         e/l66YpZGDBp7dQYRX1QDB7EUBpVZn7SoTOkQeG0oQzpGF5A2HkJm7sV3O84REuPW/dv
         Gj54zqvvOMx0cTudsKIMtKA5HgDpBHL9Pk4ctvg2THPeREPducxZX16bEEISITabqR9v
         52CNQHUqenQEmoZXjIsBUww83Km1cpsNhwfuoGljUZ+m8bJ11SCT8VA5guoXddMYya7H
         kU9yH+vpcFF1/zPaGXzvEPU68KXIzO1pmTPDGSIdsnzWj8qcr7rMCmtdoW7oCZRbHpTH
         Jsrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786478046; x=1787082846;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JgAFNW26nQ+7bGg4Sj1IWeLiDHNMoP2ck4YKWQasXjk=;
        b=ZxXE+eu2boTd7GHBafVzcJWaH2HJZzin4xBOmCelpAS21imnynpXw7kJi5sSWm25Uv
         BulHw7bQw1Jkcd+bZr+eoVQkkYiHjuu2KAY4RToD4p83brS3Ja1DAZ7mFXq7iOi5s5Uh
         PNwtzvFrRtSxEsVSSdzQ7oYZcrhOBDr402TWkbJJP9SkJtDBIdeVTLXbzDwpXCSHCjv+
         y3qIPmz9TGA9QTjqTTju32Ga8bSbum5ISDO4CCVuTVob37ZMSb4QyF4jLt4CpwDZOK6L
         bgtRasUXKm+ioJxprQwc6RNEoub0CajQ9PV/aIf9Cwon4oubX+fEp4ZT59sLvGxiFQeX
         RKIA==
X-Forwarded-Encrypted: i=1; AHgh+RoOuY70CDu1gbGbr8JJ7rgST+oplKvWKIzrUQtXHlChsYGUPNl0PUWqKJ2NGid7lQ3QR/A2JXg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0SeMwkdzHAgnWA4yfI/5Lnu2mHJPm/hdRYVmdDxKuT4C/jrvM
	E84O0ns4bFZgq7xmW4VHPp4Wdbi0/UuSMOpMqBrqHa8XC6U3i8dtdvbhUjeVeViaqx2exK6QzNq
	nojS3AVeHRf/oy0ljpSlnUYx0LA==
X-Received: from dybpd4.prod.google.com ([2002:a05:7301:4544:b0:30f:3dee:fdfe])
 (user=almasrymina job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:be8f:b0:3c4:3321:4fe8 with SMTP id adf61e73a8af0-3cc2b87d093mr8282193637.14.1786478046006;
 Tue, 11 Aug 2026 12:54:06 -0700 (PDT)
Date: Tue, 11 Aug 2026 19:53:38 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.679.g6767b8d81c-goog
Message-ID: <20260811195405.3979177-1-almasrymina@google.com>
Subject: [PATCH net v3 1/2] net: core: propagate unreadable flag in skb_zerocopy
From: Mina Almasry <almasrymina@google.com>
To: Jakub Kicinski <kuba@kernel.org>, Willem de Bruijn <willemb@google.com>, 
	Eric Dumazet <edumazet@google.com>, Mina Almasry <almasrymina@google.com>, 
	Kaiyuan Zhang <kaiyuanz@google.com>, Stanislav Fomichev <sdf@fomichev.me>, Paolo Abeni <pabeni@redhat.com>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, dev@openvswitch.org
Cc: "David S. Miller" <davem@davemloft.net>, Simon Horman <horms@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Aaron Conole <aconole@redhat.com>, Eelco Chaudron <echaudro@redhat.com>, 
	Ilya Maximets <i.maximets@ovn.org>, Jason Xing <kerneljasonxing@gmail.com>, 
	Pavel Begunkov <asml.silence@gmail.com>, Bobby Eshleman <bobbyeshleman@gmail.com>, 
	Florian Westphal <fw@strlen.de>
Content-Type: text/plain; charset="UTF-8"

skb_zerocopy() fails to propagate the unreadable flag when copying
devmem fragments, causing target skbs to appear as readable memory.

This patch fixes the flag propagation. Additionally, it returns -EFAULT
if standard payload is mixed with unreadable devmem fragments during
extraction, and returns -EFAULT in openvswitch
queue_userspace_packet().

Fixes: 65249feb6b3d ("net: add support for skbs with unreadable frags")
Cc: Pavel Begunkov <asml.silence@gmail.com>
Cc: Stanislav Fomichev <sdf@fomichev.me>
Cc: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: Florian Westphal <fw@strlen.de>
Cc: Aaron Conole <aconole@redhat.com>
Cc: Eelco Chaudron <echaudro@redhat.com>
Cc: Ilya Maximets <i.maximets@ovn.org>
Cc: Willem de Bruijn <willemb@google.com>
Reviewed-by: Pavel Begunkov <asml.silence@gmail.com>
Signed-off-by: Mina Almasry <almasrymina@google.com>
---
 net/core/skbuff.c          | 13 ++++++++++++-
 net/openvswitch/datapath.c |  3 +++
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index ba3dbac80fb49..d21af68156950 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -3870,7 +3870,8 @@ EXPORT_SYMBOL_GPL(skb_zerocopy_headlen);
  *	Return value:
  *	0: everything is OK
  *	-ENOMEM: couldn't orphan frags of @from due to lack of memory
- *	-EFAULT: skb_copy_bits() found some problem with skb geometry
+ *	-EFAULT: skb_copy_bits() found some problem with skb geometry, or readable head
+ *      payload would be mixed with unreadable frags.
  */
 int
 skb_zerocopy(struct sk_buff *to, struct sk_buff *from, int len, int hlen)
@@ -3905,10 +3906,17 @@ skb_zerocopy(struct sk_buff *to, struct sk_buff *from, int len, int hlen)
 		}
 	}
 
+	if (!skb_frags_readable(from) && j > 0 && len) {
+		put_page(virt_to_head_page(from->head));
+		return -EFAULT;
+	}
+
 	skb_len_add(to, len + plen);
 
 	if (unlikely(skb_orphan_frags(from, GFP_ATOMIC))) {
 		skb_tx_error(from);
+		if (j > 0)
+			put_page(virt_to_head_page(from->head));
 		return -ENOMEM;
 	}
 	skb_zerocopy_clone(to, from, GFP_ATOMIC);
@@ -3928,6 +3936,9 @@ skb_zerocopy(struct sk_buff *to, struct sk_buff *from, int len, int hlen)
 	}
 	skb_shinfo(to)->nr_frags = j;
 
+	if (i > 0 && from->unreadable)
+		to->unreadable = 1;
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(skb_zerocopy);
diff --git a/net/openvswitch/datapath.c b/net/openvswitch/datapath.c
index ae69b2cabab9e..482893a5f67dc 100644
--- a/net/openvswitch/datapath.c
+++ b/net/openvswitch/datapath.c
@@ -467,6 +467,9 @@ static int queue_userspace_packet(struct datapath *dp, struct sk_buff *skb,
 	if (!dp_ifindex)
 		return -ENODEV;
 
+	if (!skb_frags_readable(skb))
+		return -EFAULT;
+
 	if (skb_vlan_tag_present(skb)) {
 		nskb = skb_clone(skb, GFP_ATOMIC);
 		if (!nskb)

base-commit: cba9ccb47e9fa4cc77692fb896cc5ab57a667882
-- 
2.55.0.679.g6767b8d81c-goog

