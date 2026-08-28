Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5753C78F2B
	for <netdev@vger.kernel.org>; Fri, 28 Aug 2026 13:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787922136; cv=none; b=uuRdvQWY4HWpRaNhHvrAuWmoSM+8lM0e27TyVwLYs6dIQ4wA4xTY1/kw2b3HPHkTKGUqH+q+C/O4UsKDZlHSuRdrgI/dxkIpbYF4ecXpjVCrQopim3H9dIoWiCfUh6ip2oDtf+GqtFW7k9yfCYv7AB4nf4WgPG/CwLszNRI1SyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787922136; c=relaxed/simple;
	bh=QqzBBu7p8nODo/RmFJm1kAQ41J+L+8YvaBuNF7HBWYk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z0CEHacp5ZOLiw0Dq37ccDMSnmY17383OAh5Kn6hUgi2xmyMWCwd9yAvuofqLhG1ML1pzZxdJJvbON+szgJG2R3qjt3EEPgf0bRYrsuZ6osyM/NnoMxPrTGA/RrC1cWtP3js2kzhdJWHx23P1/qbffYEkHDHeWPj2IzfO2At2ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MKsP1TlU; arc=none smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MKsP1TlU"
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-66de7e0bc85so1443485d50.2
        for <netdev@vger.kernel.org>; Fri, 28 Aug 2026 06:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787922134; x=1788526934; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QqzBBu7p8nODo/RmFJm1kAQ41J+L+8YvaBuNF7HBWYk=;
        b=MKsP1TlUYUeUNOdu8V1C9pJvBi81lkXLkE4S1OivElINshuP9DPCx7gJEDVul60aHQ
         O6B8RkCPTl/CJXugP8mwR1OJ1p9m7ehYskD57AhN2ZDz4e3nRDERritZPgjVEu15LVRy
         nBSSaGRzdLC6jxTKqV4u0vJrtDSn3xph1F3hUgPdoFYxF7vkLRnykoDYMNBik2gI0Hdo
         lf2KGngS4ZsxTN9ChjAxBffVjb+DNyb+QTNJN9V28T1YjgIyqb3CULf4ziTeNelTNhBK
         xFeJxN+/grPnN1+fjaQDj8OD7TNyOnM0mfJ4naf1cgSoxicUCvnF8EEiZIsnEijpR/0v
         RPfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787922134; x=1788526934;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=QqzBBu7p8nODo/RmFJm1kAQ41J+L+8YvaBuNF7HBWYk=;
        b=qTLsaW07SxLKgxNEBlcL92B+g9uJ442ApJgzfe2LB0RvL6nCrMxXadUn2CltRln8Ss
         gzfIk7kyoY+pk/8RoUBW28LN8mlTd7GM5gBzi/9o/ItEQl8xypVin1gOMHlbhesik1B8
         4J4b4N07xxCgLvkTxV/6B+GzbkXodAk2aFkWq0STm/PgXic4sW6ADdbiyd5dkNd5vtY9
         pe11MiexZTOMz6Ley49SYtG5hYrWydvPVR/hlsXyIsqZf0uVTHeE8UjbCoQSqHGsiYMu
         SKrbi93oVXWZ2AKeQ1feq2Yh/88HMcaDpmWYciVZpvU4XglrlPEUzIaabz90FE6i44+N
         yb8Q==
X-Forwarded-Encrypted: i=1; AKwUvBy0ThdTbgf3g/ZU+LbpIWs4oGgSn2SSTnc/nxB+Qrr0UHh0lVGYhTCH/SFg5/gIS+Wy1D+LU3E=@vger.kernel.org
X-Gm-Message-State: AFuF++kcDdxNt3SAi/P+NQZjajd8789mMPHGzqc2XM4KLyfkRHeRB/vo
	fynnN6ztJpoXRjSq6AihT6r1RmC3wkiZWJcHyC44G4p5xbZo5/QCsY8v
X-Gm-Gg: AYBFou29L1etbgTuxu2iu0jIpQvxznsb5HcBaMmvjZi0+30zcMtWn9M6vD81mEcy8ev
	otw//HEt3xmMEFdEjylViL6wWh/HiR3JFRstlvXXmLtvkU/HTF6cyCkF1bBcnGqn6do5EOlTKye
	nAGSNNLE9LsMj2eqirpmf0zDWoW0+WK2odqfq8eb4kVcjdxb/QakppBK0jXIYaRPoKgcKGN7x+l
	0s0ChbgHtIv1axJUGu/VExgn9CDy0xVmmvYqtAgA7e/wLGK/k2KZ3A/5dSZkntRB10WYrqOLHOE
	xi53aO1j19mlIhdM5cmrQOjqb4lVhsLrO1Vjru75h5KIPv2UAJ6uVdGM/4fypoXiI66fGRPvbL4
	i6wbO20OqESdEDz6O0UWaKjzBSaxxR4MWKcalgWfwuumhC9Wvfv170of1ITjArsGevWrPfFw6G3
	1FnIYtqB/6sLHCOBJG3Xu8AQpqMeBtOmGiXvMbubwdDBPe9jhrcgGDLZfxts/j1B+zRynPgQgRe
	Qk7RA==
X-Received: by 2002:a53:c550:0:b0:66d:264e:88f2 with SMTP id 956f58d0204a3-66e4c6eb8f4mr1512029d50.16.1787922134170;
        Fri, 28 Aug 2026 06:02:14 -0700 (PDT)
Received: from mac.lan ([136.55.173.105])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66e4ed39d4csm770568d50.21.2026.08.28.06.02.13
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 28 Aug 2026 06:02:13 -0700 (PDT)
From: "Cen Zhang (Microsoft)" <blbllhy@gmail.com>
To: leitao@debian.org
Cc: AutonomousCodeSecurity@microsoft.com,
	andriin@fb.com,
	ast@kernel.org,
	blbllhy@gmail.com,
	bpf@vger.kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	geliang@kernel.org,
	horms@kernel.org,
	kafai@fb.com,
	kuba@kernel.org,
	kuniyu@google.com,
	kys@microsoft.com,
	linux-kernel@vger.kernel.org,
	martineau@kernel.org,
	matttbe@kernel.org,
	mptcp@lists.linux.dev,
	ncardwell@google.com,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	stable@vger.kernel.org,
	tgopinath@linux.microsoft.com,
	xmei5@asu.edu,
	yhs@fb.com
Subject: Re: [PATCH net v3 1/2] tcp: fix use-after-free in do_tcp_getsockopt(TCP_CONGESTION)
Date: Fri, 28 Aug 2026 09:02:12 -0400
Message-ID: <20260828130212.32968-1-blbllhy@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <apGBE3XHKeNohHF1@gmail.com>
References: <apGBE3XHKeNohHF1@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> nit: Do you need to zero this string? It will be safely overwritten
> below, no?

Thanks for catching this. That initialization is unnecessary. Would
you prefer a new version for this, or are you okay with keeping it
as-is? I may need a few days before I can send a new version due to an
ongoing email account approval process.

Cen
