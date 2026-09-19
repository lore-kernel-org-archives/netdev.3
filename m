Received: from mail-pz2-f41.google.com (mail-pz2-f41.google.com [74.125.228.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C81437E5DB
	for <netdev@vger.kernel.org>; Sat, 19 Sep 2026 21:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789851981; cv=none; b=Gsju05u+4cv9BwFfCZyeQxKn/a46QZbmnMqTNhWKYfhmOhZO558j0Lb5dlAFuAbIQ8LASi1I3ADFtIJc8KtKL39PG1ZW7QTHCre3ATVQxwHezu9jQ69TcFduYNsjPw38hN2U53n1iiiJ7wqvgT2Kg0z268PHfHzJyII0bFx6jaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789851981; c=relaxed/simple;
	bh=K01J0+xXVljADFYTWuPYsLRrU5TV1hYkYJj++ll833U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=m6o+ihOiX0pG3Xg0FHk6Tqdlcmf10azaINM94RBsHmS8FQcvyWlHptxOWM6e5yIdzfLv4zDhPaHoAszQkT7Y6gbxjyFu/Cd5kB1R3+REQJs2kOs32r0C4fcoTpvm7eCooTKvaDfoURNXJg7vnUZ1xj1csWgFrgyuw0RHKCbln/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IQN0F7N1; arc=none smtp.client-ip=74.125.228.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IQN0F7N1"
Received: by mail-pz2-f41.google.com with SMTP id d2e1a72fcca58-85469a34907so2046440b3a.1
        for <netdev@vger.kernel.org>; Sat, 19 Sep 2026 14:06:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789851979; x=1790456779; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ABiIkd49zAAyEbZWTZaaVGNz6idHB4ipKkUPNXeBUPQ=;
        b=IQN0F7N1rTHK8sh3Ckk4/FTmYqzslcYNA4eDWihzc/J2srgqEqmSseEfLThPPWh034
         tzWwZoS0yydmawvol9R7N7vk5DX6RpeVSfJhW586M2+5gqeN+rIRSbiJJDheiiYxZXH7
         CT6ixci60xa6ocNkA25EfZpJxbKilgWEc7N++F57cLDzDv624sgXJC0HAJKdfvAEqYK8
         7DN+oDv4jVJr2PZNZBk/t33lYvLvO1xnTswASspeUW58c5WKZUnmZgLzLpIzLzGCiX2o
         QCeXTxp4LCNKcIpj1Fz5je9lHamx/HR2f/lVLYx3khZGG1RPsMwQ5rRYZKrEGcXWb3ak
         gO8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789851979; x=1790456779;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ABiIkd49zAAyEbZWTZaaVGNz6idHB4ipKkUPNXeBUPQ=;
        b=P6vcJyXxom7ImGSex0DMoFzzAjpxoPiISMh8ibIvosmuOeVV6Vak96MQXKztz79q/s
         f8pAOGZa6yTJrj1paO2agQCzqaxI/g2nk5we3D2T0fkJf+iCi8ns5xDklObWHX+cMF/S
         j7n59joE+L/Y8mnTqCZ37nh0TkxqdkehsDN0F+YHen4CoLRS08JAECwDOUDH/dgM2C/L
         u2oQFEhn6SoZMzQIHV5hVVaf+r6RkGrKzBUIEX3tGgdrT7jK7r6NpM9gZVzWTRwVmCSM
         7rPwpJmTg2bf1DnJtUll7/qPhtdTvb5L8pE8tBED3caTYHOerh9qenzgqJ+07zOeU+Bp
         lIAQ==
X-Forwarded-Encrypted: i=1; AKwUvByznWQPScmX6c7XvSyHIasj/+K1mQLpieFaMNJobv0+E7OccLqL4Fe5ce5WzZJzxg1iqId+J2Y=@vger.kernel.org
X-Gm-Message-State: AFuF++k3vU5QnFRYXHrOnmiLYgIi0VXDz4tjP4Mi5uwu5OBWg3j1xjcp
	EAwOGvDblazz+0cqKqpLksqzxiYxn4jC9wNpiRs9Bd+zdwluLlB+ACSd
X-Gm-Gg: AYBFou3h9lBi1rGVf5R7DynrEJFJrLnoTNRkrLko/tL6eYFXm8RFTUy7yZRPwroPiRq
	CSQS0HwtfdJQh4jCrvCvw0Yt9WQxgXOd/IpKblJNr8ygNs7Wo6HjSRa7G6HCehNSUbf6kP8A/F3
	AESW50hnKt+llnWaEbrewEnwTzyzjPtWKCKbWwt1VDRvnVkrExHaqkL37Nz+Xc99Wp8rVlJp2uv
	d24+G4ny2rfvrXoYxsqD6LvMw1F/fKoh6ugPolM4duDnvRsTiaNXQ8k+Xx/05/2Aw4mMrGwDrLR
	LOspxSCveUL4Ny4CyHtj00O5XQorDkhYU+tRirX93/xb2S4Npj1Cs1+O7M7ItPFKoSZOAdTdPfd
	FM7qoK5spZiolmOJ71VNlLrUGBXU3d6Vgy09uHMC8Ee3SQj2zgGigQ6fMwxVcjOv+KOa1EOnVFv
	SCIH0L+MntyMX+u5E6JBoveUO8j67C4Z0ch6102OLJb7j80wmE+a40yKzXj2o7eokTfF3x1XEKZ
	8hgVRpKLTK6JgZlQUPDS+p6A9uoGeMVcyiQ+PVHcSjljRsZaP9FBF+aLQFg/murHkw7Rz5bdYC1
	ASWoH1D7qA==
X-Received: by 2002:a05:6a00:4b14:b0:857:7337:5db6 with SMTP id d2e1a72fcca58-874dd9f2458mr9704543b3a.20.1789851979438;
        Sat, 19 Sep 2026 14:06:19 -0700 (PDT)
Received: from phui-2.c.googlers.com.com (78.123.83.34.bc.googleusercontent.com. [34.83.123.78])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-877a95f2500sm1277466b3a.30.2026.09.19.14.06.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2026 14:06:18 -0700 (PDT)
From: Hui Peng <benquike@gmail.com>
To: dsahern@kernel.org,
	idosch@nvidia.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: alex.aring@gmail.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ipv6: exthdrs: copy old IPv6 header before skb_mac_header_rebuild() in ipv6_rpl_srh_rcv()
Date: Sat, 19 Sep 2026 21:06:18 +0000
Message-ID: <20260919210618.3028986-1-benquike@gmail.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In ipv6_rpl_srh_rcv(), after pulling the compressed RPL SRH and calling
skb_push(skb, chdr_len) to expand the buffer for the decompressed SRH,
the function calls skb_mac_header_rebuild(skb) BEFORE copying the saved
IPv6 header from oldhdr to ipv6_hdr(skb).

When chdr_len - pull_len < skb->mac_len (for example, an 8-byte
expansion with a 14-byte Ethernet MAC header), the newly rebuilt MAC
header at [skb->data - skb->mac_len, skb->data) overlaps with the old
IPv6 header at [oldhdr, oldhdr + 40). Calling
skb_mac_header_rebuild(skb) first overwrites the beginning of oldhdr
(version, traffic class, flow label, payload_len, nexthdr, hop_limit,
and the start of saddr) with the Ethernet header bytes, and the
subsequent memmove(ipv6_hdr(skb), oldhdr, sizeof(struct ipv6hdr)) copies
those corrupted bytes into the new IPv6 header. Moreover, oldhdr's
nexthdr is only updated to NEXTHDR_ROUTING before the pull, which also
gets clobbered by the overlapping MAC rebuild.

Fix this by copying the 40-byte IPv6 header from oldhdr to skb->data
immediately after skb_push(skb, chdr_len) and before calling
skb_reset_network_header(skb) and skb_mac_header_rebuild(skb), and
explicitly setting ipv6_hdr(skb)->nexthdr = NEXTHDR_ROUTING.

Fixes: 8610c7c6e3bd ("net: ipv6: add support for rpl sr exthdr")
Assisted-by: LLM
Signed-off-by: Hui Peng <benquike@gmail.com>

---
 net/ipv6/exthdrs.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/ipv6/exthdrs.c b/net/ipv6/exthdrs.c
index 09a4552f7f08..f9563294c5b9 100644
--- a/net/ipv6/exthdrs.c
+++ b/net/ipv6/exthdrs.c
@@ -598,11 +598,12 @@ static int ipv6_rpl_srh_rcv(struct sk_buff *skb, struct inet6_dev *idev)
 		oldhdr = ipv6_hdr(skb);
 	}
 	skb_push(skb, chdr_len);
+	memmove(skb->data, oldhdr, sizeof(struct ipv6hdr));
 	skb_reset_network_header(skb);
 	skb_mac_header_rebuild(skb);
 	skb_set_transport_header(skb, sizeof(struct ipv6hdr));
+	ipv6_hdr(skb)->nexthdr = NEXTHDR_ROUTING;
 
-	memmove(ipv6_hdr(skb), oldhdr, sizeof(struct ipv6hdr));
 	memcpy(skb_transport_header(skb), chdr, (chdr->hdrlen + 1) << 3);
 
 	ipv6_hdr(skb)->payload_len = htons(skb->len - sizeof(struct ipv6hdr));
-- 
2.55.0.1082.g2b9226bbc0-goog

