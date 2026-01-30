Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85FDE1AAE28
	for <netdev@vger.kernel.org>; Fri, 30 Jan 2026 02:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769741438; cv=none; b=XJJCGAPPPGYxZmR5ggIT7+5w6+HcyKlPX7SRudPrCIBVMpxLGdcB57jzAqhj7XmPK4Y6fny+wGV49e5Yx2anI4zLsNFHLnxIQxORK+oIz8IeD9/vHcUTytHUX216fTjbbWUC7qQD5W+xqAY40mn6oDOtVYDsoskc06dSiTUryRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769741438; c=relaxed/simple;
	bh=RWwo0x+RLxPgOOxmSbl3SmcNWjtiPGHwiyyMQdLP144=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=D3W+R6aiVOyl2aHweFBtc3aQKlTrZ0EOzD7TDFM6Bz4Ttc8Ou2hBYbt5peHsv/ejXiY/282rgFwrTD7UwejMb5OcrE06n88ZrMk0+hBO16zzJfz+6R+Bkg1cOBDXJqsC2wcXMrY29TIXioj3E0OmA6okEV3rjo4G97yFx8LOFd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ay9D2S1P; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ay9D2S1P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6620AC19421;
	Fri, 30 Jan 2026 02:50:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769741438;
	bh=RWwo0x+RLxPgOOxmSbl3SmcNWjtiPGHwiyyMQdLP144=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ay9D2S1P0enVFX4PkdZVhnQ+CE7kpSmqiKUbyxo3ELvYQXbjYuAtQmhzOW6uLQ0Im
	 UFfhXHo7u6IKEQKh8ObP+Ye4xBGvtcvS8kykHvV1hwLUL+nU055FUSfO23DOnE4bjF
	 Q6Xj+7ZXDYSKe61FnP2obV43MMaaiJSJqC+PxPpMF+4Rl+YdH4lXL1tTZyA+1TaFq+
	 UkWFN3rDtgWqN/4lGW5HmpvBiImaAy3QhsAb7S0V5xsWcIx8XtN6JsGol9ROho7gNx
	 YXWkiQr4XuwipZ/4xFxS3HfnVz8P8ehDQyB1IfMHbBBx4Se6CNu4wTwZE4wNzMWjmo
	 SoTZZEeJ06i7A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 4EE4E380CEE0;
	Fri, 30 Jan 2026 02:50:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] octeontx2-pf: Fix header guard comment in
 otx2_devlink.h
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176974143087.3149010.17900843367800587977.git-patchwork-notify@kernel.org>
Date: Fri, 30 Jan 2026 02:50:30 +0000
References: <20260127174333.1247747-1-alok.a.tiwari@oracle.com>
In-Reply-To: <20260127174333.1247747-1-alok.a.tiwari@oracle.com>
To: ALOK TIWARI <alok.a.tiwari@oracle.com>
Cc: sbhatta@marvell.com, hkelam@marvell.com, gakula@marvell.com,
 sgoutham@marvell.com, bbhushan2@marvell.com, pabeni@redhat.com,
 kuba@kernel.org, edumazet@google.com, davem@davemloft.net,
 andrew+netdev@lunn.ch, netdev@vger.kernel.org, alok.a.tiwarilinux@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 27 Jan 2026 09:42:52 -0800 you wrote:
> The closing #endif comment in otx2_devlink.h refers to RVU_DEVLINK_H,
> but the actual header guard is OTX2_DEVLINK_H.
> 
> Fix the comment to match the correct header guard name.
> 
> Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
> 
> [...]

Here is the summary with links:
  - [net-next] octeontx2-pf: Fix header guard comment in otx2_devlink.h
    https://git.kernel.org/netdev/net-next/c/241b91d9680d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


