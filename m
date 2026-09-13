Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4E243932FA
	for <netdev@vger.kernel.org>; Sun, 13 Sep 2026 09:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789290557; cv=none; b=ioWGb4uCGOP0x8+bX0wqVU9HZEmG5m6raKDQUL55JikZndRZWI9G7YFwNzUdXjpxvBAX2XXGhkRHK7OTUuRQ9ozMkqaFZ6LvL4s0DCpssybEU7wpER/B8Y4MVO9D9v1DP7TuK4ncOmbSwM93gszoeTyy3rhn4vCyCke9GachF5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789290557; c=relaxed/simple;
	bh=azu3uLy0Mux7GpCyqwyRDXjjYjMQ9/gZOf8vjQLgseM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=n0KARmTIe1vXxxCN32X8EGv3v26Xow+PQDi9HWmoCdqJJ/m43jTIFbEqGS81uoVbcEKSzrr9xkH0KAerketqDXXu5P9u5RhZLIpaDlFD6yCNwWLwi4JXpVGjSq0vP35bQvPKdtQtPf1uN+Htfnyu2ufBrtB4Xg7NhiSvwFxKafY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k6Ew7KoU; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k6Ew7KoU"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2d6d28aa26cso16937235ad.2
        for <netdev@vger.kernel.org>; Sun, 13 Sep 2026 02:09:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789290555; x=1789895355; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=MFJlL+9O/jXoy6I1rLj9f7uyrPfSM21JuJ5Ws/dqJiQ=;
        b=k6Ew7KoUyTssO/21sbBg54LSSdxnRMvRYHm/x51jFDsGbHnJPRP9SBwCxr31xfK+LV
         u937QnroBRg0S6CYTx1EatPpf2KJeex+T0L/RIPBZyGuIchEKpuddryze7cdy1i/ivRH
         MhXYW8U7MNIJ06TCyxpvd2uBU0Zhz3JMUiiB7m4dibPMQAClkxIviHQLO4IJf3ItAzNI
         fQg+ZHPkG3cvq6KWpZ2OszapxObv5wC+owjnJAxsFA2GRt7RrH1JXLAG477DW8UwYgJj
         lngY8boHDZuU7t0tXusI0FpQEgYj5qaYLlvYEodXqodPhn7yDVDa54Ez2U1L2cEGbl/c
         rQ1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789290555; x=1789895355;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MFJlL+9O/jXoy6I1rLj9f7uyrPfSM21JuJ5Ws/dqJiQ=;
        b=G9hYy9l65nEtL7Kkr5/fc4QIZwaT+wveDfPFwbiABsA8n2ktjn2zAmvrIZTfRKNdWk
         hx7vfunKgkptbunlE2uLMbYZokG0X6YpnWFuNNb/AO7TofmJkRpKJRP+XInNB5PoYBup
         R/nwXoi6Ba6r4YRIH6C0ktLWEucXkV9TEZLyF9axi5/V+7HvYqftUIhECqvs/YbzNVQO
         UuHBQsYitEHFn4zdSgN+YoqsXhWChVLg5V5ERrEytX+B0Z/+5ursVXraTbITGLsd0Mix
         F/XuRKLMPRmJtFVM+GSTjTTpKJghi7Iv/JlLsE4kaEkpyRBB55Q3bHLS8YIU5uU9SYC0
         G7Iw==
X-Forwarded-Encrypted: i=1; AKwUvBzO+VvjiMsKYjqqRXBFB+/tcO+E1bYjx6WqSxQMLt06OjCHsrw4uBsmGMwojBP5akbPoCuRZwc=@vger.kernel.org
X-Gm-Message-State: AFuF++mLISPDfzVDidsauEBUuiAaAbsPAA4ik3nXdWSz4Zs+0lTH6hH3
	6Qo+hHDDYPVH1tVXAfwiRVTt3fov/ikruHftXxAFs5AsKoz6v9t0mlHX
X-Gm-Gg: AYBFou3GhOJyoWtRK09FKs82MWPhCAu3ZW0MM6AcW2+nNxVX8HV4L1WoOFGcE5LTKuP
	l2js0ST3Wpl0Tq7r+Jcfeib6rM5GagVOPIFYOMSVGndjOJFydtZ765OyIIRJNiNSXqaYK1xkRql
	9XaSZHMxzarEr2X8ilc3pjCrSqyxFOWdjvcRCWiAE5Rk6MHubHTMnsH90eSxjC1ySWnp+c7pHZ4
	DFHOtuTUIoPGr5RAuzJrMzu/Ejo64Gy/aSmmnW3US6uLGT/u3IJMbyFLvzj9FOzfmvyGNF/UWK0
	78uqbEPp8oJtK69dYkTrCgM6oeyqBz0P+vtfzIZB08xidHy9dJRIp0mecrevVoaftSvjX+QfcP+
	BMW8cw/+R74v3jbvAff8xLIVo+CYmQlTkipQU8FgwN27k4P61d4f026U8JAn3NR9NmvmfNMJ4R4
	xxSwyoQMkGa8VCbapij3G9hBuwjFZ2c+p7YmovtaF7t+5tB5qsCKfKDREGrPp5wg+7ukd9T4lvS
	wqVlmj+112oyAbq0CKUnjAAfI8nqIGC+f4=
X-Received: by 2002:a17:903:1b04:b0:2d8:d4ce:9f37 with SMTP id d9443c01a7336-2dd2a470a45mr200065545ad.21.1789290554993;
        Sun, 13 Sep 2026 02:09:14 -0700 (PDT)
Received: from Gris-Laptop ([14.31.107.13])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33bc03ac1ecsm6570186eec.10.2026.09.13.02.09.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2026 02:09:14 -0700 (PDT)
From: Gris Ge <cnfourt@gmail.com>
To: David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Gris Ge <cnfourt@gmail.com>,
	stable@vger.kernel.org,
	Simon Horman <horms@kernel.org>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Cosmin Ratiu <cratiu@nvidia.com>,
	Gal Pressman <gal@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH net v2] net: ip_tunnel: initialize `options_len` before referencing options
Date: Sun, 13 Sep 2026 17:08:50 +0800
Message-ID: <20260913090851.468216-1-cnfourt@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The following command triggers a kernel panic:

  ip link add d0 type dummy; ip link set d0 up
  ip route add 10.30.0.0/16 \
    encap ip id 300 geneve_opts 4660:66:11223344 dev d0

  memcpy: detected buffer overflow: 4 byte write of buffer size 0
  kernel BUG at lib/string_helpers.c:1044!
  ...
  ip_tun_parse_opts.part.0.cold+0x10/0x10
  ip_tun_build_state+0x116/0x2a0

On kernels built with GCC 15+ and `CONFIG_FORTIFY_SOURCE`, the fortified
`memcpy()` got 0 sized destination with request of 4 bytes length:

  static int ip_tun_parse_opts_geneve(...)
  {
      ...
      attr = tb[LWTUNNEL_IP_OPT_GENEVE_DATA];
      data_len = nla_len(attr); /* == 4 */

      struct geneve_opt *opt = ip_tunnel_info_opts(info) + opts_len;
      memcpy(opt->opt_data, nla_data(attr), data_len);
      /*     ^^^^^^^^^^^^^ 0 since options_len is assigned afterwards */

Fixed by initializing the counter before the options are referenced.
Matching what `tunnel_key_opts_set()` already does.

Fixes: bb5e62f2d547 ("net: Add options as a flexible array to struct ip_tunnel_info")
Cc: stable@vger.kernel.org
Signed-off-by: Gris Ge <cnfourt@gmail.com>
---
v2:
  - pass opt_len into ip_tun_set_opts() and initialize options_len there,
    matching tunnel_key_opts_set(), as suggested by Eric Dumazet.
v1: https://lore.kernel.org/netdev/20260912055304.1415016-1-cnfourt@gmail.com/

 net/ipv4/ip_tunnel_core.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/net/ipv4/ip_tunnel_core.c b/net/ipv4/ip_tunnel_core.c
index 5168d546ea2f..bab42b9e277f 100644
--- a/net/ipv4/ip_tunnel_core.c
+++ b/net/ipv4/ip_tunnel_core.c
@@ -680,8 +680,14 @@ static int ip_tun_get_optlen(struct nlattr *attr,
 }

 static int ip_tun_set_opts(struct nlattr *attr, struct ip_tunnel_info *info,
-			   struct netlink_ext_ack *extack)
+			   int opts_len, struct netlink_ext_ack *extack)
 {
+	/* `options_len` is the __counted_by() annotation of the `options`
+	 * flexible array, it must be initialized before parsing writes
+	 * into it.
+	 */
+	info->options_len = opts_len;
+
 	return ip_tun_parse_opts(attr, info, extack);
 }

@@ -712,7 +718,8 @@ static int ip_tun_build_state(struct net *net, struct nlattr *attr,

 	tun_info = lwt_tun_info(new_state);

-	err = ip_tun_set_opts(tb[LWTUNNEL_IP_OPTS], tun_info, extack);
+	err = ip_tun_set_opts(tb[LWTUNNEL_IP_OPTS], tun_info, opt_len,
+			      extack);
 	if (err < 0) {
 		lwtstate_free(new_state);
 		return err;
@@ -753,7 +760,6 @@ static int ip_tun_build_state(struct net *net, struct nlattr *attr,
 	}

 	tun_info->mode = IP_TUNNEL_INFO_TX;
-	tun_info->options_len = opt_len;

 	*ts = new_state;

@@ -1006,7 +1012,8 @@ static int ip6_tun_build_state(struct net *net, struct nlattr *attr,

 	tun_info = lwt_tun_info(new_state);

-	err = ip_tun_set_opts(tb[LWTUNNEL_IP6_OPTS], tun_info, extack);
+	err = ip_tun_set_opts(tb[LWTUNNEL_IP6_OPTS], tun_info, opt_len,
+			      extack);
 	if (err < 0) {
 		lwtstate_free(new_state);
 		return err;
@@ -1040,7 +1047,6 @@ static int ip6_tun_build_state(struct net *net, struct nlattr *attr,
 	}

 	tun_info->mode = IP_TUNNEL_INFO_TX | IP_TUNNEL_INFO_IPV6;
-	tun_info->options_len = opt_len;

 	*ts = new_state;

--
2.55.0

