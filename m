Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8109371860
	for <netdev@vger.kernel.org>; Tue,  4 Aug 2026 18:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785868368; cv=none; b=K2gy6OomQkcp6v0Nb8VcERdqH0mAInMCBWuV/jBsrybQcv5v4XkNHfBsklYYx2AGKIxYsTTUL0HKEuIunC5XfSddMnYlZMD/dg5LzeYQWEBgc0fZHvh+EEZxf/lgjRNNBHV+vSVXIBo/jV9NK/bnKQPV3MIY+azd6K/k1WQ1y2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785868368; c=relaxed/simple;
	bh=RZ2UBfczD/1R4n+p2pN7umHlT0/VqSZbWqI1U5UVaS0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=puwbHgmHSwqsXAoIKcpoo9sAxeB/PyQ+gOWprPNREz7MP0TNqVT/L8snut3Liw2z5ufhkrV5RVDbK/9rnLnYDYKE2EM4P7NRRogqv1Qlgr0fP5GybWRcnCBpidELKp1s5ynZ5/woVxkKNnGu0utf6S2hmgBqxFD/dwPcTW1rudQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PBKEYcbR; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PBKEYcbR"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3856d6fbcb3so101554a91.2
        for <netdev@vger.kernel.org>; Tue, 04 Aug 2026 11:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785868367; x=1786473167; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=T46aT6b6jrcEqP7BKbyuJ+Dqx/tXTl32zZ60csvLnD8=;
        b=PBKEYcbR0PvT1zeXts34GIlYiHL3q5pnqDhgG4ltjJA5tu8fhM2N3LGGp1TPT5GUM1
         PEJNliQktkqVNYcV3yu11EZ2lJyuiES6kyqtsgWoVrjgpUs9CycCtJS00W2A7USnJWdZ
         3KY4GpNCHVROWLGmTnTRHlnkWRfmiuqh76UawMRmT4HetY7JXFzurWcstZwE7s2OLO6k
         DVbWsRYaksm5bURGklSIxUUBVwJBYJIQ33E1CwnUz00IsJ8D+hY9sSqZMJlBFKE420EM
         beUCb2PRuIDTRDSyXtHdf3Hz+EZZ8M5H8RGZOF/9msErfpR71zwM1nx/QYgdOyPAviAf
         UddA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785868367; x=1786473167;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=T46aT6b6jrcEqP7BKbyuJ+Dqx/tXTl32zZ60csvLnD8=;
        b=TDND0P90OawdkAX8qVA+rZCAaWMAzW7A5vrwIffhr5m1EhDD/uhMJF4mnQhp+QV04d
         7BIuxWsGYe5RtXlNC3dkR56WUAcIZgFwefrIfjhYRUUGhvs4TOhSm38Fxvtq1/akqJVQ
         Rtk0sMSYU1n47qkhtdnAkzHY7cXLPmZgHS47kxslB/L9iF9/A5+SriOxK4LZYdol7EBw
         T+/LzirzTWZIflDdgw+Nr3Yh3BNuWZhIkkigBfheQ5hPT/d6kl7Uky+0oT+UdnrhFLcd
         EiUlo/yYFtCLo2dG1TUTlfv1+xMRHbDPPf6JzSATNqeU0UARyAClAqrKlCd+vtn51mwB
         iG0A==
X-Forwarded-Encrypted: i=1; AHgh+Rrt1CflA6XUNiYLRU2Fw/A4ErzwyAnpzvdFGuKreerEkfiJFPFJcYqqyI2/Zj5+ut0y8WWX95w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsXoqs2U5i2Tc73So/UwpE9e3kcwLcTSTwxRJ2o9b45eC95YcW
	Fm7vbuRoBAFEzqNFgtVlDtDPCy7Bq3hjtOekQ3U6Cc8z80aBBNDoxWWm
X-Gm-Gg: AR+sD13W2MLg87qJ2MJwBEnoEzdd8sZiadeB80sUWb3Oj/ZggFI2c5xqqm9be2bEN90
	2ndMwVoQOa3VV9rUR0k/gJmJg0w3mhhRYnA5QoSkzZ/4H0P6gcF++6nvLUELcaZNuehISvOsbPI
	V48jNrP7ma6yAY8sjiWHfooiLgC0wIlLz0zIu2/G6H2pnR6yp69oZI0saLnlVrXd/cmzWIvHF5o
	o5r09+fs0CX9JTVizwzmJHbitG0Zb6c3CSY8bGZZDysOzlU8mM7GuDufNjgWJs4DYaATIpeSgXT
	OUJnEKlqJYfwRAEzaaEdBAxQXeQJO7+3Pei7dFjyxtDeQLiGarfQ8Z2iERQwlW7QsLp9tBzBy2T
	IvR4+5TDS86ia6Zio6ufhJnQXPQWUyqcjRpAPK6bVZ2apE2/vJjWHV08QoKDaGMiHDvEwsfgKDv
	RbT63coQ709aIspzniINkSWpoFBrVpM9npePGbLApPxzmM/jcNnJiaj3OKUQbr224dGfjSEqlnp
	SZb
X-Received: by 2002:a17:90b:224e:b0:38e:9ef9:eb97 with SMTP id 98e67ed59e1d1-3903c5c443dmr636262a91.16.1785868366824;
        Tue, 04 Aug 2026 11:32:46 -0700 (PDT)
Received: from DESKTOP-TIT0J8O.localdomain ([49.47.198.15])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13fca926c0bsm5440864c88.14.2026.08.04.11.32.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 11:32:46 -0700 (PDT)
Date: Tue, 4 Aug 2026 22:32:38 +0400
From: Ahmed Naseef <naseefkm@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Ahmed Naseef <naseefkm@gmail.com>, netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Eric Dumazet <edumazet@google.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>, Qingfang Deng <dqfext@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	SkyLake Huang <SkyLake.Huang@mediatek.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net] net: phy: mediatek: fix TX blink masks using the RX
 bits
Message-ID: <anIwRrQT9qMD89v5@DESKTOP-TIT0J8O.localdomain>
References: <20260804113511.3371248-1-naseefkm@gmail.com>
 <ab2f7f4f-0f46-4c6e-b3b1-ea713dbd08c6@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ab2f7f4f-0f46-4c6e-b3b1-ea713dbd08c6@lunn.ch>

On Tue, Aug 04, 2026 at 08:11:21PM +0200, Andrew Lunn wrote:
> On Tue, Aug 04, 2026 at 03:35:11PM +0400, Ahmed Naseef wrote:
> > MTK_GPHY_LED_TX_BLINK_SET and MTK_2P5GPHY_LED_TX_BLINK_SET are built
> > from the RX blink bits instead of the TX ones, so both TX masks are
> > identical to their RX counterparts. The TX bits they should be using,
> > MTK_PHY_LED_BLINK_{10,100,1000,2500}TX, are otherwise only referenced
> > by the per-speed branch of mtk_phy_led_hw_ctrl_set().
> > 
> > A TX trigger selected without a link trigger therefore programs the RX
> > blink bits, and the LED blinks on received traffic. The masks are also
> > used to decode the blink register in mtk_phy_led_hw_ctrl_get(), which
> > as a result cannot tell the two triggers apart: an RX-only
> > configuration reads back as RX and TX, and a TX-only configuration
> > reads back as neither.
> > 
> > Fixes: 7f9c320c98db ("net: phy: mediatek: Move LED helper functions into mtk phy lib")
> 
> Was this bug introduced in this commit, or did this commit just move
> the code around and it was broken before? The Fixes should go back to
> where the bug was added, which could be earlier.

It was introduced by that commit. Before it, mtk-ge-soc.c correctly had:

  #define   MTK_PHY_LED_BLINK_TX      (MTK_PHY_LED_BLINK_10TX |\
                                       MTK_PHY_LED_BLINK_100TX |\
                                       MTK_PHY_LED_BLINK_1000TX)

which 7f9c320c98db removed, adding to mtk.h in the same commit:

  #define MTK_GPHY_LED_TX_BLINK_SET   (MTK_PHY_LED_BLINK_1000RX | \
                                       MTK_PHY_LED_BLINK_100RX | \
                                       MTK_PHY_LED_BLINK_10RX)


Thanks,
Ahmed

> 
> 	Andrew
