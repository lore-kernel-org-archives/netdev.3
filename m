Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6664B28688C
	for <netdev@vger.kernel.org>; Tue, 28 Jul 2026 01:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785202842; cv=none; b=bLHZSRw/OjFF2nQagBRtSnu7m2nrRGSD7t5pyOqnx0b32DvGqNXCuXuyg8hJM9kXiVduxYXgKQAVm4VLAsbwCkC4YJq94zX1flY/xOgvLH2CR9o2o6u62ijujnZQEYMXzOkIZPr6GGsuoTCfzkSc+LGnO7MUKUaXSmqNVyqKeg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785202842; c=relaxed/simple;
	bh=JgJUjJoDDzqCRu/vxLfoo4D96t1U5cG4FkMc57dOxnU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Xm3iEHEou5RaoPhyyCgLe8Sw65u3dtrY0UFafXcPj0gE+GVvC7DlUZ6uWlmpVuCHA4Kb0JQK8AN2NQKoBCR9qt+idwd50R8rIRTQqaST9JITY5EyBAFy+sl5k6ifD5VrqwFeZhaYruGpuuTSyUhOycARZTRO+2HYBj5cPKpoacs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oZE5RmfH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oZE5RmfH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECB791F000E9;
	Tue, 28 Jul 2026 01:40:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785202841;
	bh=edCg0lhAhbUTzplxHz2XgSHJ0iZewqeOM86fCWNo/6M=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=oZE5RmfHWudgmNVNbYQ/W2oKguif6dXzc/3AinFasBoQwR7CYrebwclCcghNV+GPv
	 Hp6C1KcmH5pfNl+4XlKXBtTfRENGdHmSRRK6fmBn+PlN0eUXP13YDrFV+QLTU2FHfg
	 rWILPuD2VNamRYpPvbi1onY+jNLAJf4ln7qj8OAYiqJfoDiPSc3xIvxQvIcdEJ1DvM
	 f957HA3N7kL8KTj8AJPo+S3rDQ45FZ1F93W3AteL78I6Mt81ndQGyyQI1amMoTjIcT
	 gx+jKuxSW5MCoa9E/QNtxekxDjNSDOFj4PMXKGpS9F74lm2DN1KYlmvfX7nyk/7pnQ
	 7TGv2IQkeGO7Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56887380CEE1;
	Tue, 28 Jul 2026 01:40:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] ethtool: Embed FEC hist ranges as buffer in struct
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178520280589.1496519.4860633806524350766.git-patchwork-notify@kernel.org>
Date: Tue, 28 Jul 2026 01:40:05 +0000
References: <20260723041342.39238-1-eric.joyner@amd.com>
In-Reply-To: <20260723041342.39238-1-eric.joyner@amd.com>
To: Eric Joyner <eric.joyner@amd.com>
Cc: netdev@vger.kernel.org, michael.chan@broadcom.com,
 pavan.chebbi@broadcom.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, saeedm@nvidia.com,
 leon@kernel.org, tariqt@nvidia.com, mbloch@nvidia.com, horms@kernel.org,
 vadim.fedorenko@linux.dev, maxime.chevallier@bootlin.com,
 brett.creeley@amd.com, leitao@debian.org, nikhil.rao@amd.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 22 Jul 2026 21:13:42 -0700 you wrote:
> When a driver's .get_fec_stats() handler is called and the driver
> supports FEC histogram stats, the driver supplies the histogram bin
> ranges via a pointer.  This pointer is assigned while under the netdev
> ops lock in fec_prepare_data(), but the actual data is only read after
> the lock is released; so this allows the driver to change the ranges
> (e.g. from another .get_fec_stats() call) while the current call chain
> is reading them in fec_fill_reply().
> 
> [...]

Here is the summary with links:
  - [net,v2] ethtool: Embed FEC hist ranges as buffer in struct
    https://git.kernel.org/netdev/net/c/97ac08560d23

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


