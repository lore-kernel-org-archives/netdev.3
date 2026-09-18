Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43C0A4FDA45
	for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 16:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789747969; cv=none; b=SAc29wGj3Wy6WBEOKIjR7+Wu+cMzXISBxUvTGnTfAaLg8GVN2yXyiRWSDWNxHmIujxDNKp+SycYB+xqDNBaGgsHkgYNVUFEmmmROPR3CQxSWiShdN/GQk8LAHakYny15X9JC6wJTfAGrEiKH4ia8a5xufPZlfCBDZprk9cgRMZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789747969; c=relaxed/simple;
	bh=yQzG4GtlCEjyiKKmsLn+Iv2QufLeiSYViUgUZ9NHFD4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CXn16oqDBXNAx5e9coPS1ZSnxK5qxtV9wVCrq+uf1C5iQJ6EI70de3+PIrXS/nsk43+lzETfnKkWkDruS7BAYn8KFnM9AjzUbDZ+SP9khnnOTyUhmvOpnlqmBhoj6eST9PVJ0nR+tN7vHUUAqxIpeY2+UlGqoRO76w7TsCIr++g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HNlv65aZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HNlv65aZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 457381F000FF;
	Fri, 18 Sep 2026 16:12:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789747967;
	bh=cjhXqMPgaWKyjZyYAiLQjiB/XVBE4T2YOCBR+Sj0dkc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=HNlv65aZCMign731nwnyL9oaef0wq+zZQcELOdTX+Idewsp67rN65LQBaocKFYvjh
	 GSNWu+OUoKB4XmWMu3hdz1GdfYIKhIg9Vlwkd9w2fnZktyyNDlCpNdOzHh4Z37dZDS
	 nszvLRQiLiXC+rnRs8u65IRE9X9C776jQ7ZusGXQvMddNn47ElPIpNNkU7J20g0ixf
	 FfHakbd0Cyz4CjZFbrgVbB+sbTtW8b9vgvs03ds183RZhXZxnkPJefLr7He7mDtbV7
	 yukkggul3SKYgFovADTYaWCxYaTApsHYj6JAGGKBHggRdCbIUGLeWlOPGFoT5okpkI
	 /CrtWVHEFvkow==
Date: Fri, 18 Sep 2026 17:12:44 +0100
From: Simon Horman <horms@kernel.org>
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	kernel-team@meta.com
Subject: Re: [net PATCH v2 2/6] eth: fbnic: Handle maximum standalone channels
Message-ID: <20260918161244.GR51261@horms.kernel.org>
References: <178941996343.7700.9376081102002673062.stgit@ahduyck-xeon-server.home.arpa>
 <178942020457.7700.13129750616387075931.stgit@ahduyck-xeon-server.home.arpa>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <178942020457.7700.13129750616387075931.stgit@ahduyck-xeon-server.home.arpa>

On Mon, Sep 14, 2026 at 02:10:04PM -0700, Alexander Duyck wrote:
> From: Björn Töpel' via fbnic <fbnic@meta.com>
> 
> Standalone channels use one NAPI vector for each Tx and Rx queue.
> fbnic's allocation path excludes FBNIC_MAX_TXQS from that layout. A
> 64-Tx/64-Rx configuration therefore records 128 vectors but allocates
> only 64, leaving NULL entries that resource setup dereferences.
> 
> Include the maximum vector count in standalone allocation.
> 
> Fixes: bc6107771bb4 ("eth: fbnic: Allocate a netdevice and napi vectors with queues")
> Signed-off-by: Björn Töpel <bjorn@kernel.org>

Reviewed-by: Simon Horman <horms@kernel.org>

