Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E65E043746B
	for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 11:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786707894; cv=none; b=LPzKQnot9gsuvnGj+RWj0ikQ6umtsYQq8/RK5ID3v+2CWuxi1oQ4yFqdXQliipL8tFZ3FGe7vRbtqxdzsWtbE+XQBlZrOVfsEQDtrp36cDot659qj5cwNmYIQWdjwk5hbER3xKJVNBVHOrNfExRaeGSOv0NCEZhwAWdWCTqJclw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786707894; c=relaxed/simple;
	bh=9Y7Psrpz7ZVGA1MqX5Ovz7nLg4icry+Wn6dT4jpWro0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ovzNLPzKWp+L5xRpXQiIENJo/15cMpBK+BSz5cRNbbWA2oriz2F0YT4bHEgIfv3Zp+5LNwCvELL4kMk/siCLgNVc1Q0bNYLpm+37gv7txEQ9gvAqMswU7Vgs4+YpUvLUuyg8D/Jc8I055WpduzWDgHSE16W5HXMrDHC2A2EVx+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yo1mUrna; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yo1mUrna"
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-6b0ab918216so514606eaf.3
        for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 04:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786707892; x=1787312692; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=kz9ix/CS/l9p6EaI99ss8zgME0LR5yKN+YEGKtDT9Kg=;
        b=Yo1mUrnaQ9tqL1jsKArQR4f2xsi3HkUzjvysoerFTciCtvcutHiRxO/tla42yYmxJu
         jfcFNjdOJTzTExnbRBICRdQ87XFu6S+6N24H4tNqm3Dw9X95wPsMkg/ku/QPRCd/7nbK
         6c5wh48WEIDYNDUceST2xYysItlzVtJo2aWYTVJMD6JyRISzHryA8q9Tjw97o1sSd5Wt
         nMoYV5rSIVnnCUYUlL2QVdPFNYNNGsGxGQ+vmpfnsSgIvYFdx9LgjVvymmLUpQzj2hcI
         ntsjRMce03oz4d3iAgM9d5I5RENaxMBhF5uwGw8ypn5Hiwd4QXYy+3RhOENtK/w6gQG3
         ifaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786707892; x=1787312692;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=kz9ix/CS/l9p6EaI99ss8zgME0LR5yKN+YEGKtDT9Kg=;
        b=EhG303hj/oT8ICh7baMqc92e5LP6QOye4HG7ss+mH+s4ZmjIqKl7XB5VMw5h9F1esi
         /rwob0Y66YdZ0KrIAWlpB1cW3icWIIVwrVaP2B+o62ao8jNRy6XlaJ8x6Wp0a0tYYeuS
         SPEzF/R8OxAvmUeAQSemGhYrPJUCgec2KodzH2wr+2AJBiu5iC2x2aN3j7gINPSkRwVu
         PnUZzLJzkJuBAdVUD9uGSg8Cl2UNTlDBOsDLnjmRmd9FfgIFVhObvX7U4DgEZqDYT91Y
         HexmKJPzEXdsJJcrW2bCfqkwcPnn/7qWL1wLbxNZZMsA5A4oclKM5C2FdwKm9KQixj1S
         Jcqw==
X-Gm-Message-State: AOJu0Yzuu6oYdx1BkEQsBe0BCPsNzyFfkVYCS1n6cKSl8E6s1nhYr93M
	FaLVn6fhCeFEraNf5CGnJkMjFNhC/krufoxhyqLxboiEBJDecr2Fof+t+Z0+GA==
X-Gm-Gg: AR+sD13aCjJcw00uamoCPCnHfzcW9vzUU0K4IKOEt55JDlROkMemPzsVEFFb1s17KAJ
	KUzZTctZz7khbch/tUFXCAk611rCCme5uwhPoEhZtYWEMVqKT55nA7Ov5XWt3tZlob2qdeTO6Jd
	ArpLE5QcFxDxFYE5aufwG4c1QG6NVlK9oXlNSEDT6QGswCCsQzqw/ba5vwWcypWSNnjs09nTmrG
	m3H1we9q7lj9LX5gKJoRF45d1jdbb+BGF/O+Bfn50246rAcx4GMXX+rdIDnd1PlfVdlbuEy45ww
	I+1J9GPxq4dmeFb+nhbMgQgSXVPzIH+sqyyDO2CAFyPZIqCuFXqotIYgQKw3epaGCzYRfimZze9
	RAqMMYpIM3dbwvsYsOyu/DVLOanTDWq68c5LDN4VoLzrQb0WiFOQLcrPaJgbrmc5B8G+k7DMYU5
	HBr7up1/kff1/Pzrz7bqX1OnjMegLUfHjU+wWHulFTuaEveT3mRcMSZT7ofw==
X-Received: by 2002:a05:6820:c3c3:10b0:6b0:ded9:6d1f with SMTP id 006d021491bc7-6b0ded96d71mr1103751eaf.11.1786707891760;
        Fri, 14 Aug 2026 04:44:51 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:43::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-45e8ff322c0sm2148455fac.17.2026.08.14.04.44.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 04:44:50 -0700 (PDT)
From: Daniel Zahka <daniel.zahka@gmail.com>
Date: Fri, 14 Aug 2026 04:44:06 -0700
Subject: [PATCH net-next] net: psp: use psp_dev_is_registered() in
 psp_assoc_free()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260814-psp-dev-is-reg-v1-1-5029e1f1eb01@gmail.com>
X-B4-Tracking: v=1; b=H4sIAIX/fmoC/x3MOwqAMBBF0a3I1A6YqCG4FbHw89RpYsiICOLeD
 ZanuPchRRIodcVDCZeoHCHDlAXN+xg2sCzZZCvrKm8ajhp5wcWinLCxNdPsatf4tvWUo5iwyv0
 Pewo4OeA+aXjfDzKhjCRqAAAA
To: Jakub Kicinski <kuba@kernel.org>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.13.0

No functional changes.

In code paths that use a psp_dev reference that wasn't obtained from
the psp_devs xarray, e.g. not via psp_device_get_and_lock(), there is
no guarantee that the psp_dev has not been unregistered. The check
here is correct, but it doesn't match other code paths that use
psp_dev_is_registered().

Commit b89769f936a8 ("net: psp: check for device unregister when
creating assoc") is an example of a fix that adds a check for this
after locking a psp_dev. if (psp_dev_is_registered(psd)) vs if
(psd->ops) makes it clear what we are really checking for.

Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>
---
 net/psp/psp_sock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/psp/psp_sock.c b/net/psp/psp_sock.c
index 07dc4cf741f3..1a2a6b7516b0 100644
--- a/net/psp/psp_sock.c
+++ b/net/psp/psp_sock.c
@@ -96,7 +96,7 @@ static void psp_assoc_free(struct work_struct *work)
 	struct psp_dev *psd = pas->psd;
 
 	mutex_lock(&psd->lock);
-	if (psd->ops)
+	if (psp_dev_is_registered(psd))
 		psp_dev_tx_key_del(psd, pas);
 	mutex_unlock(&psd->lock);
 	psp_dev_put(psd);

---
base-commit: 4f93b12cf7b25fbf8e73d222722805b049f0a6d3
change-id: 20260814-psp-dev-is-reg-21bc63648558

Best regards,
-- 
Daniel Zahka <daniel.zahka@gmail.com>

