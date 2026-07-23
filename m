Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C24037F32C
	for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 15:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784822154; cv=none; b=JbWAy6Em2d4iFV5wA3YwxMJsCN+IjcIQBlfQv2NsFLwvtGa6HzoETYABCT2L96TPrcmkNyzgyAtmZkqheNsUlUHgMTxEFlLLHuoHRDUVmqQb5ni/+aVQAkxW/7QX+rtcx26++MfICxedOuJQPNaPL2rO12zUwCo4jb2kbIgK0BI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784822154; c=relaxed/simple;
	bh=SY8tYPM/nr1IJHqIxCkcvSI7a+QboJC0bygVeKDz+2g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rRgXkKszjv0W8jPRg/7leQIydJrLHinpaBOxlhArFJyBES5hPupg5ZrOhhHDJl/53vxzuiz7BC/gx4iqsa9fZ+h0QgrFfJtPQupDnMBQODnxn5wLczPvZ+hwsLmmpdM9wg359ZPlTsiFP5FzyJCeCIKDJRqr4XHjhlYYj5dDn7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F+NO3eWW; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F+NO3eWW"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4954dff6536so6822005e9.0
        for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 08:55:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784822149; x=1785426949; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=zeZ+AywV9mg1yaRsPn1N3K/jF4bEsmN09Ss25mKGkmY=;
        b=F+NO3eWWyXRZIwoK4epB9yixxvAsIjFLd9ILbDLske67jEe+clNxF/O4bSTUGdJdgu
         GRmphTKhjuKYu69Ykkvi2rVmlMWcxmnbys0GBDFQqaLj2ntA7FiAcBhXIlDsua2jTHes
         uHo7m1BjDZbDk52nl/V1/g9ZNVJBTGsTmNCIkpHLQIGZjK0DhjSig2yYkOpcKDUZflMF
         ZCsHkweJfVNQUNckPa7epIyGegw72YPEAVgG/250TJ6AsvhpIlXTyCOpYPrwZ6JvAGKr
         pPYUwlc1anyRH8yBsvLhg3NCTsDnmkaEtb5rkhqqUT8mVlJrAj16n6BYNX7KN8sEi7Xp
         7tQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784822149; x=1785426949;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zeZ+AywV9mg1yaRsPn1N3K/jF4bEsmN09Ss25mKGkmY=;
        b=rZIfVg91PjEG4Bn79aeNOaHs7UaC0Nfl52Y7vkc5LyYaAMRIG26UiWLSHycEjN16dm
         VLkvhkBLx7X1E+/REr3eiRund48eb4uix7W6oVuaI/rknSgxU5x7zJVGmyLhnjukpH9r
         6O0yvrb3ELPSOMNaMsF99B3heIcvp0g2VcM7Nx2qDXeD1YsK4EwypdOvu9A2sKGFh96C
         twGCj1D9mIx4nQRr1zTP61pVVzicZA1GmzHFWQwN7gfpxCTWI+QaUDBq3uT38o71UENs
         DCL2+VjGbze5GbtDRIDuKjbkrnBVbbEJbQ49wsL/zx2+IIo2xxc7evWAFcFOsPKca8t1
         ChxQ==
X-Forwarded-Encrypted: i=1; AHgh+Rq7rpcE2gzWASgwK2bxfjiv1KZwYAsPznoygjF94L71Nbva0V5IkGYILPSHWpHWze2GzUWdgJQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJb/F0oD201NH73MSy7b94m6gkJp9HHhPopkllQNKlTpGWDs+q
	PAHNEwqdqKMXH35xAEFTaZHwVrSH2mFkHb0zdrbkwtLm2xHspTshMcj6
X-Gm-Gg: AR+sD11jom1J5xqIWvsgCq/AnXTBrHeQ3kj8R+tWL9wxUe0O7JgR9IKKUuCcs7yHaKw
	h2WUHyLAxo7VR5uNXpfpyRuFwKaOFIed2osxkghyyRDs0txCUljtWcyXEfznBqndKoMQo4pmBdg
	VkeARAR5bxBxxAy7aLNH895UkWLlF3msBKs9o6ZPFEy8bo6XpikSHFmn4tJzhdi5ahUZYWGfE3f
	lZXyjxfsvoaWE8dQfuTgXASjneKUOHTns/zUAkE7DZRp9UnF+2t5r6LIXaa5zTLUZZDzu20YOZN
	MkKxIB7xIG50xCCOvYyLryV07Yf5tVENrSI5jLjcMyimuizn2vcOIVcsW3vfk0x3mH4xM0njRIe
	SxiukKAcOyimcuLGY+MIu2xtR+oDo6TzCfZuG2gmyjozBmdwDp7tnK6+raXVg3Op4JepULhsmh/
	fMVyxHB/38GYcN/7eAez/6Rs9/HjU=
X-Received: by 2002:a05:600c:3111:b0:495:779a:ed33 with SMTP id 5b1f17b1804b1-495779aeefcmr22201895e9.7.1784822148966;
        Thu, 23 Jul 2026 08:55:48 -0700 (PDT)
Received: from LAPTOP-AVI.taile24b5.ts.net ([2a00:a040:1b7:4f41:6d3b:a1f4:a60d:9981])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4956ab2f0a2sm105540505e9.1.2026.07.23.08.55.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 08:55:48 -0700 (PDT)
From: Avi Weiss <thnkslprpt@gmail.com>
To: linux-can@vger.kernel.org
Cc: Pavel Pisa <pisa@cmp.felk.cvut.cz>,
	Ondrej Ille <ondrej.ille@gmail.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>,
	Fedor Pchelkin <pchelkin@ispras.ru>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Avi Weiss <thnkslprpt@gmail.com>
Subject: [PATCH net] can: ctucanfd: mark error-active controller status valid
Date: Thu, 23 Jul 2026 18:55:43 +0300
Message-ID: <20260723155543.318414-1-thnkslprpt@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the CAN_STATE_ERROR_ACTIVE case, cf->data[1] is set to
CAN_ERR_CRTL_ACTIVE, but cf->can_id is not set with CAN_ERR_CRTL in
that path.

Set CAN_ERR_CRTL so consumers know the controller-status information
in cf->data[1] is valid.

Fixes: 9bd24927e3ee ("can: ctucanfd: handle skb allocation failure")
Signed-off-by: Avi Weiss <thnkslprpt@gmail.com>
---
 drivers/net/can/ctucanfd/ctucanfd_base.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/ctucanfd/ctucanfd_base.c b/drivers/net/can/ctucanfd/ctucanfd_base.c
index 0ea1ff28dfce..8f8b1c097ec6 100644
--- a/drivers/net/can/ctucanfd/ctucanfd_base.c
+++ b/drivers/net/can/ctucanfd/ctucanfd_base.c
@@ -869,7 +869,7 @@ static void ctucan_err_interrupt(struct net_device *ndev, u32 isr)
 			break;
 		case CAN_STATE_ERROR_ACTIVE:
 			if (skb) {
-				cf->can_id |= CAN_ERR_CNT;
+				cf->can_id |= CAN_ERR_CRTL | CAN_ERR_CNT;
 				cf->data[1] = CAN_ERR_CRTL_ACTIVE;
 				cf->data[6] = bec.txerr;
 				cf->data[7] = bec.rxerr;
-- 
2.43.0

