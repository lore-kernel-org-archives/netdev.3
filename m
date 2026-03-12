Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20AD73890E0;
	Thu, 12 Mar 2026 03:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773287417; cv=none; b=iXSjr//VBk3w4EHSY0OElfdM5y9lONAtn281tsB6o0qFYuhbL70RWyVZ/2t5FDjvlQx73gQ3N87EiaVj7cW4hP7V2mg/p5Whw3pIKOSF3yTB2cS1RKFtCNu8lIldkA40eY6sNOu2MqYM2ezPKFKdOgV5IJu+gN4uCcSdShz+QxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773287417; c=relaxed/simple;
	bh=XO1dEapmMejuyHSscB3tULaG6ANQjcfknjMUmCwCvvU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=f6Uy86EgxGukhXIdvEYBp6gfkNdC0CktH+WLtEoLaDQQ+skfJVLgvUaKZR/L1T58U2jtoyR5TJ3VtNVlBChy9c9I3458ysmaarOmPz01ex5viKJFFNW+pUmI4bKiJH/SqYC6Yzi3IdJRVj+2o111PARfM1u+Te784CBRwK3lorI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DMhO27m1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DMhO27m1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6906C4CEF7;
	Thu, 12 Mar 2026 03:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773287416;
	bh=XO1dEapmMejuyHSscB3tULaG6ANQjcfknjMUmCwCvvU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=DMhO27m1SgNh+TNfOq7LOEbFcJLoZTnWs3WeFeKC9XAca0DRFD7ubqtQXYVMz/6FW
	 7n092QsXMiYIFZKiDsHdXFurC8xfkVODOKtfEg4I8nJR1pHt8tPu96ymfGvFRy1LpH
	 zHXVDdC7shJCkyKe0GClQYa3rb5qsRMk6xGWp6naI3/sJJEQLJQzbZvFBRmC48z+HX
	 7+20Nu96BPatkujU4MhdxOrkAHPfWzSoofnYn4xp7OQ03AiYo+HqPm5TFlMpo9t9Em
	 Rggnxwpy5szVMJ6JriHlB4i4LvlolZNkr2ZRbNwkuuWAi4ecGgdxik7OznjrKhkNG7
	 SU9BeGjbIY24A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9F283808200;
	Thu, 12 Mar 2026 03:50:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: ethernet: ti: am65-cpsw-nuss: Fix rx_filter
 value
 for PTP support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177328741229.3930157.14195930729168379099.git-patchwork-notify@kernel.org>
Date: Thu, 12 Mar 2026 03:50:12 +0000
References: <20260310160940.109822-1-c-vankar@ti.com>
In-Reply-To: <20260310160940.109822-1-c-vankar@ti.com>
To: Chintan Vankar <c-vankar@ti.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, s-vadapalli@ti.com,
 mwalle@kernel.org, nm@ti.com, vadim.fedorenko@linux.dev, vigneshr@ti.com,
 matthias.schiffer@ew.tq-group.com, danishanwar@ti.com, v-singh1@ti.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 10 Mar 2026 21:39:40 +0530 you wrote:
> The "rx_filter" member of "hwtstamp_config" structure is an enum field and
> does not support bitwise OR combination of multiple filter values. It
> causes error while linuxptp application tries to match rx filter version.
> Fix this by storing the requested filter type in a new port field.
> 
> Fixes: 97248adb5a3b ("net: ti: am65-cpsw: Update hw timestamping filter for PTPv1 RX packets")
> Signed-off-by: Chintan Vankar <c-vankar@ti.com>
> 
> [...]

Here is the summary with links:
  - [net,v2] net: ethernet: ti: am65-cpsw-nuss: Fix rx_filter value for PTP support
    https://git.kernel.org/netdev/net/c/840c9d13cb1c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


