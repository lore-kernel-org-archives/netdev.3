Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53FBE34D911
	for <netdev@vger.kernel.org>; Wed,  4 Feb 2026 05:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770184310; cv=none; b=jm58FctMOvRUysV1Ch4ui20LsGEUr7S2S2cf09zBX6jq3xqWobYkb6BowkGjaQp13C92rcP5A1IIfrHrQZoG5vYfBcHwwnnQ1vDb56U2Qj5VLlniwg+FPj7C0IkskR3MiEGtsUjX/iQKUVe97YWcLYXq4LcfKQrms/2vj/jypLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770184310; c=relaxed/simple;
	bh=HAj1x4/x7EaWdEMVHOrvZvP6qEK01zdI9sDM1k3aNYo=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=buHsiHeTIoM2gjl+aGrZfmrqcosta6XbNkao5nGEXPzQLDYHH7yxICdAR/Xcz0kZLnVtAwaA1taTenOvFkcURCvAYma+jtsFeRkE03M4wqIjep2YPtWHtcVO9+WZX19bD8ZSCBuVDQ4iGdxJ1qVWlpY1qyZqh1ErTfDE7J3v19c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=stl8KIuq; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="stl8KIuq"
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-8bb9f029f31so2062733985a.2
        for <netdev@vger.kernel.org>; Tue, 03 Feb 2026 21:51:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770184309; x=1770789109; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gOcMhld+vwK7cF8G1o7Xvr4flUuWe87iLrDhQ0cNXI4=;
        b=stl8KIuqCN2hOCVdNd5QMbMb1G6DJJanqpj8UgBmwnrVM63CU8tbqBYpmpDhzzbA56
         Y0OMuwgrBEjzF+xrtyFcCgEHvDDeu08ZQiu+NY5Ci3vS2IAf6FKOLrJChZayxRtWzrz8
         aUK+kHu/CF4mUDULXqulcZy20XSUCaTyb5g/bkLr3eKywEurqmM7xNQWpUXY2aQpqEY+
         fswlJZQxrsKmsBUMTOSnPhYkKyjpR4IhJ6s4mIaXy4rSJK8inPj/Nw5J5C416aecj2Qp
         4o4cjM79Jul9Tn0nmx4mX3aVoMWbUipwnjoNQhyaSlPtLVnRb/svGfd1RiEMnloBPOnv
         3g9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770184309; x=1770789109;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gOcMhld+vwK7cF8G1o7Xvr4flUuWe87iLrDhQ0cNXI4=;
        b=MdDnE8Hu0ZrJ5gcKFTl3bch95zYJkOsdpOIa/lhx1V5ASH1YD2GCtyh2aPwbUCkQEW
         QHMwmi+L2L7/jfXBcoYYumMHYxJOlBHDSHcESlNueJao6U5LSMGWhNeGSBu+n4xoMyBr
         ycZJhyRRiF/K2EMav0MNpDk/Q87tckXF9wucCOzlf/prVqxOOt6GMLgDrLM5V7mzqHQe
         TMyzeDz4Nq9HJwtl/KPNtBkuugWhUHUyZ4HfNz0qtz+2qhnfa/wPVxKrBfcDO1VhoMzk
         BhRaJA+1qvVSzx7L6U+v7c7nswWA7qJVrOIJRqIV7SLUfk1D4Dli/AWn4OY/34mpvYLu
         4NEQ==
X-Forwarded-Encrypted: i=1; AJvYcCUWfkSNMsSVh92RDZPUQpTVMBlchTfXiYvZmsxOmM2e4GCpGPg33ZbO6UM4LWPdTsbGLKdpVhw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwKRw7cxf8DJ10U7docnFjzbolPcBIVx6FwW3nk9z8SfG4TNry
	V11Ocby0v/Jd0kNLN28UAp5rZFchg6GK6Q9AoSvWnjsPjejO34O4vfKhUkrFyyhJs6XfwxPt7TN
	pQlZEbcAsTOlT0g==
X-Received: from qkbbi5.prod.google.com ([2002:a05:620a:3185:b0:8ca:3170:e839])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:f11:b0:8b2:db27:4270 with SMTP id af79cd13be357-8ca2f9b71e6mr265608285a.48.1770184309128;
 Tue, 03 Feb 2026 21:51:49 -0800 (PST)
Date: Wed,  4 Feb 2026 05:51:43 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.rc2.204.g2597b5adb4-goog
Message-ID: <20260204055147.1682705-1-edumazet@google.com>
Subject: [PATCH v2 net-next 0/4] tcp: remove net/core/request_sock.c and no
 longer inline __reqsk_free()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

After DCCP removal, net/core/request_sock.c makes no more sense.

Move reqsk_queue_alloc() and reqsk_fastopen_remove() to TCP files.

Then put __reqsk_free() out of line to save ~2 Kbytes of text.

v2: use EXPORT_SYMBOL_GPL() instead of EXPORT_IPV6_MOD_GPL for
    __reqsk_free (Kuniyuki)

Eric Dumazet (4):
  inet: move reqsk_queue_alloc() to net/ipv4/inet_connection_sock.c
  tcp: move reqsk_fastopen_remove to net/ipv4/tcp_fastopen.c
  net: get rid of net/core/request_sock.c
  tcp: move __reqsk_free() out of line

 include/net/request_sock.h      |  11 +--
 net/core/Makefile               |   2 +-
 net/core/request_sock.c         | 127 --------------------------------
 net/ipv4/inet_connection_sock.c |  19 +++++
 net/ipv4/tcp_fastopen.c         |  86 +++++++++++++++++++++
 5 files changed, 107 insertions(+), 138 deletions(-)
 delete mode 100644 net/core/request_sock.c

-- 
2.53.0.rc2.204.g2597b5adb4-goog

