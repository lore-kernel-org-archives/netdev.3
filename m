Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793811029;
	b=mDSPWKYLMK7ALn6iP1mwAvRZl7fPTKatV21bYIwMnDVUB3pCZCv7MYFj4HIRa69cyv0M
	 VbyUT279UZ0C5ghSgoDIAK49IxdmwxrREbGCvj5HhBsfTkds0WJ9NYUuPCky5RJiU0n0v
	 Kvl3smGkWdrUnPG8xxJ7oJ4Y64vsXY5z7Ri7L4rkUuc0CVjo5J4QnBHG5KAZ0UnaMaHse
	 WK0lgWlSXz660jnB8+9RFPFUP1wjCmwht749BiUU1GY72jC1DxQ6xu/JV6t67gj+BENxr
	 IH3Inlo6vKHdlSXSndaUTmBNo3KqT4shCe+34V5XsLNzdoF1E/vuBGk/pMDXBG6os1A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793811029;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:Mime-Version:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type:
	 Content-Transfer-Encoding;
	bh=42ViDqY1pgRrEbxeArnQ1CxFhwVOl5Jq3QE85TAxXZk=;
	b=C2N7Oq4+ZxQ59TNRis+kbYDD0VqbTbfVGhZDexoBZvdI4dYg9e0XSVFf3WS4ucuyNBdS
	 H9agLgbzij6k4AgMUsnoqHld5cZ5+PJWV2QGLGaSXCjhQQ4DItsv4J3DHElurNzLuX0Ce
	 ogCz/MAFxeCsN4jtZXqNODyF0WGU7qDrSTSMOTOtxRagP4VoianZaq8RoOLeai9OW87bE
	 erAmJx9X9oroKM2rHmT23PZ5dWCB/ZqLAxY0iOhJA1BpJ+oxwKuxOlYqg5JEiCqQOl0Mg
	 57Faun4bU1uKwFYz4vcINGZhWE8V71d876TSLTpO524r/EsDiOWSfNXVNj7nPQisrFQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=iPzDlLqq;
	arc=none smtp.remote-ip=209.85.216.70
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B95CA6083618
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 16:50:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B95CA6083618
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=iPzDlLqq
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3b08364cdc7so928574a91.0
        for <netdev@vger.kernel.org>; Wed, 04 Nov 2026 08:50:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793811028; x=1794415828; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:mime-version:date:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=42ViDqY1pgRrEbxeArnQ1CxFhwVOl5Jq3QE85TAxXZk=;
        b=iPzDlLqq0wucSrQwYd9Hiw2sc6LoBR9qA7BaLApLpPwRDf5TRReSws+/mlNS9F0hey
         sfhXqZ3nVr0lL4eC5cUFcTrnM4kFuLBPMgUymNSRoEtwR6XYA36B7bYtYpFZk+EejDV6
         /2tArG2z/nhh/hmdoExIjSaM0Bv2cxP5apg+a0ZF9cDHMjVw8UJRyYniOjx3/L+GHh6z
         CLcgsg55KCzWH5i/v0agNjiqly9d/YTchrxi4YCWhO4s/1eyfsA8KNS2ri6BWa6NUli/
         bRUohL7PlAWSHhmMjEHY9tTwZLMOMJb8J6SWVSCXRVBP2w9Y1pdhrZlCNfH8iQ0h/jg6
         H8ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793811028; x=1794415828;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:mime-version:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=42ViDqY1pgRrEbxeArnQ1CxFhwVOl5Jq3QE85TAxXZk=;
        b=FyS3hw2RczUwm1oK/nWMUI9mG0WqoBYTNSZj0aBBbW8g7wGdbqC87xZDwSy4Wg0ADt
         e7CTS63p0dX07dYF1D2ILAHszbvqXHQAOthTvPmTD+OMo3aY5PgVVAlZBQDUzmchHnE+
         RhZhz1nMmjJ2dScOl7sKx7nsXw/Sxy670f9x+nzXih0hHBqbbDtv152vuiOllHb583oo
         up96phY7CaeA/a1w978FhYqhSQC3O+KUT1nOcbElNOiTAIQ8PXBNCHVBN7lbI4/XXS2I
         dPrURL8r1vG521n6VMyiQQq4F2ES0QEJPx4FtW/Kf/2Wu/PM00kvTn5HMzPB3jphfjD0
         uW9w==
X-Forwarded-Encrypted: i=1; AKwUvBxClOvX7AqTvHj5vMcxJH+1xxPBZiiWvN6Fi+vNh0scXZ1EGgvg5ETlWI1wVl+Z6JOoSdhxsFY=@vger.kernel.org
X-Gm-Message-State: APuU4Z/RXCSG3LNuMiZOoDiao4uUBhc6eNP4d0hG2mME3dyKb0uthwa7
	oTtbrP9xJtj794zpSgcqDCQOZAAjyvCrzeWA4pyOMuK1MZX/78/Xx7pCJ9BIcOwFCl3ZW9FMLfZ
	tHZnePA==
X-Received: from pjbqi10.prod.google.com ([2002:a17:90b:274a:b0:3b0:9569:4e9a])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5243:b0:3a8:92a3:8baa
 with SMTP id 98e67ed59e1d1-3ae897f6727mr13761613a91.27.1793811027794; Wed, 04
 Nov 2026 08:50:27 -0800 (PST)
Date: Wed,  4 Nov 2026 16:49:55 +0000
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.385.gac671c819a-goog
Message-ID: <20261104165025.1026357-1-kuniyu@google.com>
Subject: [PATCH v1 net-next 0/2] tcp/mptcp: Don't call tcp_update_recv_tstamps()
 if not needed.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Eric Dumazet <edumazet@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	Matthieu Baerts <matttbe@kernel.org>, Mat Martineau <martineau@kernel.org>, 
	"David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Geliang Tang <geliang@kernel.org>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

When RX HWtstamp is enabled on NIC, skb_hwtstamps(skb)->hwtstamp
is set.

Then, recvmsg() always calls tcp_recv_timestamp() even when the
socket does not need timestamp.

Since it is called after release_sock() and touches sk->sk_tsflags,
which shares the same cacheline with sk->sk_forward_alloc, it stalls:

   0.31 =E2=94=82 403:   test   %al,%al
   0.02 =E2=94=82      =E2=86=93 je     4a0
  12.40 =E2=94=82        test   $0x2,%bpl        ; if (cmsg_flags & TCP_CMS=
G_TS)
        =E2=94=82      =E2=86=93 je     48f
  11.59 =E2=94=82        mov    0x60(%r14),%r15  ; sock_flag(sk, SOCK_TSTAM=
P_NEW)
  12.25 =E2=94=82        mov    0x170(%r14),%ebx ; READ_ONCE(sk->sk_tsflags=
)
  20.70 =E2=94=82        mov    0xd0(%rsp),%rdi  ; if (tss->ts[0]) {
   0.39 =E2=94=82        test   %rdi,%rdi
        =E2=94=82      =E2=86=93 je     44c

Commit f0e70409b7eb ("net: avoid unconditionally touching
sk_tsflags on RX") introduced SOCK_TIMESTAMPING_ANY to avoid the
issue for UDP.

This series checks it to avoid touching sk->sk_tsflags unnecessarily.

With the change, tcp_rr -T 128 -F 10000 gains ~3% more throughput
on AMD EPYC 7B12 Zen 2 Rome (2 sockets, 256 vCPUs).

Kuniyuki Iwashima (2):
  tcp: Don't call tcp_update_recv_tstamps() if not needed.
  mptcp: Don't call tcp_update_recv_tstamps() if not needed.

 include/net/sock.h   |  7 +++++++
 net/ipv4/tcp.c       | 12 +++++++++---
 net/mptcp/protocol.c |  3 ++-
 3 files changed, 18 insertions(+), 4 deletions(-)

--=20
2.56.0.385.gac671c819a-goog

