Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793956776;
	b=i8rJrR6J4nz3wWCHYPu7HWseT2gMHuPHnf8JWZ2vXjnTcnYJyd4Nksd1EgOxf9UepAvN
	 aKwdd0Kj+YBY3iLM/OHLYbQ1LiOqPYfdZRfmjNYWbr64Y5a4okdRpD/2V9q62dmZMfcyu
	 uQJMTd3QZUrcFTYRp8DsihKRWn7ghqDwhP1LOGd1xy9J2FHG7Rty/X6caWHpqVE7vBUTa
	 KkaumJy9tbtYCFBHLITUD7HO3jcOKMohSPNbfQr+2eL60A/OYBlXW19qCX5Qs4lY93GA7
	 7ERftXKRGETFtn43yVtumCIyoGrW4n+04Hd5FP109gSUbYIGLxnmH0cXZNjwEwts30A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793956776;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=/m8DroyGi6W7B+Mw18cGVlrPsFuiEfejtQgAV31YPco=;
	b=yGkbpC1A5TbWon5U7V3heux4HyHiRRJMHEh1CCFflhAa255BZ4NipBWesPoIw8O+G8NK
	 4BXTrwGbhpwtilsgTSOcoCuL5bJ6XK3PVEEoxOiHhw4qtlqZ16QdJ4yDtboD59/2cnl6B
	 1PlNDrAAfn+DgkR2JoMcUlDMMkEnSCnaL8ZXP7Pvc8NH/U6tSgGoTAEZlK2D2Afmu9Va+
	 w3whB+gsUKkE7Y8kTN8CPeo7z8376Url0uYkbeU/QBDy7OyNOfmmqY1m8+tG4dGYav4J6
	 dY3kEWFh8IVI3C1bAJ3UePG4WLAgvmxtlBKMU83a8CM9AP4Q+nbgFR9vw+vY00GIM+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qehmNrGR;
	arc=none smtp.remote-ip=209.85.214.182
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F33B0606A326
	for <netdev@vger.kernel.org>; Fri,  6 Nov 2026 09:19:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F33B0606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qehmNrGR
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2ed0b03ce3eso1469895ad.3
        for <netdev@vger.kernel.org>; Fri, 06 Nov 2026 01:19:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793956775; x=1794561575; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/m8DroyGi6W7B+Mw18cGVlrPsFuiEfejtQgAV31YPco=;
        b=qehmNrGR5ccqnuuChUP1vPJBQoTqejx35NiKRPbp0fREJuyTzn/dZClBbTpZRL3PV8
         M58xTWcfWWYJMbc6CR4WelgwcEO6b/qdsAWVW12bOGdq51oHRzwbPNK+F+DWTk5slMhI
         YAeBBpaodynOKRBX84yfTbXWbjYKr4aeCkk7mzGLSX879gqyAVCO4lmuR0WbWKh2mVlP
         UnJ7ccibIvV96oSAcOE6B38yFVdtMSJGXtmQo/5Ww8w/yCX1hssGCa+xqt7DZ9ioTi4i
         /CPxokl3ZRawel+LJ9GoLiHnUiZiFYElbDAfGrXDNWYSCPXx6EWQUXf6L3BpElPVteGH
         7mag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793956775; x=1794561575;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/m8DroyGi6W7B+Mw18cGVlrPsFuiEfejtQgAV31YPco=;
        b=zsvLw84qY54AxHxEgQqIBplDos2TCR4r3S7H1AhWOUTLhUkk2+Ps4wu+QA8XXJ7NUP
         8TSGS5dYGboXWigCXL+4zP7kcLOIo+VDEBE1rALH0568nkh8AZNo3UzT6h9ABQpJ2eKV
         fBG5VFfsXqsw15KfPRypS/Ih2u24KmTpSpOJ7Lno9fJvzpIJOIcL/6bYq+Oplb0B1nam
         HNeKjr6Dv8LIf2sYl+VPfv7G23DdLpRjZtCC2dGFnEavnvyx83thN65UEz+avghjVUlc
         nnPSewHNiOjbdMu7Qo0A2NJVchVCg6ZwUX0YAN4zNoFJtbIo9bXhkT77yWirsAnBIDPf
         j0KA==
X-Forwarded-Encrypted: i=1; AL+hErEiH6YAYAZ7GONitS21/Rp01Wzkafzpvjkie3uKnt0qS+TNBnn3niLbAauYGvaAD7DQY/K9lvY=@vger.kernel.org
X-Gm-Message-State: APuU4Z86jWPw//Jg6JWPDL/KjbUjaXBU7boLj43d1xwnULelAEz5rR0P
	NNFOMDp9VAMW3lUX7RlGoopFPQPOONg/NULlxsmze0GSyArveWya/otm
X-Gm-Gg: AYBFou1dpHeVRHWHFcEyzofA5ZesZOq2Is+r66YCp2rkiLv7zPd/v2ZPuPRinqw73cC
	DVeAlKKOumsRsQLdjgjrpI4D7y+ascooXYhFWnHEwsdzyOvAX3vpBZRQI2TpzbjNPUyrz4AFp2K
	WyfY0LCJBLnNd/ElInRJzmrQAL4C/HXA1300z7UTyJJcndESOzXqJxpJYC/JKEGI0djeNgxspkL
	bX4hkLc1UDIY/FkyQuyLF2nwUi8vxQw+V/TRea8hO72j2gJc5ASeO9cvtUFoI2naaictQ7ekoYu
	QrBXsupbtuG6ibR6VWMrhE6TV2vhzHoYFNaekBSf0K2R5BGr9as2dcQnEUoi79nzEJD+tPkeEiB
	iLsARDMa5BDyMSCFkaWWdL9LI2AmGYE3QkH0qK6fNk+d2L8RB8s9GsmoKafCX8JzeIpuMOA4rnL
	Gpff+LPqcthyB3p8w9Sta7PIIwraNorPq6SUyaTY6BtVki76yDEbTCTDbwEXqB1z3o5px3G9U60
	B6MrJihPdRmKjLt1dMxM+NsJvyPCQPZa2TrHu6irhNvNuwLfmd8ULiwhXTkF78XSIlUD8Hc/ERe
	ELqo+AwXTJ5AVLQ3d2chf09emaOMPcRH3ZQMh+rBpsTbQgFjKSAAqOlazQsrV6ic5EMJ5ZPHqvA
	+2VmjNaO+Hgg=
X-Received: by 2002:a17:90b:254e:b0:3ad:d29c:5e64 with SMTP id 98e67ed59e1d1-3b0db701624mr1756455a91.65.1793956775264;
        Fri, 06 Nov 2026 01:19:35 -0800 (PST)
Received: from JUNVYYANG-MC1.tencent.com ([43.132.141.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b0b32baf86sm6954489a91.17.2026.11.06.01.19.32
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 06 Nov 2026 01:19:34 -0800 (PST)
From: Jun Yang <juny24602@gmail.com>
To: steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au
Cc: davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	nakam@linux-ipv6.org,
	shinta.sugimoto@ericsson.com,
	yoshfuji@linux-ipv6.org,
	netdev@vger.kernel.org,
	Jun Yang <junvyyang@tencent.com>,
	stable@kernel.org,
	TencentOS Corvus AI <corvus@tencent.com>
Subject: [PATCH net] xfrm: reject duplicate state resolution in xfrm_migrate()
Date: Fri,  6 Nov 2026 17:19:18 +0800
Message-ID: <20261106091929.52067-1-juny24602@gmail.com>
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

From: Jun Yang <junvyyang@tencent.com>

xfrm_migrate_check() rejects identical migration entries, but entries
with different old_reqid values can still resolve to the same state.
In particular, old_reqid == 0 is a wildcard, so it can match the same SA
as an entry carrying that SA's reqid.

xfrm_migrate() then stores the same state more than once in x_cur[].
After the lookup references are dropped, the first delete can release
the table's last reference. The garbage collector can free the state
before a subsequent delete accesses it.

Reject a state already present in x_cur[] before cloning it again. Drop
the extra lookup reference and use the existing rollback path to remove
any clones installed for earlier entries.

Fixes: 80c9abaabf42 ("[XFRM]: Extension for dynamic update of endpoint address(es)")
Cc: stable@kernel.org
Reported-by: TencentOS Corvus AI <corvus@tencent.com>
Signed-off-by: Jun Yang <junvyyang@tencent.com>
---
A KASAN reproducer for this issue is available if requested.

 net/xfrm/xfrm_policy.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
index 9ea60c7717ff..472f65616e28 100644
--- a/net/xfrm/xfrm_policy.c
+++ b/net/xfrm/xfrm_policy.c
@@ -4669,7 +4669,7 @@ int xfrm_migrate(const struct xfrm_selector *sel, u8 dir, u8 type,
 		 struct xfrm_encap_tmpl *encap, u32 if_id,
 		 struct netlink_ext_ack *extack, struct xfrm_user_offload *xuo)
 {
-	int i, err, nx_cur = 0, nx_new = 0;
+	int i, j, err, nx_cur = 0, nx_new = 0;
 	struct xfrm_policy *pol = NULL;
 	struct xfrm_state *x, *xc;
 	struct xfrm_state *x_cur[XFRM_MAX_DEPTH];
@@ -4698,6 +4698,17 @@ int xfrm_migrate(const struct xfrm_selector *sel, u8 dir, u8 type,
 	/* Stage 2 - find and update state(s) */
 	for (i = 0, mp = m; i < num_migrate; i++, mp++) {
 		if ((x = xfrm_migrate_state_find(mp, net, if_id))) {
+			for (j = 0; j < nx_cur; j++) {
+				if (x_cur[j] == x)
+					break;
+			}
+			if (j < nx_cur) {
+				xfrm_state_put(x);
+				NL_SET_ERR_MSG(extack,
+					       "Multiple MIGRATE entries resolve to the same SA");
+				err = -EINVAL;
+				goto restore_state;
+			}
 			x_cur[nx_cur] = x;
 			nx_cur++;
 			mp->encap = encap;
-- 
2.43.7

