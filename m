Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D233F37269C;
	Tue,  3 Mar 2026 19:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772565417; cv=none; b=hI8cANAOMQX9hpDfCVM4jPPNQduWzILZJD131thE7BLrV9ECRoy37kzPX7DQjQmBpQD1Cn94wz4t8DqR5QMnExJcwrVvkML/i5Msu1td5CUEKjsE6lLYrBPp683Z3ilkwrqIuxOXRdBcGW+diMhlOIWyEsYUaRlZiNtKXI22b6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772565417; c=relaxed/simple;
	bh=UXxORbyDVlEpfwf9Ctr4f/7XNMWf+yV5VKuY6IgJjcE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NsYvOFauOimO7DPgICTmnNiIH1rV2RtjMNabCOzNr7BIFhdJ/oOPx6DWF6xQZ5Z2zz9LqLr3yksm4GN74/z7PN4KITFYdNW1oFLxPOU0YTQ4XJG2N7clYG6tH/BwKV8Mdg3Ezgdqtpx5FafnDwYl5y12IB9M0dEHAkZITJVxB2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=mYzraozC; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="mYzraozC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1772565413;
	bh=UXxORbyDVlEpfwf9Ctr4f/7XNMWf+yV5VKuY6IgJjcE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mYzraozCCVYDQmQPsdsuuZmGHqpe3XWp0Jk7Dn/Qvhv+zvudhpzXOWmi3DXJTZtj+
	 ZFp8wK/aTqTDJkOweTe0a4HfvKvV5jmnJBHMsPU0AgGwUvwMt4x8El9P04bpdm4QRb
	 NXO/xieu32PYpKNZv1BrVLKOTHoybRpSINMGUdTk=
Date: Tue, 3 Mar 2026 20:16:51 +0100
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Yury Norov <ynorov@nvidia.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Simon Horman <horms@kernel.org>, 
	Sunil Goutham <sgoutham@marvell.com>, Linu Cherian <lcherian@marvell.com>, 
	Geetha sowjanya <gakula@marvell.com>, Jerin Jacob <jerinj@marvell.com>, 
	Subbaraya Sundeep <sbhatta@marvell.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Christian Brauner <brauner@kernel.org>, 
	Yajun Deng <yajun.deng@linux.dev>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yury Norov <yury.norov@gmail.com>
Subject: Re: [PATCH 2/2] net-sysfs: switch xps_queue_show() to sysfs_emit()
Message-ID: <276dd7af-17cf-4310-b77b-edea398c8a0e@t-8ch.de>
References: <20260303185507.111841-1-ynorov@nvidia.com>
 <20260303185507.111841-3-ynorov@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260303185507.111841-3-ynorov@nvidia.com>

On 2026-03-03 13:55:06-0500, Yury Norov wrote:
> Switch the function to use the proper sysfs_emit("%pb").
> 
> Suggested-by: Thomas Weißschuh <linux@weissschuh.net>
> Signed-off-by: Yury Norov <ynorov@nvidia.com>

Reviewed-by: Thomas Weißschuh <linux@weissschuh.net>

> ---
>  net/core/net-sysfs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/core/net-sysfs.c b/net/core/net-sysfs.c
> index 07624b682b08..a260f8b4d5c6 100644
> --- a/net/core/net-sysfs.c
> +++ b/net/core/net-sysfs.c
> @@ -1754,7 +1754,7 @@ static ssize_t xps_queue_show(struct net_device *dev, unsigned int index,
>  out_no_maps:
>  	rcu_read_unlock();
>  
> -	len = bitmap_print_to_pagebuf(false, buf, mask, nr_ids);
> +	len = sysfs_emit(buf, "%*pb\n", nr_ids, mask);
>  	bitmap_free(mask);
>  
>  	return len < PAGE_SIZE ? len : -EINVAL;
