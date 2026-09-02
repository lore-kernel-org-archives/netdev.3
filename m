Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A5654A9D56;
	Wed,  2 Sep 2026 15:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788364469; cv=none; b=j+vRkx/xyDTbRCcxxlOVoDmy80KR4MIqWgbx5dYQARvApdOOk2l8YnKQq9gzIKcvkiAXflxE8acl3uf4rK9hvnVVZXTKSAXnoQi1ZfGHvee9nC4g+yTk7I2Muhxap9IksiPa9GR4PnhPPIWGju3EshgE0f2XXxfd6d5JCsX4WiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788364469; c=relaxed/simple;
	bh=wLwvmzVQsRukFtqrXL7A77DVeN0iJazWeoBjaREnPaU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LYfbIb0V+OmMClwq8FsMZOgXvtKEOLjaDQZtDVshSmHyzafJCIW3BNK8bKSNqtAqD8FpTdZooHz64q52+FaFXLy3rK55VDFDUSqW+8TKwPCjs8/xhRakVRH4EAsiOpc5EomlTxojdXk0LYRBsjASITixnZgXRQQOx6Oi1sp98kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=og6mDPB3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="og6mDPB3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D7A21F00A3A;
	Wed,  2 Sep 2026 15:54:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788364467;
	bh=ikgGunKiG2js2SWQ2vvgXAcTmkP2clqGwoHJwoz6Jtg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=og6mDPB3fNHxT/b8DpGLOM/+fFPNR1nxAgmIc7JyX0WmQU7aOHknUrEakbgGXQdOk
	 8eHMjyLtrIx4hMI3jNx2P5hZ3/851hFFaxn7yxbb2eAZYx66WFvhc4scqBHPJtJ9pm
	 X8OJVidGTfH7w3jcE2UY3JV0+GWt0rZ8zoA6G/jRNAZByAL9u2pnkXHJpp8E+35Ssl
	 6ZsDx9yTipNh30+DHBDgW3FjyB5btSHmCLEDwO0uj+raQwG5YB3c33nv81G0rQBFFA
	 Pa5LGP4vCe8lR5hRjvzq1grDnV5Q7ls1u726Yi5d7hESIWKFsqGIm5P7GyjNZxH64n
	 3xWru1KSFFcBQ==
Date: Wed, 2 Sep 2026 16:54:23 +0100
From: Simon Horman <horms@kernel.org>
To: Yang Zi <2959243019@qq.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, andrew+netdev@lunn.ch, kees@kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: liquidio: avoid sleeping allocation under
 octeon_devices_lock
Message-ID: <20260902155423.GG396647@horms.kernel.org>
References: <tencent_6653AA61B6BB17B8D845A89977D199C08C06@qq.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_6653AA61B6BB17B8D845A89977D199C08C06@qq.com>

On Tue, Aug 25, 2026 at 04:50:55PM +0800, Yang Zi wrote:
> octeon_allocate_device() holds the spinlock octeon_devices_lock while
> calling octeon_allocate_device_mem(), which uses vzalloc(). vzalloc()
> can sleep, so this is a "scheduling while atomic" bug that can trigger a
> sleeping-in-atomic warning (or deadlock on a preemptible kernel).
> 
> The memory allocation does not touch octeon_device[], octeon_device_count
> or the free-slot search, so it does not need the lock. Move the
> octeon_allocate_device_mem() call ahead of the lock: allocate the device
> memory first, then take the lock only to find a free slot and register
> the new device in the octeon_device[] array. If no slot is available
> (all MAX_OCTEON_DEVICES slots in use), free the freshly allocated memory
> and return NULL as before.
> 
> The lock therefore continues to protect exactly the data it documents:
> the octeon_device[] array and octeon_device_count.
> 
> Signed-off-by: Yang Zi <2959243019@qq.com>

This patch has been marked as Not Applicable in patchwork.
I assume that is because it doesn't apply.
Which I believe, in turn, is because it is whitespace mangled:
the tabs appear to have been substituted for combinations
of spaces and non-breaking spaces.

Please consider updating the way that you send patches -
e.g. using b4 or a different mail server - and reposting.
