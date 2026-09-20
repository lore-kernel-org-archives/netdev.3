Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75A5D2147F9;
	Sun, 20 Sep 2026 00:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789863692; cv=none; b=RQjNyFDYKJRXjo15uaM4Kr9gSM9SMoWL9GjU7oQ4VSwathYfo/DjEojCyQ6+dFPZ0G7q2owhYi6aTPoXimqd0CVM2fiWlr1lIjJYOSeJ1eofP+HIKWgV3yWLzfsJcbiUSlNoUQCpMDFqNWqhzf9vo8AwSuvq2glkom93PdWbhoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789863692; c=relaxed/simple;
	bh=V6CX5es9Zd0geLEwfFY9PRFZ+Q6wSzYGDmxp8HG5chc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=lYdEYzTAtS3S4M05wo/ZgabKW/ScSNOYW6EpCPJugqe0UrlanjfvSQ/hDey1//rs8//zfUpSK7LCR3L4Kr2q/c7wcySH/wBEF058OzIkvb96ORo8DnUGH8qHyJypORaBG7zZ3qQfC5eHpTF+efTTEMr2Mx/mtej2f3dGvu5BmG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yow/aX4X; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yow/aX4X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C6C31F00893;
	Sun, 20 Sep 2026 00:21:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789863691;
	bh=JAkLsduyfbgZchH/UPSdqV85PTuiHc74v0gBkPOM+Ik=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Yow/aX4X/EiPrUDRr4BzJouUUt/joN61aiRzYCwbFMUGuY+ro0Mx/D1wCmoINHWta
	 6P/ObO3Rb32xlYfoRomHbnRGekQSBx20yO7vQA1IryLfryajx4GB634TOz9vZ5ZI2Z
	 BhDI3thxTnmsEAdxadRXcEsnniV3EMxDlYtjyzipgaBNnk7RWZEsKXAY7kxIHtGL+H
	 5A+ORChKLV5DmyiibiNrLgVDHZNgOImq1EoOGPvNJYR5jsf2kwFOfD6UfBHdQnc/fP
	 FN9wcjTFDse+s095wqF4AK8GIgR4DtPobTRzDCKN8FP3Xj+wXJVmyeDvqblVL8szJ+
	 R3KFoao41GtNw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D09DE3924A47;
	Sun, 20 Sep 2026 00:20:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v1] r8169: set eee_enable_default base on LPI cap
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178986362339.1500872.9609601668967871273.git-patchwork-notify@kernel.org>
Date: Sun, 20 Sep 2026 00:20:23 +0000
References: <20260916081306.184-1-javen_xu@realsil.com.cn>
In-Reply-To: <20260916081306.184-1-javen_xu@realsil.com.cn>
To: javen <javen_xu@realsil.com.cn>
Cc: hkallweit1@gmail.com, nic_swsd@realtek.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 maxime.chevallier@bootlin.com, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, daniel@makrotopia.org, linux@armlinux.org.uk,
 enelsonmoore@gmail.com, daniel@thingy.jp

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 16 Sep 2026 16:13:06 +0800 you wrote:
> From: Javen Xu <javen_xu@realsil.com.cn>
> 
> When initializing phylink configuration, if LPI capabilities is
> non-zero, it indicates the hardware supports EEE, thus we enable it by
> default.
> 
> Signed-off-by: Javen Xu <javen_xu@realsil.com.cn>
> 
> [...]

Here is the summary with links:
  - [net-next,v1] r8169: set eee_enable_default base on LPI cap
    https://git.kernel.org/netdev/net-next/c/5f22f5fb9051

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


