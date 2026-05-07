Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9D9423D283;
	Thu,  7 May 2026 02:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778119625; cv=none; b=Qya+kUCMNQ5/6dlyzc8X/tdwnTLyCuib9slbon116WER/DMnuoN5kQEh5hmU02xKY+O2qLfVSWcWWuKijgCiFcrkaVFBT872TzZueed+o3f5+MUFLpVp5CnirkKaDSpKaAVWA738+PTx4hmGHJl2RLMBq6dONank2VGFnPLRyUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778119625; c=relaxed/simple;
	bh=pKUcgXiFCysWkoNRC4FAViNRvnHbPPvFv9UzLhXpVqs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ak1QJNN6IwA7ONxx8qkgidRgIT/kF/djg3fB18MQ0QHRpto6yZ6ic2gQy3tzfG0uumyZdFjAEDWCLWCcpvJJvw/IuUFlRSmB2wXEKfiqtKs+IXa9vlWDgZ9dgQ6akgAEnXGCkK3qLikNiqp1maczdVOdJC3F+cysB7vllX3Jlds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U6UR7AHd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U6UR7AHd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9E63C2BCB2;
	Thu,  7 May 2026 02:07:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778119624;
	bh=pKUcgXiFCysWkoNRC4FAViNRvnHbPPvFv9UzLhXpVqs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=U6UR7AHdGhinWh27fvRJ6odfBWXbPk2N/dgqVnvVD6bdNvXxkSidro7l8Sksqo64k
	 Ik76XVSBmFtnyHdRfAYwx6NqJbilq0JrGwRHclP/syAUqZvn7Zn1DHiDXJ41aHfuzp
	 6SRFEzqm4QwkogRQ8zuU6hzCLRy8le5aHJJ/f4Z7lmeO5DiKyLV3AFFJ9uhfyd1oTB
	 y9u3KwsQilFgaRSctj7HPXOZhjeeB3fa0cf6X256mbB2obBOpcct9WTjnkWDdLq59+
	 8y1JbbDRwQ0NKNRL+hV3priUipOvqbpNdCAgEx+PRXBJNbaMjxGwiz5AOqgCsADR7t
	 11ebdKqG2bYmA==
Date: Wed, 6 May 2026 19:07:03 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: muhammad.nazim.amirul.nazle.asmade@altera.com
Cc: netdev@vger.kernel.org, davem@davemloft.net, pabeni@redhat.com,
 edumazet@google.com, andrew+netdev@lunn.ch, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3] net: stmmac: Add support for TX/RX channel
 interrupt
Message-ID: <20260506190703.5937aea9@kernel.org>
In-Reply-To: <20260506020018.25014-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
References: <20260506020018.25014-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  5 May 2026 19:00:18 -0700
muhammad.nazim.amirul.nazle.asmade@altera.com wrote:
> - Add net-next tree prefix to subject line.
> - Fix variable declarations to follow Reverse Christmas Tree order.

This patch does not apply to net-next, please rebase and repost.
