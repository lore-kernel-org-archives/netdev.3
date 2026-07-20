Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0386E23B62B;
	Mon, 20 Jul 2026 23:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784591428; cv=none; b=tmn/A3b0yyxrbpukf2xoEbgCkgujij7Ga4C4lN7cQ9ZKGECHVasgL4q8CfX0EK6+BllZGohqN3v+nI+c82DFhVyN/RWU5kRFwYZxXNv5aJJ7CvHIUH5sRuesDVLBFSPitA5MiQuWPCpFbhOh7W7GSDEkN3Bxj6Tvy2pdLE03Z60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784591428; c=relaxed/simple;
	bh=6McwbyPapcxi9StW5+k7jaK9H4nzKCDZ7qE2LcwxhkQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rZi81SOnPXdiNBqe2nU2+L2OdqmM62k6gjwcv9gYOUUwNl7wk/RhaasFgoeS2MLMf0s4w79M41+uuSkZTf80NrEh9Mb05UVUuIuDKuuozA1con0X8hQi4NMMOGhc4+QF0q10+9qgFD6xqVOa4xmUNx3q24VAMMoJldOg6rGcHHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZnHvffpZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZnHvffpZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C5E81F000E9;
	Mon, 20 Jul 2026 23:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784591426;
	bh=wwKJZ8GsCP81atea0GRALydFPDrvE7MBzEcIpO42pbA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ZnHvffpZJ/tLK1cHoPqVg7NgVqwp9dx2318QLYwnkMr4LUfwTeXX/TfEwaaTmW0Mo
	 agc3Hpb7irX0BU7dEujLbHW5EHxP4icP/XCfnlOgaBNV/EqWwMr1eP96f9AhfeyVcy
	 uC/zCBRRd8ZRkqdvge2swYrYWlncCRgiDqwwp1vAwl4w9jA9oruq+kJj1tpsWAEiez
	 bkcA4MDhabGNdAsvjj7vBERt7Ho7nH6Ln19EZtfmUjK9cIMcNXiMQLboH6Ov5NkZOE
	 L5SG00iE5zkKKMWsrYPfOnuPwS9bWiSTsiAGZtM+KLqMVF3b+4aENeHueheKq/+TpZ
	 jz76n/i6bKGMA==
Date: Mon, 20 Jul 2026 16:50:25 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Maoyi Xie <maoyixie.tju@gmail.com>
Cc: Veerasenareddy Burru <vburru@marvell.com>, Sathesh Edara
 <sedara@marvell.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S .
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Maciej Fijalkowski
 <maciej.fijalkowski@intel.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v3 0/2] octeon_ep, octeon_ep_vf: fix skb frags
 overflow in the RX path
Message-ID: <20260720165025.5f13460e@kernel.org>
In-Reply-To: <20260704061511.2350737-1-maoyixie.tju@gmail.com>
References: <20260704061511.2350737-1-maoyixie.tju@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat,  4 Jul 2026 14:15:09 +0800 Maoyi Xie wrote:
> Both octeon_ep and octeon_ep_vf build an skb for a multi-buffer RX packet
> by adding one fragment per buffer_size chunk of a device-reported length.
> Neither bounds the count against MAX_SKB_FRAGS. A long packet yields about
> 18 fragments, one past the default MAX_SKB_FRAGS of 17, so
> skb_add_rx_frag() writes past shinfo->frags[].
> 
> Each driver now checks the fragment count before it builds the skb and
> drops a packet that would not fit.

Why are you working on this driver?
