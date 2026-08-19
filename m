Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B491542BC28
	for <netdev@vger.kernel.org>; Wed, 19 Aug 2026 10:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787136286; cv=none; b=a9J5bsTOJLHMb8mJozZQnT29RoD2sy//P80SgPGAvyF5OnV7ycdbH8CLMduY+TDpQshnF5/zCBNGsdDkcPZfEEjJOMCY6NZn6c8YamXkG9firOQAanr+G6zTivhv9A4OIX6QQDa/grCYNQZcgDv79l0cUqT/qrd4UpCCt13FLZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787136286; c=relaxed/simple;
	bh=JMmW7X9llhVLh4tgVzKcuRGQaGeUo8lmg2UIbEtqdUA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QrOhXIk7GdH1w/dP/2IBbakDFn1DvSQnGsuTTjzW+Xua4utxQTDOprr+CyDBzFxyyy0rpwLKzL1vdUCqDxufSVuD55TGgy4jA5fgawfPP1+DZ6yM2p4ym8QXlzIzKHydnfQCuOF4ZKIdzCgLUX3nNoXCHobqIkn2zTp2F/YaWwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c797+PHR; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c797+PHR"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5b4747943b8so940287e87.0
        for <netdev@vger.kernel.org>; Wed, 19 Aug 2026 03:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787136283; x=1787741083; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=px3AKvC/vdgfBn94qjvmBeOftPFpPm1SynC6dbLUxb0=;
        b=c797+PHRwZ+xZZlXZXY6DEOAJIBwvk54c0GqPHL2YRI3zY6uy4p/lRR/Mf1T0tZhcD
         F4fipczlGmW6/OiYUfG+C6iodleXItIK90Vfv61q4ZGRI9fd3Um7c6PKhOws0FgdKdZo
         sXqgNnJCkVUgdCFPP5cdRDuQBl8Iy5acWLHkH7wEl1hhHyY1MZ3O50vESaroNcXdBW88
         YZsd6QypqRwbTxNusC/4bR96kWraQlliENClYr6Q97GP9rq96PmZAHSFUviTbVsBVA+6
         mI6x6AteRcsRcb7kzB2iVkr5HttitSBWz9b204A8iWp1BrNYCQuZD+d9McW9ZhjkkT62
         YzXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787136283; x=1787741083;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=px3AKvC/vdgfBn94qjvmBeOftPFpPm1SynC6dbLUxb0=;
        b=XcUqcvO2e3pmUH5gTgQdHKn6B8VF8EuOiGvlJt+QhN0kKksC9EZgqwv18NxmPgptgw
         uTGKatNlXWXfglpgiyBhQn5vBXhlqMVfx+Fojz9a41ACee+OJlp5lq+bgMYgTiIft1/s
         dbi6xf/xmAOwkDR7nzVlMpzA6PXTXBW2Dfmliuwu9fN28kkemDjtJTW/QpOCOZ5eNWSj
         kVNw6PGK4kaUZRbZQ/W+E4P0B2NJ1ClEJ2H+1BYDoaH7QoqYzs+oN000bMHoYcd8aPlF
         n+D+khDAYnrLRbnFlt9W/vPQUFwWYuxgDeQc45LMWOrMJljsd9kPlvQbQl2KiuE+/gZb
         XCdQ==
X-Gm-Message-State: AOJu0YxKGxiytR0Ix+fL5zaxrMe3MCmnMsJsQVVhPzkWa7IFSk/thOQC
	3n5I1GvR1RQHPr1VXGnmZut3Vxjh0Vm9I0ym96qFeNoVC38zaykk9S5U648pkXeC
X-Gm-Gg: AR+sD106wjCJPogRv0JmrITNpH4gqQajGvkF4cxe4RdZz8N6YBPAY0xPXsoHYHtD8yJ
	6I7bGIkcdAYI9wt4QrCwgSG8dTbuxjyusweftwDA3YDipzBtS4KyODHP+F6H9rk2fKyMyixZpi6
	IAwCXqQaFfhH/gCnSUfYA9eKOQ0uh0pf4WBROTPlvgLp0Pob4uQw6SnI2Oi1ltFYZhMTIhJ1DeC
	A2qv5th94CPDfQFM7xi57MC/h9GbKV/sOKfUy+lg4ehRAjmqBDlIb5XGfmMQRWQAUvj3svXEWQK
	FtXidDbp0wcmuF/4CevdL3zvlykxU/65S64uxFvta1NmFbLNY1CwJmGpKaALUhQb6ctl4o0Bi8/
	J4DfYeyQoe7GwqX0pGNUa7TpyI1F90tXqR/ruZkce03+KJRpzwngJnPvRiUkfuQ1WXRcNqXAvkN
	7abqvXSQo190nvN/BHJ0LHjL8TM50sXZirMSTuT4Z8fIFoEae+mLsOP/BI7DdT7/jWXSV/ri/5K
	mOwPAqbM4tYC7Qy7PVjMZBUO3Jk8EDn
X-Received: by 2002:ac2:4f03:0:b0:5ae:b01a:d213 with SMTP id 2adb3069b0e04-5b47892e750mr1257864e87.3.1787136282553;
        Wed, 19 Aug 2026 03:44:42 -0700 (PDT)
Received: from dau-home-pc.. ([95.139.142.55])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b4788539e3sm440890e87.13.2026.08.19.03.44.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 03:44:41 -0700 (PDT)
From: Anton Danilov <littlesmilingcloud@gmail.com>
To: netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Thomas Graf <tgraf@suug.ch>,
	Daniel Borkmann <daniel@iogearbox.net>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net] ipip: fix skb leak in collect_md mode when metadata_dst allocation fails
Date: Wed, 19 Aug 2026 13:43:39 +0300
Message-ID: <20260819104338.432631-2-littlesmilingcloud@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In collect_md mode ipip_tunnel_rcv() returns 0 without freeing the skb
when ip_tun_rx_dst() fails to allocate the metadata_dst. ipip_rcv() and
mplsip_rcv() are registered as xfrm_tunnel handlers, so tunnel4_rcv()
and tunnelmpls4_rcv() read the zero return as "the packet has been
consumed" and do not free it either. The skb is leaked.

The other tunnel drivers all dispose of the packet at this point:
ip6_tunnel.c jumps to its drop label, ip_gre.c and ip6_gre.c return
PACKET_REJECT, which makes gre_rcv() free the skb. Only ipip returns 0.

Jump to the existing drop label instead. It frees the skb and still
returns 0, so the packet keeps being reported as consumed, which is what
we want here: the outer header has already been pulled, and neither the
remaining handlers nor an ICMP unreachable have any use for it.

Triggering this needs an ipip or mplsip tunnel in collect_md mode and an
atomic allocation failure, which is why it has gone unnoticed.

Fixes: cfc7381b3002 ("ip_tunnel: add collect_md mode to IPIP tunnel")
Cc: stable@vger.kernel.org
Assisted-by: Claude-Code:claude-opus-5
Signed-off-by: Anton Danilov <littlesmilingcloud@gmail.com>
---
 net/ipv4/ipip.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/ipip.c b/net/ipv4/ipip.c
index b643194f57d2..ddf62b45566b 100644
--- a/net/ipv4/ipip.c
+++ b/net/ipv4/ipip.c
@@ -248,7 +248,7 @@ static int ipip_tunnel_rcv(struct sk_buff *skb, u8 ipproto)
 
 			tun_dst = ip_tun_rx_dst(skb, flags, 0, 0);
 			if (!tun_dst)
-				return 0;
+				goto drop;
 			ip_tunnel_md_udp_encap(skb, &tun_dst->u.tun_info);
 		}
 		skb_reset_mac_header(skb);
-- 
2.47.3

