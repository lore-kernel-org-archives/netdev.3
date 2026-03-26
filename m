Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E6253081D6
	for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 02:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774491735; cv=none; b=tVdiB1rlz7UNimdg0nJ2KYkBjHjV3v5+M2wFWkixtnZwxo/72UqqEHUKTgLuW9fs69EiFPCmkeuRZOdOx0j9n4hlKAcXgtvgC6c2j1LKQZIi+PjqvzZ0jp/PQsyZ4HEl7423ioKg99esg6zgnCCHjEPjegZbtYJxbwKS11cywA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774491735; c=relaxed/simple;
	bh=NImn/FDtSezZ+Z4YLtokf2xod7fZNrpjBFHFR2Ms/do=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CHHXE4e6GVEyloRKNR3cSSHlU7fE8CrPTqBzC+QmYpz3TRPGuBexGACBOBPWizO7yHcVFm2y+Ul5Uqob3BBHFW98ryHlCthxJRT6lAXepzoypl2m1PO/8D18o7Irt6qBsJgOIwvwsXk+u0a0Y2ghsZiCjMRqiE7Hncwr++a0fCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LNjuwAjE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LNjuwAjE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F19C8C4CEF7;
	Thu, 26 Mar 2026 02:22:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774491735;
	bh=NImn/FDtSezZ+Z4YLtokf2xod7fZNrpjBFHFR2Ms/do=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LNjuwAjEaTRCcPaIS8I/LhbvayhqX7HdPwTpOQoLLieBegp01H36aWzB35aB6H1cQ
	 2Je2m56gGmpV3cNi8VIaRJG8lOHvlnmJ18aNBxlrvRzx9OtnDWGL3BC9KzkH82mDjd
	 2kwQN6hFxAilAwHhE7xuFcTSesMvz7Y/RrmmP5TkQpfULkNMZeKAh4MIDPRAgUrM5h
	 GefN283GvdGNVhFegnr+nnkWbe2clc7sZ6GDXo9LNOi6sW7bKG4uYLStBAAWtyIIJM
	 ql78gmtF8qQYMOjcwkmaHhM4gwt2+j9/F0K9XsBRSPkmeFMZHoGWA911LgTiaT3ioB
	 4I89LwKFhfaWA==
Date: Wed, 25 Mar 2026 19:22:14 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: Network Development <netdev@vger.kernel.org>
Subject: Re: Can networking trees carry temporary patches?
Message-ID: <20260325192214.133ffaaf@kernel.org>
In-Reply-To: <e0c7030b-261c-4ed1-b6b0-bf3b83a41d60@I-love.SAKURA.ne.jp>
References: <e0c7030b-261c-4ed1-b6b0-bf3b83a41d60@I-love.SAKURA.ne.jp>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 24 Mar 2026 19:55:18 +0900 Tetsuo Handa wrote:
> I was carrying debug printk() patches [1][2] in linux-next tree via my tree
> in order to debug "unregister_netdevice: waiting for DEV to become free"
> problem [3].
> 
> While these patches had been a lot helpful, now that easily reproducible cases
> has been fixed, this problem is hardly reproduced in linux-next tree recently;
> giving me no hints for debugging remaining cases. However, this problem is still
> reproduced in networking trees.
> 
> Therefore, I appreciate if networking trees can carry temporary patches
> (patches which are not intended to be merged into the linux.git tree).
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit?id=58b4f8f612187b0d9583b5549044734ecd7071eb
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit?id=02fb7fbf5db47bf5c1736b692888232f5f6bf80e
> [3] https://syzkaller.appspot.com/bug?extid=881d65229ca4f9ae8c84

Have you see netdev_hold() / netdev_put() ?
