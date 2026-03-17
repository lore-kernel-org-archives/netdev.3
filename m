Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B4CA2D878D;
	Tue, 17 Mar 2026 15:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773762932; cv=none; b=Uv8PTsQ8YhtWqoMkbYlMNQJCSB7NV/xY8vvNjqpEQEbL1JmVMi6+Q76yt/eivSgjDV5V4JPvM9AIu9F8RjP5blUg+dc2AjcgY2xyXKKTnbuBQ+5EikDpF4ts3LY/AfXiCQGXqZJFtHGjsSYfWd0fly2zTLEtuD+9foZLNcgfci4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773762932; c=relaxed/simple;
	bh=sdxc17hjDvTbV8HLPbMxuIDiB/Y91gmpH6ASytKM/Tk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DbdwJZXpf4K2KTVBlimUMpDXeUxTthVnm4L8iI5flP+vVZimxZFF8XCC8+MHm19WT9NTMq1oQcJ8/OjI6E0YaarQxmcwrzLmyObBillFpqzy1bI/rw25WvdRDk+zTBVoxTCTsPZLHKyALs8akhdvOjDIhVZdGDFkG2TJXVw1eII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X4dA4sjj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X4dA4sjj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6835C4CEF7;
	Tue, 17 Mar 2026 15:55:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773762932;
	bh=sdxc17hjDvTbV8HLPbMxuIDiB/Y91gmpH6ASytKM/Tk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=X4dA4sjj1looa+b5wTefcyhkj+2WL4lLnQHRSOHBTGlVnDIZeOYpFKfDbJAnEa8qu
	 f+V9e9LYrOCadGrPOF3yRi9yM2VdWeExoPWiPcw7ZFCSIwwFv18Xqv0N/s6tzYrXiS
	 wMR8XCQqNOBxtIZbFu4yzMr/TQjp15/boOL0qFxiyKdvpB2YKgUlR8ldOS4KlsNoEk
	 IULKg3AtCNMejQ2wB9h1NqA7mfLeCTQIopJBMnbRViSsc37IokuJCB8+xbe2svLgi5
	 rRxdCf5ywuYjN0TRicKfZrAmc4DmAoO7Wg1ZnQSQAfREpFscgmqBh2ZYWWBUkHoPL2
	 BBPwI+lhFX2eQ==
Date: Tue, 17 Mar 2026 08:55:31 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Birger Koblitz <mail@birger-koblitz.de>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, linux-usb@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 1/9] r8152: Add support for RTL8157 RX/TX
 descriptor format
Message-ID: <20260317085531.3ddff582@kernel.org>
In-Reply-To: <2094f5a3-e692-4d8b-9b66-0368e5142b98@birger-koblitz.de>
References: <20260314-rtl8157_next-v1-0-9ba77b428afd@birger-koblitz.de>
	<20260314-rtl8157_next-v1-1-9ba77b428afd@birger-koblitz.de>
	<20260316175123.45b8d6e1@kernel.org>
	<2094f5a3-e692-4d8b-9b66-0368e5142b98@birger-koblitz.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 17 Mar 2026 06:04:34 +0100 Birger Koblitz wrote:
> I would prefer to have individual patches in the series adding support 
> for the new functionality of the RTL8157 in parts that also allow 
> developers to understand the differences, even if this functionality is 
> used only in the last part of the series.

Functions should be added with the first caller.
