Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794145568;
	b=q4hHrrHG/daKQOc+UYBwFM6HI/nYy1h6iGYXLwMsLJsAbq6U5iir4bRt/b7aGu1ZLbkR
	 YUIlCNGbvE8vKT20cPGEfC2LisV3OM/MaSOJ+HAexvnCefhoJV0C4Fts+Ea6clBorVy+d
	 EHSFvqFwm+2rrgCnSYL8FO23L2Ym/491lbeZKeTnaXK8rwiklgus8LPN6Tl7s4SW0no5p
	 P95BsPTXpmgKKOAfaynmJFJTmHqsa9MzRlRz8JEnqvQJzRIOEJYBbs0LhNPZ9cTpHeGKB
	 aYO915kHwfNelvBWm3pwVJDXiT8c52SsO2/DFpGASsbh+kiUbFFxPq9x6k88DYubHeQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794145568;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:From:To:Cc:References:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=hcBwG9BESwzJJrAjrRG2UH1edFRUWU1jC36ybyR6a84=;
	b=TyDL4PL/whM8q6cL0vBEQzTc3hyOe+b1iTMKVAwsE2tKDTEECqVlP0oYwlVvwosh0NM6
	 MGKoA3N4lXYz+dmhjslIwWnxblvFjDdwKP06Aavag8BirHrKsQq/Y5FD238JKOcbLViGp
	 cX4wGvCS1TygszGYi4QG6OUoeXM9KipqmHXx0w1gBm3yHSjWVQfxkBJRae8ZRxl1ukijc
	 FKanhdw5efWC9X0V1CIbk8Hr3bjHhRg8p+IzyBa99ZzCa+v0FWJbkp3KqDrQxmhgN1m4/
	 jKRbdjNh/yuCTG8iXMyj2lpl72ywxFLGBkhDkNUemv+kY9vZcFW9tNjXpcAw/yNkiMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="I/2IMzmw";
	arc=none smtp.remote-ip=209.85.128.45
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED6BE606A320
	for <netdev@vger.kernel.org>; Sun,  8 Nov 2026 13:46:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ED6BE606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=I/2IMzmw
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4b79502c27aso503605e9.1
        for <netdev@vger.kernel.org>; Sun, 08 Nov 2026 05:46:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794145566; x=1794750366; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=hcBwG9BESwzJJrAjrRG2UH1edFRUWU1jC36ybyR6a84=;
        b=I/2IMzmwt4DPJwa/TyIiY7ua0RmLbdo7kZi2rIoC28iuwou3y9rWE132Rtfov1qeNg
         N8NjJ3BKwFa2R+2oQ7yt23ZykgHEQolI2gvfCYY4Tv+C1H1a3VXM00cYgyu9RRx7dfsQ
         yKJrh1q1F0VDCcBGUVWtQ7DnRyYqIwJb+40q8EqUh2QPIkgXCT/KLCGOxxc92K1ogWUl
         r3PcCB0npOD5T9neyCsxmpHmBl/kDmKkm0M/L18bDH77swnnzUVx73WQN6qT65E6pyiY
         RLiNKfc37nfpQcTLSNzRUavzoA62W5swAKDd1s4tYqS5BW622vGIbPWMnGIF11VPpNNs
         3NTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794145566; x=1794750366;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hcBwG9BESwzJJrAjrRG2UH1edFRUWU1jC36ybyR6a84=;
        b=Zo7FicIom6d0cV5WzXTvbde0GGIBxu5bc8rn0XP0tpNwhDTC/fefk8nfLSCx2jgEVE
         KPgB1V3kX3F9FzENsgsDPEML9qvq9+9teS6+rN+VEeLp5YV8yIE/D7u/5fZs3SpMRNEG
         nf25318WumyvNphUvWmuOsWqQa6RvyXn98m3QPO/7b+wqwDZTTYW8g7mix/zi8Eimw2n
         HQePQlpBpeOhY+98CqagnoXUmmlbNjmjx0P6fDD3egcVA6y9L4yAkw8YEhY1gL+IgzAI
         gmpgZmcqsjoAtG3icc1CxtGvay02AYRx8PzBw5r0HgJLa/8+Th2SIOjrArCE0FWVbA5G
         i0QQ==
X-Gm-Message-State: APuU4Z8vB7V7gdeThLdwPBM48JtfeptuX9Y8bszV+cMAsm8Fu38rUjUL
	EIrW47lKjgjVO3V+/v/rLHbSQ2LvarDjKYuPZjFBpdfQPLT1PHMlHiv2
X-Gm-Gg: AYBFou2LIuh0W8nV7oa7R1wz5vqOlG0lrIxyqRKM5m6ImztJaW8sFafJxlXjjKMUrDU
	3FFbZlKSQeOysLMIgthZKtKoHfwucJdIU0Z/EBrk7HfD2HV40kmalYvRSyG05UXf723xbLKllDo
	cNwQ6zyujsUW8TdDrYJA8eCQfWxyLMrrkhQVI7RkmePCrWwfHiCdLHaQCtlF5g6oz0MGH8RZpCQ
	jY20zQ0jT9n+KQem171T858o4uSThHmtLLNhIaHdZobvNbze4d7ixnPRE6nUnV372ep+cADGHaL
	4fLk6jRk2gZM054Vup5ZfnBns/wYLdcVoeBN+GsoP+QVtoMHgxhuHemlWFV7s+autBI0YsXVxaW
	/2s2WotGmSnYXzY4HK/KxROrIsH9+PejsE/dTal3KztXUaSzV0GX4j06Cja1fFy5SO1MTrKTmKM
	JqVo5pRgXUDFs3Nj3Xn854+xHxmSwrfMGpfV0vVg9GWeOXK7d31xdF5iboCetW6Y0tnsbYDKds+
	raY0pqSCQ+PEf/zNWFTJxHwdwt55F7kXHq1EVbGa5I9K1E+oiPTnV0l1UBV0hPfnr4afaulhFf0
	YT1R6PAKyjxCDv3MfzwxwDBfg1lUe7UvaLvya0AfLPFaCz+JZ7tophIf169HWagvYqOG057Mx7k
	lDgu+Fq5N1uSa6IVZ5GauzETcXHK/l0BGsydLfzrO0SWkeOhBxPGolg2OZYuAN2wHGw==
X-Received: by 2002:a05:600c:6216:b0:4a1:fa27:df7c with SMTP id 5b1f17b1804b1-4b963c88223mr28399905e9.34.1794145565592;
        Sun, 08 Nov 2026 05:46:05 -0800 (PST)
Received: from ?IPV6:2003:ea:8f45:7100:cde5:5d75:8598:b64f? (p200300ea8f457100cde55d758598b64f.dip0.t-ipconnect.de. [2003:ea:8f45:7100:cde5:5d75:8598:b64f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4959783f1d6sm4112312f8f.46.2026.11.08.05.46.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Nov 2026 05:46:04 -0800 (PST)
Message-ID: <675f4353-125e-4168-a617-c0d1fb519045@gmail.com>
Date: Sun, 8 Nov 2026 14:46:03 +0100
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
Subject: [PATCH net-next 2/2] net sysfs: simplify creating empty wireless
 directory
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

Now that an empty directory can be created with attrs being NULL,
make use of this new functionality and remove the dummy attribute list.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 net/core/net-sysfs.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/net/core/net-sysfs.c b/net/core/net-sysfs.c
index 5c0402389c6..f58b59e1126 100644
--- a/net/core/net-sysfs.c
+++ b/net/core/net-sysfs.c
@@ -910,13 +910,8 @@ static const struct attribute_group netstat_group = {
 	.attrs  = netstat_attrs,
 };
 
-static struct attribute *wireless_attrs[] = {
-	NULL
-};
-
 static const struct attribute_group wireless_group = {
 	.name = "wireless",
-	.attrs = wireless_attrs,
 };
 
 static bool wireless_group_needed(struct net_device *ndev)
-- 
2.56.0

