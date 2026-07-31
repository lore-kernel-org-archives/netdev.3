Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 492512236F0
	for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 13:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785503930; cv=pass; b=hS88nEF5BcreQQg5WY7GZirDKaoIpWxXz6O/GksgwRrKx32vB97ebFsMaQEMosVx/DtdU5SRaPx9yB/bgFIBqX5ybc6do8dobwDcCuXzSrjoKRIDSceMtTs1h0zioHxelLIVFhkFHnmzpjp/ww88W66xCBimR4QedAAqk37Phww=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785503930; c=relaxed/simple;
	bh=No1LZO0/xWGQaiEAYrYAljUhDkAED+OYsMfKkFdGXmA=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=LbuSQnfy3nMiHwnK3evd6bR43IwYpY8Crvsc+nwYLXVzRhCJUm7BRl36a7EWT+y1ia6/VcIP2PJmxlv24wd0Gv8IOAy4BXo5idOpVaQYNcUZioYTbpCBB01rmYVC7wTzymBG+b/tVkiHZ+13rsZlPMLf0iS80AVkQBOgTP8Tne0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T4PeFN3U; arc=pass smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T4PeFN3U"
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7eb4d532e65so311702a34.0
        for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 06:18:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785503928; cv=none;
        d=google.com; s=arc-20260327;
        b=QzMn3lQJmI7qmPyTq3zCeVmfAyeP+NZXRMJ07ORdBRSWpXuVqRyFLQnzJo0Zd0b6Wk
         NE2fDlJbNna2yENd3tDDWbvJukMloivjSx46CfhS4meepyNUSUaObIl5d++WEWEMkG/z
         fCcIwwFNXlajJOKprqu2Qj5eqCs3fkJP8EClwGAZ/KjCS+zKuY0ekLD68uirLChfaokz
         48hTV2tHx/65GuiKSJ2XEqaqEDon1zeiieEiDnhxQ/68172XthnApkKu5lo94yKMPxf2
         G8UwdZRThJ3Jn0ujFgSSFfJyaMXAjhS1lmAV948S/n6KA/6EirKofbp4Pq8navq0/sOh
         Kehw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=No1LZO0/xWGQaiEAYrYAljUhDkAED+OYsMfKkFdGXmA=;
        fh=hNS+j5qqJbj5uhDEpINz9jvSbPo8IFO7uGgzK9Qt0SY=;
        b=AnnwcGHcsepzfjB3e0ppKUjFoiyLbrJ/WddgNyrDokIiyNBrx80yA66W7tzY66HS5A
         Ql4Vdg8NIE1jBdcbSKgocTWH6+WnUh362QOWtFo1ALD8DwuaVymRuhTACkewYcUXZdm1
         9kTuIz5Y3rIbVobz7Lji0cAp2H+5uWiTD58d+q38vViuG7aCVxG7ze7bJVdQE00ioIr8
         PmmGdkYMKuFVyzjrbFDXcao+Ta/FpYyXLsmXp3vLBRl/v4DrGr6cA7ZNQ6Je+6L0xwjx
         9a1Qar3t0VZZURWjtbbfQqH73h3Ro8l/ZXeSvh8Pci23ZSW3x62/eT9DoBOpUrcj6j9p
         QcsA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785503928; x=1786108728; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=No1LZO0/xWGQaiEAYrYAljUhDkAED+OYsMfKkFdGXmA=;
        b=T4PeFN3U8XGk+G6x6+kAwMDU699o2JTjbnCvFXlcaY9Fn95z40SiCJvRvpJlouSg1T
         WfOUkEplNnhaNUNeufRXwA21DyoNOm/mhmV/co3YGK72OJ7AxAb7G4zSTx9dSC27msT/
         ZUKiqq1G2ZVGv8SwE6klMYvhCweCM1TiXJvjqntsiz2GAPetB/So0PBYn8QADp2fMi1w
         jh6XTHLJoqs/wTm1OoQhCGzDZ27mWAl3xZngFAWZixovpEpWTVX59lpmKfKU7KCex/lb
         utAm3j7fxRJYI2OY43mqfQmf+wCQjL3n79oEnkViJpVw395pMyGpTVT2h04LQiq5J5yW
         RYww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785503928; x=1786108728;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=No1LZO0/xWGQaiEAYrYAljUhDkAED+OYsMfKkFdGXmA=;
        b=l1KM3q2IKVwMM036g8ht/Jc1mPZpjh4CFr41yQtl+18ntldZjqq3ouSOhhP9tj7hsJ
         Ea8H7omvtjCPoDbnsflHbv32RIveSZl6NFABy4xiEfyIQ36RPtcYlBDlcctzcYqhjJZs
         e+H61itLAHqzCQrFwCy5xRN+CXCBmpNkIZody8ekq8YwQCwQ0Bf9VfMahDAImHDXUHNK
         M7NHbq0PuxQidicJlr8z7WyJ104P3Asa94fFQ0KIQgrBNyPC6W9GP+YvYLkpHUMYALdk
         M1BW/gzBu9zNBLvxKkP1CBtuZzga7ebAQtJc5KkB6+8IB1uqyzSuskEnRF6TqlzryZXg
         5+0Q==
X-Forwarded-Encrypted: i=1; AHgh+RraXX+SWhF6EN/mcPd5Wo7Zj2hk2HHjG/BLYogb2Pta/wNdv6I/gbyKIkBdfMyu7HzrC8DW2tI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCQ+CUW/hdbvZv24dnfnNvJBfiYT5uAeqoMpfNFmWVN5IgmQRV
	bgCfUKogMvG1n2n9bZiITRFeDiR6/d55AMA8N4ZguYJbEq+Zocq+e9Uo3FBvs/t6SXVqxID8m0Z
	vL89axMbUbZGVWMG2s7npkOenBQjHdLg=
X-Gm-Gg: AR+sD13tL++ZWssQFk085wjCLBZEczaGKigKtT1enQqfLkb5T9ODfMh61F6JFG+Rj3Q
	/iIMFZOptg7qWgWqYMW6JJYsGDky3y9AKYCXDypgQQvldrppBbQN8vTt9m9VlAQCiXGk6mjw5l4
	sZFVLXN2C1XJl75nuK6LWCMaJvY9L2M9KBsWTTfJlBPhysI+FPIvxsWaSVAqVEsVn2+YoTEcDSg
	zK3HSO2A1ey1gwntG8d6awK1xRiHkXS7VjD5bwT3/wNughLVT9kJPuNbXJcedIh684kXR1XlxfD
	zOtsuiundljBaWYpUf/6Ro00Lk08b1vQjt0BPumV4joos7zWEl9GlNa9PVKcbXkH0jC+2HmvhoC
	DjW5UP7IF2Z4Xkp7pH4LMd7Z9JooceMAobEKl7+ALMydSk+5nAJnMyVBw4a9Zv0KeedwIa+4=
X-Received: by 2002:a05:6808:178b:b0:496:fd2:94e8 with SMTP id
 5614622812f47-4ae4c51dc85mr2301495b6e.12.1785503928007; Fri, 31 Jul 2026
 06:18:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Smit Patel <smit5292@gmail.com>
Date: Fri, 31 Jul 2026 09:18:37 -0400
X-Gm-Features: AUfX_mwbt9cTvAsQbxrtWkq9sJY0s-Cbx0ff8_-RCd2WxaW8Zp4iRgH_w3ybUrc
Message-ID: <CAM5kW9DyDSJz+W70HhzQL4TeY28GTcOxDvkPHnFBh7TotqiEVg@mail.gmail.com>
Subject: [stable request] Backport b2870fc21601 to 6.1.y, 6.6.y, 6.12.y, 6.18.y
To: stable@vger.kernel.org
Cc: lorenzo@kernel.org, idosch@nvidia.com, pablo@netfilter.org, fw@strlen.de, 
	netfilter-devel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

Please consider picking up the following mainline commit for the stable
trees listed below:

commit b2870fc21601db9133bc70c48c603b487614fa3b
"netfilter: br_netfilter: Reallocate headroom if necessary in neigh_hh_bridge()"
Author: Lorenzo Bianconi <lorenzo@kernel.org>, 2026-05-14
Fixes: e179e6322ac33 ("netfilter: bridge-netfilter: Fix MAC header
handling with IP DNAT")

Requested trees: 6.1.y, 6.6.y, 6.12.y, 6.18.y

neigh_hh_bridge() copies the aligned L2 header to
skb->data - HH_DATA_ALIGN(ETH_HLEN), i.e. skb->data - 16, without
checking that the skb has that much headroom. build_skb()-based receive
paths leave skb->data only ETH_HLEN above skb->head, so the 8-byte copy
starts two bytes below skb->head on every bridged packet that reaches
the DNAT neighbour fast path - an oops or silent corruption of the
adjacent page, depending on where the buffer falls.

The commit carries a Fixes: tag but no Cc: stable, so it was never
queued. It is in mainline from v7.1 onwards. I have verified it is
present in 7.1.y and absent from 6.18.y, 6.12.y, 6.6.y and 6.1.y, so
backporting to the trees above does not leave a gap for users moving to
a newer series.

This is not a theoretical concern. In addition to the report in the
commit message (Airoha AN7581, 6.12.57), I hit it independently on
unrelated hardware: a FriendlyElec NanoPi R76S (Rockchip RK3576, arm64)
running 6.1.141 with Realtek's out-of-tree r8125 driver, which as of
9.016.01 uses a page-reuse build_skb() receive path. With br_netfilter
loaded, bridge-nf-call-iptables=1 and NAT reflection rules able to match
bridged traffic, the machine took 7 unclean reboots in 2.5 hours, with
uptimes of 59, 3, 89, 22, 2, 27 and 4 minutes.

Excerpt from the ramoops dump; the full dump is available on request:

Unable to handle kernel write to read-only memory at virtual address
ffff0000c213fffe
ESR = 0x000000009600004f
FSC = 0x0f: level 3 permission fault
Internal error: Oops: 000000009600004f [#1] SMP
CPU: 2 PID: 0 Comm: swapper/2 Tainted: G O 6.1.141 #1
Hardware name: FriendlyElec NanoPi R76S (DT)
pc : br_nf_pre_routing_finish_bridge+0xd0/0x270 [br_netfilter]
x2 : ffff0000c214000e x1 : 0000000000000000 x0 : ffff0000cf600000
Call trace:
br_nf_pre_routing_finish_bridge+0xd0/0x270 [br_netfilter]
br_nf_hook_thresh+0x124/0x140 [br_netfilter]
br_nf_pre_routing_finish+0x180/0x490 [br_netfilter]
br_nf_pre_routing+0x1d0/0x484 [br_netfilter]
br_handle_frame+0x270/0x42c [bridge]
__netif_receive_skb_core.constprop.0+0x274/0xed4
__netif_receive_skb_one_core+0x40/0x84
__netif_receive_skb+0x1c/0x6c
process_backlog+0xcc/0x190
__napi_poll+0x3c/0x1e0
net_rx_action+0x350/0x3e0
handle_softirqs+0x110/0x2f0

x2 is skb->data, 14 bytes above the page at ffff0000c2140000, and the
faulting address ffff0000c213fffe is exactly x2 - 0x10: 14 bytes of
headroom where 16 are required. Keeping br_netfilter unloaded has kept
the machine stable since - 15 hours and counting, against a pre-fix
maximum of 89 minutes.

These branches are where the affected configuration lives: OpenWrt 24.10
builds 6.6, current OpenWrt carries 6.12 and 6.18, and vendor BSPs are
commonly on 6.1.

The patch applies cleanly to all four requested trees (verified with
both git apply and patch -F0). It does not apply to 5.15.y, which would
need an adjusted patch; I am not requesting that here.

Happy to test the resulting queue on the R76S.

Disclosure per Documentation/process/generated-content.rst: the upstream
branch survey and the apply-testing above were carried out with AI
assistance. The hardware, the crash, the ramoops dumps and the
workaround testing are my own.

Assisted-by: Claude Code:claude-opus-5

Thanks,
Smit
