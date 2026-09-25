Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2FE4470444;
	Fri, 25 Sep 2026 09:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790327709; cv=none; b=JjXGFwN6B++YO+QXEYgUDXead3Ksz3bO0V6c0+0npNxjPW+zhkvY6DuHwsWxqI1PanWpdWBo50seNbOtnDCLR43bMzHRKaWgtqkJADj5jk2STGl7BuU9r32u7jOoCsPtHKXFJpUZRmRpYD1SwdWxf2V4hhyC9JEJhVQAVv2jGzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790327709; c=relaxed/simple;
	bh=PXmxT8gBICH7ApuifgwKbhK28APFenDckUtjkHBBWXE=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=nkhTqk1wS6c0iV+H4RX8xxndwTPYhSiZfQmx/zGO4Q85f/Gn5rdNwaJxkOGCqpNxGHqkea/gD7IyGXn4lSXNCDH9ZCzsfFBwx9dal5wd7ooCtvWE6ccmQVXQNy615ijsoAf9//Bju4g/Lj3+rjQQNFI0VQdRMniBK4BIAzpIj1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=Ah5CkMYl; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="Ah5CkMYl"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7345CA4A3E;
	Fri, 25 Sep 2026 11:15:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1790327703; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=wehUHYkU1+VnkFgCnyBducIt0IFFdf8LGiUDz0l/zvg=;
	b=Ah5CkMYl5gXkoHslo7S+NRu5EmIdbLUyxP+V591ie1WfV4CUsoLNBOwLNK1nYbWYpXej5q
	aDFsw7+UgPuvkCOv0yVRqq4te6upJ5ODaTyMEw7lRi2WZi+c684CLw6yIoVhIq1N/tKOWQ
	q9i9lpdyO+j6D8eaNH1LoFKmXgW86n1k97xu+0XE+YuOMtyI8Q7ICU0B5JSFp051xS6eWn
	yMxIKu/w+6jja1klgF+cdmCrf8noWn0rNk49iI0SzzmbCbSxSgnZLMrsGpq13QRRSZ8/Wy
	OcjlbPFaUAJ9s8ovSzMixnpujuUu/xAb+oCSuUkH4LJcIQpJ3jrSCj1v3k6H2A==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 25 Sep 2026 11:15:02 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: netdev-bot+sashiko@kernel.org
Cc: andrew@lunn.ch, kuba@kernel.org, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 kory.maincent@bootlin.com, vadim.fedorenko@linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2 2/2] net: ethtool: let tsconfig reach a PHY-only
 timestamp provider
In-Reply-To: <179025240309.2160803.13124415103175394580@kernel.org>
References: <20260923121644.2194183-3-nb@tipi-net.de>
 <179025240309.2160803.13124415103175394580@kernel.org>
Message-ID: <802cc23e2050dfbe56b7564b921e06ad@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

On 24.9.2026 14:20, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential
> issue(s) to consider.
> 
> Critical: 0 · High: 0 · Medium: 1 · Low: 1
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let 
> patchwork
> know by including "pw-bot: cr" as a separate line at the end of your 
> reply
> (one such reply per series is enough).
> 
> - [Medium] ethnl_set_tsconfig() can now install an 
> HWTSTAMP_SOURCE_NETDEV
>   provider on a device that has no hwtstamp NDOs, and that provider 
> can…
> - [Low] The new TSCONFIG_SET gate in ethnl_set_tsconfig()
>   (tsconfig.c:303-305) looks only at whether dev->phydev is the 
> default…
> 
> --

> [...]

> [Severity: Medium]
> 
> The commit message says "this makes a netdev provider reachable without
> ndo_hwtstamp_get". Should a netdev provider be reachable at all on a 
> device
> without the NDOs?

No. v3 will pick the netdev source only when ndo_hwtstamp_set is 
available.

> [...]

> [Severity: Low]
> 
> This check runs before dev->hwprov or the requested provider is looked 
> at,
> and it only considers dev->phydev. Could it reject requests that an 
> already
> installed PHYLIB provider can serve?

Right, it ignores an installed provider. v3 will also pass when 
dev->hwprov is set.

> [...]

pw-bot: cr
