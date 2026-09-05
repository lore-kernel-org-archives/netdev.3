Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC4AC3E7BC4
	for <netdev@vger.kernel.org>; Sat,  5 Sep 2026 09:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788601883; cv=none; b=FxzeUdVzGo+pua8MGr1k++a93s5JSY7piJsiU4QWOp7IHLlG07oJNuW/FPJJ4QzwuoTpe7pFD519bSRSiuK3b8QK9jvSW2M2dJhQH6opbRR/Ni3Mz2c4rm+Ns0a4U6CjqGNfM4LAIMqWB32u8duHxgebb5NKM2JiyO+u+bMsM4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788601883; c=relaxed/simple;
	bh=hxoMOTps4ssfuwoiEgGPBDr3IeANcLabAFKshQddcHk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pQnstier4L6wwQ6rukDQ7xDMU5ldJQYg5zVOOAJmHbLQGhJtFT+unKzW+gElfeLWNfXyvH5W9KvXIbYrgddy5NSApHDJtqETNRVie4eTztsnyHOzSwD/G+MiovK3fqTD9wdOsgoG3nJQHLrawzebEpQDzb5uPaCKiCr1F9LrL7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rN05sN5L; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rN05sN5L"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-482ea739de2so1227287f8f.0
        for <netdev@vger.kernel.org>; Sat, 05 Sep 2026 02:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788601880; x=1789206680; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=+/XuGnO7C0o78lZlWgcjI0jZXorVi4R+HC8SQNL+h8I=;
        b=rN05sN5LNPMTINBXpA4t78pRBM3HdQBD0LDifweDgYRw0sKmG5hnbq9+n4XWZ3wdAY
         mWeaeKHAU9dMsvBA44tTKiP2gEQRbU+LAvBnuznHG01/5bWApKb5V3QgUAT3x5qxocJ9
         Hwc8fz377okjBDKC2HRNWxpraMcKuYLKzIaTUZ+PYrlMgTbbhGMhDNHeISpndmRxRjax
         e+K3dlJUzZZ/jxGuBNn/qn7M2O7lEDKqm410DxxNTNR6cNnpmskOfF+TVTdD7C5qvaSg
         SZ896BNtp5ntid0p9yC97sh73JhpabBhpCzcRxaIJqfy8ZGy6JpKt3uRgOTbDNmJRZXx
         96OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788601880; x=1789206680;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+/XuGnO7C0o78lZlWgcjI0jZXorVi4R+HC8SQNL+h8I=;
        b=a4gygkmupSZK8000TEXReRJjpzSXJiAAos7x5K6naiUKgGe0bpMFq4nCBCzYSEmHS7
         rFK/HtMzR747W9QDYAqbHVoAV20oYH8B+RN4/fw7XiIAUQJBLnEnQqWMEQLYmkqWGxUs
         wTb92IrdaT050wgsb/RtUm9vlKT70NGMbh012Q8CjW02zdm3082Ob13oPi1HAMGKsVS5
         4qf+PHsDsGZLSvf7s0DLBuMeUdaOxsPXudBTLa+Rb5+1g99eTe0rsbhT4WzSydB4SKS4
         HKHnCV5bDCSvKN3alzWtfsOO0K+gJz8eGi1VpwC7xfST6af6upac0OhUYBtzg42+RVgj
         A1+w==
X-Forwarded-Encrypted: i=1; AKwUvBzLqRp+as4VpgyquOQpcXrA+rIoUd7r5iimjOi/LSiUSlAJC4OrO4SfQIiqby8C5QC91gcsCSc=@vger.kernel.org
X-Gm-Message-State: AFuF++mQDQtMwi2dvWuXssCD4cYbkV+Tl3ZX4hvazuP/TnXHqvg+yLFt
	TMi9/BV+JrAWKNW3twIOBYT6pPQ01zrnWM2BTsuMFg/E7+Tdub+62avy
X-Gm-Gg: AYBFou3fEZWumcDCCOaHwJzO8PHwYUpi1KDi72/PPJncagid7zLdV8b/RKQrEZudjaO
	hMtJsVNWAGAH4vQd884MSJCBiAGHA/YM61UJjl1is7p+9W7LUiHAImVeTUhVXVCvjry/kONvHED
	rHotgdKUXptF826dvG/qSSkHyOVfIo6zNNkhHaiUhycSlPwKJr5XKuQMPtJOD6FVNn8RJd8uBO7
	bLok5/NOn/Ru2NZZphqA4jLNPpVw3wzitKja9an4DNtaye9QmE+Nnm7DOR0o2e28IZnflxqFjms
	GqwDL+99/myVmy3hhg8TABdENaj4oiDbrFCqKeBnWUr94tIXqRj8RzlA0f96qSPr5025X4ongvd
	5uWCADC/l3OYHnWA7iEgAbCApezuCktMLzOryjv+zMpuBWnVlY+pNP8ZIkzO5GwZTU4GtPglKNI
	aYrf//DzNSE13faSc0hym5nTzCiR8npNFWxoQ8ApkrMqgjqqlZNhc0tx9AUxvq8aUxXm5REFWh/
	irNAMWiB7xQS8b73Nugjh82Wd1XsnYBN9d4bXfpTArpBVQclNSeIUs1OrD0J5If7IyJfD/dZlW/
	/9vlFxH0C5lFlREys7D3BUSITsnTnUo9BNxr+LblJfxlGdZF919FB4abPTVXZZRYbvQ=
X-Received: by 2002:a05:600c:8711:b0:49c:fc6e:a3dd with SMTP id 5b1f17b1804b1-49cfc6ea7bfmr108917295e9.28.1788601879856;
        Sat, 05 Sep 2026 02:51:19 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-a4eb-3001-c06d-af27-9fa2-ea53.310.pool.telefonica.de. [2a02:3100:a4eb:3001:c06d:af27:9fa2:ea53])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49d03543064sm46925335e9.13.2026.09.05.02.51.18
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 05 Sep 2026 02:51:19 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Jeremy Kerr <jk@codeconstruct.com.au>,
	Matt Johnston <matt@codeconstruct.com.au>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	netdev@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH net-next] docs: mctp: Fix the struct net_device name
Date: Sat,  5 Sep 2026 11:51:16 +0200
Message-Id: <20260905095116.42147-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

struct netdevice does not exist; the type is struct net_device.

Use it.

Fixes: 6a2d98b18900 ("mctp: Add MCTP overview document")
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 Documentation/networking/mctp.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/networking/mctp.rst b/Documentation/networking/mctp.rst
index c628cb5406d2..3bff00c11702 100644
--- a/Documentation/networking/mctp.rst
+++ b/Documentation/networking/mctp.rst
@@ -19,7 +19,7 @@ networks.
 
 An interface (or "link") is an instance of an MCTP physical transport binding
 (as defined by DSP0236, section 3.2.47), likely connected to a specific hardware
-device. This is represented as a ``struct netdevice``.
+device. This is represented as a ``struct net_device``.
 
 A network defines a unique address space for MCTP endpoints by endpoint-ID
 (described by DSP0236, section 3.2.31). A network has a user-visible identifier
-- 
2.53.0

