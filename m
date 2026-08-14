Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF0C431F9A0;
	Fri, 14 Aug 2026 09:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786698185; cv=none; b=qHxcA2gKcTpGN7SI/TNLzp3t1oII6KishxQJ8GlMc76tt6L2HL3Xor3X3oVNKIsN+8EgtpjxRiSrRfydWmlOkOxPRxcEz6Uazy9lPoj0UGnlB9J3AqwkcAl/OU7BafYKOhjAeIAYQj99uREDdagQXoRTAdrUyBZeBCoQQLqzRp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786698185; c=relaxed/simple;
	bh=v7NnDB45iJJKZBAGewXlPldoJFcPIiEHB8dHDR3yZ5k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kxbV1St7fM5wKGHwjPuJKvislJU0f37epJIKX+KnIYweuLzomOTN8Cjh3rYfIky6iU5DMYJGXyzuTj8+vNquLel76GYQsFCgYsXe9YFv/XH2S7skCDKSOpjXjO/if8ft9z08tQFOzURqx5wa3pIPcgQsJRPEEptjsKg3Z58HIMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i96ZSBIC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i96ZSBIC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71CFD1F000E9;
	Fri, 14 Aug 2026 09:03:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786698184;
	bh=3xk8VfJKsZzxmJb2m0gzGgSJSFSxbkf5uka6wkeIoXs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=i96ZSBICf8vQYAp8qLq/Fo99bbPXFpScjTvTKfgPeFVaAVhR6W4aPbqH3vh4/SgIh
	 7DKJBgTlFfqBY3GQp5+fx8MuSFHQQVgkmO6aHYfQV4Iwg+LkxWS+sKfwWt8aq/cFgj
	 1hmBjsdsW2ekma5Z5FFeNpHrqy2wj8SxfG04oR79uQOzWXI8p+vtQ/D5G0TloYkCCi
	 ipaS7QTS69T19la5HQX1c20LM7n9DYF6fD0HBMAAqqEBpoIST4HV9oBazNT2SF7Bnf
	 /Fyzl5d1T6FYGF6Kk322pphK4UaSjIciXwDm9UqTKV1EF35mXxYIRqYsNEqlXx/UJ2
	 Ss5aO+hjFPUfQ==
Date: Fri, 14 Aug 2026 10:03:00 +0100
From: Simon Horman <horms@kernel.org>
To: nshettyj@marvell.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Satheesh Paul <psatheesh@marvell.com>,
	Sunil Goutham <sgoutham@marvell.com>,
	Ratheesh Kannoth <rkannoth@marvell.com>,
	Geetha sowjanya <gakula@marvell.com>,
	Subbaraya Sundeep <sbhatta@marvell.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next v2] octeontx2-af: Add mailbox to read default
 MCAM entry
Message-ID: <20260814090300.GI265046@horms.kernel.org>
References: <20260812053523.3329305-1-nshettyj@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260812053523.3329305-1-nshettyj@marvell.com>

On Wed, Aug 12, 2026 at 11:05:22AM +0530, nshettyj@marvell.com wrote:
> From: Satheesh Paul <psatheesh@marvell.com>
> 
> Add support for reading the default unicast MCAM
> rule associated with a NIX LF on non-CN20K silicon.
> 
> Signed-off-by: Satheesh Paul <psatheesh@marvell.com>
> Signed-off-by: Nitin Shetty J <nshettyj@marvell.com>
> ---
> v2:
> - Added a CN20K guard to reject legacy default MCAM rule reads on CN20K.
> - Updated the commit message.

Thanks for the updates.

Reviewed-by: Simon Horman <horms@kernel.org>

