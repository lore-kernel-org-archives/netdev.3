Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A4D240D560
	for <netdev@vger.kernel.org>; Tue,  7 Jul 2026 12:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783428917; cv=none; b=GnUpuHQHXcg4NXYAzrhnsmg0pOywuAzH0ELePPvU0JNIEO1Jb743A1PKZEIk7W9Oup+IElAZa/31x4SBL2ykqS0oswsQjPJAiz3q/xPGNTq2+ZHc93jG8k98eZgQg6V+0OiJWUZTeRtWphuPqTLttGCMdYaqJbqNYd7tRuTggso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783428917; c=relaxed/simple;
	bh=RvrK0eHciY43FGq0J9Bs52BHiC0uCne1sQjE8EEUj50=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d6LH9YaUuR7ilGvW00hIzH5MHDfXq1RjgGRJrbLmzA/aUK/krs8B97Un//KHDbIQFPhlWmsZqWDUeK90ZjhfW0uekNqjhYpIxAj1GBH1V+Aalq7w9VKwnaSyyDGpxwHXPeHaGbM5trwHIfNqXuGkodmysD2zBcZQnzu66f+BGa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cruJ+f6k; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cruJ+f6k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C8181F000E9;
	Tue,  7 Jul 2026 12:55:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783428915;
	bh=YT0pA/hYKGagg+Dgj3aRE3Asay2Q+BZOYen5/SRfkgc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=cruJ+f6kEkxSlTR9XlGBMM9zP7/MBffL0wJrH5hEMk0CMS6shVlGU+jmvLXQu+hKY
	 FjKFjCU8t0udlJbpjCVsRNYE71PFAGOE8wtYFa3wlvd+OzMcuwKfpI5gnoJdN5zNgK
	 LWRkj5CIaMbNU4jvhYk1CPZzEPPKSvtVORE3z+DHqEnSiqUI+JhWjeAxZIebKrQbJH
	 NuaKWuKLVVusluLOEOHN29U7Bjh/RKqGDklPAec8MVFQJEGeGj79W3doZNWm8mLFqT
	 Agf1tbhOA071Zie9/UYsdlrs/tLyxPsLlqkAaK733afnn8FtOb6WyUeiBurDF8j67A
	 jITTzN450hTgQ==
Date: Tue, 7 Jul 2026 13:55:11 +0100
From: Simon Horman <horms@kernel.org>
To: Yinhao Hu <dddddd@hust.edu.cn>
Cc: David Heidelberg <david@ixit.cz>, Kees Cook <kees@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Dan Carpenter <error27@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
	Samuel Ortiz <sameo@linux.intel.com>,
	Michael Thalmeier <michael.thalmeier@hale.at>,
	netdev@vger.kernel.org, dzm91@hust.edu.cn,
	hust-os-kernel-patches@googlegroups.com
Subject: Re: [PATCH net] nfc: pn533: hold a reference to the request skb
 during send_frame
Message-ID: <20260707125511.GD1364329@horms.kernel.org>
References: <20260626073434.3977525-1-dddddd@hust.edu.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260626073434.3977525-1-dddddd@hust.edu.cn>

On Fri, Jun 26, 2026 at 12:34:34AM -0700, Yinhao Hu wrote:
> __pn533_send_async() publishes the command and then calls
> dev->phy_ops->send_frame(). Once dev->cmd is set, an incoming frame
> can be matched to this command: the I2C threaded IRQ runs
> pn533_recv_frame(), which queues cmd_complete_work, and
> pn533_send_async_complete() frees cmd->req with consume_skb().
> 
> On the I2C transport, pn533_i2c_send_frame() still dereferences the same
> skb after i2c_master_send() returns, so a completion that races the
> send can free the skb while the transport is still using it.
> 
> The request skb is owned by the command object and may be freed by
> command completion at any time after dev->cmd is published, so the
> transport send path must not assume it stays alive. Hold a temporary
> reference to the request skb across the send_frame() call so the
> transport always sees a live skb even if completion races the send.
> Add a pn533_send_cmd_frame() helper and use it from all three send
> paths.
> 
> Fixes: 9815c7cf22da ("NFC: pn533: Separate physical layer from the core implementation")
> Signed-off-by: Yinhao Hu <dddddd@hust.edu.cn>

Reviewed-by: Simon Horman <horms@kernel.org>

There is an AI generated review of this patch available on sashiko.dev.
You may want to consider the issues raised there in the context
of possible follow-up. But I don't think that needs to impede the progress
of this patch.

