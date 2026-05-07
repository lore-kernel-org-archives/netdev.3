Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F3E91FE44A;
	Thu,  7 May 2026 01:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778119101; cv=none; b=LE5Rvxoas7e39HJ3HdAQ5LIu6chkAgDvMrxkFowN65cfSmfMXb2jzmzBEib8GJS0RaJObzHtEOwK/gYj7C0aWBfXNAFXna3c9W3MpLat6aw5ZN64+PrEIZy0zWA6afzG2ycGjbB+I+NOHSF56lFUsNHpSc5tpEwy0kdd9Kcf8CA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778119101; c=relaxed/simple;
	bh=aasvnAqp89/RSfdQ3nK6msnymtAEOsa1TifpaVtXIhg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nlWk+8XE6/MEdR9hBwxF3WM5SLvRWu7go8gAohW/L942B0hWyLxPwQGzqyMCMf9R9G6Byqol3hUMeTFzMNLRTrNtjvASctIwNVHQ9XPF8BaB6rPRMVmfEwST+9xZd8FtjTL1gPbpxlXcym7M+z3o9o4vvaynah5UGjUz+hjIyrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZMjhUoWX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZMjhUoWX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99D69C2BCB0;
	Thu,  7 May 2026 01:58:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778119101;
	bh=aasvnAqp89/RSfdQ3nK6msnymtAEOsa1TifpaVtXIhg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZMjhUoWXOlEJjXQGkfzPbOumFLAb9HDAqSInOllj+KXCqRiDFnFTExdEu0krByfhF
	 23N0Wlza6l9qP/hoQPtN8s+tDWP8vIrMY35NvTwYhkxaa4oMqGdgp7qc5uKRM6/z4Y
	 5GQzXnJNZytlExW3fP1vUd2MOyznbDfq8GgOozSEQ3FsHdqVd/5wAzxqyN1J9op3n+
	 lw93Az9zAjru2WxKaynl0W90/p7EQTDzVOdi8o7iWOtvaS6GR/5fQT2whlontQEi1A
	 pk74jbJSS2RsmQGZZFgizVCI0SvjT1Wok/QiZ+fqWwI7i4dFznaSXQYELxRpUvZdxj
	 ZpDWOx2C+3HlA==
Date: Wed, 6 May 2026 18:58:19 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mike.marciniszyn@gmail.com, Alexander Duyck <alexanderduyck@fb.com>,
 kernel-team@meta.com, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Heiner
 Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>,
 Jacob Keller <jacob.e.keller@intel.com>, Mohsin Bashir
 <mohsin.bashr@gmail.com>, Simon Horman <horms@kernel.org>, Lee Trager
 <lee@trager.us>, Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 1/4] net: eth: fbnic: Fix addr validation in
 pcs write
Message-ID: <20260506185819.1c68a71b@kernel.org>
In-Reply-To: <20260504135815.44226-2-mike.marciniszyn@gmail.com>
References: <20260504135815.44226-1-mike.marciniszyn@gmail.com>
	<20260504135815.44226-2-mike.marciniszyn@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  4 May 2026 09:58:12 -0400 mike.marciniszyn@gmail.com wrote:
> From: "Mike Marciniszyn (Meta)" <mike.marciniszyn@gmail.com>
> 
> The DW IP has two distinct PCS address ranges cooresponding
> to the C45 PCS registers.
> 
> The shim translates the PCS addr/regno into specific CSR writes
> into one of those two zero-relative.
> 
> This patch fixes a one off in the test that could allow an invalid
> CSR write if an addr == 2 was called.
> 
> This patch contains a fix for addr validation in fbnic_mdio_write_pcs()
> to only return actual CSR reads for addr 0 and 1.
> 
> There are as of yet, no real impact for the bug as no PCS writes are
> not yet present.

Hi Paolo! Was there a reason / do you recall why this was not applied?
(I dropped it from patchwork now. If the omission was accidental it has
to be reposted)
