Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E92F23EAB7
	for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 02:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784773090; cv=none; b=NOPJy76PUtRpnQQMUGSqA8jQ9LCe+qOr++E8SGU7v4ZwKOC4mrdBYrKHqi/eTrZm7BlYlwDQ7l+ZKSieIJNG5p+K+3ADu7R8d/Pv/8zdspgJKlSiDmezjk7bWIZP5fRHbpTjjeR61mJbdarr1FqTw4XOzGIsAE7mBh9Io3uLEQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784773090; c=relaxed/simple;
	bh=cEYo9hamT3hA/wq0f9aico1GziIfGODfkMW2+zg1qk8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=k5tXPmx52XKdDsqprg7NVVsvPwA8i7AJKLcF5RZJjMB+v+8GZE4nEW8s9hme8Mbni8CvxZlq8gumIYCpIeApdFbcfD8CIQkuPiydg+dK5xWyeKdQ2TEn3xTyL/9LYIVJNgz4alfQKCsT5Wkdw8vQCUTSJ3ohSFvKj1VA+5DobyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=g6ZEU/Gh; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="g6ZEU/Gh"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784773086;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=MW/PYXUP/4QRdDpTIrbkKz/3/nGq94pRcQKJUx5I8QM=;
	b=g6ZEU/Ghs4uDRelmG5OckfMJH+BQwbW7KTu5Vqv5TO+HIP5tKQxkTg0t6IfdbpLU8YkCMW
	dL7HDKwq7UQ6rGRZ44bRO44pBwEqdKxYO2i5xgKwrjqfvOoVBmF0WcSuZ/k/NDWu3emPgl
	l7K0a1JKgRwZpVoXD6PaNGmAeEi7j84=
From: Chenguang Zhao <chenguang.zhao@linux.dev>
To: bh74.an@samsung.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	chenguang.zhao@linux.dev,
	Chenguang Zhao <zhaochenguang@kylinos.cn>
Subject: [PATCH net v3 0/2] net: sxgbe: fix descriptor ring allocation failure handling
Date: Thu, 23 Jul 2026 10:18:18 +0800
Message-Id: <20260723021820.203960-1-chenguang.zhao@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Chenguang Zhao <zhaochenguang@kylinos.cn>

init_dma_desc_rings() leaks already-allocated TX rings
when RX allocation fails, and sxgbe_open() ignores its
return value and continues with invalid DMA rings. Fix
the cleanup path and check the error.

Patch 1 frees TX rings on RX allocation failure.
Patch 2 makes sxgbe_open() handle init_dma_desc_rings() failure.

Chenguang Zhao (2):
  net: sxgbe: free TX rings on RX allocation failure
  net: sxgbe: check descriptor ring allocation failures

 drivers/net/ethernet/samsung/sxgbe/sxgbe_main.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

---
v3:
- Patch 1: Per Vadim’s suggestion, reuse the existing
  code for cleaning up Tx rings

v2:
 https://lore.kernel.org/all/20260722014055.157269-1-chenguang.zhao@linux.dev/

v1:
 https://lore.kernel.org/all/20260720024747.504493-1-chenguang.zhao@linux.dev/
-- 
2.25.1
