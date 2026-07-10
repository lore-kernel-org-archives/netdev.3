Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB0582BDC05
	for <netdev@vger.kernel.org>; Fri, 10 Jul 2026 16:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783702720; cv=none; b=bAbRzEa5RPUsnTFi2nExYktABjPJtYHCq1aNXnIrtPZrl8rHQoX88u6FnKI4k2ilAYBBTx7I+wjQ9kuFpsRPC0l9yvlKl65/JEhuD88J7RBSVuBuD85ePvNbCLXdcKWOzhwJd1aAHyoi0y3P4SiApHu5QWrEav/BmFlvuE+Fh1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783702720; c=relaxed/simple;
	bh=GJMLoUvNdnWE4XXTv2fh0MAyR2jvtTtGXmw8+8W8SXY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OCCBDhnUox0sMF6iL0fqcUonBxxuV6QWPW3gYZ8lGMEhJJ3qcIbGV21kpOrq/4GcpH2+wmsCqQpWeLMEhr1S3I7+sDWGHN1kKdgZ2ljK5sp1KFzsYXLZuTKu+jJ7GWL9s0Rw79RN+fQo/A64j/jn3EBE9Ugow5Ll1wWQ4CHBVQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UXEOihJW; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UXEOihJW"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-c96c92c0980so684606a12.3
        for <netdev@vger.kernel.org>; Fri, 10 Jul 2026 09:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783702718; x=1784307518; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UzL1Q2+7WDC/g3DuLtI+wo+3VqWALiuVF8iASl1uPEU=;
        b=UXEOihJW19Vqc0rSCNVp5IKtJ6SOWfuNC3Zbg4X8OMuR8dHL7Il5iPLt8tH3Md58MD
         ZKupX2NvsrAK460q2O1uBqnug0mvyIqCfYmjDv6Rj2mcVqaT3aRk/b82k4APuLDdSL12
         vCbyosatL0yT6AWQUE6lwqaQuh1OIQZqiO2pPtlhyi9/FiF1JkcESFaEX/pSB+HGrKn4
         PqHHWc16yn8zaSZv9Pc6stQz4lvjegWT57bNTfH/K+4puU04mX25TenXbjcBeMgII5SX
         fjkYc+fx1UG3fI/JLlTMm0QRAMQBjXt30kE4WcIFELX1DdQMPZ+J+Zi3uaeZj+X2Wdwv
         JPkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783702718; x=1784307518;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UzL1Q2+7WDC/g3DuLtI+wo+3VqWALiuVF8iASl1uPEU=;
        b=Q/5pr6GG8KhzCo1oT/EpLm2zTfYKw7oxHJSYoxKAS0JqqDaps+YtlqK+D96qOJTbR8
         Oz7lJG2/FgiTN1aG+Ox5l9v62fl4YYZok8dCjn1Wh033IOtT5sOA5iKaP0RmWlCIGoIq
         8humHju1ekBaPHAUgy6dPgzaCO4PFJMDtLTH7kt8iqJM+omBbnlcMRGhWBGwJKIXvP5Z
         tVpu4d1u1sCeZ1d0KSCxTqhCs16ZJRM8SKWTMMfjEjKa7N+MjJ2G0kTRBksC4E5wimcY
         KGhqryd0FSK4+tWkMxonw6g69Uu5ntPHWi2QCgXtXplx9P5cTQPJKtOyp94M/gdykBMG
         2m2g==
X-Forwarded-Encrypted: i=1; AHgh+Rov3iN6Zpj/zMM+3qQ0USc+tm898B3fMe8ofegg/Nq9AsyNTyPI3u9t1aET69V7yelTkgt3Gp4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwuU2qW8X4+LnEK6sAyOnlmLMBjfJLY4QWTqfLDZuknqVJtRy3
	rzOnI2+Ll2YsF/ndCzhKNw+twt970bMmwtTa2prfv4jTDrDO52+JdONIFqZ9NuRY
X-Gm-Gg: AfdE7clXAXcWDmoc6Dtcj0xytNxnGnPrxp2hRdYr4bhEFxOmFZI8tC43EbSBnPVDFu1
	QxOs8exU5hYPzT0tACypAfBxA48SfN878l8A+UGxfHY6sHhO+pgLRum1G3CaV82AL6bD5YsCNql
	RpCjzCOWAHltqIUSKcM7x30AP9CPR7MlHa/naSMS8LqMx7iaESs6WrEILnzw2V3xDW+iDiLIgM1
	0QPBNi5ws9oHC94DfNLopfUr4aO9V13q1BOh03gv7owc0oS1i0DP6E9ajxLtZ2p8+cBvXKeDtXO
	/qAIkye6Q4NvLqmQHukIr+atKi2ayYG+Ae6nT3trDbT0zDjyqJV6LjiqPQ0GtSjisJ2jX28yYvu
	lcep2DXiokA+IS60nkokJPABcn/oBk5mjKlu2BBaNKPHvo8t9QKZydVulL9OJpkCQ4ylWW/Fc/Z
	D51cyfYqvGnwjexbWcUNJYBDt2kgvgM14OJt/MCVk=
X-Received: by 2002:a05:6a21:1bc3:b0:3bd:4698:e7c4 with SMTP id adf61e73a8af0-3c0bcb7f146mr13586972637.42.1783702718181;
        Fri, 10 Jul 2026 09:58:38 -0700 (PDT)
Received: from DESKTOP-TIT0J8O.localdomain ([49.47.198.15])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-311747f72a6sm48876196eec.1.2026.07.10.09.58.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 09:58:37 -0700 (PDT)
Date: Fri, 10 Jul 2026 20:58:28 +0400
From: Ahmed Naseef <naseefkm@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Ahmed Naseef <naseefkm@gmail.com>, netdev@vger.kernel.org,
	=?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
	"Chester A. Unal" <chester.a.unal@arinc9.com>,
	"David S. Miller" <davem@davemloft.net>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Conor Dooley <conor+dt@kernel.org>,
	DENG Qingfang <dqfext@gmail.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Landen Chao <Landen.Chao@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Sean Wang <sean.wang@mediatek.com>,
	Vladimir Oltean <olteanv@gmail.com>, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net-next 2/2] net: dsa: mt7530: add EN7528 support
Message-ID: <alEktKWsrriHdR40@DESKTOP-TIT0J8O.localdomain>
References: <cover.1783680864.git.naseefkm@gmail.com>
 <1865eaedef97e593ba608764c7390209cae85b30.1783680864.git.naseefkm@gmail.com>
 <f968d3fe-83dc-4b82-972b-0d4d477a1a52@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f968d3fe-83dc-4b82-972b-0d4d477a1a52@lunn.ch>

On Fri, Jul 10, 2026 at 03:32:32PM +0200, Andrew Lunn wrote:
> > +	/* The EN7528 LAN GPHYs advertise EEE by default, but negotiating EEE
> > +	 * with common link partners (e.g. Realtek GbE NICs) results in an
> > +	 * unstable link with dropped frames. Disable EEE advertisement on
> > +	 * them.
> > +	 */
> > +	if (priv->id == ID_EN7528)
> > +		for (i = EN7528_GPHY_BASE;
> > +		     i < EN7528_GPHY_BASE + EN7528_NUM_GPHYS; i++)
> > +			mt7531_ind_c45_phy_write(priv, i, MDIO_MMD_AN,
> > +						 MDIO_AN_EEE_ADV, 0);
> > +
> 
> The problem with this is, you can still use ethtool to enable EEE.
> 
> Please look at phylink_bringup_phy(), where it calls
> phy_disable_eee().

Thanks, you are right , the register write is the wrong approach.

While looking at phylink_bringup_phy(), I noticed that the mt7530
driver sets config->lpi_capabilities but never config->lpi_interfaces.
Since

        mac_supports_eee = mac_supports_eee_ops && lpi_capabilities &&
                           !phy_interface_empty(lpi_interfaces);

that leaves mac_supports_eee false on all mt753x ports, so phylink
already takes the phy_disable_eee() path for every port and
phylink_ethtool_set_eee() returns -EOPNOTSUPP. On the EN7528 I
confirmed "ethtool --set-eee lan1 eee on" reports "Not supported", so
EEE cannot currently be enabled from userspace on this driver at all.
That looks like it unintentionally undid the "EEE can now be enabled
using ethtool" behaviour from commit 06dfcd4098cf ("net: dsa: mt7530:
fix enabling EEE on MT7531 switch on all boards"), starting with commit
9cf21773f535 ("net: dsa: mt7530: convert to phylink managed EEE"). That
is pre-existing and outside the scope of this series, just flagging it.

For the EN7528 the GPHYs report EEE capability, but the link stops
passing traffic once LPI is entered, so EEE must stay off regardless.
The register loop cannot express that to phylib, as you noted.

My plan for v2 is to not advertise lpi_capabilities for the EN7528, so
mac_supports_eee stays false by design and phylink disables EEE on
these PHYs via phy_disable_eee() and refuses to enable it from
userspace. Does that sound like the right approach to you, or would
you prefer it handled differently?

Thanks,
Ahmed


> 
>     Andrew
> 
> ---
> pw-bot: cr
