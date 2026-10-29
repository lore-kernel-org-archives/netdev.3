Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793273406;
	b=u05WD+oPCd35jqIZeRYAVVWiBiaDmpa4sNcQ5bD4ZCBCeXuj2W4aVKtrOUG7IFK1i39j
	 UaIgjljROoqPR/2ubnQl+WQ+aobCus2wARqX+VMuci0yekIS7UoXje8YdDS3BKFIt/niX
	 J8v3eMfDKYzN3b1Ew7pWeolfVBEN3Qwg+HSW7oWml9b1ZKyX6s9tHLlSZlr2Tt5sjgyWL
	 EQXSyU3cieKnFTw2xExPkh67MDyzgvmeHpOV48t7S3V3SEz+o4ckd8s9aXSQocmGLH0t1
	 rJmuMSbzg526IvSqdzHLkM+BxnZzYslOSrrwceGKJ++8uSPcOqY8lhzaInZVB8/040Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793273406;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=FOe+g0fqEqQIql0dXLsp8MI6mg1qaNRIyPGvU5jn5SA=;
	b=p/dnZD+MDNpPerhd8garkZQ+WRAL0qAInOHjx/S7G4pPK2TxInA8RrWADUhcfjbp/yil
	 swYAp4tkhEXhjBvXnW6RRkwpe0Cg/OlFKRFX/VrD4BKxKdTX2vk7c7Jer+IMFSeZSN10v
	 O3csBTRAFn13xl4zV5srMDYjziA/bf0oasUGdEjgcwo8Tzw02jvw8aW98cnGpr2L8F2gJ
	 KqKsTB6Yqoc2q1bH/qNMZ2A1n4JyD6NYfoM64VSZSztT2fS7b78256tFqHln2/qTJmf+i
	 bdasL29Khp+f2rD1TtmRVwpYhWRh5CrBVRQWgapW1h+QVK9+26ySI5C0DhcM0Ffy/MQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JTo0Mo5T;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1CFB606A33A;
	Thu, 29 Oct 2026 11:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JTo0Mo5T
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B1BF1F031E8;
	Thu, 29 Oct 2026 11:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793273405;
	bh=FOe+g0fqEqQIql0dXLsp8MI6mg1qaNRIyPGvU5jn5SA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=JTo0Mo5TeWODDKi6nGU5xrCt7y2ny5m+vBcPLut2aDT8xsIjDhfbj+AkQWb1CKlxK
	 sihZiEUaKTqLNi0tjDh9e1876q0EtQ8fj4eJcMDG67OwnuxZXquicNj1B3YFqAP6wT
	 /TE5GnmskuJt7D/F96mIATJuRX9jlxJnWi5xyB3jt9UZ3CUJpbR9karQEJs+AdVGJP
	 HXrFFnM4CiN7UPegR2q/YkYytarWJUeENexIR4qXYVEbIjrKcsp8t356D2Rz/RhXcg
	 0FwCAZ+XrOJXglWhKPVF2wB5Q0UqvH+MqxO79D9WAh70Do55noFPVKCkTcXWsERqcD
	 9v+Ckhznx0htw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 814B13ABD290;
	Thu, 29 Oct 2026 11:30:05 +0000 (UTC)
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
Subject: Re: [PATCH net] net: rnpgbe: Accept link-down events without speed
 magic
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179327340432.1769177.12829102670928563036.git-patchwork-notify@kernel.org>
Date: Thu, 29 Oct 2026 11:30:04 +0000
References: <C2DFBBF04F1DCFD2+20261026075445.920572-1-dong100@mucse.com>
In-Reply-To: <C2DFBBF04F1DCFD2+20261026075445.920572-1-dong100@mucse.com>
To: Yibo Dong <dong100@mucse.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, vadim.fedorenko@linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, yaojun@mucse.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 26 Oct 2026 15:54:45 +0800 you wrote:
> The interface can continue reporting carrier up after the link goes
> down because the driver ignores the firmware's link-down notification.
> 
> Firmware reports link-down events with a zero port_magic and no
> valid speed or duplex information. The driver requires ST_VALID_MAGIC
> for every link event and returns before updating the cached link state
> when this check fails. It also writes an invalid driver snapshot to
> firmware instead of acknowledging the link-down state.
> 
> [...]

Here is the summary with links:
  - [net] net: rnpgbe: Accept link-down events without speed magic
    https://git.kernel.org/netdev/net/c/6815a2513eff

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


