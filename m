Received: from mail-dl2-f42.google.com (mail-dl2-f42.google.com [74.125.229.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 933054322FA
	for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 09:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790240620; cv=none; b=mjYUpnz0GfLIOr8iITBHJPMiPyna8ku8n01NhuhnfdSj/q5uAQZdOca2/CGHtp54N3q3V2stf2EFkNHcTGrju5hBFYm+8wO04qcw0ZanyrOXhUB7WtJuw3KncPHkCO0XehYmLihfWcUy4cQ+gB6OoxTzFJPvO+kbQRxl3tDbmI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790240620; c=relaxed/simple;
	bh=6eNEXRgdL36ZWMrD4pn9OcMZK2G/MxNlDASZOgFbQG8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KIwDxYuDA0gVsBgyUkpZ7JT++ZZc8q0oVFx3DtFYsLk8hsrRJ5uiOS2t3J1N13LHQ8UEU8ohnEQ6fQ8Nep7Fy7pIdjALdDEetzjuAxWppn6HBmCzMuH2JRzlfCjZE5pCW5jztroPSBgFCfpew4n2VYCdniDP1FaKET2XiXCKlsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=smartx.com; spf=pass smtp.mailfrom=smartx.com; dkim=pass (2048-bit key) header.d=smartx-com.20251104.gappssmtp.com header.i=@smartx-com.20251104.gappssmtp.com header.b=GGrh3oAP; arc=none smtp.client-ip=74.125.229.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=smartx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smartx.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=smartx-com.20251104.gappssmtp.com header.i=@smartx-com.20251104.gappssmtp.com header.b="GGrh3oAP"
Received: by mail-dl2-f42.google.com with SMTP id a92af1059eb24-144df39b6cfso1357320c88.1
        for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 02:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smartx-com.20251104.gappssmtp.com; s=20251104; t=1790240616; x=1790845416; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JhovNMtONHqof+lhOxfZhim/Chcx5GtaZSSYpmj4lRA=;
        b=GGrh3oAPPqYqmv8GAD7PN5cKB570ehhUqO5rDinnjqN9sljJBViOCnhmLRqUPVEBgY
         NKqkr/2a8wxli6/Jni5Cv50TUkw3Dwf9YBxX1pEAd7B7LeFEvKqm33SVqahmZp5FXth3
         mMcZB2ovH/UiYBPSFCfvJekzx7Q0Tbyt8WbamLP1gVKudlt19/WgN+b95+lbK+TZN0CG
         MMWpP3gED0+i5frbV917cAC8p6DBJVuWVH1q/Ef8VVcH8fdZh6MM3QD7PGvKfyPcMV2k
         qVwsD5Ye9pnfHSotE0X/05Zk6Ls9VLx5u11W/hPnOV5AL2TJJscXs3EZigc7rpBz4RCA
         oThQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790240616; x=1790845416;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=JhovNMtONHqof+lhOxfZhim/Chcx5GtaZSSYpmj4lRA=;
        b=16FcvlGoFSaYEF/T/q3+0arVe32GQGaAMoZOLaPV0nlQe15QkwVvox6XIRiVwMW6W1
         6JreJMvABiwmsMXl5OzovmLLdDIkuNAqHxIwk3dLmhcNO6zAITAKkN5YMViYO4EX5v3Z
         Y3f1ra2HVZ4LXSx4KSa7qowL2L0qrR6Rd6LhhRlFNzPGkJnPpo2wRSGqYSqjfvPHXzFx
         1wCyP9SsujbsmAZLG/RyfPImga85S3lPgEWv+SMgNpgjUPc2Wzl4ilYBM6wlJ40cCO4S
         XfwPCXDXLWfyv5g8L4QlCe64PNxwLRVLcITqzLiOpY9yeWUSGBH67SdqvnOXwtFZeYWz
         cQPA==
X-Gm-Message-State: AFuF++lmFRcv8AMyOfBqQUbwByVtyfD0tUin5q3xI9mxFDseuCMu9yNn
	Fmws3PUmGwdkH+wPQVT/Nwne46gyTqtBFWdz3kGJ0bZDVxqczqV1qDA0IZC4qIgxg5ziE8ZBGCS
	U/9CG8CGOQJAysauPX9mQJCuLGf02VxsMI3Znxo16xOklBlCCmAmS/NiEeuTjG6Kbaf1bcT1+4k
	o=
X-Gm-Gg: AYBFou15MIrBis05ckdfXH8UZ/X14znWYPe/DhSiPxxjKLW+8pBqrYaRxy3wi11hrmf
	sOp4RGq+g8yWyJxe+IP3JcfQzjUDq6dKuKPyq8YBeuggHIfzIfit9H2VqOoBl1Vq4G5/Ypi5ED2
	uBZq6+db/FpTbL9mYKQEQHd5Cqe/rBmgS3ckF2BpBQkXfR47RDHruYdcMXhOzGurTd6xBKE3NMU
	UH9nkPdgvArjTreYCbPGDsAcVl7SrJ1qrbnzC06kvxit/4QydWHgukRpEtlhGRgsLeMRtXKJiKK
	rQDF4wSPn459mrXUIfBGcJ7SmYdY59r9guPn5mZhpwMoMqC5Pot9yyhkMKg3XduGV2bE392ozXs
	dstBtyZCpvKnccP40DsBaZ5MVkNL10ZMY/muY8Mti1dM0P+/W4IAaFTFVrM9cId83VU8PO82F4O
	I4o7LfpzW/SWodZn5zfZjhfYTJyHJpIMr/80fQc8fViN0AWZZ25qtExl5cwwzT1n/nAWoN88yQi
	GNisJaNaQY=
X-Received: by 2002:a05:701b:4505:20b0:143:26cf:8616 with SMTP id a92af1059eb24-145040070c5mr1331914c88.24.1790240615555;
        Thu, 24 Sep 2026 02:03:35 -0700 (PDT)
Received: from localhost.localdomain ([23.148.204.128])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-144f983d73fsm15599829c88.6.2026.09.24.02.03.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 02:03:34 -0700 (PDT)
From: Wang Zhan <wang.zhan@smartx.com>
To: netdev@vger.kernel.org,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	keyong.sun@smartx.com,
	Wang Zhan <wang.zhan@smartx.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Jason Wang <jasowangio@gmail.com>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Alice Mikityanska <alice@isovalent.com>,
	Ilya Maximets <i.maximets@ovn.org>,
	Aaron Conole <aconole@redhat.com>,
	Eelco Chaudron <echaudro@redhat.com>,
	dev@openvswitch.org
Subject: Re: [PATCH net-next v2 2/4] net: gso: support bounded TCP segmentation
Date: Thu, 24 Sep 2026 17:03:19 +0800
Message-ID: <20260924090319.4182130-1-wang.zhan@smartx.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <willemdebruijn.kernel.c1280e613430@gmail.com>
References: <20260918084651.3022878-1-wang.zhan@smartx.com> <20260918084651.3022878-3-wang.zhan@smartx.com> <willemdebruijn.kernel.7b2e4c8d0d45@gmail.com> <20260920131231.3610688-1-wang.zhan@smartx.com> <willemdebruijn.kernel.2984a0c37a5cf@gmail.com> <20260923094517.3998941-1-wang.zhan@smartx.com> <willemdebruijn.kernel.c1280e613430@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 23 Sep 2026 12:42:59 -0400 Willem de Bruijn wrote:
> Precomputing in the caller, as the current series does, is fine too,
> if some caller-specific context is needed.
>
> I'm mostly concerned about duplicating logic and the number of
> functions touched in this series. But skb_segment itself is too
> complex already, so preferable to minimize complication there.
> (The reuse of partial for this purpose is very neat.)
>
> If only validate_xmit_skb allows this, because all other segmentation
> callers do want full segmentation (not checked, but I can believe
> that), the current approach is fine. If we can clean up the repeated
> tests and simplify the code in general.

OK, I will try to simplify the code and reduce the hot path cost in v3.
By the way, changing the signature of __skb_gso_segment() brings three
extra call site changes, and that is a trade-off.  __skb_gso_segment() and
skb_gso_segment() already exist, and adding another function like
skb_gso_segment_max_segs() would make the call chain confusing.
