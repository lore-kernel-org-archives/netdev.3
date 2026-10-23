Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.238
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792738184;
	b=UOu7rNiTxEpFeJPpUOWUdEtTZ2DnVHfAyVdriZA5cvABThwE//HKwkAgf/sDofEdn1Do
	 7Ok71v9AXtp9tvXrI0y4hzv0FxAOqfUhG5PeRcAWwj2f8GMff8YS8h+jIwC8NqYmiYcQZ
	 drAczjDr44nDgchkN5MHVxNoWUvRHyvIQmZiLsS08jTEdHAzwc7s+JWeM7PnyaU5yv5Zg
	 wZ44TGd39st7UkD5kAbSzVTB/1spmQe9YCF5ta8Sp5DLIAj32vSi9GRaIXvp2nVqk1Xj7
	 QedRmQdLTVe1McH5puR+z0MJZn9tJrOyH3OEL1NfguF+rB+2qGj09Bkx4oTSJGoT/fw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792738184;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=F1jkepJV6D4IYWzKMRYLwEfXjsMVqYiT+GqybV1cN0A=;
	b=4nZNb8gOFE3NAKE0m26z6GSbnX0UMbLDXF5jZM/QoRWqCSuyLdysLTjrStRRc0nfu0r7
	 QJBkbGPPmg/wVmG+9G1MmG8ELWX6bN4ECJFWtEEm42rZlwmB8tYdDWB2tvQm4zUGO/PyG
	 E88KZly5A6PQxIsEuybbGjiaMFC7TlgnnDbPuFYaisYWmz/I+6JHCiVKBC4SjCotcziJu
	 0zsWFU6NS7Tj2kh7zbtFYuceuZLlPygrJrxIQCmNU1JczUPAZBWunTO6J/WAjYwKqoB02
	 SVkagscUjkWdVRTPB3qz6g0IliwksK4w4ofMsvYWqIhoTL4iby2LqJBDEH/R04dnN2Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=A43wxlSO;
	arc=none smtp.remote-ip=91.218.175.238
Received: from mta0.migadu.com (out-238.mta0.migadu.com [91.218.175.238])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6711960A2600
	for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 06:49:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6711960A2600
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=A43wxlSO
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=VAjNykZjTT6gqwES7Mcu47qQNEpm4JBfERhNe76LP/k=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792738181; v=1; x=1793342981;
 b=A43wxlSOSUWm8lOPLk/AepmkQCGS98GJ5w+cygYDWqU7pgR3ojILjHpNB8cpO8i9Au+f7yZt
 jOsqoVtviI9xTjA0jcBy/Z54jg+HV5jOVJU769pAkohrG2GRNQt170o+jPMHpm/6CtfRiugvyUv
 tWt+R7Mucm41b0XKYCOTBYic=
X-Envelope-To: netdev@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 0961cd37f23c6ab0;
	Fri, 23 Oct 2026 06:49:41 +0000
X-Mizu-Trace-ID: 0961cd37f23c6ab0
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
Subject: [PATCH net 2/2] tcp: fix shift-out-of-bounds in inet_csk_rto_backoff()
Date: Fri, 23 Oct 2026 14:49:11 +0800
Message-ID: <20261023064915.401112-2-jiayuan.chen@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261023064915.401112-1-jiayuan.chen@linux.dev>
References: <20261023064915.401112-1-jiayuan.chen@linux.dev>
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

icsk_backoff is bumped on every RTO and zero window probe, and the only
thing bounding it is tcp_retries2 (a u8 sysctl, 0..255).
inet_csk_rto_backoff() then uses it as a shift amount:

	u64 when = (u64)icsk->icsk_rto << icsk->icsk_backoff;

Set tcp_retries2 to 64 or more and keep the peer silent, icsk_backoff
climbs past 63 and the shift is UB. For example an ICMP host unreachable
arriving on such a socket goes through tcp_ld_RTO_revert():

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

The orphan check in tcp_probe_timer() calls the same helper.

tcp_probe0_when() got a similar clamp in 2020, but this helper was left
as is. Cap the shift at 32 like it was suggested back then: icsk_rto is
at least 1 jiffy, so 1 << 32 jiffies is already far above any max_when,
and the min_t() result is unchanged. Unlike an ilog2(RTO_MAX/RTO_MIN)
bound, 32 still holds when tcp_rto_min_us is lowered.

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

