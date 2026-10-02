Received: from mail-pj2-f14.google.com (mail-pj2-f14.google.com [74.125.227.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23E6436826B
	for <netdev@vger.kernel.org>; Fri,  2 Oct 2026 04:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790916684; cv=none; b=YanVgPT5SX8znJGqz763S6NKKF6/asiz3kjPyFPk8PQthbesr4OsnbD0dNdSoRz4NbeR9cN7C3oQ6LRQCBc0hThJkR4OEfox11cGBIQvTNTgzQJ1E4Euj+JmW7ojd7KAHwuSR1ToSd2C/ii/DboMVqTnNPllhSDM8PhWTFz8ggU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790916684; c=relaxed/simple;
	bh=EGguTxu+yiR4KwL1wKGNSQg0HqiyBt2K1DUYSLPw5F8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I1R0Hzpp9HYT3e8ulTDQk1qkGY8wcRNiIsf1cIZZL3H8SiyJEdK48PPPp28veO/cWpEFc6YMTumYDZPMzJtMcsAKaqtN4Y2wsWJmGw0quaFzRDFJdFuhyiSCfHL9gUjcRckha7eNpCHAuuVu++0rL7aOszrkN9PSowml641ZYXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pqSoiytw; arc=none smtp.client-ip=74.125.227.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pqSoiytw"
Received: by mail-pj2-f14.google.com with SMTP id d9443c01a7336-2d747f05ffcso34653195ad.0
        for <netdev@vger.kernel.org>; Thu, 01 Oct 2026 21:51:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790916682; x=1791521482; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZFYDOqsBqKsmqK8JD9bXDjgEMMt1l5X2G9myljwvLmU=;
        b=pqSoiytwOV79ViU1elSejbgGBkcNMAskEzMq401Kx4d7dUhfuvHewAnjf8Zq54vauq
         veu9TWfbv1FaossOguPAii++wGK5Nw7xnaXFrDgVI32n+dIOX+uPj3puZww5uADbbqEf
         Yd53W7/OA6xGTwkk1MikccdQzNbY4ncKdgeWCDBSA71HijTwRji73T1BRrvAx3rijgek
         68uV+/MsB6RPtBgiCW+k/mO/oFhQtJK2vugCY9wQ5atIbEPTpmdpvqIU/o1wtMh6j+JP
         v4KdijnQ6Vkmk2+0ggg5HtOaAyv+EZJTvoaVeL7G9H6YBZvW2Apdx48qvgQ+x8/20xr4
         1ktA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790916682; x=1791521482;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZFYDOqsBqKsmqK8JD9bXDjgEMMt1l5X2G9myljwvLmU=;
        b=ripvm8/0qQ9nY2arcTTaYJ3Qgt0wkzUWfhQPt2Q+kwtUrZmt4/kpfB3uPt+KQdKTEd
         qCSwurvS6RqXzDKVELC57Jk0HgM4abh2Q+4hUZyo2wH87E7YfBGI+Z37S3Esie9y7zHD
         qXm4tebvcjdGLBmS6pLfIwP3fbElvQs2ST8Q20er88PQoyVkgoPoA1Wcylof6PS7jJYX
         kW/EEEzV/wGG/u3qvb0srzWAlx9VgJGTROz9MsUxYqpQumP+G25S1U0bYWREf9j09cM0
         prtOTpjhFTL1oKljTAEQYetItwjxY7cgYb/TN+HRRtkOFeqmqWmZ7OPvsH06+j3+awE5
         8EMA==
X-Forwarded-Encrypted: i=1; AKwUvBytSrWpJuowHorzlxn8fsbRSpvrScojuazLNbgHbQbIzuyPVfzKA6mR/Xe8WGnzdXLxA/bOZ+U=@vger.kernel.org
X-Gm-Message-State: AFq9FYIqaizVazvVJNw+ifhqGBkSsDk8JZua/bu19EOUCnrslc5LBXYT
	l8h7ysX7Qzotv0WLa9OBQPbVOAyRxh6w27bn4VhPdkyWWqDzWJ7SpDy4
X-Gm-Gg: AYBFou2Jm2b6TXuPYF6XjkGc7iO1VZiW2pIOycXBfVcw4c3kqOyNmLtdD/s2sjxjBag
	FEMe1VSfdIM/hmjEd9xmSd+CSEphpThO5MUukIHH8mRk3fdaY5M3R5krK9jImk7u+4I4AuQgRl5
	N5LWpt16ryVBmISIc2RSiOpfhQoMB9/EjqWXn2LR+sc7XyaAxRnhJ88eZNWSwaeU/6oOl0Mn1KP
	BLA7YQ6sMVpo/syn1fEo6lvKg2tgK7YfJO/7xkmo+3QyHHGVVZOkhwq5XrOnb5Ocp8bmq9FsUFN
	zn4yy0O7EC+/GFrIqVe+RSfBJKkMHyWwulJwg7fpjrTFoZqTGvhydddlIY9rscHsKJR03D1ajha
	hnab75dLD4H+VbSxUGiyhdePnTW8AEvqeLbIIbMDipIdxl57S1z0iuMzVpcx2z8cf6wzHViWU08
	aVcLm68XnQhR3xSohaPwGXdfFyeyvyCWPUhnMx08y6cgmf3rnsZsTIlUhIeuFSKMPkj8GQAxrml
	qrxTOcYhpU=
X-Received: by 2002:a17:90b:35c3:b0:3a0:4668:4cb0 with SMTP id 98e67ed59e1d1-3a6cead5baemr1466604a91.47.1790916682376;
        Thu, 01 Oct 2026 21:51:22 -0700 (PDT)
Received: from ancienth-X870E-Nova-WiFi ([125.186.72.2])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a6dd3962f0sm642682a91.3.2026.10.01.21.51.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 21:51:21 -0700 (PDT)
From: Daehyeon Ko <4ncienth@gmail.com>
To: David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Vladimir Vdovin <deliran@verdict.gg>,
	Donald Hunter <donald.hunter@gmail.com>,
	Amit Cohen <amcohen@nvidia.com>,
	Roopa Prabhu <roopa@nvidia.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Daehyeon Ko <4ncienth@gmail.com>
Subject: [PATCH net v2 2/3] ipv4: stop exception dump when nexthop group shrinks
Date: Fri,  2 Oct 2026 13:50:59 +0900
Message-ID: <5bb7bd97411eb9db454464bf449107395e760f26.1790915964.git.4ncienth@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1790915964.git.4ncienth@gmail.com>
References: <cover.1790915964.git.4ncienth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 4ce5dc9316de ("inet: switch inet_dump_fib() to RCU
protection") allowed IPv4 FIB dumps to run concurrently with nexthop
replacement.

fib_dump_info_fnhe() uses fib_info_num_path() as the loop bound,
then fib_info_nhc() independently reloads nh->nh_grp. If
RTM_NEWNEXTHOP replaces a group with fewer paths between those loads,
fib_info_nhc() returns NULL and the dump dereferences it through
nhc_flags.

Stop the walk when the indexed path is absent. Nexthop groups are
dense, so the current snapshot has no later path.

Fixes: 4ce5dc9316de ("inet: switch inet_dump_fib() to RCU protection")
Reported-by: Ido Schimmel <idosch@nvidia.com>
Link: https://lore.kernel.org/netdev/20261001170513.GA1657889@shredder/
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Daehyeon Ko <4ncienth@gmail.com>
---
 net/ipv4/route.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index 5f2197874bebc..268d8821f7e09 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -3170,6 +3170,9 @@ int fib_dump_info_fnhe(struct sk_buff *skb, struct netlink_callback *cb,
 		struct fnhe_hash_bucket *bucket;
 		int err;
 
+		if (!nhc)
+			break;
+
 		if (nhc->nhc_flags & RTNH_F_DEAD)
 			continue;
 
-- 
2.55.0

