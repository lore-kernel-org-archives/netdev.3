Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792659881;
	b=3JOyO+gxcNtbxU8ws2EcPy3U2u9jTf5d3vIBvcinl74xxOx5UYrzZqS4bknomfrMPxcD
	 EejrptI/Vrkl5xtLGF30zrlL/GPYEbXyMJweIVc5NBgMv6gcioObsG5o9DRouhPSbg4gf
	 o1uELajutUZov4JHqQ+Hj19penV9RvvRVBXavo/Au1kN811UcJD/MOI/dx2FkXxX9jx7S
	 EuIVDO65ORThU1tysVnpSuFa98FfkIjS1qBIWf0QEhmD5O4iV1xWADd5ptm50QcRehbjv
	 cWzeRjfOsryQgCrTiNFvZ98vyUbTiM3N4Z2ogkB+VIE3gZ+jUr5braXEZlmkHrRkHrA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792659881;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=ppDEP6lrPx9xfq6MNzv2Y3tsqjuRimolFRwRFB5o2fM=;
	b=X673+NhZwNWW4C6BwWn56MQ8LD9iAQgalAmPzA2f4Ejr96TbnkFxW0i7W4YoCuM5tOtR
	 ZIPk+DNnIWHck/JVe32A4TkjqfcMpJlW21jvCgs+riYYiYlkqzwGruqH2JOS85FmOCwZy
	 HZFStZivp5Fq4ZGWrZ8nZs7GouxW1V98WXmYs57CJ06nkIdgJqZARiPpy1HTZtSe8KGBk
	 lresB0TLoI6qwBf4YHfbQ6V8k/oVkTIqYCU4HBKX01bNdhzoCgAK/GJVp+sKBCZE/56hC
	 dhpQ91lLwIaEcuAN33elYTO4uVLhZrJ2kZQiprolhAD/MNOM3JVwBIZxeZ697W7F1zw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=IJoTo9rd;
	arc=none smtp.remote-ip=74.125.82.179
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6D7D606A31D
	for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 09:04:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A6D7D606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=IJoTo9rd
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-35b2c599f43so3630105eec.0
        for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 02:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792659880; x=1793264680; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ppDEP6lrPx9xfq6MNzv2Y3tsqjuRimolFRwRFB5o2fM=;
        b=IJoTo9rdAbqSFGz7b2xuHJqrpSv6xT2Ady6/lLee/5qVeEyyXOkCyV96qbzMgPwj0W
         +0J9MGjZ7iIBfUYZ94hoNQZO9XRc670630CqdJhhkIpjjgyZIG9CRcDZLPNP/pr9XsCT
         rJ4kypdqrTipRYZvi7doTrwORMDoo0TUDRZCWSxIbsBPVHdhiatbzRJFOsb0c6wLubon
         pvxIto8AG+NOBe+7yW1Bw98BFOpQymH2v6fNfb2EZxVPlfrguSsGPLZhaqDY8pG7Fd8j
         UdjuzfoDmh3M5C4b12KYgA6HAnQowB0LvOvKJ9PlowEfkrt2Dl8Ip3AuvrrH5C88yUyB
         yzew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792659880; x=1793264680;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ppDEP6lrPx9xfq6MNzv2Y3tsqjuRimolFRwRFB5o2fM=;
        b=ewRM8PeceW2JZ5TcdbxmvPW9CBWwOu9fCrVdPCAw1ORe+yXzdqA39USJh5tylB6unC
         UzSB4mRNGR98IloEsj5F5UNS/iS9hP0sCKYtxsJpF4DF1mvvitq7VYSwL4hI4zjAn1TF
         Ubo8WDhPL2tZ9ehp5+vN8JKZV6hYuzm3KdAQ618SL2rrWmj52pL9ELZnumKxBupUhT/3
         6EH23ZXaPYW3KOf36O7eYT3mD6Df+eMEBU6sGyuU91noKBCm/LioLltz9Q7UyJt6LFtx
         guHXA9uRtzdoS55DjXQRWosOS08teDp3pPk6CFRh71/8xzHGCnn2qYCH8y6vopApip5q
         6qvA==
X-Forwarded-Encrypted: i=1; AKwUvBzwkBHwdEOgqBTKO/4GbSUx3ZYrPdqymdtdlamP30vCkIUTQBQ/VPoAgPJq1O9Hm3fSRGhoNvY=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ8jCA8M2WiVtpnDKK7xUn7EwkhSw3DxeF4lwvcwuK6wZymZypl
	LYiXRUEnosBv0kn4gte0c8U+tURCsZ7VOTkv07QMUqrOItAPbCLJN5LN
X-Gm-Gg: AYBFou1MVKephbFcPmjSIpncl9sbHnxB867SZW/uIOAcez0rexHcs0lEOYmKAuZFHz6
	QX8ch8ApVq+ruX7SuPHyalRoth6KCx47C/k6GYscjR71gYI1hWX/hqWz0GT4FWxZqk2R4PlCNI/
	jZ3Ud9sblhPeNiDWGlrMflKFnw/qReJ9O8k+PsVkTiEUjo3mtVj3iIBG+bL4wDVLmc+/UOVNhgO
	j93uOPDzuFdYg0+8kmp3+66ScFdDUsQbWzRO9LxzpjgDlpK1nwtGHK8/BV6Kcp9f35tvEnwGNvw
	f/8q5IyslUBRHFWw4lVblbami86KrxPNIdbvP6lkqKZJGx2JPO2Sssyx4W9R1VbaKYyvCdwwk+s
	HgR3YjeY/2xILuY5FdPdvjNoW9wGeMNkuD65jg6txMy/4vw5yMwGb5GQXZaAqyuTql8LesA21jg
	qPLZdA6fuNjQd76bA3oQsBk3p68fSqpu1llNTpFaql3JGXl+eR48Xwh4rj0VnwYhiBM6VeFYJoZ
	cjmhUMbpMAPfnmxMZJlN+ZFBBaBYh/5f3LnJNCoFY+vA7dCBQe9b4f8yAMVAu7l178f1yVOm1F/
	JA7fJyN30tPg2lagF6A=
X-Received: by 2002:a05:693c:620c:b0:356:b370:a0ee with SMTP id 5a478bee46e88-3674e15fa01mr7570801eec.20.1792659879720;
        Thu, 22 Oct 2026 02:04:39 -0700 (PDT)
Received: from youngkk-vm.localdomain (67.216.200.102.16clouds.com. [67.216.200.102])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-367411b4145sm16789928eec.15.2026.10.22.02.04.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 02:04:39 -0700 (PDT)
From: Cheng Yongkang <teel4res@gmail.com>
To: Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	bridge@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [BUG] net: bridge: late FDB learning can outlive an MRP port
Date: Thu, 22 Oct 2026 02:04:31 -0700
Message-Id: <20261022090431.3641707-1-teel4res@gmail.com>
X-Mailer: git-send-email 2.34.1
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

Hi all,

An MRP-aware bridge port can remain in BR_STATE_FORWARDING during
del_nbp().  The terminal br_fdb_delete_by_port() runs before
netdev_rx_handler_unregister(), so a frame received in that window can
learn a new FDB entry whose dst is the port being deleted.  No second
FDB sweep follows.  The port is then RCU-freed, leaving the FDB entry
with a stale net_bridge_port pointer.

Observed on Linux v7.3, commit
08ab31164c55f20c7a2653de3186ae333470e2c1, with KASAN+UBSAN:

  BUG: KASAN: slab-use-after-free in br_forward+0x55/0x3c0
  Read of size 8
    br_forward
    br_handle_frame_finish
    br_handle_frame
  Allocated by:
    new_nbp
    br_add_if
  Freed by:
    kfree
    kobject_put
    rcu_core

The failing sequence is:

  br_stp_disable_port() leaves the MRP-aware port forwarding
  br_mrp_del_impl() restores BR_STATE_FORWARDING
  br_fdb_delete_by_port()
  ... late ingress frame learns fdb->dst == p ...
  netdev_rx_handler_unregister()
  call_rcu(&p->rcu, destroy_nbp_rcu)
  later frame -> br_forward(stale dst)

This reproduced in three independent VM boots.  The target bridge code
was unchanged.  Because the test VM has no driver that accepts
SWITCHDEV_OBJ_ID_MRP, a small diagnostic switchdev endpoint claimed the
MRP object and widened the already-existing post-FDB-flush/pre-unregister
window.  It did not replace bridge logic, modify FDB entries, or alter
net_bridge_port lifetime.

The deletion path should stop new RX processing before the final FDB
sweep, or drain the deferred/FDB state after the RX handler is
unregistered and before queueing the port for RCU free.

I found no matching upstream fix.  Candidate BR-007, BR-040 and BR-058
are consequences of this same root cause.  BR-040 gives the forwarding
window; BR-058 independently describes the stale-FDB lifetime.

The reproducer, module source, and complete serial logs are available
on request.

This was found with AI-assisted source analysis and fuzzing; the kernel
behavior above was reproduced under KASAN.

Thanks,
Cheng Yongkang
