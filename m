Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792440392;
	b=Sh+nVte0yp2X6zh32qaKSzdR72spJo5SSipBLhbhAE3u3+hk12fbmUcXYfr3vYNI+YGI
	 QKbn/P4WdKPbMe1JlBtw+nOHH7mJfpfiacO9nzrBL+pkPWux+icajyiTWDuQRQ27IaBv2
	 98xZ/S8pho19rbIDYE1/sCjyRFpppteX+H+8V85Fu2nnIiyuXfRAp3knAz25umNFUOmbx
	 Aokr3ucnDH0IJScukiQIS2CCUPGoMmeNb6TF2+OjD60fQx7dceg4kK8Nd/1gLGvDYflFN
	 EY6gnci1A2NJ1mRwNIfPJui21HUI86iA8JV2x0q0Df8ebS3R/h5Ktjw1EVO05TdQsXw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792440392;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=TYwt5+C9sVQEGhnNd3dOWEsZeOB/cpwbqYDBMVEcWJM=;
	b=xPYfyNJaxYiHhYsXWDBXaf33Ji6VuIfjPW5JVwMmT0lOiMkYtJRcKgTBpLyEO26Uuoqv
	 t/CrN9LKl+toWQYzXuj0RaTjHTWwmYXWCu4bGXxYV1D2FGTXhvXEjT0p469VNksnSHLFh
	 TEnZOR1ZDee6sYccPn2gVNtBWZryQRu1Z/kdZt+lg5e3hlsmotvZQ89Qso6UGeu4HqYIM
	 pie9LYFDWtXAZG9V7xo1b8p9teWg18eeJWNamVaVyj0MDdqAPfxqKrlT9GMqih4pLePR2
	 azwg+2u8BmCeRLB6QYg6hUXatI5muZ8KEMQef0a6E9BZwWh6q9PKQyC/LxGRMv3ENig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=networkplumber.org;
	spf=pass smtp.mailfrom=networkplumber.org;
	dkim=pass header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=x6bq0IV1;
	arc=none smtp.remote-ip=209.85.215.182
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDC3D606A31E
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 20:06:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BDC3D606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=x6bq0IV1
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-cd60c5da24cso1504687a12.0
        for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 13:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1792440391; x=1793045191; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TYwt5+C9sVQEGhnNd3dOWEsZeOB/cpwbqYDBMVEcWJM=;
        b=x6bq0IV1cmR5MmzbtK1HUb//7L8pJlCm3u0ogTgvAJyhPDaneA8nhAlvgUWIilfKj9
         2hdYAN0mK3vN/PRe8orvnyg9VwkiCUGRezdtC6mAx7HmrA6Cen2+qFaul98bi3MRhgz6
         NqZ2OTtDdMFaZJ+P7pjPzjvAFd6NoJ2gkUDBxEQwh/dcAb94xsWCwaKme0HHtZJvDifH
         1DSjA94CPOoPlY9VDOh+Ouz3tGCu/MgSmtBD2EBEHvTNjONkmauEHmB4L/PMo352vTLP
         fbTZQK7hbMcd+TdgSrt016LAsipiuSAEZCkg0E2A6dPY8g8upH/6ThstA2K2nm7J/Pl2
         skog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792440391; x=1793045191;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=TYwt5+C9sVQEGhnNd3dOWEsZeOB/cpwbqYDBMVEcWJM=;
        b=gEuNmVMh6IqpVhLiOZnQ8Brmo4/N2w8k/zNiJ5tX6PTMLfsE3sJ242skU1A9DvfVi4
         tNByswvn+Q4T6Rf0z2bkTJhshcgVLWr/MotClMLneVzTPSbrC0I2UtzDjsIZBhAW0QX5
         vh3mkAMXCo2vtErycUd38YgQYvyx3DjoIEJBrexp361IARqaKSWlsyfoJFq3r2wT+pbs
         zmFZPDUJsIcrpPT8j3BCN4ITE88RLj/B5xb/MElCZ/n1a7M44K0XPPxnlvMqnD2XS5rX
         hYaqDXTfPfn/ecMmCncOs0ibpOX7XqzoDAnzgM3l5Z5cXzcw+LL4Hur14LAIMbJWveyM
         VBlA==
X-Gm-Message-State: AFq9FYKZvVXKpf/Kq5r+CFuEp5cJnYMugN1OrsxNUBWu3UhdRk8LO5YW
	YmxyXC+HiSjZ5oyZ4dixBoTsyIqgEKZWRTbLxt/fczwXJklo9spqgHrAPQx4AUIoCK295Nx9gtx
	tRgQzX+0=
X-Gm-Gg: AYBFou0SoqSgKurDBtW71sU+SV6G74/LkEWKtEEFA1cRQuMA5bWidMQMjTo8/fwuBfe
	qQE7zOe0Psc+wbcnPzvSyqkKXjf9cYXtDMdUrfXmXfP3TN9EPGeUN4R+tDrFO2LLzJOFtPwy89c
	cmfCmtA+H5J6refErM21lzPu6Hlc+Vcm6cH+qnqOuAtTKTDismh84NmWCDjV/aPuBziiqDT7Ezc
	QfKmH2p5OhYPXYBTC7qGHoChcr6d2NRam7pg+YwX79siaO8gMC3q5xV81ojtJFDR19eQ1anArEK
	Ez/aqP+MOaxw+ULptXfoIdKZKLExW2zoIzRXKHJbAyGE7vm80TzxBgjVE0lNJnhQUfGOyHjWYqL
	oP/RvLz9mdipfMuhRcSCAUf6eKasVN7tIYMjwuEybnxBDjTJjSf0Elklm1bYRwg+zBR2pGrL1oc
	tsSYkPpMoIH5aqwbeTNIqjicMidL9womqzWSaMuRniOot+dBH8wia/uarl34LqIXe7fsty3uoBR
	pKh3Z3OGwVB3/BwRwBxk357eB7bDajxAyiTGg==
X-Received: by 2002:a17:90b:3d87:b0:3a4:b418:94ce with SMTP id 98e67ed59e1d1-3acee2779c0mr7505729a91.1.1792440391082;
        Mon, 19 Oct 2026 13:06:31 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cd654850c61sm4492935a12.1.2026.10.19.13.06.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 13:06:30 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH iproute 3/3] vdpa: don't build printf format out of vendor stats name
Date: Mon, 19 Oct 2026 13:03:04 -0700
Message-ID: <20261019200623.816470-4-stephen@networkplumber.org>
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

pr_out_dev_net_vstats() appended " %lu " to the driver-supplied vendor
attribute name and used it as the printf format, so a '%' in the name was
taken as a conversion, and names over MAX_KEY_LEN aborted the rest of the
dump. Pass the name as a string argument with a literal format, which
drops the length limit, and use PRIu64 since uint64_t is not unsigned
long on 32-bit.

Fixes: 6f97e9c9337b ("vdpa: Add support for reading vdpa device statistics")
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 vdpa/vdpa.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/vdpa/vdpa.c b/vdpa/vdpa.c
index e2b0a5b1..8719a636 100644
--- a/vdpa/vdpa.c
+++ b/vdpa/vdpa.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0+
 
 #include <stdio.h>
+#include <inttypes.h>
 #include <getopt.h>
 #include <errno.h>
 #include <sys/time.h>
@@ -890,10 +891,6 @@ static int cmd_dev_config(struct vdpa *vdpa, int argc, char **argv)
 	return -ENOENT;
 }
 
-#define MAX_KEY_LEN 200
-/* 5 bytes for format */
-#define MAX_FMT_LEN (MAX_KEY_LEN + 5 + 1)
-
 static void print_queue_type(struct nlattr *attr, uint16_t max_vqp, uint64_t features)
 {
 	bool is_ctrl = false;
@@ -918,7 +915,6 @@ static void pr_out_dev_net_vstats(const struct nlmsghdr *nlh)
 {
 	const char *name = NULL;
 	uint64_t features = 0;
-	char fmt[MAX_FMT_LEN];
 	uint16_t max_vqp = 0;
 	struct nlattr *attr;
 	uint64_t v64;
@@ -936,15 +932,11 @@ static void pr_out_dev_net_vstats(const struct nlmsghdr *nlh)
 			break;
 		case VDPA_ATTR_DEV_VENDOR_ATTR_NAME:
 			name = mnl_attr_get_str(attr);
-			if (strlen(name) > MAX_KEY_LEN)
-				return;
-
-			strcpy(fmt, name);
-			strcat(fmt, " %lu ");
 			break;
 		case VDPA_ATTR_DEV_VENDOR_ATTR_VALUE:
 			v64 = mnl_attr_get_u64(attr);
-			print_u64(PRINT_ANY, name, fmt, v64);
+			print_string(PRINT_FP, NULL, "%s ", name);
+			print_u64(PRINT_ANY, name, "%" PRIu64 " ", v64);
 			break;
 		}
 	}
-- 
2.53.0

