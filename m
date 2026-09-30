Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 721B3448B8F;
	Wed, 30 Sep 2026 23:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790809662; cv=none; b=W0qETYkyIpnzB+JRm1r+9/RQYUlmTCAOfh7xiar70ijaeDpRTloz/Z4H1bUgYUq3RLRhi4o/dtSpQLTiTzSky/+9syQNwQiy5qOHBWrTGSaLYNI4ipA76gcjr/SfsRVaWj8UNZgzIGNc5SdD9JKVNQct6QW7RSmpRID1/L6pn3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790809662; c=relaxed/simple;
	bh=vC9QORnlqZtBlA3M5N5zcCu38I8c/qWHaOEde7sc4JM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LgcLr8Lqz2h5nKIuRuH7ooRt74RyuTTDS3MUyMNTKg81gGscf/wqllB/an32rVfSGBLcdgTaftDznyF2UlSno9qxhRAbxp5cK4+qpayxfiNKGbVFMDPUrt0NYlT6NiA3UhXYdl1Va2SR7fKxOXutd4dqc+GyAnK6DRIE/ajN4T8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YXouvGwM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YXouvGwM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4CBC1F000FF;
	Wed, 30 Sep 2026 23:07:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790809657;
	bh=cxuWnLXV4IcGawGVDsabPJlwEsh1Tm4Ci5cwQ1fImcI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=YXouvGwMVudv3WL5xczaCCXJtJJV12bV5q3AUrZCwx9ng7+1/IFv7C8tm3yxlwy2R
	 Qn4dELrg4RGH24aiLNLqSHaGDArYqCYyxcdzkGmjqNvsuKHI4bnxdZ7xI08yq2rt5Q
	 x79YeUxWGLbL+2eY1IZbqsj2YFNNdUtDIWpZxQj8YFI+V504HAGDyP+ZTCThuiOOiZ
	 aqLBcgZ3g2lvVnjM1VbJPuYIyYaaQc80IgtKv8AXgzG2pVeur8UmvwcbdahWIvQLqU
	 lVAr6aO7ivV1KyCg4kI2PAXhfNCxgJ2WboAqv8dIBvjDZeq+7anGnZ8uyv1WAnMBBl
	 Mw4ZIVi1dHwEQ==
Date: Wed, 30 Sep 2026 16:07:36 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Maxime Chevallier (Netdev Foundation)" <maxime.chevallier@bootlin.com>
Cc: Andrew Lunn <andrew@lunn.ch>, davem@davemloft.net, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Russell King <linux@armlinux.org.uk>, Heiner Kallweit
 <hkallweit1@gmail.com>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
 <skhan@linuxfoundation.org>, Oleksij Rempel <o.rempel@pengutronix.de>,
 Vladimir Oltean <vladimir.oltean@nxp.com>, Florian Fainelli
 <f.fainelli@gmail.com>, thomas.petazzoni@bootlin.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
Subject: Re: [PATCH net-next v2 0/3] selftests: drv-net: Introduce
 flow-control selftest
Message-ID: <20260930160736.73243fe4@kernel.org>
In-Reply-To: <20260925182628.214667-1-maxime.chevallier@bootlin.com>
References: <20260925182628.214667-1-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 25 Sep 2026 20:26:24 +0200 Maxime Chevallier (Netdev
Foundation) wrote:
> This is V2 for the ethtool flow control test.
> 
> This test aims at validating the flow control implementation in drivers,
> using the ethtool API.

Still does not look like our other tests but good enough, I guess.

One note on patch 1:

        wait_file(f"/sys/class/net/{self.dev['ifname']}/carrier",
                  lambda x: x.strip() == "1")

is a shorter way of waiting for link.

Other than that looks like pylint has a couple of nit picks

tools/testing/selftests/drivers/net/hw/pause.py:1:0: C0302: Too many lines in module (1035/1000) (too-many-lines)

tools/testing/selftests/drivers/net/hw/pause.py:1020:0: C0116: Missing function or method docstring (missing-function-docstring)

.. and we'll need Andrew's review.
-- 
pw-bot: cr
