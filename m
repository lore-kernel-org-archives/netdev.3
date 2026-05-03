Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42D22495E5;
	Sun,  3 May 2026 01:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777770317; cv=none; b=tVhD2qRtAGoR49w3ukHPJeHqjeISGS7mOOIkKV3I7KYQs0AKp8tr8JfjZkxdPkuXffAF/0s0CCRwOf8uMsm5EaOxLrMCrdzg2ZCmFh6GyWqbRK8Ion4f+Fq3ZUOZOrsQEvZ/+xySXiWmSOq6zN0UoWUIoKV2iYqmJw/MQ5wVcnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777770317; c=relaxed/simple;
	bh=WbwtaJ+MQCEFP2zhUKD9ycsnZeEO9GQUkboqEKVTayk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i20IN30aeFyH+1iqp3PKLmpZ7FtwXAludULAVwrK5LhTgHtx3q9sgy2YjMEOGnOMcv1hneTx4aW5ihTHNrGkd6NwK8cunhMufRPNMifYbHLfU6Pis1Yp5YKmlNHgGljdFEpYq/Fgm/t7AjJ926R11P2eX6b06J18zLIAPTB/e20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lpxdlM/Q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lpxdlM/Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6096C19425;
	Sun,  3 May 2026 01:05:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777770317;
	bh=WbwtaJ+MQCEFP2zhUKD9ycsnZeEO9GQUkboqEKVTayk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lpxdlM/QivnLtOdwfsQ1a8DgsBgeFn5Xqm+wmwc5Bfb3wEwEajDVhzwjAitp5x6Wi
	 8QbAHp+ZLqosGSW3W24Ns6e8m4ACRl+fwhhv7zisUtCDBMvEGi9N3Ulqa+0Ob/zRmy
	 egV/FRNoD5YMWYkJcqvg8jdvZCtTCDcRAaaj3bhe7H+FpYZmQop07H7SZM3axqLES+
	 f/eLz/u5RS89XVQMnVvn0tDHHgwvkGDLUydBapdyaHFrDwCzvXHFeX5kPCA7ac32DS
	 uOZOIM9DKDc/d/6PXowrdEJszVQIvAgTD6PFofLnVDIZCSfP8ZItuXNAWGWkoEpc1q
	 x1tBC9TS4zjmQ==
Date: Sat, 2 May 2026 18:05:15 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Chuck Lever <cel@kernel.org>
Cc: John Fastabend <john.fastabend@gmail.com>, Sabrina Dubroca
 <sd@queasysnail.net>, Eric Dumazet <edumazet@google.com>, Simon Horman
 <horms@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, kernel-tls-handshake@lists.linux.dev, Chuck Lever
 <chuck.lever@oracle.com>, Hannes Reinecke <hare@suse.de>, Alistair Francis
 <alistair.francis@wdc.com>
Subject: Re: [PATCH net-next v9 2/5] tls: Fix dangling skb pointer in
 tls_sw_read_sock()
Message-ID: <20260502180515.78910e09@kernel.org>
In-Reply-To: <20260429-tls-read-sock-v9-2-39e71aa7810f@oracle.com>
References: <20260429-tls-read-sock-v9-0-39e71aa7810f@oracle.com>
	<20260429-tls-read-sock-v9-2-39e71aa7810f@oracle.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 29 Apr 2026 17:48:09 -0400 Chuck Lever wrote:
>  		if (used < rxm->full_len) {
>  			rxm->offset += used;
>  			rxm->full_len -= used;
> -			if (!desc->count)
> -				goto read_sock_requeue;
> -		} else {
> -			consume_skb(skb);
> -			if (!desc->count)
> -				skb = NULL;
> +			goto read_sock_requeue;
>  		}
> -	} while (skb);
> +		consume_skb(skb);
> +		skb = NULL;
> +		if (!desc->count)
> +			break;
> +	}

This diverges from how TCP behaves, AFAICT.
Short read is not a signal to break for TCP.
