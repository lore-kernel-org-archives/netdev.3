Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77808356751
	for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 16:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786465831; cv=none; b=RrFOER4fqMKeFs/mGmkHd0+luuzBGuxs+L4PsNvoWbwFWl15WEiU12Mk/xbFdJLVTkEIyGw504M0tl8TM5A4ZJ9zVi4Ze7v2xA/9zemFXP1mJMi5TBtQiI22OKEpCyeBUzTlkKMlgVndb0bzcY8V6lV1IEJhCfe46VAjqI+BYxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786465831; c=relaxed/simple;
	bh=SM6qLrDNeg9vFk8KqzmJ/DQe6oNlCHUaqP/o60YF8d0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dWrMk+P5O0xLsCzzBZkDK34WWWPz9rB3H5pjZ8+rjbtbwtEK6jKi+1OQI75jfysv7DdUg6TIPHJAsB4gGk0JfYBiboGcBVkptc6OUDMPB8TRT4Wo2r/ly5220Qe+wwSnA3BYo4EIoNK+4+rLTyBIi0G5R2A8Vt0VqxcMmwtvVrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=knLdXF3C; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="knLdXF3C"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-908a2ca5becso321376d6.0
        for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 09:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1786465827; x=1787070627; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fd5GTS91/o1W5I/k7tggRvZ4xiPBkudvkWkOp9orKvI=;
        b=knLdXF3C8fjEEZzNk5yqADaLCSm6IvAi0vcf1UahmI6WcWmORGXuqyghjkpMJZpnOm
         xUVZMXMSr1bMD5Lurol3nHDNgZa2X+o0y0H2AvugRyfz+5eUHa4wiuYgL4v8DpNLsRBx
         GSfQsyQ+pbkhtwyhUK0hMvkT3Ryrsx7T2aUWswxxJPUds+KAQIkf+8vxyEaQueDjKJMm
         jAG1SjaN2eBOvhZd4CaB/knsPDZn9gZ7MNIXThn0r2l5VTrCp1ySxMkrJg20c4QgcJF9
         SXbbFenZX+Q2A1ToD4Lim5Q9gilJzhKnkSqkWv51c0Eys2DHnbDyxJUeJp34DebFP928
         zJcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786465827; x=1787070627;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fd5GTS91/o1W5I/k7tggRvZ4xiPBkudvkWkOp9orKvI=;
        b=lyLYG79TCKxGisvU31vUpza/5GzeKX5JCRYE7Lkbb+GZrznnZaj/lmEpnFw6Ghs4mL
         h5Le/vRTLQycHOQE/JbgbdaTIMraazIiOcLKgFwqAeq98lkWAqne8RAGU1n8nLyoIhEW
         iWAVS4oNI0fu+C4n13yMp5eRqW5sn5EQiZP7fpUQrYWdQmVRYlNyf1l4NY121vJyb3c2
         g3q4p7hZwehyz63FVfxG4HINgCPEsXNBpqiYDt9OOIPk4Q6xUV2/INMPG1rOduoQOwyO
         nrKfd4pm4V82kDICraL0Qm/ga1BukuClMOZkiyGmktD04vakXbadoJUqJ3lZB71psdZ/
         JCMg==
X-Forwarded-Encrypted: i=1; AHgh+Ro7OO3OBd6OSSsv58n8z3QbGhFqTSkKs2bHZKLjigyVgJmEgl6FPztzWXzhuaKvesxpa3tFQLk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLFzj02dOm3O/sDhfz51hOmOEfR0cFnT8i+y7HYQzMaeGdUsFV
	Cr2a23p/8UdQUFRosbLAL1IrQ4mSvXbYgUZJSGIhVsqWqzr/U0meLbdcZd6tKlfLiWw=
X-Gm-Gg: AR+sD12knfSoUy+vWrnuuCDdQUUMy0WhN6gDcC/zDtLx3oYFMKsQwNSXaN1WSf4lv3+
	vtgU/xAabhusIVsJB3zHsSRPdsvtb6gSmNu7kOlnXQFOCSjxQZW1jhkRy3RylyB95d/QI1Zyn5m
	EGiGUEb94RzLZCaKjQMMfDqwJHBahK+uq9djUcae1YycFokNCZYN8LK7sCmEldRx8lKMCuQqMWH
	G/u7nnkKjq5PDLmwUinuzV9jb+LZPx6V3kVIBZU5frvkFR44MFwh/9RMI5mfkPPHvwpTQ3tLFM8
	bqM8jAnB3S0WnjSGn96I7irIyXsuH+jKoOUwZz/o6cAL1Ms8THA+FdyRhWRaVyu+u5xPMZ37+qF
	h6ieR9xqgrvcpN/9Ihi3FeMPlfKj9bhW0VMf7QMg8FxCWYR1s90Wobjrzb4Luy+l8IKsSygw/Yu
	sixgKGt/IfIPcZZcfVow9/qQM5Cu1j9iXJVHuT7Q==
X-Received: by 2002:a05:6214:588f:b0:905:6e01:b9a3 with SMTP id 6a1803df08f44-90a66b6ea11mr44100186d6.31.1786465827094;
        Tue, 11 Aug 2026 09:30:27 -0700 (PDT)
Received: from ziepe.ca ([142.166.156.215])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90a6c3c0338sm2416026d6.40.2026.08.11.09.30.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 09:30:25 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wtpMv-00000002YJ3-0Ae6;
	Tue, 11 Aug 2026 13:30:25 -0300
Date: Tue, 11 Aug 2026 13:30:25 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Krystian Kaniewski <krystianmkaniewski@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Leon Romanovsky <leon@kernel.org>,
	linux-rdma@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com,
	syzbot+5fe14f2ff4ccbace9a26@syzkaller.appspotmail.com
Subject: Re: [PATCH net v3] RDMA/core: Reject unregistering netdevs in
 ib_get_eth_speed
Message-ID: <20260811163025.GM544626@ziepe.ca>
References: <20260810133124.44513-1-krystianmkaniewski@gmail.com>
 <20260810113308.5db6937e@kernel.org>
 <20260810183902.GD507588@ziepe.ca>
 <de87c6a6-44c9-4b78-991b-ff858e21e806@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <de87c6a6-44c9-4b78-991b-ff858e21e806@gmail.com>

On Tue, Aug 11, 2026 at 11:21:19AM +0200, Krystian Kaniewski wrote:
> Thanks for your comments. It's my first contribution really, so I'm still
> learning on how to do it properly.
> 
> I'll do the requested changes by both of you.
> 
> Should I rebase the v4 patch on top of any specific branches for rdma?
> 
> I found "for-rc" branch while looking at
> https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git, would it be a
> good target?

At this point the for-next branch is a better choice

Jason
