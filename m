Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4C7A54A7D8
	for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 14:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791989060; cv=none; b=hPKnmitRNt/pqX/5usYAoUkWclCVQYCe3eU4P7pQMInafW5DV8bj7H5diq00dB888UnvsjCDhdcQVIxHMS7LErpCUUM+XWoobsaqA5KO1bnijeQXBgKaSdQdzOl8Qe77WNfV25P88d5+o3EeWFrxIh0Gmgvxci6dyujpO6B12AU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791989060; c=relaxed/simple;
	bh=mtEx4YAoqGDJGVw9dbkigW2WrkbZLj7Aam0LbmQx8Cs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ullYh2B0ajcOah6C0nyGtNA5q2hbbB6Mrr1BSnDYocJs0numljuvbshodIcGL5M0+ZyR7yRHpdj8E7zd20RW4BI7se4BbBuHeWMcGcXzNTWwp1Ot24xS61ztnnxUyQI+d41SSZ39xnEBh6ZMKfvMu6Qb1jwYCb/ksYABpUaajDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RY6oth6A; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=35yv5MQ+; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RY6oth6A";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="35yv5MQ+"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1791989049;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/2OEkdoYAf2F1AJEnJbu54pUpn3/iMbKh4oqbsDrpmU=;
	b=RY6oth6Atbu0jlVMjCvCoV8vHDWT9xThBQICowHaQA1g1EGVhLTT/jA0F5VVYJbtk+/p41
	Tglu+Hqz+0vZKVr6BrqZC7xZQggnV+NGCUqeuVlN7z2p5S9lkNtLO1kEHmHocB+pVVeiKY
	8vEdE+4nc8sM/6JexRQsz1G/ot/Qkf4HS9haZpElUtuWaxp3f9oJPMRJKUq84LufBZCDYA
	2RoLEjd0qRevwCI/odvSeFlYrz7pW/toloGaMpjgDFFVwzjvNLQHA9duZ1vdM9Q/UgQ14B
	NnoqH6w8vreO8luhW50gwGkqk7kJ3K4H9qeY3RG1RJxKb6OjLG5K09/5HkVVsg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1791989049;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/2OEkdoYAf2F1AJEnJbu54pUpn3/iMbKh4oqbsDrpmU=;
	b=35yv5MQ+fb4o2kjU/VeZYKAQMIHvZ4L6XMiseQhvY1onCjFT7fnnwdzTVlDieuld+zO0Hi
	aO8pzrh09XFmpWCQ==
To: netdev@vger.kernel.org
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	"(JC), Jayachandran" <j-rameshbabu@ti.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Chintan Vankar <c-vankar@ti.com>,
	Danish Anwar <danishanwar@ti.com>,
	Daolin Qiu <d-qiu@ti.com>,
	"David S. Miller" <davem@davemloft.net>,
	Felix Maurer <fmaurer@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Neelima Muralidharan <neelima@ti.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Praneeth Bajjuri <praneeth@ti.com>,
	Pratheesh Gangadhar TK <pratheesh@ti.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Daniel Machon <daniel.machon@microchip.com>,
	Eric Dumazet <edumazet@kernel.org>
Subject: [PATCH net-next v9 6/8] hsr: Assign a socket for cloned skbs
Date: Wed, 14 Oct 2026 16:44:00 +0200
Message-ID: <20261014-hsr_ptp-v9-6-2d20a2a0f816@linutronix.de>
In-Reply-To: <20261014-hsr_ptp-v9-0-2d20a2a0f816@linutronix.de>
References: <20261014-hsr_ptp-v9-0-2d20a2a0f816@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The cloned skb does not have a socket information recorded of
the original skb. The original skb is never submitted. This means the
requested timestamp information gets lost.

This does not consider PRP part of the stack. The specification says
that PTP-PRP packets do not have the RCT therefore these packages can be
sent directly from userland skipping the stack.

Assign the socket of the original skb to the clone so the timestamp is
forwarded to the user.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 net/hsr/hsr_forward.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/hsr/hsr_forward.c b/net/hsr/hsr_forward.c
index 534798da48d53..e3a7affd947a1 100644
--- a/net/hsr/hsr_forward.c
+++ b/net/hsr/hsr_forward.c
@@ -12,6 +12,7 @@
 #include <linux/skbuff.h>
 #include <linux/etherdevice.h>
 #include <linux/if_vlan.h>
+#include <net/sock.h>
 #include "hsr_main.h"
 #include "hsr_framereg.h"
=20
@@ -347,6 +348,9 @@ struct sk_buff *hsr_create_tagged_frame(struct hsr_fram=
e_info *frame,
 	if (!skb)
 		return NULL;
=20
+	if (frame->req_tx_port !=3D HSR_PT_NONE && frame->skb_std->sk)
+		skb_set_owner_w(skb, frame->skb_std->sk);
+
 	if (port->dev->features & NETIF_F_HW_HSR_TAG_INS)
 		return skb;
=20
@@ -579,6 +583,8 @@ static void hsr_forward_do(struct hsr_frame_info *frame)
 		 */
 		if (frame->has_foreign_header && frame->skb_std) {
 			skb =3D skb_clone(frame->skb_std, GFP_ATOMIC);
+			if (skb && frame->skb_std->sk)
+				skb_set_owner_w(skb, frame->skb_std->sk);
 			goto inject_into_stack;
 		}
=20

--=20
2.55.0

