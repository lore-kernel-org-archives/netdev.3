Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D64510F0
	for <netdev@vger.kernel.org>; Fri, 19 Jun 2026 00:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781827567; cv=none; b=eWLEZvJlbnIl40O93K6BVohGhdMth4AbCLtCwe3QZGFeALX+cyp97QxR9ubkfmxf85k2a25CWSd2ZWW1xxteAo4De0qA3bxb8jihr4PZYJXWTj1ss7i7YJ6rNsh9tSQb8JaQzre/fexTVye/T/tv+j83KuIrl9ZViNYknBmzmOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781827567; c=relaxed/simple;
	bh=rYHqSmGsH4cbKSWk54QP1sTrqPfbU0FMq9rs35T482U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mOm61R4EgsxroQJVv8mE9Nqu/2xXii71WCkVGo7AkggJ9bNbJ58e6r3B2Ggg5JKpUDewKOhOkhT785Y/l5wdtPMbs9G8Xy38SsssIJJGAyKCTvifNtmGB3yFeN9ty+RZdswihiuW110TIbkPYNUiO/y5L5XhhvNX+STzU4YFYNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f5QFekeu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f5QFekeu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D54551F000E9;
	Fri, 19 Jun 2026 00:06:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781827566;
	bh=mFQ9tkYMs09gniDlAXC2Ca4YvMszBGigo8IziUjXlxw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=f5QFekeuScwVIKcJsGZEG5HvoyHnSvc8XERa5UfwpShqTINeMbnrk5YzI8pVUxxsV
	 c1didLOkTmqZU07W3eqluQyY5HiRbgxat5ekMkxcVaXk37DtQ9WmW5/h16n5di2ZRH
	 plBbhnqKCDN8Ix/WNLqcBjqxKKewQEFg2D9RxAJHKiuMpRGYzHBvbbIb2xRE69Wqg8
	 STOwpCnJHqnVducG5rZh6jLhDRrhFWsJWUG26rZZ/G4nzHjSD/ImWvbxySPYaJnGax
	 +eEWnfQJBsdhZ2HfaSaBKItbVmDfmL4xbveu809meunevLvH39qwDJ36CyRZuWQv03
	 9MBl0sFSB3sEQ==
Date: Thu, 18 Jun 2026 17:06:05 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Thorsten Leemhuis <linux@leemhuis.info>
Cc: Donald Hunter <donald.hunter@gmail.com>, netdev
 <netdev@vger.kernel.org>, Riana Tauro <riana.tauro@intel.com>
Subject: Re: building ynl afaics requires updating the UAPI headers first
Message-ID: <20260618170605.0e2e4dd4@kernel.org>
In-Reply-To: <ade91456-2f93-442c-b76c-28bd7157f074@leemhuis.info>
References: <ade91456-2f93-442c-b76c-28bd7157f074@leemhuis.info>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 18 Jun 2026 15:39:46 +0200 Thorsten Leemhuis wrote:
> DRM_RAS_CMD_CLEAR_ERROR_COUNTER was introduced to mainline yesterday as
> ee18d39a087792 ("drm/drm_ras: Add clear-error-counter netlink command to
> drm_ras") [v7.1-post].
> 
> I finally looked closer today and noticed how to prevent this: update
> the kernel's UAPI files (e.g. the stuff that lives in /usr/include/) on
> the builder. Thing is: that's basically impossible to do from a srpm, as
> those should not change the build environment and can't even when
> working as non-root.
> 
> Note sure if relevant and just a shot in the dark, so maybe ignore the
> following:
> 
> While investigating this I noticed this comment in
> tools/net/ynl/Makefile.deps:
> 
> """
> > # Try to include uAPI headers from the kernel uapi/ path.
> > # Most code under tools/ requires the respective kernel uAPI headers
> > # to be copied to tools/include. The duplication is annoying.
> > # All the family headers should be self-contained. We avoid the copying
> > # by selectively including just the uAPI header of the family directly
> > # from the kernel sources.  
> """
> 
> Is that maybe not the case anymore with the recent changes to ynl?

Can't repro for some reason, but we probably need something like 
commit 46e9b0224475abc to add the explicit include rule.
