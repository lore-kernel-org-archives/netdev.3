Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793880540;
	b=pBdwyK+BxW4jerjDID2YNDvwP/5Ctcln+uvRhFC5t3sLqK3n5V2ONssAKXtdvJq/qXk+
	 43GaRoH3BmXmAX/IjnvntutroY91zk+/9a4H25KwrZdBa0NTwJh4NOKEPMPChDXC9Nfoz
	 r97R2x2etHedomxuc2QTnviq+iVdyJA9tEExzjicnxZMtINToRA5AUzXPRxleoXkdtz72
	 su03UARSqLC8Zy+aH8RTQ/L3d3cMEn8S+oUn6q32RS5IeVQkRLTTQ93skHwnoTB0wVGe5
	 2b6mZlb8SXRJkTd1rA8PGEOuWuSAgLk5q+tOjJkVY1b+6y5YSytKMFymf/n2Nbooh1Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793880540;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:MIME-Version:Content-Type:Content-Disposition;
	bh=M0ytVBeUGclJmwzuzyV3M0GWZr8TRkTqGUJG2CQhybc=;
	b=TPi8c81FQ3XwInkptL84K1ZK9J/j79ynN84r6gJUgjQL9xfTUZthfIjAI0cX503fWhmP
	 9o9XZ6UfFNNkDiR5evJo6YVrh13lUltUdNVz/gLV4PHxt0e2vYkvAXiG/Z1z/RVG6XYJp
	 NmBy7AyGc3D4Yx0fAIDlabEtqTDLXOUKGLB1EKkcASiHaOAoRHtUtTDonUHkh4l9uLZe8
	 YJYVbsUIe6MYb2wSKpgCEASqE8WyxtjZ0xK95/dMBb+o6Z4i/bjXBbBpQ3vuAqUyk1xMG
	 +NNMJL4O27wJLOgFLQYPZ6uzr2EoKjWB51X5tH7tEJYDRtzdC+PgMVJeGDtCRZPfCDA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JDLpjCEt;
	arc=none smtp.remote-ip=209.85.210.174
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACF96606A329
	for <netdev@vger.kernel.org>; Thu,  5 Nov 2026 12:08:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ACF96606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JDLpjCEt
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-8a070755c8cso995262b3a.0
        for <netdev@vger.kernel.org>; Thu, 05 Nov 2026 04:08:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793880539; x=1794485339; darn=vger.kernel.org;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=M0ytVBeUGclJmwzuzyV3M0GWZr8TRkTqGUJG2CQhybc=;
        b=JDLpjCEtB/Qk7gNp/3z1xD5/1O7b+6o7SpiRyiOAG7qgFXTPYFGK4Rs7qikiEDmDZS
         3CXSfsDfxAznrMWp+uMcCE7WT1BvYXneTbdVZFmQIdsrXDuCuyoPtLuuoJqYS3kR/Iv9
         YXwpJrOFbNgsjkE3Q1QJfNV3MSEQ99GGaCGeOvyn1xugiD23giX0jt4EfzS1bQWbM6oQ
         cDDgiKLOpTBtuKCKDAWdWpp8Z3F+jxTMrMM10Hd95fl20ZHDAYH7c3UOf7b9Yj64k+NA
         062YD2W5qLBJgb0JjC02C1G83hjo2QqytDewXLJenQ9vbGCEoN/P+lPx3++nANRDZLJC
         KU2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793880539; x=1794485339;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=M0ytVBeUGclJmwzuzyV3M0GWZr8TRkTqGUJG2CQhybc=;
        b=dP5C2TbWdsprAISTggmm055YEAjJxGJpDwG9V8sEN7dLVbKiP6U2Y5m6tua0wH+utd
         W6AKa0F8BgYkdHhgNAdZJOf094h3rRKdNMlmzlCMAOEeM0tCV6KSd8ZYpxFjtdfSDp4K
         z8oK7Pd+Yt3eiFMcTp3orptJhSVU2SexsvxK4De5jPzhn9FtiDAcKfWv4jl3CqumRWBx
         U2z0flGX7wTEzRUQKPZDvyQyQAhloQGlKJWq5AOyAzCeHgT7xNECGIP0rViXCKpcHsuR
         DOleUCMYQgCsoh1S+CeIg/Scs+ESibnAvlFlgdoOIfPg1wge8RmDuZzCY04R2hz6cBND
         5jGA==
X-Gm-Message-State: APuU4Z8FYkz3NHWOgaFPIoJ8XztwQMjhLN6ugMtimfas2G94bYc4yndS
	tDgqeRNF82+4/TbXD8LIdWQKDPy/5yt6yn1DZriTzU7A1PQTxGi5kwOfZA0U6g==
X-Gm-Gg: AYBFou15QCyVCreAesx2WdXkcunsdSfohOQJ4MZfdIf5EZLHQ3WXooi+LwLA6ZzJorB
	N9RxnHbZsmmKO0YL+wXLWf+vNLOvVBjeUds8zQmLQK+iYOjMsRGpKyVSrrU6rLIZEb8M6Dek5EA
	au4KvHhVPbr6PLmpkJTYHQn4BdHc+50k++qXSP5Q9VaGPT5ZIpKKZojQ8GtNa2ciXG+Lt/YdbKS
	pwhid8oJQVpdNRJ2cDsMXX7GEDR+9ilc6H/UDfX24cNOTAydbUVoFV8mc67jKuHJMyPtm9iaes4
	roPHfNJOePjfAGnurhLYt3kS/4bZMue/y4sQq9tIo3QkQXTIDpaxJLOrPgac8jk5A4Nv4plmf7r
	DTI5hxWutLwHBvChO12GrW4QIwGtJEM+S8noHvUkEbTwCZ77HL18r8jtOHbShLCLP+EUPt0W47O
	G9SqSSwvDOmTdkFPf2K8iPN9AAbL8b4dhDBZF72mXVaFU+BzsDlsYbhw05+X7KqZLUhsnsjoEQD
	lromRWruLP62qI/6W6+Uw8pf6TnD5ML19s/6m60jPC8fx+1NJes6CllE1r7gV8vXpHDrenOzxBc
	2G6zrFo7SVS5E684RlbFH1VtASOGaMDaponqf7Vhhm99a3s=
X-Received: by 2002:aa7:9a1c:0:b0:848:77b3:579a with SMTP id d2e1a72fcca58-8aafd55957cmr9746913b3a.17.1793880538972;
        Thu, 05 Nov 2026 04:08:58 -0800 (PST)
Received: from v4bel ([58.123.110.97])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8b2af055657sm348308b3a.13.2026.11.05.04.08.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 04:08:57 -0800 (PST)
Date: Thu, 5 Nov 2026 21:08:53 +0900
From: Hyunwoo Kim <imv4bel@gmail.com>
To: Eric Dumazet <edumazet@kernel.org>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, john.fastabend@gmail.com,
	sd@queasysnail.net
Cc: netdev@vger.kernel.org, imv4bel@gmail.com
Subject: [PATCH net] tcp: do not coalesce segments after FIN
Message-ID: <auxx1bK0QJfUvcB7@v4bel>
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

In tcp_ooo_try_coalesce() and tcp_add_backlog(), skip coalescing when
the destination skb already carries FIN. This still allows a FIN
segment to be coalesced into an skb without FIN when the other
coalescing checks pass.

Fixes: e93a0435f809 ("tcp: allow segment with FIN in tcp_try_coalesce()")
Fixes: 4f693b55c3d2 ("tcp: implement coalescing on backlog queue")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
---
 net/ipv4/tcp_input.c | 3 ++-
 net/ipv4/tcp_ipv4.c  | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index e1f2d9765f810..1f9f86028da73 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -5314,7 +5314,8 @@ static bool tcp_ooo_try_coalesce(struct sock *sk,
 			     struct sk_buff *from,
 			     bool *fragstolen)
 {
-	bool res = tcp_try_coalesce(sk, to, from, fragstolen);
+	bool res = !(TCP_SKB_CB(to)->tcp_flags & TCPHDR_FIN) &&
+		   tcp_try_coalesce(sk, to, from, fragstolen);
 
 	/* In case tcp_drop_reason() is called later, update to->gso_segs */
 	if (res) {
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index a7f9242f1e429..ef01768292fbc 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -1949,6 +1949,7 @@ enum skb_drop_reason tcp_add_backlog(struct sock *sk, struct sk_buff *skb)
 	thtail = (struct tcphdr *)tail->data;
 
 	if (TCP_SKB_CB(tail)->end_seq != TCP_SKB_CB(skb)->seq ||
+	    (TCP_SKB_CB(tail)->tcp_flags & TCPHDR_FIN) ||
 	    TCP_SKB_CB(tail)->ip_dsfield != TCP_SKB_CB(skb)->ip_dsfield ||
 	    ((TCP_SKB_CB(tail)->tcp_flags |
 	      TCP_SKB_CB(skb)->tcp_flags) & (TCPHDR_SYN | TCPHDR_RST | TCPHDR_URG)) ||
-- 
2.43.0

