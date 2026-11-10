Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794329082;
	b=s/pjT9NTdn5VCcSdnxZFv7wq+3Lw6dt6NvRpnoPLaeDMbIbu3x6Y2SgKGtOQUmXTc/1F
	 C9oyqex3tQ8mSPSsPwymsL2YerwYaKrUGTLfQOhzfICpvxa5xNRrDCDMBloLpbs/i4A+H
	 eYWq93HbyJOdRPAUNK8VLyNfDXOYOaGwd+NQ5FdqmRUEvE+ikL0Cyz8haBdT9s5wp718p
	 BFxijsFMCdYI1uWAk9isnArIq+pEEL+z44nDStXh5HvCwgz8j3toLTslpLC4s4WTFIs/x
	 GTOxEj7Nn85GKiOsDhAdyta7GD/YIPjKfK6qaFfybs8EMfauGtXmtYJOZTfQpRWIL4w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794329082;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Reply-To:Subject:To:Cc:
	 References:From:Content-Language:Organization:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=sxHO/XRSSDGO24lkBwodiv8/f1Z8PZDMLrCuaK/Ihu4=;
	b=rR6B2bBnlUIKoR7fmtMGBCqoCiKO2i/5sVvLBZuJhRf3Z2QF8T7zdXuwc6O4opEMUJht
	 e4QJEfF1tf6Fsk5MzQdylNZpVXZ6Lb9QLpDiqKl1fdCLLDVAtidLDkYr1GktO6pJ2G985
	 PeU2GJDOSFe72pWQh33fPzLKcsqX5WjU/xuz7yZKFmAXwJzrZcglM8hR3rVnb7y5QNC3x
	 EXIk62kKQLqdgM1k31QVDb+XpbfI16lMBUkucwpj9m2tflDDRyb2TE2etkpmy3OnFlvsI
	 8UJVT7wcGmi3a/Bw8AYPtoXrUFljHkeNAJjuv1ktxDSVJRo1cXuMPvmLW6xhni4+xbw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=6wind.com;
	spf=pass smtp.mailfrom=6wind.com;
	dkim=pass header.d=6wind.com header.i=@6wind.com header.a=rsa-sha256 header.s=google header.b=JLWCgSrI;
	arc=none smtp.remote-ip=209.85.128.43
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 215B9606A320
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 16:44:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 215B9606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=6wind.com header.i=@6wind.com header.a=rsa-sha256 header.s=google header.b=JLWCgSrI
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4a2119feee8so1719495e9.3
        for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 08:44:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1794329080; x=1794933880; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :content-language:from:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=sxHO/XRSSDGO24lkBwodiv8/f1Z8PZDMLrCuaK/Ihu4=;
        b=JLWCgSrIdZKp+RNAnWKB/Fqv8WAzdkJlqXy/zYWA8AD0tVysl95INoukVUQ39MxcWf
         jnsyDGHJJ50Zf80Gxzxys9zUPyNqyjHfGfSpA7b3xXhiPrh/PojI2ieNNRpKxcrhhIXQ
         YjpMSSB4eB+vd/VWRUoUgxYXN7JNBXUGWjcQGF3gComsK/PqMdwYHrzCYE2bJ6SCxr1C
         LieM95dzYXrWSDo74PAG+f3Zi3YW7Mvp9xXzc+RY+Ej5GVDAwDuHJQ83hjCZR1Bel5Sz
         H/qaLCgRCEB1lzaGVg7l4NH4aijphDqgXtIfZ6gJryui2a2lAnD6Br/LiR0e6XuECwA4
         PzNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794329080; x=1794933880;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :content-language:from:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=sxHO/XRSSDGO24lkBwodiv8/f1Z8PZDMLrCuaK/Ihu4=;
        b=rTwP2fSVGB11WNWcQiCaVxUe1XDB5pqzTedMk+k8R9iHOK4gPV5Est43dkVsws/qjP
         uZobPzDgLbO8gvbMtiO0qW+nHu7qJ+7sZPckdjIs7dPvFR1JAN71jlsoDOLh9sUubTfe
         SAlayJ05mlI64vcS5jsuMlaZNCFRqfjs/9y3MQ/z5shqKosgVo5Ky802c8YUVaAdFefh
         3Ezqzw1KAqDcBB/1urf9vU9FGX48J7ejg85ErcQirKJNY2D97aYH/Xqqp2w0L+NQE6+d
         z2OaeGvfSKJdyq9g5hews9e6Ajbk/dhszwAMLCLwWrgczG/o9nYWPut2XcEai7RtxNvU
         jsAA==
X-Forwarded-Encrypted: i=1; AL+hErGqn6ofOIFysnEEcYuh80RVVNRzylBRDl1f7YZew7Cuo/B73xSBCq8KI2lDyLyw0GkXSX6xLyM=@vger.kernel.org
X-Gm-Message-State: APuU4Z/kyQaewvsS91hBZj0QNmfNW3v1egiItwr8KtxEOVNw1+1ZgCF7
	DJmWiA0Kab21jRbeVntgu/cYbH/OuJHDdHuhNNZpGrQIZGDCNfZ72uLXEf4nvsmQJs8=
X-Gm-Gg: AYBFou246NrNQ3YOsKZJQ8nj6VT4WCn/ifDsqhjS61n/CIsJ3FMB8G/tqpfeTIfDMlm
	fszhSG9ELtoN7C9pcPIfxWcKvfOWA74nhVjLMD+plaapjIhAFXSXhEFsVniT7YtEK9M//BbidiP
	fzcEUdKE70Rd/BsdBVMwQjz82w0lKt30GtKgoA5W5NPpTrtgAkrIKEOHGLqaybiLYC12B5yijK2
	cfaNUgz+hlFq7Du8P1bHmbjWXhftpLUvB5tjEsHyLAoqAqIOepaJ02J+RAIh1ir/AptZ1FZrDXq
	yinh+bcGRLsu/JXt0BUnC89hhLJIvXfS2AGwdRfN+FE6t2EeqLkVBmVj1v3JB679b+2UT8egWr6
	mvmjbP7kyH4riv3Kro+f+aELWbIQJrUzr4G4OT4PW1NXbbIEZ9nociigqjp4EOuvRDpasRJvpx2
	g0rky+lsooixQvGoS7oxvIH8boq7OXBg+FJCfxRBzAEexuyixzKDUyL2hZcHHCqEQfCwV3TggkR
	rmjYV0kMy0YmQKxvdv0jz2aFn1obsCtBK4KEKPgCZVGqLluSJw4WgZ/Vp+MGBf8wIUGmTUsyqCm
	xcCYDgI76CN0wkT1JGZd4q0lKbS3/NJjDYoqjblzeVPt29jKBAlTon2yS63BEfRGxgyQEKFuHaq
	eRzap9Q==
X-Received: by 2002:a05:600c:350f:b0:4b2:3c81:103 with SMTP id 5b1f17b1804b1-4ba0233a711mr54346865e9.2.1794329080434;
        Tue, 10 Nov 2026 08:44:40 -0800 (PST)
Received: from ?IPV6:2a01:e0a:ab7:2110:6a1d:efff:fe52:1959? ([2a01:e0a:ab7:2110:6a1d:efff:fe52:1959])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ba02242bd9sm68388325e9.15.2026.11.10.08.44.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Nov 2026 08:44:40 -0800 (PST)
Message-ID: <e8066ad7-7a0c-4789-8859-371aa04fd652@6wind.com>
Date: Tue, 10 Nov 2026 17:44:39 +0100
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
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH net v2] vxlan: reset the remote's dst cache when snooping
 moves a MAC
To: CMGS <ilskdw@gmail.com>, netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, kuniyu@google.com,
 mschiffer@universe-factory.net
References: <20261110153020.9635-1-ilskdw@gmail.com>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Content-Language: en-US
Organization: 6WIND
In-Reply-To: <20261110153020.9635-1-ilskdw@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Le 10/11/2026 à 16:30, CMGS a écrit :
> vxlan_snoop() handles a known MAC that now arrives from another remote
> by rewriting the remote's IP address in place. It leaves the remote's
> dst_cache alone, so the next packet to that MAC is routed with the dst
> cached for the previous remote. When the two remotes have different
> next hops, the packet leaves the wrong way. For example, if the
> previous remote was on-link and the new one is behind a router, the
> device resolves the new remote's address on the local link, the
> neighbour stays incomplete, and traffic to the MAC is blackholed until
> the cached route is invalidated, such as by "ip route flush cache".
> 
> The same branch also leaves remote_ifindex unchanged, although the
> early return compares it and vxlan_xmit_one() uses it as the output
> interface. When a MAC moves between an IPv6 link-local and another
> address, the remote keeps the previous interface, and every later
> packet from that remote enters the migration branch again.
> 
> vxlan_fdb_replace(), which makes the same change through netlink,
> already resets the cache, updates remote_ifindex and clears offloaded.
> Do the same when snooping.
> 
> Reproduced with network namespaces: a learning VXLAN device has one
> peer VTEP on-link and another behind a router, and an inner MAC moves
> from the first peer to the second. Without this patch, pings to the MAC
> fail after the move until the route cache is flushed: in 10 of 10 runs
> with one CPU, and in 5 of 6 runs with two CPUs, where it depends on
> whether the sending CPU holds the stale entry. With the patch, they
> succeed in all 16 runs. In a second setup over IPv6, the MAC moves from
> a peer with a global address to a peer with a link-local one. Without
> this patch, the move and every later packet from the new peer each send
> an RTM_NEWNEIGH notification, 33 in each run. With the patch, only the
> move sends one.
> 
> This was found by our AI-driven automated live migration tests. The fix
> and this changelog were written with the help of an AI coding assistant.
> 
> Fixes: 0c1d70af924b ("net: use dst_cache for vxlan device")
> Fixes: 87613de95041 ("vxlan: fix snooping for link-local IPv6 addresses")
> Signed-off-by: CMGS <ilskdw@gmail.com>
You should put your real name.

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst#n463
