Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792598243;
	b=LdtVMe6ih/3TaJZzN1bX5RpmcG9ROp2YIK+jodAsOEh5kNvtBmHL3UB0oMEyqXysF7AW
	 lSgP1OsveswcOtly3+tvqlwPi7jjML4IOl7efxSXFGwqt7ac1bMj3JxLSJ+fuL8SATlA7
	 V1yuNiP9E3P6Eh0Bbpi8iTBOTbqFYwOyNrVSSfpTQEBYpB8ybxgbTB0Xba1tNRDaIKZeq
	 jwqJZ2IxHVNN5fC1ck6uQsASD1/DSuJQVk8VcpM8Xgu3Pjxaa4OaTFLVz431f96sy7qVC
	 bZytkYE9kjQtKWcyZiABmemnkNQQL98clpul+2TDzM989RYGMQ0UKAeEezqVxJZ00bA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792598243;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=JtAbmr2NF3t4ZTxPDbsg5aPyVRAPZZtbj1QOfmkXENY=;
	b=uo9ErBSkYE784wixcgmxE+u3Z4ZqbsntV2ysl83NY22tS9HuKvCu6nCN1/9QoN4orOLM
	 pT0Q+fAEuPTyKExY35WZHJ+c2BHrk3TtBuxvb97/eUlsZ+dEqNBVNlDDrvwffoZPwSc3D
	 IKJKt2E2afVJ93tY9euvJzLPHeP5Y9rYLtCe4Zlsm1Xg2uiT0sGC6ssmHzFgP+Ni4AxYm
	 MmOwD6W7Du9Ck0SQK4liFMxC1mG1sHZINXoQdH6WuO2oqhT9wOgXUpY70VilUrzexWOw5
	 +mj5QrNxl2DCOHTceHRE/4SRcQlLUWyGTUp4YySt9xWQ2dTcnK8DWSLoU/a7RjLIFyQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=eo8Bydcp;
	arc=none smtp.remote-ip=74.125.82.180
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7386606A32A
	for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 15:57:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B7386606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=eo8Bydcp
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-3514b90bb89so2404186eec.1
        for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 08:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792598242; x=1793203042; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=JtAbmr2NF3t4ZTxPDbsg5aPyVRAPZZtbj1QOfmkXENY=;
        b=eo8BydcpBlKhkaBCJwZ1SB3JlHB5TgjSc2WtuGyAFpcg8tzA/EPOO8Q4dojR9RDefc
         +jXMcRsaKnQ/ax/YRfsNjTmXWuUgitOCv1N/0/HIk3i8J45IDYDqTagOMT+12pHXnb1H
         cLoYdSXre7z6F4KjiuCmeoxgDKZJi8wu6yh4eYUhUNfOVGIZ+bgUvXcIYmu+eMH1flOV
         m9qU35vQSavMMT1jZkmCRLVFnWuJAG0PFs1BPQjA3hLtErDWxFSCaFVM8oFpwqqmnb1V
         a0LlK9233/1FCPjfGpP7OXqIikuDUzSFWuejR++Ot7jjucWw8x2v1dTMwRTTVmiOoLyN
         Rebw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792598242; x=1793203042;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JtAbmr2NF3t4ZTxPDbsg5aPyVRAPZZtbj1QOfmkXENY=;
        b=pQ5+YNWNesW5YjTNYxkA8nftajgzToOm9IfQB7moU5uvJLgZBV6QfCYcm2hrpW22n3
         Bu3Yh/+pIwJ4qArnkJjYvXf8a9p4boP98cJGHo/DSbGTkFtTr7z5Eqb/U9qS1SiZKTIa
         hq+0kXd+nhM0M9M/adkdoWV2anlB3VdvH6hTRshY1EslJ0XTgO2q0OOWbIZhdRLPQiz+
         VLLAv3UuoaoElKhtH712Is5JKcbJ0a5stJKHcGVZcCdOVdJUKKTULu43TTYORzUuGKuh
         sgfAlxg+GM9mT8AbhIE/1tAa+k5nm/pBzHNp4eklBAgf6dxtnBLS0ee6M20UPtGhGar5
         meAw==
X-Forwarded-Encrypted: i=1; AKwUvByUZa2xDyd+vZlAJ0ngGsWcRNZhkXN7EmyFkcOW3VsVr+2Xo7HZ/hrZv9UTORCf582oqtGMWjM=@vger.kernel.org
X-Gm-Message-State: AFq9FYKiqH1WKoyUc7MAnc8uTXbmpF3+950o1NcgTwzgX3e/+0SrpgwC
	j+EhB+6fC3GOL6AGgeYJftmkDxscq9TxeNEiHVrgEWAJ+DGOy4rjZuDp
X-Gm-Gg: AYBFou0ezP1dyvo1H9AsKay5T+l6raVAY/nNFjrQ7Z3dlRHTG2NZgayPWpELIbzjGD+
	1YEZN0/EHBWUi0DZ3866mWLdCpYRZ6t3rfWy8u4d2olC/IJNt0Em6NDAvyNePKNXRn0b8pDlwAs
	wYMaHdgLfJtQm1Obtmg6hLE8lMNKCTQ5OhDM0KXKhQQO3cSvakJ86KBuciM0/QYwSyEEIuhVC2t
	UQ3E0R5JpPARzS61eOgM6PdOozrVNaGzYqfFK5UYYMACSXvWWPD1k7MoDzwIS9okMWhmq1DvnA/
	w5czm+bIUSB38XzFbbaiK8jk8vwK4Ri8II7PzyA4GH0+StsjX5eVl9poHn2GbWMOeX7LWPBHKDA
	QUuxDvcX5155BTbsi0M3r0Kx2HUjOf+Wp7S96Cy0VB7XZt6bnQHwGTfSpuIGjIe8zPKSMkLQGob
	fQQyktqDxf/rpTt81ZqG2Qx3lR+qsVb8Ei0JMpd79Xr4M1Y58iQdZM/X+PYp3IuCqiHPW/1rvqw
	qGcAQoLZY2xKtv4h6MKNaX2+/hxEHDeHSfPMb/EpLhLceMLdiJUyaHtXW+lfBUuwG/7hGGpN+Iy
	wh1IH7PFPA+xijIwHNv3XeM+R4FjQ83VYQT8DTOkbeGK5sB5YHUUlGm7PvSvbvXC6HjBF1FW2X1
	C4w3m4BgixbAd9izkfx4++yt+XOib6INmxPQLk5K9WuJ79Bf86DljvtkWYNkTSzjiUfzwXoKdq5
	p7Juv1j/duYWJFnC49UZBIHKMphozscOpxPNI=
X-Received: by 2002:a05:693c:8815:20b0:35d:7565:8577 with SMTP id 5a478bee46e88-3674cc3d862mr3556454eec.15.1792598241646;
        Wed, 21 Oct 2026 08:57:21 -0700 (PDT)
Received: from FT6N242TWK ([223.181.118.44])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3674198f1d8sm12350080eec.24.2026.10.21.08.57.18
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 21 Oct 2026 08:57:21 -0700 (PDT)
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
Subject: [PATCH net-next v4 0/2] tcp: keep the route window metric when SO_RCVBUF is set before connect
Date: Wed, 21 Oct 2026 21:27:13 +0530
Message-ID: <20261021155715.30094-1-jain.sm@gmail.com>
X-Mailer: git-send-email 2.54.0
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

Since commit b025461303d8 ("tcp: update window_clamp when SO_RCVBUF is
set"), SO_RCVBUF set before connect() or on a listener leaves a non-zero
window_clamp behind. The SYN, SYN-ACK and SYN cookie paths take that for
a TCP_WINDOW_CLAMP set by the user, so the route "window" metric
(RTAX_WINDOW) is skipped, and a real TCP_WINDOW_CLAMP set before
SO_RCVBUF is overwritten.

Patch 1 records the clamp the user set with TCP_WINDOW_CLAMP in a new
field and keys the SYN, SYN-ACK and SYN cookie paths off it. Patch 2
adds nine packetdrill tests (active open, passive open, SYN cookies over
IPv4 and IPv6, TCP_WINDOW_CLAMP reset, SO_RCVBUF raise on an established
socket). All nine fail on net-next without patch 1 and pass with it.

As Jakub asked, the commit message of patch 1 now says how the problem
was found and how it was tested.

Changes since v3, all from the AI review of v3 (each point was checked
against net-next before acting on it):

 - SYN cookies: cookie_v4_check() and cookie_v6_check() still used
   "window_clamp ?: RTAX_WINDOW". With SO_RCVBUF on the listener and a
   route window metric, v3 sent a SYN-ACK with wscale 0 while the cookie
   child used rcv_wscale 5 (reproduced on the wire with v3, and by the
   new cookie tests). The SYN-ACK path and both cookie paths now use
   one helper, tcp_req_window_clamp().

 - A single bit could leave window_clamp too low: v3's tcp_set_rcvbuf()
   returned early once TCP_WINDOW_CLAMP was set, so after
   tcp_init_buffer_space() lowered window_clamp, a larger SO_RCVBUF
   could not raise it again. v4 stores the requested clamp (u32
   window_clamp_user) and lets SO_RCVBUF move window_clamp up to it.

 - Lockless read of a bitfield: the listener side now reads a separate
   u32 with READ_ONCE(), written with WRITE_ONCE(), instead of a bit in
   a byte shared with nonagle and rate_app_limited.

 - window_clamp_user is listed in net_cachelines/tcp_sock.rst. It sits
   in the cold part of struct tcp_sock; pahole shows the size (2432
   bytes on x86_64, with and without MPTCP) and the fast path groups
   unchanged.

 - Selftests: symbolic TCP_FASTOPEN_CONNECT and TCP_FASTOPEN_NO_COOKIE
   (TCP_WINDOW_CLAMP stays numeric because packetdrill has no symbol for
   it, and the comment no longer refers to a local build); new listener
   tests for SO_RCVBUF alone and for TCP_WINDOW_CLAMP then SO_RCVBUF;
   SYN cookie tests for IPv4 and IPv6 that check tcpi_rcv_wscale of the
   child; a TCP_WINDOW_CLAMP=0 reset test; a test that SO_RCVBUF raises
   window_clamp up to the user's clamp and not above it.

 - Patch 1 changelog: how the bug was found and tested; the cookie paths
   are named.

 - Rebased on current net-next.

Link: https://lore.kernel.org/all/20261012132622.48550-1-jain.sm@gmail.com/ (v3)

Changes since v2:
 - track a user TCP_WINDOW_CLAMP instead of checking the socket state,
   so the TCP_SYN_SENT paths (TCP_FASTOPEN_CONNECT, sock_ops) are fixed
   too; corrected the changelog; two more selftests.

Changes since v1 (single [PATCH net]):
 - retargeted from net to net-next, added the packetdrill selftest, and
   rewrote the changelog.

Shashank Mohan Jain (2):
  tcp: keep the route window metric when SO_RCVBUF is set before connect
  selftests/net/packetdrill: cover SO_RCVBUF vs the route window clamp

 .../networking/net_cachelines/tcp_sock.rst    |  1 +
 include/linux/tcp.h                           |  1 +
 include/net/tcp.h                             | 14 ++++++++++
 net/ipv4/syncookies.c                         |  3 +--
 net/ipv4/tcp.c                                | 14 +++++++++-
 net/ipv4/tcp_minisocks.c                      |  4 +--
 net/ipv4/tcp_output.c                         |  2 +-
 net/ipv6/syncookies.c                         |  2 +-
 .../tcp_fastopen_connect_rcvbuf_window.pkt    | 21 +++++++++++++++
 .../tcp_rcvbuf_before_connect_window.pkt      | 27 +++++++++++++++++++
 .../tcp_rcvbuf_listener_window.pkt            | 20 ++++++++++++++
 .../tcp_syncookies_rcvbuf_window_ip4.pkt      | 22 +++++++++++++++
 .../tcp_syncookies_rcvbuf_window_ip6.pkt      | 22 +++++++++++++++
 .../tcp_window_clamp_rcvbuf_raise.pkt         | 27 +++++++++++++++++++
 .../tcp_window_clamp_reset_rcvbuf.pkt         | 22 +++++++++++++++
 .../tcp_window_clamp_vs_rcvbuf.pkt            | 23 ++++++++++++++++
 .../tcp_window_clamp_vs_rcvbuf_listener.pkt   | 25 +++++++++++++++++
 17 files changed, 242 insertions(+), 8 deletions(-)
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_fastopen_connect_rcvbuf_window.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_rcvbuf_before_connect_window.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_rcvbuf_listener_window.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_syncookies_rcvbuf_window_ip4.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_syncookies_rcvbuf_window_ip6.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_window_clamp_rcvbuf_raise.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_window_clamp_reset_rcvbuf.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_window_clamp_vs_rcvbuf.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_window_clamp_vs_rcvbuf_listener.pkt


base-commit: 279d5c8afcd38bd841832a39bfe1aa4f8518d98e
--
2.43.0

