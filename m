Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.229
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793208939;
	b=dwpaL56k/vH9yOIufpeCxB8EStEDGzwmlgBpvofR+WdWdKCCeYwiWDMUSWiCohpA6IKP
	 LNvXYFRAE+ozxQZZRfO4d4E0G+pUy8uQFbtUKB4dttx7/bORHAPYKyRP3m9hRXO1I/PF6
	 dqJDNvy8Zfseagpk5fWIXFmkEoaVzgZdbZddK+iEj9F3FCbhh+c1bVUAWdZeGXib+TfGK
	 SBzDGJ9efUuD6zCSAo6N8+ohPnYZRd8alLW+JhYPvttpNwQ4MuCddv+ylM5FarQO4ONBF
	 mJGkjnsFixdPdwZ+Av8HtoNjUZGKdVDrIAUf9yD32k6+MI81N9WuPFJQWfiIu2l22HA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793208939;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:X-Relaying-Domain:
	 Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=JYCogINmtcWvhGsimc1XH47DC7tqKp3oabGA83x3w+g=;
	b=I4/swxrG7fBznY6QC2J8XcrPteUJnzlGLL3LvTwsZ2fyZRWDS9bpGNyR9JVEEvEqAjHK
	 tpPcWoeLKjUwG+zaHU1gOcaqKGdiJHTp6xbOQmZxOms8TqJonoIFLZe5ihg0/i57TIkne
	 cnondhgkSNJgk2ro2sCv+aQXOZsaAmHLz6WADM9zoj5feswXiLUrj/1UqyqXeBhmcWwmb
	 70BENXlgLJwM3W+ttNm4VOvREY6ZTySbTNSvFUMqvq0pn+bbqnzrRVJbtxAx9Nb3ls60V
	 eh9W28OA/864qHgVJI4C1k+YSkcNuaYT/ZbCh0cGHFoC/4FYieO7WEaYy6N4NU7hbYg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=purestorage.com;
	spf=pass smtp.mailfrom=purestorage.com;
	dkim=pass header.d=purestorage.com header.i=@purestorage.com header.a=rsa-sha256 header.s=google2022 header.b=W9kYJmzN;
	arc=none smtp.remote-ip=209.85.210.229
Received: from mail-pf1-f229.google.com (mail-pf1-f229.google.com [209.85.210.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12693606A33A
	for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 17:35:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 12693606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=purestorage.com header.i=@purestorage.com header.a=rsa-sha256 header.s=google2022 header.b=W9kYJmzN
Received: by mail-pf1-f229.google.com with SMTP id d2e1a72fcca58-8a05e3f0d23so764855b3a.0
        for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 10:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1793208937; x=1793813737; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=JYCogINmtcWvhGsimc1XH47DC7tqKp3oabGA83x3w+g=;
        b=W9kYJmzNZ6+VEHFF4uCs4IopDL0cDTwKqhohe/BFStkIvGA+lKvHXgRnYFlOyHIeiU
         UwWpHRzH1PPIYMktEDcnayYTyfAYdcVQmgQv5uesmZqdqUboRzOc11W5ZFMlV7MbxSuw
         +QZByXxtQ/EhgN2u22PSiexC4ZRU4lWuSmD7t70MIrbDVXGG9Stm1tGAOv0c/TQrb/H/
         JKkRQlV1UpbqWqb1+pGoN1dxAzuNmWlkqxXMbZFPtu6Am+F3R4Lrc6yVcN3ucYKvYx2n
         NpyJ9IbSSh6ccLTQ6nvGVgTqR0bynCKkTzB0L7W3UypUlfm4cAKLrray5sPVFJoWct0u
         TdVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793208937; x=1793813737;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JYCogINmtcWvhGsimc1XH47DC7tqKp3oabGA83x3w+g=;
        b=nbIy6EfKdwLDZw0mY8u5X1AW5w4l7IFxuP6+IOXBE/Q/ykr6Uw9r/18XME2xtRyOSA
         pLbEKnLrZNcBcUUWove53LOBuCmmnc91E/wp8yzGVzc4yEqVLMNtinDCbvoy90n5RptT
         5zS3qFLAGkO0Dgsx4b0oqx3k7tt/lzk3AADJOfC76hJ08xbycsr9XPFCzcr8rajnmlKi
         9rF9UKX73qsXC+3ZMFMz84l1xb+VAOJ2bHSUQMKRlUmOPM5zMI2LSnuTKxA0QWPVUICS
         cAstamnddiupO9a1NG4HEhgp2jhkJGthKAgBTqLy7GJiOVwepkxy2dXvdvHxxlcaR8a6
         0Nmg==
X-Gm-Message-State: AFq9FYJjVgeML+LMFF0ZlJsuol1kaYTqlC/brHjNI1YIDvyveOsM+j1K
	7G+gjjpWgE1JlCxNERIGYkWNNCoI7f0feIkjeJ2kYk/8d1Td8oS6WsuObAtug5wfrAyAjp4WWII
	+W2h0rEs35xodYm1NV92ARFGvQF8RQ81AcAuV
X-Gm-Gg: AYBFou03vk4OQxx6gZ6FXBpTTtJBH6qjcWTLwrU9JovbR7XU/GAfnguBZdQSi5eEzjr
	RXLCwA+A9eLyziplAMIp/RQsthSzqWj0jeXeLVqcQL0ikhYEYyA8voYqdWSCfzhzhZbrW/aAvsY
	E/OxGkPZkjn5/qSF1D7CFNpgBL9LKD7Rx04VJOth8n1S1VJ4MdoK14LV0hC977xTiLgdVX6R/5D
	GBLCm7W5jUu7vEMzKtv2Cz1mAbb1CeLRVPPxkB8R2AQr3MXDsVGFVBeWjkQfaKYZTqKOj2nts+s
	Eflcc7GHHDdQaFMf+MwGN4C0O9aA/5VeiwLsn9OIHl0Ez3pW2VpHozMmisy9lQJRJjmP96n1J36
	O6DkTEjSSX2Uc0iaewfmxFnyZDG1JycQG/+Y=
X-Received: by 2002:a05:6a20:9145:b0:3e2:26fc:2e1c with SMTP id adf61e73a8af0-3e902343126mr2499850637.39.1793208937368;
        Wed, 28 Oct 2026 10:35:37 -0700 (PDT)
Received: from c7-smtp-2026.dev.purestorage.com ([208.88.159.129])
        by smtp-relay.gmail.com with ESMTPS id 41be03b00d2f7-cd8ccc4f975sm188208a12.4.2026.10.28.10.35.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 10:35:37 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-rjethwani.dev.purestorage.com (dev-rjethwani.dev.purestorage.com [10.17.2.234])
	by c7-smtp-2026.dev.purestorage.com (Postfix) with ESMTP id 7983A401D3;
	Wed, 28 Oct 2026 11:35:36 -0600 (MDT)
Received: by dev-rjethwani.dev.purestorage.com (Postfix, from userid 1557719937)
	id 741D0DCDF71; Wed, 28 Oct 2026 11:35:36 -0600 (MDT)
From: Rishikesh Jethwani <rjethwani@purestorage.com>
To: netdev@vger.kernel.org
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>,
	Eric Dumazet <edumazet@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Willem de Bruijn <willemb@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Simon Horman <horms@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Shuah Khan <shuah@kernel.org>,
	Hannes Reinecke <hare@suse.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Rishikesh Jethwani <rjethwani@purestorage.com>
Subject: [PATCH net v3 0/2] kcm: reject the combination of KCM and TLS
Date: Wed, 28 Oct 2026 11:35:31 -0600
Message-ID: <20261028173533.2658096-1-rjethwani@purestorage.com>
X-Mailer: git-send-email 2.50.1
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

KCM's data_ready callback calls the lower socket's read_sock() inline,
from softirq. With kTLS RX that is tls_sw_read_sock(), which can sleep.
v2 deferred KCM parsing to a workqueue whenever read_sock() is not
tcp_read_sock(), and reworked the strparser workqueue to go with it. As
suggested in review [1], v3 instead rejects the combination, as was
done for sockmap in commit 460e6486617c ("tls: reject the combination
of TLS and sockmap"). It has never worked with kTLS RX: before commit
662fbcec32f4 ("net/tls: implement ->read_sock()") KCM parsed TLS
ciphertext as messages, and since then it sleeps in atomic context.

Patch 1 makes kcm_attach() refuse sockets that have any ULP, and
tls_init() refuse sockets attached to KCM. Patch 2 adds tls selftests
for both orders.

Patch 1 changes user-visible behaviour and is tagged for stable. Its
message calls out the errno change and the one refused setup that
previously passed data: TLS TX-only, in either order.

On the new sock flag: patch 1 adds SOCK_KCM to enum sock_flags, which
leaves one free sk_flags bit on 32-bit. I looked at the alternatives
first:

 - sk_user_data alone cannot be the marker. sunrpc and nvme-tcp set it
   on sockets that tlshd later upgrades to TLS, so it is already set
   when tls_init() runs and tls_init() cannot reject on it.

 - A new SK_USER_DATA_KCM tag, alongside SK_USER_DATA_PSOCK, is not
   safe. The tags live in the low bits of the stored pointer, and bit 3
   is not free: reuseport_array stores &array->ptrs[index] | NOCOPY |
   BPF, where ptrs[] holds 8-byte pointers, so every odd index has bit 3
   set and widening SK_USER_DATA_PTRMASK would corrupt it. It would also
   need masking at each of KCM's raw sk_user_data reads.

 - There is precedent for a flag owned by one subsystem: SOCK_XDP
   (commit e4a2a3048ed9) is set only by tun.

If you'd rather not spend an sk_flags bit on this, the alternative I
would implement is a bool in struct tcp_sock under
IS_ENABLED(CONFIG_AF_KCM), like is_mptcp and syn_smc. KCM only attaches
TCP sockets and the TLS ULP is TCP-only, so both checks can use
tcp_sk(). Happy to respin that way.

Changes in v3:
 - Reject KCM and ULPs in both orders instead of deferring KCM parsing
   to a workqueue.
 - Drop the strparser workqueue patch; it is no longer needed for this
   fix and may be posted to net-next separately.
 - Add selftests.

v1: https://lore.kernel.org/netdev/20261013033920.2069285-1-rjethwani@purestorage.com/
v2: https://lore.kernel.org/netdev/20261016025059.289202-1-rjethwani@purestorage.com/

[1] https://lore.kernel.org/netdev/3108e934-ec00-458b-8720-450554b35b55@linux.dev/

Rishikesh Jethwani (2):
  kcm: reject attaching sockets with a ULP, and TLS on KCM sockets
  selftests: tls: test that TLS and KCM are mutually exclusive

 include/net/sock.h                 |   1 +
 net/kcm/kcmsock.c                  |  12 +++
 net/tls/tls_main.c                 |   6 ++
 tools/testing/selftests/net/config |   1 +
 tools/testing/selftests/net/tls.c  | 144 +++++++++++++++++++++++++++++
 5 files changed, 164 insertions(+)

-- 
2.50.1

