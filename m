Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794328660;
	b=JJQ9penU2Gi6RCGEByGNu9/mrHNzvGC8CL/AHTCzmgLlW2W/Kbg40gCxU6JQbwIVMiVL
	 U743tkMlsoZKn5U69wVaDon+/5FExVH7KjOp9GNxRd0WrjxshXQdiZnp9SxBiDOULQnZQ
	 pxJN/bFzILGyplGhrY2ggVZDTSswmwCcD1Gc3AY1SjpfhvpXTLqWduJBfBRLxYw9KEAzl
	 v2eXc3J/32B08KQEnKdh+ge4Vkvl5acRXb3Rtb2Z0maYRBAG4Sl62WNfzk6yU1JoMUBSM
	 ut2NMF0JOeSUWWt9z2BAkUe6Xd4QejvWRU5Ra2GyjaB5tPQ1KOiU9OnFxpFEnn0hVXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794328660;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:Received:X-Relaying-Domain:DKIM-Signature:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=mdHUO0VGLnueGxzHTpyhsQE1fh1WvgBQfjWRPSJDDzY=;
	b=NKB9Ydtrkf9Eb64kHgxdD8bsxH8RSQJQ6djRWSlVLwmOyzGMcPKQUoFKBSX5Y/bl94tY
	 BwFPDmwXSsAQzsoEh82SYVznjq/8C3z1BOzFzcbPeiu8oKESmd/OuDoWK6T+6slHj9y+d
	 vNH96IDmMRzww3S1YXwWWs190ZXJjd2B6q9pYGfPKQLhhp4dQv7Ky1MrNH07geqPKHTYN
	 0sEmVxIiKaf4P73Ut63q14SUc0rtzQfnmcm5IRZ3oKCCMw1ZwoCaZP+BZDozWij0Qoj2G
	 W6iESU7N9tHwuHfgLUsyjX4WxVo1vIBokOdLeRcrMWJKsK7I6shyweiE27/m+r909Bw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zx2c4.com;
	spf=pass smtp.mailfrom=zx2c4.com;
	dkim=pass header.d=zx2c4.com header.i=@zx2c4.com header.a=rsa-sha256 header.s=20210105 header.b="ZDZr0U1/";
	arc=none smtp.remote-ip=209.85.216.101
Received: from mail-pj1-f101.google.com (mail-pj1-f101.google.com [209.85.216.101])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58E4E606A213
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 16:37:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 58E4E606A213
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=zx2c4.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zx2c4.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.a=rsa-sha256 header.s=20210105 header.b=ZDZr0U1/
Received: by mail-pj1-f101.google.com with SMTP id 98e67ed59e1d1-3b17b277a68so173879a91.1
        for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 08:37:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794328659; x=1794933459;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:dkim-signature
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=mdHUO0VGLnueGxzHTpyhsQE1fh1WvgBQfjWRPSJDDzY=;
        b=YpjLZCgN5RsMk9kHBjSx8KoaVoPMKW3VK6jBZq0qs2VUZOpxsgNx/3S+J2ke7lVB/s
         bZJdRlks7orYGe3KSufct/MKhSi6bQr71mL5vTV2lQlflmu0C1ITH9F3ZQO+sEhtSGE5
         VZnXOYu6YkOKR0lpL4PcPqCyToH2nqZPQdhPr4tq9nQUfbIOBFjGTBi6rNesturzk2MP
         J9t88SFJHwg9K0Xq1RDiZQRFSf2lY2r5Jv7fqsV9P863IIJJPEou3oU5a8sQqdSGZuA6
         ny7JKZSdJ8cWd5wzIKiWSQmvncYIEbKNbof4/NDtnz379BCDMPUWo17PdlOVk6hGZu8u
         IRew==
X-Gm-Message-State: APuU4Z9rWvVrgifM/heKcLYo2hzRGngUX5Up1S+cSv4u4E7KsSvgoZRF
	DMRJJaEjFTkY+Ks/Ik8yaOk083ON0NlIq4pSrnYVaGjVYr/aEQdLuGObu7cNxacKMW9CuQdspsu
	Y8YS2x4S82JoLs34Ig9+2m6lBvV7I5aQGAy7yAro=
X-Gm-Gg: AYBFou1WapIfiNZqDpcYrRRIr6HablGPtm7MVrjy/y249zhLY2kpqFs4XDcQQEp7Gg3
	DwaHcfj+b5STNO888osVZOqk+9JXS7f/9hKPTywp9AXFWOaF1AVH81xZgmm8+4CM78ua34/ATLu
	hP2tFfBobPiUghHrHA5q0WKYF1EMdn0JpamWI3mC3OHWQi/fDp2xYWXrgf5t2BL6q3u/tBOhKqD
	NxY65Qk17jloQQFpKrKTI8JesU13b0QKTIkr/lBvXa50AVZ5CzN/rAhIJlC77z32Z/NCgCXXqnT
	dOp1ZVF17gL2XK/Atl6+9vxxIiOsTQxxRAF05462jvcQJXPcbMopLawkLCZVOWsotdAMVUiPTrG
	9zA==
X-Received: by 2002:a17:90b:4cce:b0:396:41d1:cbc7 with SMTP id 98e67ed59e1d1-3b166aef2b6mr3328097a91.3.1794328658562;
        Tue, 10 Nov 2026 08:37:38 -0800 (PST)
Received: from zx2c4.com (mail.zx2c4.com. [104.131.123.232])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3b168f056e7sm995427a91.1.2026.11.10.08.37.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 08:37:38 -0800 (PST)
X-Relaying-Domain: zx2c4.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1794328654;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mdHUO0VGLnueGxzHTpyhsQE1fh1WvgBQfjWRPSJDDzY=;
	b=ZDZr0U1/pHeEMipCNGli2iMRTX1nXQLbpRmDwcZEDOQ+B4SQBTWVNZw7weGFZUxjHl3Gs6
	CMtZfiW5dbFxczAM63Wv9EWm5qrgXInVmcuokvE6TMadLQ6zQieK0QropTRsBjZ8DRH+nq
	xTO39zvfYLBDk4s02DwIKPTGdFI373E=
Received: 
	by mail.zx2c4.com (OpenSMTPD) with ESMTPSA id 07eb770e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 10 Nov 2026 16:37:33 +0000 (UTC)
Date: Tue, 10 Nov 2026 17:37:31 +0100
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: Andrii Pasichnyk <apasichnik9@gmail.com>
Cc: netdev@vger.kernel.org, wireguard@lists.zx2c4.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] wireguard: peer: free packets left on the per-peer
 queues on removal
Message-ID: <avNIS67grg_Qc5Vy@zx2c4.com>
References: <20261003201625.4572-1-apasichnik9@gmail.com>
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
In-Reply-To: <20261003201625.4572-1-apasichnik9@gmail.com>

On Sat, Oct 03, 2026 at 11:16:25PM +0300, Andrii Pasichnyk wrote:
> Reproduced with the WireGuard selftest VM (x86 KVM, 1 vCPU, net-next):
> remove a peer while a UDP flood keeps its receive queue busy, re-add it,
> repeat, then run the selftest's created/destroyed object check. Over
> 2140 removals the unpatched kernel leaked a peer and its keypair 5
> times ("wg0: Peer 27: merely created"); with this patch, 0 times in
> another 2140.

I'd be interested in seeing your adjustment to netns.sh so that I can
test this myself and validate various approaches. Do you have something
really minimal? Also, is this a test case that could be implemented
minimally enough that we could integrate this into netns.sh permanently?
