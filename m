Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792515734;
	b=OeWaphYwuAYaO4OzxXaa/iWp35iTIJKoKNf4zurhecgdOwwy3MAecjjIyW66J9VekDLS
	 qRPf4ayIOZr7p1lLHB6Pp9QDKoBizFPTYnOVRYMAA1WvHUDFSTt09bEPXCQ3lwNWCH3FO
	 oLmBmjEBt6S0ssbkMiOdd7tsd66auH+GsVmm7NpkICS2mBXzf77Zs6rjp5u+cdce7ih3r
	 vBpX+67+rczoNF8QH1CHbhv6q1u9VGBBKpHx9+RPKz6frVV7ncvU8WIzxAn9zxdrUL/iN
	 jcpZfo0ZU10Yrqmud/AflVgNA2H+Sd+7QRz0Z/hr4/L9i+3rkyyepbX4ZNuy/4NAZ8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792515734;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=c2tWJog8tF6NqAN0I/hU2qsBbMxLRSq66EQB1uSbRW0=;
	b=NZDDNfq0rI1E0CiwLo7z5i3DxdC+E7/woxZsq8dxf4gxZAhDmLqgNyqxeD3oVTGKP75H
	 gR1wB7KB6ZSR+iXYxupm9DkRGI+sT1cG2hYdg8+Vxw0sxZ1JrSuZZ/B6hOk/5PoCpUaPD
	 zRblTBd+VElK9Da0MBqwuGGk4USPxrBm40J0zCUYkWvBDdHAd15Yl+RdO6osztnDIxUoX
	 d4B21QgYyMhsZ0JZ510gjgdJRREp5ynvrfE1oD2V4MSSYROlHa4cZbZe5Dm7w+ONYnoWH
	 PX0JyT2NketDf2+FoC/GcZRj/g9UTHORBWnRyrCLL6P4AekjjsZv5f0fEgJTUS6WtNQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=riscstar.com;
	spf=pass smtp.mailfrom=riscstar.com;
	dkim=pass header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=AY0iWU8p;
	arc=none smtp.remote-ip=209.85.128.44
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60665606A31D
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 17:02:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 60665606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=AY0iWU8p
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4a1dfd49525so22555555e9.0
        for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 10:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1792515728; x=1793120528; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=c2tWJog8tF6NqAN0I/hU2qsBbMxLRSq66EQB1uSbRW0=;
        b=AY0iWU8pvlbKT+2yzZbsuE25L2C2Gr41g/TG90G27s8xW1rj8Lu5RhcydvNnfvj2wH
         0qr076ccreXx1HR5lJ31ZWHUn0ku3zLvM95RLCGRkwGPz7PIC805yQ0m7A9kgL/wPNyp
         DXEexD4HiSyD/TZNLVmuVV/symdSscMT6yAzyvQbEhvg+eScdzOoCcSF2Xb4UbIRv7GQ
         u0j5cmv7vOam9mhrvFcJn+b1n2bG8zw7jv1rKwjbwBu1eo6NKwzw6YLLzkSYmMy2CWie
         CHFZ+lGaed1X4VKCt8VxWxIEbLUn5imtO3LGsV3zNOpQFXRcdjDrxp1p4M/zE3JlKmSv
         c4Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792515728; x=1793120528;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=c2tWJog8tF6NqAN0I/hU2qsBbMxLRSq66EQB1uSbRW0=;
        b=d7rvoU8vDKXkMz2scbmjl15QwOhX3i8dPrRV9up4JX9HTtiCMGtko7orZfXWjhP9kV
         B+D3mDo+UK707GbdlUsv6quy7d71wj34R8PJNTayxUD1vv/wNRe35iKY7+kIxhmELUpR
         qIApgnc9z8ECge7CmfjAbpODmcFVcJ9jZ/50GoYgTcut4KfCSmGQAEd8XGr9E/9sBg7X
         codGolVVs3uFal8wZBY/X/crmdM4pbVvHLPFxKgr91AmhbAh3qJdIS35t+WIAQIzWGZB
         fo2yvGyu1TnGZmB1n+P3/S7V+REVnDjUpNU0sQqATEbwDyxAXSn0lLDfUi7ifNyNV7kI
         nD0w==
X-Forwarded-Encrypted: i=1; AKwUvBzw6qkGFlajuYJK+MkdekZmVY9a8CnUofKQumZn6nHq1hBl8CjL6wz0GmLojf0BA8tZFNy7Ok8=@vger.kernel.org
X-Gm-Message-State: AFq9FYICNpr0P6pofPxf2QUwN9i1DAk1A7VAhBbxYPMHDQT1Qkp0OiTo
	eLIjQJwrOL4W9SF+lmhOlzK1xaW2AYol8bktw4g1vjk8mTWgsWgN2qv/tzwnDn0k7TY=
X-Gm-Gg: AYBFou3tYFd1Xb6XJ8w10kOjuSZMaoD5VOe6bxDl9G3t6dKX+Skzk+XcdA4Q8TM1ipU
	T8yOSBiZsVWmhBBJZcKRhi7uJxnOuqtpIXsHD+gAO2jzdeWnp0Uk3VCyx7ffATbhtL7OIqSgj6W
	7IaRc96G1sgsqoO5MadLNuXn/o+N4n1sWFyP0QLs2uqSmz+yMmTnJRbGPTTwULeBwgSktw/bb7+
	It8JuJqQZY5uuDiYvBLoF2rBvgIubgaJMXn4Wg3YmKFLwlrUXwtCWW2nIpY/GWVfR7+PwbHAeW+
	LVTrtHyLnFokKCKwCTAP01xl6rr4+UvnFTL8f2ZB8OC5K5wkAIBWRMzu0PDo04ZOetJ2Lr3KHcL
	a3EXdidCpNidUtth9mFCZx9AhC76e+zf5FdktGgBco2sT8tcjusUC0ntiRNk4G0izdHBIY3UXuB
	gtU+iqtY8QfNXtWoEMaBEgnDPisyAzlg7vmU+YbRsluRctpmajWO4X75fg1jcUlHvahN9oMFz9c
	IkRvl/qABlvtku05esdZ4lAK/NTzc1d63Q1dSda8z05Mp8BGMQ4HKHkqemug3c5xdQ8e8eMHMGB
	yUFvRiyG6SsQoEGPZ3cbDVBlSFZXbGKIsDgui/RDwyN7iFiumagGbQukAvo=
X-Received: by 2002:a5d:4602:0:b0:48d:f0e4:27a4 with SMTP id ffacd0b85a97d-48e07f9d7edmr19141664f8f.24.1792515727622;
        Tue, 20 Oct 2026 10:02:07 -0700 (PDT)
Received: from aspen.lan (aztw-33-b2-v4wan-169864-cust3247.vm26.cable.virginm.net. [92.239.204.176])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e1d82456asm8232406f8f.42.2026.10.20.10.02.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 10:02:07 -0700 (PDT)
Date: Tue, 20 Oct 2026 18:02:04 +0100
From: Daniel Thompson <daniel@riscstar.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Alexander Duyck <alexanderduyck@fb.com>,
	Alex Elder <elder@riscstar.com>, hkallweit1@gmail.com,
	linux@armlinux.org.uk, davem@davemloft.net, edumazet@kernel.org,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 2/2] net: pcs: xpcs: select operating mode for
 10G-baseR capable PCS
Message-ID: <ateejER1HFGxjQpG@aspen.lan>
References: <20261014223100.304486-1-elder@riscstar.com>
 <20261014223100.304486-3-elder@riscstar.com>
 <f8c01002-da88-4f0f-a02a-7480591f4296@lunn.ch>
 <atI1IK6blP-vumLQ@aspen.lan>
 <fe13016b-ebd6-4a2f-a07b-324f46b456d3@lunn.ch>
 <atZJBaHU2QQGwcnG@aspen.lan>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <atZJBaHU2QQGwcnG@aspen.lan>

On Mon, Oct 19, 2026 at 05:44:53PM +0100, Daniel Thompson wrote:
> On Sun, Oct 18, 2026 at 05:48:39PM +0200, Andrew Lunn wrote:
> > > default value after a reset prevents <=1G modes from working (I think
> > > automatic switch over between 1G and 2.5G also liked this to a reserved
> > > value but I don't fully recall right now).
> > >
> > > On that basis the best bit pattern to use one that isn't implemented by
> > > whatever XPCS we happen to be running on. One simple approach might be
> > > keep using 40GBASE-R but to check PCS Status 2 to ensure we fail in a
> > > non-silent manner on hypothesized future XPCS hardware:
> > >
> > > 	if (mdio_stat2 & MDIO_PCS_STAT2_10GBR) {
> > > 		if (mdio_stat2 & MDIO_PCS_STAT2_40GBR) {
> > > 			dev_err(dev, "40GBASE-R is *not* a reserved "
> > > 			              value on this XPCS");
> > > 			return -ENOTSUP;
> > > 		}
> >
> > Maybe. But we need to ensure it does not cause regressions for fbnic,
> > which might actually support this speed.
>
> I will sketch out an idea based on explicitly checking both my
> assumptions hold by checking PCS Status 2 and PCS Control 2 after
> a soft reset. Thus if you never reset then the code will never
> deploy. Likewise we don't need to rely on my guess that all XPCS
> implementations will reset PCS_TYPE_SEL to 0.
>
> I will also, given everything I've had to share by e-mail,
> improve the commenting a lot!

Patches will follow in due course but in case anyone is curious in the
mean time, that sketched out idea becomes the following. I had to read
the TRM very closely but we can avoid using the obviously weird 40GBR
value (the key information that allowed this version to write a better
value to PCS Control 2 turned out to be a missing bit pattern in a very
narrow column that I must have read tens of times without noticing).

Anyhow, pcs_type_sel_quirk is true if and only if my assumptions hold
(explicit test after a soft reset that 10GBR is supported and that
PCS_TYPE_SEL is 0 after reset). This hugely drops the risk of
regression:

+	/*
+	 * XPCS (at least in some implementations) is a little odd in it's
+	 * handling of PCS CTRL2:PCS_TYPE_SEL. Instead of PCS CTRL1:SPEED
+	 * SELECTION controlling how PCS_TYPE_SEL is interpreted it is the other
+	 * way around: the speed selection is only honored when PCS TYPE SEL has
+	 * specific values.
+	 *
+	 * This is a particular issue on XPCS implementations that implement
+	 * 10GBASE-R because that will be the reset value for PCS_TYPE_SEL. That
+	 * means that at reset, the system does not honor speed selection by
+	 * default. This forces us to recognize an XPCS with this property and
+	 * update PCS_TYPE_SEL accordingly.
+	 */
+	if (xpcs->pcs_type_sel_quirk) {
+		switch (interface) {
+		case PHY_INTERFACE_MODE_SGMII:
+		case PHY_INTERFACE_MODE_1000BASEX:
+		case PHY_INTERFACE_MODE_2500BASEX:
+			/* Really means 10GBX unless speed sel says otherwise */
+			mdio_ctrl2 = MDIO_PCS_CTRL2_10GBX;
+			break;
+		default:
+			/* Restore the reset value for unmatched cases */
+			mdio_ctrl2 = MDIO_PCS_CTRL2_10GBR;
+			break;
+		}
+
+		ret = xpcs_write(xpcs, MDIO_MMD_PCS, MDIO_CTRL2, mdio_ctrl2);
+		if (ret < 0)
+			return ret;
+	}

The code still doesn't entirely spark joy but I think at this point I
can blame the hardware!


Daniel.
