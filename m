Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=180.76.5.236
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794216030;
	b=Lbv2TBeZFBhXhBRSOWe3yheWD0hDAIJsjEUVJkgcACSbCwMHOE+IW5EowbOBD7srGCKB
	 jwoQKeqeQ9uNbTFIXxMgBItL/VC54wdtN59I4hla2enKu/eIh1wuuAzLddoo41m0FV2Qn
	 iFHlgKH4ivYyT9Y6IJWArURmu0tlkSsocgnklSipx3IT1m46Zr0UOnRdBemZk7C0NOfKu
	 1H/3HS3WkL1Il/H3V04SBbqIjkRLe6UX8asz/cEhUni4InM+1Ttfr7KxOh4RoAhAl3sl+
	 iReLWWUTJR7HOZCMr217Zq2vuR5d3/crgngt9xLh+80mMYSNE9o1u3M3tXybOGr90Rg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794216030;
	h=DMARC-Filter:X-MD-Sfrom:X-MD-SrcIP:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy:DKIM-Signature;
	bh=kwCvPkXgwrZOz9NQ5CtI9zg2+YkBy4S3vvYk8lmOZ8I=;
	b=e4MldVr8zofJU+ILjf0KkG5xVJqg8srfvgqpHS/uNZNm3gc4ttHgtWk+hsM6+gHAKxkl
	 oFx9fFMZjVn/BL7ymOSJy+A6maf7EdPDBUxZ6TbctRY/LaT1PS2t5hnC5jxDXDWYlkNUG
	 6keVZimv3wNNT+phomX1Ve4e1CKGYxJUwgYdkvsgBGseKByAdKcts8SFYmGrE1YgKsNQE
	 KcVk2z0Xe+/cC8dq1cBDFEGARjJ0RTv0O/6czCDwvBRjjy/ADotI3nORa0ePNGV5H0vtX
	 hXf/n9uKYTdgsCuPI+i84Um+mKDbo3G97RCWxEvQWymjSSmpUZZKESQTyaiggCpgN8A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=baidu.com;
	spf=pass smtp.mailfrom=baidu.com;
	dkim=pass header.d=baidu.com header.i=@baidu.com header.a=rsa-sha256 header.s=selector1 header.b=i+jpgJFO;
	arc=none smtp.remote-ip=180.76.5.236
Received: from outbound.baidu.com (outbound.baidu.com [180.76.5.236])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 49944606A31C;
	Mon,  9 Nov 2026 09:20:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 49944606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=baidu.com header.i=@baidu.com header.a=rsa-sha256 header.s=selector1 header.b=i+jpgJFO
X-MD-Sfrom: lirongqing@baidu.com
X-MD-SrcIP: 172.31.50.47
From: lirongqing <lirongqing@baidu.com>
To: Kuniyuki Iwashima <kuniyu@google.com>, "David S . Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Li RongQing <lirongqing@baidu.com>
Subject: [PATCH,net-next,v2] af_unix: Fix wrong socket tested in the symmetric half of unix_state_lock_cmp_fn().
Date: Mon, 9 Nov 2026 17:20:16 +0800
Message-ID: <20261109092016.2082-1-lirongqing@baidu.com>
X-Mailer: git-send-email 2.17.1
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: bjkjy-exc9.internal.baidu.com (172.31.50.19) To
 bjkjy-exc3.internal.baidu.com (172.31.50.47)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=baidu.com;
	s=selector1; t=1794216025;
	bh=kwCvPkXgwrZOz9NQ5CtI9zg2+YkBy4S3vvYk8lmOZ8I=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type;
	b=i+jpgJFOOrqtKSWxMaXnNBaU2X98LQ9hpxvtTVKOP5veK66MMxsv2bpF+B0DFzP5E
	 F4khOkjV0qI/T7WJ+NQMVGlnjegqgp2GEsO04behyIwITJbkSwbyq5Bgq4dYnBZbg0
	 wyw92Bt2ifXDvGIoxqGbzGOjDh2gLv84xzmdcHOA8e7bnrr23XamLaHYeYzrtZvjUx
	 wCLuLHq2TQ+g2NZFhRajnmocWTF+hOfy6CIjxnCVeicC7+QoH+2oKs7DRlcm1pVi/I
	 9D3oHha3ahw/wuL5WAvDOUROYUlu6bigKT877QQ9V91vjkq5Zb9C4S6fk4scSbRoHI
	 GYMb7NCdLBgBg==

From: Li RongQing <lirongqing@baidu.com>

The second half of unix_state_lock_cmp_fn() mirrors the first with a and b
swapped, but it tests b->sk.sk_state again.  Since b is already known to be
TCP_LISTEN, the switch only hits default and always returns 0 ("no order
known") instead of 1.  Test a's state instead, as the first half does.

This code is only built with CONFIG_PROVE_LOCKING, so the impact is limited
to lockdep failing to validate this unix_state_lock() nesting order.

Found by AI.

Signed-off-by: Li RongQing <lirongqing@baidu.com>
---
Diff with v1: target to net-next, and drop fix tag

 net/unix/af_unix.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index e7a0582..501e693 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -163,7 +163,7 @@ static int unix_state_lock_cmp_fn(const struct lockdep_map *_a,
 
 	/* Should never happen.  Just to be symmetric. */
 	if (b->sk.sk_state == TCP_LISTEN) {
-		switch (b->sk.sk_state) {
+		switch (a->sk.sk_state) {
 		case TCP_CLOSE:
 		case TCP_ESTABLISHED:
 			return 1;
-- 
2.9.4

