Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E89C73403ED
	for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 23:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790726151; cv=none; b=T7T13a6Yl+hWinCbd0U1JTLTqErynIgKS95ILbfzUjKbjX23EpxAjldjDDnUu6pBUFoZggDhJje8TGhffzOzsoOi3TjvRQ/OhnKcBv9W9SZQ0mncIa9YQjQ+OAoqiSOe1j06wOHtAsi8i5IZEkbhs5j/AHXOCtymrtNM8zVE7bM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790726151; c=relaxed/simple;
	bh=iOi8zHRAlSu+e9agLUUkDOY5rCUo8SiROEi8v+xXB+c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=glycQYld0nUlO/MXxa2lrGk0SXbM1Tne6I2Z4zD6a4NSW2WvNQRVfwPHp0UeUpaEPff9jovxLy7q/RFlNCf10xdiU7oA6GuVbz+g3PBE+vkVTi3jfEw+rzIxH27buVg1U0im7mdl84QiYub86FBoZ7bTkd/FVMR+pV9xNA+ucvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dCo0JlsG; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dCo0JlsG"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-4843796e373so2732093f8f.1
        for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 16:55:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790726148; x=1791330948; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ceelTU88DrIVeu3cdUQDMZW3x4p6eeMeKZ+cR5QIwkE=;
        b=dCo0JlsGHlWavVLdFb9yU4QIgMmFuyIIBlah8mzdirZJHI6qi7XRbpEHL9h3GuU4Dl
         9vxISwyHQWHPP/8EnXHnirRhQ8NZ22H7Z+UXH/St3uQ4lRe81nceIN8pAgz8ORXgynAK
         Zzns9RYuMwshbA8jhwgkgcoAAcx/if8bgfmXP40FBMqI3v2d/Pg/GQJj6ChimPFcdykj
         93gLICBJn9oWw5Nll6BNwrjlFwbNY2Tpd4BQxbjZzxFLorj8r5AH8BjiH+kLeJR7HH/a
         0sT9LQREZ5NXEvhv5mrSI2Ui0iqZOsng7I1p0w4UBKZoP0u2ObrgKMVyD3XESTjN9i3h
         hHSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790726148; x=1791330948;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ceelTU88DrIVeu3cdUQDMZW3x4p6eeMeKZ+cR5QIwkE=;
        b=xjSNKcvpWdlw7rzKNHkPPrklv+kU6xY2dDFLdMdfL+8gbtzwTdqrmcvRrKpIChkUiD
         k1nzX6mBf+kU8dBZ0GGrcuGx2YFbVeqIj3agkyKjcdnmR5J1/7l/yOayJe/XL7LRlkng
         TQy6mHtFtprL9/iLWtcgZO4iG6Fet82itRBAFXSl7RWB4hhebF8wS6Unv5m3COswfDZh
         KzT+ApfVx9Gxryt5w/TQtcsExoEnRCkNAK++COZovLbUs2JXsStQf1VvrbigCjXN8F78
         a4qgtSZfwfBDIhlGerMDZvXw2ihNIqM8GEPNxFwdEfYZZVjB53qgPWuSr1yafNqLrHcb
         AScg==
X-Gm-Message-State: AFuF++kg+GD/374tHnzoGfmBrtEZVxbmyQeFYeyhVtBb8KPjaO2om7pg
	KrOHGP3O4aCCmmMPtTmg0qlL91NhrDFr8EsUu8bYJTLsd29/olUmvcZYpsHhPA==
X-Gm-Gg: AYBFou3G5DXfutPa6AInGiO+zorkvQpGagGlN3o13BEbkicaYA0A1Mpv2/KDtIUla6g
	gusRc/dmXUzb21UgSfQtDATapDhzvMnjE7OB2DHdTEufRlzutYIjJfIJmSI4SrW4N9ub4dI10DL
	qUl9y2ZXPUCaXQHYM1Ffb4nsy15VhOVQBEn2n40ZzYwDbyRu53VAUFsfPyC7W2JYjg3+b/T2OEh
	p6S3r8mCiPGZkrtEbACBWlRe6ZR0KGBoxZCGvUxliP5Ga9GAHxtu3AneJjJGRJXBh7m/mrAyjH9
	qaKjX1hLB82mo0QIJIhu1olY2ihQTAICsgEMiezfaAO61QIwPdnZU0pCBWeBgo8jiPixdsBPgM4
	Mg0yF4Rj+E+pp1iR8eKJ2cDJ4mcl8lbSxPP/U6TKB0bgZkfuNbNgmztW/C4/gImFH3As2++CytO
	h0D0paZzK38EtUfT5ZeJdIjzhD0PHnL02uWdxcePqCfNUyuye9Vbpk/VEgzWHX+lXhZ3/LpfywO
	2TP/GMALLOCosTZ8DkbV9q6pkkFP5oh1G55zclEWKfF
X-Received: by 2002:a05:600c:4703:b0:49f:ce73:7a9 with SMTP id 5b1f17b1804b1-4a01513fe8emr10875555e9.34.1790726148125;
        Tue, 29 Sep 2026 16:55:48 -0700 (PDT)
Received: from yam (ip-B9F9A82A.studo.glasfaser-ruhr.net. [185.249.168.42])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a015a3fa16sm7084535e9.0.2026.09.29.16.55.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 16:55:47 -0700 (PDT)
From: Mohammad abu saleh <ml.abusaleh.ml@gmail.com>
To: netdev@vger.kernel.org
Cc: dsahern@kernel.org,
	Mohammad abu saleh <ml.abusaleh.ml@gmail.com>
Subject: [PATCH iproute2-next] ip: remove redundant human-readable option match
Date: Wed, 30 Sep 2026 01:55:43 +0200
Message-ID: <20260929235543.210365-1-ml.abusaleh.ml@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

matches() checks whether its first argument is a prefix of its
second argument. Therefore, matching "-human-readable" already
covers "-human" and its abbreviations.

Remove the redundant condition.

Signed-off-by: Mohammad abu saleh <ml.abusaleh.ml@gmail.com>
---
 ip/ip.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/ip/ip.c b/ip/ip.c
index e4b71bde..dd84f94b 100644
--- a/ip/ip.c
+++ b/ip/ip.c
@@ -224,8 +224,7 @@ int main(int argc, char **argv)
 			preferred_family = AF_MPLS;
 		} else if (strcmp(opt, "-B") == 0) {
 			preferred_family = AF_BRIDGE;
-		} else if (matches(opt, "-human") == 0 ||
-			   matches(opt, "-human-readable") == 0) {
+		} else if (matches(opt, "-human-readable") == 0) {
 			++human_readable;
 		} else if (matches(opt, "-iec") == 0) {
 			++use_iec;
-- 
2.53.0

