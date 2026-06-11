Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A05FB23EA83
	for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 10:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781261645; cv=none; b=AQVN5NBOAx3JuOjFwRDFULO8kbZg8wcBF28QTHiFJcH0mETbJrw3SKtb1zqggE6fYC83ynUxtdX/TLp0xNumJw6Dx2MdN7ZaWzpnwh0vBEksIe+LOaJXPP1L6mxGLElBAvhCXskvFfh5iWelzxYwyXv+24V9dQC/agoftM78YgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781261645; c=relaxed/simple;
	bh=6iqgc/JGxfvkEZYNLqNHNs57KIjHNiooSiG5PIW+s2M=;
	h=Message-ID:From:Date:Subject:MIME-Version:Content-Type:To:Cc; b=nc4Wecq2V9fLkH9AvHG0TwoIJttxghTuX9mr6e3TKUzRqQOtbfJv1K9ljuuklE6bCiEoT5nXUTsL31ICKfC03kItxZwa6c9gLf8wkwjKFBBYmNC/YiB37F4nuqDixWdRrIW+prLrWdyl1FML7/GhZn5MSow40k/hV8EB8f9b/H8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z1I0dIju; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z1I0dIju"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2c40397e3caso5691075ad.2
        for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 03:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781261644; x=1781866444; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=vWBjerCcdQYX1kqAzoQ1GBFmI7LAy21K3qYQTp/XVXQ=;
        b=Z1I0dIjuTozPgFKVCSgyqw53G0m7uA7XyZvkE8LGHUPaN7/CYKpZRs4m2fztoZCIMu
         31KljYsv+cVDyKGqPemAkmrwzPI4OteNfAPZs9kzK/eKKuQ4Lno8dfKGGE03ewNOaBfJ
         kHHY1mVTA7JKqJRrzLtIGpdOfjLRzm8ydE8hf42RGR0eK4Wjl8htNno38Dd2Jd0gHi28
         3wvlsfrV3ipCQPHpxa5BMuwXe03rllqu8JlKSkem78aeaE09Zo+uJZ1DTBt8STEo7nM5
         A4XbHC1Lc3zsl+zwjtKIRoNlmBx+ERFPJDAP4PRqYW2/hArQJY5Nq2pu8twFUDTChZbm
         DLjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781261644; x=1781866444;
        h=cc:to:content-transfer-encoding:mime-version:subject:date:from
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vWBjerCcdQYX1kqAzoQ1GBFmI7LAy21K3qYQTp/XVXQ=;
        b=lS+jCVZDKxRb/Uwy2eh8uQsMKJekaqD0HOHSur7g/H5bU42TEApilyyxdeYWbg2CSa
         HIlZoO1O1qhBcYfScFaYFK6o67chqJ7BAgLVgUIA5bqtAqDwowoIF/K0NwsPUvO5rY09
         /sL5+UA44VoyVhzUJXMi5fnXdRmo+n10XZbQPekoRGGFmjWfqmVwi/DGHc+vLL5DxAxL
         I6dAOJyMxpoppbPjCYOFHAMXV2AbEREPqQqBekc+ztcbi3rXGck37VYUqTvK/FKB47do
         7pVlNf/ctm37qvR0s7v2+UlwM+uKVIovvpqxMb2XsQNTlX2CGVKFIi+duQzKmQ4TCiGj
         b9uA==
X-Gm-Message-State: AOJu0Yz5nRTWfQfXAlQelQ172yPxqvzWl16SL+kRzg/Zxn2ZYlWsqHlL
	2Qyqlr6cx0jpSPakLR8hMG3wtYmYQ/7ZZNl01N+IOw4lOaTnMaGniIGELxzVLeZ18bg=
X-Gm-Gg: Acq92OF2EMIwE0Q/Up34zLg6elkye904SNUHD23pJzz2e+etDSyXxH+50758VuPIzKN
	asiao+ug+FUmQm0JdBjl0Hm42r9yUDIax4hS/ejmifhr+mgeVsTnry8hjNE7PM34C/bTd8Mb6SG
	vo5DOreoBcNZdlycwSk+QSHLzVEnL5wlu/gcrxVycti0ZO52aN0ELno81DnJEp5uKvga9Tt74Eg
	86FbehAqCel9/m9dZJGS6MUALo5YtDM+CbOmxVjnj5tpxwUYT+oQ0mk0KMBW5u+J6PUeGzYh2vO
	l/t6Pbm/MtQ6lkvk4f+2rCeRMzikKM8YtQLLFCilnS6+FyKPCD8PSSbnJgIsdt2M4KFPVw7HwQD
	/mU3+dpIu6j9mdhrMmyW/fSNS9Ne0XzCoz3Lvq0ur8vkW+E99N/H6KoRHYew/YdGd24OvyI6ZGv
	yAfX7SmijkAzxCTSMdSTUPJPDxOJk=
X-Received: by 2002:a17:903:1aad:b0:2c0:dd75:e834 with SMTP id d9443c01a7336-2c41050af58mr30846105ad.5.1781261643919;
        Fri, 12 Jun 2026 03:54:03 -0700 (PDT)
Received: from [127.0.1.1] ([47.253.114.73])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c432c8ce89sm17909875ad.57.2026.06.12.03.53.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 03:54:03 -0700 (PDT)
Message-ID: <6a2be54b.ef98c1b2.3c3224.2ed8@mx.google.com>
From: "Wayen.Yan" <win847@gmail.com>
Date: Fri, 12 Jun 2026 07:09:56 +0800
Subject: [PATCH v2] net: airoha: Fix debugfs new-tuple display for IPv4 ROUTE
 entries
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: netdev@vger.kernel.org
Cc: lorenzo@kernel.org, horms@kernel.org, pabeni@redhat.com, kuba@kernel.org, edumazet@google.com, andrew+netdev@lunn.ch, angelogioacchino.delregno@collabora.com, matthias.bgg@gmail.com, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org

In airoha_ppe_debugfs_foe_show(), the second switch statement falls
through from PPE_PKT_TYPE_IPV4_HNAPT/DSLITE to PPE_PKT_TYPE_IPV4_ROUTE,
accessing hwe->ipv4.new_tuple for all three types. However, IPv4 ROUTE
(3-tuple) entries do not contain a valid new_tuple — this field is only
meaningful for NATted flows (HNAPT/DSLITE). For ROUTE entries, the
memory at the new_tuple offset holds routing information, not NAT data,
so displaying "new=" produces garbage output.

Display new_tuple only for HNAPT and DSLITE, and let IPV4_ROUTE fall
through to the default case.

Fixes: 3fe15c640f38 ("net: airoha: Introduce PPE debugfs support")
Link: https://lore.kernel.org/netdev/6a2b40ea.4dd82583.3a5c46.e5a2@mx.google.com/
Signed-off-by: Wayen.Yan <win847@gmail.com>
- Drop redundant PPE_PKT_TYPE_IPV4_ROUTE case, let it fall to default
Changes in v2:

---
 drivers/net/ethernet/airoha/airoha_ppe_debugfs.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/ethernet/airoha/airoha_ppe_debugfs.c b/drivers/net/ethernet/airoha/airoha_ppe_debugfs.c
index 0112c41..e46a985 100644
--- a/drivers/net/ethernet/airoha/airoha_ppe_debugfs.c
+++ b/drivers/net/ethernet/airoha/airoha_ppe_debugfs.c
@@ -121,8 +121,6 @@ static int airoha_ppe_debugfs_foe_show(struct seq_file *m, void *private,
 		case PPE_PKT_TYPE_IPV4_DSLITE:
 			src_port = &hwe->ipv4.new_tuple.src_port;
 			dest_port = &hwe->ipv4.new_tuple.dest_port;
-			fallthrough;
-		case PPE_PKT_TYPE_IPV4_ROUTE:
 			src_addr = &hwe->ipv4.new_tuple.src_ip;
 			dest_addr = &hwe->ipv4.new_tuple.dest_ip;
 			seq_puts(m, " new=");
-- 
2.51.0


