Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DE8A376A07
	for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 20:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788207258; cv=none; b=Fud9eWiPgXw7CeSRun0DsO5Flr6xT/y77pq93HRLFFTTVBAEbmCZLsbW7ju3UMFDShS0QKVXOqPiAFuSwqBqHoaaAZxueXXNTqkJVEP4d+nw7JRFmfKdsEhrMSicTzd6r9UXyQvidIZR+Qfx9sNQxaPZ/GWB27sOsLi5dVl8n7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788207258; c=relaxed/simple;
	bh=eAybLI14v6cx74Pmx8e3acei2cHO4ChMz7p+jR9Lq2A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QrGzjcrFSjt/BjlWLL7V65E4Md+499YQ7Z0BzyDf0gVrndPQbdPEek90Hyh516qBCdIUyApJjwej5UgHw0rgSb07WJ0mCAsXjF5SwuUJpKYuXD9zs757OYOp6OHkqCP3WIxP6CZPs42PnW3jwJDokYPMukF7fyJvwfbv0nweS6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b=wtzcP9rU; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b="wtzcP9rU"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2d72ae08fa1so33140105ad.2
        for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 13:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20251104.gappssmtp.com; s=20251104; t=1788207256; x=1788812056; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=d5biOjO85upMuWLwPhpTINXHI0+y4flJcmn6189t5CE=;
        b=wtzcP9rUntPU6b68m41Wz74cFovNJ2RoLdwbFlX3g/zcKpSztf4ZbroO7U2K/g8KyX
         3XG8m+JXzMT3Sujrwx82fe8fbZkJm/WEHHCo5rlyMC2pSRmJ1prYbsd4l5zljKoE63Cw
         US8VTRydoVme4uW3kmBbG1RYT79iSrFqC2Vv4q3C+d/0PooSWRjY2PQ31UB9skKO2tAT
         yYNatx5Pq5DXoFqdEM0jhV9CSLPRAMC5U0ipNzJVUa9U6IQ2pijssA2IZL7hnKK4MbK5
         WTb9rSbpWJu6CHlS6jb2u4NsIgSHqDUMfeDO7KEdQ5SWe+rXGxGmakcY1k6KEqbgV9Yl
         Hvpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788207256; x=1788812056;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=d5biOjO85upMuWLwPhpTINXHI0+y4flJcmn6189t5CE=;
        b=Qq6zys9bojbltRBA1AlZJMkhkquOC7kVbcKeOO9/F/4PMyzemiIbhfQ4uB/1ssN00S
         IEcyzbExokOuFGhPcnaOvhvzV9JFHQPYQasPdrI+VoYhpkyMbNfSr/t8S9Zy5QJ/TWBv
         /nqdatApVHtStRVgeBVNnDXYSr6IOEO44n4XByd/SAvcrmmkksRHeppoGkK4FnoeNjel
         fIu03cC3gFof00FkD9t77NvjgmiB01HHwF3IagG/fqw8bjfYhk/qSmoJEKpcQezYi5+Y
         F0rw8cNlHWbyn3sc/+rN9UamKQ+mwLJfd9TLuzqHkBNHDjtgl+b8rIAmTudvMTBox175
         0ubA==
X-Forwarded-Encrypted: i=1; AKwUvBzm6H39M1vmlhiMXFOp715XFSzCk3+0vKftDNRUUkJYGlBtRW6nEuHqfhc0qtAU5pLsBKctMq4=@vger.kernel.org
X-Gm-Message-State: AFuF++lGvZ5tjCMQXD+2dWjFWsO4eri3MEDA5fJoIyO3REibZpiKgJa3
	mkxvGFdtd+drhXmPgBiA/rquPClf97cqAdhWX6YHGuEMYU1PRywGS68/xbyjL6Cj15k=
X-Gm-Gg: AYBFou1SfrVC6+j0OMpAipQr0EGPTgtmPm8TTZwu1D9tEbNPkAzrtDaqJTY2pVufX/H
	MmmnhjFCvshM5OIV1IREAugyJsgkSjVs4hxwN1BOhm1KIjkOnwRdMphE2c3gL21YjXTFpwhV054
	ukH4SUJ+bXaUU/+PN8smpKjAJec70+8Rdb53GaK9ycdtSdRgPNPF8prMP7i4TRwxbGRcDrha80y
	cjeLduhC7dPOZfS2qcXIQKl+XngR8b+ura2/Ie0m8p7D+aP8wieNJ+WChY2Htu7Q/4TZg4vq247
	845w8yjZLL5TczVDBy5fON5V23p2giot9KJr279wxGqVqZiNmesviMsvSnOoecq97yJnZGoPIyT
	2ClYQy6dvjunfe9ZYkklEFyerL8xLpzzTKEOy+x3pUzgS9zVSUCWYO8vMlbxmSCohi2ks7CqLIm
	4iMlnnp1z+vr/InaIZdk9yYElRzTj3lQnZYASOazElfQ==
X-Received: by 2002:a17:903:2acb:b0:2d9:1c02:5a19 with SMTP id d9443c01a7336-2d94a956b48mr37826955ad.22.1788207256475;
        Mon, 31 Aug 2026 13:14:16 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:54::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d8f6a92239sm31370175ad.70.2026.08.31.13.14.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 13:14:15 -0700 (PDT)
Date: Mon, 31 Aug 2026 13:14:15 -0700
From: Joe Damato <joe@dama.to>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	eric.dumazet@gmail.com, Jay Vosburgh <jv@jvosburgh.net>
Subject: Re: [PATCH net] bonding: alb: fix uninitialized transport header
 access in alb_determine_nd()
Message-ID: <apXgl2EwsQUWsucr@devvm20253.cco0.facebook.com>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	Eric Dumazet <edumazet@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	eric.dumazet@gmail.com, Jay Vosburgh <jv@jvosburgh.net>
References: <20260831194626.119371-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260831194626.119371-1-edumazet@google.com>

On Mon, Aug 31, 2026 at 07:46:26PM +0000, Eric Dumazet wrote:
> alb_determine_nd() uses icmp6_hdr(skb) to inspect ICMPv6 headers.
> However, in xmit paths (e.g. packets sent via AF_PACKET / raw sockets
> or forwarded packets), skb->transport_header is not guaranteed to be
> initialized. While pskb_network_may_pull() ensures the packet data is
> linear starting from the network header, it does not set or adjust the
> transport header offset.
> 
> Dereferencing icmp6_hdr(skb) can therefore access out-of-bounds memory.
> 
> Fetch the icmp6hdr directly after ipv6hdr following pskb_network_may_pull(),
> and reload ipv6hdr in case pskb_may_pull() reallocated skb->head.
> Also remove the unused bond argument from alb_determine_nd().
> 
> Fixes: 0da8aa00bfcf ("net: bonding: Add support for IPV6 ns/na to balance-alb/balance-tlb mode")
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
> Cc: Jay Vosburgh <jv@jvosburgh.net>
> ---
>  drivers/net/bonding/bond_alb.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
> 

Reviewed-by: Joe Damato <joe@dama.to>
