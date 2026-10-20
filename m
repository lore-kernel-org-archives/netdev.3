Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792455964;
	b=KFF1XlLNt09/XpcxkBiLV0ztHAj2fKzlQt4vIpoh7PAaeMRInqgRAKzbBjsgN+j94vQT
	 g3QDvNrb4CZKC/79f5/KZraUZwyel9+clx5viW9oaQc5amFQSTZvNZrUaQtBInb8IgWGp
	 NgNjOSFT2/Ez7alNICtKT3wjGvv54I6mZXuaoJgmqQfvD0PwYz2UdRGNxW/zxQmpRAMH5
	 dnCiqoahe60DjX5naY1smQEFpT1sQKIUYK2bppIvN3VfZXvokBgR572OALdULzQvDPbiP
	 UqaAnZeIAw6ftFrSVeL7tghHAtC60k008FQtl+vcUTz90U17AgEGV3IyF3jPDw6X2Xg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792455964;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=COFaY0fjD4W5B9+uIoGdB1sae14RtC5HEU1O3nW/9+Q=;
	b=JNDFr6QvLYWTI4glzYoa0oZmu4L4qFMRIFmM70JeU0MtDbVghknP7hcDejr4cnu/L3gY
	 cPJq3F09nnCpmLfrcvUUj0G3TOdlKnecN3LGIV0psw/wjpoJrVsfPx/XvATEjdQ1zuuJ0
	 C+bz55xfPHY2Y4EeoS1tpJpI20raEGfhqHsXpQult2gOrCvZIjEU31GN4JKKb36sAVRRb
	 k4NZBcj7bVJMipJSKUkS5OPJTh9fkajB664ewHPcjvS/1QNnFCmHyXv3SnPUlywupqh2B
	 1Sq+NG+A9Wqa6yx/J659Jpak5fZLePzNYJbaPmzY1f7ycyiXsKIx1/WxfdWy+diawTQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=blockcast.net;
	spf=pass smtp.mailfrom=blockcast.net;
	dkim=pass header.d=blockcast.net header.i=@blockcast.net header.a=rsa-sha256 header.s=google header.b=yCPDq68v;
	arc=none smtp.remote-ip=74.125.82.177
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39027606A31C
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 00:26:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 39027606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=blockcast.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=blockcast.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=blockcast.net header.i=@blockcast.net header.a=rsa-sha256 header.s=google header.b=yCPDq68v
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-35c76e9614aso5084962eec.0
        for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 17:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blockcast.net; s=google; t=1792455963; x=1793060763; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=COFaY0fjD4W5B9+uIoGdB1sae14RtC5HEU1O3nW/9+Q=;
        b=yCPDq68vGPY3eIFms5XrKyECmnNkPXdH6G2WNwH+KbulONfq+8oO+E5/oRUdbOPDOW
         +VcBGcmu64SGSi9GH8o5D2U//87V3zgF0zoQkDZmlu8gp38/GQ5wnZ8inD6fMmQZFYKu
         H8NbO1KlMiloc94MOGzsp9GjcJvi1xOqNMySzMZdb7h/AjKdIEuOlcfad9YhRSvX7hO6
         OgTvai5Rg66fjNG0XMyAmeNPobh41ypnTqlLgJ5549lVnyVUMhBD8hrlE2H4aQFGKgqu
         BP2oKnVVYGWloxjj4uFrJxmv1/VcSwU1qjEQyCRixrC0P62CcGq1XMzX4CQro6ZA1ez4
         zmNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792455963; x=1793060763;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=COFaY0fjD4W5B9+uIoGdB1sae14RtC5HEU1O3nW/9+Q=;
        b=W5yVEbHTtROqorOycwBneLRX9Z2dXE2yqlr1RWrFMCfkc77lLycNivthVKIA+va2wu
         tVbezRaSoVT/koivWqNrYW704ZQsGMa2XHQYSxtSOs8ZkuOWr5zWQhJlSFZZv9L+7z6X
         15gJpejT8vLnpZrSOkbVt+iaiQNGuUJ+p8ayIe6k4kFw1Iw4V14qvMPQ6135WvIdRG4Q
         bf2ku1oXDQwCgq8IqXVQqRjhTU+sVIe9cuhzAGiP6kjtEQxQa5iWQXA4jTjQLjLCf1jL
         P0EEkhYRyccV6sUPTMRGipXMdAGmlS811JEd4gbUnCwfutM80kRFo7b8xjkbKpd63lvc
         9t7A==
X-Gm-Message-State: AFq9FYJODWWmzMSUO/ItpDAp2ZPBWryr0fxMjSzpjSCmrYBGQwlynIZh
	EY+ia3gOt6E5BEGmUdEKwtHNpaROGyU4omz7tlsboc20lB75oHdesAXsQszyK2aJRdk=
X-Gm-Gg: AYBFou3FzGP1J/yk8qKZUFAN3/8o3SrgrBxfqItV1bV3pnxi9OdBnRBGzp21jDaB20m
	5ccQE4PMx3eTAozL8gG5FGP7bmKIswlqdoc8XMjzi/kG0qw8NqoarboyDCJNEtTA4Ay+SqPkAKg
	7VrCqF/2RS2G2ldA4SPL04ci95xhcEt/H7F4ZitPIwZGM4M3LzSYnhhtiVKyq6B6lMLoQmtK20P
	W96m/h4gQ4jpjUCqmlWb8EltZEk6UuJfUkiLt7FNRKktkbKeJQQG3Z02fkXl80Fc7R/x2xJ+DgD
	R+dQp+CbIwz6nFmbeCloM4VHODhcGsPPpjDHa5uqP/ddnm1RKGMhF/V0J7zIYPrhoTtvoXfSK28
	k/y87OunPzVIC0QfSf+rUw2Pol+SR7agL1/k/qhXqwmpcdCGUYN5QqCBaBIuJTu3rPoT1U1JwVn
	33lQ2Ee/wf4JzkGrGjGi5Pv5mvgq7EJVAE3El9wyY37rzJ7iMO2RvFX8KCBCyHMVTcH5OwGjmMd
	jK6TwYrJOEsamAuLHSueB664iyBAkz9Bvh31NKkvpTOCndw1y/F1IpJUIgZJ9SK
X-Received: by 2002:a05:693c:88c9:10b0:35b:fe88:d053 with SMTP id 5a478bee46e88-361a2052c21mr13014070eec.23.1792455963030;
        Mon, 19 Oct 2026 17:26:03 -0700 (PDT)
Received: from devbox.ts.blockcast.net ([69.25.95.32])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3608258aa66sm44748072eec.20.2026.10.19.17.26.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 17:26:02 -0700 (PDT)
From: Omar Ramadan <omar@blockcast.net>
To: Taehee Yoo <ap420073@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Simon Horman <horms@kernel.org>
Subject: [PATCH net v4 2/5] amt: reject a gateway Query or Data from 0.0.0.0 before a relay is learned
Date: Tue, 20 Oct 2026 00:25:54 +0000
Message-ID: <20261020002557.3984927-3-omar@blockcast.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261020002557.3984927-1-omar@blockcast.net>
References: <20261020002557.3984927-1-omar@blockcast.net>
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

A gateway's amt_rcv() admits a Membership Query or Multicast Data message
when "saddr != remote_ip" is false. remote_ip is 0 before discovery has
learned a relay (and is reset to 0 by amt_dev_open() and when discovery
gives up), so a packet whose source is 0.0.0.0 would otherwise pass the
equality check and could spoof a Query or inject multicast data.

Reject both when no relay is learned: a 0 remote_ip must match nothing, so
guard the check with !remote_ip. A Query is queued before its event worker
processes it, so the relay address can also change in that window. Recheck
the packet source against the current remote_ip in the handler and discard
stale Queries. Discovery is unaffected because Relay Advertisements are
validated against discovery_ip, not remote_ip.

Fixes: b9022b53adad ("amt: add control plane of amt interface")
Assisted-by: LLM
---
 drivers/net/amt.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

Signed-off-by: Omar Ramadan <omar@blockcast.net>
diff --git a/drivers/net/amt.c b/drivers/net/amt.c
index 478bd85..c19e67a 100644
--- a/drivers/net/amt.c
+++ b/drivers/net/amt.c
@@ -2472,6 +2472,10 @@ static bool amt_membership_query_handler(struct amt_dev *amt,
 	if (amtmq->reserved || amtmq->version)
 		return true;
 
+	/* A deferred query may outlive a relay address change. */
+	if (ip_hdr(skb)->saddr != READ_ONCE(amt->remote_ip))
+		return true;
+
 	if (amtmq->nonce != amt->nonce)
 		return true;
 
@@ -2948,7 +2952,7 @@ static int amt_rcv(struct sock *sk, struct sk_buff *skb)
 			}
 			goto out;
 		case AMT_MSG_MULTICAST_DATA:
-			if (saddr != remote_ip) {
+			if (!remote_ip || saddr != remote_ip) {
 				netdev_dbg(amt->dev, "Invalid Relay IP\n");
 				err = true;
 				goto drop;
@@ -2959,7 +2963,7 @@ static int amt_rcv(struct sock *sk, struct sk_buff *skb)
 			else
 				goto out;
 		case AMT_MSG_MEMBERSHIP_QUERY:
-			if (saddr != remote_ip) {
+			if (!remote_ip || saddr != remote_ip) {
 				netdev_dbg(amt->dev, "Invalid Relay IP\n");
 				err = true;
 				goto drop;
