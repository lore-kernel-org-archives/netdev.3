Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CFE5415B8B
	for <netdev@vger.kernel.org>; Tue,  1 Sep 2026 15:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788274957; cv=none; b=EsZ0iNvN+k3tBWyaLuWLEWVuJLvcUbPEXUZRP4ibI9pHJW6mG2DYY8FiHZE2uW78WXNKScUyubMARmbsg1O+2Fy9QaKa9MxrM+b/mQ9E+GK46e2AtWr2Hq+yB5BXe2ZDWdxghGQ8kl8CH4Pv4eZEtQeXOx7molziXTm661TAzAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788274957; c=relaxed/simple;
	bh=yDBRPHFnK33L1N+d5mcPe15XNSHg8owSU635zhOo/VU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cKEzVHDEmbB0Xi0Fn7whxvwlNMH0m+AzuLd73repbhqflHRtBRPNg8VbjHJrKmRCjFuInD+bxXij1SbqCXP6kEpWOoRqDOH3otf23D9Nl19yDQ5P94fzktTWjVoC9om5VEOHaXwSsvNzwZoMv9EYhTDGHK5TWXaUSCVs72fxQ+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hDEJrtYr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hDEJrtYr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6511E1F000E9;
	Tue,  1 Sep 2026 15:02:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788274955;
	bh=Uqce1kyiEabs6+m0tmpdGYF2ot7mc/ikvZRrvj22c0Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=hDEJrtYrzvxK+3Bohu4f3MpWnckXszZCFYHR2TmafpmNO4cmeHqxD3e8XX1L/IpsT
	 nKRJ3y4xI1Sv8NIZXbHN/87uvTsUML9ABIoWg0FPDdpgOT/GWvX8yaej3L6n4RkkTq
	 1m2w0L/HD20S0w2MsHEa039hDT9eUCEkp0InBhHAkK2bNbh2aJGFLMT8vFTJ3D3JbR
	 IShhk8RSEU1kBZ62Xk4BWVQJygBsPa9sNMka/aJxwIN4p2Wlom6ZLWVy8nQQgbtNAc
	 AhHVnjVuVzRxe7ajOjqTF8r0XKc3Kw6ZXl1b4fPO+nO2AZw3aLsfx5u/PScMF8J/e4
	 Ii8mdadnwz6lA==
Date: Tue, 1 Sep 2026 08:02:34 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Hangbin Liu <hangbin.liu@linux.dev>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 daniel@iogearbox.net, razor@blackwall.org, bobbyeshleman@meta.com,
 sdf@fomichev.me
Subject: Re: [PATCH net-next v2 2/3] netdev: avoid skipping objects on race
 with device disappearance
Message-ID: <20260901080234.522d1921@kernel.org>
In-Reply-To: <apaXopeQGUR-xku2@fedora>
References: <20260831164159.1124679-1-kuba@kernel.org>
	<20260831164159.1124679-3-kuba@kernel.org>
	<apaXopeQGUR-xku2@fedora>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 1 Sep 2026 17:15:14 +0800 Hangbin Liu wrote:
> > @@ -312,11 +312,14 @@ int netdev_nl_napi_get_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
> >  			err = -ENODEV;
> >  		}
> >  	} else {
> > +		unsigned long start_ifindex = ctx->ifindex;  
> 
> The NETDEV_A_QUEUE_IFINDEX policy is u32. And all ifindex getting/setting
> in 6b6171db7fc8 ("netdev-genl: Add netlink framework functions for queue")
> is u32. Why the ifindex is defined to unsigned long?

Off the top of my head - because it's am xarray iterator
