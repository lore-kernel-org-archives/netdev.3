Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794012585;
	b=jSEVUJNbcHYYHuXFsYGfQYX6rljKJW9u1ZWShW/oIGu4tK8ZE6sn79T8JBBQmQ1lxDy8
	 +mmfs+gMx95C7/8AgYU2a6HXXGWMCnm3XecJWknUT2HqnjUjiDdnLvrlYZSuEFOzcyVND
	 9F272I8Gt71IIOkU8C6erVSr2TlzVDj1grsX5G8EYhcQ0QTNSEqnHm7S9B6SQ07ckjwjg
	 XW+68jFhUH2Xpp30qAjQn5qzzpY3QSffzi+WFkwf7k+jVFlBBTfRTsNjBAa86bY3DV56a
	 F/VF6wY8hHAyA2a8kR4KLYGm5Rg9fZmi0O24Bq7zS7/Zv32znMnuIyD75gxYdjwSTOw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794012585;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=AU8Sh3UWwtf5Levg8kTCXNKh0yXFjsBlmyC03UOP2A0=;
	b=QapmuQOtmVTgjB+OIQndNmblWJ2J/4LC0LtHG4ipw1+HWhr+q3dED/4jwCquw4uLbyYC
	 mA7kkcUVYL5NOI+PMr1Gh7AimXgBB78HmwnIyGn1vRsoFNzfKd4LmXO4nEGtaPSRjW/14
	 uU31K1Sh0DnoRDlHV4M4r0/76VG729EoPT9cwSuqTJyKhprLVf5akCquL1AGGL+cR1GZ8
	 zT1geV3/xJuLjLPdLQzBhfpDjNZqZS/Oz3HyHtc0R3kgBV8o5paBIk9OTC0iL/i6LPh46
	 wVKH8quU76Smcte5hu3DbKE0tTtnsutWwQgSPz7sR8s/URq6OqD8JsPZLup/+ieNiHQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=blockcast.net;
	spf=pass smtp.mailfrom=blockcast.net;
	dkim=pass header.d=blockcast.net header.i=@blockcast.net header.a=rsa-sha256 header.s=google header.b=HC2AXskH;
	arc=none smtp.remote-ip=74.125.82.175
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BA036070BA6
	for <netdev@vger.kernel.org>; Sat,  7 Nov 2026 00:49:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7BA036070BA6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=blockcast.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=blockcast.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=blockcast.net header.i=@blockcast.net header.a=rsa-sha256 header.s=google header.b=HC2AXskH
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-3645f0f3fcdso1981425eec.0
        for <netdev@vger.kernel.org>; Fri, 06 Nov 2026 16:49:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blockcast.net; s=google; t=1794012585; x=1794617385; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AU8Sh3UWwtf5Levg8kTCXNKh0yXFjsBlmyC03UOP2A0=;
        b=HC2AXskHrEb9BhDcUHs1I7/T5DkoUZH7cBrg2/auih3ArgAjqL8gETA2iAJ0TWyGE9
         ZXCqsnWqW0gzun98sn8nAKzK059gD2A0N4Anzn3F+Syt44ZJ1esJaI2MM9N7DhiACpQY
         gjI975cZ5ka46TFyxRD4mV1uy/5dIkEHRbGM3CPNjW/yrCMhmzR6R9EapHzT9qvbsEF1
         O3kOpLoaciq9qI1sSBMFaqvxyDoYtKsWnH18bTmNZbBGyr9LNjfR/ZvjyrV8oDwlaTWz
         t1a7Jyks83T0WsQrNxCO/OjuHEDWt91XmMfDGLGBgMqENx+SYVD3XEE2N26eks68wqjQ
         E/zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794012585; x=1794617385;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=AU8Sh3UWwtf5Levg8kTCXNKh0yXFjsBlmyC03UOP2A0=;
        b=V+79uyCtedNoysi31TBRgQVZDCh2TaBo/7PbEnFg9hY9eMycGdzX6uKmYSQvt3g4Xd
         jtezGqTYNnX89QrQZWVC+hAWhQ2nEYx24rsqhxTuStDn2nrFAa4gI/jUhJrqG+IFbIBq
         QR1w1vJlcrFE2JPazVxy6jtfk/9UzMEy8vM+PX2I7GKzY5vCIIkD9l9i4jknrEfA//mY
         AqtNP+LTvjOw62j3mILq4Xe8eesJPtiJCUG0iqBzGtJYrOuIujgBJSkojdbndGN4Xtzv
         E1NwDPHzseRByxtUlBGFxzjck10wc49ubuuP9B/TxovdW+Xqrah9rc/h4E7IS93oRtDn
         z7bw==
X-Gm-Message-State: APuU4Z9l/TfHyzJHrmIqElbHymq8KUZOOTPHM3HfIA4e327hWUTeJflL
	5lp5c5M2NXiyDwWC5vL3t8zExXxVN/5obWFyqWIH68kQKGmiDwkFzji4Q7MFNoy6rPI=
X-Gm-Gg: AYBFou0NTEpsOYC6frPbwPSD9vTKQ80b7vcEuw+2sjXDfARIcNeQdCy+6Pt8JcBKLx8
	OaNjyf8KPtGJ+VofrwR/zEUAbV+FT3Cm3C0oU643hlLfopLx/if870i1MvGJSoTLuXXdBjjWNU7
	T0y+Oht+awtcuq3u9SLS4XLhPupp6iz3FuUXkH6i7WXgLvSvgVNXOxai3igsLOzX5SU8SaWdhWC
	Vk1K/rnTv9abC8NjBPu8KR0Gag+/IziginRByRdc/hsm5a/Ihxh9yZuw9BtucSiRq4IRvfAuthQ
	wZLXthudOk7BpF3XWdPKlqSsPHgW745VO56Qi/hznrMDJFiLde8P07NHD1kEv+qAkZRtMukwoEe
	pDxVjmOYktRgiP7ejNrwh4QpDgsedCyzCcNTGud8XTxpDKZFNYxTwaimI8jp/VuOEIZTO+bRvC9
	BGT6slMEUYI/HuKd4s2E4Gg7eNJDTjvXgGHuXrlHEW2zQKEv3ba94XAKsH8+MJzGv+SClG92jXe
	wtsqjSKsU9mEj0B9E+hMZkrz24TyzmvC4GezBUdbZ0jJcRmDLy8iUCoXabIDWQ1vd3as1YXlfSZ
	IVhlMsnK3oICccy9yIQBlxlfWS+CePlvtVWImWt56I2oL3OjZPWJFghzVEmruhAdEZ8W6d8=
X-Received: by 2002:a05:7300:50d9:b0:36f:350b:3838 with SMTP id 5a478bee46e88-36f76814c19mr5876815eec.31.1794012584361;
        Fri, 06 Nov 2026 16:49:44 -0800 (PST)
Received: from devbox.ts.blockcast.net ([2602:f74d:1::32])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36fa8e3a718sm11021294eec.4.2026.11.06.16.49.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 16:49:43 -0800 (PST)
From: Omar Ramadan <omar@blockcast.net>
To: Taehee Yoo <ap420073@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Simon Horman <horms@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-rt-devel@lists.linux.dev
Subject: [PATCH net v6 3/6] amt: reject a gateway Query or Data from 0.0.0.0 before a relay is learned
Date: Sat,  7 Nov 2026 00:49:32 +0000
Message-ID: <20261107004935.2627329-4-omar@blockcast.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261107004935.2627329-1-omar@blockcast.net>
References: <20261107004935.2627329-1-omar@blockcast.net>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A gateway's amt_rcv() admits a Membership Query or Multicast Data
message when "saddr != remote_ip" is false. remote_ip is 0 before
discovery has learned a relay (and is reset to 0 by amt_dev_open(), by
amt_dev_stop(), and when the gateway gives up after its Requests go
unanswered), so a packet whose source is 0.0.0.0 would otherwise pass
the equality check and could spoof a Query or inject multicast data.
IPv4 input accepts a 0.0.0.0 source only on a limited broadcast, so the
sender has to be on the gateway's link.

Reject both when no relay is learned: a 0 remote_ip must match nothing, so
guard the check with !remote_ip. A Query is queued before its event worker
processes it, so the relay address can also change in that window. Recheck
the packet source against the current remote_ip in the handler and discard
stale Queries. Discovery is unaffected because Relay Advertisements are
validated against discovery_ip, not remote_ip.

Found by code inspection while writing the IPv6 receive path for the
AMT IPv6 outer transport; not triggered at runtime.

Fixes: b9022b53adad ("amt: add control plane of amt interface")
Assisted-by: LLM
Signed-off-by: Omar Ramadan <omar@blockcast.net>
---
 drivers/net/amt.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/amt.c b/drivers/net/amt.c
index e4b8c02a0..c714994ef 100644
--- a/drivers/net/amt.c
+++ b/drivers/net/amt.c
@@ -2499,6 +2499,10 @@ static bool amt_membership_query_handler(struct amt_dev *amt,
 	if (amtmq->reserved || amtmq->version)
 		return true;
 
+	/* A deferred query may outlive a relay address change. */
+	if (ip_hdr(skb)->saddr != READ_ONCE(amt->remote_ip))
+		return true;
+
 	if (amtmq->nonce != amt->nonce)
 		return true;
 
@@ -2977,7 +2981,7 @@ static int amt_rcv(struct sock *sk, struct sk_buff *skb)
 			}
 			goto out;
 		case AMT_MSG_MULTICAST_DATA:
-			if (saddr != remote_ip) {
+			if (!remote_ip || saddr != remote_ip) {
 				netdev_dbg(amt->dev, "Invalid Relay IP\n");
 				err = true;
 				goto drop;
@@ -2988,7 +2992,7 @@ static int amt_rcv(struct sock *sk, struct sk_buff *skb)
 			else
 				goto out;
 		case AMT_MSG_MEMBERSHIP_QUERY:
-			if (saddr != remote_ip) {
+			if (!remote_ip || saddr != remote_ip) {
 				netdev_dbg(amt->dev, "Invalid Relay IP\n");
 				err = true;
 				goto drop;
-- 
2.43.0

