Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D4A54F0527
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 13:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792416145; cv=none; b=HZORbUlkhvdwE7GV86MVYu5oV0eTJUm2AWZKFVj+bqOcN0ZirXfoMqT3PQWvcWPJoDEDHM1+6JiMYMe7du5J3UH1ZdAfmATIOa+UFNbPUoCftn/hUIHE1ocPPRbcFV+tU8sK9wxQvRKwc1UMKS1R/ULDsJvZS3o2nJxNlwKZ3zQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792416145; c=relaxed/simple;
	bh=Y3HX3g0lpxIxkV4ib/pssKJyE3f5VJM5KbpNGYoLHFY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uwHuhEZyhiJ/LNhuLO0bI9lnlHdSVHCLR2YL5BuPQIfbMUtklIS/fCJBbkS1Ko/LxBvZ+875zw1SPNb3p1CiNrhRTVmx7PeE7wug+m8MpDG8XdpnVEh45BCqwJ2JnJJ6eUUEqx5Zq7vWBVSRInXSLIPbqBl47PMbPkkCswo+llE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NGKlUdrL; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NGKlUdrL"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3ab60ff4273so1871143a91.0
        for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 06:22:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792416143; x=1793020943; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=88uXbX/jv9pcVoHDV2x+38VZZBZoNn3Hj1HsL+yQOPU=;
        b=NGKlUdrLZJCq1PJff8YhIzV5SQ7qyIkWuVSnGpcIOe8sJiikFpWAfE7n6xaTDrA0QC
         hLa2t7juvYx6ltqFvb94yjwxuWKF82V97VKVrAOy8D+zQhs+Yx/9g9zyC0Um+qtjqHqe
         Cl5tTOYVBGwkyCMDy8rSsMvsRPKiQ+Z6MsOc2399IEiMKtyqHelfpYvo0OkkFt8rrLM1
         1UBgvsV58h76+npdcLchDBy+Q0rDonjvUT7nQlpz7v02PK/4kGtFJSMdQGN5qxkjfQOD
         6R5izCI4bk8CfkzXw3WHNf63K3SbOsnXKE+GeeZw9Fd5HZOuMQVKegupwVElmS51fKe9
         MbXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792416143; x=1793020943;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=88uXbX/jv9pcVoHDV2x+38VZZBZoNn3Hj1HsL+yQOPU=;
        b=NT94ZnHnxivKPIF8bCUIQGXyhybo+yHrPWDyZUVGEg6FaYXIPRCRGOyrfRETtiwLsW
         sSfpSgoFDuDzH3hp7fmt8ywAxWIv9gm2ctBvBg0T6zLRQvcjf9UPjV9uW+6UVL4qIJXS
         JbtlL3ZSWbdpKfp/tLXIJntYM8U6QltwaQSwRHFq/KGUpQuM7Jk6QfAynlHJ+Rh7aiLI
         WjhpXp5svTBAeDscdO5tX3uY4xo0YmZebc4u0L/Jwt+SnLGf2dBuj96dxTaQimQalQNd
         GLIibxzGLVHz55cBkvYcYnL9merOottOTtJavNA+YXhK4xZ4F3Syx7QBHeY5lyeDy+3C
         6tAw==
X-Gm-Message-State: AFq9FYLUuVRNIZrZc2BoIrFLg1ck3zGKtWl1lWDjGdsc9laVBnBBYKPj
	zY0xd82lE6EgUpd2weSOjtmP3yPp2CXSUIeJWAStuOuOQ9uINeby2MDQ
X-Gm-Gg: AYBFou27hdngaKgaxkRJikWqhf5wApGiphjldY7fC9wfy/I3f57JpBobFjM1vIjbtrg
	r/pH0HMaRKQq4EPMCXiIs3gW7zGP37GbGzKdKX2GPvi2eeelFoHgkFQrVLKDxKUJ9tcMLwOuzcY
	9m35aiit8P8gKe25QTqhMzUS8pgFIh4qqfjIxXAAaq9iNpOYbRYcktpSj9g059LbODM0EBGBTFf
	X1q8RtCYnbeZj83rPDSUkVM6lYdd6jBCVAi0AvapGZnWTN+U+z7koGdzE5T38GsnlGmVsj3QB7+
	DXFckSVU8MB9AM/ss6us4d1YDQinNxvcmuxQZGzpOt6luhppFEjHbFjXUX5+lj6Th7g7AHrruLn
	3FXYX0MhmUZBwpGt4EBXd1K3nQ+l3+J1fhr2BZLzJnLOTaZI4Qdpz85QgVKiig1Vr6olC6OqueZ
	l6qydhXhwRZ+FenVCr3bvWxpTGzEBKsf29TehC5Z4SNupkHZPELKqed1TLNddBbwAmCy3RYU0cG
	7z2LQ==
X-Received: by 2002:a17:90b:17c5:b0:3ab:4f1:4f76 with SMTP id 98e67ed59e1d1-3acef17909emr7226702a91.24.1792416143321;
        Mon, 19 Oct 2026 06:22:23 -0700 (PDT)
Received: from [58.206.202.11] ([104.28.215.70])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3acd3c8e2c9sm6505875a91.2.2026.10.19.06.22.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 06:22:22 -0700 (PDT)
From: Haoran Wang <haoranwangsec@gmail.com>
To: David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, haoranwangsec@gmail.com
Subject: [PATCH] ipv4: icmp: use skb_dst_dev_net_rcu() in icmp_build_probe
Date: Mon, 19 Oct 2026 21:22:20 +0800
Message-ID: <179241614083.5916.6651154069510905781@whr>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

icmp_build_probe() derives the network namespace from the ingress device.

    /* net/ipv4/icmp.c:1296 */
    struct net *net = dev_net_rcu(skb->dev);

The ICMP Extended Echo (RFC 8335) PROBE replies identify the queried
interface by name/index/address and should look it up and apply policy
in the netns the packet is destined to, not the netns of the ingress
device.  Under a VRF, skb->dev is the VRF master, so dev_net_rcu(skb->dev)
returns the master's netns and the device lookup / reply policy run in
the wrong namespace.

The rest of the IPv4 ICMP echo path already uses skb_dst_dev_net_rcu(skb)
(net/ipv4/icmp.c:1123, :1267, :1437), while icmp_build_probe() is the
exception.


Signed-off-by: Haoran Wang <haoranwangsec@gmail.com>
---
 net/ipv4/icmp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/icmp.c b/net/ipv4/icmp.c
index 90c0e22c2..a577dfc65 100644
--- a/net/ipv4/icmp.c
+++ b/net/ipv4/icmp.c
@@ -1293,7 +1293,7 @@ static enum skb_drop_reason icmp_echo(struct sk_buff *skb)
 
 bool icmp_build_probe(struct sk_buff *skb, struct icmphdr *icmphdr)
 {
-	struct net *net = dev_net_rcu(skb->dev);
+	struct net *net = skb_dst_dev_net_rcu(skb);
 	struct icmp_ext_hdr *ext_hdr, _ext_hdr;
 	struct icmp_ext_echo_iio *iio, _iio;
 	struct inet6_dev *in6_dev;
