Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F6ED46E011;
	Thu, 17 Sep 2026 13:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789652487; cv=none; b=g/fJaf7lym6tyFMC2cy7bh3HxBLZkaNp/T2O8PuCjUDclzX23iujq20M0zBF+Xs7+/i214EWdDYeOOp+8MPeUEtXzVjns90k+vcv8YCS01wyiAh/osVdQVXYofYq9pt+OUFou2bSW5gZSPpEoge6xiIW2ov2mT/o9X7YLzWhFYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789652487; c=relaxed/simple;
	bh=HST9EaucmkFhUHvdO3KRl/gCm8AxlEQ93kW9f+QlSbg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=mDVuJ++PAedxPelaNueS+++FFWQUOWNUgC8P6C3unoKJ4Zo1m9gqWn5bWQHmwxTkLvDzKcGQc5cLLsctUpN07EkWWGdahzsAk88DY3HlFliDQfqIG1mNFwGJxzbxjI6IYb6KdBNWgCJWZaxih0NgjmlF5VNhDhzhklnmNNLhKWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dZF9ncm4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dZF9ncm4"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1FFF2C2BCB3;
	Thu, 17 Sep 2026 13:41:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1789652486;
	bh=HST9EaucmkFhUHvdO3KRl/gCm8AxlEQ93kW9f+QlSbg=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=dZF9ncm4rmsz5bHhELxe9nfxJJNFJaHVi97bJc4cHYUvjKN8v5lq1nFUKkPjCxvbQ
	 LaoOmuz5L8gsEU4jFZRE4I4LrAuLQu+3BarzQCWg5hWQ6N8Upvef+mbCBdYfUQojS8
	 OEgWm/XmJYzeuH++N6/aw51owjH8/jEtlIowjTkPEhgg0tNjT65+FL3RpqYKbZK5F7
	 DRl6KXkpRUjonwOB04NQyzDughAIKj88PDZIZD+R+Ti36lzIvbslrK9ZMKufgSqPDp
	 wBCAfeGAfUokHOqI2CYtkYYqJP+xkFA5JdpTXnK+3L1G4ZCHBiJYDFxiy2eWLb8ftU
	 Cf9waGOwoQJ6g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B472C88E72;
	Thu, 17 Sep 2026 13:41:26 +0000 (UTC)
From: Quanye Yang via B4 Relay <devnull+quanyeyang.proton.me@kernel.org>
Subject: [PATCH net-next v4 0/2] tcp: annotate lockless access to
 sk->sk_err
Date: Thu, 17 Sep 2026 06:41:21 -0700
Message-Id: <20260917-mptcp-sk-err-net-v4-0-1f04f52f2561@proton.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3XOTQ6CMBAF4KuQrq3pD0px5T2Mi1KmUo2FtLXBE
 O5uixticPkyM9+bCXlwBjw6FRNyEI03vU2h3BVIddLeAJs2ZcQIO5KaCPwcghqwf2BwDlsIuNJ
 aCNDkQMoSpbPBgTbjQl5QXrAwBnT9TvyruYMKWcy7nfGhd++lPdLl4n9RpJjiVlZUSlC11O15c
 H3o7f4JCx/ZGqg3AJaA/KZsQElVk1+ArwDKNgCeAFVSLrioRNPCGpjn+QOpj8leTgEAAA==
X-Change-ID: 20260908-mptcp-sk-err-net-7ff88ef05044
To: Eric Dumazet <edumazet@google.com>, 
 Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, Mat Martineau <martineau@kernel.org>, 
 Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789652484; l=1644;
 i=quanyeyang@proton.me; s=20260801; h=from:subject:message-id;
 bh=HST9EaucmkFhUHvdO3KRl/gCm8AxlEQ93kW9f+QlSbg=;
 b=Wu3a89wukqLv07lr32vRc6ZT8eJkrZgIyh1uRSesnCrwQSUegOODeADllKXYrBB6JithBQ+93
 1+BriVbD70HA3ImNzIori9P7I2wbQVDRy9PIiBQAWuFHHYL/piRqmIj
X-Developer-Key: i=quanyeyang@proton.me; a=ed25519;
 pk=9L9FrcvzMgxPaBRU6XV0EnqTgjDqVO596rQKSZ9qZoY=
X-Endpoint-Received: by B4 Relay for quanyeyang@proton.me/20260801 with
 auth_id=963
X-Original-From: Quanye Yang <quanyeyang@proton.me>
Reply-To: quanyeyang@proton.me

do_recvmmsg() and getsockopt(SO_ERROR) call sock_error() without the
socket lock and clear sk_err with xchg(). Annotate the matching
lockless peeks with READ_ONCE().

Patch 1 covers TCP. Patch 2 covers MPTCP, including the remaining
unmarked subflow peeks.

This does not consume sk_err. The check-then-sock_error() TOCTOU on
the no-data paths is a separate issue.

---
Changes in v4:
- split the annotation change, one points to tcp and another points to
  mptcp.
- annotate the remaining unmarked MPTCP sk_err peeks on the
  subflow error-report path.
- Link to v3: https://patch.msgid.link/20260912-mptcp-sk-err-net-v3-1-c41383878bde@proton.me

Changes in v3:
- drop the Fixes tag and retarget to net-next
- annotate the remaining unmarked sk_err peeks on the TCP/MPTCP
  send, recv and splice paths
- Link to v2: https://patch.msgid.link/20260909-mptcp-sk-err-net-v2-1-5044abecac90@proton.me

Changes in v2:
- add Reported-by and Closes for the MPTCP syzkaller report
- Link to v1: https://patch.msgid.link/20260908-mptcp-sk-err-net-v1-1-da71aaec9afd@proton.me

---
Quanye Yang (2):
      tcp: annotate lockless access to sk->sk_err
      mptcp: annotate lockless access to sk->sk_err

 include/net/tcp.h    | 3 ++-
 net/core/stream.c    | 2 +-
 net/ipv4/tcp.c       | 6 +++---
 net/ipv4/tcp_bpf.c   | 7 +++----
 net/mptcp/protocol.c | 8 ++++----
 net/mptcp/subflow.c  | 4 ++--
 6 files changed, 15 insertions(+), 15 deletions(-)
---
base-commit: 211f2a875f6f447745d80d5762d6d614503ac84a
change-id: 20260908-mptcp-sk-err-net-7ff88ef05044

Best regards,
--  
Quanye Yang <quanyeyang@proton.me>


