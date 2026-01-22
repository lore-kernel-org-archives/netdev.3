Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 089283D4480;
	Thu, 22 Jan 2026 23:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769124746; cv=none; b=iMnP+u+ngdWplDVvxZL6Mi+YkmTw83bnRr5Gcs4f4++uOFYgWTZoWsLQbfOBgl6VSgbT2qYX64m/ZiidIbsUyS7s9exlzcqAZahl4/+HuS/b0e69cISaeXAhOisw1yz6X+O2Samu1yWBSdBJA2blw39biFddzbNIrHCXFYL6yNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769124746; c=relaxed/simple;
	bh=pAT776vAMVtTw8hACG8v0ACRQ5XRO/IXCtFrCVWh7Vs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TeVZKHyQRodEQKPiNsZp7SxqlPGhrIMrLOAz5r/rJoTbDTCY8MJL9S9q/twB4TwbFkXh2p1lfJMAqYqu/QXr8YBotuPNl1XmMKsJ9AcxLWwLOSJFe1NAVGj8McFNuXV6ItaXDkZSoHO1ttylH3j+YGTmpA22sz8MZYg3jAePldM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=OfJLXUB9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="OfJLXUB9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0569C116C6;
	Thu, 22 Jan 2026 23:32:22 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="OfJLXUB9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1769124741;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pAT776vAMVtTw8hACG8v0ACRQ5XRO/IXCtFrCVWh7Vs=;
	b=OfJLXUB9m6ltf9zHvBNCvADhsi5GjaX4iOwX4LrbBBZQd/MTXcgpFlkHaOnGAb7yX/HYXq
	jxjSAe1uswY4ZNwT69DHzxIfEoo7EMkyYmWutZyJJrGGNbCN+/HEw8H/o5ZANN3TaIw4Y/
	mEPHqeOlevZqlXG2JailGs+PSKpZSws=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id f31f99e7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 22 Jan 2026 23:32:20 +0000 (UTC)
Date: Fri, 23 Jan 2026 00:32:14 +0100
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: =?utf-8?Q?Asbj=C3=B8rn_Sloth_T=C3=B8nnesen?= <ast@fiberby.net>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Jacob Keller <jacob.e.keller@intel.com>, wireguard@lists.zx2c4.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH wireguard v5] tools: ynl: add sample for wireguard
Message-ID: <aXKzflND_hv4s4xj@zx2c4.com>
References: <20260115211032.204481-1-ast@fiberby.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260115211032.204481-1-ast@fiberby.net>

On Thu, Jan 15, 2026 at 09:10:31PM +0000, Asbjørn Sloth Tønnesen wrote:
> Add a sample application for WireGuard, using the generated C library.

Applied. Thank you for taking this all the way.

Jason
