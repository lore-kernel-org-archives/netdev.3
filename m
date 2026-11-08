Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794136603;
	b=obYfR6/aHxvKewKkwRhx4R0Xe/1W9WpL/hTA2Sq4DB+NohAgfGl9chOsW2KaG+cvZZwI
	 kmcLkKwSmI1qBvOs4vsDnK5hhn3oHJM/sQp7fQiZkXWi8zOCj7JkOoUrxbFDIMuhKLZ1v
	 atj7F9Va3OQv97BHMO0YLYW1j26Ups6K7uKa/yZIE9tvmulDAFb26BcnTR4awMUI9QJNG
	 OEHlGNO1fieARadpHakdVH6EjcgfAlBYEt9AHX9N8nmDYNvyxfUyeI89rhk89Ts10hgH6
	 E8KphcsM69aCHFtcX/0CoxXmifJceXNSC30q56O9KqKF55VXTGh+spqI9dpc48fIL4g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794136603;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=tqN8u8kP7ftmzydZ0UYjojp4J7UTI9IrPrNCjr6MjRw=;
	b=I/TNq/O6uDaRHRN0/KSvB2b+hfkb2b9+JSw+Uz+JKwxYv3LY2lmluhxB94nBXh9LvKXn
	 JyjhH9MPDXk9oYp5nLetd1CGaZUfwKfqKZZoT+HGwsMrse9eGxCddxECNL5kUhHTZPSje
	 BC6JmdYH49U01nAN11igmdaEbp+lwFujEmFA+kJBF1k77I1BwyYnme3WIOuPqJKZR6mS3
	 7F4ewPffL7dK56xq7GHMIjP1rFTWWKG+BFP2RT6viGUQG3XqXStnySAfCbDB5HScXXeL3
	 XyECN3dSWkTp+e9PiqIJbzOS78jvIJyUo5rTY03HvsP8sc3wDrJ3nO8LPDFIIHQQeAA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bairaktaris.de;
	spf=pass smtp.mailfrom=bairaktaris.de;
	dkim=pass header.d=bairaktaris.de header.i=@bairaktaris.de header.a=rsa-sha256 header.s=google header.b=xTB8m2qD;
	arc=none smtp.remote-ip=209.85.218.41
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC9A6606A321
	for <netdev@vger.kernel.org>; Sun,  8 Nov 2026 11:16:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BC9A6606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bairaktaris.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bairaktaris.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bairaktaris.de header.i=@bairaktaris.de header.a=rsa-sha256 header.s=google header.b=xTB8m2qD
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-c4d58c50743so5571466b.1
        for <netdev@vger.kernel.org>; Sun, 08 Nov 2026 03:16:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bairaktaris.de; s=google; t=1794136601; x=1794741401; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=tqN8u8kP7ftmzydZ0UYjojp4J7UTI9IrPrNCjr6MjRw=;
        b=xTB8m2qDggbouqPnk5JU0G80s3Ng8xawBrDPvO4hW4/kym6JHh2ZC5S9F80Kcx3uYp
         2GQx5sZo9jimZqa909jaNiaWFCBtiKpRJwasdi37KCDc/15hCdPU/uXLCMvhN1YlQjv4
         pBNO8x4pFR8zlnKitX4OToGQxGCwvPGPE5fQN50bDFMbMjQfsPEsLeLiPhSI8E2TVS23
         SG+QTxgoFf6HfOBmZjzcv+KjaX4uuwtKSuqHo+2sq+eyWPd3u6mbUKLapD546OKJ1bXc
         qsbdaYP8YlsC+Jk+ofln7k95ujFKi6Kjr+0ELgxSlG2Aif0OnPh6PMKIh9MGWpRqJVUR
         YKRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794136601; x=1794741401;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tqN8u8kP7ftmzydZ0UYjojp4J7UTI9IrPrNCjr6MjRw=;
        b=G7Og0D/8W3RRsKWSk7qfU6xhqHm82agckhGE3bcJspjwPn6VaI4qUMG3vhjFU8at3I
         0Bu48MtoUUPT+AsQyijG6/uVPOMpENmMpox8bvro0lTkcPPeLA6zO/g11KiA4pejNWLQ
         frxxGvFwSiw96HMkcEMTeYczgjhbo79Ky8lhYvZizGNwkqY/EYnXbqLfwhP32ajG8hvR
         rA2LlvK0DwEHbgII7y9tirP/BFM0ncwDPWqgDAlqLIa0iCtI1wDSUhgJ2IeJtOJHfDTb
         Jod+xrTbTx3/9GNRjbuEeGRNc/0SbMgwyRwXjTqOh+SvSAkc6xeA99rs9Hb5ET64w9Eq
         YV4w==
X-Gm-Message-State: APuU4Z89TmB/uBD+vMbt+ygC/f9yJSIepfPPgVZdThI+Lsv/ttWnjSd/
	6TiDPRnp0wmUTniR0gSKsDzVxxQ+VTcgctx5qnm1qJr/aFGBWIpyUuEo+PjaxnMLFw==
X-Gm-Gg: AYBFou11HF4I2oeMJbfBsRGF4QTZTorVvwlU9tl1kQPNntdQkv3YxFW4Z1RfKr3RVpo
	oWQHr6dot3M/Z17eAszt7alE7/Q31SsosGsNXewM0ZbgCCtbtaasJ8Lq32QuKs0+K+YrqQ/OQzf
	ujWtrO0nN8pYe4n2hpSsnf45+XWkZfq2Hf83z5IdU3TFYNIAH2QPVPO0PmTu9Ix7oy3/LrUY6Ls
	+qgUXiAHYjBxBumczh+qKAUkOwui6T1pGkiJOIj0+k8qHvdiPsCx3oVfR2ddocxkH8skkE+brKn
	Gwft79Cb5Fx0HkFfjAS32kbrh8zm2HQHAtNB2+nKIN4BehVtUcPLf0K920GBckgLkVIt0hbQqBU
	NbrQoRQvLoWMkL65V1c+LHu3oOeIB7FzdDXHk+JJAT4MrwoHwZ6XxlWF8+oMwasERH0+aj/BdLV
	ECle+yn/ezmJ66cQedOwQ8tjn/+WC1C6+zzxCecNBfB5+Fwv4nTGJ9FXOjxwe/euAfMYL5senC/
	eSqlXPugihUKFG0piGqqSwFE/lrhzJgB0IZxkYPXYsPka9mFBtmB2s6jdVm6b3Xo+P38kfUUq9S
	S6H46DER3qOfIlqfNgCAp1E8ZVapqPr1ZDh30p02exawGOTMm61DyoJsG0qMESytxmHvEZYPIut
	nLSQ0EVHnuWAmZdV33t91Rq8kTTzzEKa/Np/yF6OchdVm3RpKVnFTzM4n26/I1Y3Hz44CkdE7UU
	blSIPX/vfYFlw/cKMxgS3jNMc3OI5gkl/yxX33aI+ALTYoSazFDZSoIbTPGAshi6WLEMlNz6Nfs
	BcDX8mSTSJR25eFrciHWRssztHGUOkRf3sl0PK0UgVAo3HpBAKBwOGIc7Yajz61Of3O5uUsv5hY
	F0UXnj+YaE9X9xLgBq2SbhMzZHHGV1/T21GBsGw=
X-Received: by 2002:a17:907:960a:b0:c3f:153a:8663 with SMTP id a640c23a62f3a-c4d6d4ec448mr99416466b.23.1794136600876;
        Sun, 08 Nov 2026 03:16:40 -0800 (PST)
Received: from Desktop (p54afff19.dip0.t-ipconnect.de. [84.175.255.25])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4d6a99320bsm54261166b.67.2026.11.08.03.16.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 03:16:40 -0800 (PST)
From: Julius Bairaktaris <julius@bairaktaris.de>
To: Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>
Cc: netdev@vger.kernel.org,
	bridge@lists.linux.dev,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 0/2] net: dsa: fix host fdb refcount when an entry roams
Date: Sun,  8 Nov 2026 12:16:37 +0100
Message-ID: <cover.1794134495.git.julius@bairaktaris.de>
X-Mailer: git-send-email 2.53.0
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

When a bridge FDB entry roams between ports, br_fdb_update() notifies
switchdev of the deletion and the addition without a lock. With two
CPUs learning one address on different ports, DSA counts the host
address on its CPU port more or fewer times than the bridge has it,
which ends in "failed to delete ... from fdb: -2" or an address left on
the CPU port.

The earlier attempt took hash_lock in br_fdb_update(); Nikolay rejected
it because it slows down learning and roaming. This series leaves
br_fdb_update() and the rest of the bridge's learning path unchanged
and fixes DSA instead: each user port records the host addresses it
holds and, on every event, checks where the bridge has the entry now.
Patch 1 is the only bridge change: an RCU lookup that DSA calls from
its workqueue. Patch 2 replaces the counting.

The counting has been exposed to the race since commit 90dc8fd36078
("net: bridge: notify switchdev of disappearance of old FDB entry upon
migration"). The change redesigns how DSA tracks host addresses, so it
goes to net-next without a Fixes: tag.

Tested in QEMU with dsa_loop given FDB operations and assisted
learning, PROVE_LOCKING, PROVE_RCU and DEBUG_ATOMIC_SLEEP enabled, one
source address sent from two veth ports on two CPUs for 5 s, 5 boots
per kernel: net-next logs the -2 error and leaves the address on the
CPU port in 4 of 5 boots, this series in none, and it removes the
address when the user ports leave the bridge. A "bridge fdb replace" of
the address onto a user port leaves it on the CPU port in 5 of 5 boots
on net-next and removes it in 5 of 5 with this series. The kernel log
of every boot has no lockdep, RCU or atomic sleep reports.

Changes since the hash_lock patch:
- Leave br_fdb_update() unchanged (Nikolay).
- Sashiko's finding on that patch, a deletion that races the locked
  roam, has no counterpart here: DSA looks the entry up when it handles
  each event and treats a deleted entry as gone.
- Of the three findings it lists as pre-existing, the MAB and
  BR_FDB_LOCAL ones are in the bridge, which this series does not
  change; the peer-site one, a "bridge fdb replace" onto a DSA user port
  that notifies no deletion, is handled in patch 2.

Link: https://lore.kernel.org/netdev/20261004124254.3525496-1-julius@bairaktaris.de/

I used Claude (Anthropic) to help write these patches.

Julius Bairaktaris (2):
  net: bridge: switchdev: add br_switchdev_fdb_find_port()
  net: dsa: fix host fdb refcount when a bridge fdb entry roams

 include/linux/if_bridge.h |  13 +++
 net/bridge/br_switchdev.c |  63 +++++++++--
 net/dsa/port.c            |  36 +++++--
 net/dsa/port.h            |   6 ++
 net/dsa/user.c            | 216 +++++++++++++++++++++++++++++++++++---
 net/dsa/user.h            |   8 ++
 6 files changed, 309 insertions(+), 33 deletions(-)


base-commit: fa5196392691051963726787944db872420dfa75
-- 
2.53.0

