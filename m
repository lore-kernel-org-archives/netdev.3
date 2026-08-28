Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B01224746A8;
	Fri, 28 Aug 2026 21:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787952425; cv=none; b=iYdk5wWXSIgevidIMvLgIBqEfnlWisDDXXNUBlvbgmNcuXdjRKyIFOMQHPoCaKIaFCga/BAGnYWE3PY2nXwhfn21j/Hctst4IitSttxy2qeWaEFj0GLeN/ibj9J70F0ypPAauY7evCSURRIYWD3pgY/PbGgLSH0jD0QUTJrbsLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787952425; c=relaxed/simple;
	bh=YUt9XlHUuYGVuLPv1w9qGwxEq25tB10H5+HjXKtdj0w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UVfPJYazNFfYNThLN0flmAyIha+eLUlhh6YwzTFtPuAvE6KWxdr9wL2i3MCKfGNdqv8KvLAPGfB4FxdBr4seethI4xuMA9qBJcWUqC0SWb3mpwJo7sBu7DMJOmC6iKtiLYun3IgUf4ruln1tpJQud0MQTGCO8cYHEUO4T/E4f6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C2HFt6bt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C2HFt6bt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 356141F000E9;
	Fri, 28 Aug 2026 21:27:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787952423;
	bh=02/+eupWtl3O4k6yVI+71Pv7fqgZ37drhXSlQCN+ujs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=C2HFt6btPYGvEEXCOeD51VYsRyAawkN1xcRdtVHNaEfWgGFQ6Cas8WxJQj0SriTPW
	 VOpl1upc1K35RSImJFq7ZYVkvj0DyktI/g7GWioBredtOrVPQSKQD9+CxMU8qwujhR
	 W0Eb9KjLAXnCezDAqj9ZXm6TANnpD+bbMhtPeDbHXrWHX+3BROqi/47W/TBGzC0Xra
	 8hLMCLbuJKLrzblKPjpZCu0IEHHYc9COfo8w5ZSd64dKcdLsYXNuNv8y8nSmT4TkFY
	 76a4wTXy3/EdlVunwrAE27zSwGYTbJ0mjoKkiwMo8AYDX4o2LV6tycOGLVFinPczPR
	 GNwBrbNzqFOGQ==
Date: Fri, 28 Aug 2026 14:27:02 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jack Wu via B4 Relay <devnull+jackbb_wu.compal.com@kernel.org>
Cc: jackbb_wu@compal.com, Loic Poulain <loic.poulain@oss.qualcomm.com>,
 Sergey Ryazanov <ryazanov.s.a@gmail.com>, Johannes Berg
 <johannes@sipsolutions.net>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Wen-Zhi Huang <wen-zhi.huang@mediatek.com>,
 Shi-Wei Yeh <shi-wei.yeh@mediatek.com>, Minano Tseng
 <Minano.tseng@mediatek.com>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Simon
 Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
 <skhan@linuxfoundation.org>, Robert Yu <robert_yu@compal.com>, Jeff Chang
 <Jeff_Chang@compal.com>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v7 0/6] net: wwan: t9xx: Add MediaTek T9XX WWAN driver
Message-ID: <20260828142702.0736cbee@kernel.org>
In-Reply-To: <20260828-t9xx_driver_v1-v7-0-bf8f6074d88a@compal.com>
References: <20260828-t9xx_driver_v1-v7-0-bf8f6074d88a@compal.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 28 Aug 2026 17:17:17 +0800 Jack Wu via B4 Relay wrote:
> Subject: [PATCH v7 0/6] net: wwan: t9xx: Add MediaTek T9XX WWAN driver

net-next is closed. Please a week from now when it's open.
Before you repost please fix the bugs pointed out by AI:
https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260828-t9xx_driver_v1-v7-0-bf8f6074d88a%40compal.com
This link will only reveal the results next week per the embargo
message, wait for that to happen of course.
-- 
pw-bot: defer
pv-bot: closed
