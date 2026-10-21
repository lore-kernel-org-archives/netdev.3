Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792598064;
	b=KbUaPXJ7ganiU0S9wI7wMMpBa+iLnFtakWW7yOtME3VwXLmpbGzn4tibGkLywHxLy7XJ
	 dOIP6j1Ew2MPb9cxmnmkRT3XVDkctSkebtJ4mgaGg2mOb1ZZGp7RqkZ19qDd/gqTTXneA
	 1rglanL9Oi95ur6IgyEKtp6+EoUzOLnibilrwj2BG1m1VGAho60LFRDmhi3xZQEn5ciir
	 nzmQTuMAgVpW94dn6K+mc26P7Sb6nzlSb2vlz1H97x00CdYxPZiCxQrkJhxubbMM1/DGa
	 aA41QYR6cfb1auaoTKXgD7QrPHdDYwD96CjU16LPmgoqwoWK/v6D8DFAwq9Cmh1tgDQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792598064;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=KjD3wOAZFh+mgSIl71daz0t7F3RO0rZ/s87feoGG8CY=;
	b=vDQjZMt0J0gnkii1+S2AbdT8RmyFi6Uvj89ozwXq+3E4heJnVy6pxXUm/hNyEvbCio9Q
	 pt29qOfZ4NZbjE07XuUeLelZjYrs7ZQGcIYxfyyOiBN4CmrOTN6SOmacgexNq1sDp1IlC
	 ULVS6E7XSyCz4TB+/A06f7+EUE+ubqUyPFP6g+8IzjjPb7ONaMPa/Ra2xXzV0+zr/OoFi
	 5xdhsoxcE6g4s6lUV7JfaoWSJbJb8FwhRcx99fMT5fdFidZTcOLbhbrfMZYxn0m4zDkDP
	 DqJtrU7n64CFqXEpbbJ5jhyFPrWU7aGrUHf7IqcL3vbdj+TRbtONMtJJILWmW8dOQ6Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=LoVVnL9r;
	arc=none smtp.remote-ip=209.85.216.54
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3AB2606A31E
	for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 15:54:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A3AB2606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=LoVVnL9r
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3acb11973c3so746714a91.3
        for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 08:54:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792598063; x=1793202863; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KjD3wOAZFh+mgSIl71daz0t7F3RO0rZ/s87feoGG8CY=;
        b=LoVVnL9r1xJFGu3Vk+G+WonmQVF6E6RrS/wRi5p5Ajki4YWnrUWp5cEmA60DSbuD0s
         kjZOAFxivBhRNNmX8EkbYaWd8cpNjNjMtBQNHMOIblwBhv9EcmtphNTIxNvsKqLXUrFu
         WPryA1L7W4qkf3OaJaJ4vSpKetWi0UY1Fq3NHzJHSEUl9hWlsIPZu2snUsA2ay1nYVa/
         Mm5B1Q7HzkFCk4djK7N9TvWKpvhR1EgMb1QnZscjKxXBMzG4nsl2rPpZM/gVWvoBNCg2
         7CjUvI+1/JsAuEKB5cKmjhoOokTvDybxkLiz2RaXYL7DiBc4O7eCwmVGBa6JDY37SPE7
         C+rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792598063; x=1793202863;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=KjD3wOAZFh+mgSIl71daz0t7F3RO0rZ/s87feoGG8CY=;
        b=1sBovpeSwyAu4hXl92txtrTD1tV0ntL0yaQ4A8mGMs8grhX0XVrbGG7LIppsWjJEWd
         WCM+xBDr/8AgP6gavAnxxrpmdcQM4R5k2G2K66yXXj2cbAgQ2Xy4HKsRncYGiHb0D22K
         xdcPIajjCC9H3gO21VFtbx4yFRGY5WVVZmg0yiBF6EOwb5Rda7RDAlJdiWvlP0GDGWm5
         TEp+zUBOVZyKvWKVPtNcOQ/Rd756R3ANBixhSZ0zOjYN8684JuhUthBW6vilphM64L0U
         mdZwtuyKfc3tq2LCZDpTS7ETYyB+95Ku5gJAtxiwPeLbxAVOW/SfHN1PnyzBivUHua2W
         tk7w==
X-Gm-Message-State: AFq9FYKTpUM1nWdbljUtGEAWzD+CRnBt0Z1V127kIpTdeCb+pgHQtLMk
	Y9r1ONS/tIvNaszrOZh1BU6HUfMMxray0slq9pbIhjc6uE5+utCwrOAy
X-Gm-Gg: AYBFou33C2xeI4jUNyjf7Q5mFdfWAMHyyiDLmRAOSzVRrppZlmzvrlXM7hfivJKg4cR
	GvkzVZMx8CwyR4eU9g0uqh1VnEc0dpycbwvEqIf6/WlYxuVF1HLtGKdREx0KJY77+I7/53rOPao
	y6vptAEKZNBHlmKjVzCsKrWvVbb1jdPdS8LWOpcbkVWx8Qep92QTznSm4NPs+sp1Gp8XhkbS2eg
	uWW3hI2pCrOk+w537Y+BrtDFM5kgaSGxfiOWE2jjkCo85r2x/NNSurjUv1MY0ZsG0+oQgz03Wl8
	YzNfpZz+gNAagja/gOivvmLTbwZzPDeKaWHCdHNXyvrgHLGXB6yK902Sb8WGXRE63SsYCNMywa8
	bqQNAP9LxZLa11ViQ6Zx/mEEIkStnWbptP3Um1B6gB5/WdbzPg9SYtA7qHSzRx2r2fYeZeN5PWY
	6pcHf0HWtZ1Rx2zC6gVZScYMprgs4vBajcOVCW7saYB2iqbhTJ4Nq3Lymn6mRH3dYpvmSJFdw0R
	v01Wvxradtast69lHPZ7Mp/QySH0rSnyZqEb3p8PnGtHudBrOfHBu4HFQ3RV+i7xHHJP1xT2VR0
	CS/g+/m16ukW1L9rgh5tXo/tekVm2yoeW5o71DKunYm+E9lNnaTdmxotpoTTQKL7RSEJG8V+d9i
	CxfCN
X-Received: by 2002:a17:90b:3d8b:b0:3ac:4e18:2390 with SMTP id 98e67ed59e1d1-3ad86dcac3cmr1927714a91.7.1792598063013;
        Wed, 21 Oct 2026 08:54:23 -0700 (PDT)
Received: from localhost.localdomain (69-172-67-073.static.imsbiz.com. [69.172.67.73])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ada490e5edsm69968a91.8.2026.10.21.08.54.21
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 21 Oct 2026 08:54:22 -0700 (PDT)
From: Dudu Lu <phx0fer@gmail.com>
To: vinicius.gomes@intel.com,
	jhs@mojatatu.com,
	jiri@resnulli.us
Cc: netdev@vger.kernel.org
Subject: [PATCH net] net/sched: taprio: unwind the netdevice notifier if register_qdisc() fails
Date: Wed, 21 Oct 2026 23:54:17 +0800
Message-Id: <20261021155417.66254-1-phx0fer@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
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

taprio_module_init() registers taprio_device_notifier and then returns
register_qdisc()'s error directly.  When register_qdisc() fails the
notifier stays registered, but the loader's failure path frees the module
image without ever calling the __exit function, so netdev_chain is left
pointing at taprio_device_notifier.notifier_call -- a function pointer
that lives in text that has just been freed.

register_qdisc() has two failure returns: -EEXIST (duplicate .id) and
-EINVAL (malformed cl_ops).  taprio_class_ops satisfies every checked
implication, so -EINVAL is unreachable and -EEXIST is the only reachable
failure; it needs a pre-existing "taprio" entry in qdisc_base.  In-tree
that is reachable only through bpf_qdisc_reg() (CONFIG_NET_SCH_BPF); a
module calling the exported register_qdisc() reaches it as well.

Once the notifier is left dangling, the next netdevice event that walks
netdev_chain calls through the stale pointer:

  BUG: KASAN: vmalloc-out-of-bounds in notifier_call_chain+0x650/0xb5c
  Read of size 8 at addr ffff80001fc5ab08 by task ip/110
   notifier_call_chain+0x650/0xb5c
   raw_notifier_call_chain+0x34/0x64
   call_netdevice_notifiers_info+0xa8/0x198
   __dev_close_many+0xe0/0x800
   ...
  >ffff80001fc5ab00: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8

The shadow row is all f8 (KASAN_VMALLOC_INVALID): the read lands in
vmalloc memory that was poisoned when the module image was freed, and the
indirect call is unguarded because the only check, func_ptr_is_kernel_text(),
is compiled out unless CONFIG_DEBUG_NOTIFIERS.

Mirror the sibling sch_cbs.c and act_mirred.c, which unwind the notifier
on this failure path.

Fixes: 7b9eba7ba0c1 ("net/sched: taprio: fix picos_per_byte miscalculation")
Assisted-by: LLM
Signed-off-by: Dudu Lu <phx0fer@gmail.com>
---
Tested base
-----------
Detected on Linux 7.3-rc4 (commit 93f51579e7df), arm64 QEMU guest.
Re-checked against mainline f47d223627f8 (v7.3-341): the affected code
is unchanged between the two, so the bug is still present there.
Checked against linux-next next-20261021 (commit 9a482184d910): the
affected code is unchanged there as well, so the bug is still present in
linux-next too.

Reproducer status
-----------------
A reproducer was written and executed on an arm64 QEMU guest with
CONFIG_NET_SCH_TAPRIO=m, KASAN_VMALLOC=y, CONFIG_MODULE_UNLOAD=y; it fires at the
claimed sink.  The reproducer source is not posted here per
Documentation/process/security-bugs.rst; it is available on request.

Triggering conditions
---------------------
A pre-existing "taprio" entry in qdisc_base, so register_qdisc() returns
-EEXIST (the only reachable failure).  In-tree this is reachable via
bpf_qdisc_reg() (CONFIG_NET_SCH_BPF); the reproducer reaches it through the
exported register_qdisc().  Then a NETDEV_UP event.

Notes
-----
Built and checkpatch-clean: this patch was applied on top of 7.3-rc4
(commit 93f51579e7df) and a full arm64 kernel (defconfig) was built with
it -- no new warnings or errors.  scripts/checkpatch.pl reports 0 errors,
0 warnings.

 net/sched/sch_taprio.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/sched/sch_taprio.c b/net/sched/sch_taprio.c
index 39ac5b97aa3a..6eb40a379e79 100644
--- a/net/sched/sch_taprio.c
+++ b/net/sched/sch_taprio.c
@@ -2572,7 +2572,11 @@ static int __init taprio_module_init(void)
 	if (err)
 		return err;
 
-	return register_qdisc(&taprio_qdisc_ops);
+	err = register_qdisc(&taprio_qdisc_ops);
+	if (err)
+		unregister_netdevice_notifier(&taprio_device_notifier);
+
+	return err;
 }
 
 static void __exit taprio_module_exit(void)
