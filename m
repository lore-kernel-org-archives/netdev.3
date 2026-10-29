Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793316465;
	b=sA/qG3QY2NJRzdB/nh5eb1VUB3SQbKacU/tRskrwTzoobhDRAJ4L57TYEMczg4AKTtHd
	 KByF/WfyyRr4Pzwk0IVzi4Eo7oL3aqjYGVbUF/bktLRGs79feMZO5Y8lpkkR2jBSr+JSK
	 I31L6I/VD/VyIhgcI20hCXvEZWw8PNdAAA1SQ6kS61T1v3412hZFHXkGm7RiUHBXn6njR
	 to5YEtVSuiBqGMQYZAncUjoVX4p7ghKFVu4KssjwBmjyGOoZdspYyuZolHTmTjH5XWpEw
	 BwgSW5eSHUZm6WqWd+++sxVhUDCkKud7tLHtLFK/astnduK3MxJtoF64UphaonJRkfQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793316465;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=VpNFSaEVPIgaitRWclY27M8HtMOzW/v4lrjfw3GGNTA=;
	b=cOtTivGwqfJRsaLXV82Uwk1+89N19GNWUO0XnVtTKdymwTZ2J6egDB6UB/ysTkCLabzp
	 trq0EC9m8J2CjlkIae+sT7CP9poSlxaDdZRpWtDL+WZ7o/wfsJE3FQ1h64PYUcTeCOpGv
	 IvLTUXr8BbKlg7g6z3j94AGpOlqH3bE7kDWWmkMhRKAASZQEWVtKIJCyaIMyEPjLaE6Ka
	 Ga5Xy+j5fzllYIuY+P3FcIlCOw8OkePrdnOXvPMvAgYBrLu+eVKqb7pBw7Goi/ILzsykp
	 pvGr7zNsJMmnUoP6pU1FygA/g84J8LCrgikwWSN0AqTkNf6Cf4TGAjknhextbpozajg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=D9aZ7Wzv;
	arc=none smtp.remote-ip=209.85.222.174
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9090D606A31E
	for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 23:27:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9090D606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=D9aZ7Wzv
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-93f269e335eso7662385a.3
        for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 16:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1793316463; x=1793921263; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=VpNFSaEVPIgaitRWclY27M8HtMOzW/v4lrjfw3GGNTA=;
        b=D9aZ7Wzvfx0yphYngHaag3ODs+QTcnPjozdlmU3oIz2a6h97M4mZm8/YYLLzQfV7Cn
         w05GuZxQxJeUaEtD1UXJWBdiR8GrpKIZhCdXgrU3hyFh56PPJT7nO9k3CxMsB8K2JLbD
         jRwxfh2HBafByWOrgVlA5h1CrVf4CD161eMYA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793316463; x=1793921263;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VpNFSaEVPIgaitRWclY27M8HtMOzW/v4lrjfw3GGNTA=;
        b=a0n4PN6oHBkCahKRDdj5TNYGZmL0C4eLzumSq/zeuDaeKPyUFi0mUujUNjqjqRD5Ho
         3CiB3svuR9dTHNvj156gqixVj5+S49LBv3k74MiT3qvpprxxsuVG75dgoup1ZqX7Zf1Q
         9PCoNmStU3Rum5heX2S+QcTwU3NXnyXpnIM1k3JgYEK3+JrL4atSLZ2KxztFRITYPTan
         I6xSCqswAchQKZ+shZcOZaS5s5p2wBD1To2ApXKRe5Tz2cfH5+tpM1EwPb+EHom1Qtqn
         ZiK7trC9pC6uUMuZPjL541rcjDXi0EAbcJxqFa6ClioZy2r+C9kHzY9iKT58HysTf/yd
         Y1aQ==
X-Gm-Message-State: AFq9FYJNLVlCT4+ceWR4NU6QDMviB3KtzJAKAG2n327HYzn+syje3vUY
	k9SpSXwhWgeQu1bDmNy+sEQiH8p1PE11xX9BUnOd++H53Frfd2zTYiq7icNrV5gj6LgUWISr2s6
	WB9g=
X-Gm-Gg: AYBFou2dCh98Jlt2Maz6pUpvrNOR/Q168r7Cf/uZJK/NUjwVZzpQ0UStSytYY0s1B86
	GvYk39Qc9WffHVGGoaKGnygz5KSRcjqB9+NmXl87I0129r64DXy1fVHcAoudA2IJbtqyZEQEMwP
	5LwlsrAQFEIjzvaeg35ryaHh4032+hBLz5NzHoEJzZTmxM8X8HJu20wibmU/sKtO7VFZTUZkOs9
	rvrFMJubJpV/fwji2q3ywbdp2z5B3GIZgLbhCHi4/0JGY0Gt5fpI8aMqkaWOZKH8h7vklfp64ut
	KiDzvaGizAdA55CLHiXsnh3OU+CTDlfO2/8tovUwZKsWHtS+23w1aGdhkMNS81gTbN5KOXimewC
	zDtiqcEnPDKBxq5R5nju3OJQgDUwMkb1f+ZRSZCPXPYZrQZAFBdpu9v9KGTFYcZ0Y6KzgroCfkg
	SuTW8QLRZutlBnQsWaJBHNZm7VLJKgineQUsQ+K1fI8Eeo4GCod97Q2nXDFPKjGhmm7mdXlOafR
	LHBm42sZehSzWWxldf2OJ0o6qr8ikSE3ps1PRwQAkj+mLWpQMpKklqxriGLpHiEjmYIPA4G1nzM
	/IvLF7IdbGECoDgl/9DFeX+nbtQIm0e9wavNyR7rmo1v0imxTnY+I3XNkZoNmP8av8psi8Zzj4k
	=
X-Received: by 2002:a05:620a:8005:b0:93f:611d:a18e with SMTP id af79cd13be357-944216ed622mr140154385a.55.1793316463321;
        Thu, 29 Oct 2026 16:27:43 -0700 (PDT)
Received: from mbili.waya ([64.203.83.2])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-94424243823sm5384385a.21.2026.10.29.16.27.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 16:27:42 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	stable@vger.kernel.org,
	shaos <shawnq1@163.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Victor Nogueira <victor@mojatatu.com>,
	Sashiko <sashiko-bot@kernel.org>,
	Vega <vega@nebusec.ai>
Subject: [PATCH net 0/3] net/sched: fix short-skb metadata and namespace boundaries
Date: Thu, 29 Oct 2026 19:27:36 -0400
Message-Id: <SER-NSBD.v1.r0.20261029191634@mojatatu.com>
X-Mailer: git-send-email 2.34.1
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series fixes three independent boundary problems in net/sched.

1/3 act_ife: encode a configured zero metadata value.  ife_check_meta_u32()
reserves an 8-byte TLV for a configured zero value, but the encoder
returned without writing it, leaking stale skb headroom bytes.

2/3 act_ife: require a full Ethernet header on egress.  An undersized
linear head can make the encoder read past the end of the skb data.

3/3 sch_teql: reject qdiscs from another network namespace.  The global
TEQL master lives in the initial netns; a qdisc created in another netns
could still mutate the master's MTU and flags.

Origins:

1/3: reported by shaos <shawnq1@163.com> with a reproducer, which was
reproduced and verified in our test environment.
2/3: found by Sashiko (nipa and gemini) while reviewing Victor Nogueira's
parent act_ife patchset; independently reported by shaos
<shawnq1@163.com> with a reproducer, which was verified in our test
environment.
3/3: reported by shaos <shawnq1@163.com> with a reproducer, which was
reproduced and verified in our test environment.

The three patches are independent.  They target net and carry a stable
nomination.  They are sent together because they share the short-skb and
namespace-boundary review context.

Jamal Hadi Salim (3):
  net/sched: act_ife: encode a configured zero metadata value
  net/sched: act_ife: require a full Ethernet header on egress
  net/sched: sch_teql: reject qdiscs from another network namespace

 net/sched/act_ife.c  | 8 +++++---
 net/sched/sch_teql.c | 5 +++++
 2 files changed, 10 insertions(+), 3 deletions(-)

Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
