Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C35F4DE716
	for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 19:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791834336; cv=none; b=u8q85FjcH4KsU9tiFQQzwjmG/u0MqrcJqoFvQk21gnuiSJbj6dnNKKCywF7Tnjh+dGZXXoHxOK/tNpv4EsY4pZKWjNlWmb7BlSggI+1vBk4Ta6trhZ8K1C5oRdRgKbo9O4tzYIEyIXzAo6u9A74f10Z5v0wnolz/keJrXvhSERQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791834336; c=relaxed/simple;
	bh=lWRqV8x5Cg8ZZwS///8STniw0n2PyvlMRvAbapqw/60=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=T7EeUU1cuuma40MHIRGgFYi7yp5JVP7lG0Rxkud93mXWONuNsdFGmj84Aig2TAFHhice/3/y+SnyjcsMJLsAGzVaMvS/eKDok96fd23yjGy2/IfkC0I66dw/NHE6P1k7WBOiOVJrW/NCZ4l401m7OZqqXKKVyHn21sQPDiRPsQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=meLaQryK; arc=none smtp.client-ip=209.85.210.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="meLaQryK"
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-88a10162189so3262964b3a.2
        for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 12:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791834335; x=1792439135; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dqKiqkfmYAEix4q01+y7kSJwyugblM+mE6iJZWjc7Nc=;
        b=meLaQryKVWy7XBunQepAdQTsYTHsDOd4TDv2ilf6V7wiaXe6acsL4oaHXuVDyaUJPU
         V20eJrgLUzXlz+MMq/S+iXjrtLjRLeWbgM9LXIaJLJ3LSdkLffMWQIrf61p7CF49sWuu
         9oCslBMkmSQT4L7QdDbHy29oyo2R7MMZ0oP65rTLagtaid1c3mKAvDNv2UXUv5vcQqF+
         e2/mMPxeAtXRz/LGQwnw4PmasvsIp34e51U9LGBuiE6T/OvB9hQyXiB30a0bYf3dKJCX
         1sPWcbw0uJh+l2Qsxj8SDVOptvSIG0QF5XbbRmrNcUDnNZxvsiYs9OMeHj3ynEFduToU
         +Qbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791834335; x=1792439135;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dqKiqkfmYAEix4q01+y7kSJwyugblM+mE6iJZWjc7Nc=;
        b=mT0SWC2DWWhMdE573l5hs6HD5tjVBR8P7CQpyMX3DaBYXf/BUTB2VfX7YX6Xjt+dWA
         3D9tVz8oohF1UyHWioFnf3DaeCvIQ7Arbm6g/1qHlZKHRympf5BNJA8O9S1/msCnX5PE
         6e3yvHZeFAeEsAi5BSg9e/Yph+7beZanXoUoUhuBkrUf1EZHKATWyxwFRmanqcDiBjQZ
         rLNQHyK3l2E8/ZvqoijQsNS5/4yyqTb7O4qP3naApZIOkvFFKx1Gb81SOU55PcWoWcha
         N7cEHyt1UMvsab6TgRDlO8fQq8gHfRTNkV8XZJ4K47gnT9q+ErPKCdTv0/+KS08IyV+w
         ZV+w==
X-Forwarded-Encrypted: i=1; AKwUvBy5/NoJtyY+P/7XHtpeXFdwWqaSgt8Mz6EjcKwA918cWoEoiBR77CEzReeMnNuMml1KdEF6rls=@vger.kernel.org
X-Gm-Message-State: AFq9FYIdR4T3EtILTdnzvgIXfMkPoRryojwJasNij0Nyej8ZXziXXX89
	j4mv803BMv9E1CawEKFghI29sNKs2yfs+Sl4f1xlo4mFKvXdoD3cZCF8EdktCBawBNp01nQJx28
	Yf/g1RQ==
X-Received: from pfz13.prod.google.com ([2002:a05:6a00:bb8d:b0:89b:3147:652d])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:987:b0:873:2525:9a00
 with SMTP id d2e1a72fcca58-897c13f31b5mr8242311b3a.0.1791834334483; Mon, 12
 Oct 2026 12:45:34 -0700 (PDT)
Date: Mon, 12 Oct 2026 19:44:57 +0000
In-Reply-To: <20261012194530.3751034-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261012194530.3751034-1-kuniyu@google.com>
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
Message-ID: <20261012194530.3751034-3-kuniyu@google.com>
Subject: [PATCH v1 net-next 2/4] selftests: netfilter: Set gc_thresh[123] for
 gw netns in nft_nat_zones.sh.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, 
	Ido Schimmel <idosch@nvidia.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	Pablo Neira Ayuso <pablo@netfilter.org>, Florian Westphal <fw@strlen.de>, Phil Sutter <phil@nwl.cc>
Content-Type: text/plain; charset="UTF-8"

Since commit cda2962b6e2b ("neighbour: Namespacify neigh_tables."),
net.ipv[46].neigh.default.gc_thresh[123] are per-netns attributes.

Let's update nft_nat_zones.sh.

Note that the number of neighbour entries does not even reach the
default gc_thresh1 (128) with the default maxclients=100, and the
raised thresholds are only needed for gw netns when maxclients is
manually increased (e.g., 2000 as mentioned in the comment).

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
Cc: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: Florian Westphal <fw@strlen.de>
Cc: Phil Sutter <phil@nwl.cc>
---
 .../selftests/net/netfilter/nft_nat_zones.sh  | 34 +++++--------------
 1 file changed, 8 insertions(+), 26 deletions(-)

diff --git a/tools/testing/selftests/net/netfilter/nft_nat_zones.sh b/tools/testing/selftests/net/netfilter/nft_nat_zones.sh
index 9f200f80253a..d935c967dd13 100755
--- a/tools/testing/selftests/net/netfilter/nft_nat_zones.sh
+++ b/tools/testing/selftests/net/netfilter/nft_nat_zones.sh
@@ -31,25 +31,6 @@ ret=0
 #   NAT Gateway is supposed to do port reallocation for each of the
 #   connections.
 
-v4gc1=$(sysctl -n net.ipv4.neigh.default.gc_thresh1 2>/dev/null)
-v4gc2=$(sysctl -n net.ipv4.neigh.default.gc_thresh2 2>/dev/null)
-v4gc3=$(sysctl -n net.ipv4.neigh.default.gc_thresh3 2>/dev/null)
-v6gc1=$(sysctl -n net.ipv6.neigh.default.gc_thresh1 2>/dev/null)
-v6gc2=$(sysctl -n net.ipv6.neigh.default.gc_thresh2 2>/dev/null)
-v6gc3=$(sysctl -n net.ipv6.neigh.default.gc_thresh3 2>/dev/null)
-
-cleanup()
-{
-	cleanup_all_ns
-
-	sysctl -q net.ipv4.neigh.default.gc_thresh1="$v4gc1" 2>/dev/null
-	sysctl -q net.ipv4.neigh.default.gc_thresh2="$v4gc2" 2>/dev/null
-	sysctl -q net.ipv4.neigh.default.gc_thresh3="$v4gc3" 2>/dev/null
-	sysctl -q net.ipv6.neigh.default.gc_thresh1="$v6gc1" 2>/dev/null
-	sysctl -q net.ipv6.neigh.default.gc_thresh2="$v6gc2" 2>/dev/null
-	sysctl -q net.ipv6.neigh.default.gc_thresh3="$v6gc3" 2>/dev/null
-}
-
 checktool "nft --version" echo "run test without nft tool"
 checktool "conntrack -V" "run test without conntrack tool"
 
@@ -59,18 +40,19 @@ fi
 
 setup_ns gw srv
 
-trap cleanup EXIT
+trap cleanup_all_ns EXIT
 
 ip link add veth0 netns "$gw" type veth peer name eth0 netns "$srv"
 ip -net "$gw" link set veth0 up
 ip -net "$srv" link set eth0 up
 
-sysctl -q net.ipv6.neigh.default.gc_thresh1=512  2>/dev/null
-sysctl -q net.ipv6.neigh.default.gc_thresh2=1024 2>/dev/null
-sysctl -q net.ipv6.neigh.default.gc_thresh3=4096 2>/dev/null
-sysctl -q net.ipv4.neigh.default.gc_thresh1=512  2>/dev/null
-sysctl -q net.ipv4.neigh.default.gc_thresh2=1024 2>/dev/null
-sysctl -q net.ipv4.neigh.default.gc_thresh3=4096 2>/dev/null
+ip netns exec "$gw" sysctl -q \
+   net.ipv6.neigh.default.gc_thresh1=512 \
+   net.ipv6.neigh.default.gc_thresh2=1024 \
+   net.ipv6.neigh.default.gc_thresh3=4096 \
+   net.ipv4.neigh.default.gc_thresh1=512 \
+   net.ipv4.neigh.default.gc_thresh2=1024 \
+   net.ipv4.neigh.default.gc_thresh3=4096 2>/dev/null
 
 for i in $(seq 1 "$maxclients");do
   setup_ns "cl$i"
-- 
2.56.0.385.gd3acb90ef8-goog

