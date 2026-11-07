Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=194.13.80.246
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794052389;
	b=O5FdAQdcI/hupMnaYsAWu7S4B9VIKapW+GiOpqPibUD2110YzmS4RiChVeraBLteuqaM
	 NHNrDBuHhzPTXEkYdREH+hdj3wvZXOq9yFa69g5HzxObyRLo+qL/HTqxrWhNkQ27IHbiZ
	 yHSK3oHO6Fh66bpxn/12WjnfzQlqNScvU3MbION1Yd2JAoUFUhrMrMuBNc1tpwrETImlh
	 p+6+BeEc5EzTqrchmJYJwexGQoYvtBvtPBGCkU9HKN44KtS9MvzZ8/4tB3jTfLdwv4axe
	 5P3YKtapzQQDv0cabnB0er6lRMDcLiwtvo5Z1X8Uj67nP2PXYr/dJ6o6AuRZcwVkOlw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794052389;
	h=DMARC-Filter:Received:DKIM-Signature:MIME-Version:Date:From:To:Cc:
	 Subject:In-Reply-To:References:Message-ID:X-Sender:Content-Type:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
	bh=tve596h8zkYZfLnnzqz1wxSl0S3pzuQnyT+uXalhoXg=;
	b=OFSBUNxT3KER0G/Lu+EKFUgTYkBAiDtx010V9IN/UEWnw+ofTsMywsUYZBFL/ffiH38K
	 ErY4B530ltqpfh6S2vfESzwInsvAh1wBjJcRN5ogdyqkcx4VI2QkoJr4AFavApaE1FbxB
	 HFr6Y5oADVXk9wyfvcDWZwEaOt9z0MEPZdy9JGxgv9teCXpZaRlRzNT1jwzT0W78KKtBX
	 gKou1Ywmv/Qc0+EgfPLJQgaPmpJ1WWprR0bLXBwTuOVty1Rooe0rX+PnwyekF2bswPPx/
	 i7SYEvZJpaDisF31jzellAr76hnQf0UM+A7l8X39ko9C0C+oOOyVvx24lzOF8ziIk0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=tipi-net.de;
	spf=pass smtp.mailfrom=tipi-net.de;
	dkim=pass header.d=tipi-net.de header.i=@tipi-net.de header.a=rsa-sha256 header.s=dkim header.b=ZU9qi2ej;
	arc=none smtp.remote-ip=194.13.80.246
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE439606A326;
	Sat,  7 Nov 2026 11:53:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BE439606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.a=rsa-sha256 header.s=dkim header.b=ZU9qi2ej
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C61EAA0034;
	Sat, 07 Nov 2026 12:53:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1794052386; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=tve596h8zkYZfLnnzqz1wxSl0S3pzuQnyT+uXalhoXg=;
	b=ZU9qi2ej3MRvknrlmOJX1qCqg+H9HV4Tz8CnPAUi+ywathWMeA2VW4JtBUu/vvP+1Pn8NL
	/KfiKF1LjlW72wXB4OUZqohf/PmvXitctdT+Q81OlpHT9Fbh0R1W5VGnK16CyT9c5XNsOO
	p3y1BB5SvFKaDWJu1TPQbdYUHhZbEP9E63PDqqyEj8H42oEMVMiYqGpcH+rn3aJvuCNvnz
	nDvx+p9jDoBTZSlxwsGRPjxO5/WMgfJVNDA2/nsBJSjlhlArzcNyLGcCr2TXnXBdZYXU+B
	O7RzNk2UwAto5RoHEk/sUrGY1zilztWmIFRB/t3YujkGxsNuCSHgw8o9wCUXxA==
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Sat, 07 Nov 2026 12:53:04 +0100
From: Nicolai Buchwitz <nb@tipi-net.de>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: Doug Berger <opendmb@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Justin
 Chen <justin.chen@broadcom.com>, Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Nikolay Aleksandrov
 <razor@blackwall.org>, Jason Xing <kerneljasonxing@gmail.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: bcmgenet: cap the Tx queue threshold at the ring
 size
In-Reply-To: <1b33c10e-fa25-427a-92a6-d26669712f09@broadcom.com>
References: <20261106-nb-genet-txq-thld-net-v1-1-53bbac647b71@tipi-net.de>
 <1b33c10e-fa25-427a-92a6-d26669712f09@broadcom.com>
Message-ID: <6c0446dbe8e63a7c6a6120d4a1d6ad0a@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Florian

On 7.11.2026 01:14, Florian Fainelli wrote:

> [...]

> Eventually we will have to decide what to do with those other queues :D

Probably sooner than later. Sashiko claims that this patch does not 
fully
fix hte CONFIG_MAX_SKB_FRAGS=31 case. The check in bcmgenet_xmit()

         if (ring->free_bds <= (nr_frags + 1))

wants 33 free descriptors for a 31 frag skb and those rings hold 32. 
Arguably
the bug is way older than this patch and you need a non-default config 
to hit.

So IMHO the options are:
Either linearize in bcmgenet_xmit() when the frame does not fit, or we 
drop
the queues as I proposed in June [1]?

With XDP in mind the second one seems more attractive, as it needs its 
own 64
descriptor ring. With the current split the main queue would end up with 
64
descriptors, against 192 if the queues are collapsed.

[1] 
https://lore.kernel.org/netdev/20260612205915.3156127-1-nb@tipi-net.de/

Regards
Nicolai
