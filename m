Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17A2D345ECD;
	Wed, 12 Aug 2026 03:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786504153; cv=none; b=i76RIIRJJZQiOnWKA+tx341B6ww7Ydksr/rBIOD6VGWl9D3FM4xTFZ+/gIkLV0ofE0htk3GOCIU8iANC9QDv8VZtGD8mAwwSzS7crrUNc3wEbKh/EUAfUVzlYcFkKX5uKb1Edl8CnxAevsC225R7tHxWXPyVJWtGATifLoxaa9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786504153; c=relaxed/simple;
	bh=36CUSExhNmUNV45CdFvF7jAP2tEN5nFaZut6iMJQSiU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XH9JvDmrruffr7ZeyRHTA8rOjS8YeWSVSyRm2ArO2ohcSG/vniQtBm80PLzfk4G/Ogrf8k/WGhfl/MCO8gs+FsxM6NlvcM0o+NKcNazsrRy6HWSK4m1eE/jdRjl08xfzzkRpS4jUL4cKBLMXrIqi82P+ttWor0GpAbGnIS1I4rI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UI0oQMOq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UI0oQMOq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 392BB1F000E9;
	Wed, 12 Aug 2026 03:09:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786504151;
	bh=Wq84iKL6ygCiqJNdxYyZKwxW2cAVvh8TSQKqYwcZIsA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=UI0oQMOq8J4lT7ZxYWnt7iJe8XtrPaGn69ki5MObrDpjOySp1gDePDUSqdTgCKfF8
	 LB4gqrSoEu/QbEIV9iCIZwfkXqPDB4cMjjvxzMNezNAlhX8ZYAgxQkLLuR+p8vokrr
	 jGl/J2xJV0+RpNKeBgYzqacUtmvoogvvRptTZNo4LzmWHXK1bFLraCLRbmRhZzGdRj
	 IIk08qPZ+jbYf+Eg6eI79EF6HRDhNiFg0H3VGuehuSBTkPhgFc7BVFs2M5BIerb+EQ
	 EXlBAwVGAIQy3yq2IpEcNvJMukBZHAGVJPnO0ujbTBkAlw0ZhATobsNDy+obRjMwXU
	 3JYbK9XJEr3qA==
Date: Tue, 11 Aug 2026 22:09:10 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Suraj Gupta <suraj.gupta2@amd.com>
Cc: Danilo Krummrich <dakr@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
	Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>,
	Brian Masney <bmasney@redhat.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, Michal Simek <michal.simek@amd.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	driver-core@lists.linux.dev,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	"David S . Miller" <davem@davemloft.net>
Subject: Re: [PATCH net-next v2 3/7] dt-bindings: net: xlnx,xxv-ethernet: Add
 Xilinx XXV 10G/25G Ethernet
Message-ID: <178650415010.657438.15353116551924864643.robh@kernel.org>
References: <20260723123838.125145-1-suraj.gupta2@amd.com>
 <20260806181153.1213996-1-suraj.gupta2@amd.com>
 <20260806181153.1213996-4-suraj.gupta2@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260806181153.1213996-4-suraj.gupta2@amd.com>


On Thu, 06 Aug 2026 23:41:49 +0530, Suraj Gupta wrote:
> The XXV Ethernet IP integrates a 10G/25G Ethernet MAC with an in-core
> PCS/PMA driving a high-speed serial transceiver. Its payload is moved by
> an external AXI DMA (or multichannel DMA) controller referenced through
> the dmas/dma-names properties. Document the IP in a dedicated schema
> file.
> 
> Add the "xlnx,xxv-ethernet-1.0" compatible with the 10gbase-r and
> 25gbase-r phy-modes, the rx_core/drp/s_axi clocks and the AXI DMA
> channel properties.
> 
> Signed-off-by: Suraj Gupta <suraj.gupta2@amd.com>
> ---
>  .../bindings/net/xlnx,xxv-ethernet.yaml       | 107 ++++++++++++++++++
>  MAINTAINERS                                   |   1 +
>  2 files changed, 108 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/xlnx,xxv-ethernet.yaml
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

