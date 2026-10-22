Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792697385;
	b=2XWg22RfXKS+yTKgO+9NX5vMzR0jLuJmzCLIDOm46ykhdonBcBhZhXfi0A3/ogyZWY21
	 RvF60uSJi8kHY5gbY8IDSGw/APzt2kf90yM0pyoq4tJGHsLY2oBPxZzpvyo6SxQf19ism
	 SJVIZxmzTyQ6DnPbcvhTEDrWWwQy6HZv9/csE4rAeL0chlUm/8xEughB1wFcgn47HOBR0
	 uonhYfYWlRf/EGGmhbRekMEcwtid4EZSHYVPUKNlHzN56hKk0FwGEg49ByaiItnwqDgAb
	 DgNJGt5qr6PQxCkM/q6+50qTHomtIzi7GS08M2MAVYeWUZo8Lmuz+GHTe7JjWMrrbAg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792697385;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=vRcYocxYeE356P8NCRi5UEknFH50Sj9wm5l4dS4YqFk=;
	b=OyYQcnk6tZc64TCFzJf0aaascHTSQS/G3B7Ajjg366agb2uPGuxwkF8RG6GnqWZ4syGM
	 DuG/PnDbgBc6gFwA1NVr3p/tLGTWqPzVTewi8TEc3tycIXIgWVJVFoPDRdDSgFax8UZZK
	 OE7I6/+V22gLR6hiRjtT+OwWF5NMWzibAFdKv0lJ0j1PJbtXux1Bz+NZnAwkYdrrmVYwF
	 iMO0H2ZTCLYgmIfyGRayJBfWn9oB113UsLRpLFqeQ6eNbEut5NyBlx2EdyVAwEjQNtT6m
	 FdnP9ElVZysYXg3CZOgUndFVrnXdpJmDZkccKIp+zrQ8Wd4rSZ59pov8ffvCirLoFvw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=eybf5O26;
	arc=none smtp.remote-ip=209.85.128.51
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F08BA606A328
	for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 19:29:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F08BA606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=eybf5O26
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4956869750eso996415e9.2
        for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 12:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792697382; x=1793302182; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vRcYocxYeE356P8NCRi5UEknFH50Sj9wm5l4dS4YqFk=;
        b=eybf5O26/k0l3v1MO/HK/DnPVSLu3bmHgW5gD1yHGwSVJ/LgXOsE8JFRGK455xhJiy
         zb5eNfqAhNy5n4VD2sR2+IcYNQkanuCAn3jsv3eRGNHsc/IwV49fHhhEMZ6rJARvVus+
         3Sw8a+QKG0QE0Of08QVSb3mF6VWXl92LJmJsP5uDk/Vr4NWpkEaiz4pqY7q6Juw2Z+FH
         DKTPVAzxJ8wv4iLNo4tJXJ1kSjZEuKTEFd/Sjs9xU0VUbJehyfmQwMC7kYsp59r92uWa
         V/ZNI02wkVVCRFHW3mdpNVO87xsXIvFknnHFPw5jcRp1goLHEi1cL74QTWwCscVmehjY
         p3Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792697382; x=1793302182;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=vRcYocxYeE356P8NCRi5UEknFH50Sj9wm5l4dS4YqFk=;
        b=OJVrMhMXO24sJchoyPMBQDheASPY6QltYuT7lcrL+5MVYEcAcFBNsZ+reh/bxaCHsF
         92MIKNsiEoAXOtCrzNm9n9cssKuVyqw84VG2pgI5WfLaR9L1zJ/tSl/FD2jY1al4eusB
         4jpz2euRpzeANTMrKRwZQY9O2FFD5zCnzM55toHOPnv5S+YtN5rf7hh1uc6wKrX/HoHV
         32rW4Emhtmstv5z6HUTDJSrmuQtqBZ9iVspTZnyI/6w68S5RydhJaL33gEKo33uTPLgx
         v1Ckui1yo57GYNRMIx3O0Fknkf9zPM6d9ybaClZs2Mj8N7DJUt1Xfmi9ioL1HnWctWfy
         NwNg==
X-Forwarded-Encrypted: i=1; AKwUvBylVZRBCb8vcipv/C9bpysZsIRVoPokYDQBeL+YnaPVnoWVip6wgxpzZ4LpvwH6hCd13b5R/7Q=@vger.kernel.org
X-Gm-Message-State: AFq9FYLWqPbqr9MDNH7DD363tbhSuorMtGk/MSf72qqV1mzc2i/0n6hc
	3Keg84O9zDmOdTe26Zq8iCe+8iTjNPQoili4QQT0eql6zK2CyQ98tO9B
X-Gm-Gg: AYBFou3aQw1YeIEJ/0XdIbrVj+Gn2dUgdEeDLJq9DzFPRYFpDMzKP78NqmSCbfwcEze
	5hCoUEpQ8Q/ixox2BT0R1UKC01GybpMDSIEmt2cIyHcnGndOo+xI0TsD8RxXaPqCTkIzj2Gb8VO
	YTzk9apQpINtkP2QbUIQVlsFCL9FLFgruRSTUV4z8hTUCszlX7xI7vxLxolmf2gjEkO7ETo7vNP
	kYv0R+EfMXrTS0watTCEK1EkwO1H3thAsnOd27QTiq6c6KKIlmh+lO+fGsl7y5F2cLroqX/Va6p
	9VZ1Qj5w9bLYG46thbHXfLLFj4R+Szb+fDG2yL5D7bZChEj6ZIdWsdrXJE+NlrmMj2yAZxJnmFu
	bvvEsMzd06X1Ae2f/peF82AipM2r65EExxDKjzai9GGUrV5GQTWMSwLzKssFhdvm5pylas/TttI
	f0hVU0HvVHXw2MZrCojAGALrnJ7wYiptudhlAfP+9f9J8eDBx5VqsdjUf00O5cgWsu0uimjYSMo
	BPBNnn5Ie5OGxnPyxStNhT3u+LxRHR4dLWI0oYTnBF7GbdJFSjyBeTZYAbigupx6okUj4fjD2/E
	UA==
X-Received: by 2002:a05:600c:8b32:b0:4a2:397:73e9 with SMTP id 5b1f17b1804b1-4a211ed726emr662605e9.18.1792697382440;
        Thu, 22 Oct 2026 12:29:42 -0700 (PDT)
Received: from VivoBook-ASUS-X712UA-M712UA.lan ([2a00:f44:c12:cf67:2010:42d8:74da:e279])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a2101cedcesm20269405e9.0.2026.10.22.12.29.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 12:29:41 -0700 (PDT)
From: Stanislaw Pal <kuncy7@gmail.com>
To: Christian Marangi <ansuelsmth@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net 3/3] net: dsa: qca8k: check the length of MIB autocast frames
Date: Thu, 22 Oct 2026 21:29:33 +0200
Message-ID: <20261022192933.384898-4-kuncy7@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261022192933.384898-1-kuncy7@gmail.com>
References: <20261022192933.384898-1-kuncy7@gmail.com>
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

qca_tag_rcv() makes only the 2 byte tag linear before it hands a MIB
frame to qca8k_mib_autocast_handler(). The handler then reads the
counters that follow the Ethernet header, up to 164 bytes on QCA833x,
straight from skb->data, without checking the frame length. A short or
non-linear frame makes it read past the packet data.

Pull the counters into the linear area before reading them. A frame
that is too short is left uncounted, so the request times out and
the caller reads the counters from the registers instead.

Fixes: 5c957c7ca78c ("net: dsa: qca8k: add support for mib autocast in Ethernet packet")
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Stanislaw Pal <kuncy7@gmail.com>
---
 drivers/net/dsa/qca/qca8k-8xxx.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/net/dsa/qca/qca8k-8xxx.c b/drivers/net/dsa/qca/qca8k-8xxx.c
index 56796df14..e5d858230 100644
--- a/drivers/net/dsa/qca/qca8k-8xxx.c
+++ b/drivers/net/dsa/qca/qca8k-8xxx.c
@@ -1656,6 +1656,7 @@ static void qca8k_mib_autocast_handler(struct dsa_switch *ds, struct sk_buff *sk
 	struct qca8k_priv *priv = ds->priv;
 	const struct qca8k_mib_desc *mib;
 	struct mib_ethhdr *mib_ethhdr;
+	unsigned int len = 0;
 	__le32 *data2;
 	u8 port;
 	int i;
@@ -1676,6 +1677,16 @@ static void qca8k_mib_autocast_handler(struct dsa_switch *ds, struct sk_buff *sk
 	if (port != mib_eth_data->req_port)
 		goto exit;
 
+	/* Past the first 3, the counters follow the header. Leave a short
+	 * frame uncounted, so that the request times out and the caller
+	 * reads the registers instead.
+	 */
+	for (i = 3; i < priv->info->mib_count; i++)
+		len += ar8327_mib[i].size * sizeof(u32);
+	if (!pskb_may_pull(skb, len))
+		goto unlock;
+
+	mib_ethhdr = (struct mib_ethhdr *)skb_mac_header(skb);
 	data2 = (__le32 *)skb->data;
 
 	for (i = 0; i < priv->info->mib_count; i++) {
-- 
2.43.0

