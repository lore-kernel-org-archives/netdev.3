Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BECE48A8A7
	for <netdev@vger.kernel.org>; Tue,  6 Oct 2026 16:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791303500; cv=none; b=dTRbGosDNcgYqK9HX+9UQje21UT/owSOVLT+VMBqD30G9MVa2+bCwCtwT6y7ty4rHQiNdRrrygQPXPIGdDJvYRN2uMAi9xTMfhxO092alUD1qiNeVtOnIdXC7JPIO0u3JT42WS7CbGWfYFJT4MCnGXbCP8yVjl6medPIU7Bvcwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791303500; c=relaxed/simple;
	bh=SEmeYEhNhxzCknQ04N8BtmKHpqcKWqm+9hDeYHNmMJ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mr+m3gIymVSpr/UEgLH62V5wv5RZ+j5RXa/1+a6L7vyaZ0F4ijXol+3LeAChgR8IFN3rwiG1RjHKQDrJ3WVkKZCtiCcV2ZZK0qY+eBVeU5GUZvs4T90vzdRhylWepgDFBl190IIsGu6LjlSW+rXVcyrJQ718u0dBwn2rdOl7TbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b=yfUu9xol; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="yfUu9xol"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4a1728d8dfcso21705925e9.1
        for <netdev@vger.kernel.org>; Tue, 06 Oct 2026 09:18:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1791303497; x=1791908297; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=j4I8sJSiMLDYcZ6HuW+SMx62hAOh6BihMSim0ZcE8Eg=;
        b=yfUu9xolh26zJp7PI8oy9IsAmWf/ZqACQMkkDfyIbkF0MBTK85l6gELEw7dqPtoG/F
         vQndSK8f9gbPUxsMi01Png7xKi8pi1Gm77FgyAGomjNeno71TS5ae69Hdk9BNOuP3wHR
         QSdi5MalpwjNsHk6/fSGJqDK+u1f5oX80qVvA4jA5YYHjiY1jfLxPuzTxD7jcGsUOiF9
         wEJtVwEbm5AxGWX2NfcDyD9/SHwbWnVnM/qhENsVY+pzuJo2yBBIRRwZX1Acsn7o62np
         oQMfJeYR0CyxoX4UAKKmsvsOtOs2p6DRMXVTzGpDHv5dw6EiUofmTEHQdtYGIaA16Gcd
         BBbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791303497; x=1791908297;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=j4I8sJSiMLDYcZ6HuW+SMx62hAOh6BihMSim0ZcE8Eg=;
        b=isvyi8PhiwaVSdNKFLvers2GhWK1Sdl1XpO1jWV6FDSmfcdb1FMv/u2uL8YsK2t6D/
         rc7aLuNfDjQ8FvTr+5GiFHaws9gjB4x2r5V4Mx9LD0s0M/FObPWVAwYjvoniSGTR7ikd
         L5IJoLZdTSUn8qdZ+AL/CLtRX+qPN812x7u7cGQi17mGXhGK0dDurjh56SnJ4viHgvCS
         w6GeOo8Si9zdPazXXXe5aatZvQ0QaEUMHptiW6p5/4DTW5ln06hOcjD8Z4pbV2/LPaR6
         f+j9O2novkhYNh9Tl2QNLy8h3f8UPCp/7ZuljKCt7xef19U1Ndq7QRuUa32Hfr+wSHNC
         HsbA==
X-Forwarded-Encrypted: i=1; AKwUvBwKu28VHMNoh8pYOW//Vdd65TaT+ZPoP6SOE5dLhWEqbVPVqZzf3TMemv6a8Nvn6LkssTbG0B0=@vger.kernel.org
X-Gm-Message-State: AFuF++kGywgAcMGrX/ejvv4HlWwCnRjAwhCRR3F13LKCjMZHYIrxsoyq
	cVWrieZHcLQll7yw/QXsqT7nAQdbAQiAIA/WinfNPgb52MKQJVqdLf0/U/3p/iOvY0s=
X-Gm-Gg: AYBFou2C4hbztjNolrExcCqkL5iqrdTxkLvrJ45jWpaLHssf9Fk/PqeCg6s79ONO5Cv
	sM3wdjlI/0EtzgctI/+dGaSS7GBmH6wH7rB+eaFpZxKYu03EVpDt3kPaQzLiPT7FsXvmNnQaABE
	zy3S8lPoxBwXymhrSUpYdbAtScCIGAha6D4q2iydmvqVVIjc488uX/5t4IpE095SMb47SExSQ5b
	u53RzuVJA9ZRL9G9xpq58DRjt5nu4/4HIWk42M3q1DjGN5z7GOsyYoYuY/onqEF4PJ2vc2BlqR2
	28JldAvVR5xU+F6/J3FB04VlVV5cF3t7Iql8tuO50al2Gze/HN2SnrO8JbnrckeUidsqLN07RUV
	Eu8zbR6u2nhwjLzegLfR1hG3N8vl/xcxJjtTN7MR2+QvpuEO8aRlPYRQl+/Z45vscySJkp1Cxv8
	/cYkiDYS1+z5rLvS4SEtsOzaclRs21kn7bwWEVuFfiEJA3cFPk2ho0DfxrREwwnQeAqHXtMPsgn
	O3O04qIcVKGcflBQhBcIyDEzLavEJf+/tQsGSJadjjjiBJoG9Y9EwjbUPCzwzjEfcCeVGO/q3dT
	qsypQ4FoO3cYZVbmAYx7ee7WF6W58FCwV1Ks2lHOWEurGiG64G68ZS7UE7OlqPNEzzCq9w==
X-Received: by 2002:a05:600c:4e87:b0:4a0:2375:dc1a with SMTP id 5b1f17b1804b1-4a1680ece49mr174863895e9.21.1791303497306;
        Tue, 06 Oct 2026 09:18:17 -0700 (PDT)
Received: from aspen.lan (aztw-33-b2-v4wan-169864-cust3247.vm26.cable.virginm.net. [92.239.204.176])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1794a1af9sm76346415e9.5.2026.10.06.09.18.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 09:18:16 -0700 (PDT)
Date: Tue, 6 Oct 2026 17:18:14 +0100
From: Daniel Thompson <daniel@riscstar.com>
To: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Cc: netdev-bot+sinfo@kernel.org,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Vladimir Oltean <olteanv@gmail.com>, Furong Xu <0x1207@gmail.com>,
	netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	Davide Caratti <dcaratti@redhat.com>
Subject: Re: [PATCH net-next v5 0/3] net: stmmac: Introduce hw queue priority
 offload
Message-ID: <asUfRhPF-J74TCgG@aspen.lan>
References: <20261006-stmmac-mqprio-prio-offload-v5-0-d7da93419784@oss.qualcomm.com>
 <179128376932.2231598.7510820392039419594@kernel.org>
 <asTnyCWBTMC-B191@lore-desk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <asTnyCWBTMC-B191@lore-desk>

On Tue, Oct 06, 2026 at 02:21:28PM +0200, Lorenzo Bianconi wrote:
> > Hi!
> >
> > This is an automated message. This series looks like a fix, but its
> > commit messages seem to be missing some information:
> >
> >  - Whether the issue was actually triggered, or is only theoretical
> >    (e.g. found by code inspection). If it was triggered please include
> >    the symptoms, like the stack trace or error messages.
>
> This is a theoretical issue found during code inspection.

I haven't triggered anything specific for the real_num_tx_queues changes
but the overall with/without mqprio offload changes can (and have) been
reproduced with netperf:

  netperf -H 192.168.10.2 -s 1 -l 12 -y 7 -t UDP_STREAM -- -m 1472 & \
  netperf -H 192.168.10.2 -s 2 -l 10 -y 5 -t UDP_STREAM -- -m 1472 & \
  wait

With the patchset applied (and the traffic class 7 mapped to a higher
priority queue and TC 5) then the split of bandwidth massively favours
TC 7 (with a 2.5G link. TC 7 measure ~2G versus TC 5 at ~2M).

Without the patchset both streams get ~1G.

I guess FWIW the whole series is:
Tested-by: Daniel Thompson <daniel@riscstar.com>


Daniel.
