Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6800745A288
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 13:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791464497; cv=none; b=NkX1olDxjsii534GLscqRSCu/3BOBwXx96GHC6E2Mu7z613h/B6fMXIMCuwbO+48mvVVzNqJ70ljrOPWRmty3Uw1iXjN9OAF61rQ3IH8oitYFLbsa7cwV1ofcXw2PlEMVxgivf7L8aYPWO74jKJrDPLIDE6YPsK9ZqCAH2xUnbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791464497; c=relaxed/simple;
	bh=rMoypnZJptpPafATEXzeovpVPUE3s8bEGp7sRAx+n1o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=L4K6wo4oFvMfquQ+vbQIy4gizvMMenNLtbMTMAu7G4SDd2/WwekrBAxYQxSrpkU9MhDFKy9hZQdcIbLwyY2cRBsR1M8AApqERwNHsYLRjmlhW9TyInE6Uiox5ICI0/bI7o/VyCJHOe982g6z/lX1yBrsP8l5TvM7/zjCR4jYTUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=aPb3vZWM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="aPb3vZWM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 883721F000FF;
	Thu,  8 Oct 2026 13:01:35 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=zx2c4.com header.i=@zx2c4.com header.a=rsa-sha256 header.s=20210105 header.b=aPb3vZWM
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1791464489;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=x98hyHg+zPp2DiI02gtM72w/f432J4nKmEQOrk+v2A4=;
	b=aPb3vZWMKbWtOuIalcejmPXNOJ3MRc1oAW7vWEaNvqDPdQsvqh99uZORFeFHP7FxN9xLFU
	XYODklSMVzL8Yjxl27Mq9rv67L8nlUBjU0Fst/WDP1XLfDm7FYb2VRPcJ+66wKb9B41brf
	p/cingv3woKgxtLx7RfTWbDEOa5hSQ4=
Received: 
	by mail.zx2c4.com (OpenSMTPD) with ESMTPSA id 0b3a4eab (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 8 Oct 2026 13:01:29 +0000 (UTC)
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: netdev@vger.kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH net 0/3] WireGuard fixes for 7.3-rc7
Date: Thu,  8 Oct 2026 14:59:13 +0200
Message-ID: <20261008130124.724119-1-Jason@zx2c4.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Jakub,

This series contains two important WireGuard fixes and one trivial
cleanup.

1) Remove an unused variable.

2) Stop zeroing out skb->tstamp_type when encapsulating packets, so that
   fq behaves correctly, from Ramses de Norre.

3) Make sure handshake state isn't swapped out while locks are
   released, reported by Jérémy Jean.

Please apply these.

Thanks,
Jason


Jason A. Donenfeld (2):
  wireguard: noise: remove unused variable
  wireguard: noise: reject response consumption after intermediate
    initiation

Ramses de Norre (1):
  wireguard: queueing: preserve tstamp_type when encapsulating packet

 drivers/net/wireguard/noise.c    | 9 ++++-----
 drivers/net/wireguard/queueing.h | 2 ++
 2 files changed, 6 insertions(+), 5 deletions(-)

-- 
2.56.0

