Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794189500;
	b=cndGuizXgAaTAcUUcdfnhMFCPg+kfT2S4oNb6P9QGB33ulStZHo2Bg5mVzMxuMAHFi3F
	 Wf+SuO2h/T5Fs6Uo6DJ5LlNabGWOPjbc8eqau+cxrZKsos2psCptJuzXe+Ih94rxPa9uo
	 jedCYVOjY0C9fCcPMylpuwPRHSa8twEl1O/XWR147ErW0W/XJXLATMpKzovESpufDJeZV
	 lHwzsRaFTfM2HI7Y/dQoAMH8huz6UH9MXL1qC0YmuPYoPYWgJte0mt8YmtABNMDhqEu7x
	 5Ah+PF9/arIwY1tqDw/W+yt+zLlvGLWPwawBQfR9//8Kz8YkdJWL4xEgtma5FY/WofQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794189500;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=VdraKtd3eok1o4y7m9k6cWYGquFxUKLDY1bnn8nTijo=;
	b=Y+Bjqi0AhuA6k8h2Ml9Qc4FMTbqQhuQBp3A3Ed5HqZdWEIWNFdEBgqPrzzCF7pl00E/E
	 Vauv//jAVPIIcy/ZYWRf5vPt6U8pzczp2NOIkdQbodBoLDXXoT0hd1OxI/nDbyFIzFMr2
	 IWAHg8q34kslCEgh6qNk0mp4Z0fiMq6k/mh80joAvHYsow8UVSrN0higWFqhToP7QUG56
	 RGl7FG2KJ59jcGziWvf6Cvq9dvMWC5HQ/820swbx7nePm74mj0KqYyP5eKOCPvUVkjQlb
	 FPsEJTaqLijiRAiKUHmLCKFrtpuPB+JvhQNcQCkwtHJ8XAKYV/1uoSKHZy5V/TTuXZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=networkplumber.org;
	spf=pass smtp.mailfrom=networkplumber.org;
	dkim=pass header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=HaBdSEUX;
	arc=none smtp.remote-ip=209.85.210.171
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D38E606A321
	for <netdev@vger.kernel.org>; Mon,  9 Nov 2026 01:58:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6D38E606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=HaBdSEUX
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-8a070755c8cso120657b3a.0
        for <netdev@vger.kernel.org>; Sun, 08 Nov 2026 17:58:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20260707.gappssmtp.com; s=20260707; t=1794189498; x=1794794298; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=VdraKtd3eok1o4y7m9k6cWYGquFxUKLDY1bnn8nTijo=;
        b=HaBdSEUXMP+2cctm72QYKpWjKXO2rfyacbE1SoCQgq8mYx9NBWSBkC9lEEoDBBWA4m
         ArwkbQkyhdEjQZbgA0tCl4bnt2CWzzf1eM7KX3+cVnhipaL0MVzsW0xo5DlNMcsquV0P
         dl0RZpxPy8N5iY9/MxsPLetlKCpqnwuKfhv/V1lu65pfNQGQGDfa4eBOqbe0FjN40jH5
         V+06jLso0WN46kTNQTVKjNqqQoDo+H7DL0P+oo8Fim7zB7uq5Ep+7Pe4cA1qCQe9MiXF
         ByUXQtg3lNXEhtOKraT7AfhERtENnajBc7iGOXnH/gOI2D7N8whoW1LRlF/4gkpiSyOj
         YklA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794189498; x=1794794298;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VdraKtd3eok1o4y7m9k6cWYGquFxUKLDY1bnn8nTijo=;
        b=S6QJ83QWnWejJ6Xelkv8ZRSYNc0jvRmYjLygM9PrANd3uJkKofgKseqO01tdPf74js
         yu7vCc15PDcVO+8Y2Zlr3UYsBnug1JacVEByVVq1Zxruov0gBfQHVXqdjaW5QgAq0pHD
         o17djdQrL1yMWy5bXkvNF6DPKtCRn/vDS2w+S7vEmsDALWGhkzsF/haq0Kwy1fsemNYY
         c9FGvrFtZbYOsIUlWfHyGKBsUqCn0UQtaDwTIuR3eTpfyPy2gPlqmsVAXP9Y0DTfey+a
         aNN6wl/bYGBfmFdIq02Aw0ygSltgKrpuDhwIXjncwIx30lQn+XHqSXCxks47uk0+9iFR
         2ZXQ==
X-Gm-Message-State: APuU4Z/IHGgEqsJMM95Ou6onCqm5dvgRvunmM4QDVKlvQqQJqLQ66hMT
	iLswNe+b+8lC+7lr6fdXvIu17noCohXi2XaAHID6AJbA0MeEJiri67tPpniSiUxYmLM=
X-Gm-Gg: AYBFou1vyFI6N9PU1WhOsqlWfDiA0HtLxoNEEMXZvR7F3EvQcpr7Hr3n3N8YGLbPmLa
	RVAu0+gMJ2jFO71ROCb+3fCWLGliMbAKGDEreRY4/swqo7FOiDprUXy30JJN+ooYOyvI+fyrmxS
	JYKc68WhOZL18FHpz02fKlHblf2PPxXiPSU2KnXMtnVySqYyMgpgbOyHdNkyGLs1Qm71GlBxLHM
	ivtqtp7zXARUrpy3xPZ/B4HCltL+qcJ2OLva5IEdrx2skEfgxHXC64s930gAzUEt/s4gp1jRt59
	L4YI4Pa2kHK2l6AMk0ojS0HV14HVfYpJcGrcgzqTK4wKzCKnDoNYXWLJfTKvjE5VBL1/+fTrWIY
	0u2w5OkAYZ4mF33n4onVLvemxmFirSBCUd91OkIK++B4KVnxrtwAyCYedYh2xWcZ8162NwUSuWx
	cVcz9Yr4VljDu2wll05Pif/0NoRZxbO5q9R5zngqHfRvIQ/L/Ktspl7puXNsVmdDM66/aGtQtor
	34kXsv/rw6afWSUXK9Dae4JEZZiDaFgufeUe42tlbNwZUlPwioxYPVC0mbwcwOuGhgIr8rBmyVG
	OeJmH80w9T+87zT2pRiRmxJfTE+f9YQgCnTv/QPLllC5RFe9CQcCa3/CGzoCmfdtwmuTiXbC
X-Received: by 2002:a05:6a21:7906:b0:3e2:7c10:d48c with SMTP id adf61e73a8af0-3eed1f2d2edmr2141738637.17.1794189498472;
        Sun, 08 Nov 2026 17:58:18 -0800 (PST)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cdb969314a5sm1086276a12.17.2026.11.08.17.58.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 17:58:18 -0800 (PST)
Date: Sun, 8 Nov 2026 17:58:16 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: netdev@vger.kernel.org, dsahern@kernel.org
Subject: Re: [PATCH iproute2-main] libnetlink: handle failed time seeds and
 sequence wrap
Message-ID: <20261108175816.07cb4a61@phoenix.local>
In-Reply-To: <20261103215932.1191741-1-f.fainelli@gmail.com>
References: <20261103215932.1191741-1-f.fainelli@gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  3 Nov 2026 13:59:32 -0800
Florian Fainelli <f.fainelli@gmail.com> wrote:

> A 32-bit time_t overflows when the board clock is beyond 2038. time()
> returns -1, and the first request then has sequence zero. The sequence
> range check underflows and discards the valid reply, leaving ip blocked
> in recvmsg(). The same range check also fails on a normal counter wrap.
> 
> Use zero as a fallback seed when time() fails. Compare the unsigned
> sequence distance against the number of requests, allowing wraparound
> and rejecting the sequence immediately before the first request.
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---

I put a better more general solution into the recent netlink fixes
