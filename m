Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69368330D2F;
	Thu,  5 Feb 2026 21:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770325215; cv=none; b=iMqnz5O3K4WE47Zy0oWLaNSEsl5wOkNF+mmRlcu2ibrWiGIlXe0tFL6EncRZsnuqxHdQewpGAA0q6fyGLNoDL/eFCWgTInmk+opjtaWGGevXv/HAfANeiSqMZHt4P5ZiN2K7Tj0lY19AYtqpAfFS6im05cMFNukcctU9YmU3hoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770325215; c=relaxed/simple;
	bh=SS5tpT8kGuo97PkIfDvy/8SWIc5XioHt0sWNGa1Q4PA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=iKSHV5CjOmn9/JeSVGOFYkNcXfunneJXjl+gR+7hAzAoHHhgUA+w8kr6TOMKQ8iTcBNH1Nd0mCm/gjyjp/Dn/9e25etWV3n16MBdum8cNYAM+X5/5iGvyoMeVab0bD6MSnvpMElzuZPNpR1FuGRkGVGgQWd82TefF9dLtDFgflE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BrJxrSfV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BrJxrSfV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCED1C4CEF7;
	Thu,  5 Feb 2026 21:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770325214;
	bh=SS5tpT8kGuo97PkIfDvy/8SWIc5XioHt0sWNGa1Q4PA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=BrJxrSfVoYZiV2oASP5/2SPw4tVy8qAoOzpjWB5Wvczv7KWlDWgpP4jGIFS05ax1d
	 uHivUJo1WJi1F0QTBVJSMMeoCPpIAxwa23YqaMyo1fBD11jfpvhz5Yzn+pfbDW7n7Y
	 ALRDcrZshNqqgqYeJt9pqEE/jKdWXIpWweu3N3D4fadMPTreV+lbfR+YHyONeAquzW
	 UhusWDpnQcI+7L/TVTp40QlLKRAK+kImslj9F3M3XBLHaqo1O920yoGxjdm08nJGeT
	 DdZxs7H+gBNOVodDAJdJGvIbxuBne+3eh8JdsYIhK8GDEFURa1nNKCJRLYCXZaDKUn
	 9BtJpi79RkNQA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id C22633808200;
	Thu,  5 Feb 2026 21:00:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH RESEND] tipc: fix RCU dereference race in
 tipc_aead_users_dec()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177032521232.564062.13419109686231427073.git-patchwork-notify@kernel.org>
Date: Thu, 05 Feb 2026 21:00:12 +0000
References: <20260203145621.17399-1-git@danielhodges.dev>
In-Reply-To: <20260203145621.17399-1-git@danielhodges.dev>
To: Daniel Hodges <git@danielhodges.dev>
Cc: jmaloy@redhat.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, ying.xue@windriver.com,
 tuong.t.lien@dektech.com.au, netdev@vger.kernel.org,
 tipc-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
 hodgesd@meta.com, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  3 Feb 2026 09:56:21 -0500 you wrote:
> From: Daniel Hodges <hodgesd@meta.com>
> 
> tipc_aead_users_dec() calls rcu_dereference(aead) twice: once to store
> in 'tmp' for the NULL check, and again inside the atomic_add_unless()
> call.
> 
> Use the already-dereferenced 'tmp' pointer consistently, matching the
> correct pattern used in tipc_aead_users_inc() and tipc_aead_users_set().
> 
> [...]

Here is the summary with links:
  - [RESEND] tipc: fix RCU dereference race in tipc_aead_users_dec()
    https://git.kernel.org/netdev/net/c/6a65c0cb0ff2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


