Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792478895;
	b=KHJMSvuQT1jxxZvLyd5ot0qTj2lnadLGn9osYUzfGN4xvPtPXcK6bRtJy2EwUysjasnQ
	 aZZDg99O8FUtNcIkSxpMM+WIfNdRe9ZknQUToPjmlNWg5aXP3EmHoiTRZ3yh53LbNDWA8
	 KFhBdq68NJSoakx0j+PBaXrw9nrRErKtJY1JRSDnRffVCORBe7PuJFPXC9r+TltfutpPc
	 9vNg8hJLZj0zQ6pJcjdRmdcyal76I2vaEudtJ2lC4OVrjycv4+fC4IN7mxyUBxPUgwVwX
	 3qIhMgksixbhTaIA8wlyDbImna/hd62VwQCxEG6/ZZmwk5V/dJ3MzwB6GUxaeGLcefg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792478895;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=h9o/WY84VpOSEy8ASk3I0e+HxMZSvbh7RJHqIMTnTzg=;
	b=i7c0xEDqKL2dQkn9cQVV+LX+szqrKL3XLOvGbLk6mqn1+Ix5FYsBW5wCfYQVCaGdop75
	 BCpoZYybippGZE+xCy50CTVmyb5ZuUL+m0qWl/VrJLMsZ4KSmLJb9Tw8BcWwhop3PS2Ph
	 4r1KTJT3u0y25gGhjWLVKZkLX3N6maNPtkKT/TIrcuzTW5Y1cvdovLA0iTxjX7Ix3scnm
	 gsDM5O0Ufn/MBLgvNBGDY3LFvpvDxuC7+np8DgYGjf60ZBJWnGzG3IIeTZx4lwW1yQIOY
	 7NWDfKXxiFCgPWjbFiwy+bSjIrM8kEYj78PPg3wisz6RiX+HuyvuidbpvvZSVyCXS1g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=YmzQ9t0M;
	arc=none smtp.remote-ip=117.135.210.5
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F128D606A31B;
	Tue, 20 Oct 2026 06:48:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F128D606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=YmzQ9t0M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=h9
	o/WY84VpOSEy8ASk3I0e+HxMZSvbh7RJHqIMTnTzg=; b=YmzQ9t0MX/TuqaITR5
	6kBzO5asBS90uu4siSc8aXUJZeBlUjEHp2t0TfKhsNdCHZ9qMxMxqSsk+fD44tGe
	NtTcSCbPtmwzDmbGCXD4DLx5GhmlBuZnL15S4SZKJR6Xq8pYMl/NljCRSF3cnM5G
	iqAomvCR0aY/oDhzF+eCnZcxw=
Received: from colol4bi5.localdomain (unknown [])
	by gzsmtp2 (Coremail) with SMTP id PSgvCgDXfydmDtdqoLOQAw--.44392S2;
	Tue, 20 Oct 2026 14:47:03 +0800 (CST)
From: Binbin Deng <18983559317@163.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Binbin Deng <18983559317@163.com>
Subject: [PATCH v1] qed: Protect iSCSI connection hash operations
Date: Tue, 20 Oct 2026 14:47:01 +0800
Message-ID: <20261020064701.535531-1-18983559317@163.com>
X-Mailer: git-send-email 2.43.0
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
X-CM-TRANSID:PSgvCgDXfydmDtdqoLOQAw--.44392S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxKrWfAFWkuF13tw43XFy8Grg_yoW7Gw4kpF
	W5Jay0yr4DJF1rKanxAFZ0yr9FyrWqkFWUGa4xKw4UA34ayr90yFs5K3ZYka4fGryqyF1q
	qF42qFy5GF4jyaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pRDCzAUUUUU=
X-CM-SenderInfo: jprymmytvvmjmrxbiqqrwthudrp/xtbC-ActEWrXDmetHQAA3j

The qed iSCSI connection hash is accessed without a common lock.
Operations first look up a qed_hash_iscsi_con wrapper and then keep
dereferencing its embedded connection object while firmware commands are
posted. Connection release removes the wrapper from the hash, releases
the firmware connection, and frees the wrapper. If two endpoints hash to
the same bucket, a release for one handle can race with lookup and object
use for another handle.

The race is reachable from qedi connection setup and teardown work: one
endpoint can call release_conn() while another endpoint concurrently calls
offload_conn(), update_conn(), clear_sq(), destroy_conn(), or change_mac().
The loop in qed_iscsi_get_hash() can also be traversing a bucket while a
node in that bucket is unlinked and freed.

This can cause a KASAN use-after-free, hash-list corruption, a stale
connection pointer being passed to firmware, or a panic. The storage stop
path also needs to see a stable empty/not-empty result before clearing the
started state.

Protect the hash and connection lifetime with a file-local mutex.  Hold it
across each complete connection operation, including firmware submission,
hash insertion or removal, and wrapper free. The mutex also serializes
connection acquisition with storage stop.

Found during a static-analysis-assisted audit: candidate sites were
surfaced by a Coccinelle rule, and the reader/writer paths were
confirmed by LLM-assisted (GLM-5.3) code inspection. Due to a lack
of hardware infrastructure, the issue was not observed at runtime.
It is identified by code inspection only.

Fixes: fc831825f99e ("qed: Add support for hardware offloaded iSCSI.")
Assisted-by: GLM-5.3 coccinelle
Signed-off-by: Binbin Deng <18983559317@163.com>
---
 drivers/net/ethernet/qlogic/qed/qed_iscsi.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/net/ethernet/qlogic/qed/qed_iscsi.c b/drivers/net/ethernet/qlogic/qed/qed_iscsi.c
index 34f1217227bc..f7b97883e4b9 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_iscsi.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_iscsi.c
@@ -14,6 +14,7 @@
 #include <linux/kernel.h>
 #include <linux/log2.h>
 #include <linux/module.h>
+#include <linux/mutex.h>
 #include <linux/pci.h>
 #include <linux/slab.h>
 #include <linux/stddef.h>
@@ -118,6 +119,8 @@ struct qed_iscsi_conn {
 	u8 abortive_dsconnect;
 };
 
+static DEFINE_MUTEX(qed_iscsi_conn_lock);
+
 static int qed_iscsi_async_event(struct qed_hwfn *p_hwfn, u8 fw_event_code,
 				 __le16 echo, union event_ring_data *data,
 				 u8 fw_return_code)
@@ -1080,6 +1083,7 @@ static int qed_iscsi_stop(struct qed_dev *cdev)
 {
 	int rc;
 
+	guard(mutex)(&qed_iscsi_conn_lock);
 	if (!(cdev->flags & QED_FLAG_STORAGE_STARTED)) {
 		DP_NOTICE(cdev, "iscsi already stopped\n");
 		return 0;
@@ -1158,6 +1162,7 @@ static int qed_iscsi_acquire_conn(struct qed_dev *cdev,
 	struct qed_hash_iscsi_con *hash_con;
 	int rc;
 
+	guard(mutex)(&qed_iscsi_conn_lock);
 	/* Allocate a hashed connection */
 	hash_con = kzalloc_obj(*hash_con, GFP_ATOMIC);
 	if (!hash_con)
@@ -1188,6 +1193,7 @@ static int qed_iscsi_release_conn(struct qed_dev *cdev, u32 handle)
 {
 	struct qed_hash_iscsi_con *hash_con;
 
+	guard(mutex)(&qed_iscsi_conn_lock);
 	hash_con = qed_iscsi_get_hash(cdev, handle);
 	if (!hash_con) {
 		DP_NOTICE(cdev, "Failed to find connection for handle %d\n",
@@ -1209,6 +1215,7 @@ static int qed_iscsi_offload_conn(struct qed_dev *cdev,
 	struct qed_hash_iscsi_con *hash_con;
 	struct qed_iscsi_conn *con;
 
+	guard(mutex)(&qed_iscsi_conn_lock);
 	hash_con = qed_iscsi_get_hash(cdev, handle);
 	if (!hash_con) {
 		DP_NOTICE(cdev, "Failed to find connection for handle %d\n",
@@ -1284,6 +1291,7 @@ static int qed_iscsi_update_conn(struct qed_dev *cdev,
 	struct qed_hash_iscsi_con *hash_con;
 	struct qed_iscsi_conn *con;
 
+	guard(mutex)(&qed_iscsi_conn_lock);
 	hash_con = qed_iscsi_get_hash(cdev, handle);
 	if (!hash_con) {
 		DP_NOTICE(cdev, "Failed to find connection for handle %d\n",
@@ -1308,6 +1316,7 @@ static int qed_iscsi_clear_conn_sq(struct qed_dev *cdev, u32 handle)
 {
 	struct qed_hash_iscsi_con *hash_con;
 
+	guard(mutex)(&qed_iscsi_conn_lock);
 	hash_con = qed_iscsi_get_hash(cdev, handle);
 	if (!hash_con) {
 		DP_NOTICE(cdev, "Failed to find connection for handle %d\n",
@@ -1324,6 +1333,7 @@ static int qed_iscsi_destroy_conn(struct qed_dev *cdev,
 {
 	struct qed_hash_iscsi_con *hash_con;
 
+	guard(mutex)(&qed_iscsi_conn_lock);
 	hash_con = qed_iscsi_get_hash(cdev, handle);
 	if (!hash_con) {
 		DP_NOTICE(cdev, "Failed to find connection for handle %d\n",
@@ -1354,6 +1364,7 @@ static int qed_iscsi_change_mac(struct qed_dev *cdev,
 {
 	struct qed_hash_iscsi_con *hash_con;
 
+	guard(mutex)(&qed_iscsi_conn_lock);
 	hash_con = qed_iscsi_get_hash(cdev, handle);
 	if (!hash_con) {
 		DP_NOTICE(cdev, "Failed to find connection for handle %d\n",
-- 
2.43.0

