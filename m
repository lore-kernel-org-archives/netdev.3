Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6945B1DE8BB;
	Fri, 11 Sep 2026 00:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789084857; cv=none; b=FlvkNket6AOUKnCh35C4rRMq8UK8koeSqd1OJ001QnHrSRg/ClPSYGBGSKKcbjf37myh5wSq2/NjdSMH0KZjFZqRTYj+6uW/fkQUncGNRCkDyP0wORX9ydzR0gQ6HtamYxEeyVRFaoy4XynVodSo3dwSr5rVyMzQiazSOg8CiPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789084857; c=relaxed/simple;
	bh=+++Gnx74GDHyJaLD0mDK+OgvkkvvYr4DyC9BTQmYWZw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i/lNvRHLMjAmVpiW9zLRHH7MGml8zZgj0aVx73I9wg4e2p6V0NyVTvYM6k7sYzMdkRMYYuJa6sy22SQ7yLjwvIZ7uX8pfbk1AznkeRGpXcSInZFjnBH5vqHaghckWF+22ls6Rq+uw4l20JSf6LlYLrjwChZYzeMbAf7X0OBXJ40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bTOXOBLQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bTOXOBLQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7E481F000FF;
	Fri, 11 Sep 2026 00:00:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789084856;
	bh=cDgYJiIAnnSc8Yv7U51j2zcro3TveNqWXT5+k6oZ0Rw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=bTOXOBLQC1SNtv+Xe/2wMIO8rNq4+VIW/3NHPJgjRdkl/Bttqo8jZkRn8DNjx0no3
	 wTvbuJoSOcsk0Mlsi3efPPd8KeOJxlfO/navz2/Bn1eH+JFCyULyAhfeTKzdD/yWI4
	 UAzVEB6gIfVclX6YIsBYIXqRWUwt8pvvJtkrR/I76NAOwJnFb2jxzKAZqY8t9X1WVK
	 83D2KOZwRU6lbr/HeBFA4AHCDOTcEF80jNZiv2wleWI9A+1x9Sz3BiKbKE0iKAzFUe
	 iJEwdRd57gq+Qig2/rqEI/Yf3dl+uAVavW1a39Jxmbhz2iPLQZqZpbkpHfhDQHIaqB
	 9NiH0ulckxOOA==
Date: Thu, 10 Sep 2026 17:00:55 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Birger Koblitz <mail@birger-koblitz.de>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Russell King <linux@armlinux.org.uk>, Andrew Lunn
 <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 linux-usb@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Jianhui Xu <neuromoments@gmail.com>
Subject: Re: [PATCH net-next v10 06/15] ax88179_178a: Add HW support for
 AX179A-based chips
Message-ID: <20260910170055.524e3c25@kernel.org>
In-Reply-To: <20260904-ax88179a-v10-6-b5e60eca7690@birger-koblitz.de>
References: <20260904-ax88179a-v10-0-b5e60eca7690@birger-koblitz.de>
	<20260904-ax88179a-v10-6-b5e60eca7690@birger-koblitz.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 04 Sep 2026 19:28:31 +0200 Birger Koblitz wrote:
> This adds bindings and HW support for AX179A-based USB-Ethernet
> controllers. The AX179A-family of chips consists of the
> AX88279 (2.5GBit PHY)
> AX88179A/B (1GBit PHY, B variant has wider temperature range)
> AX772D/E (100Mbit PHY)

Sparse flags a number of warnings here:

drivers/net/usb/ax88179a_devices.c:509:37: warning: restricted __le16 degrades to integer
drivers/net/usb/ax88179a_devices.c:678:32: warning: incorrect type in argument 1 (different base types)
drivers/net/usb/ax88179a_devices.c:678:32:    expected restricted __le64 const [usertype] *p
drivers/net/usb/ax88179a_devices.c:678:32:    got unsigned long long [usertype] *
drivers/net/usb/ax88179a_devices.c:705:45: warning: incorrect type in argument 1 (different base types)
drivers/net/usb/ax88179a_devices.c:705:45:    expected restricted __le64 const [usertype] *p
drivers/net/usb/ax88179a_devices.c:705:45:    got unsigned long long [usertype] *[assigned] pkt_desc_ptr
drivers/net/usb/ax88179a_devices.c:801:22: warning: incorrect type in assignment (different base types)
drivers/net/usb/ax88179a_devices.c:801:22:    expected unsigned long long [usertype]
drivers/net/usb/ax88179a_devices.c:801:22:    got restricted __le64 [usertype]
-- 
pw-bot: cr
