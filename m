Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 410573C09E5
	for <netdev@vger.kernel.org>; Tue,  1 Sep 2026 12:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788264465; cv=none; b=QyWkSL8v8jGhZVdM3+F5+P6rqWbNVQYwotqlpPxCuDu9MUMgFTB5hDUbFtKVPW2bEZp6ULfYs7VXNMl6/m3DccYfCtI7okWmZ7cWwI7+vR3IC+WEaOpR3OQ7XHWSTRTJkghojr+RCW6fqW8XsjniW1lkFjgbEoG0bnT/XDhglAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788264465; c=relaxed/simple;
	bh=vDHm7CkTNErA2+VH4D/qGhWbmoMxmNZSOesyPx+peIM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qnItp5/upWgSvrpVDdge4e4dtg/x4X7G0j8WpFhyrjDLCQyR8Go9WYK5HQ6CpyLfribqtaiwp5OGHe+lAcEMPgwJrQPtQzhTWyBXTQUH7TJMrgUgXjfnsMDZF/xoYU+LfW8abVIYXwF5hnvmel/bValGU1u8o4bb6Ckoj4r4OXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=cjiMJ9Mx; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="cjiMJ9Mx"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-49b8e527d63so8931925e9.2
        for <netdev@vger.kernel.org>; Tue, 01 Sep 2026 05:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1788264460; x=1788869260; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=R+TeBJucdheuLQOVi4XpjZrYuesJgF3ndjF41LXDZJI=;
        b=cjiMJ9Mxw6Joo+F0MsX0vqTp+rQb7XCt4peRHwbacc/+YWbLojdsvMCxhrcytNFMnA
         l84bR58fKaKdxzBgcf9e38PfGcmK7Vpjroqx2I07h7IDkUGebBmp7r7jNHTzxaB8/eNh
         xWtM8G4ucRIK5IT3dgq/vcoZZRgTOECCMtBBBHk0yycMI4z+lKQ+SWj/hNs2gfhW6siF
         9ksis85L9sD+ohLkxG722elMvkubVbSePIlkYu0ih9IASEavEJAco25MEkzNAV8kBAeE
         cP/lTE67rkkrXxgIgkCy1ZNixHmmulXh37XTOjvguKEmXGZNRUlQMCL7z3zpl4AHpKMB
         E+1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788264460; x=1788869260;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=R+TeBJucdheuLQOVi4XpjZrYuesJgF3ndjF41LXDZJI=;
        b=S/motf8XNrr/31L+5GRXqZ2cYAMb1Uevm5VglXhAF4AaGHldTelB5GqxsUEMoPyXGU
         Hl75ylM/RZvApqjdkjEV4pHYQEn4wVYR5+n/yeESKQLNFIIPPv/B4evrqK282IKywAAA
         I2O0KVNDPyocEE69Q4+PrnuBILxJXBT9HKD4Ab/cRZ2qxL55XHTe0L7vSQg+8lGgeXcf
         VxYvEELmq+n62qnpq+L7ft1lRfghVJwix+lYpr3G2D5ZzrBONFfAKfMw9sFw2Os678rN
         WTkwQLqTEmeKTUwyXavByCj8kD1HSEH39zjjS6gZIfKKWhCIEmhab7KsjVZXw87nPtbb
         9D+Q==
X-Gm-Message-State: AFuF++nxDUrPz0uNFN9nsv3qzvgbnEGyCqNwTL2DRCIQjgrCGeKwDT8X
	1hguOm2lpwU9R2tmfrGcyD3rm1eil2e+/wZqpckTtcLKe01CFRQi6PTHFwSunmQE9tI/9DaVhp3
	v3PPuAo6N2Q==
X-Gm-Gg: AR+sD12VFVI/VeeY30OEu3WTgTgrbOzlR0Ble4TrZLtIXqVeLml6Y8Hq/I2E8VhS0mI
	nbluWLckQmEiFm8co/vaa8IG0OCQ+aN5AIuptbpIxdG68rCbP2KPfKjs+C75aIlzNxWmqePO3RP
	c7jFbaKxOlocNDSneuZnfimOHi8aH3PToHEG/7aBkFoST9T4EP2SPhCADPiaGPXc7pNwgDFgNil
	N3k7Oa01lalTNKbNEwnLbflLcRU7LAMN4XuhfVZ3Yh88lfL2x16wNFJRrnEA8Bz1M9iBeYLUlIR
	L3C5Ol/IEnOSweCbVY0/PRZT28RLmo2iLdcTK8MyHd8h6YwPmjdvSCYggc/JIPodTme+/0x7xX9
	WfsPxhs50XPVgx+oVtyt7OiSRMygdeZyy0AjNoewWenBfyZ8JHI5lb0YbfZ8v30n7cJYdtZ9fcX
	q+NpKh1kEK0VmcDZRt6NNCz0hRrjlPj8FAo3fNleRRaYwweYCKsYnyes9kqWmUDTxDbKFDQ3gza
	GG+RdKJ//8=
X-Received: by 2002:a05:600c:4fcb:b0:499:db27:7b1 with SMTP id 5b1f17b1804b1-49b91c62d9bmr504091125e9.15.1788264459996;
        Tue, 01 Sep 2026 05:07:39 -0700 (PDT)
Received: from localhost (78-154-15-182.ip.btc-net.bg. [78.154.15.182])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-48442d78444sm5107623f8f.25.2026.09.01.05.07.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 05:07:39 -0700 (PDT)
From: Nikolay Aleksandrov <razor@blackwall.org>
To: netdev@vger.kernel.org
Cc: idosch@nvidia.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	bridge@lists.linux.dev,
	Nikolay Aleksandrov <razor@blackwall.org>
Subject: [PATCH net-next 3/9] net: bridge: mst: use br_get_pvid helper
Date: Tue,  1 Sep 2026 15:07:15 +0300
Message-ID: <20260901120721.747908-4-razor@blackwall.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260901120721.747908-1-razor@blackwall.org>
References: <20260901120721.747908-1-razor@blackwall.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The only place that accessed pvid directly outside of the bridge vlan code
was mst, change it to use the br_get_pvid helper.

Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>
---
 net/bridge/br_mst.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bridge/br_mst.c b/net/bridge/br_mst.c
index 43a300ae6bfa..95e49ec8065e 100644
--- a/net/bridge/br_mst.c
+++ b/net/bridge/br_mst.c
@@ -86,7 +86,7 @@ static void br_mst_vlan_set_state(struct net_bridge_vlan_group *vg,
 	if (br_vlan_get_state(v) == state)
 		return;
 
-	if (v->vid == vg->pvid)
+	if (v->vid == br_get_pvid(vg))
 		br_vlan_set_pvid_state(vg, state);
 
 	br_vlan_set_state(v, state);
-- 
2.47.3

