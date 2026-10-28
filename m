Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=5.135.140.105
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793150188;
	b=cvBvwv7lxZaGHvfvko0pkjgpcwQKNxON6O7kz5F7dulmGt4GcRzBhbNgq6l4b7XooTuy
	 88MLUb18hOdc6hPq7M+jgbhyDuozdLqruxHHu/qQQrEtN50FDcJn3djO2WA/kuNAdA7y3
	 i/j3dfLS8mmbA5pGT+k8jI0GwgiJJKVL0T2v6BtbmQWznM5XDvnXoi7NhWb5LR29Km4QK
	 OS+oxmypjwVMGtgBXhKYf/7HPHHtVG3JIF/0kRyP/V11CVpNvG9kD5gEGFk4cZdoxJdSk
	 bUhDHJFqHHeVjD8vJmpI9om7J6nloTjkygnY1ouUTftIFaUvmXZ7bd5YU8Yiu/e9OHg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793150188;
	h=DMARC-Filter:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Last-TLS-Session-Version;
	bh=b+REZnCfFDdefm9jnJVSHPmWlkqHTOnFekI0S/9L5S4=;
	b=pIBkKkhpUX7RmHXTirEvmzEEVQrDHfN3FsAlhHS4BwW1q5jk4rzlKQlVOYRmT7/POFpx
	 iAtLWYJldK+1xwioWCbYa8UKi0GddAemaJl4LyNAjwv0zbnRiwhvPFnZAoY2JIaiZ+Slz
	 z12A0j2x3v3w9WSzHJ/fyrFvZHjm5RO1Pteb7qKr0/TYEh4IhwWld9SZOHn2LgrltxBO3
	 yIUpFQAUVvobHq8YpMFO/wBXXM+Q2vim6PcRf7zJEtY14DV8+DklgJcmrUenV3Wz6guZi
	 9gNkfw3QYmx9PEscXmfmg54zm2FV5tLCSXKsOyGz0bsOJYOij591FFt4oINwfLnKVIw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cjdns.fr;
	spf=pass smtp.mailfrom=cjdns.fr;
	dkim=pass header.d=cjdns.fr header.i=@cjdns.fr header.a=rsa-sha256 header.s=dkim header.b=OHNvGusE;
	arc=none smtp.remote-ip=5.135.140.105
Received: from mail.cjdns.fr (mail.cjdns.fr [5.135.140.105])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78E30606A31A;
	Wed, 28 Oct 2026 01:16:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 78E30606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cjdns.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cjdns.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=cjdns.fr header.i=@cjdns.fr header.a=rsa-sha256 header.s=dkim header.b=OHNvGusE
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0C44F148E28;
	Wed, 28 Oct 2026 02:16:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cjdns.fr; s=dkim;
	t=1793150183; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=b+REZnCfFDdefm9jnJVSHPmWlkqHTOnFekI0S/9L5S4=;
	b=OHNvGusEtM6K3h6Z0yNFqbB49cR1kbiI70swtRDWeuc3Ke0YpIwKvELrBgFEuXM5BfHGtT
	uKsfHi/SBUegnadBVM7sl2zc72DgL8sS65JjKMbLmEREhJmqXARDzM18QjnYVb8jAmm5N8
	25qMwO49OF2TPyytIdVAlinNc/DFSjWVxCd+eoZC2X1b07emIk0wEtqQ8av5t0A44OshPK
	YEILFNCM5flsHNCfsEIeet9Br9fIwfoAGjrftxz+F5T57ivLOdX+PKw0wtoP+wuS2E9RDO
	iGE+po2Z+lobkZEi8KBa9Cs7XtoQl5tdu4TTG1i/rkY2c86VQs87T8CBKQOBOQ==
Message-ID: <86c89435-581b-44dd-9308-f77332944b7f@cjdns.fr>
Date: Wed, 28 Oct 2026 02:16:18 +0100
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
Subject: Re: [PATCH v2 net-next 6/7] dt-bindings: net: dsa: mediatek,mt7530:
 add econet,en751221
To: Rob Herring <robh@kernel.org>, netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, andrew@lunn.ch, olteanv@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, krzk+dt@kernel.org, conor+dt@kernel.org,
 matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
 chester.a.unal@arinc9.com, daniel@makrotopia.org, linux@armlinux.org.uk,
 arinc.unal@arinc9.com, Landen.Chao@mediatek.com, dqfext@gmail.com,
 sean.wang@mediatek.com, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, naseefkm@gmail.com, b.larsson@gmx.com
References: <20260915174643.253660-7-cjd@cjdns.fr>
 <178967820050.22033.18093714968849770785@kernel.org>
 <20260924154955.GA337010-robh@kernel.org>
Content-Language: en-US
From: Caleb James DeLisle <cjd@cjdns.fr>
In-Reply-To: <20260924154955.GA337010-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3


On 24/09/2026 17:49, Rob Herring wrote:
> On Thu, Sep 17, 2026 at 08:50:00PM +0000, netdev-bot+sashiko@kernel.org wrote:
>> Thank you for your contribution! Sashiko AI review found 7 potential
>> issue(s) to consider:
[...]
>> The analogous MT7621 case does not collide because the SoC root uses
>> mediatek,mt7621-soc.  Since the SoC compatible is already released, would a
>> distinct string for the switch, e.g. econet,en751221-mcm-switch, work here?
> This needs to be addressed.


Thanks for the note and sorry for the delay. I've just sent v3 with it 
changed to econet,en751221-gswitch. I did not see any standard for this 
and the name gswitch is intuitive for owners of the EN751221 chip 
because switch appears where the chip name has "G" in it, and it 
provides gigabit ports.


Thanks,

Caleb


>
> Rob
