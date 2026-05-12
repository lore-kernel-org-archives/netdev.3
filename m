Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25A1222156C;
	Tue, 12 May 2026 01:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778548124; cv=none; b=KbDQwXZC61aFPIz/Fbay/NxZZ9ONKyPHjUTeg7W/SKNO+5mHPsnZIm2TkuIgOCQi8fb+oT9d6ObuGN/JiBqXKg6XwXZAZs5RyflQmyWfVg4ZXSigHgTSgYyM+3jQ0F0YShizPkWgc1zh3SEL7C14te7k9S2iBcjMT1nQxpXRUj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778548124; c=relaxed/simple;
	bh=y+581VyAmDoRxgCfmK0fkL9lSondMn5xnIWlB1UWcvk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CAzmQwuzrQtE1b6zdYTdxRWTtiL2Rf09zDk0Z+bTMPxBxF7f+sMeqiUTGk6hJSw7JtHjMWN3/YefJPrwN/hEd6D17UtZndFcoaw55I+NNH7ZQ7AKiirlJFpNVOq9sDzKwaO4NSBliAsKpQ/7istTfFzFnjVjzUomdqg9omcmGrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bA/ToxwQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bA/ToxwQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 692A0C2BCB0;
	Tue, 12 May 2026 01:08:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778548123;
	bh=y+581VyAmDoRxgCfmK0fkL9lSondMn5xnIWlB1UWcvk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bA/ToxwQ5+E+ECM8M4dbimYOgMPkmOLl1zfrwLzNyRbh2l4MZUnf7c4/73Z2UoEle
	 4mJakNujH+UAy93pDnMBplHKbZORFwlg/QvQ5Yv7XkdLtjlxO4xK7JSj8TqqTPQQep
	 s+W6/Lx0ML3afttAjJbY6cV3LsD6FEUOc6Ouq2YwD9gdx/6Iz13LKDsmY5DJZR0s/w
	 RnJgn7twHjmFI9PZ8pCaHc6b3OeT/gQyeRAtgU8ArSlhLqhRTee23zJ0woVHv6jnpk
	 GRxd5CnWBevIcmoT1bYuvvq7Xa0VUz20gyCxEJRKSQRjrJLCLTqR14sv9B2Oz8ZmdY
	 TcRQ/m+ealVhw==
Date: Mon, 11 May 2026 18:08:42 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: muhammad.nazim.amirul.nazle.asmade@altera.com
Cc: netdev@vger.kernel.org, davem@davemloft.net, pabeni@redhat.com,
 edumazet@google.com, andrew+netdev@lunn.ch, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3] net: stmmac: Use interrupt mode INTM=1 for
 per channel irq
Message-ID: <20260511180842.0a547a25@kernel.org>
In-Reply-To: <20260507070125.11886-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
References: <20260507070125.11886-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  7 May 2026 00:01:25 -0700
muhammad.nazim.amirul.nazle.asmade@altera.com wrote:
> - Wire up multi_irq_en via STMMAC_FLAG_MULTI_IRQ_EN in stmmac_main.c
>   so the feature is reachable by platform drivers.

Okay, but where is a platform driver which uses it _today_ ?
We need an upstream platform that uses this new bit submitted
as part of the same series.

If I'm completely off, and this new code somehow gets triggered
with upstream platforms - please improve the commit message.
-- 
pw-bot: cr
