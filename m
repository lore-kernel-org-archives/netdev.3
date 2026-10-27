Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793141407;
	b=Zis7lIrAqY+K1GqewGk5mMAOd0SFRWj2e3ugpAFQkpv7ZIX628hOfeTFiNozpbRzDZOH
	 /vG+O6okAq5PF4BOXpZ6lV/KYOdWxAcrvIBZ/EkQDVNsPyL0vJCscMilBxxd1Wg3+1t7N
	 HjXXqAoboPBEUPtD49YMVJ5AIz9GgnVSj5s8Coi8wNUPamGFDkqlUmUgghey+57RL1OxZ
	 yhLYuhLMuyRo5CRgbzaZkWU8thbhopjeg/McWkCCuXyufImR82tyjzLs1bM4H3z6sLOLp
	 W07PA50OT83zyb6ryRcB6Gn+itApPDBH90Uuvr7mV3CyOEMZ+qDN3Uj8aE1fSAptKTQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793141407;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=vfEYE56m4j+K4mKjUOuJqPuq7r+1taq0gnqr57A9Ye4=;
	b=duhs4oXhxmT3rchsjZv4/7p4KAa/ecOr2OqjZqTqZzUbh0eTANd0AJOw4WegMxfGZg8L
	 1TRJIzR6mYTC6Izs3yr4MgMbb+LHGnU2cWrJqMW8y2CVSMxkKnw1JrToqDkGaW5D8JILd
	 Nwk6kRJfRZWnAGiKlRIYcf8VONAZcyLZVZPkDnLank5dzvUHOKU69Z0Lnnf47SFDP7V4a
	 8VPb93c58dzH7oUFOpxGonBUcoqVIR5sB0DHg+9Sa6xPLdsdNDSscKwu+zoIKsQ0q/pN0
	 91vECzCfsHdsvFslUzYV7pCdDV9NHdQohWvtWByVSnEUKnls9pc44ioLdMGcMWpQqGw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=A6nxfHMI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 049F6606A31A
	for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 22:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=A6nxfHMI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CDF31F01828;
	Tue, 27 Oct 2026 22:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793141406;
	bh=vfEYE56m4j+K4mKjUOuJqPuq7r+1taq0gnqr57A9Ye4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=A6nxfHMI9yGC/T5F5tRk9M/N4gFwAL8AlZIbZumpANxeJ4qQNGefJoElVsxj89+tD
	 0FZ65vZR7RvYeYnDSQ9m/ts87pASUeT9KYPS4dd39F5tzt8E+lwgV41n5TgfFw9ucI
	 Jz9OwyCKJ5rUVCreb3Rzdnb5WvnGbjQEXsmdSZj22B/2PwpSK2IL3D0Xc1wcgvRQyu
	 rBPUXvqShhUQ2PHb9fU6Ma8u30uOPgjumYXmGWFdRPF8WvHx5sdh95HkXz+Ng9+wiN
	 U8/nUoEh79jkANMQtQPyWKgtdj43/D5hwgip0mv6g/ZeLC7ia2WR/dP0cU5tebCWM+
	 rkU2pygjMMVtg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 814ED3AA940D;
	Tue, 27 Oct 2026 22:50:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] devlink: region: fix snapshot id leak on
 kernel-allocated
 ids
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179314140532.375317.5828428376782331028.git-patchwork-notify@kernel.org>
Date: Tue, 27 Oct 2026 22:50:05 +0000
References: <20261026174403.512-1-fmancera@suse.de>
In-Reply-To: <20261026174403.512-1-fmancera@suse.de>
To: Fernando Fernandez Mancera <fmancera@suse.de>
Cc: netdev@vger.kernel.org, jacob.e.keller@intel.com, horms@kernel.org,
 pabeni@redhat.com, kuba@kernel.org, edumazet@kernel.org, davem@davemloft.net,
 jiri@resnulli.us, yangguikun19@qq.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 26 Oct 2026 18:44:03 +0100 you wrote:
> When DEVLINK_CMD_REGION_NEW is issued without a snapshot id, the kernel
> allocates one with __devlink_region_snapshot_id_get(). That helper counts
> the caller as a user of the id, and the caller must release this hold
> once it is done.
> 
> devlink_nl_region_new_doit() never drops it. The refcount of the id goes
> 1 (allocation) -> 2 (snapshot created) and stays at 2. When the snapshot
> is deleted the count only drops to 1, so the id is never erased from
> the snapshot_ids xarray. The id then stays in use for the lifetime of
> the devlink instance: requesting a snapshot with that explicit id fails
> with -EEXIST, and there is no snapshot left to delete to clean it up.
> 
> [...]

Here is the summary with links:
  - [net] devlink: region: fix snapshot id leak on kernel-allocated ids
    https://git.kernel.org/netdev/net/c/ef8f0a1d888e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


