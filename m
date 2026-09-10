Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C314381B0F;
	Thu, 10 Sep 2026 02:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789007472; cv=none; b=hZphmPwXv7/JOn8lIxrJ58jQB+1PYE0BnJjWykUdai3zbifgkGnIlzO/aLRWPjxGR7gVWefBJ7LFtnjAyhr0yjlAP3P2pgA1/71k8kiQbU8KaVkSQ8W0YRL63Gwm2EGjvvSo6gcVNTo1wcPdf5dqVutTo0YQjj5Ni5wVmofw+vA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789007472; c=relaxed/simple;
	bh=x7FoWY7B87S7H3jW44KzHSvH2K4cjYbCfUcRdQzjDPA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=XTI8WOzpCJKVCbnDk93++M9j7vzVMLQgMFKXkoHDcd7PQYuTcgpMyMxpWzGu9vy6uN8tL79wHKk1tpxmcU10jL9cLHsr8SJT7RZl+dd3sF3GAOOydRUviMpYEKL2umBsAfx2j2Ww+eIN+/DGrCa9xpq3Lhaz0Dv2pWbgKH1p9tE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=niX6GcJ/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="niX6GcJ/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CC371F000FF;
	Thu, 10 Sep 2026 02:31:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789007470;
	bh=ILWMeGu8Q4VrWnsELjeVOHZhSwlw7EOggWUiFpzcROM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=niX6GcJ/heij9i8Av5D9HFjXSCeBDB3y8JqoglkD3MtjE1LhelhBPbSeIs0YkhXVi
	 P30sL70uts1KINW2P3kpI4cA8AxxTJtRhHJmDS9LHBf76v6XiC001WicRTKI4EpG7W
	 8e7PpEe1UpIp0HQAPdNXUfLERIs6ji51cBOxFNHQqpLLj7PTUqPk+AlItW16R6bV6v
	 P33bQ40syh68002FrdB65u3obeIkxfMwLsgFzy6PfdZai/yva/BItcA6HhluJ68h1O
	 oE1qmJjCDAL8ur9fAKKynjmBqKVfB4Uinj0sUbUyNj8jLvu2tAJ93Oc4VvkFWbHcrB
	 MeaXk1nGSrc5A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 19DF7380CEC7;
	Thu, 10 Sep 2026 02:30:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3] r8152: simplify loops in
 generic_ocp_{read,write}()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178900740762.1158570.15374984168475217881.git-patchwork-notify@kernel.org>
Date: Thu, 10 Sep 2026 02:30:07 +0000
References: <863dac62-89ef-42d7-9108-d4a0600913a4@auroraos.dev>
In-Reply-To: <863dac62-89ef-42d7-9108-d4a0600913a4@auroraos.dev>
To: Sergey Shtylyov <s.shtylyov@auroraos.dev>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux-usb@vger.kernel.org,
 netdev@vger.kernel.org, michal.pecio@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 7 Sep 2026 22:46:32 +0300 you wrote:
> In generic_ocp_{read,write}(), the *while* loops look very strange:
> the last iteration is implemented differently to the previous ones
> (doing some useless assignments before *break*) for no good reason.
> Merge the different iterations into one, using the local variables
> in the loop bodies...
> 
> Found by Linux Verification Center (linuxtesting.org) with the Svace
> static analysis tool.
> 
> [...]

Here is the summary with links:
  - [net-next,v3] r8152: simplify loops in generic_ocp_{read,write}()
    https://git.kernel.org/netdev/net-next/c/f217004a40c4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


