Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1DA74BA9E6
	for <netdev@vger.kernel.org>; Thu,  3 Sep 2026 14:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788445940; cv=none; b=U+JRiWMczH/1WmdyE4ICtlFW/dJPfpjdLs8CyH/7aJo7j3udjByB8XF9pHhGvHusYAmkh+5CJNTy7PRQDIprjMefLUDVN5O8aebC3oaVlho22LseLSbgeglTS/sRp+SAobg5HRbBhR9ywlfHB1FUl2LNNAcagVZJIBpNoYxey08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788445940; c=relaxed/simple;
	bh=SxImGqPf0zfqDmVkBuiZjei+0XPbUZkCD0Ehro4yeHc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M7be1YQzEQLxmeAs4RIw2eLZopJ0zn8fI4efetpgBHJciBuGOmiydKqe0Am12PmKMHGvtvVsovbzv4GhAxk8CbX3MVIPP/NbgltNiucSJ5ja2WSKmoA3gRYD9xhZF8exU6UcLTOw+IqYz+8BxPVwT0UEGcctHT+tLnV3PHCKyTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=mdegYEZs; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="mdegYEZs"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4956869750eso17307375e9.2
        for <netdev@vger.kernel.org>; Thu, 03 Sep 2026 07:32:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1788445933; x=1789050733; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RIFTrDCPgDQphKZqho55YQsD68R4VC9Mx+L02Osc+Z4=;
        b=mdegYEZsB047tWWlbYGm2etGo3W0SyqUcKJHb8ebC/9hhIkjNP+2GIMLWPEa2ETZaf
         hUr8bRoXDw05VmXNxZhGI30nFxSomDGpdeiD6zT8VmW8fIHGwI3SWAc3Umyg51be4EzK
         4Y4UuBNQztIrJF23SPeZ8o8DZys3KSJa7zPubm7YF06RrDiN2I56tgeapU+k3vhPDj6D
         Na3q09TY2ycwok5xbAU2WjSx/CSL5pxcbarYBIjETjs8S7gy0PjWCzg4hwNQJv2Woeos
         iAy38147KRPs1xGAp33LxeoAJYLjSzUUz12V6GCtFQLkvKKYzY0Bp5Pjf+Gh3bQmzjs1
         jWXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788445933; x=1789050733;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=RIFTrDCPgDQphKZqho55YQsD68R4VC9Mx+L02Osc+Z4=;
        b=OngMGbS8prJeMceTqntvAlY0XZ1CaGZGavzBRcakKZ6NfQ//ckeVfIetn9t8LOrXcN
         KpPSPR1qj4nF0rjk2uPik1Ft6SZf3ByLAhycX/9dnP604jx8nxqLJ3IoSkWM+Zx9qox4
         FM7Lj/yxb54lxrYuD1RG7Fwmnw4hW3Gfgbn94QbMIK/4fUnD3ro0wgLoYk9z6s6l8bGc
         5Fla+2SuXOuQxk94APWm/cR3kIeyBOXebUD/8a85lS9O41iuO0cFxRgk0bdW84DySMQf
         LB7Az6HATcA5U5AhvxUAsTPx/uPXBzNJMAteOEdF3Thf1Bvv4/deQBngckplm1qWSPHV
         qYiw==
X-Gm-Message-State: AFuF++mMEIuUV0nKo4cS22Y6+iMoly7yvN9PbOuN5+vgCZMuMSaUtbNV
	W5f5zX6f/y7/sVKjgYuWsYa+1gSfP1RqCeu3rt7J6AK+nr8x2i+VnwAOP8NTWZAg5BCsqFVpAaH
	AvuXO0UQ=
X-Gm-Gg: AYBFou2BRq6zGs4092h9091Bn7aJiSx4OqG+1VZxUwmIBni1KacAVVKd1ZGg2t3lA6w
	Eo+H3k8v9jbvKRn39yr4zYA9Hhby1vjh58qYRYERBGcM+7FjeaowPaYkgHTFCXnGlkNvReo/Bhg
	+xP9otIrBXU+uoJZXYwQFVCPpSXXdKfHOR/73C5DukeP4iIYAiYIfZg9fTRMmA7xgBmQ8BkxsXi
	3nIoo7rLNbcwbi9YA+zuP3h7W4YFJMMLzMV5QwyD8Kfj9xNlQ6IUeMjtISdcnbEukz192AfESLu
	EemkbF6DHSp0AEgru+fnvXvtCRaOkZ7s0Wuab+uhmCHj5/DkPiyhh9j8544A+qnslJQH5wZ+4wf
	DB4uMeo83pty9Z/CziQa4sIxyS9hBqAgoZJxaqTcj2GVhCEs1h6VvgLIntHDJP2vTDnwkDMtC5V
	AlHBpPbWrlYMdXQdkOb7ej7s0vqzzHac/5qMAxXBtd89tRp7av4doJwbN8WMBp2DvnAkYFEAG5B
	9b6TJPfPpw=
X-Received: by 2002:a05:600c:1907:b0:49c:ee08:6ed1 with SMTP id 5b1f17b1804b1-49cee1d993emr123427045e9.5.1788445933421;
        Thu, 03 Sep 2026 07:32:13 -0700 (PDT)
Received: from localhost (78-154-15-182.ip.btc-net.bg. [78.154.15.182])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-49cee5dec54sm90165335e9.12.2026.09.03.07.32.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 07:32:11 -0700 (PDT)
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
Subject: [PATCH net-next v2 7/9] net: bridge: vlan: annotate lockless use of msti
Date: Thu,  3 Sep 2026 17:31:36 +0300
Message-ID: <20260903143138.1574598-8-razor@blackwall.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260903143138.1574598-1-razor@blackwall.org>
References: <20260903143138.1574598-1-razor@blackwall.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Annotate data races around vlan msti field, it can be read lockless.

Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>
---
 net/bridge/br_mst.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/net/bridge/br_mst.c b/net/bridge/br_mst.c
index 95e49ec8065e..76a5bf287578 100644
--- a/net/bridge/br_mst.c
+++ b/net/bridge/br_mst.c
@@ -123,7 +123,7 @@ int br_mst_set_state(struct net_bridge_port *p, u16 msti, u8 state,
 
 	err = 0;
 	list_for_each_entry_rcu(v, &vg->vlan_list, vlist) {
-		if (v->brvlan->msti != msti)
+		if (READ_ONCE(v->brvlan->msti) != msti)
 			continue;
 
 		br_mst_vlan_set_state(vg, v, state);
@@ -176,7 +176,7 @@ int br_mst_vlan_set_msti(struct net_bridge_vlan *mv, u16 msti)
 	if (err && err != -EOPNOTSUPP)
 		return err;
 
-	mv->msti = msti;
+	WRITE_ONCE(mv->msti, msti);
 
 	list_for_each_entry(p, &mv->br->port_list, list) {
 		vg = nbp_vlan_group(p);
@@ -249,7 +249,9 @@ size_t br_mst_info_size(const struct net_bridge_vlan_group *vg)
 	sz = nla_total_size(0);
 
 	list_for_each_entry_rcu(v, &vg->vlan_list, vlist) {
-		if (test_bit(v->brvlan->msti, seen))
+		u16 msti = READ_ONCE(v->brvlan->msti);
+
+		if (test_bit(msti, seen))
 			continue;
 
 		/* IFLA_BRIDGE_MST_ENTRY */
@@ -259,7 +261,7 @@ size_t br_mst_info_size(const struct net_bridge_vlan_group *vg)
 			/* IFLA_BRIDGE_MST_ENTRY_STATE */
 			nla_total_size(sizeof(u8));
 
-		__set_bit(v->brvlan->msti, seen);
+		__set_bit(msti, seen);
 	}
 
 	return sz;
-- 
2.47.3

