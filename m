Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DA6D493627;
	Thu,  1 Oct 2026 12:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790859245; cv=none; b=ocBwngssAQ5bR1tzRblcHkhfOdfKgH5cDHXv5jCe+ZgFkq9HkKAEjv1eV9r/Y7VJu2VXMPUJRjnReoboQditbVx+3ZMzBVctnA2SzMTin+Beq2XIkM59Eh+pO1DyAbIWpKdB/ohFvB+sIARW0ZyTgpYTSorKc3DHb94scmisk60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790859245; c=relaxed/simple;
	bh=KU5OabYAFrKdFg1yhf5P8/GinTscazvaJv/8SdrY/TI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cDhZzCXeFuKoxNgIBfoiVyQqxB6+qAYVSH/ixaWDsra+5INba/tcWJRQp3sk+emeCicZrwTzqhJovNfNm4xXAWPByYLPr/7eO5XIQERVf4h8SsuMIQLm+VfGRVUMkN2kdVaTYM/ipcv7BcAxXGuosA9NmFLZadGaXmfJ2VaxOkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WL0U/z5G; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WL0U/z5G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E98471F000FF;
	Thu,  1 Oct 2026 12:54:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790859243;
	bh=HxSHK+B3XkiABUMvJgcMEA9+eWGuaPI3Ux8Wop7fDLw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=WL0U/z5GQzihTfH09gBpxJys+VnSsH64p4SKS8yJsPBJjK3pWaBwz4ymmjUfKEmH6
	 eEkDavowjS+0wa9G0k6a/B+Dcq8YmcFQu3XcKG+WcPXG1kcxKx5aJJwrvrFToVW94c
	 dti5dH9F7ARWHcpcN+IXrnqgdwzSzD1th4kmQsmfH1lAl6dn2K901zogSba5BxKKln
	 wJWpKvnIJ1hx4ZiFxVaV/tYUbephmo7j+OD/qxNq5H8vXqWb96hzzvuu43ylGbe/sT
	 wJOf2rc2iJQVharnu73j0Dq6Bf+fAho1/+2T8z9HsRHoI6EbB9SJd3pMoRf/em5dVX
	 920uVNDLgLKzA==
Date: Thu, 1 Oct 2026 13:53:59 +0100
From: Simon Horman <horms@kernel.org>
To: vjardin@free.fr
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 1/2] dpaa2-eth: use the DPMAC id as the
 devlink physical port number
Message-ID: <20261001125359.GD13925@horms.kernel.org>
References: <20260928-for-upstream-dpaa2_ports-v2-0-1cda148530bf@free.fr>
 <20260928-for-upstream-dpaa2_ports-v2-1-1cda148530bf@free.fr>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260928-for-upstream-dpaa2_ports-v2-1-1cda148530bf@free.fr>

On Mon, Sep 28, 2026 at 01:22:45PM +0200, Vincent Jardin via B4 Relay wrote:
> From: Vincent Jardin <vjardin@free.fr>
> 
> dpaa2-eth registers every DPNI as a devlink port of flavour physical
> without setting a port number. All DPAA2 interfaces report the same
> phys_port_name, p0 (see devlink port show).
> 
> The DPNI endpoint can change at runtime while the attributes of a
> registered devlink port cannot, so log a warning when it happens.
> 
> Another benefit: udev rules can match ATTR{phys_port_name} to name an
> interface based on its DPMAC.
> 
> Signed-off-by: Vincent Jardin <vjardin@free.fr>

Reviewed-by: Simon Horman <horms@kernel.org>

