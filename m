Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1108381C4
	for <netdev@vger.kernel.org>; Sat, 10 Oct 2026 03:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791604303; cv=none; b=TknIv3YfUpZdlKo1d+ApzhVFnMqGVX5//Xb21khzqC3fq8bXPxGx+/e+r0GpEjeg4cQ8VsQUOVmmRViSkT/zGWAv7gFyOAjvk/bW0wjChaRZgAs6xgLY837dnlcQ6ecdGX8Zjuf7h39yM62+cRrS/085dSVLGErQlsxG6/2NEVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791604303; c=relaxed/simple;
	bh=ArA+w71w1BaEj9a+G3Ctm79DsTHOAgfSfPNsAtEyqFQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kaZ1fWpgzbSFvCnIAAHaBCSew6KNP2w3VjsGvExh57JUGnbIaGWTOEUlkRJF57snTjVdrQRuNOFtliRAkPU0lsII9e+EsQRVfvaqB9nyEoOpYIOhhHMg196ZHcwdng9XtClJlbBCe10cgJCpAvBjzLM38oqE2QRU3W2BG9kYHys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c0f2ju7w; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c0f2ju7w"
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-3a777d4f321so4121041fa.0
        for <netdev@vger.kernel.org>; Fri, 09 Oct 2026 20:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791604299; x=1792209099; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oHTcdU7BDJRK9HJIi4NfQxgJw/5DvdcfPlbURZ+9Mwc=;
        b=c0f2ju7wLux0deMtGRTjh7mrTXUx/NkCBhsgy3dpEE8jZgG4XUeydApj6WdXTUCCXp
         noYfti7x65zfUpTtk7XiQEAo4JPI1ffZnk7Y0FRAVt35ETnuZqNfOjo1jDo3vo8dMW3i
         AkfKszqRy++qEph248hpj/NbX5l7HitxShJYxCuwTZyfjSj6hFz2bjJrapyKtCKYQJBF
         KAeSUF+mealzPMMzwfRP/g14cSjbd+D30VXWOFW4S4fg4sQZapf0rS6AAy1wHbeRy9rc
         3x40WfZ4Jx8OKYKFBsKh/DlHf3RrL4gI+Ps+ePeoHZSnHoAZ1fvyI3uC25+GafryF5cN
         XMJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791604299; x=1792209099;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=oHTcdU7BDJRK9HJIi4NfQxgJw/5DvdcfPlbURZ+9Mwc=;
        b=BjGP77DMVGWxIJ5LRjJzo3+EKg+luXYCIvbDaxtGrFsQ5R3bpX2/IrqQBBPmhcVAAb
         gaNl5HhFr2JbzAsm+Qpzqojtuy/7+ObvwMA8hEGhgV4wDRzlkK2LruRlgpHxsSkx/lqW
         lA/LynJbm9XAWnMWy4/aB97oPOehbN7RKLAyTq+Ke4blbritbdv4AYzeFsH1RfgvyCbD
         0MkJ64jkzn7tGdgzB9O7MWD/Xt0U2UoaEQNbYAyYdcRa0rgV/q8kYmkMSOGEf/MpOBsF
         sLLoz2tVhF9YZkkwNC2irO2iRSQdJ2zbDGSUSDkNkdHuCLG254X4slO4HzAbhdszjaYL
         76iA==
X-Forwarded-Encrypted: i=1; AKwUvBwEOIrjaDivTSKu+JaRuwbMXVnXU7c5ZMwDiL5yNW6mRjvfF2PtvrcyhQ8ow3Hcbt7y2SyRd/o=@vger.kernel.org
X-Gm-Message-State: AFq9FYLY57VFFtS0kpc3DGtx77UvaCcj69x+Wjqgb53hWnC9mYif7rsY
	5H6jFhFfO/nnXYxm2yXv0XvQwOWKNmdjOZ1mLNrew3/MG9gUEVU6FM3W
X-Gm-Gg: AYBFou0APfVy51SULBsDD2SS6+YcJCXb+9aSbrBHnn+2mLHBLZTIgimTQ6HtmIt9Rme
	rzVWzX0jPprupqJtz+Kebb5l5hppTTtt4HBzchka8c7gmX9A/QhNQvoEDK3Gl0el06VrOdBAgbY
	3tkCvQ379wzRCh+81BKm/M1D1h5cH4n3RnlW88Vxa4GB1FHq62yMPdemdlrKMsTvS+oVtpgEIrs
	PPQolS/EtRbJWAh/36CjUhYQ7Xi1NMK6zqwvPg+1yA+ITtojQRlD/ck7qpRKvhxVgrAHzIyugpr
	HWMlvpFRB6YTgquoGiOoJxunqmxoy0Y4DU3MvR14HFlITQoAqSLWMwboUw9CsEvhw5QtBjdAZ3U
	9GaXuVIm6cA9Yg8/lXJ/f01bL7AxijB4zF3F8XPjctFFJbggwDIqMUxaqa2bJHhpvki8vDUvoTh
	WHa4yABo5rWFSUHKVufw49al7TPsvpI1wO75P5PIVtWigSOC0bvLxP8n8NUQcXI5aQhrCztyDfl
	wJZmG8DrNZQyYJltbBru5uPRCGWfI8bKCVCZbheF40=
X-Received: by 2002:ac2:4e08:0:b0:5ba:3f72:3c61 with SMTP id 2adb3069b0e04-5bcde8ce984mr1402306e87.62.1791604298863;
        Fri, 09 Oct 2026 20:51:38 -0700 (PDT)
Received: from dau-home-pc.. ([95.139.131.22])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5bcdde9c924sm1161984e87.36.2026.10.09.20.51.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 20:51:38 -0700 (PDT)
From: Anton Danilov <littlesmilingcloud@gmail.com>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	Thorsten Leemhuis <linux@leemhuis.info>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>,
	"Remy D. Farley" <one-d-wide@protonmail.com>,
	Rachel Menge <rachelmenge@linux.microsoft.com>,
	netdev@vger.kernel.org
Subject: [PATCH 6.12.y 4/4] doc/netlink: netlink-raw: Add max check
Date: Sat, 10 Oct 2026 06:51:16 +0300
Message-ID: <20261010035116.578385-5-littlesmilingcloud@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261010035116.578385-1-littlesmilingcloud@gmail.com>
References: <2026060807-egging-prune-a3ae@gregkh>
 <20261010035116.578385-1-littlesmilingcloud@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Remy D. Farley" <one-d-wide@protonmail.com>

commit bf5a54bc0e3d8962474fcd611f1266eba036232f upstream.

Add definitions for max check and len-or-limit type, the same as in other
specifications.

Suggested-by: Donald Hunter <donald.hunter@gmail.com>
Reviewed-by: Donald Hunter <donald.hunter@gmail.com>
Signed-off-by: Remy D. Farley <one-d-wide@protonmail.com>
Link: https://patch.msgid.link/20260303195638.381642-2-one-d-wide@protonmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Anton Danilov <littlesmilingcloud@gmail.com>
---
 Documentation/netlink/netlink-raw.yaml | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/Documentation/netlink/netlink-raw.yaml b/Documentation/netlink/netlink-raw.yaml
index d8ae7f7365b0..d6d58ac63b7c 100644
--- a/Documentation/netlink/netlink-raw.yaml
+++ b/Documentation/netlink/netlink-raw.yaml
@@ -13,6 +13,12 @@ $defs:
     type: [ string, integer ]
     pattern: ^[0-9A-Za-z_-]+( - 1)?$
     minimum: 0
+  len-or-limit:
+    # literal int, const name, or limit based on fixed-width type
+    # e.g. u8-min, u16-max, etc.
+    type: [ string, integer ]
+    pattern: ^[0-9A-Za-z_-]+$
+    minimum: 0
 
 # Schema for specs
 title: Protocol
@@ -270,7 +276,10 @@ properties:
                     type: string
                   min:
                     description: Min value for an integer attribute.
-                    type: integer
+                    $ref: '#/$defs/len-or-limit'
+                  max:
+                    description: Max value for an integer attribute.
+                    $ref: '#/$defs/len-or-limit'
                   min-len:
                     description: Min length for a binary attribute.
                     $ref: '#/$defs/len-or-define'
-- 
2.47.3

