Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24D3A372B59;
	Sun, 21 Jun 2026 22:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782079281; cv=none; b=Ycf/KXDufTeCkA1YojRxjoKkxyLe7R7/AeLr1S6ZBI/XLOkcTOFPgZ2Tum0j6dw/StaV1JaeY0mJTyDhq7efdazYOZhXyoo1knBX549nngNKLCc2uyZKp8E8ijUC4i5KsuZlmxOxQQNV7QzWNPlMuWFBQSuA7/FjS6uTki0oo0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782079281; c=relaxed/simple;
	bh=gzHqVNtZ9nx/4IWaiCUdxlGpaS/vvrNo1cKnZ+AInUE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=fL2paoLojCnqQFU/4O/j3AWVlOTiIPH1CkRkGfoSAVAj49CDgAKq/1w2eFE2ZaQ8aNm2/bRf2rbtf7UihdBWdHJDR+fWSQL40htJm8qp0jvhLwSDBCJLfz8oM1EbML21WMDv57W7bjwUvWxulUld6XixQJ/FvnHIIUhcL5MWFkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OzV7DHxp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OzV7DHxp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB1B31F00A3F;
	Sun, 21 Jun 2026 22:01:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782079270;
	bh=rr1kRC7DmcQUsQS5kjH37JE6NDQYexMdeYMI9QWNd/s=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=OzV7DHxpyF6lG+Iyot/h+RDkyTEKyhL/+zsmhmqcWFxGPgM5gcOQZy8WfZGH8yGli
	 ZzEdSvg/w+0NukhiRwt8OXtUVi0v23HzrhsXS2xYS+qxi4rGmjsSKFAoDQErcuJFS1
	 9Wie/ltdNyq09aRAi1AnE0P/X8eM1eEY/lSVHa3AQi21v9ZaIatTul6GYJVORsdZoh
	 URS86bme3HkFg9oQ0m/iXof6LcI9UL+aKhpgX11CjDF2qtLQ5Dk7PbRN+nttmrPsy7
	 44hL1rT72ZfemULE9F2UI/B4I8scFlOp6d7uKz98zsktNDR9fcQfiT5xCee1kH5ht1
	 HOBrA+TNznHmQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 5683C3AAA6EA;
	Sun, 21 Jun 2026 22:01:03 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net PATCH v2] octeontx2-pf: mcs: Fix mcs resources free on PF
 shutdown
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178207926207.516339.1021134955116133326.git-patchwork-notify@kernel.org>
Date: Sun, 21 Jun 2026 22:01:02 +0000
References: <1781636420-19816-3-git-send-email-sbhatta@marvell.com>
In-Reply-To: <1781636420-19816-3-git-send-email-sbhatta@marvell.com>
To: Subbaraya Sundeep <sbhatta@marvell.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, sgoutham@marvell.com, gakula@marvell.com,
 bbhushan2@marvell.com, rkannoth@marvell.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 17 Jun 2026 00:30:20 +0530 you wrote:
> From: Geetha sowjanya <gakula@marvell.com>
> 
> On PF shutdown, the current driver free mcs hardware
> resources though mcs resources are not allocated to it.
> This patch checks the mcs resources status and if resources
> are allocated then only sends mailbox message to free them.
> 
> [...]

Here is the summary with links:
  - [net,v2] octeontx2-pf: mcs: Fix mcs resources free on PF shutdown
    https://git.kernel.org/netdev/net/c/450d0e90b103

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


