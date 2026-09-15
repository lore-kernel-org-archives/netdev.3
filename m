Received: from mail-pj2-f3.google.com (mail-pj2-f3.google.com [74.125.227.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8728475328
	for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 12:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789476002; cv=none; b=erHCVlGdn+ruNeJQz1GQvI3U9ZHVc+qwyG3nzBRVR0fY7+mBXoGQN2IgrsWNW71GrUxwW+FnOG6+RRmQj5LgEziu+wVux2Il7hCVFE3EV7fJHIfGhiUPsBfWnEE4QVAVpmUY4CxAUv4zNHISYle2OBI8pgQ3/7EECrzKYP3+toI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789476002; c=relaxed/simple;
	bh=tCrgHNTqayWFj1XRarWJorXnl2XIBvQrDCQv89fV94M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i1CKH+sC64PeCEDSEDS28xNj/j9oL8N6/XgwlFk0O8NAtVM7xBf4hEY6k5dgke3sGRSK6LMr8Ctnw/uVy9uiUB+kBM10CpLkB/z9C1XnffrA5uVQwyXTc7056Zp6ZziIRA4QxmtzxMq/SpWXSeobKn8iiAvsfBYMNERBvBnvgQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AtCYZ6Kb; arc=none smtp.client-ip=74.125.227.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AtCYZ6Kb"
Received: by mail-pj2-f3.google.com with SMTP id 98e67ed59e1d1-3859292bb51so247742a91.1
        for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 05:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789476000; x=1790080800; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rQei+xFrWR/8tHZU0Qo/Qb7KMibEAMjL/DUhroeeXK4=;
        b=AtCYZ6KbYOaS9auUBsv8QrA525jxfl7noKBHqjywxD6PrRM3L3BZVbABKVBYp5ysZB
         hcINfyL3TmcfDgLgSxDUYaDGiUNVappIAvlUN5UovcLxMpLJMcnWJ91XM1yQlXwsI6L6
         BMe7Ju+StEikNSmPbDQTpnSsr+xfHv56oday/jdbZ4n3zW3Uv1QcBtnncaMmoIC3Z+VY
         Be90ZFC3QgypwSxgwYbHWhUN8ocO7OjvZ2eW5Pa6AI2Vf6EpT4tHfpx97/rSJrew1tEG
         d6pzWISrtHgb4/MQEv/QqQs2fczOCabJgX8KusZ7rDM6RtgjIPl4Ecuvnt8BwplWsQPT
         iMpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789476000; x=1790080800;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=rQei+xFrWR/8tHZU0Qo/Qb7KMibEAMjL/DUhroeeXK4=;
        b=j01Lubf2RAH5WHj8QDAV/ovoslilotEjgUKr3yOeiFD1DHRb4dSFDMd06/gTCwk6A3
         Zq9OnraFKebjZZbXH5++hWs9R+fK5ezvy5btxDwKp3p3Cn57ICyS4kFKJLoz9by1F5bY
         ziDBg/75JsUhAF7TG1ehPWhQheN1R+fWcvcCL6+fSltzBR6Vq4B8lSIm6rOHVhyHCr2d
         fhtAnfZGJ7Eo7zYvM7vXAFbMESfzEd0n8K0C8C3Ex9AZYIHYJGHcMuJ626AZoKf8Eg1H
         URltXaQqz1doVVkLtMNW9DLA+/fxo7Ht1fehQtQyeXRysDKNhx1TtRZB+amu1qw24tPi
         mwFw==
X-Forwarded-Encrypted: i=1; AKwUvBzsm4deaZm1WjAXkeplsFDVECb50b6MK8v7WJcxVoiEpje6p64YFbMuhgvHTA3NmKJ+MhppvtI=@vger.kernel.org
X-Gm-Message-State: AFuF++lxSDF9/0RFzGb/d3u+PPoBklYpMFNU46KXtxbG1MIqMTMCnQ3P
	IpxBDl+/gpuy+TZdm+OOBQOFFgTtdl3fib3/zGkSIdcxU/3+C3ipJyrU
X-Gm-Gg: AYBFou10bbs7VjNjqbbArQia3yimDfnmuiNg1Jtn4Jf0+MSbIwDnehshgnzIrkCsEsX
	i+xwfl4FK5fXUEB2aXHzNGgHUaG0mN36DY52HpbFZvi6kuTZYZlHHCMraMBwJ026D0Mt25QlUYk
	E99HiL1buOfvYW5TIlpTaXhl8xKZnCk4DWqGKZRHsbiEcZIYrGQvz4P9tzXVSfE6pcoesbEJ+3j
	IGNCBFCfhaRLGi54OEpwxPHTWdeV8VZCEmpF1fVfRWvRL6Ij46xjwGI7pBbX28GURC2uCB+8NJC
	nFVbJdV7LftrxoprwwsGf4gkuuOGj2tJJRS1IbENI6P8DkHmexlaB9mWBGpvZAhkM8K2giUsL7X
	IJK13cXdb5/nezyMoA1tZsW1+/UQahwPxmuBqqaA1nhus6dmOpObLEHaL8hClZWkng8Drc9/b9F
	f0DXL55O3f1plTj9EhkK0o+CxI3k+SL/vSdgP+R7AEn/NPcH/h2k8JFucRdrmvWJWx41qp6bA=
X-Received: by 2002:a17:90b:314c:b0:398:9bd3:d6d6 with SMTP id 98e67ed59e1d1-39dfe1901e4mr3823167a91.16.1789476000343;
        Tue, 15 Sep 2026 05:40:00 -0700 (PDT)
Received: from server.lan ([168.138.199.194])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39dfdd28acbsm5307259a91.10.2026.09.15.05.39.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 05:39:58 -0700 (PDT)
From: Coia Prant <coiaprant@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Vinod Koul <vkoul@kernel.org>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Romain Gantois <romain.gantois@bootlin.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Coia Prant <coiaprant@gmail.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
	Russell King <linux@armlinux.org.uk>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	David Heidelberg <david@ixit.cz>,
	netdev@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-phy@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-renesas-soc@vger.kernel.org
Subject: [PATCH net-next v6 11/11] MAINTAINERS: add entry for Rockchip XPCS driver
Date: Tue, 15 Sep 2026 20:38:00 +0800
Message-ID: <20260915123802.1561724-12-coiaprant@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260915123802.1561724-1-coiaprant@gmail.com>
References: <20260915123802.1561724-1-coiaprant@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a MAINTAINERS entry for the Rockchip RK3568 XPCS platform driver
and its device tree binding.

Include the relevant mailing lists (netdev and linux-rockchip) so that
future patches are properly distributed.

Signed-off-by: Coia Prant <coiaprant@gmail.com>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3b2eb2a7a89a8..f53a519da6298 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -23739,6 +23739,15 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/sound/rockchip,rk3576-sai.yaml
 F:	sound/soc/rockchip/rockchip_sai.*
 
+ROCKCHIP XPCS DRIVER
+M:	Coia Prant <coiaprant@gmail.com>
+L:	netdev@vger.kernel.org
+L:	linux-rockchip@lists.infradead.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/net/pcs/rockchip,rk3568-xpcs.yaml
+F:	drivers/net/pcs/pcs-xpcs-rk.c
+F:	include/linux/pcs/pcs-xpcs-rk.h
+
 ROCKER DRIVER
 M:	Jiri Pirko <jiri@resnulli.us>
 L:	netdev@vger.kernel.org
-- 
2.47.3

