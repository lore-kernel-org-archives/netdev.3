Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14369C8F0;
	Sun,  1 Mar 2026 00:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772325151; cv=none; b=co40HMZBv8t+d4aaPXUcIgpw2ox/Sor+P0ooFz6qOa2iiNbpKnaJHQ7Gp4sMCllaZdJKHsa1ltflbSlcxWsRcwVr23h9202RTk93wBgusti3PKGVoj9q/Fqy9Mr1bNKUpUaa5y6/9vU/GKB6QmPhN1aScddOA/YydrWjYy9nUg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772325151; c=relaxed/simple;
	bh=TrV9WuauQIJMEiV5wFKqcBZhdXyHXR+OiLKPj6LkgY8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DwbcX72tdNdTAyJbXyBqyDfoN4ZRNDX0O7le1JqaB3nWLH3UxRuRZnF7kdKbdUBLU2v2TMSYKyFttiwe/vQIzuIFtfIn7qv48D79dZOMqWbdp7xlCXN8d+tzj3O1IjXVoxIpOZXuW3epaVr1iV1NnX5owr/75mPB9JRkxji4uak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n4FjocUs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n4FjocUs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 029FDC19421;
	Sun,  1 Mar 2026 00:32:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772325150;
	bh=TrV9WuauQIJMEiV5wFKqcBZhdXyHXR+OiLKPj6LkgY8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=n4FjocUsnH9ow+vG/caTVCBGsupj6baiby6R9/+J+554TwP7pfoCJg40d9fDBNtOY
	 XV1FPy1wsDXHW7KlsFpZC01/W+Q9U5c9qdGb35+moXGWpXYyJAkDhTQHRG7aCCSUjq
	 Y+ieR7hrNTDCeKNsfkyboHf34BS+4i0QNL1UmbeRCJZJaxOsYJRZ3ltBT87QhxGEM1
	 JNDk67+eFNZYojXj4Qqbrt1c/P3RIJDDmfzHUUFsPCXuCc0Fkai0btjP+JOK+DV4ot
	 Pgd6HtPRocHRezXUG3WrNXogy0QDgm2VXB93PRcQMr9mR33qLcClaZNHYqszPGIhko
	 eLqwxJfzZEXQg==
Date: Sat, 28 Feb 2026 16:32:29 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>, Andrew Lunn
 <andrew@lunn.ch>, Alexandre Torgue <alexandre.torgue@foss.st.com>, Andrew
 Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, linux-arm-kernel@lists.infradead.org,
 linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, Mohd Ayaan Anwar
 <mohd.anwar@oss.qualcomm.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>, Vinod Koul
 <vkoul@kernel.org>
Subject: Re: [PATCH RESEND2 net-next 0/8] net: stmmac: qcom-ethqos: further
 serdes reorganisation
Message-ID: <20260228163229.1024f263@kernel.org>
In-Reply-To: <20260301001453.lpd2rawy7bqxyivp@skbuf>
References: <aaDSJAc-x2-klvHJ@shell.armlinux.org.uk>
	<aaIysVxy-WxbiJz9@shell.armlinux.org.uk>
	<20260227165556.5cf9e844@kernel.org>
	<20260228083111.5df8550c@kernel.org>
	<20260301001453.lpd2rawy7bqxyivp@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 1 Mar 2026 02:14:53 +0200 Vladimir Oltean wrote:
> > > Yes, that's what I thought but then I saw the other thread..  
> > 
> > Trying to apply this now but stmmac parts don't apply on Linus's tree,
> > and Vinod wants a tag :( What do we do? 
> > 
> > Could you, perhaps, send us a PR with this on top of Linus's tree 
> > (a resolution of the inevitable conflict with net-next would be helpful
> > too).
> > 
> > Or do we give up on the tag?  
> 
> Actually, I think it's mainly me who wants a stable tag. 

Ah :)

> I'm working on a series for phy-next which will conflict with this 
> hunk from Russell's patch 1:
> 
> diff --git a/drivers/phy/qualcomm/phy-qcom-sgmii-eth.c b/drivers/phy/qualcomm/phy-qcom-sgmii-eth.c
> index 5b1c82459c12..4ea3dce7719f 100644
> --- a/drivers/phy/qualcomm/phy-qcom-sgmii-eth.c
> +++ b/drivers/phy/qualcomm/phy-qcom-sgmii-eth.c
> @@ -7,6 +7,7 @@
>  #include <linux/ethtool.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
> +#include <linux/phy.h>
>  #include <linux/phy/phy.h> // this gets renamed to <linux/phy/phy-provider.h>
>  #include <linux/platform_device.h>
>  #include <linux/regmap.h>

That's not too bad.. if that's the extent of the conflict (which is
probably hard to predict at rc2?) we could let linux-next handle it. 
Of course assuming Vinod is okay with us merging Russell's entire
series.

> If there's no other way to provide a stable tag other than on v7.0-rc1
> (like for example a snapshot of current net-next/main), which I didn't
> know wouldn't be possible, then I think going with the route of fewer/
> more trivial merge conflicts makes sense.

To be clear, it's only about having a common ancestor, I wasn't actually
planning on making y'all a tag. I'd just apply the series on top of
v7.0-rc1 and merge them in. Then anyone can tag the relevant commit 
in net-next or use as a base for their own work.

I haven't looked how bad the conflict would be if Russell's work was
rebased on Linus's tree. If the delta is not too bad, and we can just
resolve the merge conflict when pulling it into net-next. That's
probably the cleanest.

I don't recall us ever making a "dirty tag" on net-next which would
propagate few 100s of netdev patches into someone else's tree :S
IDK how Linus would react. It's the least good option IMO.
