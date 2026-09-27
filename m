Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5904B2C21E6;
	Sun, 27 Sep 2026 19:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790535746; cv=none; b=uP11WtOLDZcGNdF4E5MQGH1l0k8EL9k554htHb6MeOvIxXq93P+hdvruWPrXZSMMm8zMlhYdcmjw+I9RpdNYkbn1p+ZQzB4Pb3/Y5VPHBWYtbaFUqE5Y7FyFf49l7RbUCX2cQj6EeTcrf/yTyzjVa0+DwHivn/idTqPrTeEKnEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790535746; c=relaxed/simple;
	bh=bmZUXxIZqy0apceeyZkO/5n1tNNDoZ4axqt4nUT1I9I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gN/69XhpgYtIGwfTOmkwZlEb6wZ3wiFpl9RzyFs3CPF5s/+VgxTc9GvspIxGr4HymZ3DiM3o709Aw9TiDVu+m18D+Nz90ufeJ6rPtiqx56CNOBrrF5OYaUNeftDskgocMFQSoq1FOQ050ubPedSu3mDo96qRSH1gCEHAmsSNEFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=GXE3mkqR; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="GXE3mkqR"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=UQrtppGpAREwEBox3klCIQcjsYbUf0EeTuSwQEhRl+0=; b=GXE3mkqRY/t8zgm8M7PViX9qlw
	2P5+5y4FfOjpjW3YAfRO/RNQR2B+mjHhHaLVo3V2PgXSwur4ZbiWg79L3t/UZde82dIYBCQgljmVE
	MS+vGcDHhJ/arNtWKId8I4qV50ynJtihdgrIfdpN+Ohg7VE/tKgxabpA7UB6mN3tPwX8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xAu8X-007YUJ-0o; Sun, 27 Sep 2026 21:02:09 +0200
Date: Sun, 27 Sep 2026 21:02:09 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"Chester A. Unal" <chester.a.unal@arinc9.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Simon Horman <horms@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	mfd@lists.linux.dev, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v23 8/9] net: dsa: mt7530: generalize and move
 common function to lib module
Message-ID: <cd200dee-1bde-4cc2-a296-c93d704cb906@lunn.ch>
References: <20260925182435.21207-1-ansuelsmth@gmail.com>
 <20260925182435.21207-9-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260925182435.21207-9-ansuelsmth@gmail.com>

On Fri, Sep 25, 2026 at 08:24:30PM +0200, Christian Marangi wrote:
> In preparation of support of DSA Switch from Airoha, create a mt7530
> library module and move there all the common function.
> 
> Function are generalized to use the reg_field regmap API but still apply
> the same exact logic. Every function is renamed to mt7530_lib prefix to
> better identify it.
> 
> Minimum modification are needed to the register header and common enum and
> macro are moved to the mt7530 library header to permit reuse.
> 
> A library struct is introduced with everything required for the common
> functions.
> 
> The generalization and the introduction of reg_field regmap API have the
> side effect of permitting to clean the mirror functions that required
> special handling for MT7530 and MT7531 based switch that had different
> registers. This is done by declaring a common MT7530 reg_field and a
> specific one in the Switch match table.
> 
> No behaviour change is expected by this change as it's just a code move and
> reimplementation.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>  drivers/net/dsa/Kconfig       |    4 +
>  drivers/net/dsa/Makefile      |    1 +
>  drivers/net/dsa/mt7530-lib.c  | 1128 +++++++++++++++++++++++++++
>  drivers/net/dsa/mt7530-lib.h  |  391 ++++++++++
>  drivers/net/dsa/mt7530-mdio.c |    4 +
>  drivers/net/dsa/mt7530-mmio.c |    4 +
>  drivers/net/dsa/mt7530.c      | 1368 ++++++++-------------------------
>  drivers/net/dsa/mt7530.h      |  256 ++----

The number of mt* file keep going up. Is it time to move it into a
subdirectory?

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
