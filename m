Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4673A321F2D;
	Fri, 18 Sep 2026 11:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789729261; cv=none; b=AFHNMKV5T2Y29peKFQqJuSUGBrJJKpluAfyX5hITPZOK1VmB3O53e/iMCj7onYYrzwal+FX5WzdieF1uCnhMEUAGbZYxRbimSPVUnFTV8Zn+xWo0eIkY0vaaL2UvuimxW/aeN9Hp/kn2fODYXs5yseLhg3uN1cLfhK34dARLrPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789729261; c=relaxed/simple;
	bh=Wp3TFky2uNK5PTWjiy/pNmvT4Oi/y6Cs1lQC6pbNI/k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RN8fvh+Lv7EwfVJEEMvPBhjUIGv0B/ERnOrYQEg0CN+72C11w3m7g2WzJ+e9ouErpQhVN1N357JT3CfHJ5WZ7U/A0NVU1Xh9bI8SbhHge4pLu1GZqfNxxiIVnQbrC13J65MUtBkyeD3AcGvdpCXqZ+hbP4MZxjVepGS0SJxIoVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=G3rJwNUz; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="G3rJwNUz"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Reply-To:Content-ID:Content-Description;
	bh=xqxfznjQhqd8ZZuMM/AbiOa2L3kpLFZavpwb+Neo3fk=; b=G3rJwNUz16jEDw1nJJESpWlAcj
	3qybsqkBa8Mxr9xW+HgLE9StdDDLpVDU/rDxo22cL5A172YYRtC/RkTz2/CL5xEhKCKGAj0aOA5Ul
	f3QHebSc2FtqMZW7av5rEKSY02ZxZM6eGF541+b6wbKlP8Tqxc75dV1GoxHv/TUsjeSCEFtfSw/6J
	xkyU2WIIYuBaeXUYYNY0d3OSQPnqK9ERZZl1hIQz77XEh8zpnO4vqpDsSXOrdeC21xepNiUm6edzJ
	PSSMc0QVu6kmziqulbucbC4cEMCjh/Bh5xEHrhnVi/ScCcBgBvgLmamgD1cAj+uY64uaIy+RLxqm3
	Rm+gmokA==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1x7WKa-006fhI-1s;
	Fri, 18 Sep 2026 11:00:36 +0000
Date: Fri, 18 Sep 2026 04:00:31 -0700
From: Breno Leitao <leitao@debian.org>
To: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Cc: Alexander Duyck <alexanderduyck@fb.com>, 
	Jakub Kicinski <kuba@kernel.org>, kernel-team@meta.com, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org, 
	Mohsin Bashir <mohsin.bashr@gmail.com>, "Mike Marciniszyn (Meta)" <mike.marciniszyn@gmail.com>, 
	Simon Horman <horms@kernel.org>, Mina Almasry <almasrymina@google.com>, 
	linux-kernel@vger.kernel.org, Sashiko <netdev-bot+sashiko@kernel.org>
Subject: Re: [PATCH net] eth: fbnic: Keep real queue counts synchronized
Message-ID: <aq0ZiAEBNWWrLgms@gmail.com>
References: <20260915180859.4157646-1-bjorn@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260915180859.4157646-1-bjorn@kernel.org>
X-Debian-User: leitao

On Tue, Sep 15, 2026 at 08:08:57PM +0200, Björn Töpel wrote:
> alloc_etherdev_mq() initializes the real queue counts to the
> allocation maximum. fbnic selects smaller defaults and can change its
> private queue counts while the device is down, but does not publish
> either value until the next open.
> 
> Resume can also allocate fewer IRQs and silently clamp the private
> queue counts. Queues can share NAPI vectors, so changing the
> configured queue counts is unnecessary.
> 
> These mismatches can expose an inactive queue for memory-provider
> binding or hide an existing binding. A later channel expansion can
> allocate the queue without recognizing its memory provider.
> 
> Publish default and offline channel counts immediately. Reset RSS
> indirection whenever the queue-count helper runs. Preserve queue
> counts across resume and share the remaining NAPI vectors when fewer
> IRQs are available. The RSS table remains valid because it indexes RX
> queues rather than NAPI vectors.
> 
> Fixes: da43127a8edc ("eth: fbnic: support queue ops / zero-copy Rx")
> Reported-by: Sashiko <netdev-bot+sashiko@kernel.org>
> Link: https://lore.kernel.org/netdev/178915061000.219967.7726187707862333281@kernel.org/
> Signed-off-by: Björn Töpel <bjorn@kernel.org>

Reviewed-by: Breno Leitao <leitao@debian.org>

> +	/* Preserve queue counts, as RX queues may have memory providers bound.
> +	 * The RSS table indexes RX queues and remains valid. Rebuild only the
> +	 * NAPI layout, sharing vectors if fewer IRQs are available.
> +	 */
> +	max_napis = fbd->num_irqs - FBNIC_NON_NAPI_VECTORS;
> +	max_queues = max(fbn->num_tx_queues, fbn->num_rx_queues);
> +	fbn->num_napi = min(max_queues, max_napis);

It seems the comment does not match the code.  num_napi is recomputed
unconditionally from max(num_tx, num_rx), which is not what num_napi
was, so isn't the NAPI layout is rebuilt even when the IRQ count is
unchanged?

--breno
