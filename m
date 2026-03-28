Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 012AE175A94
	for <netdev@vger.kernel.org>; Sat, 28 Mar 2026 03:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774668601; cv=none; b=FyHVB+y9cT4KDVJ9A7sf7o7g19Ij3OTKR5wQUvb+srsWcs92Is+9Ff9AHKEU+HmOqw3ORScNyBQyDegmG8qHu3Vtd1g5ikph/vDCoxoPIMFaPlFd3gUI5VKepmICJ2L9kLjeiD5FzoDOFQUoCdZ7Tm9hULX19ZuXe/QSbCav3FA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774668601; c=relaxed/simple;
	bh=xrLAyfb2IjnGy5/+yFpJQusMn22PiglbRcq08RIukVg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N1tWFl1RkZVc0BL9LMs6bZjEhgyOtPeuRTxIG8aEbrMCV/tuIarKks2QCbFKBiWkDse84JWmijdLoI2CQU3AhMQR8+w2mJ59xOCFG829QqBXyc15aaL0Xuj7LTRJ0xHaeNcevtjqDj8py5GGeAmzaudJzuAgaLVBp4K6V24RQbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KgfoPf2C; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KgfoPf2C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5564C19424;
	Sat, 28 Mar 2026 03:29:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774668600;
	bh=xrLAyfb2IjnGy5/+yFpJQusMn22PiglbRcq08RIukVg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KgfoPf2CnUXWgv9bUL6W24xmPdXwAUWzOyCSLSl/nrPHQ4AhiFHV0tveUHpA7aUwD
	 0MjYGg0xVLYKELh0qPTInEXqB+Aa1Peh32wEyYL64Mhh1XLV88EDkHBNmJQgKDLS4d
	 cYbaeHxpUe1JHj6dIWfXege+M+M1yySl1VhKxmXd0Xis8NmLlNt0+sXcs3AGVKnzpG
	 CKD1wHocxThxcT11F0Yaw9cXHVVEiQlh/wqpzwiy73TdlJTftc5EEzAo6aXIh+rYcZ
	 aeorVUZPx9VN38FgiH7GWp4h+/X6Ay5i+DAO9rttw2BQ1cmoLbuKHydd9Xy4lxrSAL
	 tibimx/rSiIig==
Date: Fri, 27 Mar 2026 20:29:58 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Dimitri Daskalakis <dimitri.daskalakis1@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>, Alexander Duyck
 <alexanderduyck@fb.com>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, Simon Horman
 <horms@kernel.org>, Mike Marciniszyn <mike.marciniszyn@gmail.com>, Lee
 Trager <lee@trager.us>, Jacob Keller <jacob.e.keller@intel.com>, Mohsin
 Bashir <mohsin.bashr@gmail.com>, Mina Almasry <almasrymina@google.com>,
 netdev@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH net 0/2] Fix page fragment handling when PAGE_SIZE > 4K
Message-ID: <20260327202958.53d26d46@kernel.org>
In-Reply-To: <20260324195123.3486219-1-dimitri.daskalakis1@gmail.com>
References: <20260324195123.3486219-1-dimitri.daskalakis1@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 24 Mar 2026 12:51:21 -0700 Dimitri Daskalakis wrote:
> FBNIC operates on fixed size descriptors (4K). When the OS supports pages
> larger than 4K, we fragment the page across multiple descriptors.
> 
> While performance testing, I found several issues with our page fragment
> handling, resulting in low throughput and potential RX stalls.

Google AI reviewer points out that we will also be toast if someone
configures the ring size to just 16 descriptors. Can you check what
is the min size that doesn't wedge w/ 64kB pages and let's just set
the min to that instead of the current 16?
