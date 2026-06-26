Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98AEB3F8EA2;
	Fri, 26 Jun 2026 16:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782491009; cv=none; b=exLbSeNFN06AfHkFKRoCO+V12lVjTA5h8Rnn5VsJ+Op/6FwUIg00Kb4JrptLBrLlbeHstvtaorCLt7wxwHxRWB2JPRyUTCofEUkaf+VfUlUWbkQA9ZDpudXi7WuxARvT7VIcfThap2mkXF/kMv30gjDycknMvAdkwjc4uQM22uM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782491009; c=relaxed/simple;
	bh=h2p0BM4f+7zb/4IfXkW0GBB8xjThqWYi2VYWCxiRd/k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d+r8p7ZLHhKTPIZ8krim/FT1eEOmHeI9RPzuEaTsYdSQzaqk/WXS8PN4y5M33LgK1FegWi9ZmQu1YXRVMtW1fxL8zgAaDYSmXGQd72R8uDdT0T6EssklZxpc+Ee25jRZ5Petz8V2LjN+VYJkTMOa/W2ue+E2oCJgpZMYx0t+5Ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m60E/6k3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m60E/6k3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEB8F1F000E9;
	Fri, 26 Jun 2026 16:23:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782491007;
	bh=kMS+uA8BF/XmxnqGN1Ahl7J2e881/ew/8LVjQZ5iDrg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=m60E/6k3Oq+kZkuFbO5FnSKkT2V8WYIxSrMXkg4zZDAQilAOGu4a4cHjrvm9+6JGG
	 KbqjQohtqfnVyARl/78qr0BLA4V4FH6WKYImvks/al99Ufuo/vyH6H4ZtwyGhPr7Cv
	 9q2EX2Yzy4BtRB+H4Xb3CCNAH3ll1e0rybtCsxr8EYxy6gI+CX3LnmPwYsIu02+Zrx
	 Zfdc10ykv6wcWBel7zvfKfjZ6WBcwNCww5I8Oc1d33yp0kFmmV/4ZpeYn97pFxI308
	 swmOnQ0wLAzEBwypooXYmVrm+M7Uzp7IfKqxv/OHNefJOKF0dE5j5lLFpFPfL6jiP4
	 ZEyODC/o/AToA==
Date: Fri, 26 Jun 2026 17:23:23 +0100
From: Simon Horman <horms@kernel.org>
To: =?utf-8?B?6LW16YeR5piO?= <zhaojinming@uniontech.com>
Cc: Andrew Lunn <andrew@lunn.ch>, andrew+netdev <andrew+netdev@lunn.ch>,
	davem <davem@davemloft.net>, edumazet <edumazet@google.com>,
	kuba <kuba@kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>,
	"madalin.bucur" <madalin.bucur@nxp.com>,
	netdev <netdev@vger.kernel.org>, pabeni <pabeni@redhat.com>,
	"sean.anderson" <sean.anderson@linux.dev>
Subject: Re: [PATCH v3] net: fman: fix use-after-free on IRQF_SHARED handler
 after probe failure
Message-ID: <20260626162323.GE1310988@horms.kernel.org>
References: <20260624094922.2971930-2-zhaojinming@uniontech.com>
 <20260625164237.1222477-1-horms@kernel.org>
 <A2160E1BFD1B78E6+202606261753007787241@uniontech.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <A2160E1BFD1B78E6+202606261753007787241@uniontech.com>

On Fri, Jun 26, 2026 at 05:53:02PM +0800, 赵金明 wrote:
> Hi,
> 
> The analysis is logically correct. Since fman is zero-initialized by
> kzalloc_obj(), both fman->cfg and fman->fpm_regs are NULL when
> devm_request_irq() registers the shared IRQ handler. The guard in
> fman_irq():
> 
>     if (!is_init_done(fman->cfg))
>         return IRQ_NONE;
> 
> does not protect against this case because is_init_done(NULL) returns
> true, so the handler would proceed to dereference the NULL
> fpm_regs pointer via ioread32be().
> 
> However, this is a pre-existing issue unrelated to the UAF fix in this
> patch. The window is very short -- between devm_request_irq() and the
> completion of fman_init() -- and would require another device on the
> same shared IRQ line to fire an interrupt during that interval.
> 
> If this should be addressed, I will send a separate patch for it.
> The current patch is focused solely on the post-IRQ-registration UAF
> on error paths.
> 
> Please let me know if you would like me to handle this separately.

Thanks, I agree this can be handled separately.
