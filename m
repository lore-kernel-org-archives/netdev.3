Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2BBB35E1CC;
	Thu, 10 Sep 2026 01:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789005075; cv=none; b=HDSnacUZyp9KQgb/i7AUAyd+2zSvWFexaAZsEMD3lEtfG+vmwkTfy9vod6cFzJ1soKSjKXEi6mtiO7S1TjPCbKKNG1LYCCuQlhM1qOwYA0QqakJhcJCGhCX1MOGr8tTK7UlJ29TG9wTC8wV2i5tbjQ7ZGfSeocgCUTukvu81Sts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789005075; c=relaxed/simple;
	bh=VM7tzopPbOCFMk/lfXIhUK+yZo/khZlAYQ6XyMPRSLY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=FbuCD5zlA67hp6LZqK5/N4wFappow2nSknvsmUikCq8kutukCp5MvzeHtoPHPcvn2mGm33tym1RkJ6c2FsmLrbLrMeCyzvxGZjBmMqU6oJYaD5/z7LhuDjFU1/68fStUWcpQVe8T1i6RCh8rAeeviDYj3hhHdBVmZElzTyuHeKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hJuG1Gxa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hJuG1Gxa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56DC21F000FF;
	Thu, 10 Sep 2026 01:51:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789005071;
	bh=PfTp7d8lfQoaPKu58NzLV/HyU0NGqIegxLaVDCS1t3g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=hJuG1GxaKfJV50A5QOMiWzIeh7cUhrZ+sGWZRW3Q7MzMnpqd3p+d796uE4k1qMHY6
	 /PSro1UmLDqX3u5Ee1EMhSu+oAKNOEg7ctpz09YHbAh3GmQ7WvtladmLsqZG3VqPSo
	 4AV1l7vRsCik6lMO/oMaLhGHOBAosQ9P8mBmEnm0UMonkaRmakvIquYiPNSm2FlYUt
	 M/cJ60t3wvipPy+aVcMrk9zu1FKiqnLoClxV6GaAtNlKqJZ+J4/RvOhDwWHYd7hONP
	 w0mm5Nwa3u5wFgE8lwv6LnDAxSZpqbN96vlIoYJQPp+zk0btYdsK4LizrbXfC+V8Hn
	 pbxS25trwabgg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 569D4380CEC7;
	Thu, 10 Sep 2026 01:50:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: usb: qmi_wwan: add Compal EXC-T1 support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178900500887.1147948.5790523206837140758.git-patchwork-notify@kernel.org>
Date: Thu, 10 Sep 2026 01:50:08 +0000
References: <20260904075741.55778-1-ian.lin@jetone.com.tw>
In-Reply-To: <20260904075741.55778-1-ian.lin@jetone.com.tw>
To: Ian Lin <ian.lin@jetone.com.tw>
Cc: bjorn@mork.no, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 4 Sep 2026 15:57:41 +0800 you wrote:
> The Compal EXC-T1 is a Qualcomm MDM9207-based LTE modem which reports
> "EXC-x1" as its USB product string. It exposes its QMI function on
> interface 5.
> 
> Add a fixed-interface match for the QMI function.
> 
> Tested on a Compal EXC-T1 modem using an Ubuntu kernel build. Interface
> 5 bound to qmi_wwan and exposed cdc-wdm2 and wwan1.
> 
> [...]

Here is the summary with links:
  - [net-next] net: usb: qmi_wwan: add Compal EXC-T1 support
    https://git.kernel.org/netdev/net-next/c/3bfa48d011fb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


