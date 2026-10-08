Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C19704D4885
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 18:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791483050; cv=none; b=apaBj6km2u4MBqSwiQvxZZbOOBWr9xrZsd7d91X7jEjAyFILXHcGgrQEZD8isCiauf072kgamnsTaF+JRYM9Y6WKPoiKD49mo8zAw4OyB7Th4toUfUwjBUhPNOHu6vxfLwK9Oz506LV8uSHBzmKZF+2rv8lI3ujVROKhCJ5GE2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791483050; c=relaxed/simple;
	bh=nuodlO8O5s7zrDX5/UNeJ3IiRnHzTsUkm85sKokUP9s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=E9r03T6aaH7ldGvCvhytlm6YDXRV59A9RyzKACPzf0vztOfZlU13IASZNts8evsDSwkirvHYkUtyzxwssk8+VH/UykQ/DrI57kJFCyogwOooXGJ9sCuICZXQNDkA4MRFe5Hd8lKU2vIjDdlZA1GGZwXW1GZqHjGeTNOJ00iItFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XkE8Fvu/; arc=none smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XkE8Fvu/"
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-351775aa1c0so1733811eec.0
        for <netdev@vger.kernel.org>; Thu, 08 Oct 2026 11:10:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791483049; x=1792087849; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iGYcOJcF0oZUQLIO0eks08a1W0+2j2uia1YjT6l0DhQ=;
        b=XkE8Fvu/fgTuyxWSA7bdOiCN23dACVbfgYleAJN9opfQpbMIJNcqvWEUHR34TaPVOv
         Cp3xXdvPaPyh33iV/4EIPCXKipaN4wfEv8DmvmJffF3u6AEOVrC4ZnN8uDLodcazMv4b
         8bbw4mhqHsAZtZh3+paYPR3amkJDbr8PTQQfxXZ4bjUeeb9WY8CmEuL+kcgZw4xzSSSb
         fc06OZ1CkMntYhzpiq4ylAm87H7qEYsOosczTmlxrxO0cvVTROyqj/zN5fDmxnMwRjCM
         KMC34F0xfGQr2ydtukyXL1mKNK5ZPkKj2aemjnd4D9jFre96nPWw7zL44mY7EWOKFC3x
         Doxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791483049; x=1792087849;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=iGYcOJcF0oZUQLIO0eks08a1W0+2j2uia1YjT6l0DhQ=;
        b=oRmEYw7HnTdtyDLdyP/ONoZaNuTonimsdSO6AGURdbnVLPCp85ecfRrdC45MT+w/+h
         8heNQuC1XrOgeVWpfhveR1Aqu85JSYZA3YKsWtT6E6lKQdFytfusKvJbRd2jRPuEwpPh
         jLlZQhCiqtV7cUqk5sDl54l8OcZ9yJv+JdbxtxI6BKrvEBC4icDJh/kbJPxgqMPI+PZZ
         e9oo4eCvVUkwzLMh1hLWHKCS0HKT63lrX95+01Yfb+bQp0mge3MVBXrj/fVnDIQT+Byh
         FniO/cGaTimXo0Xo0if+/ePmr3RodaL7AbSjlWby0YYkDEPrCMvZ+urkK6eV43zSFT1F
         wUCA==
X-Forwarded-Encrypted: i=1; AKwUvByuPmpMolqO6kvjQy/qVgs2gjS62W8XUkskCzO8qt2lwP81j9Ycsm+z6yBd5hu8ObMoXJppvfw=@vger.kernel.org
X-Gm-Message-State: AFq9FYItBkYCwlDgPS54XYCWKXcOQqqAasQ0cbnHSfInWrbOdKVANaLm
	Jyw7sSPZEXMHqniP0mJ6xMELyFgWWqfFt2f+LGQXgZQhFaHfiovpFJtX
X-Gm-Gg: AYBFou2V6qJnTEHt1VTiEvE+rEhnZgpU6M9l2Q8yg7sjfKtLfHSMOVF1GLrqPDJYqhx
	M9PqLdqF4116gYUEbhWf8QfKeETO5ubdYMH6YteIxxCuEuD7qKZw2YzawQksynskJ4+MHap6boz
	U26LOhyU3wPKZz4gTRN1/VEcgBe6ZQl6McsTNXA2Kr5OU4/rUw/xKV6zEI9UuNf0ppuU9KeCKP5
	micat/ne6AsVdO0no9L6TcyXySg2Bl2z/TvBSNYQDmsbYmkNOz1GY3o9bNRcmEY/O/ANZUn5c1t
	/KF9GpPp5BhBddGgxeVNYY+OYhikH9u6u92FJEyPCyPK0AIrnxJG5tlNsRvIXEebK6BgnAVIIB0
	i4V2QtLBIfElq2wqQ+iHXptFerjviqM3NDx9P3by0lGfx9bp09N2BqnH/qRUYodfwRtFj7ZuGyL
	suoLYVbsxzVb0jjoTiDOO4cmoAzGwxqyHNABvcPlYtl1m2PLTYhHa1CbKPa3DNX4dn53+oDWGac
	DW2g6G0qtijRsMnZonpDlzA8gJFBvPZEsJRiXNPka6mUer+Umy3TlCm7nW/U1rmXuppcXsQH1+w
	JcufBUR8Jn/wt2mSpiCruET6cmqLAxMXp4Yyl6k9f08=
X-Received: by 2002:a05:7300:fd0e:b0:352:3bdd:423b with SMTP id 5a478bee46e88-3523bdd4437mr3732131eec.21.1791483048483;
        Thu, 08 Oct 2026 11:10:48 -0700 (PDT)
Received: from ramen-dev-security-2.asia-south1-c.c.ramen-dev-345017.internal (90.156.200.35.bc.googleusercontent.com. [35.200.156.90])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537b479e76sm162161eec.26.2026.10.08.11.10.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 11:10:47 -0700 (PDT)
From: Anil Kaushik <anilkaushikwireless@gmail.com>
To: Pablo Neira Ayuso <pablo@netfilter.org>,
	Harald Welte <laforge@gnumonks.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	osmocom-net-gprs@lists.osmocom.org,
	linux-kernel@vger.kernel.org,
	Anil Kaushik <anilkaushikwireless@gmail.com>
Subject: [PATCH net-next v2 1/3] gtp: set a valid genl command in PDP context get and dump replies
Date: Thu,  8 Oct 2026 18:10:29 +0000
Message-Id: <20261008181031.4129029-2-anilkaushikwireless@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261008181031.4129029-1-anilkaushikwireless@gmail.com>
References: <20261008181031.4129029-1-anilkaushikwireless@gmail.com>
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
index 4aff23bcf..99836b773 100644
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

