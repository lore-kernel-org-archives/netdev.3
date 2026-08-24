Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BBAC223702
	for <netdev@vger.kernel.org>; Mon, 24 Aug 2026 03:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787542451; cv=none; b=revyvsJJcH5ux/fHnoIQyHf24IST7cYLsp2glftb5upiPbPJGGKHe1sfciOe+kOXPBem38EDpx2XSogo5sSimPHRYaXX+fWA6mitiU4MssPU1BzPmjVOLp1B0OmkYDFqhpxGtGbbAiF4qffCKijOn+QMwlO+We1hGYnhg/cGjH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787542451; c=relaxed/simple;
	bh=tgc7fQo6gJe8G/SSc6IwY1kqu73qHMplp+16vVw+mgw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tlM25p33d102MugJeQA94eAjgONfx8sy+D1vw3wGFpA7UpRRjzk0Y1kJxny7UgOXrglBUW7OWOT3YCF5PGppZIDNjAApIQ00Ghz/GIpqjnRENHNQT7jA04e27okiPwKvZUW++BurI66qsTPl54/CitQ1QzXR7oefDqvd/mAbpxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AQduA3QL; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AQduA3QL"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-cbee3777e1cso1745438a12.3
        for <netdev@vger.kernel.org>; Sun, 23 Aug 2026 20:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787542449; x=1788147249; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=KXdtuihM1G2t1d7kD4Du7Ico+fC7apAYzZdayGyO9p8=;
        b=AQduA3QLwsfFMUbW6Tes8iwmhWZA0B2OUZAUdrtZjzc+WFQ+9DqrSvEpeafdNJ5ueb
         i2ii8lXPA668BeGqPXoML+6a2j9EK9cHBCP3tEGMY8glf2g03fA5apaNIw2NCGll7vJy
         bJW1uTkI5pW0NFFXZG7mltsTBVZHKk3Rav4ZmyovTckKa4DVC9hRrrVoNEXiSeAXxfV1
         4ELHMI+1o3g5yVdSkL5sXzeRQtKz5karWVb6SKeVKHjRBIfRu+UD8M2nVSxToWe+tDWQ
         4fDL+LpB13jKcGhFCbeTtTLMFovQI9yxZhs9PnTCmqE/aELhDZ07PUJcV3mfJHkgYEGV
         2jmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787542449; x=1788147249;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KXdtuihM1G2t1d7kD4Du7Ico+fC7apAYzZdayGyO9p8=;
        b=Xx7kERmiSOBE27Z0WuoaVYhgTPyRPzOSeqmaQXPsw4KfZ/Hgu7zfnZ/qRNuYPDg3EG
         A63CawsTqhCrUG+2wwNPNCzN2Xcfc1DlC5oCHJQGkBtXPyh/hHyos7NcdcSkL6e2bcrU
         JS7oChRuLxnZZ4amSpDMgI1eTjQG4lWqOfo8eWTXzsy2a4rBnbe+DsqAxhWamoRLlk2Q
         kuNKgAAcPRgTIwhRCyyfpf9T5IFH2B8//Lk5W3lbmK5mj59JqCTqk16ovUM7v2xRtUqP
         YhCMVm1o6KqCC20lvUyOcTbvJfrjtEo/sqRJYSAThq8c+vgw8usHS966KSUuqw9ZEncZ
         9Qog==
X-Forwarded-Encrypted: i=1; AHgh+Rr/RCJm8eBoMbsIrBZVRGk1ZC7z0q7iROVV8AqMeZEy6rvUwQyTR1Lc7EOGWAphaep190xJ6lI=@vger.kernel.org
X-Gm-Message-State: AFuF++kTz9Q37qS2vzOjDNrYAYgD7eoefCtcKLwjScuUP0B8XVdSA8ro
	ioJ0sDqmebWc33b+zuV0eLo4/mOMCnFOpVqBZZh/S7Q5j6bf+eXtwE/1
X-Gm-Gg: AR+sD13TrPx2fPJ157ljbwGZJHSAh8x6WORLR1/wYmojpZ0+ykYhMQP3lmZvGmY0e1h
	vWWlvzXGoYPuH9DoISly3PM3klT3/Yzn7WsVAH6YED5MxM/jaoprb8ig1wC34X6iLIFYAU94N52
	zgziy8DrV7D3G45WBvlZUKdim9edMpMWWumLg6AuBuXG8o5FZluYmkNzdQIxHb6wxj+QVEF+G6v
	UJkm0+BlGkKe1aYp1NOj83hJwlOktbNFGEolxYeNeevsUZJpZYI1tUQxoQRys5hg30y15pGzZ7Z
	1F3sH0NWY+nJJKNOmOk7ygg1I8wU9IyvQJo2J5vz170M/nzbcKgz1xhMcw9QG3AYsjKMsou0kU5
	Z/4qoiJU+IyOvpls/WArfpWW7PQT5FCRw1N3VKerfrPwBzepUrZ7uyZ1pUDhoevAWOW+ut4ZIbj
	kkcsHPtTL0ffm49l1hkSEK8wx8Aem9p7HJn8n9qJaC4EL/wDn++btYly4GJxu+jJdBPegAMBiAS
	y2NyU45j44=
X-Received: by 2002:a17:90a:749:b0:395:f0e8:9e13 with SMTP id 98e67ed59e1d1-395f0e8a0c0mr15619945a91.7.1787542449255;
        Sun, 23 Aug 2026 20:34:09 -0700 (PDT)
Received: from v4bel.. ([58.123.110.97])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-395c8fd34d9sm4227256a91.1.2026.08.23.20.34.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Aug 2026 20:34:08 -0700 (PDT)
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
	imv4bel@gmail.com
Subject: [PATCH net v2 0/8] net: fixes for requests completing on a socket that no longer listens
Date: Mon, 24 Aug 2026 12:32:44 +0900
Message-ID: <20260824033331.1084971-1-imv4bel@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

connect(AF_UNSPEC) and listen() move a socket back and forth between
listener and active session. IPV6_ADDRFORM on top of that turns an
AF_INET6 socket into an AF_INET one.

Two things follow. One is that what the socket had before the change is
left behind: requests still in the ehash, and parent fields a child
inherits. The other is that the socket is used while it is changing.
tcp_check_req() does not hold the listener lock, and tcp_v{4,6}_rcv()
reads sk_state twice without it on the listener path.

Patch 2 is neither. After a reuseport migration the listener that counted
a request and the listener the count is decremented on are not the same.
It goes with patch 3 because patch 3 needs it. Nothing ever resets that
count, so patch 3 on its own has a check that can be bypassed.

Patches 2, 6, 7 and 8 are new in v2.

Hyunwoo Kim (8):
  tcp: fix use-after-free of the listener's ipv6_pinfo after
    IPV6_ADDRFORM
  tcp: fix imbalanced icsk_accept_queue count in tcp_check_req()
  ipv6: fix request socket use-after-free after IPV6_ADDRFORM
  net: fix out-of-bounds write in sk_clone() racing with IPV6_ADDRFORM
  tcp: do not inherit out_of_order_queue from parent
  tcp: fix use-after-free in the lockless listener path
  net: clear sk_tsq_flags in sk_clone()
  tcp: do not inherit retransmit state from parent

 include/net/tcp.h        |  2 ++
 net/core/sock.c          |  3 +-
 net/ipv4/tcp_input.c     | 64 +++++++++++++++++++++++-----------------
 net/ipv4/tcp_ipv4.c      | 52 ++++++++++++++++++++++++++++++--
 net/ipv4/tcp_minisocks.c |  9 +++++-
 net/ipv6/af_inet6.c      |  4 +++
 net/ipv6/ipv6_sockglue.c | 15 ++++++++++
 net/ipv6/tcp_ipv6.c      | 44 +++++++++++++++++++++++++--
 8 files changed, 160 insertions(+), 33 deletions(-)

-- 
2.43.0

