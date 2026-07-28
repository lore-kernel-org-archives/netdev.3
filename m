Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 369352D3EF2;
	Tue, 28 Jul 2026 01:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785202736; cv=none; b=IwzRLIPcYqLwfCt0CCgBJ99qzb04f+gKr9EGDz+TSIKHpTcI7OQY9nk+Q7JNPEGbIGYkulDGzJvSPPImqncqURiT8x/rYeucc5XZ0zvjeuBE1qUDKqGLjOvEcd32WK8PcHPZ3dBlzFgUq7WPKbMaf8qRKjz5tr3kRsv9u42cxsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785202736; c=relaxed/simple;
	bh=SiWtjA1jZaEsHXQuOl0IJ4NXN329bgscCCGtU6ovL30=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QVwxCDndykFr+PvpYw/ECvP29kSiKOhcUMCsjBYKm9e2axxOGiC8yfhJDX4R6tToF4GB6CB3upJKq1Az5boKAYHcAxqRdl/vZHVBSDBzXNYLiQN6gTEoZ3xGwnpqOn/vzmjEQHvIWVx6baSReCSajC2wXcxKoeqZKMgMPzXZRpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZtmoWLUD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZtmoWLUD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FDFA1F000E9;
	Tue, 28 Jul 2026 01:38:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785202734;
	bh=gDl4uBdxVbV97sfyYMhEsfS6bd+bX5fUxLhSdc+Q3TM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ZtmoWLUDJt8Uq56RkH0PuEKxVU7CtSAt+jgZCnERKv8KXBuRHgnwiDeENJggmQH9h
	 vXsaQNLepFGbR0Bmx6qhVfF8gEV2MpvBSGbv491OyfK/4a3MK/ADHfxyI/0DuJXzDE
	 XPv2p3wRifiHEGmRoGG9daLVRX//NGCFCUnN8lbThNUwYZRz+iT2DsGXnm/X/iIM4i
	 cFaMRyfrPiK2e+6mtzt4iWK6oMsfSkepQsEu0Oaw0M/5IIAelyyFmFH8s0UQpF/iOZ
	 GPrrS7SjNm876jRHGax+RXIb9j4/2xFx06NPgU8HN1R08dT/DXfUhmmRIJ4AhoGkzd
	 YMH6eDWVL1Wew==
Date: Mon, 27 Jul 2026 18:38:53 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Kyle Switch <kyle.switch@motor-comm.com>
Cc: Frank.Sae@motor-comm.com, andrew@lunn.ch, hkallweit1@gmail.com,
 linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 ming.xu@motor-comm.com, xiaolin.xu@motor-comm.com,
 jianmin.wang@motor-comm.com, jie.han@motor-comm.com
Subject: Re: [PATCH net-next v6] net: phy: Add driver for Motorcomm Quad
 2.5GbE phy
Message-ID: <20260727183853.14a543a2@kernel.org>
In-Reply-To: <20260723102112.1155723-1-kyle.switch@motor-comm.com>
References: <20260723102112.1155723-1-kyle.switch@motor-comm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 23 Jul 2026 18:21:12 +0800 Kyle Switch wrote:
> Add a driver for motorcomm yt8824 quad 2.5G ethernet phy, supports
> 2.5G/1000M/100M/10M speed.

Does not apply, please rebase on net-next/main and repost.
-- 
pw-bot: cr
