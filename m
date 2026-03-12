Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10B363A5427;
	Thu, 12 Mar 2026 17:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773337074; cv=none; b=DQXRfYASUps2E66AQrWKxiOnkZOtGaZwRSW6XkMoiKeCj8mshaTI8IL2RENBTyQrKTUzhS9zcqN9LcysT+wElMHW91RQnuSJVnPgS66x7Yr6/8zxZno+owj8h2bWJtcY0kFYa9V1dMH7U1iWvTG7/u9Gfn/N/27FLHKYYsxplMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773337074; c=relaxed/simple;
	bh=K+Cz/xB86Qa6TQnZ8lj+kGKU/XCB+CgbnDb4VCfLD+I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JpYqyX7/vZfMybo4ai7scoAIzW/MqrbUxAWKPx6mtcSGkrD5kcqXqPkW84tv2G64C5xKTVCgx1fLa0SkBVxkgv+EVlzJouOhc3WuG5T3Nt5bVdhsxletAEtIeCdYXtsgbe128AZ4h5pGcVLKgWZG84FS5RCyNohpuRp265M6dE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aE5W8clO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aE5W8clO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5279C116C6;
	Thu, 12 Mar 2026 17:37:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773337073;
	bh=K+Cz/xB86Qa6TQnZ8lj+kGKU/XCB+CgbnDb4VCfLD+I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aE5W8clOzt3Mxvwhl1gA6YnoANTXGV4nJrrJxWwN/9VNCzwDZa2kZJhxP3hbQSjVx
	 dm4sXPKwkFSvKdpYwJ54NAjzF7l2BRHBhicSWYiYFVSaFAXQDrrrlZvr3SRoLXNgFz
	 ay2atzM8pYVb/M7QH48zoKf6sftfy4+ApIZyewIAhRqgPgjdPH1g5xi+A1y3vVFUj2
	 2lU4Z3NKJaH4lmS+trZVSJhkWZmuqooYmGOUg2OtLPO4mUD1QpWaLu3VYQB3PR8I/k
	 5sSeExGsgi8VRrMM0KoSrqOl0BAY2KWiU//amiRJevUVfqpwFE8F32JGe/4hLWRybH
	 RopHsG6sBP4PQ==
Date: Thu, 12 Mar 2026 17:37:48 +0000
From: Simon Horman <horms@kernel.org>
To: ShravyaPanchagiri <shravy112@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, sgoutham@marvell.com,
	lcherian@marvell.com, gakula@marvell.com, hkelam@marvell.com,
	sbhatta@marvell.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, corbet@lwn.net,
	skhan@linuxfoundation.org
Subject: Re: [PATCH v2] docs: octeontx2: fix typo in documentation
Message-ID: <20260312173748.GA1270007@kernel.org>
References: <20260311030450.8461-1-shravy112@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260311030450.8461-1-shravy112@gmail.com>

On Tue, Mar 10, 2026 at 10:04:50PM -0500, ShravyaPanchagiri wrote:
> Fix spelling mistake "Crate" to "Create" in the documentation.
> 
> Signed-off-by: ShravyaPanchagiri <shravy112@gmail.com>

I note that this file is code-spell clean (before and after this patch).

Reviewed-by: Simon Horman <horms@kernel.org>
