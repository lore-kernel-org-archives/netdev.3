Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 643AC229B38
	for <netdev@vger.kernel.org>; Fri,  2 Oct 2026 01:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790905470; cv=none; b=YTuBg52Es1s3KhKJubWOCjKKML0JoErNb6EdEWiEIYC2d4/DPaQmc0PflYRjSaPkVGU+HpeukDqRBGxyKrn9slxpf7MLLQAC4y0JjH5ZTzrH/JS7K1KFvCBL37kof1zz9N6XO/2BdNM3xyp7A0t33DSWAta2X/FgczVwO+J1z2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790905470; c=relaxed/simple;
	bh=wrvl+qgxuJuhv8ghG8yha8nJ1jMPGwC+/GIWppoFQ4E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uKM1WwI+rMiV5YZT6FzzirvjPxRdpLYvOjWFpWLmTPdgzB4lWfWNan3SpBr9917izK+YfGncaqwEEXsxJnOq1KfMGB1QJQ10dzWw7iihv/Xc5EKid+7Tl1nVTQ8DNx4buyGLvKT9xY7G5HUy/vLjPrjiRt7KxH+uNopBjBbf+sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MpsjJ/uJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MpsjJ/uJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F5141F000FF;
	Fri,  2 Oct 2026 01:44:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790905469;
	bh=6CZg0NIaw6TyqOrcwIooSuI//dsc82GM6p5KZQLeZ+g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=MpsjJ/uJmPrrPrleuY+4z95AtPlLRjHSC78pgkcFhFyyT4hwxhCPbQFKUkllAtLyY
	 J2b8jxULjpH20uRcuNUJgCb93M5jaARTMUQf4rBojBnDZDRKtgh7GSTTt+2cNos7pg
	 mUGEkP4zZ2IyKWDFQWfVSThaYvM6I3cokwB4aBsqd/igWrM6+5rvHwfS3caz4nitdD
	 uhNqlxL9ldrRgOuTTcnFc0HGTWl/xUvKmOwtTqFluO0Jv1PoSuMAMWBR7SA/9gNHyF
	 ujMire6iW2tSCHMe3RF+Q+vuDfsxtazOuVA/9pkbne1/+9bijvynqQETazeWM7Jyc5
	 NNPMqSi5lUmGA==
Date: Thu, 1 Oct 2026 18:44:27 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: netdev@vger.kernel.org, "(JC), Jayachandran" <j-rameshbabu@ti.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Chintan Vankar <c-vankar@ti.com>,
 Danish Anwar <danishanwar@ti.com>, Daolin Qiu <d-qiu@ti.com>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Felix
 Maurer <fmaurer@redhat.com>, Neelima Muralidharan <neelima@ti.com>, Paolo
 Abeni <pabeni@redhat.com>, Praneeth Bajjuri <praneeth@ti.com>, Pratheesh
 Gangadhar TK <pratheesh@ti.com>, Richard Cochran
 <richardcochran@gmail.com>, Simon Horman <horms@kernel.org>, Vignesh
 Raghavendra <vigneshr@ti.com>, Willem de Bruijn
 <willemdebruijn.kernel@gmail.com>
Subject: Re: [PATCH net-next v7 3/8] hsr: Add a magic header for sending PTP
 packets
Message-ID: <20261001184427.4060c29e@kernel.org>
In-Reply-To: <20260928-hsr_ptp-v7-3-d55d304d9a7e@linutronix.de>
References: <20260928-hsr_ptp-v7-0-d55d304d9a7e@linutronix.de>
	<20260928-hsr_ptp-v7-3-d55d304d9a7e@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 28 Sep 2026 14:39:37 +0200 Sebastian Andrzej Siewior wrote:
> Sending PTP packets (ETH_P_1588) via the HSR stack is pointless in its
> current shape because the requested PTP timestamp is not routed to the
> sender. It also needs to be distinguished on which port the message
> should be sent and whether or not a HSR header should be attached.
> 
> To pass this information, a custom header (struct hsr_inline_header) is
> introduced. This header is expected and mandatory if the ether type is
> ETH_P_1588. To avoid any wrong usage, there is a magic field to ensure
> it really is the header.
> 
> The inline header is just prepended containing the port and header
> parameter. After the header, a regular packet follows. It is ensured that
> the inline header and the following ethernet or HSR header is linear
> and can be accessed.
> 
> The two retrieved parameters are passed to hsr_forward_skb() and will be
> used later.
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

breaks build (admittedly in a weird way, some header check thing?):

In file included from <built-in>:1:
./usr/include/linux/hsr_ptp.h:10:2: error: unknown type name 'uint8_t'
   10 |         uint8_t tx_port;
      |         ^
./usr/include/linux/hsr_ptp.h:11:2: error: unknown type name 'uint8_t'
   11 |         uint8_t hsr_hdr;
      |         ^
./usr/include/linux/hsr_ptp.h:12:2: error: unknown type name 'uint8_t'
   12 |         uint8_t __pad0[4];
      |         ^
./usr/include/linux/hsr_ptp.h:13:2: error: unknown type name '__be32'
   13 |         __be32 magic;
      |         ^
./usr/include/linux/hsr_ptp.h:14:2: error: unknown type name 'uint8_t'
   14 |         uint8_t __pad1[2];
      |         ^
./usr/include/linux/hsr_ptp.h:15:2: error: unknown type name '__be16'
   15 |         __be16 eth_type;
      |         ^
-- 
pw-bot: cr
