Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2001D220687;
	Tue,  1 Sep 2026 00:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788221343; cv=none; b=cRd9xG9ev55gM80bmunSDypqFmZYWl3pfxteniw4iZE0Ms8eqfZ5Vc16fsHbccDkV4sl2buYGeMiHoigdds56X+B2+Q3Q8UZ8F4UoZ3SRZ71J7Li8bNAa/piICj8/eEq3b4JcauTVtGtbzCJWF4Fv/Us1FICDS5wxKdVWtp1zvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788221343; c=relaxed/simple;
	bh=AdhwX4+AlUR+yOn+TZD8JoDBz3Hdlh5o1W72Ag9ocjU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nMpnC+IR/WHLeDStLaqkdBMF57KhFCrRBg7Y9JFHlWKJQUbZIcg90Wx046EnfmyjX1Wqyq2iBXGH6Bcb5KsFgBajT0FvOsGdA58F60UG+4ecn7H89GIGt3m5McfW/FeQjHYk+GEJionkDMbZU9bjxI+whj4Uk36Nhc0/bwACnS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TX3AkNbq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TX3AkNbq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE4AA1F000E9;
	Tue,  1 Sep 2026 00:09:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788221341;
	bh=MOCnMiWwuAqeY7230RPEeGlPmrcMUY6HdWpI0w4hMDA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=TX3AkNbqanYf/UIUjrymI1W/9kEbYODsuEKCcVac0QFQGRRXvMVN2a6k4ib+zl02L
	 4dp09cP7ahoQGjNCsqXtcXaFrithQUTh04xQeBPXot8wQCv9TS8AwMYLKarPmDo4wf
	 JQpgQ3Qy5IbFW8obwGz+bkp8TYO8cE7Mlakf4hRnFAy62uK+fa+Zje7SPRSWjqiDGy
	 ikBThDDtZowX62erg0MYRdiH0H7OXM3w4c78GKFzWXvBeB/0sFmAq4TaEK3ZhfTL9e
	 moJ7m4a/a9eh0cWXOfpftQRl6gOiefrDNjJt0fpGwooDyr+QDzn0IJ9l06O+6lpFsg
	 laXtW67OdYyeg==
Date: Mon, 31 Aug 2026 17:08:58 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, Linus Walleij <linusw@kernel.org>, Imre Kaloz
 <kaloz@openwrt.org>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, linux-arm-kernel@lists.infradead.org (moderated
 list:ARM/INTEL IXP4XX ARM ARCHITECTURE), linux-kernel@vger.kernel.org (open
 list)
Subject: Re: [PATCH net] net: ixp4xx_eth: handle probe deferral from
 of_get_mac_address()
Message-ID: <20260831170858.7e23643e@kernel.org>
In-Reply-To: <20260827013634.167932-1-rosenp@gmail.com>
References: <20260827013634.167932-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 26 Aug 2026 18:36:34 -0700 Rosen Penev wrote:
> ixp4xx_of_get_platdata() returns NULL on failure, which the probe converts
> to -ENODEV, discarding the real cause of the failure. Return ERR_PTR()
> with the appropriate error so callers can distinguish cases such as
> missing DT properties (-EINVAL) and, importantly, handle -EPROBE_DEFER
> from of_get_mac_address().

Doesn't seem like this should be treated as a fix, AI says:

Can a device tree that actually reaches this new code path pass
dtbs_check? -EPROBE_DEFER out of of_get_mac_address() only comes from
the nvmem lookup:

net/core/of_net.c:of_get_mac_address() {
	...
	return of_get_mac_address_nvmem(np, addr);
}

which needs nvmem-cells and nvmem-cell-names = "mac-address" in the node.
Documentation/devicetree/bindings/net/intel,ixp4xx-ethernet.yaml ends with
additionalProperties: false and pulls in ethernet-controller.yaml only via
allOf/$ref, re-listing just phy-mode, phy-handle and fixed-link. It never
lists nvmem-cells, nvmem-cell-names, mac-address or local-mac-address.

Should the binding gain those properties (or switch to
unevaluatedProperties: false) so the configuration this patch handles
can be described?


And if this goes to net-next there's a bunch of pre-existing
bugs in the area which will conflict, so frankly let's just leave 
this be.
