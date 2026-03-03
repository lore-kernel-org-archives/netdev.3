Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22810481FAB
	for <netdev@vger.kernel.org>; Tue,  3 Mar 2026 16:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772555712; cv=none; b=uXJVFZkP8UWTYc2DIj8MYibUP5xiu1uvGs/yhOWNqVdXoSNPEjrUE0xo4rYjPfnUoF2eEhZQfZV5IW6KuENtEM4gS6BGPBvz50eWc+24qHYooAM6GGMDs9pJmupH5AhAq10HjhrN4qHVllli0/ShrfQKnSFdkyZIP6st56Lm2qY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772555712; c=relaxed/simple;
	bh=1ualB14ixNeaogspltzM0ORnLsFPZMzn/1GjCxoEazQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HtxFP4/yhDsNCnpvyHow1mH9UTNfD3mAxC+dLa5aCTvU1NlC0LkvN/UuVZMPPt+aMHieLGk45AOH6ZsEYNxrqScibCC76GHddBuubifJZ1amkZx754BB39uocqoTdKw/ze7Jhc028fbbcAtFPi6xQCEJcx17UO9UowFA9yBIyRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ocJq3ney; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ocJq3ney"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FE40C19422;
	Tue,  3 Mar 2026 16:35:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772555711;
	bh=1ualB14ixNeaogspltzM0ORnLsFPZMzn/1GjCxoEazQ=;
	h=From:To:Cc:Subject:Date:From;
	b=ocJq3ney9FANGmCS6Tonfit5O30pNFHNNdBFpcZz01AzqD/4w2rWzGskKZ38najnP
	 pp4XLzFwkhFeBZswjtrGUUwzUGtw3ViHjg9aklUcPNKbSlYaCxbna3HK/y1PfU2TV9
	 VEkUtNTT96tv1zymNeqHp62JV4K4QISVrCLwxroqWWYvlcIqjeOwy2JoCLElfdC/Zy
	 Ax8lDyn/IRC+D+4RORgDdnLcsQc/OJOxq6cYRt27RbUMD/FEPxaXcL25ORz2+u+CdB
	 3hoxOwpgQqkZNafTxG1bv9VejHVXeMde5tglLdWruWa3aX0Qa1ifNAH1v9K3x0/7UQ
	 PnyrcC/AklIag==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	liuhangbin@gmail.com,
	matttbe@kernel.org,
	donald.hunter@gmail.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 0/4] tools: ynl: tests: adjust Makefile to mimic ksft
Date: Tue,  3 Mar 2026 08:35:00 -0800
Message-ID: <20260303163504.2084981-1-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Make a few minor adjustments to tools/net/ynl/tests/Makefile
to align its behavior more with how real kselftests behave.
This series allows running the YNL tests in NIPA with little
extra integration effort.

If anyone already integrated these tests into their CI minor
adjustments to the integration may be needed (due to patch 2).

Jakub Kicinski (4):
  tools: ynl: rename TESTS variable to TEST_PROGS
  tools: ynl: don't install tests in /usr/bin/
  tools: ynl: support INSTALL_PATH in the tests Makefile
  tools: ynl: produce kselftest-list.txt from tests

 tools/net/ynl/tests/Makefile | 30 +++++++++++++++++-------------
 1 file changed, 17 insertions(+), 13 deletions(-)

-- 
2.53.0

