Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792664543;
	b=zC6AndZ89mXliFVTXP25i6L2KhTdviuUTTwDmpI7QpmSzAzxSGUJQEKwvXBVxsoyoWkf
	 EGO6kfpC3LlWHOCU6YG2aOJCJemD5rkEL+vyjCqWSKysMSbhZthBBDd1SNrf0wF2JHsee
	 MjDE2th0xM1gadvtcp+7HtO0fpQgz6S68W/PYgWqctn85/ZzF7ygQSd2UPVt97kW5CaeM
	 MmRgx8/9uPjqfjPNXLHWWNl2NBcpLr6eqzDoHXRHoPXPqYEJ5efjaPLg5A0g2cgMSARy5
	 cJc0VJ0JjNiO22+fdymnIcsga8oqAmFJySJrIEDkfiz3Ic15RqnJfSh1nNbDxJKj/Hg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792664543;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=X1hkH/WoS1PUodSVVDSJVTIP1ucGICUHF3hWVbzAKEQ=;
	b=IWOmzNGRoRIdPKS9C5oYY85ivAt9rfsDfonEKZBAm9cf92HeNjxsiAx4sCA7dLfSRdNQ
	 00wP0CFl4ABhMDYKO6T4oI/FPUrgTenRxYIE8UDhapyk3/6uVObWx/mRi7J5ilrgZezPu
	 IPGcWtfhx+3itAhq6sA0el6fFgWK8ZQ45a6zO5QkXdNeVALCvdpa+Hwarimwx5MWs0+i5
	 bdFicsWYEe5ADNZa5sJmtRN83UvIT1C8hvn3dF36dIjME6unm4BPYuNDnUm6pNbNk+U1F
	 b53vqFC7USTAJ/C53AEpdVXkw5beTZJNdhyaTgZcE2H9cwK7pc/LhIysWdFY3HbJcIA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=eZhprx+H;
	arc=none smtp.remote-ip=209.85.128.50
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28C14606A324
	for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 10:22:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 28C14606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=eZhprx+H
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4a1e34ecb02so11594455e9.2
        for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 03:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792664541; x=1793269341; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=X1hkH/WoS1PUodSVVDSJVTIP1ucGICUHF3hWVbzAKEQ=;
        b=eZhprx+HRqcaL2C5RomVkw5pd9xuEkURWxrCHr2tDbLRt3CYIucTGqF9jEhN8m5z+J
         wxYD9g1J7yWsweNKfd1yfNWmdN4eePhXf/jU44Pc/dkHm99AkM5NFQbDFSbulgnA9A2P
         cnfD0Ke4Rgn1tETDwGRXODCBrUMFlHaBTC2IYojDVmh80tKnnuGyR/2hOBS2svsEJAG+
         rQknlhjKtTzkR0D9jKcAwT3ZOgYxytH9eAyPYdZTc66ZMEIXNRJFNKNgyy7kw8ahcN0s
         4IrrZjAsV4OAakcfeN3bxafuXNdYY/4f+ZyzIxm60/AG+XUspYGjex9w6rbfQaHMjRd8
         EAUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792664541; x=1793269341;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=X1hkH/WoS1PUodSVVDSJVTIP1ucGICUHF3hWVbzAKEQ=;
        b=HsXsv5L8pv6MVAh0tXek4ItXfZjn2QUGVyXpcrp593SzjKLHwZaKoxPp8QlyucXHjY
         FbmABYvswOfK+iamcA47YYno8lgTL6tggYpJBiNEnLszYrPNHlZtF+Wx8x2sH0PXjE/z
         qF6jaJYcnW3dTi1Olq2YgfAqxNtF0qcaLsLMUeQW5iqJ39bQVWcIdIVbhimROtzJig2/
         f5rDaDwh8MdVMbvVspuLbqa+6MXGouCkv63mZAG7NxmU7Ezk7InVFR0Ef1KFYJmPkFIA
         xavmbfXhy/tv809zkN0dTtJZ5ZI5c6kqTMcYCdo0zbQ2pLnjck++vc82cJ9CRRCflzJt
         hyKQ==
X-Forwarded-Encrypted: i=1; AKwUvBxTiVoV0bdCc35A4v5sZ2rH6VyMmPBPgcxNr8pjMxwq+brALzdi+0UkpiVC6W+XAuXTPfkVsUw=@vger.kernel.org
X-Gm-Message-State: AFq9FYI5ddFOPU1siKhSexVdaWDnH3jSQ7iakA/TwDtK4S4dmcBhJOF0
	+sNhLJHWWSoM7dCpqY/rNfCLDbLXf65O3lYI7PJeBz1wSJ1s1FFu3Km1
X-Gm-Gg: AYBFou1LffM5poSUZB2/Uz+tP8aNP58+Iky7LObyUrmBnDXVHtdZF0wiEabQ9NaimF5
	ZciVqTROD89RpdEB40HKLYPQMoTT8BXeVCKoAmVhoGYaQThtk/LOjgPz3iQUcGTDwAFc1DFt8cW
	SKY7/Z7nG/8CPH5UCYeO6rrDAxlDAvlKcf1h77hBt3Rd+Ft2rN48SVzL/3IZLFaR9G2aVfz5enO
	dF2mdooMIsp68DVzleRMuqQi6lI4r3zqu/otyoQVetyI15whSi+5F9tVVtMDNmsXYv2CdRQ/I1G
	YcTWKz4U1OcNx9JKXU09YTeS8lcVw5m09xfhCl69JxVfnsBI3fCKy4Yh4JseKAu0lwm7oOStE3h
	AnY2yOKpRIoZYRnRXBRmeL+oIxIqDuTfXaCv9mIBB0z7W8JVJKBpY6r6+IMyxAs2Ij14WJUqDed
	p8vmVk1jfMy5pEt4IwIIHWoTyeeqrG7Q2+aaP5yMY0n6w9t1FWXC0ZhI/5dPuN0m04Q6y99wotO
	+H9YnWos9X5Xwk0GHfOUf+Rui2ZFynkicHPui1lGoY26Rqy+Q7Kv/VFKuGefRoggyo8O0p60cyS
	8d09CHdqNALuXXtfdA==
X-Received: by 2002:a05:600c:3e85:b0:4a1:e6c8:ff74 with SMTP id 5b1f17b1804b1-4a1fdd575ffmr96476065e9.29.1792664541152;
        Thu, 22 Oct 2026 03:22:21 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a203b37df4sm60298495e9.6.2026.10.22.03.22.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 03:22:20 -0700 (PDT)
Date: Thu, 22 Oct 2026 11:22:18 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Claudiu Manoil
 <claudiu.manoil@nxp.com>, Wei Fang <wei.fang@nxp.com>, Clark Wang
 <xiaoning.wang@nxp.com>, Ioana Ciornei <ioana.ciornei@nxp.com>, Zefir
 Kurtisi <zefir.kurtisi@westermo.com>, Zefir Kurtisi
 <zefir.kurtisi@gmail.com>, netdev@vger.kernel.org, imx@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 net 2/4] net: enetc: do not rely on mEMAC hardware
 frame padding
Message-ID: <20261022112218.11a1faa8@pumpkin>
In-Reply-To: <euqz7djxfn4tqbd63ymcj2bnu7k2bb6hzlmeilao3rvjdhyisf@bk3wj5hinfnr>
References: <20261021145314.1435049-1-vladimir.oltean@nxp.com>
	<20261021145314.1435049-3-vladimir.oltean@nxp.com>
	<20261022093359.723c7e93@pumpkin>
	<euqz7djxfn4tqbd63ymcj2bnu7k2bb6hzlmeilao3rvjdhyisf@bk3wj5hinfnr>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 22 Oct 2026 12:41:49 +0300
Vladimir Oltean <vladimir.oltean@nxp.com> wrote:

> On Thu, Oct 22, 2026 at 09:33:59AM +0100, David Laight wrote:
> > On Wed, 21 Oct 2026 17:53:12 +0300
> > vladimir.oltean@nxp.com wrote:
> >   
> > > The driver sets the ENETC_PM0_CMD_TXP bit to pad short buffers.
> > > This works, however sending short frames from user space and looking at
> > > the padding bytes inserted by the MAC at the link partner, we notice on
> > > LS1028A that the first octet of padding is sometimes not 0.
> > > 
> > > This is fine per 802.3, which does not require that the padding is zero.
> > > 
> > > However, there is an unproven suspicion that the padding bytes may
> > > come from internal memories, and unfortunately I couldn't get sufficient
> > > priority for this octet's origin to be investigated by hardware
> > > engineers.
> > > 
> > > To be defensive and not leak any sensitive information from the SoC,
> > > let's pad all frames to ETH_ZLEN in software, so that the MAC doesn't
> > > have to do anything.
> > > 
> > > There are 2 distinct cases to handle, for GSO and non-GSO. For non-GSO
> > > things are trivial; we need to call eth_skb_pad(). For GSO, things are
> > > not simple, because user space may set gso_size to a very small value,
> > > which could make the GSO super-skb smaller than ETH_ZLEN;  
> > 
> > That isn't sensible.
> > The minimum frame is 64 bytes (including FCS), subtract that, the MAC
> > header (14 bytes), minimum IP header (20), minimum TCP (20) and that
> > leaves 6 bytes for user data.
> > I doubt it is sensible to do GSO for anything under the minimum mtu
> > (128 bytes rings a bell somewhere).  
> 
> My fault for not being clear and inviting this kind of objection.
> 
> Since we do GSO in software, we advertise NETIF_F_GSO_UDP_L4 too, and
> there, Sashiko came on v3 with the observation that for UDP GSO, user
> space can set gso_size to a small value using setsockopt(UDP_SEGMENT):
> https://lore.kernel.org/netdev/178960175550.22033.10648880872141935672@kernel.org/

I'd fix that in the setsockopt code.
But that might be a bug anyway.
UDP segmentation has to use IP fragmentation and that is usually done because
the interface/path mtu is too short.
But there is a minimum mtu for IPv4 of (something like) 128 bytes, and
it may be invalid to fragment into smaller pieces.

> Sensible or not, it is possible, and I did generate a test program using
> an LLM to confirm this.
> 
> Regardless of that, the last segment of a GSO super-skb would need
> padding anyway, because even with a 'normal' TCP MSS, the skb->len
> modulo gso_size could still result in a last frame < ETH_ZLEN. Padding
> just the GSO super-skb, as I did in v3, would also not fix this.

True, but that is a different check to the one you did.

> > But does this code allow for the VLAN tag that you forgot about in the
> > other patch?  
> 
> Not sure I understand your concern here? Is it that with VLAN TX
> insertion offload, we pad "too much" (i.e. to ETH_ZLEN, then the NIC
> pushes an extra VLAN_HLEN)? I'm not sure that's a problem..

That is a problem, VLAN packets should only be padded to 64 bytes
including the VLAN header and CRC.
However such overlong packets are likely to be tolerated because
an ethernet switch can add a VLAN header before forwarding a packet
and it can't know whether a short packet is padded.

> Anyway, with VLAN TX offload, the VLAN tag is not part of the frm_len.
> It's part of the extension BD that we forgot to account for, when
> determining whether the TX BD ring has enough space for the frame under
> transmission.

That is what I was thinking of.
By brain thought it was a normal BD - so would be in the 15 limit.

David

> > I also noticed that the code seems to dma map the fragments for each
> > gso segment separately, just mapping each skb fragment would be better.
> > (But that is for another patch series.)   
> 
> Noted, I can look into this separately.
> 
> Thanks for the review!

