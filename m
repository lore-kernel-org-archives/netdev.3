Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74AE64E0B98;
	Thu, 17 Sep 2026 19:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789673702; cv=none; b=kDxwwTZwMZFtM3/qAF+13AYw/TD4rq2wJMhrfoaYkD6tFXap9+qp79UgSYhU4x2ZnDsKMc3aA8BcFqbxjU0KVt1zyxesOP1pP8Cq8JqwApQ9IIpajAsffPvYc/f+T2GGkRH3OGCx8jmKIMiPBS/NPY18ucMackDkz4h9UEfmDUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789673702; c=relaxed/simple;
	bh=bZj1mdoc1FNcPy1u2VVFAA7PFdDt+6yGbsfzU/UQFhM=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=gVR96N7OALKIClIASa9xmSFvaebwjLAGMKVznFFiJtzMSr+5zFmbHeIfJATvH/IrMxAjM8VrfaV5Lhd0ELwZw/SMI3rwzwiLoIeCyG3a9ww+SKunqlmZyDWIocR0sXTQ8oNFYbHpjy0bjCqgg8/3IOICIHGG697NEELTDdmfyvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bSOdK/zX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bSOdK/zX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C4581F000FF;
	Thu, 17 Sep 2026 19:34:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789673697;
	bh=a65zZrUMSOQwgUdi65oStTixYiDq1SXmCWvj/21Zp4w=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=bSOdK/zX+2qPjQfxtiPE+ce3Gia98e5k+3cmLtOuHeGNBi4LzQ6CoS6cWDcNk8EXv
	 XfCd3pCp0idvM4z/stg/FGWKNcZnnbk5s37P8bNb4DbxE9tlxGY9wQTjCKUmvoI6j6
	 lo0FyXCE6olWj6/D3EJOMIwFWyosqTu/RXNziLRRl/PZPfLF7AWHp/LyzbEXsGTiAG
	 zQ84OJ3MBfNGeS0Y2pgXndr6xz7/WsoaMl3YLM3orKeZBKCtN/5WNabz2TS6+VAlzL
	 XOqrimIcArzfyrWz0FQ9b1eqytDbP0HsqEtTLjGs9UOak9yv9AyG8QOWVl5kjWGZmx
	 M+IG0FWM04H+A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0F4138119C0;
	Thu, 17 Sep 2026 19:33:51 +0000 (UTC)
Subject: Re: [GIT PULL] Networking for v7.3-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260917161123.383876-1-pabeni@redhat.com>
References: <20260917161123.383876-1-pabeni@redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260917161123.383876-1-pabeni@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git net-7.3-rc4
X-PR-Tracked-Commit-Id: 3b95a04eb5f95bf6a016a1bb9ff37d3eee48de63
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b5a051f6b840d48f159166ef073d3021989bfb50
Message-Id: <178967363038.3838120.15352241771512304414.pr-tracker-bot@kernel.org>
Date: Thu, 17 Sep 2026 19:33:50 +0000
To: Paolo Abeni <pabeni@redhat.com>
Cc: torvalds@linux-foundation.org, kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 17 Sep 2026 18:11:23 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git net-7.3-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b5a051f6b840d48f159166ef073d3021989bfb50

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
