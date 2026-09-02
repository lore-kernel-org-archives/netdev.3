Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CBBD364EB0
	for <netdev@vger.kernel.org>; Wed,  2 Sep 2026 08:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788336332; cv=none; b=FQiiC4uvnY7U0GeIzymff4uFGvdUNFh5ry92OlRhoc6k2/F6VEa93veqO0A75sr1ZPopghUPHSEvJMbHRpxP3yEl7jEWu1lszaZjsQlEVRWYIBbJXgIQsje5QSfyuQZBtrU+514eoymrKbfFHyiRRjR6VXX2D+Pr4fLCxtY93fM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788336332; c=relaxed/simple;
	bh=bz7mbGwH1ozJNrH6PB/OKP0VMbYFPj8Q83HI+01Zh1k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mZvLdX+CjGxnj9i5/lPzMtiWO7QlisUIB16Ze5zoZaeuPRtmRMCrm0ZtyN1d0dSwaUN1IHOPuPTiF9Onl+VrHg6RbUdGSBI5vCPlSnjLedvk5nHXapjeu4+YyE7/O9AkoX/4zA+txG3L1koQdHZkKzNmknl4sUYFmhl9sbTZ/80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la; spf=pass smtp.mailfrom=lex.la; dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b=VZFpN4yB; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lex.la
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b="VZFpN4yB"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-498028b3d5eso7927835e9.1
        for <netdev@vger.kernel.org>; Wed, 02 Sep 2026 01:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lex.la; s=google; t=1788336328; x=1788941128; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=3/nvq3O1f4VDKj1llpRvfWECSeeDrPmbkSrlnnczKPM=;
        b=VZFpN4yB2iXupBjl87i5Mu6LSjrFbCppHIjDYPc4y+zjwnnp3z5HdevEz4xcsA967l
         ctNtKky08LSKHWrRs2jvmUGVL3Nnkb6jgdpo85gPtR6B3N7B2FDG2OJjrdk1sU2U2bLN
         0QCJqqUozty8BIeLUZzAiJXLEshmQmXw3NQvJDHtOZcankKekHvIV8SGrWCjPoX6Se7R
         0l4CljeADHE8IAQ3YQXgKhwnSSWWwzNm3dksj8KNf24KrrP7Jbyx2kNXJIJ/g+O+xnhJ
         aBMVDjcRO5Rwnfcf+/SBgrvHNqvInGqMzWfCYxWvrJmF9co6vuJolDQyKEG39m4Bimmc
         HnEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788336328; x=1788941128;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3/nvq3O1f4VDKj1llpRvfWECSeeDrPmbkSrlnnczKPM=;
        b=hZS5Tn7iuOyb/7HVpgpkCYq0IqNFvHRHGo4F9qhDahYx3HCz5NVGgZ1iPgpdx/FnZM
         oml2FpaDBnjmxHoPhh8bEJpk0ZyxecbHRN71nSFD8RAZ/bZdljbsO/7LTBPbX9bwCTZH
         kstZogZNezQuKVzummw5Xr/OiVcrnoIsEfOPdIe5YZbzA5/niie8FE8FHHat6skM41ua
         WQwgXRFSSzV+jvAj/H4xmePeYbJLX+dQ2mnHlFL5Vloj1JoWhYFD8DoWYeYJs7J3D8nJ
         q4DZS9EHydsMOVF1qiHW1BzHKczQm3YKpZr3R9OXSq68XbB9GENfhWYHE8gJjb1+W+va
         lWLw==
X-Forwarded-Encrypted: i=1; AHgh+RrDMb2LAMXlcqrxi6h0teti/44z0SJY0qsX4ejw0QxIc6mwIzpZkDOFIADLy91i8x3ZbpBcNaY=@vger.kernel.org
X-Gm-Message-State: AFuF++kuGiUWx13sOO0tMWWb/+eFR0ndhF24dAGyRoPsLCIaH5pdiWdZ
	CxAXNve3ZMQcqZ/4W/1O/D0KU8axXwBDy4ETbuzoJc6Z2ZLcH3rUIQXVewOuvXbODTM=
X-Gm-Gg: AR+sD12JN4AWq0AJtQ0m2rzShNlvDT6Njx/uI8ycppw5/U3Cn7Q1pQa3wWYlzIDklmR
	DQnNp7oTxDDqIdIiWmSDD7UDUWmnm5V/XPCF1EHoRjTFuwuUudZ4DIeb/KbyL0xCX86Ut1BtWEF
	2HVsPBJqxVgXRBgfWotRo9ctR/ZcdSSlpDJ15uua/nvijbr/JMrzqmbED41EUFV0TWe56JdL6V4
	cXtOBfe7BshhY2zgiyfGhDF5VPGu3Fq0x497s5WU2j5q2/bbmEjX4GWHBkcej/de6ehyGBOO+Xz
	acbIN4U4ddivKdpBUHvEJ41ESfUYAtpjWJ5JeNPOlojyXPYvI1OaebITZxQgxAOit00VP5/nZlF
	OBd5KZq4jRD2fOVIoWQB5mbL19G63feMA7nxMm6TME7Cj5k7z1gxTkW6PJdhgCI1BiLzJ0IGSdv
	CQgQPKOdAgQ8ujAopI+9o88K3X8yo5tOyfQAsj7eU=
X-Received: by 2002:a05:600c:1da1:b0:499:9eb8:a1d7 with SMTP id 5b1f17b1804b1-49ce5842935mr59733985e9.9.1788336327864;
        Wed, 02 Sep 2026 01:05:27 -0700 (PDT)
Received: from remote-01 ([84.17.55.226])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49ce4761dd1sm31219815e9.0.2026.09.02.01.05.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 01:05:27 -0700 (PDT)
From: Aleksei Sviridkin <f@lex.la>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Woudstra <ericwouds@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] net: phy: air_en8811h: refuse a firmware blob that is not a multiple of 4
Date: Wed,  2 Sep 2026 08:05:25 +0000
Message-ID: <20260902080525.2211446-1-f@lex.la>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The download loop streams the blob into the MCU as 32-bit words and
reads the last word past the end of a blob whose size is not a multiple
of four. The shipped blobs happen to be aligned, so the overread never
showed; a truncated or foreign file would carry up to three bytes of
whatever follows it into the MCU. Reject it before the first write
instead.

Fixes: 71e79430117d ("net: phy: air_en8811h: Add the Airoha EN8811H PHY driver")
Assisted-by: LLM
Signed-off-by: Aleksei Sviridkin <f@lex.la>
---
 drivers/net/phy/air_en8811h.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/phy/air_en8811h.c b/drivers/net/phy/air_en8811h.c
index 0eeb7b9a4e26..34d2727e8222 100644
--- a/drivers/net/phy/air_en8811h.c
+++ b/drivers/net/phy/air_en8811h.c
@@ -312,6 +312,12 @@ static int air_write_buf(struct phy_device *phydev, u32 address,
 	int saved_page;
 	int ret = 0;
 
+	if (fw->size % 4) {
+		phydev_err(phydev, "firmware size %zu is not a multiple of 4\n",
+			   fw->size);
+		return -EINVAL;
+	}
+
 	saved_page = phy_select_page(phydev, AIR_PHY_PAGE_EXTENDED_4);
 
 	if (saved_page >= 0) {
-- 
2.53.0

