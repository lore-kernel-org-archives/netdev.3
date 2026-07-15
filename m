Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A604B43990B
	for <netdev@vger.kernel.org>; Wed, 15 Jul 2026 19:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784142582; cv=none; b=Sjp5Oq4V/iq18CNcLdluIz/F2/eBi59/cuOBjw4bwb2lZDcZshJsXAsjyXqvU/CzV2DOuyiv0PQmDb/Dsvqb626mswMhbpaSvIzBUyVSYi+8GoOrSljRIK/VhoDQ25SSEkbYw4eVEghiKuJ4Fa8cO5Obazjf+rUYsLq+Tv4fYJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784142582; c=relaxed/simple;
	bh=mXkPZEIbeQOk6mOTFR7T7PIlvVf2BjplyEwi4uhvqEY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JOjc5SmFfeKeXkLNGydzOf/mo51Ex0yfGyapHRhOoUnS9+UC4DKDiAA+eTz+DcY55TvsjZixVcx6NUtYoErdzVc+u93TZzgs4I6tuFyjdyQSj2PJgtwGP3DyNIg9Jqn7QwdUC9LokDMekcqF3SIK4lU1K3zneLyXStXwCKNYvt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=lK1oAD5o; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="lK1oAD5o"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=HqlNLjfGzsfBsfMl2+XQaGNo9121NZIpj1yI1N1FQvk=; b=lK1oAD5ocvKMFk6JCeQRXWejpD
	gu5jpFTkvBSmmN9KV7uh+HeorRo3QIsKSXaFjj0J2oQ9n9oS7gnb2vldpJhx1ddiOEDbD6k5FeKs+
	5KCf0SGg1wK6n9Rj293V7rpF6sTpWNEj3pXBmmBUVBX7U5dCBhHF8TtogQII9sU4sdtM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wk4yq-00CPGu-M5; Wed, 15 Jul 2026 21:09:16 +0200
Date: Wed, 15 Jul 2026 21:09:16 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Simon Dietz <simon.dietz@plantwatch.de>
Cc: netdev@vger.kernel.org, edumazet@google.com, davem@davemloft.net,
	kuniyu@google.com, dietz23838@hs-ansbach.de
Subject: Re: [RFC PATCH net-next 0/6] net: add GeoNetworking protocol
Message-ID: <a1440c5d-2848-4587-a2c8-b3d65dd4272a@lunn.ch>
References: <20260715124548.509568-1-simon.dietz@plantwatch.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260715124548.509568-1-simon.dietz@plantwatch.de>

On Wed, Jul 15, 2026 at 02:45:40PM +0200, Simon Dietz wrote:
> Implement the GeoNetworking / ETSI ITS-G5 ('net/gn') protocol which
> is based on 802.11p wifi and used for vehicle2x applications. It is
> standardized by the ETSI and used by some car manufacturers
> (especially in europe). It enables ad-hoc, multi-hop geographical
> communication and routing among vehicles (and road- or railside
> infrastructure).

It looks like only the cover letter made it to the list, not the
patches.

If this is based on 802.11, you probably also want to include
linux-wireless list and the 802.11 Maintainers.

	Andrew
