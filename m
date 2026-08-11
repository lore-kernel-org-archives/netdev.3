Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2E5943C7DA
	for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 10:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786444716; cv=none; b=qwWBCYK+PfByInHiSqoMDUFx9mCh1M8AIc45rWvaqUaGmJK5kqVOlWVX53daUUphm4PB5ryp4+0cS46vvGKEw/NKo1IWDdGx6xPh0txP7g+aE/OsPF1RQBxt9whSE4qZH70L87EIdW4yw3R4ct5ACbcNB7e4ttU/u7+ihBNDaIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786444716; c=relaxed/simple;
	bh=HZv5nZWLw3BgxB/qX8toj994Rb0AWVsDgi9cLIvTv64=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hOCcN1hKvdlpdKAn0RC0xs4PMzJvG5jYryKcV7yfIEgIy5wlS2xdhlZzRdg4QyVpf1AEU2ujrZX8L7K0i4weoKw/fh4iECbRWjyK8tbq+jglwcQ+EsTTdtxGueaQ9moERf83h9fnySbpopo8fGBfmcMZ3A3bfWHt0cBpf5mewK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qrW3kvzJ; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qrW3kvzJ"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1786444702;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=yNTwC1rGcqWZrSlVej/Mu2ygchThiUoxpRGozzzwlDA=;
	b=qrW3kvzJt0s5hl/AltKuKol+s3vca8XM+Lxh/R4gKaxfR4NaS/JkEYhEPAP3UfSnwCBfS5
	JZ4An+ig7WIE5QhHlYuUvT00fzUpZYE8b/2E8exH347NCPo6ZXcOBKlR17W7gum7N2Jjma
	T5hmnChVQ2tR7LuvQ9Gvmi4hHSBEC2A=
From: Xuanqiang Luo <xuanqiang.luo@linux.dev>
To: linux-renesas-soc@vger.kernel.org,
	netdev@vger.kernel.org,
	niklas.soderlund@ragnatech.se,
	kuba@kernel.org,
	vadim.fedorenko@linux.dev
Cc: paul@pbarker.dev,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	richardcochran@gmail.com,
	masaru.nagai.vx@renesas.com,
	luoxuanqiang@kylinos.cn
Subject: [PATCH net v4 0/2] net: ravb: fix PTP clock lifetime
Date: Tue, 11 Aug 2026 18:37:31 +0800
Message-ID: <20260811103733.62599-1-xuanqiang.luo@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>

This series fixes RAVB PTP clock lifetime handling. It reports a cached PHC
index without accessing the clock pointer and drains PTP interrupts before
unregistering the clock.

Patch 1 caches the PHC index and handles registration failures.

Patch 2 detaches the clock with xchg() and drains the PTP IRQs before
unregistering it.

---
Changes:
v4:
  - Rebase onto Linux 7.2-rc7.
  Patch 1:
  - Cache the PHC index separately instead of locking clock access.
    (Vadim Fedorenko)
  - Reword the subject and update the commit message for the cached PHC
    index approach.
  - Add Vadim Fedorenko's Reviewed-by tag.
  Patch 2:
  - Replace priv->lock serialization with PTP interrupt disabling and IRQ
    draining before unregistering the clock. (Vadim Fedorenko)
  - Use READ_ONCE() and WRITE_ONCE() for lockless clock pointer access and
    xchg() to detach the clock atomically.
  - Track the error and management IRQs and synchronize all IRQs that can
    invoke the PTP handler.
  - Update the commit message to describe the interrupt handler race and
    the new teardown sequence.

v3: https://lore.kernel.org/all/20260806095126.57803-1-xuanqiang.luo@linux.dev/
  Patch 1:
  - Omit Niklas Söderlund's Reviewed-by tag because the implementation he
    reviewed has changed.
  - Describe the NULL pointer dereference before the first open as the most
    likely failure mode in the commit message. (Jakub Kicinski, Sashiko)
  - Normalize PTP clock registration failures to NULL.
    (Jakub Kicinski, Sashiko)
  - Keep hardware timestamping capabilities independent of PHC
    availability. (Jakub Kicinski, Sashiko)
  Patch 2 (new):
  - Serialize PTP clock publication and access with priv->lock, and detach
    the clock before unregistering it. (Jakub Kicinski, Sashiko)

v2: https://lore.kernel.org/all/20260802090750.116215-1-xuanqiang.luo@linux.dev/
  - Only advertise hardware timestamping support when a PHC is available
    (Niklas Söderlund).

v1: https://lore.kernel.org/all/20260731063254.71260-1-xuanqiang.luo@linux.dev/

Xuanqiang Luo (2):
  net: ravb: avoid dereferencing an invalid PTP clock
  net: ravb: serialize PTP clock teardown

 drivers/net/ethernet/renesas/ravb.h      |  3 ++
 drivers/net/ethernet/renesas/ravb_main.c |  9 +++--
 drivers/net/ethernet/renesas/ravb_ptp.c  | 44 ++++++++++++++++++++----
 3 files changed, 47 insertions(+), 9 deletions(-)


base-commit: db2ddb87143519e20a95aa36c60b36107b736a58
-- 
2.43.0
