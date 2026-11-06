Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793967926;
	b=xfJkvxVbXs59gHQ1wPOt1ZmuGkIybUtxddweqFp7Sm7JaWLadcMEoYei8q+9yrGq8N+n
	 e1MZseexZHa1e8Mp5mZndP+JUWkyEwnNSu2EFlsVaBvHgipw0vpY44qYtQQs2kCcsh2G6
	 R92trGmWrzUUzvoxCTiLV8d9KrEgjQwrfWVJx3LL7DxMmIzvmyhlz54nc+VBfxPAyskd8
	 leW+Dz6+0qhujNMc6RI8kUledCajv16Z0vQ5puAkTvb1GQxqsHTIep8qAJkIDbpmRqW/F
	 VAx7QzwdpAst6f/ItS5qlkGGP0rXAcF18ZKzJNUWCb2fUI338oZR8y0yc86T9qrve4w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793967926;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:MIME-Version:Content-Type:Content-Disposition;
	bh=jdeq7OEaVAoiCrHRA9SZExAgah8LRWZ6NagErzJomvU=;
	b=PAYmqL1zi1kea6R/O9tkh0SApN2dnF/q/NQ+TtIte2MnOWFV2CqVAfyO/vI4yz3LzOTO
	 mImORRWlT+iPMhl5FI/b04yug/88GtR//WXXzopHq0WPi2OkBuQuj4en/YXxLK4p+G20c
	 c0u+0ZK8r5+fEw6tB1WfMbj/vj7vODE+7GIiYT1Y7iPIlqpZTa3CFVME2PLkEne3DLFqd
	 w+UQW13JxKO88fntUu74W+w0IV4XZDGI1wUmVzDDbh/U5Fnlgf6t1J0uPoqgNmkqEPvkI
	 ZST5mhEAC34plHgZRAraQzJz3qNKDPl+UevX46EshF2FtGSjznYi30RWmtDE3ah8pjQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LyMEqzpI;
	arc=none smtp.remote-ip=209.85.215.182
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C239606A326
	for <netdev@vger.kernel.org>; Fri,  6 Nov 2026 12:25:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5C239606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LyMEqzpI
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-cd3310348d2so769215a12.1
        for <netdev@vger.kernel.org>; Fri, 06 Nov 2026 04:25:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793967926; x=1794572726; darn=vger.kernel.org;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jdeq7OEaVAoiCrHRA9SZExAgah8LRWZ6NagErzJomvU=;
        b=LyMEqzpIawAi63+/VRb2nOZIFVtuE4Q23X4omvDtvlJNfxkt5kFPBzgYql1VQckFqM
         qjz9gXdT9hytM0ilw8OGLkpx50RbkYtubE9On95cIT0YTC8B0XhubQjGy3GayW4zrE4g
         l1bC8NhVj6jMRXsCP3eeUG3tMNdWupoTtWSdMWybP4kyaH3P6gi8v/F39f2O0+QyFmOT
         GPwlCHmGnDxVNmvTevqf7oM6/m31PE1jmpLf96O74ETC6gLgqKeCre76gpBoLexsPGyG
         G7mqgCxhZzvbml/9lSWJrZWJjo9I3JeS7C1IK8QPv+IQ5z+Y8wOx/rSkUlIKMgEFRYz+
         nmzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793967926; x=1794572726;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jdeq7OEaVAoiCrHRA9SZExAgah8LRWZ6NagErzJomvU=;
        b=f8CE+Z+3KvJcPY89RNF7KLTqnn3v/H3Jo5JEvGIrQacYCgRgdrqdcE7aJ5lC8gg1Ni
         wyJUNeKfVIYYVI20tA2bW88JZOAvz2yao7B0ihPY32dRTJS+Ps0Up2IOuCXywXSGvcZA
         HMY02TXmVBGxamFiNblS4gnLsi9pOJsoon43Arrc7PQeIqT3bfYLbfRNRQA6syDG5Dfj
         UFzVJtdsJSX3zK/4px0RarMl2R7dWSpVi7dQEO1e7v/x572D6QKmuFTti2mYRb0UPnJg
         mM/SpKtnmrIzoTCdYx2lQc5BY9tIyAzAC7lLKeuwwSKwZngJ8k2djz2NPnpgtJyENLOm
         A7Zw==
X-Gm-Message-State: APuU4Z99rafJehfDMTFvsg0AxNmKuix4+JxVezUf6nXBe2WF/241vh4f
	Iy3zgknH3OG4hAyE+QCE58ANDxLg4MgozJ1muNR9XhTHQYn7xBO0xfYz
X-Gm-Gg: AYBFou3nRdQ0PfdQftyHe9G75YDFlOk9sIiz2rIjPdAqF85sihb/WiTCWdYvw68GS/m
	RodBQf464p3H3KzRkVwe64vGhxfa90miGFiRnowb5q7NyLbhOmZf4RJ1I8BCIA4K7XpjDluK4Bv
	t2FfebNRsi115qK+1iIuxkf0qx8OTWcylo5GhFKL3Vw1bg5bojuQNdXtRcaKeAy6VOAwU63iUkn
	088BJq3kkBVm4COqHYng+5iGe+Xt/CC55LhVkNLW3EKEo/U9Kz1zsIyCxEO9H6vALYs2Y+uvtwb
	dvBFWcfyYbSRpQgazbqMpVjj2zeGXnEOQ+tCIV+S34TW8j4gbpo9TGwrZwtb0ag8hzO9ch07oVc
	ds0s5eTE47nc/EJWZVYpuZIXLh/37EKi0oNjChK3Yr45xiCJBrCC9pTpmcqUPyYNn+r6Z0HvUfK
	5bq2z43hSANRRol6HUwKm6nyWwTuYLZnK99K4fWgkZLPKAfpV2AKCOx+ClC8BKmLbNY9ALHetrH
	syWP7qhAIORRPRkAEhKttFV+UQ75eNQ/j1Ep4SC0RQaRQgL2vonpb3kAhtPgzhIJHAHdrpr4FQh
	vqsDVFP98E+vk9n6crZq0UYUj6PpX0v4U34nV4y7zljHhno=
X-Received: by 2002:a17:90b:2e4f:b0:3ac:9ed8:f301 with SMTP id 98e67ed59e1d1-3b0db6f9073mr1421712a91.30.1793967925452;
        Fri, 06 Nov 2026 04:25:25 -0800 (PST)
Received: from v4bel ([58.123.110.97])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b0e4b26725sm857198a91.4.2026.11.06.04.25.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 04:25:25 -0800 (PST)
Date: Fri, 6 Nov 2026 21:25:21 +0900
From: Hyunwoo Kim <imv4bel@gmail.com>
To: Eric Dumazet <edumazet@kernel.org>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, john.fastabend@gmail.com,
	sd@queasysnail.net
Cc: netdev@vger.kernel.org, imv4bel@gmail.com
Subject: [PATCH net v2] tcp: do not coalesce segments after FIN
Message-ID: <au3HMfqNW3_DRMqS@v4bel>
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

A FIN consumes a sequence number. If another FIN segment is coalesced
into an skb that already carries FIN, end_seq advances to account for
the additional FIN, but tcp_flags still contains only one FIN bit.

When the preceding gap is filled and tcp_ofo_queue() processes the
coalesced skb, rcv_nxt advances to the skb's end_seq. When the receive
path consumes all data in the skb, copied_seq advances by the data
length and one sequence number for FIN. If three or more FIN segments
have been coalesced into one skb, tcp_inq() can still return a positive
value after the receive queue becomes empty and the SOCK_DONE adjustment
is applied.

TCP_ZEROCOPY_RECEIVE is another consumer affected by this state.
tcp_zerocopy_receive() takes its length from tcp_inq() and follows
skb->next without checking for the end of the receive queue.

Software kTLS receive is one consumer affected by this state. When
strp->copy_mode is false, tls_strp_msg_consume() calls the TCP helper
tcp_read_done() to consume the current TLS record. In the reproducer,
tcp_read_done() consumed the record data and one FIN before freeing the
receive skb.

When kTLS looked for the next record, tcp_inq() reported at least
TLS_HEADER_SIZE bytes even though the receive queue was empty.
tcp_recv_skb() returned NULL, so tls_strp_load_anchor_with_queue() hit
WARN_ON_ONCE() and returned without updating the anchor.

Since tcp_inq() had reported at least TLS_HEADER_SIZE,
tls_strp_read_sock() proceeded to tls_strp_check_queue_ok().
skb_shinfo(strp->anchor)->frag_list still pointed to the freed receive
skb. tls_strp_check_queue_ok() then read TCP_SKB_CB(first)->seq through
the stale pointer, causing a use-after-free.

The reproducer followed this call path:

  tls_rx_rec_done()
    tls_strp_msg_consume()
      tcp_read_done()                       // frees the receive skb
    tls_strp_check_rcv()
      tls_strp_read_sock()
        tls_strp_load_anchor_with_queue()   // returns after WARN_ON_ONCE()
          tcp_recv_skb() == NULL
        tls_strp_check_queue_ok()
          TCP_SKB_CB(first)->seq            // reads the freed receive skb

KASAN reported:

  BUG: KASAN: slab-use-after-free in tls_strp_check_queue_ok.isra.0+0x5f/0x100
  Read of size 4 at addr ffff888103169ca8 by task ktls-server/71
  ...
  Call Trace:
   <TASK>
   ...
   tls_strp_check_queue_ok.isra.0+0x5f/0x100
   tls_strp_check_rcv+0x2a9/0x400
   ...
   tls_sw_recvmsg+0x3ce/0xa10
   ...
   sock_recvmsg+0xea/0x100
   __sys_recvfrom+0x142/0x1f0
   ...
   __x64_sys_recvfrom+0x76/0x90
   do_syscall_64+0xdd/0x4a0
   entry_SYSCALL_64_after_hwframe+0x77/0x7f
   ...
   </TASK>
  ...
  Freed by task 71:
   ...
   napi_skb_cache_put+0x24/0xf0
   skb_attempt_defer_free+0x183/0x3b0
   tcp_read_done+0x2d4/0x340
   tls_strp_msg_consume+0x45/0x80
   tls_sw_recvmsg+0x3c4/0xa10
   ...

In tcp_try_coalesce(), skip coalescing when the destination skb already
carries FIN. tcp_add_backlog() calls skb_try_coalesce() directly instead
of using this helper, so add the same check there. Since both paths check
only the destination skb, a final segment carrying data and FIN can still
be coalesced into an skb without FIN when the other coalescing checks pass.

Fixes: e93a0435f809 ("tcp: allow segment with FIN in tcp_try_coalesce()")
Fixes: 4f693b55c3d2 ("tcp: implement coalescing on backlog queue")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
---
Changes in v2:
- Mention TCP_ZEROCOPY_RECEIVE as another affected path in the changelog.
  (Eric)
- Move the FIN check from tcp_ooo_try_coalesce() to tcp_try_coalesce(),
  after the existing checks and before skb_try_coalesce(), using unlikely().
  (Eric)
- Move the tcp_add_backlog() FIN check after the other tcp_flags checks
  and add a short comment. (Eric)
v1: https://lore.kernel.org/all/auxx1bK0QJfUvcB7@v4bel/
---
 net/ipv4/tcp_input.c | 4 ++++
 net/ipv4/tcp_ipv4.c  | 2 ++
 2 files changed, 6 insertions(+)

diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index e1f2d9765f810..1e25db7e4514d 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -5290,6 +5290,10 @@ static bool tcp_try_coalesce(struct sock *sk,
 	if (!tcp_skb_can_collapse_rx(to, from))
 		return false;
 
+	/* Nothing follows a FIN. */
+	if (unlikely(TCP_SKB_CB(to)->tcp_flags & TCPHDR_FIN))
+		return false;
+
 	if (!skb_try_coalesce(to, from, fragstolen, &delta))
 		return false;
 
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index a7f9242f1e429..661c9f94f9c07 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -1957,6 +1957,8 @@ enum skb_drop_reason tcp_add_backlog(struct sock *sk, struct sk_buff *skb)
 	    ((TCP_SKB_CB(tail)->tcp_flags ^
 	      TCP_SKB_CB(skb)->tcp_flags) &
 	     (TCPHDR_ECE | TCPHDR_CWR | TCPHDR_AE)) ||
+	    /* Nothing follows a FIN, see tcp_try_coalesce() */
+	    (TCP_SKB_CB(tail)->tcp_flags & TCPHDR_FIN) ||
 	    !tcp_skb_can_collapse_rx(tail, skb) ||
 	    thtail->doff != th->doff ||
 	    memcmp(thtail + 1, th + 1, hdrlen - sizeof(*th)) ||
-- 
2.43.0

