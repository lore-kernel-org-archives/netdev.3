Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4012843F8CB
	for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 22:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785363539; cv=none; b=jeCKC6YGtTE9n7A/MbSSqzFCIFOVygNrULQDuIM+DRUyPLB4YHvHsul8Q/KMCAiyV0c8mnAj/u0tsnEpaacaTxHjNm3AfRVf+uhrFtowqEpM8+Ds/IuX2Y+d1vU7Tj+oFEcUq0cn7jw5ejw7mNQPwcZ+5u03yGFm6C2bXBeHJQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785363539; c=relaxed/simple;
	bh=Y2dtgSk33GL0Fdy9JgkqGRseoB5qI2/IhvbatShCMBc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rKnZ3EUcXOy/le7RKv0kzGSzE1GWBmps89Gi9KSFC03g0KRENnAEFUq3jFDSZ8VDMDq5lHfhBCbnmhxRJwpFRjzRnFYGGvA9wljEhZjQWPRl8OhcSYaH31+olmZE5D1rwcJI8zrgxlMFHQRBFvUSC7NA0bb6zWz2AUwjLXP22sA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=LV9UBFjM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dhfnVtlr; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="LV9UBFjM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dhfnVtlr"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id 6E3F21D00295;
	Wed, 29 Jul 2026 18:18:57 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Wed, 29 Jul 2026 18:18:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1785363537; x=
	1785449937; bh=c9fQyn8u35n8fz+wNF5w/ukwau4Ihd8pQe2eAv+u9I0=; b=L
	V9UBFjMUKFSN+/fjqjzJNTfKXmnuxBMn72f6nedrG1TY3VlwTuK+eYhxsqfPb5Fv
	yWjui9sJEXfdGjpgCtrtDeh+Tp+0ytSv1EH82ooIRaR8BMdekcLzplfaw5HrnN9C
	mLs1Eum7tq0l7cGtBKjCDltlXQmM+cylu6fm2hx93rDEYpgzNagqcbJA4bhLrYFq
	762EocOEkHRSUmoIjfsR3XTNzVX3FzIXQT3qrgOvxocw/matv8vgi3oGKkNzyg1W
	C4BUDLnn1ReceQQ66WKMF+k3v4X5IPMklUDioQl1jc2JwvXvlrWKhw83gJDKQA1F
	VbmFeH7GTExwPlN7PWAUw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1785363537; x=1785449937; bh=c
	9fQyn8u35n8fz+wNF5w/ukwau4Ihd8pQe2eAv+u9I0=; b=dhfnVtlrPNtfwJ9yH
	b6dpPHpPArnpxEoZpkjOWP4pc3ns5DT8dzoKLsQDvk6Pw7SBXZJKT5ntcXyLuu5b
	hp0t/bMH3aGxUcaScwdfWN4whQ/ZzoSMhSWMKoa8tnqsD8mcjnZZn+i1gavoBeMb
	MrEQvKJNl77SUkJCAklacZEJS1b2ruDfZ/U2GREvA31fC0gPJl+r8rgd936dM4I5
	HMUTrkcFiTlpMotn2gXG75B2rJ9webt3HYvuFFxiW5Qj/9dT6dbjQhA9mfJtncRS
	QWeQiPQuc1uV0ghNBoC6CawvyKop986AJ/dlofqMri3dmV9C0IA5jvh4b1LFFZMY
	0Lrng==
X-ME-Sender: <xms:UXxqah_KgkBZLG4JP8AKhs7SgEwhP0NTFJdQHSTjjZ61YdRvGVRu1g>
    <xme:UXxqasnPCEt3cWgvyaTGpeEL0EeIxF_UNe7Mr8BIS6I2Yl3O1cNkKbl73Id-I85GD
    C-A4PbmWdGSiH72cAePhzne3YJ6mlGMr4KMNB0KU87H3LyAsuyavnQH>
X-ME-Received: <xmr:UXxqanWhzVtjdxWHkMCeAtpDQhrQH-87yGlUF_1PmF2qY7r_VdGeegqCbLPTCStSYiwOf4amCGY17SwtoApM>
X-ME-Proxy-Cause: dmFkZTGYxrxOA2kX45FjE7uWqEUywGWHyDyBWaser44hAwDMI7rJ+0mpvuMoO5poBkjbAN
    aH3CsQ3LZCMu7NFu/0dJnJTDGw38j08D0bDmRjODkSV35yDvnTovlndu+6M21iwHBKZ8f2
    dlxokyeyx9aW+sx2aGuIgjtEskeNuIJ0u+C3A5epNRiNkvqpOySB16Nw7o8RUBTmtlf9S4
    C4vZovergqyIt9UTPPajW6CQsSxoPffB4/UAyQFOeDfXtOLCXWCBpBqN4hPTP7DXcOc9iN
    XpDV+g2WODVskwBYgMy96aTglqISzcxU2Hsj+qBq6+hkVmXvdwnpOX91vEGx1Ayp+aqmRD
    Kz8ob4EPckVtqDouK1m7NfmCsrYlWW5S6nT8WnPgtlAVl2s/HH5xe3tbSIlBpk8jjXGB3K
    XNFaLDB/ZngsYoxK+OAGbtRiMOomwURku3iIuBZKsnnkN4g5cP/SlxLcylAt9F3wpKGpAW
    fpJWorBmdGtMRjB02hn4aaVb1j/+gAnZwUW7hvxes7k9/3xr99TRSnQbpexH4b5LYRni9g
    gHrSJnJgRAEUc0EHKnX2rSPV76kZCi9oRlF96++8UHIpKiOw2NNslzLROMGRdx5jqzmVLE
    ukpyBo1aDWFBzsXyi6osrKlf1Vb5GCtUg3pVQqpabt/zpYFT2tmSqYMH6iNw
X-ME-Proxy: <xmx:UXxqahEHGqmlGWMPitw5Nzh4RH7PvLh4CApYXIREB23BrNPiVznxQA>
    <xmx:UXxqajcFMNnRVT0GkkaYiB9d8-uIMJ-uY2Wz-qsfLhoZ_IYb3-y7SA>
    <xmx:UXxqaiL80SJ57cUJsEr-J_utQo0bfu4nNYJm642W-I66eoJDiiebcg>
    <xmx:UXxqaoEugL3uwqPVaoxpQZ7JXR1LehjT2gQlahcr9HCYTlnLNMqxOA>
    <xmx:UXxqakEZQRZ1GfA8nQFVZYjai5T-Kf_p-dt3vuUv8-ojjjb_5f2BzNHl>
Feedback-ID: i80b64ba7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 29 Jul 2026 18:18:56 -0400 (EDT)
From: Juanlu Herrero <juanlu@fastmail.com>
To: David Wei <dw@davidwei.uk>,
	netdev@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	Pavel Begunkov <asml.silence@gmail.com>,
	Juanlu Herrero <juanlu@fastmail.com>
Subject: [PATCH net-next v4 4/6] selftests: net: add multithread client support to iou-zcrx
Date: Wed, 29 Jul 2026 17:18:23 -0500
Message-ID: <20260729221825.42773-5-juanlu@fastmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260729221825.42773-1-juanlu@fastmail.com>
References: <20260729221825.42773-1-juanlu@fastmail.com>
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

