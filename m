Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D68D4B2CCE
	for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 16:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791822829; cv=none; b=qHppGCiLFO3ATBhho3sAUytR5tWoLxbw1G5ML+MXGS7OCsiX9tnQqANudcQjPS1iQbaU1XRvf49fSP7SOTIaXSNaft5+g7pn9V5A9TBp/OsxmN4vpOQjasy12uETuC9jzs/FHATnfTHlxm9pHGv5SpmQLS7OUMhVzYSCRIgZkdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791822829; c=relaxed/simple;
	bh=XD7Dbp4kw/iRzxBqDKqco2WKsBeWlE1PFoG0b1uYEgg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=E4MsOlZ69mPID7YIQe+z42mxtfMfbC/l3KcpreWgLuIXjBaLU7ISY980UfkZTGT6Wii0Om243kha9MwI2aIy8fv1SDfMNpBTe/ohV9qjaoxlami45IVWaE5mzhLPqgz6tZxJ9y5bDOfQRqMzx/pS5cwLmW+WKlrJqIC1eGAX1Vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eOqQxRuv; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eOqQxRuv"
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5bcdab9a82bso2320077e87.3
        for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 09:33:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791822826; x=1792427626; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=UDyNt44SSPWd9NxVXjExVE9zSGlxnfJjDCgPSSUFpi0=;
        b=eOqQxRuvWRaQlTA0Uh7mlIPupRCYPkPMwllp43ImXYHX0xG0fkcZprKwZlb7vQZY+0
         /hInKHCFcJaetJm2qpmFO6kjKjMDN8pfKZh8PEm6svHeCl27OvFZhKOClBfz59OR5ifX
         9l0XjZAPX1Ya22P5hgbCosyiAYG2AkV/LES0dI9iFCCHiopuE/LW/LYbleWclV2Atceu
         NsXJUsGZynjheLf9WJSalEaC6EqWKYawrEAMW3I4BeHFIDkAW5PX9xU4NKzWso4kK2Df
         m32/bT4+ZcGULYgY6bwW1GHWF2zABtzBV54kW21hl0MFusxCWJu/dcNHQ5NcJWIEDM/+
         vV9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791822826; x=1792427626;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UDyNt44SSPWd9NxVXjExVE9zSGlxnfJjDCgPSSUFpi0=;
        b=IpVyMZJXyz7D2eLOqNXVyCbm3SqNg4CJAkw26Z4a9ZtJshe8edEzXQSB36WeRyuzXf
         z8ORJCDv5a/NLcSQjYw68k9drZEChyCvZHRdS5jTC6lRwXX5Vn68NH6HzHaF/A6gQuPE
         MfFfx6n62NaZsFeCCX18YXSepBm2a60beOzv1lA4dwbPSwDgUBMNkcdMI8jRjPBQF2i9
         oQhjPVEF6pBi10bBsPTMb3PjeZYD9P1VMCgZm+7xatWlX3+qsh6ENsILyZsWfbEPg2rV
         +RcJHFKJYsqAMCzZlf/EmuP/Bi4fJTSQAsW6WLQSzM8Bd/wtgyg5fHfQPcFKAAitdcgQ
         aqwA==
X-Forwarded-Encrypted: i=1; AKwUvBwcey4Pr3nJo6d+06TbN5iRq5LTZWn0doKXRperiQmh+x3bEx1nrZYQvz+ngbZZ4ceCd2X+wVs=@vger.kernel.org
X-Gm-Message-State: AFq9FYIENvYvGD2xOMdJ9Pk/ZbcwBgF67Vh62a9pnHNi+Z9K52vK4Nk9
	ykFtxNto0sZ1WcTeTsYhmBrtVH78YeBJ1W/U9ZgLdfVF/dR9wjrHLYxE
X-Gm-Gg: AYBFou1cTwe8RVHAN8KjRwVXHli3KnAoeZpQSZvikomQ3T+VBkOGiwWko2ATEsgskKC
	iYfxlgbHJ3WBkRve7p7TYvOh0k5ne1keSxYlhCdbs6QFZnWLkMR6yFAWQTzcTAsSYb8xYhMsTeW
	mPfhWZE3qXJNWDJ3bn4YRbUWHA8gptbIHpfW7hgVm36aouLvKIU0klpOuNMxdjreMK2gTc9wcB3
	4jXnXkdjz7Sehf7PKKeBOS/gHNReebJda5opMuhVHyJB3B+jeXeJp9LC9dXl8zKAMdlLjYRumYJ
	+gEzdvRXgL1jgF18k9oM9uug8vapPz4t9JDKzX7i2yUX7qnFZGrIgpWuU/ol7oEfVM9j5RExuFY
	KQm+Vfh9a3lfSEvccC961ymJDajTncLiDdiENXcCHccYBTRJ/4OM6pubwfiNOfcv5me35s5Z9M5
	7cpHlMFVhAokkKRnK8l5mecInv1I7tLphw5s0dZzVdxQswsPYJZ5pWFbvpzqvXKh3UkfImCSTaK
	lI=
X-Received: by 2002:a05:6512:2349:b0:5bc:f6b6:411f with SMTP id 2adb3069b0e04-5bcf6b6426emr1063326e87.63.1791822825935;
        Mon, 12 Oct 2026 09:33:45 -0700 (PDT)
Received: from grower.uveon.ru ([185.32.132.3])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5bcddea7d87sm3074897e87.48.2026.10.12.09.33.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 09:33:45 -0700 (PDT)
From: Alexander Martyniuk <alexevgmart@gmail.com>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alexander Martyniuk <alexevgmart@gmail.com>,
	lvc-project@linuxtesting.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	co+0ea1ac045375cf05@bugs.sh,
	Xiang Mei <xmei5@asu.edu>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH 5.10/5.15/6.1/6.6] vlan: require the MAC header to be present in __vlan_insert_inner_tag()
Date: Mon, 12 Oct 2026 19:33:29 +0300
Message-ID: <20261012163331.45783-1-alexevgmart@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Xiang Mei <xmei5@asu.edu>

commit ab888242fce4f16f6c4d4c6ec53939ad36aa3b3a upstream.

__vlan_insert_inner_tag() only guarantees head room via skb_cow_head(),
never that mac_len bytes of MAC header are present.  Its ETH_HLEN
wrappers - __vlan_insert_tag() under skb_vlan_push(), and
vlan_insert_tag() under validate_xmit_vlan() on the generic transmit
path - therefore rewrite the first 16 bytes at skb->data: a 12-byte
memmove plus two 2-byte stores at +12 and +14.  No caller supplies the
bound, while the pop helpers use skb_ensure_writable()/pskb_may_pull().

An IFF_TUN device has hard_header_len == 0, so packet_snd() accepts a
one-byte AF_PACKET/SOCK_RAW frame.  The first vlan push only sets a
hwaccel tag; the next - clsact "action vlan push" or
bpf_skb_vlan_push() - enters the helper with skb->len still 1.  The
head comes from skbuff_small_head without __GFP_ZERO, so each push
drags bytes from beyond skb->tail into the frame.  After three the
one-byte send leaves as 13 bytes carrying 11 bytes of uninitialised
slab:

  0000: 5a b3 62 12 80 88 ff ff 00 b3 62 12 81
           `------------------------------'
  only 0x5a was sent; the rest is slab, here the top 56 bits of a
  linear-map address

Require the MAC header the helper rewrites to be present, so such a
frame is dropped rather than transmitted.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Reported-by: co+0ea1ac045375cf05@bugs.sh
Signed-off-by: Xiang Mei <xmei5@asu.edu>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://patch.msgid.link/20260915083152.705309-1-xmei5@asu.edu
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Alexander Martyniuk <alexevgmart@gmail.com>
---
Backport fix for CVE-2026-98377
 include/linux/if_vlan.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/if_vlan.h b/include/linux/if_vlan.h
index 3728e3978f83..2759d3846666 100644
--- a/include/linux/if_vlan.h
+++ b/include/linux/if_vlan.h
@@ -346,6 +346,9 @@ static inline int __vlan_insert_inner_tag(struct sk_buff *skb,
 {
 	struct vlan_ethhdr *veth;
 
+	if (unlikely(!pskb_may_pull(skb, mac_len)))
+		return -EINVAL;
+
 	if (skb_cow_head(skb, VLAN_HLEN) < 0)
 		return -ENOMEM;
 
-- 
2.43.0
