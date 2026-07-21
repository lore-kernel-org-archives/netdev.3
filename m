Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 645333BB12F
	for <netdev@vger.kernel.org>; Tue, 21 Jul 2026 09:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784625636; cv=none; b=GAoolZptRH5U/haXY8sToQ4O0mrdyLGgcxlY3X+RhnP+cOSJEd6g6/f17WSZqtWzysoNO2xFWJKDcLYmd8iAb/PvqozE/hzKPJKoGre4wow6WP8i/z2TyjqET5Am5LXJIFHxYxv29C/Rc8OcMVbhseCfhrRyVhZAqs2PbsxpOYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784625636; c=relaxed/simple;
	bh=19t6tDgfhafrqzphj8qt1vDke8Hlh+/LBwsqnk/Vzx4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=exRkf1no4bRSosA4b7qaa/u+s5z5gnuXDGPPQCkFTs2sj94m8qgugSL6jsVOlSqJU5i5758o9YXsHJZYnkC6WMDS06NIVKinrVU2NwmuOwVljQv6Auw8e2WXZ4XDWkb4s0ZLGVfvNK7BiHTdsSOf+JltVp9j1iGljw3cZzY1eSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dLhAsxaU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dLhAsxaU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 169EC1F00A3D;
	Tue, 21 Jul 2026 09:20:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784625635;
	bh=E5nCzcXfgPYLGPZzEw6cPlcQ/mQuOOMXGu+liuhWdHo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=dLhAsxaUBgXAMKrH/yv3nbmsmphDtMvoaQlPDn45f1htiDmWNu8snKwgAak226Eyk
	 dKb2+xX4Tx5+i7WYQdt39BbkQLlZEN4EoOk8WWqYbLhiV9jnC3AE7mU/2Vf0/dziAy
	 TW2+qXgr/wnX3OweIMqUJilPCfVonmaMA/M4VXKVA8mnQFJGyadTgtU2r8mtCs724T
	 uhQ7z7b/Au9bblAeHiQb3Xa7Cv5zkZDO1blwY19xik4UcjBICJfoeUaXrL425BmRvW
	 xIUXVDOojTph5tGB4YUSuQphCwLH6hbU7BAnlEpFdojLSW1NMNs0vjReTt3oGQHCRJ
	 lSGKOYQ5OV5HQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 199EE3924A46;
	Tue, 21 Jul 2026 09:20:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] rds: drop incoming messages that cross network
 namespace
 boundaries
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178462560490.179594.14113048072554037021.git-patchwork-notify@kernel.org>
Date: Tue, 21 Jul 2026 09:20:04 +0000
References: <20260708024314.601139-1-achender@kernel.org>
In-Reply-To: <20260708024314.601139-1-achender@kernel.org>
To: Allison Henderson <achender@kernel.org>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, edumazet@google.com,
 kuba@kernel.org, horms@kernel.org, qwe.aldo@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue,  7 Jul 2026 19:43:14 -0700 you wrote:
> From: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
> 
> rds_find_bound() looks up the destination socket using a global
> rhashtable keyed solely on (addr, port, scope_id).  Network namespaces
> are not part of the key, so a sender in netns A can deliver an incoming
> message (inc) to a socket that lives in a different netns B.
> 
> [...]

Here is the summary with links:
  - [net] rds: drop incoming messages that cross network namespace boundaries
    https://git.kernel.org/netdev/net/c/5521ae71e32a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


