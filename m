Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794308478;
	b=r4s/jjXUuspA7xDD2oMymIhiW0P195sh8nqAygqB2gnpvFQ/iP/mreTCWcN+RxRV7e8q
	 LPDwRnGcNErAmT348B7oq2WJ0CpvXcr5sOQUufASccAT8resO4BKpA7gqYzJJAGmNZiJA
	 tEq3Eyu7nuKT/+hOBPmsfp02upwv4ZFXdtYxiEeejs/tTuW9iySFAZzILhuBBQM5sSQdB
	 Uxw/irRaCpCr/dWYhEXzRoGNq+yF9DR0eEb1RvzL5IHEBYRZG2sPsLsJZ96HdF0d3AX3B
	 THy+ryaSekLFUV2kGzlV5+hJ6FlaGbMUfyQyUd9g8bhYaZnYJiVXD2ZyKcy4krmZnhA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794308478;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Scanned-By;
	bh=QipDqubznJvpk1tmEQ9WM8TXqblbek1jvvGVe4/YryI=;
	b=Bs3LzbDEWHrjeynaXe3zFK4pZSmhxZGA6JN2u40l5pssdjhuNQblLSAlwL56wGXEIcSB
	 3gtnBSSI65b+G490TrCGfJobf4hhHrc5W2qFx4h7vaycCnH+bAipRSlac0EB5a7t2ky3h
	 2PMf6NdLadbrXnBSLlaqzx1+SlAvYtshacSwVpfuFZisJqMF2dUGgGpyvc9rm6t0d8oGR
	 RVt0JYxuT2/ZkY/cK45kJ0B/Ptcxnwkdtlj9biemkoQB+NmywtlGwR6FlJKHG7HQYqp7a
	 IRqUjLEquMQhk96ErxCCkPy8uI807VSDQAl5RaGjBK6NOPP+mEG2aTyLLcH2h2Rg8nQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=QE5n+6I0;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97AD560A260C
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 11:01:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 97AD560A260C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=QE5n+6I0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794308476;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QipDqubznJvpk1tmEQ9WM8TXqblbek1jvvGVe4/YryI=;
	b=QE5n+6I07L34y95Yvanm+Hy8bRkFzcE3TtxiCcuPqFsMMLNejSKf5BTDTXExx3qJOjXQKf
	TlE36oJTTgzxmk1khk6PKSbnlTJYHX0/fxPMD1QyG40QbZ9aUk+SIdlyJ29l0I8ok5Kwak
	Asx/C127S1uOK3k3lFlCfmBzkVgUoMc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-518-tYHiZqIyM7iKxtCn4-2YSg-1; Tue,
 10 Nov 2026 06:01:14 -0500
X-MC-Unique: tYHiZqIyM7iKxtCn4-2YSg-1
X-Mimecast-MFC-AGG-ID: tYHiZqIyM7iKxtCn4-2YSg_1794308473
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BAFC619560A2;
	Tue, 10 Nov 2026 11:01:13 +0000 (UTC)
Received: from poros-thinkpadp16vgen1.tpbc.com (unknown [10.44.32.99])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0E7031684;
	Tue, 10 Nov 2026 11:01:11 +0000 (UTC)
From: Petr Oros <poros@redhat.com>
To: netdev@vger.kernel.org
Cc: David Ahern <dsahern@kernel.org>,
	Stephen Hemminger <stephen@networkplumber.org>,
	Ivan Vecera <ivecera@redhat.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Petr Oros <poros@redhat.com>
Subject: [PATCH iproute2-next 2/2] dpll: warn about interrupted dumps
Date: Tue, 10 Nov 2026 12:01:01 +0100
Message-ID: <20261110110101.2155953-3-poros@redhat.com>
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

Pin and device dumps are printed while they are read, one object per
netlink message. When the kernel marks a dump with NLM_F_DUMP_INTR,
because a device or a pin was registered or unregistered while the dump
was in progress, the tool stops at the marked message with "kernel
answers: Interrupted system call" and exit code 1. With -j the output
is then a valid JSON document that holds only the objects printed up to
that point, so a script that ignores the exit code works with a
truncated list.

Read such a dump to its end with mnlu_gen_socket_sndrcv_dump() and
print the warning ip prints in this case, "Dump was interrupted and may
be inconsistent.". The exit code stays 0, as every object the kernel
sent is there.

Reviewed-by: Ivan Vecera <ivecera@redhat.com>
Signed-off-by: Petr Oros <poros@redhat.com>
---
 dpll/dpll.c | 37 +++++++++++++++++++++++--------------
 1 file changed, 23 insertions(+), 14 deletions(-)

diff --git a/dpll/dpll.c b/dpll/dpll.c
index 60404e134d0a50..5828e78f738eac 100644
--- a/dpll/dpll.c
+++ b/dpll/dpll.c
@@ -606,6 +606,26 @@ static int dpll_cmd(struct dpll *dpll, int argc, char **argv)
 	return -ENOENT;
 }
 
+/* Devices and pins registered or unregistered while a dump is in progress
+ * can be missing from it or be there twice, which the kernel reports with
+ * NLM_F_DUMP_INTR. Print the whole dump and warn the user, as ip does.
+ */
+static int dpll_dump(struct dpll *dpll, uint8_t cmd, mnl_cb_t cb, void *data)
+{
+	struct nlmsghdr *nlh;
+	bool intr;
+	int err;
+
+	nlh = mnlu_gen_socket_cmd_prepare(&dpll->nlg, cmd,
+					  NLM_F_REQUEST | NLM_F_ACK |
+					  NLM_F_DUMP);
+	err = mnlu_gen_socket_sndrcv_dump(&dpll->nlg, nlh, cb, data, &intr);
+	if (!err && intr)
+		pr_err("Dump was interrupted and may be inconsistent.\n");
+
+	return err;
+}
+
 static int dpll_init(struct dpll *dpll)
 {
 	int err;
@@ -1222,17 +1242,12 @@ static int cmd_device_show_id(struct dpll *dpll, __u32 id,
 static int cmd_device_show_dump(struct dpll *dpll,
 				struct dpll_device_filter *filter)
 {
-	struct nlmsghdr *nlh;
 	int err;
 
-	nlh = mnlu_gen_socket_cmd_prepare(&dpll->nlg, DPLL_CMD_DEVICE_GET,
-					  NLM_F_REQUEST | NLM_F_ACK |
-						  NLM_F_DUMP);
-
 	open_json_array(PRINT_JSON, "device");
 
-	err = mnlu_gen_socket_sndrcv(&dpll->nlg, nlh, cmd_device_show_dump_cb,
-				     filter);
+	err = dpll_dump(dpll, DPLL_CMD_DEVICE_GET, cmd_device_show_dump_cb,
+			filter);
 	if (err < 0) {
 		pr_err("Failed to dump devices\n");
 		close_json_array(PRINT_JSON, NULL);
@@ -1961,17 +1976,11 @@ static int cmd_pin_show_id(struct dpll *dpll, __u32 id,
 static int cmd_pin_show_dump(struct dpll *dpll,
 			     struct dpll_pin_filter *filter)
 {
-	struct nlmsghdr *nlh;
 	int err;
 
-	nlh = mnlu_gen_socket_cmd_prepare(&dpll->nlg, DPLL_CMD_PIN_GET,
-					  NLM_F_REQUEST | NLM_F_ACK |
-						  NLM_F_DUMP);
-
 	open_json_array(PRINT_JSON, "pin");
 
-	err = mnlu_gen_socket_sndrcv(&dpll->nlg, nlh, cmd_pin_show_dump_cb,
-				     filter);
+	err = dpll_dump(dpll, DPLL_CMD_PIN_GET, cmd_pin_show_dump_cb, filter);
 	if (err < 0) {
 		pr_err("Failed to dump pins\n");
 		close_json_array(PRINT_JSON, NULL);
-- 
2.56.0

