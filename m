Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 444163EDADD
	for <netdev@vger.kernel.org>; Tue, 17 Mar 2026 16:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773766078; cv=none; b=pOM7I6NzMKyHaveCpU5MzxWbHlWNuNUt//suY9nryd2aAVJXyUO5KM9HUH7mf5wsRpJdl8ntWmVfmW+6MGd74aZQJfnF/xYNgnLFAyOmTiQ3vQikT/0oswUxAFwAiZvk1XDy14z1eCwiEciBFcmhHX/YFAfl2BILDvB6hfPZOS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773766078; c=relaxed/simple;
	bh=rumOXYImD+L1idgG1Se/fSNUa0rCcEh1M1ShMRl0WKo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XxPVbTIZR454I6vDATR6d78Ka9vmCuhv6sl0WbHMnFPstrWs7UVVX76PwAmqcOh5qru8+KE+ANx2WIGDmERXDlfoLx0e8A5Cj/kiB/rIbXdtKsVYZDy2vHCUQehnJLspvZ5fIPi74nioBLe8dvmJSAOsnzfinHg6PzRDFgAxnbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hiNB2V72; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hiNB2V72"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23AC7C4CEF7;
	Tue, 17 Mar 2026 16:47:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773766077;
	bh=rumOXYImD+L1idgG1Se/fSNUa0rCcEh1M1ShMRl0WKo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hiNB2V72ffDhZsAKnAlwyPim7jN83hjH2y6phTw7Ux8vLXkq6c/w1QOkdPJ+ina2W
	 M/hXXS078/UjRWT91MCS7GruPbrksz2DovGptGH33I7OKx3JjbkaNszB0fc0v5Kgiy
	 Rnghs8XFuezkWYaNZVG/QMGfFacObUXhkVw9ECYHqZQicsl3DgqqG6abv9UeD98vRZ
	 D/tuLrESxHbukJbJUJBuCKFFIE3cTgjbErfLi9hsVJYAIukevATbi7EJ/CqLm1szZf
	 fyQuVv9UOnjsXpqS9kDnnnYh5c7tYYx4+MQSyj8WoHLWcUaPW6fL1S1eMeD60gI7nI
	 mAUOHOQFIwrDg==
Date: Tue, 17 Mar 2026 16:47:53 +0000
From: Simon Horman <horms@kernel.org>
To: Alok Tiwari <alok.a.tiwari@oracle.com>
Cc: linux-afs@lists.infradead.org, marc.dionne@auristor.com,
	dhowells@redhat.com, kuba@kernel.org, davem@davemloft.net,
	edumazet@google.com, pabeni@redhat.com, netdev@vger.kernel.org
Subject: Re: [PATCH net-next] rxrpc: Correct rack timer warning to report
 unexpected mode
Message-ID: <20260317164753.GB1753385@horms.kernel.org>
References: <20260314195109.3867287-1-alok.a.tiwari@oracle.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260314195109.3867287-1-alok.a.tiwari@oracle.com>

On Sat, Mar 14, 2026 at 12:51:00PM -0700, Alok Tiwari wrote:
> rxrpc_rack_timer_expired() clears call->rack_timer_mode to OFF before
> the switch. The default case warning therefore always prints OFF and
> doesn't identify the unexpected timer mode.
> 
> Log the saved mode value instead so the warning reports the actual
> unexpected rack timer mode.
> 
> Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>

Reviewed-by: Simon Horman <horms@kernel.org>

