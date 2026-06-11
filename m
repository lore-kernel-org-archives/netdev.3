Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64F41405C21
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 13:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781184072; cv=none; b=X0NswHOoYkYRIACirj2FYUWknLMZox/8ySn0CT8PNZPewlYRHyuKHJTOlwk1xgmqbItnqNjjudO1kCDVMmiY6LaNxqkizQ0+hzMd+wJGxf7/rtyRirsxGQeAMQgz+Y/utWUpWA40+1G6uVYgqGkC7pw3q9/BZemd8Fphmp+eSCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781184072; c=relaxed/simple;
	bh=i69HHchfa/tPlLk5z2JDvWQW+btxSj93QBx/PdYpBQ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DmuF2iVdrpoRR57gZIc4QXjENQieztuGYwszmUFelaVpTk55nNoDuzzawCfMS7ru3CgGBCLT8mYuHZ0hkVMDzMulCIzPdt/U2lH50VaLsSyQqQsUKK5rYgH4ZxJBVCcgB976q2wM4t3+pzwxAQtLsecKPGpW//hZIU4Fd3PnHA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SEGxH9GE; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SEGxH9GE"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-c859878eb48so3214710a12.0
        for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 06:21:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781184067; x=1781788867; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GuakKPxXkpnpFQGEri3RKuU2yrpdAc9YS2PYx9vSNLY=;
        b=SEGxH9GE0SYY8xIJmhap2Xw+lZr0xVTxkCTAJB85WihQ3cFhgDEsw4y0kT7ro/Cjha
         QmPsw4XV+4gEr+RQNhmWOUq+VdpVCCNNnAWMuXalYduY3Va+5PnuBY/GyZJMjCv7mYHa
         bgEEGFtUgUNlfK3jfAQu9O+wJFIc7lRKC1xdQGz6PSo1VKASDU3k0samkDS6mO+ksFIr
         BW3C6qQFuZvjkbGKQT7RnvE/Opi6DqNaCt1MqljTyFzUy9vldRxs03VYNmX5ZWYYNQNo
         Hzdtmhn+1DFWDE9gw2coGODfoF7wNZmJneADvaFJH+wMSN0QA24czH85ODz4BF9QqUKd
         dycQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781184067; x=1781788867;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GuakKPxXkpnpFQGEri3RKuU2yrpdAc9YS2PYx9vSNLY=;
        b=Nu7D/b8P2/QCDM7P9bhTBapfp29dX6eTYy4Ycg+EgNBBmwzLe6PHpA+zBenBJqcY1X
         7ed7IOZzuan9jIZxFi+kScKxpVPH0TSWCsR0SZsFFqpg63zZN6ymSroAvvf/LGDLhpGc
         W9u2OjWYTnR1sB0NkPdBKkydpbqvDAfJOC2vNDiBqvwJW19P7kWax9R6PxAruQR2bfpW
         CrT6GR4oRfCHJqhRuiC61iw/MqtgCysHAeMzVqhafW3uuZ/+jzkx0FnTiI8ljSyq4LKp
         LF9cF3yIGceuBoUxEpH+3Vt5R2vZT+5bl9xKk6Bj9vS4gufYyn7gW5VicUmhgyCDvjyf
         YnLg==
X-Gm-Message-State: AOJu0Yzy7yXkJfOYfkE458fVt35WN4t/VWl9cl2gFq+zwJUMeo1DRy8T
	LsYHk7OnvO03R15OhOq/katwkjEK4xMYrkHS2VobWVTEQIQr+TuGSh13
X-Gm-Gg: Acq92OGsupo4KwygqVgb42E3YYWjtzSy6Cg/k9iZTlkkxuif23u6tEqxalFwPik6rcp
	JVdCpRFj13RGEGEuCjkDvlYE5+QSVf7xJkKma6lw4h9Kkrir7oYRXtdJUjKSFx5+JdLdjLYc5Bq
	ANuY2uLfByXvvESmC0SOkIBHj0kL3ihxUPQNEnbot0bHkDWFCLNfIqBRsSUvZhVSGc9qu7+7Mo9
	qdE6u/h/WEihd/O3ox2YzakerYW9KTfrHyeLMnspDwV8nspPy8R0Dxwx8zKmSCAExXR2mKw3aAs
	yKbeP212rF2WaseqGLD/ZRhzpgqzZXaTUIRNdpdCAuf8ZkM1Zcv1J/rXodrjihA7oeOYLVahCDb
	+sc8Y9w8dQk1tZd3Rm9M+b+C9tT5ihqirZNjC+oGd9CMrDUtk03IZH9IL0VMiHS/hmDfLUVCpWP
	xsUtCsqvBPZuLJlzbMS2+5XAeYXX45AyAsJGmhXrZ8AtE1q7VcwdLWJ3xHc2K6moBvDg==
X-Received: by 2002:a05:6a21:6f11:b0:3b4:5c6f:cf30 with SMTP id adf61e73a8af0-3b5e33e3b13mr3390507637.38.1781184067206;
        Thu, 11 Jun 2026 06:21:07 -0700 (PDT)
Received: from DESKTOP-19IMU7U.localdomain ([125.242.148.221])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c865880c00dsm1538945a12.24.2026.06.11.06.21.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 06:21:06 -0700 (PDT)
Date: Thu, 11 Jun 2026 22:21:02 +0900
From: Wongi Lee <qw3rtyp0@gmail.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, David Ahern <dsahern@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, asml.silence@gmail.com,
	dhowells@redhat.com, willemb@google.com, jwlee2217@gmail.com
Subject: Re: [PATCH net v2] ipv6: account for fraggap on the paged allocation
 path
Message-ID: <aiq2Pl/y//wnORe8@DESKTOP-19IMU7U.localdomain>
References: <aigx83czv+UJZA0d@DESKTOP-19IMU7U.localdomain>
 <20260611102303.GA880341@shredder>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260611102303.GA880341@shredder>

On Thu, Jun 11, 2026 at 01:23:03PM +0300, Ido Schimmel wrote:
> + Pavel, David, Willem
> 
> On Wed, Jun 10, 2026 at 12:32:03AM +0900, Wongi Lee wrote:
> > In __ip6_append_data(), when the paged-allocation branch is taken
> > (MSG_MORE / NETIF_F_SG / large fraglen), alloclen and pagedlen are
> > computed as
> > 
> > 	alloclen = fragheaderlen + transhdrlen;
> > 	pagedlen = datalen - transhdrlen;
> > 
> > datalen already includes fraggap (datalen = length + fraggap), but
> > the fraggap bytes carried over from the previous skb are copied into
> > the new skb's linear area at offset transhdrlen by the subsequent
> > skb_copy_and_csum_bits(). The linear area is therefore undersized by
> > fraggap bytes while pagedlen is overstated by the same amount, and
> > the copy writes past skb->end into the trailing skb_shared_info.
> > 
> > An unprivileged user can trigger this via a UDPv6 socket using
> > MSG_MORE together with MSG_SPLICE_PAGES.
> > 
> > The non-paged branch a few lines above sets
> > alloclen = fraglen = datalen + fragheaderlen, which already accounts
> > for fraggap because datalen does. Bring the paged branch in line by
> > adding fraggap to alloclen and subtracting it from pagedlen.
> > 
> > Fixes: 773ba4fe9104 ("ipv6: avoid partial copy for zc")
> 
> I'm OK with this tag if we want to be defensive, but isn't the data
> corruption only trigger-able since commit ce650a166335 ("udp6: Fix
> __ip6_append_data()'s handling of MSG_SPLICE_PAGES") ?
> 
> AFAICT, before ce650a166335, a negative 'copy' would always result in
> EINVAL being returned. I would at least mention this in the commit
> message.
>

+ Jungwoo

Right. I will add that info when write v3.

> Speaking of a negative 'copy', I think Sashiko is correct [1] and the
> comment regarding pagedlen>0 is now stale.
> 
> Finally, what about IPv4? It has the same code in commit 8eb77cc73977
> ("ipv4: avoid partial copy for zc").
> 
> [1] https://netdev-ai.bots.linux.dev/sashiko/#/patchset/aigx83czv%2BUJZA0d%40DESKTOP-19IMU7U.localdomain
> 

I think ipv4 has same problem (but not seems trigger oob to skb_shared_info). 
Remove comment needed also in both.

Preserving the copy > 0 logic seems good for defensive purpose 
so I will just let it.

> > Assisted-by: Xint
> > Signed-off-by: Jungwoo Lee <jwlee2217@gmail.com>
> > Signed-off-by: Wongi Lee <qw3rtyp0@gmail.com>
> > ---
> > v2:
> > - Fix mail format.
> > - v1: https://lore.kernel.org/netdev/aibiIYMAwUErTw5U@DESKTOP-19IMU7U.localdomain
> > ---
> >  net/ipv6/ip6_output.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
> > index c14adcdd4396..265502caa44b 100644
> > --- a/net/ipv6/ip6_output.c
> > +++ b/net/ipv6/ip6_output.c
> > @@ -1668,8 +1668,8 @@ static int __ip6_append_data(struct sock *sk,
> >  				  !(rt->dst.dev->features & NETIF_F_SG)))
> >  				alloclen = fraglen;
> >  			else {
> > -				alloclen = fragheaderlen + transhdrlen;
> > -				pagedlen = datalen - transhdrlen;
> > +				alloclen = fragheaderlen + transhdrlen + fraggap;
> > +				pagedlen = datalen - transhdrlen - fraggap;
> >  			}
> >  			alloclen += alloc_extra;
> >  
> > -- 
> > 2.34.1
