Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD5F360EE2
	for <netdev@vger.kernel.org>; Thu,  1 Oct 2026 00:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790814624; cv=none; b=LPwv7swHEjCUlvNB4xXxea0whNrr/qcXc/RlU0BtqBuIBsLuyXZQZKIvphbkNkXdEe3Vs4zbv3ULoDgwUm2Q3LB3rSVmsygT00+Qy+PhVrvpS6Zl6gfzhri1PdWb8H91u74plVaXIsJebvHwaM8RmI8zxVLuRQ0DnR4i5/Jhums=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790814624; c=relaxed/simple;
	bh=+e4T9eal7wIz11vTJ0Qah7TsnYInRValVPBT/yQ6ql8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=GZBa0kSQnmaxqTh4G3x4e0kMvcVpg5TR9iv3jM60b8GnChSZ1xXabTKm2BoIy8hPtz2b2uHb2hLW0YAD6KlBcEs70sQyUh6RmIyX3n1wRj7OlnzgYalCufYwN+4WtI83o3Auc+h0Ct3xKKMSISetjzXvCw8CeCwj1XpPpF9KYEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FInIRd2c; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FInIRd2c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDFA11F00898;
	Thu,  1 Oct 2026 00:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790814616;
	bh=4pXN3a/8aQGY5z43epBJEHa2ngFOOxxLDkrNmymXAW0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=FInIRd2cmBDFj8iTGLTVbfXtV7sNLWS+3nTtV27EqvL0XZYRcIo431vJQiYiHSUai
	 ZD9ojKE3PGGR/+R5DDl9Pn3OTiSfgrB9SXZA8Vj5n3KJKztPgEP1+8RMb+Yo/uM36a
	 tQ/bei9bIAqz+7vdySeYsBJdf9536N9gylNBVyqHJpIHzQD0voMB9KhsgHz0eU0rOB
	 WwEohDlqtAHUQu46voLa3/fr7N+bQM9RiRpxsHPvYPoH0C4Sda7IylsHqwzsdPjVyj
	 YbFJqrAJ9PrNF9ZncYy2ou5zzn7IvZn49+Vc7EoJtfisHJJlDUqVJ4yWthoK840Dew
	 d7I8hax3iPv4w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B44F43AA6A61;
	Thu,  1 Oct 2026 00:30:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net RESEND] octeontx2-pf: Fix RSS indirection table size
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179081461529.2189941.17932880589299208108.git-patchwork-notify@kernel.org>
Date: Thu, 01 Oct 2026 00:30:15 +0000
References: <20260928084711.2462571-1-jase@nocloud.org>
In-Reply-To: <20260928084711.2462571-1-jase@nocloud.org>
To: =?utf-8?b?SmFyaSBTZXBww6Rsw6QgPGphc2VAbm9jbG91ZC5vcmc+?=@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org
Cc: netdev@vger.kernel.org, kuba@kernel.org, sgoutham@marvell.com,
 gakula@marvell.com, rkannoth@marvell.com, sbhatta@marvell.com,
 bbhushan2@marvell.com, linux-yocto@lists.yoctoproject.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 28 Sep 2026 11:47:11 +0300 you wrote:
> The conversion to the dedicated RSS context operations replaced the
> pointer to struct otx2_rss_ctx with an inline u32 ind_tbl[] array.
> However, otx2_rss_init() still uses sizeof(*rss->ind_tbl) to set rss_size.
> This now yields the size of one u32 (4), rather than the 256 entries in
> the indirection table.
> 
> The RSS initialization and hardware programming loops use rss_size,
> so only four entries are initialized and programmed despite the NIX LF
> being allocated a 256-entry table. On an OCTEON CN102 with eight RX
> queues, the table contained 0, 1, 2, 3 followed by zeros. Traffic was
> concentrated on queue 0 and ethtool -X equal 8 did not correct the table.
> 
> [...]

Here is the summary with links:
  - [net,RESEND] octeontx2-pf: Fix RSS indirection table size
    https://git.kernel.org/netdev/net/c/9e792901418d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


