Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.183
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793776939;
	b=fdFpKVQ5ibByS9DVYnowH85Um2TCY17jsJszxlKikcRcxalQSKfiaHX+MPcISUCDHvHJ
	 rxr5xmKdWkM+yzCj8DsZ42eUIGFzVPPEuM9Ep0U5TQfx6by5yY5eVknV2WGH7hS85KEOm
	 FzVYhd/9Vuu4dI+6W78gfN5J15FkOoXRYLGHEr7KEnsp63n0yeB2DB9y39MjjFkb8tfq/
	 m18dXwIGHavW+6MLDOAKe3/tOp7aA3PdDZwpeSB0VeXy2w4Ufijcw2gv+/sMl2xOYTm8c
	 7f0mG6aW12PD8G9i0J4yJcAbDs8O6JH01svLc6tsVbHlpeS00PA8DTrQw2mrlIKV7jg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793776939;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=trfQHpaVqDGj7pdAxkIIwslilgVOcChYAvf1fDtPzO0=;
	b=KXUJLU17JUVhgsPXV3CxQ39y1VGObDp5TnuKUBSoMApXj3YtRtOaRwgMDxZxMEkIko75
	 RzdbxDF+++zQ5GfgPkjmgC5pBrhjM4op226r33u0o7E3C5X+qr7XmlZXEREres5w8rOHT
	 MjiJ23yVhw4PnUK2AkJq/JMlawxAs2XXMlJEqd6sCbOBJL6SGKWnshe+owoXi09tceeda
	 Xh5M2yJeXalFpNU/VOhRT6MByyTSFWkY1QZ8dphrqrZ0prxrlGH+UYgQXiMqgL/CuswrT
	 B66OVEeZ6eozq4Ztwn81XjgAFZ586Td6CKzT81L5oSrG9ZQwJX63o3d+5BZi3L2UB3g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=nuqfDbJI;
	arc=none smtp.remote-ip=95.215.58.183
Received: from mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0038606EE8E
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 07:22:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F0038606EE8E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=nuqfDbJI
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=pecwVT+FWwXBdSwWG68tGA8FhqyjXhg5eN//at0UjTc=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793776937; v=1; x=1794381737;
 b=nuqfDbJIDq2BB7h6N42DikY5/Xxs5nZU3Go4qtLSqXYn9QWX7gwgWu+eDZWSP6vOrgetcwYN
 CCFa+EVJUUZp6PF54fkJX0py2yBOQAhMGZXhBuu5+/Wz2KInw4V8PSpPokKxB4t0JWeCHmmqcjd
 jMYBd7s2CxBh8jS2ufH2fEqc=
X-Envelope-To: netdev@vger.kernel.org
Received: by mta12.migadu.com with ESMTPS id b4b72a2dcdbcfd1f;
	Wed, 04 Nov 2026 07:22:16 +0000
X-Mizu-Trace-ID: b4b72a2dcdbcfd1f
X-Migadu-Flow: FLOW_OUT
Date: Wed, 4 Nov 2026 15:22:10 +0800
From: Hangbin Liu <hangbin.liu@linux.dev>
To: Minhong He <heminhong@kylinos.cn>
Cc: andrea.mayer@uniroma2.it, davem@davemloft.net, edumazet@kernel.org,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	horms@kernel.org, linux-kernel@vger.kernel.org,
	Andrea Mayer <andrea@common-net.org>
Subject: Re: [PATCH net-next 0/3] seg6_local: add USP and USD flavors support
 (RFC 8986)
Message-ID: <aurdIlNaqMGsBdkr@fedora>
References: <20261103063806.132152-1-heminhong@kylinos.cn>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261103063806.132152-1-heminhong@kylinos.cn>

Hi Minhong,
On Tue, Nov 03, 2026 at 02:38:03PM +0800, Minhong He wrote:
> RFC 8986 defines the PSP, USP and USD flavors for the SRv6 End
> behaviors. Currently, the Linux SRv6 implementation (seg6_local)
> only supports the PSP flavor (combined with the NEXT-C-SID
> flavor).

No, the kernel will not process PSP when it is combined with
NEXT-C-SID at present.

> 
> This patch series adds support for the USP (Ultimate Segment Pop
> of the SRH) flavor to the End, End.X and End.T behaviors, and for
> the USD (Ultimate Segment Decapsulation) flavor to the SRv6 End
> behaviors that perform the decapsulation of the packet (i.e.,
> End.DX4, End.DX6, End.DT4, End.DT6, End.DT46).

Thanks for the patch. Unfortunately, I have already started this work back
in September. I discussed my plan with Andrea at that time. Sadly, I did not
mention this in the cover letter for my PSP support series[1], that’s my mistake.
I didn’t expect someone would skip PSP and start with USP/USD directly.

Kernel changes alone are not sufficient, we also need selftest updates for
this new feature. So I’ve begun adding PSP support for End.X, along with the
corresponding selftests. The USP/USD kernel updates are already in my local
tree.

That said, there is a sequence for landing new features. Right now we need
to wait for Andrea’s NEXT-C-SID and PSP series[2] to get merged into net-next
first.

[1] https://lore.kernel.org/netdev/20260922-srv6_flavors_endx-v1-0-4d01c05c47b7@kylinos.cn/
[2] https://lore.kernel.org/netdev/20261011192310.55-1-andrea.mayer@uniroma2.it/

Thanks
Hangbin
