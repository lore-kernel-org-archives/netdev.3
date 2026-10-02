Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06E9B466B66;
	Fri,  2 Oct 2026 12:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790945786; cv=none; b=e2YtqYaAmHjXSLJtFrmgaPr/4XCcE8LL3OiiDZkDQfzN02D2SVN4TowxEyH+DauxXBhBTEZ+S3P0tVJz6IqW86hc5X4FqMOTphfVQYvy1kab5YZGKjrwjQLHkImrp3cJSm1TNwAfh67OIVUH+pabYRdQcHva/XQ5wvaPTFlLfzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790945786; c=relaxed/simple;
	bh=JSaGC6D2aEiZZ3unlrXNp9uBN0sRn/bRihi+jjKpA3w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NhKeZGNxAN8Z0IeDrK26L8iQPq9lxhn+5ypkY45nbEeyI8985h6kbC6I/tLUkfuVv9QYJiES61T1AXjxJIzGARVvxyuO1CQ/n7iWRHsCn5fS+r9gCWBiiNFtbo/4/9cs5WlIV0SF9KCQObnnBxuqYsJvdHhx1o2uNhF1CbInbgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S59jwEf3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S59jwEf3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 000C91F000FF;
	Fri,  2 Oct 2026 12:56:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790945784;
	bh=+/Nk7usIdpaU9Rho8UOq02EsWGAHz4ioL5GfUEnCfwY=;
	h=From:To:Cc:Subject:Date;
	b=S59jwEf3fC5XrSOD/8WzV2QA7dvwovNSh3xhFFg0Zczg9X8i6YMubkEnoR2N9s+W3
	 i3AmfZNnOFZRT4yCVEvlNQ8k+APRyz9yRdfPGGtoyziZP7ADXNAvO/Td9WihZcyPOy
	 e0YFjVfFVyWLHEyZajaS4nuPgwzk6VIX27Wh8Mb/l5gjHl4fcdjxVBbO4fzE1gh0/I
	 VmrZkMsEIn01X3OzfShtE0jWT1iD4wt1YmdL4kDmSHwHWVo6HUhOyXJpKfcRVgS1Ai
	 JlidNTGGw6vLatxoG0kS0ddl0drl/IRt0Tbx0J2EtqM6zddQQUpyCZeo4KP+ooWgly
	 mJnzH5zsXQR2Q==
From: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>
To: Alexander Duyck <alexanderduyck@fb.com>,
	Jakub Kicinski <kuba@kernel.org>,
	kernel-team@meta.com (reviewer:META ETHERNET DRIVERS),
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	"Mike Marciniszyn (Meta)" <mike.marciniszyn@gmail.com>,
	Mina Almasry <almasrymina@google.com>
Subject: [PATCH net v3 0/2] eth: fbnic: Queue and channel count fixes
Date: Fri,  2 Oct 2026 14:56:13 +0200
Message-ID: <20261002125617.409447-1-bjorn@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Two fixes for what fbnic tells the core about its queues.

Patch 1 keeps the channel layout across suspend. Resume rebuilt it
from the queue counts, turning standalone channels into combined ones
or dropping combined queues, even with an unchanged IRQ count.

Patch 2 publishes the real queue counts at probe and on "ethtool -L"
while down, instead of at the next open.

Resume with fewer IRQs than the layout needs now fails instead of
shrinking the layout. That case is left for a separate change.

Changes in v3:
- Split into two patches, one per bug, each blaming the commit that
  introduced it.
- Keep num_napi across suspend instead of a separate num_napi_cfg.
- Drop the -ENOSPC check on resume, so an interface that is down no
  longer fails resume. (Breno, Sashiko)
- Skip ndo_stop when no NAPI vectors are allocated.
- Drop Breno's Reviewed-by, since the resume path changed.

Changes in v2:
- Keep the configured NAPI count and restore it on resume. v1
  recomputed it from the queue counts, which changed dedicated rx and
  tx layouts even when the vector count was unchanged. (Breno,
  Sashiko)
- Fail resume with -ENOSPC when fewer vectors come back than the
  configured layout needs. (Sashiko)
- Fix the comment and commit message that did not match the code.
  (Breno, Sashiko)
- Keep the RSS indirection reset in fbnic_netdev_alloc().
- Drop Breno's Reviewed-by, since the resume path changed.

v2: https://lore.kernel.org/netdev/20260924191817.1843726-1-bjorn@kernel.org/
v1: https://lore.kernel.org/netdev/20260915180859.4157646-1-bjorn@kernel.org/

Björn Töpel (2):
  eth: fbnic: Preserve channels across resume
  eth: fbnic: Publish real queue counts

 .../net/ethernet/meta/fbnic/fbnic_ethtool.c   |  7 ++++
 .../net/ethernet/meta/fbnic/fbnic_netdev.c    | 36 ++++++++++++++-----
 .../net/ethernet/meta/fbnic/fbnic_netdev.h    |  3 --
 drivers/net/ethernet/meta/fbnic/fbnic_pci.c   |  9 -----
 4 files changed, 34 insertions(+), 21 deletions(-)


base-commit: 71a77ab76e74131a101f4d2d2afb0dcbf81b4e3c
-- 
2.55.0

