Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C183314C4;
	Sun,  6 Sep 2026 18:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788721012; cv=none; b=eMXHbCbqhgkPGsE/ZiMQ1FyVpxxQyrLxiYplfyYXqGVqkPfmleTfT6VzpHd//YYHB77Ojq21F2Y62aeWPtbixXxvq0Mq6MIySVyWlakhUSC+35KDFqgMn2mFyYgvla/zC+zs+ytzpzFVzhIFMXqPVIG1Ob3zy5piQbnva9Jf/Hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788721012; c=relaxed/simple;
	bh=GzwTYTPNB+3ZgaSGbOJhfN4xcVHixesBzXXyYH87uhM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XdbaXFvBatSfP4ER0t94gDEytjHjNnLxunzvE47By/all3SLIu4m3NEQ3ZbQn4y03k4LZDOL38HjOBIxYH1fAdkY1lHFFDxO8Jdy71+5tFqiUB1cx8nwgYJZGL2dPJjkrL5xizGWZDXVgCczku9QhoBJ6icGyH1VDU8uwvWJXt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=Np64Orrn; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=IEdo3RZl; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="Np64Orrn";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="IEdo3RZl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1788721003;
	bh=GzwTYTPNB+3ZgaSGbOJhfN4xcVHixesBzXXyYH87uhM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Np64OrrnAiDjkzGw7b+8Sxetw8JEGWE9wGXt5gJMS0F24JZE37lL5FfV3oNgpMmRi
	 xvzCBNl6OjtpfIZV3JLajfWqssO20HL9k4fAExJTUNclCNQYHlldOvL8IavbHocjIk
	 BV93WsDVdO/Vcy0Dg27x2YPXeruiT+ItsjjeJWtJBy05AKTzysXMcG3E1rc7zQNi9C
	 OWz5Evi+L2X9TC2YRWIkmSUpr37lGKy59rIQ4spcPODfBofymIy4xylowcqeZE78a1
	 bxGh3jPF1Bg45QpSpT6aupTm8hZtKL1WOtb1L61iUNZwCJd9rlRWVPB2VbDVOxw3A8
	 XcmmMtub2tKGA==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id 0CBB13F1ED; Sun,  6 Sep 2026 18:56:43 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1788721001;
	bh=GzwTYTPNB+3ZgaSGbOJhfN4xcVHixesBzXXyYH87uhM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=IEdo3RZlgB8mBSaLjlE9yh03j0w1KvEPb6W2ens0JqphMz3PVC5in6vEhdZWLtVFB
	 xUf3LbaBNUxZ/cCqrl3VvANwFTEi+78oZXg0wugvr6Lv8sMr8SrThl63p6SOi9m/Mg
	 TPRiyirt92X/miVHl8yopnap0YJaqAfo4kNF7kY4R5EF3p/m/1ZsZkpfuFB0KeXZCt
	 wYKy5R3svxh7ligpmNR66MNb3n3co7R9wkFN/Bs9vCw+Dx/jUXMhmhg8x+iIEo05J1
	 XiO6Fmdc0ChwtZE8Dm93KiuA2Ds1q7Eaw/9h8J0zmKLoV6GmIxjWG09yEc6Yl+uAtZ
	 4Qa9yc/fJ03gg==
Received: from [IPV6:2a00:6020:47a3:e800:271c:c6c5:9fde:77cb] (unknown [IPv6:2a00:6020:47a3:e800:271c:c6c5:9fde:77cb])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id 89F823F1B9;
	Sun,  6 Sep 2026 18:56:41 +0000 (UTC)
Message-ID: <f56aa06f-fad7-4714-9c54-846397bf2438@birger-koblitz.de>
Date: Sun, 6 Sep 2026 20:56:41 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v10 00/15] ax88179_178a: Add support for
 AX88179A-based chips
To: Jianhui Xu <neuromoments@gmail.com>
Cc: andrew+netdev@lunn.ch, andrew@lunn.ch, davem@davemloft.net,
 edumazet@google.com, hkallweit1@gmail.com, kuba@kernel.org,
 linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
 linux@armlinux.org.uk, netdev@vger.kernel.org, pabeni@redhat.com
References: <20260904-ax88179a-v10-0-b5e60eca7690@birger-koblitz.de>
 <20260906104031.78051-1-neuromoments@gmail.com>
From: Birger Koblitz <mail@birger-koblitz.de>
Content-Language: en-US
In-Reply-To: <20260906104031.78051-1-neuromoments@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Jianhui,

On 06/09/2026 12:40 pm, Jianhui Xu wrote:
> Hi Birger,
> 
> I tested v9 on the same ASIX AX88179B adapter. By the time you read this,
> v10 has already been posted. Given the relatively small differences between
> v9 and v10, I expect the issue I found in v9 to apply to v10 as well.
> 
> First, as you already noticed, `data` is undeclared.
> 
> For QEMU runtime testing I also had to apply Chen-Yu Tsai's unrelated
> `usb: xhci: Fix HCS_ERST_MAX conversion` patch. Without it, this base kernel
> fails to initialize QEMU's xHCI controller before the network driver is
> reached.
> 
> All three fresh functional starts completed cold DHCP at 1000baseT/Full
> without reloading the driver and passed the normal 1000/100/10/1000 Mbit/s
> matrix, EEE disable/restore, pause enable/restore, and EEPROM read.
> 
> During repeated speed transitions, I observed one intermittent carrier-loss
> failure. Of 19 normally initiated restores from 100/full to the default
> 1000/full advertisement, 18 passed and one failed to regain carrier. After
> that failure, ethtool reported unknown speed and no link, and further
> advertisement changes did not recover it. Dmesg showed the preceding
> 100-Mbit Link Up followed by Link Down, with no subsequent Link Up before
> the device was reattached.
> 
> I could not reproduce the failure in two later fresh starts or in a further
> 90 unmodified-v9 stress cycles. Counting the normal matrix and stress
> points, all 22 tested 100/full points passed, so I also did not reproduce
> the earlier 100-Mbit carrier-without-RX failure.
> 
I tried to reproduce the issue myself. I am running the v10 USB and PHY 
driver modules directly on a PC with otherwise Kernel
Linux version 7.1.8+deb13-amd64

I am using the following script to change between 100MBit and 1GBit
1000 times with an AX88179A 1GBit dongle, each time testing a ping and 
printing out the negotiated speed:
!/bin/bash
i=0
speed=100
while [ $i -lt 1000 ]
do
         ((i++))
         echo "Run $i"
         success="BAD"
         success=$(ping -c 1 -q 192.168.10.247 >1 2>&1 && echo "OK")
         echo "Success: $success"

         if [ "$success" != "OK" ]; then
                 echo "Failed: $success $i"
         fi

         ethtool -s enx9c69d380ffff autoneg on speed $speed
         if [ "$speed" != "100" ]; then
                 speed=100
         else
                 speed=1000
         fi
         sleep 6
         echo `ethtool enx9c69d380ffff | grep Speed:`
done

This runs through without issues 1000 times:
[...]
Success: OK
Speed: 1000Mb/s
Run 999
Success: OK
Speed: 100Mb/s
Run 1000
Success: OK
Speed: 1000Mb/s

ethtool changes the speed, then reliably reads the correct speed while 
ping works and the device continues to respond normally through the 
entire test. All of this 1000 times.

So, either what you observed is extremely rare, or it could also be 
influenced by the different test setup, including the fact my test is on 
bare metal, but also by the link partner (an RTL8372-switch in my case).

The other point is that in principle what we are testing is not 
something users do regularly: you plug the dongle in, it autonegotiates, 
and that's it. And if you change the speed, there is a 50% chance you 
will do it from the other side of the link, which seems to be much less 
problematic as I noticed previously when we had the race condition due 
to PHY polling, because the dongle does not try to optimize the link: it 
accepts what is being offered.

I did not test your code, but I am wondering whether it is not simply 
enough to do:
+	if (link)
+		phylink_mac_interrupt(data->phylink);
without reading the bit whether the MAC link is up. Speed changes come
with a link-down, so I would think this is enough to do it like that. Or 
maybe I am missing something?

Given that we do not really know whether there is actually an issue, 
what it is and whether it is really relevant, otherwise your tests all 
succeed, and also because I have a feeling that Andrew may not like it 
if we try to be smarter than phylink, I would suggest we leave it like 
this for the moment. I would really like to see this being finally 
reviewed to the point where it can be merged.

Birger

