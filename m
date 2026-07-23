Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A62C52BEC55
	for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 03:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784777971; cv=none; b=qKZtl781Z4gQaSQX4qD9BcIev6U+jBKtshqxKk6nx1/NzG47oCpj6fX1jCFJkTxbvezAol3QHfHXbauoJV/fvpZ7NVuZkLTez3YJqViG0D4OQYWo8WeMqgr+QBWoa39seN396OYPnmqYXiKqOT345fpkVT5lI/+JfVz8h2xCS9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784777971; c=relaxed/simple;
	bh=GcSQDAE1wRtLPtrlrb8ZIN/uvi9Y+ars5Q6AEC/DnE0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G+qW66NN5luJMK3Oyk7s4w1D6NjhoqHULTReFj1LivqGa/9YxcnsRru8V7tGh11f1MjhFXnUIo7BOQ0p+Tb4HiF9shwgfpfjW8l6gAslzUp8JkJjQK/X/WuUiHFmFnrpcOWF6paiUswyB/Ml+GCsVLP3wb0vSN2xShmvzmh6hFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q27keboN; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q27keboN"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-8ff88549786so2099736d6.3
        for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 20:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784777967; x=1785382767; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=JZjcmph09vEWik6hkHqT0aUjM+ij2e4ZNys+sdCisss=;
        b=Q27keboNDVCxwkr3Tk9NDPWK6k8/PvWBGURB4CxmpeJyJ6pj6x4/COsYp6SADnChkh
         gwBCTVVXgsn0iIEQ5sX5R5+pIQRE/KdPBYB9HcNBLhgqNgtibfWSIkA58T62UWuL9um+
         I9By+lT+iS75VxuxCic3xQnerfIuxi7zicvb9x42QCQ+z4baoJ9uq0pwmZVhviltRK2Z
         dF4y2nQ7lxAVUMHnra8DTbkAJdtnuJgDRD3Yw7DXX0ujfHHzSRs7xbwQZmqEXyH0YBMl
         rS+rGfI9gfYxAkd/iMq0tz9/qIN/Wph6DGJJr1gPcLUr3hT/QqoJk1MuD6BtOfXRtaWj
         tDdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784777967; x=1785382767;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JZjcmph09vEWik6hkHqT0aUjM+ij2e4ZNys+sdCisss=;
        b=cfM3UVjFpAUAUDeZqhOMUhcDYqEMlUfftFw/UJNoa+Nf9y7bW2xfHcUTWGAQnk3sSV
         +EQTuswH96punDnBUmGEMJfJNmCJQZSIz5ze0dp2bQYE96dRY7mluaNVOr8O1wYaBC/9
         BvHmNY6PncG/HVg4TIYD+aH7CLzLCgnwEk6Ib8dwWzi/VGwztUMl1xA857EKdjGWsNBS
         JYkZ4Ek73gERhUGrMLhB9vA5fihcaxqkzAElzRmKayctc43cy219y7GOpv+Ycp9GZO6/
         nUrYnb8RmVebNv8GwFOWSuwuNMgOgdHc0zpKuqkWNEsJPhbjm0e1+trOO3S9Jl/K4w+7
         rEsg==
X-Forwarded-Encrypted: i=1; AHgh+RpB8gJITmZ4upWKxTtYRbBA4YlNGCL3OMN6Ibfb3YmXqpGLfJdww/+NHlmbe2DWBaFuyWIAmlg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+tgL/cSGQADqowKLFZRO0VC3enOkVu2gAcP2cpC/YDnpoIKNO
	hs39uZ0IPn1LpeRG4cOC0kqXKLRIuyubOIwRztuYPW/rtk3oDaILNBtxWGhRkmn9
X-Gm-Gg: AR+sD1243mXmonQBh0TAbdlj9ClcAGXplZM7fzVq2YBP6NgY4NYlkO0WPu+8F8QelZ8
	94yykAORdGb2CRj6K+dSUc8/JJ120mZllSeHwvz/rl7LZGMbC2Y6Hg2IPVpTJu6oUyNDef8XvGw
	U8rsSwVGkZXzYWAhJxISn2GYzDyToYO0Y3FJ6IvybOlQgyNXT3BFBUp+HTpkmEdiTMRrZSI7NFH
	eRySMk750MTkIFksbXAOGJ6WC/yeiLv5QM9aCbd1mnAPRSma03JFKFknmJGAr011dBM5iwhBiIn
	Tgh0Ghe6pQ2ofEHbfeHcStGoLzqX1vWpdTXslgPgeuBJBE4J+nVyYeSS1Oh5RgNmrsKF++QeNdf
	s8cd08MucOI6RBez9rQPzTTMOKLW8tADU87YqcYzY+YVYxILHC8BHYO4KVIB89HyzDQVukKFor4
	qbFBzyfnz9/QKp7O+1GSuYTac7sbWmROA=
X-Received: by 2002:a05:6214:1d0d:b0:8fe:310f:7f4 with SMTP id 6a1803df08f44-907ca5572cdmr18684376d6.49.1784777967640;
        Wed, 22 Jul 2026 20:39:27 -0700 (PDT)
Received: from i4-l-hqh5357-03.ad.psu.edu ([130.203.139.71])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-907ba8df5d0sm35952586d6.18.2026.07.22.20.39.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 20:39:27 -0700 (PDT)
From: Shuangpeng Bai <shuangpeng.kernel@gmail.com>
To: Alexander Aring <alex.aring@gmail.com>,
	Stefan Schmidt <stefan@datenfreihafen.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Shuangpeng Bai <shuangpeng.kernel@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-wpan@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [BUG] mac802154: KASAN slab-use-after-free in mac802154_rx_mac_cmd_worker
Date: Wed, 22 Jul 2026 23:37:58 -0400
Message-ID: <20260723033829.764639-1-shuangpeng.kernel@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Kernel Maintainers,

I hit the following report while testing current upstream kernel:

KASAN: slab-use-after-free in mac802154_rx_mac_cmd_worker

on commit: fce2dfa773ced15f27dd27cd0b482a7473cdcf2a (Jul 16 2026)

To help trigger the bug more reliably, we applied a minimal diagnostic patch
that only adds delays and print statements.

The reproducer and .config files are here.
https://gist.github.com/shuangpengbai/ea5e98e729d2ae8cb1e9481b5c315ab8

I'm happy to test debug patches or provide additional information.

Reported-by: Shuangpeng Bai <shuangpeng.kernel@gmail.com>

[  376.015401][   T12] BUG: KASAN: slab-use-after-free in mac802154_rx_mac_cmd_worker (net/mac802154/rx.c:110)
[  376.016760][   T12] Read of size 4 at addr ffff888115e78b58 by task kworker/u8:0/12
[  376.017796][   T12]
[  376.018231][   T12] Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX, arch_caps fix, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[  376.018237][   T12] Workqueue: phy1-mac-cmds mac802154_rx_mac_cmd_worker
[  376.018270][   T12] Call Trace:
[  376.018292][   T12]  <TASK>
[  376.018302][   T12]  dump_stack_lvl (lib/dump_stack.c:94 lib/dump_stack.c:120)
[  376.018393][   T12]  print_report (mm/kasan/report.c:378 mm/kasan/report.c:482)
[  376.018529][   T12]  kasan_report (mm/kasan/report.c:595)
[  376.018543][   T12]  mac802154_rx_mac_cmd_worker (net/mac802154/rx.c:110)
[  376.018560][   T12]  process_scheduled_works (kernel/workqueue.c:3322 kernel/workqueue.c:3405)
[  376.018589][   T12]  worker_thread (kernel/workqueue.c:3486)
[  376.018599][   T12]  kthread (kernel/kthread.c:436)
[  376.018647][   T12]  ret_from_fork (archkernel/process.c:158)
[  376.018735][   T12]  ret_from_fork_asm (arch/x86/entry/entry_64.S:245)
[  376.018754][   T12]  </TASK>
[  376.018758][   T12]
[  376.032833][   T12] Freed by task 8455 on cpu 0 at 375.611793s:
[  376.033290][   T12]  kasan_save_track (mm/kasan/common.c:57 mm/kasan/common.c:78)
[  376.033651][   T12]  kasan_save_free_info (mm/kasan/generic.c:584)
[  376.034018][   T12]  __kasan_slab_free (mm/kasan/common.c:253 mm/kasan/common.c:285)
[  376.034371][   T12]  kfree (./include/linux/kasan.h:235 mm/slub.c:2705 mm/slub.c:6405 mm/slub.c:6720)
[  376.034677][   T12]  device_release (drivers/gpu/drm/vkms/vkms_configfs.c:690)
[  376.035065][   T12]  kobject_put (lib/kobject.c:689 lib/kobject.c:720 ./include/linux/kref.h:65 lib/kobject.c:737)
[  376.035413][   T12]  netdev_run_todo (net/core/dev.c:11749)
[  376.035808][   T12]  genl_family_rcv_msg_doit (net/netlink/genetlink.c:1117)
[  376.036235][   T12]  genl_rcv_msg (net/netlink/genetlink.c:1194 net/netlink/genetlink.c:1209)
[  376.036574][   T12]  netlink_rcv_skb (net/netlink/af_netlink.c:2556)
[  376.036933][   T12]  genl_rcv (net/netlink/genetlink.c:1218)
[  376.037233][   T12]  netlink_unicast (net/netlink/af_netlink.c:1319 net/netlink/af_netlink.c:1345)
[  376.037584][   T12]  netlink_sendmsg (net/netlink/af_netlink.c:1900)
[  376.037930][   T12]  __sock_sendmsg (net/socket.c:775 net/socket.c:790)
[  376.038335][   T12]  __sys_sendto (net/socket.c:2252)
[  376.038676][   T12]  __x64_sys_sendto (net/socket.c:2259 net/socket.c:2255 net/socket.c:2255)
[  376.039018][   T12]  do_syscall_64 (arch/x86/entry/syscall_64.c:63 arch/x86/entry/syscall_64.c:94)
[  376.039455][   T12]  entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121)
[  376.039998][   T12]
[  376.040171][   T12] The buggy address belongs to the object at ffff888115e78000
[  376.040171][   T12]  which belongs to the cache kmalloc-cg-8k of size 8192
[  376.041250][   T12] The buggy address is located 2904 bytes inside of
[  376.041250][   T12]  freed 8192-byte region [ffff888115e78000, ffff888115e7a000)
[  376.042239][   T12]
[  376.042414][   T12] The buggy address belongs to the physical page:


Best,
Shuangpeng
