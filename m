Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 811033B7767;
	Tue, 31 Mar 2026 07:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774940858; cv=none; b=er5lyhl6imdFOzSw8+756AQ3EvL8LOMtMSoFymWjQ0HojjdyIkZotP8HY7+HLDVy/bgfK6hVN7meUgYR539nEP7NrX5emWkGkmJIyJYW1wQ4wgZY6G/j06T7A9dO/f//6oKrY/oZJ/N2szUqfcwtLNEtB1y4c9cYoi1V3qRVlDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774940858; c=relaxed/simple;
	bh=ImrAQQFn2ryacOR1iEULXCy+24ZgOpPd07z9qDw87gE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lfn0zLF7tGG7vRVjZ5i9uMXa/rGdoSnYEqLy68gJoYTggaWZRnhxv1zqun96VoCWgRwn7IhboCYV6Nz/ZJ2vkfoYWI0Db5BIp59hX+zdQnX1MC3QvvcSRZXjU88ChF6XJt/2eKjRLD4vyOOgqD6xw3sbHVF8ngfSb/gODngkG0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=e78PWvsY; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="e78PWvsY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1774940849;
	bh=ImrAQQFn2ryacOR1iEULXCy+24ZgOpPd07z9qDw87gE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e78PWvsYhIdTaLUSJtSxm7pavwPEUD53h62CbWKF8JJyYa3Gg6V1du0zO9VEhjwOT
	 b9giEqwJPaPMBNyazZPhI2b5+fHeiQRdDKwToRaa9bF0DmEnX5gYvsCaHxweGhaYxy
	 O7sOFRAf+CJ5zbcweLQS87EicNNCyCcyV2cvo9Y0=
Date: Tue, 31 Mar 2026 09:07:28 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Konstantin Khorenko <khorenko@virtuozzo.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, arnd@arndb.de, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] net: fix skb_ext_total_length() BUILD_BUG_ON with
 CONFIG_GCOV_PROFILE_ALL
Message-ID: <e478333d-2966-48a4-980e-badaa02bcb6b@t-8ch.de>
References: <20260330135337.937540-1-khorenko@virtuozzo.com>
 <20260330135337.937540-2-khorenko@virtuozzo.com>
 <9e6d5484-3670-40fa-8c09-201b76cd0088@t-8ch.de>
 <d4305d64-2632-4714-8291-d948c515c34d@virtuozzo.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d4305d64-2632-4714-8291-d948c515c34d@virtuozzo.com>

On 2026-03-30 19:23:01+0200, Konstantin Khorenko wrote:

(...)

> Thus we can probably use this hack and create the following patch instead:
> 
> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index 0e217041958a..47c7f0ab6e84 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -5145,7 +5145,7 @@ static const u8 skb_ext_type_len[] = {
>  #endif
>  };
> 
> -static __always_inline unsigned int skb_ext_total_length(void)
> +static __always_inline __no_profile unsigned int skb_ext_total_length(void)
>  {
>         unsigned int l = SKB_EXT_CHUNKSIZEOF(struct skb_ext);
>         int i;
> @@ -5159,9 +5159,7 @@ static __always_inline unsigned int skb_ext_total_length(void)
>  static void skb_extensions_init(void)
>  {
>         BUILD_BUG_ON(SKB_EXT_NUM > 8);
> -#if !IS_ENABLED(CONFIG_KCOV_INSTRUMENT_ALL)
>         BUILD_BUG_ON(skb_ext_total_length() > 255);
> -#endif
> 
>         skbuff_ext_cache = kmem_cache_create("skbuff_ext_cache",
>                                              SKB_EXT_ALIGN_VALUE * skb_ext_total_length(),
> 
> 
> Tomas, do you want me to send the v2 patch with that solution?

Yeah, I think this should have been the correct solution from beginning.
If you send this patch feel free to add my Reviewed-by.


Thomas
