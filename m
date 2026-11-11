Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794360938;
	b=O1+165mY7fjVbU/ya6ian5BnOCB//unLAwOxbTXdVLtvEGMGkY6uf9OilWTIYNl5is3B
	 3zUHzIqAztlKoENdWkf0d+0ipo0yT3MpcO9j4DPqTjz0tD/qfzDecaVvKPcksJIdMDUEY
	 Pxhk7/dY2MeRysa2R88/fPVa2YeaXJ9TTrXWUJVmzRoS7o8sPzKwXNv7lvg4x9Ol9DDKN
	 Jejeh85qMlsxmxm8RSZF6zB2inRhtVbKwoaNZOSE/nIStEtNovrTqlUXJxpv4OAOSgnxx
	 w/aVC7kqQoXVF+8LnLEKoyKYJ8vl68Q8bHojrFAmpREt1sL9Hko+9z+E4NaNz/ILa0Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794360938;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=BrmOR0k5r7xy31gHMJ7w1Hba46gBSd2dRL8+89dR1Gg=;
	b=14rlmfnMgk6nnwKCcYNj+qlcQcXvL/9pSth6H3OETbRxn1PKfcRIBftiOAxi92qZRROg
	 d+40v8bVH7Fi0Ei9bYQAziXpGgHdQOKdu9YSp82KdpUzpdkMqj8zCfQjfk95hD6out8xY
	 BN+sbyl/bTRnItltcIFwGv2ysrsJHP6NVxXQKrTM2oeQ9zMj/qihKA5e7tkJ7jnVl9nbC
	 IevBYEBw0odwhYyS+Z0t10fUA+y1CKbEGQoQkZIJBRsVEtbo2aBWCTY1kifL9FX+Qr4U2
	 6ViNaYss7QzoTmDIA+ZfOacCpjeuwDATS5c0ljWMO4knyFYhYdDWAtoe6c8BEulnS9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gt.tech.gov.sg;
	spf=pass smtp.mailfrom=gt.tech.gov.sg;
	dkim=pass header.d=gt.tech.gov.sg header.i=@gt.tech.gov.sg header.a=rsa-sha256 header.s=google header.b=nrkZal5s;
	arc=none smtp.remote-ip=74.125.82.47
Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CBD0606A337
	for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 01:35:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0CBD0606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gt.tech.gov.sg
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gt.tech.gov.sg
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gt.tech.gov.sg header.i=@gt.tech.gov.sg header.a=rsa-sha256 header.s=google header.b=nrkZal5s
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-1438d9363fbso1582104c88.0
        for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 17:35:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gt.tech.gov.sg; s=google; t=1794360937; x=1794965737; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BrmOR0k5r7xy31gHMJ7w1Hba46gBSd2dRL8+89dR1Gg=;
        b=nrkZal5sa0m6AXQH099P8P+BdPNe+Bj+KHrznDlnWn4jqUPlQlolnUbv+FFxl9+knx
         t173qdfOVHrNjNdvXg0t3Albr5e8uCSHCe69KbQus3MT6xTBKvksWi0ATODsiwBkw7l/
         lcf1HWLSUegO/iNAKO8ftdKAMH2cNaJ6LQPJ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794360937; x=1794965737;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=BrmOR0k5r7xy31gHMJ7w1Hba46gBSd2dRL8+89dR1Gg=;
        b=aSfOnk4gO/g4Quhd2omulF1OjahsIlAbiYdcdmH/aneqnG0R2QdCQBAxhqgfpFLkqx
         3BbmwpUyMn9ikkkDrN/ILKbdd0ApcE79RAVP0gBSXpLu70ELu0Z1cKEwn0xTV2zHA2KB
         YNdnYS7s3Faxi+4opWNWHcy9r7lp5HjsN4V/CjCFZve1egTIaM4oSl6Oyu2xaNQLeqPl
         zLgBuDH3pL780rf78S9zAnNPfbDu653h1Jeaf2mdZo4tXQD+IpBXTM1NcCvk3bcmxsIB
         cuyv81Agh/Er8XjmiYrqTsBfhAhVf4DMu7a5o+DCv4h5Xz2yIGdAjSi3yrMDzZhckbF4
         qDOA==
X-Forwarded-Encrypted: i=1; AL+hErErC+1my5yFX9WZwRy3StI6Gq+8UAdpsCoEg6JDX2GpArapVtBkgQTaYJ8hXtOReh6MExAnoPU=@vger.kernel.org
X-Gm-Message-State: APuU4Z8rGwGPYe21B75Bku+wkuoam22R76DxX5FAAg6Rn5kWGW9dbyH2
	McdpwOYdkSvqm19jy0nZkffn2FIcXSlsk6IUBtgfBzeJP9ffTHffw8qk559c0qvGagk=
X-Gm-Gg: AYBFou1lS/j/76gaPoIOsLPXRdpiods4hoKfYZ5U3WcYeJP89J3UJH6wCM/fGCc1stj
	R+nQZh1mClvASl9xxaIMNyQLR0gbr7mGA7OMHMvnEbdnEWuRotfgjG5MuRTxo80iJHZgzFexf6R
	3zcXYNNlKTImqac5yZpenLCEJYoNPpgne23l3KRu2s/McI9F0+bozwtYYmj0AlmTkfE2Z43hXFA
	BWDIcKdfw6IBKl8WGVNbFRv7fFClP6x3Il5ejwpAfslqjsGlBZHUJte3792F5ExCz86D0uB4ZQh
	YZX24UYutKpo/m/nbt1si9nJTEwPN7UvM+ijsxBeNY8bIkObs4J6QjgbSbfKyCIGleVMFD+FEAT
	sdvxP6nwkTwUZJH/Aay2fMayXGAVxb/NOZ3Rpta8h0J9CNW95kdcA93MOUprBt4tbSXQUnqfw4d
	Mk6rEyDH+LqF+ENC3O4VCjV0ZDHzLswsJTXOMBGaDg5u7P3r4KWue1M9nE5lgz7oNGs8fTkn5mb
	hySLIp21+j9mur80/lyikM4tldyC9LHFbk5sNtT+DK2ihon7S3Wpr080DHv/bfWwkbqL6j0E+bj
	Vcm4LtVytAHZvxLVLSijESS0XEFbLxmilH88fueI0WMH/9rg1BGV4uzprA==
X-Received: by 2002:a05:701b:42cd:10b0:1b2:de00:9bc2 with SMTP id a92af1059eb24-1b3bef25cb9mr1698072c88.12.1794360936994;
        Tue, 10 Nov 2026 17:35:36 -0800 (PST)
Received: from LAPTOP-UUUVNN1I.localdomain ([129.126.57.197])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3b5b20c55sm9696223c88.8.2026.11.10.17.35.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 17:35:36 -0800 (PST)
From: Wei Jie Law <law.wei.jie@gt.tech.gov.sg>
To: Thangaraj Samynathan <Thangaraj.S@microchip.com>,
	UNGLinuxDriver@microchip.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Woojung Huh <woojung.huh@microchip.com>,
	netdev@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wei Jie Law <98lawweijie@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>
Subject: [PATCH net-next v5 1/2] net: usb: lan78xx: do not update statistics after a failed read
Date: Wed, 11 Nov 2026 09:34:53 +0800
Message-ID: <20261111013454.34542-2-law.wei.jie@gt.tech.gov.sg>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261111013454.34542-1-law.wei.jie@gt.tech.gov.sg>
References: <20261111013454.34542-1-law.wei.jie@gt.tech.gov.sg>
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

lan78xx_update_stats() reads the hardware counters into an on-stack
struct lan78xx_statstage. If lan78xx_read_stats() fails, only the
rollover check is skipped: the counters are still recomputed from the
uninitialized stack buffer and stored in dev->stats.curr_stat, which is
then reported to user space by ethtool -S.

Keep the previous values when the read fails.

Found by code review with LLM assistance. Tested together with the next
patch, which makes short reads fail: with an emulated device, ethtool -S
then keeps reporting the previous counters.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Wei Jie Law <law.wei.jie@gt.tech.gov.sg>
---
 drivers/net/usb/lan78xx.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
index d73002b2c21a..76c2d98b49df 100644
--- a/drivers/net/usb/lan78xx.c
+++ b/drivers/net/usb/lan78xx.c
@@ -789,11 +789,13 @@ static void lan78xx_update_stats(struct lan78xx_net *dev)
 
 	mutex_lock(&dev->stats.access_lock);
 
-	if (lan78xx_read_stats(dev, &lan78xx_stats) > 0)
+	if (lan78xx_read_stats(dev, &lan78xx_stats) > 0) {
 		lan78xx_check_stat_rollover(dev, &lan78xx_stats);
 
-	for (i = 0; i < (sizeof(lan78xx_stats) / (sizeof(u32))); i++)
-		data[i] = (u64)p[i] + ((u64)count[i] * ((u64)max[i] + 1));
+		for (i = 0; i < (sizeof(lan78xx_stats) / (sizeof(u32))); i++)
+			data[i] = (u64)p[i] +
+				  ((u64)count[i] * ((u64)max[i] + 1));
+	}
 
 	mutex_unlock(&dev->stats.access_lock);
 
-- 
2.43.0

