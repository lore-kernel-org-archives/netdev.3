Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C152C36D9E0
	for <netdev@vger.kernel.org>; Fri,  3 Apr 2026 15:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775231985; cv=none; b=Kz0rt8q9xu/Rz7AprI2IATNy5o7lSCtqX+qIZtW+XOlx8u1CEdMUGvhvedDCtuPvZYIlxnIL0J/7oRBdjYx43U7LxIRxmSgpo+d8GQg8yGWCYL7U0vhO/p8OQU23wRuUhVZ8rxqAzVaeeiiRd7GuJXR+PM6eVfB2OioJgDYDq/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775231985; c=relaxed/simple;
	bh=COo09iCY2logus3uHqYWMR//alvUs6Kkf79Mc55dc4s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f6MujFNppgrYQQZc0qSaGs++8QhiiOZBTWQ9cg1D/4JtSNRRIKvjzPiqVbBogkPgKkn3PsCFBa0vTul27FC0E/1tFDqddXH11PPXcmZiPSdT1oas+XP3wkoOM3/UEuPpGf+1ZAdqO30qnF5EQG2vhhqQSZR6j+ebY8KLO07JfVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tFn92LJE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tFn92LJE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8E1EC4CEF7;
	Fri,  3 Apr 2026 15:59:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775231985;
	bh=COo09iCY2logus3uHqYWMR//alvUs6Kkf79Mc55dc4s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tFn92LJEpKEvuwYyt5u85xBMTrit5kKNA+hVNRjjAk7Op4bibl3p4f3WW/TT+YdLC
	 7hg7Ridbk6/AF4fu9lWCmF8bWCWemozfxOFe2C66HEjF9txzh89W+mz5eZG7dDXGdA
	 wbcqrssVL6vlvMw+xp4+2etaM38NyFWISHEHc8ZVbuEokLgWgZkYGG335JMgQwniro
	 djDkVKdqcoCb0BZykNePdSc74W5aA5PbUHLBicYihiF+db8ZnWezpW8r8gBC0YmqT9
	 4CjMsiELg3yxPDyexJ5ifToKd7r0D8PKrIP+I12r7sVNKR4L4bGF6/LRgYNyfW2ZHX
	 TYuPw/1KtYidA==
Date: Fri, 3 Apr 2026 16:59:41 +0100
From: Simon Horman <horms@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
Subject: Re: [PATCH net] net: airoha: Fix memory leak in
 airoha_qdma_rx_process()
Message-ID: <20260403155941.GM113102@horms.kernel.org>
References: <20260402-airoha_qdma_rx_process-mem-leak-fix-v1-1-b5706f402d3c@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260402-airoha_qdma_rx_process-mem-leak-fix-v1-1-b5706f402d3c@kernel.org>

On Thu, Apr 02, 2026 at 02:57:10PM +0200, Lorenzo Bianconi wrote:
> If an error occurs on the subsequents buffers belonging to the
> non-linear part of the skb (e.g. due to an error in the payload length
> reported by the NIC or if we consumed all the available fragments for
> the skb), the page_pool fragment will not be linked to the skb so it will
> not return to the pool in the airoha_qdma_rx_process() error path. Fix the
> memory leak partially reverting commit 'd6d2b0e1538d ("net: airoha: Fix
> page recycling in airoha_qdma_rx_process()")' and always running
> page_pool_put_full_page routine in the airoha_qdma_rx_process() error
> path.
> 
> Fixes: d6d2b0e1538d ("net: airoha: Fix page recycling in airoha_qdma_rx_process()")
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

Reviewed-by: Simon Horman <horms@kernel.org>

