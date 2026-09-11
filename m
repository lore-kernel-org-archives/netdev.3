Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5195B43F4B5
	for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 10:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789123878; cv=none; b=mGRFs/NAClGc/xZxHsLf9yOjSfyaFTjKc7LoBHfrkIv+Gp8MSFK7Hw79vIEGNVdGByubo5k73HGX0BIzu8VgKXMdu65M5akxGUe3X1SW/663MCJE7TcLT6sD8A7Nks5OcunVDksELSs8OqtUO3NaDrXpcyhqRBltA15ZC56GFZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789123878; c=relaxed/simple;
	bh=tUSiW1gzmcpR51eI+ftkT0cq87urkbDu1YspEiOmjAQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z8WsGtxayV7BVKgbZXkn9KDemHxTi0kQP045gArqd+W34VRI2y8NDf6JRlD6BznZTYVrQB3my43jrC/ZYiQmXZvpmCQGt/vhq1IqAc9qi3yOmhSvZs7udQPdYynp+r6fpu/SE9YLmwY2v9RsPe1TbGSGcQP9k9caYuEWWT8d3os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qSvBVO/H; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qSvBVO/H"
Received: by mail-pz2-f12.google.com with SMTP id 41be03b00d2f7-cc1ceb47d53so97752a12.0
        for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 03:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789123876; x=1789728676; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Dy3tPiCmSC6ac2E9SuBSByLfrAsVVo0KwKwuZ8yfA3I=;
        b=qSvBVO/HtLiTvZM1LsrL9FHKC9u5U9o7eW2GW28bNRhwyuBPPuDQAaE5DysJmMuSKO
         udal2XWtTqwFPTZ54T3NWcqIV+9MeBgE600oPPduQPauqxZuzsQy4Z5FXLuHAT67SJ/9
         1Sn7TrUvOKFK6FIPddGwsL8bbcyhvqvqkHMEwls8yjyY0F5e+XINsASLaq1GMppfXcvO
         Y0Ykjdrm4N5NRZSNzZHPqQI4WfYJAnP0wQ8uw/Er+FUZC//BjIolso+yR89fray3pmFA
         dXUn5Qjrf8sv+hEf7KCNC52xPndtwTB3nocHAN+vCt4GwowoAup3f8MOKxZsxWkgieZs
         AW/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789123876; x=1789728676;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Dy3tPiCmSC6ac2E9SuBSByLfrAsVVo0KwKwuZ8yfA3I=;
        b=JQp4AFnlUoAmpKhSdpmuxoldWlJbM/L1ey/h1CLPn8Tjr0wArzg2JztFlQ7AHOOg3l
         t15Kfrj0fmRokjFcNi/MVSXkm/tL6nzNFZZbrb/59BC1DfLi3X8OqECa0Zs70DSTRKsU
         vhPciATjSiT3dn+9mnr0/bCApoFSgJu/2wgpkM2NCo3jQTcCYiAf6kcevI6ClCJheeo0
         /KdMVXYd5VJgMC2fyyv/NU75PrQ7FM85dPhG2B0Kh3eeMTDe1qdArgijL2L0BPwvaANb
         X7ISXotTEw7mckU2bVzFkhcczlpOjgylpHTE94a42FON4OYZaCY7ObiEWJ2ycIZWmJZA
         JrHw==
X-Forwarded-Encrypted: i=1; AKwUvBxjoHcUwmZNSxXAmtwYWbnzwHJYFoT9ggB9Sk4BDDrcnmJwi+Fj63vx1Fj8j+bHCV8CtB+stsU=@vger.kernel.org
X-Gm-Message-State: AFuF++kNrAvyTofVYQ3o6V+KzMkoLll6/JlbloNsVPMa6BpenpM7bKzI
	sQdQqEggQuxr1BSj2wSrLBw/jeBVjSp4kGQFCz2CkK2A2JwCRLQfG9aF
X-Gm-Gg: AYBFou3RCACj9bn+XgoXzsIRhpdatC7cwE4TkZualJlyKr44SHXYotSvOqlHqkFppY+
	y5NP2hZmvJJg4N9qKzjTATpfE/gf26i6xx16qeEcbvUvc4nDgh8leuE2vBjDEAgh9jMyZ6/lcQy
	QFRzns4BR1ITEO0S5CSMpmYmFHvqA59q0QWWbO8Gk9B5xsetBXUZhcIjhY/BzhvFXtAmu8NxYzD
	9f2edPc0aYVTc5t1hMC52WeGernmAlhsEa63XdY2KDuNAvAL/0636ENNIBzRcjLqz+jnn1R1EqX
	gXmsaI5+5ZyiyxJiFf3Li45nuKo9nyBB/McZbAwW4U/AW8FoC3MyX4q8AFrz8Cf9O/7g1Hop4U1
	pgYM6JeCD75VazPLAIck5B+Vv8BDQCn21jVTawon5i1UihyHMQAcYBxHEy64q6xqJ827zdTCeSf
	fgt2+4nda0yXk5gxypYj22NxiKPjoLv9cQ8jTPxt98jbA6HDsUzEPwOtae2RtDqKIewHvi2lQff
	gJY1AB55gCnmxkvvX60/PNhQG2ZiX//N+k/ESGIW8TUk2Ap7BkilBWEibJxpQ==
X-Received: by 2002:a17:90b:578f:b0:398:c6e8:3fc2 with SMTP id 98e67ed59e1d1-39d97eea626mr3603449a91.4.1789123876272;
        Fri, 11 Sep 2026 03:51:16 -0700 (PDT)
Received: from m-upc-A520M-HDV.flets-east.jp ([2400:2410:3f60:500:f7e5:8b43:47c8:5245])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39d94bafb3bsm4876004a91.1.2026.09.11.03.51.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 03:51:15 -0700 (PDT)
Sender: Yuyang Huang <uyoko90@gmail.com>
From: Yuyang Huang <sigefriedhyy@gmail.com>
To: Yuyang Huang <sigefriedhyy@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Nicolas Dichtel <nicolas.dichtel@6wind.com>,
	Nikolaos Gkarlis <nickgarlis@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Shuah Khan <shuah@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Stanislav Fomichev <sdf.kernel@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH net-next v4 1/4] netlink: specs: rt-addr: fix the type of target-netnsid
Date: Fri, 11 Sep 2026 19:51:00 +0900
Message-ID: <20260911105103.7771-2-sigefriedhyy@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260911105103.7771-1-sigefriedhyy@gmail.com>
References: <20260911105103.7771-1-sigefriedhyy@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The kernel parses IFA_TARGET_NETNSID as NLA_S32 and rt-link.yaml
declares its target-netnsid as s32, but rt-addr.yaml has it as binary.

Signed-off-by: Yuyang Huang <sigefriedhyy@gmail.com>
---
 Documentation/netlink/specs/rt-addr.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/netlink/specs/rt-addr.yaml b/Documentation/netlink/specs/rt-addr.yaml
index 0ecbd24c890c..17ead2203451 100644
--- a/Documentation/netlink/specs/rt-addr.yaml
+++ b/Documentation/netlink/specs/rt-addr.yaml
@@ -119,7 +119,7 @@ attribute-sets:
         type: u32
       -
         name: target-netnsid
-        type: binary
+        type: s32
       -
         name: proto
         type: u8
-- 
2.43.0

