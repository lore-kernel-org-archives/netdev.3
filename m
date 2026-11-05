Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793922049;
	b=m5SR4QmUYEoY8Bhbv6dCw2NAfQhQY2y9h1cv53hu3m96DPknkoJiV0BGbxLl20WUvlM6
	 3MbOciLMThwMWQ7Y86S8eCwuPUUUomNaPtxjwU0aDUZ+Y98OGTKBqcOFf59r1NJRm61U/
	 T19mMkiJZ7espGd7UPlVMfgwgcLxTCkfXDYzoxeYL9dBrsf7Etmq+rYUWmFDsNyeEjwn4
	 yCsYEUyw1hqzxjhmzeN+nBCpOqn0SQIUH9PGqfvXoqnZCu6z8gk5lvq5q6QJbzTeOUSOt
	 yKDTIdV1yHXfWT/Wq/l4XpFRNEX7FILa1ZXLCtWfkCsKKh0nyFHVP4ILpJET2xf4JHg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793922049;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=DALcyRp0vjX3To2DbsLGpJo7XYxiod9b2pPkFTmQfLk=;
	b=kzcbwWAoJDcbCtY2Y0W8j+rkXY4+CtLVXvcFcT9rGHiVQew43JoD3kjF2TEXWeRBHgtW
	 VSRa5S5OZ/JLTm0G9hrDN1IlRPWIat3CSMNJgJbxorPkd0CC2Sv6bKSx7kOjEk9DcxZ0w
	 4HSSLXKLQuPLSsBWPU8hEo9/pJOm4aLtvtkWDTZ3yovw8lVjZcrd7kvIKX8Nq9wkFsQnR
	 LltxHyPyrP8ISGDfkcpy9C/dQVqSAaPObF8fBh6U0QkZcwzmEaAeCtyPdl6keR/SMCjah
	 MY20klZif3xlaTOvYWRyVCZUi37E6lEzwmVqR93B8C3iNGlfr1kD0xcRVc3K0mWujEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BCm4NjP2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DEED606A31B;
	Thu,  5 Nov 2026 23:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BCm4NjP2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF4A31F0089F;
	Thu,  5 Nov 2026 23:40:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793922048;
	bh=DALcyRp0vjX3To2DbsLGpJo7XYxiod9b2pPkFTmQfLk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=BCm4NjP2zzmaYQx55nDTiQotiZ0+FHR5odVzEn4z99P23s+3u9VzGxonfB4eoH0XA
	 JaF3F08tmQfJK6/YdAkOMkyWnj2v9T5KPud/rUx4E4TG9kMBZE0+A4qYHoIWlzRYsk
	 pYlg00lhrz+D1WXDg+jAanxy3Bodf/rKe8UdAxXevAQVYPDZxNp3TOJzDg2juGV6bS
	 4mwTbwhPXtKAD5OzKhGNKUyM3JW0MM7tIUe7Nkwtzc2BYR+l0piz5q7AspMbKeeKtt
	 XL/i/rnwksQ0EPyJsg4T4nvNjulAUFF3dozdsT33aKtsin6UzrBLNJn09dmFJQmZz1
	 BniPbdkSVVZzw==
Date: Thu, 5 Nov 2026 15:40:47 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Akhila Kavi <akavi@axiado.com>
Cc: Sammai Chakravarthy <schakravarthy@axiado.com>, Prasad Bolisetty
 <pbolisetty@axiado.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Tzu-Hao
 Wei <twei@axiado.com>, Karthikeyan Mitran <kmitran@axiado.com>, Jeremy Kerr
 <jk@codeconstruct.com.au>, Matt Johnston <matt@codeconstruct.com.au>,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 openbmc@lists.ozlabs.org
Subject: Re: [PATCH net-next 0/2] net: mctp: Add MCTP transport for the
 Axiado AX3005 IRoT
Message-ID: <20261105154047.079c5eae@kernel.org>
In-Reply-To: <20261101-mctp-transport-irot-ax3005-v1-0-36ceb822f01e@axiado.com>
References: <20261101-mctp-transport-irot-ax3005-v1-0-36ceb822f01e@axiado.com>
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

On Sun, 01 Nov 2026 06:00:56 -0800 Akhila Kavi wrote:
> The Axiado AX3005 SoC has an integrated root-of-trust (IRoT)
> co-processor next to the application processor. Security protocols such
> as SPDM and PLDM run between the two over MCTP. This series adds a
> transport for that link, so the host side uses ordinary AF_MCTP
> sockets.
> 
> The link is built from two channels of the AX3005 mailbox controller,
> which is already supported (drivers/mailbox/axiado-mailbox.c, in the
> base of this series), and a no-map reserved-memory carve-out. The
> mailbox carries small doorbell and ACK messages. The packets
> themselves go through two windows in the carve-out, one per direction,
> which the IRoT firmware allocates and reports at probe time. Each
> direction has one packet in flight, and every packet is acknowledged
> with a counter.
> 
> Patch 1 adds the devicetree binding and a MAINTAINERS entry.
> Patch 2 adds the driver.

net-next was still closed when you posted this. It only opened after:

https://lore.kernel.org/all/66b35989-9195-4e96-99bb-df383a52aa5d@redhat.com/
