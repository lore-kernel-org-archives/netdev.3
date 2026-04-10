Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 197932FDC20
	for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 03:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775792685; cv=none; b=JKo+64Vbp+oiIUumXHxJuX85nrYKiXKO6wKbnT8WVeedkw4xLjc3Lbgg8TjtdJFoW5yQL/U70wuOszvgv521BuUh+VRwbkJ43EycJxYy8E4bx6YXrcTpUL+xlrjelEeZp6QvSod6a/hCjZZPjSEafE0dRAFoa20m4NdkXQzXi7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775792685; c=relaxed/simple;
	bh=7sOkdUNwcYnif5H6qzW2XFtZqrzBrijZi7hzlxUka5s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hGksB/Y7abZrlRKOITaMGn3E+TwiXDhBWFON3ykJtLNCHYF93uRHVJBh4pi4mcwzme73JloomE72YB8vItwz4jx1QaeO8WXsrYnt7jw9FHrnP8PDzDuZkft33Z5c5GFrIO9Z3DwIeF3/m2iJEnO/+7ez1p389ArJpmOTKJJMnaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TOyqY22O; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TOyqY22O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A60AC19421;
	Fri, 10 Apr 2026 03:44:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775792684;
	bh=7sOkdUNwcYnif5H6qzW2XFtZqrzBrijZi7hzlxUka5s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TOyqY22O/lUddIERnhDoWMvv8r+bViUfJDa8/hPgYNb3kgQRzkY/GJyXCy54WlTsa
	 2ET1zffR+2pUGnzpbtQh4YAzw6T2HiN0F3DUQTOmpxfCD/92DVH7YNmoogZtvLd4bk
	 rnQ1TPGgoCNyvxhIE653bMmx30PbVqc2io6F/Ua3NvdXsmlM2JH2sP6AU/J1pMMimi
	 1dVuojRRFUN6R/Urgu9wnBP7ne3fndRqcRlqNWKYlkGvhQaaQz6Z8xA+CXmrzCf17f
	 q+bnDuSqiVX1yq19VJruT1BIEOmylMKkRAu4o7TvbKjCKCGfyKEV46fioEjBJ8Wayd
	 5iGN6E7t8IJ/w==
Date: Thu, 9 Apr 2026 20:44:43 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Stanislav Fomichev <sdf.kernel@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com
Subject: Re: [PATCH net-next v6 00/14] net: sleepable ndo_set_rx_mode
Message-ID: <20260409204443.37c57907@kernel.org>
In-Reply-To: <20260407153101.3694714-1-sdf@fomichev.me>
References: <20260407153101.3694714-1-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  7 Apr 2026 08:30:47 -0700 Stanislav Fomichev wrote:
> This series adds a new ndo_set_rx_mode_async callback that enables
> drivers to handle address list updates in a sleepable context. The
> current ndo_set_rx_mode is called under the netif_addr_lock spinlock
> with BHs disabled, which prevents drivers from sleeping. This is
> problematic for ops-locked drivers that need to sleep.

I merged the queue leasing, now netkit warns :(
