Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792697804;
	b=ECsikR4DpivAFW0sXBOUx6pEzuuVK/b2eKeuSI50s36x8hwNdQklDXJz1OJMvEtnQNcP
	 kAKRxWofTinvZQHPUawDbtiIuVmSFTt05wsyzSLjttgQ0MTa3MvyY9Fx82eRCx4rlkS6h
	 38lhAecKTxgLWUvHa5x8CAoNEK1PjO5QxzimzOwzKHo0oOGhWQd6uHTZTIRS7vaNGXwOE
	 FoCREULRZxDdz7qDMoz4lD53h3/oWlj9OOyGW4CBTwbvGwDcL/5SvPZ8EQqkW5dohjQse
	 GoQ040ORdXzhwp+uQHJNuNfXl3eyaekEm2mvPoPvDCzb++z6Lyds338ZzlxGqfBprvg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792697804;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=PZPvfX1rm0qpo9fUpVJwjmTY46uavpRGLm5yVTqEhw4=;
	b=AmrUyVUCu9/WPaLdF/jUtK3fANe8w1m/5pUVZVgjvVda6wqNKXAIRXm375LO97k9PjbZ
	 2C0OPH8uZpdnHov4AGeE+RVumkFKrdl5onZv3Jri7TeoJp7ljLW8nZJ8nG4g1eQs7tBDr
	 tHjP/q9HziV6N9qPLqH2moNzMgNQQ+feyzZUAst7+hK0kVobseGaa7dGBCNgyz6I0KdxS
	 uV1RNx2JxhhD56FDJL0cQuGq9L7zTYLe50FZ+Xf67m11SOhwf0s+t8CPzp64LyepSqSlD
	 lMGf9KJk7uWPSCIpLWThv8A+jzB/CFh5n/lC1LzL+9fvtQoezThHfvvA8AmYP6h59Iw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=aux0XHRy;
	arc=none smtp.remote-ip=209.85.218.53
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D43D606A319
	for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 19:36:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5D43D606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=aux0XHRy
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-c3fd91337baso24942466b.3
        for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 12:36:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792697803; x=1793302603; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PZPvfX1rm0qpo9fUpVJwjmTY46uavpRGLm5yVTqEhw4=;
        b=aux0XHRy9keUSnl9ec248N3wTjgf+6vJY7w6kgBPN5l50LjSLm7+/XsAJiL2CUKTxT
         GiBpbm03ztMLKK68x9VGwy2yy0EnOJS5JEW31xXsDPNyMhrfdMiqtVe6xJHmFdKxKsI9
         qAw0hOmL7iXRDT+y4K82k0+Vfb4E/bY58CYnrHSNSYx8tmsxoEw34S9VLwp1GaLjY/x3
         TfUlTrkkagRbZr7Jq6ABqsY0iwdlcp46LEDG4mUImr5/kHBQKQKjKuEZrJc/as6WNHlJ
         VyhxtAZ6iHkgAt1tM6A6+4Z9cuhk9cf2Py/iFFtcLxLP8Dor+dDfGjpQO1Q8fjqlylZd
         t4Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792697803; x=1793302603;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=PZPvfX1rm0qpo9fUpVJwjmTY46uavpRGLm5yVTqEhw4=;
        b=WnAnSCGnQyd0qSRdq+E18plWX+IJ+rDQlHo8yvKnRifUMqYx1C20zIufUc6qUMKT6E
         JulhYofl4AYYyGsNMray8zhGiko+4wD89dOBNolPDjaw1fWL4YReDvNKc564viba3k26
         Unc6fbpHvaNbjmhBQDPO78fG1rdXRW4nw6blePlRvMFHxZfYwgJC7Gzdg+64GBGZZZyP
         Ro5JstHMOY2soH+1q/nGP46t540VIqkMCoCDORAVmiko5bR1d/wvmPZNKNmwq+/R9QZG
         b+yR3EHEraxi8+8Gt00MWhKoUrxhiOqQwxJ/8Ff/lnWuxYSIc8UkRitFsnM99nSrREdd
         1JZQ==
X-Forwarded-Encrypted: i=1; AKwUvBzQsiTAy761PE8Jpbw67D9iKwNch2wAy285q/cV4jUJKd186AITyC6HSpekQJwHKucvxPIKtqI=@vger.kernel.org
X-Gm-Message-State: AFq9FYKMm9qQpclVsvJnP0AIAFBe+4YbtRGP2qzvEVLjmWh0meMMo/hj
	xQMcv0Izgu166MwZOVLZRdXxWW/0ZEPkKT0VwXp7vkkSY1U1IDEXKPMWVgJv1Ip8XHU=
X-Gm-Gg: AYBFou1ylVqDBCzeQH97mXEqFYrwr+tHxnc+aF8f50YZBAwj5D8oOgtTmgkODtFFS22
	vfs1oAiIRPEMj6aQvVkQypR2cAGX/oftZ55m1Jvndky6egn0iJ/IXgMnQGpe66b2NXzCuN2MbOb
	HvMGEbhh4W1+w+kunblfAj4Gxdt+g6xHQYnvzyqq6K/VI96ppgfckUSZ45dREP3ZN0Lp7HOey12
	2yBy2ucldoKUr03+XmRZqEZrYG9gCj16L1vDW1mXpd8hI/mj3l7PtadQLEN7iHttao1ZqWpmLZz
	PRDCI9cguML4tSFdxGV21fK+XMjP+2ieabHrAftDff3q0iECDxBIoAwOGe2U2O1raUHzcLQIjFF
	X7IjRuWlLWmRhLa7hHb0VYL8aZxx/1bNDvybqN+9WGg5RiS5AG/E+q5m9Fy10woZBpktdvCFTQT
	538morwarhMqoS4sVPnukMwpCHAMRRft7CFubCfOb56sBV/36XzI5cGQpUxezlm3MeJsggQQz/h
	es6upOoznm7czbix5j+yP52JUwlQyLuotHmf8EzK+1gVvnc4Q==
X-Received: by 2002:a17:907:dac:b0:c3f:98d4:dfe2 with SMTP id a640c23a62f3a-c46a908932cmr24015266b.18.1792697802406;
        Thu, 22 Oct 2026 12:36:42 -0700 (PDT)
Received: from localhost ([2a03:2880:32ff:4f::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c46a5ca4fa2sm22651766b.49.2026.10.22.12.36.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 12:36:41 -0700 (PDT)
From: Vlad Poenaru <vlad.wing@gmail.com>
To: Jinqian Yang <yangjinqian1@huawei.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Marc Zyngier <maz@kernel.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Breno Leitao <leitao@debian.org>,
	Andrew Preece <apreece@meta.com>,
	netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	regressions@lists.linux.dev
Subject: Re: [PATCH] irqchip/gic-v3-its: Enable dynamic MSI-X allocation
Date: Thu, 22 Oct 2026 12:36:20 -0700
Message-ID: <20261022193620.2152038-1-vlad.wing@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260715035437.700601-1-yangjinqian1@huawei.com>
References: <20260715035437.700601-1-yangjinqian1@huawei.com>
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

Hi,

Commit 0d6a7c417983 ("irqchip/gic-v3-its: Enable dynamic MSI-X
allocation"), merged for v7.3-rc1, breaks bnxt_en on our loving Grace
machines. Reverting it fixes the problem on current mainline.

Hardware:
  - NVIDIA Grace (Neoverse V2), ACPI, GICv3 + ITS
  - Broadcom BCM57508 (BCM957508-N1200FJ), FW 230.0.165.3, bnxt_en
  - The same platform with a Mellanox NIC (mlx5) is not affected

The trigger is a ring resize: a boot-time udev .link file with
RxBufferSize=max, i.e. "ethtool -G eth0 rx 4095 tx 4095". The close
path never gets the HWRM_RING_FREE completions, then TX times out and
the machine hangs:

  [   58.221] bnxt_en 0002:01:00.0 eth0: Resp cmpl intr err msg: 0x51
  [   58.221] bnxt_en 0002:01:00.0 eth0: hwrm_ring_free type 1 failed. rc:fffffff0 err:0
  ... (repeats every ~3.7s for every ring)
  [  215.539] bnxt_en 0002:01:00.0 eth0: NETDEV WATCHDOG: CPU: 69: transmit queue 18 timed out 5118 ms
  [  215.539] bnxt_en 0002:01:00.0 eth0: TX timeout detected, starting reset task!

Bisecting v7.2..v7.3-rc3 on this machine points at the irq-drivers
merge (8b5d31123f41), and within it:

  good: 9023960b74ab ("irqchip: Remove redundant dev_err()/dev_err_probe()")
  bad:  0d6a7c417983 ("irqchip/gic-v3-its: Enable dynamic MSI-X allocation")

On current mainline (f47d223627f8) the same machine fails at ~55s;
with the commit reverted it runs cleanly.

So far it only reproduces with our debug config (KASAN, lockdep,
DEBUG_PAGEALLOC, DMA_API_DEBUG, CPUMASK_OFFSTACK, ...), not with our
production config. I haven't narrowed down which option matters.

My guess is that with pci_msix_can_alloc_dyn() now true behind the ITS,
bnxt switches to dynamic MSI-X allocation and something on that path
loses the completion interrupts, but I haven't root-caused it.

Happy to test patches or collect more data.

Reported-by: Andrew Preece <apreece@meta.com>

#regzbot introduced: 0d6a7c417983b

Thanks,
Vlad
