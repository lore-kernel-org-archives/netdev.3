Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794095845;
	b=yQnro3kofPYfw79+WKbv1M31pLmssH2OjwkRb76kPHC91VR8lZArbXVxNo+2+THAKJ5Q
	 nuwwj07+4rbzqo/8nTiQ940fM890r/p8Dn8v9BWq7+3YY/2Hxo3e4aUe9sKdx2vVKtspQ
	 +4mRl4UFDiev3tBeyve2fZLSDTU/AQDyfxs8D8cuez2MIVxSnuracp1HFn5NJiOiXJxLo
	 V7+uQIvNM/vj4tMxvzDgnjMf+wwt0CeZtmFiYNBcNg4BG/oNiv1Cs78Jl1t3Rx8u8n2GM
	 WaZLnZZHzQnPzbLdIw76rREn8G/dsZtWNIz0bI/fDNNBn8llCJYn+dp4CQYf9bxTaxw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794095845;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=gxu+5zKC7k3pCsgw0BsWX0PG8iuwMTHdmxhaqeiTNUA=;
	b=hYAHzrYZgZRSD2HXBay/EvLSCtIsPClYi+ICY7/5B8nGB5LVyy1Zotpb5ybEBvp2d9gZ
	 e4hJFQsi3bmcqeSVJt6YAa2DyCBY1/397VxHq1/wgVnao5kjvZ8bMlgeqU/D5t5HCKo/E
	 dL+IY/WGzJxfey0HXWwv57AcFZJnGfu4ycswoeQKaAQ5521Q/A0Q6wxcWcLl9iKWWZoMg
	 ZXKHtP/9ykuTJvXk/UQXFNZAIhXZjaDSQhndL6QoaKabv7IOSTJH8+zzWPiOT1ntVaPZz
	 WW942lLJxrQgOxpZMsb6DPziOvKQq7csTBpkPbSBt1i8Hw+d4eDOvNap2gBAsxnO0nw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=hNGux4oS;
	arc=none smtp.remote-ip=209.85.210.199
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3226606A337
	for <netdev@vger.kernel.org>; Sat,  7 Nov 2026 23:57:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A3226606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=hNGux4oS
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-8b37ef7de11so43108b3a.3
        for <netdev@vger.kernel.org>; Sat, 07 Nov 2026 15:57:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794095844; x=1794700644; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gxu+5zKC7k3pCsgw0BsWX0PG8iuwMTHdmxhaqeiTNUA=;
        b=hNGux4oSo3+9sKDvKvfqZd4TYoJlcnfFkY4s6gJZTeKHaPHXA0y1nMveUzWqpB5Q99
         VwKVi2aNJN12fXSEcFIZwH1CK0lAkXljYN3po5m8JibXw1wkezpb+choEJ4tHsmvZGnC
         Pq9WsVN4wYrYWL7+qB+W7eJAqGGspwe524x3ihP4z8oW5bWeDjFxq/+0rbiuh8rBP/1w
         I1xdabEqd72RbY4SWdIVEt+9W96WREDynLZQLj7JQzgTxKeVEOv/I6JAHJ1HMqekOg8M
         IIatLCccvvnq6TJNedgyweOifenaLZ0LhIVXYKFZKgrEedCVUshgl0HUmvfHpoLys9RQ
         Fdxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794095844; x=1794700644;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gxu+5zKC7k3pCsgw0BsWX0PG8iuwMTHdmxhaqeiTNUA=;
        b=xNgVFIcEhmT7A7mK8wwlI90rJpRVPCRv1dMlY6IQ73qPK0XILmPAhPhz8zMwJx7CW6
         oEKbtyrfG9FlUJZgef3erm9LJyiaBC86PkBaYUfwUx6fL3qpGrQZ87vihJXZHxx3iE5j
         e1ZD6MrHwfL477pj/kDsVhp3uG7ousCuKD0ixTkMkdmn0WIsrbNqrT0SADX6r/aK1Dmw
         qKlAYfpgIc7lBVEcHFtUKAwIIqju/RZWa0g83QwPF+s35fpwngCYa82v//MgWrBKKDPz
         LM+Hqz09J4FVIykD2WLLpDZFOoTqxWkZPv/ZnOVZ62/fm+PJovI7dG6l8QWpDJeOZ7yJ
         hYPw==
X-Forwarded-Encrypted: i=1; AL+hErEako2fDw3N4/q+S3MdqRLeKe3L5sBoiVIbxauAJnXoIB+tVzmcWGjLwviWA7Jj3q2Q83vKr2Y=@vger.kernel.org
X-Gm-Message-State: APuU4Z8p3ZfE6ztNqNNbziPTRfuwZm78sw/D3fQZlcd5tfNYNSH2Dhxa
	HGt0I3sS6GCB2mNPhf/o1lfpDgt+c8ctLrEzeqOhA+VRdAGD9rGmUUa24zbqf3SA6I6/7QQhM4w
	fWwyfJg==
X-Received: from pfxa39.prod.google.com ([2002:a05:6a00:1d27:b0:899:3459:82f2])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1793:b0:87d:dc3c:1b5e
 with SMTP id d2e1a72fcca58-8b66e344e64mr168193b3a.26.1794095843854; Sat, 07
 Nov 2026 15:57:23 -0800 (PST)
Date: Sat,  7 Nov 2026 23:56:09 +0000
In-Reply-To: <20261107235720.3129212-1-kuniyu@google.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261107235720.3129212-1-kuniyu@google.com>
X-Mailer: git-send-email 2.56.0.455.g6c5a503b38-goog
Message-ID: <20261107235720.3129212-3-kuniyu@google.com>
Subject: [PATCH v1 net 2/3] tcp: Drop any segments if DEFER_CONNECT is set.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Eric Dumazet <edumazet@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	"David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Yuchung Cheng <ycheng@google.com>, Wei Wang <weiwan@google.com>, 
	Matthieu Baerts <matttbe@kernel.org>, Mat Martineau <martineau@kernel.org>, 
	Geliang Tang <geliang@kernel.org>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	Chris Mason <mason@kernel.org>
Content-Type: text/plain; charset="UTF-8"

From: Chris Mason <mason@kernel.org>

TCP Fast Open lets a client send data in its SYN. With
TCP_FASTOPEN_CONNECT and a cached Fast Open cookie, which the server
sent in the SYN-ACK of an earlier connection, the connection is set up
in two steps:

- connect() sends nothing, so that the SYN can carry the data of the
  first write(). It only sets DEFER_CONNECT and inserts the socket into
  the hash table in SYN_SENT.
- The first write() calls tcp_connect(), which runs tcp_connect_init()
  and sends the SYN.

A socket must not accept any segment before it has sent its SYN. But
nothing on the receive path checks DEFER_CONNECT. So until the write(),
the half-initialised socket processes segments like any socket in
SYN_SENT, and a forged SYN is accepted.

Similarly, ICMP with seq matching ISN is accepted in the state.
Before commit 57889a8f6d49 ("tcp: initialize send sequence numbers
before deferring TFO"), even seq 0 message was accepted.

Drop any segments if DEFER_CONNECT is set.

Fixes: 19f6d3f3c842 ("net/tcp-fastopen: Add new API support")
Assisted-by: LLM
Signed-off-by: Chris Mason <mason@kernel.org>
[kuniyu: revised DEFER_CONNECT tests and the commit message]
Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/ipv4/tcp_input.c | 9 +++++++++
 net/ipv4/tcp_ipv4.c  | 2 +-
 net/ipv6/tcp_ipv6.c  | 2 +-
 3 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 3fd0e215324d..70326323411c 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -7252,6 +7252,15 @@ tcp_rcv_state_process(struct sock *sk, struct sk_buff *skb)
 		goto discard;
 
 	case TCP_SYN_SENT:
+		/* We sent nothing yet, so no segment belongs to this connection.
+		 * Send no RST: it would be built from this socket, whose TCP-AO
+		 * keys are not set up either.
+		 */
+		if (unlikely(inet_test_bit(DEFER_CONNECT, sk))) {
+			SKB_DR_SET(reason, NOT_SPECIFIED);
+			goto discard;
+		}
+
 		tp->rx_opt.saw_tstamp = 0;
 		tcp_mstamp_refresh(tp);
 		queued = tcp_rcv_synsent_state_process(sk, skb, th);
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 0dc3b087665d..861d669a3f1f 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -541,7 +541,7 @@ int tcp_v4_err(struct sk_buff *skb, u32 info)
 		if (!(type == ICMP_DEST_UNREACH && code == ICMP_FRAG_NEEDED))
 			__NET_INC_STATS(net, LINUX_MIB_LOCKDROPPEDICMPS);
 	}
-	if (sk->sk_state == TCP_CLOSE)
+	if (sk->sk_state == TCP_CLOSE || inet_test_bit(DEFER_CONNECT, sk))
 		goto out;
 
 	if (static_branch_unlikely(&ip4_min_ttl)) {
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index b1dec5d86d63..5c7ed38f1f56 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -449,7 +449,7 @@ static int tcp_v6_err(struct sk_buff *skb, struct inet6_skb_parm *opt,
 	if (sock_owned_by_user(sk) && type != ICMPV6_PKT_TOOBIG)
 		__NET_INC_STATS(net, LINUX_MIB_LOCKDROPPEDICMPS);
 
-	if (sk->sk_state == TCP_CLOSE)
+	if (sk->sk_state == TCP_CLOSE || inet_test_bit(DEFER_CONNECT, sk))
 		goto out;
 
 	if (static_branch_unlikely(&ip6_min_hopcount)) {
-- 
2.56.0.455.g6c5a503b38-goog

