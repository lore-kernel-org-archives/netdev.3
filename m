Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F7AF49C4A4
	for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 08:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792053858; cv=none; b=hWVBP6RBbGCktmltNvB6Y2G4qjrZxQNDLZtqHZRZbwbCFx0VOe3k98QfARRmhrFeZCYCQnvRHFR8XjqosezKrtvXqN041w2ZH3/LrWUh75XMarXbZPBv4wHpbKcXmwVbazvYqoQCY4xBrcddDXz2S3YKpteeR8PjpZ0Y/liSres=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792053858; c=relaxed/simple;
	bh=SlB68F3f+BdlirJUEjyixhDsOheZ/zyFCqTY5noaKsY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=isvhj9u68+fC9V+fZArP799KN2V/PvwSFpyzuJCbEMTL5VEbkqOzJDQ2gnmTZD0vda6+TGFsfblYze3NIzfHFEDbQ9iknGGtzkvKnydRaNCIGXY0LOVzSzGq3f3IfwOZC/0QGQmmcO/KPvhJA3yDxOfyVNK2kacqbsODXoPPTW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b=Qu38pjZv; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="Qu38pjZv"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4a1b07c3c5fso16364525e9.1
        for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 01:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1792053853; x=1792658653; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7CSJIT17g58+oITTv0q53z5VUcT+bUH2Z8uN5LCucOA=;
        b=Qu38pjZvJ/9yhCQf/QKDuagSkuepfr5Kk4tIXVsmZhlVJ/NmU/xNH8es5/NAEIsURr
         yrmv9zxxVdZYiRB2SrFmfZYTl/wvPWUtOWhcyZdQI+x7U3A2zKuZwiWQ6z/t0oDn0xw3
         nUXE/xKb8VNb9VQF7TLqOuEtHg4nMfke9frKMXzHZLx0M0Y8b4l8Qst9eiJ9uIfrkqVo
         7SybQMAYfEgETv8MPcq2JMabHLhSg2gR7tpiMCubNSVkLMl5J7vhr9gf5BavxFLBBiog
         cnLE8Q+afMWLx4G8S2fD59alFjbU2N/25/ZiDwdvWe9CFq4QBDFc40wcELPL/AwHOq2g
         PcwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792053853; x=1792658653;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7CSJIT17g58+oITTv0q53z5VUcT+bUH2Z8uN5LCucOA=;
        b=XcMx5kh3SINpyPxtI26ZXi0sCvufLKO4Xnk24M5OTIvSECNmn0P0tOczs4MoPnfcaR
         CgvIgkW26X6B7tZg50cHYqN0jcXyrryUbMtgv/d8S2wpNtppz1/wPdWwERKhtXeQTRDr
         si0Fl7WLjfsuOBXEzEU5Il5daOosruPnyKbVuwQVz3hp8X6at0w/edxSerg5k2mMGbff
         qK6gEJ/5OW1Px6gL8EYI7CktbjqF9oP22M8aNyKv6EidZPlvxvQM9Soxm8mbw6BnNx7K
         8WbgykQ3Qsb+XyuHVmsqJkQOjiw/6UjvH4+QuPy4mUdFrY0n/HHTZEUFBPm7KOJq3mvG
         Tf5g==
X-Forwarded-Encrypted: i=1; AKwUvBzVSl6PaBi8Zr3YDGQL7uE/66j0Y2DC2IaTk1cvKYySYujNWPjGhN0CMxd26akakWVLbt4ZGlc=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ6elOE3QfMhj6g2A3sZMbhrhCdoUT/IcDa2nWe3dotQXA7kH8H
	ycQH9XYtg8ZY7TVhwr72vGf1+Qp0kv2yoUweOy6C0XGXInkZA4z69hwhw+UW83nUDCw=
X-Gm-Gg: AYBFou2cbebyO2olRlXiuhlzXL1zSrGQGPRFSozbOIJ36h/lCzDxYEQqIWl8rqUfnwh
	mxOnVeLCyX3Nvvbf5T+G39PAmw1nlk+g2FS0a65MIUYp1iw9hs6Wumyz2OkAzWWul8qZ0G/Ex5p
	9B1+64SLnUqaUXeDp+nDuAiQfGGcu25/rEm06xIT1LROORhWKJkcASfIF0w8Q0Iz85EDO9kCEhG
	BgPalVBpY9j5PcjnNUNPaX//NVa9W1snC4MWuvQTLjXEuFvyA0ZUHtpV5/HAb5lJXNnHzjXX7R5
	Q6nYcUe5jZijQDwVZaIbJKyYHo9IUpiAWDbQW0uDk1cH5MRGiwG2bhcpUH874aknT1Fl7zt7ot5
	IM9basrftpkM+yHNRCJPgqhO8IeZOdcKqEkMQNydb77yLmSjdGBBYgxgVIRI1yHUp/peetCjYsJ
	herbqDKVhrR6wGTJj+7ndwOnoFK3fIvJj/8MES4uceHl+24Ilx+HsiUITsSHpfac/4+y6JZRCYo
	SyBWJfAWVjaRR1yluo1LoWX83WwIlnpBmHhkpNWMXtaPb/cILTVSB9v9z/MeGdhCP9BOjgz+HS5
	qeWW34rBGU91HP921e8G5Ez1KHiedIqkKoAMse/bLrAerSZYubyFX7poTV8=
X-Received: by 2002:a05:600c:c092:b0:4a1:9831:a69c with SMTP id 5b1f17b1804b1-4a19831a9f7mr220004565e9.30.1792053852671;
        Thu, 15 Oct 2026 01:44:12 -0700 (PDT)
Received: from aspen.lan (aztw-33-b2-v4wan-169864-cust3247.vm26.cable.virginm.net. [92.239.204.176])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1bd993caesm110794555e9.12.2026.10.15.01.44.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 01:44:11 -0700 (PDT)
Date: Thu, 15 Oct 2026 09:44:09 +0100
From: Daniel Thompson <daniel@riscstar.com>
To: Alex Elder <elder@riscstar.com>
Cc: Andrew Lunn <andrew@lunn.ch>, hkallweit1@gmail.com,
	linux@armlinux.org.uk, davem@davemloft.net, edumazet@kernel.org,
	kuba@kernel.org, pabeni@redhat.com, donggeunyoo.kernel@gmail.com,
	ansuelsmth@gmail.com, mohd.anwar@oss.qualcomm.com,
	lorenzo.bianconi@oss.qualcomm.com, danielt@kernel.org,
	netdev@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: phy: qcom: qca808x: Add regulator
 management
Message-ID: <atCSWZQAyqvz62_K@aspen.lan>
References: <20261014172300.292324-1-elder@riscstar.com>
 <44a96544-5ed8-4bdc-8757-d7413e221f40@lunn.ch>
 <4c0d9a12-6236-4bc5-949c-62a092edb0bc@riscstar.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4c0d9a12-6236-4bc5-949c-62a092edb0bc@riscstar.com>

On Wed, Oct 14, 2026 at 03:41:20PM -0500, Alex Elder wrote:
> On 10/14/26 12:36 PM, Andrew Lunn wrote:
> > On Wed, Oct 14, 2026 at 12:22:59PM -0500, Alex Elder wrote:
> > > From: Daniel Thompson <daniel@riscstar.com>
> > >
> > > QCA8081 appears in embedded board designs paired with GPIO controlled
> > > regulators for its power rails. Add logic to allow these regulators to
> > > be turned on during a probe.
> > >
> > > In order to avoid the complexity of tracking state for suspend with and
> > > without WoL we take a tremendously simple "always-on" approach to
> > > regulator management, essentially relying on BMCR_PDOWN to conserve
> > > power when the phy device exists.
> > >
> > > Signed-off-by: Daniel Thompson <daniel@riscstar.com>
> > > Co-developed-by: Alex Elder <elder@riscstar.com>
> > > Signed-off-by: Alex Elder <elder@riscstar.com>
> > > ---
> > >   drivers/net/phy/qcom/qca808x.c | 30 ++++++++++++++++++++++++++++++
> > >   1 file changed, 30 insertions(+)
> > >
> > > diff --git a/drivers/net/phy/qcom/qca808x.c b/drivers/net/phy/qcom/qca808x.c
> > > index bab26e4c61408..6e2bd753257d9 100644
> > > --- a/drivers/net/phy/qcom/qca808x.c
> > > +++ b/drivers/net/phy/qcom/qca808x.c
> > > @@ -1,6 +1,7 @@
> > >   // SPDX-License-Identifier: GPL-2.0+
> > >   #include <linux/phy.h>
> > > +#include <linux/regulator/consumer.h>
> > >   #include <linux/module.h>
> > >   #include "qcom.h"
> > > @@ -181,15 +182,44 @@ static void qca808x_fill_possible_interfaces(struct phy_device *phydev)
> > >   		__set_bit(PHY_INTERFACE_MODE_2500BASEX, possible);
> > >   }
> > > +static int qca808x_power_on(struct phy_device *phydev)
> > > +{
> > > +#ifdef CONFIG_OF
> >
> > Does this need to be conditional? It seems like
> > devm_regulator_get_enable_optional() should return ENODEV, which you
> > already handle.
> >
> > Making code this like conditional makes build testing less useful,
> > more combinations which need testing.
>
> This is a really good point.
>
> > Another option is
> >
> > 	if (IS_ENABLED(CONFIG_OF)) {
> >
> >
> > 	}
> >
> > That at least compiles the code, and then the optimizier throws it
> > away when it sees  if (0) { }
>
> Yes I like doing it this way better.  I'll modify it
> to be similar to this for v2, which I'll plan to send
> tomorrow.

Reading things back, I think Andrew's first suggestion of having no
conditional might be better.

devm_regulator_get_enable_optional() is log-silent on failure. I suspect
the reason this code was conditional is that an early version used
devm_regulator_get_enable() which is not log-silent when it falls back
to a dummy reg.

I suspect I was more influenced by the log-silence than the marginal
code size cost on a CONFIG_REGULATOR && !CONFIG_OF system.


Daniel.
