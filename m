Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FA1A3D9DCC
	for <netdev@vger.kernel.org>; Thu, 16 Jul 2026 09:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784195493; cv=none; b=ki86U2zWfn1zCMMIrM96d6HdMUDJ21oUO1tazj070IeCxKEWrN5EYmmkOGavZ6DuOCKiCOspuTowgzvIpaQ+XPyfslNUTxJWHvlTeuMaRaLgoCazQaQ3AB4oP+UtoIPHsAWhjykhsatXUbkeBY17Q/was3IoXgk+cX9GzXnOIf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784195493; c=relaxed/simple;
	bh=WPpqxyFxDAbrfaBRfDTd9Ulz2MDAyfS5jkTP6wJH78w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MAwOBVSgd/P4rNA4sbyUbkaZ0Ie2KiQSXyTnhv0UfollHi/bPOaVVkQfjjpFwnxmiwwG/OnMbDo7Rm9iheV/lwNnMz6eKTW3BZTj4cTpjnwXIYCROlfub8WeWOLNLsppKXXVfip9WoEhoXM7hwAAnJLsrXQuRqc6FBfneWwgDYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nbA2T/pw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nbA2T/pw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C57F51F000E9;
	Thu, 16 Jul 2026 09:51:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784195492;
	bh=aKluR959YJtsYFmq7CGd1vzqkeU7nSfClmjCZmOcjP8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=nbA2T/pw9/0whEKkEmXukXTED9hwGP8TeVAIIvh/buIb8bq/rKAH8AHYuWC/HzlPk
	 PeFmKzzA6x9lPQJGWxCEcs2bmQZzyorFN6FIK/eiOnLOhSCCoV47myOqHy28ceEmqs
	 OtsJTUpKA8vNksXGWRnoFaHbf+WEco56ayJH+jjSZk64+TXxx3YYhJcXAe+wNQilHn
	 p55llp2qgE8wavwBDyAxAt3JbNZ8v2K1JIez/IjS9IfP1qlLuFmlTzQ8LRSmKv4w0Q
	 YdcTmw2+ZxbJ3hOPJYMmFazO+4E4xp1kOaBrTGsJM/wk7BW0Oqoz4KzweoUyFpVf4r
	 R+BGU+pakFgWQ==
Date: Thu, 16 Jul 2026 10:51:28 +0100
From: Simon Horman <horms@kernel.org>
To: Antoine Tenart <atenart@kernel.org>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
	edumazet@google.com, netdev@vger.kernel.org,
	Sashiko <sashiko-bot@kernel.org>
Subject: Re: [PATCH net] geneve: ensure the skb is writable before fixing its
 headers
Message-ID: <20260716095128.GE95246@horms.kernel.org>
References: <20260709125000.141092-1-atenart@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260709125000.141092-1-atenart@kernel.org>

On Thu, Jul 09, 2026 at 02:50:00PM +0200, Antoine Tenart wrote:
> Make sure the IPv4/6 and UDP headers are writable before fixing them up in
> geneve_post_decap_hint. As skb_ensure_writable can reallocate the skb linear
> area, reload the GRO hint header pointer and only set the IPv4/6 header ones
> after the call.
> 
> Fixes: fd0dd796576e ("geneve: use GRO hint option in the RX path")
> Cc: Paolo Abeni <pabeni@redhat.com>
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://sashiko.dev/#/patchset/20260529144713.780938-1-atenart%40kernel.org
> Signed-off-by: Antoine Tenart <atenart@kernel.org>

Reviewed-by: Simon Horman <horms@kernel.org>

