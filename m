Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 466872DF701
	for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 01:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784769925; cv=none; b=fEXhNS2ywNPRY/gfVXgnXtiEOUbIyPfGfkNqfJ0MyBqqzqzfgG5PTNhiwDxjy/ctLrakvibhvdcZRa5ac33WIgeXBW4/+w2oTwZTm+iDysW8tHkZ4FGVvuza+Sa9lgBXv54cwlk7U+lMV62tYH7zhLU9ppnL4bcQIuH2wkDYfe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784769925; c=relaxed/simple;
	bh=mQkWGh+bAY6ofFpcSCc4nFel5eSHJDO4LAP5otj0j5I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CGMxmBMgIRT+vCYpyWzesJgS/knUAnwGPJvJXzRo40K608SHJHZ+SqihGEctIOw+Jcc4Bhgyp2mT0J2JOalj9KoCY6o2W10PuEy/+8xGZJChuXvN+Qf9tW4HftSA+tC2K3vn0aK6Hy91ul3K7SmKT4TKUO7LOqGhicnPUxTFym8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WvVVQvbS; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WvVVQvbS"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-384930ca5e2so88130a91.3
        for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 18:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784769924; x=1785374724; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NwT/srxwGAs5ReBSrQZPLgwTYylwL4B3HP62uq5svTg=;
        b=WvVVQvbSawjPWfyCtTZjYQj3M6BKJ1h7CR2wJQdNm+vIjCu04kqA4jzF/EXZd1e5iN
         Np7ZW0BLtaMMXKT5cSfNK6q5AzajSWgFiD1eFGItfLRHf+rv7xoVoKAwWbW61KAQENQD
         u4vzWVKCdC2ydwllMSzxiap6uqPDGW56gBhHMrsCTc8ppdh6ROvfV1Tg6kvsW+a4ZWWr
         dOZwgKVpXJTKkT5p81XZj4iVVfxk9/u458NMvYToWNHOeGMz1Q8wL3v0I6eSXOvC+W8K
         nraHKSjf1fSShe+W2IN7qSeUMUw94AWcJYdAT15uTvqFV2hMEvgRxCzfxheiDF0B6xhr
         r0Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784769924; x=1785374724;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NwT/srxwGAs5ReBSrQZPLgwTYylwL4B3HP62uq5svTg=;
        b=sWxZBkAf+fZJRvfxsxWXiJ3dp9vo1B/U6a9Rj8VOPjg4/PncOHWhRP6Vr0tXZnqIDJ
         qZkjSVuuRc3JQjZ36iiR2Zps2BN0AzwqnKraJ4u/HC5sFI8HEp+6n199ONMmXAmCm+/E
         pTQskHSk+fsoOJkHGRXieTeyeCkSJyUTjGeYdY+WyW+ZNL7y2SIwqvHZ0Y0OgMNwWetm
         0VRMYNHL54Dy1vgYWlpaKTQXjwp/WeUpixjKRkMfredNHtVHf/7Qiv2FX9+EBXMkXMBw
         ippYjFxkoqiI9sFxicJu9S8uoPU6HuO2I64+IXJ6lDH6EpT8V9iOepmOABmJOx1bAh4D
         Ar0g==
X-Gm-Message-State: AOJu0YxcHeu5M7kZKPloBC3wuiYIrDHnj4jqNFwVZTa6ejyKqfAqDC5u
	QLUr3n/qp7OEfHKiF0gZ1RXU+ra90Ji0aADZ1RU/UUOFSyemSaz9nTQw
X-Gm-Gg: AR+sD10wDzZsmdBoFLFCEFXviIDSS941V/4u5FATNhPtO22POjgj5mXjjy0bCoXMTA9
	C+oyBPRyCUX3D1cOjD3QUmh/k/5PaL2W4rIW4JeSeoyD+abklppHzqN8b8aKDNx5TmLn98tCchD
	toayzCxZ5vDuAyKpsAp6yWx4ksNlatSsB9uU7RMbbSaUppJoANPprcE0p2hkMBMd4bKzxZBnmTt
	jXs8PG8y1gbDKWuhQ3rm4PgP/Lgh8QVkOAr6CQJSoacyCPND1IfKmM7vF3P2YYZ9H+EnqOraHTu
	16oi7Gt+yR/T7Vbhe5AIs2i8UTaNYWh5Yjg2Eyb2i8SntB7MB7EFF5eqDOinuletzps2EoVS0Q5
	/yR9KGnV9/tTZ4Gh2ni9crCRLzMtqzEyEw3e8kDF4HdJn3mUvSIWa/M91SVvZ6g99DepM6QONRy
	wM/flpo4cSw7JTHzHF7c1XQ93lxQ==
X-Received: by 2002:a17:90b:2d46:b0:381:3b5d:30f4 with SMTP id 98e67ed59e1d1-38ec645ef7bmr991436a91.1.1784769923560;
        Wed, 22 Jul 2026 18:25:23 -0700 (PDT)
Received: from CPC-mjac-HKWGEZ.localdomain ([70.37.26.35])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38ecaac56a7sm30896a91.11.2026.07.22.18.25.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 18:25:22 -0700 (PDT)
From: Jack Ma <jack4it@gmail.com>
Date: Thu, 23 Jul 2026 01:25:07 +0000
Subject: [PATCH iproute2-next v2 1/2] uapi: add NHA_DST_PORT
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260723-b4-vxlan-fdb-port-iproute2-v2-1-9012ac01b49e@gmail.com>
References: <20260723-b4-vxlan-fdb-port-iproute2-v2-0-9012ac01b49e@gmail.com>
In-Reply-To: <20260723-b4-vxlan-fdb-port-iproute2-v2-0-9012ac01b49e@gmail.com>
To: netdev@vger.kernel.org
Cc: David Ahern <dsahern@kernel.org>, 
 Stephen Hemminger <stephen@networkplumber.org>, 
 Jakub Kicinski <kuba@kernel.org>, Jack Ma <jack4it@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784769921; l=588;
 i=jack4it@gmail.com; s=20260712; h=from:subject:message-id;
 bh=mQkWGh+bAY6ofFpcSCc4nFel5eSHJDO4LAP5otj0j5I=;
 b=en1WIcWsBA8vqK3Lr90q7Ru15WwfTyYzdiC3bz0K8eDkcapVoMd/edqJ6BoQCiCqy0H4ddKf/
 DHkzPc50gtyDBp5bNsbYyP5S8wE87vJjL/C9PyPmW1mVIMiW4MpowAN
X-Developer-Key: i=jack4it@gmail.com; a=ed25519;
 pk=x8xh2Md9yNDil0xBOA9WA/oqC3O4Eg4rdlIul4YUktU=

Rebase uapi to have support for NHA_DST_PORT.

Signed-off-by: Jack Ma <jack4it@gmail.com>
---
 include/uapi/linux/nexthop.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/uapi/linux/nexthop.h b/include/uapi/linux/nexthop.h
index afbd064..ad336f4 100644
--- a/include/uapi/linux/nexthop.h
+++ b/include/uapi/linux/nexthop.h
@@ -83,6 +83,9 @@ enum {
 	/* u32; read-only; whether any driver collects HW stats */
 	NHA_HW_STATS_USED,
 
+	/* be16; UDP destination port for an fdb nexthop (e.g. VXLAN) */
+	NHA_DST_PORT,
+
 	__NHA_MAX,
 };
 

-- 
2.43.0

