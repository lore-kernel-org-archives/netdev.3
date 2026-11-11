Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794378248;
	b=IwCnxs0VEhjcOrSUq/DiKeaOP0ASs0fDfmoLrtMSZv0g3uvXRCXjULGOu6i8gNCEoyGc
	 mhtgKvvjypAi4kC5alpWlbXT71ZCcROKIG/Nfi/GAjd8uPEXiDnfLM8g4LEcQaTo4jfFt
	 41HB+MVn6xD6zK4NkaRIaG57FXiG6HOXpoWMFemJLeqEDc3NIiDOTKrgJT03Ki2Yk5u2p
	 pfNTs9uA8gI9LvLwYBtKjpKClnJt3+qj8rSACwn3pSR1Du/SzPYRqUQX/Hmt/6DDRbe85
	 VkdYxmAA3HtyQ2vFdWBi3+YqqKmW75eVQDA5sG7kTqPW7crzIsKT9jRHo0BAtQ7bK8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794378248;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:MIME-Version:Content-Type:Content-Disposition;
	bh=R+FczwnqI0GliMquKfs8JwIAtxzPEveUP/BeAfutYMQ=;
	b=g9YEwGJLfz7CgSwjbfpYp+gNeOWeH5OapEYTlG7anEAVaQjhFZlhSJczbpcVHoWH3C8m
	 uzC8nC+w0sDae/jTImoZdNC0McjC0f7ygtsKkoHt4qeHzpG4SX/WKz3UvmtIkGhlCWWl5
	 fHMtFPkiTU4SWcGEhi1i+kMCodtoY1c+m9caaLXbBRAoZ7wYfd71zWZ+/p+Y+WSqI9lre
	 VEJxfS2/C9vBdL3gVniQcTecpEDSAIph4WErIi1YBw+iSTJ5l1x07ZttLY/IUDeuSVS6/
	 4n7ie7pPMHm8Q+H0DlpXPAE+sAS1XOUlLFbuQLyGejsMYXfaKL/IRdHuzA/KZRfNtrw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0GlpYTiW;
	arc=none smtp.remote-ip=209.85.215.177
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C5E1606A331
	for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 06:24:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3C5E1606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0GlpYTiW
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-cdd9d0c9bbdso566501a12.1
        for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 22:24:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794378247; x=1794983047; darn=vger.kernel.org;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=R+FczwnqI0GliMquKfs8JwIAtxzPEveUP/BeAfutYMQ=;
        b=0GlpYTiWcFuOq5PgotHebECEIgigcDJBG4Y8ynqrJYkvjaqeeb9V7pYt4oKmr9Erib
         MpMBqnPMgmnObHYbvXIq2jbwuJ7x9OhA232zxH6fmCllvRGZlFvUEVxF+NQtVnVwOdgn
         0HXFm6HFNFBDkNuuHIy1FWqBC/0/r+1VTSWYRD50LV8TiJVzVwuE6UJ8NiOoZIxVkbrh
         M8SsBlECq2jB5q2eg8yj6HPcPg504aUIEx9ZpPnXjB4VvmxtFXEXpoIi1r6TZn3vT3om
         bXy4bpcNapyceEmzXzdTarZv2c1mAZH33T7hFSbA8RIlR0qEpo0skYDyy9sL+XmN08N6
         IkdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794378247; x=1794983047;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=R+FczwnqI0GliMquKfs8JwIAtxzPEveUP/BeAfutYMQ=;
        b=yqtpsQusNrV9D4owiJTFRFpB7NcxXtuPCYOnMtkdQg+XwI1+zebFzi05ksMzEGkbuq
         Ma+nZaC7JB0HoGK9uZ/L/IdmziZL7YjvknaBFYjkJj++GTBRTQTsiBXSZPBlPgKRFNbu
         uhpVgbN8/UHVpZGXDZcldk1BPLpICXMy5pkICe+32W87rQatS5GK/skYzCIqh1X53RkL
         ZjcFsVJ43eRy86mEPiXuXFFwyn41u1JUzz98QC2mlWoeyir57o1t4lAbDW5M6keUrDIf
         tR6Yj2CTiso0uAJzkPpVxTe6BF4PIUNYaWTYpDC/fIph3/T5MXLHMNM5iuGTnMbfjOf8
         cVXA==
X-Gm-Message-State: APuU4Z89cE4lYAmdeGzo2LnT8D4yuBAExFOIjwizIk4CptjF2AUP6lCa
	TlzUXbowEhPYAOQMN5hqy6YqjDmkN8I590NPP7eEjxlgxzwlWaaeakEl
X-Gm-Gg: AYBFou1fexD1HfmxEg2w4FmFDDFDBePOyX25Oe4O7vJCPZgGHZxflMdNJx5cmA3Tmz7
	I5dxQFDAGSHPOlO1jUqRzR0Egiz/Hb6N4QcPFf032LzE2ItFyGjrTy3MWSw67IcJ6ajs2moEHAk
	LnfjbKIWRo7HVpSIUI6eMQGpTRGxusns4bz6Z85L8PtBzRxn2UO6wWSxajs6sjo6Z1XutzB7yS5
	IU5pvNN40t79nDg5ekj37v8oKYBR7UXdMZUAW/l1K4Q4XTDPh+B0/urshXdLJ/UEFhzs0seR292
	VGbCpj3pwfkT2VFdaxcvaBB4dARY1AR8J2sGPKd3VRYkedwNHZAMs6gXr/9UlxT7u3KzXlUI0uG
	xYb47RIctGfIMfgin6wqb99iGGp7hJLnoScgc6DwALxmAP3ULJtZzVHLB5W+byd9rlAK8d4+CPr
	ncOp05jxglTLp0QSCe0t1M3NC+jOHLq7x8BXOjUw6JzDC74ddKm+MMPif/4oLfs5jT4oc5Wc15p
	iK+UMkvpzUAwxNQlhhJHBzS6vthB3mfqg/KxzHgf1JmHIv232807MkLOCsJToZ93bvZHm1FG+4a
	Yke+UqAl9RxoFZGB4v0BQMg8vWHG+bgiPO1x00/i1GZs25Xz
X-Received: by 2002:a17:90b:1d0b:b0:3b0:cc6f:1046 with SMTP id 98e67ed59e1d1-3b182f91db4mr1416852a91.67.1794378247529;
        Tue, 10 Nov 2026 22:24:07 -0800 (PST)
Received: from v4bel ([58.123.110.97])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b181fc804csm1154108a91.1.2026.11.10.22.24.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 22:24:07 -0800 (PST)
Date: Wed, 11 Nov 2026 15:24:03 +0900
From: Hyunwoo Kim <imv4bel@gmail.com>
To: Eric Dumazet <edumazet@kernel.org>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, imv4bel@gmail.com
Subject: [PATCH net v2] tcp: fix request_sock use-after-free during Fast Open
 accept()
Message-ID: <avQKA_YTAThtbsYU@v4bel>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Commit e3d95ad7da4f ("inet: avoid fastopen lock for regular accept()")
made inet_csk_accept() check tfo_listener before taking fastopenq.lock
to avoid taking the lock for connections that did not use Fast Open.

reqsk_fastopen_remove() clears tfo_listener while holding fastopenq.lock,
then reads req->sk. If inet_csk_accept() concurrently observes
tfo_listener after it has been cleared, it skips fastopenq.lock and
drops the last reference to the request_sock. This can free the
request_sock while reqsk_fastopen_remove() is still using it.

If the freed memory is reused for a new request_sock with req->sk ==
NULL, the reset path in reqsk_fastopen_remove() can append the new
request_sock to the original listener's list of requests that caused an
RST. After the new request_sock is freed, the next append writes through
the stale rskq_rst_tail into freed memory.

KASAN reported the following use-after-free when writing
fastopenq->rskq_rst_tail->dl_next = req:

  BUG: KASAN: slab-use-after-free in reqsk_fastopen_remove+0x142/0x210
  Write of size 8 at addr ffff888108230688 by task swapper/5/0
  ...
  Call Trace:
   <IRQ>
   ...
   reqsk_fastopen_remove+0x142/0x210
   tcp_check_req+0x96f/0xdd0
   ...
   tcp_rcv_state_process+0x19c/0x26b0
   ...
   tcp_v4_do_rcv+0x16e/0x490
   tcp_v4_rcv+0x14a0/0x1af0
   ...
   ip_protocol_deliver_rcu+0x39/0x1e0
   ip_local_deliver_finish+0x124/0x1e0
   ip_local_deliver+0xfb/0x1e0
   ...
   </IRQ>

To widen the race windows, mdelay(5) was added after newsk = req->sk,
mdelay(20) after the if (req) reqsk_put(req) block, and mdelay(100)
after tcp_rsk(req)->tfo_listener = false. The KASAN report above was
reproduced with this kernel.

For the lockless check, use tcp_sk(newsk)->syn_fastopen_child instead of
tfo_listener, which reqsk_fastopen_remove() clears.

syn_fastopen_child is a field of the Fast Open child TCP socket
referenced by newsk, not of the request_sock. It is set before the child
socket is added to the accept queue. The paths that call
reqsk_fastopen_remove() in response to a remote ACK or RST do not clear
this field.

inet_csk_accept() uses this field to take fastopenq.lock only for Fast
Open child sockets and rechecks tfo_listener while holding the lock.
Connections that did not use Fast Open continue to avoid the lock.

Fixes: e3d95ad7da4f ("inet: avoid fastopen lock for regular accept()")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
---
Changes in v2:
- Remove data_race(), !!, and the comment from the
  syn_fastopen_child check. (Kuniyuki)
- v1: https://lore.kernel.org/all/avFoNgJENLYu4t7X@v4bel/
---
 net/ipv4/inet_connection_sock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
index e56beec4387732..e364844f930bb1 100644
--- a/net/ipv4/inet_connection_sock.c
+++ b/net/ipv4/inet_connection_sock.c
@@ -683,7 +683,7 @@ struct sock *inet_csk_accept(struct sock *sk, struct proto_accept_arg *arg)
 	newsk = req->sk;
 
 	if (sk->sk_protocol == IPPROTO_TCP &&
-	    tcp_rsk(req)->tfo_listener) {
+	    tcp_sk(newsk)->syn_fastopen_child) {
 		spin_lock_bh(&queue->fastopenq.lock);
 		if (tcp_rsk(req)->tfo_listener) {
 			/* We are still waiting for the final ACK from 3WHS
-- 
2.43.0

