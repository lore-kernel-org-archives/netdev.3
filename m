Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A9EA317167;
	Thu, 23 Apr 2026 14:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776953936; cv=none; b=m/o9bAf4qwMKcz4++MmhJI9RgUxt5xCt79oqbXwJyKB0up0SrtqZ2LRvb8on0MELZC3Bs97eF2OegtU0x7Kf9fCPd0LZdfUTKUKgbvgLdNJrciv3LZjAb32EGBXqOQcIwvOp7Z7IcmPpAN+2FwdBhHqBR+AAgfLmuMo7v3aZ3bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776953936; c=relaxed/simple;
	bh=IQmuEVX5OC0HNHu5OSWqc6p8XoiT4gVnDgPTjDT11jQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h0kWzFlbLmlzgo1sax61POqhXCNpnTVIhcyWBq8aNqW4u/6tCHqIFLnqCoAO5Ex4dD+0jijucUjkpTTscAAnYkcKUzrz9d29MH7LQMFyiHvZVpp/8v4WxuRN994/siwR6eJ/9p9ku237WS9Lmf0A1TnM+cz/W1R2aHx6mm9L5BQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=aDtWKGuQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="aDtWKGuQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96161C2BCAF;
	Thu, 23 Apr 2026 14:18:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776953936;
	bh=IQmuEVX5OC0HNHu5OSWqc6p8XoiT4gVnDgPTjDT11jQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aDtWKGuQ//yhkfbMszcQTZQDG9CsQIuh3kIjVBBTnFyjXiiLyRX854un+GDPOnD0+
	 Xif2hfoyE+/7Gx1rwKbNQc0BKrdqEIRjbcBUQWPCAE2Q6CnXKEArDnkbRtvDaKvmib
	 RN47uIIStc734nhrpbf8bgwDytsPu5tfk1OMOOww=
Date: Thu, 23 Apr 2026 16:18:53 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
	stable <stable@kernel.org>
Subject: Re: [PATCH net] ipv4: clamp MCAST_MSFILTER getsockopt to optlen, not
 gf_numsrc
Message-ID: <2026042345-prompter-boogieman-1f5e@gregkh>
References: <2026042054-dime-spectator-820e@gregkh>
 <17e348e1-b551-41e4-a512-906109dded4d@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17e348e1-b551-41e4-a512-906109dded4d@redhat.com>

On Thu, Apr 23, 2026 at 03:57:55PM +0200, Paolo Abeni wrote:
> On 4/20/26 9:26 PM, Greg Kroah-Hartman wrote:
> > @@ -1486,8 +1491,12 @@ static int compat_ip_get_mcast_msfilter(struct sock *sk, sockptr_t optval,
> >  	gf.gf_interface = gf32.gf_interface;
> >  	gf.gf_fmode = gf32.gf_fmode;
> >  	num = gf.gf_numsrc = gf32.gf_numsrc;
> > -	gf.gf_group = gf32.gf_group;
> >  
> > +	if (num > (len - size0) / sizeof(struct sockaddr_storage))
> > +		num = (len - size0) / sizeof(struct sockaddr_storage);
> > +	gf.gf_numsrc = num;
> 
> Since this is exactly the same code added above, likely a common helper
> would be useful.

Useful where else?

> I guess we don't care if this would break bad application passing optval
> area properly sized for gf_numsrc sockets and a small optval, right? I
> don't see how to eventually save them.

I couldn't see how to save them either, and if an application sends bad
data we should be rejecting it, right?  Especially as this overflows
things as-is :(

thanks,

greg k-h
