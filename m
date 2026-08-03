Received: from mail-oo2-f8.google.com (mail-oo2-f8.google.com [74.125.231.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E055729992A
	for <netdev@vger.kernel.org>; Mon,  3 Aug 2026 04:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785731789; cv=none; b=OApT6c/e4MPICwCVvY9f+VRlr95ErBQ5ZgIZlrHktRWsww4x1caFZ723kC4rQlIsYrNGnetGs2WHNPRsqads4lgJm3nDNAzMZ8lgh64Bw5iVKAxju5dIgaKCDeLb0oWj9ABFZdEQTfbL6xnziIM1BwIWNPwfTjVxxiBhA/YUrnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785731789; c=relaxed/simple;
	bh=aFevONfkoar+s7y4dxqv3Y5mvKC0hWv9S4MCYNJspV4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ahQmk2MHSATtKeFX5Wb9gTsMou7CuxKshG6FaHELL5y+Lvex2kQDVQAfX/yO4HDwKDaDvqWE0h309NXB/Y1Y/Gse/gV10Q2gY8gAAqqe1UXq8tt68HPUMAcJLiBMGkv3WGgvMpaeBYV4qAbdO18rKFBZvpiYISzeN427VzaD770=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kU5Jy5/U; arc=none smtp.client-ip=74.125.231.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kU5Jy5/U"
Received: by mail-oo2-f8.google.com with SMTP id 006d021491bc7-6acc20cae62so459400eaf.0
        for <netdev@vger.kernel.org>; Sun, 02 Aug 2026 21:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785731786; x=1786336586; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=pUJUjFaMyCEmbsujgX0sCdV3eDwcy0rATL2iPXfXerU=;
        b=kU5Jy5/UXqpyO6EfDh5boszIlGAy9udrcB8uT7gNLmWZ+sOkXGnnPmdh72Aw720+9J
         IqtG7BPIeOdeFpveKNe8sZFP1RwTHbpBTel4uvBreNleWv9FDePyotWWNM5JZcJ4r88q
         +6rBvlMqYQAnXQkIFo+vTZItz4Y1VWuuBanbjmbiP0rVetz6/ADHxn0e/ouiKIZOUVZr
         xgsYTzkP3KC+qLmgGXrkhUPaxRFrDOtLqCrLwB2YoJXsT2Y9PLVENrkFkYrEYlIJbidQ
         IoXQDyqd/KyZuvcIodQrAgXNZhZ0dpksOx1cjlsPxV95axkANXYNVQNNJVgQiRH3MVpQ
         Eh6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785731786; x=1786336586;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pUJUjFaMyCEmbsujgX0sCdV3eDwcy0rATL2iPXfXerU=;
        b=N2w1BymieSA1YMUAfMgdKawuK7akbSNN30Q4YpBCvvyq77P8i4cM+dtTkyVneZY1Jn
         097n5AaOelJQfpSWMNj/t1KBgKrHRlb0bLhnsMK12eZaSAWAQpbxBcun548fUIBxuRsp
         /ZAr0WfOlmdlIxqorNmV/UkdnOM9EnS231rVWsyDvlq3FktIWJf4tu5nGw9yqbWTrpcS
         2BpaDV5E5dQXF6b6h0kA1UXtumtAA87XlyggXmYZStFU9FQ32j7GpFFTVzoTu/nNtLm0
         Gs1dwmXddGpYBcKNYsYcyRGTkdmRBEIs5JVigN64HZbIYRR5DoujaapB3j2Yaq2PVA7M
         ZqYQ==
X-Gm-Message-State: AOJu0YxWLAivvOR9M1RxlCffB+q4tNgP77XmB6ItFiSraizXaHYsjBo+
	e+ULwYuw++uJKz3/gJTAETHUwOHX2TJpF50f5iyYqwbL8I/vPLRhlLpHSxVnX3y2VI0AfI/r
X-Gm-Gg: AR+sD12pDCDNbScgDUOeiwXsHXqsfz3Ksu+UvaX4QpexODlNS1mN1rS5VEnOWtGApE3
	5PUC5LHmgZnWX4dNKfRNMU+bkhAtZzI4bUFo07TsWOsTB46XIOeY1di9S7kP1ASrdn9eK/vwB2W
	qOu1/bjCtlnaHVv9rv8tDW+1yhWxycLZpN+iInkGG2J/H5eeMP62Pf7VouNepBrB0NMiHW5i2Zr
	sTMe2ISOyxlHmcl5gW8clY1AYygtazNcesUDZLj/Zw0fRaOr5BNcsWDTVNeGP+RK91/DWqvoBgG
	brsS6UPN4bwT/zizGoNoBSIXqqbAHxy7sYHurVy26lybOUFl9Aq6BOMvu+d2rbxmT7OkAgzSBMe
	bwAOEGVf2gd/hTTHZ1/iC4K1fHHaBI15HCLDr4sDwimFpTeqfoC95Pz0RXoqULyQSUvJqbPTsVk
	ug+SZn+ephljBQOMP+n9o/Z2gLJVo19WG+4JupcvBD3zQhg3aHUJiHf9bZV1GWoSxkuiDsF3kCM
	6qDZS4L4hrusqvBtO60ATJXkw==
X-Received: by 2002:a05:6820:8583:10b0:6a3:76ad:8ee2 with SMTP id 006d021491bc7-6ae4358741emr9084829eaf.24.1785731786676;
        Sun, 02 Aug 2026 21:36:26 -0700 (PDT)
Received: from localhost.localdomain ([14.22.11.165])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-458f6068c01sm8035008fac.1.2026.08.02.21.36.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2026 21:36:25 -0700 (PDT)
From: Henry Martin <bsdhenrymartin@gmail.com>
To: netdev@vger.kernel.org
Cc: sam@mendozajonas.com,
	fercerpav@gmail.com,
	joel@jms.id.au,
	Henry Martin <bsdhenrymartin@gmail.com>
Subject: [PATCH] net/ncsi: fix heap OOB read in NCSI_CMD_SEND_CMD payload length
Date: Mon,  3 Aug 2026 12:36:18 +0800
Message-ID: <20260803043618.3210301-1-bsdhenrymartin@gmail.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ncsi_send_cmd_nl() takes the number of bytes to copy from the
attacker-controlled ncsi_pkt_hdr.length field of the in-band packet
header, while the source buffer is the NCSI_ATTR_DATA netlink
attribute whose readable size is nla_len() - sizeof(ncsi_pkt_hdr).
The two length sources are never cross-checked: only
nla_len() >= sizeof(struct ncsi_pkt_hdr) is enforced.

With hdr->length set larger than the attribute payload (up to 65535
against at most 2032 readable bytes), ncsi_cmd_handler_oem() copies
past the end of the netlink attribute buffer with unsafe_memcpy(),
leaking up to ~64KB of kernel heap memory into the transmitted NCSI
command packet. The destination skb is sized by the declared payload,
so the write side does not overflow - this is a pure OOB read /
information leak, reachable with CAP_NET_ADMIN on systems with a
registered NCSI device (e.g. OpenBMC on Aspeed BMC SoCs, where
NET_NCSI=y is standard).

Reject commands whose declared payload extends past the end of the
data attribute.

The issue was found by the autokbug dynamic kernel fuzzer at Tencent
Yunding Lab.

Fixes: 9771b8ccdfa6 ("net/ncsi: Extend NC-SI Netlink interface to allow user space to send NC-SI command")
Reported-by: Henry Martin <bsdhenrymartin@gmail.com>
Signed-off-by: Henry Martin <bsdhenrymartin@gmail.com>
---
 net/ncsi/ncsi-netlink.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/ncsi/ncsi-netlink.c b/net/ncsi/ncsi-netlink.c
index 2f872d064396d..29f9dd0b62dc2 100644
--- a/net/ncsi/ncsi-netlink.c
+++ b/net/ncsi/ncsi-netlink.c
@@ -461,6 +461,11 @@ static int ncsi_send_cmd_nl(struct sk_buff *msg, struct genl_info *info)
 	nca.req_flags = NCSI_REQ_FLAG_NETLINK_DRIVEN;
 	nca.info = info;
 	nca.payload = ntohs(hdr->length);
+	if (nca.payload > len - sizeof(*hdr)) {
+		/* The payload cannot extend past the data attribute */
+		ret = -EINVAL;
+		goto out_netlink;
+	}
 	nca.data = data + sizeof(*hdr);
 
 	ret = ncsi_xmit_cmd(&nca);
-- 
2.43.0
