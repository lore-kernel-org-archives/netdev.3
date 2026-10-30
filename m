Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.228.6
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793375348;
	b=SG7Ee1dY7Og0cx/SXFX43klI7wjzCf9350cevumyffwlUjtsgFpFaA6vAMSotl2B77qH
	 +VBi11l30PF8xJ1qXZPxK9eFl4jiRbTMHx8LjqTCxctFM04rh3L4XrT2fi+u1kzyIVJuU
	 rhM39in2lGzhEbrlqRs9lfLPUHtng7GFD5PiG33kUgGlhclL9Qezq4y+aGaHfQ+sTD+4Z
	 q3zzITKd3QorZ0uSAX5bNkUoaJ8Tnu46ePtYGhmheC4PZJOPwAxp7i9IKU6uUo3ca3WrQ
	 aWvy7JdSXkBj4iu0/Vx1b/h/lWU4dKMUKz3LSg1l13t7sLNAoNC74ZbJtECJtt9lkow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793375348;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=XeWdEKJNRx847la4OpQ8xK5JYD/W25iZBdkd3AUui+w=;
	b=yR+1qZd1z/IOefTIQ7xawiUVQgZbB2vPIdVQEGCr6lFvqpDlLOs5ERRba/F+qbUBeulb
	 ezhxzr2Grr67ogf5HEVahVnzsLTsoOCefxIeQZrebbrjr544sqP/vSw2nvbKijP9BxUjd
	 k6mvaGwz8DM6OA4V+D4pGey46kQZaAArC5Jb9uwn7UXZNOrUVsK88W2bipFgDTCP+LXt6
	 2m/3Mj0A41HA7tUybnuFLVtYmOQ9S4JMpiSyw87uo1YAWZP966/hzSlH7zoyOyWV6fiBh
	 X4JHzPFMz5sSDlcmpnEflxj7p48rgYtJtxv3sRlhthdfE4ld8MaQq/eiYdo8FsA0Lhw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HjsQIk0I;
	arc=none smtp.remote-ip=74.125.228.6
Received: from mail-pz2-f6.google.com (mail-pz2-f6.google.com [74.125.228.6])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F733606A326
	for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 15:49:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8F733606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HjsQIk0I
Received: by mail-pz2-f6.google.com with SMTP id 41be03b00d2f7-cd8cb23d52eso421122a12.0
        for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 08:49:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793375348; x=1793980148; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XeWdEKJNRx847la4OpQ8xK5JYD/W25iZBdkd3AUui+w=;
        b=HjsQIk0ITG7q8guMBxqFHFsECZy30VQbxjEJ2NmMCXdkdDWLTQHQ24VH+fluq1N6JE
         z+kjKcHuearmgOe2xOLYx+LA0iWAcQDxJ3kCfaER8N79zPEGsHUTBHlQ5d9C9W9sbVAS
         7ctHtlZIi0SUwufe0C/QpNZwiRCmO7lpuHdlQBwXXarUCCeNXI21U9th+pFyKz2luU/8
         Q8G+wr/FFAdicTFOx8PAbBKHUwprCMXPywThqzPIHxaK08tTqgEVYhFhslkWcjGnho5D
         7qf6v+xFg4OOHscQYVzoqba0ms9/afxXu5NVaVUuFnBFlftBB/t5d/dI0NEqSLiV3Lmm
         byvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793375348; x=1793980148;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XeWdEKJNRx847la4OpQ8xK5JYD/W25iZBdkd3AUui+w=;
        b=IxeQZ58GFNwlx9Xkwe/2pLK617uj81kVcBDUULRyUE+AnBeFqjoU9pj0YPld77dSwG
         sNjnEcDzOB6PhjB5Mu2jL0CzlLQa0Cb2j1pQBoxU1IVafc33naWZwXCce2DA8yNQvyF2
         bsP3VJjeKk3baj2PItQi8x1kvW+we6/P9TG2uDgvMvSNjWgXjk+9HcvGwySOepsJDLE9
         uuLVpVaByrPetwcYBFnEPDoNBAoCokfekVft0TpIAaKwk1bvP1RmcV2+djNGdJVI59VY
         xS+VV24GEBsVmnkMZdrFKohbKWoOfJawBpLNaH6yp2qHCOonpeyPe1cwK4meJrCqgW1e
         mJzw==
X-Forwarded-Encrypted: i=1; AKwUvBybp3pADRXqog2wcRpqZLL9Tanbc66W8vC3Rvz5FuJQ7ckUGiif6GwtXSw6CDgSbBsD0jkbhbs=@vger.kernel.org
X-Gm-Message-State: AFq9FYLR8hD6BNxsgmfvFwXOW2sXZODthFxoQ88pIZ1fcGdoKuLCJQ7q
	5MWxOhLlpAlnnKJYSfd1x5jqM+Gw+JOuAfbCfunJr/o0MWoeADijVg5t
X-Gm-Gg: AYBFou24lmEBJDi+QfT1NJxpG+aG1jTXhbQr90pMQLA8hJXqp3otqpCGC0QmtcvaB4K
	SKeex20ZOfgtuvE979p71WzCyKxUCnZJh/EWQOGDa+0rqJQ1sXsQY7ghwiUvH8Up5tuIh2jgd+1
	+bSZwuI7FRqNJCnBy1AIJbY8nQ+BYFiDODDlbDqf2Xnwfol8rEWN5+UBmlXo7BrtJa/hhbAiRuc
	c/kbF/79OWNuNCAoqE/Qio+eLoAxSJJHpOuSMPbziG0yDsoIeDqaqpmNHQPKm0sR38D1BKBS3xv
	Ga2CdDq6OSI579I9qz+XHz09s0XaRAeFsnk3s7Eu06HnIi0dwvwgAnoOHfqom5vOlDxA4dALOx+
	MIzxfrZCJbKfgwOE88subhU1izw7MVoCJKrC8Y4BBbi4EuYvrCzKz5dTqStROxR7t5Wp9O7ePIj
	uo3SoODxizUdVYQrRsnzn9wvVhp+wQFT/6j7N/QXIEfkbGQepnjSxy+I482Z8DMJwdDzXvVYbHP
	zHT7gB7Nz/hpR8Ht3Z0rCucfSAVUzI5F2g3H3HBSaC1x6JOomqDK/yRjqoykujVi7AHiQ4zLR8J
	xYUxOeBMIC+AdQgDv2UydAE=
X-Received: by 2002:a05:6a00:3a19:b0:880:fe7b:bc56 with SMTP id d2e1a72fcca58-8a9bf90d0b5mr2497234b3a.50.1793375347794;
        Fri, 30 Oct 2026 08:49:07 -0700 (PDT)
Received: from localhost ([2a03:2880:9ff:70::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8aad9d0259fsm181732b3a.21.2026.10.30.08.49.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 08:49:07 -0700 (PDT)
Date: Fri, 30 Oct 2026 08:48:55 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Bryan Cochrane <bcochrane@google.com>
Cc: Michael Chan <michael.chan@broadcom.com>, 
	Pavan Chebbi <pavan.chebbi@broadcom.com>, netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Joe Damato <joe@dama.to>, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH net] bnxt_en: Take RTNL before netif_close() when
 aborting FW reset
Message-ID: <auS8YWtAoDROqY_k@devvm16445.scu0.facebook.com>
References: <20261029032832.1511180-1-bcochrane@google.com>
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
In-Reply-To: <20261029032832.1511180-1-bcochrane@google.com>

On 10/28, Bryan Cochrane wrote:
> netif_close() must be called with RTNL held in addition to the netdev
> instance lock: __dev_close_many() asserts it, and the NETDEV_GOING_DOWN
> and NETDEV_DOWN notifier chains it runs rely on it for serialization.
> 
> Commit 004b5008016a ("eth: bnxt: remove most dependencies on RTNL")
> replaced rtnl_lock() with netdev_lock() in bnxt_fw_reset_task() and
> bnxt_fw_reset(). That is sufficient for the paths that only tear the
> NIC down internally with __bnxt_close_nic(), but the abort paths close
> the netdev via bnxt_fw_reset_abort() -> netif_close(), and the error
> path in bnxt_fw_reset() calls netif_close() directly. Those now run
> without RTNL and trigger a WARN_ONCE() cascade when a firmware reset is
> aborted:
> 
>   RTNL: assertion failed at net/core/dev.c (1740)
>   WARNING: net/core/dev.c:1740 at __dev_close_many+0x1be/0x1f0
>   Workqueue: bnxt_pf_wq bnxt_fw_reset_task [bnxt_en]
>   Call Trace:
>    netif_close_many+0xb5/0x190
>    netif_close+0xa2/0xd0
>    bnxt_fw_reset_task.cold+0x8d/0x213 [bnxt_en]
>    process_one_work+0x19d/0x3a0
>    worker_thread+0x1af/0x320
>    kthread+0xe3/0x120
> 
> followed by the same assertion from call_netdevice_notifiers_info(),
> fib_rules_event(), inetdev_event(), rtnl_fill_ifinfo(),
> devlink_compat_phys_port_name_get() and ip_mc_down().
> 
> This was observed on a machine in real use with a BCM57504 (4 PFs,
> FW 236.1.153.0) running v7.1.6: the firmware crashed, announced a
> "Fatal firmware reset event" and then failed to come back within the
> advertised max wait, so bnxt_fw_reset_task() aborted the reset on all
> ports:
> 
>   bnxt_en 0000:c1:00.1 eno16905np1: Firmware reset aborted
>   bnxt_en 0000:c1:00.1 eno16905np1: fw_health_status 0x448100
> 
> Take RTNL (before the netdev instance lock, matching the OPENING state
> which already uses rtnl_trylock()) in the fw_reset_abort path of
> bnxt_fw_reset_task() and route the POLL_VF abort through that same
> path. In bnxt_fw_reset() go back to bnxt_rtnl_lock_sp() so that its
> netif_close() error path is covered as well; bnxt_reset() and
> bnxt_rx_ring_reset() already take RTNL from bnxt_sp_task() the same
> way.
> 
> The bug was found by inspecting the kernel log of the affected machine
> and the driver source; the fix was prepared with the help of an AI
> coding assistant (Gemini based) and reviewed by the submitter. It is
> build tested (allmodconfig with W=1, plus the same change on top of
> v7.1.6 built as a module for the affected BCM57504 host). The aborted
> reset path itself only runs when the firmware fails to return from a
> reset, which could not be reproduced on demand.
> 
> Fixes: 004b5008016a ("eth: bnxt: remove most dependencies on RTNL")
> Cc: stable@vger.kernel.org
> Signed-off-by: Bryan Cochrane <bcochrane@google.com>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>
