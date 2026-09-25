Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F016E4772A3;
	Fri, 25 Sep 2026 09:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790327256; cv=none; b=lN/JrGmGJWP/f9XFLi+kUqTFWa5XWHxbszdjG0ztbADW4GdtbYt/pF+1PdW9xgEu73bpo0uI11SKFw8AgO6wTvwBDSjrJP7neZEW8y4LKspvyo0S4PZSMa7mzMmKFKorQnz5xoWJeAdqOvtyvb71qz63XX9GHi7Ps2HCl09SgrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790327256; c=relaxed/simple;
	bh=f/3fNOtJrzRzcYS8PSiH2V1CVb5OseOMX8SNzn9rR2A=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=YGvKca1OtCThyKLlnqlIiPDL4SWQ+lE3BciDTlB6UIiqqep5LRPda128hIN6caxXZ5BJrKXZMSw2Jn08Wmwgg8JXOUUXYCBN+iClevuyuA494qzDWUyN3ejpV0iuW4UNAj61+mqPi+Klhwjed2lk4xbbkjwbpOD9VhaabaoO/ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=cVJZyxwX; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="cVJZyxwX"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7CB75A4A3F;
	Fri, 25 Sep 2026 11:07:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1790327247; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=IDpKCRmAJSCwD6WXiupqIREZekd0lmTuFhUI2CzOgnI=;
	b=cVJZyxwXRK01mBHKaEBdqKf1KVNxTMae+KxAcojdQms/x3sT0OidnU4sN0AabjULeDIrJk
	RwZhHQ1knQBaoOrf3OTkLzB5Z2zBT2WosDxX0n6vjHjpgSXxT2NbBEEJXodN+pxygJWNuO
	bCQgQTwTDoULX2WD3Gr6I1y7175bsQ4YzLjzQT5qCMzoRdEL9fa6ScbJGXy5j4Cq/QviY/
	f4UFP7RBkGqyOAp4cnakBQ4ARpgL4Vt5G9whpEOeWESEQSSz7G0n41oPxB3+vhIoDhO81r
	Nw2Q7swl7SysiieJMrr1RCkxrEi4JFTbQ/LAolEwEU5606IHPerCXhpf0SPfqQ==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 25 Sep 2026 11:07:25 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: netdev-bot+sashiko@kernel.org
Cc: andrew@lunn.ch, kuba@kernel.org, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 kory.maincent@bootlin.com, vadim.fedorenko@linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2 1/2] net: ethtool: don't match a hwtstamp provider
 on a device without a PHC
In-Reply-To: <179025240177.2160803.17736204487729550368@kernel.org>
References: <20260923121644.2194183-2-nb@tipi-net.de>
 <179025240177.2160803.17736204487729550368@kernel.org>
Message-ID: <eced0ba7bd628bb48624d24d3b3cb956@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

On 24.9.2026 14:20, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential
> issue(s) to consider.
> 
> Critical: 0 · High: 1 · Medium: 1 · Low: 0
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let 
> patchwork
> know by including "pw-bot: cr" as a separate line at the end of your 
> reply
> (one such reply per series is enough).
> 
> - [High] The fix is incomplete.
> - [Medium] The patch deals with the 0xFFFFFFFF/-1 aliasing through an
>   open-coded check at one comparison site instead of rejecting the 
> value…
> 
> --

> [...]

> [Severity: High]
> Can the same -1 == -1 match still happen in the PHY half of the lookup?

Unfortunately yes. In v3 I will reject the value in the netlink policy.

> [...]
> 
> [Severity: Medium]
> Would it be better to reject 0xFFFFFFFF at the netlink boundary instead 
> of
> adding an open-coded check at one comparison site?

Will do in v3 (NLA_POLICY_FULL_RANGE).

> [...]

pw-bot: cr
