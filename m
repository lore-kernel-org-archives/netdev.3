Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B6CF5540A2
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 20:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791925106; cv=none; b=CtqtRP84UZ+m11Yz+EuS2O1bPGMUjWI8UCV8AtR2QSc0dZcAt+0nT9EpZbMp4x6hKNmI1joYWw2W4MZwahtJ3+8ftuaaQm9O6Qur4h0nU7hbEkXNoO/1s0bo2BtB0MdfV1EaC5aMUX1wqmrdmjI6ABmdgKueM6MyfiEw+4ctWCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791925106; c=relaxed/simple;
	bh=lWRqV8x5Cg8ZZwS///8STniw0n2PyvlMRvAbapqw/60=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=oUGCQzbbE2IscTXZ5sR48cQvP9nJkipgoRjr+yzbr9DmSzHCkR4mxd7uViLNFUcl+/9YOaNx4SYjEw7ayRo6LkauOB5kf7zqoJUisapJzxHPod8LcilWgopT8We8ypGzFLVr2Am9N90iYJ8nLq31OCKtpSgXISNW6JYuZsemkw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VDEUSW4j; arc=none smtp.client-ip=209.85.215.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VDEUSW4j"
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cc795ad1f5aso3194897a12.2
        for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 13:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791925104; x=1792529904; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dqKiqkfmYAEix4q01+y7kSJwyugblM+mE6iJZWjc7Nc=;
        b=VDEUSW4jZSsjYLRM8yF4TA5VTLu2eymguh0yCs1LAMvEHLhs91TibE4BEUKqIb+gNt
         rt5Jfu0q8P0izCH2rJqZzns6XwSK1+QfWSOm1wQlBjkPMnvBZ/SK/6AiPWT+zWlZ3a2/
         Y93mNefxZdSVZ0tji80rD3nuMPGElrbWfoN1D6KxDj9BYnrUeFSbczlFn/8yDB2IQVcZ
         LXyQy2tWPmWDpa9PAne3xSTIqcAOtBX7731evGtD1hzdSSiLdO9HpuSRoh5I8LJ/+64e
         8dT5TvZMw85T39pmQBgqwYnXzZtGX2/X13Iia8L73WFp6GC+3nSESb5hExYmfo/kjtD3
         GTxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791925104; x=1792529904;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dqKiqkfmYAEix4q01+y7kSJwyugblM+mE6iJZWjc7Nc=;
        b=QYcbq5XW9Ok8XcliNJlYAugDjprkxY/7W1PHsdIBhge6AiEXOBo801Au2bt/jBxOPG
         72VielNHb60XuEylaQX4P2nNER+6chmrj/dPXhPA/pgLagYNl5XMjfrlAeQG9hik5qGi
         fB3DQd297OjOr9UhnwshHIzqPgqZo7dhfplYpQXubrg9XwQaXm8BinbIMCJxe+jZQ1uP
         IDpZAJk1QGZsB1wQVAv8CuIE2OlSajfYYpVQEl0/QT6foGZV7QJrxtYuC7/ifxY1lL2G
         /XCu8OuLzLqxbxBIT4kFHHG9uN6U6pFxwZAGwZQdbgsBGAbvsldFICpbGhvcNb1mVjZd
         xUHQ==
X-Forwarded-Encrypted: i=1; AKwUvByucPMimIAhsFTmYCJqte/71aVVZCdUU9hdhTILwh8SDm6/s2qlprRGHZAawiTeGOiE0+8xv+8=@vger.kernel.org
X-Gm-Message-State: AFq9FYJAVv9Z47jY9ZzUtu4AegkQFWXpUh/X382CDPtnAV2BoqkuuPg7
	4+YJ39tFCJ8UpM3rETRxCDC8FeyTAcumni8yazS9UNv44q8bIYxgO8MkmiD4Vq8Tht9zgku3Xk6
	G+YBkiQ==
X-Received: from pgjz1.prod.google.com ([2002:a63:e541:0:b0:cc6:d405:8595])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:6e86:b0:3e1:a0c7:4009
 with SMTP id adf61e73a8af0-3e1a0c749a7mr6543696637.48.1791925103394; Tue, 13
 Oct 2026 13:58:23 -0700 (PDT)
Date: Tue, 13 Oct 2026 20:57:29 +0000
In-Reply-To: <20261013205816.1642597-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261013205816.1642597-1-kuniyu@google.com>
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
Message-ID: <20261013205816.1642597-3-kuniyu@google.com>
Subject: [PATCH v2 net-next 2/5] selftests: netfilter: Set gc_thresh[123] for
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

