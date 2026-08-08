Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98FD2312825
	for <netdev@vger.kernel.org>; Sat,  8 Aug 2026 01:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786152666; cv=none; b=MYbn8CyUOt4sv5Fg5+aZoBiVKjXX/gZSP+I619nmk+Shr5K1iS6Bvtwta/ZCBM7rMYGnkqAYGUV/W1Qy7OCqa65WOdpuTYcKfwRmonU3SAmSeFh8MaIkI2eWZW7TB1SmhlfsqPUDHi58BCW0Vb7iYa/vsF4/nEWlpsytwMmEU7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786152666; c=relaxed/simple;
	bh=Zyn9ty3P7VpfSARnLBjIvTFHTMvi+UjG+u7xf0I4NPE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=l93t5qMsx6NfsRbWWEMDE+R2dHFiJ8Jfbd297Rp/txSXKteOw2bpb2uW6aaVnXPurt9NH6SDukNbCDyJaCHouhObcqExqZGjm7ypSxHRkmgwVIMBa9kKzL1CfmhmtcFREFlogt0gCMv7tZkRSHHGBqEin4bz4/Adk0UMFRSl48I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WWnlcATd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WWnlcATd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3591D1F000E9;
	Sat,  8 Aug 2026 01:31:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786152665;
	bh=PCD5Zb9NVyILrX2MftKTb7wu55MGtoxxnw7WtccEgGk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=WWnlcATdGFwojonKkWY6CRHPhA/jVL5Intf5FAZOcmgFqGMD7/rb0+um1B/WGCSiU
	 yrAvgalPVmrIl76qUjynm1O5lH8ChzNllZalGwHKpkalbPVoVu4v/kF6xaUJc20KP2
	 KEbSLpCooNL117eGwn284LmwawM8bfFVIJALzgdlBvZ5W1i6uYtA76ywyIzgAMG+SJ
	 JtOXYub/joHSBhpr+8V/X6EuTFlr+vyUUZ2sNj9oWrYKvZ3GRX+VfVGJC/R4L4RFQm
	 IZJO5xjS0anB5OaopD1yLZjL8SeLCyKX3AlwcWQ8tMJZBze5RMDptuYuZUz77xZbVV
	 DtBEQiYsNu7Iw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0A13380CEE4;
	Sat,  8 Aug 2026 01:30:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] MAINTAINERS: add Ivan Vecera as DPLL reviewer
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178615262332.2491826.5663643916941410352.git-patchwork-notify@kernel.org>
Date: Sat, 08 Aug 2026 01:30:23 +0000
References: <20260806094432.163833-1-jiri@resnulli.us>
In-Reply-To: <20260806094432.163833-1-jiri@resnulli.us>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, vadim.fedorenko@linux.dev,
 arkadiusz.kubalewski@intel.com, ivecera@redhat.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  6 Aug 2026 11:44:32 +0200 you wrote:
> From: Jiri Pirko <jiri@nvidia.com>
> 
> Ivan has been continuously active in DPLL development and discussion
> since April 2025. His contributions cover the DPLL core and API,
> netlink, bindings, ICE/SyncE integration, and the ZL3073x driver.
> 
> He also regularly reviews and tests DPLL patches from other contributors
> and already maintains the Microchip ZL3073x driver. Add him as a reviewer
> to reflect his ongoing involvement across the subsystem.
> 
> [...]

Here is the summary with links:
  - [net-next] MAINTAINERS: add Ivan Vecera as DPLL reviewer
    https://git.kernel.org/netdev/net-next/c/1dd5bc0b9a07

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


