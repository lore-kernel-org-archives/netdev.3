Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE95D3CB2FD
	for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 12:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786363490; cv=none; b=OM46TS7r6B3A/gNfY6HpgqCfuNSb9hVJg2uol3W3w+uFwt69FS9//8k+PxqLQMTKl1QdjMnGHPz1u6cS7WspoCZF6l7bqoS+tlLTnlrjSTkvpqL9kWmMk8lr92i9P81xPUn9tSDAvoRexSuvEYVCfXGW5yCAT1pR4+IVqOaynJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786363490; c=relaxed/simple;
	bh=NItqIlw0yNt23XrGvLNDmKYzYKHHYzR8arjRUlDDCdQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FZSbUxatZDPijpHceakhR5C4aTQLgxhUXzR7xhssFCEEZb62VjgaRZpdA8P/ArAOwiayNGGTy0RjUNopOyuTw4oKPHaU6lrGSfF348pC83Af/mlilEbiVSSejOAvE5ws/tjKTcEnm6ALw0HUZY+fgDl6WUOXkJP3x3w3Mkj1WRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fZGCaa6p; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fZGCaa6p"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-47fe76491b8so159101f8f.0
        for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 05:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786363487; x=1786968287; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=cpjxRd/pvTlykMQ7Gki81PooNujxpnSGhHOAxHlwH7w=;
        b=fZGCaa6p5QKM3bd2qxmu9RBY1UrtnCeRD21M3f+5M9I3S0rI6oSwEMBhvLkS2FOdI5
         AjUz4DIXG+hAmPISl42RGPa/HSh+NOJk6Z1Hqszop+k0FJwow6hCuWBXvMZT35eDnh/b
         ugfTsqyHAA1MkGInNk92CUrxpEtDb4tICuk8BYIsizd/hR13BodomXWm2jq9xpAPDCcJ
         sMBQa5/2gTAY6DFgRpvxpTvs8PSBPBCbLHRER2u9mjm0zXNYa9ad+RXwdCCVyo7VIHAe
         e1BN8W5Cvq4Xh1i5NSEcgdTbnjoQI1B9T+GUR2oY4+CHNBwKB6rB8oimlfTHcm9BArcf
         +1kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786363487; x=1786968287;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cpjxRd/pvTlykMQ7Gki81PooNujxpnSGhHOAxHlwH7w=;
        b=kciX9z+xhCyd74acIO+YoxPBufFywMYBTmgIM6HkOqhH5DEXcKMHlgWCny9I7VVj1y
         7Br9uqZFpE6HtizhUdRgm7lR67fOQrcfih1ECCStF8wLz9KMIUpf69pMAkiti9EmQA1J
         vkgFUKWRKzaQGEm+btfrAabGkjomGsfTgk9baVyp1mQLnG4H33oAB4wf1cgn53dcL6A0
         WbTaslJ5gnBwtkLRMFOOP9uqXapEr9pvsOMdC3MidcRe9utG2cq7a9huB2sPSiZTBSax
         s7QQiMX5MlQMw7tXw4sZUz7NamSUECSYaNDIeEjjB503G/TsFgwEYMn6HddUhRnGICrx
         3Msg==
X-Forwarded-Encrypted: i=1; AHgh+Rq1iwQDSut52WqOe1JWN9Ds1T4842Iqo2ZCF0VqLICVWv6SMFgiuFh6wg40qHVp7sHI5SjgCZQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzG3Q3905/qIZJPKsqjeM5r8c1ikI/Rf2IvFWIoTl//7lCt1XV7
	OFfU8gQxB7QJWiECQFE8WjnYrFdmNcVCDjsQje4q1/Q+YbKq+V+VNuNc
X-Gm-Gg: AR+sD12VAI6fYzBy08cGJd0OmYG/lieiUm98vwF0nJF9Hxyvj1eA4h1QCxOeU1vvoS0
	MzpB8uoTdRiTRuZEa2XAuWc+LXj9Rru7lZO8SjySAglusYYLeiac2JVhTm1GBuIju1yt7tbd45G
	nhcQjvWdawcc2nHvj3tHlURyK8eMLApIzWVl3MTSoyc5FpdTrRdMUZvDUJOb454/hYod2cRKKSN
	3vkY6CECAOf1Vi6LiuWt4LI2KOT+J0meu5NQVfVkncnFnQ8JnGdlspkaxpk0jBjCr3TYnlr7obl
	Wa+QOrDC+QMNgwCr4rZ0sjvl6gWjWAWyNYXdDd6G/caQATAFkMeSpMMixlNeetcI6TwVplvIPFN
	Z2xjiCSPqaquwFp0cD9yRY8J9HxIVW6/Ku8uZe+s3GdwN544dduMd3aXkHiiFlfSum/e54JW6cG
	+D83vwIHB3YryULWXcd80j7S5+PiXRvQoJkM2tBcwKbb2yBPkPO4quPHXrF7s=
X-Received: by 2002:a05:6000:220d:b0:47e:96f2:52a8 with SMTP id ffacd0b85a97d-47fec4e31b9mr30062866f8f.1.1786363486475;
        Mon, 10 Aug 2026 05:04:46 -0700 (PDT)
Received: from skbuf ([86.127.220.200])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-480021f8f33sm39932368f8f.27.2026.08.10.05.04.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 05:04:45 -0700 (PDT)
Date: Mon, 10 Aug 2026 15:04:42 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Jonas Gorski <jonas.gorski@gmail.com>
Cc: Semih Baskan <strst.gs@gmail.com>, florian.fainelli@broadcom.com,
	andrew@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, vladimir.oltean@nxp.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: dsa: b53: be VLAN unaware when not filtering
Message-ID: <20260810120442.255nahzmurjhi5jn@skbuf>
References: <20260805072641.402-1-strst.gs@gmail.com>
 <CAOiHx==-d_nzO+TQO+4UD4GfoLSOBUyfLuO+hfj8rQ1if4sZ4A@mail.gmail.com>
 <20260806102327.wrig23oltjzogyi7@skbuf>
 <CAOiHx=kqmZSM2Vzusc_bcpJfTjJC=jYPgU3wnz_xX+_nnuiNtw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOiHx=kqmZSM2Vzusc_bcpJfTjJC=jYPgU3wnz_xX+_nnuiNtw@mail.gmail.com>

On Thu, Aug 06, 2026 at 01:09:03PM +0200, Jonas Gorski wrote:
> > static int b53_arl_rw_op(struct b53_device *dev, unsigned int op)
> > {
> >         u8 reg;
> >
> >         if (op > ARLTBL_RW)
> >                 return -EINVAL;
> >
> >         b53_read8(dev, B53_ARLIO_PAGE, B53_ARLTBL_RW_CTRL, &reg);
> >         reg |= ARLTBL_START_DONE;
> >         if (op)
> >                 reg |= ARLTBL_RW;
> >         else
> >                 reg &= ~ARLTBL_RW;
> >         if (dev->vlan_enabled)
> >                 reg &= ~ARLTBL_IVL_SVL_SELECT;
> >         else
> >                 reg |= ARLTBL_IVL_SVL_SELECT;
> 
> This ARLTBL_IVL_SVL_SELECT bit is only implemented for a small subset
> of switches (bcm5302x / bcm58* and bcm53134). Additionally, according
> to the register description, this also requires enabling "per port
> IVL/SVL" mode, which is not enable by b53. The description of that
> also says that the VIDs used in SVL ports must not be used in IVL
> ports. No idea what the consequences are if they do.

What does enabling per port IVL/SVL mode do?
