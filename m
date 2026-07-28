Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2E9C223DCE;
	Tue, 28 Jul 2026 00:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785199064; cv=none; b=QjkNXovGUlBaL+ATGu87hBR2vBUce/MJRGrrrCQjEBw4KoOot55IbaTFXM6G6IFiSn8NC7Uk/RD5uy00EZuUIF0W7GOSMXYUq2+w4+wOkO71yBYUcjBcqC6lXyHB591nxtu1845UgkSIJuBWdAPKq1fTq+6EyBYyflLxmFVnuUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785199064; c=relaxed/simple;
	bh=uSzy5xFzv74Oktuq45/FOzv/uGKeDEnFiXt3gb4ZHzM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AraEIVZaTdVdHtjKJWObFzVBdOGuqUqd0QEfxfQ8B//vpCckd2J/hXCqcTFf7k1Sa0Yaur6YkuNMeGVLie7CIsFw+L1OzOYgmmrzkHzig7jdIcPKnodVc7/XEVH8iSdcT/WMfzlC2yk6Lj8lcUE154z16taktqzt6CRffqu9iHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QDn9STuf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QDn9STuf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E67AC1F000E9;
	Tue, 28 Jul 2026 00:37:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785199063;
	bh=lKKb7VfZJbLtj2rAMK2jN4Y0F3kXYnRQ9+Wtxnk5Rzw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=QDn9STufZ6eURf1azGajbOL1++q2i/aahiJUAA7P6t4Cg6WVNekxJbXWMRd/V6U8y
	 QGbpbgDeRCebzu2xkAkECxEUT+ZH7ZOaznc2BeMpHROvMwOhWlFnelXCVOSIxjj72h
	 cfja/w549S5dN5VmTq5HAtoMuvY61QGSthRus57NWqyQ9uErWgdtkDPp2rC5LJzIdl
	 lXstzed6Xnr5cjTHwqp38cB98Rrx6Xb6X98oRynlq6plhVJrrFtegsD33TaItKWm3u
	 DyhiN8z70OamifHdslpc4XotktuY9Srg+cBYJHpBpdUpACTEf8J7L/hYwTNKJMpa3A
	 21nuzvSMkdWsw==
Date: Mon, 27 Jul 2026 17:37:41 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Satish Kharat <satishkh@cisco.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Breno Leitao <leitao@debian.org>, Sesidhar Baddela <sebaddel@cisco.com>
Subject: Re: [PATCH net-next v12 01/12] enic: cancel tx_hang_reset work on
 device removal
Message-ID: <20260727173741.67147e9f@kernel.org>
In-Reply-To: <20260719-enic-sriov-v2-admin-channel-v2-v12-1-6ff2c617001d@cisco.com>
References: <20260719-enic-sriov-v2-admin-channel-v2-v12-0-6ff2c617001d@cisco.com>
	<20260719-enic-sriov-v2-admin-channel-v2-v12-1-6ff2c617001d@cisco.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 19 Jul 2026 01:41:45 -0700 Satish Kharat wrote:
> enic_remove() cancels the reset and change_mtu_work items but does not
> cancel tx_hang_reset.  A TX timeout that fires while the device is being
> removed can schedule enic_tx_hang_reset() so that it runs after
> free_netdev(), resulting in a use-after-free.
> 
> Cancel tx_hang_reset alongside the other work items before
> unregister_netdev().
> 
> This is a pre-existing issue, not introduced by the SR-IOV V2 series;
> it is included here as an independent fix.
> 
> Fixes: 937317c7c109 ("enic: do hang reset only in case of tx timeout")
> Signed-off-by: Satish Kharat <satishkh@cisco.com>

Since this is a fix it should go separately to the net tree.
If there is a conflict the net-next submission will have to wait for
the fix to propagate there.

> diff --git a/drivers/net/ethernet/cisco/enic/enic_main.c b/drivers/net/ethernet/cisco/enic/enic_main.c
> index e7125b818087..b65796d96efc 100644
> --- a/drivers/net/ethernet/cisco/enic/enic_main.c
> +++ b/drivers/net/ethernet/cisco/enic/enic_main.c
> @@ -3012,6 +3012,7 @@ static void enic_remove(struct pci_dev *pdev)
>  		struct enic *enic = netdev_priv(netdev);
>  
>  		cancel_work_sync(&enic->reset);
> +		cancel_work_sync(&enic->tx_hang_reset);

Is this enough? The work may get scheduled between the cancel and 
the unregister, right? disable_work_sync() is probably the answer.

>  		cancel_work_sync(&enic->change_mtu_work);
>  		unregister_netdev(netdev);
>  		enic_dev_deinit(enic);
-- 
pw-bot: cr
