Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 357E317C211
	for <netdev@vger.kernel.org>; Tue, 28 Jul 2026 00:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785200002; cv=none; b=dUMfzqqR4IEFrhsPR+GtkvcsMUmRh/y8mBOJYsdnEn4oMvNMV5HfrfeOWpn2/SuQ2K1I8AfEg0pG6Z/9LSOTqDJQSeA0NgJGs6g8qe8XBFbUp7C46/1J01YzVNxUaWj61Gd4GgWswoQoUkBdq3Jt09JixVosaclUNU07tgSC+TA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785200002; c=relaxed/simple;
	bh=Id/E25Gk232lnfenBZM3BGgzILrnZQ0CvF2I6c8w2Gg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aNTu9+etVUqey7msLLEx8TsdGalMIAuUUaYdi8d3xxrpKuXDEvD5561PAvDyaWcggp2Icgxr0lO9OYoqhmz6GUs28MegE2/sZsQhqMy4sa0mcPAJdyyeZ2sXUx1XAEWrqApvEOti8cOlqhg/6imwydrpksVQX8VKqZ7ibrKKbMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gMF0ozLg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gMF0ozLg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19BF01F000E9;
	Tue, 28 Jul 2026 00:53:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785200000;
	bh=v7GXU+58Fudh3sWhmJjPf7rh359o2P/xpjRbIPs0NeQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=gMF0ozLg7Q6ZdJC+XoAHSG4TYH25hJE1idUuvKnp24e1q6Gz1Cmk1UuogFE1tZbc6
	 mCE7lmWYFiR7A8LuT15MGITXQQO/OgVP1+IN/a56dqc+eZqlrYEwEE34hsY3ViczRV
	 0Sh9XwF7JgTVDM9AqX6ObDQ9UFkL3Kpc/9r9gR/6aZTcg2Qc+6jrM8Zpwp4uXN+3B6
	 d+B3bJgiuR0B0+bjNSg7witMzvgeJyo4uW3e2mq+RYKa5mKZUO5K3v1kmreECkhzj0
	 e1S9PFdvTUIRNjUMwQrjsgdyI1WJeDftB5YZtvHHVWklCfKH2OLNF/ciHdXVP8CF5z
	 VF6YfkGCzB9dA==
Date: Mon, 27 Jul 2026 17:53:19 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Chenguang Zhao <chenguang.zhao@linux.dev>
Cc: rain.1986.08.12@gmail.com, zyjzyj2000@gmail.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 netdev@vger.kernel.org, Chenguang Zhao <zhaochenguang@kylinos.cn>
Subject: Re: [PATCH net] forcedeth: fix UAF of txrx_stats in nv_remove
Message-ID: <20260727175319.2cc087c4@kernel.org>
In-Reply-To: <20260723092637.2135095-1-chenguang.zhao@linux.dev>
References: <20260723092637.2135095-1-chenguang.zhao@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 23 Jul 2026 17:26:37 +0800 Chenguang Zhao wrote:
> From: Chenguang Zhao <zhaochenguang@kylinos.cn>
> 
> nv_remove() frees the per-CPU txrx_stats before unregister_netdev().
> Until unregister completes, ndo_get_stats64, the NAPI/xmit data path,
> and nv_close()/drain may still access txrx_stats, leading to a
> use-after-free.
> 
> Free the stats only after unregister_netdev().
> 
> Fixes: f4b633b911fd ("forcedeth: use per cpu to collect xmit/recv statistics")
> Signed-off-by: Chenguang Zhao <zhaochenguang@kylinos.cn>
> ---
>  drivers/net/ethernet/nvidia/forcedeth.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/nvidia/forcedeth.c b/drivers/net/ethernet/nvidia/forcedeth.c
> index 5b0435d7bc39..106885bd0f6b 100644
> --- a/drivers/net/ethernet/nvidia/forcedeth.c
> +++ b/drivers/net/ethernet/nvidia/forcedeth.c
> @@ -6187,9 +6187,11 @@ static void nv_remove(struct pci_dev *pci_dev)
>  	struct net_device *dev = pci_get_drvdata(pci_dev);
>  	struct fe_priv *np = netdev_priv(dev);
>  
> -	free_percpu(np->txrx_stats);
> -
> +	/* txrx_stats is used by ndo_get_stats64 and the data path until
> +	 * unregister_netdevice() has completed.
> +	 */

Applied, but without this stupid comment and preserving the original
spacing.

>  	unregister_netdev(dev);
> +	free_percpu(np->txrx_stats);
>  
>  	nv_restore_mac_addr(pci_dev);
>  

