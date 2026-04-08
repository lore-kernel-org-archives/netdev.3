Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F3387262B
	for <netdev@vger.kernel.org>; Wed,  8 Apr 2026 11:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.38.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775646631; cv=none; b=ZBhHIhIclBgS0Xzj++g1vyq+GAB/68A2nvXF5YmD2Kg+AKW19jyUVPjnsklsFek2rzrNQmy26+z6Hshb9WDkQCqaek5eZb7sB6X2EUJLu4cy3A1nLjVwYOMhMZlpbgVakTyK2GpyDM4sT9RxtcsFOERIxkQ/XcZc+aXc8fmK0m4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775646631; c=relaxed/simple;
	bh=tiM9soazBexXR9pitUUv21Z3ijIkBF8LI4RfVYgtD9M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jKIe6Wik0FAi1Tgal9A9fIavGODdFvRbVcjDTjZQga+LwOSbQ/ZM/uXTSWPxai9BpcEtqw2fvXzlSZvwWcRg71DsgaHYdmMplfQp/DdyoeaJ9wIDMPOOyMccnxHQaTWpSu3GaX3hxs7QRBOJKusQ/AThI1LxHOsLt+nyrUvZm3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de; spf=pass smtp.mailfrom=simonwunderlich.de; dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b=mqrZy+Ay; arc=none smtp.client-ip=23.88.38.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b="mqrZy+Ay"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1775646182;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=pJS2ibfOWyySj7tquSq/UocQeHFXSHfn/HFR9aV+i4Y=;
	b=mqrZy+AyIsuGGaULaUhSwNWvYnzFI13etUrR5xa0reTzbXUSPagIzqtXiq/0mcuap+KGjd
	43OaVeulFeo56UFFDUH5q7uEBbZV0raavHkqF3qCci1XukfhRCKqJ5lNY3Dn7VATEJWf05
	It7gqgtNRUFReLswtLfFMNPMFG4U+WCK4OaCqUIo3Xawzzwgy3tSh6UX4VYF97omYCQfKM
	nz7GoKWgcyTYylkjIeXuFBK8xIto+K1RgB9iyc3jH0fC0bqcbYYoGSUVU5daFaVlydLsm1
	rTJrjoP/WzvyBLDvSNzinYfMDApX2EnyTZ5jA8+cXStMYpfRT1ojF4tJvb8FfA==
From: Simon Wunderlich <sw@simonwunderlich.de>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: netdev@vger.kernel.org,
	b.a.t.m.a.n@lists.open-mesh.org,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH net 0/2] pull request: batman-adv 2025-04-08
Date: Wed,  8 Apr 2026 13:02:53 +0200
Message-ID: <20260408110255.976389-1-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi David, hi Jakub,

here are two bugfixes for batman-adv which we would like to have integrated into net.

Please pull or let me know of any problem!

Thank you,
      Simon

The following changes since commit 0d4aef630be9d5f9c1227d07669c26c4383b5ad0:

  batman-adv: avoid OGM aggregation when skb tailroom is insufficient (2026-03-14 08:29:47 +0100)

are available in the Git repository at:

  https://git.open-mesh.org/linux-merge.git tags/batadv-net-pullrequest-20260408

for you to fetch changes up to 82d8701b2c930d0e96b0dbc9115a218d791cb0d2:

  batman-adv: hold claim backbone gateways by reference (2026-04-06 15:42:29 +0200)

----------------------------------------------------------------
Here are two batman-adv bugfixes:

 - reject oversized global TT response buffers, by Ruide Cao

 - hold claim backbone gateways by reference, by Haoze Xie

----------------------------------------------------------------
Haoze Xie (1):
      batman-adv: hold claim backbone gateways by reference

Ruide Cao (1):
      batman-adv: reject oversized global TT response buffers

 net/batman-adv/bridge_loop_avoidance.c | 27 ++++++++++++++++++---------
 net/batman-adv/translation-table.c     |  9 +++++++--
 2 files changed, 25 insertions(+), 11 deletions(-)
