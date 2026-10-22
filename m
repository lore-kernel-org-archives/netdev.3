Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=194.13.80.246
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792659477;
	b=UhaRKydRefm4OgZHi8Riw4LxsLY12p/yPRRu8viqBwA8nzJSU2YR8h0b6sbIJPIS+ybk
	 oJmX15pabID/ter87uboZ9gvxzTh5TsKhlFUvO64T+fAAafdkawRAX96y04TXExQGnhEi
	 3i9BFFs1C2fVfnp7YqG7vBU2bpU1LfBg9ydu174M7bhryq55nyIF6V4Y+wa+28yVJeQ2B
	 vKoFDTD8wLV1iyjlZYmQSvqH+SmMOFVJe20ccv4JDUiTSI1VcIL0+x0thbDU4rAvY/qpc
	 TTwlDEqxo56qhmxba8uNnL270IypwwlJobamrCmYgqqydNdJ20Vj4kdBQURfjkzb1Rg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792659477;
	h=DMARC-Filter:Received:DKIM-Signature:MIME-Version:Date:From:To:Cc:
	 Subject:In-Reply-To:References:Message-ID:X-Sender:Content-Type:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
	bh=OGYrtd+SjkywYOsHd1goE1rmxbPf3oWPnIKBnt53Dsg=;
	b=ORpDgrp0R5+1sUveww5V8hHXg+m/D3p2jUaqirSv0ym6FoV0FQ/vBavt/VEHVPGJb7Df
	 47+y5KhAB7wYXfFL4/MhROJVDRgzGWZDlrVYM6LNrv5kWA13uWaMQlWgikNmF1/qKsAr0
	 dklYZkIWPvg3H/ffFkvr9FVg2npPN+9c/VQFC+bWlmqTBSLxOuO2dKnez4+yuUh1ZXW/y
	 EzTpzHuscveH+4ytV1qcCuJsuCjPuBYYljQkDJk7O2zfuxCLIMTU0ihn7IKRQixnxkawT
	 4X870UWAPzP+fpDaD0lr8QHOxM8tVdoYAhWWMClue0r/Np35H6nIPHoAV0KushRDVgg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=tipi-net.de;
	spf=pass smtp.mailfrom=tipi-net.de;
	dkim=pass header.d=tipi-net.de header.i=@tipi-net.de header.a=rsa-sha256 header.s=dkim header.b=Y4SJiwun;
	arc=none smtp.remote-ip=194.13.80.246
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 339E0606A31A;
	Thu, 22 Oct 2026 08:57:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 339E0606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=tipi-net.de header.i=@tipi-net.de header.a=rsa-sha256 header.s=dkim header.b=Y4SJiwun
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id AC266A0190;
	Thu, 22 Oct 2026 10:57:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1792659474; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=OGYrtd+SjkywYOsHd1goE1rmxbPf3oWPnIKBnt53Dsg=;
	b=Y4SJiwun9ohaxRsgL6Pk2l2pVdNKLier3sWhqd1hXDz90K7AwFB37pfUzJJWG3Kend2hvj
	gbrv7NA+iRS0zwdHkh8aN6IGhCg1VQDIShO6OgymhHwXvEuOASQu6568InGab2fds9ZPS4
	5zg8DQrQ2RlRU+tk+DkIZyHGsWtNFHFF0lzCgngyrmDuZrAnRRrn/CWUWHFWr7+m+Fy2ei
	nl3dwgOEvaFIgtVL9+xncVy3IeJYnaEFe3MJ77TbTlakTtqH1g1jhIGMsFwgXw8I31ld/X
	VZRwd91GP5TPBO/W7m5qS9mX5sJ+qh7yScg+0BS6j+stVfpL/gC+sAVTkVXGJQ==
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Thu, 22 Oct 2026 10:57:48 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Sunil Goutham <sgoutham@marvell.com>, Geetha sowjanya
 <gakula@marvell.com>, Ratheesh Kannoth <rkannoth@marvell.com>, Subbaraya
 Sundeep <sbhatta@marvell.com>, Bharat Bhushan <bbhushan2@marvell.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] octeontx2-pf: fix skb use-after-free with ipsec
 crypto offload
In-Reply-To: <20261021170856.15bb09ff@kernel.org>
References: <20261019-nb-otx2-xfrm-unshare-net-v1-1-ee9b24f9e673@tipi-net.de>
 <20261021170856.15bb09ff@kernel.org>
Message-ID: <88ca4db1ebc01483bdcc7702f2a542f2@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

On 22.10.2026 02:08, Jakub Kicinski wrote:
> On Mon, 19 Oct 2026 17:04:33 +0200 Nicolai Buchwitz wrote:
>> +	/* Crypto hardware need write permission for ipsec crypto offload */
>> +	if (unlikely(xfrm_offload(skb)) && skb_cloned(skb) &&
>> +	    skb_ensure_writable(skb, skb->len)) {
>> +		dev_kfree_skb_any(skb);
>> +		return true;
>> +	}
> 
> Why just for cloned packets? Frags themselves may be read only
> if they are spliced filesystem pages.

Right, spliced or zerocopy pages would be encrypted in place too. I'll 
send a v2.

Thanks,
Nicolai

--
pw-bot: cr
