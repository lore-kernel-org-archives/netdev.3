Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C5EA33EB10
	for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 13:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791811590; cv=none; b=Nx+u3RMoY3mFZb9PhoYUbG9qym6ISGvI7Nzoti9DYPGidr4+WjAoCyTqOKq95nJPdxEMQoLWsZZSLBjykAbqqJutW2DefrRueAcIA5tpjofJi8xVNslNtkb/37PsHLKgGnzwd8o6aEMxyf0f+DDj5G4DjU7WdobOxap7QBoXmWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791811590; c=relaxed/simple;
	bh=HXIj0gQEcDCReDu6ruJ1xTkv1w4iN2pbsUWbQr+Abws=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MTqLLKO9tNkS34XwTwNNIxHlExLo6WtDfiI1PwoIwsEd2WucgTBvycUAe6LIzAVaCwwqhuz04keBoMx+LhjZL/5K4oc7mp4AkQjtCW7waGY0MlwWeUp4K4YOtiEvqPb9ueafAS0cWvBXY6r7pJao9pizaYUj/L5v2C06KasRpUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b6V548Tl; arc=none smtp.client-ip=74.125.82.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b6V548Tl"
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-354ba08cfd1so3349848eec.1
        for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 06:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791811588; x=1792416388; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=UVtdckhLu7/IYl0AhQQTkAmfbFdz3g7PQYd+YCMHEF0=;
        b=b6V548Tli1NCOiz4w2Dz7CeoUrsbGUJHt76wRO7c57DIL0Tz2G5x/d0iQXX+OTM6CB
         RdVN1HVALktnrwBLFRJ4NjZ68+0UF7DSQLsg7h0tA8YHuOSHyb3b/j5vsmmjAyMkjA0e
         pKtUx2cEk7+IYNinrFhTqoap0ogMBFHQjloIQu9CxC9k6HIgWvKpHv7WNm+0cgfzDdxb
         IJfQtnMLnFD+eakWSh64T78H0Nii3fvM/tpgpuTdXhHTGh0Bn0oRvfmZbKZ5N07nUPBo
         Suu+eBT5hIQjLMY8IRvfGc0ks1VZ9kTjEQWokY+s3bkJXphUjzCXkKOOnz6rwN0/g17z
         HI0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791811588; x=1792416388;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UVtdckhLu7/IYl0AhQQTkAmfbFdz3g7PQYd+YCMHEF0=;
        b=uQANbQhQQ2PRsQ9yx3hlnq0VHN6SLmnswOKXUL3v0Qb7aHYH+kBPQcOrX7G4VEmEC8
         n5fm8bKqGruBwh4JT5RbvAVTNVXlbL6SoWHfAiT9YdKH3BZ7eDi9Dusc3WelNbvYG9Gd
         QUhZVMakbKgBd35rdFhwzn5hYMD+GK5Z4qI/BL9ZXB+eJ/l38zLnHaiO5MPDsFlr+ZwQ
         vYxCaCuTTu/QZxNzu4MUyx8ROTacpoD6/EkSdBTulOMNwNtpt6OubekOFX8ornuYgqbt
         bhp/GbOVPTOe+ko6usv2lTyptfVblHQt5+/4/ZZYH2tr5S2EBuRM1ndvV2H6Y13YqLEa
         OIrA==
X-Forwarded-Encrypted: i=1; AKwUvBxBswdkkbz6tK0AC2bjsLp/SMRHCLQmPQBsL1tYt4ELZUSbJ1t1Jy+94ea4yFKJyb9dVUr7Ztg=@vger.kernel.org
X-Gm-Message-State: AFq9FYI5XVlF6QnTFeMnlpjWGVuJntgEgenWEQIOEXNx8sHEAkch/t1i
	O9d3mgp0gp00lV2aVSiOvpCiRzz3Vf64QULJbQ1wKGPDVeADWe6kIHBT
X-Gm-Gg: AYBFou1kLSFKh35qCSJSs3RP7u0TSSt/F9pfVm7Pd/0I8FxpH51TflPCTRq8MSR9uhh
	92V7/gqeyEwxmed+yxw3iDSiXkx8jIAEYaw85Oa2TwZg/Li6Fu2uJscKLPQ50d3JwigpE+H3yme
	BMeF2A9vhrw8Jbu0RI+zCStI9UhFJGYsqWZ5g+TVtZD54+gGdaAkKb8b1kYoYlVW6PJ923s/nU4
	eHeFwoeKmVo6MUvqYUYbGJ9F2AYOOpn63Hdw5KoUpg4qivulYCIWHkLtL6TZDhF0XVB22fQzdog
	DW+dqVVFjU3X9C07yoJaCiWSvdVeCVfdCTUTzCWyjTkfSk8ujuToVSedvczDVb/p4v5DTP7HmJd
	RsyD7m3mWlzU23pTdZzaUcoqO14C55H25c6JeC1g276ksf/qZ976QTrz6140m9y6eYNjNNvjSuT
	OILq2WHHYlwMGfNtPa/5byp9DEyBbibStjHq4FPBABIin48ZWAs2fRC0zNfC5dRPtAMaD8dlm38
	ktB9z5C3atZ0EkJQJuu6hA/rRa/T3Uu2LURlAlJDt7llVeBaGduW8C2VCzm33M5w3bKAw0WRnAH
	bwD9HdLj+cci9YjGCdQT6RpCArEe5FlCPma5RHPCQhHulRk2arwiiQbsB8Y1BJ8CsQ9ly90YIY6
	v4uo0urvKXYiQDGG7/rM/xaMTIVOTPya27G4etgNvowsRAXPccbLy+g==
X-Received: by 2002:a05:693c:87cd:20b0:356:9345:a07c with SMTP id 5a478bee46e88-3569345a944mr12261023eec.22.1791811588166;
        Mon, 12 Oct 2026 06:26:28 -0700 (PDT)
Received: from FT6N242TWK ([223.181.117.66])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537ca1b53dsm31467174eec.6.2026.10.12.06.26.24
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 12 Oct 2026 06:26:27 -0700 (PDT)
From: Shashank Mohan Jain <jain.sm@gmail.com>
To: Eric Dumazet <edumazet@kernel.org>,
	Neal Cardwell <ncardwell@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>
Cc: Kuniyuki Iwashima <kuniyu@google.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v3 0/2] tcp: keep the route window metric when SO_RCVBUF is set before connect
Date: Mon, 12 Oct 2026 18:56:20 +0530
Message-ID: <20261012132622.48550-1-jain.sm@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v2 was flagged by the netdev AI reviewer, and the review was right on both
points:

 - The TCP_CLOSE/TCP_LISTEN state check in v2 did not cover every path on
   which SO_RCVBUF is applied before tcp_connect_init() runs. The socket is
   already in TCP_SYN_SENT before tcp_connect_init(), so SO_RCVBUF set in
   that gap - via TCP_FASTOPEN_CONNECT before the first write(), or via
   bpf_setsockopt() in a BPF_SOCK_OPS_TCP_CONNECT_CB program - still wrote
   window_clamp and still overrode the route metric.

 - The v2 changelog was wrong about the "no route metric" case (there both
   the old and the patched kernel end at tcp_full_space(), so nothing
   changes) and overstated the impact.

v3 changes the mechanism: instead of keying off the socket state, it
records whether window_clamp was set by the user via
setsockopt(TCP_WINDOW_CLAMP) and keys tcp_connect_init() and
tcp_openreq_init_rwin() off that, so the route metric is applied on every
pre-connection path, the TCP_SYN_SENT ones included. The changelog now
states the real impact: (1) routes with an RTAX_WINDOW metric and (2) a
TCP_WINDOW_CLAMP overwritten by a later SO_RCVBUF on an unconnected socket
or listener.

Patch 1 is the fix. Patch 2 adds packetdrill tests for the plain
SO_RCVBUF-before-connect case, the TCP_WINDOW_CLAMP-vs-SO_RCVBUF case, and
the TCP_FASTOPEN_CONNECT (TCP_SYN_SENT gap) case; the last fails on both
unpatched net-next and the v2 patch and passes with patch 1.

Changes since v2:
 - fix: distinguish a user TCP_WINDOW_CLAMP from an sk_rcvbuf-derived clamp
   (new tp->window_clamp_user bit) instead of checking the socket state, so
   the route metric survives SO_RCVBUF on the TCP_SYN_SENT paths (TFO,
   sock_ops) too; a genuine TCP_WINDOW_CLAMP is no longer overwritten by a
   later SO_RCVBUF.
 - changelog: drop the inaccurate "no route metric" case and the "any
   application" overstatement; state the impact as RTAX_WINDOW routes and
   an overwritten TCP_WINDOW_CLAMP.
 - selftest: add the TCP_WINDOW_CLAMP-vs-SO_RCVBUF and TCP_FASTOPEN_CONNECT
   cases alongside the original one.

Changes since v1 (single [PATCH net]):
 - retargeted from net to net-next, added the packetdrill selftest, and
   rewrote the changelog (the window scale option is still sent, with a
   shift of 0; since a2cbb1603943 the clamp does not persist past the first
   data segments).

Shashank Mohan Jain (2):
  tcp: keep the route window metric when SO_RCVBUF is set before connect
  selftests/net/packetdrill: cover SO_RCVBUF vs the route window clamp

 include/linux/tcp.h                           |  3 ++-
 net/ipv4/tcp.c                                | 12 +++++++++
 net/ipv4/tcp_minisocks.c                      |  7 +++--
 net/ipv4/tcp_output.c                         |  2 +-
 .../tcp_fastopen_connect_rcvbuf_window.pkt    | 22 +++++++++++++++
 .../tcp_rcvbuf_before_connect_window.pkt      | 27 +++++++++++++++++++
 .../tcp_window_clamp_vs_rcvbuf.pkt            | 24 +++++++++++++++++
 7 files changed, 93 insertions(+), 4 deletions(-)
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_fastopen_connect_rcvbuf_window.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_rcvbuf_before_connect_window.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_window_clamp_vs_rcvbuf.pkt


base-commit: d8674294aefef02266c4d47ad10131f1bffbe534
-- 
2.43.0

