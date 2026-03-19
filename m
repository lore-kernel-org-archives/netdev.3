Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C4FE386C02
	for <netdev@vger.kernel.org>; Thu, 19 Mar 2026 02:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773888029; cv=none; b=lpF6jZnUto/RkivP/OHNLx2pIpl//nIRTTDpfbzK0NWEeVqr2sOU1R13JrqHOeSYnEykjvF9R1HYWnV6R/bMZabKaBWWHJOyRRfYYQFKvJz0loC0AC8zKQEtqUTeMH5CS8VAZEo2xp+a9w5DcDtIZtmBL9iBX1XFQR6fkHCWIIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773888029; c=relaxed/simple;
	bh=H5RLHeJWH+I9uF37gYvFq+eFJ7VDw83fsojnhLOWIw4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Kvj/RDiy+FnTVRdY6BOjt60vzHEHR5I9YmFIKjPxeYYVyDERUbWn1H8MTQeeWpJCJjPJcm78R1xc2oNZBzdUzhshbDPX6wU9bA8QH0qTkBQ0AN0cxQWnAGXg2qXZHjOu1njOZWAf8ENLtGzDQxkk2a9bwepjLEeeCmIUF+1CBig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tZxqH/KI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tZxqH/KI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD68AC19421;
	Thu, 19 Mar 2026 02:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773888029;
	bh=H5RLHeJWH+I9uF37gYvFq+eFJ7VDw83fsojnhLOWIw4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tZxqH/KIoVzs0mOfpKcWy4GZyRRYJnGSnUSqJlhGXJSWUzFNVDqfp0FJGOTK7+H2J
	 O9SW3+sighNOVlNh23CnxkPTB45Q2xj5qZrT0c920OZSXlqU3PSlpkctZji6IRYwiF
	 ltnzrhu0w7DgxssmfhoKV8ZvKoXa3w+uVt/2Zba017a8tFfCtVFLPLSVylVJrgX2LG
	 47t48s9iHovaraFY8GFEDIHD5NTlThhV1zltf5MFz742cTs3WWGjW/sP9TsrRPaarR
	 hWEqonRcwuJEJIQczriiayu3/cVGW5aFiHw0bN+WTWGSJ8VddVOsRcwyWB4kS6uuh/
	 qSurNxcnBq6XQ==
Date: Wed, 18 Mar 2026 19:40:27 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Wei Wang <weibunny.kernel@gmail.com>
Cc: netdev@vger.kernel.org, Daniel Zahka <daniel.zahka@gmail.com>, Willem de
 Bruijn <willemdebruijn.kernel@gmail.com>, David Wei <dw@davidwei.uk>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Wei Wang
 <weibunny@fb.com>
Subject: Re: [PATCH v6 net-next 5/5] selftest/net: psp: Add test for
 dev-assoc/disassoc
Message-ID: <20260318194027.12c23a4b@kernel.org>
In-Reply-To: <20260317235222.700615-6-weibunny.kernel@gmail.com>
References: <20260317235222.700615-1-weibunny.kernel@gmail.com>
	<20260317235222.700615-6-weibunny.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 17 Mar 2026 16:52:18 -0700 Wei Wang wrote:
> +    # Test connectivity in both directions before PSP operations
> +    remote_addr = cfg.remote_addr_v["6"]  # remote peer address
> +    nk_guest_addr = cfg.nk_guest_ipv6     # nk_guest address

ruff check says:

tools/testing/selftests/drivers/net/psp.py:22: [F401] `lib.py.cmd` imported but unused
tools/testing/selftests/drivers/net/psp.py:418: [F841] Local variable `remote_addr` is assigned to but never used
tools/testing/selftests/drivers/net/psp.py:419: [F841] Local variable `nk_guest_addr` is assigned to but never used
-- 
pw-bot: cr
