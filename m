Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793699765;
	b=vjZwQJsHG0Jr1+hRlM8jw+AICxRFm5VKQ/NgwWRK9RSgCP8W3O+eJGhU71J8R9Z1eml1
	 Lw3pxf2Y2qbBAvi7tj2huFzV2/j3icPT6ZhYlGUijXoWDpec4yKSG8PXOGWhQP0RTS51l
	 IsOrlc1D2lxYKaNFYHTVvgUWJF5FOfF/YmXLvfmZY9s/yR3dkh+/QDOh5CcyGfdaJ04Md
	 UH5W98sPPiUDHkvnWYm6D+vAcyoANUczseuUucgP4aCEzTKY47+KjwlVfWinIk0qcoNW3
	 0WC8VvTIzXcpohBimtYBM/S5TJ3p1PkJJT1s7dW6dyhM7GiyAr7LKP6O8Vm6RsBXOxg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793699765;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Mb/1g8nYCeIwcAw01UT60I+xXfiBOSX5Y/kTWaVFrFY=;
	b=1FX0n93U9YwCSZpDx6wO7XVZaJ1XpXHRaqks7M65M00fgjdCwCEoRhFNx5dCZ6vMdTS7
	 83pkpMcQviGjXXCgjuAoUoMgNi0bXhfxHp+1Jj/UaNhhK5qQCNQBF+WUGvNBPqujNdeuG
	 zcOKbjsp0xvVrVLdImagWqCipYx//B/AhvR7UQm4YqI+S0xX5viLartdnV8ip6zP9MNA2
	 qBctgQlkRR9dqThcDxFjwjamTJcI0mejxs7M6ga/76wKwSeJn3BOP89syWijcsgTHXHX9
	 RB4y4OkyDs2aWHyf5eKAdNQyzA4yyEjhFESLeuDXXTnpBJni3FyIMSakjlc/AvgQrkg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="aSKb9a/W";
	arc=none smtp.remote-ip=209.85.215.174
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 440ED6085090
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 09:56:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 440ED6085090
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aSKb9a/W
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-cdb2dfcca94so758395a12.1
        for <netdev@vger.kernel.org>; Tue, 03 Nov 2026 01:56:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793699764; x=1794304564; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Mb/1g8nYCeIwcAw01UT60I+xXfiBOSX5Y/kTWaVFrFY=;
        b=aSKb9a/WJPBri2q8rqFRKhTx7aTwzfBsALEEC+mT6NqNF62bBHjSVGQCrsMWAgg5t3
         pQhEObgiXwcpkII+A9hoS1+Jqa4ApCyoz4F1N7VBK77DDIgaTtmFqIiYrgz+d7saa3Yf
         L2czhVqNSe2lMRPTqLwk2c4ljXBtw9TOlYCnZ2UPWOA92vv2pRrJjrlCNU0BT0uYhXVj
         kPDz1ckmmm6hNzz5MRt4zaoS+76bt14u4BXdMd5k5Dxd2pfgpySUqkogLvbs86aaXYXs
         35gFgoe656uPWwaRIXZ+76D4pVOuC0tG3CXEllCOCzhufU38ybktYNcI2zuQIKxzEEek
         o9Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793699764; x=1794304564;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Mb/1g8nYCeIwcAw01UT60I+xXfiBOSX5Y/kTWaVFrFY=;
        b=EK+Ac1QDpIbF0C5CvLW7QVUsNbSvVIw1gS2k8Fyb9j1Wi4ZwuL6Kn0ZeeCmRXomGEg
         HSN41V0L29D3Ji3IbBApqiMAFm/eJLmriKNu74DmfsaPZ8NmTwjv/sGDYtCpIJ8UhL0O
         SGBS0JWxH7yumMxcO/3sFuMbz/s8VEY3E1ojZBGUijTrsCMODKwiJ034sc+DSubKfRzd
         5aW/aVk73+m7eDStdPwjzeXl/MvqqTFlgTo488e9fk1wHoxnc6LfhHPp22sweHeQ1NBT
         ATJnmCvyBuMjPSQOPyPzIoJqR7qRJUyB6gWCX6M1acYPdWPxqrJyaD5pTW0xw+tgz00x
         ZBtg==
X-Gm-Message-State: APuU4Z+GqJAGr8tV46z2oqxeGWMwoXp2p5w/5UmNwpK1fLijVaWP5BK4
	DjpMLyNzb7s0loivCdM2scnQjuFaXpQA6MuMRGiIXk0jO63lDJ9QKLc4QBh9Ag==
X-Gm-Gg: AYBFou3TOGCtM90KXF3WIJxfrOFkb5UG6xmgACYCQoD2P3ji3KzQm+p/4qxOmyndMqY
	GLNXEjlhhi/W+0QUTOy/OskOBkRUU3FZYnVSu3Xj6bae2sO3Pwyyce9NhVpxqAOTWEDD364JUfG
	Dt0AuX0lFSbbZkTySF7/V9XGCqA5mxh92yeAsa+U7qle9mPfVnENhZfvurO2XW+Z58UrSLysVXV
	EWy4lMBv0rW3gh+UnGYNib+Z1hlIfV3i9BpnrR+dupPhXBW8lMCwBuKH9ntmn7jPe4tV8yJO8s3
	j8B1/pSZBn0LCB4Tr0ZARO/vsuitDzjsK21Bj6gZtO8QmdNQ171EPaSveYRpBMg/uSvWvNO9wsP
	Mkzj875dRb4U0eSiaSUtsm8S7I/8GUhYZ7nZPD/YRzRH4Js2uRAt/9cHcpi25Q4zxVZ8ZfZPpn1
	m3P1Q2nte9OSTENY1fVWZQqpfWvl67jOFjDbpLx2tIBxxbnyDiGoB/5yTR2EnSv5V7wLx4tn+Rr
	kkZrD0ZfpVrbwMG0Tz0HrVwc9JyAFRBL5CGAhnCSTxq5QFZSOIJrS3EPBRcdkQ8Xh+tTB5R30Ya
	8BzDAiuffjaaZOgJWqKny0pkdLyhDxMRj6ZuVtbJjmeJKIKmJ8n/
X-Received: by 2002:a17:90b:46:b0:3ac:80dc:f41d with SMTP id 98e67ed59e1d1-3ae897497f0mr9660248a91.32.1793699764521;
        Tue, 03 Nov 2026 01:56:04 -0800 (PST)
Received: from d.home.yangfl.dn42 ([2a09:bac1:7680:28::4:396])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b07c666cdcsm3488954a91.11.2026.11.03.01.56.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 01:56:04 -0800 (PST)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v2 1/3] net: dsa: motorcomm: Fix extack message on unsupported TC actions
Date: Tue,  3 Nov 2026 17:55:08 +0800
Message-ID: <20261103095514.338700-2-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261103095514.338700-1-mmyangfl@gmail.com>
References: <20261103095514.338700-1-mmyangfl@gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

No extack reasons were given to unsupported TC actions. Fix it.

Fixes: 8eb9e7520b17 ("net: dsa: yt921x: Add ACL support")
Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 drivers/net/dsa/motorcomm/tc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/dsa/motorcomm/tc.c b/drivers/net/dsa/motorcomm/tc.c
index 9dbd61e48fee..8835907366bf 100644
--- a/drivers/net/dsa/motorcomm/tc.c
+++ b/drivers/net/dsa/motorcomm/tc.c
@@ -1122,6 +1122,7 @@ yt921x_acl_rule_ext_parse_flow_action(struct yt921x_acl_rule_ext *ruleext,
 			break;
 		}
 		default:
+			reason = "Unsupported by HW";
 fallback:
 			if (cls->common.skip_sw) {
 				NL_SET_ERR_MSG_FMT_MOD(extack,
-- 
2.53.0

