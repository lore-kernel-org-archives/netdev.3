Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792520085;
	b=2XokDx3SOxQaRMLcPhVUnQrC5R2y8swXmZEW9Y6A4qtHppRwXycNJpx1xqjtTM71ayyG
	 uLcgLoKGR3YM/XwiHxKG1G1fsglOEDfko0wo+4kjo6WSIqFhWvWjNFGVBbH+4cYvhNI+W
	 P372qJewwwdHvswM31bXid/yKWq9Q1Xor9DgLdTy3UVM3DO7kjPmwdQ/C1zqNazpCPKfP
	 6Nzvi4Sn9KKVq+9dS/Z/SdPBIF4kEV+DnY3aUzN0BNd+lkX1qxnL5XPga6wCxqq6X4BVt
	 dfF39pwRir5iT388+jd0cRHZfJaQEJD0xA+eZSowDtG7BtuBiFwldVrLQbFnZWoaAqA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792520085;
	h=Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=uK7yicMd7fV27ely5ePv4vfAPSKVcR6O+lt+i4O5dkU=;
	b=xPAM/ua+N7zBO53Msg4y0dlR5o2nrN2Oj7QHJsj9D4oNWGW91RiKs3rc1S5Ux4j5gQKZ
	 /pP2rRQB7ghupYMVVKxy+a3R5O0L6VkxzcChH9jfIb8VJwnOjopYhhD6cEBOuinUk96ub
	 FQ3tapsp4bzj8tRaZ1rmAoLBaIPCLdPmyNWsg5DUjkor5aSZne+oS/x8A+ZxAtTEAPta+
	 yhED3svb6GjqeMb6ZayUOT5KDJWAMUiy0cVkZJDZT5BYj1UR0PFQ5uWd6z73aI9wN8DEy
	 1keiyRQiQhP/v4b2OmtcqEoLNYS/GKT86piM5L3AKfr1fgnjULiy3YhtpDbOzYTF/2A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16155606A31E;
	Tue, 20 Oct 2026 18:14:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 983261F000C9;
	Tue, 20 Oct 2026 18:14:44 +0000 (UTC)
Date: Tue, 20 Oct 2026 13:14:41 -0500
From: Rob Herring <robh@kernel.org>
To: Jacky Chou <jacky_chou@aspeedtech.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Po-Yu Chuang <ratbert@faraday-tech.com>,
	Eric Dumazet <edumazet@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v4 1/7] dt-bindings: net: ftgmac100: Make Aspeed
 compatibles standalone
Message-ID: <20261020181441.GA510274-robh@kernel.org>
References: <20261020-support_ast2700-v4-0-4d36b40939b3@aspeedtech.com>
 <20261020-support_ast2700-v4-1-4d36b40939b3@aspeedtech.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261020-support_ast2700-v4-1-4d36b40939b3@aspeedtech.com>

On Tue, Oct 20, 2026 at 07:34:12PM +0800, Jacky Chou wrote:
> The aspeed,ast2400-mac, aspeed,ast2500-mac, and aspeed,ast2600-mac
> compatibles are currently only valid when paired with the generic
> "faraday,ftgmac100" fallback: if a node ever bound through the
> generic entry alone, ftgmac100_probe() would set
> rxdes0_edorr_mask/txdes0_edotr_mask to BIT(15) instead of the Aspeed
> BIT(30), skip Aspeed clock setup, and leave the DMA mask too narrow.
> 
> Make each of them a standalone compatible instead, so none of the
> Aspeed compatibles require the generic fallback alongside them.
> 
> Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
> 
> ---
> ftgmac100_of_match[] has had dedicated entries for AST2400, AST2500,
> and AST2600 since commit 03a2aba50b2c ("net: ftgmac100: List all
> compatibles"), so there is no known kernel + devicetree combination
> where a node has actually bound through the generic entry and gotten
> the wrong EDORR bit. This part is a binding correctness fix, not a fix
> for an observed failure.
> 
> Note that arch/arm/boot/dts/aspeed/aspeed-g4.dtsi, aspeed-g5.dtsi, and
> aspeed-g6.dtsi still declare their MAC nodes with the two-string
> "aspeed,astXXXX-mac", "faraday,ftgmac100" compatible, so this will make
> dtbs_check warn against those files until the redundant fallback
> compatible is dropped there as well. That .dtsi change will be sent as
> a separate series through the Aspeed/arm-soc tree, since dt-bindings
> changes don't go through that tree.

No. This just creates unnecessary warnings even if only temporary.

What a driver uses doesn't matter. That can evolve over time, but that 
doesn't mean we change the DT schema.

Rob
