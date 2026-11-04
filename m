Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793805056;
	b=DYann0pOsn26etIKmHR66+pXpahNov0fCMriUxDV8n39RDKC+ABmOqkrqKVFYm7CsQOA
	 Hj3CM8iZxfSrThtPjMITCL353H9RsGRxQyOlOjy0cL3YPXOBhj2kpd7/KSBpQ4682A8nJ
	 q/Xv3m8HKSWym9ZGCf4k8pspyFBdoJai0S5bBeYkNeoqem726AOX0mjcnod9Takdk4wwf
	 10fc11PY7xtMfD0IxxxnfRaPLU2WdQhA9MJ9iY3y1yt1tU+jWl4sIFPbl6B5bGMJiyqgS
	 SUQAWT59H+BUQBT5Bq7RWqZ3YRP1OXrlF+lR8rJ2GiO+TIpef7eSQqQ8zDyB63BSaeg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793805056;
	h=DMARC-Filter:From:DKIM-Signature:DKIM-Signature:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=GF6d3pNDOSjz5HIuFJrfOK9I1WV91tbPmxomODct6jo=;
	b=Z11cs/EDmmLp5GGZlth3AgSjnsctBASkn4XcFhqPUrL1HeyQweCytzF1fmtYK9XJcdAt
	 69jHEqwwOB8kK6kA8aRlyyZiNz1nb/EhR4dszEcelb9QrnizFtZFI9dFFHnC7sHogVTOE
	 FYBqSp95U3f1W0ec8CSQZAhzcFhzrqqhrbyEzK+l/Zz6rSwiMsCQEt/vRHFjryLpM+0Jc
	 03ZrutLzUGU6Kp+kMncLvolwsLcB0XZr3l7MRyQiRvJigDMHJMDJnIq1xADL53VcI+RSh
	 hqi9SjjQ3PZvkULVbXwxu+d4FocKm9K+9uFUD6JM/01JnyTP8+FyYHiYplZkYsEOtOA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=LqYmIVPT;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=5K0wE7q1;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1A2D606D80A
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 15:10:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F1A2D606D80A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=LqYmIVPT;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=5K0wE7q1
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1793805054;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GF6d3pNDOSjz5HIuFJrfOK9I1WV91tbPmxomODct6jo=;
	b=LqYmIVPTsuVUEeAZ+SeSjpN5huc8rBHbyOHaXtRmBVq6V+R9jDk+WtwMUCln9B9GS63CdV
	+6/0S9k0x8JIvHKlRlIVXjoQU4T++GNz8/o0beOUsGNt5rtABBe1mS8Zv3DjnWLf5i++P1
	2YgFMUgHk/nLm1Z5Ybn4e2f/h2DHKkp0B1ynYnQAaQwQIEJlAZZ/vtDWyceLe6GGuVOMkN
	4+jH6Le3SKhEqYPjI9bbczz3gQkh42iw4eQHOzmw5A5JrggCqR9DxOHyVawdC/xse/biBb
	EDeNzBJy8BeU3AjKFhTqXX2ybcGJjiqiK3Qw+93W91Q7XQ8WJNTY1HLQQtiAtg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1793805054;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GF6d3pNDOSjz5HIuFJrfOK9I1WV91tbPmxomODct6jo=;
	b=5K0wE7q1M7VVGiUyEu+fgkQTw1hsF5FzknQ4Mae4MawWSmzX49B4pAdpWNgbchX/Q9Jvee
	DlRBt3ShV3L2poDg==
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
Subject: [PATCH net-next v10 6/8] hsr: Assign a socket for cloned skbs
Date: Wed,  4 Nov 2026 16:10:42 +0100
Message-ID: <20261104-hsr_ptp-v10-6-2c4a38ad973c@linutronix.de>
In-Reply-To: <20261104-hsr_ptp-v10-0-2c4a38ad973c@linutronix.de>
References: <20261104-hsr_ptp-v10-0-2c4a38ad973c@linutronix.de>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The cloned skb does not have the socket recorded of the original skb
because skb_clone() clears sk_buff::sk. The original skb is never
submitted but freed in hsr_forward_skb(). skb_tstamp_tx() will only
submit timestamp information to the sender if the socket is recorded and
the TS flags are available.

As of the recent changes everything is available except the socket and
the requested timestamp gets lost.

This does not consider PRP part of the stack. The specification says
that PTP-PRP packets do not have the RCT therefore these packets can be
sent directly from userland skipping the stack.

Assign the socket of the original skb to the clone so the timestamp is
forwarded to the user.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 net/hsr/hsr_forward.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/hsr/hsr_forward.c b/net/hsr/hsr_forward.c
index d2a11d4560309..85c8dd61ee6f8 100644
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
@@ -581,6 +585,8 @@ static void hsr_forward_do(struct hsr_frame_info *frame)
 		 */
 		if (frame->has_hsr_header && frame->skb_std) {
 			skb =3D skb_clone(frame->skb_std, GFP_ATOMIC);
+			if (skb && frame->skb_std->sk)
+				skb_set_owner_w(skb, frame->skb_std->sk);
 			goto inject_into_stack;
 		}
=20

--=20
2.55.0

