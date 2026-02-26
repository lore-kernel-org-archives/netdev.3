Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6D4A296BD1;
	Thu, 26 Feb 2026 03:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772076602; cv=none; b=HFPDPBw8NcEFjorS1iu9wfh5jRqml82oNLui5d2h+3LzVIUuJPc+IJIWQgWEqIjBah3g2ooDdlcYnnTRQJ9UKKYObZx8/echeCnr3fkFXqsFJa8ZYmo3AJYASBpyV8hHzzQ5c15Ogy8l7Jb+gKHmn3Ix4Ayms9s4E9Fjm/sRlxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772076602; c=relaxed/simple;
	bh=7lCmbDv+2pRFz25J9Y5YD+I1O9idkhZlZdp0R+Bw6tU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=eocIIx+m0jVdJHkjCW7RBVNHMve3U+I5K8IFeMC1wzYFlRnKlG82DBXjkasVWpGliT+50ttCxuWPgqJjvseVKPQA5B/4RgioicvGDHw2DD3dBVxJ/jIeeCLnwalcoFt/1uT0MJRLFytURUmAcmpgswDLVmhLY4iBq4zbZ51a+t8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kURdJ+ZV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kURdJ+ZV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AAA5C116D0;
	Thu, 26 Feb 2026 03:30:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772076602;
	bh=7lCmbDv+2pRFz25J9Y5YD+I1O9idkhZlZdp0R+Bw6tU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=kURdJ+ZV6FUaCIue5OgphZ6iCKILsjtgG7kBybGxnWFdJ/CE3AaK2Tpa0eHG5IpVd
	 fFWM1LUG4wTv0PKbpQTlMv/qoHFC6zcCr/4HWtg4824xHRfrXPCpLkaCN3TIoWy00d
	 aqVoi/V14euPqR4PptQWcNLnZIVWDhRD+17C5q5XAXS6onDp2JSP04hB7Ki5DHDJ4G
	 75ETwvHi0UeJE+Jnd2RhyF374d8qTfBt1HZSn7kg/fOqy/j+hNzDSxGPCOJSKw8sJb
	 SB3IoT2gDLzYKKlS9penxODyKwSWzP++vsZFYkzHoAvWPuUM6HHQY4JwkE0V6K4vgI
	 7Nw2LCnJGdNwA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9EBB380A94B;
	Thu, 26 Feb 2026 03:30:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3] net/ibmveth: fix comment typos in ibmveth.c
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177207660629.1022268.3552526517808096956.git-patchwork-notify@kernel.org>
Date: Thu, 26 Feb 2026 03:30:06 +0000
References: <20260224153601.17534-1-abhindeka@gmail.com>
In-Reply-To: <20260224153601.17534-1-abhindeka@gmail.com>
To: Abhilekh Deka <abhindeka@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 nnac123@linux.ibm.com, maddy@linux.ibm.com, mpe@ellerman.id.au,
 linuxppc-dev@lists.ozlabs.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 24 Feb 2026 21:06:01 +0530 you wrote:
> Correct spelling mistakes in comments:
> - Fix misspelling of gro_receive
> - Fix misspelling of Partition
> 
> Signed-off-by: Abhilekh Deka <abhindeka@gmail.com>
> ---
>  drivers/net/ethernet/ibm/ibmveth.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Here is the summary with links:
  - [v3] net/ibmveth: fix comment typos in ibmveth.c
    https://git.kernel.org/netdev/net-next/c/8debe7a22309

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


