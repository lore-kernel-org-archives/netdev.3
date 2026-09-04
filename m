Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C46538398E
	for <netdev@vger.kernel.org>; Fri,  4 Sep 2026 23:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788563469; cv=none; b=kLTNmSSTSAWIfcsXlrbap5vp9JPSxIw4RzmwpCV9NucQ4DT2WqnMDKdMD2jjn3XCkkMcCyTcdFwZ9uZbXGrU8ZY6IU89Bjn+SOHp7z00WbpciynvVggARp5t1G2+/jW0YqsAGEvZ2nyn81OiUT5KuIEyBgLOo2G34JcRxwXYZbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788563469; c=relaxed/simple;
	bh=qNuF1ftXcymDkow6MHGmadbEPDNl+IfXwAxXs28ozDI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=BZZ8lfPUH/r/+/Vfl1iUedESOKu/jQLMUQpAnRagrnwRJ0G1Gb9kdO/70yPl5ntax5iaoGcVKtd6sfYyo4pimQyAj5+FAq+zTQsLsJ6odnbkv9glU3Ar+FW4XCRo4RYDD3d8o4K9WmK777uWMS06bM3k3BiItvFyPK/IgkXoQt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o2O5nRL4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o2O5nRL4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0013F1F00A3D;
	Fri,  4 Sep 2026 23:11:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788563468;
	bh=JbmG8/+V/LECu5WYM8vjDVvJCpEuGdbt12vJ8piCxOA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=o2O5nRL40dMlOP7QsnzyQiTgKlipR5beJVb7jD+U319gshwvw0Btho8INby8ud55h
	 fBg4XgBpbkEASmqI9t+rI6O/fF/HNzIfcw9A0xzEAj3rr8ni1SL4cQM0oNS4FPRqY1
	 oe2XekBfiO2qnzRldnBGaD3kC+sgQwNw57WDTPbNComQphr5rSn7X7SMhYsn8WN4Uv
	 /i03JRvsQluLQAAaATBdNMP/gpvl8htPtQhtliBt3MrfkNZXFlUTeef3DLKBqlV7fy
	 A7/GS8+bRIIFUm2JMZtz3QB332f+X2hVXWjR+lV4mhV0gnSvtEj1Jsae7nfdNNaqwu
	 FX0ZKmXtm9nUw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0A133924A7F;
	Fri,  4 Sep 2026 23:10:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] ionic: use netif_txq_maybe_stop() in ionic_tx()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178856340840.1009860.16553882310182134146.git-patchwork-notify@kernel.org>
Date: Fri, 04 Sep 2026 23:10:08 +0000
References: <20260901055627.1373129-1-nikhil.rao@amd.com>
In-Reply-To: <20260901055627.1373129-1-nikhil.rao@amd.com>
To: Nikhil P. Rao <nikhil.rao@amd.com>
Cc: netdev@vger.kernel.org, brett.creeley@amd.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, eric.joyner@amd.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 1 Sep 2026 05:56:27 +0000 you wrote:
> Commit 061b9bedbef1 ("ionic: Rework Tx start/stop flow") replaced
> ionic_maybe_stop_tx() with netif_txq_maybe_stop() to get the memory
> barriers around the stop/start bits right, but did not cover the stop
> in ionic_tx() added by commit 138506ab249b ("ionic: Check stop no
> restart"). Convert the remaining site.
> 
> netif_txq_maybe_stop() requires the ring indexes to be updated before
> it is invoked, so the post has to come first. But ring_dbell comes
> from __netdev_tx_sent_queue(), which runs after that and reads the
> stop bit, so it is not known in time to pass to ionic_txq_post(). Post
> without the doorbell and ring it separately.
> 
> [...]

Here is the summary with links:
  - [net] ionic: use netif_txq_maybe_stop() in ionic_tx()
    https://git.kernel.org/netdev/net/c/c91b4d6e5cc3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


