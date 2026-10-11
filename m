Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A712834216C
	for <netdev@vger.kernel.org>; Sun, 11 Oct 2026 03:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791689352; cv=none; b=Y4aap5acXE3mbNCKz9NGetJMitfX0odDGfcU15/DbtIKcmru0XmHBqEcD84wVJbddgH0gGa6lZjiGfISYfk7mXGJu1kE2GXMuaPlWmCbk8jEQNSrfS+w3Ut1ZA3pWEinNp8n+68gNVFLlhz0PZWQaaHl6H4w1HFLHtKzIZBKVRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791689352; c=relaxed/simple;
	bh=6HfGGSg8D3mWixQMhmz+BGr6EEnCL4R6BpKLjDRS23g=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G1+eCKwD4u2EDEexbwDCVbB8e7umGkf+weynE6/JMkXN3E/Mw1ava/RNdG/2qEtUdQ+TmjKsCjVAV5Dv3aJYnIrrzY6d6bIKydLz53U6EWGTiyoiohnklGF+L8G3yfbSsu4gkIjTazRuTG7uABezTIn02nbJkqooBnqMQ/XIKAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L7dzWuUf; arc=none smtp.client-ip=74.125.82.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L7dzWuUf"
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-3535a54bed9so1178894eec.1
        for <netdev@vger.kernel.org>; Sat, 10 Oct 2026 20:29:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791689351; x=1792294151; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=YWptci4+TzqJOLv4GSiuSc1PbBXR3yAre/EuxdxFkso=;
        b=L7dzWuUfwXoeFzmJKPxOO0GSDGeBkXKETYD0oA42KEdGSAmbWpH0eQ8wnte75dAo0+
         Lqr/y7tB5MZvYgSXp25+Dlc0U+umzavDjZc6syzj0D8L7ODv1KxSuw70cFtjofERKTV8
         erkCwMNCBObkeLzVT+rtwEJnHIEYZ/Ii0xck3p8KlpNda3FEv63KpUzuBEYJCGF8C+SG
         8koMjVojvQ0Y3V4o9V4cHrfSWYT3mm1qqcuTYF6h72zRn+95U2pXmaUYXyvNMuy2Po6P
         HTv8zQSj8iDEuHFmkAwZIgN9VFWOjyhLkaugjTG3vkcVn9vmY3SAh8fjg7Ty7wkHfYPM
         /d2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791689351; x=1792294151;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=YWptci4+TzqJOLv4GSiuSc1PbBXR3yAre/EuxdxFkso=;
        b=h6CyPFGTES2HRZijrjclYEOHGmbTTf6h6u7iztLoZKvtNjO5eY5hZ9qLNe2vraDx5s
         jyCuOVMpewkC1HkJmFZsZNghl6ERdEgaRrlE542eIRP6q7zL79SSqbNFZ0F90sBh3tNp
         slF/Yp9S3NlevHRper8nE6GQ7zdbcmEvRVcbWJOFJ4fJgrniVyiPIsOXk2e9cYYMT+Yv
         0gooWSxTI/OobtT8RooDrmlQboopuPT8nMmo2/zqaIRwnmlF5XhpH6k+K28pA4Gj2kUq
         i+MmMdtY4DJOGxVImkXEc3+dnWYIAg+hUJERQUs3n+0zKZus5UMS7y5Mm4P8aW06bHuk
         n69Q==
X-Forwarded-Encrypted: i=1; AKwUvByYJI/1pxPLwZsUKzua9BCl6YRvHIcul8DL43uw5HLG7Zr7eOaCCLYPrJL8W3/5AwCW4ptIf4I=@vger.kernel.org
X-Gm-Message-State: AFq9FYJIwBfF0CnFrcMZcUDDnzupksTMM+EE1SlpxJ4j3qNWy+Bqnyoy
	g7u7a/5U443x+FA7HMXQTfg2YKlq6DmbGGhb029qZLp7bIHkjhU0SteD
X-Gm-Gg: AYBFou02CDux+b+DifwsdsbkqXyciKlgoMVtbzYvdgSCIP/KwnvFuV1mkWoBqoXYze1
	owdPVU6erj3/NpY29EP+h+zcDQ1OoeVJhMV9tWnsCycbEHGoFJgej6t6EQnPHzXUnahtG/nUiNz
	s4LX4agxa2p3264WJY8zDwzLB5IiKEiKZyu1ErQbftYA31ns/Tk5hnKol/Gl5rbzotkK2m5Tzc/
	i8gaIDbuVUxqM1ERXRfhZoPR8SuGLp0xT/zYJO6KtwYu4WtgGBvji5NZ5yWRYUHWC8z7pIWTAOu
	TFYmJLaQevCEcIiuHlMPQSlbiPo99eKZPqh5clBJUu0T1UKqjz5IF9NordUaTyTM/U4WHJp+G5x
	X+sG1ndDDFtQS7PEiWw4p2rG2PwW+F214EZCmB+5UIQQAZBzmWCEUDzuZwN2niJrPXvnAPgVSQ+
	9CFGGmzQ3wgezenLMXRgkEgi3LC1K8qNAHhkrs9hF/526lf8fZ+7FopZAW8QdiPM7esTNwvqJq+
	yVDOBzRzaSiuhvtlqgig+baUxqJxjzEX9eY3mRSlb+UvPaYZgzxWGH1dRbGVQxswrUb58GWdbwK
	x5H7J9TopRL08gfyQJ0HU24Bjw==
X-Received: by 2002:a05:693c:4098:b0:34c:b75a:ac1e with SMTP id 5a478bee46e88-3537e235ddbmr10628521eec.33.1791689350554;
        Sat, 10 Oct 2026 20:29:10 -0700 (PDT)
Received: from l ([2603:8002:ea00:6800:4112:f5be:f9b3:803f])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537cab27d5sm22393297eec.17.2026.10.10.20.29.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Oct 2026 20:29:10 -0700 (PDT)
From: Dave Seddon <dave.seddon.ca@gmail.com>
To: dave.seddon.ca@gmail.com,
	netdev@vger.kernel.org
Subject: [PATCH iproute2 1/3] iplink_bond_slave: read ad_partner_oper_port_state as u16
Date: Sat, 10 Oct 2026 20:29:04 -0700
Message-ID: <20261011032906.1398174-2-dave.seddon.ca@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261011032906.1398174-1-dave.seddon.ca@gmail.com>
References: <20261011032906.1398174-1-dave.seddon.ca@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The kernel emits IFLA_BOND_SLAVE_AD_PARTNER_OPER_PORT_STATE with
nla_put_u16() in bond_fill_slave_info(), but iproute2 reads only the
first payload byte with rta_getattr_u8().

On big-endian systems, valid LACP states have a zero high byte, so
both the numeric partner state and its decoded flags are displayed
as zero/empty. Little-endian systems display the low byte correctly
for the eight defined LACP state bits.

Restore the u16 accessor used before the string formatting change.
The actor state remains u8, matching the kernel attribute.

Fixes: 39ac2d2b802b ("iplink: bond: print lacp actor/partner oper states as strings")
Assisted-by: LLM
Signed-off-by: Dave Seddon <dave.seddon.ca@gmail.com>
---
 ip/iplink_bond_slave.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ip/iplink_bond_slave.c b/ip/iplink_bond_slave.c
index f4b28fbc..24e73575 100644
--- a/ip/iplink_bond_slave.c
+++ b/ip/iplink_bond_slave.c
@@ -145,7 +145,7 @@ static void bond_slave_print_opt(struct link_util *lu, FILE *f, struct rtattr *t
 	}
 
 	if (tb[IFLA_BOND_SLAVE_AD_PARTNER_OPER_PORT_STATE]) {
-		__u16 state = rta_getattr_u8(tb[IFLA_BOND_SLAVE_AD_PARTNER_OPER_PORT_STATE]);
+		__u16 state = rta_getattr_u16(tb[IFLA_BOND_SLAVE_AD_PARTNER_OPER_PORT_STATE]);
 
 		print_int(PRINT_ANY,
 			  "ad_partner_oper_port_state",
-- 
2.55.0

