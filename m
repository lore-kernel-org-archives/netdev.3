Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C283F210A;
	Tue, 13 Oct 2026 01:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791854546; cv=none; b=KOb9vYsM6msDjXha/3fsogBik5Pa6TYHsXoUPKTR35lfObFWcsJJH5B9H8Vy68f7meIcT7l1FdyBfjTS482Tzkdv/cPgVoM2sIKFID6lpfo4fq03QwUhblDnZaqzkGz/47sHGHlQjUgEgwYGwlFqxBiCsoWnx9eM+Ku4FsplD1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791854546; c=relaxed/simple;
	bh=kGYlQpa4tjkITLOnIv2MXqhyGAW8UQJDUESSyoVto14=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KYJeFAdnhw5P+64RtttD80RPM26RMaxt50HDMZJ05FWJe7pOo6IKFq1JfrkIYE9XwFqMw73OdVlpfv09i2jKW6+x567xR3/IsYeatRZBHR6Q3CVUpq8VjaGDAKy0Bj+Bg38SIO8FZL6kLMOOF+iyGyYGZ6dOBS08xclb6zj2R3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=5p742SHy; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="5p742SHy"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=OnAdMZP1SxFnwaARkjMiMJ27pHDglXB3OQiHuWQfYVI=; b=5p742SHycC4ZVjFPBRgwYwUMO/
	/g2OQlF2qi4Q4HrGjOpZ1Sr0wvUevY0Cgoew0PO0izOPkC/JnhUOmePd4I2/JksbmIDiCE7/vg+bG
	PHw/6pGejKGCHrMlHMkVEmoraK6qf8eaLlch9Fy+LE32lJqmfAy5D2bOuZnlfdtrAbVk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xGRDY-00AQ5M-9K; Tue, 13 Oct 2026 03:22:12 +0200
Date: Tue, 13 Oct 2026 03:22:12 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: James Hilliard <james.hilliard1@gmail.com>
Cc: netdev@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] net: phylink: allow stopping a suspended instance
Message-ID: <224296ea-f196-44f3-91d6-1461846c55a5@lunn.ch>
References: <20261005-submit-phylink-suspended-stop-v1-v2-1-8b8e5d53dfc2@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261005-submit-phylink-suspended-stop-v1-v2-1-8b8e5d53dfc2@gmail.com>

On Mon, Oct 05, 2026 at 01:09:05PM -0600, James Hilliard wrote:
> After a failed MAC resume, a driver must be able to stop phylink without
> resuming it and reconfiguring the failed MAC. This is needed when recovery
> leaves the interface administratively up but detached until a subsequent
> down/up: ndo_stop() must finish the suspended phylink lifetime even though
> the MAC could not be restored. The missing transition was identified by
> code inspection of the stmmac recovery paths.

I don't particularly like this. It feels like a workaround for a
broken MAC. It would be better to fix the MAC so that resume does not
fail.

As far as i know, this it theoretical, only triggered by fault
injection. If we find a real error situation where the MAC cannot be
resumed, then i will consider it. But until then, i prefer to reject
this patch.

     Andrew
