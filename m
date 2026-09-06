Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBAC82E736A
	for <netdev@vger.kernel.org>; Sun,  6 Sep 2026 04:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788669491; cv=none; b=Tdl70wXQyLXh368T6YYbHD/cizdg1ioreRb7LtYdrfLhchT8SpFFRg7Op2BLEinJO+DHuUZg0cyEsMS8MzeJqrhemQIEnBUS+SshFmdfPLx7LJAvlLr6PBXHr2CvZRw1Ivb2VAA9qO0k8QyFGTgdXlt+fMDnKNH8j0+JVmXzKGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788669491; c=relaxed/simple;
	bh=nJ76k/cQxfKt6GQtEAsaR8fP/KZrVl2CLoxWfkYIVrE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=usB1KKTeh7Yj8bYa0OrbMrIW51aIYadZCairBkyBZI0w1Y9ITAu3sL2oRfPT+gwGYPV9PY28zimpttS2vU+SU/rBh9z+fDkW07QtuvX0Lqd2gDB8SkmXjJK4k71nyYdtwvfWXsNS0LW+d/X+dAUEK6Wuof2e2mrGPxCQhPPQ/8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qmix7NGi; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qmix7NGi"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-49b8eeb3ff2so20336225e9.2
        for <netdev@vger.kernel.org>; Sat, 05 Sep 2026 21:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788669488; x=1789274288; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=I7ZBJrHna+bny0ult5TJeeoJUeb0vemHipmseyBOZuE=;
        b=qmix7NGi3XkhE4IrYuz0KL2SwpsFDtlaEotSbjZGSI6t8TUdEuxPulxiouna84SskD
         zCIbPmyAkF5rwtyvvXFnBKAY+/8gp6kiAxs28yO99kERSr8eF+yj2WXudXDHKjpIWvse
         TGLOQSuThr6rIxSbw/d2XStZNJIYOzNALPdBO6Gq6JXobLNJuJDe2+i8aCP7nJLRBd38
         /fQ3sTJsxlt0c0jZ6jfzEPS/S0CGSk6wDvSv/ppSsfe7Kv6V26VP7X6AEfGbKgMTWUQ/
         +j94bUhSLJATtM7bVFur3GETNuSEkkB8IW80NiNBfsfssyqiNGNiD9AKcP/UrvKV08R5
         qwNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788669488; x=1789274288;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=I7ZBJrHna+bny0ult5TJeeoJUeb0vemHipmseyBOZuE=;
        b=TIYR/KmgTv8lTws20OMU56U3bAfpdHfJBuqMXdeHHG2evrr3M+kzYlaAQJQ68mxVxK
         5ISAbIewzJKZ4Ncn0MnJLPR0LtYwEnwjoxt1D02B6Y0G2TgDPjOtNYm1KurjEeTAnRVT
         QLDyODRSE7AQXfKMQh6vNDVvFha41aRb6T6endPpFMf0ZzlNaSem3r2IgOcLwuV4VVd8
         SjybxfFcG3SiupZB1W/tFjrrtkxrCJBkGQJQsL+Ib1JW29mAGoNzsOPMbe9ErsNSL1pJ
         jaynTdeVNx+mtpDrj1zZKfnSNeAHCLYbsenDmwjIfWN54Mf8+pBkC0JXgLtpHy0X+mv2
         fYSQ==
X-Forwarded-Encrypted: i=1; AKwUvBziG+n4I8IbO5MfahjapbtmwPil/2tHNC8IgWJuDLmOfn+SfVo20i7VapK5oWoEsExrQzSgTYY=@vger.kernel.org
X-Gm-Message-State: AFuF++niQuDaT/YXUF9gP8+YwUsIusXEPrGyCRRHR4V+2GlOnbPE2hmx
	InDzc7BAxZirugS5Aww+8sC8wjNeCxdiICC00wr9egsw/qns5YIyuQ4=
X-Gm-Gg: AYBFou2UiHyA2qRdVosCrJr/jw7iCBPC3DN1Ud3CTrpRGTBsFQ8Z5uFCcs6AQoY+iRQ
	+GU2KrBOlDxOnF3o3ctyxnbu5oy6NBFHQAGuQVA0ZGhBljBzCosd8IFt8iWKdqBYmLwoRIGYEuH
	1tkFfF74X8lwLIzCL+wILSe5UjiJV3z4yDcSCobAorcx9Xd+53yQlApbN8q5vOFM/RZFu8yJdAS
	WNKb8kC3b3p6Trd9pH2N6t0p44UwjWqSLRg0r9WA5EokXdoJZ17xqgKv1QtPusrqTlkjE4WilOE
	wjAwXh8vpISidKrAl0So4oJkljAKut0K131Xuh9L936n1GT7t4WHiIPNEg9fFZNbhojSlVVgb91
	b14uzjU2KvF6Us1kswWCNTzxF4dRQ/tfW8iRiAvLJdMiXug/PU6bnqTHIXoAwd37yG1xiX8JRPF
	7758dpoXRazjFvwWfMKd7we8Zb4bSIJovDVsPykKiSeET7q+EC/33FCb9wnxB13w==
X-Received: by 2002:a05:600c:1c24:b0:498:952:e276 with SMTP id 5b1f17b1804b1-49cf824894cmr174054505e9.8.1788669487768;
        Sat, 05 Sep 2026 21:38:07 -0700 (PDT)
Received: from fedora ([46.8.219.5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49ce5936a5esm145690735e9.3.2026.09.05.21.38.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2026 21:38:07 -0700 (PDT)
From: Vitaliy Sochnev <sochnev.v.74@gmail.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	netdev@vger.kernel.org
Cc: upstream@airoha.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Vitaliy Sochnev <sochnev.v.74@gmail.com>
Subject: net: airoha: RX rings below 32 descriptors let hw DMA past the ring
Date: Sun,  6 Sep 2026 07:37:50 +0100
Message-ID: <20260906063750.719445-1-sochnev.v.74@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1788286284.git.sochnev.v.74@gmail.com>
References: <20260830095717.37218-1-sochnev.v.74@gmail.com> <20260831234701.206021-1-sochnev.v.74@gmail.com> <cover.1788286284.git.sochnev.v.74@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

e84b89f17a12 ("net: airoha: grow the small RX rings") is queued for
net-next as an RX loss fix. It also stops hw from writing descriptors past
the end of the ring into unrelated kernel memory, which its commit message
does not mention. Given that, it may be worth stable.

Nokia XG-040G-MF (AN7583), 512 MiB, 6.18.44, OpenWrt snapshot. Images
below differ only in RX_DSCP_NUM(); no other patches, no instrumentation,
verified against vmlinux. RX_DSCP_NUM() is shared, so other variants with
a small ring are presumably affected too - not tested here.

Reproducer: raw UDP frames with source port 67, so REG_FE_VIP_PATN(8)
forces them to ring 4, ~900 pps to the board's MAC. With ring 4 at 16 the
box panics within a minute.

Mechanism
---------

At 16 descriptors ring 4 occupies 512 bytes; dma_alloc_coherent() rounds
to a page. After the ring stopped advancing, the remaining 3584 bytes of
that page contained 560 non-zero words repeating with a 32-byte period -
sizeof(struct airoha_qdma_desc):

  +4  ctrl  0xC0000000   QDMA_DESC_DONE_MASK | QDMA_DESC_DROP_MASK, len 0
  +16 msg0  0x00008000
  +20 msg1  0x2A5E0000
  +24 msg2  0x007F000E
  +28 msg3  0x0000FFFF

msg1 equals the value in the last descriptor the driver did see, so these
come from the same engine. REG_RX_RING_SIZE(4) reads 0x00020010 - the size
field is programmed correctly as 16. Writes staying inside the page are
invisible; past it they hit whatever follows.

Panics
------

Three on the 16-descriptor build, all garbage pointers in subsystems
unrelated to networking:

  __queue_work+0xa4 <- dbs_irq_work (cpufreq), x21 = 2d9ce5fd003cae80
  sched_balance_rq+0x84 <- sched_balance_domains, addr 0040000034124819
  Kernel panic - not syncing: corrupted stack end detected inside scheduler

The third occurred with no synthetic load: ordinary DHCP traffic after a
network restart, 4 minutes in.

Ring size is the only variable
------------------------------

  ring   frames fed   page tail after run   panic
  16     27 000       560 words, signature  yes, 3x
  32     271 909      0 of 768              no
  128    269 845      0 of 1024             no

Controls: the same scan on idle 32-descriptor rings reads 0 of 768, so the
560 words are not pre-existing content; 273 292 frames of identical traffic
on a non-VIP source port (ring 0) caused no panic.

On the shipped configuration (ring 4 = 128, default 32) the board also
completed 1623 consecutive PPPoE dial-ups, 16 VIP frames each, and ran
9 h 52 min of DHCP with renewals every minute - 1178 samples, no lease
loss, no rx errors, no panic.

The boundary is between 16 and 32. The vendor SDK default is 32, which
looks like a hardware minimum rather than a tuning choice.

Question for airoha
-------------------

Is 32 the minimum RX ring size the QDMA accepts? If so the driver should
clamp or reject smaller values rather than depend on RX_DSCP_NUM() being
large enough.

Withdrawing the NO_CPU_DSCP patch
---------------------------------

Please drop

  [PATCH net v3 1/2] net: airoha: handle RX_NO_CPU_DSCP interrupt

acked by Lorenzo, not applied. Its rationale - ring drains to zero, the
dropped NO_CPU_DSCP interrupt leaves it dead - is contradicted by
measurement:

  - NO_CPU_DSCP never fires. Instrumented builds logged zero events across
    every run; REG_INT_ENABLE(bank0,1) reads 0x839F839F, so the bit is
    unmasked for ring 4.
  - page_pool_dev_alloc_frag() never failed and q->queued never reached
    zero, so the described path is unreachable.
  - A/B images with and without the patch failed identically.

airoha_irq_handler() does drop the interrupt, so handling it may still be
correct, but not for the reason I gave.

Correction
----------

In the v3 cover letter I asked whether out-of-order completion pointed at
a constraint on RX_CPU_IDX, having seen QDMA_DESC_DONE_MASK set in the
slot fill_rx_queue() leaves unposted. airoha_qdma_rx_process() never
clears ctrl, so that bit is the residue of the last consumed frame.
Disregard it.
