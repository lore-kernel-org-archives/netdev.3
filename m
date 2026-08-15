Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C32EB390224
	for <netdev@vger.kernel.org>; Sat, 15 Aug 2026 19:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786823687; cv=none; b=cPv0vydE/kqLHGXLldQdN4xu+Ar3GbVR+ZLqxSY0qxMBYf3Bmz3JBz+tmQJLXPxQNwFisOybzyXOOdGozcQGGl+9OLAZ3MBZSkKJ3U4AO9S9Ku06dXINZ+fCz0Z1ITFKk8N3LCMl39pY1qWesVjcHUUttwFLUl2N/fVXP/NoRn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786823687; c=relaxed/simple;
	bh=kWTeXh3Svt4m5rvAE5ofGNUOjIyRiqMTYPld1Ha4ou4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=azhi2m/uYc5OifdgMrLC447zJIsdbbrsSTr/pdWCTEtM4awEHLUVdC4zpqXULdZY4rZ0xCUnOTMAQy91Qqu7GuKKrCXAYQEpgIvTgOpe4SmxQvcaiL73XW+LZkJGtOAU+c7WBBiwcWH60zr8ucA7yt/XlXwtILL1Q27d3HE67eU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=frGua4P3; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="frGua4P3"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4955c545a94so2594285e9.3
        for <netdev@vger.kernel.org>; Sat, 15 Aug 2026 12:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786823684; x=1787428484; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=D73r29eo7FuE38av/tnsBvaxMVdSvt5ucMGI01LSnOc=;
        b=frGua4P35OsTbtBcKGgTr0/TN+W/nDajrf/wlcyeJPRfQI2laAxjmp3BmQ2i1UI9+D
         yz2U9tt7bU7NZEWfNoPAKABxLvRjLwiBf0OTpus//sLfiJD91pJp+NodfFqf52xBI6wG
         PS96YKkBKLCQYU7vRdtmS/SVSfap4KHsqxE+83mu8z1DPoWshs1fvd4HbufHRciCDMd/
         K4qjMLWBOm9HmOafLr+TDDHWb7/B7cWJPJaN+gwAmNxLP6Xpf2HnQbAk8RndUFjOsob0
         /SCrqDOS1KvMTEf1yF2tbszp5wvoI93KywymKvl0SzUUCdBJL6sHfCmMjUGr0uzKY5q9
         Bcag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786823684; x=1787428484;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=D73r29eo7FuE38av/tnsBvaxMVdSvt5ucMGI01LSnOc=;
        b=e41EsTX+QeGDjwN6lcZN8UKdZZonSj9WU8vufFgxyFEHqoxhEAu4l8KkjYnGFOcnWE
         bSNSWn4ZJHrP7LzL0O6jZTamSzz/1OD+xBN3+i6P6ijEBHDIiAXtmUPkSqD//li5pwgI
         E4o4I0b6qisDaeh6uM/g1tVatBXiTAlNlKvNLaWJe84MOoNForfyklbJdesfvmBZqRAI
         mizm5FPzCGS3HBaWxo5te/Im6HFuS0GWTFwpLO8+gGVVCk6HfmMNpSfwHkLUswtH8op9
         pgmsBtWYa+n/eNV42xdEVQd7LAEIVDWoSs+ihlXwpCpE+Qp/8cP0U3ged66fNWS/H9KM
         yNHg==
X-Gm-Message-State: AOJu0YxisHdJrZ1Rw8147k4AGw0e4vZ+CPFqVkshKW4Xgg/HKMWsWEhQ
	xY+RSpIgPayodGkCvuxmcmjuegQyQskhxjylJLqiXQ32IS7MB2qd9SZ8Jjcs9VmP
X-Gm-Gg: AR+sD12BIFBWS1YggQmwqg57WRKkklRjUm454RH0/Qn9l0o6YxIF1hK8BZXApKm3jWr
	Zs4BOlBLaTezOa7lxt2C+WTvT9Nli7Z2zAu0AB6LaXzUQuUAqkKYF1QkNAKFpwWmvqTQY2FJfSv
	qJ0/vYOlzPwgfOj9Vo+hoSgT+qA5+jXfoC1qJxm/1Ih8WFTupFHDLYosAdayCQcje46XoRwaEqG
	osH/GsTj5HDkzf90mecFS8eNN5B+JduvmCpaOJ13gCowt+upBgOuSTbJhz3ob847eKN5dhC+Yjp
	d6efG3JUi6w79vSCPP6lGB6IU0mx2yam1MHCezRAfjk3jWdQtQK0MYGFTNGqwx6zsVSo4WLIiWz
	1zvUDfZlFSy/T9f+sOqevksYUtX1lnUu+rA5CHBBbksJxGubuVc3kHpFFwQBCaGzhB5aEz9082T
	3+Jh90qQhsal8J2qEc7NrRkY54I1VSJVqOb3UaFqd6neZ7a6kSQqTxBaEUb8YUCSV5cPk+oqD/5
	3oppRHuYyefINtOL1+I3a4fltkvr2MMNR5TpSSsAw==
X-Received: by 2002:a05:6000:402b:b0:481:3db3:8eb with SMTP id ffacd0b85a97d-4816072df98mr10085524f8f.1.1786823683911;
        Sat, 15 Aug 2026 12:54:43 -0700 (PDT)
Received: from [127.0.0.1] (ip-109-193-028-127.um39.pools.vodafone-ip.de. [109.193.28.127])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4815f2c46besm18757609f8f.31.2026.08.15.12.54.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Aug 2026 12:54:42 -0700 (PDT)
From: Marek Czernohous <mczernohous@gmail.com>
To: netdev@vger.kernel.org
Cc: Rain River <rain.1986.08.12@gmail.com>, Zhu Yanjun <zyjzyj2000@gmail.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Tobias Diedrich <tobiasdiedrich@gmail.com>,
 linux-kernel@vger.kernel.org
Subject: [PATCH net 1/2] forcedeth: fix off-by-one when saving/restoring
 non-PCI config space
Date: Sat, 15 Aug 2026 21:54:38 +0200
Message-ID: <178682367885.3748309.10595890901761762683@gmail.com>
X-Mailer: python-smtplib
In-Reply-To: <178682367884.3748309.5288746298966501007@gmail.com>
References: <178682367884.3748309.5288746298966501007@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

From: Marek Czernohous <marek@czernohous.de>

nv_suspend() and nv_resume() walk the non-PCI configuration space with

	for (i = 0; i <= np->register_size/sizeof(u32); i++)

which runs one iteration too many. saved_config_space is declared as

	u32 saved_config_space[NV_PCI_REGSZ_MAX/4];

and NV_PCI_REGSZ_VER3 is equal to NV_PCI_REGSZ_MAX (0x604), so on a VER3
device register_size/sizeof(u32) is exactly the array length and the last
iteration addresses one element past the end.

The element it lands on is np->name_rx[0..3]: saved_config_space[] is
followed immediately by char name_rx[IFNAMSIZ + 3], and char needs no
padding. Nothing observable is corrupted by that, because nv_request_irq()
rewrites name_rx with sprintf() before it is ever passed to request_irq().
The bug is the out-of-bounds access itself, which UBSAN reports and which
CONFIG_UBSAN_TRAP=y turns into a trap that aborts the running kernel code,
plus an MMIO read and, on resume, an MMIO writel() to base + 0x604, one
dword past the range the driver mapped:

	np->base = ioremap(addr, np->register_size);

VER1 and VER2 devices stay inside the array, but they too get the stray
read and the stray write one dword past their own window.

Caught by UBSAN on an Apple Macmini3,1 (MCP79) during a deep S3 cycle.
The splat below is trimmed: the build path in the file name, the CPU
and taint lines, the Workqueue line, the "?" hint frames, and the
frames below device_suspend are all cut. The kernel was tainted, with
an out-of-tree nouveau and CPU_OUT_OF_SPEC; forcedeth itself was the
stock module.

  UBSAN: array-index-out-of-bounds in drivers/net/ethernet/nvidia/forcedeth.c:6225:25
  index 385 is out of range for type 'u32 [385]'
  Call Trace:
   dump_stack_lvl+0x5d/0x80
   ubsan_epilogue+0x5/0x2b
   __ubsan_handle_out_of_bounds.cold+0x54/0x59
   __this_module+0xe398c/0xe9010 [forcedeth]
   pci_pm_suspend+0x80/0x170
   dpm_run_callback+0x51/0x160
   device_suspend+0x1a2/0x4a0
   ...

Both loops are hit. UBSAN reports each source location only once per module
load (__ubsan_handle_out_of_bounds() calls suppress_report(), which does
test_and_set_bit(REPORTED_BIT, ...) on the struct source_location), so the
two splats land in the first S3 cycle after the module is loaded and later
cycles are silent even though the access still runs off the end every time.
In that first cycle line 6225 is reported from pci_pm_suspend and line 6240
from pci_pm_resume.

The same off-by-one was fixed in nv_get_regs() by commit ba9aa134287f
("forcedeth: fix buffer overflow") in 2012; these two loops were missed.
The suspend and resume side was reported on LKML in September 2013 by Marc
Weber, with the same analysis and the same one-character fix, but the patch
was attached rather than sent inline and the thread ended there.

Use < instead of <=, which saves and restores exactly register_size bytes.

Fixes: 1a1ca86158ee ("[netdrvr] forcedeth: save/restore device configuration space")
Cc: stable@vger.kernel.org
Signed-off-by: Marek Czernohous <marek@czernohous.de>
Assisted-by: Claude:claude-opus-5
---
 drivers/net/ethernet/nvidia/forcedeth.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/nvidia/forcedeth.c b/drivers/net/ethernet/nvidia/forcedeth.c
index 58d3e55def48..dc804e111564 100644
--- a/drivers/net/ethernet/nvidia/forcedeth.c
+++ b/drivers/net/ethernet/nvidia/forcedeth.c
@@ -6221,7 +6221,7 @@ static int nv_suspend(struct device *device)
 	netif_device_detach(dev);
 
 	/* save non-pci configuration space */
-	for (i = 0; i <= np->register_size/sizeof(u32); i++)
+	for (i = 0; i < np->register_size/sizeof(u32); i++)
 		np->saved_config_space[i] = readl(base + i*sizeof(u32));
 
 	return 0;
@@ -6236,7 +6236,7 @@ static int nv_resume(struct device *device)
 	int i, rc = 0;
 
 	/* restore non-pci configuration space */
-	for (i = 0; i <= np->register_size/sizeof(u32); i++)
+	for (i = 0; i < np->register_size/sizeof(u32); i++)
 		writel(np->saved_config_space[i], base+i*sizeof(u32));
 
 	if (np->driver_data & DEV_NEED_MSI_FIX)
-- 
2.54.0

