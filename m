Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B48E83EC2E6;
	Thu, 25 Jun 2026 16:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782404467; cv=none; b=DKkWhHPU/f51xdpssodyMA3Ac+PQzcX+w3q6J+TvzgGNqU4ucEJFlxBUOODKZMHtIFkm8pkmmq1tCiPXEH8nGSm209o53xGsZ1cSaNV3ZMYuz/HShiBiZ1q/T+NnsNj5MT2+CWNsykOUH5t03eKa7eFjg05Cl1kwZOYHIFev82o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782404467; c=relaxed/simple;
	bh=nmzaJ9qAjRvcDu6lvMWN1kxGdib8PzNuZj/BZUNDzqM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Dcum17AqWv12xBuwJxVoAbXPZVN+tY9kVlEi7tJ5RksrRLGnBjU4YHjGbmFGElUOAh/oPk6DwRYe9kikWljFIHFmIdXNVUPSRrJsRGMsxmSJhTUlfF023MK/tQK3wNEuoXsA9ReCi775E9/hleQTwzL3k7SG148bmv3Jf38AWpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AwVHAYrw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AwVHAYrw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D1651F000E9;
	Thu, 25 Jun 2026 16:21:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782404466;
	bh=dlF9zJmdEWtvd9sI0K2QIVPhdbAz6lNIzfcSCz1zFRY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=AwVHAYrwPzlXRzOzopzAvMrh+WosJ0nefQ7SM8HoBoAAFnTljWXkBusuBwV3TXp4G
	 LiWQA3h8nxO8cNFOHbdXDAlZZegc2RFKwJ9Tc5WmVwNjDsxOVrlV+2ngP30MzWATAI
	 wPUwd1upBUdrPfR21jKnDbP8gOeQO38dljoR+1BTybXmvQqEavaKX1PsxJgLldxOCt
	 bh/oNOlOOstkzckl4zpzGkYd5CgjPxfJepwaGp+ok8VgXFdjWyeDgwD9k/O9JcKfiG
	 UnBi/gvss9AEsd5aITUEmwcuGUm0isse/WsNxgwfqE5e1vBXYs0/OeO/MPjD7tenvD
	 pR9aFarMFs+PQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 568F23AD449A;
	Thu, 25 Jun 2026 16:20:55 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] selftests: tls: size splice_short pipe by
 page
 size
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178240445394.3803792.14417795054896791465.git-patchwork-notify@kernel.org>
Date: Thu, 25 Jun 2026 16:20:53 +0000
References: <20260624134416.3235403-1-nirmoyd@nvidia.com>
In-Reply-To: <20260624134416.3235403-1-nirmoyd@nvidia.com>
To: Nirmoy Das <nirmoyd@nvidia.com>
Cc: kuba@kernel.org, sd@queasysnail.net, john.fastabend@gmail.com,
 horms@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 24 Jun 2026 06:44:16 -0700 you wrote:
> splice_short grows its pipe with (MAX_FRAGS + 1) * 0x1000 so it can
> queue one short vmsplice() buffer for each fragment before draining the
> pipe. That assumes 4K pipe buffers.
> 
> On 64K-page kernels the request is rounded to 262144 bytes, which
> provides only four pipe buffers. The fifth one-byte vmsplice() blocks in
> pipe_wait_writable and the test times out before it reaches the TLS path.
> 
> [...]

Here is the summary with links:
  - [net-next,v2] selftests: tls: size splice_short pipe by page size
    https://git.kernel.org/netdev/net/c/3e52f56875c6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


