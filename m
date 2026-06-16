Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4D0044DB64
	for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 16:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781625622; cv=none; b=pdFWQpUeCEvBjy/v8VF79jeJaVH1GGYnhyJ/nMCoWhS+f8NCJZQpTknWXJZiHN0R3lj0fvRGj7DJONH74Lpc08AVqkHWEW9o6SIeT34ELc2PIQGRPp9MLKnOyPDy2lxjToVxqFSq5LJUYQ0axaaW6mGOpUy3P/UBJMAet/wupxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781625622; c=relaxed/simple;
	bh=PHMCrEFYzHjppXmJid0lTN5dvvmXcBIHvVcdlZMp3xM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=F4v2eo0KjSRTiJmnhcXR588c8Asz1fN8wQVX24bP3GWDv3eUjfANO26aHs6FjROaMsFQ8vI/7bxoWgZ8qG9jv4kPml8hMirJSBwuJ2M3VoHwhCB/Xu5Ljm1hex/CUyH99NbSBmDWQS0QjflFaV2elsuQHHxMBLzJuVc2Fhf9BQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=asB4JZ9r; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="asB4JZ9r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE3E91F000E9;
	Tue, 16 Jun 2026 16:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781625621;
	bh=cTfFoVnti5c+jy0tVcTKWOoKjhkNiwdBIvYu+j8avlc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=asB4JZ9rTyG7IV8GbqfEcwkUxTDQmNwPhQeH1jM0/SQZqwEx5lhuGSnk9oE7a/JiZ
	 St/G74irjy0zYYsGPBY37exeasbNdhcTukj9pzOLVjc65lW9i6DzqoJ/koB9Tkpg8d
	 eWD5SXNwn3lnXCAZ80FXNoJ8BxisGO2mXpQtoxMbhPZJkFHLw6bSBi+cq5h8uJIY2k
	 BhFUX/Nz8/jmrb3Oo8smt0irOE9RELyZVLVnsaIQlE9EvYo1W5inXMxkhgfD3tfSo6
	 3bhc4jpjoJ4YL29HPMA+zf6Lb9Be0TsCQ0cW9Q7pHOJkjysD4u71eVBOXEnTp3zZsl
	 7VSo+eDL9dgLQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 939033930ABA;
	Tue, 16 Jun 2026 16:00:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/9] atm: remove more dead code
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178162561614.1139138.15979699037640823309.git-patchwork-notify@kernel.org>
Date: Tue, 16 Jun 2026 16:00:16 +0000
References: <20260615194416.752559-1-kuba@kernel.org>
In-Reply-To: <20260615194416.752559-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, 3chas3@gmail.com,
 mitch@sfgoth.com, linux-atm-general@lists.sourceforge.net,
 dwmw2@infradead.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 15 Jun 2026 12:44:07 -0700 you wrote:
> Commit 6deb53595092 ("net: remove unused ATM protocols and legacy
> ATM device drivers") removed a good chunk of old ATM drivers.
> Our goal going forward is to limit the ATM support to PPPoATM
> used in ADSL deployments.
> 
> A recent burst of AI generated fixes for net/atm/signaling.c and
> net/atm/svc.c made me look closer at the remaining code. PPPoATM runs
> over permanent virtual circuits (PF_ATMPVC) with a statically
> configured VPI/VCI. We can drop switched virtual circuits (SVCs)
> and user-space signaling (atmsigd) support. While digging around
> I noticed a few more obviously dead pieces of code.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/9] atm: remove AAL3/4 transport support
    https://git.kernel.org/netdev/net-next/c/c1468145ce75
  - [net-next,v2,2/9] atm: remove the unused send_oam / push_oam callbacks
    https://git.kernel.org/netdev/net-next/c/b20aa9eded10
  - [net-next,v2,3/9] atm: remove dead SONET PHY ioctls
    https://git.kernel.org/netdev/net-next/c/277fb497d101
  - [net-next,v2,4/9] atm: remove the local ATM (NSAP) address registry
    https://git.kernel.org/netdev/net-next/c/a5a12d76d2cb
  - [net-next,v2,5/9] atm: remove SVC socket support and the signaling daemon interface
    https://git.kernel.org/netdev/net-next/c/aa582dc25ace
  - [net-next,v2,6/9] atm: remove the unused change_qos device operation
    https://git.kernel.org/netdev/net-next/c/6719d57ee047
  - [net-next,v2,7/9] atm: remove the unused pre_send and send_bh device operations
    https://git.kernel.org/netdev/net-next/c/ae6e653514d1
  - [net-next,v2,8/9] atm: remove unused ATM PHY operations
    https://git.kernel.org/netdev/net-next/c/e44e224e2f44
  - [net-next,v2,9/9] atm: remove orphaned uAPI for deleted drivers, protocols and SVCs
    https://git.kernel.org/netdev/net-next/c/8f9616500c59

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


