Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F28844606D;
	Thu, 27 Aug 2026 11:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787831578; cv=none; b=WLVN3CsboUpBKYkbdcLQZrc3rJ/tbX5DNXACQCCmVCGR+K1HP+0SDiQmvuK6T28dv+mFYkX2oE2hTmfw3y7o3EMNEBRR7X0m6ZFCV0UYTTzsWwH7cHoSVaqf7ixpLbIkm5C1+sPP9PwvHNyUSuhCxFjV4TdPrvO5C6B/hTitCZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787831578; c=relaxed/simple;
	bh=wLfhtJbidDA/gsiOrfePKaFD/W8brBBgPdwwN7+m9G8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=oyBmlqks5yafGI16Yx1Vkz+iKQnHKV3rJsD22bMHz0ePm934o2yM03vrLChmT+QQBkseQ4pzAlDThJAmFJbt8EN2U/2ElWAmEcNJv9o3s4jpZL78nBi47r05goGgU432R8vlWvjijZtiQ4KHzImhwnBgk8lLlTjxEdOA5FN2TN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B7l7WKVV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B7l7WKVV"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9DE6EC19425;
	Thu, 27 Aug 2026 11:52:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1787831577;
	bh=wLfhtJbidDA/gsiOrfePKaFD/W8brBBgPdwwN7+m9G8=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=B7l7WKVVWStsLjEEch7bR5sbarYzbUJkk33+C8ETBczD27tS9rO5KAofx6b/r13zs
	 5EuYoV5GZqDf0YeZSxfgZ8Ad40CJQ/FTHwUN4CH+jM2oalHg/p4pHRZiWwVaObo69b
	 XYju01Quh00IjQc6HgBa0voaOftX/LoXOG6nEiuJbXQydmr/6D7M796wKEdZDnDnNS
	 9RJOWTeB5v9JyLGSrF83gSrdHe+8xcAPJ4ahMIvfRj2Hv70JY7ba5nLgN0zmqjzICq
	 L1oaHs6Eq0njMV5SPAYAI43pzPgLL5gQYy6EwJNwDEVyFTwPzCUTPdChZAAxZWZ5GV
	 XJOg9g4JyA0Lg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89D76C61DC2;
	Thu, 27 Aug 2026 11:52:57 +0000 (UTC)
From: Ramses de Norre via B4 Relay <devnull+ramses.well-founded.dev@kernel.org>
Date: Thu, 27 Aug 2026 13:52:56 +0200
Subject: [PATCH net] wireguard: queueing: preserve tstamp_type in
 wg_reset_packet()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260827-wg-tstamp-v1-1-4acfebb855ef@well-founded.dev>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWMzQqDMBAGX0W+cwNmiz/0VUoPMW51BVPJRlsQ3
 72xPc4wzA7lKKy4FTsib6LyChnspYAfXRjYSJ8ZVFJdtrYx78EkTW5eTHelpqXKEvUeuV8iP+X
 ze90ROOHxl7p2E/t0XnAcXx73bRhyAAAA
X-Change-ID: 20260817-wg-tstamp-b327825122dc
To: "Jason A. Donenfeld" <Jason@zx2c4.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Martin KaFai Lau <kafai@fb.com>
Cc: wireguard@lists.zx2c4.com, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Ramses de Norre <ramses@well-founded.dev>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787831576; l=2656;
 i=ramses@well-founded.dev; s=20260817; h=from:subject:message-id;
 bh=WGuiPvIeqUZ6TraJfQmCZ8rPDSP8532P5rIyXoxvRGI=;
 b=Gp5zWyXdujY/Zn8Q99qdy4u61/WREzVXqkjjg9LH0XlpiPw0K+sImzBcyS/Zw+L4bOCAJLCxr
 q3EkFWdJUutAN5I84XhRxOgYoY4rZsdXKQWzkRt84APQoOdYYQSLNX5
X-Developer-Key: i=ramses@well-founded.dev; a=ed25519;
 pk=1vBXHBVeJBMaC+2Zuonl0QQhEgGIQHERyF5RZNnrCmw=
X-Endpoint-Received: by B4 Relay for ramses@well-founded.dev/20260817 with
 auth_id=957
X-Original-From: Ramses de Norre <ramses@well-founded.dev>
Reply-To: ramses@well-founded.dev

From: Ramses de Norre <ramses@well-founded.dev>

Sending traffic through a wireguard tunnel on a host using the fq
qdisc fills the log with:

  fq: likely mono tstamp with tstamp_type 0

An skb carries a timestamp in skb->tstamp and, separately, a
skb->tstamp_type field recording which clock that timestamp came from.
The two have to agree.

When wireguard encapsulates a packet it calls wg_reset_packet(), which
clears the fields that must not leak from the inner packet into the
tunnel packet. It does so in two steps:

  skb_scrub_packet(skb, true);
  memset(&skb->headers, 0, sizeof(skb->headers));

skb_scrub_packet() deliberately keeps skb->tstamp when it holds a
monotonic timestamp: that value is the time the packet is scheduled to
be sent, and the qdisc still needs it. The memset then zeroes
skb->tstamp_type, because that field sits inside the headers group
while skb->tstamp does not. The packet therefore leaves wireguard
carrying a monotonic timestamp labelled as a realtime one.

Nothing noticed until commit c4f796c4f16b ("net_sched: sch_fq: convert
skb->tstamp if not monotonic"): fq used to assume every timestamp was
monotonic. It now consults tstamp_type, spots the mismatch, warns, and
falls back to treating the value as monotonic. Pacing still ends up
correct, so the log spam is the actual problem.

Save tstamp_type before the memset and restore it when encapsulating,
next to the hash fields that are already carried over this way. When
decapsulating it stays zeroed, which is right: an incoming packet's
timestamp is a realtime receive timestamp.

Fixes: de799101519a ("net: Add skb_clear_tstamp() to keep the mono delivery_time")
Signed-off-by: Ramses de Norre <ramses@well-founded.dev>
---
 drivers/net/wireguard/queueing.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireguard/queueing.h b/drivers/net/wireguard/queueing.h
index 79b6d70de236b..663b19b783953 100644
--- a/drivers/net/wireguard/queueing.h
+++ b/drivers/net/wireguard/queueing.h
@@ -78,12 +78,14 @@ static inline void wg_reset_packet(struct sk_buff *skb, bool encapsulating)
 	u8 l4_hash = skb->l4_hash;
 	u8 sw_hash = skb->sw_hash;
 	u32 hash = skb->hash;
+	u8 tstamp_type = skb->tstamp_type;
 	skb_scrub_packet(skb, true);
 	memset(&skb->headers, 0, sizeof(skb->headers));
 	if (encapsulating) {
 		skb->l4_hash = l4_hash;
 		skb->sw_hash = sw_hash;
 		skb->hash = hash;
+		skb->tstamp_type = tstamp_type;
 	}
 	skb->queue_mapping = 0;
 	skb->nohdr = 0;

---
base-commit: 24ef02f934eeb48830cff6b739abc3c62b1d107b
change-id: 20260817-wg-tstamp-b327825122dc

Best regards,
--  
Ramses de Norre <ramses@well-founded.dev>


