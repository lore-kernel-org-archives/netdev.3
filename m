Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05E713F58EA;
	Fri, 10 Jul 2026 09:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783676429; cv=none; b=DH34GxGfPwoDej/E4YPhKKnPEyIrylKl68Ee6DjrRtD+KOkALOigCLHvbZ85EA6dp7Nd6J6LyzhNQDLVqdLRD9AtOR89n0iFJI/xEqCSOz3VDsxGSMsiEFcssAFJgxMeyTN97eTFO1sEy8Na4PVUWOfWqLfE847Mt7YUJIEBx6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783676429; c=relaxed/simple;
	bh=oRB0zKlLdf69FDvkbrNdoVMTaaxeJZcz2UccAKKznq0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=slRoyg3RSoah43FdW0A3N+VJP8c0mrFQNrhAjRaw3wkZTwrzZVNA200zyHOgLirzX4dDEtXck0C9ybQUtFSMTsSJRkSph1rh96+JlaSczlTWCBExdiR1JYyrNU7lEl+OCJFPtS87g/22AvmflCap0uC+ZHMLflwgKRDysMe0vJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JwzaLJzU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JwzaLJzU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD9381F000E9;
	Fri, 10 Jul 2026 09:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783676427;
	bh=nz29ekxFdcJXgQjDUE+cKUTqVZJa2eE0Bzz7YxbbU/c=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=JwzaLJzU0uUtPconTAa9fcQR+AGQlP2NGGuyfKPeiMFOF3QT7v+dFTUzs4p6D8OuW
	 ZgT2NX8u3PjwP2d32AJUpqrZQehOBnAgcVmh+rwu3dKDAlkvSBelxWiOutnao600G1
	 St+Xg1RQsgvcTAalLyI7dSx/hEHHmEJvsQGuZiYP6VFPF9wYjCADn5vUKjqGRZwjtW
	 UY1mbUauxrfGYiCr7NwltldL94Ja/JsCyXcbgN9jbytUr05YG2ttl6ziAw4G87SkAJ
	 /NTouzRhbdD6jqBYHcJ54gARcu+ODbHQq3TBxixQPfRrWQ/mdznWlcWHBw1yeyQnrY
	 45RpDkCUN7tCg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 197E23924A75;
	Fri, 10 Jul 2026 09:40:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: qed: Fix spelling typo in qed_dcbx.c comment
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178367640589.147449.3997713431627199194.git-patchwork-notify@kernel.org>
Date: Fri, 10 Jul 2026 09:40:05 +0000
References: <20260703143130.3685-1-praveenrajendran2009@gmail.com>
In-Reply-To: <20260703143130.3685-1-praveenrajendran2009@gmail.com>
To: Praveen Rajendran <praveenrajendran2009@gmail.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri,  3 Jul 2026 20:01:30 +0530 you wrote:
> Correct a minor spelling error inside a comment block of the QLogic
> Core module where "successfully" was misspelled as "successfuly".
> 
> Signed-off-by: Praveen Rajendran <praveenrajendran2009@gmail.com>
> ---
>  drivers/net/ethernet/qlogic/qed/qed_dcbx.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - net: qed: Fix spelling typo in qed_dcbx.c comment
    https://git.kernel.org/netdev/net-next/c/832255a6df49

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


