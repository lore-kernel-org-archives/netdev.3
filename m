Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793077145;
	b=qeuc9T5OArS0td7MwrI/ByHWNuDy/RuxmQWTqtqUAQ8tLY4yA3axJ9ESK81jU7Ao4MEp
	 bIf4/i1a2ZXZtd+4uvvQGZpS+peCc2D8pCiUzXN5Q2tt1ofC3hGnVJ2NEHf7kCSug8ABb
	 6Va77YaeiHCFn9pRgWnkkH+N2lBB2+ELXyKAwjQj2VMnJaTS5oUaNk1or0HD+gAmYy3l+
	 P2hKonArdcBTgJMGoJLbOJAJqo5TLlSBtoN5hY0hV4Rp5FLJchMbyhvRNZNxLt84/D69y
	 DMzz9hZ616Vqo+DqOLG7/EcFsJi9PHM8ubUDw8u8xT83KcYZWJdn8pNqQnS7PlKJcbg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793077145;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=A1umM+mUhHMXhhzUaIKioVtRrS9R/R9JVZiISrrvwTA=;
	b=264tAX2XVLEhUYO+ZeeBLWyHAAz7odGFnsLWsv4dwjiX4OwK/Wvir/zpETeSdQvEuScP
	 qYWCjuxDGg/dCibn0FoneMOPwqxOd40Kuq4TCqE39xE0VfQeWv20hUbdSFqYzKf2PBBkg
	 9bWHXxlaKEOOj20UI6wA5TzJKjGUDGSBZRM1ojCFK0vfVHx/8uJ7jWDMDiGxLLNIXWODu
	 1xtjZY8scGpiN3SphuWHlrkrAyW8ReFx9I7dLDvLdHxYsyzPBiiid3sAetE7v7HtBexRU
	 vgBzwlo7/zPsuyXF7waUuSnxfimhIqqrw1ckP+WEek+/8EVz+JGQ5VkCJZHVyq7zPbw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nebusec.ai;
	spf=pass smtp.mailfrom=nebusec.ai;
	dkim=pass header.d=nebusec.ai header.i=@nebusec.ai header.a=rsa-sha256 header.s=google header.b=C02XwnvH;
	arc=none smtp.remote-ip=74.125.82.43
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A807606A31B
	for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 04:59:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7A807606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nebusec.ai header.i=@nebusec.ai header.a=rsa-sha256 header.s=google header.b=C02XwnvH
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-1a3c08d6928so1021677c88.0
        for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 21:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1793077144; x=1793681944; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=A1umM+mUhHMXhhzUaIKioVtRrS9R/R9JVZiISrrvwTA=;
        b=C02XwnvHP5Ml6tFarUh5CNmbgmoB5cawKMvRnn1S5OcgBMypyeKoVWAfAojCfTVhFZ
         E4EUx1WyIthG2Na/UWsH8tKTyjn34GZZQkp49zAq+BuVbcXxZqwjAkRxqt0VTfPR+Wsp
         hPIjyFI2WWcQUgU/t7T2ePHODRoxMF4+hbNZXUJ3URiZIj8GfxD7y0ejIfLKLU7dy9Va
         k+DhV5GYniN0uln3Qye1zDFHsEFDfMCx2jXWJkxGsUryYa8sGVJYWDr6rBApnEDxrvMJ
         MfXDnb0HO1VUtCxx92a2v3RDgSD0+DWsSco+rjw6J86Pmuxa50z5m2EiNpEwyjVwMAoj
         B+0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793077144; x=1793681944;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=A1umM+mUhHMXhhzUaIKioVtRrS9R/R9JVZiISrrvwTA=;
        b=nlo9L0xZ2ZZpyWd0zqdpwRlLeceeVCYrO+ywMX7jRDOjHqC8H/v/5tJ1Mm2WRb0dPa
         jDKEyi9Y+D3NWkZwUHML8RV3Lp6nvgiluGg/2r+8ALcgoRzgVHlxlLIXRqz0I2zwh3Qb
         2aPR1mtOXpgZcdOT3IC4iCwmuW1AC3/ZF0xhYYC6uCbF4K560O3qW7yClrY+DBYYN2hS
         kue6KMjNZ+7vptAhnboq0bgdpYeCtbKkPsLuGrOkXLK57ZSqoKNNsH6ZagUDzwlQh+KK
         /6UDI1Ksr0ToYU8+adGY0f6nOtkmjD9QlJzvy5aUqU1r5zhQcowSp5z6aBttWuMQMRYj
         F/Dw==
X-Forwarded-Encrypted: i=1; AKwUvBywvUA0y/7znnrGpAqovkU1Hd8FZLda4fob7iki9/bxk3xBaKbX5GAY9B5F+7Se/1boVvsB2wA=@vger.kernel.org
X-Gm-Message-State: AFq9FYKfNr9R2j68cHLtHmx5T5hOq0vnh7mtRjh0mUE5vlC/U9dnHLgM
	shJMuKq0T7kJ7770yadTkbypPQKObQSKTkIuSmElPtnV+zLMNMsEtNCiJzey7vvsMlglKXse/u1
	ypk60TWTRX+4=
X-Gm-Gg: AYBFou0la+mwoqemXW8iNUwxWllSY+ISSeryliWESXtVmKKOQG0cFYGaQFVx4QqQZAf
	jk8ttUz7SbNxxGG6ZJfc4OKY49soeGyHAMyUldSybLoYmgYXRuZj8TilHSQgt6m3TXXtEnzFpi6
	ekAPhpcHqg6MVEk+6c+rfvmpDLfkbyxrtzhAvhaCbgMvVT26o1s5PD1gYLFhx9bkiL7SngQgcoE
	DbZYjS6EF/oGZcaWGDo5bSU31f9b9C2LnNdkoxfhHcslb7uFscxn6aEga4jN1IxTzjlZ5H1kD0x
	5dN95yTqm8bBLGn+tfn9mB2JdjlE46m0T949Cg9DsjPAPgoii70E6MpL8Oqdyj3v6z3tw0vYf5J
	2C6xULNV+DF0m5oGD3TWZYtqRPQ12WVFaaIzFBu5nOErDC/0X8ubwV6QH4RmDyy8ITOgIjkbKzx
	f/lep0OvupYC0CI84HGAtEIxUt8zOiMpV6tkArOr9pNsFajsE7PjYSQ70TBGeBpyvSZyLSln4R+
	I9G//l0nZGuLLu12VDFh5S1nOFW6v7LVGbbYNdXp6YD5BRj+RPxqGvxqmezLRvtdadr
X-Received: by 2002:a05:7022:296:10b0:193:1148:64fe with SMTP id a92af1059eb24-19929009fd3mr11069310c88.6.1793077144382;
        Mon, 26 Oct 2026 21:59:04 -0700 (PDT)
Received: from Roxy.sysu.edu.cn ([2001:49f0:d0db:fffe:97d4:c0de:15a1:9c01])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-198a32ff780sm28884906c88.22.2026.10.26.21.58.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 21:59:03 -0700 (PDT)
From: Zhiling Zou <zhilinz@nebusec.ai>
To: alexei.starovoitov@gmail.com,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org
Cc: edumazet@kernel.org,
	ncardwell@google.com,
	kuniyu@google.com,
	john.fastabend@gmail.com,
	jakub@cloudflare.com,
	jiayuan.chen@linux.dev,
	davem@davemloft.net,
	pabeni@redhat.com,
	horms@kernel.org,
	daniel@iogearbox.net,
	vega@nebusec.ai,
	zhilinz@nebusec.ai
Subject: [PATCH bpf v2 1/1] tcp_bpf: update copied_seq from current value
Date: Tue, 27 Oct 2026 12:58:48 +0800
Message-ID: <da2b3b99a2f41142acd0eab4b7ecd2210c3f4a51.1793076960.git.zhilinz@nebusec.ai>
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

tcp_bpf_recvmsg_parser() snapshots tcp->copied_seq before processing
queued data and waiting for more. tcp_data_ready() and
tcp_msg_wait_data() can release the socket lock. While it is released,
a sockmap verdict can drop or redirect data and advance copied_seq. At
exit, writing back the old snapshot plus copied_from_self rewinds that
progress, leaving ordinary TCP receive behind queued data.

Keep copied_from_self as the count of bytes consumed from this socket,
but add it to the current tcp->copied_seq at exit instead of writing
back a stale snapshot. Count the FIN byte in copied_from_self as well.

Fixes: e5c6de5fa025 ("bpf, sockmap: Incorrectly handling copied_seq")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Suggested-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Assisted-by: LLM
Signed-off-by: Zhiling Zou <zhilinz@nebusec.ai>
---
changes in v2:
  - Update copied_seq relative to its current value at exit, preserving
    progress made while tcp_msg_wait_data() releases the socket lock.
  - Count the FIN sequence byte in copied_from_self.
  - v1 Link: https://lore.kernel.org/all/af73f81ba5060272e63bfe3757295fb09f5c6198.1792733621.git.zhilinz@nebusec.ai/

 net/ipv4/tcp_bpf.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
index 2e234d155b5e6..fee7bd72cc272 100644
--- a/net/ipv4/tcp_bpf.c
+++ b/net/ipv4/tcp_bpf.c
@@ -228,7 +228,6 @@ static int tcp_bpf_recvmsg_parser(struct sock *sk,
 	struct tcp_sock *tcp;
 	int copied_from_self = 0;
 	int copied = 0;
-	u32 seq;
 
 	if (unlikely(flags & MSG_ERRQUEUE))
 		return inet_recv_error(sk, msg, len);
@@ -242,7 +241,6 @@ static int tcp_bpf_recvmsg_parser(struct sock *sk,
 
 	lock_sock(sk);
 	tcp = tcp_sk(sk);
-	seq = tcp->copied_seq;
 	/* We may have received data on the sk_receive_queue pre-accept and
 	 * then we can not use read_skb in this context because we haven't
 	 * assigned a sk_socket yet so have no link to the ops. The work-around
@@ -274,11 +272,10 @@ static int tcp_bpf_recvmsg_parser(struct sock *sk,
 
 		if (is_fin) {
 			copied = 0;
-			seq++;
+			copied_from_self++;
 			goto out;
 		}
 	}
-	seq += copied_from_self;
 	if (!copied) {
 		long timeo;
 		int data;
@@ -321,7 +318,7 @@ static int tcp_bpf_recvmsg_parser(struct sock *sk,
 	}
 out:
 	if (!peek)
-		WRITE_ONCE(tcp->copied_seq, seq);
+		WRITE_ONCE(tcp->copied_seq, tcp->copied_seq + copied_from_self);
 	tcp_rcv_space_adjust(sk);
 	if (copied > 0)
 		__tcp_cleanup_rbuf(sk, copied);
-- 
2.55.0

