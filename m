Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FC7F3B8405;
	Sun,  4 Oct 2026 05:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791092771; cv=none; b=KiMgFsia2+mWWCtc/g46v3NqJ2YYl7RpiiqRVjPbf9X4iuTXvuRYaG7zMdJKsN3jjPHiesJDdh2wCxTXieJQAlKGknMNhrHcP8vc0Pa5jR94zO+MGnQ61lLZudqenshtjTq872aiwirNf9aL5aXghcs+O2XDjeO6HilF7iGuXCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791092771; c=relaxed/simple;
	bh=sUBnTza7zDxpSZ4E33Ix18dGR98eAVVfMJGyZ+uHNiE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eJMQ8kF54bdmYlYVGTSwpXY91dDbcpxxhR2hbR+3na92/iQ7USJ5sFX1PXsRExuZUv7nx0xIGEK1/xYoQZYasIkO6pDxdb1MChrGGIGl9F1cn87z23cnyBqEPwWa5PUrjVi+ZV297O0+PUO6m/PmeEa7bA8e2CsEBcnhgn/OJgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=qVQahIys; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=JENAANXH; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="qVQahIys";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="JENAANXH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1791092768;
	bh=sUBnTza7zDxpSZ4E33Ix18dGR98eAVVfMJGyZ+uHNiE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=qVQahIyshU1J/yMkEtUrBR2p/ZA2NblhgaDIvmnv2yIewCG6TKLggAvBCFnhpUIjS
	 aEzWa1z+6/hkRteNuV/kEC6ZSVIFVdwlGMAQMz8d8+cm2Id/EJ3NEllQpGYrdY0vPq
	 p7szVWtXCqCg0+61IvvdIaEP11mnfT1L9IyC4XT7D1FpyvzrQ7SiQoPSQNxqPwkGt2
	 kpI4LIex2SRjPiXwHDc+YIE3456EnKmtF+zWnQvDXRiP4rzYITcA8Y8oAwuiGLU7vo
	 g2izH4sLFb8kG2UHONK7KbqxMohBkbhNgQmjipGiSvTAXi1WKu/bnk0SekyCD3UyZe
	 2NDfLF2Ipmd3A==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id ABD0E4834C; Sun,  4 Oct 2026 05:46:08 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1791092767;
	bh=sUBnTza7zDxpSZ4E33Ix18dGR98eAVVfMJGyZ+uHNiE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=JENAANXH1OmIUFpB0vlgJpO23Chef3B0sHmxozXNvxZ9NajlGdmPb9o3dJRzOBGuy
	 P/BMvFpb+DcOjPYEwmcwqLDNv+fC6RjtvAso3isTdAHM+A43WOMCuKDPKtuewVBHOW
	 yIWci3BEWpUzp0IlUJsfzviUfl2ZXDBxX4c6/qJot/PwA9cUAcH5nKY8zrsOU0F5B6
	 t1zAG8sydHuOwVwueHz78tdz3ZJVmObCGu57R+kfF2IPKib4yN7EqLct2qHHpAsnOq
	 s4dt2iHAit7l1fIk+dhs/ub/TshVbbZKRAO1LnStjyKYjZjtpr03zEfP5/OKNQGm2Z
	 9QgN6uGQMVnfg==
Received: from [192.168.2.51] (p5dd1ef42.dip0.t-ipconnect.de [93.209.239.66])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id 939CA481F5;
	Sun,  4 Oct 2026 05:46:07 +0000 (UTC)
Message-ID: <238071cc-9ee5-4aa1-8915-31fc83b82068@birger-koblitz.de>
Date: Sun, 4 Oct 2026 07:46:07 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 0/13] ax88179_178a: Add support for AX88179A-based
 chips
To: Jianhui Xu <neuromoments@gmail.com>
Cc: andrew+netdev@lunn.ch, andrew@lunn.ch, chenhuacai@kernel.org,
 davem@davemloft.net, edumazet@kernel.org, hkallweit1@gmail.com,
 kernel@xen0n.name, kuba@kernel.org, linux-kernel@vger.kernel.org,
 linux-usb@vger.kernel.org, linux@armlinux.org.uk, loongarch@lists.linux.dev,
 nb@tipi-net.de, netdev@vger.kernel.org, pabeni@redhat.com
References: <20261002-ax88179a-v15-0-131d9286fcd7@birger-koblitz.de>
 <20261004052619.112885-1-neuromoments@gmail.com>
From: Birger Koblitz <mail@birger-koblitz.de>
Content-Language: en-US
In-Reply-To: <20261004052619.112885-1-neuromoments@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Jianhui,

On 04/10/2026 7:26 am, Jianhui Xu wrote:
> Hi Birger,
> 
> I tested the 13-patch v15 series on an AX88179B adapter (USB 0b95:1790,
> bcdDevice 0x0200) on the declared net-next base
> 071876fd50482a68603a9460d80dd6dd58827ee1.
> 
> Builds, cold DHCP, 1000/100/10 Mbit/s link changes, EEE, pause settings,
> EEPROM reads, autonegotiation restart, module reload, USB reattach, MII
> ioctl reads, and repeated 100/1000 Mbit/s transitions all passed. The build
> only showed the pre-existing unused mask warning in
> asix_ax88772D_get_features(). Deep-S3 resume also passed with both wol
> d and wol g; resume was triggered with QEMU system_wakeup, not a magic
> packet. The guest later hit an init-exit panic during poweroff, which
> appears separate and has not been investigated further.
> 
> However, I did find a reproducible RX VLAN filtering failure. With
> rx-vlan-filter enabled, ip link add for VLAN 123 or 124 returned
> success, but no VLAN interface was created. With the feature disabled,
> VLAN creation worked normally.
> 
> The first read in ax88179a_vlan_rx_add_vid() returns the byte count on
> success, so:
> 
> if (ret)
>      return ret;
> 
> returns 1 before the VLAN bitmap is programmed.
> 
> The patch below fixes both issues and worked correctly when applied
> directly on top of v15.
> 
> Because unmodified v15 has this VLAN failure, please do not carry my
> previous Tested-by for v15.
> 

Thanks so much again for your thorough testing, I know how much work 
this is!
I added your fix and re-sent as v16 without any other changes. Since you 
tested exactly that version successfully, I hope it is OK to keep the 
tested-by for the v16 version.

Best,
   Birger

