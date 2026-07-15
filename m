Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B53C444839C;
	Wed, 15 Jul 2026 11:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784115801; cv=none; b=tQ045K0xdfnEb36TxIoBpDFIpu8UR4f9DwGXQ3CHVqQolF1dNJhQa+eTR5ATr+84kiyrNO/ajaBFy8a35hQ6ddNEEB1DxMAoLC8P+4eFOfhNpdGZi6m++d/PTjRCNDQnf06GgUsTDQW63BYhHHET8fz3ZHn9zFVIVIVymkt8E8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784115801; c=relaxed/simple;
	bh=Jll5RMiLa0jMPTumfYjgdT9QstnUZJXFMv94INS7X+w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hrr3v/ASEqOPgyiQWycOgl5vQ76UNeYgbL1azvvcVs3GfKdstuROngxV8W94zOFDs1U2unRBs5k1ymAZoJXb7evchpOgXj4W75EThNBBDGS0nJx2m2npdcQePJ4Xfk65Nhf087VjSGvtONACUNqOk2ijyz84cRbAv2S+SlU8Sbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HhxOnmWg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HhxOnmWg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FE0F1F000E9;
	Wed, 15 Jul 2026 11:43:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784115800;
	bh=t+OH7SBSWK76BJsPef8/MG+FlPYEbBchqAwFQ+qb2kQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=HhxOnmWgty1SHYCdDYii19fi1SAf2k5mYi40APByHJf50pa2CJjVL6oTTRHK0JRBL
	 TMwwj6j8hllZVF5G3tsbDrziojYi2/KO4U1tqz9J0hwl+PxeKcnhIAP2nPqJJRwwd5
	 b4/Q9R6psbPHv/NVekWnDRkqto3oRHbBS4vTbf3Ckwxl6tUbXmgG9m+h+sXxRTR5nJ
	 /NlDJvIBt08BdTi9LxRvcylCm7rtx1ZQLxHIW2r4eD+zs9GHlyWnkFrpQkaQOxWbk2
	 qRja2wDSukEXYyCKqCDLBrLd1HFV3QH4qHiUtYJxr6jmqblYZX8MNZlW1gQkO0GNWZ
	 AwVoExg0hot1g==
Date: Wed, 15 Jul 2026 12:43:15 +0100
From: Simon Horman <horms@kernel.org>
To: xuanqiang.luo@linux.dev
Cc: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>, netdev@vger.kernel.org,
	linux-afs@lists.infradead.org,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org,
	Xuanqiang Luo <luoxuanqiang@kylinos.cn>
Subject: Re: [PATCH net v1] rxrpc: fix io_thread race in
 rxrpc_wake_up_io_thread()
Message-ID: <20260715114315.GO1364329@horms.kernel.org>
References: <20260708093534.53486-1-xuanqiang.luo@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260708093534.53486-1-xuanqiang.luo@linux.dev>

On Wed, Jul 08, 2026 at 05:35:34PM +0800, xuanqiang.luo@linux.dev wrote:
> From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
> 
> rxrpc_wake_up_io_thread() checks local->io_thread before waking it, but
> then reloads the pointer for wake_up_process().
> 
> local->io_thread is cleared with WRITE_ONCE() when the I/O thread exits, so
> the second load can see NULL even if the first load did not.
> 
> Take a READ_ONCE() snapshot and use it for both the NULL check and the
> wake_up_process() call, as rxrpc_encap_rcv() already does.
> 
> Fixes: 5800b1cf3fd8 ("rxrpc: Allow CHALLENGEs to the passed to the app for a RESPONSE")
> Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>

Reviewed-by: Simon Horman <horms@kernel.org>

