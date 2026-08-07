Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D754E32B9A1
	for <netdev@vger.kernel.org>; Fri,  7 Aug 2026 01:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786067130; cv=none; b=lDsyOerkqja8lPHMEpcB5IrmYvaO0ercdY9nB47khrh+o/9/Y90Wsd4GB1+FKdtNm0Yq6kJKXgZ4FIt8dlE1P2it393cB+P/wQRVNDttlKmBmXTIV5++a5iXseRfm9T5KMEz0rYjBAa71CcrP4CliDVaS6Ct5RX6X9kpMgVhCK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786067130; c=relaxed/simple;
	bh=M1XjDIffT0FTcOD82kwXmuuqPwDoN2YGqSyC21R3u9s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lnSrVUm9y0QSzqLTugUB5l+NPH5davXTFiIkpYjN2/26nqPf03GsWoDfnuX941XPaXKzp8gn0bCYf4GxKSMuw5Cju7MUfhYSYeVspwCFBbf4XetPGx8k1hr6IGHmjq0h3JPoeBnGpMWRwUWQPIPgkn69vyGh07EyzDCwufeXBRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=EHWPNjG0; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="EHWPNjG0"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1786067121;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=8jlX+IfD+2MCo+MyUvVlXIriPQzZHfLSuI3PIRWAQ8A=;
	b=EHWPNjG0rfu7V9oGARGPNeXuTgLsK1aY/mFm4L6oroEqc71cyQtQOr7Wf0FPEZ91jRqdNA
	DqwIlhAErRVQLCbnZLKId78LLYcwApAvSrA9AHOe/VnHD8wR/vpWAdtg6v/hLiBRkNF0Nh
	7ipAD6tWWitUvehf9Dx5ox7JQ2rijGE=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: netdev@vger.kernel.org
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>,
	Eric Dumazet <edumazet@google.com>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	David Morley <morleyd@google.com>,
	Yuchung Cheng <ycheng@google.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] tcp: fix icsk_ack.ato bitfield overflow
Date: Fri,  7 Aug 2026 09:44:36 +0800
Message-ID: <20260807014437.36687-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On cross-region connections we observed delayed ACKs suddenly turning
into immediate ACKs plus a TCP_MAX_QUICKACKS burst, as if the
connection had just received its first data segment.

Commit 95b9a87c6a6b ("tcp: record last received ipv6 flowlabel")
squeezed icsk_ack.ato into 8 bits, sized for TCP_DELACK_MAX. But both
writers still bound ato by icsk_rto, which can be well above 255
jiffies, so the bitfield assignment silently wraps mod 256: repeated
delack timer misses double ato up to icsk_rto, storing 320 as 64 and
256 as 0, and ato == 0 is the "first data packet" sentinel in
tcp_event_data_recv().

Clamp both writers to TCP_DELACK_MAX, which the static_assert already
guarantees to fit and tcp_send_delayed_ack() effectively caps ato at
anyway.

Fixes: 95b9a87c6a6b ("tcp: record last received ipv6 flowlabel")
Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
---
 net/ipv4/tcp_input.c | 6 +++---
 net/ipv4/tcp_timer.c | 4 +++-
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index daff93d51342..c0d2d3c0d40a 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -1039,9 +1039,9 @@ static void tcp_event_data_recv(struct sock *sk, struct sk_buff *skb)
 			/* The fastest case is the first. */
 			icsk->icsk_ack.ato = (icsk->icsk_ack.ato >> 1) + TCP_ATO_MIN / 2;
 		} else if (m < icsk->icsk_ack.ato) {
-			icsk->icsk_ack.ato = (icsk->icsk_ack.ato >> 1) + m;
-			if (icsk->icsk_ack.ato > icsk->icsk_rto)
-				icsk->icsk_ack.ato = icsk->icsk_rto;
+			icsk->icsk_ack.ato = min3((icsk->icsk_ack.ato >> 1) + (u32)m,
+						  icsk->icsk_rto,
+						  (u32)TCP_DELACK_MAX);
 		} else if (m > icsk->icsk_rto) {
 			/* Too long gap. Apparently sender failed to
 			 * restart window, so that we send ACKs quickly.
diff --git a/net/ipv4/tcp_timer.c b/net/ipv4/tcp_timer.c
index f7215d53bbda..1038e7ba9c2e 100644
--- a/net/ipv4/tcp_timer.c
+++ b/net/ipv4/tcp_timer.c
@@ -334,7 +334,9 @@ void tcp_delack_timer_handler(struct sock *sk)
 	if (inet_csk_ack_scheduled(sk)) {
 		if (!inet_csk_in_pingpong_mode(sk)) {
 			/* Delayed ACK missed: inflate ATO. */
-			icsk->icsk_ack.ato = min_t(u32, icsk->icsk_ack.ato << 1, icsk->icsk_rto);
+			icsk->icsk_ack.ato = min3((u32)icsk->icsk_ack.ato << 1,
+						  icsk->icsk_rto,
+						  (u32)TCP_DELACK_MAX);
 		} else {
 			/* Delayed ACK missed: leave pingpong mode and
 			 * deflate ATO.
-- 
2.43.0

