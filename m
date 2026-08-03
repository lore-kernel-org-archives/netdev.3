Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EFDB3845C1
	for <netdev@vger.kernel.org>; Mon,  3 Aug 2026 16:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785775128; cv=none; b=hIUAuMgJVwxWkaU+YnALgI2nhuXHhLHO6zstj9S03aTwHmw4Nh0Ilu4BP0MdT3kMrm2m7NZBpHQyoWm+LWZ7dkZYnri/RzHhmqwlHFeqDSs8mjf32kaKiGpTbChlNpXO4D2ocFCJfs0gwvJczMA+tDmLbVrtAgIYTYkfU6U0UtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785775128; c=relaxed/simple;
	bh=kwouVj/whNGoRrlAp+DEkWyUuUJZO3rqH6VKtO+C8uc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j8pku962+fbbpl4ra6uoxm4lmR644qp53qjCzXbmGjFanfGYHmSwMFBOL5i5oM6p3lDLqotfmBA2X6D0yGbrN/9E5MrUCx+p0KXMDIUpqrfLibGy3ghFGn+ofBCxC457dGBH81qXVhmaNVoXAFI6+YHtosjMZXYhhxYEUVmBSQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RloCrJ2V; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=auUQb242; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RloCrJ2V";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="auUQb242"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785775125;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oDA30YrY/+OQRC6WLrG9g3BJdigc9XVLeVtgvYlueZI=;
	b=RloCrJ2VBZgsDfOyE6LP3N1Wx/5wwZBid4KgTUpCK/P7ehBUa6jI3CWeEteUOhBG7qWMKd
	/7q2Whpi/yCMh8oR98BL06c8SM1vScTdU1svOUDnt1gOeH7lsX8oNTbw0MrDQ2jsEOR7PN
	L2jMDXqcZyK+frHYQ2eXV1plSwO4iTM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-322-_Y-4e_XnNc2NOfEnd6gm-w-1; Mon, 03 Aug 2026 12:38:42 -0400
X-MC-Unique: _Y-4e_XnNc2NOfEnd6gm-w-1
X-Mimecast-MFC-AGG-ID: _Y-4e_XnNc2NOfEnd6gm-w_1785775121
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-47fd4ee0ac0so2736532f8f.2
        for <netdev@vger.kernel.org>; Mon, 03 Aug 2026 09:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1785775121; x=1786379921; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=oDA30YrY/+OQRC6WLrG9g3BJdigc9XVLeVtgvYlueZI=;
        b=auUQb242c1jPMALwRvIflzRwGOSCvGDS89yWZJUjp80oYLBjnxQkiKEMm9NXh4N9DA
         D0BOkxWZAITmUdogR4XY3Om+lLBPp0bCMXKGPsAbme1v9wtn9do8vLTWYk9VzyFD8faW
         52Z4ngD6za8ogGGHQxIHnTBNfguorh+E+rcfMDRhS5H6X0NflK2o1is91/CYpBnLwl9h
         E+LY4tAQzDFSZpauPORgmD8q/iai5x+dDNQJUFCgzEM2/UeX+/y573o0Adg2T/NE5RVQ
         6/210qrvIhVehh3h1XSvCwymHrwNgNOLa67cfExCZGEIVIv3Mz5kJpDmGekT5t+ataJO
         oVXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785775121; x=1786379921;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oDA30YrY/+OQRC6WLrG9g3BJdigc9XVLeVtgvYlueZI=;
        b=VZaJwEQqz7Spd1Y35W5+1NtmaG5ALsXBh/egQMAX+60XlSbyErtEqLszNZieS8wfJU
         63XTDNtWmNtGlmxZXjEEIc7UigCTZcXZQzkEExYJoAmo0wsis3YUv5qqPfA0s2i+yjhz
         +PzXk9VhAy4NmUEJ1czOoV/32ZMbjOOIvRx2I3YZ6ddPWe0FIEYONs9iOy4YWrZ+mZU6
         5G4B4v6OiVwN0l9SZH+dtsbxpoVdOTbU+wxklE1bg5IYotCeRKHMAr1trdo7hRwxmoAS
         2Xn+Zls+Zu+RBybPVj8G/sfZ5RC8vc+i/gfTvsssJfWTh/mKilZIvE6OGXG9G6BNCCtX
         OEPw==
X-Gm-Message-State: AOJu0YwQZWLkHBolJWOvrXpD0wIxwZJ9yKsaXDKi8GnFaheXq1Y8bkvj
	9Bn816jZkEXBCG9R/YSXDIGtubsk7dIqEGq5qzkkm4pC5gT8ArdmiAeOtLHNZ/Q2lqsiUGz1ReG
	F2nN6hVHlYzHzCz7eJwuS73JkfThrCTnv2pO5mBWYUj1y2wy6nLb0SuiXiA==
X-Gm-Gg: AR+sD10Qj0zJOsHrM3vn6uboYxdnYDQAwhOwEHivYvzGI/hiUvqY9MakILTQkPRvNC0
	L9eAgXjAg2aMxc3qJJMV2ZkS0CUEqeX2tzHj5JXcMyb27DC/nZinRyYZVNZK3HVPu44z7oyml89
	NfU6InNHf7x7kjSdb5m98HHIy4vs4uipuPER0BsfL8SC9kO4skd8RKShMWen/73rX1llx02G87X
	FA12ynraZKRkB0lXCZtoAkk06aTWCB/2ojSpB6v93iLI95PdZidyUE9bHrOgTXxwk5BcJPuIp2i
	8g21cFZYH0EW4ANpql5iYCqWkObHa3AZtnkeSAMc1zXkiLcla4lE63EIWVpB+xuJgRSWDv5l7O1
	8qlND01n1qv8ZMKEB8dBgDQ==
X-Received: by 2002:a05:6000:40e1:b0:47f:8b1f:efa2 with SMTP id ffacd0b85a97d-47fd729e88bmr28790597f8f.8.1785775121016;
        Mon, 03 Aug 2026 09:38:41 -0700 (PDT)
X-Received: by 2002:a05:6000:40e1:b0:47f:8b1f:efa2 with SMTP id ffacd0b85a97d-47fd729e88bmr28790527f8f.8.1785775120500;
        Mon, 03 Aug 2026 09:38:40 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-28-14.inter.net.il. [80.230.28.14])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fd64eef60sm29573432f8f.16.2026.08.03.09.38.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 09:38:40 -0700 (PDT)
Date: Mon, 3 Aug 2026 12:38:37 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Dongli Zhang <dongli.zhang@oracle.com>
Cc: netdev@vger.kernel.org, willemdebruijn.kernel@gmail.com,
	jasowangio@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	denis.pilipchuk@oracle.com, joe.jin@oracle.com
Subject: Re: [PATCH 1/1] net: tap: set skb->dev before parsing virtio net
 header in tap_get_user_xdp()
Message-ID: <20260803123808-mutt-send-email-mst@kernel.org>
References: <20260802224612.264563-1-dongli.zhang@oracle.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260802224612.264563-1-dongli.zhang@oracle.com>

On Sun, Aug 02, 2026 at 03:46:12PM -0700, Dongli Zhang wrote:
> The commit 4f61f133f354 ("net: tap: NULL pointer derefence in
> dev_parse_header_protocol when skb->dev is null") fixed a crash in
> tap_get_user() by assigning skb->dev before calling tun_vnet_hdr_to_skb().
> This is required because virtio_net_hdr_to_skb() may invoke
> dev_parse_header_protocol(), which dereferences skb->dev. Without the
> assignment, a NULL pointer dereference can occur.
> 
> However, tap_get_user_xdp() still parses the virtio-net header before
> assigning skb->dev. When the vhost TX path passes an XDP buffer containing
> a GSO virtio-net header but the protocol is set to zero on purpose,
> tun_vnet_hdr_to_skb() can reach dev_parse_header_protocol() while skb->dev
> is still NULL, resulting in a crash.
> 
> Fix this by looking up the tap device and assigning skb->dev before calling
> tun_vnet_hdr_to_skb(), matching the ordering already used in
> tap_get_user(). Preserve the existing RCU read-side critical section across
> dev_queue_xmit().
> 
> Fixes: 924a9bc362a5 ("net: check if protocol extracted by virtio_net_hdr_set_proto is correct")
> Cc: stable@vger.kernel.org
> Assisted-by: Codex:GPT-5.5
> Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
>  drivers/net/tap.c | 24 ++++++++++++++----------
>  1 file changed, 14 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/net/tap.c b/drivers/net/tap.c
> index fae115915c8e..5d2d34d24ce8 100644
> --- a/drivers/net/tap.c
> +++ b/drivers/net/tap.c
> @@ -1074,10 +1074,21 @@ static int tap_get_user_xdp(struct tap_queue *q, struct xdp_buff *xdp)
>  	skb_reset_mac_header(skb);
>  	skb->protocol = eth_hdr(skb)->h_proto;
>  
> +	rcu_read_lock();
> +	tap = rcu_dereference(q->tap);
> +	if (!tap) {
> +		kfree_skb(skb);
> +		rcu_read_unlock();
> +		return 0;
> +	}
> +	skb->dev = tap->dev;
> +
>  	if (vnet_hdr_len) {
>  		err = tun_vnet_hdr_to_skb(q->flags, skb, gso);
> -		if (err)
> +		if (err) {
> +			rcu_read_unlock();
>  			goto err_kfree;
> +		}
>  	}
>  
>  	/* Move network header to the right position for VLAN tagged packets */
> @@ -1085,15 +1096,8 @@ static int tap_get_user_xdp(struct tap_queue *q, struct xdp_buff *xdp)
>  	    vlan_get_protocol_and_depth(skb, skb->protocol, &depth) != 0)
>  		skb_set_network_header(skb, depth);
>  
> -	rcu_read_lock();
> -	tap = rcu_dereference(q->tap);
> -	if (tap) {
> -		skb->dev = tap->dev;
> -		skb_probe_transport_header(skb);
> -		dev_queue_xmit(skb);
> -	} else {
> -		kfree_skb(skb);
> -	}
> +	skb_probe_transport_header(skb);
> +	dev_queue_xmit(skb);
>  	rcu_read_unlock();
>  
>  	return 0;
> -- 
> 2.43.5

