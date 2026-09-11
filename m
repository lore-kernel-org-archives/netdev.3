Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0DD31A682A
	for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 00:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789085832; cv=pass; b=kRox2NrGdbrGgGnDOeg1dPzHNDLUqbYY/Z7lM8V7+zloy+Mr7UF53chxxY6413Rywii0GD4BEU8jqnRRF6UBiGKWy6uOI6WIo6VkAEB8hWjhhPJMbPk/J2tLdFcsFGBj8PUb3mPPpFrHEV9ZJY/Nlc71ySxqdsjifFN8/uWWhY8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789085832; c=relaxed/simple;
	bh=UhcXak3PP4CSJsJ+2ZmTXWyuXKO/e2C9z0rfeaGezsc=;
	h=From:MIME-Version:Date:Message-ID:Subject:To:Cc:Content-Type; b=ofrusGr58C4Gg6b5D2vP44XFvx+l/sy/QXfzgxQktoC70pBZ3talng/S6GmQoP/8fPQ+dL6VNiVg3Q4EaJ6g4H6fPdHSpe8RWq1Z5Hg78zab5OeDeRVxAlqOFwhlj4YpIB6ZvDg99WDj5dnFTTZOsUGpFaOa9phYlvcFBjTj8wg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=berkeley.edu; spf=pass smtp.mailfrom=berkeley.edu; dkim=pass (2048-bit key) header.d=berkeley.edu header.i=@berkeley.edu header.b=XGSRsjBU; arc=pass smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=berkeley.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=berkeley.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=berkeley.edu header.i=@berkeley.edu header.b="XGSRsjBU"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2d747eb79f7so1572275ad.1
        for <netdev@vger.kernel.org>; Thu, 10 Sep 2026 17:17:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789085830; cv=none;
        d=google.com; s=arc-20260327;
        b=RyJi7MNVUmOHGEMRW5fYlDVsTL10MRKnFwFuur1O6mbV4lYz6Fjvbre0NEsSuRXFUG
         MSSevjE4iF+1nVJCFwxw3mxB/FEG3ti/PvRfNTEBSazUCSM5a1uGtN+7UBlBNQ7r1PLg
         XCKiKhIO40hxeZOloC2ikQZEBqUXZN2FbW716USDyHVgtjy7yhWoPdLQdrZFAI/znwdF
         gqgF3j7TDFhH8SYXCmS/MBCj26w+GXZ8+T0v9zfIaKr5UOI32DKjzlP6cbIZo9jG0J4x
         08fczLNv7O8sDyeMm/tHCUmgZZrdkxS0PNmbAfwcXNoCkyWdhRgQGn9GBbXPY5KTUEyu
         9YHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:from:dkim-signature;
        bh=S44dTWF40G+fGHovL3O3dgYh1dI0740WCQy5o7cAbGo=;
        fh=Lk9d1/9YxqwpMDKd4SnMhCJ8/LIpX09ZHyvwD6M+JqM=;
        b=s4pOEXPDteNcFSIICpIEeH0UGTdwW4SuvTwpBX4hJJ/FNyGuof2sucA10geHxxu2Po
         8cifPE0/b3K5jitpEMuBTCymuT95uzIE8kFOdKKnE7rVM5LkZk0S5mIy1qAn0mbJpG2X
         O2sAtn5A14klfXyiI1j3VRL8GYkr2OUdN/1ZnIBR9HG0t8qDUq4pNM7psbpAxWRrSEKm
         X00AOQBv+pa0rI2m2x4fR8X6ioN/SgoYPDMPFy/Kt881z01mn7PY9IMCuRXl/LLsY8A2
         yMsmOjI4xh8IepubJw/673dD7EguL+hlUUVT9fZxm2TIradLycRcH8IWeZkUugtpWw01
         tLbA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=berkeley.edu; s=google; t=1789085830; x=1789690630; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:from:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=S44dTWF40G+fGHovL3O3dgYh1dI0740WCQy5o7cAbGo=;
        b=XGSRsjBUp4g76BmBhsyD4RnkmKpW1/+QL08F6ioVnKzv/M7EDTcin4QOOsu0JHX2QZ
         VNIVemujvk8kAa5UyYxQ48k9oPl4dA0KQqCjXkN+0UepeXO3atV5i2tpfvZTgPAGcwE8
         g5H5wB7CRNcRk7dWc48nNWf/70rfm8SVMeuVoAEU/biHkzRgslvYlWlxw/N1dqQsNbgX
         WQU0scJ3/C9BTHZzQvABQnWInCjoz/aZ71rVpEEnu87snffCPNbftdkIac3vCnMY81eI
         IF3QGDjRmwqLlX1yq3KCL1tP3+WogDKh9JxbMT0cEMu4AnDs1P+5s5OevOsq+ZxzbfsJ
         M0ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789085830; x=1789690630;
        h=content-type:cc:to:subject:message-id:date:mime-version:from
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=S44dTWF40G+fGHovL3O3dgYh1dI0740WCQy5o7cAbGo=;
        b=iLr/kugMPzfquo6xzCXddQjQ0RN00MQbKbU74TcNUM/BVpqdJMOGoS3f0kJreE7XMK
         4hc7d9tTrQd/QqJ/+zeV8WKWIefD1hgyx1VYlhKlFsCOj5F+ORAKI5ck+hxUNwlO7cZC
         g0W44Lf+/MFVwFa5Ut4XgVlskCrN40lS3kJW4IiengEkLIQSQEBSMk4GDFSzJ64ftk51
         nQA9eLxwRb5Vagbha0I/iHwF7OoliQlEdaGZy5ntlSpNUEF1z/WpzLBO40m9ESxt98C1
         aXZKhCVBa0NwkDnoJ0fTDY24E5fPUzQ7jGWtlnl67hPoQvUNeyWq6bzom8zWXNLLA+M0
         J50A==
X-Forwarded-Encrypted: i=1; AKwUvBx3WqwFfVREH3Jgr4T55450vMelUS4wFyR+0HQHA336UE+50mcoo62+9xN97SvLgZ0xSBJYV4M=@vger.kernel.org
X-Gm-Message-State: AFuF++lI9c5XnDMcxzmt8p1nYpQr01xp3nEgQOkpG0M8NJvenA6ObU3+
	bXtYU4Q7gn4ODmha2mYbREue+QSyk0AShMYklmlaejvIkhKdhnawc0hR9cuh7L3Nb29aOGV1/QA
	bXJdygjI8CKCCSE+mimKt4zxQTttUTywbVOTjPT58
X-Gm-Gg: AYBFou0LWJrb2841pnqIQXm22sDhmwkmofXWcGyvdkhxYRFt1VKn5/y0DVZfe8+CrWZ
	/BA+2Db7LQJN/ZVwTkbVrrYX4Cr5l5vEPsI7CVZxSTDrtg84ISwTKcM3X0d6hVJ8JDUWGye8iCB
	CEmViIfRa8ytWa89EH2NnpP1guC5ObncyaBOlla8rTFFQ3E4BIZRx6I1qqbzOVDKcjqTnBaJwHf
	e8DLKLiHg+zL8xgCRuOviqKiRt+N29VzTK2nadcXFwEWT+go2OERXJEO5OnJwJb73TeFTKP/nSC
	bHyPuPySpmQjzExRaO6x3g2JZN4P5O3ss40X8rO/sZiPk7WXADbNJeazWXo1210BMZxHnBpwSTC
	zGbDq+rhJjfmRN91x1jaB1557HORdt5tsOOQ6MTXiSJo=
X-Received: by 2002:a17:903:19cf:b0:2c9:e9db:8167 with SMTP id
 d9443c01a7336-2dd2a1ea679mr40406725ad.7.1789085829154; Thu, 10 Sep 2026
 17:17:09 -0700 (PDT)
Received: from 474444807712 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 11 Sep 2026 00:17:08 +0000
Received: from 474444807712 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 11 Sep 2026 00:17:08 +0000
From: Farhad Alemi <farhad.alemi@berkeley.edu>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 11 Sep 2026 00:17:08 +0000
X-Gm-Features: AcwNN1UI0Y2k7NpwvQMDJPRWXKOGhgWR9UD98ZG3_PEz1AwjbPB5B0x8KFFklCw
Message-ID: <CA+0ovCj+Pd5owGH+51rA8-RDu9YFx5oYUv8bV0zOE72QgVfY0A@mail.gmail.com>
Subject: [PATCH net] net: reject a forward path that loops back to the tunnel
To: David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: falemi@asu.edu, Simon Horman <horms@kernel.org>, 
	Pablo Neira Ayuso <pablo@netfilter.org>, Florian Westphal <fw@strlen.de>, netfilter-devel@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

ipip_fill_forward_path() and ip6_tnl_fill_forward_path() assign the outer
route's device to ctx->dev without checking that it differs from the tunnel
device itself.  When a tunnel's outer route resolves back to that same
tunnel, the walk in dev_fill_forward_path() makes no progress and trips its
loop check WARN_ON_ONCE(last_dev == ctx->dev). Release the route and
return -EOPNOTSUPP when the resolved dst device equals ctx->dev, so the
path walk either advances to a different device or fails cleanly.

Closes: https://lore.kernel.org/all/CA+0ovCgaRvbd0Udj70b2xxG8Cx3CaCpNhnf1V4RWQuDveZYZhA@mail.gmail.com/
Signed-off-by: Farhad Alemi <farhad.alemi@berkeley.edu>
---
--- a/net/ipv4/ipip.c
+++ b/net/ipv4/ipip.c
@@ -375,6 +375,12 @@ static int ipip_fill_forward_path(struct
net_device_path_ctx *ctx,
 	if (IS_ERR(rt))
 		return PTR_ERR(rt);

+	/* The path walk must advance: a route back into the tunnel is a loop. */
+	if (rt->dst.dev == ctx->dev) {
+		ip_rt_put(rt);
+		return -EOPNOTSUPP;
+	}
+
 	path->type = DEV_PATH_TUN;
 	path->tun.src_v4.s_addr = tiph->saddr;
 	path->tun.dst_v4.s_addr = tiph->daddr;
--- a/net/ipv6/ip6_tunnel.c
+++ b/net/ipv6/ip6_tunnel.c
@@ -1863,7 +1863,12 @@ static int ip6_tnl_fill_forward_path(struct
net_device_path_ctx *ctx,
 	fl6.flowi6_proto = 0;

 	dst = ip6_route_output(dev_net(ctx->dev), NULL, &fl6);
-	if (!dst->error) {
+	err = dst->error;
+	/* The path walk must advance: a route back into the tunnel is a loop. */
+	if (!err && dst->dev == ctx->dev)
+		err = -EOPNOTSUPP;
+
+	if (!err) {
 		path->type = DEV_PATH_TUN;
 		path->tun.src_v6 = fl6.saddr;
 		path->tun.dst_v6 = fl6.daddr;
@@ -1873,7 +1878,6 @@ static int ip6_tnl_fill_forward_path(struct
net_device_path_ctx *ctx,
 		ctx->dev = dst->dev;
 	}

-	err = dst->error;
 	if (err)
 		dst_release(dst);
