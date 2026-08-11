Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58AAA4B0493;
	Tue, 11 Aug 2026 00:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786408766; cv=none; b=js8i5yHS5Q+FbWoMvHY/+MfDMnHJxAYMC91z9rpLx3s88CVHbpxS951G1+bSWpUWR/xeV0c1LLmDwpblD66C8rCAShFXlPb48oBCPN+WPBaUo75wqqimQuGnFZUwU+flGET01Dw76jxpNw80SW+E+917LUWfbv9Oc8JSNi98m8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786408766; c=relaxed/simple;
	bh=WJfVHrN6dSCqRqPYkcZSVOQ0NuJQSPIIHppQMgWv7Qo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=otMIGPV3Lc/PSqWY+uuSNb3ehTMSu4L+KV7sbKwRTxTdGx8Z/ZUY4CaABnhODtQSDcGD3VL/jm74sNXLTgz1gfipjp8VHxFpo/HXyHqpqRkCXS6oXbOzr1o7npfP/ZzRlZC+aGv9rFLaMgAY01ps6oxuuoE04C6LilYPizTuZ8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NHplWlIC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NHplWlIC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA2D01F00A3A;
	Tue, 11 Aug 2026 00:39:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786408765;
	bh=j0LuaOmYih7KADP4bGXK7lsGfmEuqKGcz2ae+w/zhZc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=NHplWlICYIawCusVnwNt7Yqe4ZZpp49bIcX0h29PGET2M64kcWY5qmuMat+3kMg5q
	 VCVDAUxLiU8l+MRHG/+bbl97Z24ngiS0IHy+5FKxZZRYxUBe46SKuC7J4Y1LT7kCIy
	 X+6igqsLUr1a8xO/WV+WsR2PMqHZQzTsbH3cwDIusXoSoJcI/EOdBdIzO9QkODn7G7
	 rCouqVRdRo+YO8eEMO+1Yw6u0j+/ShU31/JJ02k+Y1/+rb+fiUdTriCN9tsHee74YH
	 mRgIBbbON9GS2S09hbfv/wHk5yr5SgxRYiopvRNpJAhNfmTEb9bEB9R/SQKvnfx9I9
	 9kdvMJJ1lG9iw==
Date: Mon, 10 Aug 2026 17:39:24 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Qing Ming <a0yami@mailbox.org>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>, Harald Welte
 <laforge@gnumonks.org>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 osmocom-net-gprs@lists.osmocom.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] gtp: serialize PDP context updates
Message-ID: <20260810173924.1ddcec0a@kernel.org>
In-Reply-To: <20260808124322.5800-1-a0yami@mailbox.org>
References: <20260806023226.5537-1-a0yami@mailbox.org>
	<20260808124322.5800-1-a0yami@mailbox.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat,  8 Aug 2026 20:43:22 +0800 Qing Ming wrote:
> Subject: [PATCH net v2] gtp: serialize PDP context updates

This patch does not apply to net/main, please rebase and repost.
