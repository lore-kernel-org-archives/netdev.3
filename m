Received: from bg-bec.cloudflare-smtp.org (bg-bec.cloudflare-smtp.org [104.30.16.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFDD33101A5
	for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 08:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.30.16.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787213004; cv=none; b=h60dcrB6TYyg6c+j9Q0dIICDJKOJoxG0psD7WXkJLC7XxsisYU+udiIy0VQTWR/cDwNMhuY6JWwzTlA9KdL0uGuRwByyNKris+H2i/dYFCWCR/bYXzYWKTGqhLyZV/ivGbkRkdb9g3IbOnYpuLftEzS0CKHx5yvCxEl/VDSisG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787213004; c=relaxed/simple;
	bh=7KEUql1pcIdIO6/hnwxclBYxB4sona0fkWlZ3KLZmIY=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=uBqtEBaH5Pc6uo8wVd+20Kkxyk48MreG2YShsjQCh/yQJBtmB7Ffszub3TLWA7us8z81LIgaZRvMep5HwdHkw3TrX5pcMa6H+8+O3YPA6hQhOwa+n+ZrJrb7x/pl5CShe4ajlI/Q/a3GnruV3d+P/urIS+4+NAgbFatmCMlENBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bugs.sh; spf=pass smtp.mailfrom=cf-bounce.bugs.sh; dkim=pass (2048-bit key) header.d=cloudflare-smtp.org header.i=@cloudflare-smtp.org header.b=aHwOP4F+; dkim=pass (2048-bit key) header.d=bugs.sh header.i=@bugs.sh header.b=axX0CIsT; arc=none smtp.client-ip=104.30.16.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bugs.sh
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cf-bounce.bugs.sh
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare-smtp.org header.i=@cloudflare-smtp.org header.b="aHwOP4F+";
	dkim=pass (2048-bit key) header.d=bugs.sh header.i=@bugs.sh header.b="axX0CIsT"
DKIM-Signature: v=1; a=rsa-sha256; s=cf2024-1; d=cloudflare-smtp.org; c=relaxed/relaxed;
	h=Date:Subject:Cc:To:From:Feedback-ID:from:reply-to:resent-date
	:resent-from:resent-to:resent-cc:in-reply-to:references:list-id:list-help
	:list-unsubscribe:list-unsubscribe-post:list-subscribe:list-post
	:list-owner:list-archive; t=1787213003; x=1787817803; bh=PFC61e8Czd7ToOUasW
	MkDiVQsWyqU1ojrO02DWrqu8o=; b=aHwOP4F+XdmzXCycYEkvwFfUtB3EWvO6i9/FucndxguSR
	pMxyqEuGUcUYB7ZAjmv3nSfjytdKKdk9tU4c7z+ZdWM5dt3s98CEgQ0v8XTrB2BjrZRck+aTuJ5
	xxZTx/tKCf8w4ydnpRhhzU+DuOJCS1VyGqBiTfElvXN7vG5yZrUoRpK1IH4o4QtCOfjz/eepgB0
	cU17Mr7lgjTuIwwdtyylim08+LFEJZ4r66pOpBNF7buraX9+SvF/rQpcI96T6SJdafb28ORhp1M
	AWce6O5hoqx3qk4bNF95uVQgdmOoGNAapaot3ld1ba0dw48SVE4HoNIDWFpgpY1Y0Q64wMWA==;
DKIM-Signature: v=1; a=rsa-sha256; s=cf-bounce; d=bugs.sh; c=relaxed/relaxed;
	h=Date:Subject:Cc:To:From:Feedback-ID:from:reply-to:resent-date
	:resent-from:resent-to:resent-cc:in-reply-to:references:list-id:list-help
	:list-unsubscribe:list-unsubscribe-post:list-subscribe:list-post
	:list-owner:list-archive; t=1787213003; x=1787817803; bh=PFC61e8Czd7ToOUasW
	MkDiVQsWyqU1ojrO02DWrqu8o=; b=axX0CIsTxa8ZcBO/iMoVTGSGwP6FOSE3gIAVonjOQTk+O
	lRAdLApHNZYnLIRIEIgpCYl9kcG7qS9l9rZeie/st7i+Nmt9rTg2r/CYJTqBMsipoyQXPrkQx9M
	VTyVFT9zzHotOpu6aoRyVE8CvVAUACjNEIDANxx0wbEBQAbIGAKkBAFAdB4yDjD1jQSGQnNjD40
	SFmBHi8mKF8zDmYSC0obs3OaxMMBTkvt9pznZZjZWH+aLHJmMzpz8HkiEVUyCLw+y6TdeUY6PDd
	+m2dEK/i0qkk+XGW3L9cYcWnbP7p61VqOVvufvFzKXdnsE/Xdv8deTE848gN5tB8sm/K+KDg==;
Feedback-ID: bugs.sh:5:6:Cloudflare
Message-ID: <ijg79FFMfIvKJbivdJEKvTO90Q9dTvyBkJck@bugs.sh>
Received: from authenticated-submission.invalid
        by mx.cloudflare.net (Cloudflare Email Submission) with ESMTPSA id lfuTgtUuxjQK; Thu, 20 Aug 2026 08:03:01 +0000
From: co <co+4638111fe2a12980@bugs.sh>
To: netdev@vger.kernel.org,
	Subash Abhinov Kasiviswanathan <subash.a.kasiviswanathan@oss.qualcomm.com>,
	Sean Tranchetti <sean.tranchetti@oss.qualcomm.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: linux-kernel@vger.kernel.org,
	co <co+4638111fe2a12980@bugs.sh>
Subject: [BUG] drivers/net: NULL pointer dereference in rmnet_map_send_ack()
Date: Thu, 20 Aug 2026 01:02:59 -0700
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We found a bug reachable in:

    path    drivers/net/ethernet/qualcomm/rmnet
    crash   NULL pointer dereference in rmnet_map_send_ack()
    commit  b027ca66ec02

Config, environment, the sanitizer report and a C reproducer follow.

== Notes ===============================================================
    If you patch the bug based on our artifacts, a tag would be
    appreciated:

Reported-by: co+4638111fe2a12980@bugs.sh

    Everything in this mail is validated by the reproducer below.

    We also hold an LLM-generated root-cause analysis and a candidate
    patch. The patch passes an A/B test: the same reproducer panics the
    unpatched kernel and runs clean on the patched one. Neither has had
    human review, so both still require validation before you send or
    apply them. Available on:

        patch.diff  https://bugs.sh/b/4638111fe2a12980/patch.diff
        report.md   https://bugs.sh/b/4638111fe2a12980/report.md

    This is an open science project. The code and the full set of PoCs
    are not public at this moment, as we intend to disclose our findings
    in an ethical way.

    Happy to test patches. Complaints and suggestions about our work
    are welcome at:

        cedalion@bugs.sh

== Environment =========================================================
    Reproduced on  b027ca66ec02
    VM setup       https://bugs.sh/b/4638111fe2a12980/run.sh
    config         https://bugs.sh/b/4638111fe2a12980/config.gz
    poc            https://bugs.sh/b/4638111fe2a12980/repro.c

== Sanitizer Report ====================================================
Oops: general protection fault, probably for non-canonical address 0xdffffc00000000b2: 0000 [#1] SMP KASAN NOPTI
KASAN: null-ptr-deref in range [0x0000000000000590-0x0000000000000597]
CPU: 0 UID: 0 PID: 5011 Comm: exploit Not tainted 7.2.0-rc7-00095-g24ef02f934ee #33 PREEMPT(full)
RIP: 0010:kasan_byte_accessible+0x15/0x30
Call Trace:
__kasan_check_byte+0x13/0x50
lock_acquire+0x136/0x360
_raw_spin_lock+0x2e/0x40
netif_tx_lock+0x19/0x30
rmnet_map_command+0x213/0x320
__rmnet_map_ingress_handler+0x57a/0x900
rmnet_rx_handler+0x350/0x4d0
__netif_receive_skb_core.constprop.0+0x6bf/0x3610
__netif_receive_skb_one_core+0xb0/0x1e0
__netif_receive_skb+0x1f/0x120
netif_receive_skb+0x13e/0x7d0
tun_rx_batched.isra.0+0x3ee/0x740
tun_get_user+0x2874/0x3aa0
tun_chr_write_iter+0xdc/0x210
vfs_write+0x6ac/0x1050
ksys_write+0x12a/0x250
do_syscall_64+0x116/0x7d0
entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x4240c4
RIP: 0010:kasan_byte_accessible+0x15/0x30
Kernel panic - not syncing: Fatal exception in interrupt
Kernel Offset: disabled
Kernel panic - not syncing: Fatal exception in interrupt


---
The report format is based on syzbot bug report.

This report is generated by a bot. It may contain errors.
See https://github.com/n132/cedalion for more information.

For any issue with this report, reach out to cedalion@bugs.sh

If the report is already addressed, let us know by replying with:
#co fix: <commit hash>

If the report is a duplicate of another one, reply with:
#co dup: <lore link>

If you want to undo deduplication, reply with:
#co undup

