Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C5673EB0EA
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 18:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781028486; cv=none; b=nj11SL7CjJINy6V7k1mKOHuHs9DfhlUJnvdAZyXNQzE0BRLCtpm6N9hnoCW2i9o8+LIWGWuXWivo4yR1k+guvqKJvQo+8HwvQXWiDlTQm/A8Ci9iVhgxnmK0AtzsAhsqE0KMtyGOOBUq/88hibX2wzcngtm2h2pGxhUCyi4j0+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781028486; c=relaxed/simple;
	bh=sCb924zWPlMTFentBJ82H8+6T5PSV8K3+Y9F+MMAT7M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=txab4cTtdya4QOnGza2Qc/Fv93Dnmn1ZsXl4vGm/5ILKlguXYd6DkDIXLE5IvxGHbvxSAVox+cm6qutuiN4dN7hIep2dMycwwt/q/cxyvetVvkmxg+1Uahl+csBhw5IML887kX1dJDUzJLPA7Tgl3e4te9dXamDtAVDpJYebMkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P0NevGd7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P0NevGd7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 990F41F00893;
	Tue,  9 Jun 2026 18:08:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781028485;
	bh=cY9zGB+uzL/xb+TKavBdWPlZRck7sZ0PGpuuFM3DMng=;
	h=From:To:Cc:Subject:Date;
	b=P0NevGd7FL6O2L6BSAeVQLi3QMFzxCKFRAi5f6sjEH5sJXcVcIFYfa4j4ZRJt6on8
	 vSOR7Tp+et6oF3/eopd6PYqY/uxNs5Q/RI3BL74X0+P3UG5JKclKBfgq7SCZ5fgeG0
	 e7914k26lESdDulkt9HRIsKkgMQKlAoT0cW0/UyfUVnx3PCZ9mmu5cHybZN8XSvbnA
	 tEkDkuF0AAhcp2LWK+RTm0AddIEWd4oS2p0aKUWebTPxPF/t7cxu3Yuoo2eB5SmOxt
	 TpbXGCWIRfkN/d2h9l6GrYa2WuOcPeqF3khJsflV97TcWTXdrBEGnLeePOkzdxWnP2
	 NskOm5erV9WDg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v2 0/2] selftests: drv-net: so_txtime: trivial fixes
Date: Tue,  9 Jun 2026 11:08:01 -0700
Message-ID: <20260609180803.1093428-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I noticed that so_txtime is only passing on NIPA setups which are
looped within a single host. The cross-machine cases just flat out
fail. The initial bug is obvious - the test does not deploy the binary.
But even with that I think more work would be needed to sync the
time / adjust the expectations for a dual-machine test.

Willem promised to follow up on the fundamental issues with 2-host
setups :)

v2:
 - rebase & add cfg.require_ipver(ipver) to the new case
v1: https://lore.kernel.org/20260608173305.372987-1-kuba@kernel.org

Jakub Kicinski (2):
  selftests: drv-net: so_txtime: remember to deploy the binaries
  selftests: drv-net: so_txtime: check IP versions

 tools/testing/selftests/drivers/net/so_txtime.py | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

-- 
2.54.0

