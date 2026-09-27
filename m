Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2165395AC0
	for <netdev@vger.kernel.org>; Sun, 27 Sep 2026 11:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790507347; cv=none; b=IpKjbUcCPVeZt233Dq5v6nJstS2O0Z1t125l8a649QntMW80zs8hIY0mf785NPZ+639M1+NiPlzPpXEmNnf0egyrDEAGn8+fzabvE9hvrPQxbiE0ZAa6XEeBUHrPtKrWFJI/Z5okxbR56nNK/x9jJkTAOqkfgsAcr4kYyl/Eu/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790507347; c=relaxed/simple;
	bh=Z81fYpBC83tyl2EahQ5uVBovVzoQMII9SPGovm+WyHM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=mtg1NUCbvQAh/3TiSEZGl2HYt74rBiqYF5eGlYqbxrN+lwKUvmr48SAPEPQ4lV1QqlgyrjJuQEDYmHLqZgkrLFiU1zKQWHK8s5Vogmh6NBwhuDOapW6MSYunU08cMddZuAzbjdm9MsjD8lFjGVCMmmSiz9GgjxP/XaefJbbo9DQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k/FHyv1X; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k/FHyv1X"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-4843f22dcb8so1677486f8f.0
        for <netdev@vger.kernel.org>; Sun, 27 Sep 2026 04:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790507344; x=1791112144; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3Yd776XVUL5K2a1r38X9yNDWujw1AE8eowaD1NftLV0=;
        b=k/FHyv1X6LMBLb0zXGYJ4mdH5FhmpLWDuSr0uym5KRDqs7LZQcYAPTo/miz84fj0TT
         Fw3ZTrCKfYzOMXXyt9je2i+YNMVDWWL8ao25Q9wHaysqmJZD3C0o7bjxLxw9ePe8wUBo
         PrvRO0pWsAm4pDGkl+ATr9yS9lLS5cIxnIwfECixuqFPkJUBST48vkilQcpvBzVcsnlQ
         NV7eXW7xuYJoL8F3IDXnpvXZ/8QwEOGBteyIGZ/1wtuCtfUjxZ8q9lUYQt82bT9GBohW
         MvIODoBjA1U231CahqQwTVCABEv0jkGlqqIiMTnOV5ReBT05Qn/KLZeEgK0eOJ4aw9O3
         uADA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790507344; x=1791112144;
        h=in-reply-to:content-disposition:content-type:mime-version
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3Yd776XVUL5K2a1r38X9yNDWujw1AE8eowaD1NftLV0=;
        b=diZDo+/mBBMY8g2RX/ZODZd3Z9ar6l09gHrMuOda7pniziMv//jZuXPRE0lWJE1Bho
         OaX6xaibvhMTTIRRXMTcR6KWGHLw+g3LIMhZDHN+tLccy7dsAYLwACe2HOyQOued9qV+
         UuAOa60Cck+SWRsNGh+1+G/Lu8PBh+OzpJLnWXpjGtWnJQ/OIjV/S+WQZDo7Pb1EQhS1
         zapqIfhCBK0CUAjwQBqEIIy9z8+DYP7sGvkMY2iRxZtmWpkHlTeDr7JCV0bhY5ENr1WN
         1Rju2aIOQsaEVd3bbEriucD2OC2nQ5i49OFEX9+4Kc6YYLqld+nIFAYdCzK9rNzxpcwb
         PeZg==
X-Forwarded-Encrypted: i=1; AKwUvBy9xIBTxo07/e7SM5ju9Gwr7DFTaSiKX24Q/vVwfsVDZoPFasFeqmpI11J1/o0x5ULyIIjKRFg=@vger.kernel.org
X-Gm-Message-State: AFq9FYJLN76R2ezP4hYp1YlUiHq1P1HD4HEiVTV6+rV5zyj1cC6voSwY
	imBzrUmBqLvhqFoyFXtWasRD5XI53jI6KNf1c4Bii7BJoQOfNCK9uCxd
X-Gm-Gg: AYBFou0bdpvRkNDLELsqorh8+5Jnondr1KDOSiJsm+ZgYBlBb/y37+SxNi+l8CqPVVX
	G/U7qNvIRDFKKjlcwIAS3sI1sPi42foUywDEcYJKG5JgID5hBfFcJiovC0nJAwYai2gd8ncWaF4
	U7FaBbqP0BnjOcgMbfX9LamWz+8/P3vsMGyDpyaUDaVniMoXbNJdl0+yll5+PPmCvlIi56NvFTk
	PPg7Cmxv4uCGFE0+e0bLwEk7cXl7SbGx2Bb/xHR8M5tfXms6vSegFwL0rOxch0k3zhmzGW90g1/
	9LF6FrFdzHhcigsJaCHxaCqQCWxl0OLviNX8yAGKfa/a2ET/whIqDlOPgnjZW0HbGAK17WAX0NP
	yxq3+Tgz+oWmTlPc63nMK2Rc2Lfo0t5O9Tc3qhpUojBdgJNY7azOoud7Sa1CxMMM0tMXiKiGwx1
	vIFeBBZrKuaGmbClxDiIqEfRezasH46QnExqcla8JyZCuPpCtSGUkDOLGgPibLe2AfezWlEg==
X-Received: by 2002:a05:6000:230e:b0:488:5d44:6680 with SMTP id ffacd0b85a97d-4887175f986mr18594216f8f.36.1790507343764;
        Sun, 27 Sep 2026 04:09:03 -0700 (PDT)
Received: from gmail.com ([83.231.69.9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4887a64f795sm18090168f8f.31.2026.09.27.04.09.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 04:09:03 -0700 (PDT)
Date: Sun, 27 Sep 2026 13:08:59 +0200
From: "Jose A. Perez de Azpillaga" <azpijr@gmail.com>
To: syzbot <syzbot+89001660f14fb7684c83@syzkaller.appspotmail.com>
Cc: davem@davemloft.net, dhowells@redhat.com, edumazet@google.com, 
	horms@kernel.org, kuba@kernel.org, linux-afs@lists.infradead.org, 
	linux-kernel@vger.kernel.org, marc.dionne@auristor.com, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [net?] [afs?] kernel BUG in
 rxrpc_destroy_all_connections (2)
Message-ID: <arj4xgLi_4YZl929@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6ab29768.514bccd6.255447.001e.GAE@google.com>

lets see if this works.

#syz test: https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git a7bfaba4823e

diff --git a/net/rxrpc/conn_event.c b/net/rxrpc/conn_event.c
index 611c790bc6d0..111f0844b0d6 100644
--- a/net/rxrpc/conn_event.c
+++ b/net/rxrpc/conn_event.c
@@ -274,4 +274,15 @@ static int rxrpc_process_event(struct rxrpc_connection *conn,

-	if (conn->state == RXRPC_CONN_ABORTED)
+	if (conn->state == RXRPC_CONN_ABORTED) {
+		/* A CHALLENGE packet queued for processing carries a ref on the
+		 * connection (see rxrpc_post_challenge()).  That ref has to be
+		 * dropped here because the caller frees the skb as soon as we
+		 * return.
+		 */
+		if (sp->hdr.type == RXRPC_PACKET_TYPE_CHALLENGE &&
+		    sp->chall.conn) {
+			rxrpc_put_connection(conn, rxrpc_conn_put_challenge_input);
+			sp->chall.conn = NULL;
+		}
 		return -ECONNABORTED;
+	}

diff --git a/net/rxrpc/conn_object.c b/net/rxrpc/conn_object.c
index 0ece717db0f8..1295f3de3725 100644
--- a/net/rxrpc/conn_object.c
+++ b/net/rxrpc/conn_object.c
@@ -487,2 +487,18 @@ void rxrpc_destroy_all_connections(struct rxrpc_net *rxnet)

+	if (!list_empty(&rxnet->conn_proc_list)) {
+		struct rxrpc_connection *c;
+
+		pr_err("AF_RXRPC: conn_proc_list not empty\n");
+		write_lock(&rxnet->conn_lock);
+		list_for_each_entry(c, &rxnet->conn_proc_list, proc_link)
+			pr_err("AF_RXRPC: proc conn %x cid %x state %d ref %d act %d flags %lx cache_empty %d calls %px %px %px %px bundle %px\n",
+			       c->debug_id, c->proto.cid, c->state,
+			       refcount_read(&c->ref), c->act_chans, c->flags,
+			       list_empty(&c->cache_link),
+			       c->channels[0].call, c->channels[1].call,
+			       c->channels[2].call, c->channels[3].call,
+			       c->bundle);
+		write_unlock(&rxnet->conn_lock);
+	}
+
 	ASSERT(list_empty(&rxnet->conn_proc_list));
