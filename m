Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C3D3A6EE0;
	Mon, 20 Apr 2026 17:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776706721; cv=none; b=AIxpxfgXRqH1uGSaZSCDdvlc0L2uI3P0r102Oue8pB9otBDKaJYf+PyzVcMidJ7+45hQ8pnUxORwzYKtuFLk7oiBqJbu+fPTMLXwUZavOcnpRughbqNOfrUUI0d2wgQqNu/rp8fUqfM+9E2E3noKIkmiY0asPCQDLlCHnle4tp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776706721; c=relaxed/simple;
	bh=+iB78qslZQP4oKGBKa7wsXpn6b10lPdY6xiEvvj/PCo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f3PcPSvcaP9G9VaKiOEGfnlxom3EteEhINKcasaT5emasNp7OEV/e+tcJT1XdY6R3jAgyTJCb23Uf9ve17CUwRQFQGNAWob0o2WoyQNaRk8xIQrEpm+CtnPNnl1rR7z6jngufxkrDKLdY9GejUprmKXudyskINR42+ZqYKYiT78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V9IKS28M; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V9IKS28M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13335C19425;
	Mon, 20 Apr 2026 17:38:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776706721;
	bh=+iB78qslZQP4oKGBKa7wsXpn6b10lPdY6xiEvvj/PCo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=V9IKS28Mw2SXSTNgDy8nd+cOvueV2R/S7qd1kXGd1ErYLFXplKR52uNI4//T1q+/m
	 +N+bIogJyqPauTrE2CZZQcUtwUJ3oZfBcqqTqPElqOwU2JVoeGkU6Ew5FwilhE4Bii
	 U0zL2Vt5KoU/wmMx+zskPt9kHT40JgbcDHGN6dPLQ5jJbiScDkMLKeE7/ScOITwGRy
	 YW5D01fgA4FZ2H2tI17rWG4l6ir1Qbc1y8xv5CQ6gGxTtWrxr6A5j5h0fUGAL487qq
	 oRHM3GS190Ps63nqZAq8FXV20EwWuiTMN/QLL/giXYNBSwhDt269m1BRZA9axCuS5E
	 tHGKHgGgqqMNA==
Date: Mon, 20 Apr 2026 10:38:40 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Agalakov Daniil <ade@amicon.ru>
Cc: Jian Shen <shenjian15@huawei.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <lvc-project@linuxtesting.org>, Roman Razov <rrv@amicon.ru>
Subject: Re: [PATCH net-next] net: hns: use u32 for register offset in RCB
 TX coalescing
Message-ID: <20260420103840.6a30683e@kernel.org>
In-Reply-To: <20260420144047.2846673-1-ade@amicon.ru>
References: <20260420144047.2846673-1-ade@amicon.ru>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 20 Apr 2026 17:40:19 +0300 Agalakov Daniil wrote:
> The local variable reg in hns_rcb_get_tx_coalesced_frames() and
> hns_rcb_set_tx_coalesced_frames() holds a register offset passed to
> dsaf_read_dev()/dsaf_write_dev(). Register offsets on this hardware
> are 32-bit values; using u64 was misleading.

net-next is closed during the merge window.

If you repost please improve the "why". As is I don't think this patch
is worth merging.
