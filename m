Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792598215;
	b=bBcM/DMblBaQ3xJ2KPddRTqrvJHQBwViO/WD/iG77dM2Fuk1zqGUjYxAq1kj9aoBjL6r
	 kNbF63x7OD1vbLuysBeUBs1PdSdPdE4tzMYY5aywfzGUQ4cd3CfoI8W85KWOrUAVXA97K
	 4dJOIaWqXHFugphGEltyS8sWvIt+5IgJNuNDDCzmKapKgAGnyGf4nbDQUclJJOey4al7g
	 qw6DD0VTC89HMsCuhZYSBArrcU18NVrZSAm4pnEsbmBKV5CyMG6WTgwFshbLFevnqJmAe
	 pU8drmFxdeqbMfHPSFgQ679xFfyOe8cS8hgUPvTGcfj27JCdN2m1OwHh/2f60+sBD/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792598215;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=R/H0Aa4Up4KmSYMG5hbV8V8mjw4aRBSPBfTl+cyvzSY=;
	b=fuqSvUj+OOmrqVu1qA2g9DoGBsvuq53tRXiX4swpl1yECXBbOQj8/+GlPqYxXK2lWtRk
	 lTOs2hBKfRDgERL2sVAltC3McejQF+lMa9c8TsPNxnwFicLdeDJzY44dKRu3l7GaNoY9Q
	 /aN8wPBNZdj5LuqX+CiEeJ5JqZeC1+66uGTFht87xYUMA3r3X4EQVD/e7B8GPtr5y4g6l
	 9vY1EPWft40R+Im3zEz7Dga7/qNCHKUFcXROsj0il2qDav8mog9yx1BF31gvOxq5+zgRA
	 WL397sKKxPsMFA5gWIiuR6J/7LVqb/LC60nw+gD4153gEMEsVc2ccOvVkZE4Je10ObA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=POOfgI4q;
	arc=none smtp.remote-ip=209.85.216.44
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CD26606A325
	for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 15:56:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7CD26606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=POOfgI4q
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3acdcfa2bd3so727518a91.3
        for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 08:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792598215; x=1793203015; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=R/H0Aa4Up4KmSYMG5hbV8V8mjw4aRBSPBfTl+cyvzSY=;
        b=POOfgI4qcb75idUlrwj64NiUdNvBQHL36qyiKZxfwfgr1hUfm66xGK5FmutGQyUWTH
         HBndJHM/5BHL7VoEL56rqz2kLb+dXOa1hBAEs0gPP+DH0IQlim5bTO7qJ5JMJ7dL9RzQ
         PkQNvSr+T+LMEWYdkqGdmOU/VD5c3eeJBAmCTi7rpfNqMZ9pVxMyw4mfx41E1wIM5k8P
         DNMYJ80alnMboIWiIN4PHimgFCIBDG5LniwoPl7pFhKxj9ACi6cpIytH8EBnLKdWU7r9
         ouQ3nCKzxoQpw73QCo3BNlTj5MaNokMUHwOSeWRel0idl813NpvC7wFkTGQfGitt06HU
         ij4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792598215; x=1793203015;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=R/H0Aa4Up4KmSYMG5hbV8V8mjw4aRBSPBfTl+cyvzSY=;
        b=xax/19afNL7t3TGH8Sk+QdPVpuTJwJ29hjwJgUXwoBbEbW982fXVl15YdBln0U9AGI
         g6OE00rng9LwcmqOlNOSOeeq+bvdibyfLGkxNPcw6/mwL2MmbyQWJDw7Ee5rWSwBHIAN
         JHpgn1+Z8veF/hu6mVaIQx09JlZHb7u0NiiWhTuLMq7dd4cItAsJDmBaGO8n49hQ2QK4
         p6Al0SpAnREgtkISDtPXq1jZOB1F0J0Q2L7dZFejsaKGWtNvrfpulilUDOUwXo50EIH1
         MQZ1E1BIPm5ErDDwjUjbHWF1+mcAnEhV1LHh0t2ktOT25+JQ7ZIo8llcrgU4QRvyrSzj
         LYpw==
X-Gm-Message-State: AFq9FYILSh6KvnfQMDBFEeCm9QHR/WZFHzNVYCsjCc3D/PwBQ8+WbrAu
	yM9OQjksWaqTLhm0gBjyygTR+U0slUiDwSzwjIalDyMQS+uFyBSA3o3a
X-Gm-Gg: AYBFou2KiTEpHORJbg7RC2FSnA2zdNzI1GTuwg19N4WgivZoVWptLlMcxN8h7r3suj7
	lbPM0XaGzJRGdnDoQPnUYvENWjI5BN7OdfQ7TQ+9s5G+J6RTQqlpHPnym4r1j/HRzMfOXK33yES
	LZdTn7djH5q/SecRk3HandO7CwigmBF6lJ+82ZMiRWiOGjszfIu0pxw1Ly4CD5lcWhtSVGPqOO7
	1GNtPDTHW/j2i79vwmLuvbjU/6KdvT/S8tp6vSCj6nT47PeWecFro5xMam5zvWPbSl9jpUCooXq
	vS8MmXJuqQW2fQLR4wSm/ACyRulDnIQ27ivBPYDT+bk6ndDCoxzu6pgc2dfHzi100RC0HzFralt
	tbmd02t6/rCnfSzEz0OkMYPG9vbfwmUhLd+sQrsu/OwX0cMqbV72IiUhyeqXsZZwXEZmp48euA/
	dsarbR6S6GPKZXaOo1cJProHtHF1Ln1tuvmOrL2g6Oupf3JYI0ap9QfUjc81StD4NupevfEj1fh
	gjpsNwoGwLHeKgJf6MUnxiXMH+cSEijBhnmvzBmi4EbGpE8FYP2M/y/UsoDX1daIwfJk2WroNdS
	eYlTKaARseLF2KZeYCZmzIeUgnONB0c/LEyL8Nf6hZjzeS40HIx5regtVsc=
X-Received: by 2002:a17:90b:548e:b0:3ac:95d7:2fa5 with SMTP id 98e67ed59e1d1-3ad87083900mr1990329a91.44.1792598214857;
        Wed, 21 Oct 2026 08:56:54 -0700 (PDT)
Received: from localhost.localdomain (69-172-67-073.static.imsbiz.com. [69.172.67.73])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ada4890bb2sm115257a91.1.2026.10.21.08.56.50
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 21 Oct 2026 08:56:54 -0700 (PDT)
From: Dudu Lu <phx0fer@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Cc: netdev@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH bpf] net: return page_pool frags to the pool in bpf_xdp_shrink_data()
Date: Wed, 21 Oct 2026 23:56:45 +0800
Message-Id: <20261021155645.69120-1-phx0fer@gmail.com>
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

bpf_xdp_shrink_data() releases a fully-shrunk frag through
__xdp_return(netmem, mem_type, false, zc_frag), selecting the freer from
the rxq's mem type.  Under generic XDP the rxq's xdp_rxq_info often has no
mem model registered (e.g. loopback), so mem_type stays
MEM_TYPE_PAGE_SHARED == 0 even though the frag was allocated from a page
pool by skb_pp_cow_data().  __xdp_return() then frees the page through
page_frag_free() instead of page_pool_put_full_netmem(), so the page is
returned to the buddy allocator while its page_pool accounting is still
live:

  BUG: Bad page state in process A-146-S3_S1  pfn:4694b
  page dumped because: page_pool leak
   page_frag_free+0xf0/0x11c
   __xdp_return+0x160/0x640
   bpf_xdp_adjust_tail+0x5a4/0xbac
   bpf_prog_run_generic_xdp+0x4a8/0x1204

Before falling back to __xdp_return(), try the page_pool path: if the
frag really is a page_pool page, napi_pp_put_page() recycles it through
the pool and we are done.

Fixes: 4dce1a0d7cf3 ("bpf: Support pulling non-linear xdp data")
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
A reproducer was written and executed on an arm64 QEMU guest (generic XDP on
loopback); the kernel reported "BUG: Bad page state ... page_pool leak".  The
reproducer source is not posted here per Documentation/process/security-bugs.rst;
it is available on request.

Triggering conditions
---------------------
The ability to load a generic-XDP program (CAP_BPF / CAP_NET_ADMIN) on a
device whose rxq has no mem model but whose skbs are page_pool-backed (loopback
via skb_cow_data_for_xdp()).

Notes
-----
Built and checkpatch-clean: this patch was applied on top of 7.3-rc4
(commit 93f51579e7df) and a full arm64 kernel (defconfig) was built with
it -- no new warnings or errors.  scripts/checkpatch.pl reports 0 errors,
0 warnings.

 net/core/filter.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/net/core/filter.c b/net/core/filter.c
index 70dc621672f2..94bc367cee12 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -36,6 +36,7 @@
 #include <net/protocol.h>
 #include <net/netlink.h>
 #include <linux/skbuff.h>
+#include <linux/skbuff_ref.h>
 #include <linux/skmsg.h>
 #include <net/sock.h>
 #include <net/flow_dissector.h>
@@ -4380,6 +4381,18 @@ static bool bpf_xdp_shrink_data(struct xdp_buff *xdp, skb_frag_t *frag,
 	}
 
 	if (release) {
+		/* The frag may be page_pool-backed even when the rxq's
+		 * xdp_rxq_info carries no mem model (generic XDP on a
+		 * driver that never registers one, e.g. loopback).  In that
+		 * case mem_type is MEM_TYPE_PAGE_SHARED and __xdp_return()
+		 * would free the page through page_frag_free(), leaving the
+		 * page_pool's accounting dangling -- "page_pool leak".  Route
+		 * page_pool pages back through the pool instead.
+		 */
+		if (IS_ENABLED(CONFIG_PAGE_POOL) &&
+		    mem_type == MEM_TYPE_PAGE_SHARED && napi_pp_put_page(netmem))
+			return release;
+
 		__xdp_return(netmem, mem_type, false, zc_frag);
 	} else {
 		if (!tail)
