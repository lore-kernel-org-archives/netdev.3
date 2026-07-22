Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28D5B3FA5CC;
	Wed, 22 Jul 2026 20:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784752138; cv=none; b=GstRCjAiRIgb+7EGqSMaxbGsmnRVlC117EGmIxFPoj0M4MsjU3Bfxz3PKNrEh4NuQlQM/RCYrSHH3KDgQvhLn9AMx/4bMhQY7pxzaGXFTcDF6yWN6kKUKAUDZ2ACDCIUJXuUUovl7ZH/ES/xYMv+O0GcAJROmJLB8110XDvJ990=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784752138; c=relaxed/simple;
	bh=x/MNq6uQD5QN1xj+UhOubwMGRbe/zH9rhWR0DrV1L/A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WHksbBqnYYaoWVk0QDV92AMuHsyh39d8UgB7RAihJQjBHGNMoCXHqbrYTEvAzg1jI6570ehQD0Vb317OtvsmAR6tgE7TiY6+YPVPPAFklgQGdUvNGvMChdBCK/rwYOxB+l2mGWc3sbdd2c81sgHcT0uaeL08cqjXtVOUuMPbJf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ugs9vwHs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ugs9vwHs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BA681F000E9;
	Wed, 22 Jul 2026 20:28:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784752136;
	bh=48DcziVZ6snfwhBo/jX6knGZdoGoSF48emhZvldg9to=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Ugs9vwHs5llJqC5lqJMHER2kh8xSBeJ3OzOZk7FsVF8l8T0y38v6gqLfk4pO9AI5/
	 blWv4uokhLui5dnbKAmlUQLoumuKpS/9EW83JJB1lteFl0tTocKPctMhDjuETmkqPS
	 bZ+ud2vH2TiUZHzmTXGg/3foEzo2Sa0QUqa1tUYefh1c8wyaizFiRSTlhowfjZZslu
	 QTUgdMY4JiwKtYRMkGeETQ+p7DP1G+Ino7UVX+Vvxg0JuOyYAESuxqrDAKZZfizBan
	 /NTReZTy4iaaaBHKpxJwstI9mOPiY9zz8TVmypfxiETX+EkUzwOVdzCyPn81zvzlHo
	 qCByzu8M/Al4Q==
Date: Wed, 22 Jul 2026 13:28:55 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Maoyi Xie <maoyixie.tju@gmail.com>
Cc: Veerasenareddy Burru <vburru@marvell.com>, Sathesh Edara
 <sedara@marvell.com>, Satananda Burla <sburla@marvell.com>, Shinas Rasheed
 <srasheed@marvell.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S .
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Maciej Fijalkowski
 <maciej.fijalkowski@intel.com>, Simon Horman <horms@kernel.org>, Guangshuo
 Li <lgs201920130244@gmail.com>, David Carlier <devnexen@gmail.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v6 0/4] octeon_ep, octeon_ep_vf: fix RX skb frags
 overflow and page leak
Message-ID: <20260722132855.0faea241@kernel.org>
In-Reply-To: <CAHPEe=HeQw_qtrrxc992q0v5CAys4ES3x1YTge4hev_2Z4B64Q@mail.gmail.com>
References: <20260722155131.2017597-1-maoyixie.tju@gmail.com>
	<20260722090443.0c24a5df@kernel.org>
	<CAHPEe=HeQw_qtrrxc992q0v5CAys4ES3x1YTge4hev_2Z4B64Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 23 Jul 2026 00:47:55 +0800 Maoyi Xie wrote:
> Hi Jakub,
> 
> Sorry, I should have answered the first time. No, I do not have the hardware.

Let's hold off on these fixes and please instead send a patch for
net-next to delete the driver. Try to CC folks from git history
who seem to have used it / had access to it in the past.
-- 
pw-bot: defer
