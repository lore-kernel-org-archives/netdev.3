Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C2932153D8
	for <netdev@vger.kernel.org>; Tue,  6 Oct 2026 00:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791245430; cv=none; b=D0ZnXJLL3FX+YkbfFtTHxMvZ1Olc+ES8/j0JNCBW1VlHD3/82B9nixKYYlfDeulwpUnX48HnMKl5RSxs2E9nt2KJzs05JLg3rciz4Jus0Z7sACRI0/fvzwPcyNqpIj+prOpW1rV04RljAHU0iS/Q56WUyQYRzgGWcYIeqEvdc9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791245430; c=relaxed/simple;
	bh=U4QiIHQoc29psqMocy2CISa4wU/on+D8qTdtCNWr9qA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=uhLuoIaB+dIGgx/PiRiGZ6VlR9Q2XJ5bHIvYLP1KXKul3iK06DPZ8teklcTETvd0deGk2m0sDLbPs3vWtC0FHOgGFi9AFCliLPL1ov/InoE1uiO3fn8hp1c/wbyAi99k0sn7cLopij5Na6SfKR8/rEdpniDTxL+JyyrbP/0nDmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PSaEKdtX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PSaEKdtX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FDF91F00898;
	Tue,  6 Oct 2026 00:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791245429;
	bh=lGl1BTsZOpJFzkHVrQF/+hzjvu8HhivmfIJKCeo/wvA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=PSaEKdtXIPlgru9XNCaBQGsb1Iyjdq0xWSWi6zlOSgwisMa3YtPg25zpFcowe1MnO
	 Y4iSjmEclqQjv3cevjGP/gsKrcjFiuwPSO6x8jswT0AiRAKRi1EXcX3JVVx8GAjboC
	 A+6Z7VkcHZCH74d1f99AZcyWsWU88KXZZV0YMwBgipjxIF3+iBnvBuoGxSgRTrZRBn
	 yHYGb6zMzBtvww6/cR/VWO8cFMUtciv6By2QKgvn2qi7VGgUuHgI1dDnMbBPv1ofZ7
	 /G5jyyUZubaoXqfCiBkFkDTldh8PcdTX6cbdGvGJE7CevAaeifrHMhezYG7Xj2q7ta
	 7UmPzLzbeSl7Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 775B7392667F;
	Tue,  6 Oct 2026 00:10:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] mlxsw: spectrum_router: destroy FIB hash table on
 bind
 failure
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179124542816.1947351.6129403428490899794.git-patchwork-notify@kernel.org>
Date: Tue, 06 Oct 2026 00:10:28 +0000
References: <20261003.final104.6f67a6ed1c4476b7@gmail.com>
In-Reply-To: <20261003.final104.6f67a6ed1c4476b7@gmail.com>
To: Sang-Hoon Choi <csh0052@gmail.com>
Cc: idosch@nvidia.com, petrm@nvidia.com, netdev@vger.kernel.org,
 jiri@resnulli.us, lcy8047@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 02 Oct 2026 19:47:40 +0000 you wrote:
> mlxsw_sp_fib_create() initializes fib->ht before binding the LPM tree.
> If the bind fails, the error path releases the tree and frees fib without
> destroying the initialized hash table, leaking its bucket allocation.
> 
> Destroy fib->ht on the post-initialization failure path.
> 
> Fixes: 2b52ce02e1d1 ("mlxsw: spectrum_router: Remove unnecessary prefix lengths from LPM tree")
> Reported-by: Changyul Lee <lcy8047@gmail.com>
> Assisted-by: LLM
> Signed-off-by: Sang-Hoon Choi <csh0052@gmail.com>
> 
> [...]

Here is the summary with links:
  - [net] mlxsw: spectrum_router: destroy FIB hash table on bind failure
    https://git.kernel.org/netdev/net-next/c/a089139eb47b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


