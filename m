Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E30C6376A03
	for <netdev@vger.kernel.org>; Mon, 24 Aug 2026 03:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787542489; cv=none; b=AonKZ+cu1iSEdRRdJRFZgUU8SBCQM7MiDweFMGMSuICRHb+N15E6idau1QbDnTm7cQD9BcF0drVB51CO5CoBxePS5l6ZLLEgU/MODrkFMrctCTyXfgXhuzeHis0M1B9RWjJYZjYSTzASdw2LAUZYPh3KU3ngRroBgoxv3U9Gd5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787542489; c=relaxed/simple;
	bh=sz4I1sq4K0b/4zGjd0FzYdICKmLEOx+P2s0EyxNw1ck=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UsExpWf9OT5TVYPUKtJ31HrdpJX2ThevCo5GmrQNSY7roML6soZUHb8r0xcyXGzr2eXYMqPFKnn8AmlOUGw0Xk/2GdKgTCZJs3cmBID5gfRzSjuDXrdk8TLKZ9D26KGsImMYcXfhf9VfZY6uiXKizBRpL/lkrKXEsWjiyeDvTAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UD75Iysx; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UD75Iysx"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3856d6fbcb3so2417552a91.2
        for <netdev@vger.kernel.org>; Sun, 23 Aug 2026 20:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787542487; x=1788147287; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=h3czPEGgc8kYZ51pcfr/0w7zOEtrgQWrgOFC5Loyaz4=;
        b=UD75Iysx8wdyY58cFjzUVXdFvohgn4QrSvPOepcBrVuUaLz8D+ip2mLntd5qFPE2Fr
         lEZzPZqcny2Ny6mYcbHK6j8vjnQNplMDE4sW9vUH5s/2xn0RIEI9X/FzQDMApEmfCYow
         Cs4bo0vlGl1Do3QCubUmrZBaQDo0ojeod82X2JrVhpkI48pZxgMXyH9Hspah+vnHWSO7
         r8So9mIeFEscjcV2qFT6lUpsIGrIqy/2cShFPckUz4fpabmhGctpyEFlNeXuy52JgWAE
         ZoXtRc44mNiGBHPoq5gjWN8nT2tNCA5JhwDV8A+cWsboX59fhoBx8CBYUDFBxbpqWR86
         i0qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787542487; x=1788147287;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=h3czPEGgc8kYZ51pcfr/0w7zOEtrgQWrgOFC5Loyaz4=;
        b=G0RXY69k2DD8QvXKTNh96dq00PnZef8jFuo/poM+yUDQPGe0xeuQ8EVkd0gXNnqEcg
         eXx5UukWqlFZ2Lqh75/XbOwi0YmvC4KefIql9JYbXrWdq0uvAYWOojCz62unuGe8QAIQ
         s814l6VpLNGUi0cvcVaEHBauKFOIrvpH502Q1hzwK6C4gizZSeRD+3yVuhu47n/HSTcU
         OY1p7wi59vvJ1w5/9CxFqc6aaFC5+ADPT9i4yGy8Jg7SYxnYkZegAySpUFn+TgrecEPJ
         YjXbEhUiWXyY9qXP/h6xk/pm2aDgM1AL8np5439JF9mJV8BwQDzrWzl6D3naRdMW6TX8
         panw==
X-Forwarded-Encrypted: i=1; AHgh+RrKIMDuPhEU5EPHB2vjFnmsOscauCWciVjrgyei1aMY/QF1cI9fE2GfQr27wand0/mwuy8/AbM=@vger.kernel.org
X-Gm-Message-State: AFuF++nur1aW/t95ykCRrwGgWtSqMPb/MefCapGWMmW6ak0RRbXHKjLO
	kB5QuQCWmksvctsOSGitVF1CG81a3PKGt/6Elr2vGKS+M40HYSo9XP86
X-Gm-Gg: AR+sD11ilGRTjnqk3P81Mh6qeZVm1jHtINnpDrrM/T4rI1GqTZO/0X7hOViMXk93uBX
	k3wyxKO2WDkK8wmVlJUqgLthUq8ChvpCXvEh8iy4Wy0ywHlLVy6ZlLIvjp6Kn+d6lmLX/a9tCsF
	jeGR3ovLCIs02HST4VG9y0LkpXGOm9G5o7bw4OVI0O1BUB6ypW2bR3iEBLWQ8G50zUuIJySvGt6
	2XTKdDsGp4UEUKB/LK5yraFIVqw4VYYxoHzw15fB/uIAGCwijibmP5gmtcfdJoNpHsw47gtrGTM
	iA6H2mLFiN1Lh/h/ZoT6qRQoRS6JbZSaPSm2D39WGiGRxQiNaYfqF5tKRMU5y/JEG5twF9P5SNO
	mVpHhZVYfE/5gAVC/+az+t3KKPMnnLqb2osGFCCgrZb6g4sBxwXrVgX1y1P003J9MULgLcvPwGS
	yGn2CLgPXRfhIOEU12urpwOPyGIbPiW2w2/x9JSEjLjJq+ShHMeubf/58iAoyrVkErcLiNayLdP
	m/9kl1Li2TXmJ06ih40xw==
X-Received: by 2002:a17:90b:5805:b0:38e:485c:ebd3 with SMTP id 98e67ed59e1d1-395c3a514a5mr42206353a91.15.1787542486850;
        Sun, 23 Aug 2026 20:34:46 -0700 (PDT)
Received: from v4bel.. ([58.123.110.97])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-395c8fd34d9sm4227256a91.1.2026.08.23.20.34.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Aug 2026 20:34:46 -0700 (PDT)
From: Hyunwoo Kim <imv4bel@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	ncardwell@google.com,
	dsahern@kernel.org,
	idosch@nvidia.com,
	kuniyu@google.com,
	horms@kernel.org,
	willemb@google.com,
	andrew+netdev@lunn.ch,
	kees@kernel.org,
	jiayuan.chen@linux.dev
Cc: kerneljasonxing@gmail.com,
	ij@kernel.org,
	martin.lau@kernel.org,
	shakeel.butt@linux.dev,
	matttbe@kernel.org,
	martineau@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imv4bel@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH net v2 7/8] net: clear sk_tsq_flags in sk_clone()
Date: Mon, 24 Aug 2026 12:32:51 +0900
Message-ID: <20260824033331.1084971-8-imv4bel@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260824033331.1084971-1-imv4bel@gmail.com>
References: <20260824033331.1084971-1-imv4bel@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A socket returned by accept() can be freed while its fd is still open. A
setsockopt() on that fd then hits a use-after-free.

TCP_TSQ_DEFERRED owns a socket reference. tcp_tsq_handler() sets the bit
and calls sock_hold() when the socket is owned by user, and
tcp_release_cb() clears the bit and calls __sock_put(). sock_copy() gives
the child the bit but not the reference, so the __sock_put() that runs when
accept() locks and unlocks the child has nothing to pair with. The socket
is freed by the next put, which in the log below came from a timer.

A listener can be holding this bit. An established socket becomes a
listener again through connect(AF_UNSPEC) and listen(), and
tcp_clear_xmit_timers() only calls hrtimer_try_to_cancel(), so a pacing
callback that is already running survives. That callback sets the bit while
accept() holds the socket lock, and in the same window the child is created
in the TCP_NEW_SYN_RECV branch of tcp_v4_rcv(), which does not take the
listener lock.

All seven bits in sk_tsq_flags describe work pending on the parent, and
four of them own a reference. They are set in four different places, so
clear the whole word in sk_clone().

In short:

  socket(AF_INET) -> setsockopt(SO_MAX_PACING_RATE, 100000)
                  -> setsockopt(TCP_MAXSEG, 1200) -> bind -> connect(peer)
  send(64KB)                          // arms the pacing timer, sock_hold()
  connect(AF_UNSPEC)                  // stop being connected
  listen()                            // become a listener again
  setsockopt(TCP_DEFER_ACCEPT)
      // another socket connects, and with TCP_DEFER_ACCEPT there is no
      // child yet
  accept()                            // the child is created when one byte
                                      // arrives. while accept() holds the
                                      // lock the pacing callback sets the
                                      // bit, and the child is cloned by
                                      // the receive path, which does not
                                      // take the listener lock
      // a timer on the child does the last put and the socket is freed
  setsockopt(accepted, TCP_NODELAY)   // use-after-free

KASAN log:

  BUG: KASAN: slab-use-after-free in sock_common_setsockopt+0x44/0x80
  Read of size 8 at addr ffff88800e2ab668 by task repro/94
  ...
  Call Trace:
   sock_common_setsockopt+0x44/0x80
   do_sock_setsockopt+0x15e/0x2b0
   __sys_setsockopt+0x9e/0xe0
   __x64_sys_setsockopt+0x64/0x80
  ...
  Allocated by task 95:
   sk_prot_alloc+0x45/0x170
   sk_clone+0x49/0x960
   inet_csk_clone_lock+0x29/0x2c0
   tcp_create_openreq_child+0x2a/0xf20
   tcp_v4_syn_recv_sock+0xd3/0x7e0
   tcp_check_req+0x374/0xff0
   tcp_v4_rcv+0xc2d/0x2040
  ...
  Freed by task 0:
   slab_free_after_rcu_debug+0xc5/0x200
   rcu_core+0x4de/0xd30
  ...
  Last potentially related work creation:
   kmem_cache_free+0x11d/0x5f0
   __sk_destruct+0x29a/0x3d0
   call_timer_fn+0x12f/0x3f0
   __run_timers+0x4a4/0x5e0
  ...
  The buggy address belongs to the object at ffff88800e2ab640
   which belongs to the cache TCP of size 3200

Fixes: 73a6bab5aa2a ("tcp: switch pacing timer to softirq based hrtimer")
Cc: stable@vger.kernel.org
Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
---
 net/core/sock.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/core/sock.c b/net/core/sock.c
index 098e58b40f304b..06fbb19824e267 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -2533,6 +2533,7 @@ struct sock *sk_clone(const struct sock *sk, const gfp_t priority,
 	newsk->sk_reserved_mem  = 0;
 	DEBUG_NET_WARN_ON_ONCE(newsk->sk_drop_counters);
 	sk_drops_reset(newsk);
+	newsk->sk_tsq_flags	= 0;
 	newsk->sk_send_head	= NULL;
 	newsk->sk_userlocks	= sk->sk_userlocks & ~SOCK_BINDPORT_LOCK;
 	atomic_set(&newsk->sk_zckey, 0);
-- 
2.43.0

