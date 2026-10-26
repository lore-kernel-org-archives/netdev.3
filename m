Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.227.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792990095;
	b=qtNDtyWXd6sGcvzp8QwgVLsVp+HdocAJp47aSp9GgInvJ3flg/JF3SjeFrOpH4xrV6jn
	 V+TJXg6eWONfLq3YbnupnFVWug4JkARnfFI7Itjyc5JqY1wUmVArhfyR/8YkR0vOlq0i/
	 17Tpcn/ZplTB3WCVBOk/6PmTbj+9DjvrDItJ/VjAXA/nfkVs051l4GmFmYu/Fqhb0Vb06
	 Etf7bcwCHkCe+gLaaQVnQAGHJbhCivlcyuW2qCMnp8BjhY+rVbYpR6PEoIYn3kk6TFD2j
	 0eCdqU8P+7qzSBeU6L7683U2l5puVFCcQv788pI/0gCJjOVDIQm3gwEtj3XU3qkXDvA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792990095;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=k/JB2/vnEe/nhNkdsVP6HUPiRtdVAo3aP+vpEA0X8co=;
	b=dMWH9IYCECfLHBaNnwx+3s7/bUgqwceTcNUGgrQmKHKxwAxGK2MiTPuOMilDyfxtyJSp
	 kuPuLUVO7UkSDRri78GURkcvzF8Pmj/SDNMMnWuZYRI1Rhl7FpfgeAIW0TunCbaz1rk3Y
	 UxwoG0J6iYdTZQhIEBviEUf4vZ8Ca37fzxQPzizeUxhFAc+zT5KvMA3Z6KWnk+Kd0p2ZS
	 66t4PGGHJg8v/3iaE8qqxxRmNFd62TM9JPQP2dXjhPnACjgxLeT7MabamZ/95bpgwZUcE
	 uEXnLgWYuNDGrx9yatAEJS8JZ7q1gJQ1zuT5YISFTJmPuPdy4tylymjvhwV3v2ANzTw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=EJ4WlZTI;
	arc=none smtp.remote-ip=74.125.227.130
Received: from mail-pj2-f2.google.com (mail-pj2-f2.google.com [74.125.227.130])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6674C606A31D
	for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 04:48:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6674C606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=EJ4WlZTI
Received: by mail-pj2-f2.google.com with SMTP id d9443c01a7336-2e613f813b0so4026405ad.1
        for <netdev@vger.kernel.org>; Sun, 25 Oct 2026 21:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792990094; x=1793594894; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=k/JB2/vnEe/nhNkdsVP6HUPiRtdVAo3aP+vpEA0X8co=;
        b=EJ4WlZTIcbgcuKmwpDrhJsKZFt4OasvMx1uaaMfnCbhaVB6Ea1F7Y+cZqMypQOXwiz
         kjbvhoR27SoMV2Qd5nAecC2UwvkICePmaWHKy4f7rsompsKYuHIM00xbm1QzYwo4Vees
         PrEiq48okHVRgJf2K24pzMrQ6avEYt5Efo8E9Pz43NvR8bPM1x2BrLud/DjVXhl1Bkbh
         LNht6Fx0WANuYi/OPP6T3O7Zt78LfSv44bnEz7hkanPLZERqvk1Ce9His2omPpYiNuIj
         S9Oe0yOmatN+pzhxEPHbYECcxbi51p8pmbigwifs9dKspLf2Yw6W1+h26/LqlenfOvCA
         Qgiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792990094; x=1793594894;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=k/JB2/vnEe/nhNkdsVP6HUPiRtdVAo3aP+vpEA0X8co=;
        b=SIlLpx+UiLMx6YVJWwSCC3Tnm63fM0hvmlazqkl8w24iaLi9kSgRgzFHHgFWU3UZ4Q
         0kLIEc+FJVStAwzUsJc4ILY6jaX4+jB96wAtMRclzxwW3N0hztKNy5pvQs31tMlevqyf
         gZXXbkkGqzG5XIQC+e7ScePYy/Y6ZyPbnZJfxNbDWZiNOngrF5CrWKwHQaiFsZmKyH5T
         i6rbsIbPEx03eZJPEjfchuA3pO5OjnWVcUonBBq3PBF/raNCq+LY3Dk2ZtU9fXLwpSqJ
         0r/Ou/rnqs/7Xv7aiTiwYNhpafCYckKtswMp0mdEOxqMo1E+YutN+Fh4Wz9/Cn4r0PEe
         u+Kw==
X-Gm-Message-State: AFq9FYIk4U0z80u34AkR2BSCwpQw9z4DaNt10m8CPXgGGQB2oryKrP92
	QI5zdTV1Om7Vt5h7KJpiSuODDLM8W+CeyaFJRi8HESP8t2YOqxQNZfMrJpcFVk9UYB70gw5T
X-Gm-Gg: AYBFou1zE8jKQ5cQ62VNfwRfKf5r/Em3APngHyGDyYtULK9ZjrsFibsUJpt7XXK2KVp
	xjF+WkQKzfMadn523ZrEDdw8BaTzSJyMl86+htpXpD7g60CwWX5PgoWKNu+e/e3PAHTHdGL2wmM
	w0XiGKxZ8XH52M5o+TIPRYvnehiM0Ifh5TT/in+3ki3ABlp2/WVZBb4xtLJg4onlp2CTMv5pypt
	12/Xk59s/oGPvK1eKtX9gPuGtZ40RaG9afk3o6y2A2Y5hPQYzFAICRxWsEpE3/hpiXzgJrEXeXL
	kGcG0JyThCZMeUNnxHFyCFEh8fttf/vRUzHEFqR5NWElkgzeQjlEK5CD1vltDUbnbkcGSOD95J6
	jiR4l4hBjslCXQqvjZOE1N2a70nGjESozdxtTiaAkrO/8cxv6qcTrXeHWHQ1c2lmt9tyfpUNkTv
	40SgpuQvJXJXrXnXzQ7jwQRaWTIzerVJ94lk4MWJoCAyI+tR1DGOhdOCqHz0Rf5WpY2iRBXQ7Om
	Kn6V6iP8iRGoDhw0EwuyiekQWCumGMX4FQwkujOt8jM4C6Ru2AoOu5Oj+f8ov4NNOzKxt+qB5LO
	NFEttyo9jwhg4CDHp4E=
X-Received: by 2002:a05:6a21:880e:b0:3de:3f4d:f2bd with SMTP id adf61e73a8af0-3e7db876af6mr2824220637.6.1792990093603;
        Sun, 25 Oct 2026 21:48:13 -0700 (PDT)
Received: from LAPTOP-0A59PORJ ([119.234.82.208])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8a36e7fbc64sm858163b3a.24.2026.10.25.21.48.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 21:48:13 -0700 (PDT)
From: Zhou Qiuyue <n0ps1edzz@gmail.com>
To: netdev@vger.kernel.org
Cc: David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Hangbin Liu <hangbin.liu@linux.dev>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net v2] ipv6: raw: fix use-after-free in rawv6_send_hdrinc()
Date: Mon, 26 Oct 2026 12:48:08 +0800
Message-ID: <20261026044808.613-1-n0ps1edzz@gmail.com>
X-Mailer: git-send-email 2.50.1.windows.1
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

rawv6_send_hdrinc() caches the route before handing the skb to
l3mdev_ip6_out(). The VRF output path may replace skb->dst and release
the original route, leaving the cached pointer stale.

The function later dereferences that pointer for statistics accounting
and as the output device passed to NF_HOOK(). Its RCU read-side critical
section starts after l3mdev_ip6_out(), so it cannot prevent the old route
from being reclaimed in between.

Reload the route from the current skb destination after
l3mdev_ip6_out() returns.

KASAN reports a slab-use-after-free in rawv6_sendmsg(), with the route
allocated by ip6_dst_alloc(), freed by dst_destroy() from rcu_core(), and
the related RCU callback queued from vrf_l3_out().

Fixes: 4c1feac58e06 ("net: vrf: Flip IPv6 output path from FIB lookup hook to out hook")
Cc: stable@vger.kernel.org
Signed-off-by: Zhou Qiuyue <n0ps1edzz@gmail.com>
---
Changes in v2:
- Rebased onto the current net tree at 7076f684d513.
- Regenerated the patch with git-format-patch so it applies cleanly.
- Corrected the Fixes tag to the commit that made the IPv6 VRF path reachable.
- Shortened the code comment and added the required recipients.

v1: https://lore.kernel.org/r/6adad51d.8fc0b0c9.1ec657.1868@mx.google.com

Thank you to Hangbin Liu for reviewing v1 and pointing out the submission
issues.

 net/ipv6/raw.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/ipv6/raw.c b/net/ipv6/raw.c
index b965258cf..bdea82543 100644
--- a/net/ipv6/raw.c
+++ b/net/ipv6/raw.c
@@ -654,6 +654,9 @@ static int rawv6_send_hdrinc(struct sock *sk, struct msghdr *msg, int length,
 	if (unlikely(!skb))
 		return 0;
 
+	/* l3mdev_ip6_out() may have replaced the skb dst. */
+	rt = dst_rt6_info(skb_dst(skb));
+
 	/* Acquire rcu_read_lock() in case we need to use rt->rt6i_idev
 	 * in the error path. Since skb has been freed, the dst could
 	 * have been queued for deletion.

base-commit: 7076f684d5132e6a6145e1da2fa74771ecd052e5
-- 
2.50.1.windows.1

