Received: from mail-oo2-f40.google.com (mail-oo2-f40.google.com [74.125.231.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BA3A49E14C
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 22:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789685150; cv=none; b=NvQRLxIF670MKBFu2ud0uHN95hKhXcSwAII4HbjK2vC2nIXYcTYIfyT1hLFy2mCyGdYMpclAStjGzP0q/v1bkXfMRJw50cNRqNozCF/ADrzj9FXnkQdZncMydpS4dM9wNDmb8K1+NLg/S4tVLZUeNYkEAarfM4O9akjx4FJFoO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789685150; c=relaxed/simple;
	bh=zyiYEk10eB/kfU/3XaR5OsKrEVsYOd7+5Qs+zBC9Ldg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OSgCfEifrVHBz/UgASJQzNNz12FjFb7V1LXsJpV+7O7bFFHlAPSoh40MNw5ppvfJJKlJfZd++pCIsIVe6R0RiTRv6T0Tuxs03TxA7xQNOUjFF/R4W13Fdw7t8Py1RlSKceLUfuyej5l336kVn+KdwJgJszYMNdDlvnb4D9T5TEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=pass smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=Ydmk+ma8; arc=none smtp.client-ip=74.125.231.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="Ydmk+ma8"
Received: by mail-oo2-f40.google.com with SMTP id 006d021491bc7-6bc475ffcf6so74538eaf.1
        for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 15:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1789685143; x=1790289943; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZBne/fy9/p0sDf+PiW32C/CCzN6ou/SIlzMsJNK3aPc=;
        b=Ydmk+ma8y6CR99UoekJ2dYdUOOPErf0w5V6Hsqioik0NEnDIWr6CHATWjeeIcDsTuj
         Rt66LEPPnfFTNzg0XuqBoJ7lmXqn60urv1yrtZqm8rkduIadjVoPE8WUXUP3kNiZEW4B
         t3wc/WbWTRCyE8vrN5qY1pJTfIcMzrB+CqDvQfLFZDu3HsO+stDIkRlxYtF2a+oqIqf4
         AB0G8IU5zhsZf1fduIRh3DP//lY+AhMQ/Gr5Fnnhe/yf6uve4A3uS2uzUpzrVsF8bfzk
         0XxMvO91NDQLjB0QdHvqkwME/EMg6zOgN25BwtFqUJRwA2rEA88VElwMIVzvMs0cZTEv
         f6ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789685143; x=1790289943;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZBne/fy9/p0sDf+PiW32C/CCzN6ou/SIlzMsJNK3aPc=;
        b=kxJM5clrnts+3pozMGNiT9/1Fd/a/A7A1kJ6tUopaK5RDL675014Sy3s/1rUwfGkrn
         jrNa03kxEPZtdvCwsNutoPHSkK8ityL7nMY692mE2+6Su9eP/NChEBk7fJfNmiJ+lph3
         auhClLC2jS9xMmzASurG1Hgv8DDz5FG0c2TMsos91CLOv3NosJJ0lTu6760hidz/kWGF
         pCqe1ICMcrsIhXa/R3bJEHHK0VDZ7c37cTDUryXTsNaUQWJjRHXP0gkg+/sLnaHN1RjJ
         pLN6Qo1CIzI2f7a6A0yMf/aUxu7DTZbJjdnb9Xxii7scYZUMWOMa+xt1LKmq5cb/X7/5
         qvZg==
X-Gm-Message-State: AFuF++mXixMOd2iCLkzJFnZLYWRy3ECfr8ih0fWb70Emr+vl7BH1+cN/
	w3a1PRTxUPS7VQs6VA6DDh1I5NrQgv+LhZa8BqKApu2tS9qk1MMBTr17Lehy2Z9jHjeQhl9wQHo
	zumM9ncaC50QUhOz0gOrvHOnz+PE2IXro0lue/cz/0/bZmSirQaW2y/Y1BS+HTfLf9PSiiVv8AR
	cKU0UFK4wnOGQN66smgbgeILQkyItEzUcfOaefrPAPF6nfo74=
X-Gm-Gg: AYBFou2FlKpDVTavRfa6hfQM5ZfX6Uop0iAzaBbwezV5Q2o5uwtvVCkAsqV6PpyCwPV
	zT52bmXl8Y1Reeg4AOGVBYVrD/H9Y3eJyrKE4XB1BLz5ezfIIzHS8GoJ5F70imUqPpqg387WGDT
	uhz6Zy0I11ptRyF0kqoV/xAfc+l0HpQOOyjk0vz7attByh+uAslYIVMQtgoM5Kh5aqgWqq1Agpp
	kqkkeEWnBy2ssYAjSVFQczArhnD2TiNBxvn7yYVEPitqMnvnoaQS/4WGA95RRz4GutWEbYos9+p
	EiAG+3jTPPSnpM7vDyMLAcVNd1vwC8AAEDH/jtLxZU/pAIdHD0PpnVSpkKpIlqBQP3RBAfda9RB
	PDI70ycIf7fDSr6im0FNOAQjrLipeCnYSjIcWwnQ5ULfEmXrqbmDgN5wtsk95nT6sBGZSmHUowI
	0IEBnrxvwU816SWj5G9TsJDs3bRI3m6oDjW81iVSeXvSgRPClA6TNkxkIQ3OhwUK0L1fb3yxQ9T
	At5UIveCXoiM9IbKyuZCBo1CFL80OZdtQl7vT4BRjxryXe+ezFyuP0vp9oNU+UTwduzgqirOJSd
	yjiu3IjUvHQa6MWeyH1NUcyPaLuLEhfh71ZrFN44lL0F2/HF8IbWYxKCfQ4US0xgdNACsNWpX8t
	WIxk0pccvK3sbaOOrhQ==
X-Received: by 2002:a05:6820:201b:b0:6c9:80d9:5e8 with SMTP id 006d021491bc7-6ca9bf4c753mr505516eaf.41.1789685141953;
        Thu, 17 Sep 2026 15:45:41 -0700 (PDT)
Received: from dev-rjethwani.dev.purestorage.com ([208.88.159.129])
        by smtp.googlemail.com with ESMTPSA id 586e51a60fabf-4870ac16ec0sm88605fac.5.2026.09.17.15.45.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 15:45:41 -0700 (PDT)
From: Rishikesh Jethwani <rjethwani@purestorage.com>
To: netdev@vger.kernel.org
Cc: saeedm@nvidia.com,
	tariqt@nvidia.com,
	mbloch@nvidia.com,
	borisp@nvidia.com,
	john.fastabend@gmail.com,
	kuba@kernel.org,
	sd@queasysnail.net,
	davem@davemloft.net,
	pabeni@redhat.com,
	edumazet@google.com,
	leon@kernel.org,
	andrew.gospodarek@broadcom.com,
	Rishikesh Jethwani <rjethwani@purestorage.com>
Subject: [PATCH net-next v17 14/15] selftests: net: add TLS hardware offload test
Date: Thu, 17 Sep 2026 16:35:25 -0600
Message-ID: <20260917224355.2288021-15-rjethwani@purestorage.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260917224355.2288021-1-rjethwani@purestorage.com>
References: <20260917224355.2288021-1-rjethwani@purestorage.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Two-node kTLS HW offload test using NetDrvEpEnv. A C helper binary
acts as TLS client or server; a Python harness drives it and verifies
TLS stat counters (RekeyOk, RekeyReceived, RekeyFallback,
CurrRekey, RekeyAborted, RekeyError, DecryptError).

Covers TLS 1.2/1.3 with AES-GCM-128/256, rekey with various buffer
sizes, and burst variants that stress TX rekey (temporary SW phase,
HW reinstall) and RX rekey (boundary tracking, old-key reencryption,
deferred dev_add).

Signed-off-by: Rishikesh Jethwani <rjethwani@purestorage.com>
---
 MAINTAINERS                                   |    2 +
 .../selftests/drivers/net/hw/.gitignore       |    1 +
 .../testing/selftests/drivers/net/hw/Makefile |    2 +
 tools/testing/selftests/drivers/net/hw/config |    2 +
 .../selftests/drivers/net/hw/tls_hw_offload.c | 1132 +++++++++++++++++
 .../drivers/net/hw/tls_hw_offload.py          |  446 +++++++
 6 files changed, 1585 insertions(+)
 create mode 100644 tools/testing/selftests/drivers/net/hw/tls_hw_offload.c
 create mode 100755 tools/testing/selftests/drivers/net/hw/tls_hw_offload.py

diff --git a/MAINTAINERS b/MAINTAINERS
index 0e04d92d1b09..4f1645bf2ee5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19255,6 +19255,8 @@ F:	Documentation/networking/tls*
 F:	include/net/tls.h
 F:	include/uapi/linux/tls.h
 F:	net/tls/
+F:	tools/testing/selftests/drivers/net/hw/tls_hw_offload.c
+F:	tools/testing/selftests/drivers/net/hw/tls_hw_offload.py
 F:	tools/testing/selftests/net/tls.c
 
 NETWORKING [SOCKETS]
diff --git a/tools/testing/selftests/drivers/net/hw/.gitignore b/tools/testing/selftests/drivers/net/hw/.gitignore
index 46540468a775..911a9bfeaf41 100644
--- a/tools/testing/selftests/drivers/net/hw/.gitignore
+++ b/tools/testing/selftests/drivers/net/hw/.gitignore
@@ -1,4 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0-only
 iou-zcrx
 ncdevmem
+tls_hw_offload
 toeplitz
diff --git a/tools/testing/selftests/drivers/net/hw/Makefile b/tools/testing/selftests/drivers/net/hw/Makefile
index 8aebdc6feb17..b3831c2d09ea 100644
--- a/tools/testing/selftests/drivers/net/hw/Makefile
+++ b/tools/testing/selftests/drivers/net/hw/Makefile
@@ -46,6 +46,7 @@ TEST_PROGS = \
 	rss_drv.py \
 	rss_flow_label.py \
 	rss_input_xfrm.py \
+	tls_hw_offload.py \
 	toeplitz.py \
 	tso.py \
 	userns_devmem.py \
@@ -80,6 +81,7 @@ YNL_GEN_FILES := \
 # end of YNL_GEN_FILES
 TEST_GEN_FILES += $(YNL_GEN_FILES)
 TEST_GEN_FILES += $(patsubst %.c,%.o,$(wildcard *.bpf.c))
+TEST_GEN_FILES += tls_hw_offload
 
 include ../../../lib.mk
 
diff --git a/tools/testing/selftests/drivers/net/hw/config b/tools/testing/selftests/drivers/net/hw/config
index d89a9ba17655..169e608516bd 100644
--- a/tools/testing/selftests/drivers/net/hw/config
+++ b/tools/testing/selftests/drivers/net/hw/config
@@ -22,6 +22,8 @@ CONFIG_NET_IPIP=y
 CONFIG_NETKIT=y
 CONFIG_NET_SCH_INGRESS=y
 CONFIG_SYNC_FILE=y
+CONFIG_TLS=y
+CONFIG_TLS_DEVICE=y
 CONFIG_UDMABUF=y
 CONFIG_USER_NS=y
 CONFIG_VXLAN=y
diff --git a/tools/testing/selftests/drivers/net/hw/tls_hw_offload.c b/tools/testing/selftests/drivers/net/hw/tls_hw_offload.c
new file mode 100644
index 000000000000..303c6752ace2
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/hw/tls_hw_offload.c
@@ -0,0 +1,1132 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * TLS Hardware Offload Two-Node Test
+ *
+ * Tests kTLS hardware offload between two physical nodes using
+ * hardcoded keys. Supports TLS 1.2/1.3, AES-GCM-128/256, and rekey.
+ */
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+#include <errno.h>
+#include <limits.h>
+#include <time.h>
+#include <sys/time.h>
+#include <signal.h>
+#include <sys/types.h>
+#include <sys/socket.h>
+#include <netinet/in.h>
+#include <netinet/tcp.h>
+#include <netdb.h>
+#include <linux/tls.h>
+
+#define TLS_RECORD_TYPE_HANDSHAKE		22
+#define TLS_HANDSHAKE_KEY_UPDATE		0x18
+
+/* Large enough for a TLS 1.3 KeyUpdate handshake record's plaintext. */
+#define MIN_BUF_SIZE   16
+
+/* Initial key material */
+static struct tls12_crypto_info_aes_gcm_128 tls_info_key0_128 = {
+	.info = {
+		.version = TLS_1_3_VERSION,
+		.cipher_type = TLS_CIPHER_AES_GCM_128,
+	},
+	.iv = { 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08 },
+	.key = { 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08,
+		 0x09, 0x0a, 0x0b, 0x0c, 0x0d, 0x0e, 0x0f, 0x10 },
+	.salt = { 0x01, 0x02, 0x03, 0x04 },
+	.rec_seq = { 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 },
+};
+
+static struct tls12_crypto_info_aes_gcm_256 tls_info_key0_256 = {
+	.info = {
+		.version = TLS_1_3_VERSION,
+		.cipher_type = TLS_CIPHER_AES_GCM_256,
+	},
+	.iv = { 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08 },
+	.key = { 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08,
+		 0x09, 0x0a, 0x0b, 0x0c, 0x0d, 0x0e, 0x0f, 0x10,
+		 0x11, 0x12, 0x13, 0x14, 0x15, 0x16, 0x17, 0x18,
+		 0x19, 0x1a, 0x1b, 0x1c, 0x1d, 0x1e, 0x1f, 0x20 },
+	.salt = { 0x01, 0x02, 0x03, 0x04 },
+	.rec_seq = { 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 },
+};
+
+static int num_rekeys;
+static int num_iterations = 100;
+static int cipher_type = TLS_CIPHER_AES_GCM_128;
+static int tls_version = TLS_1_3_VERSION;
+static int server_port = 4433;
+static char *server_ip;
+/* Address family to force: AF_UNSPEC (any), AF_INET (-4), AF_INET6 (-6). */
+static int force_family = AF_UNSPEC;
+
+static int send_size = 16384;
+static int random_size_max;
+/* Burst mode: sender keeps pushing records without reading from the peer;
+ * receiver drains without echoing back. Only the client initiates rekey.
+ */
+static int burst_mode;
+static int zc_rx;
+
+/* XOR each byte with the generation so both endpoints derive the
+ * same per-generation key without a real KDF. Generation 0 leaves
+ * the base key unchanged.
+ */
+static void derive_key_fields(unsigned char *key, int key_size,
+			      unsigned char *iv, int iv_size,
+			      unsigned char *salt, int salt_size,
+			      unsigned char *rec_seq, int rec_seq_size,
+			      int generation)
+{
+	int i;
+
+	for (i = 0; i < key_size; i++)
+		key[i] ^= generation;
+	for (i = 0; i < iv_size; i++)
+		iv[i] ^= generation;
+	for (i = 0; i < salt_size; i++)
+		salt[i] ^= generation;
+	memset(rec_seq, 0, rec_seq_size);
+}
+
+static void derive_key_128(struct tls12_crypto_info_aes_gcm_128 *key,
+			   int generation)
+{
+	memcpy(key, &tls_info_key0_128, sizeof(*key));
+	key->info.version = tls_version;
+	derive_key_fields(key->key, TLS_CIPHER_AES_GCM_128_KEY_SIZE,
+			  key->iv, TLS_CIPHER_AES_GCM_128_IV_SIZE,
+			  key->salt, TLS_CIPHER_AES_GCM_128_SALT_SIZE,
+			  key->rec_seq, TLS_CIPHER_AES_GCM_128_REC_SEQ_SIZE,
+			  generation);
+}
+
+static void derive_key_256(struct tls12_crypto_info_aes_gcm_256 *key,
+			   int generation)
+{
+	memcpy(key, &tls_info_key0_256, sizeof(*key));
+	key->info.version = tls_version;
+	derive_key_fields(key->key, TLS_CIPHER_AES_GCM_256_KEY_SIZE,
+			  key->iv, TLS_CIPHER_AES_GCM_256_IV_SIZE,
+			  key->salt, TLS_CIPHER_AES_GCM_256_SALT_SIZE,
+			  key->rec_seq, TLS_CIPHER_AES_GCM_256_REC_SEQ_SIZE,
+			  generation);
+}
+
+static const char *cipher_name(int cipher)
+{
+	switch (cipher) {
+	case TLS_CIPHER_AES_GCM_128: return "AES-GCM-128";
+	case TLS_CIPHER_AES_GCM_256: return "AES-GCM-256";
+	default: return "unknown";
+	}
+}
+
+static const char *version_name(int version)
+{
+	switch (version) {
+	case TLS_1_2_VERSION: return "TLS 1.2";
+	case TLS_1_3_VERSION: return "TLS 1.3";
+	default: return "unknown";
+	}
+}
+
+static int setup_tls_ulp(int fd)
+{
+	int ret;
+
+	ret = setsockopt(fd, IPPROTO_TCP, TCP_ULP, "tls", sizeof("tls"));
+	if (ret < 0) {
+		printf("SETUP ERROR: TCP_ULP failed: %s\n", strerror(errno));
+		return -1;
+	}
+	return 0;
+}
+
+/* Echo (non-burst) mode drives both directions from a single thread: the
+ * client pushes a whole payload with one blocking send() and only reads the
+ * echo afterwards, while the server blocks in send() mid-echo. If a payload
+ * exceeds the peer's receive window the two sides deadlock - client stuck in
+ * send(), server stuck echoing, neither draining the other. Size the socket
+ * buffers so a full payload always fits in the peer's window (the forward
+ * send() then completes without needing the peer to read concurrently); the
+ * send/recv timeouts armed by set_io_timeouts() turn any residual stall into a
+ * loud EAGAIN instead of a hang.
+ */
+static void configure_echo_socket(int fd, int payload)
+{
+	int want = payload;
+
+	if (want < MIN_BUF_SIZE)
+		want = MIN_BUF_SIZE;
+
+	/* SO_*BUFFORCE bypasses the rmem_max/wmem_max sysctl caps (needs
+	 * CAP_NET_ADMIN); fall back to the best-effort, cap-limited option
+	 * when unprivileged - the timeouts below still turn any resulting
+	 * stall into a loud failure rather than a hang.
+	 */
+	if (setsockopt(fd, SOL_SOCKET, SO_RCVBUFFORCE, &want, sizeof(want)) < 0)
+		setsockopt(fd, SOL_SOCKET, SO_RCVBUF, &want, sizeof(want));
+	if (setsockopt(fd, SOL_SOCKET, SO_SNDBUFFORCE, &want, sizeof(want)) < 0)
+		setsockopt(fd, SOL_SOCKET, SO_SNDBUF, &want, sizeof(want));
+}
+
+/* Arm send/recv timeouts so any unexpected stall fails loudly with EAGAIN
+ * instead of hanging until the harness SIGKILLs us. Wanted in both echo and
+ * burst modes - burst mode has no other stall guard.
+ */
+static void set_io_timeouts(int fd)
+{
+	struct timeval tv = { .tv_sec = 8, .tv_usec = 0 };
+
+	setsockopt(fd, SOL_SOCKET, SO_RCVTIMEO, &tv, sizeof(tv));
+	setsockopt(fd, SOL_SOCKET, SO_SNDTIMEO, &tv, sizeof(tv));
+}
+
+/* Send the whole buffer, looping over short counts. A blocking SOCK_STREAM
+ * send() may return fewer bytes than requested (e.g. when SO_SNDTIMEO fires
+ * after partial progress) without setting errno, so a short count is not an
+ * error - only a negative return is. Looping also sends each iteration as one
+ * uninterrupted run of bytes, which the peer's userspace reassembly in burst
+ * mode counts on to keep iterations aligned.
+ */
+static int send_all(int fd, const char *buf, ssize_t len)
+{
+	ssize_t sent = 0;
+	ssize_t ret;
+
+	while (sent < len) {
+		ret = send(fd, buf + sent, len - sent, 0);
+		if (ret < 0) {
+			printf("FAIL: send failed: %s\n", strerror(errno));
+			return -1;
+		}
+		sent += ret;
+	}
+	return 0;
+}
+
+static int set_zc_rx(int fd)
+{
+	int val = 1;
+
+	if (setsockopt(fd, SOL_TLS, TLS_RX_EXPECT_NO_PAD, &val,
+		       sizeof(val)) < 0) {
+		printf("SETUP ERROR: TLS_RX_EXPECT_NO_PAD failed: %s\n",
+		       strerror(errno));
+		return -1;
+	}
+	return 0;
+}
+
+/* Send a TLS 1.3 KeyUpdate handshake record. The kernel only
+ * inspects the HandshakeType byte to detect KeyUpdate, so don't
+ * bother with the 3-byte length or request_update fields.
+ */
+static int send_tls_key_update(int fd)
+{
+	char cmsg_buf[CMSG_SPACE(sizeof(unsigned char))];
+	unsigned char key_update_msg = TLS_HANDSHAKE_KEY_UPDATE;
+	struct msghdr msg = {0};
+	struct cmsghdr *cmsg;
+	struct iovec iov;
+
+	iov.iov_base = &key_update_msg;
+	iov.iov_len = sizeof(key_update_msg);
+
+	msg.msg_iov = &iov;
+	msg.msg_iovlen = 1;
+	msg.msg_control = cmsg_buf;
+	msg.msg_controllen = sizeof(cmsg_buf);
+
+	cmsg = CMSG_FIRSTHDR(&msg);
+	cmsg->cmsg_level = SOL_TLS;
+	cmsg->cmsg_type = TLS_SET_RECORD_TYPE;
+	cmsg->cmsg_len = CMSG_LEN(sizeof(unsigned char));
+	*CMSG_DATA(cmsg) = TLS_RECORD_TYPE_HANDSHAKE;
+	msg.msg_controllen = cmsg->cmsg_len;
+
+	if (sendmsg(fd, &msg, 0) < 0) {
+		printf("sendmsg KeyUpdate failed: %s\n", strerror(errno));
+		return -1;
+	}
+
+	printf("Sent TLS KeyUpdate handshake message\n");
+	return 0;
+}
+
+static int recv_tls_message(int fd, char *buf, size_t buflen, int *record_type,
+			    int flags)
+{
+	char cmsg_buf[CMSG_SPACE(sizeof(unsigned char))];
+	struct msghdr msg = {0};
+	struct cmsghdr *cmsg;
+	struct iovec iov;
+	int ret;
+
+	iov.iov_base = buf;
+	iov.iov_len = buflen;
+
+	msg.msg_iov = &iov;
+	msg.msg_iovlen = 1;
+	msg.msg_control = cmsg_buf;
+	msg.msg_controllen = sizeof(cmsg_buf);
+
+	ret = recvmsg(fd, &msg, flags);
+	if (ret <= 0)
+		return ret;
+
+	cmsg = CMSG_FIRSTHDR(&msg);
+	if (cmsg && cmsg->cmsg_level == SOL_TLS &&
+	    cmsg->cmsg_type == TLS_GET_RECORD_TYPE)
+		*record_type = *((unsigned char *)CMSG_DATA(cmsg));
+
+	return ret;
+}
+
+/* Confirm a handshake record starting with HandshakeType KeyUpdate. */
+static int check_keyupdate(const char *buf, int len, int record_type)
+{
+	if (record_type != TLS_RECORD_TYPE_HANDSHAKE) {
+		printf("Expected handshake record (0x%02x), got 0x%02x\n",
+		       TLS_RECORD_TYPE_HANDSHAKE, record_type);
+		return -1;
+	}
+	if (len < 1 || (unsigned char)buf[0] != TLS_HANDSHAKE_KEY_UPDATE) {
+		printf("Expected KeyUpdate (0x%02x), got 0x%02x\n",
+		       TLS_HANDSHAKE_KEY_UPDATE,
+		       len ? (unsigned char)buf[0] : 0);
+		return -1;
+	}
+	printf("Received TLS KeyUpdate\n");
+	return 0;
+}
+
+static int recv_tls_keyupdate(int fd)
+{
+	char buf[MIN_BUF_SIZE];
+	int record_type = 0;
+	int ret;
+
+	ret = recv_tls_message(fd, buf, sizeof(buf), &record_type, 0);
+	if (ret < 0) {
+		printf("recv_tls_message failed: %s\n", strerror(errno));
+		return -1;
+	}
+
+	return check_keyupdate(buf, ret, record_type);
+}
+
+static int check_ekeyexpired(int fd)
+{
+	char buf[MIN_BUF_SIZE];
+	int ret;
+
+	ret = recv(fd, buf, sizeof(buf), MSG_DONTWAIT);
+	if (ret == -1 && errno == EKEYEXPIRED) {
+		printf("recv() returned EKEYEXPIRED as expected\n");
+		return 0;
+	}
+	if (ret > 0) {
+		printf("FAIL: recv() returned %d bytes, expected EKEYEXPIRED\n",
+		       ret);
+		return -1;
+	}
+	if (ret == 0) {
+		printf("FAIL: connection closed during rekey\n");
+		return -1;
+	}
+	printf("FAIL: recv() returned unexpected error: %s\n",
+	       strerror(errno));
+	return -1;
+}
+
+static int do_tls_rekey(int fd, int direction, int generation, int cipher)
+{
+	const char *dir = direction == TLS_TX ? "TX" : "RX";
+	int ret;
+
+	printf("%s TLS_%s %s gen %d...\n",
+	       generation ? "Rekeying" : "Installing",
+	       dir, cipher_name(cipher), generation);
+
+	if (cipher == TLS_CIPHER_AES_GCM_256) {
+		struct tls12_crypto_info_aes_gcm_256 key;
+
+		derive_key_256(&key, generation);
+		ret = setsockopt(fd, SOL_TLS, direction, &key, sizeof(key));
+	} else {
+		struct tls12_crypto_info_aes_gcm_128 key;
+
+		derive_key_128(&key, generation);
+		ret = setsockopt(fd, SOL_TLS, direction, &key, sizeof(key));
+	}
+
+	if (ret < 0) {
+		printf("%sTLS_%s %s gen %d failed: %s\n",
+		       generation ? "" : "SETUP ERROR: ", dir,
+		       cipher_name(cipher), generation, strerror(errno));
+		return -1;
+	}
+	printf("TLS_%s %s gen %d installed\n",
+	       dir, cipher_name(cipher), generation);
+	return 0;
+}
+
+/* Open a TCP connection to server_ip:server_port, switch to the TLS
+ * ULP, and install initial generation-0 TX/RX keys. Works over IPv4 or
+ * IPv6: getaddrinfo() resolves server_ip (honouring any -4/-6 forced
+ * family and %zone scope IDs in link-local addresses). Returns the fd on
+ * success, -1 on error (with the fd already closed).
+ */
+static int client_connect_tls(void)
+{
+	struct addrinfo hints = {0}, *res, *rp;
+	char port_str[16];
+	int csk = -1;
+	int ret;
+
+	hints.ai_family = force_family;
+	hints.ai_socktype = SOCK_STREAM;
+	hints.ai_protocol = IPPROTO_TCP;
+	snprintf(port_str, sizeof(port_str), "%d", server_port);
+
+	ret = getaddrinfo(server_ip, port_str, &hints, &res);
+	if (ret) {
+		printf("SETUP ERROR: getaddrinfo(%s): %s\n", server_ip,
+		       gai_strerror(ret));
+		return -1;
+	}
+
+	printf("Connecting to %s:%d...\n", server_ip, server_port);
+	for (rp = res; rp; rp = rp->ai_next) {
+		csk = socket(rp->ai_family, rp->ai_socktype, rp->ai_protocol);
+		if (csk < 0)
+			continue;
+		if (connect(csk, rp->ai_addr, rp->ai_addrlen) == 0)
+			break;
+		close(csk);
+		csk = -1;
+	}
+	freeaddrinfo(res);
+
+	if (csk < 0) {
+		printf("SETUP ERROR: connect to %s:%d failed: %s\n",
+		       server_ip, server_port, strerror(errno));
+		return -1;
+	}
+	printf("Connected!\n");
+
+	if (setup_tls_ulp(csk) < 0)
+		goto err;
+
+	if (do_tls_rekey(csk, TLS_TX, 0, cipher_type) < 0 ||
+	    do_tls_rekey(csk, TLS_RX, 0, cipher_type) < 0)
+		goto err;
+
+	set_io_timeouts(csk);
+	if (!burst_mode)
+		configure_echo_socket(csk, random_size_max > 0 ?
+					    random_size_max : send_size);
+
+	return csk;
+err:
+	close(csk);
+	return -1;
+}
+
+/* Drain `len` echoed bytes from the server and verify they match the
+ * payload we just sent.
+ */
+static int client_recv_echo(int fd, const char *sent, char *echo_buf,
+			    ssize_t len)
+{
+	ssize_t total = 0;
+	ssize_t n;
+
+	while (total < len) {
+		n = recv(fd, echo_buf + total, len - total, 0);
+		if (n < 0) {
+			printf("FAIL: Echo recv failed: %s\n", strerror(errno));
+			return -1;
+		}
+		if (n == 0) {
+			printf("FAIL: Connection closed during echo\n");
+			return -1;
+		}
+		total += n;
+	}
+
+	if (memcmp(sent, echo_buf, len) != 0) {
+		printf("FAIL: Echo data mismatch!\n");
+		return -1;
+	}
+	printf("Received echo %zd bytes (ok)\n", total);
+	return 0;
+}
+
+/* Client side of a rekey: send KeyUpdate and rotate TX. In echo mode
+ * also wait for the peer's KeyUpdate and rotate RX.
+ */
+static int client_rekey(int fd, int generation)
+{
+	if (send_tls_key_update(fd) < 0) {
+		printf("FAIL: send KeyUpdate\n");
+		return -1;
+	}
+
+	if (do_tls_rekey(fd, TLS_TX, generation, cipher_type) < 0)
+		return -1;
+
+	if (burst_mode)
+		return 0;
+
+	if (recv_tls_keyupdate(fd) < 0) {
+		printf("FAIL: recv KeyUpdate from server\n");
+		return -1;
+	}
+
+	if (check_ekeyexpired(fd) < 0)
+		return -1;
+
+	return do_tls_rekey(fd, TLS_RX, generation, cipher_type);
+}
+
+static int do_client(void)
+{
+	char *buf = NULL, *echo_buf = NULL;
+	int max_size, rekey_interval;
+	int csk = -1, i;
+	int test_result = -1;
+	int current_gen = 0;
+	int next_rekey_at;
+	ssize_t n;
+
+	max_size = random_size_max > 0 ? random_size_max : send_size;
+	if (max_size < MIN_BUF_SIZE)
+		max_size = MIN_BUF_SIZE;
+	buf = malloc(max_size);
+	if (!burst_mode)
+		echo_buf = malloc(max_size);
+	if (!buf || (!burst_mode && !echo_buf)) {
+		printf("SETUP ERROR: failed to allocate buffers\n");
+		goto out;
+	}
+
+	csk = client_connect_tls();
+	if (csk < 0)
+		goto out;
+
+	if (num_rekeys)
+		printf("TLS %s setup complete. Will perform %d rekey(s).\n",
+		       cipher_name(cipher_type), num_rekeys);
+	else
+		printf("TLS setup complete.\n");
+
+	if (random_size_max > 0)
+		printf("Sending %d messages of random size (1..%d bytes)...\n",
+		       num_iterations, random_size_max);
+	else
+		printf("Sending %d messages of %d bytes...\n",
+		       num_iterations, send_size);
+
+	rekey_interval = num_iterations / (num_rekeys + 1);
+	next_rekey_at = rekey_interval;
+
+	for (i = 1; i <= num_iterations; i++) {
+		int this_size;
+
+		if (random_size_max > 0)
+			this_size = (rand() % random_size_max) + 1;
+		else
+			this_size = send_size;
+
+		/* In burst mode, use a per-iteration fill pattern so the
+		 * receiver can detect any plaintext corruption without a
+		 * round-trip echo.
+		 */
+		if (burst_mode) {
+			memset(buf, i & 0xFF, this_size);
+		} else {
+			int j;
+
+			for (j = 0; j < this_size; j++)
+				buf[j] = rand() & 0xFF;
+		}
+
+		if (send_all(csk, buf, this_size) < 0)
+			goto out;
+		n = this_size;
+
+		if (!burst_mode) {
+			printf("Sent %zd bytes (iteration %d)\n", n, i);
+			if (client_recv_echo(csk, buf, echo_buf, n) < 0)
+				goto out;
+		}
+
+		/* Rekey at intervals. In echo mode this is a full bidirectional
+		 * exchange; in burst mode the client only rotates its TX key
+		 * and sends KeyUpdate - the peer is expected to follow.
+		 */
+		if (num_rekeys && current_gen < num_rekeys &&
+		    i == next_rekey_at) {
+			current_gen++;
+			printf("\n=== Client Rekey gen %d ===\n", current_gen);
+
+			if (client_rekey(csk, current_gen) < 0)
+				goto out;
+
+			next_rekey_at += rekey_interval;
+			printf("=== Client Rekey gen %d Complete ===\n\n",
+			       current_gen);
+		}
+	}
+
+	test_result = 0;
+out:
+	if (num_rekeys)
+		printf("Rekeys completed: %d/%d\n", current_gen, num_rekeys);
+	if (csk >= 0)
+		close(csk);
+	free(buf);
+	free(echo_buf);
+	return test_result;
+}
+
+/* Bind/listen on server_port, accept one client, switch to the TLS ULP
+ * and install initial generation-0 keys (plus zc_rx if requested).
+ * Returns the connected fd on success and writes the listener fd to
+ * *lsk_out so the caller can close it. Returns -1 on error, with all
+ * intermediate fds already closed and *lsk_out left at -1.
+ */
+static int server_accept_tls(int *lsk_out)
+{
+	struct addrinfo hints = {0}, *res, *rp;
+	int lsk = -1, csk, one = 1;
+	char port_str[16];
+	int ret;
+
+	*lsk_out = -1;
+
+	/* AI_PASSIVE gives a wildcard bind address for the chosen family
+	 * (0.0.0.0 / ::). The family is forced by -4/-6; when unspecified,
+	 * bind the first entry that works.
+	 */
+	hints.ai_family = force_family;
+	hints.ai_socktype = SOCK_STREAM;
+	hints.ai_protocol = IPPROTO_TCP;
+	hints.ai_flags = AI_PASSIVE;
+	snprintf(port_str, sizeof(port_str), "%d", server_port);
+
+	ret = getaddrinfo(NULL, port_str, &hints, &res);
+	if (ret) {
+		printf("SETUP ERROR: getaddrinfo(port %d): %s\n", server_port,
+		       gai_strerror(ret));
+		return -1;
+	}
+
+	for (rp = res; rp; rp = rp->ai_next) {
+		lsk = socket(rp->ai_family, rp->ai_socktype, rp->ai_protocol);
+		if (lsk < 0)
+			continue;
+		setsockopt(lsk, SOL_SOCKET, SO_REUSEADDR, &one, sizeof(one));
+		if (bind(lsk, rp->ai_addr, rp->ai_addrlen) == 0)
+			break;
+		close(lsk);
+		lsk = -1;
+	}
+	freeaddrinfo(res);
+
+	if (lsk < 0) {
+		printf("SETUP ERROR: failed to bind port %d: %s\n",
+		       server_port, strerror(errno));
+		return -1;
+	}
+
+	if (listen(lsk, 1) < 0) {
+		printf("SETUP ERROR: listen failed: %s\n", strerror(errno));
+		close(lsk);
+		return -1;
+	}
+
+	printf("Server listening on port %d\n", server_port);
+	printf("Waiting for client connection...\n");
+
+	/* Bound accept() so a client that never connects (a deploy or connect
+	 * failure on the peer) does not block the server forever and leak the
+	 * process past the harness timeout. accept() honours SO_RCVTIMEO on the
+	 * listening socket; the client connects right after wait_port_listen(),
+	 * so 30s is generous.
+	 */
+	{
+		struct timeval tv = { .tv_sec = 30, .tv_usec = 0 };
+
+		setsockopt(lsk, SOL_SOCKET, SO_RCVTIMEO, &tv, sizeof(tv));
+	}
+
+	csk = accept(lsk, (struct sockaddr *)NULL, (socklen_t *)NULL);
+	if (csk < 0) {
+		if (errno == EAGAIN || errno == EWOULDBLOCK)
+			printf("SETUP ERROR: accept timed out; client never connected\n");
+		else
+			printf("SETUP ERROR: accept failed: %s\n", strerror(errno));
+		close(lsk);
+		return -1;
+	}
+	printf("Client connected!\n");
+
+	if (setup_tls_ulp(csk) < 0)
+		goto err;
+
+	if (do_tls_rekey(csk, TLS_TX, 0, cipher_type) < 0 ||
+	    do_tls_rekey(csk, TLS_RX, 0, cipher_type) < 0)
+		goto err;
+
+	if (zc_rx && set_zc_rx(csk) < 0)
+		goto err;
+
+	set_io_timeouts(csk);
+	if (!burst_mode)
+		configure_echo_socket(csk, random_size_max > 0 ?
+					    random_size_max : send_size);
+
+	*lsk_out = lsk;
+	return csk;
+err:
+	close(csk);
+	close(lsk);
+	return -1;
+}
+
+/* Server side of a rekey: confirm recv() reports EKEYEXPIRED, then rotate RX.
+ * In echo mode also send a KeyUpdate back and rotate TX.
+ */
+static int server_rekey(int fd, int generation)
+{
+	if (check_ekeyexpired(fd) < 0)
+		return -1;
+
+	if (do_tls_rekey(fd, TLS_RX, generation, cipher_type) < 0)
+		return -1;
+
+	if (burst_mode)
+		return 0;
+
+	if (send_tls_key_update(fd) < 0) {
+		printf("FAIL: send KeyUpdate\n");
+		return -1;
+	}
+
+	return do_tls_rekey(fd, TLS_TX, generation, cipher_type);
+}
+
+/* Burst mode: verify one reassembled iteration of send_size plaintext bytes,
+ * each filled with (send_iter & 0xff). Catches decrypt-succeeded-but-
+ * plaintext-corrupt bugs that AEAD counters alone would miss.
+ */
+static int server_verify_burst(const char *buf, int send_iter)
+{
+	unsigned char expect = send_iter & 0xFF;
+	int j;
+
+	for (j = 0; j < send_size; j++) {
+		if ((unsigned char)buf[j] != expect) {
+			printf("FAIL: data mismatch iter %d off %d: exp 0x%02x got 0x%02x\n",
+			       send_iter, j, expect, (unsigned char)buf[j]);
+			return -1;
+		}
+	}
+	return 0;
+}
+
+static int do_server(void)
+{
+	int lsk = -1, csk = -1;
+	ssize_t n, total = 0;
+	int test_result = -1;
+	int current_gen = 0;
+	int recv_count = 0;
+	int send_iter = 1;
+	char *buf = NULL;
+	int record_type = 0;
+	int filled = 0;
+	int buf_size;
+
+	buf_size = send_size;
+	if (buf_size < MIN_BUF_SIZE)
+		buf_size = MIN_BUF_SIZE;
+	buf = malloc(buf_size);
+	if (!buf) {
+		printf("SETUP ERROR: failed to allocate buffer\n");
+		goto out;
+	}
+
+	csk = server_accept_tls(&lsk);
+	if (csk < 0)
+		goto out;
+
+	printf("TLS %s setup complete. Receiving...\n",
+	       cipher_name(cipher_type));
+
+	/* Burst mode: reassemble one iteration (send_size bytes) in userspace
+	 * from however much each recv returns, rather than demanding a full
+	 * send_size batch in a single MSG_WAITALL call. A blocking MSG_WAITALL
+	 * of send_size deadlocks when the client's last record of an iteration
+	 * is still partly in flight as its socket buffer fills: the server
+	 * waits for bytes the client cannot send until the server reads, and
+	 * the server will not read until it has the whole batch. Draining
+	 * whatever is available keeps the receive window open and breaks that
+	 * cycle. kTLS never splits a record and returns data and control
+	 * (KeyUpdate) records separately, and each iteration is a whole number
+	 * of records, so capping each recv at the iteration boundary keeps the
+	 * reassembly aligned and delivers a KeyUpdate on its own.
+	 */
+
+	/* Main receive loop */
+	while (1) {
+		char *dst = burst_mode ? buf + filled : buf;
+		size_t want = burst_mode ? (size_t)(send_size - filled)
+					 : (size_t)buf_size;
+
+		n = recv_tls_message(csk, dst, want, &record_type, 0);
+		if (n == 0) {
+			/* A clean close on an iteration boundary is success;
+			 * one with a partial iteration still buffered means the
+			 * peer dropped the tail - the truncated-data case this
+			 * test exists to catch, so fail loudly.
+			 */
+			if (burst_mode && filled) {
+				printf("FAIL: closed mid-iteration (%d/%d bytes buffered)\n",
+				       filled, send_size);
+				goto out;
+			}
+			printf("Connection closed by client\n");
+			break;
+		}
+		if (n < 0) {
+			printf("FAIL: recv failed: %s\n", strerror(errno));
+			goto out;
+		}
+
+		/* Handle KeyUpdate. In echo mode the server mirrors the
+		 * rekey back to the peer; in burst mode it only rotates its
+		 * RX key and keeps draining. A KeyUpdate always lands on a
+		 * send_size boundary, so no partial iteration must be buffered
+		 * when one arrives.
+		 */
+		if (record_type == TLS_RECORD_TYPE_HANDSHAKE) {
+			/* Check for a partial iteration before validating the
+			 * KeyUpdate, so a mid-iteration arrival fails with this
+			 * message rather than a misleading KeyUpdate-OK line.
+			 */
+			if (burst_mode && filled) {
+				printf("FAIL: KeyUpdate mid-iteration (%d/%d bytes buffered)\n",
+				       filled, send_size);
+				goto out;
+			}
+			if (check_keyupdate(dst, n, record_type) < 0)
+				goto out;
+			current_gen++;
+			printf("\n=== Server Rekey gen %d ===\n", current_gen);
+
+			if (server_rekey(csk, current_gen) < 0)
+				goto out;
+
+			printf("=== Server Rekey gen %d Complete ===\n\n",
+			       current_gen);
+			continue;
+		}
+
+		total += n;
+
+		if (burst_mode) {
+			filled += n;
+			if (filled < send_size)
+				continue;
+			if (server_verify_burst(buf, send_iter) < 0)
+				goto out;
+			recv_count++;
+			send_iter++;
+			filled = 0;
+			continue;
+		}
+
+		recv_count++;
+		printf("Received %zd bytes (total: %zd, count: %d)\n",
+		       n, total, recv_count);
+
+		if (send_all(csk, buf, n) < 0)
+			goto out;
+		printf("Echoed %zd bytes back to client\n", n);
+	}
+
+	test_result = 0;
+out:
+	printf("Connection closed. Total received: %zd bytes\n", total);
+	if (num_rekeys)
+		printf("Rekeys completed: %d\n", current_gen);
+
+	if (csk >= 0)
+		close(csk);
+	if (lsk >= 0)
+		close(lsk);
+	free(buf);
+	return test_result;
+}
+
+static int parse_int_arg(const char *arg, int min, int max,
+			 const char *name, int *out)
+{
+	char *endp;
+	long val;
+
+	errno = 0;
+	val = strtol(arg, &endp, 10);
+	if (errno || endp == arg || *endp != '\0' || val < min || val > max) {
+		if (max == INT_MAX)
+			printf("ERROR: Invalid %s '%s'. Must be >= %d.\n",
+			       name, arg, min);
+		else
+			printf("ERROR: Invalid %s '%s'. Must be %d..%d.\n",
+			       name, arg, min, max);
+		return -1;
+	}
+	*out = (int)val;
+	return 0;
+}
+
+static int parse_cipher_option(const char *arg)
+{
+	if (strcmp(arg, "128") == 0) {
+		cipher_type = TLS_CIPHER_AES_GCM_128;
+		return 0;
+	} else if (strcmp(arg, "256") == 0) {
+		cipher_type = TLS_CIPHER_AES_GCM_256;
+		return 0;
+	}
+	printf("ERROR: Invalid cipher '%s'. Must be 128 or 256.\n", arg);
+	return -1;
+}
+
+static int parse_version_option(const char *arg)
+{
+	if (strcmp(arg, "1.2") == 0) {
+		tls_version = TLS_1_2_VERSION;
+		return 0;
+	} else if (strcmp(arg, "1.3") == 0) {
+		tls_version = TLS_1_3_VERSION;
+		return 0;
+	}
+	printf("ERROR: Invalid TLS version '%s'. Must be 1.2 or 1.3.\n", arg);
+	return -1;
+}
+
+static void print_usage(const char *prog)
+{
+	printf("TLS Hardware Offload Two-Node Test\n\n");
+	printf("Usage:\n");
+	printf("  %s server [OPTIONS]\n", prog);
+	printf("  %s client -s <ip> [OPTIONS]\n", prog);
+	printf("\nOptions:\n");
+	printf("  -s <ip>       Server IP address, v4 or v6 (client, required)\n");
+	printf("  -p <port>     Server port (default: 4433)\n");
+	printf("  -4            Force IPv4 (default: auto/either)\n");
+	printf("  -6            Force IPv6 (default: auto/either)\n");
+	printf("  -b <size>     Send buffer size in bytes (default: 16384)\n");
+	printf("  -r <max>      Use random send buffer sizes (1..<max>)\n");
+	printf("  -v <version>  TLS version: 1.2 or 1.3 (default: 1.3)\n");
+	printf("  -c <cipher>   Cipher: 128 or 256 (default: 128)\n");
+	printf("  -n <N>        Number of send/echo iterations (default: 100)\n");
+	printf("  -k <N>        Perform N rekeys (client only, TLS 1.3; N < iterations)\n");
+	printf("  -B            Burst mode: client sends continuously without echo;\n");
+	printf("                server drains and handles KeyUpdate without responding.\n");
+	printf("  -Z            Set TLS_RX_EXPECT_NO_PAD on the server: TLS 1.3\n");
+	printf("                opt-in to the zero-copy RX fast path. Not needed\n");
+	printf("                for TLS 1.2 (always eligible). Server only.\n");
+	printf("  -h            Show this help message\n");
+	printf("\nExample:\n");
+	printf("  Node A: %s server\n", prog);
+	printf("  Node B: %s client -s 192.168.20.2\n", prog);
+	printf("\nRekey Example (3 rekeys, TLS 1.3 only):\n");
+	printf("  Node A: %s server\n", prog);
+	printf("  Node B: %s client -s 192.168.20.2 -k 3\n", prog);
+	printf("\nBurst Mode Example (client stresses TX rekey under load):\n");
+	printf("  Node A: %s server -B\n", prog);
+	printf("  Node B: %s client -s 192.168.20.2 -B -k 3\n", prog);
+	printf("\nIPv6 Example:\n");
+	printf("  Node A: %s server -6\n", prog);
+	printf("  Node B: %s client -6 -s fd00::2\n", prog);
+}
+
+int main(int argc, char *argv[])
+{
+	int send_size_set = 0;
+	int is_server;
+	int opt;
+
+	/* When the peer aborts a TLS connection (e.g. tls_err_abort() on a
+	 * failed decrypt), a send() here would raise SIGPIPE and kill us by
+	 * signal, so the harness sees only a bare non-zero exit with no
+	 * "FAIL:" line. Ignore it and let send()/sendmsg() return EPIPE, which
+	 * send_all()/send_tls_key_update() report.
+	 */
+	signal(SIGPIPE, SIG_IGN);
+
+	if (argc < 2 ||
+	    (strcmp(argv[1], "server") && strcmp(argv[1], "client"))) {
+		print_usage(argv[0]);
+		return 1;
+	}
+	is_server = !strcmp(argv[1], "server");
+
+	optind = 2; /* skip subcommand */
+	while ((opt = getopt(argc, argv, "s:p:b:r:c:v:k:n:BZ46h")) != -1) {
+		switch (opt) {
+		case 's':
+			server_ip = optarg;
+			break;
+		case '4':
+			if (force_family == AF_INET6) {
+				printf("ERROR: -4 and -6 are mutually exclusive\n");
+				return 1;
+			}
+			force_family = AF_INET;
+			break;
+		case '6':
+			if (force_family == AF_INET) {
+				printf("ERROR: -4 and -6 are mutually exclusive\n");
+				return 1;
+			}
+			force_family = AF_INET6;
+			break;
+		case 'B':
+			burst_mode = 1;
+			break;
+		case 'Z':
+			zc_rx = 1;
+			break;
+		case 'p':
+			if (parse_int_arg(optarg, 1, 65535, "port",
+					  &server_port) < 0)
+				return 1;
+			break;
+		case 'b':
+			if (parse_int_arg(optarg, 1, INT_MAX, "buffer size",
+					  &send_size) < 0)
+				return 1;
+			send_size_set = 1;
+			break;
+		case 'r':
+			if (parse_int_arg(optarg, 1, INT_MAX, "random size",
+					  &random_size_max) < 0)
+				return 1;
+			break;
+		case 'c':
+			if (parse_cipher_option(optarg) < 0)
+				return 1;
+			break;
+		case 'v':
+			if (parse_version_option(optarg) < 0)
+				return 1;
+			break;
+		case 'k':
+			if (parse_int_arg(optarg, 1, 255, "rekey count",
+					  &num_rekeys) < 0)
+				return 1;
+			break;
+		case 'n':
+			if (parse_int_arg(optarg, 1, INT_MAX, "iteration count",
+					  &num_iterations) < 0)
+				return 1;
+			break;
+		case 'h':
+			print_usage(argv[0]);
+			return 0;
+		default:
+			print_usage(argv[0]);
+			return 1;
+		}
+	}
+
+	if (send_size_set && random_size_max > 0) {
+		printf("ERROR: -b and -r are mutually exclusive\n");
+		return 1;
+	}
+
+	if (zc_rx && tls_version != TLS_1_3_VERSION) {
+		printf("ERROR: -Z (TLS_RX_EXPECT_NO_PAD) requires TLS 1.3\n");
+		return 1;
+	}
+
+	if (burst_mode && random_size_max > 0) {
+		printf("ERROR: -B and -r are mutually exclusive\n");
+		return 1;
+	}
+
+	if (burst_mode && send_size < MIN_BUF_SIZE) {
+		printf("ERROR: -b must be >= %d in burst mode (-B)\n",
+		       MIN_BUF_SIZE);
+		return 1;
+	}
+
+	if (is_server) {
+		if (server_ip) {
+			printf("warning: -s is ignored in server mode\n");
+			server_ip = NULL;
+		}
+		if (random_size_max > 0) {
+			printf("warning: -r is ignored in server mode\n");
+			random_size_max = 0;
+		}
+		if (num_rekeys) {
+			printf("warning: -k is ignored in server mode\n");
+			num_rekeys = 0;
+		}
+	} else {
+		if (!server_ip) {
+			printf("ERROR: Client requires -s <ip> option\n");
+			return 1;
+		}
+		if (tls_version == TLS_1_2_VERSION && num_rekeys) {
+			printf("ERROR: TLS 1.2 does not support rekey\n");
+			return 1;
+		}
+		if (num_rekeys >= num_iterations) {
+			printf("ERROR: num_rekeys (%d) must be < num_iterations (%d)\n",
+			       num_rekeys, num_iterations);
+			return 1;
+		}
+		if (zc_rx) {
+			printf("ERROR: -Z applies to the server (receiver) only\n");
+			return 1;
+		}
+	}
+
+	printf("TLS Version: %s\n", version_name(tls_version));
+	printf("Cipher: %s\n", cipher_name(cipher_type));
+	printf("Address family: %s\n",
+	       force_family == AF_INET ? "IPv4" :
+	       force_family == AF_INET6 ? "IPv6" : "auto");
+	if (random_size_max > 0)
+		printf("Buffer size: random (1..%d)\n", random_size_max);
+	else
+		printf("Buffer size: %d\n", send_size);
+
+	if (num_rekeys)
+		printf("Rekey testing ENABLED: %d rekey(s)\n", num_rekeys);
+	if (burst_mode)
+		printf("Burst mode ENABLED\n");
+	if (zc_rx)
+		printf("TLS_RX_EXPECT_NO_PAD ENABLED\n");
+
+	srand(time(NULL));
+
+	if (is_server)
+		return do_server() ? 1 : 0;
+
+	return do_client() ? 1 : 0;
+}
diff --git a/tools/testing/selftests/drivers/net/hw/tls_hw_offload.py b/tools/testing/selftests/drivers/net/hw/tls_hw_offload.py
new file mode 100755
index 000000000000..99ae5b3b8996
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/hw/tls_hw_offload.py
@@ -0,0 +1,446 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+
+"""Test kTLS hardware offload using a C helper binary."""
+
+from collections import defaultdict
+
+from lib.py import ksft_run, ksft_exit, ksft_pr, KsftSkipEx
+from lib.py import ksft_ge, ksft_eq
+from lib.py import ksft_variants, KsftNamedVariant
+from lib.py import NetDrvEpEnv
+from lib.py import cmd, bkg, wait_port_listen, rand_port
+from lib.py import CmdExitFailure
+
+# Burst variants push hundreds of MB and perform many rekeys, so they
+# need far longer than the default cmd() timeout.
+BURST_TIMEOUT_S = 180
+REKEY_TIMEOUT_S = 90
+
+# Reading /proc/net/tls_stat is trivial locally, but on the remote it runs
+# over ssh, where connection setup can occasionally spike past the short
+# default cmd() timeout. Give these tiny reads plenty of headroom so a slow
+# ssh round-trip doesn't fail an otherwise-good variant.
+STATS_TIMEOUT_S = 30
+
+# Per-packet HW crypto counters exposed via `ethtool -S` on the DUT NIC,
+# keyed by the `ethtool -i` driver name. TlsTxDevice/TlsRxDevice in
+# /proc/net/tls_stat only prove tls_dev_add() accepted the offload; these
+# increment once per packet the NIC actually encrypted/decrypted (mlx5 counts
+# gso_segs, not records), so they prove the HW crypto path was exercised.
+# Names are driver-specific, so the
+# check only runs on drivers listed here and is skipped (not failed) on
+# others, keeping the test portable across NICs.
+HW_CRYPTO_COUNTERS = {
+    'mlx5_core': {'Tx': 'tx_tls_encrypted_packets',
+                  'Rx': 'rx_tls_decrypted_packets'},
+}
+
+
+def check_tls_support(cfg):
+    """Skip the suite unless both hosts have kTLS and the DUT HW offload."""
+    # The tls module is autoloaded lazily on the first TCP_ULP="tls"
+    # setsockopt, so /proc/net/tls_stat (created from the module's pernet
+    # init) may not exist yet on a freshly booted host. Load the module
+    # explicitly before probing for it.
+    try:
+        cmd("modprobe tls")
+        cmd("modprobe tls", host=cfg.remote)
+        cmd("test -f /proc/net/tls_stat")
+        cmd("test -f /proc/net/tls_stat", host=cfg.remote)
+    except CmdExitFailure as e:
+        raise KsftSkipEx(f"kTLS not supported: {e}") from e
+
+    try:
+        features = cmd(f"ethtool -k {cfg.ifname}").stdout
+        if 'tls-hw-tx-offload: on' not in features:
+            raise KsftSkipEx("Device does not support TLS HW TX offload")
+        if 'tls-hw-rx-offload: on' not in features:
+            raise KsftSkipEx("Device does not support TLS HW RX offload")
+    except CmdExitFailure as e:
+        raise KsftSkipEx(f"Cannot determine TLS HW offload support: {e}") from e
+
+
+def read_tls_stats(host=None):
+    """Snapshot the per-netns TLS MIB from /proc/net/tls_stat as a dict."""
+    # /proc/net/tls_stat exposes the per-netns TLS MIB (TLS_INC_STATS on
+    # sock_net(sk)). The test runs on a real NIC in the host namespace, so
+    # these counters are shared with anything else doing kTLS there. The
+    # strict before/after delta checks (exact rekey-outcome sums, zero error
+    # counters) assume no other kTLS activity in this namespace during a
+    # variant's window; concurrent kTLS users would perturb the deltas and
+    # cause spurious failures. Don't run other kTLS workloads alongside this
+    # test.
+    stats = defaultdict(int)
+    output = cmd("cat /proc/net/tls_stat", host=host, timeout=STATS_TIMEOUT_S)
+    for line in output.stdout.strip().split('\n'):
+        parts = line.split()
+        if len(parts) == 2:
+            stats[parts[0]] = int(parts[1])
+    return stats
+
+
+def nic_driver(cfg):
+    """DUT NIC driver name from `ethtool -i`, or None if undetermined."""
+    try:
+        output = cmd(f"ethtool -i {cfg.ifname}").stdout
+    except CmdExitFailure:
+        return None
+    for line in output.splitlines():
+        if line.startswith('driver:'):
+            return line.split(':', 1)[1].strip()
+    return None
+
+
+def read_nic_stats(cfg):
+    """Snapshot the DUT NIC's `ethtool -S` counters as a dict."""
+    # Driver per-record TLS counters from `ethtool -S` on the DUT NIC. Same
+    # before/after-delta caveat as read_tls_stats(): these are device-wide,
+    # so concurrent kTLS traffic on this NIC would perturb the deltas.
+    stats = defaultdict(int)
+    output = cmd(f"ethtool -S {cfg.ifname}").stdout
+    for line in output.strip().split('\n'):
+        key, sep, val = line.partition(':')
+        if sep and val.strip().isdigit():
+            stats[key.strip()] = int(val.strip())
+    return stats
+
+
+def stat_diff(before, after, key):
+    """Return the delta of counter `key` between two stat snapshots."""
+    return after[key] - before[key]
+
+
+def check_hw_crypto(cfg, before, after, with_tx, with_rx):
+    """DUT-side ethtool -S check: the NIC actually crypto'd records in HW.
+
+    Complements the TlsTxDevice/TlsRxDevice MIBs, which only confirm the
+    offload was installed, not that any record was processed in hardware.
+    Driver-specific; skipped (without failing) on drivers not in
+    HW_CRYPTO_COUNTERS so the test stays portable.
+    """
+    counters = HW_CRYPTO_COUNTERS.get(cfg.nic_driver)
+    if not counters:
+        ksft_pr(f"NOTE: DUT driver '{cfg.nic_driver}' has no known per-record "
+                f"HW crypto counters, skipping ethtool -S check")
+        return
+
+    for direction, active in (('Tx', with_tx), ('Rx', with_rx)):
+        if not active:
+            continue
+        key = counters[direction]
+        if key not in after:
+            ksft_pr(f"NOTE: DUT {direction}: counter '{key}' not exposed by "
+                    f"{cfg.nic_driver}, skipping")
+            continue
+        got = stat_diff(before, after, key)
+        ksft_ge(got, 1,
+                comment=f"DUT {direction}: NIC reported no HW crypto "
+                        f"({key}={got})")
+
+
+def check_path(before, after, direction, role, require_hw):
+    """On the DUT, require HW offload; on the remote, HW or SW is fine."""
+    dev = stat_diff(before, after, f'Tls{direction}Device')
+    sw = stat_diff(before, after, f'Tls{direction}Sw')
+    if require_hw:
+        ksft_ge(dev, 1,
+                comment=f"{role} {direction}: HW offload not engaged "
+                        f"(Device={dev}, Sw={sw})")
+    else:
+        ksft_ge(dev + sw, 1,
+                comment=f"{role} {direction}: no TLS activity "
+                        f"(Device={dev}, Sw={sw})")
+
+
+def verify_tls_counters(stats_before, stats_after, expected_rekeys,
+                        tls_role, is_dut, burst=False, allow_fallback=False):
+    """Verify TLS counters on one side of the connection.
+
+    tls_role: 'client' or 'server' (TLS role this side played).
+    is_dut: True for the local DUT; requires HW offload counters.
+    burst: burst mode - only the TLS client rotates its TX key; the TLS
+           server only follows with an RX rotation on KeyUpdate receipt.
+    allow_fallback: tolerate rekeys completing in SW (TlsRx/TxRekeyFallback).
+           Default False: a rekey on an up, offload-capable device must stay
+           in HW, so any fallback is a regression. Set True only where SW
+           fallback is expected (e.g. a mid-connection link-flap variant, or
+           the peer, whose offload state is not under test).
+    """
+    role = 'DUT' if is_dut else 'Peer'
+
+    def diff(key):
+        return stat_diff(stats_before, stats_after, key)
+
+    # In burst mode the TLS client only TXs and the TLS server only RXs.
+    # In echo mode both sides drive both directions.
+    with_tx = not burst or tls_role == 'client'
+    with_rx = not burst or tls_role != 'client'
+
+    if with_tx:
+        check_path(stats_before, stats_after, 'Tx', role, require_hw=is_dut)
+    if with_rx:
+        check_path(stats_before, stats_after, 'Rx', role, require_hw=is_dut)
+
+    if expected_rekeys > 0:
+        if with_tx:
+            # Each KeyUpdate yields exactly one terminal outcome, so
+            #   TlsTxRekeyOk + TlsTxRekeyAborted + TlsTxRekeyFallback == N.
+            # At most one rekey can be PENDING at socket close (single
+            # TLS_TX_REKEY_PENDING bit), so at most one lands in
+            # TlsTxRekeyAborted. TlsTxRekeyFallback is a legitimate, graceful
+            # degradation: the device did not (re)install the HW context for
+            # that rekey (device gone, dev_add rejected, or a transient
+            # crypto/alloc error) so it completed in SW while the kernel
+            # returned success. It is recoverable - the next KeyUpdate
+            # re-attempts HW offload (tls_device_start_rekey() clears
+            # TLS_TX_REKEY_FAILED). It is folded into the outcome sum below; on
+            # the DUT it must be 0 (allow_fallback=False), on the peer it is
+            # only NOTEd. A genuine rekey bug still surfaces as TlsTxRekeyError.
+            ksft_ge(1, diff('TlsTxRekeyAborted'),
+                    comment=f"{role} Tx: TlsTxRekeyAborted expected <= 1")
+            ksft_eq(diff('TlsTxRekeyOk') + diff('TlsTxRekeyAborted') +
+                    diff('TlsTxRekeyFallback'), expected_rekeys,
+                    comment=f"{role} Tx: rekey outcomes must sum to "
+                            f"{expected_rekeys}")
+            fallback = diff('TlsTxRekeyFallback')
+            if allow_fallback:
+                if fallback:
+                    ksft_pr(f"NOTE: {role} Tx: {fallback} rekey(s) completed "
+                            f"in SW (TlsTxRekeyFallback); HW not re-installed")
+            else:
+                ksft_eq(fallback, 0,
+                        comment=f"{role} Tx: TlsTxRekeyFallback expected 0 "
+                                f"(rekey must stay in HW offload)")
+            ksft_eq(diff('TlsTxRekeyError'), 0,
+                    comment=f"{role} Tx: TlsTxRekeyError expected 0")
+            ksft_eq(diff('TlsCurrTxRekey'), 0,
+                    comment=f"{role} Tx: TlsCurrTxRekey expected 0")
+        if with_rx:
+            # As on TX, each received KeyUpdate yields one terminal outcome:
+            #   TlsRxRekeyOk + TlsRxRekeyAborted + TlsRxRekeyFallback == N.
+            # At most one rekey can be deferred (single dev_add_pending) at
+            # socket close, landing in TlsRxRekeyAborted. TlsRxRekeyFallback
+            # is a recoverable, graceful degradation (dev_add failed or the
+            # device was gone, so RX temporarily dropped to SW; the next
+            # KeyUpdate re-adds the HW context and clears TLS_RX_DEV_DEGRADED).
+            # It is folded into the outcome sum below; on the DUT it must be 0
+            # (allow_fallback=False), on the peer it is only NOTEd. A genuine
+            # rekey bug still surfaces as TlsRxRekeyError.
+            ksft_ge(1, diff('TlsRxRekeyAborted'),
+                    comment=f"{role} Rx: TlsRxRekeyAborted expected <= 1")
+            ksft_eq(diff('TlsRxRekeyOk') + diff('TlsRxRekeyAborted') +
+                    diff('TlsRxRekeyFallback'), expected_rekeys,
+                    comment=f"{role} Rx: rekey outcomes must sum to "
+                            f"{expected_rekeys}")
+            ksft_eq(diff('TlsRxRekeyReceived'), expected_rekeys,
+                    comment=f"{role} Rx: TlsRxRekeyReceived expected "
+                            f"{expected_rekeys}")
+            fallback = diff('TlsRxRekeyFallback')
+            if allow_fallback:
+                if fallback:
+                    ksft_pr(f"NOTE: {role} Rx: {fallback} rekey(s) completed "
+                            f"in SW (TlsRxRekeyFallback); HW not re-installed")
+            else:
+                ksft_eq(fallback, 0,
+                        comment=f"{role} Rx: TlsRxRekeyFallback expected 0 "
+                                f"(rekey must stay in HW offload)")
+            ksft_eq(diff('TlsRxRekeyError'), 0,
+                    comment=f"{role} Rx: TlsRxRekeyError expected 0")
+            ksft_eq(diff('TlsCurrRxRekey'), 0,
+                    comment=f"{role} Rx: TlsCurrRxRekey expected 0")
+
+    ksft_eq(diff('TlsDecryptError'), 0,
+            comment=f"{role}: TlsDecryptError expected 0")
+
+
+def run_tls_test(cfg, cipher="128", tls_version="1.3", rekey=0,
+                 buffer_size=None, random_max=None, burst=False, zc=False,
+                 dut_role="client", num_iterations=None, ipver="4"):
+    """Run the TLS offload test.
+
+    dut_role: 'client' (default) - DUT runs the TLS client, remote the server.
+              'server' - swap: DUT listens, remote connects. Used for burst_rx
+              so the DUT's RX path is the one under rekey pressure.
+
+    ipver: '4' or '6' - IP version to run over. The C helper is forced to the
+           matching family with -4/-6 and connects to the peer's v4/v6 address.
+           Variants requesting '6' skip cleanly when the environment lacks IPv6
+           connectivity (require_ipver()).
+
+    The DUT (local) is the kernel under test; the remote is just a traffic
+    source/sink and may run any kernel without HW offload. Both sides run
+    kTLS because TLS is pairwise, but verify_tls_counters() requires HW
+    offload only on the DUT (is_dut=True); the peer may use SW kTLS.
+
+    Rekey/burst variants additionally require the peer to support TLS 1.3
+    KeyUpdate (as the RX or TX side of the rotation). SW KeyUpdate and its
+    MIB counters landed together in v6.14; an older peer cannot follow the
+    rotation, so those variants are skipped rather than failed when the peer
+    lacks the rekey counters (see the probe below).
+    """
+    cfg.require_ipver(ipver)
+
+    port = rand_port()
+    send_size = random_max or buffer_size
+
+    if dut_role == "client":
+        server_bin, server_host = cfg.bin_remote, cfg.remote
+        client_bin, client_host = cfg.bin_local, None
+        client_target = cfg.remote_addr_v[ipver]
+    else:
+        server_bin, server_host = cfg.bin_local, None
+        client_bin, client_host = cfg.bin_remote, cfg.remote
+        client_target = cfg.addr_v[ipver]
+
+    server_parts = [f"{server_bin} server -p {port} -c {cipher}",
+                    f"-v {tls_version}", f"-{ipver}"]
+    if burst:
+        server_parts.append("-B")
+    if zc:
+        server_parts.append("-Z")
+    if send_size:
+        server_parts.append(f"-b {send_size}")
+    server_cmd = " ".join(server_parts)
+
+    client_parts = [f"{client_bin} client -s {client_target}",
+                    f"-p {port} -c {cipher} -v {tls_version} -{ipver}"]
+    if rekey:
+        client_parts.append(f"-k {rekey}")
+    if burst:
+        client_parts.append("-B")
+    if num_iterations:
+        client_parts.append(f"-n {num_iterations}")
+    if random_max:
+        client_parts.append(f"-r {random_max}")
+    elif buffer_size:
+        client_parts.append(f"-b {buffer_size}")
+    client_cmd = " ".join(client_parts)
+
+    if burst:
+        cmd_timeout = BURST_TIMEOUT_S
+    elif rekey:
+        cmd_timeout = REKEY_TIMEOUT_S
+    else:
+        cmd_timeout = 20
+
+    stats_before_local = read_tls_stats()
+    stats_before_remote = read_tls_stats(host=cfg.remote)
+    nic_before = read_nic_stats(cfg)
+
+    # /proc/net/tls_stat lists every MIB the running kernel knows (0 or not),
+    # so a missing name means the peer predates that counter. The base rekey
+    # counters (TlsRxRekeyReceived, Tls{Rx,Tx}RekeyOk, Tls{Rx,Tx}RekeyError)
+    # shipped with SW KeyUpdate in v6.14; a peer without them cannot follow a
+    # KeyUpdate, so the rekey/burst variants can't run against it. Skip cleanly
+    # here rather than letting the peer-side rekey-sum / RxRekeyReceived checks
+    # report a confusing "expected N, got 0" later. TlsRxRekeyReceived is a
+    # reliable probe: the peer must bump it to have processed the rotation at all.
+    #
+    # Only a base v6.14 counter is probed. The newer HW-path MIBs (Aborted,
+    # Fallback, CurrRekey) are structurally 0 on a SW-only peer and defaultdict
+    # returns 0 for absent names, so the peer-side checks hold either way.
+    if rekey and 'TlsRxRekeyReceived' not in stats_before_remote:
+        raise KsftSkipEx("Peer kernel lacks TLS 1.3 KeyUpdate support "
+                         "(no rekey MIB counters); required for rekey tests")
+
+    with bkg(server_cmd, host=server_host, exit_wait=True):
+        wait_port_listen(port, host=server_host)
+        # Start the client in the background so we keep a handle to it. A
+        # foreground cmd() raises TimeoutExpired from inside its constructor
+        # if the client hangs, and since the child is not killed on timeout
+        # it would be left running with no handle to reap it. A leaked
+        # client keeps bumping the per-netns TLS counters (TlsTxRekeyAborted,
+        # TlsDecryptError, ...) and would corrupt the before/after
+        # measurement window of a later variant. The finally clause reaps it
+        # within this variant's window instead.
+        client = cmd(client_cmd, host=client_host, background=True)
+        try:
+            client.process(terminate=False, fail=True, timeout=cmd_timeout)
+        finally:
+            if client.proc.poll() is None:
+                client.process(terminate=True, fail=False, timeout=5)
+
+    stats_after_local = read_tls_stats()
+    stats_after_remote = read_tls_stats(host=cfg.remote)
+    nic_after = read_nic_stats(cfg)
+
+    peer_tls_role = 'server' if dut_role == 'client' else 'client'
+
+    # Which directions the DUT drives (mirrors verify_tls_counters()): in
+    # burst mode the TLS client only TXs and the server only RXs; echo mode
+    # drives both.
+    dut_with_tx = not burst or dut_role == 'client'
+    dut_with_rx = not burst or dut_role != 'client'
+
+    verify_tls_counters(stats_before_local, stats_after_local,
+                        rekey, dut_role, is_dut=True, burst=burst)
+    check_hw_crypto(cfg, nic_before, nic_after, dut_with_tx, dut_with_rx)
+    verify_tls_counters(stats_before_remote, stats_after_remote,
+                        rekey, peer_tls_role, is_dut=False, burst=burst,
+                        allow_fallback=True)
+
+
+# The cipher/version matrix runs over IPv4; the socket setup is the only
+# IP-version-specific code path, so a single representative variant over
+# IPv6 is enough to cover it (it skips cleanly without v6 connectivity).
+# The rekey and burst suites below likewise stay on IPv4 to bound runtime.
+@ksft_variants([
+    KsftNamedVariant("tls13_aes128", "128", "1.3", "4"),
+    KsftNamedVariant("tls13_aes256", "256", "1.3", "4"),
+    KsftNamedVariant("tls12_aes128", "128", "1.2", "4"),
+    KsftNamedVariant("tls12_aes256", "256", "1.2", "4"),
+    KsftNamedVariant("tls13_aes128_ip6", "128", "1.3", "6"),
+])
+def test_tls_offload(cfg, cipher, tls_version, ipver):
+    """Cipher/version matrix over the HW offload data path, no rekey."""
+    run_tls_test(cfg, cipher=cipher, tls_version=tls_version, ipver=ipver)
+
+
+@ksft_variants([
+    KsftNamedVariant("single", 1),
+    KsftNamedVariant("multiple", 99),
+    KsftNamedVariant("small_buf", 30, 512),
+    KsftNamedVariant("large_buf", 10, 2097152),
+    KsftNamedVariant("random_buf", 20, None, 8192),
+])
+def test_tls_offload_rekey(cfg, rekey, buffer_size=None, random_max=None):
+    """Echo-mode TLS 1.3 KeyUpdate rekeys across a range of buffer sizes."""
+    run_tls_test(cfg, cipher="128", tls_version="1.3", rekey=rekey,
+                 buffer_size=buffer_size, random_max=random_max)
+
+
+# Columns:                                          dut_role  zc     interval rekeys buffer_size
+@ksft_variants([
+    KsftNamedVariant("burst_tx_rekey_every_1",        "client", False, 1,       50,    65536),
+    KsftNamedVariant("burst_tx_rekey_every_1000",     "client", False, 1000,    3,     65536),
+    KsftNamedVariant("burst_rx_rekey_every_10",       "server", False, 10,      20,    65536),
+    KsftNamedVariant("burst_rx_rekey_every_10000",    "server", False, 10000,   1,     32768),
+    KsftNamedVariant("burst_rx_zc_rekey_every_100",   "server", True,  100,     10,    65536),
+    KsftNamedVariant("burst_rx_zc_rekey_every_20000", "server", True,  20000,   1,     16384),
+])
+def test_tls_offload_burst(cfg, dut_role, zc, interval, rekeys, buffer_size):
+    """High-volume one-directional traffic with frequent rekeys."""
+    run_tls_test(cfg, cipher="128", tls_version="1.3", rekey=rekeys,
+                 buffer_size=buffer_size, burst=True, zc=zc, dut_role=dut_role,
+                 num_iterations=interval * (rekeys + 1))
+
+
+def main() -> None:
+    """Set up the DUT/peer environment and run the offload test suites."""
+    with NetDrvEpEnv(__file__, nsim_test=False) as cfg:
+        cfg.bin_local = cfg.test_dir / "tls_hw_offload"
+        if not cfg.bin_local.exists():
+            raise KsftSkipEx(f"tls_hw_offload binary not found at {cfg.bin_local}")
+        cfg.bin_remote = cfg.remote.deploy(cfg.bin_local)
+        cfg.require_ipver("4")
+        check_tls_support(cfg)
+        cfg.nic_driver = nic_driver(cfg)
+
+        ksft_run([test_tls_offload, test_tls_offload_rekey,
+                  test_tls_offload_burst], args=(cfg, ))
+    ksft_exit()
+
+
+if __name__ == "__main__":
+    main()
-- 
2.50.1

