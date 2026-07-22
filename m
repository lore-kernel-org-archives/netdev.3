Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5946243C051
	for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 20:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784752946; cv=none; b=SRfChI5LP8ytqQnuGYrluPwoo+SB8fFWLOtsa0nYRxKUR43TnzRyfou0bS+QSM4W+7B7nmriyIMhTCCKmvMqgN54mpkFfOztH0VB9AMls6miGT+oWydqGdpZ2Pfo8UIosxumgGb/WGe+UbjCc4/BL+eI90RFVO5TovYzYU8bSKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784752946; c=relaxed/simple;
	bh=Y2dtgSk33GL0Fdy9JgkqGRseoB5qI2/IhvbatShCMBc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pLJw/e5Axaqh4B8K4tGyj5A8L1VsXCkYPnZ3bRavoUN4fxTUY0fjq5+gsuu/OrWRGUjqJyD6CD0+ZFBryjpbV3zvURD8S18ZH7r+cTF70tVsUmnuSjtSpKxayMAoEJ474MFezvnoK0tjRU2vcMPHoL0FrRhOTXcvdfEonPpe++s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=eESzBttz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ovqtYu0I; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="eESzBttz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ovqtYu0I"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 8F2B11D000D9;
	Wed, 22 Jul 2026 16:42:24 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Wed, 22 Jul 2026 16:42:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1784752944; x=
	1784839344; bh=c9fQyn8u35n8fz+wNF5w/ukwau4Ihd8pQe2eAv+u9I0=; b=e
	ESzBttzov6n6gC5y31qGeVCMN/P7FADUmKvb+GtCAS5aYKcg0fHjQ7QsB8coB+h5
	+X8llOvprr4V9OuQEuAp/p4QcsHKydjIOWexQ3+Den24+1irC9FT+JBFHiTFvEyU
	KYvpn9XyrIJDbtF+Vv/pjCHNwOD81+SvhnZ4nGS4RSoIfH9AGJkQr7MDqfd6wP0P
	C2SZ5P5EzpDW3PuYcxffU9PRw+mUfj4WewDlTb/Dl7ysmDmO3qSXyb6AEyzyaO6R
	Ft68D6iHdtGH5PRYp1k3OHRkjer4nPBiuJ0sOvSU1L1qFSdO4pou/eaK98mvtOP5
	iNTlrGgCMnUqniJrccfmA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1784752944; x=1784839344; bh=c
	9fQyn8u35n8fz+wNF5w/ukwau4Ihd8pQe2eAv+u9I0=; b=ovqtYu0IZtwMF7ytd
	yS90YVKJhqm7t99VMt4gRBeeaa7UlBKoKgLy36ec2exlYGG+IfNB9MjzCZpZZw7D
	85CbYSkxFyarcTJIh+g2jLcL6gA3XBzzyo87sFVu4LqK6Bdne+Lfy/zKgkGik1gm
	X5kVOh3xg7ErFtgkMRFWDfKac0zchrZejUgzcGgCbgS6jbnx3bmPEx1Dt0StDX7u
	e9wLipsnKmQlMXkYPuV2qniTpkxUSXSM0Qz6v+xMYVmmbpea3HkYqY4JqJee8pTG
	VaZBtopznAtPl8M8VcfsthieNzgbmA2fQwqfFyM5Wo5St5si0kiSON8FfFhNwRNM
	GmwgA==
X-ME-Sender: <xms:MCthao01b17F-B-0OgI6ueAGQa1x8IaQz8tNQJjKaKGZGpa0oLSCJA>
    <xme:MCthap9hn94ZIgyLM_jUfFylxHfuyDDaa8fykXRl6u4wheNMZnoxP0rtXeP4Phqn6
    hrdpSUtz3fgrYazdAfAHKjnlbaWFaAFckw2qALHdzFKJVdeRiQjqGTX>
X-ME-Received: <xmr:MCthapP9N3_ifZn01UyVjgz15f8_XYQluSBKiYh3S8O-cRehTA3q83ZX-glz3xHMuoPajFjPsHxvan8rv5BNOg>
X-ME-Proxy-Cause: dmFkZTFRc+tI3NI8PVhs8W+LKGb9J4nIq+oOSJXc+3MGu/5Ezy2lozc/BYR7F4ogyrsV1A
    WxRM/Osmjcu3J7EqiiL24IBYXprYFr0L87cpaUuwODFkCR6BxRER5wacvxedqaLfgT6geP
    5ciYI+ELjSmwAuiYhyy7MZNs8mZ1UZqIcWspy8AbhI6/bAkeLBUWjgOOoxV/vBLjoSMom+
    3SmIq3UpgSD/oxB8T5GL/myr9hpWZS9+uW3pLDFo2YyJX7UQfr8bkaar2VYiCivsvAIYuW
    9F5v21to5HzPN55d+sEYls8l1jMHaoy+qkjOIaNDF+cmm0P/gKMgV9SINsBc7SGKlEjPU+
    HIyKZ0AKuddYjh2jYnkhfvDXyB4idr94+SeWEks1WLEH0/vQS3Idl9F7PxyguBGnj+hbbU
    UZ8KZvW6pKxFVuXRDztHtJQ18INuU+uirEDAZstdM/g4ZZb1NcziG6EcNLAoAZ9WkAR4R6
    iNONRZ8TepZGPA/uhkVgUv53spl3sJ9vkP6CJCS8wsglTb9P/5iUMrc6KdK9oZhmIzi1Nr
    DSR+WsaYlc0bY5kWeSfufRLS0Jdd48nK7q6ZcU6IGzNGCHbbR2WImakclJZ3GwIfI3KcdJ
    qNOasDDYctoOxKDFLV039FEttrizTv+1fgDgQJ9u/LOXFGA2zhxtlm+UQPOg
X-ME-Proxy: <xmx:MCthatczzjt6Kw1nW6Tuy47ioLDTr4zrl3Xnt4nNUb43I32NyP6qaw>
    <xmx:MCthaoX5qCpFMQ-BOnr9yHGjCsjkSIHGKHzd72sAsC3idsUaW13aLg>
    <xmx:MCthalgVuFpRblsjBboulAPQoPiajW0hqA2xtj2veYUo4D1t1dcHBQ>
    <xmx:MCthan9u51YspSA99_hqVBKo-jb3gfthsVHsVxYZknADe_HL_R-yig>
    <xmx:MCthavc3b-x1qqndCte99nryvy1m3KduNjhSs-VfeL9piIrkDdZx4Qar>
Feedback-ID: i80b64ba7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 Jul 2026 16:42:23 -0400 (EDT)
From: Juanlu Herrero <juanlu@fastmail.com>
To: David Wei <dw@davidwei.uk>,
	netdev@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	Pavel Begunkov <asml.silence@gmail.com>,
	Juanlu Herrero <juanlu@fastmail.com>
Subject: [PATCH net-next v3 4/6] selftests: net: add multithread client support to iou-zcrx
Date: Wed, 22 Jul 2026 15:39:48 -0500
Message-ID: <20260722203950.58550-5-juanlu@fastmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260722203950.58550-1-juanlu@fastmail.com>
References: <20260722203950.58550-1-juanlu@fastmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add pthreads to the iou-zcrx client so that multiple connections can be
established simultaneously. Each client thread connects to the server
and sends its payload independently.

Introduce the -t option to control the number of threads (default 1),
preserving backwards compatibility with existing tests.

Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Juanlu Herrero <juanlu@fastmail.com>
---
 .../testing/selftests/drivers/net/hw/Makefile |  2 +-
 .../selftests/drivers/net/hw/iou-zcrx.c       | 38 +++++++++++++++++--
 2 files changed, 36 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/hw/Makefile b/tools/testing/selftests/drivers/net/hw/Makefile
index 234db5c2c90cc..3cab3b4adbb2e 100644
--- a/tools/testing/selftests/drivers/net/hw/Makefile
+++ b/tools/testing/selftests/drivers/net/hw/Makefile
@@ -88,5 +88,5 @@ include ../../../net/ynl.mk
 include ../../../net/bpf.mk
 
 ifeq ($(HAS_IOURING_ZCRX),y)
-$(OUTPUT)/iou-zcrx: LDLIBS += -luring
+$(OUTPUT)/iou-zcrx: LDLIBS += -luring -lpthread
 endif
diff --git a/tools/testing/selftests/drivers/net/hw/iou-zcrx.c b/tools/testing/selftests/drivers/net/hw/iou-zcrx.c
index 9b62fd0703e61..7bc61f3b70ca6 100644
--- a/tools/testing/selftests/drivers/net/hw/iou-zcrx.c
+++ b/tools/testing/selftests/drivers/net/hw/iou-zcrx.c
@@ -4,6 +4,7 @@
 #include <error.h>
 #include <fcntl.h>
 #include <limits.h>
+#include <pthread.h>
 #include <stdbool.h>
 #include <stdint.h>
 #include <stdio.h>
@@ -85,9 +86,12 @@ static int cfg_send_size = SEND_SIZE;
 static struct sockaddr_in6 cfg_addr;
 static unsigned int cfg_rx_buf_len;
 static bool cfg_dry_run;
+static int cfg_num_threads = 1;
 
 static char *payload;
 
+#define CONNS_PER_THREAD	4
+
 struct thread_ctx {
 	struct io_uring		ring;
 	void			*area_ptr;
@@ -379,7 +383,7 @@ static void run_server(void)
 		error(1, 0, "test failed\n");
 }
 
-static void run_client(void)
+static void *client_worker(void *arg)
 {
 	ssize_t to_send = cfg_send_size;
 	ssize_t sent = 0;
@@ -405,12 +409,37 @@ static void run_client(void)
 	}
 
 	close(fd);
+	return NULL;
+}
+
+static void run_client(void)
+{
+	int conns_per_thread = cfg_num_threads > 1 ? CONNS_PER_THREAD : 1;
+	int total_conns = conns_per_thread * cfg_num_threads;
+	pthread_t *threads;
+	int i, ret;
+
+	threads = calloc(total_conns, sizeof(*threads));
+	if (!threads)
+		error(1, 0, "calloc()");
+
+	for (i = 0; i < total_conns; i++) {
+		ret = pthread_create(&threads[i], NULL, client_worker, NULL);
+		if (ret)
+			error(1, ret, "pthread_create()");
+	}
+
+	for (i = 0; i < total_conns; i++)
+		pthread_join(threads[i], NULL);
+
+	free(threads);
 }
 
 static void usage(const char *filepath)
 {
 	error(1, 0, "Usage: %s (-4|-6) (-s|-c) -h<server_ip> -p<port> "
-		    "-l<payload_size> -i<ifname> -q<rxq_id>", filepath);
+		    "-l<payload_size> -i<ifname> -q<rxq_id> -t<num_threads>",
+		    filepath);
 }
 
 static void parse_opts(int argc, char **argv)
@@ -428,7 +457,7 @@ static void parse_opts(int argc, char **argv)
 		usage(argv[0]);
 	cfg_payload_len = max_payload_len;
 
-	while ((c = getopt(argc, argv, "sch:p:l:i:q:o:z:x:d")) != -1) {
+	while ((c = getopt(argc, argv, "sch:p:l:i:q:o:z:x:dt:")) != -1) {
 		switch (c) {
 		case 's':
 			if (cfg_client)
@@ -469,6 +498,9 @@ static void parse_opts(int argc, char **argv)
 		case 'd':
 			cfg_dry_run = true;
 			break;
+		case 't':
+			cfg_num_threads = strtoul(optarg, NULL, 0);
+			break;
 		}
 	}
 
-- 
2.53.0-Meta

