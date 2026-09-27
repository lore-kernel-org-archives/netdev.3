Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C76A63E16A1
	for <netdev@vger.kernel.org>; Sun, 27 Sep 2026 12:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790510688; cv=none; b=spYupNG0Q80JcPk9yWe8eznne3EWQtx9hgCuz+K+kTFLkIh4ojeBvy9q30hjdiA72JtB2QY97oe0is3x272WFw0ydI7NsHW/RinuBQ5oCvw/oijW6wMA+A9A2N9m1OuPxkdCoSXYePJ2bAaqB0ZGT3A1IJ3VouF+bbMjvCGURWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790510688; c=relaxed/simple;
	bh=ot0jbORaTJGRRQZg6tLvbXq+cyNGWm10JUVUlcn26vY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=fsTO1KE5AtBBd3cfPfDbr5PXIux4lyp66/bWC7xFfpkyec/9APpSeW3Qtvn4Qnwa47u97cEVLM8naaVGsajMWd0NOmOa9T1zd+KXBs7e4B6vijmJbqaATtQ+SHoGNFS4Q2qpvG73+NKjsPoAhfMiRqk3EzII6sZ+fVAZpNLfULU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C2W2yhNn; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C2W2yhNn"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49b912d822dso16110385e9.2
        for <netdev@vger.kernel.org>; Sun, 27 Sep 2026 05:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790510685; x=1791115485; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=p73dx9rkt6mjYajPsO9IbZU4Sl+ZeNH7qZWcKoqLHm0=;
        b=C2W2yhNnYMWRAGglC538BAJOfK02X8t4pp7wOCoedwcFZHkfAZjmzllf7tMTuisdGD
         AxmbdP2JDuMfekwfNF9C9q6pUCdIrzpu/ZFPQIQLAFSbIHYFHrEfmNSZpwvhv5K02G6B
         V1kkY6CmX5uz88w6UOknmZy6d8MYuFY9RH3j1L55DepmJt7MDl8T31R+GhoWPzgDuCAt
         9MtmlC423hSJ/b5ML9TIrlnwhH6IU9wvfJ184WS6OmjGWcdt3BQP7WtfkH5d86xGCLPp
         s3+l/vu2M0YcajtTMxwkWmYngWQRdEGqSMD/S5J9hMnNNTOqtOFAeJN3dVD7hMgDXm7m
         ASiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790510685; x=1791115485;
        h=in-reply-to:content-disposition:content-type:mime-version
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=p73dx9rkt6mjYajPsO9IbZU4Sl+ZeNH7qZWcKoqLHm0=;
        b=lwhRDcS9br3WTGXhsfbyt0LKmszzEkXvxWv6DTf8VjV6qLefIG2vxazaixdmezXHja
         ITc7g3SvxqeRWPml2XfR4TCyhGPrDe1718ceduhQ/AT39cJ8e6miMDeekhiJwxuWWjsq
         rukfg4y4fN+r5HyQKcqokUGf865GTty4Wm0kEvffPKJAjk0uR3oQNoJrm6OfW+Z3eY23
         sIn43JMERevM+2h1VUSykntq/cYTCmBWq8AvKKXLKoI9i4h3dJYM6nyU2yp3aS13cvej
         UD5TbEkcvX7uhQQ5Dq61laDLRNxe/8bx+rt7VcmjhLD06Htsm3bwBsj9aURgJAuUG/77
         Qbkg==
X-Forwarded-Encrypted: i=1; AKwUvBxrHPJKbAo1eGeo5FecUGfV3W5DJl1lETd9oxtQWM0Q3/p2sK69oOTpA9fE2P6y1RkqzPxzUWc=@vger.kernel.org
X-Gm-Message-State: AFuF++kSA565PfPAumwToS+n708uslhXWQxmiwWKK5qeisBVtlN9KSQG
	Coc63bIGsRgkmUwt8CtonW0GbuC5h2HTRfaxNw43VLPt2tQzcRgHolbL
X-Gm-Gg: AYBFou3NNWOhCmteWRbsIyUFPrbyIIVQRPEs+BHGGrtlpWmlEXCy9kSlyxNhzT1CpgO
	xu/fC8hxz7TnB2bXCb92jxIo9x3GuuJnFv2bZYSLjaWJyEB3ow5a6uUvLGTVKu2L+q5fgH2pWLS
	zCw+4Fr8yATKv6u96KnwOH+0wL7baWeZerOFbbAZn+hIerWe3gT4wUTvyAe4lxHjmTDcsTAJ78F
	SBoJSU7cYabw0GKLrOOtJDfZDNFG+1ctMOWf8dr65n6lxQKffbUe+VLGX30A+164Cg1pxMfJYWB
	Am1eXIwnBtxHjoPFjAvVzOptrFRTIbuWUIH5PFTdmLQa6cTHtTQf2bxtllMBufRJeXhPyotKtIi
	vyPoVnOz3KUrKGDOf/wA1JfRsIYn7miMG3I2ZmMViS4ziHKP7cbvg7qvIxcRhYK8wsgZPyqBy7C
	R3H9YUNgBA0vLBgjSuD4ejOHdswXB3ERuizsNsTE1FKqM5U5QAicTIg7w8EP0afj16nTWpQg==
X-Received: by 2002:a05:600c:c494:b0:49c:fa21:1c81 with SMTP id 5b1f17b1804b1-49fe7bab979mr173765785e9.22.1790510684687;
        Sun, 27 Sep 2026 05:04:44 -0700 (PDT)
Received: from gmail.com ([83.231.69.9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fef4fc959sm179581875e9.2.2026.09.27.05.04.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 05:04:44 -0700 (PDT)
Date: Sun, 27 Sep 2026 14:04:41 +0200
From: "Jose A. Perez de Azpillaga" <azpijr@gmail.com>
To: syzbot <syzbot+89001660f14fb7684c83@syzkaller.appspotmail.com>
Cc: davem@davemloft.net, dhowells@redhat.com, edumazet@google.com, 
	horms@kernel.org, kuba@kernel.org, linux-afs@lists.infradead.org, 
	linux-kernel@vger.kernel.org, marc.dionne@auristor.com, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [net?] [afs?] kernel BUG in
 rxrpc_destroy_all_connections (2)
Message-ID: <arkFzpbQnWICoJDt@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6ab29768.514bccd6.255447.001e.GAE@google.com>

#syz test: https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git a7bfaba4823e

diff --git a/net/rxrpc/ar-internal.h b/net/rxrpc/ar-internal.h
index 865f05fe37ab..2ecfd58cd566 100644
--- a/net/rxrpc/ar-internal.h
+++ b/net/rxrpc/ar-internal.h
@@ -1205,2 +1205,3 @@ void rxrpc_disconnect_call(struct rxrpc_call *);
 void rxrpc_kill_client_conn(struct rxrpc_connection *);
+void rxrpc_discard_unactivated_client_conn(struct rxrpc_connection *);
 void rxrpc_queue_conn(struct rxrpc_connection *, enum rxrpc_conn_trace);
diff --git a/net/rxrpc/conn_client.c b/net/rxrpc/conn_client.c
index 48519f0de185..8ccf69cc973f 100644
--- a/net/rxrpc/conn_client.c
+++ b/net/rxrpc/conn_client.c
@@ -697,2 +697,13 @@ static void rxrpc_unbundle_conn(struct rxrpc_connection *conn)

+void rxrpc_discard_unactivated_client_conn(struct rxrpc_connection *conn)
+{
+	if (!rxrpc_conn_is_client(conn) || !conn->bundle)
+		return;
+	if (conn->act_chans || !list_empty(&conn->cache_link))
+		return;
+
+	_debug("C=%x never activated", conn->debug_id);
+	rxrpc_unbundle_conn(conn);
+}
+
 /*
diff --git a/net/rxrpc/conn_event.c b/net/rxrpc/conn_event.c
index 611c790bc6d0..a30cbaa8a48b 100644
--- a/net/rxrpc/conn_event.c
+++ b/net/rxrpc/conn_event.c
@@ -40,2 +40,5 @@ static bool rxrpc_set_conn_aborted(struct rxrpc_connection *conn,
 		spin_unlock_irq(&conn->state_lock);
+
+		if (aborted)
+			rxrpc_discard_unactivated_client_conn(conn);
 	}
@@ -274,4 +277,10 @@ static int rxrpc_process_event(struct rxrpc_connection *conn,

-	if (conn->state == RXRPC_CONN_ABORTED)
+	if (conn->state == RXRPC_CONN_ABORTED) {
+		if (sp->hdr.type == RXRPC_PACKET_TYPE_CHALLENGE &&
+		    sp->chall.conn) {
+			rxrpc_put_connection(conn, rxrpc_conn_put_challenge_input);
+			sp->chall.conn = NULL;
+		}
 		return -ECONNABORTED;
+	}

diff --git a/net/rxrpc/conn_object.c b/net/rxrpc/conn_object.c
index 0ece717db0f8..6d453b9a9457 100644
--- a/net/rxrpc/conn_object.c
+++ b/net/rxrpc/conn_object.c
@@ -251,2 +251,3 @@ struct rxrpc_connection *rxrpc_get_connection(struct rxrpc_connection *conn,
 	__refcount_inc(&conn->ref, &r);
+	pr_err("AF_RXRPC: conn %x GET why=%d r=%d\n", conn->debug_id, why, r + 1);
 	trace_rxrpc_conn(conn->debug_id, r + 1, why);
@@ -367,2 +368,3 @@ void rxrpc_put_connection(struct rxrpc_connection *conn,
 	dead = __refcount_dec_and_test(&conn->ref, &r);
+	pr_err("AF_RXRPC: conn %x PUT why=%d r=%d dead=%d\n", debug_id, why, r - 1, dead);
 	trace_rxrpc_conn(debug_id, r - 1, why);
@@ -487,2 +489,18 @@ void rxrpc_destroy_all_connections(struct rxrpc_net *rxnet)

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
