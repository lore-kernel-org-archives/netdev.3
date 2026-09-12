Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 564622F8E90;
	Sat, 12 Sep 2026 00:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789171275; cv=none; b=Q6ZH7NJ6AVQCs9YnmI1v6RrE/0laO8yH58k96ke09r66zmbsjTeUrtwc1Zbs7KBMpG30xMYNPEXjgEGXnqUbVdUsarN2++zOVFHCkp3u4zU7gpkYhDLfkBkChuLm2nOmow3DFiVK8e0hDWPwyR+lfqVIWYqaGTd3T4Oms5lIjDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789171275; c=relaxed/simple;
	bh=VCm2aft6A/tQReKgZG3uBM0I9/xMC6nbPAiNNRTcdRM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Jcnv8+9aclJ32bf0grTNG6OOlyNOs/1GL9/ly9dhYwrQZa2Pa6olxUGViZIwHeblwrmRG8yhmBjZB0jbYb9sE2l5SftqZL3NVDqa2uUriHBagGIe0vs/ivXzogXp6LHVbAXx4vSjjbaUJO4kC1xO0vGD9BpMpqo1tDRyc4Qsc2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FUR2ON4n; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FUR2ON4n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73A801F00898;
	Sat, 12 Sep 2026 00:01:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789171272;
	bh=wXNnz+MNIdVbdIjnmAzzJQtYMeNfMWq2EtmaVnHnA4A=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=FUR2ON4nmV7hE6ByMmqyPaCe3lFhvFc4CUresaVZVBL1URMPVX8TvyZiJvfT1bcrh
	 J/HUJvzFTxQOUc+PTyFMhjS55ukarq7OoyXoNhM8eUX70tkfiQABvzhF6t4I8JpGKN
	 ex0Ei3nkac53gJilMN2ehV/fIx9jpbgdM9VT2BWo9b0+JXP2xzUpLrd+xh0TVoXeox
	 0cQasaJfnPujd0CPEt4wWH+NheK40oaVa9I7F/aO8AGyZ+kbBGALy88kW00vgHD6Bq
	 WWODD3aZf2REmYUTkr+STP3/PKyCWgN51wzmbQljVhXgiRFMgX+sL6BSJqe+OZD+lO
	 RL4hx5jn3R6xw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56BEC392445B;
	Sat, 12 Sep 2026 00:00:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v6 0/3] net: xilinx: axienet: Fix IRQ error
 handling
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178917120887.3168051.5032452399743854940.git-patchwork-notify@kernel.org>
Date: Sat, 12 Sep 2026 00:00:08 +0000
References: <20260909045450.16176-1-phucduc.bui@gmail.com>
In-Reply-To: <20260909045450.16176-1-phucduc.bui@gmail.com>
To: Bui Duc Phuc <phucduc.bui@gmail.com>
Cc: radhey.shyam.pandey@amd.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 michal.simek@amd.com, horms@kernel.org, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  9 Sep 2026 11:54:47 +0700 you wrote:
> From: bui duc phuc <phucduc.bui@gmail.com>
> 
> Hi all,
> 
> This series fixes IRQ error handling in the Xilinx AXI Ethernet driver
> 
> Handle errors from optional IRQ lookup and preserve the original error
> codes instead of returning -ENOMEM.
> 
> [...]

Here is the summary with links:
  - [net-next,v6,1/3] net: xilinx: axienet: Propagate errors from optional IRQ lookup
    https://git.kernel.org/netdev/net-next/c/90ab44517ee1
  - [net-next,v6,2/3] net: xilinx: axienet: Handle optional IRQ return value correctly
    https://git.kernel.org/netdev/net-next/c/2d2f18d49221
  - [net-next,v6,3/3] net: xilinx: axienet: Fix IRQ error handling
    https://git.kernel.org/netdev/net-next/c/bb2b71024976

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


