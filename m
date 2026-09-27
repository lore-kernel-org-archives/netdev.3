Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2521F3BFACB
	for <netdev@vger.kernel.org>; Sun, 27 Sep 2026 20:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790540914; cv=none; b=CJJayMLSZmqS7db9MHo0EIhk7bisX7yEpRk6d17EayZ9XjXkAsgmhUQYYSSyS7Z2mw4Pp5NboGvXb4qn3yssMxY9oFuuOla9esOKfbEaQpMECvBzS+czTWWEuHyv+Wlov/YdcBdjv6m79uvJeoV0QtKbyntcsV9fmABqj1mkA2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790540914; c=relaxed/simple;
	bh=FSVVe/cPDU2HiWT6f26OgXG1GyfOSzOG3siiaAo3dOY=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pHU2DT9wlN0KHjKa76zrdRATCeCGQ5/gU0xP3yY0Pj8GHbH9OfO1uuzH5hNiotjvqzh99xwL0l9rJnPKDk69XK49oOnyhErfYw9mPxTc6qM4Y/Iwt96Doyk+vwH8XVHkzlS8KoLhZetVfjUloH90+mA6gdmfPQ4eBT0TiLT2kBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gKZqtEiQ; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gKZqtEiQ"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49ffed768deso4474845e9.1
        for <netdev@vger.kernel.org>; Sun, 27 Sep 2026 13:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790540911; x=1791145711; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:subject:cc:to:from:date:message-id:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZpDxu+FSADcYkY7OEJ6DHltLDpB0SvAaV3ZviPXPtHQ=;
        b=gKZqtEiQNt2Gf2yCYfkyFVHF73EFKbd8MQ1TV9Nv4FKk+yIawe94Ud6voNrFcbuXsN
         4j7AceejpUTCeLf95nSQWnOFxY0x/pNNbL+g75Sv653PtHRkp3ZTBuPX3AvHIBYCSoug
         tLFpwWKdvQSzy7L7rt8tEBXP4nVHTixSuszgnCaOn/DRNmdYhZsmnYUhqSr266GFik1M
         ybWZ1lxhVnyPDCfeUneecCkX3EKLekTh8vsBperf+uXuH6gxZqAWIzg+dlsBe8ijTGL2
         5xl+ssxAU9sQA3q6SGC5E+HkTZd4or+aYT1IfVrR4ZEiGkjWFglhIWMTYl8z7K2gTL8I
         Y3WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790540911; x=1791145711;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:subject:cc:to:from:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZpDxu+FSADcYkY7OEJ6DHltLDpB0SvAaV3ZviPXPtHQ=;
        b=IL1EuBbC+6kcCl37ANXIy6xswQs5bDV2b5oB9MJU//7/qMcoeFbyZtimFNDswQP1Bn
         X85THoo4KJj7v03diCcTjhnKKwTTmZPBV7cMPFIxDWZ1u/iKYKJ5Rfmc/OsHexZXp2Zl
         1vRBGToo8TmoVygfHVZ97tycuu339bUl6GYofeldDaVER7nsjhhkzrYen2Eyu38A1eE4
         C6J1OdmUJfQn2KhaqQuXl+VR20q44KN2GXVkTXp+bMZP1dvWmBVGUW61GmuYOFvjKDzH
         TRY0rnTO51JmVKJV3jaNNxZBubdMcer1ySMc/e7T+KwU8UJPfWL44+dcTUzTAagSOjT9
         z5hw==
X-Forwarded-Encrypted: i=1; AKwUvBw432hXyRKj/NjbPehU2QGcTJWVWmGKzpzEr4cenFNUrhDlIPofBRi8T77NBUWEDnExEmrpDfo=@vger.kernel.org
X-Gm-Message-State: AFuF++kZHdhtrJtxMCGgaxxrJXXVlZu8gicdqGzCyWdEs8xOtaP4xe4M
	rLbyDMknxTTusspYzC5x7hhIylR1psleMdPfhR331mnYnq74xj+JyRlu
X-Gm-Gg: AYBFou1WT+T8uC7kVVcmqMDEMRqHxuSlOWcf3V9DQnxozQvdTjD13519U8SvGzd/M59
	wFd9gfNZPN79K2Bfje+9qwSQ/+i+JRf7LJ8Qa9s5GatMgeA1/avwxXw8tPlmno5PEmHdKDgJMdp
	89JYyk5b8sz/MKtC1cDAeokvbpwyT8a7tP00Hqcjgd0DZ/UPA2SQmgihXipL4QBQ6kVzPFZWlho
	gGGsVcE42XC5CNLE1LssMLRnwmWQoGzH7M1YKPS39E70oT6726qBRVqRcyIG70vG8aJWHKdZILZ
	pAEOFBVBDB2PUADwlI7WlK/zjIrpMJAQw6CrK0649/tHjUYAydBjnC1++6OaDzErsNAyfSGyiLf
	ynpIjHUjucstqHbz5J1fE4ZjUbQxoisRP7Cu2W5PUXapAqEI9QA6B6rUneKpLfcGP7T0lRkkYxJ
	R060oK1ifoKTccqVU86bFNu6/zIeqlWqcBtLcHFhE6s8ZPL7tKOfQwOrUyJ+QSlZNu8ISpqnNgh
	DczZj8XIVbhRqLnoFnrzJ1cfWPqE8Q0YUJtphYzkCX6WyQ=
X-Received: by 2002:a05:600c:1f83:b0:49b:8f5e:51fb with SMTP id 5b1f17b1804b1-49fe66c8087mr198495325e9.3.1790540911202;
        Sun, 27 Sep 2026 13:28:31 -0700 (PDT)
Received: from Ansuel-XPS. (host-82-57-191-234.retail.telecomitalia.it. [82.57.191.234])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a00571744csm17037495e9.13.2026.09.27.13.28.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 13:28:30 -0700 (PDT)
Message-ID: <6ab97c6e.f5ac67e6.37e70.11e5@mx.google.com>
X-Google-Original-Message-ID: <arl8aT34M7MBL89n@Ansuel-XPS.>
Date: Sun, 27 Sep 2026 22:28:25 +0200
From: Christian Marangi <ansuelsmth@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"Chester A. Unal" <chester.a.unal@arinc9.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Simon Horman <horms@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	mfd@lists.linux.dev, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v23 8/9] net: dsa: mt7530: generalize and move
 common function to lib module
References: <20260925182435.21207-1-ansuelsmth@gmail.com>
 <20260925182435.21207-9-ansuelsmth@gmail.com>
 <cd200dee-1bde-4cc2-a296-c93d704cb906@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cd200dee-1bde-4cc2-a296-c93d704cb906@lunn.ch>

On Sun, Sep 27, 2026 at 09:02:09PM +0200, Andrew Lunn wrote:
> On Fri, Sep 25, 2026 at 08:24:30PM +0200, Christian Marangi wrote:
> > In preparation of support of DSA Switch from Airoha, create a mt7530
> > library module and move there all the common function.
> > 
> > Function are generalized to use the reg_field regmap API but still apply
> > the same exact logic. Every function is renamed to mt7530_lib prefix to
> > better identify it.
> > 
> > Minimum modification are needed to the register header and common enum and
> > macro are moved to the mt7530 library header to permit reuse.
> > 
> > A library struct is introduced with everything required for the common
> > functions.
> > 
> > The generalization and the introduction of reg_field regmap API have the
> > side effect of permitting to clean the mirror functions that required
> > special handling for MT7530 and MT7531 based switch that had different
> > registers. This is done by declaring a common MT7530 reg_field and a
> > specific one in the Switch match table.
> > 
> > No behaviour change is expected by this change as it's just a code move and
> > reimplementation.
> > 
> > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > ---
> >  drivers/net/dsa/Kconfig       |    4 +
> >  drivers/net/dsa/Makefile      |    1 +
> >  drivers/net/dsa/mt7530-lib.c  | 1128 +++++++++++++++++++++++++++
> >  drivers/net/dsa/mt7530-lib.h  |  391 ++++++++++
> >  drivers/net/dsa/mt7530-mdio.c |    4 +
> >  drivers/net/dsa/mt7530-mmio.c |    4 +
> >  drivers/net/dsa/mt7530.c      | 1368 ++++++++-------------------------
> >  drivers/net/dsa/mt7530.h      |  256 ++----
> 
> The number of mt* file keep going up. Is it time to move it into a
> subdirectory?

The problem as always is that mediatek directory will also contain airoha
stuff...

> 
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
>

I would like to fix some trivial things pointed out by sashiko. Can I apply
those and keep the review tag? For this patch for example it's just the
typo for the multicast MIB.

For the other patch is also very trivial stuff. 

-- 
	Ansuel
