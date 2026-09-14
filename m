Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48BCA43CE56;
	Mon, 14 Sep 2026 10:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789382505; cv=none; b=lIHEDaN9mZCYmpEqBWs5EYIwvO/LZEXx9rojMq2BI8LhnlJaSKae019A20KVaRkspb12/pn5gBBFhbF0cw4ftAskCFw/o6kIZ9u2SC+I0Aa6Wtzf1fvUukD+d2Rwru6tgNU0OJJ/F3hsL7JR2lwDeJL3NT7HPrzQapf+fUxfRIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789382505; c=relaxed/simple;
	bh=jYWGwTVscQZvyzMPLUqiRtuzbXNvSQSgHl1LKzIA2SU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E8VBQIQJ+lUUfasGGofk4hPMSt3aeFws3PSfC6BCwV+9MPDcuKRbZJsTWg/mhBuOCVi+zUOK4HoA3vv21CZypHGZaQM0ZtbNk6/CPeTL+3aDSLaUZonqRJPU6J0MudoFHJ5CY2wzcsq2+kfcfCbC0/wPzpz7A/k6+k93/kVw1IA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I5vbpmut; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I5vbpmut"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB8EE1F000FF;
	Mon, 14 Sep 2026 10:41:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789382503;
	bh=vCB1+7kd7R3XSELn154UQxv9Ow8oYfIsCZUacOtnP6I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=I5vbpmut6D4nQ8oi2upxqf2xiafQq5AKENR6AHlImlsbxzyWj5Trtl9Fd10fvu+bX
	 7bJyebWzGZajALd8RTNStsBkM5o868PlQxO1sgnw3nbiOaob9CtqU8LlbUjOdtHVCO
	 rOBrdmXFhSFIJWdEjp0889WJI2briKYSlG+CI93o9Ze6onN/mCLXyc8gE2awPa4W5E
	 oc8YzL7VIF1JTKxsYBic0v8/SV0+XaL/llukS338IU7JM8BVG1R12itQL6hJ5Za5B3
	 pJdKhFrJw5ZpEhcivXLj9teltGnpQ1OkLX6uUaeLLmHV5Kbi4jq4QiR8eY5JtH7VpO
	 kMLdNpcN9Z+BA==
Date: Mon, 14 Sep 2026 11:41:39 +0100
From: Simon Horman <horms@kernel.org>
To: Yige Jiang <yigejiang86@gmail.com>
Cc: netdev@vger.kernel.org, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Masahisa Kojima <kojima.masahisa@socionext.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: netsec: fix device_node reference leak on
 phy_np
Message-ID: <20260914104139.GR48209@horms.kernel.org>
References: <20260913064102.37452-1-yigejiang86@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260913064102.37452-1-yigejiang86@gmail.com>

On Sun, Sep 13, 2026 at 02:41:02PM +0800, Yige Jiang wrote:
> netsec_of_probe() takes a reference on the PHY device_node with
> of_parse_phandle() and stores it in priv->phy_np, but the driver never
> drops it.  One device_node reference is leaked per probe, on the success
> path as well as on every error path reached after netsec_of_probe().
> 
> Neither consumer takes ownership.  of_mdio_parse_addr() is a static
> inline taking a const struct device_node * that only reads the "reg"
> property.  of_phy_connect() borrows as well: of_phy_get_and_connect() in
> drivers/net/mdio/of_mdio.c brackets its own call with of_node_get() at
> :364 and of_node_put() at :373, which would be a double put if
> of_phy_connect() consumed the reference.
> 
> The node is still in use at netsec_netdev_open() time, where it is
> passed to of_phy_connect(), so it has device lifetime.  Release it at
> the probe error label, which every failure path after the acquire
> funnels through, and in netsec_remove().  Both releases precede
> free_netdev(), since priv is netdev_priv(ndev).  The ACPI probe path
> leaves priv->phy_np NULL and of_node_put(NULL) is a no-op.
> 
> There is no end-user visible symptom on currently supported platforms:
> a device_node is only freed once OF_DYNAMIC is enabled and the node has
> been detached, so on a static device tree the imbalance is inert.  It is
> observable as a refcount that grows across bind/unbind cycles, and would
> matter under device tree overlays.
> 
> Found by static analysis of reference acquire/release pairing rather
> than from a runtime report.  No reproducer was produced and the change
> has not been runtime tested; it is compile-tested only (arm64,
> CONFIG_SNI_NETSEC=m via COMPILE_TEST).
> 
> Fixes: 533dd11a12f6 ("net: socionext: Add Synquacer NetSec driver")
> Assisted-by: LLM
> Signed-off-by: Yige Jiang <yigejiang86@gmail.com>

Reviewed-by: Simon Horman <horms@kernel.org>

