Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3FA0489875
	for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 09:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785488490; cv=none; b=j0sngVBqoUfHjq+M8W1rE/bSlGHea8TFrDfn/g5MsCsWJ4Ijq7nO1lK9bFQCrtYYrg2nzAtPS/4aW8r8Ox6Bxg/xJWEbCpvCiCZ4RQniu++DEige7UOpjegCvMoT7v7QRnBcDcplXvJybijQjdl63bsZbL0ksqTavVqMX+Q/ZrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785488490; c=relaxed/simple;
	bh=0VrUY+gEnLtmGw+1gj7YQuosVWmN/YPI9qdIPQID/vo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fh6x6rzxflN5ZhHV2vaIGB47Eh7yiMg4x9dgnGmb9T7uZLzP4v0tF7KWeRX+lUGdP5hoQ9Da/9EB6aDbeTBNqdwi0GUJ6CC2TilUcjM73/0JhKKb/CncqSn1tOBkCHcL7Z1EohWjhrOtjcxdLDsgf93DV44ikons2eMevpfRqYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=JcwUt14+; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="JcwUt14+"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=wafImtkEyd9MI5nNFWdF9f9ypA+3yvesyjLi7gMe+4Y=; b=JcwUt14+2+CeuYXrfh0EAV/2BH
	bB87h4St5NtmAvOC6BhD0emfgqGuKmtLO67gvJFJn2gLCp892i2TgishKKuOpd1fmtp7QBnk2LVxc
	mV2zo++9BdXtQ7DU41DBYVmepYVKXD6V7Iv9uv/EI5IDMwYcpICPZcyWCGQhTg1eoUvEmuJouq/sS
	2VUMR4y3vKxi8h2k1bCom0nIq0UagLENpFwAIgYjC4hjU1Zf3yI36WS7xiDc9ay14IjSCh2dC/ejo
	112PRO5vn+CHbTMDWqPZ17T4MPwvXaOUlZ4c5yP+9lytxNB9tWeSAlmPmezn5gilIhEM2tEvodCYR
	F91/j0eA==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wpj7K-009toS-2A;
	Fri, 31 Jul 2026 09:01:22 +0000
Date: Fri, 31 Jul 2026 02:01:15 -0700
From: Breno Leitao <leitao@debian.org>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: netdev@vger.kernel.org, Mengyuan Lou <mengyuanlou@net-swift.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>, 
	Russell King <linux@armlinux.org.uk>, Aleksandr Loktionov <aleksandr.loktionov@intel.com>, 
	Jacob Keller <jacob.e.keller@intel.com>, Simon Horman <horms@kernel.org>, Kees Cook <kees@kernel.org>, 
	Rongguang Wei <weirongguang@kylinos.cn>, 
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>, Joe Damato <joe@dama.to>, 
	Larysa Zaremba <larysa.zaremba@intel.com>, Chenguang Zhao <zhaochenguang@kylinos.cn>, 
	Fabio Baltieri <fabio.baltieri@gmail.com>
Subject: Re: [PATCH net-next v13 2/5] net: wangxun: add Tx timeout process
Message-ID: <amxjZX1eShpKD1V8@gmail.com>
References: <20260731061837.12672-1-jiawenwu@trustnetic.com>
 <20260731061837.12672-3-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260731061837.12672-3-jiawenwu@trustnetic.com>
X-Debian-User: leitao

On Fri, Jul 31, 2026 at 02:18:34PM +0800, Jiawen Wu wrote:
> @@ -1275,6 +1288,7 @@ enum wx_pf_flags {
>  	WX_FLAG_NEED_DO_RESET,
>  	WX_FLAG_RX_MERGE_ENABLED,
>  	WX_FLAG_TXHEAD_WB_ENABLED,
> +	WX_FLAG_NEED_PF_RESET,
>  	WX_PF_FLAGS_NBITS               /* must be last */
>  };

You need WX_FLAG_NEED_PF_RESET and also WX_FLAG_NEED_DO_RESET? isn't one
of them enough?
