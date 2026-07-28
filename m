Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 392DE25A2DD;
	Tue, 28 Jul 2026 13:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785246965; cv=none; b=Y4p/39s0QG26rWgYtSNSktZvuX0ismyLmy78/jhGcOsbLbG7VzBYE9EtKWllHIwG9ZNztWMB8cPCnGKUTBs+AW9OScmAwgQsWUiwi0ieyiwkwV94dIv/xgKknSOPS1fX41VPu8CDgFXQE8qlYqpw091qqgyt6USAlFhi65v6dtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785246965; c=relaxed/simple;
	bh=5jqEUx08eAE2J34aNEz/+vzJmjFtiMTEUqSFxvnq/qo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YD1lway/SE8OFzcnmuruIHeKpfWe/P6zIQF6BlMnNOGwz05GLQJ1AFjJusMMbteYX+QX0ENSKMS6hBKmh03aAB0CJmf9CZHuZJ8zL6Sp+6q402Z9oPEt+18mENMSfmroMtke9mS6UJQtNHUNn7kje+KJTqCjOaOfAFdX4935HYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WympEKji; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WympEKji"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A87501F00A3A;
	Tue, 28 Jul 2026 13:56:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785246963;
	bh=8AIcAbR0xjsaYfJnIWcSClSS5upVh0OYFPPy2rQ/0vE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=WympEKjis5WhwlRHSKY1ULD7cjbDdEigV7OJN3bFHVZKe2eKTL72HSCwTBowULdUt
	 ska7DC6i+JQ/yNgg4Fdk/H+VSHaKNZRZJ2JUqIB3wRkCf/PMOQ8tq0Io9L7IyM0S7l
	 YdIGx/iH7M1oO0jAlJ8ilVX4Row0VR5PR/OAygH4BeT45iIhaQWtm9y+npqrdRuX0e
	 me//+EW3RSq2oiYdATa9Y+8lVUrOUCuUc9kdyJX03Yfsl8lKlozie7lSkRGYxo8ENz
	 Kk2pYaJsyfI5cnBONqVhOPgF27pqIJ74PlzZzYlrgnKAmmZWPZy6R3GUbJkAx0f8xM
	 ubqZcXbOVHZqg==
Date: Tue, 28 Jul 2026 08:56:03 -0500
From: Rob Herring <robh@kernel.org>
To: Suraj Gupta <suraj.gupta2@amd.com>
Cc: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Michal Simek <michal.simek@amd.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Shyam Pandey <radhey.shyam.pandey@xilinx.com>,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
	linux-doc@vger.kernel.org, driver-core@lists.linux.dev,
	linux-kernel@vger.kernel.org, harini.katakam@amd.com
Subject: Re: [PATCH net-next 3/7] dt-bindings: net: xlnx,axi-ethernet: Add
 10G/25G (XXV) ethernet
Message-ID: <20260728135603.GA1807237-robh@kernel.org>
References: <20260723123838.125145-1-suraj.gupta2@amd.com>
 <20260723123838.125145-4-suraj.gupta2@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260723123838.125145-4-suraj.gupta2@amd.com>

On Thu, Jul 23, 2026 at 06:08:34PM +0530, Suraj Gupta wrote:
> The XXV Ethernet IP integrates a 10G/25G Ethernet MAC with an in-core
> PCS/PMA driving a high-speed serial transceiver. Extend the existing
> xlnx,axi-ethernet binding to describe it.
> 
> Add the "xlnx,xxv-ethernet-1.0" compatible and make the resource
> requirements conditional based on the XXV compatible string:
> 
>   - "dmas", "dma-names", and "phy-mode" are required.
>   - Interrupt properties are not required as it does not have a dedicated
>     Ethernet core interrupt.
>   - "phy-handle" is not required as it has internal PCS and PMA.
>   - Add the 10gbase-r and 25gbase-r phy-mode values used by XXV.
> Annotate the existing compatibles, generalise the title to cover both
> variants, and add an example node for XXV.
> 
> Define properties at top level per binding style and use if/then to
> constrain requirements and phy-mode per compatible. Forbid 1G-only and
> unused ethernet-controller properties on XXV nodes.

This looks to me like it should be its own schema file. The only shared 
part is dmas/dma-names.

Rob
