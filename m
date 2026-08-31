Received: from relay.smtp-ext.broadcom.com (lpdvsmtp11.broadcom.com [192.19.166.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D60AE2EF67A;
	Mon, 31 Aug 2026 18:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.166.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788202305; cv=none; b=goasV1OrvI1WjaKBZJ6RGnHx8IMv43hmUSZdD4uJo2e+3vcdvgPPStjhQntQUcnnQYX1fH0GYYfU+N+rKQF/VR/YpRK+bzVfRi3PRp4F1GpSJyJVkP712ferkH3PiVWgmnDU2BiE/PabRfaCbO3KePBKK1m5YsYDPnndUDeFM/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788202305; c=relaxed/simple;
	bh=bPni7hRX3VfpjtS18Tixz4pbM+1YxfRfagcWhgZ3xXQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RdsEUXVrhep0td0RWy9oJnag+MYoEN5s511lLp/ChjuXj8ptXL4WTU0Edew7FzX+G6t1KHsRYgXgGsGPH9gr4/XOCoIxlxvFdk9sufE3bX7Bi8dxRma/wsYa1NbyF/I4XU+tem27jShltu7pLKyOP6H1I9DNRX1r9Y5jC76oM7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=pQHD2n0j; arc=none smtp.client-ip=192.19.166.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="pQHD2n0j"
Received: from mail-lvn-it-01.broadcom.com (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 3098EC0000CB;
	Mon, 31 Aug 2026 11:42:39 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 3098EC0000CB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1788201759;
	bh=bPni7hRX3VfpjtS18Tixz4pbM+1YxfRfagcWhgZ3xXQ=;
	h=From:To:Cc:Subject:Date:From;
	b=pQHD2n0j9N3S92X7oH9jgZaVZpjAa+U25mP/6W1lKTbXEXNj/r/zNv5v8InACY5kh
	 4RpHJCMyF/rM4nEvx38SBCxYjm31zUBl6MRPhVn665n/g8/KskGC1Y/Bo1Eolj1MxK
	 mBuQLT/1f0wC/DQXOGXlx7ZtcIyoaAGsoRt433dA=
Received: from bse-build-07.ric.broadcom.net (unknown [10.136.28.187])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-lvn-it-01.broadcom.com (Postfix) with ESMTPSA id 96E9EA9A;
	Mon, 31 Aug 2026 11:42:38 -0700 (PDT)
From: Danesh Petigara <danesh.petigara@broadcom.com>
To: justin.chen@broadcom.com,
	florian.fainelli@broadcom.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: horms@kernel.org,
	bcm-kernel-feedback-list@broadcom.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Danesh Petigara <danesh.petigara@broadcom.com>
Subject: [PATCH net 0/2] net: bcmasp: fix TX ring accounting bugs
Date: Mon, 31 Aug 2026 11:42:33 -0700
Message-ID: <20260831184235.4133351-1-danesh.petigara@broadcom.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Two fixes for TX descriptor ring handling in the bcmasp driver:

  - tx_spb_ring_full() re-initialized next_index from
    intf->tx_spb_index on every loop iteration instead of advancing
    it, so it only ever checked a single descriptor slot regardless
    of cnt. This let bcmasp_xmit() proceed even when the ring didn't
    actually have enough free slots for the SKB's fragments.

  - bcmasp_xmit() only set txcb->last for the final fragment of an
    SKB, leaving stale true values in reused descriptor slots from a
    prior transmission. Combined with the ring-full miscount above,
    this could cause bcmasp_tx_reclaim() to treat a mid-SKB
    descriptor as the last one and free the sk_buff while later
    fragments were still in flight.

Patch 1 clears txcb->last unconditionally before it is set, and
patch 2 fixes the ring-full slot check to advance through each
candidate slot.

Justin Chen (2):
  net: bcmasp: clear txcb->last before writing each descriptor
  net: bcmasp: fix tx_spb_ring_full() checking same slot cnt times

 drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

-- 
2.54.0

