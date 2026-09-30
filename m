Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B641B808;
	Wed, 30 Sep 2026 00:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790729064; cv=none; b=XPgTF5B0joVKiQ/KvWMG267yQoOh6GzS1yGkHP8k/ymq4o/s0Xj+nLdue38u2CtBns4SsjdSUnnA+iLGa2i4ectZcTZ/qDGtbr63eg/d6N5iCZ4Hq6gfVRPq5d/jCDDG5zAzDqtPwhy/lLdrVB7WStbw8Kmt5VrQnCqB7yjCbXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790729064; c=relaxed/simple;
	bh=42s93+Ahiy1j/QDTXEPMarCUu0J1LiCLSFEQgLZEfi0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JhswkmP1MFnZlzggG2XnqY5F4hYCnzjzkyr8SjQvbJhz/ZuiABlnOq2LwBQjvpJ9tD4FXKdLC+WT/z0SjiobIBNx/ihAVZ7jnYVK/MiaeTH81JpLfZoLa9WA/CufzVzFEFZu8I0IrFivWUUQZZFaoNm3TONVwLxgzFZb3anOeBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l0cbHA14; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l0cbHA14"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AEE51F000FF;
	Wed, 30 Sep 2026 00:44:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790729063;
	bh=h/wV/WdNFUnOOvypb2BAm6IfQesxn9+taEOKJryMcWw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=l0cbHA14trDT8+lPV3WR2TvAPXbyoeNQ4ab2r1oPT2fLxb3BWJHUoAPiXRwG3mRZg
	 RDTVY3/nHIUiEeFx8Sg/z8LlFsFNlzbW9R+P+6V9Sw7mhgGICuYL5U37WqgVh9qSMw
	 +w9l7sRpoXZWjifgi6AKM6MKN+oo76UlCkiGefNkgX+YC2yHXLkSdgNHd203aSu/m+
	 cOC6I8/wrw0Q675TzMwjmwkkOVxjZcw3YohnwGYRwqq8wOThpRe+eHQh4mnKgP50au
	 oip0yjDuY2aGqWtLi8Vn6szx9ULkYyyd9BIXlw3A0aZV9Bn4QguxP9Op7d13QA4dSM
	 +WW42SnN456bA==
Date: Tue, 29 Sep 2026 17:44:22 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Aleksei Sviridkin <f@lex.la>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org, Florian Fainelli
 <f.fainelli@gmail.com>, Mao Wenan <maowenan@huawei.com>, Woojung Huh
 <woojung.huh@microchip.com>, Vladimir Oltean <vladimir.oltean@nxp.com>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH net v3 0/4] net: phy: make PHY driver unbind safe
 against attach and use
Message-ID: <20260929174422.59279fbd@kernel.org>
In-Reply-To: <20260924215951.2127682-1-f@lex.la>
References: <20260924215951.2127682-1-f@lex.la>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 25 Sep 2026 00:59:46 +0300 Aleksei Sviridkin wrote:
> v2: https://lore.kernel.org/netdev/20260919015340.499675-1-f@lex.la/
> - Retargeted to net, and the race closed with locking rather than a
>   NULL test at attach entry, as asked in review.

AFAIU this is a long standing problem with PHYs, admin-only inflicted
self-harm. Let's switch to net-next until the merge window.

> - The module reference fix is its own patch.
> - New patch 1: a second attach no longer detaches the first consumer.
> - An unbind of an attached PHY now waits for the detach.

BTW what happened in v3? I only see a changelog for v2
