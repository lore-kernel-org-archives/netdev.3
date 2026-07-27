Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44515345CCE
	for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 01:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785117404; cv=none; b=cIs2/N7nBcaZMDCY7p1AmLVcDlzyw45krpMcv22brLNFxau7MDhEhUsCxCkWrQhw7PIA1gV0RydDOZs27p9pqab4ZIKL8Ls0t7SlVwRefhOZI0g9RWcesqEMNMItHg9JLUZ4D8oaUJMf7MzJNwCVsH7inIYhnYwVKShRG1gHbOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785117404; c=relaxed/simple;
	bh=vVosi6H8JXxwpeR93dI/hxM4TRpGQYRsY8RttHDMOMo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JTc24URZ2K9zkA2r+UdS/INBJ53LtgoJm2qFquRdaJzXLPb447m8ED8KSlVSAjKZyEY51jFFjl2/N83DAItzmCb+7mWuTT9i13J3HiIPDcmuwKd4aFQ8b5NJ2ZTCwUFIM8iJ0EItOYTB/ysLYf+uPN1HcuZSlLoPsR9IqtYAaJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dI6SDuRb; arc=none smtp.client-ip=209.85.222.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dI6SDuRb"
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-977310532a7so2234365241.0
        for <netdev@vger.kernel.org>; Sun, 26 Jul 2026 18:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785117402; x=1785722202; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=48ucx6vxkjyDrEtQeFE2NpJQRNvwNltlrSD1sIV8/ys=;
        b=dI6SDuRbreOqb+Qn8/sFqs6LiSaa/4pj4DeLCOiKskq/2ameQbTMjP0wV5ZpHj1Ghc
         zBeFVsNtC+2CvwPdUo++gVVVhraGm6G8hEw36bbQrASVnEDziw/pOoAnvsZ402+R5Gc9
         Qxz2nwtH6Ajy5e1PVqBykKKULF/iGwt1+NMPJMkAhw20xcLRD8pWLWiLcaUkOPt7nI/P
         5NEr7C5GioWLm5WJHXCbIcjVtlt/3XlraWCs2Su2rbPU28oPaj2Xp6vaQaxLQy3evZyy
         j3S/qf4H4G2cwFpKVtOjDs6fPQAeJ5eDCGc/ZsfT5gq5vWlmRWd3YYu7QPk8G1CVH1s1
         2dfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785117402; x=1785722202;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=48ucx6vxkjyDrEtQeFE2NpJQRNvwNltlrSD1sIV8/ys=;
        b=VgcIVLTTIujbTZcFfKQPyeGRjp/sx36PhfOtnX5k9afUIeBqeBQGRGU6MOYMJVXTdB
         ukq/+SCERjwyCCoz4vHCh8vLJ28FJrlwU0md5ugsCpItOQk6/twV/E7cQwrgiStSWDGc
         bpAYJHANKgyDBJXN+RNSdW+ZD66Maic5bKT9P7Ydw3mUyTBTVQt2hQs5VcU3BDU4rDJX
         Ss/jxUknhZEDxkzlg/Kd7jnUhTU51Eh+YIKpuHj6zAdwwQOuY2XuYK/ztN1DpcxngoRb
         3/Vqu/bW8K1Z5fyL9kBQvICFfQFybT4KKWOLvBsplPV/2JrakueuUdA+qATeqjgh+Vyo
         kvaA==
X-Forwarded-Encrypted: i=1; AHgh+RpKGK6l8HJUee5+je2W2suqnHN3ZhKuao4wDohtPdaFROa6EAUCR9NPo/r/rFdISd0BEMKh02k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9kC7lPgWjV4nZSEpwbVMLWkLPSXJQv8/iTJmgHgj/nvMtdDOE
	Kqc8Oj0eNbyJSPDEyjlkD6BYSP5gd0wlt5wQxEfroVm8fpRxnyNbGIU4
X-Gm-Gg: AR+sD13cBUNPJ/iKYAZn4p+qvaI9vL2RA3y7uTK8bDEsXXEkQws3KhvI9bOwHJ/x4K0
	acxJwApOxBibMQY2LvXmz/l093fFKYzPfVt/9OVM2UVETdUXUZcQeNx4zwiyew1L+d/r+YU1m8w
	3quHen8ePEpkmyJTZ73pujx8N9xS24tSB97OHksc/FuiWtpIMZEHIeiMQlBvER9qNYbxR6NEG+h
	wnpMk/i7gUI9iV7LScvIZkQ6osYK0Vhmtl6VmIMAOU0kauTGU6Bt5MpwPEkk/xY6yEEYsPW43+9
	ibVzPwXX4j4jgmH03ad8rybPtHRUx26lS84eLvIJqbUxVqyv7CanIvaebZsSB6LBjFnlcW8iFMs
	7OUV6womX27Ll7QUvSeeu3BRlolvMNN1UoxKwVRizYlNe5kMyxxUV7R5ZF0YNwjZUTaOGKpohoD
	IswEv1HT8/o/pb6s6FD20aTVFahGt3
X-Received: by 2002:a05:6102:6b0a:b0:738:394e:a595 with SMTP id ada2fe7eead31-7504b3a43cemr3130975137.11.1785117402195;
        Sun, 26 Jul 2026 18:56:42 -0700 (PDT)
Received: from tresc054937.tre-sc.gov.br ([187.65.210.13])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-75036705086sm4545306137.12.2026.07.26.18.56.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jul 2026 18:56:41 -0700 (PDT)
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Sun, 26 Jul 2026 22:56:09 -0300
Subject: [PATCH net v2 2/4] net: dsa: realtek: use devm_mutex_init for
 regmap lock
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260726-realtek_mutext-v2-2-5d62ba998791@gmail.com>
References: <20260726-realtek_mutext-v2-0-5d62ba998791@gmail.com>
In-Reply-To: <20260726-realtek_mutext-v2-0-5d62ba998791@gmail.com>
To: Linus Walleij <linusw@kernel.org>, 
 =?utf-8?q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>, 
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Michael Rasmussen <mir@bang-olufsen.dk>, 
 Florian Fainelli <f.fainelli@gmail.com>, 
 Mieczyslaw Nalewaj <namiltd@yahoo.com>
Cc: Luiz Angelo Daros de Luca <luizluca@gmail.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.15.2

With CONFIG_DEBUG_MUTEXES enabled, mutex_destroy() needs to be called
before the lock is discarded. Use devm_mutex_init() instead so the
cleanup is handled automatically.

Fixes: 907e772f6f6de ("net: dsa: realtek: allow subdrivers to externally lock regmap")
Reviewed-by: Mieczyslaw Nalewaj <namiltd@yahoo.com>
Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
---
 drivers/net/dsa/realtek/rtl83xx.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/dsa/realtek/rtl83xx.c b/drivers/net/dsa/realtek/rtl83xx.c
index 71124ecca92f..9402bfe4f85a 100644
--- a/drivers/net/dsa/realtek/rtl83xx.c
+++ b/drivers/net/dsa/realtek/rtl83xx.c
@@ -156,7 +156,10 @@ rtl83xx_probe(struct device *dev,
 	if (!priv)
 		return ERR_PTR(-ENOMEM);
 
-	mutex_init(&priv->map_lock);
+	ret = devm_mutex_init(dev, &priv->map_lock);
+	if (ret)
+		return ERR_PTR(ret);
+
 	mutex_init(&priv->vlan_lock);
 	mutex_init(&priv->l2_lock);
 

-- 
2.55.0

