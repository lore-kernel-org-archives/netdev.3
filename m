Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.110
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792635519;
	b=hH+81fk2xcR3LAMNgVc1XUy9JWSza+sYg5iXVhYTQVuNHg+smbqaWuWBC3XJlxTz8XyP
	 8vh9Ra+R3RcgeeV10hBElKvhLIe8Uz2geRhJRsTS3orhJx0p/zXqLe2xWApM6ABv3JiY7
	 U1grw34u+3KDwIIc8jhfD5VfpVyk6g8vkY1PzgX2N7y4WRJ/Jt26orL1vUMrv9vKof+Cs
	 kfN1okfjNeE5eTfUQCgI+4ZiAev8f7NKWzc8YtphKsFZXLx9y/192w1kgqF82Imc/i/zP
	 pkmGoaL4nnidAF1URVs1yPzQOhtbMekkYMA0CzsO4omdyT4SZlF7BCMGWjdhAazxUXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792635519;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=V/bK1oHMn1rt+dKdcCYOSmcwkHw/5HHuvQOfHL/lIbY=;
	b=x6aCG3S57sdKhKRMAJY+c9qaSX9t3W+I2VREJvXClFM2PJj4I1bJw+GjtSJ/shQO8NT+
	 G/gIN9jYUDcPtLE45FSErfDK6ucb3jYQ2Kx09Kx709xUBtz0nTm7uEaQ+WIdoLup5PnbS
	 9DFs34zYOEgiepQ6TAzWG9nhVCIwH8KhI4PnY3cT4nW2OC7dnJhVDzWSQ8TK5BKEQyYzz
	 KGHsErjGY2hW0+IiBrAMIo4RJyQmp3kSCpEr4wtb5nTj2PkLHuEsb5Nj/UgTD8MIDUOKE
	 EVU5t70AZbPsIx+CnAsSokz/CEyj2pRaN3iEiUmXZGzyBXZhAxB//o0CXee0ag+n1Rg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=HgAXSlwc;
	arc=none smtp.remote-ip=91.218.175.110
Received: from mta0.migadu.com (out-110.mta0.migadu.com [91.218.175.110])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AE3C606A337
	for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 02:18:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7AE3C606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=HgAXSlwc
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=ooqyk9o6+mpPrkv3GOQDSDUiZawfX8BzqiIhm5l6pnQ=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792635503; v=1; x=1793240303;
 b=HgAXSlwchmv9Y+9KUXMqqEP/X3dvSR4dnagDzZyQV+xIkneaqn9/Mevv0XToW189HH8UMw4d
 w5SpfGVvRFduIkWS3FUDNKxEK/i3LgWWusv1sAwtkoB6kl9DTC5Pl7hweELWfDiPGfZMuJ/WePj
 BurxRwlRCGPDBb0udenPRyrs=
X-Envelope-To: netdev@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id e1ec92438c6690db;
	Thu, 22 Oct 2026 02:18:23 +0000
X-Mizu-Trace-ID: e1ec92438c6690db
X-Migadu-Flow: FLOW_OUT
Message-ID: <b3091ab0-0e1b-4835-ae36-14978af46fa3@linux.dev>
Date: Thu, 22 Oct 2026 10:18:12 +0800
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] ppp: linearize bridged packets when required
To: Eric Dumazet <edumazet@kernel.org>
Cc: netdev-bot+sinfo@kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Breno Leitao <leitao@debian.org>,
 Kees Cook <kees@kernel.org>, Taegu Ha <hataegu0826@gmail.com>,
 Tom Parkin <tparkin@katalix.com>, linux-ppp@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 James Chapman <jchapman@katalix.com>, Sashiko <sashiko-bot@kernel.org>,
 Felix Fietkau <nbd@nbd.name>, Pablo Neira Ayuso <pablo@netfilter.org>
References: <20261021023608.55867-1-qingfang.deng@linux.dev>
 <179255036282.3290.8488375760281728576@kernel.org>
 <c0f348bf-0e13-4cb1-8014-cd9b7787bfe6@linux.dev>
 <CAL4WiirRPnbSBgcoh8Aiq8zGVzsy34w9uaqAgSKQwpgJ0ht7aA@mail.gmail.com>
 <315a8794-db40-4d0f-9e4c-0cad66174bff@linux.dev>
 <CAL4WiiouaJ5QU24uKt=CuxpfgHmWHS5oxoE2E_C6KFCLbDh0+w@mail.gmail.com>
 <51ccddcc-53b0-47cd-9526-ccd825f0f6d9@linux.dev>
 <CAL4Wiip2F59XO3BrjUHVrFqYMuD-LxNmZXhtftkV-JG0Ya84Yg@mail.gmail.com>
From: Qingfang Deng <qingfang.deng@linux.dev>
In-Reply-To: <CAL4Wiip2F59XO3BrjUHVrFqYMuD-LxNmZXhtftkV-JG0Ya84Yg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2026/10/22 1:55, Eric Dumazet wrote:
>> What about NETIF_F_FRAGLIST?
> I do not see your point. Can you elaborate?
>
> There’s also nothing left to gain on fraglist packets.
>
> SKB_GSO_FRAGLIST packets already go through skb_segment_list(),
> which just unchains the original skbs without copying, as the fraglist
> test run showed.
>
> Frag_list skbs that aren’t fraglist GRO go through skb_segment(),
> which with NETIF_F_SG already shares the pages of the chained skbs
> instead of copying them.

I've run selftests and confirmed that NETIF_F_FRAGLIST is unnecessary here.

One extra finding: passing NETIF_F_SG conditionally can avoid an extra 
reallocation in skb_linearize().

segs = skb_gso_segment(skb, chan->direct_xmit ? NETIF_F_SG : 0);

