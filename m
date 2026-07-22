Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15A2842E8DE
	for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 20:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784752801; cv=none; b=cEplcEO6E66ss492agp4owFX7yywHhgUVL/gGvbFl7DcyEQt8PCZUq5y4KGFTLFAeFHRHg0n7oDDO6BXSiMqTY7wKp7S8E7eqs2W3UGwUIxHsPtvixTAwhufTwT04/T8c5X8CgWUz9bUv9FYIw3ekcVwIuuMkiOTkm1OPzTOB38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784752801; c=relaxed/simple;
	bh=dGnHQk0igmOtn9iby89ByVMhfksIZX33Hc2gckDZ16M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bNacKy1bK6OZBqzyXt7Q4ozwjaSJwORTxfUdErspHJkDV2P6y6LsQcC+KT7dtLrs7yntvq4ErnOptMCgS/xo9zqrVGSAHoxMZ27yfJux3U7o6QRElmwwY2w+DR5OjGPGfSUHhp2eRSitmWPcJYba5+e70BXA72KijA6NB2pXBHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=XaaXbfPE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=W7zn8O5J; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="XaaXbfPE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="W7zn8O5J"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id 095811D000FA;
	Wed, 22 Jul 2026 16:39:59 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Wed, 22 Jul 2026 16:39:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm2; t=1784752798; x=1784839198; bh=4NSjax90TAlTouczwUgqo
	QQdKKjYU0Immcx++vUDT1k=; b=XaaXbfPEi+ClwND4GoMkYC+R46bbMZelIkLAi
	yjPODApBc3vGGMH9of+j9l7CO0eBuKyGyHou/yHZ/BqtGcxD+C92FKS3l3Z8Ia72
	KarANle1npAuYZ8pGT+SAgRG+rdAhbH8xS9NItNJ6HpnRuEe09Q1IXWXJ3Kkgz5b
	aEnHF6rkg3KYQ14DWylKBkrsV+8DIGtzif8WJpvvtzO5WpD3+wksR/G9gA2l8MWb
	303iKxI8AlUUsHS1gyYu3ncZ5HbyMCSaGLGJFjb9FgMif0o5GyOtdJewaKbaxtrW
	QYS4SdxQMLyC6bBk9N2n7Xpx/KEB/7cZ3o5yFF/3sluS/TwUw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1784752798; x=1784839198; bh=4NSjax90TAlTouczwUgqoQQdKKjYU0Immcx
	++vUDT1k=; b=W7zn8O5J3CbaT1kSPlTnn17tsPM/t5G5KFxgZ3pdmstcLjIHQPX
	deeZ2PasBtImtJxyUrx//0O+yBdBmD7fnJqW7dWmyklAcFprRlcIPzjjIYMxGLWG
	Nq61HRvFU+jYZxGYzDHFQP9GnDFs9v/FFQezTswv9pSd4MLozYwc9uoxNxZxczoy
	Z8taF3wbfAoGdvimF31sUn4CotjM6t3G83WpsM0rpYZeHgj5cPV00zQAo42Swb6s
	MGHNOL0fMuhrnGPHB1PYz1JjIQij7Dt4pk1Yy9BQoLocGi9Fi9ikInYFVtLcfp19
	bsNkdDAvjVDLt9uXnqo4hsVkhwa501XSoBw==
X-ME-Sender: <xms:niphaunHxczEM-F842PnY1xaEM29wBYbdCPFG8bMKQfQHfcugg3NNw>
    <xme:niphastaylWf6GAwSE76q_mdziAOI_Ewb55QNOYZsYKtrG0vkMoYKg4_B5xADNZpl
    qXZvAefT-6VvpgWD8mf879hq2vv8OwnGbxLkpkukBUHLat6K8K2qvc>
X-ME-Received: <xmr:niphak-d8bSn5D7xF2c2zpmE31FyXnRlnwfv2HszrzFYyw-_RLz530I83qZ87y_l6JORHwqCD-6daQwmu3DA_w>
X-ME-Proxy-Cause: dmFkZTFe+MzsfrF4yPzGITNQ1XzqAhkAPQ0hPfHqHIXEBH6dmhUf07BHZYMbCfFzNW7AEB
    QiV+VJwBSA0doEXdX5OgB0qe4dLe2QdoGNIbVAGy3YCnhJHqFmrnaTP0CMizotExf0kjr/
    nbM54rfhMKUAeKXu1nQWjCcdzGXyDhaMQ5drDadv4ss2qi+67dl0CuhA96QdP7gSAXF3Hf
    IaW+QmBWiIldOewqIQ/2G0N5nW+Qp9yIg972mcwwfVM2mrPrqneX+l3N86L+1GvoxmCvgF
    xZT3W19HOGueeQhD/Q0gqhvSWUGjr7cJo8j9H+k4PG631F28TDLR0Fq20kKeTqgg5NG9jl
    Qeh2UsOsAzQVdM6wktvaOWYPct3aW1u2jMuxFRyrHp2pEkm5rLCBYJ3ARmRXgqIe+W1AAY
    Gt4ZwaVzXQw4I1JbZpGjHKOC1UbZ8y9n64arrR9sUNyZLtWuA1iDa7omNXyiYoglkqtv3/
    AANg3B1t0kvwFC8z0lktioslEsPoP0iX9lJPurHi1dXgujCmj91RbVzeX1vAHvb/+e8ejS
    01R8DifX4Ep5K8VRcrOIjYSqRiSuBHD6dnKqgDDLZMVXlDmtYBREEN5F35sJGnmKT2sVaa
    MmAWEmeCCmSVW2YlqdqVEVjmGh2UldfTAC18MwLT0WIOFtbLw1APOqNPUR2g
X-ME-Proxy: <xmx:niphauMeqirQInovq2s8MqRZr9KC9xjPKa7XRAiIQGWNkepOhqwuQQ>
    <xmx:niphaqHViIqJ2bsVql5ZQZ2aszB_4vsm4dd57U7WHq_ZaBFZcMd58A>
    <xmx:niphakT1mX6_D2C8rvktkPyk5WjwP5TFVzBJwWvsUpQ098ktlq2Lxg>
    <xmx:niphavvN0aJEksdgG6BuR1SMvkAkvjjdExwPF_i6fLpZ1YGuZUuXQw>
    <xmx:niphauOCOk6DBAWoXjSuNCyFR3loPzIbMwb_mxxvzETpFPkfINE60eh1>
Feedback-ID: i80b64ba7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 Jul 2026 16:39:58 -0400 (EDT)
From: Juanlu Herrero <juanlu@fastmail.com>
To: David Wei <dw@davidwei.uk>,
	netdev@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	Pavel Begunkov <asml.silence@gmail.com>,
	Juanlu Herrero <juanlu@fastmail.com>
Subject: [PATCH net-next v3 0/6] selftests: net: multithreaded multiqueue iou-zcrx
Date: Wed, 22 Jul 2026 15:39:44 -0500
Message-ID: <20260722203950.58550-1-juanlu@fastmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series extends the iou-zcrx zero-copy receive selftest to be
multithreaded while preserving existing single-threaded tests.

The first two patches are preparatory fixes/cleanups. Patch 3 is a
refactor of the server's global state. Patches 4 and 5 add the
multithreaded client and server. Patch 6 adds the python-side
multithreaded test case.

Changes since v2:
- Moved the per-queue NAPI ID query from the Python test into the C
  binary, using the netdev netlink queue-get interface; the -n option
  that passed the NAPI IDs to the binary is dropped.
- Server startup now uses a per-worker eventfd handshake so each worker
  registers its zcrx queue before the main thread queries NAPI IDs and
  dispatches connections (with checked read()/write() return values).
- Minor checkpatch style fixes.

v2: https://lore.kernel.org/netdev/20260418094907.3cde57ca@kernel.org/
v1: https://lore.kernel.org/netdev/20260408163816.2760-1-juanlu@fastmail.com/

Juanlu Herrero (6):
  selftests: net: fix get_refill_ring_size() to use its local variable
  selftests: net: remove unused variable in process_recvzc()
  selftests: net: refactor server state into struct thread_ctx
  selftests: net: add multithread client support to iou-zcrx
  selftests: net: add multithread server support to iou-zcrx
  selftests: net: add rss_multiqueue test variant to iou-zcrx

 .../testing/selftests/drivers/net/hw/Makefile |  10 +-
 .../selftests/drivers/net/hw/iou-zcrx.c       | 444 +++++++++++++-----
 .../selftests/drivers/net/hw/iou-zcrx.py      |  48 +-
 3 files changed, 375 insertions(+), 127 deletions(-)


base-commit: 6deab902b4c06abadeb5242db1488a17fd614e2b
-- 
2.53.0-Meta

