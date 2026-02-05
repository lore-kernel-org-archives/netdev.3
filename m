Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA35F29DB8F;
	Thu,  5 Feb 2026 05:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770268090; cv=none; b=jgjgVf11TzECCzcTsKviukmAfCShDkBKSTForU0+kFiWJxpKHjpP5IZzaWadgKTNPbAkQ7RtnDJo6xqOuuEGBY6oHJBJ5KcLOul3WzIrv3x7rrooiHf5Jszn+p7Ri70unfQBWXGRd+Cqs52WpjYTpriY5C5YBt5hSppQ10nW03E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770268090; c=relaxed/simple;
	bh=O+iJ1V2YqJOaU1IvKchZMyjR8w/3OwWdvGA4b2nG988=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OJx/cRVHGLZG/VfFAOHDDUxkY2iQEyo615C2F3rsCG+Oqey5yvoKLWr6c5I+i/yDR5E5u48C6IDQfWOiEHM3pZjFcHTFKu5dGvZcxQS6/V3KA6X37mQolrFxqE+V6km9rBND3phA5yjM+AlkpgSJ+MUHs+7UuttC0O32IOk2yb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EV/pSR8H; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EV/pSR8H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D32F9C4CEF7;
	Thu,  5 Feb 2026 05:08:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770268090;
	bh=O+iJ1V2YqJOaU1IvKchZMyjR8w/3OwWdvGA4b2nG988=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EV/pSR8HUKAhrWo3tvbbvVz8Sz9uPla6R4axYd9ImHLQsjQ+alrsj83nThPgCW5zQ
	 yhX/d6Jn6pGHU+tgoosvQtgNA8hPHLPdDPX+onGYgDo/THqMaOXuYuR7MFquAr9aST
	 HQFOe2QU1a3mfTWE0/QZCiLcq/EQ95Tb2PEJyq62fiihhA+N+BE45O8LiwaIf4BinZ
	 FOwBHR847A3ZxdAU/LkRQXMKZE2nHsk2FjWkWqaW8VOW8WxAOQ3ujbx10lqKKUQDtk
	 EFgef6/KyICMYqOla9ZnTekfh3zbtVGR19hPIkTxp0RIB+4nqDNG6ZX0ShoLsw16Sw
	 ji5aQ/24tpjVg==
From: Jakub Kicinski <kuba@kernel.org>
To: arnd@kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	jeff@garzik.org,
	bhelgaas@google.com,
	davem@davemloft.net,
	tglx@kernel.org,
	lukas@wunner.de,
	linux-kernel@vger.kernel.org,
	andrew+netdev@lunn.ch,
	giovanni.cabiddu@intel.com,
	netdev@vger.kernel.org,
	gallatin@myri.com,
	arnd@arndb.de,
	brice@myri.com,
	mingo@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com
Subject: Re: [2/2,v3] myri10ge: avoid uninitialized variable use
Date: Wed,  4 Feb 2026 20:57:43 -0800
Message-ID: <20260205045743.2412516-1-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260203230501.832872-2-arnd@kernel.org>
References: <20260203230501.832872-2-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
myri10ge: avoid uninitialized variable use

This patch fixes uninitialized variable warnings found by gcc-10 on s390
by initializing cmd.data0, cmd.data1, and cmd.data2 before calls to
myri10ge_send_cmd() across multiple functions.

> diff --git a/drivers/net/ethernet/myricom/myri10ge/myri10ge.c b/drivers/net/ethernet/myricom/myri10ge/myri10ge.c
> --- a/drivers/net/ethernet/myricom/myri10ge/myri10ge.c
> +++ b/drivers/net/ethernet/myricom/myri10ge/myri10ge.c

[ ... ]

> @@ -2238,6 +2250,8 @@ static int myri10ge_get_txrx(struct myri10ge_priv *mgp, int slice)
>  	status = 0;
>  	if (slice == 0 || (mgp->dev->real_num_tx_queues > 1)) {
>  		cmd.data0 = slice;
> +		cmd.data1 = 0;
> +		cmd.data2 = 0;
>  		status = myri10ge_send_cmd(mgp, MXGEFW_CMD_GET_SEND_OFFSET,
>  					   &cmd, 0);
>  		ss->tx.lanai = (struct mcp_kreq_ether_send __iomem *)
>  			    (mgp->sram + cmd.data0);
>  	}
>  	cmd.data0 = slice;
>  	status |= myri10ge_send_cmd(mgp, MXGEFW_CMD_GET_SMALL_RX_OFFSET,
>  				    &cmd, 0);

The initialization of cmd.data1 and cmd.data2 is inside the conditional
block. When slice > 0 and real_num_tx_queues <= 1, does the subsequent
myri10ge_send_cmd() call for MXGEFW_CMD_GET_SMALL_RX_OFFSET use
uninitialized data1/data2 values?

Simon Horman pointed this out in his review of v2:
https://lore.kernel.org/all/20250622162715.GA297140@horms.kernel.org/

He provided a diff showing that the second cmd.data0 = slice assignment
also needs cmd.data1 and cmd.data2 initialization. This feedback does
not appear to have been addressed in v3.
-- 
pw-bot: cr
