Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792851684;
	b=bSyyCmnT+KISoo3LHi9JDbD0TFfXCWcp+fGJeKIGA8tslbxilEq38TJD+iA/AUh3slR+
	 IrCpwIoXeEsQ2gn9jQs41lRgwqF+nXO+03I/89fm14WGgSw0xdJ1DQjeL3AJ4eFAjYrwh
	 YxkPbmlyTSszNg41R058FYNFm4SvKXwBXQc7Zz5ETI7SPizHbIhG46rXveFB/nq79W5Wg
	 fNb0WVFCKQyClKHv1u5w5L4sO/S1DpGvyknuLlzITEKLGVtD+CrUouItPIeGbopzp/9/u
	 +5FhWlUBoIGzX5M9JijKvBJ4PXACM7y+U2Bd1j2iyFAGcCAiYmJu8pvLMEK5F2pGoiA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792851684;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=ILKql1U17ZfYdbGh/o09NbbC6DxSQr/t8U530mCEIZ4=;
	b=vL+Vpb/F7YLRrG4CZi3P1bQg2NMRPg1YscwB1nVrFDvJLMbJTjuHnS8KzRvismw6skyN
	 Tuw19rn99kv23eG0P+6vvdTeQFm2OKM7F6o/96/z5Wja/XiBTjvcDf6Gjpt71/o8T5SmG
	 DUNwY5tvyYDTHNcsZLb/aN3z7qJaBz7nR6uzqgpIxjXeWw5EIK96EfPXzaaFdYOOea8FD
	 wAqECQYV66fDHnsQl7jSHRBKpghIlHcj/UGliFPXSVd2qqgnZNWedEsbGH+YhJvGnijZi
	 8ZGNEybV7Wy4BtTrhBpC7gb93btr34jD3+Ajep4sjL1rBwEAWAwKCARbwFtuah9FzRA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lunn.ch;
	spf=pass smtp.mailfrom=lunn.ch;
	dkim=pass header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=4NSztzYm;
	arc=none smtp.remote-ip=156.67.10.101
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 378B9606A31A
	for <netdev@vger.kernel.org>; Sat, 24 Oct 2026 14:21:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 378B9606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=4NSztzYm
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=ILKql1U17ZfYdbGh/o09NbbC6DxSQr/t8U530mCEIZ4=; b=4NSztzYm6XtVv+qtDLDx+cyrgn
	yYUNWMA44UPyKDo5O6TdcLrl2hrZ5bq6Rf/uTPKYVz7p5kCrhGlMz2hkXBrWXPvG9ZsyqJMuBj2CQ
	ToeFvmS3iCqhqtCwwFWfcp5+ov6K4ZSpu367ZZ/Szp/rvMeiL70qe2KeG1vZb0/P+0bk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xKccU-00CXf8-8R; Sat, 24 Oct 2026 16:21:14 +0200
Date: Sat, 24 Oct 2026 16:21:14 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: David Mestre <dev@davidmestre.net>
Cc: netdev@vger.kernel.org, linux@armlinux.org.uk
Subject: Re: [RFC net-next] net: sfp: add quirk for OEM SFP-2.5G-T-C
Message-ID: <1f015d68-c1b0-486d-8edf-bfc453f97f7c@lunn.ch>
References: <e0137c6e-7ecb-4b45-8108-70058f9906e1@davidmestre.net>
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
In-Reply-To: <e0137c6e-7ecb-4b45-8108-70058f9906e1@davidmestre.net>

On Fri, Oct 23, 2026 at 07:49:29PM +0200, David Mestre wrote:
> The OEM SFP-2.5G-T-C module needs the same fixed 2500BASE-X host link
> as the existing OEM SFP-2.5G-T entry. On a ZBT Z8803BE (MT7988),
> the module has no carrier with in-band autonegotiation enabled.
> Forcing 2500 Mbit/s, full duplex and autonegotiation off restores
> the link.
> 
> The existing OEM SFP-2.5G-T entry requires an exact part-name match,
> so it does not match the -C variant. Reuse its quirk for the exact
> additional part name.
> 
> Signed-off-by: David Mestre <dev@davidmestre.net>

This is something which could go via net, rather than net-next.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
