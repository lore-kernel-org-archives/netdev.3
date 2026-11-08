Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794145508;
	b=mq7VDh7z/HNlGy6fL3i/bVXpf+y+HZ+/cwH7bShdX2gNujWU2qGspaRYhXyZop3WjLwg
	 r2962m8ZG9E5UZGnzo5tbhXExXVYoEKp/Fg83nAVRxA0SbqwpC59WoEiNSRJExF1yEWse
	 zJJKHP0D/RynADOxqh/lBYrattG6WVvlPKYLixZotE/xnXGFjfCBsxXrkYRzOxSLt8yAb
	 4YeYrlO2mynoirqgFQ+YMRd0Be5aoYKVLu5zsJBYbZ4RMh2NinPIQlrcBxZCAsguCdlsf
	 5FXojoESKKQ8upQ6afQpnXkuvDfIa3eSiIKJwxEMESwkozv9XamOU6KHsBRb589o4aQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794145508;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:From:To:Cc:References:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=Y9JGx0xp9VYGX29iTN5G+CyjHNPMVNGZ9xkDhCs814o=;
	b=sIktrac7496WMCH7rV+ZcDIS3g/Bj9/Gge22mt7iAMktmwkRoIvcB79fROZnK/mgA6aH
	 gfAoUZMayCZOu4XNny2u8nnNJ4mMveYLZJEioDvCtwL2btE1zJH9Ogzc2yJf/9tBPXeRg
	 wzflwBovweR7xRDULA6R2GdsGny23kE4IMKRSfrKg2D5D+Sg4QOcxPxhiImjrn3bEJmeB
	 /Ng0zhOMCj+1a2aWNaHgnW0HWfOECJlh1ln7laYwOzIhQuHliTLDXyTZp7T5zLMzt5G05
	 KA7TF442QYCqCQF0CtKbuaf31ixW6TW7pZ7WyliOZXdzHyPxS3AJbQYepUXSBSPa/qQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GWWq1Fyb;
	arc=none smtp.remote-ip=209.85.128.52
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81662606A31C
	for <netdev@vger.kernel.org>; Sun,  8 Nov 2026 13:45:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 81662606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GWWq1Fyb
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4a5036bbac7so320525e9.3
        for <netdev@vger.kernel.org>; Sun, 08 Nov 2026 05:45:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794145507; x=1794750307; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Y9JGx0xp9VYGX29iTN5G+CyjHNPMVNGZ9xkDhCs814o=;
        b=GWWq1FybwLJjmLvof1Fc5A6VXX2czF3H3zpQXVOCyU7f/YY3tmTOp6ZgUXa1xYDMk+
         zxIk0LB8fTJPklMa3KYukLvv1TQGVKM5tewY+oCQDDN8GMCJLwRZfJHks6mtEJBP1bzV
         Fo7hYwQm3x62oL2Aib9WyWlt0NaiMyRlwu3kZx+jwPbf5dZjlPmZ1qLtdGhwoj52WUvt
         wnJkKpbWDL+bgEqCU8CnHNyi5P1pL9WbjXoTTLtVsCFAn8YyNzcwy9AW7tI1jta4Z/HU
         7GbJqBMjzuDl4OI6KYTJn6EPT81zAfKhWNPknmN8SJ28QQYb8TV+hdVwxSDy1QNfD3jZ
         zcfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794145507; x=1794750307;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Y9JGx0xp9VYGX29iTN5G+CyjHNPMVNGZ9xkDhCs814o=;
        b=lqezaRE19p/ErvHiQ588IXDB9qW2CdStcLtQSvSq47+X1n7CkwJr88snFrdZI2Gu+r
         Kwxrl3si5S51p2IhDAE9MCaLmPtySFJkxOz+HsuyCm7BNVihM6Pkj6m4VdYKHwJe9DbE
         9tGE/2X/I01Hd2dhhhx0ak84q75zk6j4Yf7aUIM/kLuQ0cxpXB1nAmeoDqnjCEG93FAG
         bMP1dgE9T9Fiz9HXZgqgmVIzGZzeX4x3STiFCLx18wn71IIDpJuiu4aCuhk2kezQ7ZyE
         8joyF8SiNcc1W1AXnJOrIm9n0ERARnlF0aLL+xJLHNcIHcf47A52Gv3S5i/98NFYFBoK
         +EWA==
X-Gm-Message-State: APuU4Z8GNu+7vgBMZT4odXiBztfG8DaZVedG7UJ0xeKJ74BCvrtgb88F
	nQMPZgar7JeKzgB7WE264z/iUs2Wy1+frg0rkTZiy2u0xwWzKkwv9m0d0yCewA==
X-Gm-Gg: AYBFou37GKfYQ+e+m2HtQY070kx0wTcakkULBcvp0qiF3Mo+xgdtgBFSYpiTKMORAec
	n0F98b+mHX5VBDJ8gA8UD0tIdM/t/J1vrbOYTBKzgK5Ze9qIHdZL+o6mVheR11mRRz+ewXOiioq
	/i8vJ6Bl+9cCOA4lejQ3SkImgw6cQig3ZT96fkSgTOJgQE6N5gLkNKT1SyqZZk2Oi7gnSwdd7r2
	RysunuExGcZuX4wrY6XI9jKDnoR99crORVg639QPma4pajsm1v7zmIUxp+VIp9hrYH2b8TOTmn1
	chwD14rAh0HixEF4Tin5LrA97tKZG6GPLEUn4grQce2acwjY+L1fYfEGya92mzPkM/Ajhji/LPw
	V1SNehrluPRDgDhAKijVJ2geOICI2YrriYUmZrwVBX4bz0WDcz8ZBNMGCC3gVq6n3dPAQFwfkoc
	LjeBlKZhnCU6LP7S9i94jNibHGw5tC+Bk8po53zNdEzlwcxR+yvl9YDWCSXZDr+ozyX1NZQiEws
	fu3jAvaXTkkYUo5ML7L0AD24zabsQ21noq7SSfP6SJh1SPvMcHTn91hTbtuS57oE5H7GeVth2Hk
	1HhiL9WJPp8Rx1cimoIfDhnndzCSMzBX6s/dQDlnj2z8C2Qhm+ZG6Bm5e0Ma4KOzk/1DU3sF5fa
	lTzC7oUgvseIcncY5HszjXtBdg8yCMcHQr/yXYaYxLDyWV5X/tzok3ZhoI4lhF3zgWw==
X-Received: by 2002:a05:600c:c174:b0:4a3:5a42:b2a4 with SMTP id 5b1f17b1804b1-4b963c675c1mr30195885e9.12.1794145506839;
        Sun, 08 Nov 2026 05:45:06 -0800 (PST)
Received: from ?IPV6:2003:ea:8f45:7100:cde5:5d75:8598:b64f? (p200300ea8f457100cde55d758598b64f.dip0.t-ipconnect.de. [2003:ea:8f45:7100:cde5:5d75:8598:b64f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b90ee247e9sm62857665e9.6.2026.11.08.05.45.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Nov 2026 05:45:06 -0800 (PST)
Message-ID: <340683d8-83f5-415b-b54c-b2916817f860@gmail.com>
Date: Sun, 8 Nov 2026 14:45:05 +0100
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH net-next 1/2] sysfs: facilitate creating an empty directory
From: Heiner Kallweit <hkallweit1@gmail.com>
To: David Miller <davem@davemloft.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>,
 Johan Hovold <johan@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 driver-core@lists.linux.dev
References: <0a0a7987-abb2-49c8-bc16-3938233ae9c5@gmail.com>
Content-Language: en-US
In-Reply-To: <0a0a7987-abb2-49c8-bc16-3938233ae9c5@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

We have use cases where an empty sysfs directory is created.
This requires an attribute list consisting of only the sentinal entry.
It takes only to modify one check to enable creating an empty directory
with a NULL attribute list.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 fs/sysfs/group.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/sysfs/group.c b/fs/sysfs/group.c
index 4e1e4f18a16..031cb6f36b5 100644
--- a/fs/sysfs/group.c
+++ b/fs/sysfs/group.c
@@ -141,9 +141,10 @@ static int internal_create_group(struct kobject *kobj, int update,
 	if (unlikely(update && !kobj->sd))
 		return -EINVAL;
 
-	if (!grp->attrs && !grp->bin_attrs) {
-		pr_debug("sysfs: (bin_)attrs not set by subsystem for group: %s/%s, skipping\n",
-			 kobj->name, grp->name ?: "");
+	/* If name is set w/o attributes, create an empty directory */
+	if (!grp->name && !grp->attrs && !grp->bin_attrs) {
+		pr_debug("sysfs: (bin_)attrs not set by subsystem for group: %s, skipping\n",
+			 kobj->name);
 		return 0;
 	}
 
-- 
2.56.0

