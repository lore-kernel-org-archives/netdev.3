Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2374145C710
	for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 09:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792143161; cv=none; b=qxFvZKT5vnHY802nUjNKxIK9tMlKZ9xtdRUZsQvwI5H3lzGuOpNLyZ61nYZ68JKdVA/p3IeGrmqk1HK8Q9FjfZZ4Uzk4bo8rBJIOHi/DML8BIjNX5s7jomqEIbRZobGbjA+AsTLDbpvfTEV0FHi+i8x83hdlRXkwt8kXhtQr1g8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792143161; c=relaxed/simple;
	bh=3OTy30U9zaA/EoJrB2LEVikw7T9erylLWW9kg7srSqA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aIS55n9MSnfaspi+J9F99NbDfvL+gTgGPrOtCAKaCiwnE4UYi3c471Gm9PzvBVJXuqM9MiwIUM+7arEHgdqKmb3EnB1epo0UHiWUhlD0lORkyCrRfWT9e8VHBnA7aGK37f9NeDuyCZc/0+39rP99Hijfhw/W8m0eMLlse6qBWKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lG9eWanX; arc=none smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lG9eWanX"
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-35f1f76ea84so3251638eec.1
        for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 02:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792143159; x=1792747959; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uV/uHpIyvSDg1rMqWOrJjW5nbbNl8aiS8yrcLtotir0=;
        b=lG9eWanXp6F34VL+5KABtmaUD/FqjI/9F1aRT5KoeQsWikE7x4YtnSIg5F2/ZPg8Dq
         PePTpdsCVU4ZWXqstpXLsySY4u9tBu1lrbUykdf9yk2JO2fxO17cX5IdogM+kq2ndZS1
         BPQOv9MrXmSaMx+HIg/c5JAGEO3bBQakipVu8VcRIxEFe+4dWirEnWCvlp8hdOkOaDhT
         CI0ThqY8xcgrcQmTG+scdgYqjTixt3eJGCbZRX2h3CThnRuwmRjoSC/6mu0nHH23ElF6
         azoxe8JwGb031mFgckOWiSzV3psUNE8eWaLFLrqN8yseVA5GtEJoTOd1I5UAMYBKGtFL
         +gIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792143159; x=1792747959;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=uV/uHpIyvSDg1rMqWOrJjW5nbbNl8aiS8yrcLtotir0=;
        b=ATx/y4gaAq7D5gxVNNsAlDOGZClL93/IvT2Whsar6lmKuVk7Cqc83/g/TRB+2Td1nq
         PSmCaOlfgXVIFxy26VBYXYTYE8yCS+IEm13jsgdwvxTMH2wTyN6eyyzNH5w54chlVnfD
         3t24n7jd4h5pIeqxJZ74zMUNEis/10YyVRWAa7d4/32edG2c4UCgd7sO9Wmyb3qVEVYy
         EcTedoQuRgCfJUS9LS1eYs3M9FnqP1/QlA55VTuXVpBuyDFkJ/lIXp4lM0GHAeld/Waq
         UI/Ue9yQCgOX8MMTH4eB80j5tuajdQDHC30LY8wOjBhxuOUmDSXaxCJaNKqWENgevElS
         a5VA==
X-Forwarded-Encrypted: i=1; AKwUvBwwOaeW06Cb49VCprl6bJmpMPbHB7e4Q0tS+twJPTLbe2XJrKSBAyUEgVbg5vTlvxVDL9jM9Wk=@vger.kernel.org
X-Gm-Message-State: AFq9FYJC5ySKGAjDP+Se8cneHIDTyE8jqe0A9vZLmyFyIxO+FH3qwFZ7
	dFRKEWI/bwckrC8O3D+M235CcKG2wLCxlDf+Y3qyJkcwW2+VCFNRFGD+tWF25A==
X-Gm-Gg: AYBFou3P8I4Kz9LlWy2Gs/Q4Koqbqrh+0QvCy+PooaUkL2mfKFFAAn+8ZYckZX6TT+A
	RVwbJZVmIl2nK0hTofOCXZJh4OLcyxe2YnQjjDogbydulYu+3xmvY1xXErRHaREx7Qw4jLodNL8
	HQD/B7yLw1oKxDCAdL+CHHBC445/MF3/wXhufUHHP355yvEbeT+Qr31e9OHsHknZk2jVWfD+WqQ
	3JfpoxHXbqObsiQ9hjcCZTnrRZEVjEOl7+KiTh9du77uGIUikie2H75IC3So1CMkUiU6C/FJiQx
	LbSpR494DWmoSL0M6xTzwNxamDhkTdREaI9mnaOVg+aZtrvcZDXYMbw/Z5635cxC9GvYRH0sXWe
	iShmxy08hixJOc03R5siGj//b9Jn8aIRMl1q/eljcp9SI+QBp/PckZIHMi6F+zfoaEfdybVDLZ7
	BP5kGFH9tG/hoKZjVrwGYfnNyblMP3+TU7L+Jc7qamNDYWzzHY2xOlfIas/eB1OPw84ZRLDBwEA
	QD1DVuuSI3BPZNU8P5AXAny26GhkHbG2MmlozL05az2+imDjI+kxZIoXFZWgE1gzIZ2uilGIii8
	4aEfA0FeTa9bDtv1whJb1i23gCQ183CrldUn0pHYUlg=
X-Received: by 2002:a05:7300:87:b0:360:c266:cddf with SMTP id 5a478bee46e88-360c266d46amr1747387eec.5.1792143158891;
        Fri, 16 Oct 2026 02:32:38 -0700 (PDT)
Received: from ramen-dev-security-2.asia-south1-c.c.ramen-dev-345017.internal (90.156.200.35.bc.googleusercontent.com. [35.200.156.90])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-360820a79c7sm5157172eec.18.2026.10.16.02.32.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 02:32:38 -0700 (PDT)
From: Anil Kaushik <anilkaushikwireless@gmail.com>
To: Pablo Neira Ayuso <pablo@netfilter.org>,
	Harald Welte <laforge@gnumonks.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Shuah Khan <shuah@kernel.org>,
	Stanislav Fomichev <sdf.kernel@gmail.com>,
	Nicolas Dichtel <nicolas.dichtel@6wind.com>,
	osmocom-net-gprs@lists.osmocom.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Anil Kaushik <anilkaushikwireless@gmail.com>
Subject: [PATCH net-next v7 1/4] gtp: set a valid genl command in PDP context get and dump replies
Date: Fri, 16 Oct 2026 09:32:22 +0000
Message-Id: <20261016093225.1036375-2-anilkaushikwireless@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261016093225.1036375-1-anilkaushikwireless@gmail.com>
References: <20261016093225.1036375-1-anilkaushikwireless@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

gtp_genl_fill_info() stamps the reply with the command its callers pass
in. gtp_genl_get_pdp() and gtp_genl_dump_pdp() pass nlmsg_type, which in
a genl message is the dynamically assigned family id rather than a
GTP_CMD_* value, so replies to a PDP context get or dump carry a
meaningless command number.

libgtpnl ignores the command and is unaffected, but parsers that check
it (for example the ynl tooling) treat the reply as an unknown command
and discard it. Pass GTP_CMD_GETPDP, as gtp_tunnel_notify() already
passes a real command on the notification path. No uapi change.

Fixes: 459aa660eb1d ("gtp: add initial driver for datapath of GPRS Tunneling Protocol (GTP-U)")
Signed-off-by: Anil Kaushik <anilkaushikwireless@gmail.com>
---
 drivers/net/gtp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/gtp.c b/drivers/net/gtp.c
index 4aff23bcfdd1..99836b773e5c 100644
--- a/drivers/net/gtp.c
+++ b/drivers/net/gtp.c
@@ -2279,7 +2279,7 @@ static int gtp_genl_get_pdp(struct sk_buff *skb, struct genl_info *info)
 	}
 
 	err = gtp_genl_fill_info(skb2, NETLINK_CB(skb).portid, info->snd_seq,
-				 0, info->nlhdr->nlmsg_type, pctx);
+				 0, GTP_CMD_GETPDP, pctx);
 	if (err < 0)
 		goto err_unlock_free;
 
@@ -2326,7 +2326,7 @@ static int gtp_genl_dump_pdp(struct sk_buff *skb,
 					    NETLINK_CB(cb->skb).portid,
 					    cb->nlh->nlmsg_seq,
 					    NLM_F_MULTI,
-					    cb->nlh->nlmsg_type, pctx)) {
+					    GTP_CMD_GETPDP, pctx)) {
 					cb->args[0] = i;
 					cb->args[1] = j;
 					cb->args[2] = (unsigned long)gtp;
-- 
2.25.1

