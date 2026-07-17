Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 784381F7569;
	Fri, 17 Jul 2026 16:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784304489; cv=none; b=JDF1UzmzMlqr//nb4HDbP8N/Yow419ASAzoYSAg0q1rj/S8vkLL+Kbz1zRdiKfpv8BZr0Js8btzY+iHPh8hhRehmzPnxEJHSDbm8mG3CwMPzn5QXn4l9K/bboy3mBsj2PueNId9WMfA4rT14BYBjvnmx9iG1W8GqK//8KnX98Bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784304489; c=relaxed/simple;
	bh=F3xkE8kkq+yNUu4fgR7NiTQRD5ek/6NB3jD1dyHs1MI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JVjOMEUg6RACQNy/z4D0KzthHpuQyqoZ9dMHpzW+u2hHlFvMfcwCIPjBy9bANA8CJmUYNlsP7l1D9kLuHl/1Lt+NytHkggPrLdsmB8OGWWRNDmok8U6Fym4OFuFYvyrL0uWDwU4sDooFJHlfpuPd9O1LNFy92js21pcCminKAio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=LWqZTpTY; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="LWqZTpTY"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=eTDlUb/mBnl/NzixsKML9EwqiRxHef51x4lkiALNwH4=; b=LW
	qZTpTYTf38dOL8qxDD5rMn2MERuhtT5KKKCSQdbgsG2mNg61PIYAepHeSpn7tZWOpDxUshcZ7epni
	YDclVg2p/uh3ZGDcb80HXZSzHoTQCQFd0buFpF0U4EnD4W9aI1QFeuyzJTzL5DQXeZ0cYaF44mv3R
	21vubMLtAqlSiv4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wkl6N-00CpuW-0K; Fri, 17 Jul 2026 18:07:51 +0200
Date: Fri, 17 Jul 2026 18:07:50 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Julia Lawall <julia.lawall@inria.fr>,
	MD Danish Anwar <danishanwar@ti.com>,
	Michael Grzeschik <mgr@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Yibo Dong <dong100@mucse.com>, LKML <linux-kernel@vger.kernel.org>,
	kernel-janitors@vger.kernel.org, Dan Carpenter <error27@gmail.com>
Subject: Re: [PATCH v3 net-next] net: rnpgbe: Delete a null pointer check in
 rnpgbe_rm_adapter()
Message-ID: <a07b229f-a258-4b1b-a411-7c815f9f1cb9@lunn.ch>
References: <7a9ea765-2c75-4a16-aaf9-510f2450beb3@web.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7a9ea765-2c75-4a16-aaf9-510f2450beb3@web.de>

On Fri, Jul 17, 2026 at 10:38:32AM +0200, Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Fri, 17 Jul 2026 10:20:15 +0200
> 
> The check for the pointer “mucse” was identified as redundant because
> the relevant address information was preserved according to calls of
> the functions “pci_set_drvdata” and “pci_get_drvdata”.
> Thus remove it.
> 
> This issue was detected by using the Coccinelle software.
> 
> See also:
> Reconsidering pointer dereferences before null pointer checks (with SmPL)
> 2023-04-09
> https://lore.kernel.org/cocci/1a11455f-ab57-dce0-1677-6beb8492a257@web.de/
> https://sympa.inria.fr/sympa/arc/cocci/2023-04/msg00021.html
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
