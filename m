Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26D58457E64;
	Fri,  2 Oct 2026 10:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790937029; cv=none; b=o6suYB6vi8bXnu/72gp/roxXnv1IaAPP9qcwhIV4qbS+zgXAgKQs9ytLzPDRcqOR2obeny1VslOs1de5bCCTHvXSDunm+RR1w0IGmhUNz1dj9kSILTXuITyb/R1aEijDVcTD3LOtm4oF/cgom3cp/GAnJjJUukOemZyVbFAF4yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790937029; c=relaxed/simple;
	bh=NmRTtrX3c0NVyjxrY1zGG1uYeTrlOqEaLry9eP5TkwU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LTR0WEIfWAydx3rXNpxgM+X2nrG3+VvtEcyn4nlDpC32BcpR142MsuVfszzCTmBgLLU270XCvyGin1PJ8fY4NnXBFuB559t2ttH3GrCnK3zHQD3O2dxz978HWimFM9Zm87nQzKss7jYMLK75v3R1S9hhQaTXcz7UYCRz6Ct5p88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=KRm5pRr0; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="KRm5pRr0"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=goidX4y0mXKn7jrXINEO2VnJ7ujOWyUtvQ6PGsR2fRs=; b=KRm5pRr0xAfpjjTpTUizNLBVto
	68ilqaVhaODJ4P6Fej8unx3O+FJDoDvP0w0GbP0biha0NUx5dOZufRHYHFz0DpVZTFvcT/1moXtkv
	wRNIBvJ32+ghE5lLOMYraSemamc09pQOyIcTFhFXa48KLUx+FJjIzEK+gRLSfVCFsTuEtC5CRFl8o
	T1VwEKD3lbu1Q+FrHIAPUFxerMCOilwsF+afToegbmEM31Vhh8ql3ervpdMyrI6oEj7D4MGOH7KEl
	67yuizx9D6pv6lltOBMNsIKgn+nzWz1GhkzvjJdChjPD2oqjb9qBH5PZXAIcrw3GWwVLDRV2GVL1Y
	a/ynZZvg==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1xCaX0-000nsr-2k;
	Fri, 02 Oct 2026 10:30:23 +0000
Date: Fri, 2 Oct 2026 03:30:18 -0700
From: Breno Leitao <leitao@debian.org>
To: Haishuang Yan <yanhaishuang@cmss.chinamobile.com>
Cc: netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Guillaume Nault <gnault@redhat.com>, Akinobu Mita <akinobu.mita@gmail.com>, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: fix NULL dereference in skb realloc fault
 injection devname filter
Message-ID: <ar-Hj5DhKuZeUisY@gmail.com>
References: <20260930122013.110284-1-yanhaishuang@cmss.chinamobile.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260930122013.110284-1-yanhaishuang@cmss.chinamobile.com>
X-Debian-User: leitao

> --- a/net/core/skb_fault_injection.c
> +++ b/net/core/skb_fault_injection.c
> @@ -19,8 +19,8 @@ static bool should_fail_net_realloc_skb(struct sk_buff *skb)
>  	struct net_device *net = skb->dev;
>  
>  	if (skb_realloc.filtered &&
> -	    strncmp(net->name, skb_realloc.devname, IFNAMSIZ))
> -		/* device name filter set, but names do not match */
> +	    (!net || strncmp(net->name, skb_realloc.devname, IFNAMSIZ)))
> +		/* device name filter set, but no device or names do not match */
>  		return false;
>  
>  	if (!should_fail(&skb_realloc.attr, 1))

I think something like this untested approach reads better:

diff --git a/net/core/skb_fault_injection.c b/net/core/skb_fault_injection.c
index 4235db6bdfad55..63a397f761133c 100644
--- a/net/core/skb_fault_injection.c
+++ b/net/core/skb_fault_injection.c
@@ -18,6 +18,9 @@ static bool should_fail_net_realloc_skb(struct sk_buff *skb)
 {
        struct net_device *net = skb->dev;

+       if (!net)
+               return false;
+
        if (skb_realloc.filtered &&
            strncmp(net->name, skb_realloc.devname, IFNAMSIZ))
                /* device name filter set, but names do not match */


