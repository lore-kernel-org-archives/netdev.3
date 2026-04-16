Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 786663876C4;
	Thu, 16 Apr 2026 22:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776379253; cv=none; b=F0dNzm9+mzc5mN23lNz6lU5/+HIOa7WH1Erq6IxtccbxrkI0ibcuYX8DAEerfB+9KEPavXKa5PyvqUTQXAFbaS6Yd59iDn3vHqgoMv+GGb2NkWkuS/CAC64IQLeDPl2h96UCt+W28DL7Cyppys/dk+nqFqfWwTG6eZgtn1q+D3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776379253; c=relaxed/simple;
	bh=sC+zcrByO+PGlqBAQ8rYqYYaIL1rr++mYDDrX4PXZgs=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H+onEJEA7u2vI35gfkOT4bPPwiZcs/ADvGajc7fvr57HNOLm5bBKr2ly0JCfzJgW65jyxNrIFRXtWXTxsoWs8CGNHZ0Y6PTX70yoAvdCeIQr1ZTDUXVaSSZUYKdkvgZvLKaVeuDKWdZC9RbKmYzFlK30GnyJS3jYCPfEgt4I0eE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=RCK1HdBg; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="RCK1HdBg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1776379250; x=1776638450;
	bh=+hcirqWTitm0iG+vWSxCcCrg9AcXPeBecN4cQG5hBU0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=RCK1HdBgleK7OAkuLRCOP6pIHQVCGyf+HYKXEmAOCrBdVLq4MoJZY9KIrwsEByXjm
	 xWQsUeQWBG09dTeGHYfYDEqIHPiKZcNR/2r+hShkyihRPcWFsvtFQUaor4U8vIqfoe
	 5beR5ELzUD3LyExV48e/RTHsiGr3lwxg0qyShXHHXBJxXRR9rHV+JRgtf9Zj8BXdIg
	 Ff0heUIb0kGTzfBjpYzRCxHbcNAPuC2hlso11kKyTku8GKgo6Jik4zwvNNGz6fdszz
	 LVTH3dBD1/s48ofVYpAi2dAYQCpzk57vGTjqIVSqYrbxZn1AaDDOqlJvnjy2sMmABZ
	 10VeXGHNxRJ0g==
Date: Thu, 16 Apr 2026 22:40:48 +0000
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Alex Elder <elder@kernel.org>
From: Alexander Koskovich <akoskovich@pm.me>
Cc: linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Alexander Koskovich <akoskovich@pm.me>
Subject: [PATCH RFC 1/4] dt-bindings: net: qcom,ipa: document Eliza compatible
Message-ID: <20260416-eliza-ipa-v1-1-f4109a8e43c4@pm.me>
In-Reply-To: <20260416-eliza-ipa-v1-0-f4109a8e43c4@pm.me>
References: <20260416-eliza-ipa-v1-0-f4109a8e43c4@pm.me>
Feedback-ID: 37836894:user:proton
X-Pm-Message-ID: b1235ab0014dab494a1ff26196651d0f34457f5b
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Document the IPA on the Eliza Platform which uses version 5.5.1,
which is a minor revision of v5.5 found on SM8550, thus we can
use the SM8550 bindings as fallback since it shares the same
register mappings.

Signed-off-by: Alexander Koskovich <akoskovich@pm.me>
---
 Documentation/devicetree/bindings/net/qcom,ipa.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/net/qcom,ipa.yaml b/Document=
ation/devicetree/bindings/net/qcom,ipa.yaml
index fdeaa81b9645..38a5a337c34f 100644
--- a/Documentation/devicetree/bindings/net/qcom,ipa.yaml
+++ b/Documentation/devicetree/bindings/net/qcom,ipa.yaml
@@ -60,6 +60,7 @@ properties:
           - const: qcom,sc7180-ipa
       - items:
           - enum:
+              - qcom,eliza-ipa
               - qcom,sm8650-ipa
           - const: qcom,sm8550-ipa
=20

--=20
2.53.0


