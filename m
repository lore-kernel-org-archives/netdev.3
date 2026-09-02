Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6774A411A1C
	for <netdev@vger.kernel.org>; Wed,  2 Sep 2026 21:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788384576; cv=none; b=jWBp/qTpsFklAooLh6ucXSP1R4/GYm25OT4GyiR8fdF4zZnvqgGYjhoYmIzTiRGThEBjTh7DasqpTCq6fLnXN+UMYoQfveXg+DRN4zqTBkbpI76TZOM6zq4yvcHiG/hX2ikm8vhBH0qDO/b7qsw5nTt8XJzZt8AHQmtlxlJj97c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788384576; c=relaxed/simple;
	bh=4fTOBu7ZmtSh/C3l6jTVpDrODpwVf3HW1zi4un9olTg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VK+0x2TWd7H1Yi0hxmdTBWLn3a4wb+VptqKNT4OVW4h7BG1C87Voz3KIJeRcWPY84A5NZ/y3Wax8GIwcqrQlz1ZO/R8ry1MMbmmapwjjwasGUCzi172zWc6DE4PsYwXXjAGhlWl9ZGsbB7fWwC/k6qzZb1U8SCCWsnD8072t2jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=v8pC8Hko; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="v8pC8Hko"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-91034716d1dso5903296d6.2
        for <netdev@vger.kernel.org>; Wed, 02 Sep 2026 14:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1788384564; x=1788989364; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=W05eG7tDptWvPiRXlFUVnZdx6HhWTPdwO0Ji7A8VYos=;
        b=v8pC8HkobADCSt9CU5LgMwnv2jwUDlGUkfloTl9vY9HjSiOho7vBPbqfwVw++Iiyez
         FEjWuXaRCLN7KQYtXuuuXC3CuSfo9DiWFSEzirMgyFuTJhI5w8qt3klTsS3W1c5s0Un8
         9ScSS22HpEtsekMNW95Io0BPd3eK0JuA+4wRU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788384564; x=1788989364;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=W05eG7tDptWvPiRXlFUVnZdx6HhWTPdwO0Ji7A8VYos=;
        b=Jif325ChVqe3KqFKFqz0Tla69/j4/OmSGNPlTy7jFD56LkQAZVgIEPPcTNhUe94twA
         7CkGm7MEb+Qdw0Vll5rxdBzHR34dgKsWkOXRVEyXp/bYP7/N95vgP7/CijNa+XiK+oea
         r2ud5iWQggr8LTCbEDZPTHXrOGiFX6NoHBLyhdC6yIVeCh1SLelqGXsTjQXaJaI6BdUO
         UzbJO3x6Nrbo/uBU1iWyPTzJb0kNASXFi3nbKxEzkcooKZr0gsa2X2PlbCXgqWU7vGJq
         ZxNCea28SgKW1fSvo3h2Q9xWkXwz9TfXy8kbKTAubOYeKzpT4zyX9P2ZkY2HStqkn7pX
         wYuA==
X-Gm-Message-State: AFuF++mfJbvi5fNep8nkdUNOsLmR02Ec5Shx6yjX+zXmuSxiWhwdjz2e
	0awXU5PyWOZqNE7Qo0mwoRYAFFJgrUC2fvYhho5jmVgfKDz5/D1dD3mQslgXskgjNS6XElZuBe/
	GRBiqRA==
X-Gm-Gg: AYBFou0R8UD36qWV+N2t7Zn0HQOg0Qqc0GhpT4upaa/rJJuoF8XinL69mpiCDkUoznR
	9mCv9mpNfAgszLB65KvGCevtR4+dVQLyifsa7JVXMfZzCrlNpFCtIZ+AhIFsBmiW/QRsvv058ES
	j9Wt4VvW4DCvLm2MnNPG6GywONzoAEARlHVSX+MqJiInGED2AZ/t3nRyJTnZk/3YJFY+gzz85E/
	VrvRJrVg39heH59fO2vUfIbpFaKVZDn8mVS8d0I1e9ufVUjv8mTcL0LHiTWbPhJlVk6J2XDUrzC
	wTfjIZgu+s5MSJz9sYIdAkB3CWte3vMl8eZOK6GEwOpmXBlyQN75VWIvAzfJWND5iJ5wh2fD2as
	cfmlfkmD1lYFVNzEFVQW6MZdseV0rJVjTHkpwPARypu/2lHBovdebSanxQj/LeyDPct6SvolnlM
	pAdrqVGKcbFU05biSs23s9om2UVbvRvPtFWzrb34c2CEwuOPg7jvJFpRXnyczV9PJKGxdgBeakh
	ovwxdiIwF01xR3yY9rZmUHgRitz/lPP0l31dw==
X-Received: by 2002:ad4:5cc9:0:b0:90e:8424:4068 with SMTP id 6a1803df08f44-90eca39df2amr102399596d6.24.1788384559119;
        Wed, 02 Sep 2026 14:29:19 -0700 (PDT)
Received: from majuu.waya ([142.159.91.240])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90e9ee08710sm27169086d6.2.2026.09.02.14.29.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 14:29:18 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	stable@vger.kernel.org,
	Jiri Pirko <jiri@resnulli.us>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Shuah Khan <shuah@kernel.org>,
	Vega <vega@nebusec.ai>,
	Victor Nogueira <victor@mojatatu.com>
Subject: [PATCH net v2 2/3] net: reject oversized tx_queue_len at netlink parse time
Date: Wed,  2 Sep 2026 17:29:09 -0400
Message-Id: <QDISC-2899.v2.20260901233641@mojatatu.com.2>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <QDISC-2899.v2.20260901233641@mojatatu.com>
References: <QDISC-2899.v2.20260901233641@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

rtnl_create_link() assigns IFLA_TXQLEN directly to dev->tx_queue_len
without going through netif_change_tx_queue_len(), so a device created
with "ip link add ... txqueuelen 500000" bypasses the S16_MAX cap and
still triggers the oversized ring allocations in pfifo_fast, tun and
tap. The veth peer nest (rtnl_nla_parse_ifinfomsg()) and the
RTM_NEWLINK-on-existing-device path reach the same sinks.

Enforce the cap in ifla_policy instead: IFLA_TXQLEN becomes
NLA_POLICY_FULL_RANGE(NLA_U32, &txqlen_range) with
txqlen_range = { .min = 0, .max = S16_MAX }. All netlink consumers
parse against this policy - rtnl_setlink(), rtnl_newlink() (create
and change), and the veth peer nest - so every netlink path is capped
at parse time and rejects the attribute with -ERANGE plus a proper
"integer out of range" extack message before any device state is
modified (the RTM_SETLINK half-application wart is gone with it).

Document the bound in the rt-link.yaml netlink spec.

Conditions to recreate the bug:
- CONFIG_NET_SCHED=y, CONFIG_VETH=y, CONFIG_USER_NS=y, CONFIG_NET_NS=y.
- Unprivileged user in a fresh user+net namespace (unshare -Urn):
  ip link add v0 txqueuelen 500000 type veth peer name v1
  -> on the fixed kernel this is rejected with -ERANGE ("integer out
  of range" extack) instead of installing an oversized tx_queue_len
  that later inflates pfifo_fast/tun/tap ring allocations.
- ip link set v0 txqueuelen 500000 is likewise rejected at parse time.

Fixes: 38f7b870d4a6 ("[RTNETLINK]: Link creation API")
Reported-by: Vega <vega@nebusec.ai>
Tested-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 Documentation/netlink/specs/rt-link.yaml | 2 ++
 net/core/rtnetlink.c                     | 3 ++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/Documentation/netlink/specs/rt-link.yaml b/Documentation/netlink/specs/rt-link.yaml
index b80c2ac3ac31..99f6fba456cc 100644
--- a/Documentation/netlink/specs/rt-link.yaml
+++ b/Documentation/netlink/specs/rt-link.yaml
@@ -898,6 +898,8 @@ attribute-sets:
       -
         name: txqlen
         type: u32
+        checks:
+          max: 32767
       -
         name: map
         type: binary
diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index 81c5a6104dea..9ea4ff9c1e29 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -2285,7 +2285,12 @@ int rtnl_unicast(struct sk_buff *skb, struct net *net, u32 pid)
 	rcu_read_unlock();
 nla_put_failure:
 	nlmsg_cancel(skb, nlh);
 	return -EMSGSIZE;
 }
 
+static const struct netlink_range_validation txqlen_range = {
+	.min = 0,
+	.max = S16_MAX,
+};
+
 static const struct nla_policy ifla_policy[IFLA_MAX+1] = {
@@ -2297,7 +2302,7 @@ static const struct nla_policy ifla_policy[IFLA_MAX+1] = {
 	[IFLA_LINK]		= { .type = NLA_U32 },
 	[IFLA_MASTER]		= { .type = NLA_U32 },
 	[IFLA_CARRIER]		= { .type = NLA_U8 },
-	[IFLA_TXQLEN]		= { .type = NLA_U32 },
+	[IFLA_TXQLEN]		= NLA_POLICY_FULL_RANGE(NLA_U32, &txqlen_range),
 	[IFLA_WEIGHT]		= { .type = NLA_U32 },
 	[IFLA_OPERSTATE]	= { .type = NLA_U8 },
 	[IFLA_LINKMODE]		= { .type = NLA_U8 },
-- 
2.43.0
