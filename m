Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79A9D3859E0;
	Tue, 23 Jun 2026 01:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782179061; cv=none; b=X4z/VVl5njiQz2L5bznvSG4LWkcAf7JmBPgOmXO4WMDBRraWqWQwL9IEYKTeAlUxrev7BgxJbI6yHdxP4/FVjw4z8VWf/TbeRiTy4UhxNhWVh9dh68aB5A5JEoDX7QPvHqmX03MpEbnW54VXE6e3dxENBrhLuoicduwGe3vb4mU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782179061; c=relaxed/simple;
	bh=C6pekLeFAiXx/L721/RQl2O3BL+P1Vu3Tc5jWIQ2eFM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Co2TS2EdanzfqR7Ugom141qIHW0rvdnjqqn9nVPN4O0VfOAn3iOFG8BB76ClGYNisdv2RtmXsKmxGUlhrCwJ76nJ3GTAwKX7lvNxj/AgRLbbNAwbYYKRiyaVKb+Dt+8TMtaXhRT4CJc+3Zrmo5GAl1x8wGwfzW1oQuBZ3M1nYxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CaRJR8yB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CaRJR8yB"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 234BDC2BCC9;
	Tue, 23 Jun 2026 01:44:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1782179061;
	bh=C6pekLeFAiXx/L721/RQl2O3BL+P1Vu3Tc5jWIQ2eFM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=CaRJR8yB5JK7L6JhMgcs0rZN8SWApVo9EjARIyPfKyrSIhSMKRSt8/NKPKW6FNLiL
	 B3n3b5GClNp6a/vfDwv2GPciu9Z9QBBxI+DHmokUNdm0y3okawqV2B2+wz6Npj+e1e
	 XS447tMXKHis9ufDdmdMKInhk6seSxHPwfxRiVyz8Nm8Zd60WJ4KnRYMLbcknvD+hE
	 SqMGCXi7BcZbFsCKZEvpgzwPqSQXnG8E6q7oTeHcNBq5hXBKTrm7ZevhPXuvfITZKX
	 O2vEfsjuZfM0oNjmWCEsv3YJGZ/TsM/0eyxJarHf2q0PCNh43LwNHa0kqLOFNGxWLH
	 JB7cIni6RGCZA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E922CDB471;
	Tue, 23 Jun 2026 01:44:21 +0000 (UTC)
From: Esteban Urrutia via B4 Relay <devnull+esteuwu.proton.me@kernel.org>
Date: Mon, 22 Jun 2026 21:44:18 -0400
Subject: [PATCH 2/3] dt-bindings: net: qcom,ipa: Add SM8450 compatible
 string
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260622-sm8450-ipa-v1-2-532f0299f96e@proton.me>
References: <20260622-sm8450-ipa-v1-0-532f0299f96e@proton.me>
In-Reply-To: <20260622-sm8450-ipa-v1-0-532f0299f96e@proton.me>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Alex Elder <elder@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 Esteban Urrutia <esteuwu@proton.me>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782179059; l=741;
 i=esteuwu@proton.me; s=20260622; h=from:subject:message-id;
 bh=W4HaPPuqJKWe7vEYJVxbrdUViHRUB9llZBviI9Yuc4w=;
 b=2V5hi6hHuHqSLGzTbR1Ekc1t3eHAqRambzD/YV3uUWQQviFAkWUMRyt0gVpT2cU1WdSrQBb5h
 nvZGCc5qs15B0JtRCEDVerdRrK8+CODEoyXTZXfzYD4Q5iSV/RocnMi
X-Developer-Key: i=esteuwu@proton.me; a=ed25519;
 pk=wToFt4mOAWkzbqb15Ye1hrhevI13vK9BcMUFiQ/me1M=
X-Endpoint-Received: by B4 Relay for esteuwu@proton.me/20260622 with
 auth_id=835
X-Original-From: Esteban Urrutia <esteuwu@proton.me>
Reply-To: esteuwu@proton.me

From: Esteban Urrutia <esteuwu@proton.me>

Declare compatible string in ipa binding for SM8450,
which uses IPA v5.1.

Signed-off-by: Esteban Urrutia <esteuwu@proton.me>
---
 Documentation/devicetree/bindings/net/qcom,ipa.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/net/qcom,ipa.yaml b/Documentation/devicetree/bindings/net/qcom,ipa.yaml
index 68ec76fe4473..db91bfaaf833 100644
--- a/Documentation/devicetree/bindings/net/qcom,ipa.yaml
+++ b/Documentation/devicetree/bindings/net/qcom,ipa.yaml
@@ -53,6 +53,7 @@ properties:
           - qcom,sdx65-ipa
           - qcom,sm6350-ipa
           - qcom,sm8350-ipa
+          - qcom,sm8450-ipa
           - qcom,sm8550-ipa
       - items:
           - enum:

-- 
2.54.0


