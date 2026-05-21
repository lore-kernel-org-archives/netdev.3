Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A6EE2DC79B;
	Thu, 21 May 2026 21:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779400385; cv=none; b=NKfJI5eZdRd/j3RtZtxJxt69ehlF7Y6yIiMc6JHhyb3sMo1NjWeb9garV8RI2EbgZABXVBd1RoMzJby1+i9hAijknD9fDWBfd6JZc7EVXFG8o9Gv1kF4+0KldJAedRTB2R1lBfKZxZOmqdYPW8ggYENwcVwdkvJtDgGH2MUivzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779400385; c=relaxed/simple;
	bh=P6t++7H4NYxtgouX+EhSJUtOXcdoNuJ45cYFSfpkIjY=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=m8xL8Fgb4ElCRgwhPerQAP4z7/YV27AnVTcZRbIrteHE0LypZW2E3ZafJ4+ujZq3JiR8hRPMJgA3QNLIBSA1MqQa7sgN+irj/nIEp0PI/gWo+Fixb1m/S7HHhpKmqedzqF3JakKImA0Ax3HtuYfEI/oB5hJj58glq4JW4qLO1/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i2jhf5cn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i2jhf5cn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 700131F000E9;
	Thu, 21 May 2026 21:53:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779400384;
	bh=lkC0IGbGhl/rI6vPu0NjiQDvizsR/QEpsuz8yrNje+U=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=i2jhf5cnDBE/+K+311d2Sh8ys4ExDfDoPUUEQWk9br8ZPmgIpKgU3umorMA7s24yK
	 YPF/7x9kEv14nq/4GJo0eoUlS+m53AFBimaH0xs+l3scpLKKSY22LHDojBh+MbAdj2
	 yJnbHlor9RHTqVndwaruBsWrzIGBDGENSyYQEDaBIuRpJZUx/+p7eqSxGMzFmusykM
	 P5D1ZAco6pP4sMokJgGWAYXaiV67qH1bf0wQYAXv3E0tabkMakzbP7Im427IYkvw+y
	 9Ev395WgyyH5N1+XpmSbIv0Q+q980F51/tuJ6GY2YLlp0BJ/XmJ2V1hZ2vZMnnx8SG
	 DG3Sd97X+TdwQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56A6F3930E3C;
	Thu, 21 May 2026 21:53:15 +0000 (UTC)
Subject: Re: [GIT PULL] Networking for v7.1-rc5
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260521184315.3654490-1-kuba@kernel.org>
References: <20260521184315.3654490-1-kuba@kernel.org>
X-PR-Tracked-List-Id: <netdev.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260521184315.3654490-1-kuba@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-7.1-rc5
X-PR-Tracked-Commit-Id: 0e3c08f1b7b79b2e9635e70fde3a2f053c99eff1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 68993ced0f618e36cf33388f1e50223e5e6e78cc
Message-Id: <177940039394.527128.15616272266258641113.pr-tracker-bot@kernel.org>
Date: Thu, 21 May 2026 21:53:13 +0000
To: Jakub Kicinski <kuba@kernel.org>
Cc: torvalds@linux-foundation.org, kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, pabeni@redhat.com
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 21 May 2026 11:43:15 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-7.1-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/68993ced0f618e36cf33388f1e50223e5e6e78cc

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
