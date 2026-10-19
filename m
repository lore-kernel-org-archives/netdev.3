Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792440389;
	b=q+TmY/Htad6uH71H0+zGsYsVTgnHZeugzAtOixHVJo/fheuP5YWs8VdOEUg2C5bdgg+g
	 LrSYoglI3TVHKfluQrst1u5i/Oxf7nEnAsjD/fiqxSRYnejqo211EGMOGg0O5qH1FM3wZ
	 eu4BBDxhLkdynmas9QgUH8Ki6xG7G27HxUw1LK1wroMkjs5M9j85xARdsoaBZppJFHb3t
	 EdfQv4EgKZJGf1XefQVgXeFKa0STwUjdyNDodijok4tenCP18Hd5LjzokUzqoicXXiSnE
	 Cc0yu/g3SkFrA3t7a/TMzUdLfzGAu7I8v3emTqDB1sfgYJsiqTP26hxvqFz/3e4+0+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792440389;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=GKvFPIiWsPBqUlyXejunJjNEpXocLP020jmL4CYmeQI=;
	b=c5pVcP8nRHUkcdjQuhp9a6fp+pGwlHpKWSJcCyKbdl9+DRhdgCnhJbCLU9xM66CT8KJa
	 tyYoP0GxHgD5ru478IrvufHF9D30NeS/oYOsjsq2TIkl2Iegk3AjGCWRIG5plqAhBFK/x
	 UDUur0aGN63Nax4rW973AxCJnYC1uXGnNzDJMa1ReNjFIFPzt3sXUtvbKx52lZSELOG6Y
	 FEJo4ZIHSUbNA9+VmpNLLa6QlMIEXRt2XncI34amAMoZB1YxqKg2hi0h2tGjBE2Y2LxYN
	 NZjQ+2xnmzoVTdds3lkoaJ8iPS7z2nj7QHYY9an/u62NwaXgeiKqxVrLlyODbmEypVQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=networkplumber.org;
	spf=pass smtp.mailfrom=networkplumber.org;
	dkim=pass header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=lusLDZlE;
	arc=none smtp.remote-ip=209.85.215.178
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FD1C606A31E
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 20:06:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0FD1C606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=lusLDZlE
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-cc758830601so1707185a12.2
        for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 13:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1792440388; x=1793045188; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GKvFPIiWsPBqUlyXejunJjNEpXocLP020jmL4CYmeQI=;
        b=lusLDZlEjthEPNukUwOei0Qc/zMDhBp7We7Rx61T5Lun+w7iyjohx+5h/1C7ApDtr/
         ghdksf879JWyMUj0nNqNgKNA1VSLNhnBe5cS7Z4gJoz4VlzgoVsyG7nKu+8RS0hUf1w0
         QC8EDZJfQgyvgpd+MOGXxZ/Yh08P4KfuzUHx9VS0yfMgs/ceGsg6zXsWmGk1uVwstxlk
         PAE5F3c/WuG7W2oDYP/O4BLm4+TmO8uzaKYscyZ3nid5f0+u426n6kUHDmqDVDieJiCO
         JOWB6hE2N2Ts2aE/5+ivCLLy+RRmWHx5vl1BVHpSN6P6vxHQvfxug2QvGMQsqHs2l1JD
         M+Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792440388; x=1793045188;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=GKvFPIiWsPBqUlyXejunJjNEpXocLP020jmL4CYmeQI=;
        b=h3XiMo03XAuZSLEvs+C1HP23qiLOaIU9aNo1f04rbvkx/RNxWUd2KgZuN+QiDwX7rC
         0qdwBOUl2sO4j4fwa942QRYZZi8CkT7cdNtqLJBGFxTBuW4iGLQdSTUeS4/WN3FNF4wj
         EZdbyEInbHO4KXJGH1fpZ0dcx68XIoQp4dhRITdWYr3ZXn7XQ9RGJSgAonbsWP1g/c0v
         nOJjvSvAhw+ngZ4ObxNOzxOXr24I6Um83Da55MNdBG7WXe6wA3eKod1FkTnNc+gIw/hB
         g8vuxAqk+Iq2TabJ3M1Bwq5naYRL5lw5puZbJCDIePIZDc1xiRbB24Gz4M18vmZpTZ6a
         Zksg==
X-Gm-Message-State: AFq9FYK/spSRQZdKpT8AmUH/Zm5dOxGKjPgdkdF3nQDxgUWlEfa8xJ/L
	iXovWYXVF8YAhVtLtz51FWOMjozauhsrD2xEqQxCxyMh4HdpKy5lqvf8W66gz6yk3sYCfMNoXaP
	WFElHutQ=
X-Gm-Gg: AYBFou3nYCKeMlNWDUw4riYkp5lbC53GCxYXLZfs4T+LeMyWomA7cL4PJdb6RQ2Nqaj
	IusYSwzMHG963bHgwt1lmIbY1EbGLGeRhRXABn0Aupfd8fK71qxQf6H04y9cpYA+MZ7392YM0UR
	HZX029h27bHRK2De1hwJsfN98uTyX29mR0HHZYTA1CUX8cvPfQJLnKo4FDHGDpeKvAhq/Jhgyfc
	ADGEHcw8GypvE93DWRJcS+Xmb5/0HJ/5bzGXsSi+II64RljIu5V7Q3ADgelyo77pH9Q9/CFz9Ox
	UJWYA9NIcsNMc+55biqUYtH47inOm9rSpxAEsggvNIiw5yKo/oAa+bwkVkXLcPVKJ1E7HuhhHoG
	+0zvdEDAQmMkqH6BsU918mskpS3eto4R5VtK10Ka2PUx/4G5yJh6aw2eRoGQ2G+604l5JiAwp2W
	Ao+lXE2e0J+y4dnbektfuqJOfHWHEl9pdClYs6j9mFeITc4FZ5r/fEyNSLAb+OyOhubX31Md3ou
	4Ps2zrzZancxedeX+KaGKHOlCQqLIEn2if07SI=
X-Received: by 2002:a05:6a21:6b88:b0:3dd:a00a:1715 with SMTP id adf61e73a8af0-3e2263d5f61mr7548730637.48.1792440388374;
        Mon, 19 Oct 2026 13:06:28 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cd654850c61sm4492935a12.1.2026.10.19.13.06.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 13:06:28 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH iproute 2/3] rdma: don't build printf formats out of keys
Date: Mon, 19 Oct 2026 13:03:03 -0700
Message-ID: <20261019200623.816470-3-stephen@networkplumber.org>
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

print_key(), res_print_u32(), res_print_u64(), print_driver_string() and
print_ipaddr() passed the attribute key as both the json key and the
printf format, so a '%' in a kernel-supplied driver or hwcounter key was
taken as a conversion. Pass the key as a string argument with a literal
format; output is unchanged.

Fixes: 9b578bbaded6 ("rdma: use print_XXX instead of COLOR_NONE")
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 rdma/res-cmid.c |  3 ++-
 rdma/res.c      | 10 +++++-----
 rdma/utils.c    |  4 ++--
 3 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/rdma/res-cmid.c b/rdma/res-cmid.c
index 17a89cc4..956253fe 100644
--- a/rdma/res-cmid.c
+++ b/rdma/res-cmid.c
@@ -53,7 +53,8 @@ static void print_ipaddr(const char *key, char *addrstr, uint16_t port)
 	char json_name[name_size];
 
 	snprintf(json_name, name_size, "%s:%u", addrstr, port);
-	print_string(PRINT_ANY, key, key, json_name);
+	print_string(PRINT_JSON, key, NULL, json_name);
+	print_string(PRINT_FP, NULL, "%s", key);
 	print_string(PRINT_FP, NULL, " %s:", addrstr);
 	print_uint(PRINT_FP, NULL, "%u ", port);
 }
diff --git a/rdma/res.c b/rdma/res.c
index 7efced8d..185612f7 100644
--- a/rdma/res.c
+++ b/rdma/res.c
@@ -222,7 +222,7 @@ void print_key(const char *name, uint64_t val, struct nlattr *nlattr)
 {
 	if (!nlattr)
 		return;
-	print_string(PRINT_FP, NULL, name, NULL);
+	print_string(PRINT_FP, NULL, "%s", name);
 	print_hex(PRINT_ANY, name, " 0x%" PRIx64 " ", val);
 }
 
@@ -230,16 +230,16 @@ void res_print_u32(const char *name, uint32_t val, struct nlattr *nlattr)
 {
 	if (!nlattr)
 		return;
-	print_uint(PRINT_ANY, name, name, val);
-	print_uint(PRINT_FP, NULL, " %" PRIu32 " ", val);
+	print_string(PRINT_FP, NULL, "%s", name);
+	print_uint(PRINT_ANY, name, " %" PRIu32 " ", val);
 }
 
 void res_print_u64(const char *name, uint64_t val, struct nlattr *nlattr)
 {
 	if (!nlattr)
 		return;
-	print_u64(PRINT_ANY, name, name, val);
-	print_u64(PRINT_FP, NULL, " %" PRIu64 " ", val);
+	print_string(PRINT_FP, NULL, "%s", name);
+	print_u64(PRINT_ANY, name, " %" PRIu64 " ", val);
 }
 
 RES_FUNC(res_no_args,	RDMA_NLDEV_CMD_RES_GET,	NULL, true, 0);
diff --git a/rdma/utils.c b/rdma/utils.c
index 90ea1c55..f6605eef 100644
--- a/rdma/utils.c
+++ b/rdma/utils.c
@@ -795,8 +795,8 @@ void newline_indent(void)
 
 static int print_driver_string(const char *key_str, const char *val_str)
 {
-	print_string(PRINT_ANY, key_str, key_str, val_str);
-	print_string(PRINT_FP, NULL, " %s ", val_str);
+	print_string(PRINT_FP, NULL, "%s", key_str);
+	print_string(PRINT_ANY, key_str, " %s ", val_str);
 	return 0;
 }
 
-- 
2.53.0

