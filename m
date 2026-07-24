Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EF6B2356BE;
	Fri, 24 Jul 2026 07:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784878761; cv=none; b=InjT+8fovQ6FWmap/KNgzXWh0tzOMvM7yzNXgL/hPJXUpR7NqLtpIURUhEHEglbGqTy6pkfC8eVV9kTmNGivRP5YDZLMX+0RMIvIHjj0Lz/PhNfSuPN7j5oBsR+RJEuT+f/4cnJY7D3tx2NuBd5jxy4+q+XtVSBrA8YMDmZ1cDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784878761; c=relaxed/simple;
	bh=4+h6+0W9hG/bgYe6eIcilzToUKFqL/gs9dulMBIL6wU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZjzpAZ2D+xdymhKtcPkEhncsq/L0NGZOS8Tcgj4VRZ4KWtcJxqh65D1bL8E0mHSfBx8s78jJcMwHtpJUTtwo32lhvpw6jLSoC+JcUQLb0JiabEaNIJl+ld+3ySmPsgwizWLmJVsS0VRwdnrH66Y1ZrdwsEA6HXDiue0thpluFjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=oPCGoZSq; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=v1vQ4sCJ; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="oPCGoZSq";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="v1vQ4sCJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1784878758;
	bh=4+h6+0W9hG/bgYe6eIcilzToUKFqL/gs9dulMBIL6wU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=oPCGoZSqIg2ZxdlPJEv3Od6vX+U6jQPkJ0rOBnAKclBHPL7SQaRyeBbCPzZvj958Z
	 k7TVxZo/V/uOE6K1AqznA4EoN/ht5VUfbLepugH0kpm9GIuDRyK6qHWnyG2CJ33kJI
	 JKx8pD2AyA0Mp0qOFfieiEnJGRCDHKK8AmOmnogLxoZxuqBXKXFOou2ePNo6nsWldx
	 ClrLCSdyVM54nUizaIQ6mU/gJl7XJ3TyCqVQTF1yWvEn5dxjmMgiz0YKTzg5HqgnRW
	 u28RmAKNARmW2f5T0eb2jvUvPAvShym0A5j8xRi5wZgGyjJRvYGeer+bG9YCTsxOhW
	 UKhrZUD4OK19A==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id 53F8949330; Fri, 24 Jul 2026 07:39:18 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1784878757;
	bh=4+h6+0W9hG/bgYe6eIcilzToUKFqL/gs9dulMBIL6wU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=v1vQ4sCJkgyq858wxl1grmPNpOkeg5W2mTrUEYurGvEtHAljtmlupTsAF7zZId3CH
	 7uFjRiTWuPyMqlZ//EHfgo5Ngvmb04AWumGgEhjRMOzvrmUmLU9QEofK63veRoZLy7
	 Lf+fO89SHbw5yz3hlKs4/FwsZhNNcdwXtvb+IeXvTKEpXmuamhoiJh7gKhlJe/LZ4T
	 nVfSq5tSOUW27wL/KTJUxvPSSkldmtkFZmEhJ2/DFpaQ0cU/NmOwzlRSDTvZ/XYDIb
	 4lMqadPKxPqaG3FSuYTzy2VC5MGhCOb9O7Sxjb91SsGYj/x+DMXn3jVSbgyHQ/yhM1
	 X5zK50A5bXvxQ==
Received: from [IPV6:2003:c6:9f1c:3c00:ecd1:8782:4fbc:6faf] (p200300c69f1c3c00ecd187824fbc6faf.dip0.t-ipconnect.de [IPv6:2003:c6:9f1c:3c00:ecd1:8782:4fbc:6faf])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id 88FCA48F41;
	Fri, 24 Jul 2026 07:39:17 +0000 (UTC)
Message-ID: <7f74229e-15a0-4633-9eb2-100fb9cccb91@birger-koblitz.de>
Date: Fri, 24 Jul 2026 09:39:17 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 00/12] ax88179_178a: Add support for
 AX88179A-based chips
To: Jianhui Xu <neuromoments@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 linux-usb@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260708-ax88179a-v2-0-0800fedb2e16@birger-koblitz.de>
 <20260723143420.672680-1-neuromoments@gmail.com>
From: Birger Koblitz <mail@birger-koblitz.de>
Content-Language: en-US
In-Reply-To: <20260723143420.672680-1-neuromoments@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 7/23/26 16:34, Jianhui Xu wrote:
> Hi Birger,
> 
> I tested this series on an ASIX AX88179B adapter (USB 0b95:1790,
> bcdDevice 0x0200, firmware 1.3.0.0).

Hi Jianhui,

thanks so much for testing! It was requested to change the driver to use
phylink and I just sent out a v3 doing that. This changes quite some of
the way the PHYs are configured. If you have time, it would be great if you
could test also that patch-revision.

Thanks,
   Birger
