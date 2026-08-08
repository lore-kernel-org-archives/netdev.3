Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCCB91A6814;
	Sat,  8 Aug 2026 01:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786151120; cv=none; b=GaE7vY1FP1WgQrRtK9Yx3j0NPSb1Asuxmcv+nwxrUPVru/eDrP3q9rnoSIubsqSMyA6hF4t6K2R/e51AMau37Njat5WwP0Zavptam2CU80e67WhkoupwmdkoL0lu3ZQmcAs2QaVgwX2LBOtuJa41KLbXTEaGRRv8rMtCHAtJtyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786151120; c=relaxed/simple;
	bh=8+fdE8j3a7Hlv0lyHS3fKmGh77uXsR/05i+Fl4uw8Y0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Vya++WxCUafYfc/3p9PRajBFkUxvpzKO0sQTrhpQgK6s6RWV63HLik3teEvvWyGj6NpRl7d1+XPkW7wpyh2zb2yVtS8kOWTXL6+75YSlvwxcD7gxPa49NiKHeJdppXW5Hk+VQghkrR4+bPjz05YZ6bqA3o3KuNkraAHeO4gJono=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jyDp96CJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jyDp96CJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34AED1F000E9;
	Sat,  8 Aug 2026 01:05:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786151119;
	bh=Wl1NojbxYlCFC8IRtpseNB09uIGnB+TGYTWDPKi4M3w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=jyDp96CJrKXGbFTFwjiUfOYXGxIil4NIhYi4sPXnXt0KJstU4lSqjUo9JcXETeqEf
	 3k4B9c9d37njpCNOlxKCB8bTOngBdkruQJCT2t+3nk89mv8EEjJBa7/qcIksWBgZWo
	 7hRhxGKV9mBnej3p9N6ViyU12VkU5SOaWGvy/T742vBC3P8uop0AqW8+zS1VNCKROK
	 A0GW5JBQm/f+DWQSlpyQdD9S31riS8tkkwrrGzOfYFEC6Y3VcW350CsaIGencyfvtI
	 9hav5edLRhrI5XvjLHgFCZf/0HuLJznltw7J/gLI8GPkGlVuRGaxSFrp/K5tRHi7j4
	 E7sL0y+s4mRyw==
Date: Fri, 7 Aug 2026 18:05:18 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: netdev@vger.kernel.org, Marc Dionne <marc.dionne@auristor.com>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v6 00/10] rxrpc: Fix CHALLENGE packet handling
Message-ID: <20260807180518.0287b58e@kernel.org>
In-Reply-To: <20260806091511.46a2fabb@kernel.org>
References: <20260804172639.2844491-1-dhowells@redhat.com>
	<20260806091511.46a2fabb@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 6 Aug 2026 09:15:11 -0700 Jakub Kicinski wrote:
> On Tue,  4 Aug 2026 18:26:27 +0100 David Howells wrote:
> > [!] Note that this entails a significant change in the UAPI for AF_RXRPC,
> > with the CMSG types and sockopt to support the OOB queuing being removed
> > and replaced with a new single CMSG type that conveys the user key ID.  I
> > don't think it likely anyone is using this outside of my kafs-utils
> > package.  
> 
> If the remaining Sashiko issues are false-positives - should we queue
> this to net-next, then?

Blah, doesn't apply or pull cleanly now to either tree :(
