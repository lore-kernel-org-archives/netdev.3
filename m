Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.203
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793017987;
	b=HB81VjpiQaXpKfbJsCoWkmQX53EADdN6m93GLvelnIr6fI+RwKJupiWRe7CrPe47zv/y
	 /VvAyeZ0zVXkB4fPJ+M9zmVBzFN1zegJSz6OCEwuuZimUMUb9AmMRgvv85gUrwHYHbEPH
	 UIT6lAyrCw4WYq8UbF62RQgyyTRlUrgDqLW7vBX09qs3yA4WOSvmsQr89jEJeev10SZyX
	 bf9OmBh6zy9DLEiRcreJTs396ogawLi8QFbtTkDn1sgDDiNdey0aWjDnFLE9yV8v/ka4E
	 YV3n/sMwSG7dT1CAKwFvJKJ2t4lDiyYvrzm+OiZhyZE8EV6eTzXT0MkDIpFRoV0K63Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793017987;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=7mgiolJC8r3eZzy98FWtx4U1AHXNmN+96u0Ij+bgNDQ=;
	b=h98R1PdM0XSHw78YEZsSvuNLCk4I8Ou7z9amoAuJhLB/QU4x6lDHXLIbKCxmsK8HjOUT
	 sf0fMRZgSTggEUSRrRRGiPEuLGEOji5V6UZvvNmKEgUbVYZsrOtfOLmpRQpsRD8isDrW0
	 AQ/dlxeXm5RWPWbt5ewihDfdfVWRSIuzJ4QQquMQ05UUIyaAlLHj/ZnO96Hfs44hfX/Jc
	 rGt9yjc6igfXnkDh1J7aOa/sCGIIDBajLa6V6Bx+EJQx0K988unt3gz6NrLA+oFy6ZQLx
	 /0kJQMDavgw9UR4EREp00nNCd9nIX4tfKeLrHz8zUiRVFmULyIAmpKdlUM+0sPo1NHw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=LKMYI4Q7;
	arc=none smtp.remote-ip=91.218.175.203
Received: from mta0.migadu.com (out-203.mta0.migadu.com [91.218.175.203])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94552606A32A
	for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 12:33:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 94552606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=LKMYI4Q7
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=9lM8ZmCt5oSDpMBB/mA6pb9f0mkJCYo0DmDEVHVew+A=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793017984; v=1; x=1793622784;
 b=LKMYI4Q73DkLwaO5yZpDGyBOgkU0E6i5edhX5Kc5KhSspTNV6Q1Ek9mREno+zN26UB1KtwyC
 EncgqdceAOagH0G821GpGVsFq5msIy/Ei0opQHiVvRf0zfH2CAD3hbCNZvOVVpIQDJrjuXWn3K9
 LmP6BruKJc0XNfqW2Y+A2FF4=
X-Envelope-To: netdev@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id ba99167e89fbca0f;
	Mon, 26 Oct 2026 12:33:04 +0000
X-Mizu-Trace-ID: ba99167e89fbca0f
X-Migadu-Flow: FLOW_OUT
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: netdev@vger.kernel.org
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>,
	stable@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v2 2/2] tcp: fix shift-out-of-bounds in inet_csk_rto_backoff()
Date: Mon, 26 Oct 2026 20:32:39 +0800
Message-ID: <20261026123244.239766-2-jiayuan.chen@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261026123244.239766-1-jiayuan.chen@linux.dev>
References: <20261026123244.239766-1-jiayuan.chen@linux.dev>
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

icsk_backoff is incremented by tcp_retransmit_timer() on every backed-off
RTO with no cap of its own, and by tcp_send_probe0() up to tcp_retries2.
It is used as a shift amount in inet_csk_rto_backoff():

	u64 when = (u64)icsk->icsk_rto << icsk->icsk_backoff;

Once it climbs past 63 the shift is UB. Seen with tcp_retries2=255 and a
silent peer, when an ICMP host unreachable goes through
tcp_ld_RTO_revert():

  UBSAN: shift-out-of-bounds in ./include/net/inet_connection_sock.h:258:40
  shift exponent 73 is too large for 64-bit type 'long long unsigned int'
  Call Trace:
   <IRQ>
   dump_stack_lvl+0xc1/0xf0
   dump_stack+0x10/0x20
   __ubsan_handle_shift_out_of_bounds+0x1d1/0x390
   tcp_ld_RTO_revert.cold+0x16/0x92
   tcp_v4_err+0xdb3/0x13e0
   icmp_socket_deliver+0x1a7/0x390
   icmp_unreach+0x2dd/0xe50
   icmp_rcv+0x93e/0xe30
   ip_protocol_deliver_rcu+0x36b/0x3e0
   ip_local_deliver_finish+0x37d/0x620
   ip_local_deliver+0x165/0x1d0
   ip_rcv+0x284/0x320
   __netif_receive_skb_one_core+0x16b/0x1c0
   __netif_receive_skb+0x21/0x150
   process_backlog+0x37e/0x1200
   __napi_poll.constprop.0+0xa5/0x5e0
   net_rx_action+0x4c0/0xf70
   handle_softirqs+0x204/0x9b0
   __irq_exit_rcu+0x13c/0x220
   irq_exit_rcu+0xe/0x20
   sysvec_apic_timer_interrupt+0x92/0xd0
   </IRQ>

The orphan check in tcp_probe_timer() calls the same helper. On x86-64
the oversized shift count is taken modulo 64, so an orphan that should
be dead can be seen as alive, and tcp_ld_RTO_revert() can end up with a
smaller RTO than intended.

Cap the shift at 32: any non-zero icsk_rto << 32 exceeds TCP_RTO_MAX, so
the min_t() result is what the unbounded math would give. The
ilog2(TCP_RTO_MAX / TCP_RTO_MIN) + 1 bound of tcp_probe0_when() does not
fit here, as icsk_rto has no TCP_RTO_MIN floor the way tcp_probe0_base()
has.

Fixes: fcdd1cf4dd63 ("tcp: avoid possible arithmetic overflows")
Cc: stable@vger.kernel.org
Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
---
 include/net/inet_connection_sock.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/net/inet_connection_sock.h b/include/net/inet_connection_sock.h
index 903499581db7..562e12033a5d 100644
--- a/include/net/inet_connection_sock.h
+++ b/include/net/inet_connection_sock.h
@@ -255,9 +255,10 @@ static inline unsigned long
 inet_csk_rto_backoff(const struct inet_connection_sock *icsk,
 		     unsigned long max_when)
 {
-        u64 when = (u64)icsk->icsk_rto << icsk->icsk_backoff;
+	u8 backoff = min_t(u8, 32U, icsk->icsk_backoff);
+	u64 when = (u64)icsk->icsk_rto << backoff;
 
-        return (unsigned long)min_t(u64, when, max_when);
+	return (unsigned long)min_t(u64, when, max_when);
 }
 
 struct sock *inet_csk_accept(struct sock *sk, struct proto_accept_arg *arg);
-- 
2.43.0

