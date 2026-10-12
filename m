Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D7B1442FCD;
	Mon, 12 Oct 2026 10:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791799327; cv=none; b=Z40TrUSF0nePwYrxNBID4dj7X2LEbRKp3RC0WDV5bAgVosX7EntUhNR9jsXtcQ3CIxNFAfbIbkzAa1Q85UDjCtfdlPLeShipLJum8thxA5KJq+fkOpBl9l8tcRYvKMTPWT36QSo6ABi6k+KgkLpT4aNd19IgqJ1INltMvnFbGYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791799327; c=relaxed/simple;
	bh=0pyzztU0NngLfC81+czlzcRfIB90PorUF3VMb7LsUPQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OCdOq8FAKjoDy+BErKRJBU0OjQeyEhfuP5bqkaIEU2+gvZsi0drt1LAyXzqvvPd1uOxSbqRksbpQKATQqXhema/WYS5/IazyklsLIdWZaKLm5kzwJAKP14dDzL4X5sVym7UIkgKeRR/QH8IJH4PQqAzDPd4HtEea8hP5bMH9rYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=EZcingkA; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=tPN1omDS; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="EZcingkA";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="tPN1omDS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1791799314;
	bh=0pyzztU0NngLfC81+czlzcRfIB90PorUF3VMb7LsUPQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=EZcingkAMEWMaAaPt8HKTsVxiilOYo02mN/DcePLSTSfWwplEJsldWjdeMkl6Ubl3
	 w5s290+l0MP/pXOBnt6siqgKbViir7WQBFbOthvLxe7t3xKDBmqIavVm3RIkIDU3EM
	 F6Vv/SlevaGk25TU9uizzolVZCzum2Vm6qpMd/aWpiaBx25Zn60jEEeLh9vRrhqAVM
	 u2bzxYD9gU93THLBiNyJYcCrr/GUg42CBGqXS20yGHYkPO8+KzTYeeeSAQW39Ltc1S
	 ix9aEVz25BTrGURLkVhPN8E0WYGGsn5Gu2Vnu80+jDmjzjJyTZPixUNW4Ch0HmEcFq
	 y/SvZ/axS46Hw==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id E119F48257; Mon, 12 Oct 2026 10:01:54 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1791799313;
	bh=0pyzztU0NngLfC81+czlzcRfIB90PorUF3VMb7LsUPQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=tPN1omDSDJ3Eji9VdMbsc5JmlemifaoNvVyG1qUc/uRqxanyttMZF7246Gmajcyo8
	 6mlBxFVYJT+PEYY62YRA3yLFovFo3j5jrTdPPqdS25myrghGOFEVVf51cOOVTUNea5
	 NpTn91jxf8FEqsRcpt1CGvG9ZWS/On4MXU273tJp5iWXu69RDu6s9lo3P5gQP+V8Dg
	 NN8H77fdxspFCNNR0YEJhIJn7O9y9TFXjjXwACJtjD6Rhl4ksOVHtM6oq/HPcT5zjm
	 jANexW+X10DgkyPF1ksWEUJIBSr3y1PepTiNNqLkF6rRMx3XDRdKDQCzPgYSE6d8te
	 CgfOzTYm3faPA==
Received: from [IPV6:2a00:6020:47a3:e800:271c:c6c5:9fde:77cb] (unknown [IPv6:2a00:6020:47a3:e800:271c:c6c5:9fde:77cb])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id 9A9C348257;
	Mon, 12 Oct 2026 10:01:53 +0000 (UTC)
Message-ID: <b4709a5d-ba7f-471c-8092-7a6887033e41@birger-koblitz.de>
Date: Mon, 12 Oct 2026 12:01:52 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 01/10] r8152: split r8156_init per chip and
 factor out wait_autoload_done
To: Chih Kai Hsu <hsu.chih.kai@realtek.com>,
 "davem@davemloft.net" <davem@davemloft.net>,
 "kuba@kernel.org" <kuba@kernel.org>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 nic_swsd <nic_swsd@realtek.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
 "edumazet@google.com" <edumazet@google.com>, "bjorn@mork.no"
 <bjorn@mork.no>, "pabeni@redhat.com" <pabeni@redhat.com>,
 "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>
References: <20261008081556.47901-1-nic_swsd@realtek.com>
 <20261008081556.47901-2-nic_swsd@realtek.com>
 <633a0f2b-67b3-4896-8464-6a4d0c05498f@birger-koblitz.de>
 <816bbc26531f411283f43e24c6156b5c@realtek.com>
From: Birger Koblitz <mail@birger-koblitz.de>
Content-Language: en-US
In-Reply-To: <816bbc26531f411283f43e24c6156b5c@realtek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Chi-Kai,

On 12/10/2026 11:24 am, Chih Kai Hsu wrote:
> Hi Birger,
> I'm sorry for making the previous reply hard to read, so I resent this.
> 
> On Thursday, October 8, 2026, 8:18 PM, Birger wrote:
>> Hi Chih Kai,
>>
>> I have a hard time to understand why you want to separate out one init
>> function into 4 different ones, for each chip one. Especially, if, as you say no
>> functional changes are intended, which might justify the re-factoring in this
>> manner. By multiplying the functions, it will become more difficult to maintain
>> the code: if an issue is found in the init-sequence, it may now be necessary to
>> fix it 4-times and future developments touching the init-sequence will also
>> need to be replicated multiple times. In total, there would afterwards be 8(!)
>> different init sequences including the other ones for the RTL8152 and different
>> versions of the RTL8153. The same pattern repeats with _up(), _down() and
>> other configuration functions.
> 
> The split is meant to make each function readable on its own. In a single shared
> function, every chip difference is a tp->version range check, and the function is
> hard to follow. Your concern is valid: if a fix needs to be applied to the four chips,
> it will need to be applied four times. But if a chip gets chip-specific fixes, the init
> or other functions will be more complex with several tp->version checks.
> 
> On the other hand, using a single shared function will make the function very
> complex when new ICs are added.
> 
Thanks a lot for looking into this! I think we agree on that 
maintainability of the code is a very important quality. Where you 
believe that using per-chip init functions is necessary for that, please 
follow that road, striking a balance between as many as necessary and as 
few as possible. Maybe look int the different generations of chips to 
see whether there are better ways to combine or split the 
init_functions() than is the case now.

>>
>> Would it not make more sense to try to further combine the init sequences or
>> try to disentangle the code by establishing common library routines put into a
>> _lib.c file and possibly different .c files for the different generations of the chips?
>> For example, it appears that the
>> rtl8157/9 belong to one generation of chips, based on the rtl8156 design. On
>> the other hand, rtl8152/3 appear to be a different generation with various
>> family members. That would allow to build a basis for future development like
>> to rely on using phylink to handle the PHYs integrated in the chips, which all
>> appear to be already supported by the Realtek-PHY driver.
> 
> I agree that chips with the same generation or very similar sequences should be combined.
> 
> I prefer to combine the callbacks, including init, up, down, and enable.
> - For init, I can merge r8156b_init into r8156_init and r8159_init into r8157_init.
> - For up/down, I can move the sequence shared by rtl8156_up/rtl8157_up and by the down
>   functions into common helpers, as rtl8152b/3 do with exit_oob/enter_oob.
> - For enable, I can combine rtl8156_enable and rtl8156b_enable.
> 
That sounds like a good plan, it would be great to reduce the number of 
these little helper functions being used, where suitable. It would 
greatly improve readability.

Best,
   Birger

