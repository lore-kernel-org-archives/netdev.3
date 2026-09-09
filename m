Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D161E2222D0
	for <netdev@vger.kernel.org>; Wed,  9 Sep 2026 01:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788917667; cv=none; b=S4gaa5en2vbTOmXKiQpC0GKc0elcQTWO0vSzoPczDz1KI3hg18xxNvP0/SraBQjb6VtFh1JWehiI1nkHAsxiIp8PkYTJ1gLVw+vpdu/OKtuEzl9IwSJmLDqjD1QedTiO2b9bmQ8W+jpHjTiDRl3M9vrnlsa8a83x2u9Y+nBgJQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788917667; c=relaxed/simple;
	bh=EBcVrnHHrPyxRqOOfHraM7Cj3/vhEau6in5geWEuBBY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Nhdv4POwAuKF/Epu1CYbqx49bO89Yb7tDY+VxY3W4oG7a47RqrSRzRCFbyHJk24sWYH9SPqarQr3v6VCvAxGNurgZjync6+MC2ZP+w8NktHt2QwpWVwgVTokeIwUYm2FN+EKbNLjQa7IsGo2a2/ggZZ7+nppLUbuD14cApo0yfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YHdZjFbX; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YHdZjFbX"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2d01663d816so39051675ad.1
        for <netdev@vger.kernel.org>; Tue, 08 Sep 2026 18:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788917665; x=1789522465; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=S8HXgsUe8d8r+ydmsF6B29V68PoRsQNSsTVHaoSKsZs=;
        b=YHdZjFbXru+P3dI4PKsQEWHpFqaLzTuEdlhbuZXGIv5YHGqBLzD6Rlm0+a906r1PH4
         EFo94cOAzMpwsb2InEy6vSeKEuxKcx/9W0Xnk4T7q+SvP0JTSLjRdhSga8Y1wGFh+Eg0
         GG9s4bbZ5jBVTmq3OAS/wvFRvq4ZSO4vefz17S602WuFi/womfuesoaVIeUvRDfk4M51
         DtzzB8nliYkeo0t7ww2yNREWu8GmubxtB5GoTKvUXLaSM9cU5vfix7zlr8YiAX2FFN/5
         WQvTH7aWdb49znrFoX+5Qsi/Y0p0LN8+P1Rkt1sLMnAbIoJAOZbEMdNEj467EuektSfO
         5nLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788917665; x=1789522465;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=S8HXgsUe8d8r+ydmsF6B29V68PoRsQNSsTVHaoSKsZs=;
        b=Y8rkEaVCtTpjoev6C3cDVfw0rXGXJWm/9/Op031potGKRmyxRKK1pnkzDWQ3AhYO74
         0yjb7jkk44bAr2UbPGl18KSUSE69isyc9QUCKf9OQbGCV/K4DCl0lbfbGJftb7tS6V0V
         ILFj9JCPuhf5Ir8g/eTnUl54X5pSdKthDrKopTunu+twPi9eCZUJtH9kVWCHS5w6Fifr
         +w8d333r2noiRtOjX8LOxD8PDHQVUxnqeWR1jsdBDbWDiluA6ZCnVowGsBF54mnl1rnH
         786uNKVOdL6f6ebjLMHG1gW3PYF5VgudlaG++x/zLssSlkw+WAq6kt7GYWOKODh+uqpz
         CLGA==
X-Forwarded-Encrypted: i=1; AKwUvBzvXF9H4f+RJ7c1By31GI5Q4J4nrJGnnZF8Dl+OT5PJXsEtweP86/Mp6hqCihuFIw0invMJ4j4=@vger.kernel.org
X-Gm-Message-State: AFuF++lJkX+8JLIlBvfMT4ktq9tmiBryd/tgCUS9+/8i/h5CmuVXupDG
	HR5cuoibwPnATYCO06QX+FhgIS6ecqKlDWWo+nvNgVpQ9Z7FdC57TE6t
X-Gm-Gg: AYBFou19wHIhJjgJSYbQDv6kY8TPc8Bt7FLFBds2KyBeNaVj7k4TP/eeQ0Rcza07ZjZ
	S4RyDTPQiZfzOH1WKXqxfQmaq4k6hIdSWgHSGAFWlLwZU89QFijQQY4olL8sanmEVU6dxd3uHBK
	Mb8dQ//5mgnLZ2LED8Zy1bs+ARs0W+dVZLL1ND01geFRYo1Dymx+rl2xeYn6vm/3p8uK7Iduayj
	1kVak46egrFkfDgYfxpAVBAZLcXxEQM3pvrHFmKQsDQ3XejIdDX+1GrCa1/vRg7INBmJCW8F4Hq
	7MnZ9HterO494nDSovrYRJf8/BMgi1VpZKRUh0XvBKNFfVETjgiYrbvRyvpAKF0AQJLS23aSfSg
	vDRnwCOxrnmb9//s1kOrnNw23SKMAjBSU/wxh2OB+bLS7dmrneCgZYCx9Qir/F+T4r0iSTlhg4r
	9aJlULlhgz6sDH6mlEwNO4ln4tG3yxjoe8576//IdaHplrL4uCVbkxDQPPMzAQ1pJMni6DCS16L
	oYc7nYU89XKAhlrot4OGIwaknXggCS0bK0Coe/luBk7BNWRy8eq0Z/LStLFtw==
X-Received: by 2002:a17:903:22c8:b0:2d7:5ebe:a588 with SMTP id d9443c01a7336-2db126d6e31mr456681265ad.13.1788917664922;
        Tue, 08 Sep 2026 18:34:24 -0700 (PDT)
Received: from m-upc-A520M-HDV.flets-east.jp ([2400:2410:3f60:500:574b:e1a5:307b:15c5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2db63c00837sm27975145ad.40.2026.09.08.18.34.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 18:34:24 -0700 (PDT)
Sender: Yuyang Huang <uyoko90@gmail.com>
From: Yuyang Huang <sigefriedhyy@gmail.com>
To: Yuyang Huang <sigefriedhyy@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Ido Schimmel <idosch@nvidia.com>,
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
Subject: [PATCH net-next v2 0/3] rtnetlink: dump link-layer multicast addresses
Date: Wed,  9 Sep 2026 10:33:58 +0900
Message-ID: <20260909013401.14408-1-sigefriedhyy@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

"ip maddr show" prints three kinds of entries: link-layer, IPv4 and
IPv6. The IPv4 and IPv6 ones can be read over netlink today: IPv6 has
had RTM_GETMULTICAST for a long time and IPv4 got it in eb4e17a1d915
("netlink: support dumping IPv4 multicast addresses"), with IFA_MC_USERS
added later so the user count no longer has to come from procfs.

The link-layer list is the missing piece. dev->mc, the addresses
programmed into the device filter, is only exported via
/proc/net/dev_mcast, so iproute2 still carries a procfs parser just for
that. This series closes the gap so that "ip maddr show" can be served
from rtnetlink alone.

Patch 1 handles RTM_GETMULTICAST dumps with ifa_family set to AF_PACKET
and walks dev->mc under netif_addr_lock_bh(), no RTNL. The reply reuses
the ifaddrmsg format of the IPv4 and IPv6 dumps: IFA_MULTICAST carries
the raw link-layer address, IFA_MC_USERS the reference count, and
IFA_F_PERMANENT is set for entries added with SIOCADDMULTI, which is the
"static" column /proc/net/dev_mcast has and "ip maddr" prints. A
non-zero ifa_index limits the dump to one device.

Patch 2 updates the rt-addr spec and patch 3 adds a selftest that
checks the filter, the user count and the permanent flag on a dummy
device.

Nothing changes for other families. AF_PACKET dumps returned
-EOPNOTSUPP before, so iproute2 can keep the procfs fallback for older
kernels. I have the iproute2 side ready and will post it once this is
in; with it, "ip maddr show" does not open /proc/net at all.

Changes in v2:
- Always validate the request header, not only with strict checking
- Use a single "with" statement in the selftest (ruff)

Yuyang Huang (3):
  rtnetlink: add AF_PACKET multicast dumps
  netlink: specs: rt-addr: document AF_PACKET multicast dumps
  selftests: net: test AF_PACKET multicast dumps

 Documentation/netlink/specs/rt-addr.yaml |   7 +-
 net/core/rtnetlink.c                     | 129 +++++++++++++++++++++++
 tools/testing/selftests/net/rtnetlink.py |  57 +++++++++-
 3 files changed, 189 insertions(+), 4 deletions(-)

-- 
2.43.0

