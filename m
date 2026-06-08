Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46FED2BEC3F
	for <netdev@vger.kernel.org>; Mon,  8 Jun 2026 08:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780907426; cv=none; b=IYn/xmV4vgDbxxkQjRj3ndtbpXW6mTO1RJpMKPlN9RNDY2bQaB69H7nrShPECZ0vrT0+GN7yNGNY3ADXM+ajWz/w24Rmrmo/qa/mLXctiHh/fGS6uViV6/O5l4xW2e5glYkZVzrJFLTxJcRtRqrO592GvVW2vpwpBaFD8YPzoQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780907426; c=relaxed/simple;
	bh=uwHLugokt6wTViB6gk+QIYR6ZA3nKcU9v8GIUGnRLD8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:In-Reply-To:
	 Content-Type:References; b=KEblYiquOeQ2hBgb91IqQ/8yYIHE9T4RHTk+k6ZYYvWkn+mBGMyUxygR4+X2bzwDS1PjeQlUTTOT9B8af4QpSEuihrYqlv6XmawCuyiKbYasMLDM0gQoXhSBo8tJz3DyjKaK2LVU53tb65ySf24itVDIxcByWnvAmFp3Jy3UYUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=nx8PZRa5; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="nx8PZRa5"
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20260608083022euoutp01525ddcc6e279609b22baf615005d1bf0~3Dd15bJ_i3186431864euoutp01V
	for <netdev@vger.kernel.org>; Mon,  8 Jun 2026 08:30:22 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20260608083022euoutp01525ddcc6e279609b22baf615005d1bf0~3Dd15bJ_i3186431864euoutp01V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1780907422;
	bh=wjeEYiLODKr24D2k4QSbkK13mn3e3WvrB5HFWfCI+Mc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nx8PZRa5udYktTVgfsn5NFFHUa0anqP+Lf438B0SRyHqaNPT+Z2alvfxDANX0dPc4
	 iIIH5j6AoGsxoVmEIdBTv6bpZU5Ei5SWnwsvodFfB7wUEKenBlNrYeEghZv4RgVikX
	 OlBZ+D7+m31Xh2U2BVQgVxTGqGwDSGa1sPlW+V9w=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20260608083022eucas1p2ddbb690dd15bcc5297e83779ce13f694~3Dd1itoi62513225132eucas1p2F;
	Mon,  8 Jun 2026 08:30:22 +0000 (GMT)
Received: from AMDC4622.eu.corp.samsungelectronics.net (unknown
	[106.120.77.34]) by eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20260608083019eusmtip256610289b9ea9aea5e3d3d6b518c3b1e~3Ddywy60Q1379413794eusmtip2V;
	Mon,  8 Jun 2026 08:30:18 +0000 (GMT)
Date: Mon, 8 Jun 2026 10:30:18 +0200
From: Jakub Raczynski <j.raczynski@samsung.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Larysa Zaremba <larysa.zaremba@intel.com>, netdev@vger.kernel.org,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
	linux-kernel@vger.kernel.org, k.domagalski@samsung.com,
	k.tegowski@samsung.com, cs0617.lee@samsung.com
Subject: Re: [PATCH net-next v2 1/3] net/stmmac/dwxgmac: Modify DMA
 functions for future hardware
Message-ID: <aiZ9milz2xnxYBHM@AMDC4622.eu.corp.samsungelectronics.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260605190210.13d9b18c@kernel.org>
X-CMS-MailID: 20260608083022eucas1p2ddbb690dd15bcc5297e83779ce13f694
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----FoLMw5K6Fe9t5vMBf.HRV6LBdzA_42JMttv_zc4dtfIAKr8-=_10f6c_"
X-RootMTR: 20260601162618eucas1p1fb6e7ed11e0a77e709bca37cbc7e4f28
X-EPHeader: CA
X-CMS-RootMailID: 20260601162618eucas1p1fb6e7ed11e0a77e709bca37cbc7e4f28
References: <20260601162537.553512-1-j.raczynski@samsung.com>
	<CGME20260601162618eucas1p1fb6e7ed11e0a77e709bca37cbc7e4f28@eucas1p1.samsung.com>
	<20260601162537.553512-2-j.raczynski@samsung.com>
	<aiAULX7SlidVGmhq@AMDC4622.eu.corp.samsungelectronics.net>
	<aiAiAbasQA3B3aT_@soc-5CG4396X81.clients.intel.com>
	<20260605190210.13d9b18c@kernel.org>

------FoLMw5K6Fe9t5vMBf.HRV6LBdzA_42JMttv_zc4dtfIAKr8-=_10f6c_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

On Fri, Jun 05, 2026 at 07:02:10PM -0700, Jakub Kicinski wrote:
> 
> +1, this feels a bit sloppy. The driver has some painful abstraction
> layers but if we cut ourselves some slack because of that that'd be
> basically encouraging shitty architectures.
> -- 
> pw-bot: cr
> 

Alright, will think about it.
As said in commit, problem is that current code really does assume
number of DMA=MTL=TC's and uses it interchangeably. So that was quite minimal
setup to get this stuff to work.
This is not longer true though for new hardware.
XGMAC 3.20a and 3.40a are fully compatible with dwxgmac2 as far as
I can tell, so new HW is generally supported with generic xgmac driver,
only some features are extra. And since there is no free space in some
registers, it should continue being that way.

Probably better solution would be to not change these functions to return
something, but rather check this in upper layer using synopsys_id or
whatever version. Will see what is more feasible.

BR
Jakub Raczynski

------FoLMw5K6Fe9t5vMBf.HRV6LBdzA_42JMttv_zc4dtfIAKr8-=_10f6c_
Content-Type: text/plain; charset="utf-8"


------FoLMw5K6Fe9t5vMBf.HRV6LBdzA_42JMttv_zc4dtfIAKr8-=_10f6c_--
