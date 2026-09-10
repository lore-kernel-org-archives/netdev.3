Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A0313C0633;
	Thu, 10 Sep 2026 21:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789077223; cv=none; b=glHihHiAbk4FFqBR+0grOiWMdZ8GHiDjayCxFcVOkZyW8Z1oN8vuDWgHB7JOvrmPLUd2gWeFdxEucFEHv7z4cQIc33OyVV/xF83lM3E/DMvHfVE6BLd0JcdC2ZM1sNpBkl4EULybaizcVQsqphrQhB4ZpPuuckq2adiYgYo4qCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789077223; c=relaxed/simple;
	bh=xkN1wAvKoVLbEqpRFyvXhAF2bd6qAqP4Ksn9a3A0830=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=ipDQoaGoVEl0kCZoy6Rd3hKkTp6wH2EaLDdN81uFQBdDBUzRkOCws/dHBykr5t+b8XyoCB9ejSWG0uzEMKwe0bPMVxqRvUkI0qNzkPsmDylHVKMo5awvPn7Twpkn2bLvASPHt6A5cpdRE4VJz6G4SflaoE3pwalwf5CBSGByFIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PS7KDg/G; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PS7KDg/G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 522411F000FF;
	Thu, 10 Sep 2026 21:53:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789077222;
	bh=piYUtNvUuBh2yIwpROCFiJvta4bPOLsZxeIhf/z5ZYo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=PS7KDg/GqmvhF5Cy2o1a0TeVi6cYKJD0MDxEBSEzF+8csAV+zyvWdHEDsQ1kAvtR1
	 IZgN0xNgfAPnYHVwM6Wg2yETy08jJe5QeLtgDgJ14wkjQynXSsYBB6UFvyx/uVv4BK
	 XGuSyvKo9Z+doxy0mOwMpUxtGeOVIQtN0GK64JblXOvkwAEyHRmJrTu1z5MxttGAYu
	 CQn0iiPk7bVccdlIHfMYwzI6f2u40qLWn2ZwNAhZwTAFDjV8uhVVri2oAQ/k9KeWm4
	 bOC8BTgsnUl83xAPXivywlkFOP8KWJ8OjSfJOj3WkVS9BlvP4MpbF6j5sRfkPB2Qky
	 0zadSbvVdlqYg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D099D380DBDD;
	Thu, 10 Sep 2026 21:52:40 +0000 (UTC)
Subject: Re: [GIT PULL] Networking for v7.3-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260910164948.2123565-1-kuba@kernel.org>
References: <20260910164948.2123565-1-kuba@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260910164948.2123565-1-kuba@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-7.3-rc3
X-PR-Tracked-Commit-Id: 5096947508b750bd4a65a8e61bd2083a44d61bfd
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 78445023439506ebd83b86d40b1e428a3b309d4a
Message-Id: <178907715946.2100681.17685188663869489955.pr-tracker-bot@kernel.org>
Date: Thu, 10 Sep 2026 21:52:39 +0000
To: Jakub Kicinski <kuba@kernel.org>
Cc: torvalds@linux-foundation.org, kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, pabeni@redhat.com
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 10 Sep 2026 09:49:48 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-7.3-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/78445023439506ebd83b86d40b1e428a3b309d4a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
