Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B021B248881
	for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 08:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789461122; cv=none; b=A/Tizn1CvgOVFI0SmNqL1IIh6sxjpiV6wEBvYKqtZ3StvWngTGOnQzm7QXyJPNKyj3avIhW5VUkxMitI86EtYwhdNjfe40Cnp07cgUoRcWX5yo6AOP5NEe33zGX6nUyAULx4hUmHKv/MWEw2J7F7FMc5+VLkmz7+he5WcyWZ+n0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789461122; c=relaxed/simple;
	bh=Kyljv4Ok0VOKC1521YIj/5MqOlgJleHDXLfDK8e9KT4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KClsn6GSf0OeldQpuu5OfN8pQHYcLMKMawCX3yIYshAgMNMHV8DUyuEbYp0ax/2qOQ95VGpnw0hAl7aao8mtrf140jCw5vefiyLxvd/KSmmFGy+1r6P/GMn7cl5fnO0qJtwpg8jlh6QqPle5h0UujHzJUy+2cPGVafh87aBjX3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=CtmKId3R; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="CtmKId3R"
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-6b1334a3b16so2970160eaf.1
        for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 01:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1789461119; x=1790065919; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=nfGU+d0Ce1ol/Tm6wjF345/Jrj4e+fpsFxiynd3zRTo=;
        b=CtmKId3RdfumA/w6zh32NfLeMv7G7HjRGzsGUTA0XZrv393XmRI2/zcF7VkSqUAlWf
         yNwtTI4N66M0tg4+x8powKLGzGYF83QXsCtc5sO1F3BGxu6bkCWn4O1fOXQywNYH+crF
         owvoW+M+4nJqVobywFWMLZ+rdi9tjR0iu5spiOy7v5oIcwzv1xXrv4DIqdbnqwoN39hV
         5pSkTI19I9RQM+MiwJkjOPGgWKcZxGJ8tan0Q4VyUbHromhVr4XQfmXYDWr7QN5mh2te
         NWNX6NF+D6GtbdqlAfggAhqlyMCYBYEgfcurQS87Ipn6poRqIQtuiYfPlwEqGrKRRbCi
         g0TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789461119; x=1790065919;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nfGU+d0Ce1ol/Tm6wjF345/Jrj4e+fpsFxiynd3zRTo=;
        b=kCi4uyQTyuRYeLlyTBQ8zEKNLK3uYy9Ywn5MjXsVnvQ24H1DyDD03DUwixUovtQ6kx
         bdvJfLI1UeVoYZIVvAKvy0mchqjx22ewQYRTYQz6Kx4gB86NgpWSlGhDguDyxnmdY88O
         iI1c8SL+gnICVD7ASKYN+N27f6xZBY63TZdKdMljeM/m4eAJphtd9obDNQtFsIq/vQxE
         fpbuwC6dC48O1nBlHBgNLIbfkn1a1aBlpVFaU4XgvhQ+AXkzeUGUIYRc3ZCO3689m4vg
         A5F7QnVfqTWF3grW7ywcE5c47WWXYWTggA0HELcQ2zb8+j0ScvrDKm5pTBD4kV5DwGQO
         6f0w==
X-Gm-Message-State: AFuF++nb8LAF9uWsMko5NymWI1FyzIfE616djiydcrpwX80co0hNiXu7
	cuyXrLzhEUaxvUUK73ZM5Y5I9lmcL+svB/cKrbX/vGAMNLjyn8xvKtUS9+//fdmY2A==
X-Gm-Gg: AYBFou38YvZn4g+37zVeUNGj+GKKgarFA4oQSC0Fibl9hM7s8J/hi8WBlfKIg/hJ63f
	RtYK/6ew3ZNJrEzjZYa/IZpa5VHMKdFfSN129AVmWMxukx4MQ9TIwzKjdYk53XpfMNBOmxahN97
	D4Xrv9CB0JMhWBYPUgarL8RhHZzaLPSsmid9QT0xbaUGtzT7n/g1iSVvUcAHaq386EiinuXNXi4
	7ldjhVaqaHLzxNn4UMaupFuiq9gTvGaDS4x22nj31otGQGl4ps6+HSfghRi039sRqEVdV13fBrN
	taytRrBSc3DmWtoDdsCMVOV3VMGkSHVb9cvdcBXHhmG3sBicTM6jUKEMPm64MkLZJkMHPxNmzxZ
	z3yOEs/+GBkbUF5/CGN1nnlejV0zDYT91WftjMJqFeM1LHZV2GmnTvuueAGK31W/Q9JnixHiVjG
	ftokPBnBi4Z7bgArZykc5oH52z7WeqrSbeDT2Y1tsvHMDTaBEEH0zSpEz8/wTwMH97UDX0ZB+O/
	YN6SsXYh4u8oKSul/p+HMtSEwNjmAIHajtX3ymP6Z0GOnKDdmcT5kda
X-Received: by 2002:a05:6820:190b:b0:6b7:83d6:2925 with SMTP id 006d021491bc7-6c5423435dbmr3269444eaf.40.1789461119455;
        Tue, 15 Sep 2026 01:31:59 -0700 (PDT)
Received: from xps.tailc0aff1.ts.net (149-169-99-5.nat.asu.edu. [149.169.99.5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14382741839sm13579723c88.6.2026.09.15.01.31.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 01:31:59 -0700 (PDT)
From: Xiang Mei <xmei5@asu.edu>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jakub@cloudflare.com,
	Xiang Mei <xmei5@asu.edu>,
	stable@vger.kernel.org,
	co+0ea1ac045375cf05@bugs.sh
Subject: [PATCH net] vlan: require the MAC header to be present in __vlan_insert_inner_tag()
Date: Tue, 15 Sep 2026 01:31:52 -0700
Message-ID: <20260915083152.705309-1-xmei5@asu.edu>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
Assisted-by: LLM
Signed-off-by: Xiang Mei <xmei5@asu.edu>
---
 include/linux/if_vlan.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/if_vlan.h b/include/linux/if_vlan.h
index 20cc16ea4e5a..4846032bf4ff 100644
--- a/include/linux/if_vlan.h
+++ b/include/linux/if_vlan.h
@@ -365,6 +365,9 @@ static inline int __vlan_insert_inner_tag(struct sk_buff *skb,
 	const u8 meta_len = mac_len > ETH_TLEN ? skb_metadata_len(skb) : 0;
 	struct vlan_ethhdr *veth;
 
+	if (unlikely(!pskb_may_pull(skb, mac_len)))
+		return -EINVAL;
+
 	if (skb_cow_head(skb, meta_len + VLAN_HLEN) < 0)
 		return -ENOMEM;
 
-- 
2.43.0

