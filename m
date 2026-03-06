Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0230A33B966;
	Fri,  6 Mar 2026 03:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772767492; cv=none; b=GqWawZ3y188GUTcJ70ycVF+OtHHIoG2UzKFZ1gxQptLiIi6zNcz+91PxzKy62RIdurj2Scv/lmZR5gUztdLmyB17HS8U6O69xba5s02Xu/D3e1zQTx/ZKLfxfn/MzXOtQJr7O3wiPjBCuIANSYjpur19Sw/IFgBDRPTYf6ntCGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772767492; c=relaxed/simple;
	bh=mvW+NtXdHBx+tI7OMGBFJUTaS/lXyUfhNEhDbDDcgI0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Ywk0QvP0//1gmuSK1TCU03m7yUUAJmGo32J4wHTOssSKpb6TMm2WfEnTbnNLZcWP034tlK3tBQXFYg8IT/+HGM2Z5ANGng3vb/55TjEq/BxbuUWuPLUOJdLvk3xYgzfVEXIJyetudmFyS1D3+ehgRNmUHY7mM3DkQ9FJQAa+I1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kWinz89e; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kWinz89e"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BFD7C116C6;
	Fri,  6 Mar 2026 03:24:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772767491;
	bh=mvW+NtXdHBx+tI7OMGBFJUTaS/lXyUfhNEhDbDDcgI0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=kWinz89eok6JmcQuJTlBOBSs91cclM1gkyZAfvg4vKBTN7cpDcJkOJoDW7Vlihd52
	 /PMiHuP6YKMhxm1ApfkzbtVCugv5zxxsRh5XTsmhueiqdrUsczh5Anls1ofGqs+62a
	 tp/wJzg/aFwA38XLuMM7hhjhD93r/qZ6+P6K4Lczn5T8pr5rsh24Kg1rtx/RjhHqsm
	 1yK/50wdAja0cAVtOOhrIGBgfTQH6vVjnjhAPfAIfaAM2ZGnF6YLsEA2IxmDQM38up
	 obYjAQRRCpyiFiVZCe5Nqb+jpv7SoRrjUTjSl2d0rvnB64dv8kzC8YP78XgPNCTj81
	 wKqsEtT13Nj0A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7D0513808200;
	Fri,  6 Mar 2026 03:24:52 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: dsa: realtek: rtl8365mb: remove
 ifOutDiscards from rx_packets
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177276749130.3348267.7684486746553731251.git-patchwork-notify@kernel.org>
Date: Fri, 06 Mar 2026 03:24:51 +0000
References: <20260303-realtek_namiltd_fix2-v1-1-bfa433d3401e@gmail.com>
In-Reply-To: <20260303-realtek_namiltd_fix2-v1-1-bfa433d3401e@gmail.com>
To: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Cc: linusw@kernel.org, alsi@bang-olufsen.dk, andrew@lunn.ch,
 olteanv@gmail.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, f.fainelli@gmail.com, mir@bang-olufsen.dk,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, namiltd@yahoo.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 03 Mar 2026 17:25:12 -0300 you wrote:
> From: Mieczyslaw Nalewaj <namiltd@yahoo.com>
> 
> rx_packets should report the number of frames successfully received:
> unicast + multicast + broadcast. Subtracting ifOutDiscards (a TX
> counter) is incorrect and can undercount RX packets. RX drops are
> already reported via rx_dropped (e.g. etherStatsDropEvents), so
> there is no need to adjust rx_packets.
> 
> [...]

Here is the summary with links:
  - [net-next] net: dsa: realtek: rtl8365mb: remove ifOutDiscards from rx_packets
    https://git.kernel.org/netdev/net/c/f76a93241d71

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


