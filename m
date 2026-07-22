Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F68D348C4C
	for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 13:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784727638; cv=none; b=YwQh8Z2E7bcL1u3GxQUv+OErgJp9g0K0KwwmlFvJHsAS/JPKHevfOXCCaOyzkI+D97qglpBXWRUmltL8yMmK5FfjA59vfkSmXgGO8ydgDGweqcHikvZzoFKmeBwlPHilS8op9g13o1f8RGf2T19GKrnGPHtIkH3kiuKm0HWQ1j0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784727638; c=relaxed/simple;
	bh=gui0VHTSLLwEHTPJ7tc1ugqJNcqEWciy6Fvv6kb8FpI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dhnRLEKey/UFxE6qCZ6RnEvPt2BLdTJK0CzfJyrmvYqhUJA9Qzfe8dvKKCmqBjoBrQgI0gpLpZvgyZ8IiqB/bJRGoYS4tY0+JxLlo2VDvgVFB5NAJf9upaEFEYLXfkZIQbPnHyz/MXWEGwxbhDtoNgeVNYj9WraegppfiSfci/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b=ftS+fLD0; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b="ftS+fLD0"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-385ea3ce80dso12609266a91.2
        for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 06:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20251104.gappssmtp.com; s=20251104; t=1784727636; x=1785332436; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=9feiKeFcTEnJsnOt+AVgxkROZ++OwVZ0S00dQJw9vl8=;
        b=ftS+fLD0qv/usuDVM+ESN4XKOBsoTKL2Df1skMTcrKJpPs/FYnGILEECIUyN4Y0dmJ
         hSAdny02ZivrrvoI1DRt+zq4G7RKhWYAC+zQsHGBJI5RJ7cCeKv+djO/MItHWvbRloR4
         T7y8A8oxGiY4z7xW/njiWXG+OekQH2kFNYnUWVNcZOrJvCiP0ik4dUPJVl+7l/ReGaLh
         cJ6axA5npjVn5KXrA7GtBVQsRiol13yVhAWEMoQb/hyTN52XgiHHre96VwRBSBU7IMwB
         oVul2VZqDOWUDGAEG96NPQseqNkl5C/+LNvt4iCPVmJ5vwVAJE9IxyPoPJ3W4wXpNxBx
         oG3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784727636; x=1785332436;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=9feiKeFcTEnJsnOt+AVgxkROZ++OwVZ0S00dQJw9vl8=;
        b=qQGQQ4wQJveUeAjedq8ngwylsTfignq5j4RdAl7oufZawTLfqPYWWVlvxmoZ4iFQZy
         zBXRHBQ0YPAf495s0QljAjLxxqV/HteKdfoNsCyGj6XhsT+O7NQwwWE+FfY8f7edu4vV
         pSCxoCoDnHbTTfsoa0/jNE7RxYSxSKv3Q3/aOErx5aR0NajttoR4P/oygV5rMDaFB/qI
         x3vuvW6wMjVDDKyQ4Ov8Q1vq6Y2s9+42iVubWYYMYnmePvCHq/Whz8c8PkO+rgYNr75v
         VG6/Y23f/t927CIcBmEq8VvnLok/di2XWjXEnkkQ80ecB6RVYipvux367B2Bwcu2hQkn
         cPOQ==
X-Forwarded-Encrypted: i=1; AHgh+Rp9ZeUCfcqeND+KQoL7Mjdff+OjUcR9aeCXD8hG6WjvZBeZryTz8BidnM2cWnSPP5BORUgNKo0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8S13mBlAUuc6eEQid/idHA5y247YG0bW5mrloOawjMEwwNBjG
	Pnq+xvjSyYJmT5J4zX3GV5PNAU8x9ZjGsYVQJpm7dBPUkhaRxCPl+GLpSV32hw1SJxI=
X-Gm-Gg: AR+sD12sjafQJ4NMPzjzxNA52lUmlv2ML4tfwlbX7m1ckuMcG5G6dTNLP4NEpCklBaB
	RsQ5aD6J5Jtrwrutd10bAdL6Mq6ojlgClYuIH1Uw3X+V7BtVWakeKqvz9yKO4GrgEdLAFg16u2g
	idCmnjXvc4iubAj6VS8mBVNT8Ivk4/gepZDbYdKA7a1WepvZB4szPKDw74DyWCA09z6IJuEpiyv
	yCIX6+klHeMNxwAg3cbLjphYrxzKgx5UPeudQh6W2tG+3ld26tViF2BV31c9K+/T1nwuCvRsTZu
	lzwFvxI0FglDZXsmxZuBv3GkvqnFbc7RC9b53yS/J9UFXiZA25k7WZ8lLYefjZl9byWimhEjJZr
	eqFvkZPvz++Ni7W0pJpwgYJTMAYViBE/ggnhub6VM60cI60tTwWiOARGw6QWrFp5k5aV67g==
X-Received: by 2002:a17:90b:3dce:b0:38e:7f1b:f01 with SMTP id 98e67ed59e1d1-38e7f1b144cmr11954633a91.36.1784727635713;
        Wed, 22 Jul 2026 06:40:35 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:44::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38ea7aa8c97sm1110409a91.9.2026.07.22.06.40.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 06:40:35 -0700 (PDT)
Date: Wed, 22 Jul 2026 06:40:34 -0700
From: Joe Damato <joe@dama.to>
To: Breno Leitao <leitao@debian.org>
Cc: sdf@fomichev.me, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Alexander Aring <alex.aring@gmail.com>,
	Stefan Schmidt <stefan@datenfreihafen.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Remi Denis-Courmont <courmisch@gmail.com>,
	=?iso-8859-1?Q?R=E9mi?= Denis-Courmont <remi.denis-courmont@nokia.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Sabrina Dubroca <sd@queasysnail.net>, Shuah Khan <shuah@kernel.org>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-wpan@vger.kernel.org, linux-kselftest@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH net-next v2 3/7] ieee802154: convert dgram getsockopt to
 sockopt_t
Message-ID: <amDIUv4Sa/i7MfEq@devvm20253.cco0.facebook.com>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	Breno Leitao <leitao@debian.org>, sdf@fomichev.me,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Alexander Aring <alex.aring@gmail.com>,
	Stefan Schmidt <stefan@datenfreihafen.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Remi Denis-Courmont <courmisch@gmail.com>,
	=?iso-8859-1?Q?R=E9mi?= Denis-Courmont <remi.denis-courmont@nokia.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Sabrina Dubroca <sd@queasysnail.net>, Shuah Khan <shuah@kernel.org>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-wpan@vger.kernel.org, linux-kselftest@vger.kernel.org,
	kernel-team@meta.com
References: <20260720-getsockopt_phase4-v2-0-8a08fcfa0d72@debian.org>
 <20260720-getsockopt_phase4-v2-3-8a08fcfa0d72@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260720-getsockopt_phase4-v2-3-8a08fcfa0d72@debian.org>

On Mon, Jul 20, 2026 at 09:17:44AM -0700, Breno Leitao wrote:
> Continue converting the proto-layer getsockopt callbacks to the sockopt_t
> interface, splitting dgram_getsockopt() into a do_dgram_getsockopt() helper
> that takes a sockopt_t.
> 
> No functional change.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>  net/ieee802154/socket.c | 38 ++++++++++++++++++++++++++------------
>  1 file changed, 26 insertions(+), 12 deletions(-)
> 
> diff --git a/net/ieee802154/socket.c b/net/ieee802154/socket.c
> index 85dce296d7513..763f63e48afe4 100644
> --- a/net/ieee802154/socket.c
> +++ b/net/ieee802154/socket.c
> @@ -831,20 +831,12 @@ static int ieee802154_dgram_deliver(struct net_device *dev, struct sk_buff *skb)
>  	return ret;
>  }
>  
> -static int dgram_getsockopt(struct sock *sk, int level, int optname,
> -			    char __user *optval, int __user *optlen)
> +static int do_dgram_getsockopt(struct sock *sk, int optname, sockopt_t *opt)
>  {
>  	struct dgram_sock *ro = dgram_sk(sk);
> -
>  	int val, len;
>  
> -	if (level != SOL_IEEE802154)
> -		return -EOPNOTSUPP;
> -
> -	if (get_user(len, optlen))
> -		return -EFAULT;
> -
> -	len = min_t(unsigned int, len, sizeof(int));
> +	len = min_t(unsigned int, opt->optlen, sizeof(int));

Does the same min() feedback David gave on the last revision apply here as
well?
