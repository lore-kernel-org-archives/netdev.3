Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 267F64BEE41
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 11:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790077174; cv=none; b=SVlhd7pCZrYiyqh2prtXQFqbnioqGgGzwbwN4SMhCDDeRl97HzeO8CU8/2k0+03M+lH08NgdjB+zb8spHzFpWhIqAquJaCxsMmBAJRb5s4i+EuHK+tqY4u2yf25qv8gLNMEQWg+kTl2DS0M3zHn924Sfpxgbt/sGE4PC0D3pcXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790077174; c=relaxed/simple;
	bh=9Yzl/8Ai2Uw+XgFn6WfidbnPUjHCcwHFWODjayfTG2Y=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=pZtIp9CZLu2meiKm06Q82Rm2pAGWFaaSqc9Oxwnxm9t/n3a8/s4NLSZAE6sTCsN6SEtwcKiHT1ayeZYxtTOoJW0C27hVZxJ9G2QuqsLpOgd5uwThFavUWbPCdV3eiU2BhhWjLnqLnfLCplYHiXL9KZN7N/gaD8uOEe13JOMaiWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rgsxX+R+; arc=none smtp.client-ip=209.85.219.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rgsxX+R+"
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-90cdc69a7b5so85083016d6.2
        for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 04:39:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790077166; x=1790681966; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8IaeAu8XdRPbvC0+Nqs89s2HqZ0xwY5fh/h0Cknh/vg=;
        b=rgsxX+R+wBZvDJoYIrr8UWgJ1GvbMT7mrC9qdu4Oa04RFmziQB3ZDyjvP238AZ/BZT
         Pg/n4N38nlNVVGdZ7UgE8dFLGBY/Z96Fk8ftqHglBpx8lNkVajvubhAkOPnJHouDig4U
         cXybj6WnBqMHd0IcKPdCD25CH7a1Q+37jWqRi60O01pTipzQTan+qYiAoCVG93VnfxlR
         0ASmiqiWamNB1jc2nkWUkAiJV5P7kWxDV1c2dicrrlbfpakaexdpN/r6x6ugUCuaxVoD
         IapJxrmApz6Q0OXAFpHwMtMgqT2Q2ddxLGkVXpUe0evVv4ENqckcEVv0UC9/Oy/nMY8M
         Ccrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790077166; x=1790681966;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8IaeAu8XdRPbvC0+Nqs89s2HqZ0xwY5fh/h0Cknh/vg=;
        b=2dGNziNoG7EkmlxwTkuWjOxLV/Yawv4oGSyG9IRkXeuNDe/xiefpgTnCDp7rClLsGc
         NFjpm4AeuD0ZPXHEdC5KM+WP/w/Ym1WavFrtPHRjkiEwrHWk2iBnIM0KHRq20Q6aJXsJ
         cvcVPRi+3WQjKDIZF2C/y3sitrfDA8IsZ2S0rekVVULjBIZist9XgoRw2aBQuSntLw58
         Zqid5Llsb9zAC2jWoANY7dRYAyXsSr788O/fD8v26Kns9/ZTeMYvKZzlhxufwlQ4M37n
         BhJ1tEoNT3IPP5RQ4vdLoU8OeVzeIbALhz/Jd+4JcwPTzG8ZAb12987CdQps0lJr0HvR
         HBag==
X-Forwarded-Encrypted: i=1; AKwUvBx9m/OIr1/CVB2VY8GYFmQHxwKIbNmoMX2wYsVxVnkUQyRl0X8o9YqVbrUXAZhNCb/j3QGwvGA=@vger.kernel.org
X-Gm-Message-State: AFuF++khCvedFXwp/yvnRPKHZrjkrOR56Qvob2SZHLpFBKHYXjIOqMi6
	VBYH2GuF7PugoyLA8GRNGwRI39yjmb6t2s/QQxI5XqyHHfHGFBRid0Z71U37BrXotgN28+HnVI9
	Ox2AYA5tpsEzJ2Q==
X-Received: from qvtm3.prod.google.com ([2002:ad4:4483:0:b0:90b:56ee:e4db])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6214:625:b0:912:517b:90a with SMTP id 6a1803df08f44-913fc97a1bfmr52246706d6.41.1790077166088;
 Tue, 22 Sep 2026 04:39:26 -0700 (PDT)
Date: Tue, 22 Sep 2026 11:39:24 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260922113924.3165190-1-edumazet@google.com>
Subject: [PATCH net] vlan: ensure sufficient headroom in vlan_dev_hard_header()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, Zixuan Chai <petalzu987@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Callers that only reserve ETH_HLEN or less (such as llc_alloc_frame() or
br_send_bpdu()), or skbs allocated before dynamic device/headroom
changes (e.g. toggling VLAN_FLAG_REORDER_HDR or bonding/team switching
slaves), can reach vlan_dev_hard_header() with insufficient headroom and
trigger skb_under_panic().

Use skb_cow_head() in vlan_dev_hard_header() when VLAN_FLAG_REORDER_HDR
is not set to ensure sufficient headroom for the VLAN header(s) and the
underlying device hard header.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: Zixuan Chai <petalzu987@gmail.com>
Closes: https://lore.kernel.org/netdev/cover.1789987105.git.petalzu987@gmail.com/
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/8021q/vlan_dev.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/8021q/vlan_dev.c b/net/8021q/vlan_dev.c
index 2859cbac3f266b7c4e3f44f41280d33ab69c5270..3598ad0779f050d25c6110de476fe9613137f983 100644
--- a/net/8021q/vlan_dev.c
+++ b/net/8021q/vlan_dev.c
@@ -55,6 +55,9 @@ static int vlan_dev_hard_header(struct sk_buff *skb, struct net_device *dev,
 	int rc;
 
 	if (!(vlan->flags & VLAN_FLAG_REORDER_HDR)) {
+		if (skb_cow_head(skb,
+				 dev->hard_header_len + dev->needed_headroom) < 0)
+			return -ENOMEM;
 		vhdr = skb_push(skb, VLAN_HLEN);
 
 		vlan_tci = vlan->vlan_id;
-- 
2.55.0.1082.g2b9226bbc0-goog

