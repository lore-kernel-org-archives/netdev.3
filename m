Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.155
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792602244;
	b=Ax0wk4TO2JVtgXQcF0dFv6aGf+rj30rvZHGX3BtK/t26jOMyAyDd1a/h2tyWGNWC0EmF
	 7Jr2tj6IrTJiCQESGhQ2jyCxOvYTBqIbRR5HWhuL0wRqE5Wt+qJULiEDqlAUEVrzC8fFI
	 1910Nh2dRTPrrUM1NyiHZjB/0HKsBWiuS/oDz+NrX7bvOl/iUk+zF7BOY/qLzTrBpRzAg
	 lMUKFM8S6rS7oyVerGGZS+U9qMjRgYdRB/o6RTDH2xFI++VRc2zWYyQuKzvI5oawqdFqw
	 EbaUz3eK5BO/s6y08ZQ+BQ5Cpz+FH0apGFcUkc+HIDAGYqgzEAhKkQyAs2y9O5KEusw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792602244;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=XxkAtzk3cuV4R/7ZEJ4B77roig8TiSn44g1A3T9utgI=;
	b=Q/zmVjag4inN4U/ariifA20ZScqb9/+/LwrwEY+23fyXI2dhQw6yuQdpFdTMtKNSr9cr
	 q507WcVE30ZcKJ9q33Uz8NUryRzgZkD6xKd39sfS7rufbCQPH9mv53mjYa9YTER60HLsM
	 wt5P7QIbXcDyQ5aE3Iu6r2OZMyTr19czOh82Fvjjk8fGv8Qb+fXZkeQuIw5fUvVcv8TYJ
	 uht61wJUQkHW2S71L3V9eMANWxi03BGRoNQ2tjhdoyHKPHsvAFm0Gi6sLUNcZvR25jaxS
	 njjaqRpoIjR47uuLC1W0U1wnl0vN44xM2nkjadA7URpqqrpTFVTVUjtJFAEiV43agbg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=OKzhBjGE;
	arc=none smtp.remote-ip=91.218.175.155
Received: from mta0.migadu.com (out-155.mta0.migadu.com [91.218.175.155])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C43E8606A31D
	for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 17:03:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C43E8606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=OKzhBjGE
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=xxzknvAGwBqrx+ryt5T3qM3aIvNfAZ9P3IcDt4rnT4w=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792602236; v=1; x=1793207036;
 b=OKzhBjGEncpgo3Uz3/LILxAqU/+xcGGiC7mavksAJYiq3PMGFkBOisxga95iE3oHTTuyKuhB
 M6cpiiUbcmVjfp75wVT6QnKK+Ui/yyjMS1BAZAZsCmOKVzrhmHTOh4+AZbDa6bzIAftpDE2xSeR
 qiZVGnmdkMLCYqQCxM8nt4/s=
X-Envelope-To: netdev@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id d445459a510384bd;
	Wed, 21 Oct 2026 17:03:56 +0000
X-Mizu-Trace-ID: d445459a510384bd
X-Migadu-Flow: FLOW_OUT
Message-ID: <51ccddcc-53b0-47cd-9526-ccd825f0f6d9@linux.dev>
Date: Thu, 22 Oct 2026 01:03:48 +0800
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
Content-Language: en-US
From: Qingfang Deng <qingfang.deng@linux.dev>
In-Reply-To: <CAL4WiiouaJ5QU24uKt=CuxpfgHmWHS5oxoE2E_C6KFCLbDh0+w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/22/2026 12:31 AM, Eric Dumazet wrote:
> Le mer. 21 oct. 2026 à 12:27, Qingfang Deng <qingfang.deng@linux.dev> a écrit :
>>> +       case PPP_IP:
>>> +               skb->protocol = htons(ETH_P_IP);
>>> +               break;
>>> +       case PPP_IPV6:
>>> +               skb->protocol = htons(ETH_P_IPV6);
>>> +               break;
>>> +       default:
>>> +               goto drop;
>>> +       }
>>> +       skb_set_network_header(skb, PPP_PROTO_LEN);
>>> +
>>> +       segs = skb_gso_segment(skb, 0);
>>
>> Passing zero features to skb_gso_segment will linearize every segment
>> prematurely.
> 
> Good point, PPTP and L2TP do not need linear packets.
> I will pass NETIF_F_SG: checksums are still computed in software by
> skb_segment(), as openvswitch does, and ppp_bridge_xmit() linearizes
> segments only for channels without direct_xmit.

What about NETIF_F_FRAGLIST?
