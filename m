Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B7613D9DB0;
	Tue, 14 Apr 2026 11:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776166196; cv=none; b=qDW7sXm6bE8y21x5TqsIGBtJUcghWH12m+StcgqaiaNiIkEdIdVFSryaOZ1WyPq9XZ//HY+IQeuqaWaZZROXR48V13oJMQHiH6imrj933njSYsqmYZ7ln+pz16HAyQGcXRchdYXQcnta8VXYqqAvUuJW1eLJgg4twArc9WQztY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776166196; c=relaxed/simple;
	bh=y5RqzwqGCOp6MOPA0v+0gXwKnYP7j3g4YU/R6L65eU4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PV4A9j4p19gMJYk15vvT95yKNvwRzuHvaEuMiSJbGBe7zSSynEJ1T06P/mkuqqNEoinbVicj9FYj/X4rjGXRtQkuVPMew8fSjB2IcNAb7dEg1b82XUWPDv8YuzCFiBDuh15dv5Z6w/GvRX5mWFcrQI+By2eBSrjcVPGRC7lqlNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B9QpkSDE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B9QpkSDE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EFF9C19425;
	Tue, 14 Apr 2026 11:29:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776166195;
	bh=y5RqzwqGCOp6MOPA0v+0gXwKnYP7j3g4YU/R6L65eU4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=B9QpkSDELOlqTiY4srJXIcyld3VzkskOLRoQFO6cIOU4AKQOOvzR4OBjGEqbAfDv1
	 uqABgHlLIwhJPSckFu6dToCTmNoLnjOA/o1E5rOTp9GBrXAgik24dcayvHIISrsK1E
	 EfBBXLcYYOTHYGpbcsWDnY7oiFUMi/1qRLEtN3Ho89J3PTPbKvHTkhu+xIdF9tp0At
	 fB/8Hfotc/WmvQFhlkttpk2k1rgjN+aXzQ2OO1x4qApIb1bgOauEJDQ6FmsH9+RrS2
	 QiUVWTR2cUcN2G0wO2jx4saC5RYAVyVum5/q+SeODCpLDISIqhv25hUQJQX6ugTDXB
	 jXJbM+vqcZd2g==
Date: Tue, 14 Apr 2026 12:29:51 +0100
From: Simon Horman <horms@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Kangzheng Gu <xiaoguai0992@gmail.com>, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, kees@kernel.org,
	thorsten.blum@linux.dev, arnd@arndb.de,
	sjur.brandeland@stericsson.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v5] net: caif: fix stack out-of-bounds write in
 cfctrl_link_setup()
Message-ID: <20260414112951.GD469338@kernel.org>
References: <0f9e9d4e-8083-4297-91d3-10d0f614c87c@redhat.com>
 <20260408125333.38489-1-xiaoguai0992@gmail.com>
 <20260412135743.GK469338@kernel.org>
 <255224dc-0a55-4a0c-95f3-b84d4c6b3897@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <255224dc-0a55-4a0c-95f3-b84d4c6b3897@redhat.com>

On Mon, Apr 13, 2026 at 11:30:53AM +0200, Paolo Abeni wrote:
> On 4/12/26 3:57 PM, Simon Horman wrote:
> > I am wondering if it would be best to follow the pattern for
> > writing linkparam.u.utility.name elsewhere in this function.
> > That:
> > 1. Uses a somewhat more succinct loop control structure
> > 2. Silently truncates input without updating cmdrsp if overrun would occur
> > 
> > Something like this (compile tested only!):
> > 
> > diff --git a/net/caif/cfctrl.c b/net/caif/cfctrl.c
> > index c6cc2bfed65d..ba184c11386e 100644
> > --- a/net/caif/cfctrl.c
> > +++ b/net/caif/cfctrl.c
> > @@ -15,6 +15,7 @@
> >  #include <net/caif/cfctrl.h>
> >  
> >  #define container_obj(layr) container_of(layr, struct cfctrl, serv.layer)
> > +#define RFM_VOLUME_LEN 20
> >  #define UTILITY_NAME_LENGTH 16
> >  #define CFPKT_CTRL_PKT_LEN 20
> >  
> > @@ -414,10 +415,11 @@ static int cfctrl_link_setup(struct cfctrl *cfctrl, struct cfpkt *pkt, u8 cmdrsp
> >  		 */
> >  		linkparam.u.rfm.connid = cfpkt_extr_head_u32(pkt);
> >  		cp = (u8 *) linkparam.u.rfm.volume;
> > -		for (tmp = cfpkt_extr_head_u8(pkt);
> > -		     cfpkt_more(pkt) && tmp != '\0';
> > -		     tmp = cfpkt_extr_head_u8(pkt))
> > +		caif_assert(sizeof(linkparam.u.rfm.volume) >= RFM_VOLUME_LEN);
> > +		for(i = 0; i < RFM_VOLUME_LEN - 1 && cfpkt_more(pkt); i++) {
> > +			tmp = cfpkt_extr_head_u8(pkt);
> >  			*cp++ = tmp;
> > +		}
> >  		*cp = '\0';
> >  
> >  		if (CFCTRL_ERR_BIT & cmdrsp)
> 
> I agree that the code suggested by Simon is clearer. Note that AFAICS it
> lacks an additional `tmp!= '\0'` check to break the loop, but even with
> that added it should be preferable.

Sorry, I left out the `tmp!= '\0' check.
That was unintentional and I agree it should be there.
