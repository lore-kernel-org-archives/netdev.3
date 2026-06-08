Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5050934EEF7
	for <netdev@vger.kernel.org>; Mon,  8 Jun 2026 17:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780939996; cv=none; b=fjaPVGBquYmi0dcrwYueLDys1VdoXqC9lS/dQps3GYfOxt8XZueCXBSP2bhbpKnYykwbzFzIEahuYKRJ9hpwh6MmfKEv9zo69e3MAask3eSjqXfJuPwMyqTIIO0885/6xreTDGHBMQi+oIv5NEFqc8DRl0oiyDW7FCSLQ6WjxYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780939996; c=relaxed/simple;
	bh=t6PbaQFaFaNPFScMXvcyC6deTSlUOgGj+lsEl6bI3BQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NG3eS8UBTehats2Aa4qF4rJ3TvHnb1dancTtDMQ8D+Yv8kLdHmMfIGRMCMlKlZEHzKUc3yhVFuRmrhvW/ilzptRfUvNfg577i/LMBYKGREEO+OdKhcDxorcOegAw0RziNaTNJBJL1IkX7L46W0AOVW0ZJX0stv2J7g4GqyHhstw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZGuhAUEW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZGuhAUEW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F49D1F00893;
	Mon,  8 Jun 2026 17:33:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780939995;
	bh=o3U6GxMxZtA2Ttj48bu/+Feg1kdvNB6iFhl63WTlH6g=;
	h=From:To:Cc:Subject:Date;
	b=ZGuhAUEWeZX3ifWyZuT19b3HnOM78baZVH6FHA7tT3HcvohMJ2VB1AXhxqHiGR28i
	 f8J/eC77os4kNY3WWOoMqKMT9PBsbuZ3hXGmC7h3EFO3xEPJQhhasW2H8nTLOQg1jD
	 YQqdHo5yvtm7iXSXQn/rYv7c0yrosFUBrMwFxzHV83AvDMUHbgMqk4ZO/YNBl7RSDt
	 /mgla2Av0o/G2AagIzN5hQn0fXoGLy6Vn4dcy6v1el0DDzbvmQQ0H9pL/6Lo0yjo/j
	 oJqzzdvSQe8S3ihgInG5690qM/36yYA1FPN1u99Uf/SBZI/gc3zsia4v70l163OWK5
	 8/i31uiTn7eEA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	willemdebruijn.kernel@gmail.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 0/2] selftests: drv-net: so_txtime: trivial fixes
Date: Mon,  8 Jun 2026 10:33:03 -0700
Message-ID: <20260608173305.372987-1-kuba@kernel.org>
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

Feel free to nack / take over, this series is admittedly achieving
very little in practice. The test will still not be usable on dual-host.

Jakub Kicinski (2):
  selftests: drv-net: so_txtime: remember to deploy the binaries
  selftests: drv-net: so_txtime: check IP versions

 tools/testing/selftests/drivers/net/so_txtime.py | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

-- 
2.54.0

