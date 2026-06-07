Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 306742EEE74;
	Sun,  7 Jun 2026 17:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780853304; cv=none; b=I3zyMV0OfTVMR9Dts+XJ+5P7Nf7rfTeSAoUxO0QDzLo43Ew1wB247or1Ig58/fX3hBp268aZIbsAP3YF0KkexArD9vmNkqcV3XkbCJ2/hkrPKKL7wT9G7g8kS86tcxpM83cs73t6rQqLcAiFmBfOT0kesBEvwbarOJ/SYLQbUsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780853304; c=relaxed/simple;
	bh=g6Qssiyd/0gNBdIF+YVWj7h6uA4J1vqU8FZUZN3RMP0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H7osp+L6mYy3veA4FAP9iyG5ASgmLow39LUEIWgnVXFTdm6bZo2m/f1g/XUHhEs4sGFwFDZSfS19KdulwTs8KJ9PTP63AbDXFFAsEDo4FEsafA/gYLgQZSGpAjkdWlzr3GaPHU0q6Io37OQl/+KaH030XZjsB2EO1MZyqyjERW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=fJoVabPR; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="fJoVabPR"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=vkRXkBHTm1p59dLWdZH+b6kuiXEG97WGreWW32kZBcI=; b=fJoVabPRm7sSrD8SYBAPv9XVuB
	LT8iLJLArRNeO/aE9RYUAGc2UybhReA9LeCxwjmdNXi7ZZ2uG+pKUCZklygP0URF0PSHp8/fxButY
	By5OHnJhEYiimEZgKMRhn04GSJXudvFgLOUK+4Ah64tvzeWqNi1ZgfbX0AN1nryfapdw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wWHI2-006UPP-OB; Sun, 07 Jun 2026 19:28:02 +0200
Date: Sun, 7 Jun 2026 19:28:02 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Mieczyslaw Nalewaj <namiltd@yahoo.com>
Cc: Luiz Angelo Daros de Luca <luizluca@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Linus Walleij <linusw@kernel.org>,
	Alvin =?utf-8?Q?=C5=A0ipraga?= <alsi@bang-olufsen.dk>,
	Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [net-next PATCH v13 2/9] net: dsa: realtek: rtl8365mb: reject
 unsupported topologies
Message-ID: <9f8d3ee8-4249-4cb2-925d-53b2996239db@lunn.ch>
References: <20260606-realtek_forward-v13-0-b9e409687cbe@gmail.com>
 <20260606-realtek_forward-v13-2-b9e409687cbe@gmail.com>
 <617aa489-4f0c-4fe0-8cf3-55c98f4d4d9e@yahoo.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <617aa489-4f0c-4fe0-8cf3-55c98f4d4d9e@yahoo.com>

On Sun, Jun 07, 2026 at 02:55:07PM +0200, Mieczyslaw Nalewaj wrote:
> On 6/6/2026 10:29 AM, Luiz Angelo Daros de Luca wrote:
> > Explicitly enforce the presence of a CPU port (-EINVAL) and reject DSA
> > cascade links (-EOPNOTSUPP) during setup to prevent silent failures.
> > 
> > These topologies were already non-functional. Without a CPU port, the
> > driver does not activate CPU tagging. Additionally, the switch hardware
> > was not designed to be cascaded, and DSA links never worked because
> > CPU tagging is not enabled for them.
> > 
> > Reviewed-by: Mieczyslaw Nalewaj <namiltd@yahoo.com>
> > Reviewed-by: Linus Walleij <linusw@kernel.org>
> > Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
> > ---
> [...]
> >drivers/net/dsa/realtek/rtl8365mb.c:rtl8365mb_get_stats64() {
> >    ...
> >	mb = priv->chip_data;
> >	p = &mb->ports[port];
> >	spin_lock(&p->stats_lock);
> >	memcpy(s, &p->stats, sizeof(*s));
> >	spin_unlock(&p->stats_lock);
> >}
> 
> Sashiko reports a potential deadlock around stats_lock, however I couldn't find a call chain reaching rtl8365mb_get_stats64() from softirq context. Can anyone point to such a path?

Enable CONFIG_PROVE_LOCKING and use the device, get the statistics
etc. If you hit the two paths with a potential deadlock you will get a
report.

	Andrew
