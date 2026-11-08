Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794146777;
	b=rQ2JEKw/Bg5LOYsDjhYG6jHmDqB1NGL/vKKnfUBUNpyA/JccS+vBExBH/ghjSxIsZSAi
	 vqvLci3cyvUe3f6dAyLphPN/OAINpMRhd14JqMb+ETgFhalnRY0/IBpdSl44oC0u6MBve
	 U54ZqfLTIZ2qAa8vZIBJHmsBnx+d0ZH5O7oCycZPdMgz1h88NczCwNsAL9C7uj6q7hE9o
	 wnoS1AZl4dDSzAfgA3i42prrAuc0nrwFUf1xiuDk3gdX0PzcqihTf3AY7LMRWHZmD7Ue7
	 OcQ08v7yrim0bi4mQwCHBCRhXYnBexy1q6To7lSXE5lDR55A4UXH0EB8266GtxJRYQw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794146777;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=KpFhWEgRChoJJWWLLsoxr9atX7ojHr52psIpS09DOzQ=;
	b=ijgc7bwb/jXU7jgxmYRVex1w2usNFXKfS0serghwgCtNzrIqc13qMdcgQ+NyLAI9E2D9
	 VCXmRmWjWpSuFVbF3zaH5k/lVWKiDIKgh/7H/AP0CO76CT8m8uuUdSg17kDUUn0Q3N+bQ
	 O51sByA2w2vbG+O/6bZF9ffRE9NKZISBU0DdWYBYZOJ/X8tj8YU3ZQX0oYmCBLmpPVNK7
	 jB86U9SXWj208vPL4vco5yMe55AKFFfa3HTP+U+ucCxunAVGgiRB8tESmSA9Wu5wWIl6T
	 u/DoCAILS2fHRTzBV84xvZHDCHNA1r2IxRGxLkwCrWmM4yd8pZulLN9Gb8FOdOXZ2/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=hUui69+6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FC29606A320;
	Sun,  8 Nov 2026 14:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=hUui69+6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A144D1F0089F;
	Sun,  8 Nov 2026 14:06:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1794146776;
	bh=KpFhWEgRChoJJWWLLsoxr9atX7ojHr52psIpS09DOzQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=hUui69+6vx72SEp6I4RU2bEau87jQtKoVfAyOjJjDlcotewG6fSbL+q6Y+aqxEdTi
	 4hMSFTWG1sVrvJSHwfFSGV/qGPevSQDUeR9piTUi1hman1XCtIs5fgigwJyKn6qqxF
	 RlW/cPruYELdDhSak3VhviNhOlfChgzwFFq7/Z5U=
Date: Sun, 8 Nov 2026 09:06:13 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: David Miller <davem@davemloft.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>, Johan Hovold <johan@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	driver-core@lists.linux.dev
Subject: Re: [PATCH net-next 1/2] sysfs: facilitate creating an empty
 directory
Message-ID: <2026110846-iphone-alarm-134f@gregkh>
References: <0a0a7987-abb2-49c8-bc16-3938233ae9c5@gmail.com>
 <340683d8-83f5-415b-b54c-b2916817f860@gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <340683d8-83f5-415b-b54c-b2916817f860@gmail.com>

On Sun, Nov 08, 2026 at 02:45:05PM +0100, Heiner Kallweit wrote:
> We have use cases where an empty sysfs directory is created.
> This requires an attribute list consisting of only the sentinal entry.
> It takes only to modify one check to enable creating an empty directory
> with a NULL attribute list.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
>  fs/sysfs/group.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/sysfs/group.c b/fs/sysfs/group.c
> index 4e1e4f18a16..031cb6f36b5 100644
> --- a/fs/sysfs/group.c
> +++ b/fs/sysfs/group.c
> @@ -141,9 +141,10 @@ static int internal_create_group(struct kobject *kobj, int update,
>  	if (unlikely(update && !kobj->sd))
>  		return -EINVAL;
>  
> -	if (!grp->attrs && !grp->bin_attrs) {
> -		pr_debug("sysfs: (bin_)attrs not set by subsystem for group: %s/%s, skipping\n",
> -			 kobj->name, grp->name ?: "");
> +	/* If name is set w/o attributes, create an empty directory */
> +	if (!grp->name && !grp->attrs && !grp->bin_attrs) {
> +		pr_debug("sysfs: (bin_)attrs not set by subsystem for group: %s, skipping\n",
> +			 kobj->name);

Where is this now documented?

And why would you ever want to make a directory with nothing in it?
That is not how sysfs should be working.

thanks,

greg k-h
