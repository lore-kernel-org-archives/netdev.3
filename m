Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CF4917A30A
	for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 03:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785296891; cv=none; b=bTck1LctvK/fpgbFBoWUHgS3R6CFXxJ4XWBYRrM9YNSw8HAyw0SvKr3pIO8Z+/P4//iiqWsb98387/IRvVAlsNPOmasdmuJk64FzsapyPMHTP1xe1XfUO8Qd50YteJPTZIMIHoXeQNe1fmdJJNx/cFv/sI3QnoPxWsExJioEi6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785296891; c=relaxed/simple;
	bh=P9nGJR3wq037sbZ4BCSnVggh+4PFS3z4B0EBS37VO8g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qq8kYz0G78SmZo4ird70ArkWb39z18zluVHZtuzvRXD/P8RcNguxvn/4IMoToKLc0hqQ6KrJzoDoKhKUpEMhLP2X6bVOYwNrEjQ0QT1ncP8246rxNBU3Uvw6PTJHvh10vMq9khNm4lF9F09xfNYBglHrjL7N14m8WNCF7KV1NRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mIQ65k8/; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mIQ65k8/"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2cacf197759so8369295ad.2
        for <netdev@vger.kernel.org>; Tue, 28 Jul 2026 20:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785296890; x=1785901690; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=j4mXarqLChjkLTj7P6sDrdVZlpiC+6o8xzReS9GjIp0=;
        b=mIQ65k8/ChweQkNT0a0PXC6I5OSBPAEofmc665+CgmRnfXELV1iNhpmjNH1qLF82fF
         qLMSNNQzcwnGONLuiwxBZk3V5n3vlRAy7azeqPSq1th890LyhLqMS1hvZ7fYIf8iPXIT
         e9gczM6Io75ZCIQvloUJWuMSQBcV7gs4xDnvH7LTH6AIxNcG8VVMyKqZuU64vMl7M7bN
         2aRvIvZaBsM+yzUY+56DIEdfmPTXon7xsqL3OsGxpIlygwhDG7sU41u/0CE7JlvTHQcb
         YetRHpV/UiEBKl9RAVjKUwejO/GuzlbDWa9cl74JmroWXGzNfYqcGQZoZ5xZzaeElXpz
         VSjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785296890; x=1785901690;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=j4mXarqLChjkLTj7P6sDrdVZlpiC+6o8xzReS9GjIp0=;
        b=UF/ehkjWa7y5MZ5NW/dYkhVCxVQW5kfy2i4u5v+aWwMXp0MT+da6li22KUEsU5PSkh
         fmPlu1JBebL3GEy16mcgOja72rMUibGiOlBJw/rr8cuYtSMROLVAeiak8EwLZnIRUFf+
         mXB7wC2QpaLEvYIZEjQx3fv/ezTvbA4x0CuovOL3KBE5MbuwJz2AK+3FibAfBV2kFCwP
         bwcDlVKhNxF8cFJrvLeeHr4WCyAa66Odwij31546RJiF/fo92J92kXMHxuul6aGkRy57
         OHScYD1VXPLS0w+nTM5fm2L/yAgy9TMhF7lHkqymt8Q9SO4Y8fw38DQXx2C+v0FGsI9w
         dZBg==
X-Forwarded-Encrypted: i=1; AHgh+Rpj+21qmbTlKb/dsUO4csHA2zOvc/2i3NNmQLR8g1il4xvlMzyH1DHijBOEdNHIkv1dznZ+UDo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2HFeqZBJHjbpBz9c1VJoaXxrvNSeALIqwals6wScU9UDAt2OR
	wb99zzjBwWJk5I22dz4GyDiZ5rXrwvSVJtBTZQ28SQOeLVWGg4ksrfKj
X-Gm-Gg: AR+sD11iAxlIK90871DGQ8fKkhcgpvFxj3jlRrqzwnCMaCIpIpv5df81fKpBq+6zVOq
	ILsJQ3ERA/hL1VaJT0l2mZPS+BsFL57GVZbrOck1AX7grLPA9zy5iHzYsYYK2WaZcbX8sJaq01b
	qCWpETqC0JIG/ZvqkpbkrYfeQQvTeW8mCm9Uva8tNuFCO78gfEqqo3iijjEZwI1TTd+4WJnSXm2
	/KLoTqnfsAz72+Qml7kZxwfWEH2xBdBE6All16Fq9Wcev5idEwlKZNFSgUCSRhQWWOTMat/4Sz5
	ON7BotbtaotwbtI5L6ZYmoD4xmor5KL/Hwnflgg/3Z/TzXqauU5EMHJJFyAGZVTpr5VmiL5COdV
	QPhzDHIX4qqRg9iZSHMfnpcvMAl7/xMTIOox99iptUo8kgNeX8Z0aYhcEGUeJIjDi/OQhA0vB6z
	Guw775WrnqN74Yj8cq3kHVlj9q7WzNah2jqwQ+rlT/xQzEDb9uIdWcakiJhbj4CQkyyU933QwkV
	W7rwOvmPg==
X-Received: by 2002:a17:903:3c68:b0:2cc:ffa6:4622 with SMTP id d9443c01a7336-2d016052725mr68562065ad.41.1785296890050;
        Tue, 28 Jul 2026 20:48:10 -0700 (PDT)
Received: from localhost.localdomain ([116.105.227.66])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d022a15215sm4544985ad.8.2026.07.28.20.48.06
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 28 Jul 2026 20:48:09 -0700 (PDT)
From: Yuejie Shi <syjcnss@gmail.com>
To: David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	YOSHIFUJI Hideaki <yoshfuji@linux-ipv6.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net] ipv6: fix Route Information option length validation
Date: Wed, 29 Jul 2026 11:47:19 +0800
Message-ID: <20260729034806.58923-1-syjcnss@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

rt6_route_rcv() validates the Route Information option (RFC 4191) length
against the prefix length, but both checks are off by one.

rinfo->length is the ND option length in units of 8 octets and it
*includes* the 8-byte option header, so an option carrying N bytes of
prefix has length == 1 + N/8.  RFC 4191 section 2.3 requires length 3
when Prefix Length is greater than 64, and 2 or 3 when it is greater
than 0.  The code accepts length >= 2 and length >= 1 respectively.

ipv6_addr_prefix() then copies prefix_len/8 bytes out of rinfo->prefix,
so a Router Advertisement with (prefix_len=128, length=2) or
(prefix_len=64, length=1) makes the kernel read up to 8 bytes past the
end of the option.  Those bytes end up in the prefix of the route that
gets installed, so they are visible to userspace:

  # RA with a Route Information option (prefix_len=128, length=2)
  # followed by a source link-layer address option, 01 01 de ad be ef ca fe
  $ ip -6 route show
  2001:db8:dead:beef:101:dead:beef:cafe via fe80::1234 dev veth0 proto ra
                     ^^^^^^^^^^^^^^^^^^ the next option, read out of bounds

When the Route Information option is the last one in the packet, those
eight bytes come from the skb tail room instead.

Reject the option lengths RFC 4191 does not allow.

Fixes: 70ceb4f53929 ("[IPV6]: ROUTE: Add experimental support for Route Information Option in RA (RFC4191).")
Cc: stable@vger.kernel.org

Signed-off-by: Yuejie Shi <syjcnss@gmail.com>
---
 net/ipv6/route.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index fc42d67e5822..5968ce5ad150 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -988,13 +988,13 @@ int rt6_route_rcv(struct net_device *dev, u8 *opt, int len,
 	} else if (rinfo->prefix_len > 128) {
 		return -EINVAL;
 	} else if (rinfo->prefix_len > 64) {
-		if (rinfo->length < 2) {
+		/* RFC 4191: Length MUST be 3 when Prefix Length > 64 */
+		if (rinfo->length < 3)
 			return -EINVAL;
-		}
 	} else if (rinfo->prefix_len > 0) {
-		if (rinfo->length < 1) {
+		/* RFC 4191: Length MUST be 2 or 3 when Prefix Length > 0 */
+		if (rinfo->length < 2)
 			return -EINVAL;
-		}
 	}
 
 	pref = rinfo->route_pref;
--
2.51.0
