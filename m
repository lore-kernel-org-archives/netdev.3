Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5374C44C4F5
	for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 19:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784834125; cv=none; b=uE/gn6hpMlcA6+os+KiNSpzMYKWtDMy6LQbkRb6JdLUO06jhOy2/t9uVijRCYc70ZK0SrjMluJSZTQEttBH6wg/mg1d4UNDvMV52aGoyhdYW490+M+RGAzzHeYG115kMwSBdyXy5zlbUmpFGbY3jj1yAe3e6BUhyXSUAmOcux4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784834125; c=relaxed/simple;
	bh=B/cbd40IfGGwEDT/sZtoF6lLEQHkQSH6Ng1TbpSwRhI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KH8T5Uqtg03ILHGv+ouLieYHtVDS89Sskvx6iiAF3M8Uh0eHfV0MjbXrzoO4sHf1mfLQuMehYsgjXmbjupf3NRQfTukz2Lv72OJ6Vot1ms8Qwhyxiflo8DF5ti1h+0Oc0pZMgUyEqRMNB8mulnMOJwEeWLu9M+v3knXAf5njkYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b=F6EZ0261; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b="F6EZ0261"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2ceed7018c8so7966375ad.1
        for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 12:15:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1784834117; x=1785438917; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=W8OQI4G5gldyEWs9XQinID3fsttnXqgab4xX11Op400=;
        b=F6EZ0261C+ioRTg6QgxIXGiL0qZV2z1w/qU4q9MlFjxAVGGreNbktag3Kxgua54j07
         Y+wGY9ydF8qvi2iuUWPxmnO70lj0rt4/Jbj+t8aQ5yLYUsw0DuWX5GmhagW7AD+zxkjE
         8xXoPq/xcp/mGxK/Uhf9tXrDjHfpntuMoGq0B86SwC2WSI6Bi/wr3YAinCETwJVULB6G
         Iq0FjZuZukDZYyICB8TQoZD42gwijEpzwXoOYbMLymwLYnVYTE5eyNrsT/aWbdcoQzlV
         FOB/WKDurIwePwfSml5YzTn0LHRfGdhJz0BsZ1ixPk7mu7Dvh8ndASmAFNvypnTB1I8x
         hDLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784834117; x=1785438917;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=W8OQI4G5gldyEWs9XQinID3fsttnXqgab4xX11Op400=;
        b=cJIHsLEIqZp3SkIV20Px1SgzU+kQDeaDHM1OeJM9W8sm9/ifas0kogkQZWulOFvZhD
         bpsr0YdK2BBsogytrjhjOC6g6JlipZxZVgw3vvcSKZCy/UyKT43aecYUMEqko+YTePHu
         Gl3ZLtSlRh0bAmOYWRzmz/fdWrxc99lsf9awmQ3pznMnfqmuP8i57dDnqpqMtcEauJWH
         a9/nMpELWOOrFU+qoHD90gnOTKz6ypt6rQqbfln4ogpEA/0zq/0Gm+ZUDa43JYcvoeQM
         Mn9XU4SfKfBQl5gACl9gX9b3CZ3303hbblTJZOZdcCToDqjHNqRTMuwivGysPvj61TeI
         y3Kg==
X-Gm-Message-State: AOJu0Yw+7YDAceUHYEd98j36P6WhB0rQqlBv9ouucPBWc8q/Lkzv0sxr
	Pz25l4PKb/YNj67esZCvE8teoORIwXtRFSXu2v3Qcvho28Kshu6kbIGrey+SG55cYh2ijFsKqGW
	LyiCC
X-Gm-Gg: AR+sD10o3OQL/MfV35s1PsS2wzRR6C+yz5w+GtxXBnJr0PBNjhdG49k01xTZTGhmAzI
	0RfH8P8ZNXgfnREfCOkwtfDkqheu2wxcQIs+ZKB5uv1egZoz0sUJifFXfXF8jMfa1pirIeUEHSe
	P7DD4pWl8o7R6jWSVgn7w0botDctEXQTiSV41DrNsoXAENe0v8E1wvHGXkfsxOAbsML70QZpQQX
	jiUrzmgzuH7OMHzzEzVVI30k1TjhvtOllnziMfD8mNcWufMtlsxdji7S2q4mf/tXjljBS2ZjT8t
	2mlPaxApCTgsPAS/fyNxl33XqRwOrCSDUXAHfo9hfeJ7decySv7H1EfXbboSYzpXZ9urjVRy9N0
	bzQBwRach8gNmQk+/DXf2OLUGkKeWJH0CwHuNUG4Iagl3uMP7UzBs3ZtPY0fEYFHGND28RwJtJi
	pGvq1x3b6fsfcqW38ig33swGEWd8P/kV+NrKZCeD+q
X-Received: by 2002:a05:6a21:8282:b0:3c3:731d:546a with SMTP id adf61e73a8af0-3c44b1ead26mr4638857637.43.1784834116528;
        Thu, 23 Jul 2026 12:15:16 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3149198adabsm11843090eec.8.2026.07.23.12.15.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 12:15:16 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH iproute2 1/3] utils: add hexstring_alloc and print_hexstring helpers
Date: Thu, 23 Jul 2026 12:11:38 -0700
Message-ID: <20260723191511.216182-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260723191511.216182-1-stephen@networkplumber.org>
References: <20260723191511.216182-1-stephen@networkplumber.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hexstring_n2a() writes into a caller-supplied buffer and silently
truncates when it is too small: the loop stops once fewer than three
bytes remain and returns the partial string. Callers using a fixed
SPRINT_BUF therefore drop trailing bytes for keys wider than 31 bytes.

Add hexstring_alloc(), which formats into a buffer sized to the input
so the full value is always emitted, and print_hexstring(), a wrapper
that formats and prints a binary attribute in one call with no local
buffer to size. print_hexstring() covers the common
print_string(..., hexstring_n2a(...)) pattern.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 include/json_print.h |  3 +++
 include/utils.h      |  1 +
 lib/json_print.c     | 12 ++++++++++++
 lib/utils.c          | 21 +++++++++++++++++++++
 4 files changed, 37 insertions(+)

diff --git a/include/json_print.h b/include/json_print.h
index c0d6315f..6a458189 100644
--- a/include/json_print.h
+++ b/include/json_print.h
@@ -84,6 +84,9 @@ _PRINT_FUNC(float, double)
 _PRINT_FUNC(tv, const struct timeval *)
 #undef _PRINT_FUNC
 
+void print_hexstring(const char *key, const char *fmt,
+		     const __u8 *data, unsigned int len);
+
 #define _PRINT_NAME_VALUE_FUNC(type_name, type, format_char)		  \
 	void print_##type_name##_name_value(const char *name, type value) \
 
diff --git a/include/utils.h b/include/utils.h
index f0d45bad..6a8872bf 100644
--- a/include/utils.h
+++ b/include/utils.h
@@ -162,6 +162,7 @@ int get_size64(__u64 *size, const char *str);
 
 int hex2mem(const char *buf, uint8_t *mem, int count);
 char *hexstring_n2a(const __u8 *str, int len, char *buf, int blen);
+char *hexstring_alloc(const __u8 *str, unsigned int len);
 __u8 *hexstring_a2n(const char *str, __u8 *buf, int blen, unsigned int *len);
 #define ADDR64_BUF_SIZE sizeof("xxxx:xxxx:xxxx:xxxx")
 int addr64_n2a(__u64 addr, char *buff, size_t len);
diff --git a/lib/json_print.c b/lib/json_print.c
index 810d496e..21589073 100644
--- a/lib/json_print.c
+++ b/lib/json_print.c
@@ -179,6 +179,18 @@ int print_color_string(enum output_type type,
 	return ret;
 }
 
+/* Print binary data as a hex string. The buffer is sized to the input,
+ * so keys of any length are printed in full rather than truncated.
+ */
+void print_hexstring(const char *key, const char *fmt,
+		     const __u8 *data, unsigned int len)
+{
+	char *hex = hexstring_alloc(data, len);
+
+	print_string(PRINT_ANY, key, fmt, hex ? : "");
+	free(hex);
+}
+
 /*
  * value's type is bool. When using this function in FP context you can't pass
  * a value to it, you will need to use "is_json_context()" to have different
diff --git a/lib/utils.c b/lib/utils.c
index 50602e59..7a1d8b48 100644
--- a/lib/utils.c
+++ b/lib/utils.c
@@ -1186,6 +1186,27 @@ char *hexstring_n2a(const __u8 *str, int len, char *buf, int blen)
 	return buf;
 }
 
+/* Format binary as hex into a freshly allocated string; caller frees.
+ * Unlike hexstring_n2a() the result is always sized to hold the full
+ * input, so there is no silent truncation. Returns NULL on allocation
+ * failure.
+ */
+char *hexstring_alloc(const __u8 *str, unsigned int len)
+{
+	char *buf, *ptr;
+	unsigned int i;
+
+	buf = malloc(2 * len + 1);
+	if (!buf)
+		return NULL;
+
+	for (i = 0, ptr = buf; i < len; i++, ptr += 2)
+		sprintf(ptr, "%02x", str[i]);
+	*ptr = '\0';
+
+	return buf;
+}
+
 __u8 *hexstring_a2n(const char *str, __u8 *buf, int blen, unsigned int *len)
 {
 	unsigned int cnt = 0;
-- 
2.53.0

