Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 761EB21A434
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 00:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789606271; cv=none; b=hAGCaEr+qcCloqaqTkci+e8OA/HWDBNpUdMomiIhwb/1Pj9yg3+/2tX0/zrHLn1mq/OG9GqcTCxnDRNWIx4cH4lVCI7Kp7yTdjhPDlb+IHKxUskkyepEetj9N+t9wZNjcIahtvpRK4UuyNa9GHdxLTDQjAqvO7GDY0epXB6MXHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789606271; c=relaxed/simple;
	bh=NkkV/JdWPtHZtDiotQWufze6j6wJc3PhuWbsQ9zuwzM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=cbtFAADScPtRIUP5dji2VU45H9eFg3rPz9aO1PT6//b589r9m+839BelYcdlYWVK+cyj0yXBK/Chhn/hFIId5dM0fSoeqaRX6OIAIVHoMmge4HpiQcSAwxS4Be3Ofl24XADarj/mKtJlBX9z/sCPxDraz2qUF1NXs3/C/UqAVgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Egq0l3Px; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Egq0l3Px"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 100B01F000FF;
	Thu, 17 Sep 2026 00:51:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789606270;
	bh=t269HfjMFw+Ac088/gaNj0s7Ccstg652Ux3gzTL6sls=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Egq0l3Pxnf/UHoRkbw35xosF+yKeoBCcD/DBO8obFgALTxJSR0VpaOvpEXXWQ0xye
	 ffW3+Q+kZgw6Z5l7/8jvSGJdoPYKOjGGuYPYIPfCjPVIrVuCLaA4JMlsLaDKUkKIns
	 F6a+GDH7476osvkVhf0avojD4mFIdFvNglfVkn7z59pMyRXpeGwFcTaKmcuKXhHtfK
	 KvkB11wzyAWjXIFdCCU+r3hUWgZc/g40vjaeS1Jzw7FfmtCn/q50kyt0A9+3e1eiII
	 9PrrnodLefSsQK3EkpkSg525N4ZKeNXf2GJrVMyyCAwV+z0NhZQzR1L6VDVEh4+YN+
	 Cbcz5tH4H68XQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 2349E39E9601;
	Thu, 17 Sep 2026 00:50:05 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/2] net: ethernet: cortina: Gemini Ethernet
 fixes, part 2
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178960620388.3357310.12320664709519264100.git-patchwork-notify@kernel.org>
Date: Thu, 17 Sep 2026 00:50:03 +0000
References: <20260914-b4-gemini-ethernet-fixes-2-v2-0-5ab39a047b90@kernel.org>
In-Reply-To: 
 <20260914-b4-gemini-ethernet-fixes-2-v2-0-5ab39a047b90@kernel.org>
To: Linus Walleij <linusw@kernel.org>
Cc: ulli.kroll@googlemail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 mirq-linux@rere.qmqm.pl, netdev@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 14 Sep 2026 23:26:40 +0200 you wrote:
> Fix two RX-path issues: acknowledge FIFO overruns with the correct status
> bit and bound descriptor processing when malformed chains lack EOF.
> 
> Assisted-by: LLM
> Signed-off-by: Linus Walleij <linusw@kernel.org>
> ---
> Changes in v2:
> - Resend as prerequisite patches didn't yet reach the merge base.
> - Link to v1: https://patch.msgid.link/20260909-b4-gemini-ethernet-fixes-2-v1-0-5ea3aa393f41@kernel.org
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/2] net: ethernet: cortina: Ack RX overrun interrupt correctly
    https://git.kernel.org/netdev/net/c/1dd85662fee6
  - [net-next,v2,2/2] net: ethernet: cortina: Bound RX descriptor processing
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


