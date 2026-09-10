Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C837489FB6;
	Thu, 10 Sep 2026 13:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789046467; cv=none; b=YCI+viXed9926LNzFV/JBdEyFM+MjVF5vCsjRQWsY4r3afY+7IT+IN4HfclXry+p1HY4BrE1Q8I9Ysg2w5BBTlmCwrq7CtVgbgIrs/nT+5xg05RldXVQAKSz4zhcWuf6p5EfwIgBNN2KVjpsMeegFNmeydbCaa5mIfVUBqqfyqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789046467; c=relaxed/simple;
	bh=J7AkbIU0w67j8L7UI7Z+8H4Cfckn7EIW71gNSZ9YqbU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ViFHCpS1lmsovZ2Nsl49CI6AQs+gKzf0OZRwYowxfFT3iZjorI4l1nC5bV+eqwwYjJ2Xh0omCSAjxed7go2E1PlHSAlkuyWsba8y9bVym57AfkGNrQrt2Sa9qcsLoe8U2oO/wpG7ua775+C6v8QpERXZDNfBtaCltce/APkasQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IZKRF+bD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IZKRF+bD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C4091F000FF;
	Thu, 10 Sep 2026 13:21:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789046466;
	bh=6kdWNS6qHpM7rESSd5+lK0SElqpcsXbcuIlVAkccGBw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=IZKRF+bDhD2JRkiUmK8/qwpQjOpJ0SEt+UbUezBmtBjmrOkYFeIQzDMnZ6sg7nn6r
	 J/NAtOrz6N6EtQGiwbKTCPajmsL+dlvfizk3Ed/o8D+Zm680q/sKaEW47mh0mOWidQ
	 G4k6fvRK4jXjxUOUUu+CDcZO2uMAWJzVhW8n98JAAt+F7KHywzSkaT1eyjsqdXjjUb
	 MPBIU7qJexOVheocobi/gtvOPvyZ6URTGOHTx9kDsY+k/vhyOgyNgCgUFb7o806hv0
	 8Qw8hXqIz3+9pbE7x/hEeMDcd4j8NNbWZXmIRwdl9BPJViW5SyxsXatUrqqyVdxLw+
	 4194iCEEQsq8g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D09F0380CFEE;
	Thu, 10 Sep 2026 13:20:04 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 net-next] net: phy: air_en8811h: select LED GPIO pins
 based
 on AN8811HB package variant
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178904640364.1426497.6750503287059225933.git-patchwork-notify@kernel.org>
Date: Thu, 10 Sep 2026 13:20:03 +0000
References: <20260907015638.2875763-1-weiting.lee@airoha.com>
In-Reply-To: <20260907015638.2875763-1-weiting.lee@airoha.com>
To: Weiting Lee <weiting.lee@airoha.com>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, hkallweit1@gmail.com,
 linux@armlinux.org.uk, davem@davemloft.net, kuba@kernel.org,
 edumazet@google.com, pabeni@redhat.com, linux-kernel@vger.kernel.org,
 bjorn@mork.no, ericwouds@gmail.com, frank-w@public-files.de,
 joseph.lin@airoha.com, wenshin.chung@airoha.com, lucien.jheng@airoha.com,
 albert-al.lee@airoha.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 7 Sep 2026 09:56:37 +0800 you wrote:
> The AN8811HB comes in two package variants, AN8811HBCN and AN8811HBN,
> which use different GPIO pins to drive LED outputs. AN8811HBCN uses
> GPIOs 0, 1, and 15, while AN8811HBN uses GPIOs 3, 4, and 5. Using a
> fixed GPIO assignment causes incorrect LED behavior on one of the
> variants.
> 
> Read the package variant from the read-only silicon identification bits
> in AN8811HB_HWTRAP2 at probe time and store it in priv->is_an8811hbcn.
> Add an8811hb_led_gpio_setup() to configure the correct GPIO output pins
> and select lines based on the detected variant, and call it from
> config_init.
> 
> [...]

Here is the summary with links:
  - [v3,net-next] net: phy: air_en8811h: select LED GPIO pins based on AN8811HB package variant
    https://git.kernel.org/netdev/net-next/c/10ca508878b6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


