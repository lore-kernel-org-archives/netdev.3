Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=43.154.197.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793262840;
	b=PaEW+YGSTaTbeL7vhVWr54NJGihkg7MwUBo1KNq8yn9fN8uEzbQCQd79Innbrv6bjsCt
	 8FBZK9/jz7GEuF/cTb2KD3Y9MT9qyGzip6f4RpmNJJMUqi8MXZywvB710epcicL594j70
	 m/wtMxlrof/LRUaZmWmphFCkYQLHaR3g9zciNsrrYr2M/rwzS0/FOOdegnfXvKssKqYqc
	 ANfdaEP/03pYn+TgAyrN2Tr8JIXHgLg6Tjna0nymnPg0wYHuuoV8TpLI1mjf327gWGGsD
	 6kss4O1ttRa2R/Q2AimiQNzntsNVNiB2pXhxxBN2Cupw2HdNod548Y57LHPBPN6gVHg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793262840;
	h=DMARC-Filter:DKIM-Signature:X-QQ-mid:X-QQ-Originating-IP:Received:
	 X-QQ-SSF:X-QQ-GoodBg:X-BIZMAIL-ID:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-QQ-SENDSIZE:Feedback-ID:X-QQ-XMAILINFO:
	 X-QQ-XMRINFO:X-QQ-RECHKSPAM;
	bh=oLjLlm6d05PAVJP2rYWwLbOI+yWp6mAuqGSOFUBSRHE=;
	b=l/LoOWqiW+KnArcpjAvwj4JTEFZQYwlWKTmfcI+eAf6iwFnkQCeP71rRsLvnjLOcIKnT
	 C82N50rbxH7a6oXyR8QWXDkoH1p5pvQh+hS4O1/t5HXE5cUZIB0sgf07Nx8tGTg6XpWWR
	 he871bx59TC2BQqsLwWcLPEE6lbeHmykTilKTRutqnHq7XGk2sJKCHIxS0L7c4qm7hvRS
	 F1+t1Xr6JVnicPmQPhbJlyUdxu/RmL/hAsN+/55JPlW1fJdK9INKMzafqeUqRaV5mlscW
	 AdftKrsCRGLzBI61K9YpCCg+/9WZxJh3Q93vjQUq6HyAFVSZXAYR+gD6udlRtfbUm+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=tencent.com;
	spf=pass smtp.mailfrom=tencent.com;
	dkim=pass header.d=tencent.com header.i=@tencent.com header.a=rsa-sha256 header.s=s201512 header.b=ZzHMRzmH;
	arc=none smtp.remote-ip=43.154.197.177
Received: from bg5.exmail.qq.com (bg5.exmail.qq.com [43.154.197.177])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED21060A2610
	for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 08:33:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ED21060A2610
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tencent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tencent.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=tencent.com header.i=@tencent.com header.a=rsa-sha256 header.s=s201512 header.b=ZzHMRzmH
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tencent.com;
	s=s201512; t=1793262827;
	bh=oLjLlm6d05PAVJP2rYWwLbOI+yWp6mAuqGSOFUBSRHE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=ZzHMRzmHhVIKpKI16bgSorQxBB5/FPw9285hjvhRlyzTE8sqwWRNsGD93LtiKoVkS
	 Ao2ycPUfQvQJPS9T1UeETTg57Z4LRSMEeFmc3EUCeIlepcjXkER36Gn+En8Cr3DK7A
	 x5TMB10zqEe7y+EoBleXnehAgmU5nxC/4jQCoHL0=
X-QQ-mid: zesmtpsz5t1793262827t92aa320f
X-QQ-Originating-IP: N04cQZPh+ePcyPfUaJ+nQimqCFa/Iu7vFxXbmwamb3g=
Received: from localhost ( [9.218.227.176])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 29 Oct 2026 16:33:45 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 14796253007528086033
From: "=?gb18030?B?dGVuY2VudG9zX3NlY3VyZShUZW5jZW50T1Owssir?=
 =?gb18030?B?uau5stPKz+Qp?=" <tencentos_secure@tencent.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org,
 David Ahern <dsahern@kernel.org>,
 Ido Schimmel <idosch@nvidia.com>,
 Paolo Abeni <pabeni@redhat.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Willem de Bruijn <willemb@google.com>,
 Steffen Klassert <klassert@kernel.org>,
 Eric Dumazet <edumazet@kernel.org>,
 security@kernel.org,
 steffen.klassert@secunet.com
Subject: Re: [PATCH net 1/2] net/ipv4: reserve exthdrlen as headroom instead
 of counting it in skb->len
Date: Thu, 29 Oct 2026 16:29:29 +0800
Message-ID:
 <ipv4-fraggap-review-p1.5c53816d985b45c391671df3826be282@tencent.com>
In-Reply-To: <willemdebruijn.kernel.754d523a3a4@gmail.com>
References: <v2-20261026-cover@tencent.com>
 <589B4474E0A78486+v2-20261026-p1@tencent.com>
 <willemdebruijn.kernel.754d523a3a4@gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:tencent.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: NrAe7+WDJxFXFEpgTVe0NYgXxcq9rZQhFKJoERK4mKuqhudpVZlKTnYx
	Fbtd0aTnMi2GiBQKXIQkGv52vGvQy7rXPJxzy8ELiYbFAP4u3TvyqcZcwSH24tOB3FhK+o3
	m/dJQcTU4gTJXws3Cw9lnXxJguuT+40zk67Pazw90hJt1gGxdYxYinSS6mXpIhDu/2jpKy3
	hjiMlnS0VFDetCwQNkAm1kTkYIhYmOcJpnaKx5guqJbOBDjMqINYiBtg9gNvrgbkhBFLGpF
	FENt4WUB5O0E4xV8QVHt9322XSEKbcrsFbVGq6oM4s/kWkptV4beLVEMvXo9ABN+kyY7fWV
	fKEi9370xs1kIJG+QJDyYKwgIn+gQy4/K4zc6a8wOqZCvyVZ7H0vl7vEYB3+DHZpBwODCnB
	pH/6RzRGUGMU2tvy7/rexcfkCpPSXFTjh2dRm3Wl47DhdrFQFkjUsT69ry1csURaYV5UFJi
	0F0mPoE+CLLPcUvEdHUPdn8fDk4hB+wWcyk0qVGyXf+gLyghRQZVYp2KhqKLEClkcvjkiNc
	aa94dYhEXTcVEbyHP7v0n2Fe6UYrnvym8EQRtbq7iauPqQhyaf+r02TJnAaoFN2feKAAs4z
	c8XLeWqfL8Os1ifwMMoJDiTGGF9tAWVJKfAcHE2+zDFrOxXA39H9H52dAXOpZ8V9kW7BT5C
	m52qS9VPMuA/te+0K4RAwuejarj6YXgugdvGF687jMbOOOrnxirW+ITcJSv+gFmceqzNSs/
	lJ/KKYzZ+JGVDlQShkPBplipLNK65zmbMLKO+a1cpNo+jPgWKFKLHrHPH67X0lqKFX0wZix
	sCg3B4CK5Xd8YhdEl1eS0PNVF6q9JH0KCN+68SYzShKWGCnTPNFxw0uGq3LZ1FDCnnJyyAv
	PaEl5CVy4V836RpOuzNydxqyL+wfH1TQ0nT6YlPCxluUU6b4wbW3U8L+IBozsX0BhuCq6zg
	/BHdvzVvFv7/rxxV7e1FCbaqUrM8AMdFxzVRinNfYwVx5JA==
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
X-QQ-RECHKSPAM: 0

Thanks for reviewing this and involving the IPsec maintainer.
I understand the concern about stable backports.

For the same inputs to the skb setup block, the allocation request
is unchanged, and the tail offset is equal before and after:

  hh_len + (fraglen + exthdrlen - pagedlen)
  == (hh_len + exthdrlen) + (fraglen - pagedlen)

The network and transport header offsets from skb->head are also
unchanged. The initial pull in __ip_make_skb() becomes unnecessary
because skb->data already points to the network header.

These are local layout checks, not a proof that the change is
semantically neutral: skb->len intentionally excludes the reserved
space, which changes the subsequent fragmentation calculations.

Also, my claim that every skb has len <= maxfraglen was too strong:
an skb can reach mtu, which may exceed maxfraglen. I will correct
that wording in the next revision.

Understood on IPv6: the corresponding variable is dst_exthdrlen.
I'll wait for the additional review before respinning.

Thanks,
Anakin
