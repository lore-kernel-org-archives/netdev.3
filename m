Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 455F235B636
	for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 06:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792131016; cv=none; b=N1gspxt6gcqp8TWJ1qaUL8ogR1bkKKj2LfTRLmUp2MurnydWJxtGrlsG/ONGW2unLjiGOhd5mQkx3cIJby+DRwD9enJ6y3xkcm2RusS7VQBSXFsp1wWcV9rqJbaThQftsEV3iCaE9ONmW+gduT3uXPHp5SZuHQw5xuIqDw9tLWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792131016; c=relaxed/simple;
	bh=rfclI43Gt0jOxEzPCEKf62xMSKmmsFMZNhF9lP4Mfck=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=a6EpWGNGNVBc9aQocFA91dOvnTkYshuJuRryvw+cFZj5QwvH20s5Slap7TDuNK0MQux5yxPA8EoEEeToFL5gLNfLfsdWBPBoAP7MJadvWfY/woW+lBxNoBppLbsVUtu+hfkoRAKrPrDFyaNsSJpe3kkCTOshEztJmnhOTl5TPzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hgn96mft; arc=none smtp.client-ip=74.125.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hgn96mft"
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-15354aa70e8so2093467c88.1
        for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 23:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792131014; x=1792735814; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kItInSB7Il0bFX5rQnMMdEMc2ibDWAXPMzy5j1ycaRI=;
        b=Hgn96mftoFUSxo+xbH2o0Ww2+oSKGIq0bq0wOwcpWtah898wMdDR1+GjATgw8IU+mx
         K5ja4y8FQzij2GjCiwjhmswLB1O+lvjhbh4JHmCPMVlt5kIxsRbZmnTYNAjXknZDa7Ep
         uFcxF0eBAhJDOJKapYWvcA7ZD0jZIHudK50rdjyjTnbxsb1tTUTZf14oXXPGm9xZo6Zw
         8Cd3gxY6z+GmprqdJSjAjs9gksjDh+LDU1QhQsgWC1B+gAQCPcaUPDn/9JT5M6Q35jDO
         vmm5F3WqMvLGE/gAofa1ioYAkm9gxTMQzFBZr3h77VJrw4I7mjoeUVZrrqOcR3ZmB/q9
         +ARA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792131014; x=1792735814;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kItInSB7Il0bFX5rQnMMdEMc2ibDWAXPMzy5j1ycaRI=;
        b=I8usKXSCVx6TtRuDMd3qD+QnjNVrf7HlLteuxORcybalJzC5lbD+0o1d74ODfFbobc
         lLzUfxYLf4W7bUFwyJ/NDY80xDkvAw8R82jq9oYZftxoXLSlMDS5i9mlXDbPYSZMcK9m
         lp51X9uKyM1zHzN6L1JWZ5zlgGVQB0UtHeWNvIF5OflIjONnvCrFZFR21VihjgZCcJCk
         Zr+xhBVaE4d7RKO3Rizol5598n9ZHX0Chy/9k9d/PDrBFS/q1vG2esuI7hvF7//WFZZ7
         on3GKygrSSoNm1UvWfjOVTFoJHBHYBKR8TcHSqSi9m9i2d3AdeWBj/XVI3takemjHL7B
         JCzA==
X-Forwarded-Encrypted: i=1; AKwUvBzp1IVdsvRy+3BbpugwI2bJs6IoHdgVpB3hHsMQ93NVXedfN3E4tPWf3HB2onYJCWvGh+s8JgY=@vger.kernel.org
X-Gm-Message-State: AFq9FYI4eesn/OT9m8QECPXS3sdmjqSUT2f68EV65AecASkLWNYcfyYJ
	CU1xvCi5iveUWyiEUHTqeha+rfBhrsrq/sqC0IyxsMsX/itQWoQuO//i
X-Gm-Gg: AYBFou2egUgGAQ25nT6mf2lpG35ducjeN8qZNkIyK97c8caatieVWm23lw9VJnbH/kj
	HkzCPKvfFhzuCdqGV/CHIDqHqqZYreG2W3xJxEeqonuw/inztvcfe7AXYrEYyy/+qi4pOySoFPN
	HI+SV9GDz4S58+qX38xnRMXdBgft1WO+oyD8rT+AglIZiAWp4UTgR9y+RbHcKaYrAY4xRlebdC4
	TixZla3ItrPpWN8w9+SwS9nDM2OfxfMfCjhhw/mIo8pmhv+W1GmpHOMhuxUT/pI8i71F/dSHUmF
	TZOvRIy+0QLXyLXv+J9mcXlEpV8eq6PHVDfzs7Ul2WzIChwPBb8UlTkwika7t1BZIIpH9ESAsbC
	GosN0o5yHYS6FNdtb182dG9UNQSIGwDSTXKec+/PVsroFKZQEIYC3RsUfocw4dri46d3PAX7iJG
	6bLnX+8G/N6rejuGlqM4WEQhSEeWcXD/A84ru/uxv7REtbTmbmbvN9h98KYUPPJSOxUvjK0mMKu
	hLu
X-Received: by 2002:a05:7022:3f0c:b0:151:2e62:fe8d with SMTP id a92af1059eb24-16a5dcf817bmr31111126c88.9.1792131014345;
        Thu, 15 Oct 2026 23:10:14 -0700 (PDT)
Received: from [127.0.1.1] ([23.254.208.9])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-183190aa411sm3309068c88.4.2026.10.15.23.10.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 23:10:13 -0700 (PDT)
From: Qiliang Yuan <odys.yuan@gmail.com>
Date: Fri, 16 Oct 2026 14:09:55 +0800
Subject: [PATCH net-next 3/3] net: remove rcu_barrier() from
 __dev_change_net_namespace()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261016-bug-net-netns-move-rcu-barrier-v1-3-4157d798658f@gmail.com>
References: <20261016-bug-net-netns-move-rcu-barrier-v1-0-4157d798658f@gmail.com>
In-Reply-To: <20261016-bug-net-netns-move-rcu-barrier-v1-0-4157d798658f@gmail.com>
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
rejected once its netns changes, since rt_genid and fib6_sernum are now
unique across netns.

Creating 400 netns, each with a veth pair whose host end is moved back
to the initial netns, a tap device, addresses and routes, in a 16 vCPU
guest, median of 5 runs:

                   before      after
  1 thread        68 /s      440 /s
  4 threads       74 /s      409 /s
  16 threads      77 /s      283 /s

Signed-off-by: Qiliang Yuan <odys.yuan@gmail.com>
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

