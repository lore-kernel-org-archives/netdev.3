Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75D1D2931D3;
	Sun,  2 Aug 2026 15:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785684395; cv=none; b=eL27AusM2OGMPv1llkMVGtTs0x8k9Ql3EHBJ80Wa8KoWzdJumkaBdp7nsjAt1tzHr+t0IDeFa0szxKdgk+iirAlpkKKafLftR6QMcZcQJg1WTyJK53FHGERp+/orzg7OoeRlvA78iv63/I2G66m1gU5PF47uFvLABDk3F55XJ2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785684395; c=relaxed/simple;
	bh=/g5eBjePeYSd5AuEwLi1eWK7eCxXb3ltUj1YPFeRRwQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PfcsyM9J3Ub7VDXdNNxA8p9iYoUB+4zG7rPZMrT5uzaxTnC/2mQKAiIM/AHZTpQyKA9OWuOalZJW5jU04KGLE5pLDDSpkt9C4ynn2mKbuuKF//LHSN64MrTtsDYd91Rz2k6xEC5wtJydold+NXSBltWEpY9G4pPLq/tTZSDldHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=F7GXUx8x; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="F7GXUx8x"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=ayzKqlx3NrcNeAIA64bqiM0aoEbl9uFL5Ve1TM9hU+k=; b=F7GXUx8x2ZmL1Ews3vNlwAB5FK
	hjcz4HWmRH5AVVRMYXQE1Kr0GtlgH4F/bW3JeHUNIvtgFs6wvU0tKfK+ENNYgpYbXb8sUbPr0qy6j
	DrXN5QI9yLy2Vluj48QlC/+JEAfB5nfdJTRuy0i8+hzCjs5zqxaZ7e3D8SAsKjc8aSxs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wqY55-00FaWE-6B; Sun, 02 Aug 2026 17:26:27 +0200
Date: Sun, 2 Aug 2026 17:26:27 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Birger Koblitz <mail@birger-koblitz.de>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Heiner Kallweit <hkallweit1@gmail.com>, linux-usb@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jianhui Xu <neuromoments@gmail.com>
Subject: Re: [PATCH net-next v4 07/12] ax88179_178a: Add AX179A/AX279
 multicast configuration
Message-ID: <dbb2387b-7643-4567-9d1d-df742300605c@lunn.ch>
References: <20260731-ax88179a-v4-0-2cf1f71b1dd2@birger-koblitz.de>
 <20260731-ax88179a-v4-7-2cf1f71b1dd2@birger-koblitz.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260731-ax88179a-v4-7-2cf1f71b1dd2@birger-koblitz.de>

On Fri, Jul 31, 2026 at 06:19:07PM +0200, Birger Koblitz wrote:
> Add support for conditionally setting the ip_alignement flag
> AX_RX_CTL_IPE in AX_RX_CTL and make sure that AX_RX_CTL_DROPCRCERR
> is also set to be consistent with the initial configuration in
> ax88179_reset()
> 
> Signed-off-by: Birger Koblitz <mail@birger-koblitz.de>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
