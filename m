Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=5.135.140.105
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793188778;
	b=kSc9KQEGnpKDeK1o/Sp/rsyTdTqUHlMLnIezULlg4tQlsKrq8UO9W4ZpEoAc3pIIhP7i
	 KuYyeWhVLEX9yORpGxQXVoIDQMYUueDiJzK6z+F43I+y6iEZw0y2AU5J/fnAr50xrf5NR
	 BhvP9UCQ7lMpwPVApcc6Ipdgm+7HMzY4xRA9NfCoiMiylVwH7GXFauhYtHjbXkwLfg544
	 zYsUP4XPv0GwEYUj0aP4s4D1RaTFu10Wgaju030BWxd/7MbKWUlbNDDKby5ikjVEb3eE2
	 /fbso1C3PDhcBf0mJ++6nnQrN3TrWE2L1Vf4vMJAXB2BYmJ+14C+Y+5Wz09DtkSeifQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793188778;
	h=DMARC-Filter:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Last-TLS-Session-Version;
	bh=f5NboUzo78TSvbEnVlTQueU5GwrKHZYmgsrDTsu8dJU=;
	b=eVC5Bt2hJZXgD7SZoYQ45x8al4SFdgmeG3uZUYzpZROEZEDqo9HdCDPUipl8GXHvOl5V
	 lLlJJZXsEOjUZEdyIc/+HYQiIdw016s5S5+ybxFGf+AZ3/JhK79BRNL0/L30x3nYk7rPL
	 frB4xs2P19UFpiQxFMmX/c9GH7J7GvSv4UTaP9rS9Z64W1bpY9+h/TdKxGl49K/J9sp7a
	 5YQKeRSj17wYdmS2uDt65hmT69EhZNYKKMPxDSfOoiiv3VVfWAnexzRitYIWStOM2VFaM
	 efukY7LKfSXvw1lQ4ZRF8Z9EcrZkQi+WArYqBi0MbmC61P161zqJrZS53JQLFka/gmg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cjdns.fr;
	spf=pass smtp.mailfrom=cjdns.fr;
	dkim=pass header.d=cjdns.fr header.i=@cjdns.fr header.a=rsa-sha256 header.s=dkim header.b=P4N3rUJS;
	arc=none smtp.remote-ip=5.135.140.105
Received: from mail.cjdns.fr (mail.cjdns.fr [5.135.140.105])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6740B606A31A;
	Wed, 28 Oct 2026 11:59:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6740B606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cjdns.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cjdns.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=cjdns.fr header.i=@cjdns.fr header.a=rsa-sha256 header.s=dkim header.b=P4N3rUJS
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1914B15A2B6;
	Wed, 28 Oct 2026 12:59:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cjdns.fr; s=dkim;
	t=1793188773; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=f5NboUzo78TSvbEnVlTQueU5GwrKHZYmgsrDTsu8dJU=;
	b=P4N3rUJSUM89fo9E2InG1shZOpy0XpXcOvgzNy28wcBa2dk4P+TiyEQhdoOKC2iZpyCfPD
	3ki45bzf6FsuR4HE9CJkmwVihB614DfRgS/1XQ+uPFi+9AMFDG1fWWwXOt2dzfQQ40M3iM
	yuGpbv53MOJ6vmorSa04cXulx/u/LT0azavSqBwvFsvyydeLefaE2bibPSsF3BgI2YyWkt
	nM5O2J2kEHb7kt0fXTbIUXYuG0QbnJCJlBx0jM6KzRffivz4eEXivXbeeDL5mrVjpWuf0l
	/kOdX6Q1O+75jHkfq5kQJjBmHJF9/NsjcJkyR2P/LWH3a4zE//wRaFyRRmisiQ==
Message-ID: <acf55987-e96d-407f-a4a7-1c78178a0c7a@cjdns.fr>
Date: Wed, 28 Oct 2026 12:59:23 +0100
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH v3 5/7] net: dsa: mediatek: support MDIO switch downstream
 of MMIO switch
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, olteanv@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com, chester.a.unal@arinc9.com,
 daniel@makrotopia.org, linux@armlinux.org.uk, arinc.unal@arinc9.com,
 Landen.Chao@mediatek.com, dqfext@gmail.com, sean.wang@mediatek.com,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 naseefkm@gmail.com, b.larsson@gmx.com
References: <20261028011317.1557238-1-cjd@cjdns.fr>
 <20261028011317.1557238-6-cjd@cjdns.fr>
 <f6fe9c7a-5617-475b-babe-da24cda815cc@lunn.ch>
Content-Language: en-US
From: Caleb James DeLisle <cjd@cjdns.fr>
In-Reply-To: <f6fe9c7a-5617-475b-babe-da24cda815cc@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3


On 28/10/2026 03:20, Andrew Lunn wrote:
> On Wed, Oct 28, 2026 at 01:13:15AM +0000, Caleb James DeLisle wrote:
>> The MT7530 / MT7531 can connect via either MDIO or MMIO. In MMIO mode
>> the switch provides its own MDIO bus which connects to its integrated
>> PHYs, but also can be connected to other things, such as another
>> switch.
>>
>> If the MDIO bus contains another switch, then the upstream switch
>> will register but it will not setup the DSA tree because the
>> downstream switch is missing. Without the complete DSA tree,
>> mt753x_setup() will not be called on the switch and therefore
>> mt7530_setup_mdio() is never called so the downstream switch never
>> registers.
>>
>> Update mt7530_setup_mdio() so that it can be called multiple times,
>> export the symbol, and call it again after dsa_register_switch()
>> from mt7988_probe().
> I would suggest just moving it to probe. Don't also have it in setup.
> KISS.


I don't think there's a way to do that which will work. And I guess I 
need to add a few comments to explain why. Basically 
when dsa_register_switch() is called, one of three things can happen:

1. return error (often without calling mt753x_setup), typically this is 
EPROBE_DEFER because the ethernet driver is not there yet.

2. return 0 without calling mt753x_setup (because not all switches in 
the tree are yet probed)

3. call mt753x_setup, complete setup, and return 0


In case 1, mt7530_setup_mdio must not be called, because it would be 
setting up an MDIO on a driver that's about to get deleted.

In case 2, we have to call mt7530_setup_mdio because otherwise we may 
not discover downstream switches (this is the patch)

In case 3, mt7530_setup_mdio must be called before mt753x_setup returns 
because after it returns, the DSA core synchronously enables ports and 
it will expect PHYs to be operational.


Only the DSA core really knows what it's going to do, so I think the 
only way to solve this without going inside of it is this patch where 
calls are made from two sites.


That said, I think it's pretty clear that I should put a couple lines of 
comment in there so that nobody is tempted to "streamline" this code 
into one of the things that doesn't work.


Thanks,

Caleb


>
> 	Andrew
