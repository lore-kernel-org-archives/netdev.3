Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BECE339390;
	Fri,  2 Oct 2026 15:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790954252; cv=none; b=bQjdes1DurVUKZJcX/m7v2fyUcX0rTd4CD+qJigpMh3synpzfHWl+w1H/BgOWsx8ARFl3UssQNIMlviaoW7GclszC+JJZip1ImgU9bEe/PiklmxNkIdgKvkoxtvbJIarN8VNG5fyXuotIuh3Zb/by8zbxCdyx52gmy3D5/e70Jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790954252; c=relaxed/simple;
	bh=OWrRY1L0lr5L241yI1W1zoC7MC22LmDGJClsebq1+OM=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=kvzKGuwcYpx0qT0Tm2zTiCdLqvsKUVIVDUjcc2BF6o1DU3oGjXJ61kF8Pc4fAoemQGbH7ZZfIbGYJ/RCMI0Af9pmA2Kd+vBJe87rXbhXLVWwInn0JFRjHvEtUpivyWriuAVVCX8QGjERVZ9i1RHV5KEqkmAB+px4Ai/6LkcZwd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=SMCF/6DT; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="SMCF/6DT"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=default; h=Content-Transfer-Encoding:Mime-Version:Message-Id:Subject:Cc:
	To:From:Date:subject:date:message-id:reply-to;
	bh=wE3U7Byhrw/Kpcm8Ly1rmNIVci2f+5xG9aFcXfipmYw=; b=SMCF/6DTq0glMoooo/iQqxm/tX
	sg7VCwD1qirlhknp4EwkW5M42uM+MoJd9oS3digNacbkJgC2yN030yIeoNl4o+GpPv8SlgXJTQNjy
	SSOBuFI8nphakfUvWg5xBYzJ91sQ3iG4V8b6DAbC1wAgZKQWCiOPCUQl9CT4+qptf0LA=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168] helo=pettiford.lan)
	by mail.hugovil.com with esmtpa (Exim 4.98.2)
	(envelope-from <hugo@hugovil.com>)
	id 1xCf0k-000000007gc-07t4;
	Fri, 02 Oct 2026 11:17:23 -0400
Date: Fri, 2 Oct 2026 11:17:22 -0400
From: Hugo Villeneuve <hugo@hugovil.com>
To: Stefano Radaelli <stefano.radaelli21@gmail.com>
Cc: Frank Li <Frank.Li@nxp.com>, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, pierluigi.p@variscite.com, Stefano
 Radaelli <stefano.r@variscite.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix
 Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>,
 Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, Shawn Guo <shawnguo@kernel.org>, Joseph Guo
 <qijian.guo@nxp.com>, Josua Mayer <josua@solid-run.com>, Ernest Van Hoecke
 <ernest.vanhoecke@toradex.com>, Mehmet Fide
 <mehmet.fide@screeningeagle.com>, Francesco Dolcini
 <francesco.dolcini@toradex.com>, Markus Niebel
 <Markus.Niebel@ew.tq-group.com>, Hugo Villeneuve
 <hvilleneuve@dimonoff.com>, Stefan Eichenberger <eichest@gmail.com>,
 netdev@vger.kernel.org
Subject: Re: [PATCH v4 00/13] ARM: dts: imx6ul: Add Variscite VAR-SOM-6UL
 and DART-6UL
Message-Id: <20261002111722.a09e76b8e19fdfe3dc857b4e@hugovil.com>
In-Reply-To: <ar-cgeR8U0dmOTvI@Lord-Beerus.station>
References: <cover.1790693249.git.stefano.r@variscite.com>
	<20260929121455.437291ea4b53130e3e19778c@hugovil.com>
	<arv4MwHV4LntROkN@Lord-Beerus.station>
	<20261001144344.2100854b8f5e2d81cf87b424@hugovil.com>
	<ar-cgeR8U0dmOTvI@Lord-Beerus.station>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam_score: -2.0
X-Spam_bar: --

Hi Stefano,

On Fri, 2 Oct 2026 13:58:57 +0200
Stefano Radaelli <stefano.radaelli21@gmail.com> wrote:

> On Thu, Oct 01, 2026 at 02:43:44PM -0400, Hugo Villeneuve wrote:
> 
> Hi Hugo,
> 
> > 
> > Great to know Variscite is adding support for the DART-6UL.
> > 
> 
> Thank you Hugo :)
> Over the past year, we have been prioritizing security and consistency
> by adopting a mainline-first approach.
> We have added support for almost all of our SOMs and configurations,
> as well as several driver changes and additions:
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/log/?h=master&qt=author&q=Stefano+Radaelli
> And now it's time for the immortal i.MX6UL!
> 
> > 
> > Please work with the existing modular DTSI files, do not simply remove
> > them and reimplement them into your own files.
> > 
> 
> Agreed. Where possible, I’ll reuse the modular files you added and
> propose fix commits wherever changes are needed.
> 
> > 
> > I tested it and it works. But like I said, if adjustments need to be
> > made, they are welcome and can be done in a separate patch to fix it.
> > This sequencing is something not very well documented in Variscite
> > datasheets. I asked Variscite support to improve the documentation for
> > that aspect but it was not accepted.
> > 
> > 
> > > For the LWB5 option, the procedure enables WIFI_PWR, waits 10 ms,
> > > enables WLAN_EN and BT_EN, waits 200 ms, then lowers BT_EN before
> > > re-enumerating the SDIO device.
> > > The other Broadcom option does not use the separate WIFI_PWR step.
> > > The existing regulator and MMC power-sequence nodes do not express that
> > > complete, module-dependent procedure, particularly the BT_EN step during
> > > Wi-Fi initialization.
> > > The scripts also select the Bluetooth firmware according to the detected
> > > SDIO device.
> > 
> > Firmware loading is handled properly by the kernel without external
> > scripts (tested with Concerto EVK).
> > 
> > 
> > > We use that procedure to avoid sequencing-related failures for our
> > > customers.
> > > This approach is not new to Variscite’s mainline DTS files.
> > 
> > Yes, this is an old way of doing things, which may have been
> > appropriate in the past when proper support in the kernel was missing
> > to achieve the proper sequencing, but no longer true these days, unless
> > I am mistaken.
> > 
> 
> We are glad the kernel-managed sequence works on your Concerto EVK.
> However, it is wrong for the LWB5 module configuration we support:
> it does not follow the required power-up order and timing validated
> by Variscite.

Please detail exactly what is wrong so that it can be fixed. Better,
create a patch to fix/improve it.


> The sequence is based on the module requirements and has been tested
> in our labs and across customer configurations over many years.
> A successful test on your EVK does not show that it is correct for all
> the modules and configurations we ship.

Again, like I said before, if things are not optimal they can be
fixed/improved, not completely wiped out.

I can help you with this (test/implementation) if you explain the
problems properly.


> The GPL-2.0-only userspace scripts implement this required sequence.
> This is not a matter of preference or an old approach we kept by habit;
> replacing it with the sequence in the current DTS would risk breaking
> supported Variscite configurations.

Please be more specific.


> If a future kernel implementation can reproduce the complete,
> module-specific sequence, Variscite will be happy to update all affected
> DTS files to use it, after completing the necessary lab testing across
> the supported module variants and configurations.

You need to work with the existing kernel implementation, not delete it.

> If you need any additional material, datasheets, or other information
> from Variscite, please let me know at stefano.r@variscite.com.
> I’ll be happy to provide whatever is needed!

As mentioned before, please add the required timing
sequencing info to your datasheets, it will help everyone.


-- 
Hugo Villeneuve
