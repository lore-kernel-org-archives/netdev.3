Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6679E3E00A5
	for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 05:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792040832; cv=none; b=Nas5crk5za9Oo5Meq9mM6s9f88Av5UpkfOTiGWJB+sF/UxIalpoji6QSLPzeocwv2GJzGJug0AdlAYF6pVbGa8GYfmf/ppFwKtUIA0ooX45Up1AKSgszcjgRKH6k+AmtIY4w2VRQqVdcm7Ybm6LpZbtvYVHTeKNGfytKVnOXZOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792040832; c=relaxed/simple;
	bh=7LoSF686mLrWPGZTio75JTRXruj93Qwxl1zG32Ekw5g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aiMeXP/ivHiQtbeKL9wyUboyCea51E6TELbQOSurlyE86LWCMVi9fbI9/IFZUwMfxPv/fbHArULksDyFa4eH5DarJYrZinwS2/C85KSDHp9uHa3u+8B9LeSvSWX6aUw8tqzV5Q/KZomj5fyUN5nUEw1DX7eNyI5TiF5sAkLWCbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rtxB+Xhw; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rtxB+Xhw"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-398b3c37877so2448313a91.0
        for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 22:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792040831; x=1792645631; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WgOhoN5/U80fCOgOhVFqKH9UM9LLPSaTXFuvuwFPfTA=;
        b=rtxB+Xhws6zTminN8LgemImF13h18rSjbCRxIHhTECh5g8LoLF6WoiFm3rqcD8Mv15
         yfOpAC4gCJyMLDrIzz8UG1Kq4DTt2bQor4PFWe0t7Oqr7cpla2hOq5IAiy2S0swUYKhf
         92HSQF3Z8slclnfM7ewsJb2LBAuCuALX33SS21K7/KQEiOXe/HkC+aQJKC7Twgs6RGC+
         K4Ix91P3zEguHsov0foboJzHqa+lJSuuw1kMd+gyVxCGeIlEkO6S/7Ts525HJ6FsEzw1
         phrEdIW+Tq6TqD+DRIA5/IdA9vIH+euqjGnM6bcK3+X2H8lE3sflCDICXAAZ9vwU22Mp
         6ddQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792040831; x=1792645631;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=WgOhoN5/U80fCOgOhVFqKH9UM9LLPSaTXFuvuwFPfTA=;
        b=MboBnNXFl54PC9TDU9V34xMfPHVH041rnOIdeQdtwkCwcgFi0r7LdYrKAUJmtANCU1
         2Vx11A/TNFJmyibVSxpNa86kVA3q3QLHT+6jBU4hFhGLn7ynJAGVE8McbDOqyQ+YEzLR
         RPPufVxoxZoONG615g/GXdRim2iln2o6Ozyr1o9oAyMA77KcqatwTMBIfsWxoruzHOJA
         WPWhC7DtEa1Qgv2fedLD1rv0w5zylsyHz3Br5RKoHmPTYQAAXjcweZxfvLQbOFiLJXo4
         uzv3LjW/zsaA9/biwpl0T5Jo61K1qwiG9rZdEfAwkODRJQhynpowndw48ftz4zeDwG4/
         M57g==
X-Forwarded-Encrypted: i=1; AKwUvBw6KMxzufdEHp1z4nbonQWHqdJpc+81uYpIXpMwR82V1iQu/UgieOLlGTebYC9cEGFetlZNQ4I=@vger.kernel.org
X-Gm-Message-State: AFq9FYKjmo9CqlVKFWl4IUyBTwgn8I97KK7Y80PfVWex33WOnTK2dRGX
	52kM3z6eGCzOSQhkce9Hf9z1hXJpw1egpYE9gIRGZatiQBBUUrivUcoi
X-Gm-Gg: AYBFou16lecwDYtdJD95h+odeKPSPCZYX1z+QGxYQ4h0iMmy2EFDhX8s4AD1Y+1vRFD
	9ZACOmkdCvMlo6sG3d5gPEV/jtrdeN+PK4aHrfhKLeMwknhSSqZ4x+KgHNSU3HO1hDIzXmy7nwK
	FFDv7Nb7EwPvktJdffaaSNPEdu1M2s0lPgPtMkyJua19yEiiMNYpPocuPx73MonRP2QieJBr3iy
	2ByErtKv5Um4wcklZqic/L75jzucsJJNGHTAvM1whJ0ZoBBQIAjP8HFDyg3PYSNS/13OwN9zpyr
	h5Zu+qbPpqy+/WrliPkopOxrkL8579U8baPv/g3i7Oo1vsxtV2PZ3MWA49Squ43ola+/CUI2psl
	sStqngPfm/MpOlgMwxn3ho31wfAVdI36QZEIVtjbzku5MvOGjjY1rx0Jpy5mqDnqtohRRXfIUav
	ZZ5p+82iQrn7PqjgShA+qz0ne31TK4EbmF9IB2dTLM/2/oLSvbbttFh/QHC2dYXZQVtWBGKAfJJ
	dlJPyoIk9o=
X-Received: by 2002:a17:90b:35d0:b0:3ac:450a:fa22 with SMTP id 98e67ed59e1d1-3ac450b74ccmr6062336a91.2.1792040830612;
        Wed, 14 Oct 2026 22:07:10 -0700 (PDT)
Received: from ancienth-X870E-Nova-WiFi ([125.186.72.2])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac9449ae48sm2548033a91.13.2026.10.14.22.07.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 22:07:09 -0700 (PDT)
From: Daehyeon Ko <4ncienth@gmail.com>
To: David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Hannes Frederic Sowa <hannes@stressinduktion.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Daehyeon Ko <4ncienth@gmail.com>
Subject: [PATCH net v4 1/4] ipv6: remove ifaddr from hash during ifdown list cleanup
Date: Thu, 15 Oct 2026 14:06:48 +0900
Message-ID: <20261015050651.1841557-2-4ncienth@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261015050651.1841557-1-4ncienth@gmail.com>
References: <20261015050651.1841557-1-4ncienth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

addrconf_ifdown() clears the address hash before snapshotting the
per-device address list. A concurrent ipv6_add_addr() can publish an
address after the hash scan and before the list snapshot.

The ifdown path then removes the address from the device list and drops
the list-owned reference while it is still linked in the hash. Once the
remaining references are released, inet6_ifa_finish_destroy() warns, but
a DEAD address continues to kfree_rcu(). The hash therefore points to
freed memory that later RCU walkers can dereference.

This follow-on was found by source review and was not separately
triggered at runtime.

Remove each non-kept address from the hash immediately before removing
it from the per-device list. Keeping it hashed through the delete
notification blocks same-address publication until NETDEV_DOWN has been
delivered. hlist_del_init_rcu() is safe when the earlier hash scan
already removed the address.

This handles a late publisher captured by the list snapshot. The next
change serializes publication with teardown so an add cannot miss both
observations. Both changes are required when backporting the complete fix.

Fixes: 73a8bd74e261 ("ipv6: Revert 'administrative down' address handling changes.")
Cc: stable@vger.kernel.org
Reported-by: Ido Schimmel <idosch@nvidia.com>
Link: https://lore.kernel.org/r/20261004135117.GA206930@shredder
Link: https://lore.kernel.org/r/179161099539.434549.2238120015372268173@kernel.org
Suggested-by: Ido Schimmel <idosch@nvidia.com>
Assisted-by: LLM
Signed-off-by: Daehyeon Ko <4ncienth@gmail.com>
---
 net/ipv6/addrconf.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index c90ee6dd7446cd..72d7df23f79674 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -4019,6 +4019,10 @@ static int addrconf_ifdown(struct net_device *dev, bool unregister)
 		}
 
 		if (!keep) {
+			spin_lock_bh(&net->ipv6.addrconf_hash_lock);
+			hlist_del_init_rcu(&ifa->addr_lst);
+			spin_unlock_bh(&net->ipv6.addrconf_hash_lock);
+
 			write_lock_bh(&idev->lock);
 			list_del_rcu(&ifa->if_list);
 			write_unlock_bh(&idev->lock);
-- 
2.55.0

