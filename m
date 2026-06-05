Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B51643D5C06;
	Fri,  5 Jun 2026 15:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780675200; cv=none; b=qPaw8KAHOUa8hvurvAMuKogxXkdNo52Dwl5Q9NdmKToaojGnzMOeVRr/HBJCuhDlOqsIjgcpDBOAP5gLXGFOhmcZSiC6Pw38yqAg47OdFOnJ5TPrUxYinIu/a54CvwoVagrBIIN4n7TKLcELaDbdcr1ToSEueNpHv7jJgcUdjME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780675200; c=relaxed/simple;
	bh=yCAGbq/6JlyTZp4QI10TckEayK0yDn1kPsMjsDABZF4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M/xP3qwl3yrnMJEVjdmOX1v4ANHsA539y82rXu3qia59vQSqL7WQ2Uta9KZ6r7/HYXJx0Div6kgkaDnK7nCsfJQtUgGnC0z9WWa/Yo3m3Hat90LNeG80P/fj+FyI1eet2xB7tRsE4SHgV0W3ml3PJBswbKX4AyiFUHmTviEGkXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VRmTccUp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VRmTccUp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB3551F00893;
	Fri,  5 Jun 2026 15:59:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780675197;
	bh=ObS4SJI1Hi4ANlAVGEHF39GV4a6SL8/PZg5/oxRIZLA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=VRmTccUpapuDZg1/Vo2DsF06NMWmciMkNXi/GgmSGq3xx93DqVQHxLpPk4g/WCV2U
	 EspohMbt6QuyOFDYwEftJjiC9mwsZYm1zh5s3g/Pc0pFxvQflbAmZYMIfLguDRvKZC
	 KdVcyQGeu6j+/RCkux/B2CP/JSz/gX06GALj81XaV4nmYmdQipIGfMFSPlPS2e5WQ0
	 jGfhtTpvcey86tuJk/JvHD4lta2OBBcHqx41l52ANQtq+cMXyqSwl8vTarHNdfJnc7
	 /N4o+bCi3Menj58/hh6WGqLKKa6Vyd9sI7jNHJtDqvCvram8JzqRLePprdObZ7zYEB
	 BZ3vvnXgLpOAA==
Date: Fri, 5 Jun 2026 10:59:56 -0500
From: Rob Herring <robh@kernel.org>
To: George Moussalem <george.moussalem@outlook.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v3 1/4] dt-bindings: net: ethernet-phy: increase max
 clock count to two
Message-ID: <20260605155956.GA3788055-robh@kernel.org>
References: <20260605-ipq5018-gephy-clocks-v3-0-f232d9ca0966@outlook.com>
 <20260605-ipq5018-gephy-clocks-v3-1-f232d9ca0966@outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260605-ipq5018-gephy-clocks-v3-1-f232d9ca0966@outlook.com>

On Fri, Jun 05, 2026 at 04:41:26PM +0400, George Moussalem wrote:
> The clocks property has a restriction to maximum one.
> Yet, some PHYs may require more than 1 clock such as the IPQ5018 PHY
> which requires two clocks for RX and TX. As such, increase maxItems to
> two.
> 
> Signed-off-by: George Moussalem <george.moussalem@outlook.com>
> ---
> Commit 350b7a258f20 introduced the clocks property with a restriction to
> maximum 1 to the main ethernet-phy.yaml binding for Realtek to add an
> optional external clock source. This is restrictive to all PHY bindings,
> as some PHYs may require more than 1 clock such as the IPQ5018 PHY which
> requires 2 clocks (for RX and TX).
> ---
>  Documentation/devicetree/bindings/net/ethernet-phy.yaml | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
