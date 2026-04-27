Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B70EB2EFD9B;
	Mon, 27 Apr 2026 14:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777300612; cv=none; b=lvmkUatKpyGByXrHMYtTFGnNjH99ZFqqW7GAP4UXMYNtrM3VS1UkW4d24qaH/HxKDY7ZyHYjAJMiTwCEffHHZ6AVDaheh2grpN2TM93dts4kJsZtgXmXj7dDMrkw/iVMx5ycpNecFWo2/cH8gVPs/tjo8IFkM/aGKgfscq0ZA20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777300612; c=relaxed/simple;
	bh=zhj7BefqB70/GWAfwb4qblb+GXfGPk9Ous1fc6wxcUU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tTDdtLVa61iQ9y3BphxPUJFaDurMokbyj51V8mG51WIvU3+JRsm4Bi9jqBUO6nKyNm/cjhh+5Van8REsKYk4CK9OfDnBKNI7itGTDwcZ+MuB98ypM8viwcFebEB41V+A5DDgulhkUk5ZBYuTZ8mL6ux3IQGgs9G6lpYeVkSHZ9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=hKo4g06f; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="hKo4g06f"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=+CqZeB9Uj+nOMbZEeZioPvECq2KYqxFoLyWyf1YlGvE=; b=hKo4g06fhgnSc9oOcTeBr9jFhs
	juILaZVqvPzYjVqxvL6u6DJ/Zp0oy8YPsamCQqaWEKGR1acEkYvSzpgWeCUTZLdXBQRn8zMLXMIJe
	OngQ7r1c6b3QwRZp+U0mmbfweK/bmTFNlJ/X0ys6OUjzJeEgRlDH5M5OJQca6jQqtzO8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wHN4p-000B3V-Er; Mon, 27 Apr 2026 16:36:47 +0200
Date: Mon, 27 Apr 2026 16:36:47 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: MAINTAINERS: Add self for the 3c509 network driver
Message-ID: <70910fab-7054-48a5-a41f-ffd4c5d429ac@lunn.ch>
References: <alpine.DEB.2.21.2604271056460.28583@angie.orcam.me.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.2604271056460.28583@angie.orcam.me.uk>

On Mon, Apr 27, 2026 at 11:23:17AM +0100, Maciej W. Rozycki wrote:
> It appears there's a need for a maintainer for the 3Com EtherLink III 
> family of Ethernet network adapters.  There is documentation available 
> and the driver is very mature so the task ought to be of little hassle, 
> so I think I should be able to squeeze in any issues to be addressed.
> 
> Signed-off-by: Maciej W. Rozycki <macro@orcam.me.uk>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
