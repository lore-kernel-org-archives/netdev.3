Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2003E21ABAA
	for <netdev@vger.kernel.org>; Sat,  3 Oct 2026 15:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791041568; cv=none; b=Bi3r1hj6BJOtnohaCBx7eCR1vHSv40RMeJQRjKNxlKbdleVz0gLWhcwwMKce4Oytb6Z+HvNpnrPscYEXQERUJcHXL4cY+nZhD995ce82qA5ZbvwCaOWxOGPmxl1bVOS2ePqqKF8WYk/ZP2mreg1oKbdS3lcsrNv+48tonDbbxbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791041568; c=relaxed/simple;
	bh=J8Tll/VLNt8JScE8FOiO8Ze5cawoB3U978ao0umZdK0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tErztG5bnhOn1X37r9ny9Yg7Xyq6sTzBKcI57QiGCzz0/wHneK6pHZWv+B4mwqPw2wIR0k55kOKwfqKJL0n1uFxkNMk3U8oW9cwHLteZtuUq4OD8gXc0e3sP+IKc4EIhJ8lN0msaXicVo9G5ei+E9UvvvIxNrFyZBFIw1IjrUDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nJwAAMOb; arc=none smtp.client-ip=74.125.82.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nJwAAMOb"
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-15354aa70e8so988396c88.1
        for <netdev@vger.kernel.org>; Sat, 03 Oct 2026 08:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791041566; x=1791646366; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=yadZIPttRBv9dSKwud0a+5YxcIkLDEjOglnwJ2Qre08=;
        b=nJwAAMObHugGA0YG12f89NyL7cMpcmgjH84EEJXXPfnz8j/9/uS5O/JratbladAOwg
         PZ2n6nCFMSKXu5mctKbaR45aSj3BGlMunuBy1vwVco50Cgr1JfrGexnKMWqlMmWZ+WjC
         i6lJPb9ck1Z+k+p2/g9RR1JEl4IhYk6+56eUS1DOEIs/p+D5f/LvJD1FERb4K3YtpOuV
         2zk5atVpn0Rjx4fs2JuTMBLvXbeLEEt+OaekuYSZl8zlMnL3XXr+QBSsCnTg9Jb2Oxzt
         fKEiw5gX10BtA92vvwdsxe4hMVwAs4NPtCK/K8I0yPGnZp+zbNPcuScL8O1WMBHiCh1T
         lN7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791041566; x=1791646366;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yadZIPttRBv9dSKwud0a+5YxcIkLDEjOglnwJ2Qre08=;
        b=BG9vgYL2Rttl2xSC65cm7bg2gzgPfJnu5N7SqC8esy6eN0WIVMMdF3MD8FS3tfg7b3
         pFwHR27LT16ktt8I5pUE5VV200rW+oPfYArbDqIsxninFaVRpDQHT8kRqWa2SIdepGfj
         c657Lp5lzaEnmHFp5UZxiul1t0VQE08sx/Ulxc5DE78LvyfOOJL89kkUAbJiZKzw4uqX
         2pqb7NVXsYMEf+KStHc6x7cG16ONb43UFuY6fv1frV+2Ql+RA6eCNuh021SmUuJ/ZbHR
         RMEJLegEzWjy3uK0iz/aZtlDi5tcFHtE1wDBD9kf1NMxaKJfxGFEBfYZYWoOkmmih4u4
         VlNw==
X-Forwarded-Encrypted: i=1; AKwUvBxy4XKK77IDayaoh19HGHS/e/x9owE8LRB8GTE/zMgFU/97d34LPdiCNmLTOSg42VnkwgMZg/U=@vger.kernel.org
X-Gm-Message-State: AFuF++mLJEaCdZ2QsziAz8OIXPyFrIxsiwQRppPskM8lHN7HvNaj+mVB
	spLNp6Z4j4cn1Z3Nr4llggU4l/SJepO3JvbGuBlsjDLccDRAQZ5hOy7J
X-Gm-Gg: AYBFou0iKYzSRbQBVBHX9uvFo3+iD6bw+f1Y3CwnljhKVhuNGbXPbgvH7KVgIzLYl3w
	2T79Qj0x8n+WdQ8B8HGKuJrxtBiieGSPS5vF/Bd0GcY7HUjJwOj9h2rKh6dNGk3kbPXbbFrXVRz
	9CJZVCRrSSO4kJJrqYqD3aDY5HmGeHsAemFRqr6ev54ZqOUBtE4/kRKENTBGQZ+TEiTsOkVIGkP
	9VCTnDnf7rFbLpnCxFrQgqR+ONkbIGTCk6uQ3+z3ETP1GmmupFOGg5cz3HfFqXkwD8tGh42jMi+
	iiF5T+yHmGsMTyviEvKn1jQ81eagM2QgEUY0ftEe4j51zan6siMz4ydJ9QohVGyjeTm1hNRQAKI
	n7YqjT29iNYI+SPY2PHffmSQZgE7k43p4GRj70EXvJ/wX311GY1hH15O7gN1fHMA72GeWZQMmpZ
	TjXh1L4AZgtY3qd9naHyH4kCc+S5Xfv8Jn1bKrIn2SwxKDxW5S97ixOKDUzwrgtQQ8HwbuhGghw
	NRjYuqIfwA9Fx1d6n499KZRCEjzY1md
X-Received: by 2002:a05:7022:126:b0:153:4a27:4ea5 with SMTP id a92af1059eb24-1534a3691aemr2407293c88.28.1791041565937;
        Sat, 03 Oct 2026 08:32:45 -0700 (PDT)
Received: from 192.168.50.3 ([198.176.50.208])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-151fc39a7d1sm6576061c88.3.2026.10.03.08.32.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Oct 2026 08:32:45 -0700 (PDT)
From: bestswngs@gmail.com
To: edumazet@google.com,
	ncardwell@google.com,
	netdev@vger.kernel.org
Cc: kuniyu@google.com,
	davem@davemloft.net,
	horms@kernel.org,
	xmei5@asu.edu,
	co+71b6509cb791e531@bugs.sh,
	Weiming Shi <bestswngs@gmail.com>
Subject: [PATCH net] tcp: ignore locked zero CWND route metric
Date: Sat,  3 Oct 2026 23:32:25 +0800
Message-ID: <20261003153224.2683219-2-bestswngs@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Weiming Shi <bestswngs@gmail.com>

A locked RTAX_CWND route metric of zero is copied into the TCP metrics
cache and then into snd_cwnd_clamp. This sets the initial cwnd to zero.
With a cached SSTHRESH metric, a later Reno ACK can reach a divide by
zero in tcp_cong_avoid_ai(). A user with CAP_NET_ADMIN in a user-created
network namespace can trigger the oops.

Ignore a zero cached CWND metric when applying the locked clamp, leaving
the socket's initialized nonzero clamp in place.

  Oops: divide error: 0000 [#1] SMP KASAN NOPTI
  RIP: 0010:tcp_cong_avoid_ai (net/ipv4/tcp_cong.c:482)
  Call Trace:
  tcp_ack (net/ipv4/tcp_input.c:4440)
  tcp_rcv_established (net/ipv4/tcp_input.c:6678)
  tcp_v4_do_rcv (net/ipv4/tcp_ipv4.c:1854)
  tcp_v4_rcv (net/ipv4/tcp_ipv4.c:2248)
  Kernel panic - not syncing: Fatal exception in interrupt

Fixes: 51c5d0c4b169 ("tcp: Maintain dynamic metrics in local cache.")
Reported-by: <co+71b6509cb791e531@bugs.sh>
Assisted-by: LLM
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
---
 net/ipv4/tcp_metrics.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/tcp_metrics.c b/net/ipv4/tcp_metrics.c
index dc0c081fc1f3..ff41804ad086 100644
--- a/net/ipv4/tcp_metrics.c
+++ b/net/ipv4/tcp_metrics.c
@@ -484,8 +484,11 @@ void tcp_init_metrics(struct sock *sk)
 		goto reset;
 	}
 
-	if (tcp_metric_locked(tm, TCP_METRIC_CWND))
-		tp->snd_cwnd_clamp = tcp_metric_get(tm, TCP_METRIC_CWND);
+	if (tcp_metric_locked(tm, TCP_METRIC_CWND)) {
+		val = tcp_metric_get(tm, TCP_METRIC_CWND);
+		if (val)
+			tp->snd_cwnd_clamp = val;
+	}
 
 	val = READ_ONCE(net->ipv4.sysctl_tcp_no_ssthresh_metrics_save) ?
 	      0 : tcp_metric_get(tm, TCP_METRIC_SSTHRESH);
-- 
2.55.0

