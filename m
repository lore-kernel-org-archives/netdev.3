Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66FB41C32FF;
	Fri, 30 Jan 2026 04:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769746642; cv=none; b=nAYvUxfFfinmqlf5Ai8LNRaJK32/10sPWHDwI7/Cd9nffK+mitn77+zcvZ+e8ykTDGYGlXbYk1ffssuW2pqdHghk85aIYA+PvgVdNuBct6KkczkFV74YhrazigcMakD9uS7NxxVsN6AXiUfY8Fxs642epfGvA7uynYMwdCOewjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769746642; c=relaxed/simple;
	bh=Y6LjcF5R3pXVrTlcVL2++4gcBbUe0OMuA+W09Q96gJA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TX6kXVn3A86btaTkXOvv1deJ+ji8rKS+7DA5jWmCxp2P9pHvIukofX2pXkn0gemdQfxx5c1+7RMZU/VsbSOrSYvIZxeAau0BQZ2h9knpl47BLjfhpyxuYoHi5ab9lELphPz5qSndOrfyQK/y8vIjcDpQ/Nt36/sJqdDICuKgA3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fz1uy1Sa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fz1uy1Sa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06D07C4CEF7;
	Fri, 30 Jan 2026 04:17:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769746641;
	bh=Y6LjcF5R3pXVrTlcVL2++4gcBbUe0OMuA+W09Q96gJA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Fz1uy1Sa/pMHa1dpvAA2l3PPLVMGtRMEP3TKbEiuetSsIPZlYv5q9CK7cK+mR5szl
	 qOFSgpBCSXLeARaJzuoCUXBHZYWfkQGIbTTNcTEONCLZlq6yls4MPTc4C8Vkms/GFZ
	 dTpsh2vPgn6BLGteQPYEhpolVDxbKjE5WcwnTfrS3x7LK0V2gRjDxnQ3/w8c+gQ1cW
	 skBxU4CxTr4KfgMuZDBLLQ/Tr8Y9nrf01wEHLmGYnkfbc460aD7Q/Smsi4OV96l9e4
	 J01pDCWhDHcGjxbOGKdDKpiVyUgsl8F+wZwOhstQHwj34y7n2LK4CBjkBE+/pnRhqs
	 U67xRhUnqmV/g==
Date: Thu, 29 Jan 2026 20:17:20 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
Cc: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com,
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>,
 Simon Horman <horms@kernel.org>, Pascal Eberhard <pascal.eberhard@se.com>,
 =?UTF-8?B?TWlxdcOobA==?= Raynal <miquel.raynal@bootlin.com>, Thomas
 Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v4 6/8] net: dsa: microchip: Enable Ethernet
 PTP detection
Message-ID: <20260129201720.0a63447b@kernel.org>
In-Reply-To: <20260127-ksz8463-ptp-v4-6-652e021aae86@bootlin.com>
References: <20260127-ksz8463-ptp-v4-0-652e021aae86@bootlin.com>
	<20260127-ksz8463-ptp-v4-6-652e021aae86@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 27 Jan 2026 10:06:48 +0100 Bastien Curutchet (Schneider
Electric) wrote:
> KSZ8463 needs to enable the Ethernet PTP detection to fire the
> interrupts when a timestamp is captured.

Is it worth stating our expectation WRT other switches given this 
is a shared function (not advocating to add a condition to be clear,
just document).
