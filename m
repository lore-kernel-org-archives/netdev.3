Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A9A570830;
	Sat, 13 Jun 2026 22:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781391556; cv=none; b=DIwDgmaoDpiJOGtfjNuyJp82myDNbY0F+XYJCwhB9+RHOh6zqnIuUjln05shrH+ZkIkK+qkcyc553ssOTuN/qKyWqHxJ5O7AAosvv1qbPha+7aMTDy9siY0pIuKaE1NEb4o5OQlJB5PoH8Wbm3XlTJijGwmqkHRRuVkZHKkF5Fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781391556; c=relaxed/simple;
	bh=/HcngOFacV4go3McTXOhGYFw4t1jgvxuhGFRwMZCRGg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ruH8ZJ9jMsvtVMkjYBZsl89wN7QkzeIHDwIiZJu3P7dZtFjwIHKvvfU8yfgsTbCzvpoAhp+gembNSPzSxJSecSfG9CHHww2iURBtzxn+Cx80M4eEXW7/xSf1ai0dkgNFjjVK41yhgyxHENKfaRMWhdKUdiQdhQIq7zD8FoO101M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V/1FXH0E; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V/1FXH0E"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2ABF1F000E9;
	Sat, 13 Jun 2026 22:59:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781391555;
	bh=bEj4ks/2XCQ+6BnDhYUjIHJe4oM/a1u+JgjglS9s4tQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=V/1FXH0EchJ3MZAidI8Po8S2ybsrh4jFqpIv749EY1JiYUhtB+bldDSFBEo4PyEKI
	 je5OdQWiKHAKacA+o0FXpGG4aSnu3JViXcQfPEbKrPffyy/kATMpYL6sddpLA5GJ/e
	 e9Sl7+b2a6RJ9urUnr9Y5kacF7C3BidWrH5af0qLMmtVSpuG53M2LLahyvKLx1Pfkr
	 9540oErSEdFrP72TzjZ0FYB2l6qn6wPmpzMZqN0OYIvHsRE25WpPOItR+5YE2n90LW
	 MX72gqzCdtlnAE2RTEzR6R9agDq+jMyEleA4cJeuuo8Ex1B+y48mw2/05EnUq1Thxm
	 uDiuCuhBDvqvA==
Date: Sat, 13 Jun 2026 15:59:14 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Robert Marko <robert.marko@sartura.hr>
Cc: o.rempel@pengutronix.de, kory.maincent@bootlin.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 luka.perkov@sartura.hr
Subject: Re: [PATCH net-next] net: pse-pd: set user byte command SUB2 field
Message-ID: <20260613155914.391515c7@kernel.org>
In-Reply-To: <20260611102517.445549-1-robert.marko@sartura.hr>
References: <20260611102517.445549-1-robert.marko@sartura.hr>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 11 Jun 2026 12:24:49 +0200 Robert Marko wrote:
> The Set User Byte to Save command has three subject bytes.
> The PD692x0 protocol guides defines SUB2 with value 0x4e, while SUB1
> carries the NVM user byte.
> 
> Template only initialized SUB and SUB1.
> Fill SUB2 explicitly so the command matches the documented layout.

Could you mention if you observed any misbehavior in practice?
If you can see any effect of this patch it needs to include a Fixes tag
so that it can be backported.
