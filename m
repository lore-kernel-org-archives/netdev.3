Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A181238398D
	for <netdev@vger.kernel.org>; Wed,  7 Oct 2026 23:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791417014; cv=none; b=AmhWAtAjHdl6Z87t6QqOw3PE061YDmrxJVL8WPYYtSY1mxD4rEsH68xz6KedDRP2zltcYdpsJpJQki4KdRlN8tTLQyg5sdpN7V/z6LUSwXXi7xl4h61heeAWjTAdwx7+niYQ5tFdaUKCVLedZwzGu8R6CRc2bARX8es76A/z1mY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791417014; c=relaxed/simple;
	bh=YKagJWl42UFgT9MwyMMC3/PIZ8WGba91UhnZjCm4F08=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=NZpWZWJbPX7tnA0hgXT47mjtZ2wbRexcEJYBWK24a3hObwjC5UDz0aaYswk1G6ntp5uKS5EZv2Fped8ycpjC4zEfI/RPKoxc7qtL909DCLFngCiOskq1+VPKtE4DMJMOzKubwiBPBG3Ugc2VW/5zh2wRseXiO2nsaTu3ko2ss/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hk7ufrIu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hk7ufrIu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F9401F00893;
	Wed,  7 Oct 2026 23:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791417011;
	bh=9huMJS2omXifPcdMUrkqZdPguZWo4m5ZDQAWUb6MUeQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=hk7ufrIuPENrwVL7FsquZxa75B0G+yPxdhOnjrNp9Tgb2gvD1dCLasNU4L1MDVCFD
	 f5cIqkY0S71zsuytBHnzZRJB9yfth490k0tDpIIbv3Jw0l2cRZmKNG5jJOlb+Fxeqt
	 jKhPxvVbOw1S7jQKaPCCUx7mYA9igsSCilZh5l+zGKdpyVyQ1mXKTXlYAtJF7eiRiJ
	 eZ+EX5glSEUb4GAesp6SGo+IBuVyctb1P3NMkn8ohhNks/egYBbIAyQQX7u+B08gB9
	 xwIBvcX9AUNzYl6dR9YaGFOMZOF4x5Q+i2sjXseXggBZV1/i7umCW/dlEsLq8ozVt2
	 /7rS4rQ6SwZlg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7756B3809A08;
	Wed,  7 Oct 2026 23:50:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] sfc: handle rhashtable walk errors in mport lookup
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179141701002.3739009.18146882524432057763.git-patchwork-notify@kernel.org>
Date: Wed, 07 Oct 2026 23:50:10 +0000
References: <20261003.final089.e0910b3ffb849fe4@gmail.com>
In-Reply-To: <20261003.final089.e0910b3ffb849fe4@gmail.com>
To: Sang-Hoon Choi <csh0052@gmail.com>
Cc: ecree.xilinx@gmail.com, netdev@vger.kernel.org, linux-net-drivers@amd.com,
 alejandro.lucero-palau@amd.com, lcy8047@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 02 Oct 2026 19:47:40 +0000 you wrote:
> rhashtable_walk_next() can return ERR_PTR(-EAGAIN) when the table is
> resized. efx_mae_lookup_mport() currently dereferences that value as an
> mport descriptor.
> 
> Skip error values and continue the walk, as the other rhashtable walkers
> in this driver already do.
> 
> [...]

Here is the summary with links:
  - [net] sfc: handle rhashtable walk errors in mport lookup
    https://git.kernel.org/netdev/net-next/c/2a1359aa651f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


