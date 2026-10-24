Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792834221;
	b=2qGN1kyeh9QMR6z23aKhkWHOrQEMIJ8dZFYu3VaKbOh/BTIuBQhWiCcKjgW+JeXAjivz
	 NQmjRFKJ0x3oxssybT/zw38i7I8pgjQ79hRW995+NpYpKzQF16mWBhQmzvhlwLB9RJUoW
	 zpQKPjDd0kof2vQFWnQmy3IhW3nUJwkLUs5fX7H/XfzADLHbpqeT+KnbRQjUfZt+Pul7C
	 5EyEaY2JZB9d4wJ1t6O5q0ClMfmGEKqtVXw3qwN8EI8dPN3BvY9Hd8kdgElCeMolFps0a
	 CS/d9frdvcCop7EPT0Z5x+QkPMTY6/hm03yXgILy/MgEJSqVPU9rhtcOMGJIcPvMjMg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792834221;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=T/uGr9O5F7z9D4gBA52zJiYNaYbWI1NRoXexG5R5ETM=;
	b=jgZxAehp5NBu5+lseefYiIyxMiZ+RHVli/0EhHT74dOTQQjFcog7wlLkfHnuJK82E0NO
	 iNbuHhIi9kt7/eL4uwjYdDiTAed/xQC/nDn6itF9PmPW9o8N2aOsivQR3xXHJ03dkLNwe
	 PDRH4P9l82+ofG8dHzdhA2sdF7mSge2SRKnztOB8AOSQziCQDAzQnJpPwBbHPTdoW3mhX
	 8tLie7ok7BJWVDn5ba69ZsqOKF+XBGu4f/sGiDGaAfrOEg19JvAT4JQ1vIsxle4+6twD6
	 kHNTcgV8RGs3ViiiutNd+mHm6QUk+C1uUEwWPNFtt9Hb3sLzFMA+ApSYNk78QOiwOXw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=YtgVCBXS;
	arc=none smtp.remote-ip=209.85.215.180
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27E20606A31A
	for <netdev@vger.kernel.org>; Sat, 24 Oct 2026 09:30:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 27E20606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=YtgVCBXS
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-cd5cd8d89a7so543178a12.1
        for <netdev@vger.kernel.org>; Sat, 24 Oct 2026 02:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792834220; x=1793439020; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=T/uGr9O5F7z9D4gBA52zJiYNaYbWI1NRoXexG5R5ETM=;
        b=YtgVCBXSUeVcu8Mqv7J5aUu2nXj3G0PBC8eaw6IEYZbYR7toBD03RGII2GHcevewBc
         uXSyjYy5oPmaYloGbnWwwG+1sAPv8l0xVLdGUPO7PCxTdlvM4MRy4sACFVDhRR1g+Lrh
         6jcBf3IYdDe7ounKGQ+ZyL0iDvqPbUMkpyZfzNEWh1NgmatpeKW4YXvhE4m3BLnCL81f
         euAlYL37fvC3VSc1e7PHCnwVSaTcJv0H8AjKwAzSEtBbOysjDdFULIs70a3bGTWmF0ne
         m13LCDXUO0x0qrWH3/PVgXfCjZShU3lclP9biOLLPHmNEmjMG/IzwISZ51CDES475xJN
         pqLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792834220; x=1793439020;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=T/uGr9O5F7z9D4gBA52zJiYNaYbWI1NRoXexG5R5ETM=;
        b=2j63av/MIhsht/ZGX0yA7z/NSDT8Tj6ZKRzKV1jNF9XJKDDVDgDK2ZeVUpEZhdi6+L
         iqTXF0Ayjp0PwKRM7hKqwfFseDYWWfiQNEcpfgadNRvjXs8N2a10Bon3N+XICTcnkIk6
         dDiFMhbaZrLXPQxdgsmRW5OWjjBf66uKEHCRtqWg5KdfY4PlKzXgg+xOm9lexHmpeiY1
         FCTMOtO7JSRTwYSfGv54q9ADZ5J2+iM4o65ORPemfcn7HrLUFBP42eTkptiHunZzJmaa
         xkpJWbZBtJMkWtQWwM2ZCbpHMuMhxktbqa7xKJpUlF8jKnpzGqOs/IOT3G1EJ7Rvxr1k
         7kuw==
X-Forwarded-Encrypted: i=1; AKwUvBw2z7HWzclj7oiRopHA5Ya4Dq5UwX/gzV5wX/NztQse5YfP8GVZo8ecOeV52furg6RIoudtVh4=@vger.kernel.org
X-Gm-Message-State: AFq9FYIBF5+mhMweRZax+XyMXDA5jj0q8wz2fGORZEAgKB2Rs1TNcbj7
	L1U9UGukK1G6NDBBnYVfgaXPdh0S5KAZ0r71WvfEj7MVyNtt9kj+SKig
X-Gm-Gg: AYBFou0CpOvABoD3MuOmKRH05G6Tk4KfMmyJJuHvJbdjF/QtKNBUDHjtiYXqHz/NKSC
	t+HiA+HV4RmujZGFlTaEzDbqjNpdakwveF/ojd/JVgXrlaBQ/IoLVnfZ1EZmjLUTcAsN7Svz4VA
	OX6J8WdCRup/tJSw44gFqNy2dRG3xDSyU4J49E4ZNdd0PZgzT9YbucBKCXQfjpDtIE+XFuPhkZ3
	G0wb3I80WE63Bewsd/Lc543Ew5hx51heBT9TAHrMBGeaYBwqYRkXTX+WU0ehWKsuyjEb8tFxv3F
	7QeKY3JtEFcY4URMUMnF7xeUWyPVPnye3yWeFMf1Kj3Ilw2WYrWlTpo281Q8l8osLUL1AdewDls
	Ole4oJa8iSOyRK2q+4LOU5sqUG4iB6vdyqX7MbEckNUz4ljFKVLkODNURSJTCbnaZ9KdZpaU7ZY
	XcufcuFYdz/1OuRWH0NERGPbAkdqGcv6zGb9GbURdgirAZC47v/+ir42LEZMCLVE9cbeIH3JvKZ
	sKX4RzC3Qv7iQqvPeMHhcCA7WcX8G2zwbf9OdE3u3j5Qeh65CfHbG0XQflgBy+ZGm3XSj7JBl1+
	2+zY7yDfbAEXTTfKGDfegfPNcf3AWIfWyTj42iFyHcheiuq7//A8Ivnq/CcyCOqaMexY73moWtP
	fXjQNlSvMz4NahSpOYpgNn8P13L0d4RCWmRzeVyeCDPPfI8vZOQ4xZ00VRguDSv926X7t6NGOeA
	rj7eUO4blskmj4Y+ZBQ558cG4bOOQkAV2XsL5eydqfjYm1tsvRT7u+sub7
X-Received: by 2002:a17:90b:4d09:b0:3ac:8ee5:e007 with SMTP id 98e67ed59e1d1-3adeaae619cmr1148374a91.20.1792834220445;
        Sat, 24 Oct 2026 02:30:20 -0700 (PDT)
Received: from desktophank.localdomain (111-242-220-176.dynamic-ip.hinet.net. [111.242.220.176])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ea9af32085sm4345075ad.2.2026.10.24.02.30.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 02:30:19 -0700 (PDT)
From: Ting-Han Hou <ue081723@gmail.com>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Chris J Arges <carges@cloudflare.com>,
	Eric Dumazet <edumazet@kernel.org>,
	Weiming Shi <bestswngs@gmail.com>,
	netdev@vger.kernel.org
Subject: Request: follow-up fixes for "net: add xmit recursion limit to tunnel xmit functions" in 6.6.y and 6.1.y
Date: Sat, 24 Oct 2026 17:30:10 +0800
Message-ID: <20261024093010.485-1-ue081723@gmail.com>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Greg, Sasha,

6f1a9140ecda ("net: add xmit recursion limit to tunnel xmit
functions") was backported to 6.6.y in 6.6.160 and is currently in
queue-6.1, but two upstream follow-up fixes for it were not. Please
consider queueing:

For 6.6.y:

  c38b8f5f791e ("net: prevent NULL deref in ip[6]tunnel_xmit()")
  77facb35227c ("net: increase IP_TUNNEL_RECURSION_LIMIT to 5")

For 6.1.y (on top of the queued 6f1a9140ecda backport):

  77facb35227c ("net: increase IP_TUNNEL_RECURSION_LIMIT to 5")

The queued 6.1 backport of 6f1a9140ecda already includes the
"if (dev)" check from c38b8f5f791e, so only the limit change is
missing there.

Why:

- 77facb35227c: with a limit of 4, setups with multiple tunnel
  layers and MPLS lwtunnel routing drop legitimate packets with
  "Dead loop on virtual device ..." even though there is no loop.
  6.6.160 now has this regression, and 6.1 will get it with the
  queued backport. Upstream raised the limit to 5; it is in 6.12.83,
  6.18.24 and 6.19.14.

- c38b8f5f791e: iptunnel_xmit() and ip6tunnel_xmit() can be called
  with dev == NULL (e.g. SCTP and TIPC over UDP), and the new
  recursion check dereferences dev when the limit is hit. It is in
  6.12.78, 6.18.19 and 6.19.9.

Both commits cherry-pick cleanly onto v6.6.160, and 77facb35227c
cherry-picks cleanly onto v6.1.190 plus queue-6.1 (stable-queue
fa04d3db75). I build-tested the affected objects (ip_tunnel_core,
ip_tunnel, ip6_tunnel, ip6_udp_tunnel, the GRE/IPIP/SIT, VXLAN,
Geneve, bareudp and GTP drivers, SCTP and TIPC UDP media) with W=1
on both trees, with no new warnings. I did not do runtime testing.

I noticed the gap while checking which stable trees carry
77facb35227c.

Thanks,
Ting-Han Hou
