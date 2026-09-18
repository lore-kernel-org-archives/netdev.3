Received: from mail-pj2-f42.google.com (mail-pj2-f42.google.com [74.125.227.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 010923546EB
	for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 01:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789695227; cv=none; b=l9Q1swgvs/8Gg78ggSYPaUfd+lmy7Cl/R1//aCFuGS3zFD0C9x+3/UVaxWTJLM/ba5ITjPHOvzDzPBtsj2/Up/1z1eyphbZXd6GGa3BwBsvVV2asPSeOqkQJBlK+M7uho1D0NkmDEYgwvaQGpbPmML8y8R+U0YoBiGI5cutZMsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789695227; c=relaxed/simple;
	bh=vQ71nP81xJIGLGl+WldFcoeRSyjZOcokzca2ie96Obs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aU1avLHsKKxzpBFWodB43t/UKITcjb+by4fj5EZEdqtY3J2ZNyRvMzZLU/MYATWchxC8Jl/X+t8IsZBEN7uq9eXL4sCK9U5gHktxfty2nJAwc/TLgGV0mNzwQCf0DT499bG4AbIuusvSvZaHm0nA2F+xBfy0zwRUj/VQWlRMTfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F9KplXRv; arc=none smtp.client-ip=74.125.227.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F9KplXRv"
Received: by mail-pj2-f42.google.com with SMTP id d9443c01a7336-2ddb44ad1c1so1272975ad.3
        for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 18:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789695225; x=1790300025; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=S3eHLQ4W/b80X19nrEr9wAXnZ5B6H1Ytyc3QQvQncgw=;
        b=F9KplXRvTQLO1Vy0xt2ZkpkZHJZ1PGLY0ON/wd2amdzH1fWFOunOdY0HeDoqiqpVDw
         VH5J3wFaRxfo0xtb8Oa0V5kB/AoUwBQEMJYI4Dy+6z4kTVQEFWh5/KsFhydbZDC9GT+8
         4ZG7NVjJ8YxTP3E9OygkS0j/muscuf4uYGmdENq5prt/QfRKiv00EaNMialvt9gFztux
         k952Cqtr4OEqofuN3mktDveL7bJmZGlEMLo6f0/g2tLeBxGQ5nB91SMT1OTq1Bib/c82
         fuqasDib/oxt0h3KcySvI8WIwTW2nBWlPfi2A9Gx7mYRh2G7mC6vb5sEutFhVBWrCPJ4
         KD9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789695225; x=1790300025;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=S3eHLQ4W/b80X19nrEr9wAXnZ5B6H1Ytyc3QQvQncgw=;
        b=CQHiY/UTUuSS+O+ilguHHuA0Po2JEtrEL3djsepiM1wdc1JtEzKmQNC2HKzmFnl/79
         KhbRxvzeJXRCTjdOrGqEM9XhxRWa3PW6iYKyuoTm8StvT9SDwsuUyLBGR+XDXV+nss4G
         K+4+5forH3+vbdUxKVC6wDvXCxOPQSOtI7tI5jrFmlqi4Ri2fRHwkognWiWXLvE7FLg/
         yrp+wwP9ZDX+FJRF9H7sSQk5hvZW1AbvmjFkL7xl9hy0O27MYAAMXeLqzLK5PTDtKa73
         JcQXKJK+HSUn6fRT3sDvB47p1FfuY/cP6NNvEkf7vzgHO82sWe4v11FDNw2qqjlDZ9QA
         Y09Q==
X-Forwarded-Encrypted: i=1; AKwUvBwWCI8Kx2lW5Elc8BfISzrUaxWjlloDvykg4kYihw/rI4PJS4VPiQgON8HFiG4KvDT/QfNMEg4=@vger.kernel.org
X-Gm-Message-State: AFuF++mj6+F/5kZIy/AFKpBX5bZLXPZkBruYQ5wrXaqqNOhohRfoxDgP
	ERX/nj21BP4tqhumm6E2g7F0vVtBBxnXZKRkPPJZ9vRCeBK/BIl+HrIA
X-Gm-Gg: AYBFou3W5pIBkim+d9uKTM7CSsc91OZNuv1JCjR/hza5EwEBzlS4FZOLCAVQrtMpH6l
	KgFQam5H5aSvduQvCD1VF2kf/POgknlUALaUFjaJ6ipggU099TvFbT9glyFBe9iN/QpUody7Y/9
	gRdkrbVG4Fn5GTtgio/1b7EkFgWvCM5PrjqksRGKE7Ofwix6wp/jJEO8JliH9QCBeoTbepgJ+Iq
	9A5ppcyiWneLmydgkvHkPYOm/lYOj+QyH3YxoxUwd4PZ79fWr1j00homjeOLHTrFsmByHaxqlcQ
	2TBYnKbe/s3To/eIz3TATb+K0HhGeCXy+DtHBPTb25gCxI2M5149n7ocFjMhD5cV+3Jf/EXrTX0
	i8awG27uSU8cMVgS6aoPG1mZcu1oR0xVcLmsWccQHbavTP2Ie6EYBZxuXkVE1re8B3maULUPFZ3
	WZf0sylnm6lnRYbOI4naiwg+TrpVOmBO6g+DdmARu3YbCxhH/fqSrenEslH/+f0jALtFY3mmvY9
	aQkSULWUZIeZsTrJwm7+Kcs8tPQKZQeW8vqW4Y=
X-Received: by 2002:a17:903:2f84:b0:2cf:8131:75e8 with SMTP id d9443c01a7336-2ddb1af51a9mr17366565ad.13.1789695225346;
        Thu, 17 Sep 2026 18:33:45 -0700 (PDT)
Received: from localhost.localdomain ([2409:8a1e:2e81:7320:e17f:a362:fc0a:a2ab])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33c2872052fsm40520eec.11.2026.09.17.18.33.42
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 17 Sep 2026 18:33:44 -0700 (PDT)
From: zjamg <ndaugoing@gmail.com>
To: David Heidelberg <david@ixit.cz>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	oe-linux-nfc@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yuchao Zhang <ndaugoing@gmail.com>
Subject: [PATCH 0/1] nfc: nci: ignore unexpected CORE_RESET_NTF
Date: Fri, 18 Sep 2026 09:33:36 +0800
Message-ID: <20260918013337.82214-1-ndaugoing@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yuchao Zhang <ndaugoing@gmail.com>

Hello,

This patch addresses an issue in the NCI core stack where an unexpected
or unsolicited CORE_RESET_NTF packet can prematurely complete unrelated
in-flight requests with NCI_STATUS_OK and corrupt protocol version state.

Problem Overview:
=================
Commit bcd684aace34 ("net/nfc/nci: Support NCI 2.x initial sequence")
added nci_core_reset_ntf_packet() to handle NCI 2.x CORE_RESET
notifications. When received, it updates ndev->nci_ver and manufacturer
information, and calls nci_req_complete(ndev, NCI_STATUS_OK).

Unlike other notification handlers in ntf.c (which validate ndev->state
before acting), nci_core_reset_ntf_packet() does not verify whether a
core reset request is actually pending.

If an unsolicited or delayed CORE_RESET_NTF is received:
1. If another request is currently in-flight (such as CORE_INIT,
   RF_DISCOVER, or CONN_CREATE), it prematurely completes that request
   with NCI_STATUS_OK, leading to state desynchronization.
2. Even when no request is in-flight, it unconditionally overwrites
   ndev->nci_ver and manufacturer info. Because ndev->nci_ver acts as
   a parser and packet format selector (e.g., in nci_open_device() and
   nci_core_init_rsp_packet()), unexpectedly modifying it can cause
   protocol format confusion.

Solution:
=========
Introduce an NCI_RESET_PENDING flag in enum nci_flag to ensure
CORE_RESET_NTF is only accepted while a reset command is actively
awaiting it.

Testing:
========
Verified with module compilation and checkpatch.pl (0 errors, 0 warnings).
Empirically confirmed that unsolicited CORE_RESET_NTF packets are safely
rejected with a warning while legitimate reset sequences continue to
complete normally.

Thanks,
Yuchao Zhang

Yuchao Zhang (1):
  nfc: nci: ignore unexpected CORE_RESET_NTF

 include/net/nfc/nci_core.h |  1 +
 net/nfc/nci/core.c         |  3 +++
 net/nfc/nci/ntf.c          |  5 +++++
 net/nfc/nci/rsp.c          | 15 ++++++++++-----
 4 files changed, 19 insertions(+), 5 deletions(-)

-- 
2.53.0
