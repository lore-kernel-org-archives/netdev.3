Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EE373B5837
	for <netdev@vger.kernel.org>; Thu,  3 Sep 2026 20:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788466466; cv=none; b=b5FjclTbwcXjLNglUjnYs5fyydcSL3o/eABTJvivR2vGE2pZmYWkErsWoIN3Z6ojBr7AKP7EaTOG4MugbH1cC8XydW+K1sJ7vPpGqMFyEqkXQUxIV9sOoRs3ixMjw/gQtzS35PjRUe1HGUaox8AF28Svj9fY6ofzMmM0IQE8ylQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788466466; c=relaxed/simple;
	bh=PXHv/uSzDhxCNQnjSd40odOiZVTPRMimycX6GvPMlGE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=atizxEuPLk3ZdYfJ1pYFQ9Vq3FRPtAT/W3gNMteY9dh9bWj7gUID2tckR6DAG3qn5fYobSSY/i+mqDD8bPWH4gS2GvklodDegJAKXFQmCt6AVL2NNJmO1XhJ8N9ooVrVJU5RwMpKhAu5wo1pywj37iVcbmARGqLK8DxzQcSrYrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b=HBKreGoh; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b="HBKreGoh"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2d715f4a587so3933495ad.2
        for <netdev@vger.kernel.org>; Thu, 03 Sep 2026 13:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20251104.gappssmtp.com; s=20251104; t=1788466445; x=1789071245; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=iDplvj+ZDvMboLyoXyPhV2M+bmAxBWACgrtDZdQrMjI=;
        b=HBKreGohwytgtVux11tGGmp1NzAdQudin9NUcHHCH3QwPTEXFJW052lKk9MuYWkEBk
         zd2OWYQugkcaZBRvlUAu9ygLcRuPIu3Yd1YHBxjTVOHnvj23CazZDU8vpV/V3Pj9AIAS
         THG+30805VScH4OSKkoxCIPCLICKEHxEAgtibjbakpZcAajDXNSTCx+6GptwR02aqGjL
         SRx3jj2ySglCfhuRwEdWm7P/XYb5jT+AIITbAXkX9LeVTfmdefamRM09hNWhsmoHff1X
         RNu+TeutNToFnv5UpHOT0OJYSwa9CNvkt1hez8V+GO+GKmCumGar+Fm5wUksISPcPVOQ
         LrPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788466445; x=1789071245;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=iDplvj+ZDvMboLyoXyPhV2M+bmAxBWACgrtDZdQrMjI=;
        b=Skdsh0g+fXTruzkT7YUdoSajs8SCT9+ru2rtuc05uyotd0s3HMyvDO68uAztvOfRt/
         r2LARXqQoFAJl0UTwenxRX5n1nW2SMQrJlyL1W89rjlBwU+6tYJINLq27ANXpRBOVacn
         6osYy6J+LVKS0bokB3cRUZSOeJcb6SWSquE3KUd+/7qdU8yvG1nWkse3rZViC9euklDD
         L1U2r1jyNU5a/5yPUYFj+QLe8lqBhkc/rGoM8hTi6UMUxMYxLbrRphgs7NKoLdV32A1v
         w4KgkWYvM3ga9WV9akPTl93QbjLvWr1+UMOWaZE/UwVvK7r1Nj6WWACuKJq4z+5FSPXr
         0oLw==
X-Forwarded-Encrypted: i=1; AKwUvByjPBu7gu+Q7nQHbyoFyiKoP2LhpWqagr5jP05uv9CN42rjcaD0o6ATAQ+pr9FOdsY3g/55fio=@vger.kernel.org
X-Gm-Message-State: AFuF++ne1ksPG0ZzLrQMwbaM60x38gAH/n5E7z952PpHQFbywfUZB1Xc
	+plAy22z/otnbeWxDb+wwuaiVoBH6diC8WMAIovDVxeb/eAXmmpcKfSNpPENOYHKbN4=
X-Gm-Gg: AYBFou3Od2VpMW3imIjZtYcVxwXqXYfXYrZK2lTSGteMqgUQhD0cHRb5f0bUymsdqD/
	7rA7/WamcTVRawWWrfDIMdf4Exen66Kkf2ROBW9Ib4guwEVaiQQzJM4GW8/R3UtEem5/jjcDBPs
	d+3yQBek/DF0DI28u3dh5PCPVrqfufl9GYuerUwqG7LYR8QRNh3qVIvHUzLCtQa9d7dKuhTgzDz
	9UNfO9EKVwNeqHqLfw0BcItVbfICFd5SXmOhP6vkBdvCH85yXGH43ZTjfLz8y0O0pyRE3KA0Mfl
	Kzjjkkwld4ULxENvJQ9DpXgeCilssb6rAghVc+YO1eDiA3pdnT0VtT5tbo1nkYiu9EAXcU3yqnV
	nqDPsXQdT0cCqie6T5sWDykw2BnjxHM5pdWU+7Tsl1bR8dKQi1ckJBCYAGxBKWK5ylFrZ3dRogX
	n/agyyOW440ajkYu5a/25fnl206zXnZIJh6VrEKSAF
X-Received: by 2002:a17:90b:3803:b0:395:7fff:a08f with SMTP id 98e67ed59e1d1-39b25eef036mr1509927a91.0.1788466445566;
        Thu, 03 Sep 2026 13:14:05 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:9::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b26127fddsm588409a91.12.2026.09.03.13.14.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 13:14:04 -0700 (PDT)
Date: Thu, 3 Sep 2026 13:14:03 -0700
From: Joe Damato <joe@dama.to>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	florian.fainelli@broadcom.com, jonas.gorski@gmail.com,
	andrew@lunn.ch, olteanv@gmail.com, VEGA <vega@nebusec.ai>,
	leitao@debian.org, louis.peens@corigine.com,
	yinjun.zhang@corigine.com, oss-drivers@corigine.com
Subject: Re: [PATCH net 2/5] eth: nfp: bound the ntuple rule dump by the
 caller's buffer size
Message-ID: <apnVC8cgHhtGhGNQ@devvm20253.cco0.facebook.com>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
	netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
	andrew+netdev@lunn.ch, horms@kernel.org,
	florian.fainelli@broadcom.com, jonas.gorski@gmail.com,
	andrew@lunn.ch, olteanv@gmail.com, VEGA <vega@nebusec.ai>,
	leitao@debian.org, louis.peens@corigine.com,
	yinjun.zhang@corigine.com, oss-drivers@corigine.com
References: <20260903032611.3000029-1-kuba@kernel.org>
 <20260903032611.3000029-3-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260903032611.3000029-3-kuba@kernel.org>

On Wed, Sep 02, 2026 at 08:26:08PM -0700, Jakub Kicinski wrote:
> nfp_net_get_fs_loc() dumps every entry of nn->fs.list into rule_locs[]
> without consulting cmd->rule_cnt, which is how many entries the caller
> had room for.  ETHTOOL_GRXCLSRLALL requires no CAP_NET_ADMIN and the
> ioctl sizes the buffer from the rule_cnt userspace passes in, so once an
> admin has installed flow steering rules any user can ask for fewer slots
> than there are rules and run off the end of the allocation.  A rule_cnt
> of 0 leaves the buffer pointer NULL and the walk dereferences it.
> 
> Bail out with -EMSGSIZE when the buffer fills up, the way the other
> ntuple capable drivers do, and report how many locations were filled so
> a shrinking rule list does not leave the caller reading stale slots.
> 
> Reported-by: VEGA <vega@nebusec.ai>
> Fixes: 9eb03bb1c035 ("nfp: add ethtool flow steering callbacks")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: leitao@debian.org
> CC: louis.peens@corigine.com
> CC: yinjun.zhang@corigine.com
> CC: oss-drivers@corigine.com
> ---
>  drivers/net/ethernet/netronome/nfp/nfp_net_ethtool.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
>

Reviewed-by: Joe Damato <joe@dama.to>
