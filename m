Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D7E147B439;
	Thu, 20 Aug 2026 15:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787240502; cv=none; b=AgrVPZdfIgByqiwdpeh6xHeNZ8VuDmJIt3ZYUspoYZzfxWOoTCg9U00wtSW5Y818GqQtZcI46utD7f0TH6klKAycYRzXC3pJuQnv04M3t97PAqZEaBfJSgwfcfZ0dtRc/oNv5iu86D49KdmDC+i9K5zbDR6X0hlMcmrke0t+Z0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787240502; c=relaxed/simple;
	bh=8C/HrTe9xEShkLb1riOpAYPxYlQ8jSe0MHMB6sBEguU=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=WfMMTR+NKVl9PIhMLRJLpkC7XNKN92wdQNXjbPgUSpMhLX62A98KLaMv8TuNuG8zcxV1aTUFE7Yn0rNmaOyoHFySiAFrrTfM0puqyv2D/3ZOuFZIUdi/j8x2ndwrgrtkU2PIbf6/FSnQge70t8f1WGMPSp5cgUcD7MJGlFVWyuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JzEckS9W; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JzEckS9W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B9371F00ADB;
	Thu, 20 Aug 2026 15:41:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787240501;
	bh=lxrl1xc2+/TLal+cfTcR6I0lz18NCAUQPCMQmGuVCnY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=JzEckS9WoVgY8IEZHa6M6VlR69BMdzWIN3VeGNlU9LBTl4DUVqdUVwZi9gHi+bHK4
	 yRSRik692WX+cgUTYEV44jKS0Y8VSID3KJPIs8jNNe7xxq96uief21KQAh4qsfmQcp
	 m6Uo4hs9wEXEKKXiFAb70K8UktrUS2RXVKEgY6l27L56UHl/FifBnbf32ngx90XDOo
	 8syp0jZJnCFgUhTE0j/0aO2oWy/TE010UyVCksAYO/XSR5rY4/5cJQSe5FPUvRACFY
	 4zGyEtqsFhTx/qEqqlTeIKVmCyYv7fx7ns0ADNKbH5uZ86V/II+hbwWT7WxOAFrWTH
	 nX9n5gt9WiJ1A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id CB9B53812FD7;
	Thu, 20 Aug 2026 15:40:52 +0000 (UTC)
Subject: Re: [GIT PULL] Networking for 7.3
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260818212923.2725202-1-kuba@kernel.org>
References: <20260818212923.2725202-1-kuba@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260818212923.2725202-1-kuba@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git tags/net-next-7.3
X-PR-Tracked-Commit-Id: 61eb236c41c2a4717015dff18016a75a5eb90052
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 91ec2035134982b98fab0609a9fd8480e8217dc1
Message-Id: <178724045142.314069.5536331249020534037.pr-tracker-bot@kernel.org>
Date: Thu, 20 Aug 2026 15:40:51 +0000
To: Jakub Kicinski <kuba@kernel.org>
Cc: torvalds@linux-foundation.org, kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, pabeni@redhat.com
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 18 Aug 2026 14:29:23 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git tags/net-next-7.3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/91ec2035134982b98fab0609a9fd8480e8217dc1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
