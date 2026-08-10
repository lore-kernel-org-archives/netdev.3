Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AE484457C1;
	Mon, 10 Aug 2026 21:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786398352; cv=none; b=nfjva1KvxOnIIxCqtyGosO6Yb32TqB6X9u7ZAU8BV54PN9Ab7qlclT7jfroKsMV9AK+ZSWzmVScDbv2cSKlXVIqfNvOBg2Pkx1XoL2DcNzIlasazWtwDgCwb5Ee9b/nUIn/+1bCxfFHTqizojGsfDCdCt/XAK3lxajkQc9Vl5+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786398352; c=relaxed/simple;
	bh=nudbu+wRR5RE3tRW87s86XZDj7jpvb3brh9I34iDiK0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CRrnaa3c7okvwblgJOHoNfhKJX6j/o9TpwzZpXkwZMLzpi+HBRqVYJbbYSUUXgEibikZDbj7OzdjLNDl+vrCK4gPud/OFWkrG9WFPqpPIE9/W8EMwqmQt/RMmSH0CgoYrrLT0eAJ1ibwb7vS9ufhREFbs48+0A43ltkBcQ8DEDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m5nTxSa4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m5nTxSa4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F085F1F000E9;
	Mon, 10 Aug 2026 21:45:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786398348;
	bh=iew1hHdrAv0NVNcfDkSf3bRYe/H1tVF34mVfLlcGEyw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=m5nTxSa4vaLyoDotBhx+pbUWWQUjIWIijyvpikym8cRb7mtNFe4W8a3ZRORQ+tx7T
	 LxzPsCMrMK2Pi+djjuBkpnVr/7QilqBCl3mPIr9/znNFmdXTBz1LhpgOkpRSUmByj9
	 9oBrGZC/X59iFw+0AolJ8N4+vuolVW6C25bPVZCG8DfIxBBchgM9UHxOoF/B04qPbU
	 l6W4bt+qNjmOjuH8cR7xhyFaJELuewhKgnrzc+mZTC8uU6LyDs0e6fuF8S/r8DS/3T
	 ASyskw1gXTwPPQ7LC21LCnPr1OzQvxd6xJvjht7dqsvyHV5hyVU0KUJrUqHPs4421e
	 msQlC51W+zrAg==
Date: Mon, 10 Aug 2026 14:45:47 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Pei Xiao <xiaopei01@kylinos.cn>
Cc: chris.snook@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: atheros: atl1: Fix use-after-free in atl1_remove
 due to race condition
Message-ID: <20260810144547.3984dced@kernel.org>
In-Reply-To: <59fa855b60e30eb37bb073b41fbde94b4c68901a.1785812450.git.xiaopei01@kylinos.cn>
References: <59fa855b60e30eb37bb073b41fbde94b4c68901a.1785812450.git.xiaopei01@kylinos.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  4 Aug 2026 11:02:20 +0800 Pei Xiao wrote:
> In atl1_probe, &adapter->reset_dev_task is bound with
> atl1_reset_dev_task, and &adapter->link_chg_task is bound with
> atlx_link_chg_task. atl1_intr (on PHY link down, DMA errors or link
> events) and atlx_tx_timeout can schedule these works on system_wq.

Same story, this can reportedly deadlock on NAPI handling
-- 
pw-bot: reject
