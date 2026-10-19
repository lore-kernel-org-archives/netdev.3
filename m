Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792440389;
	b=MCwPLW+QE+6ZIE+zhJVT0V/sWd36J9fz7MVoLlPAff7P/dkg8xeTL1DCJXrM0kSS8uiJ
	 RJ9SLcnHKUt8ZfkIfqJzhkshTWg6O90FTJ696crv1yerVYdL2ASdBjFK6iqYYzE4qTsuH
	 n9C+pd/MjocdThuNTJ/Lyb1wKciYAngEMMMILkJ+g1fuCdAr5ZmBeX5eKeIKYZslXfWzx
	 ZNLWCD8+HMRRw6G9pZ09PqoC0XeYvWImWJ768cVQWSGf6Fu2pZfjmjBnZyhfTnpuAaGy3
	 eQht1SORpLS7E+Vks6VyP3vBB6hYHOF6aAHjlmmcQsr3Uribb9HmHppdZ6ohVMW+VUw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792440389;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=LysVNfg+bUVcKwCmhO7AqSEB1P1BLdy0/b/zuf0o/VI=;
	b=K/HXp24u9A1XuBr0xq8daeWhaFz2Y1UmJ886XbOfXAb4y5zGYbyr/ejRBkZ1akSoPuuf
	 JmSZi62UC/Ih2PH78bABZtCX4Eb9ixV6+mqc0aJ7SBxLDIHdiy8xb7+J80GJrqYQX1qox
	 yVshvT5cI6I7sUbUno/chYHpMcpuvfxgARQsb7io0fs8vjUFS0FneyQDH9gl2asTUZu39
	 eB+iNEwaAiEzHkUuonu847TVtuIgp5zqEuOSJVrt0IhL6PyrixBCNKPbtAJ2T08XUVNzZ
	 aB5zgzTqKY1XlSf5urO4aEvJ3amnIn5Oy5miu8aI7zyQ0WAk6ZFraiMK+he3+J4eixw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=networkplumber.org;
	spf=pass smtp.mailfrom=networkplumber.org;
	dkim=pass header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b="Cee/hzph";
	arc=none smtp.remote-ip=209.85.215.178
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78EB0606A31A
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 20:06:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 78EB0606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=Cee/hzph
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-cd5c9e52398so884524a12.1
        for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 13:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1792440388; x=1793045188; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LysVNfg+bUVcKwCmhO7AqSEB1P1BLdy0/b/zuf0o/VI=;
        b=Cee/hzphaBy/9eW9/wlej93L6rcIhDxqhBmhzLr+AJYQG57VJBLz5HIm4lInvsmXEh
         fQF6ifaHCs+o5SbvvOL1XdiYEsopzFQIlGkeSE/JLKEUmJajc6C4nN0vFnevr8Zz/Mk+
         tE2bbvmQ3VfueXYuuAZEam5isFRn5iqx9XWGyrCWBAvvoCtKDV+V9vPKVLAB8mIZOJZX
         d4Wbh8UjKwaEdplC3ZbAUqpTeDDz4e/iPwgrareWBam3UiHfIjoOUNezyxeq00GXvCyY
         k0SaXqgO2l/3ZyzTPIrxStqiDwf/LhM+hLhAOQwjzIcDl2CS+OgrHeeeNJVWZRv2Wvs+
         bovA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792440388; x=1793045188;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=LysVNfg+bUVcKwCmhO7AqSEB1P1BLdy0/b/zuf0o/VI=;
        b=KNk/KrS47dKHR9xTy+ToA/ZZ7cKE+cgZKEVwT0Lr7rYQW56VIwctnPU8ZhiSsrNaqE
         XJ4oQsEu3SKdkDE3zBLeidE+XimGCgtUzqYGC5EBifgpgtTO/8/GGOnnlA/nRFAttlNT
         STS0HcF2bND115Agd31NvzD+S0OEV6iABfiZTRS5N6Y+VhMzxLUPhazrgCpeKajacAFE
         OIhir05/S9o92Q1kRN4ZnhlNLcTOgx/RlLbzXyECQo8HyW5XjktQZX9goYSXtJd822SN
         u4E4vdfOFt5sGWasWydv1p+ok8mNlwvk6DZkyKcc0kA8VJ33H8s57Jamd3qVaulvYLvx
         n9kQ==
X-Gm-Message-State: AFq9FYJPMJnN77H3f2fq6O4rflGQq7IWUUICzhiP+ZvKQ/5RZBspZlFu
	LpvQBZ/wJpJ/AUPDn8KXpYIBz9baBFN3HPGwGQGe1Xr9anATrn2W5Gigvx6HEe0WRZe8PAkRK3h
	zeu2clf4=
X-Gm-Gg: AYBFou3iEAziP/RN2r8PUBLSc/I1/fuzqrJtxKq7UlEH79MWFsYNpdmKrPBMDGikMfY
	hj/jN3tk0kYNrB/8Ki5hWrmARzUgzPj8hiqM+dQuBwKrBFoL97OGTyvEFtZHjLleXF7fOnx4EGl
	R11yYgeXfJM7BFH6vPejQ9T3yAv3mGI1/TlV9DV5asUEaN9k4BSctBq6DTlBl9nQO43CvWuVZyZ
	jDJjPwk8fxPilMFTAe9+gtVJ4vPBVc5wpJekrNJhD3fvIZIF5FcdYgVPerA06oOqq8JoWlTl1He
	s2phTzfT+1RBTRiY1zyJ33U085m8eJFk2vwiSZRZFdNnK9Krez+IshVzgFQmZuPos1BU4/hLrXx
	VnZ5mlaFV8FGgkPDnyWNlnrLBLZVVWpTpJb4RV+LoSKU6FGi2gq+oAnHbSouy0vSpPpQSYYx2vc
	Ewud5/33rSZ0xuNH6eTmuop8NxcXWh0XyuRNjtwdwGqsBT7v4koNmuwX0kY3RbIUsZQUGNIN+IX
	B42dMyeXkiK0cOJSkqp/SHkJRJDyhQcAhlVKIU=
X-Received: by 2002:a05:6a21:6117:b0:3d3:ae40:51e8 with SMTP id adf61e73a8af0-3e225f7dc82mr6760454637.28.1792440387694;
        Mon, 19 Oct 2026 13:06:27 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cd654850c61sm4492935a12.1.2026.10.19.13.06.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 13:06:27 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH iproute 1/3] lib: don't build printf formats out of names
Date: Mon, 19 Oct 2026 13:03:02 -0700
Message-ID: <20261019200623.816470-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261019200623.816470-1-stephen@networkplumber.org>
References: <20261019200623.816470-1-stephen@networkplumber.org>
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

print_string_name_value() and print_uint_name_value() snprintf'd the
caller's name into a 64-byte buffer and used it as the printf format, so
a '%' in the name was taken as a conversion and names over 63 bytes lost
their value to truncation. Pass the name as a string argument with a
literal format instead.

Fixes: 31ca29b2bec4 ("json_print: Introduce print_#type_name_value")
Reported-by: Anthropic OSS scanner
Assiste-By: Claude:claude-opus-5-5
Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/json_print.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/lib/json_print.c b/lib/json_print.c
index f604f265..e028e766 100644
--- a/lib/json_print.c
+++ b/lib/json_print.c
@@ -147,11 +147,8 @@ _PRINT_FUNC(float, double);
 #define _PRINT_NAME_VALUE_FUNC(type_name, type, format_char)		 \
 	void print_##type_name##_name_value(const char *name, type value)\
 	{								 \
-		SPRINT_BUF(format);					 \
-									 \
-		snprintf(format, SPRINT_BSIZE,				 \
-			 "%s %%"#format_char, name);			 \
-		print_##type_name(PRINT_ANY, name, format, value);	 \
+		print_string(PRINT_FP, NULL, "%s ", name);		 \
+		print_##type_name(PRINT_ANY, name, "%"#format_char, value); \
 	}
 _PRINT_NAME_VALUE_FUNC(uint, unsigned int, u);
 _PRINT_NAME_VALUE_FUNC(string, const char*, s);
-- 
2.53.0

