Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F42B302CC1
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 12:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790599193; cv=none; b=LixSzlBvTm/d+jZeSNi9HWnx0CTGSvrYNLnfZKN8XG9w733T9SUTIktiEsJBBedgtdgAJZ+LpcfGJkR63W/BAQ5ZY3ON3MEsnOqr1yIK6sX+U9E6V1jubgWq1Ea+MO+dT5MvlJHHnRX9GP1R1O00V7Z0Ta8hOeQkU8gkXHAoqUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790599193; c=relaxed/simple;
	bh=VMgY1P+jq0WbBXIlteABApp+SfiYvc8Sqm5dpy9M9Hs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u/Qf15FmpuPAtRwfH1QWUREArA6phsRzOrf8G1YVWWri09mutvbz5aaEsl1eJ5UpZ82SrJGe0zLeMIcenRdumMBhMrhvgxepbLGUEy+86vRaNsA6enlDQfk5Vh/v+MX+GNYPffkpEmLvb82E07qmMIv4Yy5GvFnkBhSUHwUMqds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3PcN467P; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vGL6W76o; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3PcN467P";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vGL6W76o"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1790599190;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LFlP7qcGF1jPukuNoCiG+brouPMOaIQQIzf+Iy2+3SY=;
	b=3PcN467Pi+JOLR+SElIgU895fJucwes/lXWiUS83vbI9wYJXSfnhhwxMU8/NcI7DqJmPM5
	EgBIKimuFFjEFBYrk6opyjJ75D/E7NYZtyBJ50Ia8bNSKkzxrNiAHSgGfsZh6BWar7r0x6
	X1CbNr/QBepp9UlCJoF42S/aHSwM5itJ5vS5fXQs8iRJjWYZA8fOtMzgMcKWroWreXkO+u
	jsKmnYi9Xe5wAAKoPYtXxqGGzezuebbxdRuuJoT8+HkACm2ipKdWfAQpacNPFr1vR+x7Sv
	HKoPBAWauQXfyce5655WbICnd26rVPlEbBo6AJmgGXBC7F34t83qHBl13F37Ag==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1790599190;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LFlP7qcGF1jPukuNoCiG+brouPMOaIQQIzf+Iy2+3SY=;
	b=vGL6W76o+Np+fvDrBGWCsu2HQ5u41OMMjM0jW2KVQr8Qo6JuIILcTy8l3pV5EVwNyv+tAV
	1QfngHTzWE7drlCg==
To: netdev@vger.kernel.org
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	"(JC), Jayachandran" <j-rameshbabu@ti.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Chintan Vankar <c-vankar@ti.com>,
	Danish Anwar <danishanwar@ti.com>,
	Daolin Qiu <d-qiu@ti.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Felix Maurer <fmaurer@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Neelima Muralidharan <neelima@ti.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Praneeth Bajjuri <praneeth@ti.com>,
	Pratheesh Gangadhar TK <pratheesh@ti.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Subject: [PATCH net-next v7 6/8] hsr: Assign a socket for cloned skbs
Date: Mon, 28 Sep 2026 14:39:40 +0200
Message-ID: <20260928-hsr_ptp-v7-6-d55d304d9a7e@linutronix.de>
In-Reply-To: <20260928-hsr_ptp-v7-0-d55d304d9a7e@linutronix.de>
References: <20260928-hsr_ptp-v7-0-d55d304d9a7e@linutronix.de>
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

Assign the socket of the original skb to the clone so the timestamp is
forwarded to the user.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 net/hsr/hsr_forward.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/hsr/hsr_forward.c b/net/hsr/hsr_forward.c
index 2ce31b1da7b35..eb696e33bd739 100644
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
@@ -348,6 +349,9 @@ struct sk_buff *hsr_create_tagged_frame(struct hsr_fram=
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
 		if (frame->has_foreign_header && frame->skb_std) {
 			skb =3D skb_clone(frame->skb_std, GFP_ATOMIC);
+			if (skb && frame->skb_std->sk)
+				skb_set_owner_w(skb, frame->skb_std->sk);
 			goto inject_into_stack;
 		}
=20

--=20
2.55.0

