Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22FB4363C79;
	Sun, 12 Apr 2026 18:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776016859; cv=none; b=kDpO5mKph1qIshzR6ZwrGMkM4sn8bsfeZERJHvNkBLfrWJ3wTzu3qo550bORIL9PvtztjrLo6sRp0yHHV2pZb4JMWxCAs/iSwLIuBvhdhC4Z5uPIAAZCLrlF4wBl8atFREIg6N9C5E7e7QbUZAMHR5tCOgF+3RAr2v19uO3Qyuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776016859; c=relaxed/simple;
	bh=ZTj+Pf1vhOOU7UDfBpeBhRWCuyyiIuj5iAm0UMKjVt4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=krl+OfiMu5yFXxLxiyrGiCpg+tw0hTekNSjJbOXwj4iw/rzDKUDyEGEnlOYcCd8nRJhwuJ0Mx2FMFTkNOCPA6z0/Psfrd7HsiTQEuBUxCvT+lIyiupNBxKKd2R3HzK65aAujCWs/vkXaybQ4C6zfzQDQUa/eyYBfS3NANORUBjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mzC2Yriv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mzC2Yriv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 855D8C19424;
	Sun, 12 Apr 2026 18:00:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776016858;
	bh=ZTj+Pf1vhOOU7UDfBpeBhRWCuyyiIuj5iAm0UMKjVt4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=mzC2YrivYgzsZ6gptw/R9zsdENJvl9X/1WHsKdTiB9ueJmwo7l7rd5Zru2T9SrdTz
	 EWwgMwQ/Nl8P10vnOfIhYJppDVWvqh4ZRY8LaXaWD35keE5KFDCqssJh+wBNK2MfWI
	 0oWmuefXGcB8+43rYM4EcOafwoimCcgeTDOZYOBgYJCxQ+bZNUXkVov9xYYyFi9ZQP
	 Jyg2AvfpQrrKMJNbIypcDQ5XdCRCWrZLh6LpwqmHiWvfwB7MKqDSfIG3ofusULprMf
	 LOGsMzZb4Zejmk4pJmW+XB8hBjqsbrzMklGGW6tdj7lJlNeYWTa9SFqzFBtY7C+E3I
	 03UDTJo92nsBQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FF9E3809A8C;
	Sun, 12 Apr 2026 18:00:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: lan743x: rename chip_rev to fpga_rev
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177601683079.3359939.16057683164182751683.git-patchwork-notify@kernel.org>
Date: Sun, 12 Apr 2026 18:00:30 +0000
References: <20260410085710.9246-1-thangaraj.s@microchip.com>
In-Reply-To: <20260410085710.9246-1-thangaraj.s@microchip.com>
To: Thangaraj Samynathan <thangaraj.s@microchip.com>
Cc: bryan.whitehead@microchip.com, UNGLinuxDriver@microchip.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 10 Apr 2026 14:27:10 +0530 you wrote:
> The variable chip_rev stores the value read from the FPGA_REV
> register and represents the FPGA revision. Rename it to fpga_rev
> to better reflect its meaning.
> 
> No functional change intended.
> 
> Signed-off-by: Thangaraj Samynathan <thangaraj.s@microchip.com>
> 
> [...]

Here is the summary with links:
  - [net-next] net: lan743x: rename chip_rev to fpga_rev
    https://git.kernel.org/netdev/net-next/c/469faa546e7a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


