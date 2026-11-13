Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794602524;
	b=l52lGcred6uZK7PKh/t3QumZ4/+1CfA7n3G91slzqcc0ElWSk2fdwLP2vUUwhslSfWxW
	 oDxzTOoOV+b8X5rQWfZGS+nvPTtBmi3Tp+9Mv+A62uA2gu1WkgicHQgv/hBMLdupyy3Ab
	 ebS3cJZDXk70U9vlTEakomiX41zGP5nh6AI0x7y4k2upvVrp1dUbKRiB5GjZWEZ2sdqqv
	 sVo65Y+QS64pTgGVN0NG5iPI5LpnxU6emFxOpNnfviSK/xl6JaV4HFPFOhj9aCHGArqlY
	 oKllTpgsFKCi2sXSIPfpjQh8uUbQYEV33QM4aL9YrvRfAhvDkcDV5LhRSKVZcdzn4SA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794602524;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Subject:From:To:Cc:
	 Date:Message-ID:In-Reply-To:References:User-Agent:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=dGcn824rKEZ2cs2j/D0bTmwKcmAhL8Vsfhtp6L68fts=;
	b=MnzUR5G4xQgJbB3xNNJW69x2SAjhM0J3GqCv4vt6MFYP+CIwEYggnM/zvYfX3sqzwiOB
	 xkn5E3FI1RuQLroNSLvE/bYgrN11gJtwejJL/+j68g+gYIWDaTjQJpRAhjT0Gu3OG2Qj+
	 mAka5GHSL7lPE35fSbKkNnIJZEbj+pwjVl3gaDQ6B7D/erGknMrgP7guS7sKinn9dhe1z
	 FCaVFvP43FV/MJ0cBGmIJL8S+BhsPoL+l/EZH9wTJ/2Rpk82+fb6RJ2XuZrUdXifDgjMk
	 UIyPtfYq4XOjlGwBP52Ro5otr/KbeUlyOqWV1w5gLsiJoPdVPF627f7FDZI84dQ8OQw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="bPD/NoZD";
	arc=none smtp.remote-ip=209.85.216.43
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDD48606A323
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 20:42:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DDD48606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bPD/NoZD
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3b18717a193so805627a91.1
        for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 12:42:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794602523; x=1795207323; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:user-agent
         :references:in-reply-to:message-id:date:cc:to:from:subject:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=dGcn824rKEZ2cs2j/D0bTmwKcmAhL8Vsfhtp6L68fts=;
        b=bPD/NoZDhEN66i91GjHVmMPtwT4PFaMA+5+W+uaS/kF1xX+eA0atdJyMT8sl/rwmIm
         wlFrPqTl/oO6vOAFWkWxMUFk+1DAiYW8zVo+ZPGVpX4HaDMyd4lKNWtMGHSulEm7K5jC
         J9NvQECrjau4sX8grDa1HJzN1RRaTKwTv4JV8KsVS8U9wWJl93SlCVcNAEMNWz/MRsqu
         bRBY2BpMusNDmpUGzy2DjAeLkuUVPLsbg/cc/71uE8bukqWMcu8f59tG8ViU6RmhoqaA
         Dcv/Se9nBpgXThZTpGY4BEkA6pUNu/6IECUNghRBysMs7zGqL4YVH38U12iQ9HImjgM7
         /Asw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794602523; x=1795207323;
        h=content-transfer-encoding:content-type:mime-version:user-agent
         :references:in-reply-to:message-id:date:cc:to:from:subject:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dGcn824rKEZ2cs2j/D0bTmwKcmAhL8Vsfhtp6L68fts=;
        b=JGP9KTkcxckXsO7fsCb1RffB/4aoIufGtGG8wlO0VTkYOPdIxqzsCxE3mS7mX09AHE
         A2AB9mvyxdqJWF441slyTAB2rFSeM8FJZx2QQsG6k0QMbYDHiQ9CQbX5YzlxSocGmfda
         vYyJh9ERPbSwXei0VxtoiNRAQIXFj7+9W6M/ZObGX33tEDTPiCYnt+xjfTD2u1Puup76
         X22Q1bcJVuS1mZFBvvLCOfyPiVSZIVmWVF2BPNNURI9cNrC+V26/hdogjSQFqQf4zcol
         ZjUsY16D/sgZvrpMerckQD2A2oD852dSNz9In1m6VKbGyvJl+2c8Y3Y3IYjMvcNqcw/k
         jFYQ==
X-Gm-Message-State: APuU4Z+aLngpkwl5+BkNL1pyyCdtCX5QMsMELLL9ybUTGuJkii9JHAEE
	mNqsHhuVhYlrv3SdzR38St4uaPI5EgYpLtkkxLmVdkG0iDlQwhk9imu1
X-Gm-Gg: AYBFou0KNGwUOi9Wxmt2etFAncq4W6pkdD26RRvTUWPiVXL6jXbLidXO8oZts5J2G7l
	eTCmslLxSueS352bajqvypaEXhpz67XNZejL2/hfo7hcLc60lnCMbPbmPjXpydqaC/DiyfE2usA
	vfczmR/ftd+qtLN677bKkZ2AUx5r9j+5nEQy/ezgvbNxHiobOXYLkd1aTLz08SApHpVBpQvbN+6
	dLmP7Hn+AcedkWElmohhWYm9l2EnTZ8dkHnA2bAJFeno+KCv7Mkmiwi+Tz9r7mN5Hj3ZWEGoQ4H
	Ph3AWgRJfzWey4S36IDQkERB7CLVA6zpRFu04AXwBsa8sX/uLUH+tScFfa3amToeio7563GKPIE
	g7Nul5xLMIfAorm47fLl7vLisHP3urJVcINVMELl7873Lqe2GFY9HGzZKfzZzsVnkbVaEK25dsz
	uCDSADnL4LYeBt0U3rP+q7xiM1WaAGDQyN33vFsjezJagbTYFAA8Tx2H4AN46G61IPyypaNqLRQ
	STm22goO/FAX9Cp1ZNWZkzPdSA0DSgrl+OTTv/qRzA03f/n4/Vgyj0EY2EaGFfDU+dReL7hIsoX
	HeAByrcYloh3LR79pNz6NwebmQbAuMQFMOW9vpqzXfY4c25LXh2SAh6bDs4MNm3nCIIwRYHxOFF
	HW7bZDzSrltHItXeZE7n5ccQJzM0REoYJvN/jR2ZRD8AwBQ==
X-Received: by 2002:a17:90b:2543:b0:3ac:9e5e:d195 with SMTP id 98e67ed59e1d1-3b1b0b92206mr3127882a91.61.1794602523217;
        Fri, 13 Nov 2026 12:42:03 -0800 (PST)
Received: from ahduyck-xeon-server.home.arpa ([2605:59c1:38c:400:22f5:2de:b9c3:f27c])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1aeb179fasm6008867a91.4.2026.11.13.12.42.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 12:42:02 -0800 (PST)
Subject: [net PATCH 5/6] fbnic: Stamp heartbeat and ownership requests after
 allocating them
From: Alexander Duyck <alexander.duyck@gmail.com>
To: netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 horms@kernel.org, kernel-team@meta.com, kuba@kernel.org, pabeni@redhat.com
Date: Fri, 13 Nov 2026 12:42:01 -0800
Message-ID: 
 <179460252146.8819.5116894946781183620.stgit@ahduyck-xeon-server.home.arpa>
In-Reply-To: 
 <179460241885.8819.7179935130629202331.stgit@ahduyck-xeon-server.home.arpa>
References: 
 <179460241885.8819.7179935130629202331.stgit@ahduyck-xeon-server.home.arpa>
User-Agent: StGit/1.5
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Alexander Duyck <alexanderduyck@fb.com>

The fbnic_fw_xmit_heartbeat_message function records the request time
on entry, before it allocates the message. The service task sends the
heartbeat with RTNL held, and under memory pressure that GFP_KERNEL
page allocation can sit in direct reclaim for minutes. The request then
goes out stamped at the start of the stall, so the FW_HEARTBEAT_PERIOD
gate in the fbnic_fw_check_heartbeat function has already expired on
the next service task pass. That pass expects the response to have
been processed already, and if the mailbox interrupt thread has not got
to it yet on a host that is still struggling, the heartbeat is reported
as missed and handled as a firmware crash although the firmware
answered.

Take the request time after the allocation, just before the message is
posted. A response still cannot be recorded as older than its request,
and the firmware gets the full period to answer however long the
allocation took.

The fbnic_fw_xmit_ownership_msg function restarts the heartbeat the
same way, stamping the request and the last response before it
allocates the message. It runs from the service task with RTNL held
when recovering from a firmware crash, so move its timestamp after the
allocation as well.

This was seen on production hosts during host memory stalls, where a
page allocation stall of 464 seconds in this allocation was followed by
a "Firmware did not respond to heartbeat message" warning while the
firmware kept running normally.

Fixes: 20d2e88cc746 ("eth: fbnic: Add initial messaging to notify FW of our presence")
Signed-off-by: Alexander Duyck <alexanderduyck@fb.com>
---
 drivers/net/ethernet/meta/fbnic/fbnic_fw.c |   14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_fw.c b/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
index e00d626f6438..3465f0139883 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
@@ -538,8 +538,8 @@ static bool fbnic_mbx_event(struct fbnic_dev *fbd)
  */
 int fbnic_fw_xmit_ownership_msg(struct fbnic_dev *fbd, bool take_ownership)
 {
-	unsigned long req_time = jiffies;
 	struct fbnic_tlv_msg *msg;
+	unsigned long req_time;
 	int err = 0;
 
 	if (!fbnic_fw_present(fbd))
@@ -556,8 +556,10 @@ int fbnic_fw_xmit_ownership_msg(struct fbnic_dev *fbd, bool take_ownership)
 	}
 
 	/* Initialize heartbeat, set last response to 1 second in the past
-	 * so that we will trigger a timeout if the firmware doesn't respond
+	 * so that we will trigger a timeout if the firmware doesn't respond.
+	 * Take the time after the allocation, as for the heartbeat request.
 	 */
+	req_time = jiffies;
 	fbd->last_heartbeat_response = req_time - HZ;
 	fbd->last_heartbeat_request = req_time;
 
@@ -793,8 +795,8 @@ static int fbnic_fw_parse_heartbeat_resp(void *opaque,
 
 static int fbnic_fw_xmit_heartbeat_message(struct fbnic_dev *fbd)
 {
-	unsigned long req_time = jiffies;
 	struct fbnic_tlv_msg *msg;
+	unsigned long req_time;
 	int err = 0;
 
 	if (!fbnic_fw_present(fbd))
@@ -804,6 +806,12 @@ static int fbnic_fw_xmit_heartbeat_message(struct fbnic_dev *fbd)
 	if (!msg)
 		return -ENOMEM;
 
+	/* Stamp the request after the allocation, which can stall in
+	 * reclaim, but before posting it, so the response can never be
+	 * recorded as older than the request.
+	 */
+	req_time = jiffies;
+
 	err = fbnic_mbx_map_tlv_msg(fbd, msg);
 	if (err)
 		goto free_message;


