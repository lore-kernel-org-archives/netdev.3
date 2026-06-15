Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1E312E7631;
	Mon, 15 Jun 2026 21:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781560239; cv=none; b=Uq1EXbHDjeCvLlZ2XAmL462KWqZ135RPH4PwGCRDZ/VWnU21qLYL8QR0t6S/NBkzOqyFWDR4KTsHt70DiAkoIK0OZgLdS9m88zb6NiyW/Y2G4CuzsPfsgxtn8/AnABje+7ig1yGGTCGLIAsULxhGCadldS3S/hSA/9/wZbnl0Q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781560239; c=relaxed/simple;
	bh=2DMamNs0h4ZXC5SkjSLbLQslhWpf5W1TUFb9UnPucbk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J2eHzZIz4bGt7rRtW/lC3zlq/X40k7cXH+wcjnIr2w1DS43Bpho/1ITb+rWrEO8uS+GuW108JMeJlpuLnRneCtJNJr9JW8Csg/d96PGJOsN9f+sip7ChMah2+OAbJc1VtRQU6wgp2n06h+AlLj1NhWBa4yiAbL3BR6YL5L7r4IM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=maSZAd5I; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="maSZAd5I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BDC11F000E9;
	Mon, 15 Jun 2026 21:50:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781560238;
	bh=rUmDL9/uSXnWdNDTm7S51nG4txVC/VP/YIY87isaxgY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=maSZAd5Ix4BpMiX30F0b5Q3d+lU10nzTyZIx27FJJfd029aHr4x2f1z8yKBCMv8lp
	 /z4jOQ8IHcXUabZfJMDx3vUQcxHoso7jPyikcYYtAWXBC8PYetMMnCkWv3hzgiYQ3D
	 6tagLpYrjRDakp7dgixQkRaeF02O6F6kxjyjoWGGM2u2PFfuARXdj2OA/EKOW3tVKm
	 6n9D+PP/IN5vadP0crSxIKrWi9030iUreQQHWuRyAYyB1mdk/x9V2LbPOu9k3+lh+v
	 o5+sIXwV9e+nX3HBJFrnxrKD0YghMrIxysEWtztgWSeEB4P9nRvbvj1j/E0AFlLxFg
	 cx93xgQr5A+Sw==
Date: Mon, 15 Jun 2026 14:50:37 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ratheesh Kannoth <rkannoth@marvell.com>
Cc: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
 <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
 <pabeni@redhat.com>, <sgoutham@marvell.com>
Subject: Re: [PATCH net-next] octeontx2-pf: add page pool ethtool statistics
Message-ID: <20260615145037.0970f6f0@kernel.org>
In-Reply-To: <20260615032141.521667-1-rkannoth@marvell.com>
References: <20260615032141.521667-1-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 15 Jun 2026 08:51:41 +0530 Ratheesh Kannoth wrote:
> Expose page pool allocator statistics through ethtool.
> When the interface is up, aggregate stats from each
> receive queue page pool and append the common page_pool ethtool stat
> block to the driver's private statistics set.

include/net/page_pool/helpers.h :

/* Deprecated driver-facing API, use netlink instead */
 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
int page_pool_ethtool_stats_get_count(void);
u8 *page_pool_ethtool_stats_get_strings(u8 *data);
u64 *page_pool_ethtool_stats_get(u64 *data, const void *stats);

Is the page pool in your driver shared by multiple netdevs?

If not just set netdev in page_pool_params
If yes then you need to explain it in the commit msg

Please note that net-next is closed for the next 2 weeks
-- 
pw-bot: cr
