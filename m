Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C801341DEE4;
	Fri, 10 Jul 2026 11:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783683658; cv=none; b=m4QhqsqSOX9OkHnpgFurNN1VW34ZJ+S5cz8mEF5KGBqEeCQHrW//TBlEqTs9oGYNKp5r49PDV51ja86f21+Tez27CwOarhM3M5rfDcu8bGEoT92ZdMtgXS0nF2wpu4tfApi7/8Xs0dUi7uWA2NhUEnllGvU0b/8/7Chd7M0kD6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783683658; c=relaxed/simple;
	bh=Qiw8sO7D9OfWIkFKgSmfbQU5FuDCSZxhLrFe/qiy1ys=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=EVh/USz52jse7V4bXo5zBXSWMSS+XpS6vhyi6TD4i4ZYXHSaooMqzqbIxqk/9aSjwdXNMyelhK4Eavh1yv55g6GeO5WPklG6964aMB1EQtp+A7DkhdAy2DP+Sr1/WVFONaeL5pcU06kbJDqvtAg9xsjWVEGrV0A7Trbz4vaHkyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fDJZdJQI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fDJZdJQI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 950D81F000E9;
	Fri, 10 Jul 2026 11:40:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783683632;
	bh=wOafub/PHc72pays8fyMJ0bla9fiEDFv5P07yKezDtI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=fDJZdJQI/AgRPokdECJbmsj+7q72wFddNGi00LXMs3B1jxEiS0D+nk3gb66BW7370
	 vejQ38EUDhYctxb62Si+0CyEL3mh1y3EPIHGPPaSYkEOUqKs9aXQxIb5LKl7ObJdeN
	 rfXbB4v7xiBrvM6sFRYj/0gDUsrF0M3JQe9LtAzs/xoY1UD+7oMUA2C5vCRSQRFxUa
	 I7D0MXeDmePXlPA8BS3DjodXLZJ/OYOuh3BnZKYvhiVu44Fnp3MAd/HbOnXrORN8fp
	 9EDkVnzkt1FDB+2WB7Rpgka9beNRxSVvOdPxEJYlKwYawdigygNz3QRnL658ytcC3L
	 WatHt9YqGmJmA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B683A3924F8A;
	Fri, 10 Jul 2026 11:40:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3] ppp: defer channel free to an RCU grace period to
 fix
 pppol2tp RX UAF
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178368361038.197766.8115253096775560860.git-patchwork-notify@kernel.org>
Date: Fri, 10 Jul 2026 11:40:10 +0000
References: <E793FCF2-58DE-4387-A983-C7B4BC3158BD@doyensec.com>
In-Reply-To: <E793FCF2-58DE-4387-A983-C7B4BC3158BD@doyensec.com>
To: Norbert Szetei <norbert@doyensec.com>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 qingfang.deng@linux.dev, yuehaibing@huawei.com, gnault@redhat.com,
 kees@kernel.org, hataegu0826@gmail.com, linux-ppp@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 6 Jul 2026 11:01:59 +0200 you wrote:
> pppol2tp_recv() runs in the L2TP UDP-encap softirq RX path:
> 
>  l2tp_udp_encap_recv() -> l2tp_recv_common() -> pppol2tp_recv()
>    -> ppp_input(&po->chan)
> 
> It runs under rcu_read_lock() holding only an l2tp_session reference and
> takes NO reference on the internal PPP channel (struct channel,
> chan->ppp) that ppp_input() dereferences.
> 
> [...]

Here is the summary with links:
  - [net,v3] ppp: defer channel free to an RCU grace period to fix pppol2tp RX UAF
    https://git.kernel.org/netdev/net/c/ec4215683e47

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


