Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794509497;
	b=wA79TvOBB/yvfTXpwk+Idzrdxgfm87qjkoUPzXqO3/cwJ9tDEf0fGmMsdW1DdjR5WPDl
	 2HoSFQ+sqiR7rZZregcpU48iYV7vK4CNH8QDCpW+cBEE0DSV0wnLGSLvLOqALK8QQpZ08
	 laxBrXnVG/AZHcvIDSJIfkKgIwHFDAUePSp6+GD8AaHcmT4IOhF/FvKB+dYdn3Rxe3h3Y
	 s3V4WcmlpUwt2TwmzOClGN8jKMqsX4QI7+6/66kCv2YvzCmR0QAYwhKwsuX7iA65TlTei
	 XTMF3O95lNp9EWuvosyBSuKj4ycXPQKQjtPpPuuFFCI4Qnu2pWygIO2mB0RdR5qiXqA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794509497;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=aLRVzX9PeR6FBcLdIwkKfybHt+7DSHy/1JXxytp7nMk=;
	b=SBRSXzsOWcNCun4XvQdHQkEdNKf52Rn9y85YeeK6kL+ma2TUnplWl+4rD17BOXRfbEMe
	 xIXVyq6VvMJ+jswuigd/W6yiFuFp7ggthd8s/8TJ+DaGlgbPGZXGzssQd1qwuhAUp7XX9
	 f2xebsKf7demN0VvKg3/8mTpKsfI3EFKZf1jQfDanF9J+nMiKew6qOzCQmwYaBdqjcvDN
	 x5STddb2FkemN6698wDOyP1Def05Wk95qzOsCMXelGFEWQ/GGm+tWmsOMIAUWgxbD4VT4
	 n7hUk3dfKhFmlDpo7d32hVAH/BmqQHKjKxKTL3rpA63Ik7Vf3x8sbLGfGtnVhswxuOg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iPGsyGW0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 508D3606A321;
	Thu, 12 Nov 2026 18:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iPGsyGW0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 910C91F000C4;
	Thu, 12 Nov 2026 18:51:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794509496;
	bh=aLRVzX9PeR6FBcLdIwkKfybHt+7DSHy/1JXxytp7nMk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=iPGsyGW0FzALvLPVM4S03MqKJupGbazdpkeJWLFpl/0uwFEjMWjQ5nFh0+QUNIYZc
	 vQmqfmK2HSmgIZ4But0Vdox9O7JafcGWzt1g0tZlvuDsHTfEgvy+GKGwNSMMEBypov
	 WqMMpqCgPQaIebkTnuiGU418i4YtRDCli8Iaik0F+aBVOwgfvI78FPeGOX5BmW4Tr6
	 S37nesjVwzJilcWjWKVi8yNRYrFQHjH+OpEHTaUdGLiwCCa1SxEnigkqAoPHvtbUVJ
	 qFCAcPBln3LvJsvB4tcrYE9iu+Kd91J1ZVCbKU/N5Y9FAEO/lOD3Glbx9T58KP8C1X
	 mB896DRxoP1lw==
Date: Thu, 12 Nov 2026 10:51:35 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Wenbo Sun <sunwenbo@cmss.chinamobile.com>
Cc: Taehee Yoo <ap420073@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 1342116488@qq.com
Subject: Re: [PATCH net] amt: handle all upper amt devices in
 amt_device_event()
Message-ID: <20261112105135.1ee728e4@kernel.org>
In-Reply-To: <20261111061535.189769-1-sunwenbo@cmss.chinamobile.com>
References: <20261111061535.189769-1-sunwenbo@cmss.chinamobile.com>
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

On Wed, 11 Nov 2026 14:15:35 +0800 Wenbo Sun wrote:
> When multiple AMT interfaces are created over the same lower stream
> device, each AMT interface links to the stream device as an upper
> device and takes a reference to it via dev_get_by_index().

commit 7262e999ebe already fixed this


