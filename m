Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5811230E0F2;
	Thu,  3 Sep 2026 03:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788404478; cv=none; b=X9vC/Rf6Z470VbyHAV6sS7fQJJRR61O3asfPMqJpBEPhGL5Th/PldRXTQqs0aamjQFohtoKOXK7azZ0P2p4hki9LztPjZpi621GmdjQUgfgu5EAZtCYyTPAOXAMO6+p1+FyO6b5HntAV/7eEutaTshFj0bu+iSm0LrKjimsZJ8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788404478; c=relaxed/simple;
	bh=p9sRPDGBEk2WvxAPuN0T6RSQweOkdbzblQuy6UrGQVk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=KjdU81Jo4gizrbN0cm1dzqx9EVY7EtDE05nHYF/Va7ZAl4krrTPiK37+3GKt7RKqAEP2L8GMJhk2fgXATuHhFoflCRNT9JK5MK/c5VdxGrDGAm+0GQGhrXTc2j6PH4mPpQ6DVb5WK/v4Xn0Z9MlhIYWZI7gC6iDph9UrCqixwas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HzRaQr7r; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HzRaQr7r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B92E21F00A3A;
	Thu,  3 Sep 2026 03:01:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788404476;
	bh=sNR50hyIJeugfx+EtEMz5UogmE69rtpr5xwj5ESSMUQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=HzRaQr7rlQX8VX5pzuqugut4JuZg6bMedwlSuA6jQm0FkozZWIRCzwY8XZpSoYz5C
	 joEUcKLC4nS+jbgXZQoj26W3/S08OZ+ASuL6KIFOrmRuJupXumwnJQc7PwWQGVKM9o
	 XmbYwRFvauWXo+9s0Bw60K9Fno4uPX/WBPM8Yy1cRTkaiRdXhPLZhu8oyle0t/BdX0
	 W7UKBId+/UVulEUkV1vy+jN38pDFOCokbxbQ5UEZ4py3piLQ5Wgzr+3zowuAXr9dJy
	 AB5wPJ6u3JPRApm2YNKtvm3ZP9T/U8+66oojVwINzg6jC0htD5q0aGR230cdt3yBWf
	 5+L3s3TdxxuSw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 9396D392705B;
	Thu,  3 Sep 2026 03:00:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3] net: usb: qmi_wwan: add Compal EXM-G1x
 support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178840441813.3061644.7138929140858941896.git-patchwork-notify@kernel.org>
Date: Thu, 03 Sep 2026 03:00:18 +0000
References: <20260831084124.65074-1-jisayme@gmail.com>
In-Reply-To: <20260831084124.65074-1-jisayme@gmail.com>
To: Ian Lin <jisayme@gmail.com>
Cc: bjorn@mork.no, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, johan@kernel.org,
 netdev@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 31 Aug 2026 16:41:24 +0800 you wrote:
> The Compal EXM-G1x is a Qualcomm SDX12-based LTE modem. Add support for
> its QMI WWAN interface 8 using the DTR quirk.
> 
> Tested on a Compal EXM-G1x modem.
> 
> Assisted-by: Codex:GPT-5
> Signed-off-by: Ian Lin <jisayme@gmail.com>
> 
> [...]

Here is the summary with links:
  - [net-next,v3] net: usb: qmi_wwan: add Compal EXM-G1x support
    https://git.kernel.org/netdev/net/c/08710f033e3e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


