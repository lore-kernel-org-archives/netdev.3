Received: from mail-lr2-f10.google.com (mail-lr2-f10.google.com [74.125.230.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26E6D3E8685
	for <netdev@vger.kernel.org>; Mon, 14 Sep 2026 07:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789372601; cv=none; b=oRis5+8shfvj/xOsw9IglxoVgocXS0ZtpFkaG7u2aWFlpuNfwFAkz1DITtBLHAUm4znquKZ/O79XiEggi/IjGqFSGVbunjgeDlpk0We1HmzINySxebFyaHChWE/SC4Ppwm6UVz6ZC2lMNHg4Bsir+gweOBArO0nI4LmXHoHjpHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789372601; c=relaxed/simple;
	bh=YA/Zt5Rp3A+cv1udmI30pynM10rZrp/ZOB5JXnp18OI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SSNUQqd4adx4dYes4sTdLd7EAs7gYWubw7DRcsoHFxQPGLHzYS2xA2tNBpGgDib2X+vfhFCfG4MVetvv6TZyxEiM45i32CiDH4JDiXQgt2NVx7Uu75PtKn07B2rduhCGDnoZX2GIubrNT70lvsmhtGpTdMXxQcXXSpF24msvQGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tNLIjZOA; arc=none smtp.client-ip=74.125.230.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tNLIjZOA"
Received: by mail-lr2-f10.google.com with SMTP id 38308e7fff4ca-3a34f24f409so16219471fa.1
        for <netdev@vger.kernel.org>; Mon, 14 Sep 2026 00:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789372598; x=1789977398; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=4SXkJ61xh36bbhjQO3MwznVY3pjw6v2KKNzzDKE9IK4=;
        b=tNLIjZOAhhx7LnwZ8WXXw8zGUA4ITwBbS3XntzmrTulikKKtWFCi+kqbxz4jdNheFI
         8o72cSVGde9gDYASAGIpjf1sI5M3ekiM+OPohDYo7YQOYbBwd+rxmtYetld4XK1nt9lZ
         d50lUH3FuYtWHNyauwYcF2405D0Ukq/3ltGetcjt5bqscDcMnkwkumwhHe+RzSeOgLC6
         CnjqKPL3Byvh3wD24Wqu4KzKhEK7ms6oPGMJ4aBdSQYvLcQ40GucAgkFq5HIvMSqSIuA
         bsvSHaxB+BWe20Wde8EG3veecIDUvcvSLzDKDEHmYYDXDjPQ4KAUNcWzAF8j/Hxt53dy
         /GSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789372598; x=1789977398;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4SXkJ61xh36bbhjQO3MwznVY3pjw6v2KKNzzDKE9IK4=;
        b=IqdjDkoN4x1uy1nEBGV08kF7qyk5h2krx3gyygZEZinu/Gruey+rPd635wsyNDWAFt
         WAXDUL8qLh00+SRgk11lR3rZjnp16rP2uHpq3D+YXCgtzN5+5Z1XqReJptzN8TqcqMPp
         NHRkT1jkuKBoKVrz/dqfssHVl5xppcgbF0Z0W4gfb8lZVyltzbOcguqmICtNOagPZ5Xs
         Y0MqKf88g3gDKGetxcQVJ5HvaHHaSKVyZDZInKGzlad0jfFyiNvpYV3oU5GTcRIOdVeD
         bbA56kbP73gxXwcSK+FChlG8WOhM8l4oDrK3BcI12v+nDm+qCwEmcgx1SCiy19tQVHZr
         kIeg==
X-Forwarded-Encrypted: i=1; AKwUvBxhsKLSRATq9qInEW0YChjUfnS0ehyvbobiiWr6lQVcVhJN6y0vyWskCG3fGkYev84r9V1gcxs=@vger.kernel.org
X-Gm-Message-State: AFuF++nIwDbl623maR3PzA0y/B24/IPzz+FVnM0PzVx7JR9AbIDSLwEy
	rtVqE1CWiUsRgyCpKwLwajgwuBjORfUlixh7j+1CO8B9FWzYGM17m4g/
X-Gm-Gg: AYBFou3vQtXSL9aiJDW49iN56NW8VgnCsfZDbgDhpkryhGzoFVdEsgT4oriBZWHsUje
	coIglz5brGdq5inzdpTiERGh5eD3hA9ZFMDaQfbXlcmNvwS6kh6quIPxr+mrnr2gMjQzwVQ8K4s
	kXNsZXGzsQM3lMHlnmiYh2EtncpgPN9vXvNbsjt5FsqExWKhmbMkd9ymVMKlH6QE9I1Ajx8ur++
	Rhqoip3DTV7NnlNUL5B5Pru9wl41KTIZBnx+iqm3uUCON+7AjbDkSayvz7Iocf1D8HEAgtB2BNb
	peP7Lm5PU3azWqfAwzA2gaIR+ntC357UhfA3fXPTWiwW3vdYslvkCm/PO/A+iJd7/fGtUOJ2sia
	kqnBmSlrW8AKYXWtbFV3mryxHeHOkbT2x5K/oRQ804jXaG7csL1dug719MAMcOvBUzOa6nVA1Lk
	R2YfKt4tINGGTCmb5vIC12ZSQPm0muHjkzfXBMXaHCL1/n+G99JHURDt/hPraRUZzi7IBNyOoB3
	APs15ynDI/oXBaefaf1MzxzXQ/g
X-Received: by 2002:a05:6512:1241:b0:5b4:ac27:6bb0 with SMTP id 2adb3069b0e04-5b8ae6b89famr713138e87.25.1789372597734;
        Mon, 14 Sep 2026 00:56:37 -0700 (PDT)
Received: from localhost.localdomain ([78.40.184.2])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b8a047113esm2231327e87.55.2026.09.14.00.56.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 00:56:37 -0700 (PDT)
From: Roman Demidov <roman.demidov.nn@gmail.com>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Roman Demidov <roman.demidov.nn@gmail.com>,
	Ilya Dryomov <idryomov@gmail.com>,
	Xiubo Li <xiubli@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	ceph-devel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
Subject: [PATCH 5.10] libceph: Reject monmaps advertising zero monitors
Date: Mon, 14 Sep 2026 10:56:19 +0300
Message-ID: <20260914075620.11202-1-roman.demidov.nn@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>

commit 40480eee361ed9676b3f844d532ac28b47251634 upstream.

A message of type CEPH_MSG_MON_MAP contains a monmap that is sent from a
monitor to the client. This monmap contains information about the
existing monitors in the cluster. Currently, a monmap indicating that
there are zero monitors in the cluster is treated as valid. However, it
is impossible to have zero monitors in the cluster and still receive a
valid monmap from a monitor. Therefore, such a monmap must be corrupted
and should be treated as invalid. Furthermore, a monmap with a monitor
count of zero can subsequently crash the client when attempting to open
a session with a monitor in __open_session(). This happens because the
"BUG_ON(monc->monmap->num_mon < 1)" assertion in pick_new_mon() is
triggered.

This patch extends a check in ceph_monmap_decode() to also reject
arriving mon_maps with num_mon == 0 rather than only with
num_mon > CEPH_MAX_MON.

[ idryomov: drop "log output for unusual values of num_mon" part ]

Signed-off-by: Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
Reviewed-by: Ilya Dryomov <idryomov@gmail.com>
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
Signed-off-by: Roman Demidov <roman.demidov.nn@gmail.com>
---
Backport fix for CVE-2026-68155

 net/ceph/mon_client.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ceph/mon_client.c b/net/ceph/mon_client.c
index e1f01aef263e..fac52fe7a587 100644
--- a/net/ceph/mon_client.c
+++ b/net/ceph/mon_client.c
@@ -59,7 +59,7 @@ static struct ceph_monmap *ceph_monmap_decode(void *p, void *end)
 
 	num_mon = ceph_decode_32(&p);
 
-	if (num_mon > CEPH_MAX_MON)
+	if (num_mon == 0 || num_mon > CEPH_MAX_MON)
 		goto bad;
 	m = kmalloc(struct_size(m, mon_inst, num_mon), GFP_NOFS);
 	if (m == NULL)
-- 
2.53.0

