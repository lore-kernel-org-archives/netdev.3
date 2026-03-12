Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 455753C660A;
	Thu, 12 Mar 2026 19:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773344689; cv=none; b=DBhuE7+dEwhzj6QgPDpAiCNFM043tqz/QCxRrhMNOC3QDa8ea4Z0lwydxFwREtDLpkbt3BzTYtqHknf8U7VCaO1XjoSO7zYSJv7tQFRBLgsKbZ7mPZqgFmaUHhwr4fgp+ajI7oOTF2vQX2aIvq6X0qv4oz39A7brK954IiTyAzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773344689; c=relaxed/simple;
	bh=HbgJLOEQ0oV93hkQkjDhJIesRiYk6RqPcmdVKW1FEUw=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=lN6wi95L5iVmfYbMgEq1mPAio0AIngbQVToNH0YAGS3YIdx1KLH/c/Fv2QcESg1m3xEAjYaAN49JLbD7PRM6Z+LFUfU3GxNc0G5RjgNIORppxMbw+CudXwEmVzAqVbVTIDp8pRw+JjjGwIj3EtwHcdkcdHY9MOQrGeD3WED1DUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lOvwOXgA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lOvwOXgA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29B97C19425;
	Thu, 12 Mar 2026 19:44:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773344689;
	bh=HbgJLOEQ0oV93hkQkjDhJIesRiYk6RqPcmdVKW1FEUw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=lOvwOXgA00A8/9TDa41Qv/xbYmgHOcwSW3NeH/flXmjo49Lfl4LwTffNCTnC6vZJH
	 6SFRyZpBJ1H7aUqhUO83VSKV6BCdM73Xwnc5wzW9f0sCph64BOmra/zzxdfeQhr6Fd
	 BfaeTOIKAJ5fGZW1qPWyq1PDu44seN9kMepZbCJiW1UkXet11PzZdxrPyqNErUrtbE
	 LnNz+vKEuxrTP1cNVbj4tgjwVAJPNOrZlEAYNHhAxlDCtsOdhS3OgfnRo/L8V3LjF6
	 MYNyUql1yS/HTcjsTWgHdUDEYI/240o8gF3FawEmPQdy+PvtOgtfFtOZOMrwM925KN
	 krY0N2L8fYypg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9F793808200;
	Thu, 12 Mar 2026 19:44:45 +0000 (UTC)
Subject: Re: [GIT PULL] Networking for v7.0-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260312151934.271993-1-pabeni@redhat.com>
References: <20260312151934.271993-1-pabeni@redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260312151934.271993-1-pabeni@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git net-7.0-rc4
X-PR-Tracked-Commit-Id: c38b8f5f791ecce13ab77e2257f8fd2444ba80f6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2c7e63d702f6c4209c5af833308e7fcbc7d4ab17
Message-Id: <177334468421.523191.9794640527948284929.pr-tracker-bot@kernel.org>
Date: Thu, 12 Mar 2026 19:44:44 +0000
To: Paolo Abeni <pabeni@redhat.com>
Cc: torvalds@linux-foundation.org, kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 12 Mar 2026 16:19:34 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git net-7.0-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2c7e63d702f6c4209c5af833308e7fcbc7d4ab17

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
