Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 934A73B6BF4;
	Thu, 24 Sep 2026 15:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790263726; cv=none; b=C05Gqi/2NFtj8RBSBHn8F4hG9zyWXwHYdNYNhouRz3QmxCt/oBpySMXXJC1b01fb83YZ8jO51lViSjX2QaUfTo6CoTYcWFWA4YXprq26w51MnFD7ssuQ5vZ6jAwQYf/MDG0kfcAZtUjcEDibragM9+FQfwtOmqsfLP/R+h4G6bY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790263726; c=relaxed/simple;
	bh=agKgS6per3DPTKo/oSIPvzyV++2D6qGAcSu7hYSESwM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N/NrIHFsO7dBS8eH970o5IJmxKhB/SH5x+Rj/MEch2cOQAO29gUQ+JklFCNqmn0LMfjFaGXCdddxl9WGQ/P61PZnhvsn2DtTYSlIsPi026368uAP98uLoKpVyURbg5Cj948/+jB6pjfetgQRhigjZ4E2xtCMeSsps7RNkh+eb8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kvYGijbZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kvYGijbZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D8D51F000FF;
	Thu, 24 Sep 2026 15:28:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790263724;
	bh=gRDrDqRSTSu1wAuAiMUnEXEYN6plI8hGn4/iodplTGo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=kvYGijbZcCWStjUumZ6i+KPYNbP0jIqli6M7dl/dHMn67wi85o0zhoAPxRDnbKfSh
	 Tp7VWtUsZhQ3gRJjdzmodCsGU5TgfQqDwIZiyNDegT4CXV2FFrWJ6I1vXn2dRVzA+w
	 tIn5vW/DybS4iTzSEKIeH1iajfTl+nYPZgeCawsUmIlsmNPi0gI1uZgwUMjQfOrHuR
	 SQpYxvXvQqHhAcnEI5F1Q5GpSuG5ZYQTifv7rY6xwP5GneSX1c6eZCtj3p93Q7Xawv
	 QKCWZzjA7ea6bgsZ98hY3cZNrvCyynQDbBykR/rrF6Guer+aH/v/6GjJBAmW/9rOrJ
	 yH+YFXvbUHriw==
Date: Thu, 24 Sep 2026 10:28:42 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Simon Horman <horms@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, linux-kernel@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	"Chester A. Unal" <chester.a.unal@arinc9.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Lee Jones <lee@kernel.org>, devicetree@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	Vladimir Oltean <olteanv@gmail.com>,
	Daniel Golle <daniel@makrotopia.org>, mfd@lists.linux.dev
Subject: Re: [PATCH net-next v22 3/9] dt-bindings: mfd: Document support for
 Airoha AN8855 Switch SoC
Message-ID: <179026372208.171717.56830935141482934.robh@kernel.org>
References: <20260915123812.14747-1-ansuelsmth@gmail.com>
 <20260915123812.14747-4-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260915123812.14747-4-ansuelsmth@gmail.com>


On Tue, 15 Sep 2026 14:38:00 +0200, Christian Marangi wrote:
> Document support for Airoha AN8855 Switch SoC. This SoC expose various
> peripherals like an Ethernet Switch, a NVMEM provider and Ethernet PHYs.
> 
> It does also support i2c and timers but those are not currently
> supported/used.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>  .../bindings/mfd/airoha,an8855.yaml           | 176 ++++++++++++++++++
>  1 file changed, 176 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/airoha,an8855.yaml
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

