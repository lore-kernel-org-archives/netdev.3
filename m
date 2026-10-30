Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793333190;
	b=Gy0H2gIKnfbMR/1QsscMLsyxvHjbzFKSoOC8pny55VXSJd7/RctjuJAO7wLp//zER7vT
	 f7KLr4fyIhCbiaZhPQdqqaAcv9Ujiv1W3VQpgc8HtfzJlwe92tkGE8piuQvjMjOiFmqob
	 5I+42hkcm1z/WTJg+U8CA+wW0ao2cLRyMu/BSzPe1AzwMdWD77LpDJOfp1Juk4YCLE4v7
	 lsJHAWr+sVAy/DBAoFyeR8OO9BXBlRoVJrduxSIffvFYJtgiHkYt4KfHKOzrVfMOhDqZ3
	 cUOVARLD7RSvZZtFZCDm+7B+tsRGbwNhGQMBjCbA5/VZC5oi5dCjDRMbIEX52oZXA9g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793333190;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	bh=uWhG69hUkv8+lJDJp2Q5DGOfAlOtWL0/OT+J3s73WV0=;
	b=0zthXZxiAbhleJrJSxOeOsCLz+aKfS6N4by6FRZM0aIUFaxnCY3pcnqzCZRxPD7Ou7zo
	 9fnmnKll7iIrO8gj+5Vb9Lz1K6qP/ECjj4q5JhmXT5XElqX5L/1wCIO2Vab2ZFUn5HUaa
	 23fYU0z827homDkA6o60uMUyQWnmXYqffkVU47Dsbedt1TN2HnYAM1gWk3Wc6VR3n9aXF
	 XgTetfKCWK4KEOXw5d6voc4r9KZZEU0k7mUmHU7Cuk9ag0OJbQ9xoZP/wb7y0LRleLsLT
	 v3wqXCj6mtQxMX0P3ERWfwxLJECv6ObBsfAWnQ0cclqYxvv6hRBbJQSzYhCOSnTWRgA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=naBneU0i;
	arc=none smtp.remote-ip=74.125.82.53
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A54606A321
	for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 04:06:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 67A54606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=naBneU0i
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-1438d9363fbso235581c88.0
        for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 21:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793333189; x=1793937989; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=uWhG69hUkv8+lJDJp2Q5DGOfAlOtWL0/OT+J3s73WV0=;
        b=naBneU0iFArIi8eqr15ZeHE2r6fXY4sAd/jMYwWUqKEfJ4URpBQDycYcimswKQEL/L
         xULs8W2YWVcJ+buOF71p+LlkpLMO9OfgnA+PonDj99//Uf6h0V6CBE0cfqltgdR4S1oX
         vxX7kzYLECZHT44TEdA+MT9lnpq70obLs4xS0j33mzTBNQ17ijO0rL0caBCoSlhdEqzW
         gx8VrIuzCibPrsVuQmwAZ7T6BiVf54vGvHOinKLNTFKgh8tG2lb8Y1Bd5zXRFG34Txf/
         1745NZPHkTCmod+I097nJLFts98YmLHHFWnAIoJfTqZFQzQcSi5rGRlQDNHd8Uf20xPt
         v3cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793333189; x=1793937989;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uWhG69hUkv8+lJDJp2Q5DGOfAlOtWL0/OT+J3s73WV0=;
        b=te/JPFSF2RY5g3chItY7Yc6vgwc5v5vspt9u58FDbTKFokyYhAyWyF9GbzjDDGjij2
         jnLcI1TzKU8q2B9a6H36ob02PnVKoAYJIwLzCvghntH5bf2AOUe9n2TySCniq98L1B0u
         wFeAGW7B8ig5dDh4PIf+NgTRKM9HyqyYIpal0mAFdpoWTXKZx1NBlM0vDNHaUACpFGeW
         AFwEX8plsiqlgwJboon3XuALStbP8Q5GPpEveOz3mmxjN2aLkuB4ORIY0z7I43qplnYB
         j4LYkC/TCa+VRAvjJbkHKcQ1uVRsWEJUV3VC0eq9jTXKQplJAFI9B25yrk2bDQObecQh
         TJ3g==
X-Forwarded-Encrypted: i=1; AKwUvBxs0B0NJPOru7dSYp0SgFMEVZrNlt8ZSr/Oy+qefAV9x2e2W0LYrmFWnCSNQXZ2Q0JxKsPnpSs=@vger.kernel.org
X-Gm-Message-State: AFq9FYKxpg2Bu5q2LEaVT7jQDcAlUnEpMm/ufvGGqE/P+sNSgN64aAzu
	EGW+C7vAUPH1Q+7NRmQ8ClCEtl9eYE+bRrqNoV1M4pgA+uXs7bd1NJla
X-Gm-Gg: AYBFou3mNNC75UXl3iDRC5SZZtIcAIZtUXXc8uwMqMxmpQ+tk5l7o9L9uwxuYMltmK6
	Ua8TLDNsL5Eg0KeXk6AJhJ7RKhavZ7Geh5+gfOVnNn2JZ9podkTSfEa1WyrupV0V3gE6NV6eV8Y
	canO+jm0arRNhquZXiWpDevEKrd+qroKblpU81qKgeQ7cJEdNIamy44OvFV6gWkL8gGw99dmSh+
	rhzTDavU1Hp5EA8/ryJD7ruA1lmgrS8ZQhN84QerHqa2+rP21SmWgDm3LVjxRN5GI6yL5F0MWvN
	EceYCqSeQy0EPLsCgh/2IupH9iUWr1AizDKWKu72Ht9VWU0bW3n+gWB8wWi0EUw9auJ45bFH4Uf
	/kiWtzmbUmC+eI72ERc1dyaoD0M/lNhCUlmwrLgh7O6grUunscZTvCXz2VTKdElf7szkA1tai4X
	oqpwjqD/MTPSvq77tn4nqYyiMIYUmwmTi8ayc5dI8Yu5x9tmLR7t8/UqhvgQ/MUWjyRbDb9ZhB0
	ZP0v8OAxpQF0v04rtzkSg30CP6DxO3qm8IbjL5ILMAMSnqGTUY4ns4ZmbFZQOnWVpFK3iViqb74
	rW2m7TySzPARyzyFrZ62KNUjTv3CZyNrkF/lTVnDV8dBmB7116wU12dA/+DFQnH4aCcfs6U5Aog
	=
X-Received: by 2002:a05:7022:ec2:b0:19f:cc98:f603 with SMTP id a92af1059eb24-1a9420e4a4emr7161417c88.1.1793333189327;
        Thu, 29 Oct 2026 21:06:29 -0700 (PDT)
Received: from [127.0.1.1] (67.216.200.102.16clouds.com. [67.216.200.102])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a42902649sm3410984eec.11.2026.10.29.21.06.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 21:06:28 -0700 (PDT)
From: Cheng Yongkang <teel4res@gmail.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: Nikolay Aleksandrov <razor@blackwall.org>,
 David S. Miller <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>,
 Horatiu Vultur <horatiu.vultur@microchip.com>, bridge@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: bridge: flush FDB again after unregistering the
 RX handler
Date: Thu, 29 Oct 2026 21:06:18 -0700
Message-ID: <179333317813.2102764.11838518621146184655@gmail.com>
In-Reply-To: <20261025081919.GA53797@shredder>
References: <179268538303.70821.8213834342995341232@gmail.com>
 <20261025081919.GA53797@shredder>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Hi Ido,

I'm sorry for not getting back to you on this patch sooner — I only found
your reply when I went through my spam folder.

I tested your suggestion.  I applied exactly the reorder from [1] (move
br_mrp_port_del() and br_cfm_port_del() before br_stp_disable_port()),
and ran the same reproducer: a diagnostic switchdev endpoint keeps
del_nbp() between br_fdb_delete_by_port() and
netdev_rx_handler_unregister() for 1.5 s while a flood keeps sending
frames; the test then waits for destroy_nbp_rcu() and sends frames to the
learned MACs.

On an unpatched v7.3 KASAN kernel the port stays in BR_STATE_FORWARDING,
new entries with dst == the dying port are learned in that window, and
the trigger reports:

  BUG: KASAN: slab-use-after-free in br_forward+0x55/0x3c0
  Read of size 8 at addr ffff8880200bf038 by task mrp-poc/9420
  ...
    br_forward
    br_handle_frame_finish
    br_handle_frame

With the reorder the same window is still exercised in all six cycles
(the 1.5 s hold is reached every time), the port is disabled before the
synchronize_net() and the FDB flush, and there is no KASAN report.  A
normal (non-MRP) bridge regression (two veth pairs in separate netns,
ping, FDB learning, port detach and bridge deletion) also passes.

So the reorder is sufficient and the second flush is not needed.  I have
prepared a v2 implementing it and will send it as a separate patch.

Thanks,
Cheng Yongkang
