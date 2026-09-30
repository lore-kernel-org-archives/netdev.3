Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C68B23451A6;
	Wed, 30 Sep 2026 01:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790732409; cv=none; b=m3vmNF1SyQCyw3NdPL0SeuF1DmdNeuecp0EGnaRmPbUz4B9fPJnPs31qTfLgpy+5h4x2JE1NlsEEL4zW+FEa7kVdgfXr0fyAAHJskrHq7zJxjAjvKMA0z5iqS/Jc7N9NErMSlyJHnDydaxoStLxzn4aY6lHjQLB9YACEavsEd1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790732409; c=relaxed/simple;
	bh=rTwaGF6Si9doGtbQ2xytNlzHM5QXDTRl5HHqbST1/L8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=cCcczqsusvjXoEDKRNNP/IKG7j33wGtuiHxOloRzk7WJFzdqXJidW0Kv4YdkidbtyZAxE8s4rXQsWOZqkfbAkVDq0k93FwXHGbyZixTsNPmaeyR3XC+uDkEIPfXFo6LAmNSgKanzMbVVDCbk9u1ZtpliKmmhY/vG3wDkYoQ46Ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lf+pYSps; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lf+pYSps"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 476541F000FF;
	Wed, 30 Sep 2026 01:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790732408;
	bh=FJR6AKUyGSUOsMk5lSKuZJ2Wvblf/S3YNFdN/AvpJ1s=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Lf+pYSps/lAIbsWOY9uCo8t96C99/0ySQjrRaxJMx8pWPe43vQ+b1uorWaQTJHp9h
	 ex2yoxw/HZuOiY9fHJShbg7VbysThdY9FP86ZUMeAnRjaZguFjxJEe2Phiuhte/1bZ
	 DVKJSpiDUhdXGe7AfPrJTgbU6gGINUCT/Tq24LcRn96rqWlkcgGNiKYgT2mxRG9Oa1
	 19A4uhuNU/1xiHjw1bNMCSJ/QAr+qid/CwPh43bBj6X8ewI1I1g7YFY3MnGiclVTLQ
	 MEaCsC7VGjaLdU01gvoGksieuXGPpjqcbYqquiU1hR+XzD+jjK0YUFdU+SekEFVL6p
	 qcnOj0IYatqzQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3A3AA3924FEA;
	Wed, 30 Sep 2026 01:40:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v6 0/3] net: stmmac: add Allwinner H616 EMAC1
 support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179073240703.1199722.17774874033053476727.git-patchwork-notify@kernel.org>
Date: Wed, 30 Sep 2026 01:40:07 +0000
References: <20260927-submit-h616-emac1-v1-v6-0-e64971f4e414@gmail.com>
In-Reply-To: <20260927-submit-h616-emac1-v1-v6-0-e64971f4e414@gmail.com>
To: James Hilliard <james.hilliard1@gmail.com>
Cc: richard.genoud@bootlin.com, maxime.chevallier@bootlin.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, wens@kernel.org,
 jernej.skrabec@gmail.com, samuel@sholland.org, mcoquelin.stm32@gmail.com,
 alexandre.torgue@foss.st.com, clabbe.montjoie@gmail.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, peppe.cavallaro@st.com,
 joabreu@synopsys.com, alastair@d-silva.org, mripard@kernel.org,
 netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, linux-stm32@st-md-mailman.stormreply.com,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 andre.przywara@arm.com, krzysztof.kozlowski@oss.qualcomm.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 27 Sep 2026 12:52:18 -0600 you wrote:
> The H616 secondary EMAC supports RMII at 10/100 Mbps and uses a separate
> system-control clock register at offset 0x34. Add its binding and a
> sun8i stmmac variant using that register. A distinct compatible without
> an older fallback prevents the driver from using EMAC0's clock register.
> 
> EMAC1 connects internally to the co-packaged AC200 or AC300 EPHY and has
> no external PHY pins. Leave PHY initialization to the PHY driver instead
> of using the H3 internal-PHY controls. The RMII-only variant does not
> expose the RGMII clock-delay properties.
> 
> [...]

Here is the summary with links:
  - [net-next,v6,1/3] net: stmmac: sun8i: reset the MAC after PHY initialization
    https://git.kernel.org/netdev/net-next/c/fee9c17671b6
  - [net-next,v6,2/3] dt-bindings: net: allwinner: add H616 EMAC1
    https://git.kernel.org/netdev/net-next/c/1cf9c2ac57fd
  - [net-next,v6,3/3] net: stmmac: sun8i: add support for Allwinner H616 EMAC1
    https://git.kernel.org/netdev/net-next/c/61240e48a67d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


