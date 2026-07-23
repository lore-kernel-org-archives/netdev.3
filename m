Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73D2D350D74;
	Thu, 23 Jul 2026 23:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784848156; cv=none; b=BOcGgr3s/zKLWWIqSQSgrFPnSDWkevp+7JUt0cEbFJYYxj+faW/jVXLfIUUykMftHWO56N69CllSpHRstad6wxCzXtY3OaWnzfU6bcEQ8qEs3kNCDW5jly9ckr8CmHBrKsv/fCL804OVxktWcxcopdTVsz7aoOco7eAl8pmYSsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784848156; c=relaxed/simple;
	bh=jpExcFbAllSaU0H8zzsOMipgVwRjwhTGfY/9qx8vQKY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KquZmwrVYPQzb14PluoKSdEg1CQkEpMBs8/8mbgAoroVz9758YVCKsR4Ewdgs9vDvUMqBUxYanEz4KRrOBoXoniyo14G87yi17DbFeYJMW574vjTPj1x8rtlSA66CKcWlQmcK4yTV0q4G20UWtTw+mdj9KPkLqjbL6izCBnFtlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YyC36DKn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YyC36DKn"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 16601C2BCC7;
	Thu, 23 Jul 2026 23:09:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1784848156;
	bh=jpExcFbAllSaU0H8zzsOMipgVwRjwhTGfY/9qx8vQKY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=YyC36DKnVpZchJmsaVDfJTAU3HMefQ9JOiyYpxUi2XFDuIpvYO8XgY7rIgbfUQ1aK
	 RvZwBLQsD7T2kdLsCOTScqCcRqcalarlshmE6WIwyEmsV2MAwDvBU2JoM0FFM6/sec
	 DoY7aF8YjC27xHFrm8cQHmkY7HDnjh43ITF7BhKkPDb/fD93CZaHjsdjMIkv66ZjKI
	 Qsr2TEfYvADUfOE8VFv6SvHnA3AS9Y1L5k4Jc9w8N7SakdVCJhAoNzVcZo24qQI3eW
	 W3biReraRwR0hkCku72oPFxLV5HUOxMyW/9BXZQpYF0dFI5vqJ97Y/ebq0PcmykBmJ
	 31QOC3MhEDQvw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB717C531FA;
	Thu, 23 Jul 2026 23:09:15 +0000 (UTC)
From: Vincent Jardin via B4 Relay <devnull+vjardin.free.fr@kernel.org>
Date: Fri, 24 Jul 2026 01:09:12 +0200
Subject: [PATCH 1/2] dt-bindings: dpll: zl3073x: add ZL30643 compatible
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260724-for-upstream-zl30643-v1-1-ea93ba4d85c8@free.fr>
References: <20260724-for-upstream-zl30643-v1-0-ea93ba4d85c8@free.fr>
In-Reply-To: <20260724-for-upstream-zl30643-v1-0-ea93ba4d85c8@free.fr>
To: Ivan Vecera <ivecera@redhat.com>, 
 Prathosh Satish <Prathosh.Satish@microchip.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>, 
 Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Vincent Jardin <vjardin@free.fr>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784848154; l=819;
 i=vjardin@free.fr; s=20260525; h=from:subject:message-id;
 bh=Dlh4xhCfEnokysm2lyYGJyxT/l4Fz9ZHB7O0gaUNLfE=;
 b=fYEvgmTReR29OMQGo4G0nw6hXS0kUMbVhtMfHuwyddR0FAMgXbtfyuDiUHybBbD/e4Cr0kysD
 K+NeFJmlg1jBu0LZoVZjn13yS7w2dxoOKUn2dBNBcx7IdTWXjB6i/2b
X-Developer-Key: i=vjardin@free.fr; a=ed25519;
 pk=hppgLeFpGpKOi7LNwGEZ4jOYofJCoGd4Jf1ltAabiLw=
X-Endpoint-Received: by B4 Relay for vjardin@free.fr/20260525 with
 auth_id=871
X-Original-From: Vincent Jardin <vjardin@free.fr>
Reply-To: vjardin@free.fr

From: Vincent Jardin <vjardin@free.fr>

The Microchip ZL30643 (chip ID 0x0E3B) is a 3 DPLL channel member
of the ZL3073x family. Add its compatible string to the binding enum.

Signed-off-by: Vincent Jardin <vjardin@free.fr>
---
 Documentation/devicetree/bindings/dpll/microchip,zl30731.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/dpll/microchip,zl30731.yaml b/Documentation/devicetree/bindings/dpll/microchip,zl30731.yaml
index fa5a8f8e390c..13ea55c2c146 100644
--- a/Documentation/devicetree/bindings/dpll/microchip,zl30731.yaml
+++ b/Documentation/devicetree/bindings/dpll/microchip,zl30731.yaml
@@ -18,6 +18,7 @@ description:
 properties:
   compatible:
     enum:
+      - microchip,zl30643
       - microchip,zl30731
       - microchip,zl30732
       - microchip,zl30733

-- 
2.43.0


