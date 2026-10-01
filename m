Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E3D7352003;
	Thu,  1 Oct 2026 12:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790859263; cv=none; b=qlAZElPQ2ctVze4PmRQAtHvWndKPZP/7TuLV1AbV8nw8+mo9lQ9BS/ZkKYA64P0D0DhDCAVUYckkRctCvAUajG8s0OS5rEDuyLj0SiQkB9QHxHwXLuFo/cH0B7oQ1uz6L+aH4i/I2Sd8HY529MA5UrCn5pCnJOafFnFq+F6bZPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790859263; c=relaxed/simple;
	bh=FysRlPmutX8xqPMKVdPsKTshudlIPRhjWHqrTgXDy7w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i0Aczk1iu6fm85deYzoh7ceXY/2ToEIEmZCSqan9FLfhvFENTFczcLHCx3JueQXosTsS+dz3ar7GeNMNTy9Z46X2Mchbl9Ac0zqHG/t7Xh1LdWF0JPeyA2pyelufrkrrfDiDYLzOCkH0pvHTsN2M11+DX/6pOJRA6lK/quh4QKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z+egY17+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z+egY17+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA7611F000FF;
	Thu,  1 Oct 2026 12:54:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790859261;
	bh=5/rKKwhISCEq0Hr8V83vwSdvlurbUyLhYtlKG+3hPIY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Z+egY17+SrxZU9RWlbJkHlyazhx8PmlV0xDoZPDdtnl24Bw64DBtxwm0kvWTZA0e7
	 jj+Ss3JkSIo7bW0Z5fLvr3YMH0UcsC2DfKQb9GAKwLFh8uRM/vFjpzEjw9JKiGVyCz
	 ouMWPiSDhBleNy3IR0EUarrCZTjeDCK4gzK+laK0fY8RLYPMeQ4FD1tGg7Zi4MWgLb
	 T429Yl/kteO5QY9oUb4ZOQ4Iqm43/PitDS7jer/NT0jqkj2WlRuKmtMIas9hFFRRb4
	 9Be/kWDek6A0us5MOj0eQibJiwzcLSxLLIuaFaBgqP4RiK1uwk99G9WDKJVtYIG7og
	 iBoAmeqzPbQ2w==
Date: Thu, 1 Oct 2026 13:54:17 +0100
From: Simon Horman <horms@kernel.org>
To: vjardin@free.fr
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 2/2] dpaa2-eth: mark DPNIs without a DPMAC as
 virtual devlink ports
Message-ID: <20261001125417.GE13925@horms.kernel.org>
References: <20260928-for-upstream-dpaa2_ports-v2-0-1cda148530bf@free.fr>
 <20260928-for-upstream-dpaa2_ports-v2-2-1cda148530bf@free.fr>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260928-for-upstream-dpaa2_ports-v2-2-1cda148530bf@free.fr>

On Mon, Sep 28, 2026 at 01:22:46PM +0200, Vincent Jardin via B4 Relay wrote:
> From: Vincent Jardin <vjardin@free.fr>
> 
> A DPNI whose endpoint is not a DPMAC has no physical connector: it
> may have no endpoint at all, or be connected to another DPNI or to a
> DPSW port. Until now, such a DPNI was still registered as a physical
> devlink port with number 0, so userspace saw a physical port that does
> not exist.
> 
> Register these DPNIs as virtual devlink ports instead. A virtual port
> has no phys_port_name, so only the DPNIs that serve a DPMAC at probe
> time report one, "p<dpmac id>", and those names do not collide.
> 
> Signed-off-by: Vincent Jardin <vjardin@free.fr>

Reviewed-by: Simon Horman <horms@kernel.org>

