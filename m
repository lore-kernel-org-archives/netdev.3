Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E6533E92B5
	for <netdev@vger.kernel.org>; Wed,  5 Aug 2026 20:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785962603; cv=none; b=MZZt608jHJymVKNf0hJYrE2MjV5keXcWzA11SMka4yHgMzgR+k/yvIImiKL+Rq8jcU7PgrY6UHBjudmUmLjbSAxRtR+xyz71avOx+NxlUmWm3IXg/J6DCbd2I/alAegTXGMYA6YfoAvpXU6yDzNom3Y/4KHvy4XSPkgY07I02/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785962603; c=relaxed/simple;
	bh=tz3MX6RgSvTY4qZxc5WPPga+j7i90nNZ8gjHJTr0Cok=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IsQujg6O2pkTncZBDo0fA1ouUx8cbO1/5um98NBRjlam2Xh/vvng/3Uo4vk2omIx0o8j0lY0yY6DIbrcHLvlRKSzX3+xTSx13NeHFL6Cj0poKs9s5q771/PAfQ5Uvo5qo0tHBHXAZEkA0DuZ8BdWrPK49yJtn/lKaghDW5Z6IKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VLvaM2fv; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VLvaM2fv"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-38dd55ad76cso338320a91.1
        for <netdev@vger.kernel.org>; Wed, 05 Aug 2026 13:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785962588; x=1786567388; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oQn73DnaYnP2eIm20VaPqmI6rB049cGwP1GfXwnXLN0=;
        b=VLvaM2fvt1STa/XnK8eg0ZwvQAR5Bg+KgvpPlwPAXtMcGJ+yA/Inusv4hTUzynhj6d
         9AmzjR3H7EXun4m3pA9XyQh3jfgP5MJgebzilAz5YcBy88MVZp7qmMVJ4rI6dCpxGI1+
         flW+sWcpYRxWDRXCSXtLmzY3XgeM3th6K3IRCmkIliS5QihFy8u+Ffm6OuaGXE1FA0HT
         jjcfWYUS/kdxHNZ4FLPLcJsAyP+GB/rOs6usynQCjaKBzMhloqf4gM0WBsU398TjSd63
         HlcW4mm8OyZZNgCgarHvXVOUpV3+hiWFUqQxjvEpA3p8IBjyExO9DuExjMGtnpNkXzxM
         9Fhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785962588; x=1786567388;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oQn73DnaYnP2eIm20VaPqmI6rB049cGwP1GfXwnXLN0=;
        b=AhduUKSH3TJlI7AQeAB9L2MiaImXkPVsjPLzXQOd4LsOZCI/GaQQ2s3j6SY70SdTdP
         w2xgzOS0RbWczQUqjEkR1T4zrnSVLC79mX26E9I+xv5cP9A66SNZ+BUaAFXCwZtEt4MM
         +/8uWM4Z+gT+g19q/kbrhn7rmsORbr6X9XY3aqcS4wPrTLgvISzSPD4mNsVXMK63XEZm
         dwuOsYeDyF10VQ7Y6ASTVPV9RMFx9z9OXPfT0LYzu5h4WQQR85TFHDeHR/7VPPMxeVzW
         Plwzx9SJT7ob8gw9WN1oNuGELEtyGe+mIq8XFRXDLLnvFbNFRGhpQ8vYz8TFEFknF1Ea
         pWlw==
X-Gm-Message-State: AOJu0Yz9vgyDhl6s5IoRdBfvsGuWtjVqOJcxonsy2ikdyzoBy3ZWoeGK
	BUXAAxcuyGSCgG7NZwWaJUfG+PUHKwZ8H1jcG306Dby7eOvE+V05p8cz
X-Gm-Gg: AR+sD12qNawfDutLKa7NXErmz/6Y7AJEuhAiI5eo/9O52P73q22wW72nIjiJjBkCqJh
	AFc489tQx6hLOD+ZXOCnwCWBf4/obS8sxV1gBpR54QBI41flgeYX6MG4pabhyLp7JTmT54smHt+
	17XpH7dQ5W+4IYzEPRsIXpa4A7Qh8aG2EI79JTbHU9h6Tp302ek0SzFLFDvcQ0XWvtrucaU3sr5
	wmc29Q8EOKGnyitays6Lt/7Vpk91H72q89vl6ez1Mleso5nv8dyoG6SQLnuJ1iVO22Tl7BSM/II
	53MhJPRjXjFfJitYnJDdIMyNSEqtOVIBdztMTXIgUGS5tJ+szLiEwANZ/KI8RDzy9yzegVF5SMF
	f9paY48NiwkAj/RoorMrwgyGpg7XmdoyxfzrTkRPKnfOt86GS/bFbJLIepA9w0hYGxFM3iBZrQn
	YZaw8OeH0Qs0cFotVdDplAWbDbmyU/FGdjvqN0U7dWKeUm8pJ7587ibRVGK2qqT1cUxmPEeuZ/Z
	W99hA==
X-Received: by 2002:a17:90b:2e52:b0:38e:c232:9d2c with SMTP id 98e67ed59e1d1-390839951bamr925253a91.2.1785962588343;
        Wed, 05 Aug 2026 13:43:08 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:8::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39085dbf82csm162821a91.1.2026.08.05.13.43.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 13:43:07 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Wed, 05 Aug 2026 13:42:44 -0700
Subject: [PATCH net-next v8 2/3] selftests/net: ncdevmem: add -b option to
 set rx-page-size on bind
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260805-tcpdm-large-niovs-v8-2-3e0225e2808c@meta.com>
References: <20260805-tcpdm-large-niovs-v8-0-3e0225e2808c@meta.com>
In-Reply-To: <20260805-tcpdm-large-niovs-v8-0-3e0225e2808c@meta.com>
To: Donald Hunter <donald.hunter@gmail.com>, 
 Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 Gerd Hoffmann <kraxel@redhat.com>, 
 Vivek Kasireddy <vivek.kasireddy@intel.com>, 
 Sumit Semwal <sumit.semwal@linaro.org>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org, 
 linaro-mm-sig@lists.linaro.org, linux-kselftest@vger.kernel.org, 
 sdf@fomichev.me, razor@blackwall.org, daniel@iogearbox.net, 
 almasrymina@google.com, matttbe@kernel.org, skhawaja@google.com, 
 dw@davidwei.uk, Joe Damato <joe@dama.to>, 
 Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.14.3

From: Bobby Eshleman <bobbyeshleman@meta.com>

Add -b <bytes> to request a non-default niov size via
NETDEV_A_DMABUF_RX_PAGE_SIZE. When the value exceeds PAGE_SIZE,
udmabuf_alloc() switches to an MFD_HUGETLB-backed memfd so each 2 MB
hugepage produces one naturally-aligned sg entry.

Acked-by: Stanislav Fomichev <sdf@fomichev.me>
Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>
Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 tools/testing/selftests/drivers/net/hw/ncdevmem.c | 36 +++++++++++++++++++++--
 1 file changed, 33 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/hw/ncdevmem.c b/tools/testing/selftests/drivers/net/hw/ncdevmem.c
index ffe1d5c1fa4e..918e3b51f3b8 100644
--- a/tools/testing/selftests/drivers/net/hw/ncdevmem.c
+++ b/tools/testing/selftests/drivers/net/hw/ncdevmem.c
@@ -40,6 +40,7 @@
 
 #include <linux/uio.h>
 #include <stdarg.h>
+#include <stdint.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <unistd.h>
@@ -61,6 +62,7 @@
 #include <sys/time.h>
 
 #include <linux/memfd.h>
+#include <sys/param.h>
 #include <linux/dma-buf.h>
 #include <linux/errqueue.h>
 #include <linux/udmabuf.h>
@@ -79,6 +81,7 @@
 #define PAGE_SHIFT 12
 #define TEST_PREFIX "ncdevmem"
 #define NUM_PAGES 16000
+#define MB(x) ((x) << 20)
 
 #ifndef MSG_SOCK_DEVMEM
 #define MSG_SOCK_DEVMEM 0x2000000
@@ -100,6 +103,7 @@ static unsigned int dmabuf_id;
 static uint32_t tx_dmabuf_id;
 static int waittime_ms = 500;
 static bool fail_on_linear;
+static uint32_t rx_page_size;
 
 /* System state loaded by current_config_load() */
 #define MAX_FLOWS	8
@@ -142,6 +146,7 @@ static struct memory_buffer *udmabuf_alloc(size_t size)
 {
 	struct udmabuf_create create;
 	struct memory_buffer *ctx;
+	unsigned int memfd_flags;
 	int ret;
 
 	ctx = malloc(sizeof(*ctx));
@@ -156,9 +161,14 @@ static struct memory_buffer *udmabuf_alloc(size_t size)
 		goto err_free_ctx;
 	}
 
-	ctx->memfd = memfd_create("udmabuf-test", MFD_ALLOW_SEALING);
+	memfd_flags = MFD_ALLOW_SEALING;
+	if (rx_page_size > getpagesize())
+		memfd_flags |= MFD_HUGETLB | MFD_HUGE_2MB;
+
+	ctx->memfd = memfd_create("udmabuf-test", memfd_flags);
 	if (ctx->memfd < 0) {
-		pr_err("[skip,no-memfd]");
+		pr_err("[skip,no-memfd%s]",
+		       (memfd_flags & MFD_HUGETLB) ? " (need hugepages)" : "");
 		goto err_close_dev;
 	}
 
@@ -168,6 +178,11 @@ static struct memory_buffer *udmabuf_alloc(size_t size)
 		goto err_close_memfd;
 	}
 
+	if (memfd_flags & MFD_HUGETLB) {
+		size = roundup(size, MB(2));
+		ctx->size = size;
+	}
+
 	ret = ftruncate(ctx->memfd, size);
 	if (ret == -1) {
 		pr_err("[FAIL,memfd-truncate]");
@@ -699,6 +714,8 @@ static int bind_rx_queue(unsigned int ifindex, unsigned int dmabuf_fd,
 	netdev_bind_rx_req_set_ifindex(req, ifindex);
 	netdev_bind_rx_req_set_fd(req, dmabuf_fd);
 	__netdev_bind_rx_req_set_queues(req, queues, n_queue_index);
+	if (rx_page_size)
+		netdev_bind_rx_req_set_rx_page_size(req, rx_page_size);
 
 	rsp = netdev_bind_rx(*ys, req);
 	if (!rsp) {
@@ -1411,7 +1428,7 @@ int main(int argc, char *argv[])
 	int is_server = 0, opt;
 	int ret, err = 1;
 
-	while ((opt = getopt(argc, argv, "Lls:c:p:v:q:t:f:z:n")) != -1) {
+	while ((opt = getopt(argc, argv, "Lls:c:p:v:q:t:f:z:nb:")) != -1) {
 		switch (opt) {
 		case 'L':
 			fail_on_linear = true;
@@ -1446,6 +1463,19 @@ int main(int argc, char *argv[])
 		case 'n':
 			skip_config = 1;
 			break;
+		case 'b': {
+			unsigned long val;
+
+			errno = 0;
+			val = strtoul(optarg, NULL, 0);
+			if ((val == ULONG_MAX && errno == ERANGE) ||
+			    val > UINT32_MAX) {
+				pr_err("invalid rx_page_size: %s", optarg);
+				return 1;
+			}
+			rx_page_size = val;
+			break;
+		}
 		case '?':
 			fprintf(stderr, "unknown option: %c\n", optopt);
 			break;

-- 
2.53.0-Meta

