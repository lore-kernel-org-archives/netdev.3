Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE8E3443E56;
	Fri, 25 Sep 2026 12:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790340529; cv=none; b=LzIsWwSlYOHW6lNNc4yQA80JlSkw4FZqqEzsSGun6KinbrLbJlwPekOlKZojkoZ3nH06KMgvMHFGB4MCBF+CNeIClJ+m2iv1b//ONHzzo4wMx+FgIbQ9m7zTZIQITm8iZ+bxIKjo6JYqDmLnw+z3XDv7vmzSYnq8NdhGhtBBMgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790340529; c=relaxed/simple;
	bh=yzTFT5eQV1N0hhk6LRnlE8otFg7jvGAPkT6VYEZMNPs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ZO1DeD3S3uF8fz81KfCuAifW3wK8N+9jmDZRus0ugFl9NO1vJIj7/DaknWsXSeZ5Onsc9AEd0WqAM7F33H63w6zEgX7++V/VK/jJFPqGvPPW5PIx0mtousAJIxii/eFFnG8gsZCYt8PHlcNQqxBiPCmSWP+mj6jzTSXdgqPKtO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GM1uq25H; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GM1uq25H"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 57483C2BCF6;
	Fri, 25 Sep 2026 12:48:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1790340529;
	bh=yzTFT5eQV1N0hhk6LRnlE8otFg7jvGAPkT6VYEZMNPs=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=GM1uq25HLmcDk9iNSpWrDG+R8gp2338d+LYmAEmskVf5xSbn/g9uYG36Rfbgqbebs
	 Wzdc7LHR/T72L1ZcfV6URpQxobfxnHwgtcHf7DfhOLmsRIqA2DQaWbu9cCW/CrFqzH
	 cAoRC0I+xRXTWg1vUruBXVHy4R3v2wZxpl+WrdCH99ufv1tmHHnxOqiad4wnFgzpF3
	 0gucCvStEedIT3CulOdP6ycU0jZ9RBntfe3IJMTRx93I5B0HLwCqcMRREWQ2iHctuc
	 XNDNemopQgsIUMn44X6gTKLL474KsnQNXs6IjD0m29VSU1a00jS2nrFzQRW5hE/fTe
	 m3YOQLoJKXZXw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32B13C9830D;
	Fri, 25 Sep 2026 12:48:49 +0000 (UTC)
From: Quanye Yang via B4 Relay <devnull+quanyeyang.proton.me@kernel.org>
Subject: [PATCH net-next v5 0/2] tcp: annotate lockless access to
 sk->sk_err
Date: Fri, 25 Sep 2026 05:47:55 -0700
Message-Id: <20260925-mptcp-sk-err-net-v5-0-0cac04d6ea48@proton.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3XOQQ6CMBAF0KuQrh3TliLFlfcwLkqZajUU0laCM
 dzdghticPkzM+/PmwT0FgM5Zm/icbDBdi6FYpcRfVPuimCblAmn/EArKqHto+4hPAC9B4cRSmO
 kREMLKgRJZ71HY8eFPJN5weEYyeU7Cc/6jjrO4rx7syF2/rW0D2y5+F80MGDQqJIphbpSpjn1v
 oud27e48ANfA9UGwBMwv6lq1EpX9BfIVwDjG0CeAC1YLnNZyrrBX0CsgXIDEECBGSpMwQ0vDmw
 NTNP0ATbphJ+PAQAA
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790340527; l=2016;
 i=quanyeyang@proton.me; s=20260801; h=from:subject:message-id;
 bh=yzTFT5eQV1N0hhk6LRnlE8otFg7jvGAPkT6VYEZMNPs=;
 b=0ecpuS0VbDnnDSJOQFSDqe8rw7eLXRYGHFCxZPctJXRC8+Z0JlcHL+juPNO3Yf+a7SaNI7SFN
 ZWerm32oUT5C9AeI8Q4qq+994bzSwJvJR6Iy4OjwY7Ub0KHJWyzXidY
X-Developer-Key: i=quanyeyang@proton.me; a=ed25519;
 pk=9L9FrcvzMgxPaBRU6XV0EnqTgjDqVO596rQKSZ9qZoY=
X-Endpoint-Received: by B4 Relay for quanyeyang@proton.me/20260801 with
 auth_id=963
X-Original-From: Quanye Yang <quanyeyang@proton.me>
Reply-To: quanyeyang@proton.me

do_recvmmsg() and getsockopt(SO_ERROR) call sock_error() without the
socket lock and clear sk_err with xchg().

Patch 1 covers TCP. Peek-only sites use READ_ONCE(). On the no-data
recv and splice paths, call sock_error() once and only stop when it
returns a non-zero error. tcp_bpf_sendmsg() folds two unmarked loads
into one READ_ONCE() and uses that value as the returned errno.

Patch 2 does the same for MPTCP and annotates the remaining subflow
error-report peeks.

---
Changes in v5:
- recv/splice: call sock_error() once instead of peek-then-consume
- mention the tcp_bpf_sendmsg() READ_ONCE fold in the TCP commit
- Link to v4: https://patch.msgid.link/20260917-mptcp-sk-err-net-v4-0-1f04f52f2561@proton.me

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

 include/net/tcp.h    |  2 +-
 net/core/stream.c    |  2 +-
 net/ipv4/tcp.c       | 12 +++++-------
 net/ipv4/tcp_bpf.c   | 10 ++++------
 net/mptcp/protocol.c | 14 ++++++--------
 net/mptcp/subflow.c  |  4 ++--
 6 files changed, 19 insertions(+), 25 deletions(-)
---
base-commit: 211f2a875f6f447745d80d5762d6d614503ac84a
change-id: 20260908-mptcp-sk-err-net-7ff88ef05044

Best regards,
--  
Quanye Yang <quanyeyang@proton.me>


