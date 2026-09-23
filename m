Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DB3130FF08
	for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 00:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790125014; cv=none; b=m30ct91v9Nrefu7ciDfwsR5x+V84ineemZW3G0eWCpEOVxAYcDyfipnKHICuN9PrJQUqWRvPaxYrKrv1rSvCNqpTuU6bhmAFowhZEs0UmPnBQK+OxneUq1G156THiZ4jrNOCDexhHdbWFdkwfmSvH6dGz4+u9a4KKCutKiagXXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790125014; c=relaxed/simple;
	bh=PFQp7g92q+Tpba9RQ8Bpn018hdOQ9F5qrstOsLNkJ6E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WEeNs8TcNc+E3lF/gN6PZ6LgbX857EXeRGgjuAW+C5ANn3TBu+T7QpqG22XjbJlFr79OIb9JjsMDGsHnD/pj52sshAoRt80pTnZNMEA8lLhoUT65oEmbGYB9+SuCGwvcUlELx+8hQyD1RebLMSZosUQznGx9SSj5mLXBIH+IEGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U1dbpVR7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U1dbpVR7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFC331F000FF;
	Wed, 23 Sep 2026 00:56:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790125013;
	bh=o0ozVqhfvrckFmMoctVk48Vngujn2pQPCuaFxfX6BfM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=U1dbpVR7ZZ+zsTPe13TuViU+GZKu1eMjkdJxpCBNKWtOpkYxRspLYXSK8jYwWVHyC
	 EjYJU/oG9UVI1I36ABJqgaE36G3XNHHJ6Y7TskEtcS/nCb6VoWhZp+GHh3JPjIu+8k
	 J8nTxtdp85dd3jSqwu88YwyzI04O6FNhiDIMy5GmNj+qvvS7dEQsLj6GLuFOAcphLr
	 nostbWOhjWpJq0+CAcNGDfu5tUG7th6wV/WvKV4S93PT6D3StwBCDaDSPsR2qKtCmR
	 f6GhCXc1EPKkupuou9V3W25Z/Vpk1RNWo7BpfRjCyWG3PVtqVLujOQis3vmYfGZJim
	 p0MWBzT/Wi/hg==
Date: Tue, 22 Sep 2026 17:56:51 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Hannes Reinecke <hare@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>, Sagi
 Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org, Sabrina
 Dubroca <sd@queasysnail.net>, netdev@vger.kernel.org, Martin Belanger
 <martin.belanger@dell.com>
Subject: Re: [PATCH 2/2] tls: return a distinct error for control records
 from read_sock
Message-ID: <20260922175651.3ce5d18f@kernel.org>
In-Reply-To: <20260922133708.84522-3-hare@kernel.org>
References: <20260922133708.84522-1-hare@kernel.org>
	<20260922133708.84522-3-hare@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 22 Sep 2026 15:37:08 +0200 Hannes Reinecke wrote:
> tls_sw_read_sock() leaves a non-data record on the receive list and
> returns -EINVAL. The same function returns -EINVAL when an sk_psock is
> attached, and an actor may return it for other reasons, so callers
> cannot determine whether a control record is waiting.
> 
> Return -EPROTO instead. The record can then be read with recvmsg()
> and a control buffer, which reports its type.

Please run the selftests.
-- 
pw-bot: cr
