Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95D8B3DD523;
	Fri, 25 Sep 2026 20:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790368272; cv=none; b=qA305VzCmaRjB+vA/kjpWAmIWGCeL1MVaqBCT+xzhgosZiWhAvSUZsMz/mB0m6iJiC/M6EEY5UzITVbss9AQ8z77WNrOlzy2nsM/nWiKkxAKzs2T4c2n7eBnieLTaucCdLZq4vDZK7HrMLhdXWeawgP3W+IsSVGPKZHZJuEWQF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790368272; c=relaxed/simple;
	bh=G1cRMCvQgExZ/8QTMQMMdwlsD4hXvasNLu7/GStsa+4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=haALpui89vU8K8qXc80dX/6g4cehc0w8b/7WzYKQXiWgBVH9qVnfzVV3LkUw4D9YKZeusCVrIUuI/wGHbvlgoRTYi9MPyFzXI4tjCUS8FyqLEgmXk8UPqevvXoY6DDLOv/9Zup6tVB9MoxugLzIPZfljRHG18Xr2dZa1tZdl1fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iJRxkOlF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iJRxkOlF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C121F1F000FF;
	Fri, 25 Sep 2026 20:31:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790368267;
	bh=G1cRMCvQgExZ/8QTMQMMdwlsD4hXvasNLu7/GStsa+4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=iJRxkOlFbnbW8/xJHzxRbTD8cEVK41dtY8T46yxBakKZ+QfcphlZTdJdKQb9JnNnK
	 k4rDMrlkd3zYvV1bKgMMycMb9ohw8hWuvy4WbbchbAVOhChS0LBeBjeWKIBIUvW7Mi
	 xgFF+NePQ4aTe2+Sm32YVnByEcJDSR5ujlLdtqBykZhOPpwVIpAsTDEB0RDGB2ygPn
	 y7TJFrYFxy7CjfIHo6fKGVy49GNBt561uZk/luKStynOZ6lv9zgJqqRGFBPwRdzXfQ
	 tk3DDmw8TaCXhKlgch9OuCBvtx2zOodiALYMxFUU3E90HJuw3eRG7NyuLhBwX8pF7J
	 H/gZtuIv98Naw==
Date: Fri, 25 Sep 2026 13:31:06 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>, davem@davemloft.net,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Russell King <linux@armlinux.org.uk>, Heiner
 Kallweit <hkallweit1@gmail.com>, Jonathan Corbet <corbet@lwn.net>, Shuah
 Khan <skhan@linuxfoundation.org>, Oleksij Rempel <o.rempel@pengutronix.de>,
 Vladimir Oltean <vladimir.oltean@nxp.com>, Florian Fainelli
 <f.fainelli@gmail.com>, thomas.petazzoni@bootlin.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
Subject: Re: [PATCH net-next 1/3] selftests: drv-net: Introduce a selftest
 for ethtool flow control
Message-ID: <20260925133106.7ad8cb3d@kernel.org>
In-Reply-To: <fb18618d-6402-4f7d-b318-1872570ceb27@lunn.ch>
References: <20260920164732.349744-1-maxime.chevallier@bootlin.com>
	<20260920164732.349744-2-maxime.chevallier@bootlin.com>
	<20260922194251.06e00e2e@kernel.org>
	<72bdfa09-34ea-43ab-88ad-b3c64c7e1f70@bootlin.com>
	<20260923201051.66e9bf14@kernel.org>
	<fb18618d-6402-4f7d-b318-1872570ceb27@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 24 Sep 2026 15:54:36 +0200 Andrew Lunn wrote:
> I apply software engineering principles to tests as i would to any
> other code. It has to be maintained, bug fixed etc. For my $DAY_JOB, i
> spend as much time maintaining test code as feature code. So i don't
> really want lots of copy/paste version of the same code.

FTR I disagree. Driver ksft are partially born out of my frustration
with people treating "tests as normal software engineering" which
somehow always ends up overly complex. Every team or group of people
has their own, and it gets rewritten whenever the employee who wrote
the initial version quits.

Simple, linear scripts which one can read without digging thru modules
are the best possible tests. Even if they are 4x longer.
