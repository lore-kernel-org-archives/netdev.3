Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC6709463;
	Thu,  3 Sep 2026 00:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788397091; cv=none; b=VJFNP+ewuQmiaE2rcfms3SMKEPuZcYPCU9KpPzg3hWnIo/VC1U2/Bk8Dak7QZd1It8DTV7ZvcQJVmPDAMLreJvnzwRNxCLFsYrVl6SHOF1ZPl8RNfaf05SjrqiX2vViIjKEv2+eTWK64bnqQDTHR+kRItDWF+T3d/cFGkBXT0dA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788397091; c=relaxed/simple;
	bh=6Z1QLTho/qg24a8CEJ9NUBfWxa+C17nrF+txoyv2xwc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NGK/DmiZ2xQUvxBwNkCRFIMfpre/kQAUwud1YMOyfUOvW0e2DR73P8tKP7lI4/VyFVXEJ338hBIv5U3uK4CpMSGcJd8HIVBf5YHS/8IPxJAKaef6SgMaoFxcQ7aN9ZI0Bx1YqJDjsyIUtKYe36A01tzd/50RzK3xALElxY+XHGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RKCYj5Hs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RKCYj5Hs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4025D1F000E9;
	Thu,  3 Sep 2026 00:58:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788397089;
	bh=MVuln2L/DOqdg7FfuTweNKo/Jqs+fblHDj6cIXMRwzU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=RKCYj5HsenuRPArA52fvWck9s/9/CWa4nMce8h7Pi1fosgHETajJgfT8RlzjXxwGx
	 MPRkngL30zUfJxcknESaivvhWk1w0wC2dHZ8tD1BP+6ojuOe6CBb6AREcBAIPzlnIF
	 d81A1Wdumz477duNW2cIDYjBKkgQ0g7Hi3Op+uQYx7UFsZajAr7RijSPWjhvWsC22Q
	 bLV1OOgYlD/LBagLFtVpDQUH65qW+Unv3D4hteakPRcDlgJeriRkN0aBcNkBFKApdQ
	 JvJI+L/0zRB+cr+yDY31GiofVeL67zJiiSHlHYi78SvoNXa3FxzgpR0mNGiCZjkLNa
	 rb33TpP4V76uw==
Date: Wed, 2 Sep 2026 17:58:08 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Simon Horman <horms@kernel.org>
Cc: Yang Zi <2959243019@qq.com>, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, kees@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: liquidio: avoid sleeping allocation under
 octeon_devices_lock
Message-ID: <20260902175808.095e3cd4@kernel.org>
In-Reply-To: <20260902155423.GG396647@horms.kernel.org>
References: <tencent_6653AA61B6BB17B8D845A89977D199C08C06@qq.com>
	<20260902155423.GG396647@horms.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 2 Sep 2026 16:54:23 +0100 Simon Horman wrote:
> On Tue, Aug 25, 2026 at 04:50:55PM +0800, Yang Zi wrote:
> > octeon_allocate_device() holds the spinlock octeon_devices_lock while
> > calling octeon_allocate_device_mem(), which uses vzalloc(). vzalloc()
> > can sleep, so this is a "scheduling while atomic" bug that can trigger a
> > sleeping-in-atomic warning (or deadlock on a preemptible kernel).
> > 
> > The memory allocation does not touch octeon_device[], octeon_device_count
> > or the free-slot search, so it does not need the lock. Move the
> > octeon_allocate_device_mem() call ahead of the lock: allocate the device
> > memory first, then take the lock only to find a free slot and register
> > the new device in the octeon_device[] array. If no slot is available
> > (all MAX_OCTEON_DEVICES slots in use), free the freshly allocated memory
> > and return NULL as before.
> > 
> > The lock therefore continues to protect exactly the data it documents:
> > the octeon_device[] array and octeon_device_count.
> > 
> > Signed-off-by: Yang Zi <2959243019@qq.com>  
> 
> This patch has been marked as Not Applicable in patchwork.
> I assume that is because it doesn't apply.
> Which I believe, in turn, is because it is whitespace mangled:
> the tabs appear to have been substituted for combinations
> of spaces and non-breaking spaces.
> 
> Please consider updating the way that you send patches -
> e.g. using b4 or a different mail server - and reposting.

Also we should consider deleting liquidio instead of fixing it?
It's _stupendously_ buggy, and Orphaned.
