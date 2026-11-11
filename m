Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794420011;
	b=JkidqLgvvzNFgqTXy8bNGu6TxqECYv2zNg1wCs3r6gIC7NtLLI4PZKBe2/eUSVrNgvNZ
	 hxOqtDAJtUtj7o/Faf8pkPr/cO1Yucm7jKyTi68OB6ki/cuWFDlg2vtZ7zMS/l5VldgMC
	 L9hiuXLykTuzEN72t5d2+teKLudRTkI6E9gXNmbLW/nqR+5fLocMSSVzaSQmk3kocm8f+
	 cn3FrmQi9F5HRB23ghpOZ2K2OtiNeo7fgLtVRSi6yIZFCg5jvwuW19bQKwdH5RVuT0cSK
	 /SfSCBji/gwPRS88gHCSC2RRj+ZBXuQh6HOmvNPyYCUXIbYrEIl6YcJFIdSjpIkGRyA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794420011;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=1/CKi+wv0FEefgVJu7N7aC/Ymg6LzWP4g3Bva4f+y3Q=;
	b=MIzkYmVP5Pvnb1v6zSVMnn85b5aje+UYrfdAVZoMt+kho8sG9/BvCJt37JpVNp7X0eP4
	 tUEOS1AVb3HnbcKewnCc1+AFYmFot9CBFFH+r8/mHUJ4BEZTvKb6xzcsYqr93XG+C/SF9
	 e8ms1AuKnVtLd0TcxoO0WWB9xiBFL8SvC7tWZhr22+VirIYEWCgxlNzEo/eVekVDnURCw
	 /7sAKWH/36wct8PB01J7272r5Y+67fcEwDTloFAnBmzIp3ekbD5txmBK1vyuuwlqoaOBX
	 PtHX5R7xKG9GTlo5m9R/dEGbLdoTzHGNKXUHM4TfnKuohJAHHI36zqezPVbFPtE1XCw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="bq/Qkh1d";
	arc=none smtp.remote-ip=209.85.216.52
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D28AD606C217
	for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 18:00:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D28AD606C217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bq/Qkh1d
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3b1535be329so1861895a91.3
        for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 10:00:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794420010; x=1795024810; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=1/CKi+wv0FEefgVJu7N7aC/Ymg6LzWP4g3Bva4f+y3Q=;
        b=bq/Qkh1dvC+NmgyE+YHCF54HL/u2ERLGIvp5mD2vZweYYGIdifpsin9JIHjK6zsqpA
         ze0F3EpJ6PjL0BQ4sSxR4bQtx4sYjiXmbMs6nxTa3s/OJsWfQNLPQH6XoIUeD5fIKbbb
         94tFM0SHKaB37qScCvYVz+iAitzZLfwQ5q5xAxN8P+jNozBkWUdeyPIkk2tEPp3QalOL
         x2/BWqTYEC1q2WGrL8304/QLspZX9sC20XaRWnpKw27pEqL9xImuvTER7q9Ne/dFw4q2
         oguSiN7lRC0Jm1PBfcGwmza+VFiF4OmGCgZuhLg7pATH/QKmvkDekD1Kvnu9mDKgG2FQ
         aanQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794420010; x=1795024810;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1/CKi+wv0FEefgVJu7N7aC/Ymg6LzWP4g3Bva4f+y3Q=;
        b=wgNtNfBOqYRc1ANd5D+FLpeznZTO7fJROKfz9DCwRQi5NnKelaJhZZl2VuzrdP5pP5
         2rP5LFCyPNKXrH3pp7htOdKNSrwYzQUxJybPjTL9oB2qKmo0CxEYxXAM5ZTWqs20Mcne
         a/zCL8OHe96yug+L9vjSyg0h5/Fz1SWsPq85VVGtL8dzW3lNmRe69mDi5UJkF1Jq5lFK
         Y8CglJBPcvtOxapQQ+CC4WITaxrIVc09xUmllxj0xRgpYxGwmlhc7MV3zoxL1efWMTFU
         8EqwnHwTVLvKsGzVXp5fyxH7mMLBAnZpSMRO4fmnapcFfAYSaRvpwNeRgDMDJxUewo5e
         3Lug==
X-Gm-Message-State: APuU4Z+OZoCRYEKbpM2/todh8ZyyG8HghkHQot51Xi3Hm5FQG1+wW9zT
	57e8CMqMKoh/ZZs7jn2FnS28pncbmn83dm0IIQxhSRiyOcMedkiqfTv45jHe6wCm
X-Gm-Gg: AYBFou14mjmvVmRZN/cVGgbMaO3jMk7tby5TgcuQfIaIA+3iDpqVbaoxT5WuZFHHk4C
	PX3D/E06gRIDtDeOz0j7Z5/IliqFCcihu+MzrufxJvCOaZ4fCTywAsRFTFV3X13XPBWR1nf8pwQ
	ufyNJKHjvhivSonYcLTmfGI+SJgugS9R9yCpwPVeox8UNfHTxNU4iYibgsJg0/+Xz4NiwxS01Qp
	OTPEf7bK5Cmu3iTaz11vRIcQcgXdx7yxqBBVFs4PNuu+CvTF6MRCY2w3y1idzYGKwpLqySiIRYG
	dzFnpFW9992ivTQdk4CiK515vuZDZzB6jMjtkZgkegks8hy98PKhPFrk18lt66cIphbCWr5wye4
	OZHcr8KOe1FgN92H5XJsOGiHI+MA/uOUTxefqZWiYtM1IwMqYaF0tp5AN/KbFG0Tux5y3AA0Pay
	MovVpAQMarbuZdAVKsSCAtcFv2lkMe7lmIxvmHYYr+l6F2JWS6BXWP6E0KHvYSQ/U60Ro6nYK6P
	HkwpZa+MiiOLYf+XvvfRcrzjzlZesmxaZIBnaQij2ruEJc8Zmb4qGLkHTUElIQEmhM6Fkdalrpx
	MDXIFndWqlePxO5eapBRn2s+bGlzrehmleLUOi2JLmvE4AEtImTAU6RPHcElafoCTNfYoLJcIGz
	uUm4=
X-Received: by 2002:a17:90b:4ac6:b0:3b0:9e2f:cfc3 with SMTP id 98e67ed59e1d1-3b182f26e60mr3203834a91.32.1794420009369;
        Wed, 11 Nov 2026 10:00:09 -0800 (PST)
Received: from localhost.localdomain ([219.95.157.251])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b197d282fdsm271193a91.14.2026.11.11.10.00.04
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 11 Nov 2026 10:00:08 -0800 (PST)
From: Zhefu Peng <ilskdw@gmail.com>
To: netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	kuniyu@google.com,
	mschiffer@universe-factory.net,
	nicolas.dichtel@6wind.com
Subject: [PATCH net v3] vxlan: reset the remote's dst cache when snooping moves a MAC
Date: Thu, 12 Nov 2026 02:00:01 +0800
Message-ID: <20261111180001.2475-1-ilskdw@gmail.com>
X-Mailer: git-send-email 2.54.0
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

vxlan_snoop() handles a known MAC that now arrives from another remote
by rewriting the remote's IP address in place. It leaves the remote's
dst_cache alone, so the next packet to that MAC is routed with the dst
cached for the previous remote. When the two remotes have different
next hops, the packet leaves the wrong way. For example, if the
previous remote was on-link and the new one is behind a router, the
device resolves the new remote's address on the local link, the
neighbour stays incomplete, and traffic to the MAC is blackholed until
the cached route is invalidated, such as by "ip route flush cache".

The same branch also leaves remote_ifindex unchanged, although the
early return compares it and vxlan_xmit_one() uses it as the output
interface. When a MAC moves between an IPv6 link-local and another
address, the remote keeps the previous interface, and every later
packet from that remote enters the migration branch again.

vxlan_fdb_replace(), which makes the same change through netlink,
already resets the cache, updates remote_ifindex and clears offloaded.
Do the same when snooping.

Reproduced with network namespaces: a learning VXLAN device has one
peer VTEP on-link and another behind a router, and an inner MAC moves
from the first peer to the second. Without this patch, pings to the MAC
fail after the move until the route cache is flushed: in 10 of 10 runs
with one CPU, and in 5 of 6 runs with two CPUs, where it depends on
whether the sending CPU holds the stale entry. With the patch, they
succeed in all 16 runs. In a second setup over IPv6, the MAC moves from
a peer with a global address to a peer with a link-local one. Without
this patch, the move and every later packet from the new peer each send
an RTM_NEWNEIGH notification, 33 in each run. With the patch, only the
move sends one.

This was found by our AI-driven automated live migration tests. The fix
and this changelog were written with the help of an AI coding assistant.

Fixes: 0c1d70af924b ("net: use dst_cache for vxlan device")
Fixes: 87613de95041 ("vxlan: fix snooping for link-local IPv6 addresses")
Signed-off-by: Zhefu Peng <ilskdw@gmail.com>
---
v3:
- use my real name in From: and Signed-off-by:

v2: https://lore.kernel.org/netdev/20261110153020.9635-1-ilskdw@gmail.com/
- also update remote_ifindex and clear offloaded, as vxlan_fdb_replace() does
- add the IPv6 link-local case to the changelog and a second Fixes tag

v1: https://lore.kernel.org/netdev/20261106144406.66035-1-ilskdw@gmail.com/

 drivers/net/vxlan/vxlan_core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index d11028b37..6bc54642e 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -1482,7 +1482,10 @@ static enum skb_drop_reason vxlan_snoop(struct net_device *dev,
 				    "%pM migrated from %pIS to %pIS\n",
 				    src_mac, &rdst->remote_ip.sa, &src_ip->sa);
 
+		dst_cache_reset(&rdst->dst_cache);
 		rdst->remote_ip = *src_ip;
+		rdst->remote_ifindex = ifindex;
+		rdst->offloaded = false;
 		vxlan_fdb_notify(vxlan, f, rdst, RTM_NEWNEIGH, true, NULL);
 	} else {
 		/* learned new entry */
-- 
2.47.3

