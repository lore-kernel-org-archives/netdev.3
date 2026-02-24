Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9E601E5207;
	Tue, 24 Feb 2026 02:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771901323; cv=none; b=jzBAxZsKoctdbVJhppjC89aYapZbMkQSfujpzDxpbU/N0DHAXZJdrTBrS/uUmCTmQ5rrUiM7lK2+4Uo+4YswjyfbrVpGAaltuSgjwSGDMUT1tkjc703ZJDgPPuDb03eZfowxmhwQZzdpY30OZmE+R8uAKnSBdqTFDLiKKuGMXSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771901323; c=relaxed/simple;
	bh=7PJlfl1E8kHqQjY0Dl7T+Y3HgXwyKOBil5hIKHkainE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MnSM3XSusFPA4uw+4E29hHhTwqvs9Ngpr9y3aAqrB2/mYDAFhWD5OsXZeKq/WUcJ20I5Eu7goATjT0+ha+8BufnxIiTCkA3Y+ff+YOS+kNThEUgjkrWCBzUfe0MdmHqlWHLXT5fhfDrcgHPVIDxlDR9fCPy9+Qo0MdNaPN8Lsyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c0r7REpI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c0r7REpI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43363C116D0;
	Tue, 24 Feb 2026 02:48:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771901322;
	bh=7PJlfl1E8kHqQjY0Dl7T+Y3HgXwyKOBil5hIKHkainE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=c0r7REpI/o3XSVvBhMUsoa8mVeQQy/N1mZa0h9vor5J2fLnWeZgp1ByFLy0U3jhVp
	 05sQnXKohDzDQRJBAhzOdM/8yhm25w2TSC8P/Bq2M3lVefiF/zJrFrCL89RaKJoYz2
	 MtcrAFUasbYxLh1iT+sUECSU91JmdsIOIFbHSkeGaArrd+kdOYUcLkwV6bNnyJJQTs
	 Yu/TN2dAWBKfdY+aD8QKPApeuaXJogjOKMWlWD7W404Y2kkgfUTTaP71grxOdP8S03
	 KXRDOoUpCZqILopGpBexu9mGPP3QL5JwMyBs/CtegvM2+/rRZZukOCWY9z1nIwg/Lv
	 h4Vo7Rr0azmag==
Date: Mon, 23 Feb 2026 18:48:40 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
 <pabeni@redhat.com>, <danishanwar@ti.com>, <rogerq@kernel.org>,
 <horms@kernel.org>, <mwalle@kernel.org>, <nm@ti.com>, <v-singh1@ti.com>,
 <vadim.fedorenko@linux.dev>, <matthias.schiffer@ew.tq-group.com>,
 <vigneshr@ti.com>, <m-malladi@ti.com>, <jacob.e.keller@intel.com>,
 <stable@vger.kernel.org>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <srk@ti.com>
Subject: Re: [PATCH net 2/3] net: ethernet: ti: icssg_common: set
 irq_disabled after disabling TX IRQ
Message-ID: <20260223184840.06069afa@kernel.org>
In-Reply-To: <20260220041431.372610-3-s-vadapalli@ti.com>
References: <20260220041431.372610-1-s-vadapalli@ti.com>
	<20260220041431.372610-3-s-vadapalli@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 20 Feb 2026 09:41:58 +0530 Siddharth Vadapalli wrote:
> The 'irq_disabled' variable indicates the current state of the TX IRQ and
> is used by the TX NAPI handler to determine whether the IRQ should be
> enabled.
> 
> Currently, 'irq_disabled' is set before actually disabling the IRQ by
> invoking disable_irq_nosync(). In an SMP environment, this leads to a race
> condition wherein the processor taking the interrupt sets 'irq_disabled'
> while another processor executing a previous instance of the TX NAPI
> handler sees 'irq_disabled' set and invokes enable_irq() before the TX IRQ
> is actually disabled by disable_irq_nosync(). This results in the following
> warning:
> 	Unbalanced enable for IRQ ...

AFAICT the flow on the Tx bug is not buggy, owner ship of the IRQ
vector passes handler -> NAPI -> timer. I don't see how those can
race.
-- 
pw-bot: cr
