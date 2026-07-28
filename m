Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E61D42AF94
	for <netdev@vger.kernel.org>; Tue, 28 Jul 2026 11:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785238990; cv=none; b=BJG80LQb4iVO2AYlHswNI3+fr2XG3h/BFaDOOO0oh2GCjgQ8sE9i1Rd/hzc2+cYfdvZMcNreztsQl2j33bTtCAdrtzs6UMELwmfE0CCL21slqHlWIX5gFvSFxgpcG0AssgSrCfyIruK5ulnzzbZ/UAhMhqqhuRVq/bXBXuBFe9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785238990; c=relaxed/simple;
	bh=0euIPyBzRxpAJl+05iawUam7o4hv9536euClyCfq3S4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Kih4qCUxRBbsmrusmN9ewZqLEz/wd3QHuhfg16pnDWApmbB3jOZgPnnU0TuZefOQ3nc3yHVQj3bVK5ZmEyzByxbbW88VOyuvzUWMxp3OCFIU/kamZK/h5i54xQ0bz9jPGyAAF2g1h1QTPup6uua1stlva4yY2qpjH4K0DuAN1dU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in; spf=pass smtp.mailfrom=cse.iitm.ac.in; dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20251104.gappssmtp.com header.i=@cse-iitm-ac-in.20251104.gappssmtp.com header.b=Fu3bRBZm; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cse.iitm.ac.in
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20251104.gappssmtp.com header.i=@cse-iitm-ac-in.20251104.gappssmtp.com header.b="Fu3bRBZm"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2caf228a910so28560765ad.2
        for <netdev@vger.kernel.org>; Tue, 28 Jul 2026 04:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cse-iitm-ac-in.20251104.gappssmtp.com; s=20251104; t=1785238988; x=1785843788; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=39GrJvnkpg8Y0WqMuL6o5Nxkg2xZIq2hCAlpo4jOXC0=;
        b=Fu3bRBZmPIbA/eag6vIWKIphjlhnI2HkunBnHyGaRyuZtA8xCsMu9ePRFMWgL+7tOU
         cWoDaYUA84+b4Whl6maYPq7dSsbm8nmiMfZFw2vYckWMa36Zsk9BiMD/h4ubPP3m91ny
         hHwtsjXIDaf/DEFr0f5iOagC3cPwdICrM++3icORGI0Ds7coIp8I035GpAYqGUYtAXNb
         lm4v6eAUcDgXbg7q0Ij2pNqtEMYUD0oWBIJnDE803933rY8eeT+79YheZW7ydjcjJMck
         FDVWDCejS8x2lS017gz+ZV1vTLJeYiwVd8IDhawjmUoMHKGSl/eOC5YJU6r2/umAuUxa
         8DSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785238988; x=1785843788;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=39GrJvnkpg8Y0WqMuL6o5Nxkg2xZIq2hCAlpo4jOXC0=;
        b=VvAJi7ngz5Lu9BScgpurW26uPgz2FD+o7M1/V6u6HMb8v9rGLSIOd8p9V8RWr3M+Nz
         H+dCmyerrnsVwhYl0xQYro/vpkwZnIgzEcapeBqxhEjz8xvKyJND1FCdRXHOAUEfuva9
         K3vT6ECIvquyB8fN8zwKMLMvz4RJ/6lll9L5afds01cjU3QShP4s23BZu6hWmjxrUBbV
         boq8pJTvXvEqBvi98xIeEldoO4D5utWx9Gmw/VTDthQ8FiOxlxuT0APt42W0UsGgYmSH
         IIA2BSqgGfZb5HmMFJSODIljDtf4zTs4gSwNMo+Y2uBbpy0fJSSSd/dn/awPzmB8cJP7
         xPwg==
X-Forwarded-Encrypted: i=1; AHgh+RqLAZ/UwJ+I+HXWcLY+6tqO8iTJuPUFjkBc8d4PCRLqzje1y8bCOjSkTfK55UuWKSiksvXYv90=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzAfkMukzXG2W2UZJgDwMZUVmzhZ9quA7CNO+Vh3PezWoVP8kk
	c5j/rxmOvLaca9sHrZvAfpDh0ZS9FfHwHLLEllvRzBw6xM5ihCBSP0AK45+0F9KIWUU=
X-Gm-Gg: AR+sD11lw9MsM11iG53qZtssh/1wat9Jk9xZ05NdJJG8uKPlWU7sZZLWo1uFSo/9CUq
	Q5hEv2qyoFV/gnui3kQG8nY7NQcYRpnnh5wUe+YpsGhLMemKnnggllgh+qdlGJldlFJpSiK8EXg
	2/s3rPBhK6xwktxBEIAmV8KPm/QVDM6pIL1W2a6aFTLY73adWSJkGQYCUgq/5JuV9edZgXTfYaQ
	yOG40VAHDrKiwjFltnzItPP4Yy0IqSzmR3tmXA+XSjq7Y7KwV4tq/M00hzeUthTAS8cpimoqucU
	bxHAEE57yB0WjzBLAQn7NuPr2J70P6vuQONph1cbfCZ1QBZe46EvY9+iZ/uiQNsBv+BDJ2Hk4jQ
	crGI0VCpibTFPyI7upym7om5L3G2lX3f+2nUZnYlJXnqe2H59o+zdIHoU8jVqHmoVklR0pUL7hv
	PMNVcYK++I0UnyHHhCrpEOTKCT8hxqAzRza8TgbsmIaYJZZz1zF+JvZJ1NxXc3ssHidWYgTOuqR
	p24rij8pXaKoKExlFYXWOAAMlXbKhDs
X-Received: by 2002:a17:902:f64c:b0:2cc:98b4:e7d7 with SMTP id d9443c01a7336-2d01605dbe6mr24259225ad.45.1785238987907;
        Tue, 28 Jul 2026 04:43:07 -0700 (PDT)
Received: from Metius.iitm.ac.in ([103.158.43.43])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-2cfde59bc5asm50642555ad.6.2026.07.28.04.43.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 04:43:07 -0700 (PDT)
From: Abdun Nihaal <nihaal@cse.iitm.ac.in>
To: Steen.Hegelund@microchip.com
Cc: Abdun Nihaal <nihaal@cse.iitm.ac.in>,
	daniel.machon@microchip.com,
	UNGLinuxDriver@microchip.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	joe@dama.to,
	linux-arm-kernel@lists.infradead.org,
	horatiu.vultur@microchip.com,
	stable@vger.kernel.org
Subject: [PATCH net v2] net: microchip: vcap api: Fix possible memory leak in vcap_decode_rule()
Date: Tue, 28 Jul 2026 17:12:51 +0530
Message-ID: <20260728114253.196398-1-nihaal@cse.iitm.ac.in>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The memory allocated for struct vcap_rule_internal, keyfields and
actionfields inside vcap_dup_rule() are not freed in some of the error
paths in vcap_decode_rule(). Fix that by calling vcap_free_rule().

Fixes: 610c32b2ce66 ("net: microchip: vcap: Add vcap_get_rule")
Cc: stable@vger.kernel.org
Reviewed-by: Joe Damato <joe@dama.to>
Signed-off-by: Abdun Nihaal <nihaal@cse.iitm.ac.in>
---
Compile tested only. Issue found using static analysis.

v1->v2:
- Convert the error labels from "err" to "out_err" to avoid confusion
  with the err variable, as suggested by Joe Damato.

Link to v1: https://patchwork.kernel.org/project/netdevbpf/patch/20260727125757.134611-1-nihaal@cse.iitm.ac.in/

 drivers/net/ethernet/microchip/vcap/vcap_api.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/microchip/vcap/vcap_api.c b/drivers/net/ethernet/microchip/vcap/vcap_api.c
index ff86cde11a32..376be059d662 100644
--- a/drivers/net/ethernet/microchip/vcap/vcap_api.c
+++ b/drivers/net/ethernet/microchip/vcap/vcap_api.c
@@ -2427,18 +2427,21 @@ struct vcap_rule *vcap_decode_rule(struct vcap_rule_internal *elem)
 
 	err = vcap_read_rule(ri);
 	if (err)
-		return ERR_PTR(err);
+		goto out_err;
 
 	err = vcap_decode_keyset(ri);
 	if (err)
-		return ERR_PTR(err);
+		goto out_err;
 
 	err = vcap_decode_actionset(ri);
 	if (err)
-		return ERR_PTR(err);
+		goto out_err;
 
 out:
 	return &ri->data;
+out_err:
+	vcap_free_rule(&ri->data);
+	return ERR_PTR(err);
 }
 
 struct vcap_rule *vcap_get_rule(struct vcap_control *vctrl, u32 id)
-- 
2.43.0

