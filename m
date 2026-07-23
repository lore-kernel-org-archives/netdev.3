Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA99626A0A7
	for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 14:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784816438; cv=none; b=VjOHVkAGGWWpqfZhP9DWEr+QuKVnBWzNQkS0vueack+IsPDL6NCR+K9x26YH5pAhmSZfEwfr5NBpHLCvoGLQ0bPRpivSgG19ieXDImzi6vMW/mV0elqXfo8sFZ4etAQ8tEZuMi0gr1IFmO6umhENjXjoL8By/7zhVHO6eXAcv50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784816438; c=relaxed/simple;
	bh=UsIY7bHVSxnfJs7xqr+nTU87YvwtsRG8y5k0Pk6HPaw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=sFrk5hH6rzngAbi6CD7YqVWGbFh44EGxkiIjTXz+PKzJITHAO4S2d2hW4+ceJpm0Gre56+YPbokjJSUbQbAfXCbWLhWhQSsvgz2+WhFkwNTyRzuzNcQJ8zKNuoCeXG0GncswuuGAnOmNX6JVSoKs2BsudrxhkLHn5Wn/kNUnhNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MRdVuYxo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MRdVuYxo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 855B21F000E9;
	Thu, 23 Jul 2026 14:20:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784816437;
	bh=vQ6qCLlSkfDH9AijWMmdNqndl+7NMPlZf5Z0VJDZizM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=MRdVuYxoYRjG6A2DOalVyKaRqhSjqPJFvn7u/BPrjhV5G+LWHF1bo+YjKcL1pS1Gb
	 NTI8fAd6eR50IFrKM6NmToOzp01K7KNFb1GN+8Ndu2IokXE4og4djh9IwzJT72VLhO
	 i0njldNUHCixSezsj1gaBYWJvGcadLbvK3agj4GYwK3w1o42O2wIo/bDu7SxktIeuA
	 FkcyzX3duvrHj6dDuUrwbJNI91Hnv/vMEl5d0CsTLkoWadq1bfn9Ed2eqZo988QBHJ
	 1Kdj/ym6vkiTyXUDakOeKqYp7KCHiQ+PzV8cFqF4Dv+e1zTC06i9a4AK2p/CpmK7N3
	 bgW/2t9A8DIZQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id DF691380CFDF;
	Thu, 23 Jul 2026 14:20:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] hinic: remove unused ethtool RSS user
 configuration
 buffers
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178481640569.2277630.11774218099848941237.git-patchwork-notify@kernel.org>
Date: Thu, 23 Jul 2026 14:20:05 +0000
References: <20260722025353.328179-1-chenguang.zhao@linux.dev>
In-Reply-To: <20260722025353.328179-1-chenguang.zhao@linux.dev>
To: Chenguang Zhao <chenguang.zhao@linux.dev>
Cc: cai.huoqing@linux.dev, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, zhaochenguang@kylinos.cn

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 22 Jul 2026 10:53:53 +0800 you wrote:
> From: Chenguang Zhao <zhaochenguang@kylinos.cn>
> 
> rss_indir_user and rss_hkey_user are allocated and filled in
> __set_rss_rxfh() when the user configures RSS via ethtool, but
> nothing ever reads them. hinic_get_rxfh() fetches the state from
> the device, and the hardware is programmed from the original
> indir/key arguments. These buffers only leaked on driver unload.
> 
> [...]

Here is the summary with links:
  - [net,v2] hinic: remove unused ethtool RSS user configuration buffers
    https://git.kernel.org/netdev/net/c/fe0c002928c6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


