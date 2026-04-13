Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ADA41DFF0
	for <netdev@vger.kernel.org>; Mon, 13 Apr 2026 00:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776038809; cv=none; b=Bdd6xoEQ0jREC3q+hgjObfvld7FY5InuFNG422kQAskvwCHiVDU+oOI60oYk0qplvzbJ8hUscqirp8YgIAqZ+lPinlZ2X7ln1ANp3Wmo25kc+BfJHjU1AkvvzPkhfiI4So/nXdbXZfAjAveH3HhU8XFpn1VtDfs6M21/aZGG97E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776038809; c=relaxed/simple;
	bh=DthFOMLc2Mv6YnNW0QLRZ7pCzEt8OEiySSjyMCuBaZc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BMTrO1zMJo4Uimutb93U++sldBnL6tCMKwASPSkcGcyYnRNFHbwwqJV5bR3eRCuegcOrfDmxiHsRckFxlqlmLbNgnF+5EBAJG3in+UHsaaUeZObJuR09vn2/gRRARnrJ4wZ6uw4lwUUqHgfORdHP2cPVCOFQKKmG3UeUtNShezY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C/ScsfKQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C/ScsfKQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDAB2C19424;
	Mon, 13 Apr 2026 00:06:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776038809;
	bh=DthFOMLc2Mv6YnNW0QLRZ7pCzEt8OEiySSjyMCuBaZc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=C/ScsfKQQB6t0ZkxMSDDKpG6ZdJApnHZ0QtHVL5mVDt+YRENC0P0YKOdKVuyzIxGT
	 AyVROEOc0TP8EkcZxEBzqXgpmGiVwvYi2FD3JonlY508ower/0KqSKLVUl3V7oKjhT
	 w49lfKjP14ooOMjDeyil+pCWjQNx9tlioVXjRRbpvs22GvAkZxTKmEuSDvtf1VOndm
	 UUzs0Jfmtu1sXCJtyFNGPXY0+FEwBzYWFh5b9BBWCIqM8kKtGX2sASoAm5NRAFQF1v
	 ucGHskXMnFJdv6nKWuGHkD5SzN7pN7BYR7o1plAvy2IkG2HadaKS9CjyAj6SWovj9Z
	 dRhUB6bPoTvfw==
Date: Sun, 12 Apr 2026 17:06:47 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Matt Vollrath <tactii@gmail.com>
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 hkallweit1@gmail.com, andrew+netdev@lunn.ch, nic_swsd@realtek.com
Subject: Re: [PATCH net-next v3] r8169: Use napi_schedule_irqoff()
Message-ID: <20260412170647.37e73644@kernel.org>
In-Reply-To: <20260412232914.31463-1-tactii@gmail.com>
References: <20260412232914.31463-1-tactii@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 12 Apr 2026 19:29:14 -0400 Matt Vollrath wrote:
> napi_schedule() masks hard interrupts while doing its work, which is
> redundant when called from an interrupt handler where hard interrupts
> are already masked. Use napi_schedule_irqoff() instead to bypass this
> redundant masking. This is an optimization.

Linus tagged final v7.0, net-next is closed. See for more information:
https://www.kernel.org/doc/html/next/process/maintainer-netdev.html
