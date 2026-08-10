Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93EF13E168A
	for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 13:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786369267; cv=none; b=jmTlH6R9IdSPKMyAZgdz60H8ex437kmiIu/e5ODlO1cZRdOxNRyWcWoaE2if6p4/e18qte+bgpcem7UG16pO60jLUXeGddACL23CNi7kBCE1WaF99AfrQRW+VTui0BR8s257gPVqKe0GqSpOXEH5hLlmhN8ZN4Xs6tCnkIwWr2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786369267; c=relaxed/simple;
	bh=OR5SJbAjYqfNbWbLK/Xp9DBpEIRw6MZvXrZYmbjvOZs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YICN0bLvreezQmLDz1fyCHMY7C2eC/vzUBN0q+2LMsw3hP0vgef0aL8Ed9kXfjEeZB+RRGSOF01s5/D1yZC7Xy+q3dLuDAp1VFRhDUobSMSmM1kmS5FitqiinKb0D1iwCOJSozbgtPPpyBWCBzks1DQAvWziwCuDGCBaGwtJ8LU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nkgeGrME; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nkgeGrME"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-84847482584so1257003b3a.0
        for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 06:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786369266; x=1786974066; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WBpRbjDpae64ONOAIzC7CQyuvwbiULpdksSC8EfBNlY=;
        b=nkgeGrMED/BnADIseGgNwE9yKH7QWUbfP5ObzPqSkJ+/7xlEh194AXD7TRUE+WVR6P
         OPDuhf/M4n/k+aWQcEKsp5H1F60SHbLG3fII4pf4yersSf3NIEvGNuDpmttSRofGb13y
         y/wctwLotJomgvKjx7sECk9I43+P20XChjK81yucRep2NAu5pVqowHvZFMkMwWwnG+TL
         fHa3J7/g77mZ/CUrNkPFzfL6Ky1lyIUjf56XfMOOk+Mb8BQBig5T5h2roEXjMJ9GTlOr
         XKyg97mYhhC80Sl33kTyO2qT9i1WF6fQDZhBsXvAEpIxHaN+/IqLZ/xzk+cGErokDpzt
         8/Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786369266; x=1786974066;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=WBpRbjDpae64ONOAIzC7CQyuvwbiULpdksSC8EfBNlY=;
        b=IKObamgKsXXIeefVwGNSa5RcVObccZSFUewf88qqPVd91QKpwmaQB3whsaThgUOrmF
         BeHTUP92j3/M+1UOb37Aw1lX9667o5s+AOQcYh4NJy1p2EFHTq8MQUMIto7vcFSiNWui
         MH9pfrIHTuSmZ+/efX9Rj82hatr8YWZU14woQ91QyEbU3S8Pm8paM4smjFDuiD4Wgi3T
         4tW2BWuoy+GUvFWmsJkbOCpztTEqVUzOFPxCGhViKIU8E2j4igCO4+Gmbag+l5y3w4Ca
         RjiaNt9CngJo8cVsXShqK9tBDpsp7ZEbhSH2MGcVUcK7nNP07qYIweLEyTnHAE8ixP9x
         ZOqA==
X-Forwarded-Encrypted: i=1; AHgh+Rowuksi4RIvHEX0rqohNv+ZJDUz3uqYAfA8wRjCCBuzkF6uctKrpsX1UPMT+6pdMzNq3PWpRgQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2dvs7Fi6P1oCsIqWa8Hh6FXS1wylZVS6dfogi1p5rNUakWgdt
	gqpf6MhA9lYKzczCtJPHa3RNcnV+7a+Z8wVPvvCeSN2V6cMA8JLYn+Zu
X-Gm-Gg: AR+sD13vlcmPiEeabXjhK6XWbu+nsfyPokJMCewkZLKoMZ3TfkinwsV1wmintNrzKVv
	0gPQDAoUnVMZ3Cz3PBA1bJOh4AtxZA9AlSuJsGTac4EcAIWgev/z/anWl576cfsjY67a8+QD5w2
	wmgXu6pZdIuGWnGY5/miNr4y6aRDLZ2p0DnM/DptvkiAZn6ZHjhkZDfOVl3TVigf1z1W5K0ccyR
	6x+d+bv8FppOCRJfqkbj/BglAcnxHoJahzCQzBrVDzWH5bRwcT+d704ePHwGbRY8tjvg3BxkQw5
	GzclAovMtqbm87XIdT2lInCTE8rKbXA9+wADrVSty/JfCNUWhxNenOWwa70j90dOFIxTelIwlhb
	I8poGq90/MJp1YUFmjmjFCcv9/NBgzEkoZb3RzFOEu0TN7K0WXrasL5Quu2TrzzMqNJClIE8iIW
	82fEl9H7pn2wnigb2XBMqKgz7PDHAnhQvkODLE8JHJdtQovG6mHHfPTvD2yHz1RKIr6KIdmbY=
X-Received: by 2002:a05:6a00:4b45:b0:84e:cd14:aeba with SMTP id d2e1a72fcca58-84f6b6f2e61mr17355422b3a.6.1786369265853;
        Mon, 10 Aug 2026 06:41:05 -0700 (PDT)
Received: from gmail.com ([123.118.75.63])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84f5a51f166sm4006236b3a.35.2026.08.10.06.41.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 06:41:05 -0700 (PDT)
From: Jia Jia <physicalmtea@gmail.com>
To: stefanha@redhat.com,
	sgarzare@redhat.com,
	mst@redhat.com,
	jasowangio@gmail.com
Cc: eperezma@redhat.com,
	kvm@vger.kernel.org,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/2] vhost/vsock: keep IOTLB across feature updates
Date: Mon, 10 Aug 2026 21:40:18 +0800
Message-Id: <20260810134018.143973-3-physicalmtea@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260810134018.143973-1-physicalmtea@gmail.com>
References: <20260810134018.143973-1-physicalmtea@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

VHOST_SET_FEATURES is also used to update logging while a device is
running. When ACCESS_PLATFORM stays enabled, allocating a new empty
IOTLB on every call drops valid translations and forces avoidable
misses.

Initialize the device IOTLB only when one does not already exist.

Signed-off-by: Jia Jia <physicalmtea@gmail.com>
---
 drivers/vhost/vsock.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
index 7372c22691de..1beae7f5b9a9 100644
--- a/drivers/vhost/vsock.c
+++ b/drivers/vhost/vsock.c
@@ -889,7 +889,8 @@ static int vhost_vsock_set_features(struct vhost_vsock *vsock, u64 features)
 		goto err;
 	}
 
-	if ((features & (1ULL << VIRTIO_F_ACCESS_PLATFORM))) {
+	if ((features & (1ULL << VIRTIO_F_ACCESS_PLATFORM)) &&
+	    !vsock->dev.iotlb) {
 		if (vhost_init_device_iotlb(&vsock->dev))
 			goto err;
 	}
-- 
2.34.1

