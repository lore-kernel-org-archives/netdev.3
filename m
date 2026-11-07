Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794081167;
	b=t7HH2f5ICB5+By4h/ljsqqSCBYpDsaZTP3ultNFkOamMFC2zOgPm5ukRxWTFANpt9lM/
	 IgAseZq7quyO6AlJr+/gLUnXsyr2w2hbuT75uK5elp/kAzF2Tfq3Es+DmdbQuMef1HarM
	 cubK5vqqWDEa9ks/oS5BkhWKkOjRb9kz5Io3iMDsBC9+qQL5w1raCixKnUa+uGkmFycYS
	 u6NwSmNdi1Bvo/baZPUva5ZfMWCLwXuVTO9v+ttDNxUBxKNmtVRTXHV/vmyHosVTFEJmD
	 hVihTM19SlmjQTsrWOErVrFU0o5FfOTBK9LhJA/7QNftpOR1ONfFvnrkEFks7YZWQtQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794081167;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=7L/MDyWNPktLzS6Yto3hu+NE19udBVCCXoZ+5qjXmtI=;
	b=gY7aYgv3fXVbqDcV0RW3LERlYc49t619ln+tP1Cfhmska0XZTrbG94i8Q4sKXaEUC9U5
	 gZdHG9INDJOvZGg/T7gaAvRy+f0uPVlXbTqtt/b8SQ+i5ckPfSWHNt44SuhKaPGaMsDtZ
	 5lRqP1spkMOZnLN0PYynHabnd6WKW8eUHoKRCawgGsiuQ8VDmEGGzw1EUzGCqAzuE6h0X
	 q5qivil0Uei8OoXkbg91Bc0KrKe8C5SZKdJH41+QYIksJE6h5Iv1O2b3BQ88DwWzFACNS
	 aB9oyT+8kxZIeagF5Y71iuSuZldfh//fUIBoG23J3gBIodC7X7NBJ2tFsVHXhwOmj1w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=fLoTRkFg;
	arc=none smtp.remote-ip=209.85.214.200
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F0FB606A326
	for <netdev@vger.kernel.org>; Sat,  7 Nov 2026 19:52:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3F0FB606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=fLoTRkFg
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2e954d87b48so28248285ad.2
        for <netdev@vger.kernel.org>; Sat, 07 Nov 2026 11:52:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794081166; x=1794685966; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7L/MDyWNPktLzS6Yto3hu+NE19udBVCCXoZ+5qjXmtI=;
        b=fLoTRkFgJWgSDA4ONtKWHN9FvZ+3qYFStgAmqj4fr2ntheFwzGv4QbUUPGaw7/XViH
         JLyiV0u85Hx4K8lD/m/7lTZjeBcXjArDqpYYsP+pJKeXzYW5eN9Ly6kgqJWjW4zJwDUf
         DBN6XRYjxbRWaLDlGQxU1KysEN1ncWGxsl7bg5D3o9Dde/fNYcom5HXfQ/lTe7j6X/uu
         pwed1awUlRYpcigNFD8Wwa0GaQPTPMCi7OOoq/yj5FJjmguJTZesrMJ4DXw2DppTHnh0
         wkw5bhLWYqYwd968GT+MLcgSMciF1VW5AsO4krstndc8rJSi62pzTT19edWtggiQ2WgF
         o3qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794081166; x=1794685966;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7L/MDyWNPktLzS6Yto3hu+NE19udBVCCXoZ+5qjXmtI=;
        b=KFZnmXrcSVXnlh0JMakPbFh+4gsDh1w1lTtq4yzE1dG4hnIkniDMyELeh6Pw5ZcDNs
         Xrv2rlKibibHPJrXPlrL3ZeyXD9LOhy5bPa2c/1FNNkGZatvKjhYsgLcjnO+jSP2hzhX
         U2cuhGjAIswlJwvKzOGHJGtfo52j8mAGK+lsvOmE+WJT0vi7ao9rl43FzKO6bsxmM/RJ
         v+AYdkCD1dxyyr/YfjHNGISrFBLc5oid4Q+8Gds/0T5aIHvor9j1chV9ki+Gp30lhvKL
         cA5PjHykpF9w44o2sUvvoflwzEJgwphpFUWV09DdkTwsFp58byQeMD5EODcAa8zu/Wy4
         +wrQ==
X-Forwarded-Encrypted: i=1; AL+hErGPo96gtMoJ1R8R2zJ5XXtqhOceW1T15VnPUFWcVgVId+lqDPAXYfEGaeQTJbdgwLsgbS8Snh4=@vger.kernel.org
X-Gm-Message-State: APuU4Z+AS79ZU9AOqrDymDSCOERgOtGYTu8KXSYtNM2s6s3kkUUr7TS8
	nzuw4lIE4r36TlUEIcYSi9ClZgfy6Lcfw+lcw7PW51afCo+laZVcytVJoIbPm3HPhSF862j7rUJ
	I2gZkXQ==
X-Received: from pjbpl18.prod.google.com ([2002:a17:90b:2692:b0:3ab:f091:d7bd])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:47:b0:3b0:ce1c:e754
 with SMTP id 98e67ed59e1d1-3b0db70120emr6415623a91.62.1794081166391; Sat, 07
 Nov 2026 11:52:46 -0800 (PST)
Date: Sat, 7 Nov 2026 19:52:45 +0000
In-Reply-To: <20261106110135.2161204-1-edumazet@kernel.org>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261106110135.2161204-1-edumazet@kernel.org>
Message-ID: <au-BcpZWQg0zcb7r@google.com>
Subject: Re: [PATCH net] udp: do not use a cross-family sk_rx_dst in early demux
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Eric Dumazet <edumazet@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Willem de Bruijn <willemb@google.com>, Simon Horman <horms@kernel.org>, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Fri, 06 Nov 2026 12:01:35 +0100, Eric Dumazet wrote:
> A dual-stack UDP socket connected to a v4-mapped address can receive
> both IPv4 packets and IPv6 packets using v4-mapped addresses:
> ip6_rcv_core() no longer rejects a v4-mapped source since commit
> dcc32f4f183a ("ipv6: weaken the v4mapped source check"), which kept
> that check only in tcp_v6_conn_request(). ipv6_portaddr_hash() hashes
> v4-mapped addresses like IPv4 ones, so both early demux handlers find
> the socket, and both __udp4_lib_rcv() and __udp6_lib_rcv() store their
> input dst in the same sk->sk_rx_dst.
> 
> udp_v6_early_demux() validates the cached dst with dst_check(), but
> ipv4_dst_check() ignores the cookie, so an IPv4 dst gets attached to
> an IPv6 skb. ip6_rcv_finish_core() then skips the route lookup and
> ip_local_deliver() parses the IPv6 header as an IPv4 one: the IPv6
> next header and hop limit are read as a fragment offset, and the IPv4
> protocol is taken from a source address byte.
> 
> The reverse direction looks possible too: per-cpu dsts of IPv6 routes
> using nexthop objects have rt->sernum set, and ip6_dst_check() then
> ignores the cookie, so udp_v4_early_demux() can attach an IPv6 dst to
> an IPv4 skb.
> 
> Kyle Zeng reported that such a packet can reach XFRM input still
> holding the prefetched, non refcounted, socket set by early demux,
> which can then outlive its RCU grace period.
> 
> Only use the cached dst if its family matches the packet. Otherwise
> fall back to a regular route lookup.
> 
> TCP does not have the same problem: sk_ehashfn() hashes a v4-mapped
> socket with inet_ehashfn(), while IPv6 lookups use inet6_ehashfn(),
> so IPv6 packets do not normally find a v4-mapped TCP socket.
> 
> Fixes: 5425077d73e0 ("net: ipv6: Add early demux handler for UDP unicast")
> Fixes: c9f2c1ae123a ("udp6: fix socket leak on early demux")
> Signed-off-by: Eric Dumazet <edumazet@kernel.org>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
