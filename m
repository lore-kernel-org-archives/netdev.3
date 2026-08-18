Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D2D33A8FE1;
	Tue, 18 Aug 2026 01:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787018286; cv=none; b=jS/mXaaucUw7Oz0KTKBF5KLOJywF3KZenzkxiN1xpogezSzaBfc75ybhZEx1H0zmyq07vcCbS5SqVy/4pyRkseJqod2DVXRhaiUybNSBSYaRZENSqgfpJKxmiHcEaRxDY8iSfEKfeYHtCmQpzdoQFhBXnbygm4+ULhPC+/Ua3IU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787018286; c=relaxed/simple;
	bh=ByruQTWAhzsAskB7G6qFbzwroTnmyJPYs0KmaBahPAE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TVx4EZ1ZwPBLHHeYy3CjvrqGzkyq85uTXQai3PnqrFKZ5IftGyhNhrrhEhQZKjtEeXIF/c+pKaFWWBxP/vm973/PXaENtyzcqt5oRznFxfWDT5hb4FudcQkBILuUxZbC5blgoSdPUgBcq2TrWUSzUTjq4MzlAA/vcNZ6F3X4mXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C7EGN+a3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C7EGN+a3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 994E41F000E9;
	Tue, 18 Aug 2026 01:58:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787018282;
	bh=ehz01vxFoqWDZKs0SGRZ1tdcZgsnlGv+WYUq2CyH+LM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=C7EGN+a3+aIn1QDEj/IZsHXyz9dN4nwW+kPXVsxtwI5nODOt3knr89KKZHS/17G2e
	 SLQqnFpSUj7G2F+TY82Lt+KmgiZOzFvo5cNvlze6sQrwcdapoqd+Z1kzBoktGs27pq
	 uQeCR81A6Cx+E1bn1XpKU+hjb/f5hmH0p2fh5VdZ3M5mkM5dUwsUpxJ1zS21dOaKYP
	 aoLSRWvt3VviaTZCaUU7NT1YQEX+WUZtqaw8v4IAQ5ZcOgOjLuBSSjXwGidaXF8LfA
	 6w7o3x5zgG5miN+2C0bliX19EXVfe3YWcI5w29rJNdpe0ei7I7t4EH3ywlxdTOHxn6
	 gPmH4zGb4diIw==
Date: Mon, 17 Aug 2026 18:58:02 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: netdev@vger.kernel.org, Marc Dionne <marc.dionne@auristor.com>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v7 00/11] rxrpc: Fix CHALLENGE packet handling
Message-ID: <20260817185802.0aa4c9ee@kernel.org>
In-Reply-To: <20260812110129.979970-1-dhowells@redhat.com>
References: <20260812110129.979970-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 12 Aug 2026 12:01:15 +0100 David Howells wrote:
> - Fixed more Sashiko-reported bugs[7]:
>   - Made the loops in afs_make_call() that call rxrpc_kernel_send_data()
>     pass the amount left in the iterator rather than an unreducing size.
>   - Made the second loop in afs_make_call() check to see if
>     rxrpc_kernel_send_data() returned an error.
>   - Removed yet more OOB references, two in linux/af_rxrpc.h and one in
>     rxrpc.rst.

FWIW I had to kick off clashiko manually because sparse false-positives
on one of the patches. It should finish in 30min or so. I'm signing off
for the day, so please TAL if you can:
https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260812110129.979970-6-dhowells@redhat.com
and let us know if we should ship v7 as is or you want to tweak..
