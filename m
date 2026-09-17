Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 928A33DBD65;
	Thu, 17 Sep 2026 08:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789634009; cv=none; b=CkBfyiWKmUQ316ITxgli1Yl0i3bDUXOs+I9oRyk/bO+kH8oyACHXj7lzPhXpwESsla57sFDsSbTRXJ0eniGKnDY07xdiAF4nvxGQ6krHY8XEOOKroIp5PcBW1p6bbUPIkzgukimIGd3WfL5plgf1FHsSuiC0VCgJQQ+YlAfMUOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789634009; c=relaxed/simple;
	bh=pDMKA6qIRf+AndEbIesdGOG1IRINsDxNU9mkBH8CjVE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e8QlQRqjHyzG49CCHpfXpQitt+uIJhyqa4x+gBazjxbfluNZfoL6yz1uC6SeYQvoGlvqwzk6EuYmXJFOlxPCSdo5YK2YYik/a/7fl1/YcZoxJx90ElS2OX14PLPJQa0LQRqPiG00AxBUi4ne1ylwtRhszxY0y0pzFvw554bied8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Minpxb36; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Minpxb36"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A46891F000FF;
	Thu, 17 Sep 2026 08:33:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789633999;
	bh=vekd0poqQzCqoyuw3DPmsc6osNEhDh9nMSKZScdJaRU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Minpxb36rKkrHq+i94+gtYcUxuCbnsEvOyXdtsdRjvqloVMfLb84uy4vPKxktnPKk
	 xB5idmk4UreX85dBB2IkoFSnlFQ+RL08QIiJR0rU7n6QSDfriTEc4uo4qECs9X/844
	 PXQWSqF6lroKsD5EIWmOzbgy4YazYY2HHWe2gFP31vUS/nD/g2gbV7fOVuMBT6z0hp
	 GLjDV0edHQdj0h9gpCrcnZ6xZDFRtV5cUi7XKggKKKrqWJDe0A63UEgTly/qczVrdV
	 uJQArG0RD2OnIp+30KLNXfzmbSgLmCqSZTMhU1FHFzPJ3C86NRInTgF12wQVZ35WbB
	 VSODgnrb0/X8g==
Date: Thu, 17 Sep 2026 09:33:15 +0100
From: Simon Horman <horms@kernel.org>
To: Cong Nguyen <congnt264@gmail.com>
Cc: David Heidelberg <david@ixit.cz>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	oe-linux-nfc@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nfc: llcp: fix sdreq TLV list leak on parse/alloc/send
 failure
Message-ID: <20260917083315.GX51261@horms.kernel.org>
References: <20260914121129.2098606-1-congnt264@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260914121129.2098606-1-congnt264@gmail.com>

On Mon, Sep 14, 2026 at 07:11:29PM +0700, Cong Nguyen wrote:
> nfc_genl_llc_sdreq() builds a list of TLV nodes while walking nested
> netlink attrs, but 3 error paths (nested-attr parse failure, TLV alloc
> ENOMEM, nfc_llcp_send_snl_sdreq() failure) all skip freeing what was
> already queued.
> 
> Route them through a new free_list label, mirroring the SDRES path in
> the same file which already does this. Harmless on the success path
> too -- send_snl_sdreq() drains the list as it moves nodes, so it's
> already empty by the time free_list runs.
> 
> Fixes: d9b8d8e19b07 ("NFC: llcp: Service Name Lookup netlink interface")
> Assisted-by: Claude:claude-opus-4
> Signed-off-by: Cong Nguyen <congnt264@gmail.com>

Reviewed-by: Simon Horman <horms@kernel.org>

