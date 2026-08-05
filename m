Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 413743D6486
	for <netdev@vger.kernel.org>; Wed,  5 Aug 2026 10:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785927075; cv=none; b=KVmB9ZZz0OadtYmBLTHHi2eZ803BCzuiDSnZetyBXQmCSKHx2VcbGIolF03zm29EsliVedvkIMve005VyT4iY4kMbl5I+2TjSbVZmZqBPRU0Ou3jQm/6lI1x7Yfp76Qf1HxRAMArGbmDoh3Kp1GtslEvkKM3/OONTdqZgBNY+wM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785927075; c=relaxed/simple;
	bh=/15PUj06gZdNoqqu4iQAax9vq1FrdkLCbJLxvBjukQo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c1Y/M1iOF2oDuXRIvDquLzpjqvrUO72Gf7ydM7+osWBI2MUrefLBBbh11Ptl8bb0tclzZGk2AppX8Uo+ahtf2h3HItElZdHuDS5GBvbg6vjYHr/PJfH0Uq5KU2YPBVKEccoc59AEtA/2vPaWlZPphWE52jAwnA6Ztl/hCfQN3OY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N4QVfI7o; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N4QVfI7o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A66591F000E9;
	Wed,  5 Aug 2026 10:51:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785927074;
	bh=2BMeO9OIzsqA9J1Xfa2OMw9kjWPkLc9DITJlIFAcpos=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=N4QVfI7oHz5BFCAm8Wr9l2J1I8QnKQHHy7CstkGMRVKFOxj5YaIy5nzA4PA19UQzX
	 c66jTummaVkqyLfNDoRLZKjb7saSZlRgalT6nGSkhS01eXqCZKUe0zL0GIekd+ofKi
	 sswILjvu4KWCPaTNaRgbl4aIahDP1AIuslwbdsosl39A7mUq0Buha7MI4+b/YnsUmx
	 7MTa5JSWnfzgjAfhIGNnJ7wtjPY6vgL56u/8Qr3tXk0UTgBzo86NbVO4+aRgm92kVm
	 /WooOVj0hMRxJtKRnnCVCCXrYplGv6738y46t1wgFUjNkdRT2uDAyeekuU7xqRicIl
	 dcTw4CuplS9dQ==
Date: Wed, 5 Aug 2026 11:51:10 +0100
From: Simon Horman <horms@kernel.org>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Subject: Re: [PATCH v1 net-next 0/2] pfcp: Support per-netns device
 unregistration.
Message-ID: <20260805105110.GQ51943@horms.kernel.org>
References: <20260731224406.2444121-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260731224406.2444121-1-kuniyu@google.com>

On Fri, Jul 31, 2026 at 10:43:39PM +0000, Kuniyuki Iwashima wrote:
> Patch 1 adds a per-netns mutex for pfcp_net.pfcp_dev_list.
> 
> Patch 2 supports per-netns netdev unreg by using
> unregister_netdevice_queue_net().
> 
> 
> Kuniyuki Iwashima (2):
>   pfcp: Protect pfcp_net.pfcp_dev_list with mutex.
>   pfcp: Support per-netns netdev unregistration.

For the series:

Reviewed-by: Simon Horman <horms@kernel.org>

...

