Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 893313E6DFA
	for <netdev@vger.kernel.org>; Mon, 17 Aug 2026 15:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786981818; cv=none; b=GjcXQ+hmGsQTk9qxEwvyvvpA8Y/VP+qGEAk03qVieE56PtbM6VumPdoWBMsBdzwN/gu63C5Yt9r0rlcnvxcC/tN5F6a00KTeUu9ZATqVTDv8Iao7oE9jgCPwZB5bIpfm2lYWsDL88aIlpWmZB+Hhg8XCYmG1jVRQZADMJBhyD10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786981818; c=relaxed/simple;
	bh=upfOBcx67ccUHVILLZj6LHzNU3JzIn4py8iQVhZWU7I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VluUOzJ37l6O68O2opefv/KZvHIGpTdmcIc9YtFaglA1sZXr3TmRdPE9Nv7Z76fWafvSYsT1YZU7U4/fV5fwzifHubc56QRFxllwwt05LuztTJuo4cVf1tiHzUg0qkSYAmFNJaR8W2xdqh0U1rLw072AvcTU+4OM6aX8n9ZIIFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hlmbvgP3; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hlmbvgP3"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-38101f85591so13150a91.1
        for <netdev@vger.kernel.org>; Mon, 17 Aug 2026 08:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786981817; x=1787586617; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZqT0TP65I8/htknlz+a1OswTUdfg3AFV14OnEYJmW04=;
        b=hlmbvgP3nnPeLEfNfXo++sjd7Kd24+tQKpC0DkUL3r1qcfa9vHYRzrOkx8pw+FG9VE
         1REURMHWPXrj1sGFEOcqzs46OgPRER6IwlhDCDrxR6WQXNCO3GMvg73qM8zdPEQU7OMZ
         /4YFmpB2xetxg+NQXrm95/8ZDfToVwDnDHsm7Wwdc6q7A6J+yIwLyQku+9p/dUxAhuNN
         EbelIv08p04TJEIv3oUPLnxG3JhcdzovscgLpPIgoEz/Yfqo9+u+IKedZtbWuJuH7WV6
         eaZNJgfe6v21oL+ew8OAmJSOEvBySQig0q7T7LjJBAqYgnshtTCjTcS/2bIFmv9Ukmn2
         k3jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786981817; x=1787586617;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZqT0TP65I8/htknlz+a1OswTUdfg3AFV14OnEYJmW04=;
        b=LhLk4kK31PC5euY+Bv9mY+mjqYjdITEAAYF+GJg0jsolh0psydsSDAI+fAvprMKbvG
         clc0jJXdx/cwhCtpkbWB4ZkX3u/HwMxuaMsFjIQ6binZ0rvXCbS/iyKHPAVmcizsAQfV
         2kdLRhHyagWSn87muLNGA63dLtHJEnn2bhscRMvsFyaNohaA26o8X4yON4O06QpgJ1Sp
         EegC197ZNwRz04Z0J+fsiDwbiW21TITVv4FA1IOQY2u6csr7FaNToiFLC9yIyIuaOVVk
         gGk8d3B7ys0BWlI6H0Y5EBVN32O+9swjSosvzhrxzReN7JzEfp7fRxHFlhUJ6pK/uHAX
         /IVQ==
X-Forwarded-Encrypted: i=1; AHgh+RrTNjSQ585ZFAB2LGEk1jinBHdQ7tczj7lOnrH2eLClZ1goscOFvy2RLPPPT6f2lH+g3kPnQZI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9g731nQPt2uFx0ZTnigCvcuPrOkvcWnMLW9p5U6djwqDIsy50
	PnBzQvx4P5p3GdMaH2t2RK2EwCyDmHUck/4gj5ezDAiH05ICfzyssK2G
X-Gm-Gg: AR+sD127rEewlNSZG+04oj5DhwZJ6s83NqOeT9c80IsQvZUJeEKBePbU9NtioguYf7Z
	glnNi554TFHIFTp7CeJeabM3EGPgTpQ5VjkBF2nTDZI+lkbKkJcAyBD2ENqpTsV7VsQoNBaaZuY
	tV9PPNMraLkhs7PMzABYjUiGkz16IZT2ESz+b8otykNiaFNKoyqkVNwc4dOjP3J74jj2TJzDxUE
	PJqNmoaJ7wyssfeE7SGVq4GHFSd6a3wjrESo1QgFLRpOtH9wdcbHfwQMBTQnkPQQr48HcyKOa/W
	HZbdREVadnyT1PibAD1gAFvwbLL0OXWs8HK0SCdQLzdXtt74HASeMs5xv8GDMFTPsAcQ8Z5+jVQ
	3BC3HHNpqEQ86Rm0E4qKp9AOGr9KWlrfO4yYPZgnnQaedXuGaJ7cIMCDuw9kaTJqxm0p0KY+xvC
	xvvWSeyYItoafb8xbRmMmBOo3lpDItGWdeFnyABSKD5XGChj8l/kprhSQ=
X-Received: by 2002:a17:90b:4d12:b0:387:d5bd:622f with SMTP id 98e67ed59e1d1-3955f25132dmr11450a91.18.1786981816608;
        Mon, 17 Aug 2026 08:50:16 -0700 (PDT)
Received: from omen-arch ([211.58.239.197])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39339b0d6f4sm4682766a91.0.2026.08.17.08.50.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 08:50:15 -0700 (PDT)
From: Junseo Lim <zirajs7@gmail.com>
To: John Fastabend <john.fastabend@gmail.com>,
	Jakub Sitnicki <jakub@cloudflare.com>,
	Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Sechang Lim <rhkrqnwk98@gmail.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf v3 0/2] bpf, sockmap: fix forward allocation accounting in strparser self-pass path
Date: Tue, 18 Aug 2026 00:50:07 +0900
Message-ID: <20260817155009.232670-1-zirajs7@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The strparser SK_PASS path can queue cloned skbs back to the same socket.
When one TCP receive skb is split into many strparser messages, repeated
receive-owner assignments for unowned clones can leave sk_forward_alloc
in deficit before the next skb_set_owner_r() charge. Teardown can then
uncharge more memcg pages than were reserved and trigger a page_counter
underflow warning.

Fix by avoiding another receive-owner transition for same-socket skbs
that are already receive-owned by the socket. For unowned strparser
self-pass skbs, settle any existing sk_forward_alloc deficit with
sk_rmem_schedule(sk, skb, 0) before skb_set_owner_r().

Patch 1 also fixes psock backlog retries by restoring the original skb
redirect metadata after skb_bpf_redirect_clear(). If a deferred strparser
self-pass skb needs forward-allocation settlement, that work is done under
the socket lock.

The selftest adds a sockmap_strp case using a one-byte stream parser and
an SK_PASS verdict program. The test checks INET_DIAG_MEMINFO to verify
that sk_forward_alloc does not go negative after exercising the self-pass
delivery path.

Changelog:
v2 -> v3:
- Do not call skb_set_owner_r() again for already receive-owned same-socket
  skbs.
- Preserve the original _sk_redir value across psock backlog retries.
- Add a backlog-specific self-pass path so deferred strparser
  forward-allocation settlement runs under the socket lock.

v1 -> v2:
- Keep skb_set_owner_r() and use sk_rmem_schedule(sk, skb, 0) to settle
  sk_forward_alloc instead of skipping the owner transition.
  (Emil Tsalapatis)
- Apply the same handling to psock backlog retries.
- Add a sockmap_strp selftest based on the reproducer.
- Add a Reported-by tag.
- Change the Fixes tag to point to the commit that introduced the issue.

v1: https://lore.kernel.org/bpf/20260723065244.186916-1-zirajs7@gmail.com/T/
v2: https://lore.kernel.org/bpf/20260801102633.1872012-1-zirajs7@gmail.com/T/

Junseo Lim (2):
  bpf, sockmap: settle sk_forward_alloc for strparser SK_PASS
  selftests/bpf: Cover strparser self-pass forward allocation

 net/core/skmsg.c                              | 125 +++++++++++--
 .../selftests/bpf/prog_tests/sockmap_strp.c   | 171 ++++++++++++++++++
 .../selftests/bpf/progs/test_sockmap_strp.c   |   6 +
 3 files changed, 282 insertions(+), 20 deletions(-)

-- 
2.55.0
