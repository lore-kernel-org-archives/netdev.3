Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2CCE32BF24;
	Sat,  1 Aug 2026 06:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785566588; cv=none; b=hTle4A+bsrYwDGqJWY9Kv2gz+WL0mhtOFFcioxJ2/ISCmvi5CW+BiIqdqYAlEr+5nCTWcLnYP8kqa/SQ7vsDsggBroRlnzUBwhmVMnAFU+ppCyZYXeL/B6Vwi0JIVXcrBoy0HkqyIp5fK+9C99Gq0AM/JlU3BS41zvGF6/eC4L0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785566588; c=relaxed/simple;
	bh=osnwDph6MFi26DQIRJSBGI20rTtm56C8CjH0+T3M0zI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y8rb9bV6rMqft9q7jCHKfnFi2kEzDnNjvhgi2A1uMuv29XU/hKUTy+LkpYCEd+nMOCntmBp9qrOcHxdfqNs1eXfGH2b8Ql9BB5O84JSdd6aOmLGzKUxJNvIiSIzts+/eDpBMbiFgh5STPmMNP/0ydgRz/4S0oWnSScu75MbCqNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=QQT66JbS; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=EInCbrWS; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="QQT66JbS";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="EInCbrWS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1785566585;
	bh=osnwDph6MFi26DQIRJSBGI20rTtm56C8CjH0+T3M0zI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=QQT66JbS1OOIrbqUlbxu/Y1UeTOTXDgp5h7dt0Ko2treuTGEqu/N2fEYy0pb+E7zc
	 jeSGs3kdi5OJ20VdlOiH49NyLnWutqoDlZ6GWIcRja4mKdCAF+umlG3XfdRT0UZDTD
	 GpV8TF5jDde1Y/pnuRxPuxlj7HUMdHSFyLSSN8O3w8tCjym0bur6gxjSqmMoW39BJH
	 wHEpZ8TKhvdP3/wL84u65f0QGY6s0+iKBXN72rlfHeePOz3cBXVyZrnyiRtKK9eAap
	 Pl/BpfMLtHL+M7fZHylzhUIvNJ5alVTiMd0HEo+JdvkKp6ONxXk8ie+Q8pMVN/kzXG
	 ynDm3drBEt4nA==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id 097D2494FD; Sat,  1 Aug 2026 06:43:05 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1785566579;
	bh=osnwDph6MFi26DQIRJSBGI20rTtm56C8CjH0+T3M0zI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=EInCbrWSE1bp2lVNDK5f2tnC+ZkD0kVLplD4CufVLiAPYSNhtTzpVdZhIhQFssvex
	 FBm1NOx6GtQk4Oxmawwc+bxgeT8ybUhblCWNugu/4uGh2yR+lE6SluhxUp2jXSLaBK
	 aYtKU+oZ/5ffYq24Zl203JSe7CgXEc8WU2m8/FJiqPh0G4fYoyBrhZrKGQw6050InQ
	 66hI6WtEoi/GvRHLW8ZBL7oYC89bjFhEImZ9DRZWq9Gex2GiX10Obp6YUViMdPalQC
	 4TxjgZWC1/m1XTv5Z85N0sheCezqQGS1MXabRyWZoUHKyMbwFEe1YnEsqKfuNutrNm
	 VAnEpJLdu2nYA==
Received: from [10.99.12.190] (unknown [82.99.30.195])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id 5032C494F6;
	Sat,  1 Aug 2026 06:42:59 +0000 (UTC)
Message-ID: <a4dc8989-1576-4b40-86d8-6ea1ae4ee778@birger-koblitz.de>
Date: Sat, 1 Aug 2026 08:42:56 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 03/12] ax88179_178a: Add HW support for
 AX179A-based chips
To: Andrew Lunn <andrew@lunn.ch>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Russell King <linux@armlinux.org.uk>, Heiner Kallweit
 <hkallweit1@gmail.com>, linux-usb@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Jianhui Xu <neuromoments@gmail.com>
References: <20260731-ax88179a-v4-0-2cf1f71b1dd2@birger-koblitz.de>
 <20260731-ax88179a-v4-3-2cf1f71b1dd2@birger-koblitz.de>
 <3eb5691a-4a84-487e-8d5e-f91a646c03c1@lunn.ch>
From: Birger Koblitz <mail@birger-koblitz.de>
Content-Language: en-US
In-Reply-To: <3eb5691a-4a84-487e-8d5e-f91a646c03c1@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 31/07/2026 21:37, Andrew Lunn wrote:
> 
> Overall, this is looking a lot better.
> I'll answer to the rest in detail once the code is written, but thanks
already, Andrew, for reviewing the code and providing so many helpful suggestions for
improving the code. In in retrospect it was rather immature at the beginning.

Birger
