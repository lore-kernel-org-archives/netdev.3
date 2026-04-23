Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 344363A7F61;
	Thu, 23 Apr 2026 02:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776912278; cv=none; b=CaVrTLGVyyVdu6ISwZCONw8aaho7/DKR2vRWdPBosnWghmjQosL2IfKr4XnQalLnnkAjOMCczlw45naGAINfjGTTxZ6Gme+yilK45+v34aZOWmnK+Qg2Mvvl6G0s0GzEIhXWf0047PTnU2BM7Y25bTlJFzgAwt+Qe53chzd9ewY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776912278; c=relaxed/simple;
	bh=X6TikhqBuKL3LHIiQZRafoGq2I9En0G3QhQRU26UtH8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=chWr0JfMDg/Ukd2Zy4Q1GrKEKVWZFL798jGLdWrR3gcmoH2jWTQMHUF9XQeP3hQnylJkDAT/QMG5q1rjKmJP4HvWuTCPV2RchJ90Eg4z4iSfI8dCCR39Oxc7hroE9GAUc3SOFQ49x9ekkGhzEqBXm+I7LQFq+pJmYC//NIE4Plw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=epxMGkaK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="epxMGkaK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47767C19425;
	Thu, 23 Apr 2026 02:44:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776912277;
	bh=X6TikhqBuKL3LHIiQZRafoGq2I9En0G3QhQRU26UtH8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=epxMGkaKD1KnvCAr2uEOuBEj+WyuNFq0Wu9fnVwxD/v8fyI7XMVuBUG9Ly/lrBw7C
	 t45vL0AL1p0dYdWBbH2eL+/+BzkR73njaBnWpJ/YsO7YTqZgRu3bYD3nlGIt1UbQ0K
	 n9mlmbo/vUIJiFA33OaDnsli6H2kSA8tdp2DsPeAVRDZmwh3MvR7mZRdgG4JB0JZc5
	 gEBLEDJ5ynMTgW6DUl6H8RzCJlx79EyhuFwqA5JPyciMDmzrEQJ5k4XwEzjjhpjdAx
	 Ws60RlIc+WjvpC6bqnDitefmygd1EICWH9XAr4RWb3MdASv9izrLmjqyQdOi2VcVc9
	 Rjl7GPzjzaEXw==
Date: Wed, 22 Apr 2026 19:44:36 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Daniel Palmer <daniel@0x0f.com>
Cc: David Laight <david.laight.linux@gmail.com>, Andrew Lunn
 <andrew@lunn.ch>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Jonathan Corbet
 <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org
Subject: Re: [PATCH net 00/18] Remove a number of ISA and PCMCIA Ethernet
 drivers
Message-ID: <20260422194436.7e1e6ce0@kernel.org>
In-Reply-To: <CAFr9PXnuyb0jTAhRgJGRmdzUMxP-0HrHHHN3YpQnOn8-nBBC1g@mail.gmail.com>
References: <20260421-v7-0-0-net-next-driver-removal-v1-v1-0-69517c689d1f@lunn.ch>
	<CAFr9PXn1ixyhD42OswoyGZ=W-O-oZygUGpRNm2dcAuYBNgtmQw@mail.gmail.com>
	<20260422101316.0efdcf24@pumpkin>
	<CAFr9PXnuyb0jTAhRgJGRmdzUMxP-0HrHHHN3YpQnOn8-nBBC1g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 22 Apr 2026 18:33:15 +0900 Daniel Palmer wrote:
> Seriously though, I think we should have something to mark stuff in
> MAINTAINERS and elsewhere that is in the kernel but only because a few
> people are having fun with it.

IMHO that's not a great use of upstream maintainers' time.
We support loadable modules, perfect fit for retro computing
and drivers which aren't up to the standards.
