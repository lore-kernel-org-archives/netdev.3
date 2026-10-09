Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D5FC4279FE;
	Fri,  9 Oct 2026 06:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791526253; cv=none; b=uPfsAeo49sJxjOUW/i4z97p3iTBRF1tsPiiW7Fpb+hMBBEgDRl2GPhPVxhtc/VqbiHugjYnqIGbZuEGaJGq6+DWMJOXCTq0FFhZr+VQKStU8wAXck9A576uMuEvixNEPnPRC4UiyGeMdQrRjKCFbAIye45cwYPzlvDD+duyxec4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791526253; c=relaxed/simple;
	bh=JsKn0W6V7DyjIbmw/qt1dkI3v6Snv+d4FND9/dAuNAA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ied1V6tJW1jdkYhFbl+JVVBcDUR/w75FQ+BbtsBkmak9wX7fa9wD9NqsyE0PNhPrW1fxbsq2or97rjCQM2UcTLhczMQi60jAUJDjGeeWS/SfKYWdAx9H1h9RywWUW/gc2SynCJzFUSAHoTWJpdil/NGCTvLiGQctDppx5O3hf8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mEFPiUoo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mEFPiUoo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23D211F00898;
	Fri,  9 Oct 2026 06:10:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791526251;
	bh=jeMjLgvkM8NXuE64fpizt11DP2l7PUI8HIjgpZhg86c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=mEFPiUoo0HDXDa8cjlKiaenJJUkobMyYTGISHLrH6r7jvPzzRa5i+C4BD1c79aJU/
	 lG6N7tEk/EoFuaqiH2eGAxzK51KptjifgrAUjuQXnfnDYTto0IhooUACaMb01GSU3I
	 NXZhluNGAUJw25+CIC/TRVYehWaRtSITKOD285Tzlt//exz7c/wVWT6Vc9+e4Ti+z6
	 FUh3HWs8jRFjd2zxtPZR0UqeiM7/SP5Lr8+s+mLePkdkGSMC/3M87YYYK24vdQSB2J
	 Qfvy3OwUG7uSUjkKPZsUFVHtTL11FVAytDFacsKNY6jfepRCKL4FiOp4NSOeiekxRO
	 UJoqveA5k272g==
Date: Fri, 9 Oct 2026 08:10:49 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Haotian Zhang <vulab@iscas.ac.cn>
Cc: David Daney <david.daney@cavium.com>, Paolo Abeni <pabeni@redhat.com>, 
	Andrew Lunn <andrew@lunn.ch>, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	Eric Dumazet <edumazet@google.com>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Russell King <linux@armlinux.org.uk>, Jakub Kicinski <kuba@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH] net: mdio: mdio-mux: fix device_node reference leak on
 success
Message-ID: <20261009-narwhal-of-unnatural-shopping-7dfa7c@quoll>
References: <20261008175612.2748920-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261008175612.2748920-1-vulab@iscas.ac.cn>


On Fri, 09 Oct 2026 01:56:12 +0800, Haotian Zhang wrote:
> mdio_mux_init() obtains a reference to the parent bus device_node with
> of_parse_phandle() when no mux_bus is passed in. All error paths release
> it through err_parent_bus, but the success path at the end of the
> function returns without calling of_node_put(). of_mdio_find_bus() only
> takes a reference to the embedded struct device, so the device_node
> reference is leaked for every multiplexer that probes successfully.
> 
> Release parent_bus_node before returning from the success path.
> 
> Fixes: 0ca2997d1452 ("netdev/of/phy: Add MDIO bus multiplexer support.")
> Assisted-by: DeepSeek-V4.1-Flash
> Signed-off-by: Haotian Zhang <vulab@iscas.ac.cn>
> ---
>  drivers/net/mdio/mdio-mux.c | 1 +
>  1 file changed, 1 insertion(+)
> 



Multiple things here:
1. Your team ignored completely previous feedback.

2. You use multiple identities with this email, thus I actually doubt we speak
   with actual person.

3. Finally, same feedback:
You sent multiple independent patches, to multiple independent
subsystems. The amount of these patches clearly suggest this was
AI generated and most likely not tested.

More importantly, you sent all this work without properly organizing
relevant patches into patchsets. This makes reviewing difficult
and might cause multiple reviewers to address the same issue.
Replying to the entire set is impossible and requires handling each
patch independently, instead of applying or discarding the set.
Maintainers also won't see the bigger picture of your work. Quite
worrying.

This is on the verge of hostile patch: bomb us with so many
contributions, we won't be able to handle them in efficient manner,
like responding ONCE to ask you to slow down.  Considering all this
is untested and LLM generated, I have even more doubts whether this
should be considered for review.

Please read kernel documentation BEFORE posting more work. It will
explain you how to identify subsystems, how to organize your work per
subsystem (so a patchset grouping multiple patches with a short cover
letter), how to document usage of LLM and how what you should not do
if this was posted in a good faith.

Best regards,
Krzysztof




