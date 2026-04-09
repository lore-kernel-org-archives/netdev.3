Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 699AB30AABE
	for <netdev@vger.kernel.org>; Thu,  9 Apr 2026 03:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775704423; cv=none; b=GTU3wVN4iBhLArJpqv8RkdjGiu71fK5+aXUpL0G9/g5MXB8aByzNUPhS9H6bZ/Ebj63UfOparFBEHyiWrTxFDegCnSY8Vs1ze/aWhIF/VLPGJT9p0SJMFIWbwGDraemteuF1oTGCBzY9ybMO0/qZ7jwFuhxgl2dfk7zRrukWM/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775704423; c=relaxed/simple;
	bh=WdHbPodKdp11GGlUGgi0bX6m31nOEGTKa2NRrA4PuJw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g0ndxzQ1jYHfpBeH+/Vkj55OvI98Y0orE643x3CYMxOtqh0PsVPrj/I6zst2M1DD6RhakrgYIZonKpvLy+0lYXQhsse7oRuhYbV6PwIOrthhSM/yzrs4OudCFZdmhocXLq3RpTEvsttzO4bmY2uMB9xf1Bw+c1yy/lJxjdWnzjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=thY2AZoL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="thY2AZoL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E50BC2BC87;
	Thu,  9 Apr 2026 03:13:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775704423;
	bh=WdHbPodKdp11GGlUGgi0bX6m31nOEGTKa2NRrA4PuJw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=thY2AZoLbzVe3yfk2v20AUpxW1dYpLcr5x9tcWLBVe9mQo1D3doArgBjPTi/iG3PT
	 +2eDji5Aufnh9yWhiQq8gl+XvVDJ3VwrgskYnFZLUj/1/j/HGIYBSNVztELXLRkGa7
	 T2IKDJKc06fKqgOG2ryV8A/Lgw6aKKgPIHrf4NLLtO0digSTyGWWa422TK3WeuBt/4
	 ngJ1lfJIhBEJJ56/aeycw+HS3QFVMJMB0Q2DtuDJA32mz5TWf1h5e2VBXd/71gjxVC
	 dQb0KogwcPieb2w1+fMxiv5QyT8jKcatDh8tKtu5RibzEcv1+KpkAXm5fPP4rOW0DI
	 NJ5bSEfYQhKug==
Date: Wed, 8 Apr 2026 20:13:41 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Louis Scalbert <louis.scalbert@6wind.com>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, jv@jvosburgh.net,
 edumazet@google.com, pabeni@redhat.com, fbl@redhat.com, andy@greyhouse.net,
 shemminger@vyatta.com, maheshb@google.com
Subject: Re: [PATCH net v3 0/5] bonding: 3ad: fix carrier state with no
 valid slaves
Message-ID: <20260408201341.68f31247@kernel.org>
In-Reply-To: <20260408152353.276204-1-louis.scalbert@6wind.com>
References: <20260408152353.276204-1-louis.scalbert@6wind.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  8 Apr 2026 17:23:48 +0200 Louis Scalbert wrote:
> The current behavior is not compliant with the LACP standard. This
> patchset introduces a working behavior that is not strictly
> standard-compliant either, but is widely adopted across the industry.
> It consists of bringing the bonding master interface down to signal to
> upper-layer processes that it is not usable.

Is the only problem the compliance? If so I don't think this qualifies
as a fix. Please drop the Fixes tags and repost for net-next. Please
keep in mind the 24h reposting period (also I need some time tomorrow
to queue your patch to the CI so that the selftest passes when v4 is
posted :()
