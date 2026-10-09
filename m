Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86EF94E433C
	for <netdev@vger.kernel.org>; Fri,  9 Oct 2026 17:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791568794; cv=none; b=sMCmgu8yaE+AUeiAJWvB338SN62cKbYW91q5se3gf+kPdGxcgKhKnW1IfYWuldXsjJIGg2qaVE1CkoYZCu5EMeJgUiwsmRiIoHfs+12x2MTZ9zMDptZ1plVGyM/59Tbr84Na4lRGcwbti9yNawqgOHnFZGf0ZqXGugiz+2M6QXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791568794; c=relaxed/simple;
	bh=rzbk2MxA3bmBuvl4Feh4G/Vzg97qanUbygWm4jUMOcc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A1rwu1hdTIet3QVzEUcjwTQmQ+zvHye2G+hR80f7QhVn4NslB2VHDdNoNKDOHKa7dlLT8htCTJGuGpH9YURg7gcpLcVtwsvENYjGsN9ZTV6bM/3WdW4e6xwpQ9/TMi59WPwFsrkD0aRLOX7afU/NWsLvq6vzTGOajdSolqEJU8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T/lKRNP2; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T/lKRNP2"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2e6038cebefso4355ad.0
        for <netdev@vger.kernel.org>; Fri, 09 Oct 2026 10:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791568793; x=1792173593; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1VT+ejyWafsXKR5vefLCF5m4HpAS0Vj6O8SOoRARlLI=;
        b=T/lKRNP2zB5JLneN6JCpCLQ+FzrJhKB4jErDB61N3v23EeuLWnox+jZZshBs7cyuxU
         XvZxk6bubtQiBV+qOCAWRe5b9OQsL4OMcqzCb9sANCcfPiJ5J31Td4SHhaFUNSwSO2PT
         zWOjaO2VGCWgKIvAgwE6iZqx5J3bW5vFBES1ekCxO/3MBYn8PR12MquFGpoyvwKHAzFq
         rftgEmQJu7haP5EDtGvonNGOaRjSvDNTiEE3Wfl0pwKBb7J4DsszeGoeMrPhEgo9SnTk
         9cR6fRxIThvkAbDzwg+JdN4m97LcGandDGbAGZn0i0DCPy0bMGOTnJxegF0f7gCS+A/K
         rAkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791568793; x=1792173593;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=1VT+ejyWafsXKR5vefLCF5m4HpAS0Vj6O8SOoRARlLI=;
        b=A1vtgk7fuLQ6XGJseAWEOQtmf7NJ2ihIcoQhaNP74gb3fQivDSFDg3dUb/sl7xtUKH
         Z4GqHYJb/+BclEO50q25sWhZg+dwTM9VnJ0DGYnJmKAHNh1ecTZHw6D8hSWcl+Vq35e8
         l5c4wNX0jpJSiJFc/wl78cVC+40KAYWETohw+eXJm0Qf9wH4l8oiB4zlkzSNlSP/u8nE
         x390nwHy7N6x3sgEncnXu6dUjgMRQXEzM1nqJaIzddswUexDaWe3LdLy9DjR0vyYPJi6
         w0PC3XOMOgIiOOvMzn2zr4o/wLAVPy28cQRIKX9pceVpuitPQAzGW35bIJB675t1NlcO
         5FBQ==
X-Gm-Message-State: AFq9FYLT5R48sW7Qz30SArbMedhVcTeTkrxzfb5LquHk9BWTdsbwWtBb
	+TbRhRTSoxYY/FLuYt7VSO93/Px4ijKtXQO0gYj6E8lz77jBQBTZqrKAR+V1aRJE
X-Gm-Gg: AYBFou3B9i/j8ZeKjH81NKlRxmN7pNGicZDDWmZZnEu413Qsqd1PobJ0NhB+K9jsNwC
	MllmEnbG0/LrAR6Ru91SXwinnNXkKixSzlrIeaXa2IvXpYK/mXOGNEgus4mz6exlyomtD7Ngw0k
	pJB2nm6CNZFmH8wtXbL+uoPnZ0qNNToih1s/HKH6r0dGLjGtD3PS/4ZDQ0uUTC9vOY5Pw9Hugk5
	F4wza7t/xnoJCCqY+++IGijTs7EEVAIHy5GECprAhXgvsugLVw8CrwwGwE8Ne4/kxMu6iMlOlOl
	MMseesmwQvDsiYm1R8mM1ergO4Vm5cL1UtSNymtyLu6ZwlDBhaYtUVJKN0xy2HwuD8aucXF0Ap2
	Tg3iBY95pSvzZ7cOsVSUnLoCnp4Qge2YGHfHzMnsu0B9xWj7m/m4+sGMV9L0w9Nox0AUpS7TRFK
	vQ8WR2wn/wHwDqg862HJ3XAz5RsNZ2gYCgr9mkXqLgkg6mERTGHwGCSRsReQu//i4PRBuvrmMVy
	kjyURcNtq8TMgpAXegRdO/Rhw==
X-Received: by 2002:a17:902:cf08:b0:2e2:c79e:5462 with SMTP id d9443c01a7336-2e8429a5740mr24238575ad.10.1791568792691;
        Fri, 09 Oct 2026 10:59:52 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([2a09:bac5:661c:1246::1d2:d1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e84219e74asm14167105ad.29.2026.10.09.10.59.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 10:59:51 -0700 (PDT)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Frank <Frank.Sae@motor-comm.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v3 1/3] dt-bindings: net: motorcomm: Add YT861x PHY compatible
Date: Sat, 10 Oct 2026 01:59:30 +0800
Message-ID: <20261009175936.428256-2-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261009175936.428256-1-mmyangfl@gmail.com>
References: <20261009175936.428256-1-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The YT861x GbE PHYs integrated in YT921x switches honour the
"motorcomm,auto-sleep-disabled" device property like the other
Motorcomm PHYs. Add ethernet-phy-id01e0.4281.

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 Documentation/devicetree/bindings/net/motorcomm,yt8xxx.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/net/motorcomm,yt8xxx.yaml b/Documentation/devicetree/bindings/net/motorcomm,yt8xxx.yaml
index 26688e2302ea..85d01690c856 100644
--- a/Documentation/devicetree/bindings/net/motorcomm,yt8xxx.yaml
+++ b/Documentation/devicetree/bindings/net/motorcomm,yt8xxx.yaml
@@ -15,6 +15,7 @@ allOf:
 properties:
   compatible:
     enum:
+      - ethernet-phy-id01e0.4281
       - ethernet-phy-id4f51.e91a
       - ethernet-phy-id4f51.e91b
 
-- 
2.53.0

