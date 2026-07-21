Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA3D237F8B1;
	Tue, 21 Jul 2026 11:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784632237; cv=none; b=rx6IfnrGixdb1NirGLTmzhJYmipF0nIciX+BQJogaL4FlULzML1uiK/ocLBDe1QWNMp3heLsrVvJj8gMfGfNp5Ew8NstyjUiI6ep4t7U5ihyNQIpBQSA+DmmPhoTOSodSVqaFe23K+qy7iSlUGizqnrpq8Lhn5K9qNidNzdYP5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784632237; c=relaxed/simple;
	bh=leBq+HSfNq2JFJ8kmh3h0AFxIcWXHLIQblQ1F9MElZ4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=UowCrWYkCVt7mEgEa7s6S36FFch3Xrv2Lnz00hMZf3pZ2ZBHDOE7Om5dVzsVHNhyTPaRmCfi00xSTM7JW/0/zbcNA66kq8JHK/CG+FAgbGhSHk14r8bVCp/lWC2lknpXOb5dhGcCNND0fPVk3UF+xmlQxDMSto31G/H/PIAY1i4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gPb96Ypm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gPb96Ypm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AF0D1F00A3A;
	Tue, 21 Jul 2026 11:10:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784632236;
	bh=m0RyBuS3wt/BzKLPGPeNmA7qjYvbUJ28+RQA7P6Y4yA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=gPb96Ypm9Ol7wS7OcnY2qWnAYCvKvGSugRaagGRl07XPFkEobOcq/fnPMUrXcUrnE
	 t0BVOjya/H0dM8EDFazTIrqHNiQfoMXaEK9RTMYkVTF2qmo0Vvl8p0GON/djz6EUPg
	 BbYKksl9v5AA/52N5u9w2GNDvaWny6BHATjYbipr9aCMm8zz1AGdKiYSMMCy6NZop1
	 ErSroU1aaskQog5nTbpeXMfY7nBGFHqjw8tMHDzy0N5dU+60bZwQQu2qUcpmfuoodn
	 Rxa0hYVXgzbheUiit+BDYRwaa0FCNbjQIjB7nOG45fCKH/SNCyHSRsJGAOpbdlhBm9
	 8c1Fid+SLTNZg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93B203924A7E;
	Tue, 21 Jul 2026 11:10:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] nfp: Check resource mutex allocation
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178463220641.233717.10539663587729927939.git-patchwork-notify@kernel.org>
Date: Tue, 21 Jul 2026 11:10:06 +0000
References: <20260708143408.3168425-1-ruoyuw560@gmail.com>
In-Reply-To: <20260708143408.3168425-1-ruoyuw560@gmail.com>
To: Ruoyu Wang <ruoyuw560@gmail.com>
Cc: kuba@kernel.org, horms@kernel.org, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 oss-drivers@corigine.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed,  8 Jul 2026 22:34:08 +0800 you wrote:
> nfp_cpp_resource_find() allocates a CPP mutex handle for the matching
> resource-table entry and then reports success.  nfp_resource_try_acquire()
> immediately passes that handle to nfp_cpp_mutex_trylock().
> 
> However, nfp_cpp_mutex_alloc() returns NULL on failure.  If that happens
> for a matching table entry, the resource lookup still returns success and
> the following trylock dereferences a NULL mutex pointer while opening the
> resource.
> 
> [...]

Here is the summary with links:
  - [net] nfp: Check resource mutex allocation
    https://git.kernel.org/netdev/net/c/a61b4db34a75

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


