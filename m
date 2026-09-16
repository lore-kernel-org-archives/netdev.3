Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61F4A4BA1E7
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 10:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789552939; cv=none; b=h/Ye2oAH4pR/At+YCIc+dEAZwSrXcaTjTFwoUo8r+Eq59/4FnXa1XJqEOE15ogZCzAb/JAvVOHUbJdfZry/Dx/Vuzge41sy//HxTIhM/dqxC4UVENvMVgwlg2pT5H8PuDMIs/XSuUZXwA6u8hK5/G+h7Xykbr3uejJDBvxGdYvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789552939; c=relaxed/simple;
	bh=5HBA/P6/Uru2uXY+8z1N08P21xcC9dkmvnMQ4zD8YtI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PghtaUWkyaQeq0IGluAg88+U8kW+6bPWs8o4PAf1t0fFduhbxy0Hz+vCTrd0lAsS1O8liPq3PIgYuxEm1jOmJHOdmDlzCMAwXUMZ8JaRXSmcFjfTDUcdPu90BKelZOmLCAJGqhrjrbWd9kaom8AvHdX7OF/mQKILxjqS99Hc0NY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Hb4vMWvg; arc=none smtp.client-ip=209.85.222.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Hb4vMWvg"
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-939f248907fso436389285a.3
        for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 03:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789552918; x=1790157718; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2kllq1CawMs2zznw7q84hEm9n1BOacb9A9xmoulWQV8=;
        b=Hb4vMWvgYUuEfhivSq2VHCdz85zT5AaZ/4NvDuS0Ms12/KCLPjGz8PMdvkTKnVI6dT
         PM84ZTpIBk5SO77QgEeU6qDuU1ho154S9wx9FlEU+fqIKQR2YA0XUGlCsBPYrHAmj0g5
         lAzbSKNgZZnDG3udkQoK/Q11t7l78FP+2aqpXk5fySfqHbI0oImEJ/syt4silbmRX59t
         BBSFjx5cjov0KcTVvetm6f3mvlt0DdJOVO5K8vAq2zJadGyTklxRdDYLRkvyaguHnWsY
         TqPQeJy0D0zd7vWgQX67K2q35vAgVxUjeucXc8JbiMg+8blcuMkgDVsWejBGzKrGV5h6
         vSGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789552918; x=1790157718;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2kllq1CawMs2zznw7q84hEm9n1BOacb9A9xmoulWQV8=;
        b=tIsGyf1GfZnICilu+7Sgkx0ueV/93NLSi00Gg859115a2pAqhHUQgVnshPm55TbP9U
         G8V3tkkzlkp13rdlRKc8pd1uT9KuQNqdBJd8/GCjTpk5nOcM+Eybk2C1JKoKYnySsqex
         wIXbAiVY8Ah6OhhT0DlsMcOTk8otH666slnJ8VSRAX01fS+uy2xOTChJhuPcJVIkqaC3
         NbJIxtEvJxRYu4dl6cQ6gFn8GMekG6esLfb6vsOcxSeJnnsjDnDud/0nV81ofr4BsLao
         +2gUQoPObQle5hQRAYiTZ8NovDfOm5HBnRFp/RgXYC6OwiAXAqvbD+lSNp47lunBtIuO
         W+sQ==
X-Forwarded-Encrypted: i=1; AKwUvBzvdrbnHDe926ZoBBSfgcZstyui5TbnhKNBbsFeadiM6dcZ9FvgWUSQ5GC1uYSuqBH5yvUgvMA=@vger.kernel.org
X-Gm-Message-State: AFuF++keM4JDXK9/8/6WGJrfhdS+UhBuAh/p0111AoI4q4By579dEKz8
	nkjeiXNDjOkHVy9mqADn37KqDpzQOrOxu5wAUdE4fEYBu/1MmUEzEstEzhsij7KCfFeavQt8MCw
	X6HR01yRFFWAXkQ==
X-Received: from qkcbk15-n2.prod.google.com ([2002:a05:620a:72cf:20b0:93a:1865:3b91])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:4506:b0:939:fa7:8df8 with SMTP id af79cd13be357-93bb772ac2dmr272271085a.11.1789552917811;
 Wed, 16 Sep 2026 03:01:57 -0700 (PDT)
Date: Wed, 16 Sep 2026 10:01:52 +0000
In-Reply-To: <20260916100155.1398403-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260912150944.3470971-1-edumazet@google.com> <20260916100155.1398403-1-edumazet@google.com>
X-Mailer: git-send-email 2.55.0.1032.g73a4cd73de-goog
Message-ID: <20260916100155.1398403-3-edumazet@google.com>
Subject: [PATCH net v2 2/5] ip_gre: validate netlink attributes before
 changing the tunnel
From: Eric Dumazet <edumazet@google.com>
To: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com
Cc: horms@kernel.org, dsahern@kernel.org, idosch@nvidia.com, 
	netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

ipgre_netlink_parms() and erspan_netlink_parms() write into the live
tunnel before all attributes have been validated, so a rejected
changelink leaves it half updated.

A request carrying IFLA_GRE_COLLECT_METADATA and an invalid
IFLA_GRE_IGNORE_DF returns -EINVAL, but dev->type has already become
ARPHRD_NONE, breaking the interface for good.

Parse the ERSPAN attributes into local variables and commit them only
once everything is validated, hence erspan_netlink_parms() now calls
ipgre_netlink_parms() last. Same reason for moving
IFLA_GRE_COLLECT_METADATA after the IFLA_GRE_IGNORE_DF validation.

Only the parsers become all-or-nothing: ip_tunnel_encap_setup() still
runs before them, ip_tunnel_changelink() after them.

Fixes: e271c7b4420d ("gre: do not keep the GRE header around in collect medata mode")
Fixes: 84e54fe0a5ea ("gre: introduce native tunnel support for ERSPAN")
Cc: stable@vger.kernel.org
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/ip_gre.c | 55 ++++++++++++++++++++++++++++++-----------------
 1 file changed, 35 insertions(+), 20 deletions(-)

diff --git a/net/ipv4/ip_gre.c b/net/ipv4/ip_gre.c
index 82309efd417e0f1f6554e7028be8e05d769e932d..dad3d054bd15612a3ebe1cf27e6e8c5d9e6896e9 100644
--- a/net/ipv4/ip_gre.c
+++ b/net/ipv4/ip_gre.c
@@ -1233,12 +1233,6 @@ static int ipgre_netlink_parms(struct net_device *dev,
 		parms->iph.frag_off = htons(IP_DF);
 	}
 
-	if (data[IFLA_GRE_COLLECT_METADATA]) {
-		t->collect_md = true;
-		if (dev->type == ARPHRD_IPGRE)
-			dev->type = ARPHRD_NONE;
-	}
-
 	if (data[IFLA_GRE_IGNORE_DF]) {
 		if (nla_get_u8(data[IFLA_GRE_IGNORE_DF])
 		  && (parms->iph.frag_off & htons(IP_DF)))
@@ -1246,6 +1240,16 @@ static int ipgre_netlink_parms(struct net_device *dev,
 		t->ignore_df = !!nla_get_u8(data[IFLA_GRE_IGNORE_DF]);
 	}
 
+	/* All attributes parsed here have been validated, we can change @dev
+	 * and @t. This only makes this parser all-or-nothing, the caller can
+	 * still fail in ip_tunnel_changelink().
+	 */
+	if (data[IFLA_GRE_COLLECT_METADATA]) {
+		t->collect_md = true;
+		if (dev->type == ARPHRD_IPGRE)
+			dev->type = ARPHRD_NONE;
+	}
+
 	if (data[IFLA_GRE_FWMARK])
 		*fwmark = nla_get_u32(data[IFLA_GRE_FWMARK]);
 
@@ -1259,40 +1263,51 @@ static int erspan_netlink_parms(struct net_device *dev,
 				__u32 *fwmark)
 {
 	struct ip_tunnel *t = netdev_priv(dev);
+	u8 erspan_ver = t->erspan_ver;
+	u32 index = t->index;
+	u16 hwid = t->hwid;
+	u8 dir = t->dir;
 	int err;
 
-	err = ipgre_netlink_parms(dev, data, tb, parms, fwmark);
-	if (err)
-		return err;
 	if (!data)
-		return 0;
+		return ipgre_netlink_parms(dev, data, tb, parms, fwmark);
 
 	if (data[IFLA_GRE_ERSPAN_VER]) {
-		t->erspan_ver = nla_get_u8(data[IFLA_GRE_ERSPAN_VER]);
+		erspan_ver = nla_get_u8(data[IFLA_GRE_ERSPAN_VER]);
 
-		if (t->erspan_ver > 2)
+		if (erspan_ver > 2)
 			return -EINVAL;
 	}
 
-	if (t->erspan_ver == 1) {
+	if (erspan_ver == 1) {
 		if (data[IFLA_GRE_ERSPAN_INDEX]) {
-			t->index = nla_get_u32(data[IFLA_GRE_ERSPAN_INDEX]);
-			if (t->index & ~INDEX_MASK)
+			index = nla_get_u32(data[IFLA_GRE_ERSPAN_INDEX]);
+			if (index & ~INDEX_MASK)
 				return -EINVAL;
 		}
-	} else if (t->erspan_ver == 2) {
+	} else if (erspan_ver == 2) {
 		if (data[IFLA_GRE_ERSPAN_DIR]) {
-			t->dir = nla_get_u8(data[IFLA_GRE_ERSPAN_DIR]);
-			if (t->dir & ~(DIR_MASK >> DIR_OFFSET))
+			dir = nla_get_u8(data[IFLA_GRE_ERSPAN_DIR]);
+			if (dir & ~(DIR_MASK >> DIR_OFFSET))
 				return -EINVAL;
 		}
 		if (data[IFLA_GRE_ERSPAN_HWID]) {
-			t->hwid = nla_get_u16(data[IFLA_GRE_ERSPAN_HWID]);
-			if (t->hwid & ~(HWID_MASK >> HWID_OFFSET))
+			hwid = nla_get_u16(data[IFLA_GRE_ERSPAN_HWID]);
+			if (hwid & ~(HWID_MASK >> HWID_OFFSET))
 				return -EINVAL;
 		}
 	}
 
+	err = ipgre_netlink_parms(dev, data, tb, parms, fwmark);
+	if (err)
+		return err;
+
+	/* All attributes parsed here have been validated, we can change @t. */
+	t->erspan_ver = erspan_ver;
+	t->index = index;
+	t->hwid = hwid;
+	t->dir = dir;
+
 	return 0;
 }
 
-- 
2.55.0.1032.g73a4cd73de-goog

