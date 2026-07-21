Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEF68446822
	for <netdev@vger.kernel.org>; Tue, 21 Jul 2026 15:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784647553; cv=none; b=HrYXHWisHpt5+waRIpx9YggKBdlOFoYjtnfqPBEFPEr4aZ+cbtFzw+K3l+8WkJCG1sHal3KMITts3HWCvxqWKM7dW06XhZQQ3MfOXnvXloCIrsNjoHNl/wApTKs5lQCJ8lGo7QqRYEIIl5cvMI4B2lvpD2VSk8sMhhCVOirp+mI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784647553; c=relaxed/simple;
	bh=3tlONGbl5FY4JfDLdcQmYfGARzj/mZZ6AYlkZ/eCbCI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZfTKCpQu9mLwssmKOf/xPukVwHsn43HGz+oWmc6NkaoOBNkwWO6MpyX+cNi6usHw3lVTMJ7dvd8gSswJYS2uI0nDqcETAm3g+GlTnzbKvLlCoIYnA0BXOFTCUJx2ATDzjDHDGSfxEnfGUYWguufUZnLC3D7H/gpu6iOLTVLexe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D8OHbPxg; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D8OHbPxg"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-38101f85591so4245076a91.1
        for <netdev@vger.kernel.org>; Tue, 21 Jul 2026 08:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784647551; x=1785252351; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=aw3knJHot21+lS9Gq8JIMC5gWBrB+umKx5Ms/CgHkac=;
        b=D8OHbPxgUnwPcowyu17PLtmhmNt4U0KGE86GgsCImAroIzjJT/dyyRGQLojs8XiXxB
         8C2iLmmWG3xFEks4304VFAXebWgkfJVeaC8J2Jq3ZMUe2oM4YWffpbSWrPf6Ee39SuD/
         gizPuMpuEJR5FpxIm3Hpyh61PJbL4wyBprgz1v6GFViArK6q69JTTtFFMkD7ZJpt97Rf
         RupT3ifx6OWZYILl4VhjBtSPKII7G+/wveOlstfJCnWHrqbRS7eBUndtDbzGxo1FMuAh
         VGxzjbOV5B1BP//DkrLXSj76DOZqI4Q6P4MEAAwm2D2dmnFoNJ1OiKQxAKVtFtjDIKhg
         hxtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784647551; x=1785252351;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aw3knJHot21+lS9Gq8JIMC5gWBrB+umKx5Ms/CgHkac=;
        b=JlUnoZ6fTC6NNgYjusiOBKmkOkDk1xEUWQdy9D6vJFmbtg5Xd/y+VomSUn0mSkImhA
         rfVeVhLUVp30u3NTNODzhEKEeve5+XjQIiULxwPUajZ7rbzwMus5rN34X/uhVY2WukX0
         JmV7Ki6ILBJXnr2ePfCEuMuVequNptUDFaJduMQzoga2A1A1xjpnGTiPZ1AA/Z4sDNua
         VLmH457j/DPcvj8RgKkP9PCaVHX6dtHL9Q+/HdZpvFdQbffiK3jXymhRAlD9m/LDIj3g
         jzzvABVEXxZJKVw/wqNVR+VB1Zik57Dx6lp4QzPR44PJI/oiOwCFaXonoBvG9eZ7iox6
         KUDA==
X-Gm-Message-State: AOJu0Yw0+hAuOkXgMlCPCv9GJbTZt+efL1DCOua3XH2Pq3E/nWKi6L9a
	qLUQ6fTMC5NEFSbUzPiVX4zd8+DVei4cvy78y9Knw4y9HFLQ2OTFXb018z52jyr3
X-Gm-Gg: AR+sD13B92Nl9HoURQ0g1oXCbofb0ERXagBnV4GJOPqhwfKuYs/AJhKAoyDyzRRk3Ir
	7Kkr36fDWXvLWHTv73NgKtyhFHp9h7uYA7ugH9LSVzxp48Hd9u/BDLqHJDiZ+nb6CGAX+iNgBBR
	KtqcCZVPs/XIHNwCvEDcOKK0Qrz7qEdKLplGtTFvCCO/5D61oIK+AW5UMmhpcnmRfcXleJPbFPE
	/0JaC10fC2WAbtUKchmWLOY4JVHzO+0LPEo712ihZP9IwqlX9ziaUVBir4g82T9a0Cok6AP0Bgi
	5GnhoeuvPABnalzE1wiyxyVcSTKczUiGK56prENTznK2SOTw1qj5KdCICxQmSY5HALMVP+D/JZD
	BpTA0/Qm9I3X/bLFwX1bASKzi8hferqvEnfcUsaPpuUB/LgXNs89WmVvqisyrIONKtCeivcNPIJ
	arEA4zVg2rK2QU+zPen/JUYi2BR6UX
X-Received: by 2002:a17:90b:3811:b0:37f:bfcf:fdfb with SMTP id 98e67ed59e1d1-38ea343d642mr57160a91.8.1784647550847;
        Tue, 21 Jul 2026 08:25:50 -0700 (PDT)
Received: from enjou-Legion-Y7000P-2019 ([144.48.80.242])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38e9232c388sm1779394a91.6.2026.07.21.08.25.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 08:25:50 -0700 (PDT)
From: Ren Wei <enjou1224z@gmail.com>
To: netdev@vger.kernel.org
Cc: steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	eyal.birger@gmail.com,
	vega@nebusec.ai,
	xizh2024@lzu.edu.cn,
	enjou1224z@gmail.com
Subject: [PATCH 0/1] xfrm: avoid lock inversion in nat keepalive work
Date: Tue, 21 Jul 2026 23:25:41 +0800
Message-ID: <cover.1784645321.git.xizh2024@lzu.edu.cn>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zihan Xi <xizh2024@lzu.edu.cn>

Hi Linux kernel maintainers,

We found and validated a lock inversion issue in
net/xfrm/xfrm_nat_keepalive.c. The bug is reachable when an outbound
ESP-in-UDP state enables NAT keepalives and races with SA deletion.
We've tested the fix, and it does not affect the normal delete path.

This series contains one patch:

  1/1 xfrm: avoid lock inversion in nat keepalive work

We provide bug details, reproducer steps, and a crash log below.

---- details below ----

Bug details:

nat_keepalive_work() walks the state table through xfrm_state_walk()
while xfrm_state_walk() holds net->xfrm.xfrm_state_lock. In the buggy
code, the walk callback nat_keepalive_work_single() then acquires
x->lock. The delete path takes the reverse order:
xfrm_state_delete() acquires x->lock first, and __xfrm_state_delete()
later acquires net->xfrm.xfrm_state_lock. That creates an AB-BA lock
inversion between the keepalive worker and the delete path, and lockdep
reports it as a circular dependency.

The fix keeps xfrm_state_lock out of the per-state processing phase.
The worker first collects matching states under the walk with an extra
reference, then processes them after the walk finishes and only then
takes x->lock. This preserves the original logic while avoiding the
reverse lock nesting.

We first tried to validate this with the original userspace
NETLINK_XFRM reproducer in the bug directory. On this validation kernel,
that reproducer was rejected during strict attribute validation with
"attribute type 34 has an invalid length" before it could reach the
buggy path. To validate the same root cause and the same keepalive
worker versus SA delete ordering in-kernel, we used a temporary local
in-kernel reproducer that creates an outbound ESP-in-UDP state with
NAT keepalive enabled, flushes the keepalive worker, and then deletes
the state. This temporary reproducer was used only for local validation
and is not part of the patch series.

Reproducer:

    # Build kernels with the temporary local in-kernel reproducer linked in
    make -C /var/cache/linux-patch/xfrm-nat-keepalive-src \
        O=/var/cache/linux-patch/bt-parent-uaf-net-main-build -j$(nproc) bzImage

    # Boot the unfixed kernel
    qemu-system-x86_64 -m 2G -cpu max -smp 2 -machine accel=tcg \
        -kernel verify/bzImage-unfixed-kpoc \
        -append 'root=/dev/sda rw console=ttyS0 earlyprintk=serial \
        net.ifnames=0 biosdevname=0 panic_on_warn=1 oops=panic \
        slub_debug=FZPU page_poison=1 init_on_alloc=1 init_on_free=1' \
        -drive file=/tmp/qemu-unfixed-realboot.qcow2,format=qcow2

    # Boot the fixed kernel
    qemu-system-x86_64 -m 2G -cpu max -smp 2 -machine accel=tcg \
        -kernel verify/bzImage-fixed-kpoc \
        -append 'root=/dev/sda rw console=ttyS0 earlyprintk=serial \
        net.ifnames=0 biosdevname=0 panic_on_warn=1 oops=panic \
        slub_debug=FZPU page_poison=1 init_on_alloc=1 init_on_free=1' \
        -drive file=/tmp/qemu-fixed-realboot.qcow2,format=qcow2

We run the validation in a 2 vCPU, 2 GB RAM x86 QEMU environment.

------BEGIN xfrm_nat_keepalive_repro.c------

// SPDX-License-Identifier: GPL-2.0
#include <linux/init.h>
#include <linux/in.h>
#include <linux/ip.h>
#include <linux/kernel.h>
#include <linux/slab.h>
#include <linux/workqueue.h>
#include <net/net_namespace.h>
#include <net/xfrm.h>

static int __init xfrm_nat_keepalive_repro_init(void)
{
	struct xfrm_state *x;
	struct xfrm_encap_tmpl *encap;
	int err;

	pr_info("xfrm_nat_keepalive_repro: start\n");

	x = xfrm_state_alloc(&init_net);
	if (!x)
		return 0;

	encap = kzalloc(sizeof(*encap), GFP_KERNEL);
	if (!encap) {
		xfrm_state_put(x);
		return 0;
	}

	encap->encap_type = UDP_ENCAP_ESPINUDP;
	encap->encap_sport = htons(4500);
	encap->encap_dport = htons(4500);

	x->id.proto = IPPROTO_ESP;
	x->id.spi = htonl(0x100);
	x->id.daddr.a4 = htonl(INADDR_LOOPBACK);
	x->props.saddr.a4 = htonl(INADDR_LOOPBACK);
	x->props.family = AF_INET;
	x->props.mode = XFRM_MODE_TRANSPORT;
	x->props.reqid = 1;
	x->sel.family = AF_INET;
	x->sel.daddr.a4 = htonl(INADDR_LOOPBACK);
	x->sel.saddr.a4 = htonl(INADDR_LOOPBACK);
	x->sel.prefixlen_d = 32;
	x->sel.prefixlen_s = 32;
	x->encap = encap;
	x->dir = XFRM_SA_DIR_OUT;
	x->nat_keepalive_interval = 1;
	x->lastused = ktime_get_real_seconds();
	x->km.state = XFRM_STATE_VALID;

	xfrm_state_insert(x);
	flush_delayed_work(&init_net.xfrm.nat_keepalive_work);
	err = xfrm_state_delete(x);
	xfrm_flush_gc();
	pr_info("xfrm_nat_keepalive_repro: delete err=%d\n", err);
	return 0;
}

late_initcall_sync(xfrm_nat_keepalive_repro_init);

------END xfrm_nat_keepalive_repro.c--------

----BEGIN crash log----

[  129.325779][    T1] xfrm_nat_keepalive_repro: start
[  129.348170][    T1] WARNING: possible circular locking dependency detected
[  129.348170][    T1] 7.2.0-rc2+ #5 Not tainted
[  129.348170][    T1] ------------------------------------------------------
[  129.348170][    T1] swapper/0/1 is trying to acquire lock:
[  129.348170][    T1] ffffffff989f9fd8 (&net->xfrm.xfrm_state_lock){+...}-{3:3}, at: __xfrm_state_delete+0xa4/0x9d0
[  129.460853][    T1] but task is already holding lock:
[  129.460853][    T1] ff1100001bbfc0c8 (&x->lock){+...}-{3:3}, at: xfrm_state_delete+0x1b/0x40
[  129.460853][    T1] -> #1 (&x->lock){+...}-{3:3}:
[  129.460853][    T1]        _raw_spin_lock+0x2d/0x40
[  129.460853][    T1]        nat_keepalive_work_single+0x15c/0x1c40
[  129.460853][    T1]        xfrm_state_walk+0x4ed/0xb70
[  129.460853][    T1]        nat_keepalive_work+0xe8/0x1b0
[  129.460853][    T1] -> #0 (&net->xfrm.xfrm_state_lock){+...}-{3:3}:
[  129.460853][    T1]        __xfrm_state_delete+0xa4/0x9d0
[  129.460853][    T1]        xfrm_state_delete+0x23/0x40
[  129.460853][    T1]        xfrm_nat_keepalive_repro_init+0x4ba/0x640
[  129.460853][    T1]  *** DEADLOCK ***
[  130.799594][    T1] xfrm_nat_keepalive_repro: delete err=0

-----END crash log-----

Best regards,
Zihan Xi

Zihan Xi (1):
  xfrm: avoid lock inversion in nat keepalive work

 net/xfrm/xfrm_nat_keepalive.c | 57 +++++++++++++++++++++++++++++------
 1 file changed, 48 insertions(+), 9 deletions(-)

-- 
2.43.0
