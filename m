Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1985A330B3F
	for <netdev@vger.kernel.org>; Sun, 23 Aug 2026 18:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787509365; cv=none; b=lQ1MDUAHEgNUZtlQqe2QhQYF49tbkobslTTjozBWQwTWwbeNAR3YBBQyXgZyvJ6LVrcfxQWMwjdbU5XjaPQ7CZz2jVd7z+4MuPUDyGMRmn6Fa55NAt3K/EBYI8BZwm3yl6nYvVNTZLkAPWhNKsKLz7aROdKHqjehOWzU/aHTpGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787509365; c=relaxed/simple;
	bh=r0b2BPGD11jtjC1KV+0PJvg/C/dyiWJBTNgSgtvKtYU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=jMpp+2QCi8BKZv25ImtKtQugdpfnkIUjAdW1g/ZVRYFYBWoSxMAUsoXDt+zc2HBz+DNJNja9vIB+QphydyC5A4eiEI0IC196Wiufmmc/SRXKU5e7q7cA3djSAlpnvvmabJN8z2jKetQljkOwoMcIC3RoaJtyMQtKOnmlJccrxqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Al7VSqBm; arc=none smtp.client-ip=209.85.160.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Al7VSqBm"
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-52dcf1bb6e9so36272221cf.1
        for <netdev@vger.kernel.org>; Sun, 23 Aug 2026 11:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787509363; x=1788114163; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=gcpTil0oaf2Dq1YaTgXsJ83bVsB9+Gwo6tAFSTilNno=;
        b=Al7VSqBmILcmjZNckeQtJkC05DclQodu10Bii4toP5AI9RcvuSEyRiFfJze74WfKoK
         /vb54bUvEmzjJmovmr+pSp4eq3Fk5Fil5zyG/qsDyT8xkClmH83lo0qWz59sfto9z3Er
         JOHmwaWwwACTG2vaHjqfPNbCG9xYzBG+U3zvqMqvWzLlrGGn1w6xI229zUyvMjl6vJjZ
         qBkKA7kNpYESV2EY8i5uS1B/zwAL7l7kPyGsFHqpgAZuQnphiFamEfChoA+9GZDY+Mdb
         HcvBlqr+P+Y8BFHzNnaJfr0A6lYs2XfqImzOGcP0PrUjkA6dAc+oIV54f8Zn0MitrBfA
         QZ/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787509363; x=1788114163;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gcpTil0oaf2Dq1YaTgXsJ83bVsB9+Gwo6tAFSTilNno=;
        b=c7nuChOv7w2/wYQzp8/Sih5WeoXQEQ+cgsXDcFDEXPaAWHulLXGMqDcwhn8Cm/+YQB
         FGuvNb6V1he+cWn8oR8+ejhNz5/o8WwxsTUsqtv5LAwL2YJNB5iklTeglFe9KGFP8EM5
         XwxwmhM/NpHZXShQc8VEKYWar/bsQD1Ffbj2FXM9Oq6wfEtUzVhKAYJXhwYg4jhBI6cq
         5WBi9Ke0sBH0uymKrX39l7MbMGkYo0vnmKF4vdp8eyUermkuI5AzupHdrJtt8GGEHM4H
         QbeyqE3GurNL4dhcghFU20qZKOueBXYsPSO4Z6GyDhDfytO1GH5DzLtlUKZ+jRRnrrCK
         8ixQ==
X-Forwarded-Encrypted: i=1; AHgh+RpUKk6/wBKu5GCYLRDu3+0TScAj0JKq948nTf719jii9Ggsq8yEY3HJObUtSvO0BVLfvis+bhM=@vger.kernel.org
X-Gm-Message-State: AFuF++n2OVJkay1Eu5lbe4EUE05EzW20N5Aalju/krB+BKxzLaXpoHtw
	BYv72nEqeWj4nlOZWt/oTRpausG5WuTzG2pWB/nCCKHiwhl4e/8lzpKJGuIqWdQMW76TYnFHynJ
	9lCFB1Ns2K4yXOg==
X-Received: from qtblb17.prod.google.com ([2002:a05:622a:a211:b0:51c:ab6c:1907])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:305:b0:51c:ca9:7cdf with SMTP id d75a77b69052e-52df6389d06mr197212221cf.2.1787509362725;
 Sun, 23 Aug 2026 11:22:42 -0700 (PDT)
Date: Sun, 23 Aug 2026 18:22:41 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.766.g2966f0265a-goog
Message-ID: <20260823182241.1958695-1-edumazet@google.com>
Subject: [PATCH net] net/sched: act_skbmod: fix length calculations and avoid
 invalid header warnings
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Victor Nogueira <victor@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>, 
	syzbot+1d56f14f95c0480cfdc9@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"

syzbot reported a warning in skb_network_header_len() triggered
by tcf_skbmod_act():

  !skb_transport_header_was_set(skb)
  WARNING: CPU: 0 PID: 14949 at include/linux/skbuff.h:3243 skb_network_header_len include/linux/skbuff.h:3243 [inline]
  WARNING: CPU: 0 PID: 14949 at net/sched/act_skbmod.c:55 tcf_skbmod_act+0xfe8/0x1810 net/sched/act_skbmod.c:55

There are a few issues in tcf_skbmod_act():

1. Calling skb_network_header_len() assumes skb->transport_header is set,
   which is not guaranteed when tcf_skbmod_act() runs at TC ingress.
2. Unconditionally calling skb_mac_header_len() at the beginning of
   tcf_skbmod_act() triggers a warning on L3 devices (e.g. TUN) where the
   MAC header is unset, evaluating to an underflowed garbage length.
3. On TC ingress, skb->data points to the network header. Adding the MAC
   header length to the IP header length causes skb_ensure_writable() to
   request more bytes than the actual IP packet length, dropping valid
   short packets (e.g. 28-byte UDP/IPv4 packets).

Fix these by:
- Using skb_network_offset(skb) + sizeof(struct iphdr/ipv6hdr) for
  SKBMOD_F_ECN so that the required length is correctly calculated on
  both ingress (offset == 0) and egress (offset == mac_len).
- Setting max_edit_len to ETH_HLEN for Ethernet header modifications
  after validating ARPHRD_ETHER.

Fixes: 56af5e749f20 ("net/sched: act_skbmod: Add SKBMOD_F_ECN option support")
Reported-by: syzbot+1d56f14f95c0480cfdc9@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/netdev/6a8b39c0.dbb3a75c.13dd47.0051.GAE@google.com/T/#u
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/sched/act_skbmod.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/net/sched/act_skbmod.c b/net/sched/act_skbmod.c
index a464b0a3c1b81dba6c28c1141aa38c5c7cad3acb..7579cf1e0ff37c1314d112a6aaeed0a965280834 100644
--- a/net/sched/act_skbmod.c
+++ b/net/sched/act_skbmod.c
@@ -38,7 +38,6 @@ TC_INDIRECT_SCOPE int tcf_skbmod_act(struct sk_buff *skb,
 	if (unlikely(p->action == TC_ACT_SHOT))
 		goto drop;
 
-	max_edit_len = skb_mac_header_len(skb);
 	flags = p->flags;
 
 	/* tcf_skbmod_init() guarantees "flags" to be one of the following:
@@ -51,14 +50,19 @@ TC_INDIRECT_SCOPE int tcf_skbmod_act(struct sk_buff *skb,
 	if (flags == SKBMOD_F_ECN) {
 		switch (skb_protocol(skb, true)) {
 		case cpu_to_be16(ETH_P_IP):
+			max_edit_len = sizeof(struct iphdr);
+			break;
 		case cpu_to_be16(ETH_P_IPV6):
-			max_edit_len += skb_network_header_len(skb);
+			max_edit_len = sizeof(struct ipv6hdr);
 			break;
 		default:
 			goto out;
 		}
-	} else if (!skb->dev || skb->dev->type != ARPHRD_ETHER) {
-		goto out;
+		max_edit_len += skb_network_offset(skb);
+	} else {
+		if (!skb->dev || skb->dev->type != ARPHRD_ETHER)
+			goto out;
+		max_edit_len = ETH_HLEN;
 	}
 
 	err = skb_ensure_writable(skb, max_edit_len);
-- 
2.55.0.766.g2966f0265a-goog

