Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21627285072
	for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 14:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774363617; cv=none; b=oGS/ogBPMbif+k3IBz7LoldSJoXfkycUJ4XVRNUzndobAI4nRjbquV4XUqd3p35UvNwASKH5bOVGEzZX3613Q+u2Uombi34vC45x92gbU5LjWzFZGt8Z4zcytf/QgR845+iTNnUlYdrMpqkQbQsqO7SVZ1X1ZHnVzJLKaWCKMGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774363617; c=relaxed/simple;
	bh=ktLK1j+CCbKSPDnyVoq2WfFeCU+8Ovc3K8zY99zt6mI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=l8dfCMJD3HtUM0ahirJpcU2sK4OemUANE70vwojyNbOknL587zrINkM/le9v0RtKhGSeITvSKoJ1+Y6oSIg7yCSyEqLdQW3vMyHnUuuvwKZM8fGUH7u55c3Yh/F2PIjPXKu1nXVIc6zo7b0VbTBnqQJQAOIXczq2o0einvfr7ZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pXaxKw1n; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pXaxKw1n"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774363613;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=MZTsImrJajFpDF2tWJdZhgoDmJTWSyHHGqcvf+YG0LE=;
	b=pXaxKw1nFIQ9aDmIjO+phyB6FbwQ6vtN1SdA6wlgLCWZkufR3ueWqiXCiTYTHo01AlNTwZ
	hjJc3eynRaLUVgU6df45N2Rx2hHtwgmUIgDUle1LDrXkwcsL2T1mOZZtbG5r851kVg8Ujr
	XErMUrR9bdeSKQNMPl9wg0vq6GHeXm8=
From: luka.gejak@linux.dev
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Cc: horms@kernel.org,
	fmaurer@redhat.com,
	liuhangbin@gmail.com,
	linux-kernel@vger.kernel.org,
	Luka Gejak <luka.gejak@linux.dev>
Subject: [PATCH net-next v1 0/7] net: hsr: subsystem cleanups and modernization
Date: Tue, 24 Mar 2026 15:46:23 +0100
Message-ID: <20260324144630.189094-1-luka.gejak@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Luka Gejak <luka.gejak@linux.dev>

This patch series performs a general cleanup and modernization of the 
HSR(High-availability Seamless Redundancy) protocol driver. Since the 
HSR subsystem is currently orphaned, these changes aim to bring the 
code up to modern kernel standards and improve overall maintainability.

Luka Gejak (7):
  net: hsr: constify hsr_ops and prp_ops protocol operation structures
  net: hsr: replace fallthrough comments with fallthrough macro
  net: hsr: remove unnecessary void function return statement
  net: hsr: use __func__ instead of hardcoded function name
  net: hsr: remove unnecessary braces for single statement block
  net: hsr: add missing blank lines after function declarations
  net: hsr: use BIT() macro for bit shift constant

 net/hsr/hsr_device.c   |  5 ++---
 net/hsr/hsr_forward.c  |  2 +-
 net/hsr/hsr_framereg.c |  3 +--
 net/hsr/hsr_framereg.h |  2 +-
 net/hsr/hsr_main.h     | 23 ++++++++++++++++++-----
 net/hsr/hsr_netlink.c  |  4 ++--
 6 files changed, 25 insertions(+), 14 deletions(-)

-- 
2.53.0

