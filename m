Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A89330D3E8;
	Sat,  1 Aug 2026 05:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785562983; cv=none; b=TWMx/YTwEp+nfzCvCEOMjK5TXAXmXaYXF7f36i7LnxcxWoUA3h90iMhjQ4v7+LmqIPwvpFkaEQoUO5KFxXD8ftB++o9U6tVXwXSr3dLzcohO3ug5cHiNGYm1I/aS1weLvJ9vfX5yyyhzwmuYY/BZamSmdfdK5SrTSasghagHwNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785562983; c=relaxed/simple;
	bh=xBfvEklLLtV6SjOJNggtAcgD9/QTtI4BwgVlPozoUNI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nsEQu+36ZpCXQVR+9OhhdjraWYRPYexUKt2SNSl/RXN7KyQhx4SRfY1h1HknGf3YCerOHCrbCIY/EkuQnEczakjnUtlzYshdn1J30k9I+WyUKpAfyzSTPlJIdiPc8wTcgOQdIJmy5Ul1OFxQ9cjuAU2XRmUgrpVPMoUPyKolY80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=qlueqOQg; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=qlueqOQg; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="qlueqOQg";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="qlueqOQg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1785562979;
	bh=xBfvEklLLtV6SjOJNggtAcgD9/QTtI4BwgVlPozoUNI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=qlueqOQgcYi6zQJiivXe3oTv39nMj4IZ8pdSmhxAC8O6hMapacw5hywPU2CPEkKpc
	 Sbdgr6p50uZjDUkZEWEuF/OX9Fjd9Pap2LVt8vGWNQP9HAS4mQtpDCxlwIuzqCc6NH
	 YjGep8cW3MBCSC6tq2fLjYg4prRwFy294gdkYISmFoACxcxGhipyrU+OZF+TDtgBLu
	 XdTXS0eQHpxUf0D/IXYmoK16Y37lHOgFAd8brE39Id8jj2hEoWC4uxVnEOWN+wzTSF
	 KRq4Q+aTjEkHySNbiZxvlT0m8Jz8Qbwo/TAXgpS9JE4kFn2UtoUXJv18Nn2hIr+92S
	 +gImWpfOdT7XQ==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id DC35C494FE; Sat,  1 Aug 2026 05:42:59 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1785562979;
	bh=xBfvEklLLtV6SjOJNggtAcgD9/QTtI4BwgVlPozoUNI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=qlueqOQgcYi6zQJiivXe3oTv39nMj4IZ8pdSmhxAC8O6hMapacw5hywPU2CPEkKpc
	 Sbdgr6p50uZjDUkZEWEuF/OX9Fjd9Pap2LVt8vGWNQP9HAS4mQtpDCxlwIuzqCc6NH
	 YjGep8cW3MBCSC6tq2fLjYg4prRwFy294gdkYISmFoACxcxGhipyrU+OZF+TDtgBLu
	 XdTXS0eQHpxUf0D/IXYmoK16Y37lHOgFAd8brE39Id8jj2hEoWC4uxVnEOWN+wzTSF
	 KRq4Q+aTjEkHySNbiZxvlT0m8Jz8Qbwo/TAXgpS9JE4kFn2UtoUXJv18Nn2hIr+92S
	 +gImWpfOdT7XQ==
Received: from [10.99.12.190] (unknown [82.99.30.195])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id C4E6C48E50;
	Sat,  1 Aug 2026 05:42:58 +0000 (UTC)
Message-ID: <f6c946ef-3adc-4410-b62c-5f8fff8862d1@birger-koblitz.de>
Date: Sat, 1 Aug 2026 07:42:57 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 00/12] ax88179_178a: Add support for
 AX88179A-based chips
To: Jianhui Xu <neuromoments@gmail.com>
Cc: andrew+netdev@lunn.ch, andrew@lunn.ch, davem@davemloft.net,
 edumazet@google.com, hkallweit1@gmail.com, kuba@kernel.org,
 linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
 linux@armlinux.org.uk, netdev@vger.kernel.org, pabeni@redhat.com
References: <20260731-ax88179a-v4-0-2cf1f71b1dd2@birger-koblitz.de>
 <20260801035941.3307404-1-neuromoments@gmail.com>
From: Birger Koblitz <mail@birger-koblitz.de>
Content-Language: en-US
In-Reply-To: <20260801035941.3307404-1-neuromoments@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 01/08/2026 05:59, Jianhui Xu wrote:
> Hi Birger,
> 
> I tested v4 on an ASIX AX88179B adapter (USB 0b95:1790,
> bcdDevice 0x0200, firmware 1.3.0.0). And it worked smoothly.
> 
> I applied the series on top of net-next commit
> df13c1df8147675470213ffff29dd5762fa321f5 and tested the resulting
> 7.2.0-rc3 kernel in a KVM Debian guest with the adapter passed through via
> an emulated XHCI controller.
> 
> The driver automatically selected USB configuration 1 and bound as
> ax88179. The MDIO path bound the "Asix Electronics AX88179A" PHY driver
> (MDIO device ID 0x003b179a), and phylink reported 1000 Mb/s, full duplex,
> autonegotiation enabled, and link detected. Driver information and read-only
> EEPROM access also worked.
> 
> DHCP and interface-bound pings worked, and bidirectional iperf3 completed.
> I also tested EEE disable/enable, pause enable/restore, module unload/reload,
> ACPI S3 suspend/resume, and QEMU USB detach/reattach. Each recovery test
> restored the PHY binding, carrier, DHCP, 1000/full reporting, and traffic.
> I saw no AX88179/PHY/phylink warning, oops, call trace, or traffic timeout.
> 
> Tested-by: Jianhui Xu <neuromoments@gmail.com>
>
Thanks so much for testing, Jianhui! I know this must have
been quite a lot of work.

Birger

