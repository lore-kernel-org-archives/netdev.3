Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 133D92E1EE0;
	Mon,  5 Oct 2026 17:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791219655; cv=none; b=ZHS7hRDQbDVhcANlMyqRHDaYlhrzZe3DL+jIFccRVjCHV+zhoRKu6jPT+lE7oGeX0snNEOai+ySf1VnTDkoVDX1YSFcjRGk8z9o+2uksIpzyA09uI7/A75x5HZVcN5oNClZOp3Obx1IZXnocl1FzBWlkXW0C7FF3SmexEj6eVAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791219655; c=relaxed/simple;
	bh=eUq/Fpd/aMiRZ/Ud2kB6zdRZRopf1TOGDea7P4TysU4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IrM7KW/39yf54jhLVfLL9vRvLyxBf9I7cMJqvLYIRuakjCm/AsaXrVc84kraRiMqTPdS+qVDB9KO7e6pkZ4OFpyBVIMnVYBQR8hiTibblOpfTOVbAyYdPrsyk9yf4AvG8eRNa0fbvGrkTG0RTAQvaQp61W/8vWLZHR5vYOtpEXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=hpO0dsJd; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="hpO0dsJd"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=N42AkCPvlmOexUxUv8KwZoDJ9cuIoVCrhb/0fTBAssY=; b=hpO0dsJd6ZsI+y7jl1uhxVBNJ3
	kacqWjU571HaWBKFlrfhuSY2jwJ5o3TePJ8MAePiwJshkdPQeynLvLQuRFOkDO83Ol7Dy+hboGZSB
	oRQg6m8XJOeFqEJkfly5rk/axDJHsSb4qkPXHFVA46giL/IAe824Bk/S0fgus8OLhZQQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xDm3R-0095Xm-1Q; Mon, 05 Oct 2026 19:00:45 +0200
Date: Mon, 5 Oct 2026 19:00:45 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Yongzhao Chen <yongzhao.derek@gmail.com>
Cc: netdev@vger.kernel.org, Christian Marangi <ansuelsmth@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	John Crispin <john@phrozen.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 1/3] net: dsa: qca8k: propagate MDIO errors
Message-ID: <314592e3-8c67-44e0-a4ce-08f5cb47fe50@lunn.ch>
References: <20261003172405.342-1-yongzhao.derek@gmail.com>
 <20261003172405.342-2-yongzhao.derek@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261003172405.342-2-yongzhao.derek@gmail.com>

On Sat, Oct 03, 2026 at 07:24:02PM +0200, Yongzhao Chen wrote:
> qca8k_mii_write32() ignores errors from both 16-bit half-word writes.
> Its callers (register writes and read-modify-write helpers) then return
> the earlier successful page selection or read result, incorrectly
> reporting success even when writing the switch register failed.
> 
> Propagate write errors from both the low and high half-words through the
> regmap paths and internal MDIO master transactions. Attempt to clear
> MASTER_EN even if a transaction fails, preserving the initial error, and
> report a cleanup failure if the transaction itself succeeded. Preserve
> the existing Ethernet-to-MDIO fallback order.
> 
> Propagate read errors through the internal and legacy MDIO bus callbacks
> instead of masking them as 0xffff. Returning 0xffff causes PHY
> read-modify-write callers to treat the failed read as valid register
> data, which can corrupt unrelated bits on writeback.
> 
> Stop polling when reading the MDIO busy status fails, and return the
> error immediately. Because the read helper clears its output on failure,
> checking only the BUSY bit mistakes an unsuccessful read for transaction
> completion.
> 
> Code inspection found these problems. Fault injection into a userspace
> model of the driver's functions reproduces them; the corresponding cases
> pass after this change.
> 
> qca8k_mii_write32() has not returned write errors since its introduction
> in commit 6b93fb46480a ("net-next: dsa: add new driver for qca8xxx
> family").
> 
> Signed-off-by: Yongzhao Chen <yongzhao.derek@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
