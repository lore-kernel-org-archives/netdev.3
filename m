Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA73422CBC6;
	Wed,  4 Feb 2026 03:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770177023; cv=none; b=VEeoHc7LjkRfCJVjb6neLFU56DZb7CF3wrlyW7xSLZF+FvLLSEWNT07DOUTjp61f2GMA6065pVQz3FUZN0F05EL1jcNODDlc/Npuz+/tfCRJ0UAEFZVoWYTAh+HmAWwsOrM5Kq2O+gCpdVQhnJl05etcTmkKScwwqjmeVUfFEIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770177023; c=relaxed/simple;
	bh=eBd5S3SPjvZYEhdcJYxmPkZw0dJfSQSSlBdfX+AgFbc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=EK2WzDXCHNMTJoUh6OXrJnvDSGd3CZdMx5PTbBwYCdwtA4Lc1e4wJh6HCE3My6rYCUCD1cUNcPHB5kijCO9E5ajJiqU6F/LTbNBDcZ81Qs6kZqxKmzZtugeo2yYcRqpB559a7HBOEX7jKNhdlNfDrx2Uhq071n5ZDcVvBAkUyVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r+KrZMos; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r+KrZMos"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67FFFC116C6;
	Wed,  4 Feb 2026 03:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770177023;
	bh=eBd5S3SPjvZYEhdcJYxmPkZw0dJfSQSSlBdfX+AgFbc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=r+KrZMosVIvvwCyrDCUaJaD/jePwwpfXBdeJ5G5dCvwaFWfjIUvO/lf83GqvyCSZu
	 q808tAnf15Epi7CXi1el8ypKAPA8J9n8vtcfeJept1rJej4WG2bMbMd4wUUUtUXnca
	 iSqBdnmRXFMsyPbX71yTktKCKsNtDr4RNBn2zIRyknuvOqPOghCzjodNjO71k2rIqV
	 rWy5IEmscutBVugwI98ewE4rrmp5dkF21Ehev6WYHxcEE5pJl9R+DFARbriU/Qujsa
	 FnYZcAnni04MKSmf9iAsMy2M69w0+XDe3CPCTC5cDCXbtHI0OOrljeQ1JMdBwoLpWZ
	 PAqtPXJrWcc9A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id CDF293808200;
	Wed,  4 Feb 2026 03:50:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v4] net: usb: introduce usbnet_mii_ioctl helper
 function
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177017701937.2171580.10699466934388678419.git-patchwork-notify@kernel.org>
Date: Wed, 04 Feb 2026 03:50:19 +0000
References: <20260203013517.26170-1-enelsonmoore@gmail.com>
In-Reply-To: <20260203013517.26170-1-enelsonmoore@gmail.com>
To: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Cc: linux-usb@vger.kernel.org, netdev@vger.kernel.org,
 vadim.fedorenko@linux.dev, andrew@lunn.ch, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 peter@korsgaard.com, steve.glendinning@shawell.net, oneukum@suse.com,
 gregkh@linuxfoundation.org, o.rempel@pengutronix.de, max.schulze@online.de,
 khalasa@piap.pl, andriy.shevchenko@linux.intel.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  2 Feb 2026 17:34:55 -0800 you wrote:
> Many USB network drivers use identical code to pass ioctl
> requests on to the MII layer. Reduce code duplication by
> refactoring this code into a helper function.
> 
> Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev> (v1)
> Reviewed-by: Andrew Lunn <andrew@lunn.ch> (v3)
> Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>
> 
> [...]

Here is the summary with links:
  - [net-next,v4] net: usb: introduce usbnet_mii_ioctl helper function
    https://git.kernel.org/netdev/net-next/c/61e94cbdf822

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


