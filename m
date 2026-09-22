Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D76C4B827C
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 09:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790070153; cv=none; b=h910vQ/fst4G6UMTURAd+s7mnqm3vXCyXPBLgRBkK9MQwSh+9bVcRnPjWgfrlxB53ieRsFiMKAimGLoB52DF0GDo5KNyiT6FkWSoAFlhuGo3cxfU5C1YqA0LhkTvU/BeUD7TA9MSy1c7Xw0DI9B8GASXO5JLmleMddOjS3g/jeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790070153; c=relaxed/simple;
	bh=EV3qeg/IT2dhQk0AAQm7n/YC1210gfudvYCjLTPTQTw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fw89Cv+Gw76gpwneYrc87X6Cvgtpjzxco2qFezhzJ5F5T9M48wYj758YlYJLa1U6+5GfTRu0dJeE92X9QZUtoLIw98fshq5xqC+N5JGqzJZusblJwIuTkH1ns59KbPhHbp2ZUkfJfyTrdi+7GwddN70Zqbr+hkpPLtYyEWiYVxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=Nr51vpjA; arc=none smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="Nr51vpjA"
Received: by mail-pj2-f43.google.com with SMTP id d9443c01a7336-2d91ede8035so47532115ad.3
        for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 02:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1790070151; x=1790674951; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wd+T6ssCXbt72WCToNvBeLcTHQSX6SP8R0mHNa4Aoq8=;
        b=Nr51vpjAMR4gmOMObq1xtGKFpAvNj6J4sWRV4+Jjho+sdkoUtfr9jB26iha3FrwUn3
         1eEFIs6xYduI1dT1XkqLogHnxAWC+uKqafRBpNU2nDDWoJITUXKpvTMz1j4H9ChUed0c
         dxiz+fkqrQYXMdAdrm5hVt5yPOVfzdkpO6wf+hhvmAB+x/uzNZP/47+z+4OPN3VjTTSA
         Ef6eEjMLa360R4BTbjb7zh9mNF0910F/2AFizXPLAObx+GoPBDtVrFExERiejI+CKnuY
         SNw/L2YgonZYcormXbmgb7KkDrb5jLcwqsX2rP70ieEa+Gr/ZhuBQBFfEqNRczMM6KfN
         qRBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790070151; x=1790674951;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=wd+T6ssCXbt72WCToNvBeLcTHQSX6SP8R0mHNa4Aoq8=;
        b=OG77SdB50Ut183HJbhhd82DS9dBvMupKuBwslWaY9YGRqoLVa3tTzjaZuKNp9wPABu
         MKDGZcFCi2twZ2e0+mgl9g6mitrL0Padxb21tED+oF+q0Mk9ayXAI4toABIgEKUIeL8I
         7CbaPVwmrYHHIj4ZOq8dAE43FiES0pOlDTlIZpxRruvY4jiYszifMuYAHTJJjCd8/6/Z
         6BVKZpcW0h+WpdTRpYj9kSIAEoJYn0VsZzlgHkPfiUAFVcTKDZFwtkecW7TWNEy5Pxzn
         zAt158vN5qwaSfAO3pvK3L9YMjQQPvLGen4HB9pyig7fAGCUsrDyKZLb2qauIgddMmeI
         VsQg==
X-Gm-Message-State: AFuF++kMXa3g6kHDNH4bsCr3TR6FqGqtQbXTcqhAKSgaOm6yewpSraVZ
	RDYe1k+eWUEwRzUANTt3E53ppNqAHOtpUcGZGgqls8PU7xur6qmucMmA5W8dSfs8HSasMMg7gks
	TP/iO5t+z
X-Gm-Gg: AYBFou1k4P+sqz7QGqnvXarlL/313igtq+LxY9sXKMUdSZYhoDWpmNWc0cr+RLic3uK
	aStBe0eLMIFCBCinbtZLUAuaBU4LZEKa+0nV9+ZXCJQhBTOuf3Enl3Ra4nDbIld9wB3jbmb+f+s
	33RKo5I0WSTc2y5d013ljZ9luu8H4fFlda9AgvTtrDfWHtfR103+2e4uoyHP1LzauGJdGuY319C
	qIWfXGnXfhq/b/90vtkX8GhbztlYg7jthwxERpOfETrDgTxWyApqrZxYJ4Mwe17zLAWzcyvMlzN
	56QuZ9QYAkX8j947v/5aEED5a7hZPLiYvJmnwW6GIgOcco/Dj/Y/HBra4XPglQUKHe6qyMJDJ2G
	NIuqyo4t2i78Qy77re6snNBL4Hv/QOskQPUIikUBHo9ru5OXg43Xp2XbrjN/ByLcDTLm9Ird9hE
	y79fX45f2+weYz4ya+RLvSE3KoI5ovNMra9wZKkvTbTHMmY7r1ss72GUw7o9NLJYEndUw2FCoxq
	vo8IQfV
X-Received: by 2002:a17:902:e892:b0:2dd:c100:9431 with SMTP id d9443c01a7336-2df60b53cd4mr6321585ad.47.1790070151400;
        Tue, 22 Sep 2026 02:42:31 -0700 (PDT)
Received: from enjou-Legion-Y7000P-2019 ([167.71.204.91])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2df5d056911sm6799025ad.70.2026.09.22.02.42.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 02:42:31 -0700 (PDT)
From: Ren Wei <weir@nebusec.ai>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	tim.bird@sony.com,
	opurdila@ixiacom.com,
	vega@nebusec.ai,
	petalzu987@gmail.com,
	weir@nebusec.ai
Subject: [PATCH net 1/1] llc: reserve device headroom for allocated frames
Date: Tue, 22 Sep 2026 17:41:54 +0800
Message-ID: <5002123a7fd47989926bcefe4d5bdeb824f40b63.1789987105.git.petalzu987@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1789987105.git.petalzu987@gmail.com>
References: <cover.1789987105.git.petalzu987@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zixuan Chai <petalzu987@gmail.com>

llc_alloc_frame() reserves link-layer headroom using the device type.
This is insufficient for stacked Ethernet devices such as VLAN devices,
where vlan_dev_hard_header() pushes a VLAN header before the lower
device's Ethernet header. An LLC response on such a device can
therefore underflow skb headroom in eth_header().

Use LL_RESERVED_SPACE() to account for the device's actual required
headroom while preserving the existing reservation for the LLC header.

Fixes: bf9ae5386bca ("llc: use dev_hard_header")
Cc: stable@vger.kernel.org
Reported-by: VEGA <vega@nebusec.ai>
Assisted-by: LLM
Signed-off-by: Zixuan Chai <petalzu987@gmail.com>
Signed-off-by: Ren Wei <weir@nebusec.ai>
---
 net/llc/llc_sap.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/net/llc/llc_sap.c b/net/llc/llc_sap.c
index 1bd446a21092..4b203ffb1e83 100644
--- a/net/llc/llc_sap.c
+++ b/net/llc/llc_sap.c
@@ -19,16 +19,6 @@
 #include <linux/llc.h>
 #include <linux/slab.h>
 
-static int llc_mac_header_len(unsigned short devtype)
-{
-	switch (devtype) {
-	case ARPHRD_ETHER:
-	case ARPHRD_LOOPBACK:
-		return sizeof(struct ethhdr);
-	}
-	return 0;
-}
-
 /**
  *	llc_alloc_frame - allocates sk_buff for frame
  *	@sk:  socket to allocate frame to
@@ -45,7 +35,7 @@ struct sk_buff *llc_alloc_frame(struct sock *sk, struct net_device *dev,
 	int hlen = type == LLC_PDU_TYPE_U ? 3 : 4;
 	struct sk_buff *skb;
 
-	hlen += llc_mac_header_len(dev->type);
+	hlen += LL_RESERVED_SPACE(dev);
 	skb = alloc_skb(hlen + data_size, GFP_ATOMIC);
 
 	if (skb) {
-- 
2.34.1
