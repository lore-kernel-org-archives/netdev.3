Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 840DE3CA4AF;
	Fri,  4 Sep 2026 23:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788563472; cv=none; b=bF0+EYSKoCOMVq8Y0iPLXGHJPGPKv8oY7iaGbWJz5hyr9drwGn3ZW6ljID8bf5m4HlOjD6uKKgOGQSdPzZuq9LXS2z4AcWDmbm5P1S83Ft8TlC9FAxlH5mGsvQxvult2zoWYF1qx6CdMjjEJ/ecu+4dim3Pdsuh2cJOAartABBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788563472; c=relaxed/simple;
	bh=J042o9i5ejh/e89sRVIuKzhrtGV3vAO29OPuRr/JQis=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=apQvIU9MeBvcTV4O+z2pE/4qx9amhZEY6lbMQ/L/WYSL9F+r4VHbBKE7PIajPQzmrZhFitDqxdRu1IZCmj1yfCiL49uM7jZeK5+fmGYGNbdGl9H8n13FvmW+dnIgKdHWsPxSvxrb+FyjghJy/joMqJZ5NW/ZfoM7Zphy2iIVfQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=elM0orPE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="elM0orPE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 002431F00A3E;
	Fri,  4 Sep 2026 23:11:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788563471;
	bh=bwkzB6tOe+xnr3M4zsU0jcw3ZOj7puHpXh+7yWXqYLU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=elM0orPE3wyRY6d3OxSF24dHlAfvRLsXaCFZisb6Chsf70Uo1R6shXRusnd0scyd2
	 wRf2jT5x0ehkpxiu1ini5+XD3O1JWL8ocpIk+B83Km1Sk20KTcAJ2s0YmA0DaEi5l2
	 jJN5N5U3LR0eQ8p1nyfwayN+1VXV4yEHsErkpB+cL1Pnq2OTTjFd7MR0AIQk7Hqb4D
	 istWMDv8sa0emEBRfFG7sBsx2xCDbFNpvakuBsa+Dm4NojklSrIHlvd2oqELFQA5Fw
	 PXEyjrwbW5sKsnse+huwCdrKOPoz4fawekuNsU+FvvJCOdSA4ZCFSASCnAVLCF5YGD
	 HhwMkMmeoYbSQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0A723924A7F;
	Fri,  4 Sep 2026 23:10:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: usb: cx82310_eth: drop URB after 0xffff reboot
 sentinel
 to prevent partial_data heap overflow
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178856341139.1009860.14059696429879515114.git-patchwork-notify@kernel.org>
Date: Fri, 04 Sep 2026 23:10:11 +0000
References: 
 <BESP194MB283265DDDC63B6B78D8D34FBB8B72@BESP194MB2832.EURP194.PROD.OUTLOOK.COM>
In-Reply-To: 
 <BESP194MB283265DDDC63B6B78D8D34FBB8B72@BESP194MB2832.EURP194.PROD.OUTLOOK.COM>
To: Jason Winter <jjx@live.nl>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, gregkh@linuxfoundation.org,
 kees@kernel.org, linux@zary.sk, linux-usb@vger.kernel.org,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  2 Sep 2026 10:40:41 +0200 you wrote:
> The 0xffff length sentinel detects a router reboot and schedules
> re-enabling of ethernet mode, but then falls through to the rest
> of the loop body.  The next check is
> 
> 	} else if (len > CX82310_MTU) {
> 
> which is the else of the just-matched if -- it never fires for
> len == 0xffff.  The MTU bound that normally caps the
> incomplete-packet save path is silently bypassed.
> 
> [...]

Here is the summary with links:
  - net: usb: cx82310_eth: drop URB after 0xffff reboot sentinel to prevent partial_data heap overflow
    https://git.kernel.org/netdev/net/c/5d50e90add8b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


