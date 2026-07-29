Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EB9D382F28
	for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 22:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785363536; cv=none; b=kglgiQN2v9KdMvYX9eerJIcwQfDOlWODDWbzFvHOlQLWlJDbvbltAO8Pw+omoDd0ynGrwmdVtP8OMXSm180O6Oa7I2BWJ8CCgpkHrrZWf4OAJCdIgHU2TWjZQPjHvtUSUl3++U/rcbjyH360Q0xTVZL4WbF7oN/fydYCQbuNGPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785363536; c=relaxed/simple;
	bh=p6YT1ojFdHH6dPJ1COfHWuAMGY4uAomeoBbLL9a11c4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LJl9jQ/cTsUD06ezSCKmTY9+dRp+QW5BWLTN+GX0Hx3QoP//9B8KnaxLIaNmIRGdsYKGIa5rxUo9K3Rug70YqGVAlcIozI27ZTetsQa//+B/MaOV2DYKn9yVK/OFi8gh+BQqzg6wMleggQUEq6b7Qh72QTk6WnxhcaLhYF7IShI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=WbxB8sTU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AJM9TKQv; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="WbxB8sTU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AJM9TKQv"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 629531D0033C;
	Wed, 29 Jul 2026 18:18:53 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Wed, 29 Jul 2026 18:18:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm2; t=1785363533; x=1785449933; bh=OScgmI7bI0slUvvJcmdn4
	OlxoI8boCp/h48Nv/WH/2A=; b=WbxB8sTU/5Mdf/f1vwJaSZBRgjrYHjp4dENIx
	OukbojFMsqHxnDXTH5RbwuR4+qbkIm0+Hly3owLcEcbAnhzCCXUmCVL4G4Qp3/WJ
	hPF6K0yEF10yy0wgeWpIEj769MVjmv+W1NJCtXMvhT/uubq86+ykURlALtnubCGJ
	nWI6+FwBceO7dCTqnjhX2ZAFrNA4+mWEDTkx67Xy1SjGgY5dFqL3KoTUpVM56srN
	GqSVNS/0yTmqA8Tmhm0GLlx/V07wvJhjzAQ/4T60JEWAEdlPTNGm403mg4RTs+Ki
	uBY1mawrTWqk0yDgL+XJA4g8aS/PX6tBZSW/PifIxgONeKJ7Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1785363533; x=1785449933; bh=OScgmI7bI0slUvvJcmdn4OlxoI8boCp/h48
	Nv/WH/2A=; b=AJM9TKQvvtoL0K8NVHiMbV17KUbMX7gTg/xzP1oVy4A+6JP+lXX
	qPdJGFREN/NLjeax8+1UC9QIFP8BtrsNGObkHXYbXG1C/oOksVXYzuKkKM7XkRRv
	c3DVzWMmAZrY1ITNdgbsjHVICF6HN8qzcOTM+eAIVmIr7aiQ0ZhEQiRzHO5wQGAY
	P3CTcFEKFH0L2h+FbcfBH35RlZY98j90vwVkwI0bHEs+P3R3XZ9311NEdbuE6JUB
	sphjrMstB0u3Ro+NpKF5oT2sOAxOhOd8A/cx1MpRcHnLmsDTfG3NuShHr7Dpn7qr
	KwSIC6z8wCehH4/DLX3lPcQPL7W6W9PNd8Q==
X-ME-Sender: <xms:THxqajbC-kVZNs27WFN1V3l_8cTfcjBLFj6o8rMbkxOkQ0ZnX-7wPw>
    <xme:THxqapQbNg9uD6H3klZkoO2S2IBwHMl9hXKElvcbkzAtLKIYpT8W-6PnBl5YfksF_
    1i-c3QoAcSVbXx49miIj3R1DMWFuxlVw0oNcxaeL4h_l2LFgFjP6IA>
X-ME-Received: <xmr:THxqauRIU372VAtfvjJcMbwvmZzlI23n90p_6FDp3LOlTWNTWbbrTshtrFmtOg2vzxCnQ8oQPmp3E21fXniB>
X-ME-Proxy-Cause: dmFkZTGZTYMpZx7npKrobN2GRfEQSy3971WhVLbHQJJtJzfcokwFL0IWR/DYPuuTierWNv
    ox2BMQR2xC3PY9KNZyU/9BCKRehWtXuoqooi3FHjPW2GvQ6orEMLQtEwdARECdfNC6wKjc
    SKhHCsGh0Zd6OwH2eLmlXoGd/ENGpng/24JvdFoFmti3em/nvcp5zMQ5U5bow8kbwyB9bi
    4NGXnnZNqIfstjLgwfmy8dg1m6Fy7HkAWNGyFZ8y4TAo1Gb6PFVSqXOYRjdC6cyMsRkf4m
    4WeNQsixacMnzMTmQDiFMsoRM+pBCHgNkOmGEEmFo0cU8BQlZSBLBTEzvdwFZxHDU46THf
    9jjqd1QQhvSV8EQIWPsbtQg+eNOr0xPU6WwtCHkO0ckKZ7nrOszC3KC+8fi6+U0xaSjcYk
    vRQ+Om5PvpX71GSnIdnVZ5e06vOj5uOelFlNoAIBQ23VERyAtb1MQR2mWTEPAsAGpAH/cC
    lI+enURK2GPaqeVMs2mbfqZHWh+RN+r/v95zf0FZv5DRk7rEQXiIxU8gvRGbnAgx/1Dxsi
    utV9veFLfpMK5qRvflFiCj+Z3YST1e/j9sHmL/L9iNwJ3rrX5G8kynxJwdwEU3Gti3eHo+
    s44ehq08hf6EdrJrHS+ZuBH1j5j+BhL5IG1bt0ZcmAQkZxR+2uyzBdBsbYjw
X-ME-Proxy: <xmx:THxqalQLxAxV8dQEDN8DHsReNp4CvStIXQ9tbFUZLxxc7jxifVzxHg>
    <xmx:THxqar4HLBAfeqT__rZcF9mrj_n29j5Kckpu5QlUyuC1XnHxJHuX_Q>
    <xmx:THxqap1Z2Fz2jIQLs3WD-08Zo7wPbrsNuyNRR0Qc44pw8qD_81DMQA>
    <xmx:THxqauB9lgEwCIUGxpZnGhJbxqMQRlcj-yH5vt4Bk3QSpvsNju7kvw>
    <xmx:TXxqanwxiUEBELOqssU4OAIVq45Io3SP1vVKpmiz8-dkR6ZZUr6a77e6>
Feedback-ID: i80b64ba7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 29 Jul 2026 18:18:52 -0400 (EDT)
From: Juanlu Herrero <juanlu@fastmail.com>
To: David Wei <dw@davidwei.uk>,
	netdev@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	Pavel Begunkov <asml.silence@gmail.com>,
	Juanlu Herrero <juanlu@fastmail.com>
Subject: [PATCH net-next v4 0/6] selftests: net: multithreaded multiqueue iou-zcrx
Date: Wed, 29 Jul 2026 17:18:19 -0500
Message-ID: <20260729221825.42773-1-juanlu@fastmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extend the iou-zcrx selftest to exercise multi-queue zero-copy receive. The
server can now run as N worker threads (-t <n>), each owning a receive queue,
io_uring and zcrx ifq, with each connection dispatched to the worker owning the
queue it landed on. A new rss_multiqueue variant drives traffic across a
multi-queue RSS context; the earlier patches are prep fixes and a refactor.

Changes since v3:
 - size the io_uring CQ to the zcrx area buffer count; the default could
   overflow and abort a recv with -ENOSPC under multishot load
 - Makefile conditional/list cleanup (Jakub)
 - drop the anonymous scope blocks in run_server() (Jakub)
 - docstrings for the new Python helpers (Jakub)

v3: https://lore.kernel.org/netdev/20260722203950.58550-1-juanlu@fastmail.com/
v2: https://lore.kernel.org/netdev/cover.1776444379.git.juanlu@fastmail.com/
v1: https://lore.kernel.org/netdev/20260408163816.2760-1-juanlu@fastmail.com/

Juanlu Herrero (6):
  selftests: net: fix get_refill_ring_size() to use its local variable
  selftests: net: remove unused variable in process_recvzc()
  selftests: net: refactor server state into struct thread_ctx
  selftests: net: add multithread client support to iou-zcrx
  selftests: net: add multithread server support to iou-zcrx
  selftests: net: add rss_multiqueue test variant to iou-zcrx

 .../testing/selftests/drivers/net/hw/Makefile |   7 +-
 .../selftests/drivers/net/hw/iou-zcrx.c       | 437 +++++++++++++-----
 .../selftests/drivers/net/hw/iou-zcrx.py      |  50 +-
 3 files changed, 366 insertions(+), 128 deletions(-)


base-commit: 2bb54b49e9d522f54dc9c0fe10ba40fbc56041c8
-- 
2.53.0-Meta

