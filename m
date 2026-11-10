Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794344748;
	b=UCoWl7ZexIq+Igeqb6DKk9nJWg2vmbGMR40AZm/UWcQ54Ps9MiUqfDXfrdi53ZdcHwe+
	 RURRlTMRsLem4kNqCd4o+2cIXi90VmSDopU7/x3asogfWs15ZkWj/riVPMNBbt+hsgkUo
	 78n2Ei2TpODoZCiCVfwt+QDuwUysKuUAHlZ35HNXLwh34wrnRVGVTf7e3sjHAqOgx2ovB
	 I8K2l7qSpSXp6v/jh10nvTKfLMjTmgZwKyTBTGm+tOfDYZ7hXSZ/m0I9w3Y4PZPd0hLlI
	 HE3NcnvLXOb3yXUT9WygTHd1mKUvbs3HiA6hnBuDj75opE5OadOw1z8pO8Ia/G8C3XQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794344748;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=tlTA7sqBysXN+F6fe4TMgN82A274aSjTjJDiigwKkzo=;
	b=WajKPhpfyLlFTDbwvDDObl1b3zXX34j+LGscKzlGcIJBmNHVtyNdjibZI2F9MH4QMGRx
	 VGk5iRDRhakL0adXuRrJL82xsAFF0+gcmim/S0NJ+ku9leMyyX5MuX2zKNfVd9JSq/aXh
	 OaSVF28ooaGZ9HQcU+EGvVSb3wy60TEaLVzcYliJL1BiKHlW6hJ8mg/G8wJWPfdcXar2y
	 JN+HQoekIlO8OLIOg5YdZ0fZMFwHfI8JfxldBmdbW4RGRcDrqQG6aygUPFondc2FodIgG
	 LMSVRI0IJllPgrNHE+z2YKUmhhtOj22OvfCN8fYnc9Z15q4UksanN8f3wxOo8GLIDcw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=blockcast.net;
	spf=pass smtp.mailfrom=blockcast.net;
	dkim=pass header.d=blockcast.net header.i=@blockcast.net header.a=rsa-sha256 header.s=google header.b=PjZAvCXD;
	arc=none smtp.remote-ip=74.125.82.171
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1C7960A262B
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 21:05:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E1C7960A262B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=blockcast.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=blockcast.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blockcast.net header.i=@blockcast.net header.a=rsa-sha256 header.s=google header.b=PjZAvCXD
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-3282db206d3so1782289eec.0
        for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 13:05:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blockcast.net; s=google; t=1794344747; x=1794949547; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tlTA7sqBysXN+F6fe4TMgN82A274aSjTjJDiigwKkzo=;
        b=PjZAvCXDMrTNut+6hDPeDPP8whf8WAVkjVIU0/3wwXOzeObjjQwPkhZh1CdFvfAggg
         BJu1GFt43cJFfR3RTeUp6wIn4ogBztRny8R3fNGBc+mEYVA2zeRtXphG0GXa2hEg2yEN
         hmZHyCJCtGUgsSd/l/uQM6zupSfA1wKPdy/Br6xxy3ShRRklzVRC12SaP6DANWS08Rd5
         M4ONgjwRnQs6V2xZa85PI6sITqKfkm7g9UDENeFiyJZjV7msYx+i+4rSfR5gVzZfc3Q6
         0foJQI5OpIxMNR6Tzh/683oT9qpSFNc8Bo332TYt2cdrdyCo4UJCYcTo/QQDLFj8coDP
         El2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794344747; x=1794949547;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=tlTA7sqBysXN+F6fe4TMgN82A274aSjTjJDiigwKkzo=;
        b=lygaiWw9KMmix4XQmtQJt/dJNrLKxeJoGQNBYFSjLV5+IcDNZkx81gl/6Tc/UUPqfK
         94VgX5qypUddRl63dujDd7IYylu3p6ipjqh+9ZoAsYE45LmUqc4FTrK0dMvGtWE0yOlP
         OQkX0RNmJhS1exsTFWfwvlaINiOsgEj4IsKqM1Z9o5Mo31V3QjSGRHYU3tc3SUuJFmLc
         TFQ0FZgbpgWFtgHno6fxDvfUm0nir1Q9eDhCw8b9/xpB8wDp/1Cg6skg375V5NGiyYbC
         xdVQfi3ESz9kHWzAEUDEsL9/O5v5x/uhSOYwnGJ2r0xzak/40ONeSh3bfdVFT6T+Fxti
         0jaw==
X-Gm-Message-State: APuU4Z/Y4lrbBiu2Wx1k5hY3DrmRAVKQMrxK2Abmy9ADP+pr/K4HUhnR
	1s4zVlSf28IWDzH5UU9MeTSbIqKUG3mIG/EhKG/JD3soiPwKlwP6bAI1XD9+aPJjcjo=
X-Gm-Gg: AYBFou1SQJ7Wo/0HHHb2UWIfj6/v5bF3mSyp5TMexx/2xWKmKErmXtq4+JH1vLG7w5c
	60JRka3DUyjaaq9iCxHQYpbTEY9OBQEKIOP7PrVAaSC5wfRhGd3wzRQYuKqQKvNHNWcXttclvos
	WngLvqwO9JrkQ0Hnr4IXVcR7mo2E5mESG/0B48AWDQj7ZaScDf1TnSJdls40CjD6FM8hGMW5Xpj
	0222KrNsy2Lv18QJD0BJQ4OT6opvI9qAeOG6S6aoEEAoRyt7zaUu9vmRCnyXa9YYKH86iuq59z4
	F4QC+iqRnA9w2z2YgZt7CL2fm6ljlufWezknCdd67DGqUcV7yl6+lCzuXXCKfcMNXdF9wJlUg/i
	l9T/i78NQIDF+2lKsfd8UCA3h8jFrYmPBjVx67FK4ofBzGU6lQnUMFDgcvaZxoLV6pHskmScQBH
	q8OLPkE2TKhqCqkICZIomkWTjHhtRkDvSlpGOGIP/0zQZcSs4jHbmN4YZcfQ1aLN5P2VIHR8EpG
	hU8A7ZYIpRggauEBlypZ8nvOAPnkvMevxgZwFyZDKxyQapGnIUTQIimFxZShbZ+r8cBm1OXuG/y
	Tp1Udbwd2lBqlY3aTOksZDuISnSH5h6sVy1sn17ztqG16peJnY59kTaevR+EpJRPuV12Tik=
X-Received: by 2002:a05:7300:d211:b0:372:eab:d700 with SMTP id 5a478bee46e88-376831886c3mr635514eec.1.1794344746875;
        Tue, 10 Nov 2026 13:05:46 -0800 (PST)
Received: from devbox.ts.blockcast.net ([2602:f74d:1::32])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37520cfdfc6sm10464097eec.17.2026.11.10.13.05.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 13:05:45 -0800 (PST)
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
	linux-rt-devel@lists.linux.dev,
	Kuniyuki Iwashima <kuniyu@google.com>
Subject: [PATCH net v7 3/6] amt: reject a gateway Query or Data from 0.0.0.0 before a relay is learned
Date: Tue, 10 Nov 2026 21:05:34 +0000
Message-ID: <20261110210538.217936-4-omar@blockcast.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261110210538.217936-1-omar@blockcast.net>
References: <20261110210538.217936-1-omar@blockcast.net>
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
IPv4 input accepts a 0.0.0.0 source only on a limited broadcast or a
link-local (224.0.0.0/24) multicast destination, so the sender has to be
on the gateway's link.

A forged Query must also carry the gateway's nonce. That is 0 until the
next discovery tick re-randomizes it, because amt_dev_open() and the
give-up path in amt_event_send_request() zero amt->nonce along with
remote_ip. The Query handler then sets ready4 or ready6, mac and qi, and
moves the gateway to AMT_STATUS_RECEIVED_QUERY. From there
amt_event_send_discovery() returns early and amt_advertisement_handler()
rejects every Advertisement, so discovery stays blocked until the
Request retries run out and the device is back in AMT_STATUS_INIT with
nonce 0. The Data check is defense in depth: amt_multicast_data_handler()
already requires AMT_STATUS_SENT_UPDATE, which a gateway with no relay
reaches only after such a forged Query, or in the short window in which
the give-up path has cleared remote_ip but not yet reset the status.

Reject both when no relay is learned: a 0 remote_ip must match nothing, so
guard the check with !remote_ip. A Query is queued before its event worker
processes it, so the relay address can also change in that window. Recheck
the packet source against the current remote_ip in the handler and discard
stale Queries. Discovery is unaffected because Relay Advertisements are
validated against discovery_ip, not remote_ip.

Found by code inspection while writing the IPv6 receive path for the
AMT IPv6 outer transport; not triggered at runtime. The Sashiko AI
review of an earlier posting pointed out the nonce condition, the
blocked discovery and that the Data check is defense in depth.

Fixes: cbc21dc1cfe9 ("amt: add data plane of amt interface")
Fixes: 30e22a6ebca0 ("amt: use workqueue for gateway side message handling")
Assisted-by: LLM
Signed-off-by: Omar Ramadan <omar@blockcast.net>
---
 drivers/net/amt.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/amt.c b/drivers/net/amt.c
index fc3900e25..9f59ec6c4 100644
--- a/drivers/net/amt.c
+++ b/drivers/net/amt.c
@@ -2527,6 +2527,10 @@ static bool amt_membership_query_handler(struct amt_dev *amt,
 	if (amtmq->reserved || amtmq->version)
 		return true;
 
+	/* A deferred query may outlive a relay address change. */
+	if (ip_hdr(skb)->saddr != READ_ONCE(amt->remote_ip))
+		return true;
+
 	if (amtmq->nonce != amt->nonce)
 		return true;
 
@@ -3005,7 +3009,7 @@ static int amt_rcv(struct sock *sk, struct sk_buff *skb)
 			}
 			goto out;
 		case AMT_MSG_MULTICAST_DATA:
-			if (saddr != remote_ip) {
+			if (!remote_ip || saddr != remote_ip) {
 				netdev_dbg(amt->dev, "Invalid Relay IP\n");
 				err = true;
 				goto drop;
@@ -3016,7 +3020,7 @@ static int amt_rcv(struct sock *sk, struct sk_buff *skb)
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

