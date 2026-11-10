Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794308476;
	b=gImzRnESDxQuAG/KHKtCD1kZBCOqfr1JOcI9Us3Y/nnReAW+gSxihQG23xlyMVMIW0ps
	 P6c5bnmy1Wv1KcycQDfUubsZUkB+ayqIYcFGFXLrGcypJQAtEUxdHQcrjDCWeV/373qaO
	 T3jWwZImeqH6uQ9jJ51YpVqhuMpvVsMSl4GOaLtY6LnVYSArcR/kEtKwE9XUaB1jjm3RE
	 0bNkvW45yee6toqLIKTZtldqS1wBpqkbtMcPs8sSOL9e5tI6Ky5QN6ovYt731v6NLzpCG
	 ltpJnS25iXBdGPUkDokOdr3gtn/E+cpjKNpsCKEmSPsQH+FHlldvL2EHrqs1E7YFsaQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794308476;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Scanned-By;
	bh=gWZcEk4QFFcpX3DF3GAzwErvJEHcFB2jeEIxQdKqk5A=;
	b=iLvXgNUHAiPN+1Bst15nxsPxH9zNTGtFO/KubK06MrFXovCQWit8zgWh5X5fKCLL+Q0J
	 C3NkWGdK7+zy50xODf9quyOpxb+hspUv1KySER2EhVTHogvD3QLXVhPaSb+dDwLh/qOzh
	 OLFajLhHsh7w6kjBWcNecd5I7l16BAfHAUgSk8zCJCTmrRdPNLP/hdBlZ0k7P+kG3nLjp
	 5Uy9ErAcdkS2Yu9dnsTgkZZIKZReDH/LZtYysPvGvnoJ7afreF4idC8c+dNR1lngFg1an
	 EDsMrEZK5J/6rH5GMU+MYnidAVX2bZAyxZ3+/P/RonggzXdjXJheDnB7aLx8jzHjVPA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=YOE4g9yE;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA68860A2602
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 11:01:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BA68860A2602
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=YOE4g9yE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794308474;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gWZcEk4QFFcpX3DF3GAzwErvJEHcFB2jeEIxQdKqk5A=;
	b=YOE4g9yEg/VRykVtpC6NcIZoM77EmcODIXAtzaVZI29KmpzdgjryRKaoFity8vlyo89j/N
	Mov+0cYOOTMBj1bAFo/MluKT0+iQQeNhCVjEto469W096/oJHNg6s8RKLCWVWwIQn5jKLd
	RiarwmTzG4u9gVIyGt+odG6qcUXlDiA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-558-2SCYnSh7N6KSe25NixvWYQ-1; Tue,
 10 Nov 2026 06:01:12 -0500
X-MC-Unique: 2SCYnSh7N6KSe25NixvWYQ-1
X-Mimecast-MFC-AGG-ID: 2SCYnSh7N6KSe25NixvWYQ_1794308471
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A2B7B1800350;
	Tue, 10 Nov 2026 11:01:11 +0000 (UTC)
Received: from poros-thinkpadp16vgen1.tpbc.com (unknown [10.44.32.99])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id BB4BC39204;
	Tue, 10 Nov 2026 11:01:09 +0000 (UTC)
From: Petr Oros <poros@redhat.com>
To: netdev@vger.kernel.org
Cc: David Ahern <dsahern@kernel.org>,
	Stephen Hemminger <stephen@networkplumber.org>,
	Ivan Vecera <ivecera@redhat.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Petr Oros <poros@redhat.com>
Subject: [PATCH iproute2-next 1/2] mnl_utils: add a dump helper for NLM_F_DUMP_INTR
Date: Tue, 10 Nov 2026 12:01:00 +0100
Message-ID: <20261110110101.2155953-2-poros@redhat.com>
In-Reply-To: <20261110110101.2155953-1-poros@redhat.com>
References: <20261110110101.2155953-1-poros@redhat.com>
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
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

The kernel sets NLM_F_DUMP_INTR on a dump message when the dumped
objects changed between two parts of the dump, so the result can miss an
object or list it twice. mnl_cb_run2() answers the flag with EINTR on
the first such message. mnlu_gen_socket_sndrcv() then prints "kernel
answers: Interrupted system call" and returns with the rest of the dump
still queued in the socket. The caller has passed a part of the objects
to its callback by then and cannot tell an interrupted dump from a
request that failed.

Add mnlu_gen_socket_sndrcv_dump(). It clears the flag in every received
message before the callbacks run, reads the dump to its end and tells
the caller through a bool that the dump was interrupted. The caller can
then repeat the request on the same socket or warn the user, as
rtnl_dump_filter() does for rtnetlink dumps.

The receive loop is shared with mnlu_socket_recv_run() and
mnlu_gen_socket_sndrcv(), which behave as before.

Reviewed-by: Ivan Vecera <ivecera@redhat.com>
Signed-off-by: Petr Oros <poros@redhat.com>
---
 include/mnl_utils.h |  5 ++++
 lib/mnl_utils.c     | 58 +++++++++++++++++++++++++++++++++++++++------
 2 files changed, 56 insertions(+), 7 deletions(-)

diff --git a/include/mnl_utils.h b/include/mnl_utils.h
index 4df9e398e59165..82c26f05742ce3 100644
--- a/include/mnl_utils.h
+++ b/include/mnl_utils.h
@@ -2,6 +2,8 @@
 #ifndef __MNL_UTILS_H__
 #define __MNL_UTILS_H__ 1
 
+#include <stdbool.h>
+
 struct mnlu_gen_socket {
 	struct mnl_socket *nl;
 	char *buf;
@@ -22,6 +24,9 @@ struct nlmsghdr *mnlu_gen_socket_cmd_prepare(struct mnlu_gen_socket *nlg,
 					     uint8_t cmd, uint16_t flags);
 int mnlu_gen_socket_sndrcv(struct mnlu_gen_socket *nlg, const struct nlmsghdr *nlh,
 			   mnl_cb_t data_cb, void *data);
+int mnlu_gen_socket_sndrcv_dump(struct mnlu_gen_socket *nlg,
+				const struct nlmsghdr *nlh,
+				mnl_cb_t data_cb, void *data, bool *intr);
 
 struct mnl_socket *mnlu_socket_open(int bus);
 int mnl_add_nl_group(struct mnl_socket *nl, unsigned int group);
diff --git a/lib/mnl_utils.c b/lib/mnl_utils.c
index 43b4cd1a9e40d4..4b971797777cb3 100644
--- a/lib/mnl_utils.c
+++ b/lib/mnl_utils.c
@@ -102,8 +102,29 @@ static mnl_cb_t mnlu_cb_array[NLMSG_MIN_TYPE] = {
 	[NLMSG_OVERRUN]	= mnlu_cb_noop,
 };
 
-int mnlu_socket_recv_run(struct mnl_socket *nl, unsigned int seq, void *buf, size_t buf_size,
-			 mnl_cb_t cb, void *data)
+/* mnl_cb_run2() fails with EINTR on the first message with NLM_F_DUMP_INTR
+ * and leaves the rest of the dump in the socket. Clear the flag, so that
+ * the dump is read to its end, and tell the caller that it was there.
+ */
+static bool mnlu_dump_intr_clear(void *buf, size_t len)
+{
+	struct nlmsghdr *nlh = buf;
+	bool intr = false;
+	int rem = len;
+
+	for (; mnl_nlmsg_ok(nlh, rem); nlh = mnl_nlmsg_next(nlh, &rem)) {
+		if (nlh->nlmsg_flags & NLM_F_DUMP_INTR) {
+			nlh->nlmsg_flags &= ~NLM_F_DUMP_INTR;
+			intr = true;
+		}
+	}
+
+	return intr;
+}
+
+static int __mnlu_socket_recv_run(struct mnl_socket *nl, unsigned int seq,
+				  void *buf, size_t buf_size,
+				  mnl_cb_t cb, void *data, bool *intr)
 {
 	unsigned int portid = mnl_socket_get_portid(nl);
 	int err;
@@ -112,6 +133,8 @@ int mnlu_socket_recv_run(struct mnl_socket *nl, unsigned int seq, void *buf, siz
 		err = mnl_socket_recvfrom(nl, buf, buf_size);
 		if (err <= 0)
 			break;
+		if (intr)
+			*intr |= mnlu_dump_intr_clear(buf, err);
 		err = mnl_cb_run2(buf, err, seq, portid,
 				  cb, data, mnlu_cb_array,
 				  ARRAY_SIZE(mnlu_cb_array));
@@ -120,6 +143,12 @@ int mnlu_socket_recv_run(struct mnl_socket *nl, unsigned int seq, void *buf, siz
 	return err;
 }
 
+int mnlu_socket_recv_run(struct mnl_socket *nl, unsigned int seq, void *buf, size_t buf_size,
+			 mnl_cb_t cb, void *data)
+{
+	return __mnlu_socket_recv_run(nl, seq, buf, buf_size, cb, data, NULL);
+}
+
 static int ctrl_attrs_cb(const struct nlattr *attr, void *data)
 {
 	int type = mnl_attr_get_type(attr);
@@ -242,20 +271,29 @@ struct nlmsghdr *mnlu_gen_socket_cmd_prepare(struct mnlu_gen_socket *nlg,
 					    nlg->version);
 }
 
-int mnlu_gen_socket_sndrcv(struct mnlu_gen_socket *nlg, const struct nlmsghdr *nlh,
-			   mnl_cb_t data_cb, void *data)
+/* Like mnlu_gen_socket_sndrcv(), for a dump request. A dump the kernel
+ * marked as interrupted is read to its end and reported in @intr. The
+ * objects passed to @data_cb can then be incomplete or duplicated and it
+ * is up to the caller to repeat the dump or to warn the user.
+ */
+int mnlu_gen_socket_sndrcv_dump(struct mnlu_gen_socket *nlg,
+				const struct nlmsghdr *nlh,
+				mnl_cb_t data_cb, void *data, bool *intr)
 {
 	int err;
 
+	if (intr)
+		*intr = false;
+
 	err = mnl_socket_sendto(nlg->nl, nlh, nlh->nlmsg_len);
 	if (err < 0) {
 		perror("Failed to send data");
 		return -errno;
 	}
 
-	err = mnlu_socket_recv_run(nlg->nl, nlh->nlmsg_seq, nlg->buf,
-				   MNL_SOCKET_BUFFER_SIZE,
-				   data_cb, data);
+	err = __mnlu_socket_recv_run(nlg->nl, nlh->nlmsg_seq, nlg->buf,
+				     MNL_SOCKET_BUFFER_SIZE,
+				     data_cb, data, intr);
 	if (err < 0) {
 		fprintf(stderr, "kernel answers: %s\n", strerror(errno));
 		return -errno;
@@ -263,6 +301,12 @@ int mnlu_gen_socket_sndrcv(struct mnlu_gen_socket *nlg, const struct nlmsghdr *n
 	return 0;
 }
 
+int mnlu_gen_socket_sndrcv(struct mnlu_gen_socket *nlg, const struct nlmsghdr *nlh,
+			   mnl_cb_t data_cb, void *data)
+{
+	return mnlu_gen_socket_sndrcv_dump(nlg, nlh, data_cb, data, NULL);
+}
+
 int mnlu_gen_socket_recv_run(struct mnlu_gen_socket *nlg, mnl_cb_t cb,
 			     void *data)
 {
-- 
2.56.0

