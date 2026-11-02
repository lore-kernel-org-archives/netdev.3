Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793604078;
	b=snV+FAE0PryHZGxNYSakmlUKrgysJL2ZbAIT8rnh2/dETxd3uBcwb43wp7MJThn14AUx
	 YLYLHUjJ0Ny3C39fjUOBUE/habuyrFEzITvMjzuBQyGWcQZFw9PfxYMdj+A9IuBZ+3fdD
	 gN1Q8+Gs3DBajOCbxwY9nrJHaTHc5hH1BLCnPlYRh1JBlZm3k7auJv+xjDWwGp+mbPvVF
	 hwrykgzbPTqaVVfBv0lYMh6YZUwxlVzbsM+lfwzUTLBaeHoeq9eD1ulEM3ePJS3R4Nn05
	 Lxq4gBFtAjzZ1JEf2NVQp1g2Dq0tYqqV8HWz7SllgQHupf1TDJd85/mAsWeWjafVqJA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793604078;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=bK+b/qrfSwKnSjxBPgQ7rRNYPJMfbkszlGWmScXGZ8I=;
	b=m4yeq1OfPNDHgkWkt/goqOij1gO2wgkgIYMVx5xSwMQqb7i54N4ekNOgLeUKOqeZyIA4
	 /00CVCvvhzXnH+UP1vaKcLUD48eQNF90JcRjrENTd+rKnCEtbAgM2RRqYZuMfjEUWiocY
	 gnsDwyWRCIMEb9Irk0DzZEBxCXeRUthJgSa+HaTexNozhRpV8PWAPepUsk/PZdEcf5s6V
	 kpUsv0vU0yTkXuLcfy427ogppDUwvBDmky2GejNRNWtm0AIw8ilxrJx1XNkNCreph5jiT
	 /o43sbJ81XydLtbiqT5j6jiNkDj834CWJ8M2DKBiL+CtHReAH2wnwrsHyu42I9VtFqQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qLs7ggxf;
	arc=none smtp.remote-ip=209.85.215.172
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E16AC606A324
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 07:21:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E16AC606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qLs7ggxf
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-cc7e79c1eaaso913890a12.2
        for <netdev@vger.kernel.org>; Sun, 01 Nov 2026 23:21:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793604077; x=1794208877; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=bK+b/qrfSwKnSjxBPgQ7rRNYPJMfbkszlGWmScXGZ8I=;
        b=qLs7ggxfy98u/p78nRhn4s/E8LVCyu42Kx2L9Q5AGrh4igdHOevn9dBtbVo7RYq2GI
         vMtn8X9O50+RYyoZb/GBt+rivC9aM9ttHNPVNz8c08aKdo7UX2/bD/qwHrf+ALBCLh3e
         zPGkhbuUKjxYWUHd/w5sTRIfZlGKusu85N+uEJQkCMypkIFaNeeNJoYUWJYM7jv3w15z
         0as3PN8KFwnAJ74ykaR3rse/MP8WA0vq6tTz8v9Id/cjJhZl1dVzU/+3qeQF9SliQiFm
         F6rALkgjPPnhIpIw6+cPz3bSpQSn1gDYXQXeGJqkvyjesJzb9po9hnPKQKjYUehXGYVu
         LiSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793604077; x=1794208877;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bK+b/qrfSwKnSjxBPgQ7rRNYPJMfbkszlGWmScXGZ8I=;
        b=crz0X5WeBNW4z5Wa8/7d8xeBJLLSTETbvhUXyrs/pqrqvbikGGj/8SF/Yr0GeB7QD4
         MY4Cu/zNPFYnSstg8/72XLoFFZGzbL9fkSfmBLzB/ZiZui4slwZCY8GwKvBKTald6FW8
         lkyJVsWZ68cTISu+0t3NEjL4eTKagBmUju2KtBzkwlUPmcb9it86Ob8DnPzn4i8/Hz0z
         oQ2G1WFFFaI90EuZ4ZPOBOsihHehT7WM0N3atfVx1fryd6BRdVthYMLpH49y2Ozwn8i9
         aFu7IXyykBuZrkq5K276IfPq2BK/ZLk4MuE+QcYzENXfgp3Kv7YweBggDFSI0heREQHF
         2csw==
X-Forwarded-Encrypted: i=1; AKwUvBx1h6Uo7caGzR4R8u1S+Npp2CHEp9aYXBlUVn6HALOeQ3YZo2Rm+B6BRvTf6QX4jWS6Mlksts8=@vger.kernel.org
X-Gm-Message-State: APuU4Z+W/+I4MpZHZyDFuPMvQ3JbVddCcx53pu/4W0nkqC0nhhC2IV59
	tL3IpY85dxFKfVdhv+2pwrG3RSii2EIQ/4ZWgRSf/mDnkjo/zlp3hBt1
X-Gm-Gg: AYBFou1lmfmp01HYUDKrJ27l3TgcvvfAVugaam+efc4e6RazjXevrChxkvglG2+P41U
	7MyGtUyjYp07hFTkOtOw/yzYgJ/LNv0lZE6X4ajq+2CU3n9MH1xd1hGxlRf7D8VU/rRhdUw9gIe
	TcSKvAO43AN6wmrlVrunGAXd8plQO3SA16oV7w9qEKaYFbjDoNgiFrUay99zAaYB0Imel+LZk14
	eGNs5k1mcQYpYKNiYKyWQbFWTao31KlNBsvEJCDuMlOaDjZQ8W1UwYANI+y4Zvij9ON9o3W5pS4
	J6rAIf1Gi7egDjDV+FHT+0PRRUM7IOdQlw5LZGziV8h+mrOL/KDcfpcqad6JknxcsrURnjTqUVP
	nYiffe6+xHUJLc/JdGn6E6C6Pi2dcVqsG3VCYgCtTQKTXN4G3Zf2it5hhwnbYxiaX/GQf+Co32j
	K3wFvq3I5B9lHnjnv5a8QJCHSw8fk7+f6amKpwrvAE5A9vXbcxIRW/CKVN9kjR4gFaPybxNO3bR
	Qdy/MCGOcDLSRvK6h9uGeGKllxQ+5k2TH5SwoiXu484PD1Y157Lf5GnlEhWeo+Gn9xbS/lhjsjU
	C5B8ssjriN04DuqrZHcv0LLyiMaF8iC28hWEHqfpqYEN9/Cv1VanZA8XfzqKclOp9jrPNhbsgbc
	st1WmBy69iRhCAMC4aKqL+WZOWLx4Tx+hUX2uWT/5TZ4M7aQp6NnbRPamtr0VGbWmFET55tSMiM
	E=
X-Received: by 2002:a17:90b:3148:b0:3a8:13d6:f740 with SMTP id 98e67ed59e1d1-3ae897364c0mr7170464a91.22.1793604077199;
        Sun, 01 Nov 2026 23:21:17 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.254])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae6e944ba9sm17483813a91.8.2026.11.01.23.21.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 23:21:16 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org,
	netdev@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	john.fastabend@gmail.com,
	jakub@cloudflare.com,
	jiayuan.chen@linux.dev,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	kuniyu@google.com,
	willemb@google.com,
	matttbe@kernel.org,
	mptcp@lists.linux.dev,
	mason@kernel.org,
	josef@toxicpanda.com
Subject: [PATCH bpf v2 00/15] bpf, sockmap: Fixes for verdicts, redirects, corks and recvmsg()
Date: Mon,  2 Nov 2026 07:20:57 +0000
Message-ID: <20261102072112.4160195-1-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
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

From: Alexei Starovoitov <ast@kernel.org>

These patches fix bugs in sockmap:

  patches  area
  -------  ----------------------------------------------------------------
  01       recvmsg() after a fault
  02-04    the verdict of an sk_msg prog and the return value of sendmsg()
  05       the backlog of a stopped psock
  06       TCP listeners
  07-08    the target of an egress redirect
  09       the TCP state in recvmsg()
  10-14    corks and the redirect target
  15       bpf_msg_push_data() and bpf_msg_pop_data()

8 of the patches are from Chris Mason and Josef Bacik.

Patch 08 changes net/core/stream.c. Patch 09 moves tcp_can_send_ack() from
net/mptcp/protocol.c to include/net/tcp.h. Patches 10 and 15 change the
sk_msg helpers in net/core/filter.c.

v1 -> v2:
- Patch 03: end the verdict after a failed push too if apply_bytes is 0.
  Another sender can use up apply_bytes during the push (CI bot)
- Patch 04: correct the Fixes tag (CI bot)
- Rebase on the bpf tree

v1: https://lore.kernel.org/bpf/20261101192057.2296489-1-alexei.starovoitov@gmail.com/

Signed-off-by: Alexei Starovoitov <ast@kernel.org>

Alexei Starovoitov (7):
  bpf, sockmap: Don't let an SK_PASS verdict cover the next message
  bpf, sockmap: Subtract all dropped bytes from the return value
  net: Leave sk_stream_wait_memory() once the socket is dead
  bpf, sockmap: Clear the redirect target before the sk_msg prog runs
  bpf, sockmap: Check that the redirected message is the cork
  bpf, sockmap: Keep the rest of the cork after a redirect
  bpf, sockmap: Clear the end mark of elements added by push and pop

Chris Mason (5):
  bpf, sockmap: Give no progs to a TCP listener
  bpf, sockmap: Check the target of an egress redirect before each send
  bpf, sockmap: Check the TCP state in recvmsg()
  bpf, sockmap: Reset the copy position when corking
  bpf, sockmap: Don't copy 0 bytes into a full cork

Josef Bacik (3):
  bpf, sockmap: Write sg.start when recvmsg() faults
  bpf, sockmap: Don't let an SK_DROP verdict stick
  bpf, sockmap: Clear the resume state of a stopped psock

 Documentation/bpf/map_sockmap.rst |  4 +-
 include/linux/skmsg.h             | 19 +++++++
 include/net/tcp.h                 |  6 ++
 net/core/filter.c                 | 17 +-----
 net/core/skmsg.c                  | 13 ++++-
 net/core/sock_map.c               |  9 +++
 net/core/stream.c                 |  6 +-
 net/ipv4/tcp_bpf.c                | 93 ++++++++++++++++++++++++++++---
 net/mptcp/protocol.c              |  6 --
 9 files changed, 141 insertions(+), 32 deletions(-)


base-commit: 5e96760b25fdedbbf9312827f1f237d6b18b03e8
-- 
2.55.0

