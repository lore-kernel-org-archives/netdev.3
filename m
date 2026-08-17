Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B5883C1D4C;
	Mon, 17 Aug 2026 08:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786954885; cv=none; b=QH5e2OAYsuZB+dd69aDmtHgdVv/5ZuzMPb28184tGHxBQnG/5RWb3+71g2u3GTpvOJ3bfFxxELMK4ddnetg4vxKYE5U3imFuJJa42CSXijwYSMWX3dP9k452kCUL+Thv7zYRHvwUkOfRdADLb6ES8KVRDLhmhKTXEZmf6vD5Wuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786954885; c=relaxed/simple;
	bh=zlfWJA+yG2KHHMVnqiY7zbblItwE4y5p7EwlCPKsCl4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WLAfI+/x7yMBNSFZWcH54JWhvZaiVkfMGi0BhmOZQQ66Qp6sES8p1NSH9iVdYMp85+Y48ye1zWftGhzsqqB7smEl+8p43j1UKDYwMjSjArp+iQGH2UBknK8CI6L7ULK5qMQ7c3frYtrOzg80Q6ZO12z0uHNt0fv8n9bQ4s85PIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tt0kpmoW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tt0kpmoW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7D621F0155D;
	Mon, 17 Aug 2026 08:21:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786954883;
	bh=x1s8IO0Gv34ic+NyjGbuv0eajc3hFNRAjyrWOVejEoE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Tt0kpmoWJircA3aou5fJbNek/4Ftg+oS8Wyls3V/YQsZUP8U2KD4mH7iu9hJWa6i4
	 LadYIzR19hmaYnCUoif0qj1XCL2z38wHQkbky2X/oi72QcFMPd5ETny+EpPEsEys9o
	 pIMEouYN3NjXZplLFykLh3iIThgqD+6CeH3Obf+GfFZUkOrugfqWXP4E10XaDBp97U
	 iOEKf0lJzBmeyQBCwO1+6lqxYoXvB0prr/UzLsXaVUXyNbM1UGO/ql/+izCebLa0zV
	 t4IswhRpypvWtOB93vmiqF3SMxpQG0Q2wjRr2EKiqNfbxyeom+LwkKoxobFEnn2htQ
	 MpK7pzXn+KeYw==
Date: Mon, 17 Aug 2026 09:21:19 +0100
From: Simon Horman <horms@kernel.org>
To: Bui Duc Phuc <phucduc.bui@gmail.com>
Cc: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Michal Simek <michal.simek@amd.com>, linux-arm-msm@vger.kernel.org,
	netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] net: xilinx: axienet: Propagate errors from
 optional IRQ lookup
Message-ID: <20260817082119.GU265046@horms.kernel.org>
References: <20260813042012.17631-1-phucduc.bui@gmail.com>
 <20260814170001.GQ265046@horms.kernel.org>
 <CAABR9nFxfzf8QP-wq5iaJRTL+HG+a+tNqqX2daj-=Cwp46hPJQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAABR9nFxfzf8QP-wq5iaJRTL+HG+a+tNqqX2daj-=Cwp46hPJQ@mail.gmail.com>

On Sat, Aug 15, 2026 at 10:13:59AM +0700, Bui Duc Phuc wrote:
> Hi Simon,
> 
> Thank you for you review
> 
> >
> > It would be useful to explain how this problem was discovered,
> > and what testing the patch has seen. Please add an Assisted-by
> > tag if appropriate.
> >
> > Link: https://docs.kernel.org/process/coding-assistants.html
> >
> 
> Greg Kroah-Hartman previously asked about how this issue was discovered
> and how the patch was tested, and I provided the details here:
> 
> https://lore.kernel.org/all/CAABR9nEfPqXAt8wDo597qDS3b3KMaHeF6-swAFg9RLanapDnBQ@mail.gmail.com/
> 
> Regarding AI assistance, I addressed the same question from another
> maintainer here:
> 
> https://lore.kernel.org/all/CAABR9nFgiNv6cnYa3+ZY3KnjbKpcF-JHpZY8TVcR7H40vOoR=Q@mail.gmail.com/
> 
> The answers are the same in both cases, so I hope it is okay to refer
> to those replies
> rather than repeating the same information here.

Thanks for the clarification.

For future reference, I would suggest including something
like this in the patch description.

  Found by manual code inspection.

Others may differ, but I would find that helpful.

> 
> >
> > The same check seems to have been added to both arms of the if/else
> > condition. So it seems to me that it could be moved out of that condition.
> >
> > I would suggest placing it below the existing rx_irq/tx_irq condition
> > which appears a few lines below this hunk so that those and
> > dma_regs errors are still propagated.
> >
> 
> Previously, I understood that errors should be returned as early as possible.
> However, with the current implementation, I agree that your approach
> makes more sense.

Thanks. I agree that early error detection is the norm.
But as you note, the existing structure is a bit different here.

> I’ll send v3 soon.
> 
> Best regards,
> Phuc
