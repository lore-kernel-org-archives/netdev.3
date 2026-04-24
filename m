Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E91BF41754;
	Fri, 24 Apr 2026 00:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776989658; cv=none; b=OnaO/3Cp9MwLKifAzFlESmW8rrz2WWJ/wQTXfHEgcQJ4c3fPFlF64Wn2sQdGbt5CtVHj4iblHiWMp86yU3mhcz3Bh+ATTm4LdBcwXiDCLAvJOhzsOQpb92fmj8QI6yFBG9Z+wGs7A5h345KtEt9u/sf5Blnz9Opkhxpmtwdno/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776989658; c=relaxed/simple;
	bh=fRxGKCDe3uujqu5RjuSl95dE7n0qZu9XQ6QXSGByckE=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=PC55VyPR/UWjEKkM25eGW8wXCkYxawGdld/SqFl0uvXbPAbHvUP1fdCBvllV2S5XMEgPROL7wQ4R3El4c186ETR9ZBBkekQ+L3zZC+MSGNCrY6V4JQ/GvO1zVAdWOr8o0nMr6mHNjxngn11poRMmS4AH+IH5cFmUOY6TtN8aobk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VwrahYhi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VwrahYhi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 943A5C2BCAF;
	Fri, 24 Apr 2026 00:14:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776989657;
	bh=fRxGKCDe3uujqu5RjuSl95dE7n0qZu9XQ6QXSGByckE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=VwrahYhi3ZxQk0K3OgRyHh8JXfH0r/0G/mOsXtFk65hcH7VmqvAc1CvGnUEgDB9dt
	 w+K54LuEn60bmd5WbRfTY/KW50WGDdfA5dSUaZCA312Fc4HPuhHJliDGcZROU9iINa
	 32pBnEfDykp0BV/o0SwMszvk7LixUS91msHDtmuqjh/uTTDu01GHm41NxQWVpgubUi
	 o4q2hUokRfez4kK6xpxM0+qq8VedJQ6z/2kkVAtHI9EAQtmqoYgVIa7ZPFUr8GVCRi
	 ua4YFwrLEHJeFHtOhtmldUhPZ11wjt6wVg321iNNs68MKBoM2GMzmfFOI30BYzHbC1
	 7aeCiixqbkHmw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02CDE380A951;
	Fri, 24 Apr 2026 00:13:40 +0000 (UTC)
Subject: Re: [GIT PULL] Networking for v7.1-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260423214441.1357981-1-kuba@kernel.org>
References: <20260423214441.1357981-1-kuba@kernel.org>
X-PR-Tracked-List-Id: <netdev.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260423214441.1357981-1-kuba@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-7.1-rc1
X-PR-Tracked-Commit-Id: 5e6391da4539c35422c0df1d1d2d9a9bb97cd736
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e728258debd553c95d2e70f9cd97c9fde27c7130
Message-Id: <177698961860.818077.14800428144861981416.pr-tracker-bot@kernel.org>
Date: Fri, 24 Apr 2026 00:13:38 +0000
To: Jakub Kicinski <kuba@kernel.org>
Cc: torvalds@linux-foundation.org, kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, pabeni@redhat.com
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 23 Apr 2026 14:44:41 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-7.1-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e728258debd553c95d2e70f9cd97c9fde27c7130

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
