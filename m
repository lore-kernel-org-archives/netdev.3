Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7F3E3D1AA4;
	Fri, 24 Jul 2026 13:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784899529; cv=none; b=oGVhVvVHS+9GXXTjfPcult0q6BMKfijyOQQEM9LcevRJrnswNH2AzXHuwTPKM6c8xGcbsvc1VEqHBs0oZCBqAATAaR18W/phEBKOdvFnZwq5thfwfXcjDe5UI4ULiu8A3/dsfH9nChVhWLtShJaNbnEg694RFUnMU46W+w7/2LE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784899529; c=relaxed/simple;
	bh=6F0F+YX65cy3BAoDvLit6bsv35Vg3bExDc7uxgOoZZg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jol/+jqMjbs9zjM8mKG2D/ZLDqWdQHQK6Q8PVFg+b0UXZ/FIxGEmfL62UkTULp26VgZuL74BJUTHGlb55scCTmiCYirT0XTaOJL4gF+52hJxLBaXtHtqlcLrYUadp0IBUYjfbgmWvkgIP9aKiusDyTb4qwzPAeMsg2b2Ez2NFlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=bepC38il; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="bepC38il"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=k9MwmO4hh4WTsa/GuSXzTTnhgnh/gX9BGvnhj2CeTWk=; b=bepC38ilBHL1PYYhKN7ktWj7UQ
	JDNwo8EnHsr/XhCGivJ7ESouX/Gbyf9lh1dVO0fzaoux3MN2mbb/T/qLkVkvPkhm/o8qhbGjsbFX/
	LgPq+Ixc+QipbdTxI//CnQzGg/5hUqj5JuypcG2Y7KGzRmsIwF3TfXC1yDZ7dEsGPARc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wnFtt-00Dztl-TO; Fri, 24 Jul 2026 15:25:17 +0200
Date: Fri, 24 Jul 2026 15:25:17 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Birger Koblitz <mail@birger-koblitz.de>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Heiner Kallweit <hkallweit1@gmail.com>, linux-usb@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 03/13] ax88179_178a: Use MMD accessor
 functions for AX88179A
Message-ID: <7658e9ff-d1fd-478a-bdad-da492a371be5@lunn.ch>
References: <20260724-ax88179a-v3-0-bdde4f905883@birger-koblitz.de>
 <20260724-ax88179a-v3-3-bdde4f905883@birger-koblitz.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260724-ax88179a-v3-3-bdde4f905883@birger-koblitz.de>

On Fri, Jul 24, 2026 at 09:36:46AM +0200, Birger Koblitz wrote:
> The AX88179A uses a much simpler Clause-45 MMD access interface,
> which are made available through ax_read_mmd() and ax_write_mmd(),
> which in turn call the chips' respective implementation.
> 
> Make use of these functions for stract MMD read/write operations.
> 
> Signed-off-by: Birger Koblitz <mail@birger-koblitz.de>

I expect all this EEE code to go away once we have phylink code, and
phylib helpers accessing EEE registers. But as a step towards that,
this makes sense.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
