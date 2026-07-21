Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ABC3237180;
	Tue, 21 Jul 2026 20:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784665837; cv=none; b=FHiDGsJiTTWNm04rQ1wfoJsZOU3ietJowEp4UtvKCgr5aqyNfwxH5gIn4gbiwBEJOc7r1yrS9rXOSn7M+nXqS/bqKxkzUs6lLwIzbZhVUc1vSWgb3+3LJThtvvM/2YlmmWuFmk786pLX+X1i00b8B28ggH/BOf+NmBFu+ZtJMnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784665837; c=relaxed/simple;
	bh=v+mUbWSwpfwtTbSiJLWPy9EbO9/fb7NZd6VS9vESHpQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=crvWOYjMFORb8zMEpc4/mTNIevdL458uAw9OMzmNdo9ik++Ozv8bpM26AGodO6eXAsUAwBGtrT465nOCCgKsN5cdK5kUb8i95tRfu3mwSVBfC/6Iat6WEDT2jHbOgrfDbf5TAjqYme2kxDHsBeabJHOI0WQyn8t/iVRHys4R5C8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cTeQJ53R; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cTeQJ53R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FD4C1F000E9;
	Tue, 21 Jul 2026 20:30:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784665836;
	bh=x3DuSLFqxjfDQeIDxUDRnUVuk1TMchbwixar/Bzxivc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=cTeQJ53RSQ1O8v+ee2/zYTfG0Cbarw34uWuxaAazI92LVi2laq/rLUSHQRT17fjT9
	 zA8I/as5pBMqUTECMO2kIWKPlCsqVEjMX3oWp2Ce5EHjo19WitPJ8bqcwP1+5jOq3h
	 O8a5b0fZpEA0NDedvVhrmZtl+PTbBN5IlHOqekWOKwWRiY2EVvm2GL0i6i1ShNslMF
	 8slfO/aQlMUmR/v0KCszsJmhOlmsDYItVDl85lJczAdvRRCbxok5t0OB/lWHEcA0jI
	 KXW7eCDh+M7eR+4b6PC0BHL74+C3Hkhl66OXQ8vsvgy7Z037C/EImcCyA9BffvdXhB
	 OGoC6I6BiIZfg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D286F3926242;
	Tue, 21 Jul 2026 20:30:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4] dt-bindings: net: microchip,lan78xx: convert to DT
 schema
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178466580540.1037533.12729119858156455519.git-patchwork-notify@kernel.org>
Date: Tue, 21 Jul 2026 20:30:05 +0000
References: <20260712113821.12543-1-avermoal@gmail.com>
In-Reply-To: <20260712113821.12543-1-avermoal@gmail.com>
To: Mikhail Lukianchikov <avermoal@gmail.com>
Cc: Thangaraj.S@microchip.com, Rengarajan.S@microchip.com,
 andrew+netdev@lunn.ch, conor+dt@kernel.org, davem@davemloft.net,
 devicetree@vger.kernel.org, edumazet@google.com, krzk+dt@kernel.org,
 kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 pabeni@redhat.com, robh@kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 12 Jul 2026 17:38:21 +0600 you wrote:
> Convert the Microchip LAN78xx family (LAN7800, LAN7801, LAN7850) binding
> documentation from plain text to DT schema.
> 
> Restoring a mistakenly deleted email in MAINTAINERS file and fixing
> microchip,lan7800.yaml.
> 
> Signed-off-by: Mikhail Lukianchikov <avermoal@gmail.com>
> 
> [...]

Here is the summary with links:
  - [v4] dt-bindings: net: microchip,lan78xx: convert to DT schema
    https://git.kernel.org/netdev/net-next/c/c86cfc982957

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


