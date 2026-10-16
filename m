Received: from mail-pj2-f11.google.com (mail-pj2-f11.google.com [74.125.227.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5617A45C70B
	for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 09:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792141558; cv=none; b=Nhvs2Zf9fUxPcHahzj01VgRAWm8hk68wYX4V+QaVJBFsAztI2KnZLa79WRGg0O2xtSnFoPjY6LyWHcb+yylXsAqR0fLl99q7NCede5sfRB1Nh8wbQYN0OWW6VTNaWQK/U/5KE9LhubjAcK//yJw14f3ExpLgjofpXh0eqrUsMVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792141558; c=relaxed/simple;
	bh=vBIXkU5a0czakfaG5UvhQYLDQmtPpOHhwRqC+37to5w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bn0iZ4kbjyBlthjXpetyEQ8omqkXlL6NXn4JeNxY+eoekl4xZuOQcXwlJGsbgI4j58c4leZsGw0MHxI+xQesGt83Mb8SCVBS9n44KfPSU9jBz0bmQyyXrl0WP/EPJY9rZtqzJW5yMWhYiuYLUVPiXXSPa/llf7tBqgd8J9K1Kd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R/ma36wG; arc=none smtp.client-ip=74.125.227.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R/ma36wG"
Received: by mail-pj2-f11.google.com with SMTP id 98e67ed59e1d1-3a0aa5e2b20so1730555a91.1
        for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 02:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792141557; x=1792746357; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=yIua1GyF5CyLs9zVRRQ2YP0+xQy31M4iXC7gh2QlT8o=;
        b=R/ma36wG/IHRU2eoU0KCWSBoMR66p9M6DTdmOOjFlc/4eMkm5OzKOY0h56NXsULWRY
         IgsALiiGVxAVMLQL7HCOIv+AbktrciTx4F3MkyaXiPIi637hKWySRrD+hEdtTuDPpzcT
         PUbRvbJw6xC7unByrBbLZoCGZry+bWJ5MeodvfScKLm8GObt1ltBDiBNGDO8OoEAzuDG
         S2VwVqWIrI8ptNhYehpvTZE/CfJeP1bBSZe+yQgtlQDOdAcTUW2g9wk+BDZhuTmtASqC
         Qyqop8R0nbuEjwJfiJiPmjuLZQeOT0z+ljTYOrc8er4X2LhLtpK1s4QNct00ji8/iJEN
         iAXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792141557; x=1792746357;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yIua1GyF5CyLs9zVRRQ2YP0+xQy31M4iXC7gh2QlT8o=;
        b=q/hnmPxJzFL2Tq6rtTDAqi1d9kfz7MyvZ3evtCSpDYkUrh26EfKiH/+VmKuLCP3oaM
         KwiOPNv9vD449yE7WJunIsxgmGdNaqH0QA2oJfsju0XLiNkro7KLFa0alnVR88LEmHL7
         o0djQgsjpa1ev2Ju0TU6HxcsdDLkZGorWiQFT2ALaHP54dQu+RmXCYhh11ZYSuQOiOTU
         aPrLgAsFLB71iuQ1UlJt2CeyTe4lWEmpfavQ7bO0dlqW6GcZ7orImW0/o5Ag5IJ+fEio
         JDN7DdN8CiVpHYZHgEIEvuS+TqKzeizmmqiI5fxYoX1QoyNIwIUYxSYM8/vqcddV8ThO
         ckWw==
X-Forwarded-Encrypted: i=1; AKwUvBxMqbyUvYM9FTe21c4V0O17YwHJEq5xGPGcMjvp8p88yc9z+5+s4kmIyhYVmHnLu7HTjV58tPI=@vger.kernel.org
X-Gm-Message-State: AFq9FYJwHTdmVwLJzAHfbzimSxvSrNdVidzjuu+WG85VqWhsfyQ1N2FR
	82HEiZs86r/1JzsXAu1M4BMhJ1o4zFCLvVQlLedrxu5gVogfaWFHs8aU
X-Gm-Gg: AYBFou21Zhalym11HW1qpHZF8QVskQxtqwhcDqf7Vh2gqvDi2cWAgjIMEX+lyIc4PNG
	uPPE1+yqrDi7F19J6SaiEi0gLkyDi78zpsthjoUSSCBbxV/JNzdC0A4fULLsLjojnz2IA/gdSIU
	QQqKADck5fYtMQGJ1GHSPoWU61RSxEI/J4J7e6SKLgdI6P44wn6fqa39xDl7Q7ZjYeG6H9558G3
	qGuONlkIIFYvC6y/umBWLG61HfXCbbcm2FmvhGCziq0uvNPAQN0DF2LH090e28/YC+uEqgkE4QR
	Ce5vGK8m2DQ7GDfjL+VY+stiB/+opgMdu/SC8aAvPVRxrYz+pmrVVcefdmxq5Yzll2HlHF7L+kp
	o97bMjWokrVkb+p7SBU4d4oA3Wzduzc8qpVbHSTiabez4xs+wlgkVX0stt+bShT1z7gm4Y6lwyQ
	bGEW4dBFV3f0wfJDKfKxzY8QSiQ7VyfCp9es4Sm6LHQOyf2l/B/TTdvGaT+g2LOwp07JacVYpSC
	8rXMXa08aajaVnihgc=
X-Received: by 2002:a17:90b:2d0b:b0:3ab:36c4:b4ff with SMTP id 98e67ed59e1d1-3ab3a747069mr19095398a91.24.1792141556494;
        Fri, 16 Oct 2026 02:05:56 -0700 (PDT)
Received: from LAPTOP-QJLDGQ2L.localdomain ([112.224.225.97])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3acd0aa3c24sm1310370a91.4.2026.10.16.02.05.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 02:05:55 -0700 (PDT)
From: Boyan Liu <yymhvert@gmail.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	co+98d7de09cd94fec5@bugs.sh
Subject: Re: [PATCH net] udp: Fix out-of-bounds read with unset mac header in unexpected GSO path
Date: Fri, 16 Oct 2026 17:05:25 +0800
Message-ID: <20261016090526.2497-1-yymhvert@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <willemdebruijn.kernel.2a345d6bd54c5@gmail.com>
References: <willemdebruijn.kernel.2a345d6bd54c5@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Willem,

On Thu, Oct 15, 2026 at 10:49 AM, Willem de Bruijn wrote:
> I wonder if the right fix here is to not call skb_unset_mac_header in
> the first place.
>
> There are plenty of L3 device type with no L2 header. They still have
> a valid skb_mac_header.
>
> This fix may be papering over a tunnel doing something non-standard.

You're right, and after digging into it I agree the seg6local side is
the real offender.

I checked every skb_unset_mac_header() call site in the tree. There
are exactly two: net/ipv6/seg6_local.c (end_dt_vrf_rcv) and
net/core/filter.c (BPF egress, unrelated to the rx path). Every other
receive path delivers packets with a valid mac header: NIC drivers set
it in eth_type_trans(), and L3 tunnels without an L2 header (ipip,
sit, gre, tun, loopback) reset it to the network header after
decapsulation. seg6local is the only producer that lets a packet
continue up the stack with mac_header unset, which is also the state
skb_mac_header() warns about with DEBUG_NET_WARN_ON_ONCE().

One complication: the unset in end_dt_vrf_rcv() is not gratuitous.
vrf_l3_rcv() -> vrf_add_mac_header_if_unset() relies on it to
synthesize a fake Ethernet header when a sniffer (e.g. tcpdump) is
attached to the VRF device. Dropping the unset entirely would change
what sniffers see on VRF devices.

So instead of removing it, I restore a valid mac header once the VRF
rx handler returns:

        if (!skb_mac_header_was_set(skb))
                skb_reset_mac_header(skb);

The sniffer rebuild happens inside the handler while the header is
still unset, so tap behavior is unchanged; when no rebuild happened,
the packet now carries the same mac header state as any packet
received on an L3 device.

Tested under QEMU with the original reproducer:
- unpatched kernel: KASAN slab-out-of-bounds in inet_gso_segment,
  same stack as the original report;
- patched kernel: no crash, the re-segmented datagrams are delivered
  intact, and the unexpected GSO path is confirmed taken;
- with a sniffer attached to the VRF device, the fake Ethernet header
  presented to the tap is identical before and after the patch.

I'll send this as v2 with the fix moved to seg6_local.c. If you'd
rather drop the skb_unset_mac_header() altogether and accept the
sniffer behavior change, I'm happy to do that instead.

Thanks,
Boyan
