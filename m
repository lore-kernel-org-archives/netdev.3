Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793922701;
	b=tPhPSU8WXS8/tXI5NbDUZvajd5QaSlO17oVCwXAF8IkOenQlRWZEaUuAJVLMzIdSEbYU
	 ekyk+Wb0C8qkqNSw5pq3iqDfGfs5qkKo5ZgDWb9HrlpjJ09J+RDkvsKB1ilXlGAeZ+MBw
	 VIrnpzaS0LNmUK6dZrxNhbqUsNqxEycvL50WczQ7fYgsFqhSpFezW0x0+gNSlmjFeIfYm
	 eB+oVeJUxAJLjVW/PKjW6x2J/xcrIXfv/Yr2YwKipN4XGYHUoG1OIOKFOXBKV/kG57HM9
	 8u5Raaz0zpbc37+ednhWQyf8nrILXwtXMSbWeD5EWm2M7K53RCyvNa1UVxmlBDeoVvw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793922701;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=g44mK+plD5sYiMjqWHGKE0hvOEMuE0Ig6tN159VgK2Y=;
	b=iMJop7sl4hjcdP4FmR+syrS9ZdhbOaD5Wg5N5gMElptdounqd0mA8DEFcrEnt0G+fT2j
	 D0PB+PnRgc+jhqZHo+cqRMMovnuDTace9fYgE3KB2YB0eFx017RF10Hd+SGx1Vghp7Qft
	 lCKpDCGy12szWgcvzFyCMvM57yBCtDhEC4FmSVC6I0M3a1n7aQ5UTa29s5zgWcBM5l6Nj
	 TrBUS7yfC5M7wHFe2gJhWRLNggcLbQrvUmkvA+uiBthpTxKNFJTHO8fNwUAicYn9LReu5
	 xXYgyI6ebgUNhPth9R4l0aiLLb+LgX6YHpqEpOhdQlNmm//JtDsrfeXy9nw7iul+02Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J74h6aqt;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD3F7606A31B;
	Thu,  5 Nov 2026 23:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J74h6aqt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C5221F008A1;
	Thu,  5 Nov 2026 23:51:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793922700;
	bh=g44mK+plD5sYiMjqWHGKE0hvOEMuE0Ig6tN159VgK2Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=J74h6aqt77ckp9L2LmmNSQUfJsgjBxoloBMHSwaGAHb57seS29WM5BV+GE6SJiHin
	 hyB+oJqLX8I4stQncSFMWiYI93Vk1PW1KeKO4vvgN80JOz3Di+f394xnlMSqIIwfUq
	 7DC5P4JOKMQ5AW74UIp0nznn/kHTp8zjt5sp4KP40kYzOFAJt+PiB5a11Rxa4IwHa5
	 1SQ5nqCOcJZCimUG9KZxQvMjeQfMuwcDjlm3fpSTMP9PoxV2nc544a6XNJCzgILp+5
	 6C1DDfq99eOgz9lGWIPv/Gjcq9JSMGsmVDsWbFxOOKnqmVpV6vGgWaFmNNvZFb2UaO
	 4g+Urd41mYM2A==
Date: Thu, 5 Nov 2026 15:51:39 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Sicong Huang <congei42@163.com>
Cc: netdev@vger.kernel.org, ecree.xilinx@gmail.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, pabeni@redhat.com,
 kees@kernel.org, linux-net-drivers@amd.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v3 0/2] sfc: fix use-after-free of aRFS work on ring
 resize
Message-ID: <20261105155139.5a2892f9@kernel.org>
In-Reply-To: <20261031063823.876645-1-congei42@163.com>
References: <20261031063823.876645-1-congei42@163.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 31 Oct 2026 14:38:21 +0800 Sicong Huang wrote:
> No hardware testing or runtime reproduction has been performed.

Please do not submit patches you can't test.
