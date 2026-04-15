Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4305034BA50;
	Wed, 15 Apr 2026 02:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776220866; cv=none; b=ZD88rVYe56JfQlXjoUbMblY01lzAXh6RxLwJ+kR7fCNiyqsZtropHhX4rVSlX42w/wV6tt0B5hbAB2FbCP1l3ry+h5VE1BB3+S8BYlG9+NCSxH0Qh39a3B6IZj/qqG+aFAFo6kMANuEAsSQPSps5/YedbDdbyd4SQrj2wn4wMUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776220866; c=relaxed/simple;
	bh=7ddT1jnx0DhwTTOczx5qFSYQ6w4ZwHtwpFlWTfSQr/c=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=XixV+Ru8R+L4z/BHKTQYtk6YHG26ULUVoaIhnGjYPHeSd50DkOq2+Xr1MDZJx02w5LOGdNq3gmms1TF8GlZ4W+G8DP3uu6hezcJWlvMxGTkJLdhkWpRdbpVhe3CSrXMIZ6vX9RWDssKoFjqesifFW4VDJnpff446lD0ugkglWTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jNmnAASx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jNmnAASx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28078C2BCB3;
	Wed, 15 Apr 2026 02:41:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776220866;
	bh=7ddT1jnx0DhwTTOczx5qFSYQ6w4ZwHtwpFlWTfSQr/c=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=jNmnAASxRJfVR0+BNLePLMTyDRx8EUaI490F/F8dNS/RJvyCTBz9qaOFEOZc974GS
	 zQN0zixFyC0Ytvxkykqu0XtKQErqJpVsGhByFE4lDSQKBgzDHJKm1OgNBW5WZv4uIp
	 69pRFTGpE5Vlsz8MIOBsyP6jNicqr8lvn4zgsdeKTdyiBWcXVShaoim067ofUUrQZR
	 be3trRm3g4tBkAwLc90c65i4bPmmKcwimaVjGTaoQKOs9ar7Kh9uu8vS4NHI4/Q5lM
	 cGDlGEclPxlwGx0ylsX25HqBy5KXnJRX6wCF5rhpghPsA0bpcbAhBNTS7QmqZbtygx
	 2ti6YQILrlg3w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7D2453809A33;
	Wed, 15 Apr 2026 02:40:37 +0000 (UTC)
Subject: Re: [GIT PULL] Networking for 7.1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260414193324.1390838-1-kuba@kernel.org>
References: <20260414193324.1390838-1-kuba@kernel.org>
X-PR-Tracked-List-Id: <netdev.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260414193324.1390838-1-kuba@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git tags/net-next-7.1
X-PR-Tracked-Commit-Id: 35c2c39832e569449b9192fa1afbbc4c66227af7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 91a4855d6c03e770e42f17c798a36a3c46e63de2
Message-Id: <177622083630.1583446.3647968761703946403.pr-tracker-bot@kernel.org>
Date: Wed, 15 Apr 2026 02:40:36 +0000
To: Jakub Kicinski <kuba@kernel.org>
Cc: torvalds@linux-foundation.org, kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, pabeni@redhat.com
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 14 Apr 2026 12:33:24 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git tags/net-next-7.1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/91a4855d6c03e770e42f17c798a36a3c46e63de2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
