Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAC1A23D7DC;
	Tue, 28 Jul 2026 01:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785201015; cv=none; b=kbIASHCDz5Mir3VkC6TSWP/LE5Ql4Gdg2U2YYnuPBwCnggkdsB6eQtoydN6jdzM9rQUUcZSIEqG+W6C4GfWLFjOhui+qONbW0UTR1lxnVWdrEElITTUBwpqG3Xnylu3tU5gZQ6kQHlrJREAvoQmq70aHSq4qfTkPU3jVQy8bKg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785201015; c=relaxed/simple;
	bh=nVEBoKzfUyPm8tHtO7Jjox76meTF4JrHJKZpDSHPWkM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BCjHgGh0hTDzOmwdon4KzohT5PBnhwRC/9sron9XcwsUND6qz3I+IYTNicyUOURlvQhxu0Q3GdH7t/w2KpiUS/LubYSYxJE9T/MCmIXb0M7RE7Tznk/FvEXdk6qz4vxCySvV6xWxWNR4BtnTXNwyrKtkNl6hGhHwWPHRmoKYeqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F1fc74TA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F1fc74TA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD29B1F000E9;
	Tue, 28 Jul 2026 01:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785201013;
	bh=493ZPMKc7CVoQ5vLmzCynAdIb8jssCGmTqekQLIOUmc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=F1fc74TAXXucSCsrm/m3/uM6tXC+diNSMFCDJ3lgUnr2j1P+hr2E3OmAcq5DoLgIi
	 DrX5ZQZt4rBjDrC9s4p21FE9W0DOrD1eZ4hIvOH8z7ay9HbbnA/3QanVdrE9ITOtlm
	 xZtKVeJA15ayrX9AJ1i9O19Y/Va6CWRC+d24B5zOyoMfbJpf/Dt2FTiCNIKbdQe9Vl
	 nE4KiVfrnUx++ERbiTWZBKlTaU2wDYoCHsKUiZHuXnf6UmvYwrZrY7KIFqvhfb0kMG
	 XBc6PpFtj5vhU5G1VrIs94qxCrbyvGglbY5CHj9Wt6G3SiEe5kPDTo7UNSiwJP/xNE
	 +HfU4Vtk3cFfg==
Date: Mon, 27 Jul 2026 18:10:12 -0700
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
Subject: Re: [PATCH v5 3/7] net: wwan: t9xx: Add control DMA interface
Message-ID: <20260727181012.69e06bf6@kernel.org>
In-Reply-To: <20260723-t9xx_driver_v1-v5-3-b27afb99ccbb@compal.com>
References: <20260723-t9xx_driver_v1-v5-0-b27afb99ccbb@compal.com>
	<20260723-t9xx_driver_v1-v5-3-b27afb99ccbb@compal.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 23 Jul 2026 16:34:28 +0800 Jack Wu via B4 Relay wrote:
> Cross Layer Direct Memory Access(CLDMA) is the hardware
> interface used by the control plane and designated to
> translate data between the host and the device. It supports
> 8 hardware queues for the device AP and modem respectively.

each commit has to build cleanly with W=1 C=1, please:

drivers/net/wwan/t9xx/pcie/mtk_cldma_drv_m9xx.c:34:22: warning: symbol 'mtk_cldma_regs_m9xx' was not declared. Should it be static?
drivers/net/wwan/t9xx/pcie/mtk_cldma_drv_m9xx.c:167:22: warning: symbol 'cldma_drv_ops_m9xx' was not declared. Should it be static?
-- 
pw-bot: cr
