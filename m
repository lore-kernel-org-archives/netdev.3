Received: from mout-y-209.mailbox.org (mout-y-209.mailbox.org [91.198.250.237])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A7862C11FA;
	Sun, 29 Mar 2026 14:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.198.250.237
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774794898; cv=none; b=Afta0G7u40UPt7anoORMI5fzh1x9nqg7tyAru89F1/eiiZfWItUIC21GSvUlixCr/3HW7VdoMa562a60Ry6uDqZI9q9GMMqqbRgAEmYEPa/Ki9mw4u11LbdRtRdd5JBc3JNTqAAkBLDn6Io7IPnelTVnJpUD0ow0kK0/WSGJB0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774794898; c=relaxed/simple;
	bh=mFOfVxg4beDGDW+HklWbQmFzVFB7631Kyj8xJRxOpL8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=COtJthGjAaocH6KIvmXMq6Rnf3NprZvVQFhKGPTgpXpurU/VISrZApI91MVee4LMFVBdwu83P1JrFPLwAvGQA0ethn3zKmLksN4jbKHAoJuJURdQCGZBDCs7giBRW8TWYE1vskR49l/MlQfLBEDZnggztfNK57UPdI+MYgmlp00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=rN9rivMR; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=LqwAp41z; arc=none smtp.client-ip=91.198.250.237
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="rN9rivMR";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="LqwAp41z"
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-y-209.mailbox.org (Postfix) with ESMTPS id 4fkH2v5gKHzB11x;
	Sun, 29 Mar 2026 16:34:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1774794887;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=fob0xdYkxSEYz5yn46BkFSAJQg8OhKURrvvxcepZJhs=;
	b=rN9rivMR3Vc4UTKtWiOMZW1CoI+RoDk/rzJREy3uLKlr9522ifUmIUyotlSFz2n+wK4jRJ
	p1JzB8HU7iD+rlRzllOqdlww+gnmBAd3kQKH5ZdYz6qooKk78l2DL07F9XWcIMC+4CANGy
	xSO0SDGL3ZOC3nOjpXOX8bTJ3wiVM+ZlWctQ8sc0NI7kzsDDIQ5RoWetSpnKz0/hk61RK1
	HExlbCQz9WZVLSszr+y+VDogk1TdICPE2Qw6MNLqBLXnBc4vhJ3haMKnyKBtY+qruyG5BH
	ZzJQbTjAG+pBZpxgSA3Op8YPns7SduHmWWsOa7M6ZzmHHQPnkDI0bWFt98EJVw==
Authentication-Results: outgoing_mbo_mout;
	dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=LqwAp41z;
	spf=pass (outgoing_mbo_mout: domain of mashiro.chen@mailbox.org designates 2001:67c:2050:b231:465::1 as permitted sender) smtp.mailfrom=mashiro.chen@mailbox.org
From: Mashiro Chen <mashiro.chen@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1774794886;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=fob0xdYkxSEYz5yn46BkFSAJQg8OhKURrvvxcepZJhs=;
	b=LqwAp41z0gfWJM8Yj1mFU6+YuNK6tYyHIa9JtvcJ+DLUHlgFZ+9ijilzsPzchq2GV1mJV1
	vZ3LJ7j2BMzIk1iZIIhbW5HG6GXwqLJpaYAWdFq8UMhDw51ynQJOmbsTam6TvxG1jCU9IM
	wck5vKzV2AlABAeUtHxBODRex8cW98l4qbitLZZ28VKThAA2Qj/XbziYfSPTHP/8YLgYoU
	atEIfR4se0bvqGI64eLdwKdgdEaJOrNrwaZxdj0Cd3RcDfyWtpGc6RzaqYEuAXYe/BWEH7
	yu71yk6EVW6KDhWFMurYRkxWlyJNLmC3OqETEHwHj6wv4PvB3ysOIzDupKy+Hg==
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-hams@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mashiro Chen <mashiro.chen@mailbox.org>
Subject: [PATCH 0/5] hamradio: mkiss: modernize and clean up mkiss driver
Date: Sun, 29 Mar 2026 22:34:03 +0800
Message-ID: <20260329143408.747197-1-mashiro.chen@mailbox.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 73f3938f14cdde63320
X-MBO-RS-META: y4s1mx1rtgyyy8tdfn969h1p63oq17ud
X-Rspamd-Queue-Id: 4fkH2v5gKHzB11x

This patch series modernizes the mkiss driver, which is used for
AX.25 communication over serial lines.

The series starts by moving variable assignments out of 'if'
conditions to improve code safety and readability.
The second patch removes redundant static initializations to 0.
The third patch fixes missing spaces around assignment operations.
The fourth patch modernizes the logging system by replacing legacy
printk() calls with netdev_* and pr_* macros for better
device-specific context.
The fifth patch addresses remaining checkpatch.pl issues, primarily
converting space-based indentation to tabs, aligning parameters, and
fixing comment formats.

These changes have been compile-tested.

Mashiro Chen (5):
  hamradio: mkiss: move assignments out of if conditions
  hamradio: mkiss: remove redundant static initialization to 0
  hamradio: mkiss: fix spacing around assignment operator
  hamradio: mkiss: modernize logging with netdev and pr macros
  hamradio: mkiss: cleanup indentation and coding style

 drivers/net/hamradio/mkiss.c | 98 ++++++++++++++++--------------------
 1 file changed, 44 insertions(+), 54 deletions(-)

-- 
2.53.0

