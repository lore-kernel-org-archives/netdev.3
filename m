Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 467A43ADBAD;
	Fri, 12 Jun 2026 20:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781294472; cv=none; b=THfJTVxlExHVZwcBJ9oBHsJGV2qNb7uYpuHaPuXnyDxa8CXJo9ixAcuAN+H7eLJCNA31an7IAhJGq1k6oUNKWw9awV7ONO+LOCVJPDqCmXUIhkAx87nADrZcczlT+MffAY5HwsosPhqmwgemrmxaU08iFg6efcdmZ+/jHqVaF0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781294472; c=relaxed/simple;
	bh=agMd+urAvIyKRjQYU+TIhH8AHBmKyGvaoohLJsoxiyU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ju2Nku0QOPONDfklUqGYSzaH7bwXRpqLeE/Ox/jSqx990BQc49o6bGflvb/2VqpoY1cMOPgP+/+ZtSyBd30uAoBR1n1G50MqIcYDT+wyCNQlrzgBKxXgXGgbQuuyfbf+HA5jsC4D0qerQL3l0jWaCft2xutDX9sUUvllO+9DtXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H14Rv8QI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H14Rv8QI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E76031F000E9;
	Fri, 12 Jun 2026 20:01:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781294469;
	bh=6cNLNgKkcl8y9XOjsHZbmwTHwlAMKwujnNeJuX5MyOM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=H14Rv8QIWLqMP5DKAKGLXtlhlq3IhYgWWJ6DqMIRiuBuURhTpCog/S9xltrF1bRv7
	 l4Kec9HrjhQHQpafmFP65nTJnZgD5g0fkkxmPgXvxLRp7Oon4CobbdefGMepHu/DWr
	 WuO/0iRij4UTgHdWeZhIeWh+Oi4T6+zINU8JzBc74X8nfSyNVPH34nS1ZNkHM7rPOA
	 gAAFEW14575TMb5lZWOXngy2vHBwGa1OSvR3OYGYY7w1Vq8JCobMte7yuCvOi9KzYg
	 EJOeDpKKT+scHphKNlQc8ZQs+xroSlIvgPAlvze0zsyNeP8i6SLw7HVfaWWbVPd78W
	 /DKIR6ILAjPuA==
Date: Fri, 12 Jun 2026 21:01:02 +0100
From: Simon Horman <horms@kernel.org>
To: Parvathi Pudi <parvathi@couthit.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, danishanwar@ti.com,
	rogerq@kernel.org, pmohan@couthit.com, afd@ti.com,
	basharath@couthit.com, arnd@arndb.de, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	pratheesh@ti.com, j-rameshbabu@ti.com, vigneshr@ti.com,
	praneeth@ti.com, srk@ti.com, rogerq@ti.com, m-malladi@ti.com,
	krishna@couthit.com, mohan@couthit.com
Subject: Re: [PATCH net-next 0/3] Introduce HSR/PRP HW offload support for
 PRU-ICSSM Ethernet driver
Message-ID: <20260612200102.GN671640@horms.kernel.org>
References: <20260611123636.376577-1-parvathi@couthit.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260611123636.376577-1-parvathi@couthit.com>

On Thu, Jun 11, 2026 at 06:03:25PM +0530, Parvathi Pudi wrote:
> Hi,
> 
> This series introduces HSR and PRP protocol HW offload support for
> ICSSM-Prueth driver.  HW offload support for HSR/PRP is implemented using
> dedicated HSR/PRP firmware running on 2 PRU cores(PRU-ICSS) as a "DAN"
> available in AM57xx, AM437x and AM335x.

Hi Parvathi,

There is AI-generated review of this patch-set available on
https://sashiko.dev

I would appreciate it if you could look over that with a view
to addressing any issues that directly affect this patch-set.
