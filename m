Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F379364934
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 03:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792380694; cv=none; b=CHo6LG1aGDghky6BUTiKWUGut5eOJh/gUt49BUR4KkdUuRl5EjQB7uFO4ucLVae1gfvn/v9vozyhJQqRCMWmNrSPXnqomMy0KAnV3l80fG30AxW3FTKO5KPu5eCCsfXFFckJKvbk1T+J2xkZlVpZqoR3RyufJrbup+NJefqc618=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792380694; c=relaxed/simple;
	bh=2ISdvGV7pkF79YAQofMB1xUFsmDARlM1DblPDqt6G8U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=joJ8Ff+3EnzBVyqC/uZRBVIqo5HMZWgnMm8Yt0izpZwkYaFF6w6MTOSnOPhqonL2RAQhJ9VRWjB0i/mVgFtYkRRSMsJ9RNOIKpTPyP4Cf0bjWNI9ass8K6hskAsX8L2hNr+CVdwPdc4YAeGYwLyice0mhZTF9kH61D1J3Om88QA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EgAoVlbY; arc=none smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EgAoVlbY"
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-35ef6b49813so3203090eec.0
        for <netdev@vger.kernel.org>; Sun, 18 Oct 2026 20:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792380692; x=1792985492; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZqzNU1e0dfFjl60Tsw5RH9N/elLcwfaAYKt+WjG7Sz8=;
        b=EgAoVlbYXjt45C634rPTAfMLiFYLbacxEKKQm3XS5kfJL63/k0X+z9rX4QY8Lewldn
         YPNzmeY04NfdnYtlTca1Xg0rKRwjkmQSVJrRaLrMS4XMQdxwHxJsGS+M/Ovwa/j3ncXA
         iTR9EAIR2nVluRKbn+kdmJEhbX2ENnjfKZ7HnikIHGUJ5RJCWKqp1oRRiHLzdcW8tywI
         DT+A82l8RoVqtwpjekNGL5KI2RFBmYQZL+KGeTieliKMJp9KFF2OWv1Uw9t1J5bmeVCh
         KG8u3ePRiwpPyK+1v5ukaDWygVLStPmzVZf6FWXAwmXxIb7RRqXimWd8Eym3aLVUqecH
         j4qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792380692; x=1792985492;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZqzNU1e0dfFjl60Tsw5RH9N/elLcwfaAYKt+WjG7Sz8=;
        b=ESfShGtEkJlpzNdMbFtXSJIginm2A/Z+4Gfav+7Fdpey+9XhmZ95VLOiU1e/+MU+zH
         7q7OKRjI6tayatx5XVslP+LXHTX3FJqrvgrfiq576mUIQ15eKeTZE1Gx7Ivtyu6L/Sdq
         qPqxlM65do8hzJQFvuq+n8gj5/2XXJJL2NY16KuEAjZb1YI7khikOHYi5JNQUsIWi7qE
         yhFOWkWrC1ZgMiDvmrhyF12Mn8l0kkhMjvMjsAAVS/8iM4WhBkbteX0ngm31bl0uDhFb
         dAytlcC3S54us5no1N+N0u1Lqv8DEaGmB1t+4wiCmZZUMHdXkcXtKXoIGpQ+46Myz7px
         L0mQ==
X-Forwarded-Encrypted: i=1; AKwUvBzpE3jOyFHOPF7AKFsz4KGo+izj4DX5vQfq15EA0GXPaCyO+cxbVXRsRJOCWVFHyo6hku+b250=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ20fvKNdDqyNGzMxMjpBKwl8VaJiI0NcT00I4gdmRQnH0h4FiD
	RFWoFIkm9pEWG1I3VY0zQEuqCAHH6Hy2FuDfgF6Z/6OQkyWPVrV+f+Fl
X-Gm-Gg: AYBFou0um2hCVomtaMWyLpHqBB01VM3IMZA/fyAiNlHFT9T81ncJ1qgm3sGXMR/d6wM
	hmybrgJiYLBSmXHkxi5bCiZXW7EmSLxb2jPNCzEsx5BgBHhuANityCMyCtDeAMMXsvZ0xZhX28m
	J+I81q+TlH+/pG3lEOc/1rWJe15J7u+4nVhxp0lrv2BDpmN7FVQvie4lXGceSx+qZRMCvyNc/IL
	w72dtyJ/24o6l89KkDLXZYmATouZzJEFi0a64eC7YFFZkvNctl4WYbiRJV5A0w/Tms1xdDd5HFl
	7l0BGdGSBlhm8XB+U3QszqH0FbY9xp//p4j6eACfN02nC84qR5miaYF3W+TYhjF0Gy/a5vcTbPK
	ufkIBJ1yy6il1GLM8rl/Njx6DoxjFoXszpRh4d8h5AQQfPZcS3kuNiufrzoVihK3DV//I02Foxq
	S+PX9HE/cezjQ9WSweXwrhp4eF0ork++JypZnVEPMGp2fNqkXkLwJXLdk0LE8mngMaHA==
X-Received: by 2002:a05:7022:e804:b0:168:6ad8:e89e with SMTP id a92af1059eb24-18514cf2721mr10290927c88.45.1792380692465;
        Sun, 18 Oct 2026 20:31:32 -0700 (PDT)
Received: from [127.0.1.1] ([23.254.208.9])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-183190aa7bbsm24066888c88.5.2026.10.18.20.31.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 20:31:32 -0700 (PDT)
From: Qiliang Yuan <odys.yuan@gmail.com>
Date: Mon, 19 Oct 2026 11:31:17 +0800
Subject: [PATCH net-next v2 3/3] net: remove rcu_barrier() from
 __dev_change_net_namespace()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261019-bug-net-netns-move-rcu-barrier-v2-3-b6eb7780c492@gmail.com>
References: <20261019-bug-net-netns-move-rcu-barrier-v2-0-b6eb7780c492@gmail.com>
In-Reply-To: <20261019-bug-net-netns-move-rcu-barrier-v2-0-b6eb7780c492@gmail.com>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>, 
 Nikolay Aleksandrov <razor@blackwall.org>
Cc: Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Qiliang Yuan <odys.yuan@gmail.com>
X-Mailer: b4 0.13.0

Commit 6549dd43c043 ("net: dev: fix the incorrect hold of net
namespace's lo device") added rcu_barrier() before
NETDEV_UNREGISTER_FINAL in dev_change_net_namespace(), so that dst
entries released by RCU callbacks were on the dst garbage list before
dst_ifdown() moved them to the loopback device of the old netns.
Commit 070f2d7e264a ("net: Drop NETDEV_UNREGISTER_FINAL") removed the
event but kept the barrier, and dead dst entries now point to
blackhole_netdev instead of a loopback device.

The barrier waits for the RCU callbacks pending on every CPU while RTNL
is held, which takes a full grace period on each netns move. Container
and sandbox managers move one end of a veth pair for every new network
namespace, so this limits how fast such namespaces can be created on the
whole system, regardless of how many threads create them.

Remove the barrier. The RCU callbacks queued by NETDEV_UNREGISTER
handlers free memory and drop device references, which the move does not
wait for. Cached IPv4 and IPv6 routes through the moved device are
rejected once its netns changes, since they no longer match the rt_genid
or fib6_sernum of another netns.

Creating 400 netns, each with a veth pair whose host end is moved back
to the initial netns, a tap device, addresses and routes, in a 16 vCPU
guest, median of 5 runs:

                   before      after
  1 thread        69 /s      385 /s
  4 threads       74 /s      368 /s
  16 threads      76 /s      263 /s

Signed-off-by: Qiliang Yuan <odys.yuan@gmail.com>
Reviewed-by: Eric Dumazet <edumazet@kernel.org>
Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/core/dev.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 8eb9bf1ff9eb6..ef172905109ee 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -12994,7 +12994,6 @@ int __dev_change_net_namespace(struct net_device *dev, struct net *net,
 	 * the device is just moving and can keep their slaves up.
 	 */
 	call_netdevice_notifiers(NETDEV_UNREGISTER, dev);
-	rcu_barrier();
 
 	new_nsid = peernet2id_alloc(dev_net(dev), net, GFP_KERNEL);
 

-- 
2.43.0

