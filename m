Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B4683ED3A9
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 14:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779200840; cv=none; b=Rt6p0+rJTUlt8OSEqJR6TQ0ZRwP4X3ZcZREIJyvCaEHoo3KUwAHBn3hE4KM8SKCBNps/ASaZWP9F6DWdh9AkzolH1cuA4549rlhaOddxhkro0hOOkqrP1HA3T7B+NVPO7n31T3Aif1oESuRaCBS6ZqGJCAn4dsN2jRl2bg27RGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779200840; c=relaxed/simple;
	bh=0XIrWrrKOXAS4JSnBkq9LW5tElkQkITWVSOhNm7XbxY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=k6x3NvoFFX3F2Qwcbq1GF4zDUwARJzX7hi+H1cfHsRKefgEstaCxrLBVWvXLGEEW8SntKBgFshaE40HxXg+qGa65a0jtQBY9z5fx4MlLYztxR1XMnjqV0oyDJdJbBKvHYGcSV49yqv0qRgtHjbXU/E0jkP/v/uk5QOF6pqgLxjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=H9CfzdgY; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="H9CfzdgY"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-488a9033b2cso29818515e9.2
        for <netdev@vger.kernel.org>; Tue, 19 May 2026 07:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1779200837; x=1779805637; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GnYW6cai+fx/W9v9Sht8UdcFwU9lnBLs3mWevgJE49k=;
        b=H9CfzdgYi3z46QMaZV7su4v1RA8u55NUFY3DOv8imzinUetRJAyt2M82Ks1CvcD3qx
         OlbEaLtzNuhwgbVqexNmZvnmoPhLcRCyILArafpw/9fHjYqq1/Ni+F7xNhV4cNAxQPR9
         Q0yZOxfEAWzuf6L8A2+pJ5V8KxhjUehRuWI5R86NqFXmU27wG+koSprRqxSDO9ooxo+P
         zu+Q8PUU6dXeMhxP5ZaQOi00jkvD7SK3dgWyl+p0pHtecyUEFD4rHFTa4pBvx1wph/gE
         11HVOMpyzVce1dCUmekOGHrUB6W5Vbg6qhj6hfI8HYbgiTq94gxlIWQyjVJjL3kMMden
         sfKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779200837; x=1779805637;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GnYW6cai+fx/W9v9Sht8UdcFwU9lnBLs3mWevgJE49k=;
        b=AWg8oQ4oE+pHQq9gtnt7aYTHG37JmB+Dc9EozmiHcNHmnilZQ66/gx6EP9TiP/BkRX
         4i/7O/hs3qeGlA7WKE2VRFqrEL2RAq0vs8kt/3T/sph4p+70bioeCY9tJxX8DTACoSER
         zhWtH+RsISNadV+BWjQQqLqaMXsVHl1DyweNWZCfUQxvhB9CAOQJ1OnoTHZD1HmxZD4d
         U3dBO27DVmbeeZRUooLoppsBmZsxcMTbnwehx66U+HxcCZo8d4LARf7NUCwLIkiAXOHb
         vsms/TGW6f0fzWJqc3KhvtZ6DUsfcr9QFdklpbP6rUv8zHpIT6owYou+pYgbflKKrE+z
         Aljg==
X-Gm-Message-State: AOJu0YwY5SKCnVIBM24Xxg11NhatHe70AbZMo2o4fiNyT4bgRqfwl2wz
	cG18f5eoiWBLCDF8xm36d2UEeofHACuHE0TvkKNU4wIAviW/nkNLccwSvgAgPkVg/4Y=
X-Gm-Gg: Acq92OHQKLWaySAel/m2dcW4t9sC8Ajkdy+0UPmlM6eePd5c+ygMV4K6d9y/XF3295X
	hrz+HqN7yK0Op3fEVO2+U4SfwAuPDO+2UbU2PfRPtw9xjRxazYRUkKNWprVjjSttiIU7x7Oswg5
	A+/mpSwOkzndiET7A+pLhxZY5k9ut4Q0w6H0m66cxVJVkKdJ95u+/e4S4Xuss2czTZ70cC0Qf9/
	m2UE3jS1u7Cr3KIEz9KiRJZVwYmW/A+TTFA1FuHgw4nbq0g2NQg0ZcIrG5du6/IeDjXSjofRK01
	xuXDPEkORM+AVkebe8zcW1ggLkpq4A5pRUdVb7nzuXGF2dT8n+p2NkqKdWkOSMEu3bdC0JzEZD/
	uOueqotoMVdXyuyXqIkXOwSAd9yy1jNXvH3xoEy3DBlbdtjcH8V3MwuKCY8osD5Hd1Kuyt25aYf
	RGOjtFQdEgd4QDAFOQRfnAKgJWifxgE2G+NbwnfhFVdfUpVnyK+0d3+fHhACrWQhPhZPq4rhOiM
	GypAEovQWd3S/U=
X-Received: by 2002:a05:600c:3e1b:b0:48a:8905:a500 with SMTP id 5b1f17b1804b1-48fe60da647mr333513865e9.12.1779200836810;
        Tue, 19 May 2026 07:27:16 -0700 (PDT)
Received: from localhost (p200300f65f47db048a8dfcf61053817f.dip0.t-ipconnect.de. [2003:f6:5f47:db04:8a8d:fcf6:1053:817f])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-45d9ec39ff1sm49364941f8f.10.2026.05.19.07.27.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 07:27:16 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>
To: Ivan Vecera <ivecera@redhat.com>,
	Prathosh Satish <Prathosh.Satish@microchip.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1] dpll: zl3073x: Use named initializers for struct i2c_device_id
Date: Tue, 19 May 2026 16:27:10 +0200
Message-ID: <20260519142710.1587324-2-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1926; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=0XIrWrrKOXAS4JSnBkq9LW5tElkQkITWVSOhNm7XbxY=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBqDHM+D4fIZMJcwHlRIDBr/rS0Oqb6HZFnub+fA zJI8208+l2JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCagxzPgAKCRCPgPtYfRL+ TqIoB/95YWl5qAe6ho7LJkiiQ7hS8dEb6um0QjbYJHsChmMD/7b5EoqN5f5vwrtrZtvIj1k8J0u UvBovJsqwWKWoA3/GtHrZLQOlbrMTM4hdg5p6UM1DAm3RFFnBhWXv3wOqrR4GGNHqBqPUI/Fg2D kaHBL3yHa0IFz5bfM6S3sYo2GVjcwVfrEwP44kLZvh+gJ3jge/Yp8AaMfaTG9jaCSbJYP1HfSSM 3GnFN0e1I0QuuFRx/5VJCz2SWudQ3Hro80BmtxLrLm1PS4ExLMmb2KsI1efr0iuG4iNst/cQhPZ fmhriOB54ZIXMuZn219o3eLBhnElyMq3PfxwK+HZvt9hWjyn
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

While being less compact, using named initializers allows to more easily
see which members of the structs are assigned which value without having
to lookup the declaration of the struct. And it's also more robust
against changes to the struct definition.

This patch doesn't modify the compiled arrays, only their representation
in source form benefits. The former was confirmed with x86 and arm64
builds.

Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>
---
Hello,

this patch is part of a bigger quest to use named initializers for
mainly struct i2c_device_id::driver_data to be able to modify
i2c_device_id. See e.g.
https://lore.kernel.org/all/20260518111203.639603-2-u.kleine-koenig@baylibre.com/
for the details.

This patch here isn't critical for this quest, as no driver makes use of
.driver_data, so apart from the better readability this is only about
consistency with other subsystems.

This is the only i2c driver under drivers/dpll, so this is the only
patch needed to adapt the whole system to the new style for initializing
i2c_device_id arrays.

Best regards
Uwe
---
 drivers/dpll/zl3073x/i2c.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/dpll/zl3073x/i2c.c b/drivers/dpll/zl3073x/i2c.c
index 979df85826ab..4a23340e29d0 100644
--- a/drivers/dpll/zl3073x/i2c.c
+++ b/drivers/dpll/zl3073x/i2c.c
@@ -26,11 +26,11 @@ static int zl3073x_i2c_probe(struct i2c_client *client)
 }
 
 static const struct i2c_device_id zl3073x_i2c_id[] = {
-	{ "zl30731" },
-	{ "zl30732" },
-	{ "zl30733" },
-	{ "zl30734" },
-	{ "zl30735" },
+	{ .name = "zl30731" },
+	{ .name = "zl30732" },
+	{ .name = "zl30733" },
+	{ .name = "zl30734" },
+	{ .name = "zl30735" },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(i2c, zl3073x_i2c_id);

base-commit: 254f49634ee16a731174d2ae34bc50bd5f45e731
-- 
2.47.3

