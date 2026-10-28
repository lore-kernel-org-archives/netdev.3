Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793229345;
	b=mGMY36CfBfb0YH4XA8PWzftNtPrvLe3VYbFytjbpnhH5SimIy26v1rujd8C/jQSHZ6tZ
	 Q2NeK1PvX8L3LTGaOG1oVLCBvyaLjyPlFGeV3GNwhGO2l7gC5ZJk5MTDjUHS0yK6cWVKc
	 oWNe5beJJn6vTDrlIfC53Is+ZixK58OfTLObgrEWKm9297pE2TdHDI/ZoBxdtFZmLXA8Y
	 wbfWfL+156KPiBLk82qbLctYb1iGHdhfetDb3M8iDPkbSZIXDs5jyU1hwaytSl5T4MOGe
	 YD0GoXEPs6l3UbLJMVl2AZBqChaAajwtocnxeobBYkPj305zM3LpT1mG2Gf0jlGLSDw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793229345;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=4H51EEZYUB8it4zk+eyiOGR8tcr7HTYZIsqAE4gLce0=;
	b=XgKNAkzdp9H00l1i+n0h5gOag4VLjfXS1xgdNmQEA7Ktugp2aJ9enWNb1C2KCPt/Zol7
	 cIoifJF2ts2Bc3O/mUhfsnYrn1+UWwg5m5McUPJyTnPhYrw8hYPbNaD0DF5GQu0EUU1s5
	 +9qxJzmcZzEyNAXeC2hsNn3K3N9ls10gxZIIrhyQzdfLLtrzrN34Cl6x9VEQ/x5lVS3Hh
	 vA/vB14Bm22BtirVgQE1PSIZnM9NXQjy4B0Wm/PdYmF5fssL3K/RTt9llmayI6BPL8mWy
	 xgy/L4//sJjSAmQA3Lvm+XsBNjUwQG2KC6sBNnxXDxuV2J7DyJb2uXSg6vmHRHi7Z9w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="j/kH8taw";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D799C606A31A
	for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 23:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j/kH8taw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 606DB1F01825;
	Wed, 28 Oct 2026 23:15:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793229344;
	bh=4H51EEZYUB8it4zk+eyiOGR8tcr7HTYZIsqAE4gLce0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=j/kH8tawgUjq+7S4Jc5LTcr3awVlvis8IoOFuBOQE/2tJN8e1tbbzdolXAH01Gxf3
	 FOAb4jFi3r1q1SoxdYOi3He/HTJPO4sLZC2z0RPvXgxTwXWVs8iYnB4Rwj4BYHGTpF
	 1SaSbpnC8VhvAlSR3hg6KraGViV6s95OdPbON7zKWZuV/FYyFUFH8x0nxKEBsGOn4A
	 EIctQ6jIhrh4T0HnHu1tXuQmrESJL/rL2cQfDfVp9NTf+7iIExO/RhMenUCYt9wrvU
	 ouuFEp+TM8XLu6tg0gVVbJ+wVc765U96enTk3QH1uZ0b4XuFTOb9fvih6ll3FOzgLQ
	 pgg7eNOyMHBqg==
Date: Wed, 28 Oct 2026 16:15:43 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Rishikesh Jethwani <rjethwani@purestorage.com>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH net v2 0/4] tls: device: fix RX record start tracking
 after strparser rework
Message-ID: <20261028161543.662fd94d@kernel.org>
In-Reply-To: <20261022221732.1397620-1-rjethwani@purestorage.com>
References: <20261022221732.1397620-1-rjethwani@purestorage.com>
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

On Thu, 22 Oct 2026 16:14:56 -0600 Rishikesh Jethwani wrote:
> Subject: [PATCH net v2 0/4] tls: device: fix RX record start tracking after strparser rework

let's defer all these until we have the selftest in place and can start
adding test cases alongside the fixes..
-- 
pw-bot: defer
