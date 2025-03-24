Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28E0B10F1;
	Mon, 24 Mar 2025 14:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742827195; cv=none; b=nVXuwXsOq3b2LNp6oPlT7U5Mkaf3KUYzVMQrBaxDMOuwGJcKmR0/8+4Eq+gq5r5MjflmG/9pizQRrUP1CgfemaQ0SwyKcBEb1Gx5EBoVSTr7YnNz2PTLB1mwmpzBdXicDZWhqPUj3dx/bcgdGr3x2VaSiWGdDRfFeKCTodE5vOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742827195; c=relaxed/simple;
	bh=3lXO4OPAJR68/q4fbUETtcYDiWzIV3gLjNKEwnazdrs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kgtPuh98PBWzoOAf/o+NovCXlD+CgfD5Bh/EXZgiT9iUDWuNuMZAE7IHVS2uKbEP4pCdi5WfqXCYDIf5OfRB5xVLtiX3+MOSBpCfy0VB/uKuPe0DUFw5uyvSRktxN1ert0FGFuvx+Il1thI2l8WkCW203FCBZ3Xe0i24K8Maz00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TG9M6SQ1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TG9M6SQ1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AE51C4CEE9;
	Mon, 24 Mar 2025 14:39:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742827194;
	bh=3lXO4OPAJR68/q4fbUETtcYDiWzIV3gLjNKEwnazdrs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TG9M6SQ14DpAyW1qmtpbS0GPeMoJ1n04QLU5AeWtP93ShwbDKW7JYmuieZDYRojfJ
	 0WQ0kN5yWgT2PmEwBMSbjQKUyb1o6A/9kLUMTRkvHzQhMxvIwQWq7MGPSfdIfwBrJP
	 eqiC5NNJWmBmTXyBmUE5gwvAw7gHmw4lvallzJXRkX6EEQpuWQpWt3KEBj8wJmQfsj
	 k60F6xmWMWRvhhuRP8fB+j6quuvs9eWV7v4pDM9nZpnsbYk8IAl21lWz9YtIbRoV5B
	 RDClcVl2EqTWx0BasWfWCzc2MOfApNkXLUSwkb6IKjSB/a7UVigF4KGVPtIuGtDn3S
	 cpldF3/BW6q0A==
Date: Mon, 24 Mar 2025 09:39:53 -0500
From: Rob Herring <robh@kernel.org>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: Rasmus Villemoes <ravi@prevas.dk>,
	Colin Foster <colin.foster@in-advantage.com>,
	devicetree@vger.kernel.org,
	Felix Blix Everberg <felix.blix@prevas.dk>, netdev@vger.kernel.org
Subject: Re: [PATCH 2/2] dt-bindings: net: mscc,vsc7514-switch: allow
 specifying 'phys' for switch ports
Message-ID: <20250324143953.GA11614-robh@kernel.org>
References: <20250324085506.55916-1-ravi@prevas.dk>
 <20250324085506.55916-3-ravi@prevas.dk>
 <20250324100055.rqx4rle6fdtn7dg2@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250324100055.rqx4rle6fdtn7dg2@skbuf>

On Mon, Mar 24, 2025 at 12:00:55PM +0200, Vladimir Oltean wrote:
> On Mon, Mar 24, 2025 at 09:55:06AM +0100, Rasmus Villemoes wrote:
> > Ports that use SGMII / QSGMII to interface to external phys (or as
> > fixed-link to a cpu mac) need to configure the internal SerDes
> > interface appropriately. Allow an optional 'phys' property to describe
> > those relationships.
> > 
> > Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
> > ---
> 
> Oops... I had thought 'phys' and 'phy-names' would be part of
> Documentation/devicetree/bindings/net/ethernet-controller.yaml...
> 
> By the way, should you also accept 'phy-names' in the binding?

No. There's only 1 phy, so not needed.
