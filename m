Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 596C613D51E;
	Tue, 29 Sep 2026 00:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790640348; cv=none; b=TcWBuU90MSE5VjKlZz6fbQxOFqPD6hnmuSrG1dR7pQULzHMV7igI5MbEyI63Jxeq/k/Au8VFgfuY8KK5mwMqebNjgPbefdjdzQQ2upuP2H+40fnSJINgbrtHQhcxyg/lNSgz0zTkbtyiXwUvQ8TGxljeZaZf5WAsRkoouEoVCL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790640348; c=relaxed/simple;
	bh=OTEgqAp1EdledAlQJV+Do2k4j6A9lVDoW/TNC7zXddI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N2ejp5sXgO4IP5NhYJjO7a8zSdBKgWvKADOZfxgZYTJEt1gX5K+HOmZDcKgfgPDL/6Uq7BoWJqyYBzdzLlQZGOz8tRHNFydqeNRdF3iJBcX8Dp8FZ+x5VopZQf8f5scOjh8Jit+XwLk4VWBN4L7AG5J9sVUXAwux9FyuagaHpWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L0YocRl6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L0YocRl6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F9AE1F000FF;
	Tue, 29 Sep 2026 00:05:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790640347;
	bh=OTEgqAp1EdledAlQJV+Do2k4j6A9lVDoW/TNC7zXddI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=L0YocRl6bs04b3oSsas+27Pmpdgm/sXCyA4xE8faBvyofWndfj3XN49ato8E2EprX
	 /n3Ap9Ud113y/8XZ4dKIm72t+hejrMJgyKHMY17qyy09oDX4o5bAuI4njHLEn/l254
	 kl4WwXeLpUxPVqHUPGqkvWVEAevZWqs9Ar8yQStMEFpKAUUoJ5i1KHbeIJy8qxJVEk
	 Gd07D/OeOncHWqXCY8wNHbf1/GXdJuO6f/b3pwC58WDSSVEm4AQ3H6anwkQa6Ty2SO
	 YXNrmXcK6yS6q4IBUzz1/bgne5FlghHkBADqGDuKUU4sHT/3gAtKTalTaeuwDK8P9R
	 vaA3YohpYDyIg==
Date: Mon, 28 Sep 2026 17:05:46 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: netdev@vger.kernel.org, Doug Berger <opendmb@gmail.com>, Broadcom
 internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Andrew
 Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Zak Kemble
 <zakkemble@gmail.com>, Simon Horman <horms@kernel.org>, Ryo Takakura
 <ryotkkr98@gmail.com>, linux-kernel@vger.kernel.org (open list), Nicolai
 Buchwitz <nb@tipi-net.de>
Subject: Re: [PATCH net v2 07/10] net: systemport: Fix out-of-bounds array
 accesses in DSA queue mapping
Message-ID: <20260928170546.48532cef@kernel.org>
In-Reply-To: <20260922232440.598918-8-florian.fainelli@broadcom.com>
References: <20260922232440.598918-1-florian.fainelli@broadcom.com>
	<20260922232440.598918-8-florian.fainelli@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 22 Sep 2026 16:24:37 -0700 Florian Fainelli wrote:
> The priv->ring_map array has a fixed size of (DSA_MAX_PORTS * 8). In
> bcm_sysport_select_queue(), bcm_sysport_map_queues(), and
> bcm_sysport_unmap_queues(), indices calculated as
> (qp + port * num_tx_queues) were accessed without checking against
> ARRAY_SIZE(priv->ring_map). If unusual port or queue configurations are
> encountered, this could lead to out-of-bounds array accesses.

same question - can this really happen?
Does "unusual port or queue configuration" imply some runtime config?
Or bad DT?
