Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A580B48A2DC;
	Wed,  1 Jul 2026 13:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782911720; cv=none; b=YcSqLp1sA8jmU3PsZ1T3+XqpGrKeuW01Bv67jbmj/6ARY5DS5YN9fVamg/KkP2u+lFk6D5y0F6HkHcLj/OTUQpH3fELm9oiPXxRe3f4XT6fGHRJz6scXBETmIVXcYjOyJ1/Eqo9Z6yzbm31bvZKbQ5sapUksRd4HOTOpbspW/ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782911720; c=relaxed/simple;
	bh=d4WACMk98/bvJWsQOJhx8TBnoSsVXkTaRk/wfSQfEZ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=twe0p62Gb0/wl3u+dREOmeH5xo6FJGC7Xbdidprza4hIpMAUgeWwKo2fo2Gq95zptvjlUYQPzgDTUvFn372Xfr2X8fSXalmrBi4ODwaEUZ60lDdUjO+B1dUvtubfQjRxD87iy7s3KCLbj614wgoz5aoVX0Pinr2iPGWjs3b2KCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=FQ0iitez; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="FQ0iitez"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=HhDJMkw8yo1u/tJof60puNsToXcPHoUHIzSq0U0VloE=; b=FQ0iitez3dUJLaYI8OyknqZ6DV
	e1St5B3sW3QvdO9fKHxmL7dZg+IP0cSI2X91ValCLTGKYvG8xA7wEIDc6tTwT10Cf9vTJWMWKYLVf
	KayOovNyhAJsxe4DFdVaeKza4n/sVWMcG0l4BL6t4pYQKKfcMlVqzI+usrZQeZa7qZCeL53bJsfHB
	ZA8I/yIY8sb6Fm1PlecIzSZHLYo7RodkG2YZSUt6TpvQgey3M9xPofiNDXqlg3TUeGWwKpjPkQFQx
	ta82RT52FKbuoNsENOsBQXsJvkFNxGdNiQ2zpL/0sxCBwhmsyrkZq2E+YkJl563ITV3UGC2xVEmul
	w1LraPHA==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1weumQ-007rn4-1c;
	Wed, 01 Jul 2026 13:15:06 +0000
Date: Wed, 1 Jul 2026 06:15:01 -0700
From: Breno Leitao <leitao@debian.org>
To: Norbert Szetei <norbert@doyensec.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Qingfang Deng <qingfang.deng@linux.dev>, Taegu Ha <hataegu0826@gmail.com>, 
	Yue Haibing <yuehaibing@huawei.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Kees Cook <kees@kernel.org>, linux-ppp@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] ppp: defer channel free to an RCU grace period to
 fix pppol2tp RX UAF
Message-ID: <akUSFR-ih9U27fgr@gmail.com>
References: <C954A7EA-AA98-4E3C-80B5-42C34B3183A3@doyensec.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <C954A7EA-AA98-4E3C-80B5-42C34B3183A3@doyensec.com>
X-Debian-User: leitao

On Wed, Jul 01, 2026 at 02:14:39PM +0200, Norbert Szetei wrote:
> diff --git a/drivers/net/ppp/ppp_generic.c b/drivers/net/ppp/ppp_generic.c
> index 57c68efa5ff8..cb8fe37170d3 100644
> --- a/drivers/net/ppp/ppp_generic.c
> +++ b/drivers/net/ppp/ppp_generic.c
> @@ -184,6 +184,7 @@ struct channel {
>  	struct list_head clist;		/* link in list of channels per unit */
>  	spinlock_t	upl;		/* protects `ppp' and 'bridge' */
>  	struct channel __rcu *bridge;	/* "bridged" ppp channel */
> +	struct rcu_head	rcu;		/* for RCU-deferred free of the channel */
>  #ifdef CONFIG_PPP_MULTILINK
>  	u8		avail;		/* flag used in multilink stuff */
>  	u8		had_frag;	/* >= 1 fragments have been sent */
> @@ -3583,7 +3584,7 @@ static void ppp_release_channel(struct channel *pch)
>  	}
>  	skb_queue_purge(&pch->file.xq);
>  	skb_queue_purge(&pch->file.rq);
> -	kfree(pch);
> +	kfree_rcu(pch, rcu);

Why not use kfree_rcu_mightsleep() instead? That would eliminate the need
for the additional `struct rcu_head rcu;` field.
