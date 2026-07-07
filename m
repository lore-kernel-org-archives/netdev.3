Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0741047F2FB
	for <netdev@vger.kernel.org>; Tue,  7 Jul 2026 21:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783460743; cv=none; b=n3XjQtAEH/q+nTiWP3mIU+glgBkcqVfr91nNmO0fN8owbYRRG8kIYQf3ZL4c//muEwS3yf8AalF4QJMyavv/oKcixpWyqcN75q3HB2srAW7wloJ358AgeMzKltTgVPQkSkRnNgSQJCGXYdns8GsgEJwTkTOeyLJymopjsbJhzNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783460743; c=relaxed/simple;
	bh=uxlarWoZJRMoaFl5LzOGETwdh8dbdjkRxQ56mGu427k=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:In-Reply-To:
	 Content-Type:References; b=fOH+ClRGQcHo4iQ8gjPwSxuKt3QcgY+nsMlOO9NO5TZyO5oW1+EpW22lCPiNBOSdphv5Wy5Vx/luS5g9tdslwMq6PCr5W7ikssGueUy0IUFY626xmzMAa/4PIhZRBU4wyRKZnwSsm/4wVoOBbxZxPjh8MBsplgQpelCEcH1/LEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=J5Ql4lP1; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="J5Ql4lP1"
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20260707214540euoutp013a73bd6e533971feef0140281426ec80~AIBgXrGhz0751007510euoutp01C
	for <netdev@vger.kernel.org>; Tue,  7 Jul 2026 21:45:40 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20260707214540euoutp013a73bd6e533971feef0140281426ec80~AIBgXrGhz0751007510euoutp01C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1783460740;
	bh=64yZTokUOKWEi1l5XEMnLoTKVKqtdorCaDPLUUg5R/0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=J5Ql4lP1oiFXtQYiTzFXBmfxUjrzpzyZIpRJNeQHBONwrncCno0MOBr6cc0EmYxlu
	 qF5E54SFmmGhCpalWIiWVKmoAGz/OtSGDc+SJJDY3j4GJwLNwxWljxwjafpp1QFsxE
	 4Fs1fvxkC4wf13bezU9LBhFtgTzqgDUb5ayosdMk=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20260707214538eucas1p2b46a6831dbed600dab30756a0078711f~AIBeoMkm10868008680eucas1p29;
	Tue,  7 Jul 2026 21:45:38 +0000 (GMT)
Received: from AMDC4622.eu.corp.samsungelectronics.net (unknown
	[106.120.77.34]) by eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20260707214537eusmtip272eee7641a70a5f1694e39ef6326faf4~AIBd7L2FY0322003220eusmtip2Y;
	Tue,  7 Jul 2026 21:45:37 +0000 (GMT)
Date: Tue, 7 Jul 2026 23:45:34 +0200
From: Jakub Raczynski <j.raczynski@samsung.com>
To: Stefan Agner <stefan@agner.ch>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "Russell King
 (Oracle)" <rmk+kernel@armlinux.org.uk>, Maxime Chevallier
	<maxime.chevallier@bootlin.com>, Ovidiu Panait
	<ovidiu.panait.rb@renesas.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>, netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, regressions@lists.linux.dev
Subject: Re: [PATCH net v2] net: stmmac: resume PHY before hardware setup
 when opening the interface
Message-ID: <ak1zfkNN4akdKrRQ@AMDC4622.eu.corp.samsungelectronics.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ak1rseUKTWFKzBib@AMDC4622.eu.corp.samsungelectronics.net>
X-CMS-MailID: 20260707214538eucas1p2b46a6831dbed600dab30756a0078711f
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----086pkQbFtnoS7HLFmBecfPu9Cf9WQCmSNse4hrMKP7AYRkCa=_12ee25_"
X-RootMTR: 20260707211350eucas1p2c7d585a2f5cdcfdc3f1d9f7bcb1759e1
X-EPHeader: CA
X-CMS-RootMailID: 20260707211350eucas1p2c7d585a2f5cdcfdc3f1d9f7bcb1759e1
References: <message-id-of-your-v1-mail>
	<20260707195425.405989-1-stefan@agner.ch>
	<CGME20260707211350eucas1p2c7d585a2f5cdcfdc3f1d9f7bcb1759e1@eucas1p2.samsung.com>
	<ak1rseUKTWFKzBib@AMDC4622.eu.corp.samsungelectronics.net>

------086pkQbFtnoS7HLFmBecfPu9Cf9WQCmSNse4hrMKP7AYRkCa=_12ee25_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

On Tue, Jul 07, 2026 at 11:13:46PM +0200, Jakub Raczynski wrote:
> - This change is actually broken - in previous patch rtnl_lock() was asserted
>   by dev_ioctl(), but in this version it is not asserted anywhere and will
>   trigger WARN_ONCE().

Ok, as I looked again, I am wrong again, ndo_open() does hold rtnl_lock
already. So from this point it is good. Relocking would create deadlock,
so I take that part of comment back.

BR
Jakub Raczynski

------086pkQbFtnoS7HLFmBecfPu9Cf9WQCmSNse4hrMKP7AYRkCa=_12ee25_
Content-Type: text/plain; charset="utf-8"


------086pkQbFtnoS7HLFmBecfPu9Cf9WQCmSNse4hrMKP7AYRkCa=_12ee25_--
