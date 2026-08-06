Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74EEE44239D
	for <netdev@vger.kernel.org>; Thu,  6 Aug 2026 20:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786046682; cv=none; b=kbCVWzoaBI3FMkXAxslYtXFfvgmf5fKRJtFYMuw82rUgZ0c2Pn7CstuUsK0cK0Ld0/NWcg4Ym/OXPndAwStsD8saIHGwXsHrDbut0Tp15dcRBV/oV28WtyBoTekuJZojbyZS/Si3N/v4n3986ITnWh9meNVXz1rFyndHd2UDRLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786046682; c=relaxed/simple;
	bh=nMuAQou5vb8AvNyuLvOh9rAn8Pe0qkTIoxCS/nbble8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S7eP//qMX6s2uu9OkED5DYhmAF+E/LxyrGhxU/c6fL63/4wYKpVYvSduETxJ4cqSredKPNhvDXqSoHMjeasLBuqr2UkRXaIdU3Cnk45jXqLe3PwuL4FgpN9sHqIrV34DSwEa3MBxi/e5dmEwnNFqNCe9dqdDZP2q+LOF3F16jC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZiI+eOiH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZiI+eOiH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF24F1F000E9;
	Thu,  6 Aug 2026 20:04:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786046666;
	bh=vthLYYf2TKTLaloDBdMmWDi6/ShXvx0o2/otfEmBDUE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ZiI+eOiHWNjGY+UCLHXpTTZ5pz3uSkvxvswgRnSdqFP/pexPqEw/2oQmtI1Vbaqwf
	 hUX8A4o5Vqw+3VBcq0q8chS4jsqaGycAZIbfUJXXac4fh48ByGxyHlK9y0TC284gd8
	 MjOJRt728VB5dR9U4auQgMvR7AE/eBDztvs9t68VlERu7zmgI/42ZW7UpYnwKkO5wi
	 MrQyNCbDB2vSE8EFOI4VXvevmz2441saIDMyUpV5n67rAF2ujiy6c9zYp0GzcvyQr6
	 pLmypZ2hqQ3F7FzUVdRB0mEl00fOk5Vz6gEBqRVDzkJORgCWdNstmFjfEYQxZiWkt2
	 /vivVjx8jjgnw==
Date: Thu, 6 Aug 2026 13:04:24 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Tung Nguyen <tung.quang.nguyen@est.tech>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, jmaloy@redhat.com, horms@kernel.org,
 tipc-discussion@lists.sourceforge.net, Xiang Mei <xmei5@asu.edu>, Weiming
 Shi <bestswngs@gmail.com>
Subject: Re: [PATCH net v11] tipc: fix NULL deref in tipc_named_node_up() on
 empty publication list
Message-ID: <20260806130424.62a59734@kernel.org>
In-Reply-To: <20260805161356.193230-1-tung.quang.nguyen@est.tech>
References: <20260805161356.193230-1-tung.quang.nguyen@est.tech>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  5 Aug 2026 23:13:09 +0700 Tung Nguyen wrote:
> User-space applications can bind a large number of service addresses to
> one or more sockets. Each binding of a local-scope service address inserts
> one entry (publication) into the TIPC name table. If the number of these
> publications exceeds TIPC_MAX_PUBL (65535), protocol service types
> (such as node state and link state) are no longer inserted into the name
> table. This causes two issues:

make htmldoc on the testing branch flagged:

Documentation/networking/tipc:184: ./net/tipc/name_distr.c:261: ERROR: Unexpected indentation. [docutils]
Documentation/networking/tipc:184: ./net/tipc/name_distr.c:262: WARNING: Block quote ends without a blank line; unexpected unindent. [docutils]

+/**
+ * tipc_named_dist_cluster_scope - distribute all publications to specified node
+ * @net: the associated network namespace
+ * @dnode: destination node
+ *
+ * Return:
+ * 0 on success
+ * -EINVAL on failure, insert duplicate publication or reach the max number of
+ *  supported publications

is it this line ?

+ * -ENOBUFS on failure, no buffer space is available
+ */
