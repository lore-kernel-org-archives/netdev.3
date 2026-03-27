Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53FBC3264DE;
	Fri, 27 Mar 2026 02:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774576824; cv=none; b=KYLty+Ak4rynsVS8X7hzZsU2td6y1oPOgNFlb/g9vtDCk1yG+WfvuA0BwhsKrhEdaOvhJ+MEPZ8ZIVWb9YHrIzcG5J8xsiIR6xoYw7zcRSBfPSWQwG3Pr+WUcx2uIVLIl9nhQVre0NK9MwXwhnj3aVeKPtCOb2nrDLbRC/I4h3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774576824; c=relaxed/simple;
	bh=0hvJlQ5vBTRk27pts8id+XnWGexblQQkdTV///covsc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=tAhuycM4JYTzp3BeY7Cx606qKuJFnWZzR/InbvXgbNpj628CgIfWHCVZNDzKzQ0oRtPDCr5JElkYjqFGRRqhWsLycUn3/yV+A/Kk44oqK4hL+b+2r9zIniMNx560KTCUH7CpqX5kZ29qPTfxYPT61uydOnrUxsGTkh+WFe2yxSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HLsCtsup; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HLsCtsup"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5C2DC2BC87;
	Fri, 27 Mar 2026 02:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774576824;
	bh=0hvJlQ5vBTRk27pts8id+XnWGexblQQkdTV///covsc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=HLsCtsupB+Y44bZC2leQ9dmg3xsEjK7J7lzcSLJ9BbQSK7PJadwROapLzGbrjDGGR
	 QX24U9xWbnnFegAkep1GGJp6RTbRoekF37hJ8DfFNJU5x2ESJwnQveotqRo2dDUqVy
	 sdC37bbEHP4m6IZTEKFfgF+l64JMH426y0Vz0vICYXRUwSb4M1bjzv3c586S70RjEY
	 okwBecbXl3V/3VAtMbkJchGeIlD5PFAgAsQzI1SuehvNwO+4OzglEdvPDyPRURbs3n
	 J+nj65AZHhMFPDETLEEiurRdIzSvrBCj2Iiqs6lloagj5gon+3R31DJk53fhB39lXV
	 b1UvH2hmKgq+w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CDAC3809A07;
	Fri, 27 Mar 2026 02:00:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/2] net: dsa: microchip: Small cleanups for
 ksz9477
 SGMII
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177457681028.3259194.16998147916976766476.git-patchwork-notify@kernel.org>
Date: Fri, 27 Mar 2026 02:00:10 +0000
References: <20260324180826.524327-1-maxime.chevallier@bootlin.com>
In-Reply-To: <20260324180826.524327-1-maxime.chevallier@bootlin.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: andrew@lunn.ch, kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, woojung.huh@microchip.com,
 olteanv@gmail.com, UNGLinuxDriver@microchip.com,
 thomas.petazzoni@bootlin.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 24 Mar 2026 19:08:23 +0100 you wrote:
> Hi,
> 
> While working with ksz9477, I've done some  very minor cleanups around the
> PCS code for the SGMII port. No changes intended.
> 
> Maxime
> 
> [...]

Here is the summary with links:
  - [net-next,1/2] net: dsa: microchip: Drop unnecessary check in ksz9477 PCS setup
    https://git.kernel.org/netdev/net-next/c/e1da0e1859c6
  - [net-next,2/2] net: dsa: microchip: drop an outdated comment about SGMII support
    https://git.kernel.org/netdev/net-next/c/588cd4e7d22c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


