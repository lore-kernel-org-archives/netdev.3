Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D476323BD17;
	Mon, 27 Jul 2026 22:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785193130; cv=none; b=nSP2If4u0ne23sselOdHGDRfIAZHxqnH5i+8Vc8Ib6pUjyCbEApumxSYfLnJcK5J5LXfR0fkrTw+zXj8fm/K6M1kYzZnl0HEFB1vMC3hAVedoy50FiGBFq1Ls3iJAV42rxToQyswC4c09Lkg2OSyF4XZ7QDcg22wpJYwRVo6DSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785193130; c=relaxed/simple;
	bh=3ARINi7/8/8jq7By+QNG+0e1/qT1Qidv9621l7v3IGQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eUi6zzMfPm3CovyC84zmP+oXaFYapagkfSgT9SIkZeU0v/J/BMK1PG0m8bU9Wj8kkWiWt+CdcMNh221Hxo7v4WbgFYFQejNLnFGceoBiIFApeWEq6crjqp2i0ELDE52RPz19L/eXqvq/7aI6PD7IH5gvmEGq+nO7d/fbKSZuDSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a33mjbGp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a33mjbGp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 458861F000E9;
	Mon, 27 Jul 2026 22:58:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785193129;
	bh=QoM27bDr3vhO5Be7WeU/fTyHXRw3cVZ6el78HEIouw0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=a33mjbGp0+df3ExF1WLMlDZ+91dm7dWzNwUvDD/4X/wU0z25KJcefgybt48cOmXLA
	 SzX4pfKa26aXdpauNEH3+QjqnSCjCRd06xUIA1ILtftw3+oy2i0RvHuyUtp37wBqBF
	 WL+bNevAgtF8PP3xQlHeXGnqgYXhd1Xc9Wi0S8C8Xqc0D5XMnD7X++LVSB2BwZJ59t
	 prUxYdsRxWmGUATU9bwK76pLz4zjmRlVFIdl9A7hI09avbRhD+ki3chxbmiC40Ebie
	 NNKH6Xc2pAXuobQlJADaoyArZ6eRhG/2/rsQOxHxwfvU5lwNWoPP38rYbDouJf0ll3
	 IJ5X9gH6P5IRA==
Date: Mon, 27 Jul 2026 15:58:48 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jiawen Liu <1298662399@qq.com>
Cc: Jian Shen <shenjian15@huawei.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: hisilicon: hix5hd2_gmac: fix NAPI teardown order
Message-ID: <20260727155848.387245f6@kernel.org>
In-Reply-To: <tencent_3C891D50F517A212AE7EAA88051244B7C005@qq.com>
References: <tencent_3C891D50F517A212AE7EAA88051244B7C005@qq.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 26 Jul 2026 10:35:55 +0400 Jiawen Liu wrote:
> hix5hd2_dev_remove() deletes the NAPI instance before unregistering the
> netdev.
> 
> The netdev should be unregistered first so the networking core can stop the
> device while its NAPI instance is still present.  Delete the NAPI instance
> after unregister_netdev() has completed, matching the usual teardown order
> for drivers that call netif_napi_add() during probe.

Just delete that call. Unregistering deletes all the NAPIs
automatically. Also you're missing a Fixes tag
-- 
pw-bot: cr
