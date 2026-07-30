Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CCE43A543F;
	Thu, 30 Jul 2026 19:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785438948; cv=none; b=gstDS8pGwjwtMBq+R3QCv2fjfDcE0i6EZIpLt6sfH4xc7MD7h9XfNQpWdEkY4gReJsUzExTzYfTMp4poWQHUMOa21ubCMSOSmfPY04/p4/Bi8etLqMjvoBCitiZvBm5obxyXD6MFJOV+imdId4dOiG2psrgjiSkK4iMEwHyIolE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785438948; c=relaxed/simple;
	bh=ztG/lv9VtiJXXGMsPJ+6jFjvLk5sK9A2W2Cwoi/LIQ4=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=EPHqIWInI8ChF2XF319hrp4FeB59a3C+E9N5pIK6mdf0GIXWagyX2h60WL14XLgU63aTnI4LZaickPkOnh6bJxFiwS8etONZ+H97srayYlQhDP1Gm++wfrEffJOogw0bINZnTDKnbQURF0i6fZY5W0QegGTvApeQNT+Zdj20p+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nYpMeTku; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nYpMeTku"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 643FD1F00AC4;
	Thu, 30 Jul 2026 19:15:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785438937;
	bh=OlXfH/lo93IcHdy3bXEES9demDGynYCU4Qy5W19Nn2c=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=nYpMeTkumb+Ny7EFdspnDdMb0TTVcH60rZHCIR8rWiR8HiXrw2mr3O4ijgJCi7mx5
	 eFs6IP50B2ZI9xRusWUJGsZfUQ98uiaWedNikEZTGa2EF2bGKTsuYBR6rsj+EaLtVV
	 Zgf720B7FVvHWzZgh7SePgEXr5h+DJ/BuA2AcaUumONCHsh6P2Ek4b4XIBAx/3016p
	 KCCvdS0OO0RUWniGeS+1xcR+vfXp0OyY3Nl0U3oKlqwp5su3Nfxfg4Rcc2yxCprlnW
	 g6pnUOO15D9es4POhfSdHs2lhpr/KmMym98uYdTr8/l7sLv4SpTgBD0DeiI0EFnDsE
	 30n1hxnNIvQDg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 199B93811A6C;
	Thu, 30 Jul 2026 19:15:02 +0000 (UTC)
Subject: Re: [GIT PULL] Networking for v7.2-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260730142557.354953-1-pabeni@redhat.com>
References: <20260730142557.354953-1-pabeni@redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260730142557.354953-1-pabeni@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git net-7.2-rc6
X-PR-Tracked-Commit-Id: 451c9075d6c53f2438d110addbeeeea6fac18567
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2812e64e1575e05500a35c405aaa6e99b7d7930b
Message-Id: <178543890061.4145507.16142363972916308534.pr-tracker-bot@kernel.org>
Date: Thu, 30 Jul 2026 19:15:00 +0000
To: Paolo Abeni <pabeni@redhat.com>
Cc: torvalds@linux-foundation.org, kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 30 Jul 2026 16:25:57 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git net-7.2-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2812e64e1575e05500a35c405aaa6e99b7d7930b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
