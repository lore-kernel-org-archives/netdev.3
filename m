Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792630812;
	b=aKJl61K5KeJ/gCHNdroaRTMNfhZ3ljGzXNeanEp2cNWTMbKHUWzhB6IX0c3H1BbD4aOH
	 og9em+vFJmQanMYUPSCWvBpbzdAPDAfblfsSB6Lf3HMlnwoChMyoaeM5x33wKbJWZZQZX
	 0EX213K6oj2rMcRdrgZDrNqI/i/4ZQgTVW6sM92VT/pgt8d09iWk6mQeMYqUsZz4M7Op0
	 sO9I8ukmm92jv+nTV4Ry8pwSrmuEcROITA6y3n9SRhuClm4WLpvoeHbEdZLGm1B+7xuAJ
	 V8mi4j4eWfX0acS6vxoPiUT74Kw+SdZpDgbqhQRJE/N2vJOZtwChiKSmTT9fTOgIpkQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792630812;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=+YdYM0NBllqNB84LphHbsjLz+SbuP9MXplji+Syrpqg=;
	b=DNTmc/e/0VLIC6pifzmbx+7wbemVw9xm19RcVZOUcKErh+JA3qjYE6lwL3brs8kTnxIR
	 eO4ErVzmSIwculmpaVPzPfJ1ulIPev9r6ACfHEEBLKjejfcYQtdHYyKQSMhYePGI7QJX+
	 H0yAwH/TYHUdnGVwJLh1mou7r39hP9cDcIr2lF+fIOHf9YsmkdzovsdzVf5If8mqeKh6q
	 JVfneIC+yqu6pQzHeliJ+4qASH7B/ZJlxn+L4PZXyKfSdMfMudGgY9J25JAFNdG2MbgwC
	 yt/3v7aM+huc6NoqvoeurpNGL63cOo3Sl9D6XhDRAr5xn5ebx1vq/uqJNA88/yhXUTA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eYmnA9xP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7AE1606A329;
	Thu, 22 Oct 2026 01:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eYmnA9xP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F4BF1F000C1;
	Thu, 22 Oct 2026 01:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792630811;
	bh=+YdYM0NBllqNB84LphHbsjLz+SbuP9MXplji+Syrpqg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=eYmnA9xPPy5SLGVtXJNO2wWltoFAw3eT+7XShjxpu2hJBx6ob466pKZZoNW+M5Uos
	 oDcqLk7B2hK40DW+zeCU4X7PpotDduGRzcWrZiSWAMbSXHuHMMDGbaNMWW16joEn9S
	 idWMTcrv6K6OqEOaMJjKtHR591L+m8Vykp9CVlOQZPsy4ifbohpDqO7EI3pILDSUt9
	 ypM6V/PSqGwCqi/FlIDM9T75PsR0O1eKnqOGnJzGvPTCSi7A4W4tDh3+ANNbmS2fTt
	 ALHVD52s2K8R9SSXZ4JdDmKQ+0W9Mv+OPTj45+yFklkCTEj58G5/1UwzGW+COBsco9
	 Rb3KzXn8N7myw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7736A380A963;
	Thu, 22 Oct 2026 01:00:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] tg3: Add Datto SIRIS 5 1U Server to restart AER quirk
 table
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179263081003.1390149.18016340703133602527.git-patchwork-notify@kernel.org>
Date: Thu, 22 Oct 2026 01:00:10 +0000
References: 
 <20261019-tg3-datto-aer-quirk-v1-1-f0eccfb2ab5d@lafayetteinstrument.com>
In-Reply-To: 
 <20261019-tg3-datto-aer-quirk-v1-1-f0eccfb2ab5d@lafayetteinstrument.com>
To: Travis Howard <thoward@lafayetteinstrument.com>
Cc: pavan.chebbi@broadcom.com, mchan@broadcom.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, lszubowi@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 19 Oct 2026 20:03:10 +0000 you wrote:
> From: Travis Howard <thoward@lafayetteinstrument.com>
> 
> The Datto SIRIS 5 1U Server is a Dell OEMR XL R640 (Dell's OEM-ready
> variant of the PowerEdge R640) sold under Datto's identity. Its DMI
> strings report sys_vendor "datto" and product_name "SIRIS 5 1U Server",
> so it does not match the existing "PowerEdge R640" entry in
> tg3_restart_aer_quirk_table.
> 
> [...]

Here is the summary with links:
  - [net] tg3: Add Datto SIRIS 5 1U Server to restart AER quirk table
    https://git.kernel.org/netdev/net/c/a55eb6a62214

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


