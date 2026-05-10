Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B49D2D97B9;
	Sun, 10 May 2026 23:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778454847; cv=none; b=aFkT9r4UUCUlg3Y4ghWqSVhaROCzasAhJzTa/+lOubsczIiK9Xu037fHFIauOnAvd4K7+px1jnnSlVo36rY4yyfbTpRqnEujbv2uMognHD+9EIECsHyr3PuescaxcKfkzyETTuiUGNJX7cX1Prs0Qaol4Yd3FgEq/PmRcjvZxds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778454847; c=relaxed/simple;
	bh=qxh6luq/7BAjZG8of3vHHGe1hUXb2EdPMS6C84ih70g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=twzZdF1xXP1n5qPvdldGtjFc0zGIwNkZfDsaFBCbU4AXEy7USKaJ6/vYFujKFntG7QTI5iHo6cSlhoXj+PlGIexosfyhtxBYxRn0vZuaB2lJOJRkgdsZUahwwDVsWthKluECE1E1dmomdrTy5ua+0VSndZ5zKkMs1eWMN2WYlG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=tCBjlAnw; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="tCBjlAnw"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=FQ2K6mCxdrZVom4w0H5maOa8tI2N6T1sDeC27qPOq7I=; b=tCBjlAnwcrVNFE1YWKEAFwCPZS
	cpntLRCYsskN9WU87fPSIASLQsCGbqtZ8vHqt5haI7jflXClROMgz7ALersSh5JSPROqoVTX8JW7c
	nLDr5t5lPyVhOq06Kwyip1Sypii/MZ7HfCyMQQ/jf1HghfKjectXYz7/Eb3/qYHVoDuo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wMDLS-002Fz5-Nc; Mon, 11 May 2026 01:13:58 +0200
Date: Mon, 11 May 2026 01:13:58 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Fidan Aliyeva <fidan.aliyeva.ext@ericsson.com>
Cc: olteanv@gmail.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, marek.behun@nic.cz,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Thomas Eckerman <thomas.eckerman.ext@ericsson.com>
Subject: Re: [RFC PATCH 1/1] mv88e6xxx: Cache scratch config of 6352 in setup
Message-ID: <d979651d-bba0-4042-8e72-609b56121682@lunn.ch>
References: <20260510213429.2044612-1-fidan.aliyeva.ext@ericsson.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260510213429.2044612-1-fidan.aliyeva.ext@ericsson.com>

On Sun, May 10, 2026 at 11:34:29PM +0200, Fidan Aliyeva wrote:
> In mv88e6352 scratch register in Global Control 2 set of registers
> returns which port is attached to SERDES. This value is set and
> stays constant after the switch is released from reset; thus, it
> can be cached during chip setup instead of reading the register
> everytime when SERDES config is needed.
> 
> 1. Add setup_chip_specific member to mv88e6xxx_ops and
> g2_scratch_config3 member to mv88e6xxx_chip.
> 2. Add mv88e6352_g2_cache_global_scratch_config3 function as
> .setup_chip_specific which reads the CONFIG3 value from the scratch
> register and caches it.
> 3. Call .setup_chip_specific during chip setup.
> 4. Refactor mv88e6352_g2_scratch_port_has_serdes to use the cached
> value.
> 5. Remove the locks surrounding mv88e6352_g2_scratch_port_has_serdes.
> Not needed anymore since no register access in the function.

We ask for lots of small patches which are obviously correct and have
good commit messages.

It seems like you could break this up into smaller patches. Taking to
account my other comment, how about 4 Patches:

1) Add mv88e6532_reset() which simply called mv88e6532_g1_reset(), and
make use of it for the 6352 family ops structure.

2) add g2_scratch_config3 member to mv88e6xxx_chip, add a helper to
read the register, and call it from mv88e6532_reset().

3) Rework mv88e6352_g2_scratch_port_has_serdes() to use the cached value.

4) Remove the locks.

   Andrew
