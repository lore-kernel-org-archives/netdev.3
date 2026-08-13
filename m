Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 142053AFAEA
	for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 17:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786643240; cv=none; b=NBo2pcQLTgq1zpPOIQgP/gAXOcIEDW17hu3QjDi2erg7as58xJNYzP6uAn9+p+7uWg5vq54cNBt+AiYKdlumpdZ/yzy+dxqFUco84FXuH9LyyFerumKG4EavcKawUQ8cj7GXUQYPmlS63BnlrRbLdktGkpJ3+cJB1pS8AH9WdLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786643240; c=relaxed/simple;
	bh=pWbFVB6hMHQbmXekH9w26NBkSZWrnle2Say6dxS8m1k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OpjzlDeIEDETNBqp5UfsAQ8Li3o6IJ2kyEOAjF6cVJJvSHwDXgQeSmnutk6Se901odfJI1MIfND0jdhY6wyVsBskYIO11t3LWHCYED5Te36o4OGcluHssLbpIEoYTWn2T6R13PY9DpgDBD0BMsvMZFcHA6oA+lrHACA+WdfH1aA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nW1zBEJi; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nW1zBEJi"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-47362928f65so83100f8f.2
        for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 10:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786643236; x=1787248036; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=VnWj3Ci1OnIACJ3JVJqb73bM1HVRpMarLwyVRWGih30=;
        b=nW1zBEJiLkjMlNvu6fnR6jCOJKdRSj46AkRsBok6qZqrSzwNmG6EzviX7y9Gm53NWd
         8HK+yAhWxVbwm9CX3Cpq97oJtkdES0Efo29Rfq+e8gFg7tIRbVvXS2jtXIOoWKiwiG02
         6dPUkGnRTLVzyHbOTik/LGYcEz7l/LvzkkL5o2Qzk7ZaVsrwumwxN+jF6JfEZisdbq7i
         PP1fLsppm5PQWpAjUjJIqfSmp9HruI1xwjPfQj5O3LlNNS3XenNbfpjULR/PKcDKftOI
         kPTT2HQbgqIRdlbqnwT0RrIuYzFXt4WY34IjwU3i88ls0g++7v1Xfr4WBMAvd4HpnHz+
         yoPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786643236; x=1787248036;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VnWj3Ci1OnIACJ3JVJqb73bM1HVRpMarLwyVRWGih30=;
        b=N+VxlN/cwNet1dTqlqt+eaqw2YpuZn7jxVV20WTGM4CWpRwMSMW2Z/lY2EMcy02z2g
         dGgGZOiMcr12U5r1wR+BqHbO20+zfWXbNOK/ryRPfcVNWsCBZu8AqbWPRAKHac9xK9mm
         lsrb+XZj6a9xeMssSw25SbXHA8IWPZsXDSCbAuar+4j6T/XA5hwTGyU/D+F4GYkgYm0Y
         Cu/vRQ2LouzcwcvTN92zL4gAqfd/i8lcFcsXyVQZ8VYgNgUCtQeL5NRj2jycitXO2Ji7
         AAPaPmKAnmpPgonoR1hzZwlNOd2z7oVUT+Az+qUPL1adC8h1SK3fW8d7sCo4dQvvXGI2
         OpJA==
X-Gm-Message-State: AOJu0YyaQ7B9DA8dxBwbVXVKyEfOtHBPtk6l+N39xm8iBSydEfC8aaxF
	jtfG2Mp8iYvGYWiYXzC/McmIJPSbmRHihz+Liv6GAcFytnyLwwFcs3JEnWYfAQ==
X-Gm-Gg: AR+sD10iW1ttlp+l/kQ82EGQuicKfRQFbUkCDV5tcQpCP+3xHda1mX60cjLCzkH18il
	zZTuqZPObrcifGppmVUCH9Us+d022sd1HcO3Psh2JzpSpHzHYysCXukgKktT8ctaHWTuHfZkzGc
	bmcX8aAbP0l8+FRmylpZYInbtPSfxuOr6YZZKEgoM9/v+8c/ChorlCE76qgJqRrwZaNxesHTfd3
	frv9tvRd8uygZnFQrtewv08kM3i1yEl6oRjayopchgMsTV8QnxFNZt/fn6oGLoMQ0ee2hhJvDb8
	NTC6l6ChaKkYHavrDfo7c6ZDQo0c2J7ij4G+qqAS8FY+xeliYqJ6jDDsU7Bcg4CaMS1Q10GV3ll
	/XKehNb6+BJuZWjyLDHoq1h4pTCX1ZFao7FJ9dpoFQPtsr8Sg0gQYQr/+qFYttZWeS3+HQ2Injz
	eAUbD+5QoQYTDq9dgnPasrgxP24sl665czBag5N9lNNkeN+8CFmx+JpqQAXHs0Z0JSWjrr
X-Received: by 2002:adf:e193:0:b0:474:18d9:8371 with SMTP id ffacd0b85a97d-4815a011050mr11963406f8f.28.1786643235944;
        Thu, 13 Aug 2026 10:47:15 -0700 (PDT)
Received: from SurHub.localdomain ([102.218.51.180])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4815f21a068sm986132f8f.12.2026.08.13.10.47.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 10:47:15 -0700 (PDT)
From: Abdifatah Suruur <suruurism@gmail.com>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	dwmw2@infradead.org,
	Abdifatah Suruur <suruurism@gmail.com>
Subject: [PATCH net] ptp: vmclock: prevent read-only mappings from becoming writable
Date: Thu, 13 Aug 2026 20:47:07 +0300
Message-ID: <20260813174707.14809-1-suruurism@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

vmclock_miscdev_mmap() rejects writable mappings of the shared vmclock
ABI page with -EROFS, but leaves VM_MAYWRITE set.  Userspace can map the
page read-only and then upgrade it to writable with mprotect(), after
which the guest can corrupt the host-written timekeeping data (sequence
counter, UTC time, TSC offset) that the vmclock ABI defines as read-only.

Clear VM_MAYWRITE on the read-only path so the mapping cannot be
upgraded, as i915 does for its read-only objects and as fixed in drm/vc4
(CVE-2026-68445) and drm/panthor (CVE-2024-53071).

Reported-by: Abdifatah Suruur <suruurism@gmail.com>

Fixes: 2050327242269 ("ptp: Add support for the AMZNC10C vmclock device")
Cc: stable@vger.kernel.org
Signed-off-by: Abdifatah Suruur <suruurism@gmail.com>

---
--- a/drivers/ptp/ptp_vmclock.c
+++ b/drivers/ptp/ptp_vmclock.c
@@ -372,6 +372,12 @@
 	if ((vma->vm_flags & (VM_READ|VM_WRITE)) != VM_READ)
 		return -EROFS;
 
+	/*
+	 * Restrict the read-only mapping so it cannot be upgraded to
+	 * writable later with mprotect().
+	 */
+	vm_flags_clear(vma, VM_MAYWRITE);
+
 	if (vma->vm_end - vma->vm_start != PAGE_SIZE || vma->vm_pgoff)
 		return -EINVAL;
 
