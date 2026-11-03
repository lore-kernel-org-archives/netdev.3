Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793712180;
	b=mKwWcvT27+wYiEjRYJCw5sxtRA2eIie8q0gOktG32rGoXG88JB8WEhTYFH7e7c0cr+DQ
	 TFmJ+JzIhvhfn5TVQ+MiEbLddJ6wRfWLr/VKDZJcPkYFCZxcfMPflYA4iwrXPQqsFvF50
	 Yy/s7jVbCEsWdk8t5TtW0xg4D0z7j1jrU2hgsTXKq/BAOPnrgmGvMz/j66Hvw5ECoi6gl
	 9OVHuDS68kzqc7KMaEQ9tpDMNUS0BFVtR6ij0B9Uihv1kk1LrXmGzPDzIba+poUHzIcWK
	 vdS88ZLQs1qNmF/z/yG8p/P+4H0fgoebbR8b9JXSyUJpyee1m7ABo3vSh6e+fQTBMvw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793712180;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:Content-Type:
	 X-Developer-Signature:X-Developer-Key:Content-Transfer-Encoding;
	bh=T0FqMog4IcpWe1YEj5FPSU9w3uh4BL0oNm3nVQw/i0g=;
	b=On75/Agf3sXqoNt/4/M9vrdygfKpfnUaRKfqLq3dwJyX7dANSPy59xzbKud/V6i1UxHF
	 OuZTENeXiWGcjDfEWg/NmvmIrSqXzWxzCakIsF8MPAKH99rxtAgf4uRs9bcwNrwPG2juD
	 5johC/xMTTQ0DbaIKJY8KmQ448742KoKir+hQOBMXf55yQJZQg6wCQeAVqWSTLXohOlts
	 vtPre+N2YY5bNvnphkGpy7LpOwEjRq84Br3Ki+guUPg8Fznmq0zuUdPTL0PUAKmMxHO9M
	 i3zE+xTo1Ju8Z17iz8MgvWO2Sk0Brx5CozT68lOY+xBDaPhjtZflbnGSs903O9aVW6A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=baylibre.com;
	spf=pass smtp.mailfrom=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=MZKobFRF;
	arc=none smtp.remote-ip=209.85.221.47
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E699606D824
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 13:22:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1E699606D824
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=MZKobFRF
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-48df54150dfso2096714f8f.0
        for <netdev@vger.kernel.org>; Tue, 03 Nov 2026 05:22:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1793712178; x=1794316978; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=T0FqMog4IcpWe1YEj5FPSU9w3uh4BL0oNm3nVQw/i0g=;
        b=MZKobFRFf2B6nwmZ6eNhe4g2CS9IOmc0lTwHjXT1iu1WmeivllUndpmE3aR7eCJJp5
         VjGxTBcBIrVXrzNUTMpJd15+jkHywvDgHwuWcfS42Ov8IjGS5X3Jzo3+2V+ijphWzRmD
         snE/r3vaZy8lcWdmkHGOzOof8kdxjbizFG/mgdZvog2aGlDaH7JfaZ5Yvdylxj+oJDX6
         f4e+OTxlkrUlR4RVKhOl5ep+B0PQTbxtaRWmXhcK4NH/h4hkf17C74Jzsx+KLtZ8WO1Y
         UKE1GrBaYandU4Kt6xIRmGYGDoGg2nGxp+jD6f8D11gvFjUmy30dRJoa/YnAvbl6TWHF
         XDiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793712178; x=1794316978;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=T0FqMog4IcpWe1YEj5FPSU9w3uh4BL0oNm3nVQw/i0g=;
        b=QOjp7ObKxfC7p4uhy/oEe8QmCRzPQa3J7NTPcSFkDfaN9nsLWPXtM52HMZp+B1Sk3J
         KhuCTo0J+LXdIBmCW8AkqfQ8KbRQlDkR7jV+G8fElWPocwNqPeghYI+kggAaIurrmdcq
         TODJH1c1+77mAWvj0BJa8OHg2GVZyPaRfUdFMSjanr9dZ8YEDmHXP1ZGTZabW6vb3zH/
         5nJawoMVzuF7Zkx00oPECaL0qFyXjA0hs6NGCRW0+2dz3nyfGQHppbpHbSZ4hkzejhvj
         TQ4nXbCYatwNIORKYhbCVqWvHOgfbQFddtMx2dxrfzvwIRH3MmIMU8jYYW/ZGXSmVf84
         6/ew==
X-Forwarded-Encrypted: i=1; AKwUvBwhck3BDMvvg+zP0qEhaT3DIUelkTj08HnE02HZrWxFBtcmQ8tXKKo6nzryGXjqKW9cPt3RK0c=@vger.kernel.org
X-Gm-Message-State: APuU4Z8LmTXZV44wymAkZfOhUJNu30BtbwWW6rg+bUeGhIOnMpymo1gJ
	B3lYav6hIDoYVtoIjDEQoL5WS4beakPCg/AOp38ZGxtHxCE74RSU/cXEwGQ+T+adSdk=
X-Gm-Gg: AYBFou0oJWjfTENXUYcdCZAaMdonQDmgytGvM8eVFlwcqXon8j9laiaRNoeo6NVfMLZ
	by10NaPlh9rVzNWvrGr/aLd2t77jPW8h+7y2TR4h/sVT/OIEysMfcDhd/K3tYHeS1Q7Yh22dw+h
	tYtKcBu3Pn0f1ExJhwk0rtOl+pPQQ/DQwvL1o0iAwm6p7C6pWDKjP8XqoBHafjBcoTso45vcaC1
	jYHmepQoCexz3xLXOcxwbTmeIGuaz0Q//4cD0gu0MVYc4JxKaq40npzoSlAxwU275Z0Jgt5dR9X
	nqgVdYR41QwQOjXdB8RoH1VBEgDpKxCrXQWci2VO4doAiEj7iRS1MmNxs/NE/k8THzMn2TsC8lL
	IcplGsbWJbnK+i+LNhnb5pvtjbqzXr4kOsApXid3EsTesb3pCmf3qtxtEU09cXYqTzIpcb8QtyW
	wTok4MA3ZE72ePU1pGhgtdMFo1Rf8WJLEztGvcXJbUKou/9U2swsevE79D7fhpphqX5a6WDkHs5
	ZC2GP66Gg80X7z3vEoEmTgDBuHp2iyrbb26Mw3Hq14oVGa8GDcEKRffVxM9BipHAo/sNILH90Ni
	bEfyNPmtcYyzLMeerD/4tFcqLLMKcBinybCLDbBu4xRQujlu7CzMPdZnETo8Um8MJcK3jKwMMN9
	itFVh9t714n+eAAJ7y1RHgN2dTbU2crFsPcQ5
X-Received: by 2002:a05:6000:178c:b0:487:b50:101c with SMTP id ffacd0b85a97d-48e6e2bc04cmr30304403f8f.5.1793712178173;
        Tue, 03 Nov 2026 05:22:58 -0800 (PST)
Received: from localhost (p200300f65f19a9048e0e65dd41210f6d.dip0.t-ipconnect.de. [2003:f6:5f19:a904:8e0e:65dd:4121:f6d])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-48e71bae0f4sm22307781f8f.58.2026.11.03.05.22.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 05:22:57 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Arthur Kiyanovski <akiyano@amazon.com>,
	David Arinzon <darinzon@amazon.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Guangshuo Li <lgs201920130244@gmail.com>,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	Sang-Heon Jeon <ekffu200098@gmail.com>,
	Dawei Feng <dawei.feng@seu.edu.cn>,
	netdev@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] net: ena: Make ena_pci_id_tbl.h self-contained and simplify
Date: Tue,  3 Nov 2026 14:22:40 +0100
Message-ID: <20261103132240.442686-2-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2948; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=+gVsiAK1fNaTWf0SLgLEclzZ7RxZ7QMhU5Ir6dVMJ0o=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBq6eAgL7zVVP7fPFGVhsfUEA1f4G7B+oNrtVkxA PfbgruqQwOJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCaungIAAKCRCPgPtYfRL+ TulZB/4oev48ydjymW0ga7XATv51XGwH4LXerAt0rTWGhlkPYIABl+gqDyfAeJ2lfTdJvNquLHs +mJA54G8XKszvK9yGqevwoWdI4NpwXK/acTrH0mVvNb+29pCxyirGFa+j90eQH+6FnIDkGDDKEQ 0P1KFYRJ9+qTb9C4fqh3LdE80BmEZU1te7TcnEzvCcB7Io/0GQwPSq8Jvr5NydLl9Tqtv25y8hZ IzThpm7SyvhSMVzpL6WPk0NK3P2S1OGIW5YlfPT8xn8f93RPRO/Y0azHBZuzCWriF7rWoHjGhKE XO1kqCpEoI8Ab8BV18l8pja/BJCdZOaPVziWru/tzYpPH4pB
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

The header makes use of struct pci_device_id and PCI_VENDOR_ID_AMAZON.
Include the needed header for those and drop the local definition of the
latter.

While touching this file drop some cpp guards and improve the coding
style.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
Hello,

(implicit) v1 of this patch had a different subject, so maybe teh
automatisms won't find it for automatic comparison, but you can find it
at
https://lore.kernel.org/netdev/20261102110907.356621-2-u.kleine-koenig@baylibre.com
. Changes since then:

 - keep the local header and make it self-contained
 - Do the simplifictions in the header instead of the folded-in copy
 
Note that while keeping the header is fine for me in principle, I still
consider it a bit ugly to have a variable defined in a header. OK, there
is only a single user, but if there were two or more, each user would
get its own copy of that variable. 🤷

Still this patch makes my mod_deviceid.h check script happy because now
the usage of pci_device_id doesn't depend on ena_netdev.c including
<linux/device-id/pci.h> before ena_pci_id_tbl.h.

Best regards
Uwe

 .../net/ethernet/amazon/ena/ena_pci_id_tbl.h  | 31 +++++--------------
 1 file changed, 8 insertions(+), 23 deletions(-)

diff --git a/drivers/net/ethernet/amazon/ena/ena_pci_id_tbl.h b/drivers/net/ethernet/amazon/ena/ena_pci_id_tbl.h
index 3ecdf29160ca..72605991528c 100644
--- a/drivers/net/ethernet/amazon/ena/ena_pci_id_tbl.h
+++ b/drivers/net/ethernet/amazon/ena/ena_pci_id_tbl.h
@@ -6,39 +6,24 @@
 #ifndef ENA_PCI_ID_TBL_H_
 #define ENA_PCI_ID_TBL_H_
 
-#ifndef PCI_VENDOR_ID_AMAZON
-#define PCI_VENDOR_ID_AMAZON 0x1d0f
-#endif
+#include <linux/device-id/pci.h>
+#include <linux/pci_ids.h>
 
-#ifndef PCI_DEV_ID_ENA_PF
 #define PCI_DEV_ID_ENA_PF	0x0ec2
-#endif
-
-#ifndef PCI_DEV_ID_ENA_LLQ_PF
 #define PCI_DEV_ID_ENA_LLQ_PF	0x1ec2
-#endif
-
-#ifndef PCI_DEV_ID_ENA_VF
 #define PCI_DEV_ID_ENA_VF	0xec20
-#endif
-
-#ifndef PCI_DEV_ID_ENA_LLQ_VF
 #define PCI_DEV_ID_ENA_LLQ_VF	0xec21
-#endif
-
-#ifndef PCI_DEV_ID_ENA_RESRV0
 #define PCI_DEV_ID_ENA_RESRV0	0x0051
-#endif
 
 #define ENA_PCI_ID_TABLE_ENTRY(devid) \
-	{PCI_DEVICE(PCI_VENDOR_ID_AMAZON, devid)},
+	{ PCI_DEVICE(PCI_VENDOR_ID_AMAZON, devid) }
 
 static const struct pci_device_id ena_pci_tbl[] = {
-	ENA_PCI_ID_TABLE_ENTRY(PCI_DEV_ID_ENA_RESRV0)
-	ENA_PCI_ID_TABLE_ENTRY(PCI_DEV_ID_ENA_PF)
-	ENA_PCI_ID_TABLE_ENTRY(PCI_DEV_ID_ENA_LLQ_PF)
-	ENA_PCI_ID_TABLE_ENTRY(PCI_DEV_ID_ENA_VF)
-	ENA_PCI_ID_TABLE_ENTRY(PCI_DEV_ID_ENA_LLQ_VF)
+	ENA_PCI_ID_TABLE_ENTRY(PCI_DEV_ID_ENA_RESRV0),
+	ENA_PCI_ID_TABLE_ENTRY(PCI_DEV_ID_ENA_PF),
+	ENA_PCI_ID_TABLE_ENTRY(PCI_DEV_ID_ENA_LLQ_PF),
+	ENA_PCI_ID_TABLE_ENTRY(PCI_DEV_ID_ENA_VF),
+	ENA_PCI_ID_TABLE_ENTRY(PCI_DEV_ID_ENA_LLQ_VF),
 	{ }
 };
 

base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
-- 
2.56.0.rc1

