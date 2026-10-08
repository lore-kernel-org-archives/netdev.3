Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE270348C63
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 19:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791487353; cv=none; b=TZrshizmBELUyjXRQU56GbuxPAQX1HJmWs77a63oHOxUz7huDQ6zgOJ04UgXeqzI86LC4PZBS4RZRASvPv6Fh1YOpYUObWN3GlQkPz5l8GARNX5Qx+WZpL+okzsfjFsVwKHwZqayEqEorcc1UtynH5711yOg7SH/lL+MOvKfW1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791487353; c=relaxed/simple;
	bh=55a+ZTa665YdTKC3dKEXCX5kuSbF7nGC76QUAuFkYl8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Nrjq+3+OxQYp5QaOdOgQzChlNCM/AaITyuCXb9AJQ3+MSrdQ7UYezPWDzLCNx9OBasXQeoyJuwRPmbD4CjdALVnUXlYHbv/tNHnQ0d5a3ynI2YOailJXubqS4dCFbyYMcikuu5IUPYIYRyovuHem9V46zNWe5HoTQkNJLiAm334=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XoAIJywl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XoAIJywl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3026C1F000FF;
	Thu,  8 Oct 2026 19:22:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791487352;
	bh=HmvTIBcQxpjE0Q5G82DExkCUKuqcSZhaYlKA+bieC6s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=XoAIJywlXtaocSnvtDEBNLmUI6Fm7HmOrrBHwJZMxP9BUEAh6oNW3oAm5QOIC1RMf
	 2Ucgb31lEGShPF+5RWAPM58ldgsmm5+EiiWzAT18Qjx/VDB5OmNBFhUNB5+5RdPPM4
	 haXwHSbBmY2XMpFnTU6wQrPjAffi8Be77mSCCuCGQZTcNxViCEL9RU41M7tlwrEX0D
	 oFnHxMt4dylbLh50wP13NRvbevnzfhk17v5pmtBcoIsxO2ipCsVX/BcqTDhV+4dq5L
	 PU+yfc3acd6R3AJ9ufFvwXwAjRK99bGbCy8bdYj3yRzmMu1IZ0atsqT29b+vMFTTtO
	 37GmARNCPu/rQ==
Date: Thu, 8 Oct 2026 12:22:31 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: <intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>,
 <magnus.karlsson@intel.com>, <pabeni@redhat.com>, <horms@kernel.org>,
 <przemyslaw.kitszel@intel.com>, <jacob.e.keller@intel.com>
Subject: Re: [PATCH iwl-net] ice: keep the RSS hash function on
 indirection-only updates
Message-ID: <20261008122231.7713313c@kernel.org>
In-Reply-To: <asfjGzjV7scRJpis@boxer>
References: <20261007200311.730443-1-maciej.fijalkowski@intel.com>
	<20261008083412.23481894@kernel.org>
	<asfjGzjV7scRJpis@boxer>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 8 Oct 2026 20:38:19 +0200 Maciej Fijalkowski wrote:
> > Could you double check if we need the trailing else as well? 
> > Not 100% sure now if I added it just in case or it mattered :S  
> 
> else part seems to be just a move from hfunc being initialized to
> ICE_AQ_VSI_Q_OPT_RSS_HASH_TPLZ.

of course, lack of caffeine
