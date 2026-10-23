Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792743038;
	b=uUSF8K6uAsxZnRY84pZVr6C0+AkgQLm650CL8RvLbtHPxlGXrQLfN8lgWELM2BytFBGK
	 tA9pO2C0xL9o8QFXJ4dSDxxEas0DGilwyMS4KudbOiYNGgvIQcrQCybtclL9c/6QzdH5w
	 mT1Xczo7EluQ03mZTEUOYhNeDx7bjPukos48TJJw1z8m7O6oszXGiH2oN3Ihg0RwBIqRQ
	 pv9qLd1yaMklLfDvGFFwSKkISD6b7WpNNkxDfLIHQFIzT6MK7NVnG1hZCD8cYrQJuQi5t
	 VZQ1KEKMyUvXSCOCD4/guQLgEQTYe/pG8ZA5WOLdYiLzz2qttELL3ZidE9UELPpwYiw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792743038;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=t1HGN9k89SSRdYCs5v027mAthueeDnZ3FtFBWpQLM/E=;
	b=BP+V+GFXLx/qxo9GE+f1bJgzGc/nci3KJ+gJFxnVs435DMCmpX3w5l4nAd6fQ8hhvekV
	 8z0gazpTuyz1SULp0/GMKpCw0Y/ZYst9E2oRY2qkzFaB42Lhmhc2zYF6DJWe0498v5eHO
	 WuuWVjtce1ZRTDaEaxV3xEWhOjbMsjxukWJ7SmrIE5Zu1FK41lWHkNS5sB6+spLLkEvuk
	 +4Ouc/fYNuLi31auuUffywy5DZTjEyLXtrHNONbPv82T9qm9yra7sPxr1afjjUAvPQWA1
	 znvO7oDqah6ethwcbeM0xLlDOsFv7pePmlSwHl+LpDKvtcNG8C6/Fw7jLwkly6Tljcw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=iWf80ssf;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ka3bBCxa;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1239606A32C
	for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 08:10:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F1239606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=iWf80ssf;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ka3bBCxa
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69N7FMAl1048184
	for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 08:10:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	t1HGN9k89SSRdYCs5v027mAthueeDnZ3FtFBWpQLM/E=; b=iWf80ssfOvmVKlnI
	cab6ohzn3GukSbD5s8FwmdyjPD+fTRMpwXCweGlzIIJ9rSAKATSoCYpfAT7f8ht4
	U2l0sX8iIdtCxHJjUxyfYmsWqp5SyCb2CdFCWkaNfC8urzOZhQQdz6sfiHOttEL/
	u1CGNmWGmZNPtYyWSTnImsCa7CeiFnia2CEIUg18Kf9wa2w3FiyNFwj3mmO/XGad
	R+w1kLJdIjlV4uYXmr07orj1jUY+sVHd1HbRnlFlZDI2FuOe6aJKPH55GkYcSeEG
	8jCZ+jCTVnQr+AsTYBnxvRItjh7aPhLK4kWmKsb+JY6XQ8lTKdKIhwT1xXcvye4N
	drkLjw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfqmbjpv4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 08:10:36 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-93cbf2fd504so113076885a.2
        for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 01:10:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792743036; x=1793347836; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=t1HGN9k89SSRdYCs5v027mAthueeDnZ3FtFBWpQLM/E=;
        b=ka3bBCxa3DSUWftZ4/jR893yrteF4/uHTYqAwPBAYZp+Y36wr2YAii4BoE/ZFkmvGm
         EKJOtqBOjr5d91D/HDQfu4BJewNQJ37Uj/wsWl8BmHLJ5WExRA70BTw81BnVksqvsyxH
         mP5NlFIHXYfJ2nrIh/a4qcbXoy74dqd3g63Uiknf2mS/y4nmqxrnozHulvrrUfrEQASA
         atqF3SBWCv1c8EdQlxhnP/5wreYdB/9KByQzDoJw3XJB8vRA26iBmn2IrCWh8QImkRGn
         j4D37IextmWubSMfKPiscg3BPOy0wNPlCcbZbj3dm8DgHIgGEsMFnK82FtAnO6AntdZO
         UJKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792743036; x=1793347836;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=t1HGN9k89SSRdYCs5v027mAthueeDnZ3FtFBWpQLM/E=;
        b=rp6JiHDVBBYnyPYqjv6pDISJV6Yw52rKnwNT+4A1bejrFeF7MIo2uyGRpRNN/5NvHJ
         w/i6Gj75ZTpowKPK9c/FEBkOhM7WObIre/MAdtpN1l4tQo2610izYYgpIesZLcnbqian
         zoy+kRTJUCkYcL5a8jwaGMwnQKccoqR4phu1vwXZ57Ov7HU4WhKiLYNE/Y1Xf+bW9bRF
         cMa0xmyl/kojGSDsBVhG3SvirXtx9hRaOSTZn7YITdjnLJHsNe02DeRgAS6voM5nf4HM
         +3RWyycY/05PIS829tETAC3kEwv+T09/mxig5T0qB9zYgF+RMK32Rt1Mnj4b+Q7OsgSC
         AMQw==
X-Gm-Message-State: AFq9FYLi5o8Kwe8Z8LmYBAfIxIcn2sMmxwrxIZGd30xq/gBBCagPZxEV
	M9V5+2O3PvEb9UHeZ44UWvWP1SV8W77HJHZj5+8H80jfgHqeSJYoWrUjLGSEabW7GQm6xPT2jk+
	xpCA2x21Hg8oaPWNC/KmcvgGW7mtswTNnTUqu1DKY5T1g8pxnISHgFlrArhE=
X-Gm-Gg: AYBFou35H/21Ywi08AW2tJV0hpZm069LYkIl8k3uVHYTngK1pScJRShF0xW4Nn5dY/v
	9x/1JZc+75wGAqOvne6xBEb5P3d5LP0wn8O7d+/6RUl2ZASNUUulQCzox+mNgCGM738v+nGlq+C
	f/OG4O4Eot8aInlNN+Uw3EbrRKeNkj2zhGgIc22KLLXhpthSFPDLb+4MuTuXP5PiDD/P9IM/9vI
	578lk92rSJf4Mbj25oDENXwpQ5/nnxOWAFQD1NFQGbRFTF5rXWIJeZT5WEWMTqqewGOXrseNMgH
	THCf7GfQrS328o3ovQr9oDKis4tQEjjFX2ihpfA9Z9XqX6TdfAvJvbsbDx1E/nh8nCOop2cdB7L
	U0kYpv8TZPt+4akWT0Bpqe0WIUPRnFFzrvCkfZMjMwqVycgXK
X-Received: by 2002:a05:620a:4109:b0:93e:c12c:4412 with SMTP id af79cd13be357-93f6f8ce27cmr271339185a.78.1792743036262;
        Fri, 23 Oct 2026 01:10:36 -0700 (PDT)
X-Received: by 2002:a05:620a:4109:b0:93e:c12c:4412 with SMTP id af79cd13be357-93f6f8ce27cmr271336785a.78.1792743035688;
        Fri, 23 Oct 2026 01:10:35 -0700 (PDT)
Received: from localhost (net-93-144-6-81.cust.dsl.teletu.it. [93.144.6.81])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e38063e62sm3172727f8f.57.2026.10.23.01.10.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 01:10:34 -0700 (PDT)
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Date: Fri, 23 Oct 2026 10:09:54 +0200
Subject: [PATCH net 2/6] net: stmmac: drop split frames on AF_XDP zero-copy
 RX
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
Message-Id: <20261023-stmmac-xdp-fixes-v1-2-efb37e19f5bd@oss.qualcomm.com>
References: <20261023-stmmac-xdp-fixes-v1-0-efb37e19f5bd@oss.qualcomm.com>
In-Reply-To: <20261023-stmmac-xdp-fixes-v1-0-efb37e19f5bd@oss.qualcomm.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Stanislav Fomichev <sdf@fomichev.me>,
        Jose Abreu <Jose.Abreu@synopsys.com>,
        Ong Boon Leong <boon.leong.ong@intel.com>,
        Oleksij Rempel <o.rempel@pengutronix.de>
Cc: netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        bpf@vger.kernel.org, Nicolai Buchwitz <nb@tipi-net.de>,
        Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDAzMiBTYWx0ZWRfX4cKtSn0P2uST
 ANkt3n258pzXklsjxjsNnSIckhURel5W+G94ioE2hGN9jZeNXlLOPEZUZAwIcv/i5vzDY6WJO7W
 cgLXOaRq978+MRXl/XpX3WQdYKq0+Mo=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDAzMiBTYWx0ZWRfXw3UbKkGqFiAm
 hmoWHwkhi4Z9D4WPRRVzyTRheWsXy2+2cDXN+Dli1GVJRQhGvsr18IEIHuR8IoTA1PDkyiJILJA
 XFONa/jC+kVnXFw2UCJurQsQnVSa4y4AJuyj1OyH+XZ63Catn0zNYdpYEJd5RDKaZS7BDNshc0o
 1j9w5HnzRWtH56KIL3l1tMoZTlZiZUT1LIfztk1K/axrtfqgIWDoI/OixK5hYFGqBvRvpkDpJkZ
 F3/CKKs198h6Fjmp8HdPtr511+e9DWD8I1kfJEKq4K10QiNfcbWcmrp3U2EvAV+ESF7qB05sh+q
 vDCw30gjTEFgYeK8JzdCcTUBUF4ktQQDhDQKxLrBdClCzTNjJV51iA9mq+Dj4/Zq/9homInCj86
 peF127ZMk6vLnZl6m4/QwGEl9FNpGSlAFB6Kg+QO12DaqUvPW2rWpJW8+1RyJguqDoFoDjmSv+n
 Xo3TRYEVe6ua1/FGkFg==
X-Proofpoint-ORIG-GUID: 8sOiwpWWJ0PR7QeZkTEzFb3Hx5faPLXf
X-Authority-Analysis: v=2.4 cv=Nt1E4MdJ c=1 sm=1 tr=0 ts=6adb167d cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=7fYLNvKHbgS61GKHX+yayQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=6POjKhNZmwZEydtLWKIA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-GUID: 8sOiwpWWJ0PR7QeZkTEzFb3Hx5faPLXf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 impostorscore=0 suspectscore=0 malwarescore=0
 phishscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610230032

stmmac_rx_zc() assumes a 1:1 mapping between a received frame and an
XSK pool buffer and drops any frame that spans more than one RX
descriptor:

        /* XSK pool expects RX frame 1:1 mapped to XSK buffer */
        if (likely(status & rx_not_ls)) {
                xsk_buff_free(buf->xdp);
                buf->xdp = NULL;
                dirty++;
                count++;
                goto read_again;
        }

The non-last descriptors are freed and dropped, but the frame is not
marked as errored. When the poll reaches the last descriptor of the
same frame, error is still 0, so the fragment is handled as a complete
frame: it is passed to the XDP program, copied into an skb on XDP_PASS,
or converted for XDP_TX. The tail starts in the middle of the original
payload at a predictable offset and, parsed as a fresh frame (len == 0),
stmmac_rx_buf1_len() reports the full dma_buf_sz length for it even
though the DMA engine only wrote the tail remainder into that buffer, so
the reads extend past the received bytes and can reach beyond the end of
the XSK pool buffer. GMAC4 always enables jumbo frames (GMAC_CONFIG_JE
in GMAC_CORE_INIT), so an on-link peer can trigger such a split even
when the interface MTU is left at 1500.

Set error when the 1:1 mapping check drops a descriptor, so the
remaining descriptors of the frame - including the last one - are
drained and released with xsk_buff_free() instead of being processed as
a new frame. Account every freed buffer with dirty and count the
dropped frame once in the poll budget / rx_pkt_n. The direct 1:1
mapping drop also increments rx_dropped.

Normalize the legacy normal and enhanced descriptor callbacks to report
rx_not_ls together with discard_frame for non-last descriptors. This
allows both stmmac_rx_zc() and stmmac_rx() to drain split frames on
dwmac100 and dwmac1000 instead of reparsing the final fragment as a new
packet.

Fixes: bba2556efad6 ("net: stmmac: Enable RX via AF_XDP zero-copy")
Fixes: 644b8437ccef9e ("net: stmmac: dwmac4: report Rx checksum errors in status")
Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>
Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
---
 drivers/net/ethernet/stmicro/stmmac/enh_desc.c    |  2 +-
 drivers/net/ethernet/stmicro/stmmac/norm_desc.c   |  2 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 21 +++++++++++++--------
 3 files changed, 15 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/enh_desc.c b/drivers/net/ethernet/stmicro/stmmac/enh_desc.c
index 051253601225..297e2428a8f9 100644
--- a/drivers/net/ethernet/stmicro/stmmac/enh_desc.c
+++ b/drivers/net/ethernet/stmicro/stmmac/enh_desc.c
@@ -184,7 +184,7 @@ static int enh_desc_get_rx_status(struct stmmac_extra_stats *x,
 
 	if (unlikely(!(rdes0 & RDES0_LAST_DESCRIPTOR))) {
 		x->rx_length++;
-		return discard_frame;
+		return discard_frame | rx_not_ls;
 	}
 
 	if (unlikely(rdes0 & RDES0_ERROR_SUMMARY)) {
diff --git a/drivers/net/ethernet/stmicro/stmmac/norm_desc.c b/drivers/net/ethernet/stmicro/stmmac/norm_desc.c
index c4b613564f87..d19bf7ca4db3 100644
--- a/drivers/net/ethernet/stmicro/stmmac/norm_desc.c
+++ b/drivers/net/ethernet/stmicro/stmmac/norm_desc.c
@@ -70,7 +70,7 @@ static int ndesc_get_rx_status(struct stmmac_extra_stats *x,
 
 	if (unlikely(!(rdes0 & RDES0_LAST_DESCRIPTOR))) {
 		x->rx_length++;
-		return discard_frame;
+		return discard_frame | rx_not_ls;
 	}
 
 	if (unlikely(rdes0 & RDES0_ERROR_SUMMARY)) {
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index fba21599a5e1..3fa2c15222d8 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -5710,18 +5710,21 @@ static int stmmac_rx_zc(struct stmmac_priv *priv, int limit, u32 queue)
 		if (priv->extend_desc)
 			stmmac_rx_extended_status(priv, &priv->xstats,
 						  rx_q->dma_erx + entry);
-		if (unlikely(status == discard_frame)) {
-			xsk_buff_free(buf->xdp);
-			buf->xdp = NULL;
-			dirty++;
+
+		if (unlikely(!error && (status & discard_frame))) {
 			error = 1;
 			if (!priv->hwts_rx_en)
 				rx_errors++;
 		}
 
-		if (unlikely(error && (status & rx_not_ls)))
-			goto read_again;
 		if (unlikely(error)) {
+			xsk_buff_free(buf->xdp);
+			buf->xdp = NULL;
+			dirty++;
+
+			if (status & rx_not_ls)
+				goto read_again;
+
 			count++;
 			continue;
 		}
@@ -5730,8 +5733,9 @@ static int stmmac_rx_zc(struct stmmac_priv *priv, int limit, u32 queue)
 		if (likely(status & rx_not_ls)) {
 			xsk_buff_free(buf->xdp);
 			buf->xdp = NULL;
+			rx_dropped++;
+			error = 1;
 			dirty++;
-			count++;
 			goto read_again;
 		}
 
@@ -5898,7 +5902,8 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
 
 		if (priv->extend_desc)
 			stmmac_rx_extended_status(priv, &priv->xstats, rx_q->dma_erx + entry);
-		if (unlikely(status == discard_frame)) {
+
+		if (unlikely(status & discard_frame)) {
 			page_pool_put_page(rx_q->page_pool, buf->page, 0, true);
 			buf->page = NULL;
 			error = 1;

-- 
2.56.0

