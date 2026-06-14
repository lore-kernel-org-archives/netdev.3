Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CC9E2264C7;
	Sun, 14 Jun 2026 00:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781397021; cv=none; b=YzRBIe1aL6dLHbco4iPTaOgbQOuTyjUTVxPji1xfmj4gzeGYjJQsz+50Pqyfks0eMWqI/YiqwVsCivWun/T+M8UcxH/TTsmzl4CLtjqkwe6eHbS25IgTgwshr/RqMVRsAmM2IiwcHE9keCSRDjQY+iIyDB7HqH2YBbTz/5YVf5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781397021; c=relaxed/simple;
	bh=0L0Zy3ZnKFfqwXJgmHweu/NlR3Tv8hruLpIGR5oggfI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FNX9GicckcM/HqVP1NL8Lp5ftYvrd6z58nxz16a4kOL8bnVbbIg1Ob1mmZu6zjpVMdjId7cgi96CNyCe9n2iFGW+gPW5Dz06GBMQCoE4yr0vo4O0KP+h7ZASq45sB/BSg3srYYDOonsLudingHYhIfmXA9KV2G0Vk3b31BUzkQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EcBer6RI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EcBer6RI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 366EF1F000E9;
	Sun, 14 Jun 2026 00:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781397020;
	bh=ZMdBuFq+Egdpf4xXaVRlDiUSnmhKuXX5amo2pNZUkl4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=EcBer6RItrC/+oVd2Kax1LWzKvX0vH4X3tM0z0tnln1N3DLGFMKoWYR6a5/toDx7j
	 PqKUHlaRmKC3H77fwIQP9zSaaEPkocTEk3DZ9UijYzkkAwXcBGnfUtGGwJUwOZ9+gn
	 xwXGnxn4mOjkl0tQSvMh/hq5KSBweQvHmb1yp8NYS/fH1dz5Xsv6uHoERtHmIyb5h5
	 N+/aB/ElIyEUZJTpIObPWuYDZFpX71nofGT0gt94yJ67TueuTj8CIKoqptC96vuEE2
	 wUEZ9ktrZLSvyERFy8Yo6O1DI85bWRaLfmtVQvmmwUazcxAnZCJzCovLrJV/tKnPSi
	 XuVbHfaK/B/3w==
Date: Sat, 13 Jun 2026 17:30:18 -0700
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
 <skhan@linuxfoundation.org>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v2 3/7] net: wwan: t9xx: Add control DMA interface
Message-ID: <20260613173018.7a0581f1@kernel.org>
In-Reply-To: <20260610-t9xx_driver_v1-v2-3-c65addf23b3f@compal.com>
References: <20260610-t9xx_driver_v1-v2-0-c65addf23b3f@compal.com>
	<20260610-t9xx_driver_v1-v2-3-c65addf23b3f@compal.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 10 Jun 2026 18:41:06 +0800 Jack Wu via B4 Relay wrote:
> From: Jack Wu <jackbb_wu@compal.com>
> 
> Cross Layer Direct Memory Access(CLDMA) is the hardware
> interface used by the control plane and designated to
> translate data between the host and the device. It supports
> 8 hardware queues for the device AP and modem respectively.

Transient build warnings:

+../drivers/net/wwan/t9xx/pcie/mtk_pci_drv_m9xx.c:52:30: warning: symbol 'mtk_dev_cfg_0900' was not declared. Should it be static?
+../drivers/net/wwan/t9xx/pcie/mtk_ctrl_cfg_m9xx.c:19:22: warning: symbol 'mtk_ctrl_info_m9xx' was not declared. Should it be static?
+../drivers/net/wwan/t9xx/pcie/mtk_cldma_drv_m9xx.c:33:22: warning: symbol 'mtk_cldma_regs_m9xx' was not declared. Should it be static?
+../drivers/net/wwan/t9xx/pcie/mtk_cldma_drv_m9xx.c:166:22: warning: symbol 'cldma_drv_ops_m9xx' was not declared. Should it be static?

please also see all the AI code comments at:
https://sashiko.dev/#/patchset/20260610-t9xx_driver_v1-v2-3-c65addf23b3f@compal.com
-- 
pw-bot: cr
