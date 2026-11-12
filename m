Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.28.218
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794487940;
	b=No/ZHUd9uFpopLdS3oE1MSHoOh32CDOpO86ECrizvM/SxXFmFL9K20E6hoNZxphd1uJA
	 oQZ+h3VMdwQyD6KORrkurj2/1jXKKI89jvrv1Ybc9eFKmteww94QWVBPx0xXBHZldHN6m
	 6QMJX4zbfu/WymQwgCa0YY70UHYGXeqL6IA87/7CLDAypUX+oy2r04gmFJu0wrmtk2jlD
	 g21WYXDobhEuYKovVM4bT8ueOKvHKoXpG1HeLR/ezMSpxk3hW4lDYz8Xyxvfy8SOd7g56
	 tE0kwKY9R7n2jeOI/WriEcbhiv+pi9UIVLhgwFktBm4R/ZLFbfMNLMTlRTADil0xlUw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794487940;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=6XcGtGAW+6Ub371/XFnhKIHvkGjNjYFiujd/YbHY8nE=;
	b=dkypSPzl82W2WN+w8gGuyPGd3n5bevT3oiRy5/EETySNtSFVUlLc+q33v9//il1vBX4v
	 sPormqBU5GilPMlqAvRiwvZ86LxUQctbMN/ddoi8uzyCn7dwx7RD9TvIh7wQE8hDUvjne
	 w9AwZPMyJuvJPsldtsapMWf/AwMh8SdeZ2Lk9LpR3q198ttQwZgF9OMEttRjJuDi6g61u
	 LVNbTo2IjQLb9Ri3u8m3mhd9sVEKUKc1t+ssKyq5PyBsegvSICgERGAd3zyOC0UwRvS6A
	 F2uwkxQsU+Qu+FStyKDIE4ZsKRhSPxiVtXIZC7uP2CR3sTGRV4y+AHwpgOgGOJ74HvA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=xiaopeng.com;
	spf=pass smtp.mailfrom=xiaopeng.com;
	dkim=pass header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=CrPLjen4;
	arc=none smtp.remote-ip=115.124.28.218
Received: from out28-218.mail.aliyun.com (out28-218.mail.aliyun.com [115.124.28.218])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD766606A8A7;
	Thu, 12 Nov 2026 12:52:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CD766606A8A7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=CrPLjen4
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xiaopeng.com; s=default;
	t=1794487931; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=6XcGtGAW+6Ub371/XFnhKIHvkGjNjYFiujd/YbHY8nE=;
	b=CrPLjen4Jj8bm5y1vtxOLgbfarEbsenBrPhHAdFMCBEk5zknLkpWHUTcMPLzqzDbczpkZMvaXL5nqG8DpWax2H2u6+tGeHAN3rvrFYQ+mTbN8oGnCqhmmAJ6lC5UT7ZqVH8XIXSNjidb3MIe+QyIRk28Bm3kOld2WU1QLyYunQA=
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.04436265|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.00745487-0.000394108-0.992151;FP=16019763649318518801|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033045038069;MF=fangxy@xiaopeng.com;NM=1;PH=DS;RN=14;RT=14;SR=0;TI=SMTPD_---.k0cpdf3_1794487929;
Received: from localhost.localdomain(mailfrom:fangxy@xiaopeng.com fp:SMTPD_---.k0cpdf3_1794487929 cluster:ay29)
          by smtp.aliyun-inc.com;
          Thu, 12 Nov 2026 20:52:10 +0800
From: Fang Xieyan <fangxy@xiaopeng.com>
To: Loic Poulain <loic.poulain@oss.qualcomm.com>,
	Sergey Ryazanov <ryazanov.s.a@gmail.com>,
	netdev@vger.kernel.org
Cc: Johannes Berg <johannes@sipsolutions.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org,
	Maoyi Xie <maoyixie.tju@gmail.com>,
	Simon Horman <horms@kernel.org>,
	M Chetan Kumar <m.chetan.kumar@linux.intel.com>,
	Guanglei Zhu <zhugl3@xiaopeng.com>
Subject: [PATCH net 4/5] net: wwan: iosm: pass the DL command parameter by pointer
Date: Thu, 12 Nov 2026 20:52:00 +0800
Message-ID: <20261112125201.1019-5-fangxy@xiaopeng.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261112125201.1019-1-fangxy@xiaopeng.com>
References: <20261112125201.1019-1-fangxy@xiaopeng.com>
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

ipc_mux_dl_cmdresps_decode_process() takes the twelve byte union
mux_cmd_param by value, so every received command copies the whole union
out of the skb even when the command type only needs one member of it.
The driver also builds its answers inside the received block:
ipc_mux_dl_cmd_decode() writes the link status response into cmdh->param
of the skb and reads it back a few lines later, and
ipc_mux_dl_acbcmd_decode() writes into it as well.

Take the parameter as a const pointer, and keep the link status response
of the lite path in a local variable. The aggregated path does not need a
parameter pointer at all: it passes a size of zero to
ipc_mux_dl_acb_send_cmds(), so nothing is ever copied from it and the
write into cmdh->param had no effect.

The bytes handed to the UL path are unchanged, the lite path still sends
the four byte response field and the aggregated path still sends none.

Reviewed-by: Guanglei Zhu <zhugl3@xiaopeng.com>
Signed-off-by: Fang Xieyan <fangxy@xiaopeng.com>
---
 drivers/net/wwan/iosm/iosm_ipc_mux_codec.c | 29 ++++++++++------------
 1 file changed, 13 insertions(+), 16 deletions(-)

diff --git a/drivers/net/wwan/iosm/iosm_ipc_mux_codec.c b/drivers/net/wwan/iosm/iosm_ipc_mux_codec.c
index 2c4f175233a1..aea4cd9ec20d 100644
--- a/drivers/net/wwan/iosm/iosm_ipc_mux_codec.c
+++ b/drivers/net/wwan/iosm/iosm_ipc_mux_codec.c
@@ -184,7 +184,7 @@ void ipc_mux_netif_tx_flowctrl(struct mux_session *session, int idx, bool on)
 }
 
 static int ipc_mux_dl_cmdresps_decode_process(struct iosm_mux *ipc_mux,
-					      union mux_cmd_param param,
+					      const union mux_cmd_param *param,
 					      __le32 command_type, u8 if_id,
 					      __le32 transaction_id)
 {
@@ -194,7 +194,7 @@ static int ipc_mux_dl_cmdresps_decode_process(struct iosm_mux *ipc_mux,
 	case MUX_CMD_OPEN_SESSION_RESP:
 	case MUX_CMD_CLOSE_SESSION_RESP:
 		/* Resume the control application. */
-		acb->got_param = param;
+		acb->got_param = *param;
 		break;
 
 	case MUX_LITE_CMD_FLOW_CTL_ACK:
@@ -318,7 +318,7 @@ static void ipc_mux_dl_cmd_decode(struct iosm_mux *ipc_mux, struct sk_buff *skb)
 	__le32 trans_id = cmdh->transaction_id;
 	int size;
 
-	if (ipc_mux_dl_cmdresps_decode_process(ipc_mux, cmdh->param,
+	if (ipc_mux_dl_cmdresps_decode_process(ipc_mux, &cmdh->param,
 					       cmdh->command_type, cmdh->if_id,
 					       cmdh->transaction_id)) {
 		/* Unable to decode command response indicates the cmd_type
@@ -333,14 +333,15 @@ static void ipc_mux_dl_cmd_decode(struct iosm_mux *ipc_mux, struct sk_buff *skb)
 			/* Decoded command may need a response. Give the
 			 * response according to the command type.
 			 */
+			union mux_cmd_param response = {};
 			union mux_cmd_param *mux_cmd = NULL;
 			size_t size = 0;
 			u32 cmd = MUX_LITE_CMD_LINK_STATUS_REPORT_RESP;
 
 			if (cmdh->command_type ==
 			    cpu_to_le32(MUX_LITE_CMD_LINK_STATUS_REPORT)) {
-				mux_cmd = &cmdh->param;
-				mux_cmd->link_status_resp.response =
+				mux_cmd = &response;
+				response.link_status_resp.response =
 					cpu_to_le32(MUX_CMD_RESP_SUCCESS);
 				/* response field is u32 */
 				size = sizeof(u32);
@@ -500,26 +501,22 @@ static void ipc_mux_dl_acbcmd_decode(struct iosm_mux *ipc_mux,
 	u32 fctl_dis = IOSM_AGGR_MUX_CMD_FLOW_CTL_DISABLE;
 	u32 fctl_ena = IOSM_AGGR_MUX_CMD_FLOW_CTL_ENABLE;
 	u32 fctl_ack = IOSM_AGGR_MUX_CMD_FLOW_CTL_ACK;
-	union mux_cmd_param *cmd_p = NULL;
 	u32 cmd = link_st;
 	u32 trans_id;
 
 	if (!ipc_mux_dl_cmds_decode_process(ipc_mux, &cmdh->param,
 					    cmdh->command_type, cmdh->if_id,
 					    cmdh->cmd_len, size)) {
-		size = 0;
-		if (cmdh->command_type == cpu_to_le32(link_st)) {
-			cmd_p = &cmdh->param;
-			cmd_p->link_status_resp.response = MUX_CMD_RESP_SUCCESS;
-		} else if ((cmdh->command_type == cpu_to_le32(fctl_ena)) ||
-				(cmdh->command_type == cpu_to_le32(fctl_dis))) {
+		if (cmdh->command_type == cpu_to_le32(fctl_ena) ||
+		    cmdh->command_type == cpu_to_le32(fctl_dis))
 			cmd = fctl_ack;
-		} else {
+		else if (cmdh->command_type != cpu_to_le32(link_st))
 			return;
-			}
+
 		trans_id = le32_to_cpu(cmdh->transaction_id);
+		/* No response parameter is sent in the aggregated protocol. */
 		ipc_mux_dl_acb_send_cmds(ipc_mux, cmd, cmdh->if_id,
-					 trans_id, cmd_p, size, false, true);
+					 trans_id, NULL, 0, false, true);
 	}
 }
 
@@ -571,7 +568,7 @@ static void ipc_mux_dl_acb_decode(struct iosm_mux *ipc_mux, struct sk_buff *skb)
 		     skb->len - next_cmd_index < hdr_len))
 			break;
 
-		if (ipc_mux_dl_cmdresps_decode_process(ipc_mux, cmdh->param,
+		if (ipc_mux_dl_cmdresps_decode_process(ipc_mux, &cmdh->param,
 						       cmdh->command_type,
 						       cmdh->if_id,
 						       cmdh->transaction_id)) {
-- 
2.50.1

