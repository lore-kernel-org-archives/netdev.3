Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35B3833CEA5
	for <netdev@vger.kernel.org>; Sun, 26 Jul 2026 05:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785045060; cv=none; b=O7yca0u6t+ssPpsPy+0+EMdsbyV9XjcEmoJ1umLt5bjWWk3zoHuWOVDPLwac0KNBwPjus8Gt0qgZy9JyxUjY2vL4kzF7K2G/e1GTW3n2ZZwGyPl4RvFnxfUhEqmeZRZllBzOdywFF+/oBpyGWuVw7nXLwzdVmCB1DKCd48UIOzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785045060; c=relaxed/simple;
	bh=JfcgKY1bxODc/MFqL+UtQTpvigjYvJWWyNJn1RyJk5Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YgPRt6oUyeHNI5CIbotsA86VUTFIZC2cQqu6v654rqWEEf3lWAcBLvcgambJU9zpWI24v1vz3NMAFnthm/YbJNkjGzinkAyz7+mzy3eJx3Qn0MjvE+DELZmZKXvoq4Ki0gHjeeVaMwvDMUVFiaOhfcIUPpi1Qzof1Pm0LV/aJ1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BuxwOdqt; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BuxwOdqt"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2ce98cb8165so19681565ad.1
        for <netdev@vger.kernel.org>; Sat, 25 Jul 2026 22:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785045058; x=1785649858; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=pMkc8d/oqMSOvNnpXsJe10kMIEvPzFEPmZNw8V9kaIc=;
        b=BuxwOdqtzsDOq9bwgx9OmEG5XJuzCVZQ/VbS4u3yTVEiA2754mlhM25naZ5Ax3Hf9R
         kb1cR1uA621Tu5xG9tBsGFypIcGSasox8k9UWtbyNQxCEKgukPptOZloIIvFh7Hxl7En
         04RoJf0A+nqaHeL2ukiWUeR3iE5cO7sTqn5IDm3ZwK2kxt8igS+68KbruVVG1hizrr5W
         2DAV/1eG1eABVhmkBKwxwhqFGaTDkBVrMfcUE4FNQpnxsxKSyR1U00sKnY7jUqoFAMZ0
         rB5mYJZc3T/n0hK4mvJctZfIukXhpnQS91wrPltdj0Jv0aCwsNSFHAHnTCAsUWoGoquZ
         vY+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785045058; x=1785649858;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pMkc8d/oqMSOvNnpXsJe10kMIEvPzFEPmZNw8V9kaIc=;
        b=O0X3s2pGHMy5zqIIwVx0XMKusxZ9CL6KL2MKdJlReg98i7hRQgAwGCM1RApxc3e5jV
         NVVuSkeSVQS+wm+OaftE6HfMpptgYhsBi0Qe6hQNY+AQe8Im9oy+1FwQCEs4zlKQWTBW
         P54fZk9OQTJ/6LIlnIIs7Th0ZdLrL6saLfB4LgpBfhptN+LJO5xJQwtbE+IDj/QFC+9I
         1MNcHuGNm3VJp4liX5Z27RZiR+HiOZeYyhfqMzzPG9vgjpBwx1+AGYY18uPKA/0aK9r6
         attErknv+9V1fleNL+w1dLVBQMrDChIZjEw1kLT/hQF0nfJBsAN3srPKhJ8aA1oW2+OM
         BKTg==
X-Gm-Message-State: AOJu0YxDlgkYQQtV+Q0jA5oPHjhZ5PC+uwUmfBW5l0/nsmRIwzpDkua5
	ffeZPK0ucFMuSgpU+d0RLkoHpu3u7bQio0aQ3K1O/c/BcTVCj2loknpI
X-Gm-Gg: AR+sD10Jow/hKjnKgth0SbX/k4OApM2K5nKWdydoq6tq3kNe8j6fGRVLp7NDmqoHO62
	I1yEjNO0FWl9ajirz7hC2FU1t/USHPSpwew9lwnCjRmTx943ixH8aDXr+i1vbzE07pHfQg1A0O0
	rPT8oaZWskvB6FET+xqvahCYEgchTIPihN4XlcoQWDaMUNC7YoGoq7PZNBZTMsjiK/fFlJ98K8J
	kofDl/Ett4BsaTA3o//TD7sciIjyP55ScYNz94Ulowk6typXHvryQQHnTtdCUoS0FhVFJ4++JuX
	SD50DZdZuFrPRx/t7xGpHLk14i8GbsrXlTv2Ehi6a2Pk4drbCrJDoSOWkoGhcZyxYxvfXhIgMnk
	Shk3UY7MKL7N9VcoSmsX7BJKZcDMuqawFl8myre1AFE/Cqmbfou5H79/2qX4S7NeZgVaMbYKWmo
	6KZ1Nyt7ILyGSEKdou/xZzEMnEzlG2ttU=
X-Received: by 2002:a17:903:b88:b0:2cf:8aa7:7810 with SMTP id d9443c01a7336-2cfdf337686mr34097145ad.2.1785045058448;
        Sat, 25 Jul 2026 22:50:58 -0700 (PDT)
Received: from acer-nitro-anv15-41.entro.com ([118.34.230.2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cfde5e2b44sm16735795ad.27.2026.07.25.22.50.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jul 2026 22:50:57 -0700 (PDT)
From: "shaikh.kamal" <shaikhkamal2012@gmail.com>
To: Donald Hunter <donald.hunter@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	"shaikh.kamal" <shaikhkamal2012@gmail.com>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next] netlink: specs: nl80211: fix TOOD -> TODO
Date: Sun, 26 Jul 2026 11:20:46 +0530
Message-ID: <20260726055046.18029-1-shaikhkamal2012@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix spelling error reported by codespell in description strings:
TOOD -> TODO. Attribute names are untouched. No functional change.

Signed-off-by: shaikh.kamal <shaikhkamal2012@gmail.com>
---
 Documentation/netlink/specs/nl80211.yaml | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/netlink/specs/nl80211.yaml b/Documentation/netlink/specs/nl80211.yaml
index 802097128bda..d9fdd66b497e 100644
--- a/Documentation/netlink/specs/nl80211.yaml
+++ b/Documentation/netlink/specs/nl80211.yaml
@@ -1139,10 +1139,10 @@ attribute-sets:
         type: binary
       -
         name: fils-discovery
-        type: binary  # TOOD: nest
+        type: binary  # TODO: nest
       -
         name: unsol-bcast-probe-resp
-        type: binary  # TOOD: nest
+        type: binary  # TODO: nest
       -
         name: s1g-capability
         type: binary

base-commit: 1590cf0329716306e948a8fc29f1d3ee87d3989f
prerequisite-patch-id: 912014811782d33538ddb17f00b64c15b364425e
prerequisite-patch-id: ccd9499245f9528a029f13653f6a670c70796caa
-- 
2.43.0

