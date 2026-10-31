Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793454223;
	b=q8Zhapd3psm1L4u1jwjQYfHRRz2lp459raofgjd8Hme1MJHnO+QnhJ/NawxtD9NA26tN
	 TN1y2BhTZXt1FbD/7VsdVjPcTG4+pJvI3kZBtxJxCrHPxzz3IFNaFmY9/kmUr+ShlAkIo
	 9q4eiO1QTxyvXCiSsCYO+ii88x75d6A5zAX0LCUS1+GbJgaAKjH3pqLLGZybvJOiRtfsY
	 ml9FVg83KDreiWVQsZNUI/3D8nX3d30IuZhZKJ+eWEBR/21AWFZtj3iwleX1SMK0yNpWK
	 WMriiIO2rajTm9/hOjM/5Xz/O7BZ6tPqPwLQlarUQri4wFqq19QrlExWPtjpbYXEcwA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793454223;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=P0O29ManTeKtpfhBPE9fT4zh0to6VFIKGUZDe3mDtyg=;
	b=Q9fMDWXTYrPq+y5JGXuwWt+FlAfO6fNuY0p/HrNVHmoVQEY/JZuWdKjI3LUe5BsEqMif
	 5PzlKuI9JYttr/aSXyVwl87jIS+VXrL7/FwtbzPnAiUxr0RVirtozVfCbtidm3Ntmxync
	 8OOqFxvptw9AjmulRm9OlWjqvsMGR2NpLMSnwQ7PlIycYs0Zhi2QeVYQV3/azRDarUF5P
	 tyCbwcJQAEMc6Gjq9qMKsUFnBXsNy4hXy7PBCjeoqQe0h0N8FS7E2SZjukd/FUXjw8eaq
	 1X85hPEQYnYb50O+FBLIpoHGCKfoKCRi2SAfBDx9GB+jQCRDWVw2xqhZ4x61xgtDiwQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lunn.ch;
	spf=pass smtp.mailfrom=lunn.ch;
	dkim=pass header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=gWXg1lSc;
	arc=none smtp.remote-ip=156.67.10.101
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46547606A31E;
	Sat, 31 Oct 2026 13:43:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 46547606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=gWXg1lSc
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=P0O29ManTeKtpfhBPE9fT4zh0to6VFIKGUZDe3mDtyg=; b=gWXg1lScEuSJcAC4FFWPm8gZ85
	VTLub86ng2WutlicUJra7WZgCTd3OwapzhfOTBHIyHiwIXIVRfH4R/SOo7E1Ijur4BWR5Jt77CT+6
	BltnQ8+8oe7LXY6YHrMz9BTz4ZZtMKRYD5jEY/jGeqTUlh0/+BDi173mMngHnLihirSU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xN9Mk-00DWrK-S4; Sat, 31 Oct 2026 14:43:26 +0100
Date: Sat, 31 Oct 2026 14:43:26 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Kyle Zeng <kylebot@openai.com>
Cc: linux-afs@lists.infradead.org, David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, outbounddisclosures@openai.com
Subject: Re: [PATCH] rxrpc: Serialize client connection IDR updates
Message-ID: <d2f67f23-8535-4965-a9bc-f3fa16149bf8@lunn.ch>
References: <20261030042129.73690-1-kylebot@openai.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261030042129.73690-1-kylebot@openai.com>

On Thu, Oct 29, 2026 at 09:21:29PM -0700, Kyle Zeng wrote:
> The common connection destructor calls rxrpc_kill_client_conn() for
> service connections as well as client connections.  A service connection
> gets its CID from the peer and never owns an entry in local->conn_ids.
> Its destruction can therefore remove an unrelated client connection.
> 
> The final reference can be dropped by the service reaper or a call
> destruction worker, outside the owning local endpoint's I/O thread.
> Client connection destruction can also run off-thread, and can remove an
> ID already released by rxrpc_unbundle_conn().  These writers can race
> idr_alloc_cyclic(), corrupting the radix tree and its RCU callbacks.  A
> second removal can also delete a new owner after an ID has been reused.
> 
> Only run client cleanup for client connections.  Restore a per-local IDR
> writer lock and the client-ID ownership flag, clearing the flag under the
> lock when releasing the ID.  Serialize IDR destruction with the same
> lock.  This covers deferred final puts without changing connection
> expiry or the RCU lookup path.
> 
> Fixes: 9d35d880e0e4 ("rxrpc: Move client call connection to the I/O thread")
> Signed-off-by: Kyle Zeng <kylebot@openai.com>
> ---
> I have a reproducer for this issue and can share via DM

Please take a read of

https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html

You need to set the subject line correctly to indicate the three they
are applied to.

All the patches you have posted are very likely to be sent to
/dev/null because of this. It is a good idea to start slow, only one
patch at a time, and figure out the processes.

      Andrew
