Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B01247ECD8;
	Mon, 21 Sep 2026 23:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790032878; cv=none; b=ahuZVUZo3NJ0Ft1NjL1K7iIC6IJrfl9Q+43UFxy7xaryL8GQdJ6QxYOVQr3ZMeiB4LY1lECwZyuNM+wVma98bW3Zcd1huGRydFbxc47spXnE4zCVY07a9hVzTIgScxRfkkcPOryEBFm9ttvniWyqSL6s8e3HwJbAJrHfz7sqo1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790032878; c=relaxed/simple;
	bh=49o9pb+1VoZAoiQJaXKdb0V6bNnez0VH69mWuklhJBU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=OswnVLn0OaOefKux3FJyHnKsU7iG+ZGRhWLxG1Rx+UsjG2E9BNrhF7rxC6OfdYuk9rIn0ckcOIYPd/j7Wb44K7dcHT84fxBiIsfgkpz1uf70JgeYlpe+okKfkxuVeCxzPme65F55a1w6HIIMLTYx/C/AXZeW26oo1h0zRVfAsks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Da6lJQRE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Da6lJQRE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3121F1F00893;
	Mon, 21 Sep 2026 23:21:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790032877;
	bh=k9NrOWYVGtDR/lirl5Q6knd2UgIX1yDhfPFcB6MWFEU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Da6lJQREWrNr5lnviBVprCqBiPq3nwtPDM8GnBB/5Lp7JnO66fg12kYXGJHirKBuN
	 41cHRUdTGWqbIZ4OU1Bdui66/tlZjkI4mHzwECLyK91aXS3MyjlnIiPnloINwlcAlr
	 egjUi+n/qZFO+y8Q87YvfTBt/Iq4P3aSYEtR3x+cgCNdtFNStg4hAd4SqRUmlyFQsz
	 QL66aaq8LSsYnh3ryShk44WZ0evU/o8qIOsKyuXO4qz1dicvvANUkEXZQ+9YKp3T8p
	 KnyxEVfnZsJkCh4XgzTxHQHstw8+yjOOjaIFRJ8klO2JqMatXkDQWXLpYCmFtPh/qn
	 vmICFVYVlzRiQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D09D23927048;
	Mon, 21 Sep 2026 23:20:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] sfc: fix CONFIG_CXL_MEM dependency
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179003280839.3282843.14048096814750266893.git-patchwork-notify@kernel.org>
Date: Mon, 21 Sep 2026 23:20:08 +0000
References: <20260917155519.2121486-1-arnd@kernel.org>
In-Reply-To: <20260917155519.2121486-1-arnd@kernel.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: ecree.xilinx@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 dave.jiang@intel.com, djbw@kernel.org, alucerop@amd.com, arnd@arndb.de,
 Jonathan.Cameron@huawei.com, alison.schofield@intel.com,
 netdev@vger.kernel.org, linux-net-drivers@amd.com,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 17 Sep 2026 17:55:11 +0200 you wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> A recent patch introduced a call to devm_cxl_probe_mem(), which is only
> available when CXL_MEM is enabled. If CXL_MEM is in a loadable module,
> this causes a link failure for a builtin driver:
> 
> s390-linux-ld: drivers/net/ethernet/sfc/efx_cxl.o: in function `efx_cxl_init':
> efx_cxl.c:(.text+0x156): undefined reference to `devm_cxl_probe_mem'
> 
> [...]

Here is the summary with links:
  - sfc: fix CONFIG_CXL_MEM dependency
    https://git.kernel.org/netdev/net-next/c/c6219deaee41

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


