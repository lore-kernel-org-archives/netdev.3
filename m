Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794070488;
	b=zEyRX1xbpKGaz2iepR7Mhl5fe9HnPHWW/Z9xxWIiYoPUtA5SSYy9N7BKU8O5H8dKkE6q
	 AODXyt37U0o2h/YCEkq97twH9oN2XhhQPU6/CUd2weIZ4kkXSYlqACn1N/sosmbCU8KuF
	 22gxrIpnGpInm/juVKAOAlU5lLxLZHND5JrR8sRZSO1ZtSM/bLQWTY6Ogo7TqnqUexEbI
	 m3c+HpwjR0Ys7+rjcvAScuwQoTs3CwEOkKuXR/DZgtm1DSGhUocpHguu/1NHPZVUV8wg0
	 5qxxdgUAI3wjC700d9eSuNm6VCAuB/Qls2ZO/et09JCRa7UXPT+z0QgYyT0A0X5rZBg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794070488;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:To:Cc:Subject:From:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=9crvf8Iw5xDhgykteC/ydKrbY+Caq7Bxsz2VEq620k8=;
	b=2Tr9adt82KngM/7+gHwtBajSH7X4YU/li0zWfMWawHHKJse5FS6GgNawka1GX7Ce5jUz
	 zFj89S8ejR1VOW4r9PbUEzauXp7N+ZOfSIwkWHsKO+XbAmdep6nMT6rj6hDcGpG8jrTZ8
	 dh22Y0KRlMRp31apG1cazFn4lAO6qdjO4Vj1onCLuDiHAHyICfSY7fJz9lhc0EWFdLvSa
	 a2NoGejMedhCehcubSKQ9coPqA7/L4fp6hs5ER+oKMxcuS7K0zoSKhb8WCRPsVaaYw3jD
	 2ERzuXxSVzvGxP3EM7vrMmy10XPkTAKmempGDnob3AaDMEL0YoeCCyqAVqjxnG27WoA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EJ9xwmCX;
	arc=none smtp.remote-ip=209.85.215.178
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65EA0606A326
	for <netdev@vger.kernel.org>; Sat,  7 Nov 2026 16:54:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 65EA0606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EJ9xwmCX
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-ccca948203aso596343a12.3
        for <netdev@vger.kernel.org>; Sat, 07 Nov 2026 08:54:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794070488; x=1794675288; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:from
         :subject:cc:to:message-id:date:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9crvf8Iw5xDhgykteC/ydKrbY+Caq7Bxsz2VEq620k8=;
        b=EJ9xwmCXuRLVDRzge33hcKr2+q/R5m/0hsPPquNGhCKVcmsug8bFHuIiz3T1CovAX9
         VZukWJM+7/ZGGa+72Pujv/cE2agl6ecl2tcwmK+t6+zjfQrSLoUEXmKjCVIW4WkoRoPB
         n8TqckVGUqrmobnfTWeOETlbfobjxZesd+MaQh2f7uVmdVqXtyuCHHPGIRXEjhdGSRLO
         MI6SCmFLLYOwf47nWgJ+Jsl547qKwvFSsfR6TVCF7jdCbZdG3mdWreqMiryOJZFxXzWV
         muRrCXsv/Y+XK4jFLG+U+L785zpCws/1fCPfo41Y0g13tCmbNSuS+KdZ5BoPK1AhYcQ6
         i1cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794070488; x=1794675288;
        h=mime-version:content-transfer-encoding:references:in-reply-to:from
         :subject:cc:to:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9crvf8Iw5xDhgykteC/ydKrbY+Caq7Bxsz2VEq620k8=;
        b=d5lD0EF86rnjQS2FMZjPHpUMeOoALPN8Lh/cLjIH0Wl71wfkPCzF3Ufxy+4/iXRgOd
         e+yZiE5p7TlBw1ltY3igCCqMJvQq5kbpAZGT98m5hjrj9y+elkvty38qzM8CAR2tqIrU
         qyOpHOI7axJ6UkcLoeFL0WsmRr/R+WSdJcwlHZXG3gYGfZHudXZYut9Z6k3flo9ZVJnE
         usMeFAxAc0/Fm09bGei8zwt8O5Ko8TdAG7IPk3hZOlr/SCLwHR5PaJuASMzJ/hOqBCZB
         9V4CtYFO1rktMX4Tn83qwLdPRiHH13QS3bjqNOnhLLn4viGMjk1ZkM6mOxfFCNIMKE+b
         yfbQ==
X-Forwarded-Encrypted: i=1; AL+hErHlHCNr/G0on2QfIaKlQpAwo7axuQ0ba4j8wrpSmdERFCmPADhItlDMgIS5CbfxIzVNnxXml1E=@vger.kernel.org
X-Gm-Message-State: APuU4Z+b4ai3MuAL19zX9NjlbOixoOHzHkhu+Pc55AntMnH0A0Bv/YDm
	Fyipf87AehR9oOtd3Rmx7UAP1UzC1nDTH40qypSHYW8jW6At0/70Trt+
X-Gm-Gg: AYBFou1Q7reNeKzCZGTmP0xJyXrhW92jeLaHe2+pEsA7xNGQfSw+Cr8NGjzm079NHOv
	K++rRmcBMlwasMRqkHHSXWEE3TSmMDg6urhRa/MCNib4lzK9R8AYRoxhI8TXTOfeZwz/QnKPJif
	Jf0ZOvyRPh67uqlsdmWyoVlyfy7fBH9d57RU7oXyLCRbNgsBDtiC8GKSOtLISDSLWfA+q8ozR7Y
	+uWGdGZf5LIOiaOOhBjOzZsTh9+6rRhNfvm1jLVT716vLJpIYBvaVwqNMBa7MZoO+ELvx6ANE5M
	VMWb1h4w26x4H8mtQPf2ODh/aqajB74oPwUdm/EEdwCC07q2J6SDEr4K4DhnRNlhuCfzd7/WNs9
	2A/x4HMHu5WWGo3vDcElfP1HQSxRPIizRRn/v7Uks6QwX9zOyLDHGjx4AubEKdiAEQVgrTjU2hl
	RSavGlreZvinRi3OM5bSQV0fL+IDM2hKJxyHjvc+suCGlUzzHxMijh5HHoSBoXcaDn80DTlwKoX
	oPzqwA118MpdDiyDFL0BTFBDZ8mVTUTfls4LumRagJVEkBGhUSwHlrxjCtS/+PIIeNp6vGCJQ5F
	gV2mGlZ/Kex2cb44CKaUQjP/odx4iy2NR9jBLTYLt+6485NZ/iiZgT6iNqTbtD7PhV+IglRMHUD
	X8q2EZbK5Dsh37OsfRhD0EtSkztkxlSH77cxVYSH2pZVFAyI/brQxoXU=
X-Received: by 2002:a17:90a:d60c:b0:3ac:6e91:3f22 with SMTP id 98e67ed59e1d1-3b0db72c4d0mr5096080a91.52.1794070487771;
        Sat, 07 Nov 2026 08:54:47 -0800 (PST)
Received: from localhost ([153.61.198.246])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b11b04458csm828387a91.13.2026.11.07.08.54.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Nov 2026 08:54:47 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Sat, 07 Nov 2026 16:54:46 +0000
Message-Id: <DMP4WRIOGMBX.3VW2KNLBGDZ0K@gmail.com>
To: "Yingjie Wang" <1075151112@qq.com>, <netdev@vger.kernel.org>
Cc: "David Ahern" <dsahern@kernel.org>, "Ido Schimmel" <idosch@nvidia.com>,
 "David S. Miller" <davem@davemloft.net>, "Eric Dumazet"
 <edumazet@kernel.org>, "Jakub Kicinski" <kuba@kernel.org>, "Paolo Abeni"
 <pabeni@redhat.com>, "Simon Horman" <horms@kernel.org>, "Thomas Graf"
 <tgraf@suug.ch>, "Daniel Borkmann" <daniel@iogearbox.net>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net] net: ipv6: reject collect_md tunnel route without
 inet6_dev
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
In-Reply-To: <tencent_CB9E1044AC97882719FF3A9F5B410A562408@qq.com>
References: <tencent_CB9E1044AC97882719FF3A9F5B410A562408@qq.com>
Content-Transfer-Encoding: 8bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Sat, Nov 07, 2026 at 07:29 AM Yingjie Wang <1075151112@qq.com> wrote:
> A route using a nexthop object can remain after its output device loses
> its inet6_dev when its MTU is lowered below IPV6_MIN_MTU. The route still
> has no error, so ip6_route_output() returns it with rt6i_idev == NULL.

since so, should it be fixed in there?

This is the fifth check of the same pointer:

  commit        function
  ------------  --------------------------
  d101291b2681  __fib6_rule_action()
  4db783d68b9b  ip6_output()
  d46401052c2d  xfrm6_get_saddr()
  1b9b5323725e  rpfilter_lookup_reverse6()
  this patch    ip6_tnl_xmit()

Three more callers still dereference it without a check:
__ip_vs_route_output_v6(), validate_ipv6_net_dev(), cxgb_find_route6().
When the same mistake is made in N places the interface is the problem.

diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index 616b86f..e4834e1 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -1151,6 +1151,12 @@ static void ip6_rt_init_dst(struct rt6_info *rt, const struct fib6_result *res)
 		return;
 	}

+	/* addrconf_ifdown() removed inet6_dev. The device can't do IPv6. */
+	if (!rt->rt6i_idev) {
+		ip6_rt_init_dst_reject(rt, RTN_UNREACHABLE);
+		return;
+	}
+
 	rt->dst.error = 0;
 	rt->dst.output = ip6_output;

@@ -1186,10 +1192,10 @@ static void ip6_rt_copy_init(struct rt6_info *rt, const struct fib6_result *res)
 	const struct net_device *dev = nh->fib_nh_dev;
 	struct fib6_info *f6i = res->f6i;

+	rt->rt6i_idev = dev ? in6_dev_get(dev) : NULL;
 	ip6_rt_init_dst(rt, res);

 	rt->rt6i_dst = f6i->fib6_dst;
-	rt->rt6i_idev = dev ? in6_dev_get(dev) : NULL;
 	rt->rt6i_flags = res->fib6_flags;
 	if (nh->fib_nh_gw_family) {
 		rt->rt6i_gateway = nh->fib_nh_gw6;
