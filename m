Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93583200C2;
	Thu, 12 Feb 2026 17:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770918824; cv=none; b=R/6CP+Wbb7yFmn8WXH4YiXxRmtSEwoUBms96DmkDyTbj/QpH8rgFQZ6sXbEhCkzuRucp/rFJVlFx4BDbGBwXakIFb3Y4DGv1c7DajweeP1Ruj+HyXWyRv1FOWNMMOMis2nON2U6yyqO1SB5Ux8JdKIoJfMB5hJQKMwytgVeMy48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770918824; c=relaxed/simple;
	bh=ZwsAByPty+lTE4KYyectuJTv8ZOdcyIpbTH3QqcqjnY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d7Y+7d74Hzox0UJOIea9gwxUShOsoRzdlCqr4kZykHztX3aaXLG43dvH92tiRBMFvR00ZW6x6n9Z3sKTcoSObrp5C244gmSJemkAY/KhImoiMxmiBR3K6z6tzJSHPPBD7iTgVL4NAvWqp/zjzf82JaY75TyJKJkTgzL/58A6mxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=trWs5Slr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="trWs5Slr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00E1FC4CEF7;
	Thu, 12 Feb 2026 17:53:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770918824;
	bh=ZwsAByPty+lTE4KYyectuJTv8ZOdcyIpbTH3QqcqjnY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=trWs5SlrsmoR2B9g/1WisjJh3lx4QRifD3oG3j6OvCHKmsS81sQUemKNKte6ZcfvL
	 hYi0onICvtPKHsKRoAupiPGwshr6K8rJYJS4+P9Gqu8XAwJN02lySHtWixGJ0NtK2j
	 3mZ8YhQIas6ym4fhmg9a3GS0ol8mZX/3amNNFpSMGdB83kutFCr7P7YnMVn/UhkG1H
	 an8+z4oAh9EkaYRIimum2W2KrlkQwjJw9qlymRkjxlvvWanQSmOpFeXj1huZuRm/3j
	 bmMrCy8D48PUuolOoA5AKiOPChvPTkuTvuFu+v/Q7O9W1YD4LMa2x1ydJ9EX7hgZFZ
	 Pub7zi7PgEZPQ==
Date: Thu, 12 Feb 2026 17:53:39 +0000
From: Simon Horman <horms@kernel.org>
To: Daniel Machon <daniel.machon@microchip.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Steen Hegelund <Steen.Hegelund@microchip.com>,
	UNGLinuxDriver@microchip.com, netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: sparx5/lan969x: fix DWRR cost max to match
 hardware register width
Message-ID: <aY4TozfU1piv40Nh@horms.kernel.org>
References: <20260210-sparx5-fix-dwrr-cost-max-v1-1-58fbdbc25652@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260210-sparx5-fix-dwrr-cost-max-v1-1-58fbdbc25652@microchip.com>

On Tue, Feb 10, 2026 at 02:44:01PM +0100, Daniel Machon wrote:
> DWRR (Deficit Weighted Round Robin) scheduling distributes bandwidth
> across traffic classes based on per-queue cost values, where lower cost
> means higher bandwidth share.
> 
> The SPX5_DWRR_COST_MAX constant is 63 (6 bits) but the hardware
> register field HSCH_DWRR_ENTRY_DWRR_COST is GENMASK(24, 20), only
> 5 bits wide (max 31). This causes sparx5_weight_to_hw_cost() to
> compute cost values that silently overflow via FIELD_PREP, resulting
> in incorrect scheduling weights.
> 
> Set SPX5_DWRR_COST_MAX to 31 to match the hardware register width.
> 
> Fixes: 211225428d65 ("net: microchip: sparx5: add support for offloading ets qdisc")
> Signed-off-by: Daniel Machon <daniel.machon@microchip.com>

Reviewed-by: Simon Horman <horms@kernel.org>

