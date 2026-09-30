Received: from mail-wr2-f34.google.com (mail-wr2-f34.google.com [74.125.225.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC38D5172F5
	for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 18:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790793525; cv=none; b=atZXcqpTKmw8mUdalUizn8qRylnmCa3Kb+FQ9el53MZ2ts3lQx22JNdUr92gF7d48ywcm1lnLQQ1jDgmJ+TDQzERkGMl8BSCtqaY2jaL5UqkYpBV49DeX3mq/S6Evn9NqbJllmV1nUeV2ccrQa06y/xF9N0S31IZ+jFLFfxdNxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790793525; c=relaxed/simple;
	bh=qIYeVUCO05ZbZhdAAAoZexxaRjrSKWkj1JQrUJwwZr8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d+thLkxxXZlhjQWMKKj1D7kjmiIZVJr1uQhMZFeNjhZApeCnpwAjwrpgQ5qTMgCdBgiK5O1EZAsdDn9ADNqLrrg/QA9S+MihdiP6rhWPwzkefIfIWj8lqOzngPzJ3z+20JGQxYsHtG6XCGsrubsHY8dDCwLjnCvgkOpXg4lssGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nyu8+fl+; arc=none smtp.client-ip=74.125.225.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nyu8+fl+"
Received: by mail-wr2-f34.google.com with SMTP id ffacd0b85a97d-48af9f88c95so642176f8f.0
        for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 11:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790793522; x=1791398322; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=X/kW+42sSDWDUbw6VMWjlova15EUzqflh+DF1qz2pHg=;
        b=Nyu8+fl+9C0oTojAC9MciU8R4YNL7wQ7rEibxddMpIWYU+7X3C+IHEKm791q5fV7sj
         15MTvicEaq6YvPzvZrMICs6c8KIAGtD0dMPuAat3ogEh1iURaeYsrLH9NgsSCQCEq1ry
         Fsx3bI68ZegE9P34gIvRXAkGcdyRpQIaXkJxn+kyNVqfecpD0t/iueq3XpcrNSLd08r8
         F1gHeG25h99CA5yqW9kV8jb7dCI0qe3FnTNptdBJ+IaEf+Wugfx4GwItKE6V9FHRJRJr
         XlG/lxC6xpQDe72NW96eP2BdTF6nsAw0uDj3oj1U1HrSTfx8C8QLylDRyDZln/9EXwtR
         nVrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790793522; x=1791398322;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=X/kW+42sSDWDUbw6VMWjlova15EUzqflh+DF1qz2pHg=;
        b=Gjj/ObdhXXD25I2VMFON9DXvQh+eu4hOz7JFHd9eKm3+kjeBfuzJmPE1z8JFEFuiq0
         jqc5t2ZPwyZjTLpm/N28H9ZjIpz0A8rioJ6trwCFblR5SnWeAUOQDkfsY4Vwdr9nDa4r
         zbC7lnGPl/c1/ufJmlE2muFKQwqXWqhgNzugM8SPYYZ0DvsDa/kPgst8OCRyp2h7D/+4
         RmD+GvBGu9NgFbeUIcwXTzuPOmRnFX1cz0RGKQ0x+JCXU5epfjXJtMc3iz8CTY+l+MTF
         DA6IFNxBN+WVKlM1m1GyMnS7cBCs2Y+j+s4Mz+gNK8laWKx95uTpJEmP1xWPz0OE9hIJ
         Y9Gw==
X-Forwarded-Encrypted: i=1; AKwUvBxASLdyNcNOwJKyOLrZTRE4LW4gLRAIJgEI2yw/qaQ0ykYm7zM8ouraYQfBv76pA+08fAPtiik=@vger.kernel.org
X-Gm-Message-State: AFuF++mgaa6uJXNL4k78Tbtn+XUvz551Yu92CVHBLRJG9rrk/4tvzUNS
	RnxteX9L/l7E4i2uVXwin/GyJponBVMAAi+Bd69P7mhYjSi+8cLYz774
X-Gm-Gg: AYBFou0fkruJSaiOBCwbfFbarsL8POlSzEhYccCmLOmxWpJyQL0VeV2E1WaWtiIojTL
	flUUAx8nk6JYhi0LTJFRiBmKHm/2fVzNauLtFY4IZB6xx0h1mQpWXAm1VGE+lqgnhb2aacp4Em4
	UYD/YYytRcVFoG9fhcS3cjotMsg7akTy9NX2SAoiozUKwBl+eFR1Asu8NQVRA+6bJmxSHt0SP3z
	EIJg9K9kXqgd2zyfIcFVskShBKYN7tkZGasNFPgO/A34PEDCsn82MWtHFRxnv1A2H2hdi9VzX0G
	rnvzJIMDcgyiyQr0c5N0M6WlubUpwCQuMloBdsk3BAhpgSM7KTOWxe1B322D367P/T7K9dZy+9+
	WlnlUXska3DDhdhyQDrBzUrwNk0erkDo7pj0qL/CBzhrtjtxfon4Zm2+kZ28OyOuBhZIU6gytvj
	p1XE/zJugAojqdh2rZP/SHoNTLLD3hsHCywXXp5hrxOoezufwt+JJdNiyPYXCyRqWzyCW0G406X
	jeXUFNRm/FGOEkuBdRQ27PFFzCG75MkD8g8hyQB9140ZNJg3JpoQDqIbHgEmLx6OyqfsiHWHEz3
	KQgsStOHOc2Km5qXtL+mF2+us5xFDzFzPK088UHnp5MhLGwdlcm5K1OZs/LvYQpNN1lWt3om8Q=
	=
X-Received: by 2002:a7b:ca5a:0:b0:49f:fbad:29ae with SMTP id 5b1f17b1804b1-4a01eb19ffdmr6267285e9.17.1790793521692;
        Wed, 30 Sep 2026 11:38:41 -0700 (PDT)
Received: from unknown748F3CBA5068 (dynamic-2a02-3100-b2b3-0101-b51c-a607-3dcc-3979.310.pool.telefonica.de. [2a02:3100:b2b3:101:b51c:a607:3dcc:3979])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a01f979bbcsm1867795e9.5.2026.09.30.11.38.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 11:38:41 -0700 (PDT)
Date: Wed, 30 Sep 2026 20:38:39 +0200
From: Karl Mehltretter <kmehltretter@gmail.com>
To: sashiko-reviews@lists.linux.dev
Cc: linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev, 
	netdev@vger.kernel.org, sashiko-bot@kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Stephen Hemminger <stephen@networkplumber.org>
Subject: Re: [PATCH net 2/2] netpoll: avoid blocking on the transmit lock in
 queue_process
Message-ID: <ar1VeFD4pTgsG0i0@gmail.com>
References: <20260928064239.32456-1-kmehltretter@gmail.com>
 <20260928064239.32456-3-kmehltretter@gmail.com>
 <20260929064307.569CE1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260929064307.569CE1F000FF@smtp.kernel.org>

On Tue, Sep 29, 2026 at 06:43:06AM +0100, sashiko-bot@kernel.org wrote:
> > +			schedule_delayed_work(&npinfo->tx_work, HZ / 10);
> > +			return;
> 
> [Severity: High]
> Does this schedule an excessively long delay when encountering a transient
> spinlock contention?

Yes, HZ / 10 is too long for transient TX-lock contention. I've changed
it in v2 to retry after one jiffy. The existing HZ / 10 backoff remains
for a stopped transmit queue or NETDEV_TX_BUSY.

Karl
