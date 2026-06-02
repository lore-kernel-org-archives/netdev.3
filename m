Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1491D3546F7;
	Tue,  2 Jun 2026 23:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780442964; cv=none; b=ndh+z30AnjklRhJxMzCEaJFei+FlDp9jfvqykGOs2vYTdSjhyDrCKniydM3wnTP6l+KDHiKdXSSH6VqWywVtcsTTvoMf49E0pITzzxFvLyoyXuLqG8ryLRCPgtSivT+iFehz25+5m+g4vrXgXJfHL++uVJALWkRQJRwPppwF0Cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780442964; c=relaxed/simple;
	bh=8lrdi2XPHjenZdt5fi7PLDLnsvNp+MvAb8OfdiNTTXg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oyS3H7KPTnHr94hQVmvJGOO9KKPTfJtMvAYTlQktd7DxXFkQyw682dIIqRnQi2cwRwz4O7fvGhcTBRVfrom7M4vgs6DN5XzuC9MUkvHvOn5AFXPbsD+mXPK+PZCXxz0XeebEBlAn42Ri++qFvSjBxnLiLhP/7e5Fvgb6iErM9EI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1wUYHB-000000007TN-2GrH;
	Tue, 02 Jun 2026 23:12:01 +0000
Date: Wed, 3 Jun 2026 00:11:58 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: John Crispin <john@phrozen.org>, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next v4 4/4] net: dsa: mxl862xx: add support for
 SerDes ports
Message-ID: <ah9jPhiHSSqYjScK@makrotopia.org>
References: <cover.1780032869.git.daniel@makrotopia.org>
 <2b57a3d73519a4be8f45252707c335ecd251b2c1.1780032869.git.daniel@makrotopia.org>
 <20260602142209.740b18d7@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260602142209.740b18d7@kernel.org>

On Tue, Jun 02, 2026 at 02:22:09PM -0700, Jakub Kicinski wrote:
> On Fri, 29 May 2026 06:40:17 +0100 Daniel Golle wrote:
> > +struct mxl862xx_xpcs_pcs_cfg {
> > +#ifdef __LITTLE_ENDIAN_BITFIELD
> > +	u8 port_id:2;
> > +	u8 interface:6; /* enum mxl862xx_xpcs_if_mode */
> > +	u8 neg_mode:2; /* enum mxl862xx_xpcs_neg_mode */
> > +	u8 permit_pause:1;
> > +	u8 usx_lane_mode:2; /* enum mxl862xx_xpcs_usx_lane_mode */
> > +	u8 role:1; /* enum mxl862xx_xpcs_role */
> > +	u8 usx_subport:2;
> > +#elif defined(__BIG_ENDIAN_BITFIELD)
> > +	u8 interface:6; /* enum mxl862xx_xpcs_if_mode */
> > +	u8 port_id:2;
> > +	u8 usx_subport:2;
> > +	u8 role:1; /* enum mxl862xx_xpcs_role */
> > +	u8 usx_lane_mode:2; /* enum mxl862xx_xpcs_usx_lane_mode */
> > +	u8 permit_pause:1;
> > +	u8 neg_mode:2; /* enum mxl862xx_xpcs_neg_mode */
> > +#else
> > +#error "Unknown bitfield endianness"
> > +#endif
> 
> With the bitfields and MACROS for read/write this patch give off vendor
> BSP more than upstream code :( Doesn't look like the driver used
> bitfileds before, please use FIELD_GET / FIELD_PUT

It wasn't necessary before because the older and more mature parts of
the API have a different hand-writing and used only (sometimes quite
arbitrary) 8-bit, 16-bit and 32-bit types. Now this more recently
designed part of the API breaks that rule.
Anyway, a single __le16 it is then in this case, and I'll use
FIELD_PUT/FIELD_GET.

