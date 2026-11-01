Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793560861;
	b=Qss/bKsRv91Cegp7MUTEakdPljGNVqe43e+yMOyZPlJi7kddf9i1iRqy6JJ/Q2J2Lnv2
	 d9BTdwjQndfywRR8VogoFmfSHtSqlJHsxIMpiu8ZxBNjQIg6aQ9/qbPfduxSPkfCMSQyL
	 K72pKFSEu/cHNxoRGYF1u4PxUYvBZ5RYvucYzUo8XJ8BzRMu2Y+RjIxNrQIx1uWm6ieB3
	 vFqvbSn53nuFOjfWJlrOeHCNlbTCF5PtkXtNMIKjt/NTGz79KWJGBX8yzGJ/0kRkjTsr8
	 vnGuHnDJvmZRApilnTdnmQ2YEkU6GAab4k1eT+eLLWi9KTdAOhXPvva/ZrE2aMj2xKA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793560861;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=iAeiSOPaaWkQBppOUsktRtMkprnZmaPxcUrEefFlWVc=;
	b=QyAYsLL4OSGHsKdhnU/53XQp+ewxGbBzRH2fvvD9CoS1VWX4JzxCaq99NcMzZsNHwIws
	 oZfAEQ79EnZCyJw0vcVlpyEwKn72w/sgNb8uH818OFooO+ZsMbhznjolliyO9xL3L/TCL
	 OpeIXClznYGTArysKN9y5ZzaxP+n+ubiy+ZrzjpFVn0h2q3tQYjPOTu8TBRBwPzSSPuCT
	 emuLnAw2gqtHeyjwyCch8eKu/5KOLcEnCqg+avQESAp91TjiLFGTv2XEtkEXixiYGgeCE
	 gO9KoFQ6FVCEaU0hsAKBpFBX4AX9UjkmJy0I7lbCtJGGmRaavvUnKKAB+isSChH6EFw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=G7r1Pb0P;
	arc=none smtp.remote-ip=209.85.216.41
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B9B8606A324
	for <netdev@vger.kernel.org>; Sun,  1 Nov 2026 19:21:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6B9B8606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=G7r1Pb0P
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3ae1da332bcso1045817a91.2
        for <netdev@vger.kernel.org>; Sun, 01 Nov 2026 11:21:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793560861; x=1794165661; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=iAeiSOPaaWkQBppOUsktRtMkprnZmaPxcUrEefFlWVc=;
        b=G7r1Pb0PM8rKvbabZG6DbUaHrypMYxZIEigHQRNUZCKYZjRfQ0WRO5sZ6lr3XGqnT1
         edU3+biJcSM4yJNPLx50J7uFtFqDxEb+GFxnGSBciBokdfKTYjaRGW1KlVI9yGkVZFIU
         pdfCopUucfGlW2Bss4OEuWrnSEhiKHjIx/FM1qVmbqJ5d0J07EJ3OpuOty4yf133VOl6
         se1JvscppLBxRPyHRQTM8IIENG4MqK5C+k0fmy6WhURdpjEK6gLG12LWlqPupqAMpCTa
         nJqO2iXQF/mxo9QV+v/69gXFvAiOMvu+EWo7j5NXrECeHisdT3CDkOnwwrkMhxSyhhTe
         JHtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793560861; x=1794165661;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iAeiSOPaaWkQBppOUsktRtMkprnZmaPxcUrEefFlWVc=;
        b=uohpLPgnfiParjxDxgpXAvtrrR1WWfxr2i2mO5On3BjN2oUR+ceyMvl5rd2N8XdAQE
         89UGWW9/h6HBW4EuF5OMmpl1XSyOJizOm+ibxhnunvzfTrgB/ge+rN+A3zycEeL3SE17
         xWkDLBrqyDscVQyGL3mr/LemYTowoI9ar78NOhoSSEJcKnRjgkJJ4YeEbl1H/Qn9S0LH
         6nEJffD88R9iOJ++BFUywKFy3pJD88Ejkir5xzO0CzxKqX2DQ9PHYTipsOL+ijzOHMkk
         qkr3G1I4Q/m1eCIuuN+B7ae3eWhnjPk7aFQKKgvVcuoy2yxSaskKx6fEme33mXcEvE2h
         IaVQ==
X-Forwarded-Encrypted: i=1; AKwUvBwWQ+FIcMWFJcTJBKTZGKTBSRCAc3ig7cRVjyNf2GhKYncJ/73jTCUE8YN+Jy75VDYh4ojwTiE=@vger.kernel.org
X-Gm-Message-State: APuU4Z9Ri0lpzp6CKfq2tl4QLJwQbZNqWPM+Ksj/x7RoJ/3fiXQYji8X
	V91zIOajcwIdsccO8snWL7QJ185YQ6P1/I/PZViOzBiYVdKjcWBpM1HI
X-Gm-Gg: AYBFou1f/82IAwe6MONh6idp9UvZSHcajygc6LWFKk7iiTLw7WqELD0LPphxfko8Lzc
	t2IbCMkV4lEwaqYzUgeid6RcQR7c/6QnExIyqaYZYBLAqI8HllyanAWTiUGDIriz3cvrAO5KK67
	BNG8FNAqqcoYgoPMl2fR3DsN2ALrAFqmwahnPQvxCTZsuXUDmRPsZRQnTsAQJc8RR8y8kixUU/U
	V+2zyQUmGrDp73Hjt1xHbfKD0sGMTGGMShZo78tb3bHtiIAruMTn6XnBfcwLwL3rz+j/WhDXcwD
	YHcjWiGaa5zA6hLyOlh1IjRsD0EhRagKlaoEiiVHX0g0SYAxmD+/QtzVBJtsWMaihE1Ce2WgBUe
	BSuTad3EKWGVy9NnLVVhHYLNJ3lwIrpv87sWvaA5zINABPqu8Adiau7xMVBzvJrHgU8ZgFQBArX
	LV27O9ooSoy85MsTcoxOHM2LA3T87eGIb39HTqMVJUZWhfj9LPThw4/oDh3+KheDIwDZj6ZL8fC
	em00rw49uoNQCeXZh6IE10cN4KaKdP+hxBCgp2frMMdehnRRWrWZ6gxnWijnvnkVNedBsOo8j2a
	3qWNP3ZsXkuCnOsoKEloeZRbqCZ7k9WcAYKj7LwPUL76VGsTiK0E8nQ6xRZe7NsslloA4Rz6KpO
	HZ0kORwukk9hDabUiXr+0eNcp4Ovtn/OqrbYQ4CDrn0ESCoDXdCPzdjnn+g2zIQo08wo7+Z/ZHg
	==
X-Received: by 2002:a17:90b:4a02:b0:3a7:9e3d:b3 with SMTP id 98e67ed59e1d1-3ae8987e31dmr6107376a91.66.1793560860808;
        Sun, 01 Nov 2026 11:21:00 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.251])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae845984absm11157692a91.10.2026.11.01.11.21.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 11:21:00 -0800 (PST)
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
Subject: [PATCH bpf 00/15] bpf, sockmap: Fixes for verdicts, redirects, corks and recvmsg()
Date: Sun,  1 Nov 2026 19:20:42 +0000
Message-ID: <20261101192057.2296489-1-alexei.starovoitov@gmail.com>
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
 include/net/tcp.h                 |  6 +++
 net/core/filter.c                 | 17 ++-----
 net/core/skmsg.c                  | 13 ++++-
 net/core/sock_map.c               |  9 ++++
 net/core/stream.c                 |  6 ++-
 net/ipv4/tcp_bpf.c                | 85 +++++++++++++++++++++++++++----
 net/mptcp/protocol.c              |  6 ---
 9 files changed, 133 insertions(+), 32 deletions(-)


base-commit: 5b96632457e4ccae88ecb751cf48176b2e3629a7
-- 
2.55.0

