Received: from pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com [44.245.243.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A3F35DA4C;
	Sat, 25 Jul 2026 03:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.245.243.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784948951; cv=none; b=O89ZCz7QFhNnaggiKyMCdGCsSGy09ImFgQFVbnMNluDQkI7P6vMsju48NSRUi6wOZifhhWYn3IczAAYQFkxJhx3ZL1YJiHPLKJiryh40aRg7Y8y9V/pIAPNLNhFYiWKukFWTUhvSQwucLSh5QGM+sZTxj0ujDFNy0MQM+pjB+jA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784948951; c=relaxed/simple;
	bh=EdecioZBQGgjiicpcDV9vkEmtfCiqCmSCjU/N80BjBE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kxrF39bs+W2at9kaDfZEFdyuB4PyRu3Zqhs+HHvlvUMmf64javm2T65rIQLYoju4HbkzmJg3zxrk7QTjOHMAXM4h2zyqkzutLyWtukNJ7HFWh0qzkRIkQeOfGQYrlG3VsShcRgyLIGeREOrOHiy1nP1fL5W9JkegBD5pnoT9uGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=mEIX6csg; arc=none smtp.client-ip=44.245.243.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="mEIX6csg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1784948942; x=1816484942;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=4SHthpA2VdGO5hxR117d4YC51wSw6nerJD53gKA0yd4=;
  b=mEIX6csgEashErKiHbuMKv02eS/de4K02Qo0e0w/Huyojdn0joJLRhwJ
   x5Ot/gM3/542KkB59ZDM4BNLf6LF9iXyJx6fgnzwKzOAT8mQSVskyv2T4
   Gd7XVZvR1nrGntRHlBhjDo/1n0NXS6T/ruGFwkC3mVWkwIo3Du9uLdOr3
   KpOwMnq/8DxoOyCTtcPtNcjpImk3NcRtzcv0CgKNJ341hvm/XtZTGBg4O
   ICUJWAJxhQ4n/6Ywn4aVpIx8taWZVYoIKEIAnYtymDcy4OAWd6eB5F1SD
   fjtrNW4wA/g59HLgToVrdLUXK/4Wy0C7sOn8F2ziGN28Qw38Ds3eQCA4I
   Q==;
X-CSE-ConnectionGUID: /Fc253PlSLmh0b6EAfUudA==
X-CSE-MsgGUID: G/Fj5uZtQDOhIZPwzpBstw==
X-IronPort-AV: E=Sophos;i="6.25,183,1779148800"; 
   d="scan'208";a="23831622"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2026 03:09:00 +0000
Received: from EX19MTAUWA002.ant.amazon.com [205.251.233.178:5970]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.25.115:2525] with esmtp (Farcaster)
 id f004b53f-6603-4e90-aa5c-797f02c0926a; Sat, 25 Jul 2026 03:08:59 +0000 (UTC)
X-Farcaster-Flow-ID: f004b53f-6603-4e90-aa5c-797f02c0926a
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sat, 25 Jul 2026 03:08:59 +0000
Received: from 6c7e67c92ceb.amazon.com (10.106.101.50) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.45;
 Sat, 25 Jul 2026 03:08:58 +0000
From: Nathan Gao <zcgao@amazon.com>
To: Eric Dumazet <edumazet@google.com>, Neal Cardwell <ncardwell@google.com>
CC: Kuniyuki Iwashima <kuniyu@google.com>, "David S . Miller"
	<davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Nathan Gao
	<zcgao@amazon.com>
Subject: [PATCH net] tcp: do not change rcv_ssthresh in tcp_measure_rcv_mss()
Date: Fri, 24 Jul 2026 20:08:06 -0700
Message-ID: <20260725030806.28135-1-zcgao@amazon.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D036UWC001.ant.amazon.com (10.13.139.233) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

Commit f5da7c45188e ("tcp: adjust rcvq_space after updating scaling
ratio") replaced the direct window_clamp update in tcp_measure_rcv_mss()
with a call to tcp_set_window_clamp(), a helper that implements the
TCP_WINDOW_CLAMP setsockopt. As a side effect, the helper also shrinks
rcv_ssthresh via __tcp_adjust_rcv_ssthresh().

As a result, each scaling_ratio decrease detected by
tcp_measure_rcv_mss() also cuts rcv_ssthresh. Elsewhere in TCP,
rcv_ssthresh is usually cut under memory pressure and grows via
tcp_grow_window().

Flows whose segment sizes vary keep scaling_ratio oscillating, which
leads to an unstable rcv_ssthresh: a dip of rcv_ssthresh only recovers
via tcp_grow_window(), keeping the advertised window at a relatively
low level even after the ratio itself has recovered, and can even stall
the sender.

Observed on a customer's proxy gateway after upgrading from kernel 6.1
to 6.12: in the worst case, rcv_ssthresh was cut in half by a
scaling_ratio dip. P99 latency jumped from <10ms on 6.1 to ~100ms on
6.12, and almost returned to the 6.1 level with this patch applied.

Restore the plain WRITE_ONCE() update of window_clamp, as introduced
in commit a2cbb1603943 ("tcp: Update window clamping condition"), and
keep the rcvq_space.space adjustment. Now rcv_ssthresh is decoupled from
scaling_ratio changes in tcp_measure_rcv_mss().

Fixes: f5da7c45188e ("tcp: adjust rcvq_space after updating scaling ratio")
Signed-off-by: Nathan Gao <zcgao@amazon.com>
---
 net/ipv4/tcp_input.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index daff93d513428..5b6378b94701e 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -252,7 +252,7 @@ static void tcp_measure_rcv_mss(struct sock *sk, const struct sk_buff *skb)
 				struct tcp_sock *tp = tcp_sk(sk);
 
 				val = tcp_win_from_space(sk, sk->sk_rcvbuf);
-				tcp_set_window_clamp(sk, val);
+				WRITE_ONCE(tp->window_clamp, val);
 
 				if (tp->window_clamp < tp->rcvq_space.space)
 					tp->rcvq_space.space = tp->window_clamp;

base-commit: 78f75d632f74b8de0f081a128588f7c37d0d1164
-- 
2.47.3

