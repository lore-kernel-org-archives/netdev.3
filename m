Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793889242;
	b=G5JlGSGLPHNP9YZPN1aETXjc7ewR34YjXFHFDNrRgI3bHLX5dlGPF0gG/l16vO0aUfGN
	 fL9BUgpY4aV/Wo9iL+xb1bYnEBPoMlj97AtLV35RZkM7V4RDGKdWOhMNSz7CpJ80hZ7yT
	 AGMXbEme3EJmT5Q3XmOiSOVjRlyARh2E7irb6X3iVBrlFT21vfDj4HknRX4wx9fK4EpVw
	 bYYYAwvI6YrmlxtX4ldtc9GxXrLThc2ElHsMHRi4cENVcrBP0JRncXIFic8+7W+jgaSkz
	 MaApzR3DfDQX2v0ghewiulVH8/85XhzwdQiwqdiZLPWyL2ckBQ6TGGDx5wcZWbJJ4Qg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793889242;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=NdOrVzG3OCGSr60lMULw/RwF+DfcJzV9jGQLzrSIiVA=;
	b=LWVJe8awN2CvKwt087UuEMdB95CZy973jnU5iIAFkfBtmpDs6nRTfXjkcxRnXIcZpe1x
	 h19Tcilf2AeBy/FbFPkPzrsg6gRXT/j34YFW4JwcXZivWrZRubhwmPbDuLxI5MmyVGOy9
	 OdX6oDBfm0JeVzePIKCWabde9oZ+ANyFu+BtceHNoI1krmkjeKSgUNk2TxwYe4FcYLCly
	 CEmPyny5TGjn1h64Wa69y6wufZymZspQVE/32S69IuemVqIffGV729rogJJuxZs6CVqcH
	 WhWJZSfd8Ll0x7eNP+fnOpFsLs8rF8X3ohVkDP4m+5OllFIzykhiQ55oxug7iJUfIAg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cloudflare.com;
	spf=pass smtp.mailfrom=cloudflare.com;
	dkim=pass header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=RcItvQZW;
	arc=none smtp.remote-ip=209.85.218.52
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C599606A326
	for <netdev@vger.kernel.org>; Thu,  5 Nov 2026 14:34:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9C599606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=RcItvQZW
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-c4ced671398so303340666b.3
        for <netdev@vger.kernel.org>; Thu, 05 Nov 2026 06:34:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1793889240; x=1794494040; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=NdOrVzG3OCGSr60lMULw/RwF+DfcJzV9jGQLzrSIiVA=;
        b=RcItvQZWLu6oodSC2bv8dHfWDL0GIt2qmvKNPvNvKMjaJXxgv9Eyc45gGdT2/H5qMq
         zJMGxlhwIroSZMhz6xRZojb0KdzZDU2epUyYSLcCd5+cR++B1GIvVW9p0ECeyzxaDkIK
         hgp1RiILJ/MVeoe5wK8flNWnrnDvqJCAxSrFXAkIJdAWXJF6iuGgXYpQl+xHbDP9Ph/h
         gukN0UgLTKmH8Axy2gPQvjp+G3thhc0hmclGfbgPV43mdB7r5td40U8/rH6stnGvfcqj
         FdXpbwBKja6bkyyZNo1WXNfPZWsTij547pcq81hOSlQR86GDs6/xrkgDKeK0J2rOJpsx
         FI4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793889240; x=1794494040;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NdOrVzG3OCGSr60lMULw/RwF+DfcJzV9jGQLzrSIiVA=;
        b=Kx/ZjyPy8k/TMWxjrvII8lUCPJsJmglnDAT8c0nysZw8jl/f5uDaNLHyFCa6Abwau/
         iamH8F+qd5AKk7YE+AESflJCj4LzjRezOjt680Xfs7afveSpW9HEqoCgk2594oV21F/7
         blLI1/FgNIkOz4PQjHJxvpdKnla+XE/63UlpZVreQR3g3BQHqCHZzIcgCIBpIi9e7gNf
         3oFN+YneYVunvwuwq5TGULFSxY9wqvphbx2wskAXz+Il+XNFJKKChYthEFkGmpenGJPg
         QjrVtnXv+g3vodkbLvRM4ILCqW8MLvcJIUqyZqJYZG1yUhfVeCMuQQ0bQHr8zs33c9kO
         dz4Q==
X-Gm-Message-State: APuU4Z/9txLP3En8OHLX+dSouZG3dlWguYAVHwPVGLkk6aMKjT2imHIN
	hQOq9xeVJn9DresaB3HfTF5zrOjmRurG7nNHy5xgR2VuqCX87V3MjhEN2fglGbURcyopbYHMYlQ
	QYe5ycXSCvg==
X-Gm-Gg: AYBFou0tWFcITBNvOLZcYYw4a+FwfAMn6qu6PLP8aqLU9RN84m6I+zoJhixY9oUmlSh
	u/v0gQ9/43AdT7qpTWEsZFPbj3q5vwrJbUzW7yFJ257lIqKZP5wMX7pvxVsqYmzvDofo2K8zEB/
	EFQzvl9HQvSsh118yFri1l4i85SKGBUrD/A6vBzorrLp2GuwNe7sQcknJoh/BR6D3piT9LdT6JP
	Kkh9DIPqG3HVh0jaKT5k+kQlUKcwDTRiHMOmn5tf77fDD61v8k8OKVjNiiqPIhjhlcRlczTyuhT
	vTaFKtsLikkc6bnq5WJYYY4YHKhfSr5atCEqg4LPRPXRVjPKEoKz5EvX+xBuVkaJ3KGhMvweoB7
	NErOnDKdyk0Owgq1H9rhPdXwVNvb9lOwVT5Y0H7AMzZ8JjNAcwRlhyRrjjKVgfvUG+f7xAoai6E
	JibehS4oFRW/uOqgJg4IdhcbFyDXM8K1I4FGsjfFmdYe0ZRuk6lbLAVLUEbLxg20SAsodoVhxwY
	8zNZZw2wAIVNGjH3VtYkyEgrpHvbqig6LL0vb0Vr+2kLLX4XAPkDd6TXhyRSXH7yDyegPLxAX/Z
	SoyZo3TIA/OoUMGmj0SBVXW90sUBSJLfH9pmn8H37NQlwzyGgWIxd8ezR5BEp9h7iHau
X-Received: by 2002:a17:906:f59a:b0:c3f:7e8:235d with SMTP id a640c23a62f3a-c4ca792f92dmr1718115666b.5.1793889239960;
        Thu, 05 Nov 2026 06:33:59 -0800 (PST)
Received: from L9JK9NPFH9 ([2a09:bac6:37ad:1e5a::306:b])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4d0e466be0sm178671066b.54.2026.11.05.06.33.58
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 05 Nov 2026 06:33:59 -0800 (PST)
From: Tianyi Gao <tianyi@cloudflare.com>
To: netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	toke@redhat.com,
	lorenzo@kernel.org,
	horms@kernel.org,
	bpf@vger.kernel.org,
	shuah@kernel.org,
	hawk@kernel.org,
	kernel-team@cloudflare.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	linux-kselftest@vger.kernel.org,
	jiayuan.chen@linux.dev,
	Tianyi Gao <tianyi@cloudflare.com>
Subject: [PATCH net-next 0/3] veth: link RX queues to their NAPI instances
Date: Thu,  5 Nov 2026 14:33:53 +0000
Message-ID: <20261105143356.17062-1-tianyi@cloudflare.com>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

veth does not link its RX queues to their NAPI instances. queue-get
therefore reports no napi-id for them. napi-get lists the NAPI instances
of a veth, and their thread PIDs when NAPI is threaded. It does not show
which RX queue each instance polls. Userspace cannot tell which NAPI
thread to pin for a given queue, or which NAPI to change with napi-set.

There is also no way to busy poll an AF_XDP socket bound to a veth
queue. xsk_bind() takes the socket's NAPI ID from the RX queue, and a
veth RX queue has none.

Patch 1 is a cleanup to ease review of patch 2. veth_enable_xdp_range()
adds the NAPI instances only to pass their napi_id to
xdp_rxq_info_reg(), which no longer uses it. Patch 1 moves
netif_napi_add() into the loop that enables the NAPI instances. It also
removes the arguments and wrappers that came with adding the NAPI
instances in two places.

Patch 2 calls netif_queue_set_napi() in veth_napi_enable_range(), after
napi_enable(). In veth_napi_del_range(), it clears the link with NULL
before napi_disable().

Patch 3 adds RX queue NAPI link checks to veth.sh. The napi-id of every
RX queue must match a NAPI instance of the device. The queues must be
linked only while NAPI is enabled. The checks run with GRO on and with
XDP attached, and across RX channel changes and link down/up.

---
While working on patch 1, I noticed a pre-existing race in
veth_disable_xdp(). Jakub already pointed it out in [1] and suggested
fixing it as part of Jiayuan's series. This series only drops an
argument on that path. It does not depend on that fix. If the fix does
not end up there, I can send a separate patch for it.

[1] https://lore.kernel.org/all/20260917185814.0f944e78@kernel.org/

Tianyi Gao (3):
  veth: refactor NAPI enable paths
  veth: link RX queues to their NAPI instances
  selftests: net: veth: test RX queue NAPI links

 drivers/net/veth.c                  | 83 ++++++++---------------------
 tools/testing/selftests/net/veth.sh | 79 ++++++++++++++++++++++++++-
 2 files changed, 99 insertions(+), 63 deletions(-)


base-commit: 0822d2fe38262e8b55c5ea55c970022bca8dd2a9
-- 
2.56.0

