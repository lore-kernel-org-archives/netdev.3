Received: from mail-24418.protonmail.ch (mail-24418.protonmail.ch [109.224.244.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A43F38D;
	Wed,  9 Sep 2026 03:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788923486; cv=none; b=bq3mzYRZELjG5Ll92S6EkzP7FglAokXcKLtj/qSQftCzP0LZPXkzPLBjFncDGKNFBoGkIR+uVnEfd3fvcVCQBkEn/t85lSy3vKPnx/t1VhizYnwWaZFBjHKygcS9ECCm2sxqi9KwWo9i8xU/Pf0E8r6hH3YL5Xu0qcNx55clzY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788923486; c=relaxed/simple;
	bh=dLNKuhcrePHbBifLeDTkAyjnCHYYE/stTjBihrmk+bg=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cKEkSuEveqh+nkjDHu410Vxk4NWtCI3l5gsxSU7gaToWxmnkLNDQh/rb/RilhZ7g0rCBaJpbjfsy5uowPjjWuC1MFTdLOW1HAn/IkfTlE1jYMJeiiVOU3Bzes9UPmCSrvxe+4VsSUvnoZmDtQAY4JpiUkO0jpfWrJqSAanq2DuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=JS+ehv2o; arc=none smtp.client-ip=109.224.244.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="JS+ehv2o"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1788923471; x=1789182671;
	bh=6V5vNBbkmNPezVZefxzahR0ftBgmoG/UPsu/x9aLVH4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=JS+ehv2oFu9q3QePjIySoIdMB2f791dLteUPVv8SjxqnZE5+uD0+l7w5+9aU9Z/qn
	 8QjY3UVNfB5hLdF59Ug4dvrV6yNo0h7ibqmmkgwmbT7mxgzxMLOqZbtUZSxWeEE8G5
	 u0vXXN/v9dNH6WKcj+CiePsw3AmNWiXH+vufP+nicVpmxJb/jU3erfZQZoJO/BYaZh
	 kPFoHhAePSg75xxWBtRD8R8KeWVrc8N8S9bc1eqy8OOMgHaZsrDRD1FWtmX0YuZV1t
	 qCbcuv2oqCQCHlLNVK007cC5PnMVPONdbm6f57Kg8G4tbDqsil7xmDbW04HqMJMsTg
	 PLyiCH/tnUsgw==
Date: Wed, 09 Sep 2026 03:11:04 +0000
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Alex Elder <elder@kernel.org>, Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>
From: Esteban Urrutia <esteuwu@proton.me>
Cc: Esteban Urrutia <esteuwu@proton.me>, Nazar Kompanets <xlie7669@gmail.com>, linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org, Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH v2 1/3] dt-bindings: net: qcom,ipa: Add SM8450 compatible
Message-ID: <20260909-sm8450-ipa-v2-1-2deb8b4e91a5@proton.me>
In-Reply-To: <20260909-sm8450-ipa-v2-0-2deb8b4e91a5@proton.me>
References: <20260909-sm8450-ipa-v2-0-2deb8b4e91a5@proton.me>
Feedback-ID: 147889766:user:proton
X-Pm-Message-ID: aba9c28308fded0664a4deff4d2b230bb8215508
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Add support for the SM8450 SoC, which uses IPA v5.1.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Co-developed-by: Nazar Kompanets <xlie7669@gmail.com>
Signed-off-by: Nazar Kompanets <xlie7669@gmail.com>
Signed-off-by: Esteban Urrutia <esteuwu@proton.me>
---
 Documentation/devicetree/bindings/net/qcom,ipa.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/net/qcom,ipa.yaml b/Document=
ation/devicetree/bindings/net/qcom,ipa.yaml
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

--=20
2.55.0


