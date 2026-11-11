Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794405049;
	b=YrerKSM9/WMhY6fE0IkgUACay8n0rMlXNgEBIrHPOHQef+ZnscKI8gwet1zAxlD7CqX3
	 5nEPfDn5ByYIVH78cjFk+VhdoajjN46R/6kN7e2pOsuLkwSv+S7bypf/WuV0e5yFf2K6Z
	 f++P0ibVlQRnhT6wEmSCakZNQlP8tj3ooYCioDWFOo5k2GBAUCIWdut6rbJWY9f47KTUf
	 tXL11E+sVW2IiL3G/2vHUGy6Hei3fTR9P3+qublCB5sY7RIoGeLEv+ZxveGAy/qBUFgQ0
	 KXyqoz42cCeIMdpBVGKFc2dYvuGn/Rh2BsemIdurWL27uydub8kXUmIEknGqemT3b9A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794405049;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=3IHYneG0XiL9m1fVv7YUKi9/nFsKN9f9thYm/Fr3gw0=;
	b=D7kcuppHToRAXTjCKA4tEAcZsuL2C3TwKMBxi2xT1djQyfskuGNI/aC6HeWT/PA92yOd
	 aHre90nw3lFTEdoQqeGc4lRnqJRI2tFpsWfuVBSvyMPqGX6fursDXjdg9gY01S+YJf/jO
	 yNdChGf3ad5XDald2hRsUj0D1wYXzQEZZXd2vZsKrTNpQRNugw2aGSAWBgjGrSbHekkjO
	 PLw4qwPVb2lhCkjTtCmX+kKKBCAFugwrJ4B4OQwdeo5HHZKsq7tZ++GDE9Mx6FDhVmwWz
	 Bh9BdedHkVhNYBx9sSlXgUatmmse5nGJv9MeGli7oKZBUnegSkAAl5tJd1dtdvFksLA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lunn.ch;
	spf=pass smtp.mailfrom=lunn.ch;
	dkim=pass header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=W0fcNzNv;
	arc=none smtp.remote-ip=156.67.10.101
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 117E6606A33F;
	Wed, 11 Nov 2026 13:50:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 117E6606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=W0fcNzNv
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=3IHYneG0XiL9m1fVv7YUKi9/nFsKN9f9thYm/Fr3gw0=; b=W0fcNzNvnYYt9HuzHGSliJaU1j
	toe1MASRDtfyLi9b1tUL8Sn9JyAUpTfNGbIMKdo5qdXh1OgpMqb0WkseGFJ+LM1VgmV7OZXz0DP4G
	hzRF81jga5UyNDrVWGPitCEBSqGSMkmo6rnr3hPKv/iOrv6EDm4DF+/btAunLPuFVagE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xR8io-00FlBU-SB; Wed, 11 Nov 2026 14:50:42 +0100
Date: Wed, 11 Nov 2026 14:50:42 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net] net: ibm: emac: fix fixed-link speed and duplex
Message-ID: <b931b470-5626-469b-8709-ca08e3379a75@lunn.ch>
References: <20261111003008.960305-1-rosenp@gmail.com>
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
In-Reply-To: <20261111003008.960305-1-rosenp@gmail.com>

> EMAC never attaches or starts the fixed PHY.

Maybe this is the real problem?

A fixed-link is meant to look like a PHY, attach it to the MAC and
start it like a real PHY. That makes the MAC code simpler, no special
cases for a fixed-link.

	Andrew
