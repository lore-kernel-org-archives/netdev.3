Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDB55366541
	for <netdev@vger.kernel.org>; Thu, 10 Sep 2026 20:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789072280; cv=pass; b=IM+pYOOl8amz4rhGOvU+p244P+lI6OHjLCA99yfC+DALIzFsuyYh73DhelGeEMPJ0ldFAmg5EGU/qWM3IW786jgw0LmycgOGMmppRCIiwy0VnJsB/ZDkH2y3gyiuPoRH3pJkvD1cQMD2W34KUzAcJ6R/pQt4btnqipl8AbL5ago=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789072280; c=relaxed/simple;
	bh=HnpGtnRbnZM4AM/ENNwGiaWU5/n9HHmzlea3vnt2Eao=;
	h=From:MIME-Version:Date:Message-ID:Subject:To:Cc:Content-Type; b=RUlDiEvhPByVXQfbAwIjCQkXA79WaV4kXSTOhq0f/yEpydxuCrz6EV6pky5azh1N/p4dOqiiQhJkVSmPGjNP0mpsew/F8RDTUfVg6SiGjjeQyDGUHk20d+UXydLFbEqYQRSV/yI0ByToaNjODfLPKvFgclcbzBM0fcW9yO+cDog=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=berkeley.edu; spf=pass smtp.mailfrom=berkeley.edu; dkim=pass (2048-bit key) header.d=berkeley.edu header.i=@berkeley.edu header.b=gWBo/ZXP; arc=pass smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=berkeley.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=berkeley.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=berkeley.edu header.i=@berkeley.edu header.b="gWBo/ZXP"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-85377c8bc96so112268b3a.3
        for <netdev@vger.kernel.org>; Thu, 10 Sep 2026 13:31:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789072277; cv=none;
        d=google.com; s=arc-20260327;
        b=kDqAa4dPo+cNl6hb+cEiN0rqzVu0xyREIAkCMQL1qcFK25psuMTk8oprMCVr2Y83wb
         faSoMBsusdGBkmARwTBU7ZmPPuGpU5IxP0kNfNOqpjJ7JOT6lHbowYMiwCOKWAsU3y9L
         zKIXab+ez2K92C1+h/WPO/M+euSODotX0+GN+KKhz0sYz2X9OwyeoET5IEtkP6Dru8eJ
         e1eH/AEoiRrQaixu+16HD0bQu5MehKDbXvmYaEeAaMkQnLpqdPKWcAnA9DkpKGORgXyk
         6ZIrpnt+NXw00GEWq24SU2sIdzA4QjPFF5AHPHtZP7ggtcxidpdYmDlczUHaAn/K+uDP
         L9yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:from:dkim-signature;
        bh=maCUZCHQL/0Dung/jQglQrSJpIrbe49RGrAjwhWAl9E=;
        fh=K/QNd6o2hVLN8v5zLLBXKyMZwS0vqnsTJ7kj+uiEd9E=;
        b=Ufcw7NDqX+So+KNCmmCZEI55fi3sRqfKiXKCr9MtllwACODmf1Arajsl/eYuJO2NMz
         rM/VMSYVHkOVT9vXBi7N1OVrnp1al+C17gTuwthTlUdF93sok38Q2LU8rGzHSg5g9fVF
         UXHHgJaeqFKDvKYkHKmOY/8Zoj3mcjeoVcOQ3dOzbe0WkesJkIRnXi0n8AtHHDsHtsp/
         IAIy6HSb/Quc7Tni3V5dea+fZtEqZgYJGD/KMpe1N47tQAMW1/9LOucGiqkjI4dpKRCc
         4KPQQ/55rFdDCry/8xFf/o7RZyEULlRP8hY9sToZ7MPo2atZXlEoK0xmBc2P+h9+J8yX
         7XOg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=berkeley.edu; s=google; t=1789072277; x=1789677077; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:from:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=maCUZCHQL/0Dung/jQglQrSJpIrbe49RGrAjwhWAl9E=;
        b=gWBo/ZXPT4YZik/B+Jrmlb2U1l6J+wYXZZoaJDOG8Bn3Jgtf29X7Wyu43Adr3JDxrW
         veyxYkuPxigA0wYCWvFgvq1x9kg7uApW5OqFhijdUD/JNxROj6JZ+1FLUJS+HTOUQid6
         ke19X7blz4r5bqBC3IM41a8yXKRU2xlqMl0o/5SB7inuvrAu27CoXUCo6BP1kXXYh7zW
         x0JpnVCy20WRGC7GkoazdeuY/Mo2Y4b5EJlypHXHQyRE2mub+tE9qTwpNU6Pa8hgPUCs
         j3cNCEQL//dQnnCFSyXRsJ55hXPliYPCdeH6WDlXHKu9sUaALMSEJLpvmlfHD9+5inG/
         Xm0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789072277; x=1789677077;
        h=content-type:cc:to:subject:message-id:date:mime-version:from
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=maCUZCHQL/0Dung/jQglQrSJpIrbe49RGrAjwhWAl9E=;
        b=f4duLXG8nOgO2Ivvduj1nsCPIwv4iNb32aWX+F9dK1SmjsP1XiIi54mBtU4FuQYzC3
         pf9oir3wHUG+lFC2EM2aCnV21ijbIiI6Z9wasIHVUmRmY8OEXQBATryiEfKzafsEHIAy
         HhpoQJ1J/EVEFuKUxLWwn8CB8D8h5KONd1uoPkbf7zUCcRZIuTsPhYDyWXW5FMLxgJM1
         +w91w5CgNdWo1DxqiPDQXN/dKP3LheL6NcBYcbt8flxHJFThbHGFCO1bvlXMr9r4uMqc
         /94P4qL0IY7/T9rw9uQIw7SDj0tHUdF6uNvtOT0IZX5Tm4cYYLYUKidUxiKeK95pycKz
         6pkQ==
X-Forwarded-Encrypted: i=1; AKwUvBwxBztY1uIcZG2pcgzwvRvkSIoljJ3L4+50RSUHRbTkI4CXo4JIPIgwH54IhFDleic+jJLpl4M=@vger.kernel.org
X-Gm-Message-State: AFuF++mgwysQUgitI8LmENrOigk88yHOidQNlIhQ83WAXnBrwS0q0AF+
	1OlWZVIuZWAxlCVTtnTlb6RtmbUQnWKsvmVfnUhhbuDmNzmKFnDLWH5TEYKArI0iYXIWPTJW1vG
	Sejb46yj7olEk+XE1gL5KfqNn/rCpDXSTLbvzdNiu
X-Gm-Gg: AYBFou0l8QLMEx+F0+XYeob3wLQ2ptPJomRnXoMRCWFEjw2atgYahy9/XVUWPVO8goU
	3DJEdPXntvZgoRK1Uq4uiMcAJfnw2dBLqA7sKOTcYXioMEGhsF4ZogOach2mzs5Zz6amfsqUHg9
	gv9Vxm/2uAE78slTlPGLNte/m+wXQeseDwtzV7kuHrI4pEFm1qxmGLDceNJUxvIrptWe9g7kL2Y
	i2FzmMZCisXjvBMbYY+WdUfjCugfUZOUv2b6Z0jqc7LYEBRenw2QrvNRtX8xzgimhoSe7i+3+Fa
	VIa6q0INN5EN45EOyl64BHKxNFcanG/GqXeMUunUJdxF46Hvj7MRIfcp6wwpmffQUI+bRDX49/e
	LyYchlQzX1xvzSzYlZqQqmurwAyjM4IVFTkkdsErgS6U=
X-Received: by 2002:a05:6a00:981:b0:861:2029:4f59 with SMTP id
 d2e1a72fcca58-86b2eaf0dd9mr981631b3a.3.1789072275873; Thu, 10 Sep 2026
 13:31:15 -0700 (PDT)
Received: from 474444807712 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 10 Sep 2026 20:31:14 +0000
Received: from 474444807712 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 10 Sep 2026 20:31:14 +0000
From: Farhad Alemi <farhad.alemi@berkeley.edu>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 10 Sep 2026 20:31:14 +0000
X-Gm-Features: AcwNN1VUXzs2Scd6J6vqkMNAsWPmubZx5Syf8DU19mCYgSWymDz_57w_RDyC_Fc
Message-ID: <CA+0ovCgMrVBnn+0d198i0th0bcr0EAwNZ=0juh1ug8DdJX5mPw@mail.gmail.com>
Subject: [PATCH] 6lowpan: do not compress headers that are not fully present
To: Alexander Aring <alex.aring@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Farhad Alemi <farhad.alemi@berkeley.edu>, falemi@asu.edu, 
	Simon Horman <horms@kernel.org>, Marcel Holtmann <marcel@holtmann.org>, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, linux-bluetooth@vger.kernel.org, 
	linux-wpan@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

lowpan_header_compress() pays for the IPHC header it pushes by first
calling skb_pull(skb, sizeof(struct ipv6hdr)), but that pull is a no-op
when skb->len is shorter than an IPv6 header, so the unpaid skb_push() can
drive skb->data below skb->head and into skb_under_panic().
lowpan_nhc_check_compression() has the same missing length check,
committing to the next-header compression path without requiring the
nhc->nexthdrlen transport bytes that nhc->compress() reads and
lowpan_nhc_do_compression() then pulls.  Return -EINVAL from
lowpan_header_compress() when pskb_may_pull() cannot produce a full IPv6
header, and return -ENOENT from lowpan_nhc_check_compression() unless the
IPv6 header plus nhc->nexthdrlen bytes are present, so that the nexthdr
falls back to its inline encoding.

Closes: https://lore.kernel.org/all/CA+0ovCjTsygN76s2o=TZqPqW8v2gBhmRnz+q6G-NaB3Cq-YPqQ@mail.gmail.com/
Signed-off-by: Farhad Alemi <farhad.alemi@berkeley.edu>
---
--- a/net/6lowpan/iphc.c
+++ b/net/6lowpan/iphc.c
@@ -1140,6 +1140,10 @@ int lowpan_header_compress(struct sk_buff *skb,
const struct net_device *dev,
 	if (skb->protocol != htons(ETH_P_IPV6))
 		return -EINVAL;

+	/* The IPHC header pushed below is paid for by pulling this header. */
+	if (!pskb_may_pull(skb, sizeof(struct ipv6hdr)))
+		return -EINVAL;
+
 	hdr = ipv6_hdr(skb);
 	hc_ptr = head + 2;

--- a/net/6lowpan/nhc.c
+++ b/net/6lowpan/nhc.c
@@ -47,7 +47,9 @@ int lowpan_nhc_check_compression(struct sk_buff *skb,
 	spin_lock_bh(&lowpan_nhc_lock);

 	nhc = lowpan_nexthdr_nhcs[hdr->nexthdr];
-	if (!(nhc && nhc->compress))
+	/* nhc->compress() reads and then pulls nexthdrlen transport bytes. */
+	if (!(nhc && nhc->compress) ||
+	    !pskb_may_pull(skb, sizeof(struct ipv6hdr) + nhc->nexthdrlen))
 		ret = -ENOENT;

 	spin_unlock_bh(&lowpan_nhc_lock);
