Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2624032B11C;
	Mon, 14 Sep 2026 05:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789363482; cv=none; b=HMWOMqLurt0aK+leupDJdDyuwWCLRCsuexVl2Xvpv56pSckYQZDHxJy8crE3bJ6VtxKUIKetGiQhShMUdKCaqr+hcATPalRMa6c0+9Ii4U5sMcoLejRX92JwN7Yoy/VuRR+wm8tt2O18d7wxYgCC9m/DErQ8QnhTnMpdbSyO0eU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789363482; c=relaxed/simple;
	bh=IzbMcXq77wl7SCNXE3d7CF2D1JQiUrOVEGdvlMtaGTQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Jdi1j5LIcsmzAPX5w7Bh0tv027zksvWlx/vWE3CNGPlpWklDiBdJNHfFors9UkyZhtmSTqom3PWPXuWQb+at+/nSrFiV/7JPR5xt845faSIiDRKVkpmL6VqS9JQM7yeMxeXyF167q4idZcGc/7EUl8EFu1BwxrTQ9QLdtr7dkBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=zAfPEA2A; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=1EPR5yxA; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="zAfPEA2A";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="1EPR5yxA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1789362911;
	bh=IzbMcXq77wl7SCNXE3d7CF2D1JQiUrOVEGdvlMtaGTQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=zAfPEA2AnKOKb5ZNIGNc3S3d1FpomTiGn5RredNPVq9VQxgo+4jSZb5b0oMUZ7Fi3
	 YsRbYQgodevmxyRpfnKlIK0xhJqUvzyaKLmEtY9bUa1EoDm71kvzaYrdZd7I02U+fB
	 XSYyjQJ3syRMrK6REvAxa5LBQR8BlQ5Ap9g1RULKbEazr10I3DzVZ5fFFQfFznfGhL
	 eDLUxmtcDf0iDxfnIhbIsb9WDjCo3zgoDynoiqvCuScxJeUi3pHU5K7vEGHJScWxNm
	 CnCMVAnlT2EPt2h6C4tKMyKnlGlmKrhNtsYlJHzUSy7LzhR0vAzReDpowUfWmEf3DK
	 KY/cdyguVyxFg==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id 719713F693; Mon, 14 Sep 2026 05:15:11 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1789362910;
	bh=IzbMcXq77wl7SCNXE3d7CF2D1JQiUrOVEGdvlMtaGTQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=1EPR5yxAuTEcDL3YokL0hDVvjjlRAJhV1gtVzk34cfSuH4l9Hm7FOfiTK7czMKSZa
	 aDYOdBxs+jrfuTw7lpqMZREdJYXTaWzuHNdIf3clseF1OScbDmnZb5bVFzYoh0VfFv
	 /UNb50ecwlo9JE9bVBtUtR2oZPlXvjcJKz4TfCi8itmT6Xdr/oP0RiqoRiKbFH42EV
	 RKcMcOlNje1KGzcqpgADgvoSNfix5jqi376bjjCvw+8JXsUGREwmTYwutq86W6P4bo
	 5YwHWDVhSKUFNehePzo9+UFGWrgJpjA6kwpY2S7dlhPktcrlNYKZBMN+mWfx9H5rtN
	 GetkR2oA/SOJw==
Received: from [192.168.2.233] (unknown [223.86.26.228])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id 579423F693;
	Mon, 14 Sep 2026 05:15:03 +0000 (UTC)
Message-ID: <2eddb9fe-22b3-4fe4-a2ab-e408e4a726e7@birger-koblitz.de>
Date: Mon, 14 Sep 2026 07:14:46 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v10 06/15] ax88179_178a: Add HW support for
 AX179A-based chips
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Russell King <linux@armlinux.org.uk>,
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 linux-usb@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Jianhui Xu <neuromoments@gmail.com>
References: <20260904-ax88179a-v10-0-b5e60eca7690@birger-koblitz.de>
 <20260904-ax88179a-v10-6-b5e60eca7690@birger-koblitz.de>
 <20260910170055.524e3c25@kernel.org>
Content-Language: en-US
From: Birger Koblitz <mail@birger-koblitz.de>
In-Reply-To: <20260910170055.524e3c25@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Thanks for checking the code, Jakub!

On 9/11/26 02:00, Jakub Kicinski wrote:
> Sparse flags a number of warnings here:
> 
> drivers/net/usb/ax88179a_devices.c:509:37: warning: restricted __le16 degrades to integer
> drivers/net/usb/ax88179a_devices.c:678:32: warning: incorrect type in argument 1 (different base types)
> drivers/net/usb/ax88179a_devices.c:678:32:    expected restricted __le64 const [usertype] *p
> drivers/net/usb/ax88179a_devices.c:678:32:    got unsigned long long [usertype] *
> drivers/net/usb/ax88179a_devices.c:705:45: warning: incorrect type in argument 1 (different base types)
> drivers/net/usb/ax88179a_devices.c:705:45:    expected restricted __le64 const [usertype] *p
> drivers/net/usb/ax88179a_devices.c:705:45:    got unsigned long long [usertype] *[assigned] pkt_desc_ptr
> drivers/net/usb/ax88179a_devices.c:801:22: warning: incorrect type in assignment (different base types)
> drivers/net/usb/ax88179a_devices.c:801:22:    expected unsigned long long [usertype]
> drivers/net/usb/ax88179a_devices.c:801:22:    got restricted __le64 [usertype]
These are indeed actual bugs and I will fix them in the next version.

Birger
