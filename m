Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F341047D470
	for <netdev@vger.kernel.org>; Thu,  3 Sep 2026 11:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788436544; cv=none; b=Cf2hnLejozKEMiYFkVjbBuO7z6Iufz/956ANTwoEOupUCPF/AgRa2bxwlzSsUC+b8OaJ7CFiQKMQWxwTgw6Z0LhWLmxg7q0vK9Kucm2tHCVnWkyDi+Ovz5++HBfYmc01jr1QolJLTHWA8GMcotafvI8leZAK5J0f4i+GEoPpBBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788436544; c=relaxed/simple;
	bh=DGBqDOeyzfNy+29WumkC3kdwnB2FhZZ+segPy9L+b28=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gq3cLkzR0+T7sJWBf5z2BxxVKAU9f9ve0PIAIUs1NJAfSoPy/Yed3ccT8OPuBregqoetDUrClsIkCvmu6cTMEihwmUYppw4fscbnP45g5oJrTIL3r3aU1LM5Liq6wRRtmQEo8rGY0bCD6mN4oC/IDxR+RgrvaIyT6Lwf2zSzFgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=VPNuweyD; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="VPNuweyD"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-38dc4553f62so2864359a91.0
        for <netdev@vger.kernel.org>; Thu, 03 Sep 2026 04:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1788436538; x=1789041338; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1i8Z8yZUed8BAdZrDOJbsKwDdPch3XADEoDyC5AXu00=;
        b=VPNuweyDUMW0NSWpt0dq7gvoO0kdJsp8RwtiTJ5k5T1waZ74uq7OQmwSh3/CPSkWXB
         oFymUSl644bEGqNLh8X8YtEoMEp5NuTDitior76S4ZWqWKL0oTLHudSKTvRyhmhq8v12
         M54y12mzEy9gnlfiYlQYuKhNkmSJo7YP2SxyAyViXmfXdN8bOmwzmqRHbUbivg479qZO
         llNZ0DE2f46vDYLl+Z3y/EtpZmEqU46MLWxQUQqlQ9tsiqFZbLckXUqndvJ9UrmJVzhs
         FwTT7p5EYOSxyGgH7uIwwFhvN0OfRqRKtv3eVmU1M6LM6/cI7WYywAK5Asixzz6hl5w8
         tmyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788436538; x=1789041338;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=1i8Z8yZUed8BAdZrDOJbsKwDdPch3XADEoDyC5AXu00=;
        b=UnHEZ27GrvktODVzcjswYM9T8lhcL8jw8ZQc9x/Pf4lcV76dUwU69uFmmCPu9BVS5c
         bnXRIptY/RI7NxYeNiYTUCVgHtQaq5s6vnrgxbcNarJGLUCfdIrqtEecYRog6GYFswWC
         N47F5ewARq3tp+LIj+CS5lzVCSte/6VDtyVVX+BLesbHjLpeV1sg55eXAIIBIbHIsFhv
         cXl6yhC/23FLgcWUSlJpvpxVlhAunhLjMY2v0QLzJ2wKoLQYUnN2ASmF1jO/Bed2CDqX
         /PM4MwfGkBMRVZCV9GcBJVzdKCCsxV63peCIhiMPqJBBKfKB01XDljZUzWYqrPObytB+
         HqoQ==
X-Forwarded-Encrypted: i=1; AKwUvBzsdm7LlbLtoW441Q+tbvZRgZMqrOwfwUlIDdfqb4MC3HVXzFlMJRVm3hi1j2f6KvkiobiJfkU=@vger.kernel.org
X-Gm-Message-State: AFuF++k0Qxp8FLiEH1K63Ir2ps95CjSfcKHOM26QlgW953YugtIIi0EA
	nHTooq+hynJB5g6fM9NxX7INZj8bS0h+q2C7/SkmBBNYwISWUjeSpX8gzCxlTI2Q4S7c
X-Gm-Gg: AYBFou3yknsrrS6RFXyvx8DWuX+SW28/YzsgLDDrcJJHiLoO3GmYkuABW/LbcG4dQAM
	L1drr/UzejsYxXtod4xG9PItgKcGUp/ZoL8CZTFbwddWqIcNzDaacadhpgoti5rJqAUVWuZR5N6
	ezw62Qcm5tE9rIy7UaoC9pHtTUcBZ0FTbmZ/vO7yE9x85OCmbzlj4fLp1Q2eGJcl0XAdKZiLt28
	XuRFC94d37CLEVvbeaGlVGqpmmYvsOveuwa2HMZi0BpmlSaXsjVCfpqrkxYol4ZoB0e9D2buS3I
	ywLVTAbTjHQ/YWRCq3Qbhk7JjjU0EmKdOJoKHobseAYyIBAezIGs6wUtHj+0bYaGkzQPaVHFK9d
	lBS6kE531ntXse6dv09ZoP6O35pxZMPqJmGT5Tl64AfPsUSqojatllEKJcCovOmwDvNtpSluWrK
	Fs6Z5055x2FnQAwzPC5pw5OctSOYCg911r0U0VHot35hE8g46rqHWJrwv3T/oEETjPPwr+9Pogg
	eOlbmhHzEuJAWAsQQkJo/ZwJpZM9jU=
X-Received: by 2002:a17:90a:f94f:b0:398:bacb:1137 with SMTP id 98e67ed59e1d1-39aee21a4demr19811899a91.19.1788436536858;
        Thu, 03 Sep 2026 04:55:36 -0700 (PDT)
Received: from b6ad5085b32f.. ([122.51.212.64])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b08bcc090sm5222206a91.4.2026.09.03.04.55.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 04:55:36 -0700 (PDT)
From: Zihan Xi <zihanx@nebusec.ai>
To: netfilter-devel@vger.kernel.org
Cc: Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	Phil Sutter <phil@nwl.cc>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Patrick McHardy <kaber@trash.net>,
	Jan Engelhardt <jengelh@medozas.de>,
	coreteam@netfilter.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Vega <vega@nebusec.ai>,
	Zihan Xi <zihanx@nebusec.ai>
Subject: [PATCH nf v2 1/1] netfilter: nf_dup: disable duplication in user namespaces
Date: Thu,  3 Sep 2026 11:55:21 +0000
Message-ID: <34fe34497e78fc763a3f93605e29ce2a3fd7438b.1788425393.git.zihanx@nebusec.ai>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1788425393.git.zihanx@nebusec.ai>
References: <cover.1788425393.git.zihanx@nebusec.ai>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

nf_dup_ipv4() and nf_dup_ipv6() send a cloned packet through
ip_local_out() or ip6_local_out(), so the clone can traverse netfilter
hooks again. A network namespace owned by a non-initial user namespace
can combine NFQUEUE with TEE or nftables dup and retain the clone until
a later verdict resumes it. The transient in_nf_duplicate task guard
has already been cleared by then, so the resumed clone can be
duplicated again and generate packets without bound.

There is no sensible use case for packet duplication in a user
namespace. Skip IPv4 and IPv6 duplication when the network namespace is
not owned by the initial user namespace. Keep the existing TEE/dup
behavior in the initial user namespace.

Fixes: cd58bcd9787e ("netfilter: xt_TEE: have cloned packet travel through Xtables too")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Assisted-by: LLM
Suggested-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Zihan Xi <zihanx@nebusec.ai>
---
changes in v2:
  - drop the persistent struct sk_buff::nf_duplicated field and nf_copy()
    change from v1
  - disable IPv4/IPv6 duplication in network namespaces owned by a
    non-initial user namespace, as preferred on review
  - v1 Link: https://lore.kernel.org/all/cover.1787903722.git.zihanx@nebusec.ai/

 net/ipv4/netfilter/nf_dup_ipv4.c | 3 +++
 net/ipv6/netfilter/nf_dup_ipv6.c | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/net/ipv4/netfilter/nf_dup_ipv4.c b/net/ipv4/netfilter/nf_dup_ipv4.c
index 9a773502f10a..c33dae248c47 100644
--- a/net/ipv4/netfilter/nf_dup_ipv4.c
+++ b/net/ipv4/netfilter/nf_dup_ipv4.c
@@ -53,6 +53,9 @@ void nf_dup_ipv4(struct net *net, struct sk_buff *skb, unsigned int hooknum,
 {
 	struct iphdr *iph;
 
+	if (net->user_ns != &init_user_ns)
+		return;
+
 	local_bh_disable();
 	if (current->in_nf_duplicate)
 		goto out;
diff --git a/net/ipv6/netfilter/nf_dup_ipv6.c b/net/ipv6/netfilter/nf_dup_ipv6.c
index 6da3102b7c1b..a5f6f074a7e9 100644
--- a/net/ipv6/netfilter/nf_dup_ipv6.c
+++ b/net/ipv6/netfilter/nf_dup_ipv6.c
@@ -47,6 +47,9 @@ static bool nf_dup_ipv6_route(struct net *net, struct sk_buff *skb,
 void nf_dup_ipv6(struct net *net, struct sk_buff *skb, unsigned int hooknum,
 		 const struct in6_addr *gw, int oif)
 {
+	if (net->user_ns != &init_user_ns)
+		return;
+
 	local_bh_disable();
 	if (current->in_nf_duplicate)
 		goto out;
-- 
2.43.0

