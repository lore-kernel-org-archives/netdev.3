Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79A342D9EFB;
	Tue,  5 May 2026 12:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777985460; cv=none; b=ohnEudkmxoRoHVJ7y8xEr6ELLrYiuO0Szmp8KhS7Ca14PqbRARMjrocO7YDzwydEX/BzyzKUMLj7yr7Zoale7ObpgDxcKaNfrPiSdPZZ4nrdocSbl0tM2AtYfDrmjcdOSjLCW1GZS8uKpKYv+k54WsCEzCzZMP4ebZa+NK57iXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777985460; c=relaxed/simple;
	bh=ZqIiNWdXiJAiL/Rf9EfJxYFKaiKVWBsVcRA2SGTvH/M=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=PgpNxb5v1JO0VVaqsj4uQO94JwQwY2mR/DwL3l5nC7UWrE74QuWGnQTaMbn25gY3YaSeID15+Y7jo+W8q1bLcL7AaW/4tEFM8H8Iy0z5LiXqEkvV2iDkf+73LJGgeDXVeiZOHUyKhnE5pE2TT+wr5FDZvHj/Z9lqePejfXncqK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WESTXWMn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WESTXWMn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34174C2BCB4;
	Tue,  5 May 2026 12:51:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777985460;
	bh=ZqIiNWdXiJAiL/Rf9EfJxYFKaiKVWBsVcRA2SGTvH/M=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=WESTXWMn0zH6B43vjXhV7b+BblLWdbSlNfJ6gR6OM4/1s6o3O7rpVyZHP/32GIUCa
	 xSWR4eYFKtC5sYGcT0SuRAozEtvlVvWIwZ1X4rMYIGeScNXO3XJJzGfAb+LHKnh+oc
	 zjynvuLDkS/D7865/LBc+omS7LWIjdHxo7x9DIKL5FqGnNTSxRPq7nOpC3bQ/i6a9J
	 003W906ahS2O4SpVKZRDzv3R0avX7M76+QJY9Qh0QmFuQVPHiTY5RUarVUVbzphGjH
	 xdsP0FIK+8cBVoPNqzSiXfDy+dRnCX4LEhEG2X2IBVmXgpr1KtPW4SYvP04VTxUH+x
	 4LDFkYoOPFBeQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9EFD3930229;
	Tue,  5 May 2026 12:50:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3 0/4] irst series for xpcs based rsfec
 configuration
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177798541055.1614648.8039689211689710267.git-patchwork-notify@kernel.org>
Date: Tue, 05 May 2026 12:50:10 +0000
References: <20260504135815.44226-1-mike.marciniszyn@gmail.com>
In-Reply-To: <20260504135815.44226-1-mike.marciniszyn@gmail.com>
To: Mike Marciniszyn <mike.marciniszyn@gmail.com>
Cc: alexanderduyck@fb.com, kuba@kernel.org, kernel-team@meta.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, hkallweit1@gmail.com, linux@armlinux.org.uk,
 jacob.e.keller@intel.com, mohsin.bashr@gmail.com, horms@kernel.org,
 lee@trager.us, andrew@lunn.ch, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon,  4 May 2026 09:58:11 -0400 you wrote:
> From: "Mike Marciniszyn (Meta)" <mike.marciniszyn@gmail.com>
> 
> The series:
> - Fixes an addr validation error
> - Adds MDIO defines associated with RS-FEC
> - consolidates the handling of the boilerplat ID registers
>   into a routine to report id'ish registers and reduces the lines
>   of code across the entire set of c45 routines.
> - adds PMA read/write routines
> 
> [...]

Here is the summary with links:
  - [net-next,v3,1/4] net: eth: fbnic: Fix addr validation in pcs write
    (no matching commit)
  - [net-next,v3,2/4] net: mdio: Add support for RSFEC Control register for PMA
    https://git.kernel.org/netdev/net-next/c/ca283942e5b9
  - [net-next,v3,3/4] net: eth: fbnic: Consolidate register reads for ids and devs
    https://git.kernel.org/netdev/net-next/c/d7dbf00b4a55
  - [net-next,v3,4/4] net: eth: fbnic: Add pma read and write access
    https://git.kernel.org/netdev/net-next/c/3877097c3c9e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


