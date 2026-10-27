Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793140329;
	b=j98i3XmNLCxsrADITcwV3L8GPMQxCqCBDPoma7h3VLG6XQIb21qHS4q76/hYBnte4QPZ
	 1k9ivRqPWbkpD1x4pM/kxDl3V976UK1AUyPJYv92UKrnhjGHT1jF+xIOwIt/rs39kRTGY
	 vIOOUIeiomBGSQPXyX9XYetHPIBUo4GzkIO/gF3p3pxWGZO7BQbvHjXqlc2ZrKwJ4ufv+
	 ZqeDhU3OwuV8Op+jJHEjLLnuKCjU7JplIgVzMo/bbA7PLhkmLbngZMqHsYbp3C3l65DXI
	 3AptFb3QjnGZw6KtQFlDl9Wic5pYKEovmWs3qoiBMQ56mU/ETVc0Ifwk4T7eYNCdh1A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793140329;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=UvtJxlS4Xn9a0ucNbB5dZokM03LeBqcphUz2ZEfTajM=;
	b=b478sHndRhvMg0X9tOwj9SW/nMDPuPrxSG0tVQlrQZehH0NoeG0myWNJC/2WZLUEb2JQ
	 kOYgoCTAhf8muLd9S9h0RFnVFBVvootkbQz8NKWdJWy5CS21UYHSwFw7rEh7Jp2cVfhgW
	 fDA/DHcbR9YikPTUvhECNcSSIrHeqxNoVUnVhgg+p2k/0ZNclOVDDI78/Wrf6Dt64pDmi
	 CKB1ISerIWSYjgDc0S/GrCpqKsxp3Yb5Sljpo7HtT9s4t8P9beTQiQYxyLaSkR1PCGRJL
	 8DAzNj26KnctUzGPEW5suN74jrQ3oiiA2X58kT84jBRd+Q+9ZcpykXRBtgQpEZIgzJw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ofb4mCsX;
	arc=none smtp.remote-ip=74.125.82.171
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3906760A2624
	for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 22:32:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3906760A2624
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ofb4mCsX
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-3535a54bed9so492706eec.1
        for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 15:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793140328; x=1793745128; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UvtJxlS4Xn9a0ucNbB5dZokM03LeBqcphUz2ZEfTajM=;
        b=Ofb4mCsX9h8Dr99UoFDU974S4WLkozvmMKwd2+FYDBrVC5CiP8M+aa/0K8XAh5LWNR
         M2I+1RFjqWOLdiPYCG+2E9JunW8yQzHK45gQlW0z0TM6uWPW1m7yo5Nf6wlKfsJB7Mky
         839h0BofkZTf5be1mpTZkuNE11lPajzDCb3opAWYTe6k6zy7ni3VAyOYEPUAztfsFMWq
         w7RYiCi/8CrfjqYHEfMonQ9jZSZX72afLv8IMv4YEavA21/aRXtTnegJJovJ2lWbjWtw
         kwDNx9YbGftRvxO+shqc972M2qgayp7v3pxa9jW11+pPryuAjQomYzCrt53EYzjNTMcy
         qwRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793140328; x=1793745128;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=UvtJxlS4Xn9a0ucNbB5dZokM03LeBqcphUz2ZEfTajM=;
        b=F5ijy5rTuAhb/oSSqt6lp/ycemxuLFRunIKRTfDsu0oNbBM8SJe0oulSLqHcXmtsLp
         1d8qGHJGzEUIC2cfevNLHgqCksWZarpIl4a2+DPLtn8RxaxB/iDhnKM0xLe1vdG6Tslx
         68LldL8nSMv94ZjT15wskR+yc83UOIT6kWU+0hXbvuT2fOoXeqsthWzf4d5j4PYyK8+W
         IidjUFPEWkN3zEbEVwPAXtMLPvorrZIrBa3med+wVW3vZWd4LJJStwPtTnEP0Yi3y9mr
         RU2cOPfiIbMKa71yQlkRokMyWUjCPkyzfgItE26Rhn/2SBukbIp3Gj+Hiy32W9+UMPO/
         Y+lg==
X-Gm-Message-State: AFq9FYLkWRUjVqMwMG3bfuNRMmj4gvt/QCdb740qiISQ6/06P+WcGw9Q
	vBGEiMITfOYyFbxzWDBhmfzWvpyYWvCA+0HMJkXPUd4OXmlqQacfuO4xxmI4tks9
X-Gm-Gg: AYBFou1rO+ILS/oeud0AKg1MPV69JD1ycipvFEpAk/ly/mAZ03Xc5aNq5ak1+f6Day7
	GGl3PnKlnRjWm93NvRr3wT8j3AvvWtzWxghV/zeDjf+gMZ9Keq5FkiwW0XQH/JDII7Mv5rjSjBj
	a05d5FEpurHJUovIt2idyT499jSuu6AtaWIAmsnCyItpYAyk0E3N4bfGpmZyT1WUTjBS4Ys6MKq
	8mporVw+fsG/VOA2msWGTPx/kZtsTnghSik5+5J6aAxe4Lofbn0fhXdEnMK4ky6cQN/rseFvlxe
	pMssCrUhphLxEbeoWruj5yV2PKyPdfocf7UyCRSX355uCNuY43P6bHlTSGgrx/m6iURarkkmmqa
	VEp8SkFrGso4gvZJ7ZHLDsbnHNRAn2mog9ucZZ+j9IOba4yAgrUoZvXgB3fWUESD/ZEap0kwtNM
	zP02NZiIiYhdi8sU2NhPLtfXr7/Jkd1Oi8tw0KO6KdQIc0vJLVQ+aaU1IehVOAw9DYF2nr7FSAY
	9xWjlzBwFQOoWx9aAdcBFDUiS0LKXV+iLGnqJXn6r9NJutUXVTneiLIOijs/ct/gNyHn1L5j9BN
	MTbFUw==
X-Received: by 2002:a05:7022:b0c8:b0:183:3c2a:ae8 with SMTP id a92af1059eb24-1a6d0b6281cmr811524c88.41.1793140328023;
        Tue, 27 Oct 2026 15:32:08 -0700 (PDT)
Received: from eldorado (ip70-187-214-22.oc.oc.cox.net. [70.187.214.22])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1a6d98c93d7sm1130735c88.13.2026.10.27.15.32.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 15:32:07 -0700 (PDT)
From: Florian Fainelli <f.fainelli@gmail.com>
To: netdev@vger.kernel.org
Cc: Florian Fainelli <f.fainelli@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Jijie Shao <shaojijie@huawei.com>,
	Simon Horman <horms@kernel.org>,
	Runyu Xiao <runyu.xiao@seu.edu.cn>,
	David Yang <mmyangfl@gmail.com>,
	Herbert Valerio Riedel <hvr@gnu.org>,
	Jeff Garzik <jeff@garzik.org>,
	Danny Kukawka <danny.kukawka@bisect.de>,
	Mugunthan V N <mugunthanvnm@ti.com>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	linux-kernel@vger.kernel.org (open list),
	Manuel Lauss <manuel.lauss@gmail.com>
Subject: [PATCH net 07/11] net: au1000: fix buffer descriptor free list insertion
Date: Tue, 27 Oct 2026 15:31:36 -0700
Message-ID: <20261027223140.3774570-8-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261027223140.3774570-1-f.fainelli@gmail.com>
References: <20261027223140.3774570-1-f.fainelli@gmail.com>
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

ReleaseDB links the old head to the returned descriptor and makes the
returned descriptor the new head without updating its stale next
pointer. This loses free descriptors and can create cycles. Link the
returned descriptor to the old head instead, matching GetFreeDB and the
list initialization.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/net/ethernet/amd/au1000_eth.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/amd/au1000_eth.c b/drivers/net/ethernet/amd/au1000_eth.c
index c0e38a507f89..f8976e324f0e 100644
--- a/drivers/net/ethernet/amd/au1000_eth.c
+++ b/drivers/net/ethernet/amd/au1000_eth.c
@@ -583,9 +583,7 @@ static struct db_dest *au1000_GetFreeDB(struct au1000_private *aup)
 
 static void au1000_ReleaseDB(struct au1000_private *aup, struct db_dest *pDB)
 {
-	struct db_dest *pDBfree = aup->pDBfree;
-	if (pDBfree)
-		pDBfree->pnext = pDB;
+	pDB->pnext = aup->pDBfree;
 	aup->pDBfree = pDB;
 }
 
-- 
2.53.0

