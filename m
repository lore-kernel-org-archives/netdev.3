Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AA9A41F5CC;
	Thu,  8 Oct 2026 18:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791482409; cv=none; b=G0jSPiVpWQfPLJJzol0yIxoefc05IXDg0PyNXE9NsQ7isndN0N0XnhMCKhlOCOtWskWuN1Q4UpQVgcSycAcnUIQ8ujkLKBSn2PomAWeteAWJnev+3BZvrn8larZariV5r6yZJXiHkV8DtUArq9YxakaMQrTGpMu/3h3WlRN2vLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791482409; c=relaxed/simple;
	bh=Mrc2biQk8EgOFAl81bbVj8lF/4TWbOuZnQZgXOggJGs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=iZ/9sgoSU2WDwCRhD7Kne8ZYe6VrCkVMCnmwqE4cMJcgtM5s+j8/nnx6N9Qcpbxy3KAOHiTsj0GQ/1nujCEGy7HaV/+LdnkcCq9SXGWvZ6IxIPiK3WvUAvK6RYwbuZt+09DPHrAAT73qP7BWynqhApQTow/Sk5imFOdXKdizZ0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jQEp47nV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jQEp47nV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 448DE1F00893;
	Thu,  8 Oct 2026 18:00:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791482408;
	bh=6FHQR9Zwf35cHXjGhBIMoGCp+MRKmr8i0WuLxV25XgE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=jQEp47nVYgsRS9GxV/SJEdNj91RLBkpMq72EVXSWlqh3oFQX9tjvEd/oIcnxjT9e1
	 OfOTyfq/mb5pwJT99oHjQvg2VxN62KQxzi3JZ71dILUjMXoD0yZ9uadGeX3y2yQpeX
	 /F9orb3Oh9EEgRzaOjbk6AC6suy16sdgzHwMwozm05hSvKF2b3/jB1Enpju9AMd1D+
	 /QypKOk1RGcqLIC0l435n0PCTpUmY9kNOj8VzVanAThIeigiePr2PjKMD9nLqQxAmT
	 5XfWzSTKFGiti3kxl5ngaNejdXCmKATLGW/ysZY48UcET0+aedKoaG6b3TdQTDSmY9
	 TncHHn7+tTrlQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3A321380CEC8;
	Thu,  8 Oct 2026 18:00:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: sparx5: free the matchall entry on destroy
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179148240704.372666.16255779189495351496.git-patchwork-notify@kernel.org>
Date: Thu, 08 Oct 2026 18:00:07 +0000
References: 
 <20261007-sparx5-matchall-kfree-net-v1-1-c8918685b337@microchip.com>
In-Reply-To: 
 <20261007-sparx5-matchall-kfree-net-v1-1-c8918685b337@microchip.com>
To: Daniel Machon <daniel.machon@microchip.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, Steen.Hegelund@microchip.com,
 UNGLinuxDriver@microchip.com, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 kees@kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 7 Oct 2026 17:03:15 +0200 you wrote:
> sparx5_tc_matchall_replace() allocates a struct sparx5_mall_entry for
> every offloaded matchall filter and adds it to sparx5->mall_entries.
> sparx5_tc_matchall_destroy() removes the entry from the list, but never
> frees it, so the entry of every deleted mirror and goto matchall filter
> is leaked.
> 
> Free the entry after unlinking it.
> 
> [...]

Here is the summary with links:
  - [net] net: sparx5: free the matchall entry on destroy
    https://git.kernel.org/netdev/net/c/2b82e16d6084

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


