Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84C1A175A66
	for <netdev@vger.kernel.org>; Sat, 29 Aug 2026 14:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788014942; cv=none; b=AirkZbOEXZXSEx0IwY+5SxR7fDmd1d3v9CaEZ2/W7atUQWamo07f065v/6Of6tTmkB2Yc82biVh+fiUOdcCOiyV7tzw7SDOV5AJP+vCpgU819a9zzc33MZdpIfXg3HdsFQAzBTyAH1A5X/vy3zRFPOcQqE0wk119YSl0qlYpOkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788014942; c=relaxed/simple;
	bh=VkiTfQVxUTrw0T26RyfgyZTH0MoOGSFKlFOsqotHuPE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jaR+4pIl5IIbVOe10Xb34Z3k1ZM8pj63lVyteowGnwcv5ulvJrYdHZr0RTUg5dJ8UvP3GeC4ycV+B0eb4OVkdShDw0yaOU7u/yQ4zMVzPqADUseDUCCybQtnh86Ye/kzKMXDORPNZ0txZAcNRsSnPrJ97cNxXZYWvzGVPPHmYLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ix/ccs39; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ix/ccs39"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-cc1c7364550so2068319a12.1
        for <netdev@vger.kernel.org>; Sat, 29 Aug 2026 07:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788014941; x=1788619741; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=3vrBLtTPaDgsD3NUp4Z5b+goMknBBh8lYG+iL1zb6xU=;
        b=ix/ccs39BIkx1Jmu6621VW4snUtHMjO9KNOanFOOaeKuFToQDdsVqtXmi+IE3tl1ll
         MwoVhjyJUlsNfimIBnYfjBCVwYze7ufqNgPs7KWxflfME5ijyQtPMd0/qQINrwR0WDqC
         fO9xx66dEOZVwgLXul//pFrXG7XK0BrHzCzf42+tfFjP5epyJ5bsUL6EjoD3J+NUXCL5
         KL+WQASyyGxw3LjvE04ghBZD/6XGK4g64oWwVfIXgFwoY8/q+GssLuBQqbMd6mo3ksyy
         ZODGWmMeWRz0nXF6b/0HXCAjcFslyOrHAjHXDeLSKGlpQJjJloF+uiu7S+cPUQlgNFq7
         p7uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788014941; x=1788619741;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3vrBLtTPaDgsD3NUp4Z5b+goMknBBh8lYG+iL1zb6xU=;
        b=MPT6K8MkYNtu+QVTzGZzCOU0oM0HsxON0YB5ZnSsIMiGlJmS3+YSXFXny2s0G51z8R
         F1n5qZ5j8mSEUZkWtJo2tvH25fZ710sDFqzM7Rhbhprs+Kzdk4B/UWiMjoY4Nyb8m/HA
         twJ3OcVmHUKrBec03yJK2Y/dvIQXy8vjy+DLh3VyrGri6KFqw0nwnVx8bkLTmjmFoYsi
         aLrVh7HJM155Y9zNikE94AwC2S6r+9VVyIVR7YrdimGwAPVsU8ipu8IeJUbtmkbIyOki
         qGyqNYI+SK+josnGNW8bCwHTYo/ueXX3w2swOWhbw6JSugYZhI24R31cz4l/KFEwF91v
         OiUQ==
X-Gm-Message-State: AFuF++nis/djAuFThyd0N2arGk1hKcBN03sdPVgiQ8Vcxi5uji+9FPSP
	BNz9u7x/U8ePzghi2+Hk8s7i5sVir3YEcCgbLlo/O8hRW72K43P6d4e6vhoZkA==
X-Gm-Gg: AYBFou0UK0vR3nfQd2yDQOxcez/OUzXvSU1jWCmA+Zkxhm6d3dtFS0HdxRTM+DkkWgP
	gbyHevv/MtO3bv00KBj1ui08fao7LCb3iNg/gGei2gAiJtsmrJeALZ4vnZtc8R6WvopxkXRgQis
	WemZASy2Bm+Qcax8mRxtEfBaQvHtDrUwoFPckYV54KqYqxww73IvRBpKydFFsLxxOhZaP3ek+1u
	Zqp9H+FhHWSSt/kbTlT9Wj0yUiQo1Ad3rfMbTnCRTOTASqbbaB/GrCPw6i3eh/M2pkib24qGNBJ
	v222xr23klxd+tN6Wm+tT0MlFls5eqmfSMR0RPbbHaIbgMGcWt7JEs7lFgu+QT09N9FJIxKvtJl
	igxVKrfbPXbb/Pd2OIY5nLTKVZaUTN6tvxx70VLDpPRhgKiAupelXCoiOFGbJ0TDpQV3QUAP5Fn
	rZzJJyZGsFpEnOGv42MN/YWooFCmKGe+3LeeoZWT2ZHnjjA1C8Aj8ci0p9U3vtwHgAFSZzfmaf
X-Received: by 2002:a17:90b:518e:b0:38e:1497:af5b with SMTP id 98e67ed59e1d1-396d0d2f6d6mr27108885a91.1.1788014940747;
        Sat, 29 Aug 2026 07:49:00 -0700 (PDT)
Received: from ancienth-X870E-Nova-WiFi ([125.186.72.2])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-398bd57b18asm1540071a91.0.2026.08.29.07.48.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Aug 2026 07:49:00 -0700 (PDT)
From: Daehyeon Ko <4ncienth@gmail.com>
To: netdev@vger.kernel.org
Cc: David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v2] ip: skip IPv4 cmsgs for non-IPv4 packets
Date: Sat, 29 Aug 2026 23:48:44 +0900
Message-ID: <20260829144847.1738294-1-4ncienth@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

IPV6_ADDRFORM can convert an IPv6 UDP socket while a native IPv6
packet is still queued for reception. The converted socket then receives
the packet through udp_recvmsg(), which passes it to
ip_cmsg_recv_offset() as if it were IPv4.

This makes the IPv4 ancillary-data code interpret inet6_skb_parm as
inet_skb_parm. In particular, IP_RETOPTS can take the IPv6 lastopt and
nhoff offsets as an IPv4 option length and RR offset. A destination
options header can then make __ip_options_echo() copy more than the
40-byte stack option buffer.

KASAN reported a 152-byte write on 3/3 fresh v6.12.105 boots and 3/3
fresh v7.2 boots. A production-shaped v6.12.105 build instead reached a
hardened-usercopy BUG followed by a fatal-exception panic on 3/3 boots.

Check the network header version before parsing SOL_IP control
messages. skb->protocol is not a reliable discriminator here: IPv4
multicast route cache reports can leave it unset, while software VLAN
processing can change it to ETH_P_8021Q before a TX timestamp is queued.
Both paths still carry an IPv4 network header and valid IP_PKTINFO.

With this change the original trigger returned its payload without a
control message or a target KASAN report. The no-extension and native
IPv6 controls passed, and IP_PKTINFO was preserved for both the
multicast route report and software VLAN TX timestamp paths.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Daehyeon Ko <4ncienth@gmail.com>
---
Changes in v2:
- Use the actual network header version instead of skb->protocol as the
  discriminator.
- Preserve IP_PKTINFO for IPv4 multicast route cache reports and software
  VLAN TX timestamp error-queue skbs.
- Validate both reviewer-reported paths alongside the original trigger and
  controls.
---
 net/ipv4/ip_sockglue.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/ipv4/ip_sockglue.c b/net/ipv4/ip_sockglue.c
index a55ef327ec932c..01d264e8f34ea1 100644
--- a/net/ipv4/ip_sockglue.c
+++ b/net/ipv4/ip_sockglue.c
@@ -174,6 +174,9 @@ void ip_cmsg_recv_offset(struct msghdr *msg, struct sock *sk,
 	if (!flags)
 		return;
 
+	if (unlikely(ip_hdr(skb)->version != IPVERSION))
+		return;
+
 	/* Ordered by supposed usage frequency */
 	if (flags & IP_CMSG_PKTINFO) {
 		ip_cmsg_recv_pktinfo(msg, skb);
-- 
2.54.0
