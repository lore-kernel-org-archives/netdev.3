Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7442F3D2FEC
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 11:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791889545; cv=none; b=mJIjZ5YigBNv+4SZVvq/D9FwPNkYW6yLGn83DdrlxOK1hnw3X2IHaoXKyzbiCIgmuaOJjwnDwvwtEq3qEHELfoBWf/bIFZQP6FrKYQo5FbR+lkw9UHhgEeWGbsX+b/HnKF7KaEuX7cX9aMG1vGvz9Yc3PAS7udumx9o6zt4L5Tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791889545; c=relaxed/simple;
	bh=KCvmW2gkawrOwrsfGgGaOaal5YLOj9U1cr31ee+/jNg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=phrW2A4I2kL1aNVLofWIgaZOvbG3sWnZjiLhfmAnGy5vABBcc4h5QLEhRXvNuKL9JH6qTOPF/0/bG1KxJXJWWk8x6cpvTRqFUnd1SU2Y8GW5MnNsbkTde1RdldjmW77+eWMUan20v24GpolFKQrn0dqd6iSgB5Q8X7DKvLpt09Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NYNu8TyG; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ihkeFwf/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NYNu8TyG";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ihkeFwf/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791889543;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1fqSmGGq4xZz7TtpMoBw/I0gc3DOkgjRVuZqWTSTZfw=;
	b=NYNu8TyGgE/4pcVcs/Tf1iKVuy+Ps/jOizsdW0hNggPiv4SgIG18We1NQkHjLbEu2UJX2g
	9ufF+IsgWogv/ST78EQz10SDLNmQShQOL8l+G1cZ2DjtPYUJyiT1c1+1aDpnPD0aNzlJE4
	yrnJSqagMor80Hl3VDK030Ecf+JBG2Q=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-438-yVZb39LQN4G6L75GRLbX4Q-1; Tue, 13 Oct 2026 11:05:41 +0000
X-MC-Unique: yVZb39LQN4G6L75GRLbX4Q-1
X-Mimecast-MFC-AGG-ID: yVZb39LQN4G6L75GRLbX4Q_1791889540
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4a028616bebso19575185e9.1
        for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 04:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1791889540; x=1792494340; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1fqSmGGq4xZz7TtpMoBw/I0gc3DOkgjRVuZqWTSTZfw=;
        b=ihkeFwf/AbFYbkNlBMZ8G/UaKoQBz1HWxWMBUSNzCfG3XnmW3rrBRAR4ZhyY7PCx19
         z2r/QHdjeyoR5Nb/OPuL8e0UGrh5O8EWDoLNJOW7hlsWCnVAtMqqRsWjfnElMeCall+8
         kXK0lOOipJnzfAf72UPAM9y9VKgcKZnO9lk2x1vjdcaPu8/f90Lo9QCssiHnyJ/LyeO0
         AQ1XLzxY6VJqeOV1iLRIhH+XNjSgmpPIKd7pvZFfP+cPzMM/S7Ea8NTsPyS2K1ZAX8RR
         4sHrvsRtLPuBsQUyqDopfeE1fFHc0nMiLoDj0yGk3wCY6/85H7wjYaliVEuF2OAJyXDB
         hAWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791889540; x=1792494340;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1fqSmGGq4xZz7TtpMoBw/I0gc3DOkgjRVuZqWTSTZfw=;
        b=tSz0LiGrQLddcaBUR5KXdq+SlWE9rx2bLNocW6rxBjr7CYzkVBhTqwoMuiO8RXYIw5
         emSRETK+OObyupfKnnlo33rXRF1oTOl538vmGgO6IXYBXW95daY7BC1oeV96xJ4qd7+q
         kb8t8pQvgrOeE1EOP7L/veDtiYWf7AGRJdashUoyeStKtb/R65g3TBJHwImUpcXYTOj6
         zcBSCR9vmw12yBVqN9AuDOzA/8KZb3BU3FwtS38o+oE9cJmdf/jAcaYdtuqL1NK9Oj3q
         uM5nKMCmJx+Nx0+3coFbreczl1OEKO4Dv7gFuMc71zR3N/8iV0Wb1Tv4MduiYLrNUFR4
         os5g==
X-Forwarded-Encrypted: i=1; AKwUvBzTYfpDTAvhzYfC+ZlGC242x+Xsrnqn+lqLhRdr/iSSLUOBR+M+LiqUqjGEK4BJwnD8pI7gMhA=@vger.kernel.org
X-Gm-Message-State: AFq9FYIrPFmkVVAk7ajRxrCM22frSMcOUhMXFTJk53oXYwHPS1mFyDwD
	I+vrnxEr/bx8hu4erPUpKs2DHO615xHz33Sbj1QmzehBu52pCXkZW6d4odpnuQbDRV6eFi7PDbt
	IAmvbL8lqxEE2dM7t+ogXl2mkehZMZ0mDuHW4pTn1OhnBCabkQ8IA4xsaCQ==
X-Gm-Gg: AYBFou0WJ9JdnTIAjyJXcIK4/MVFbl8zNIWbxPD4GwAykBSYBYCtSU1mnqZS+qrSENP
	mpTXHs5CvVbvmqBs3LI0o8pzzmoODS730OB1AyoKx6py/sneRPBLTZz6dj1RkRqZbqqde7+tLc/
	K/6ZVbkAZT2jfQ+plwEWXhPAdSeq+dU604oJu2GEj0yHgK0BBk34AC366bPFB2Nc1NJ44jr7RHt
	WcCmZHki7s4wzscYloixMB7CG6u0nBnEkUZBEtDWYSsgaVzuLiAglhhx5LozLv3KFDuhaUavK/l
	biiu5ysKfxr5Pq/madnVwKu8E1D7a1dvrimslNYvg4JBLcROedwyYH4idIA/dz9gQCUVAw==
X-Received: by 2002:a05:600c:8518:b0:49f:cbf3:551c with SMTP id 5b1f17b1804b1-4a18e4a8ca6mr220181085e9.12.1791889539537;
        Tue, 13 Oct 2026 04:05:39 -0700 (PDT)
X-Received: by 2002:a05:600c:8518:b0:49f:cbf3:551c with SMTP id 5b1f17b1804b1-4a18e4a8ca6mr220180275e9.12.1791889538853;
        Tue, 13 Oct 2026 04:05:38 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:3fd7:5300:3d6b:52a4:a23f:9d0b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a18e48db03sm510740965e9.3.2026.10.13.04.05.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 04:05:37 -0700 (PDT)
Date: Tue, 13 Oct 2026 07:05:34 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Jason Wang <jasowangio@gmail.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, virtualization@lists.linux.dev,
	Max Krasnyansky <maxk@qualcomm.com>,
	Paulos Yibelo <habte.yibelo@gmail.com>,
	Chris Arges <carges@cloudflare.com>
Subject: Re: [PATCH net-next 0/4] more virtio-net csum hardening
Message-ID: <20261013070259-mutt-send-email-mst@kernel.org>
References: <cover.1791887415.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1791887415.git.mst@redhat.com>

On Tue, Oct 13, 2026 at 06:58:28AM -0400, Michael S. Tsirkin wrote:
> Allowing untrusted hardware to specify csum start/offset for
> CHECKSUM_PARTIAL was not a good idea, because, if it edits the packet
> outside the actual checksum, and depending on the setup, the networking
> stack could be looking at the packet both before and after the edit, and
> seeing different results.
> 
> Previously, commit 6785011f8b16 ("ipv4: validate checksum_start before
> completing checksum") validated all known instances where this
> causes the most grief, but the real fix is to make sure
> that either only actual checksum fields are ever edited,
> or the checksum is completed before the net stack looks at it,
> so it is always consistent.
> 
> This basically does this: checksum at ingress, except in a narrow list
> of specified known good cases.
> 
> Fixes: f43798c27684 ("tun: Allow GSO using virtio_net_hdr")


I forgot.

Reported-by: Paulos Yibelo <habte.yibelo@gmail.com>
Reported-by: Chris Arges <carges@cloudflare.com>


> Michael S. Tsirkin (4):
>   net: add ip4_parse()
>   net: use ip4_parse() in receive validation
>   net: resolve uncommon partial checksums at ingress
>   net: account for ingress-resolved virtio net hdr state
> 
>  drivers/net/tap.c                   |   4 +-
>  drivers/net/tun.c                   |  44 +++++++-
>  drivers/net/virtio_net.c            |   2 +-
>  include/linux/ip.h                  |  24 +++++
>  include/linux/virtio_net.h          | 161 ++++++++++++++++++++++++----
>  net/bridge/br_netfilter_hooks.c     |  15 +--
>  net/ipv4/ip_input.c                 |  13 +--
>  net/ipv4/netfilter/nf_reject_ipv4.c |  13 +--
>  net/packet/af_packet.c              |   4 +-
>  9 files changed, 228 insertions(+), 52 deletions(-)
> 
> -- 
> MST
> 

