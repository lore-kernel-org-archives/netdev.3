Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91F093B774D;
	Sun, 27 Sep 2026 09:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790501931; cv=none; b=KIX+v7hEREWpH7/sFN6BHOO3W0Sx2QD6s4u0muaNpEPwDLaNAlIjGN3h3XlaQwGHGqNmqscZcFHd3gyVYVmw5eZGqHg/RgSewhnalh0beexrNmhluVGGacewuEfNeAU/9kStiScBzSge0Os8OCtCXtHlx69Es+jpcpfvwufDuio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790501931; c=relaxed/simple;
	bh=F3WsatFd/Z0FgAALy7M1C0ndZ/KjYxk1HyNY/5VVCl4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cw+GyD3SMccCGo3wxi2lc0uL1kiF4kjNdUzE24n0V6/ukKOo9eSELXODTdyZlSIe3pPSle8FLreRBuLtL1+/54n/iH/dQl9xNVvefjURBlx0W7bOIFYL7wqjGzrkLVPyVpzwma7BndUsm9L4IZz+b+cwlw1kOI6foMjO7EP9KVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=CQcaAWYU; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=OHhqxYTR; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="CQcaAWYU";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="OHhqxYTR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1790501928;
	bh=F3WsatFd/Z0FgAALy7M1C0ndZ/KjYxk1HyNY/5VVCl4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=CQcaAWYU2bY1IgE3oufo2MNQXedoRgBbnWgk4c4V27epOPJzxoWldiWO1WJHdIr1o
	 rJk1xWX8CXKRGwXDJiQXXw0bjGa6I1TZREFZItKoom2NEnrr7FZPRwlZHC+PwAYXbg
	 wZOc/LUOZW7t55fYGl7/gvKrh3sVrbjx3onL5jO7TK9I5ZH3IB0TXjSIPONB16An9n
	 qz2YVS+3SwvVhu2R8ImX8UY9j4K4b4qi6szl5atLh4cg2wgGqAQDsK3ZO3I+4m7NTF
	 tUXpaPoUVru07Bul0IZz37z7+AOz5NkTnkA0TdqoOn8xqHrD2dnMqOWTRJEOxHR3zw
	 0NudZD5Fo3fZw==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id B75F5412EA; Sun, 27 Sep 2026 09:38:48 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1790501925;
	bh=F3WsatFd/Z0FgAALy7M1C0ndZ/KjYxk1HyNY/5VVCl4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=OHhqxYTRW+5iwI6gkLlnZlKFcaPw3w5U+R1wEC43xn0ydlBY0vCgCJ34YF1vGz6mc
	 aHZ2T03WQx3QpoTFQlvRZqrur1KokfvCITrLRnX80Ey0gaIUAQ/pQBSl609x3lJVzV
	 MNCffphCLll0X5q+/TUs8HyoPMl2MboayCf2j4Cfkt8nCBnN0qUuHmFNw3Pc/l3VIy
	 of0aIYesPle4jMzDTB8uatGwuFE6AVqMaxyUeZgA0ev2A20o0UYx/9W0Vo4VmemwEJ
	 aW+eKq6qnNGl8zduLvVYUPnNxT/KkTPYmohMwI4HoSR9dbklVWA0Lzi5NVMWLebOCS
	 Mvl0228vSAEBQ==
Received: from [192.168.2.51] (p5798b961.dip0.t-ipconnect.de [87.152.185.97])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id 4E959412CD;
	Sun, 27 Sep 2026 09:38:45 +0000 (UTC)
Message-ID: <05963f11-9312-49b9-bea5-3ee0ac3ba613@birger-koblitz.de>
Date: Sun, 27 Sep 2026 11:38:45 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v12 13/15] ax88179_178a: Update driver name and
 information
To: netdev-bot+sashiko@kernel.org
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux@armlinux.org.uk, andrew@lunn.ch,
 hkallweit1@gmail.com, linux-usb@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, neuromoments@gmail.com
References: <20260916-ax88179a-v12-13-60c04c9924a2@birger-koblitz.de>
 <178968030633.22033.16665978438548871360@kernel.org>
From: Birger Koblitz <mail@birger-koblitz.de>
Content-Language: en-US
In-Reply-To: <178968030633.22033.16665978438548871360@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 17/09/2026 11:25 pm, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 5 potential
> issue(s) to consider:
> 
> Critical: 1 · High: 0 · Medium: 1 · Low: 3
> 
> - [Critical] usb: net: sysfs ABI and module name breakage for ax88179
Fixed by adding MODULE_ALIAS(ax88179_178a);

> - [Medium] Undisclosed Kconfig symbol rename leaves two in-tree
>    defconfigs orphaned.
Fixed by changing defconfigs, Kconfig symbol name change mentioned in
in commit.


> - [Low] FALSE POSITIVE (retained only per validation policy): the concern
>    claims `select AX88796B_PHY` is bogus because the synthetic PHY IDs…
N/A

> - [Low] The Kconfig prompt/help and MODULE_DESCRIPTION updated by this
>    patch still describe the module as Gigabit-only while the device list…
Will adapt description.

> - [Low] Firmware-version producer/consumer mismatch: ax88179a_bind()
>    (drivers/net/usb/ax88179a_devices.c:761-766) reads only three bytes…

Duplicate issue, fixed before.


