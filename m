Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2821821D5B0;
	Tue, 11 Aug 2026 01:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786411096; cv=none; b=N/EpA80M1hRACFlaKHfcTKB7vzclDv6dBUEw0z4WVXT5O2aOXZYAWjDzzF9WQCgBLlBKu2HixdM2k6hAyDqksZAoviTjJ2MVnOfL+5GweD2z0nutta2fqTRmVzs5qrUq+1hnjutnI1pw/ymEjfJTta8hIxQf5J3Xm2mSwaWshwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786411096; c=relaxed/simple;
	bh=x/ojJ+RWTYHeoX7x/sYjjT6qOdsbi+z2b4n/32JQzyM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Zv5VhIsfR5AequEV+GHxKhzEJWK2c2YF8115LG7LytzJN1MuIQjsKhEDjV9IycotvICqHcSX4Q+BVmB/m9vqKFxHI0KTO+SsvqQNnb2Lym17MALi3SUnf2PyodhgUp9lyWRsBQqbGOO9W9/VGB+t3QLhRwLpYAulkCpO95K22rA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D+aEg/cf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D+aEg/cf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50F4D1F000E9;
	Tue, 11 Aug 2026 01:18:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786411094;
	bh=htNOwPEGZiXK+S+ozCYxWkKsaktpGjB9O34py1vUs7Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=D+aEg/cfl9fPDzf9rFB+pLIblxT7IuSZVa73nvcSRBZ6Xh+FwIH6H76jVmrAU9wPn
	 ciN2XNaRBmT429v1/edI7qI5Op1qOotMMb0hpZWmqZiwpc//1ZAEU3Pac73hGnDBKl
	 no4xAUWxoRBbbSYsLo0rt7F6fNQp+rwk9YFPguK6sFIoJYxSBBFjXx7vPuik9APZcM
	 UF/vitgxyECdOFdfy2XxBjR7QwWzw5lZ3cGs8KOdjCr+GziS7roznCM8hkXNc1Vwk/
	 HMfHq5pmdQLg4ouhhJWUZtTcqgbB0RPbCN3Ad503n1QvL/rPFg2WQPuqRxAlvp/UFq
	 0o/jRnDX3TmMg==
Date: Mon, 10 Aug 2026 18:18:13 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: vineeth.karumanchi@amd.com
Cc: theo.lebrun@bootlin.com, conor.dooley@microchip.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, git@amd.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] net: macb: configure ENST registers for all
 queues
Message-ID: <20260810181813.0d1fe0f6@kernel.org>
In-Reply-To: <20260806162557.2762166-1-kuba@kernel.org>
References: <20260805044204.272989-1-vineeth.karumanchi@amd.com>
	<20260806162557.2762166-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  6 Aug 2026 09:25:57 -0700 Jakub Kicinski wrote:
> This is an AI-generated review of your patch. The human sending this
> email says "What's the expectation for the other queues?"
              ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Highlighting this (human) question in case it was missed in the wall 
of (AI) text.
