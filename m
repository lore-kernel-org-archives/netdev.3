Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793635123;
	b=CHTv/rdm7Y119kQkOjeCNc5dEwqQSVpF+xkUVg48F+3zg4xaLBcQ8PxtOncn5IkkaVb3
	 xR2PXBL+qDTzHtFvwJn2JDxaB35gf3v7Py1lA9rEEM4c18l2txhztUd6yRxoByZm20yYV
	 FbVmg+LK2m3R/ZIDh9/8B0end1kka0z9uV2RTeoQeMPicl/FXmreOfWufG9eUQDgsthh7
	 tn0rBlyuAgUXzwrtZrL08MVb8r4rlww7iwoOZpmXjystALUgEePciCqUDhIgMY3we7jR7
	 kJrf3Tp4GPEOLHKheSk4imgYjPYyW+f3wbsKLGy4p5hUrC3KdehdTdadK1cE5idQLBA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793635123;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=sI6mXD4yaK7Ns7KJBv2qv3XEUsVwizuE1gM/skedcVA=;
	b=HN23BOnuxfGlIUekUDzjkFTZc+xdlQMRQJVi6eWpG15YiRbFoiJtlEZKPccIUyHLXcgW
	 RyErCvtkLviVxvGDAQOFVxekFjh8PsIaj+lsLNYKbWcphYVEGGuIeUYDUJBozytk3rkbT
	 53yxxMpMO/cMPKbBgLDMVTcfKWh0hNKIiYKCJnV02xq3Hze8u+8f7zM9zFiCMpwakclJe
	 SqgHguNnsWBeOEU0u2/rxQw3Gi3ToZUAifL5hV7A0Fa1IHnfFdl1bU+blvhtgNW8pi45M
	 GuV+kLZeJ3hw5zwDTaaZso1bWp7y1iuH73f5CrBKeXoHNa4xzWhMVS3n9i4PHMKDRuw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eJUWMay8;
	arc=none smtp.remote-ip=209.85.215.175
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B523D607BDC6
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 15:58:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B523D607BDC6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eJUWMay8
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-cc4be0e5351so1247228a12.0
        for <netdev@vger.kernel.org>; Mon, 02 Nov 2026 07:58:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793635122; x=1794239922; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sI6mXD4yaK7Ns7KJBv2qv3XEUsVwizuE1gM/skedcVA=;
        b=eJUWMay8nXxOvoeA7ZaJmxGcmoyEELAJPJmKNuDB+VE1xWFlhJVmmKDRdLYtyj6N9U
         Rf81WbSVE0jjdAs9a1NVx2JkhWpwgOvcmpsqamDNhRAAO2hkaZmQMOL7yeI4prhevzps
         rSJNsWOcglrR8OlhSKJlxY5p5jdAqrCAInEHo02UUVhQNPXlyyPK36NZ1FShywOSh36w
         Prxa4kg45TK+Oam0If3OBemT1ld68CrHwswfIZfoQ/Oq7EovP2GPXLjZs2VdH552MtjK
         mNRbZ/IdBXaeDCPVa9rtuL9vxyIsWxV0fmhbDSIjpwGd/SO0FbdaKivWjhIw+Ou0c++l
         OqzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793635122; x=1794239922;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=sI6mXD4yaK7Ns7KJBv2qv3XEUsVwizuE1gM/skedcVA=;
        b=oiTxVn5jrPwswtjuHpC3sXpUybCA3iGaCAGprgikZlqK5FBw+VbAx/5tuaVYaAVnTm
         vOvYwKd64Y33yA7nmCZmrEFtOoYDMnb2m929vfLnZ8WHlqt+/8I3VPmsvMra7MsctmSP
         aE1asq2Qd1oi0uAZseVdSQdR3sUqInY05SUeIJnTGSknr1F0lcpVxHOoENZfQ16tNfk8
         EOYLKGF/KEp38bj0Wh5q0SbFIseUYDly7k/D/GmTHu2w0LAOM6QiR0tN4Rrl7dA1UXYg
         44peDy8ZrqomTAfur/fRwa7R3ZjeIWvnlXxtaHZdhhVSNZL/rgu/omRQvxWpgoSsX/1O
         CqJA==
X-Gm-Message-State: APuU4Z/ubbYJXCR9IGlFDkpzhnDJ/cQVOJ6ua7rsszkGl48BBlOKKRh9
	eYVKZBY5TnesX7N3oxfeUeIfdbhE5RGa/yN9zAr/jz7QB8xedd8BLEczkkqboA==
X-Gm-Gg: AYBFou3+bex7AeBW8GWgszAw0/azMxj6adw2Y8DS/IP0Utkq8j1StWzMiJjCSbACs6m
	mps9/LkqXb9InGTqKnyduIiaaLKS3q6lRlpinsV9jLXsBrmxa4PGy6RHyUSJw3A6BZhPXKapOku
	BCNfXIjyekSwgqYm6xaWf1u6AaCKVHk4SJf0DSaTxcQ4ln+5zd6dQ0zu0WTfjvjVebflnq7l0//
	WRI922Ng9Mla+EDa8zZT2esu49TObwFEkjqH/y6mB36sjNGBNYIksA/ANRZQXKx9gyg+NvTb80G
	f6l7H8sZKRZUlwHZscKkvjnHDwGKteO6ZGImflERZMsm4VbQBysl7zqe5tk2Omk7a5OADXXDkV9
	ZQ9Lltvl9RF42esAo1FwhR14YXS5WfZiY7gtqFtrvf8R8YbvMaGBKuADfCEfC88SZct1lwjwKu7
	6jPMxFT4dLkDhj1gH78uU71FBA5X9kVF1aZqh8HXj/TYmbgqSl/FIThOVjP8MCq4gVCiI6e0rHT
	SKaS7U7g6EJruiqxH82eMuByiKG6eqnSuHd8+0KfIp2T5jn0mwT0NOm1C48snz9/CG87adAY2sw
	9AZQRvm0yHWrN22YR1vf1/sTU5h07TF757f/YRRxvIWOFAcT1zD/
X-Received: by 2002:a17:90b:28c7:b0:3a0:a912:e759 with SMTP id 98e67ed59e1d1-3ae897ee62amr8717288a91.25.1793635122045;
        Mon, 02 Nov 2026 07:58:42 -0800 (PST)
Received: from d.home.yangfl.dn42 ([2a09:bac1:7680:28::4:396])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae6e7d429fsm19183949a91.2.2026.11.02.07.58.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 07:58:41 -0800 (PST)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 4/6] net: dsa: motorcomm: Translate FDB VID for VLAN-unaware bridges
Date: Mon,  2 Nov 2026 23:56:36 +0800
Message-ID: <20261102155641.3682626-5-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261102155641.3682626-1-mmyangfl@gmail.com>
References: <20261102155641.3682626-1-mmyangfl@gmail.com>
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

A VLAN-unaware bridge reports VID 0 for its FDB entries, but lookups run
with the unaware FID (VID 4095). Entries added through switchdev were
installed under FID 0 and could never be hit by the hardware lookups.

Translate the unaware FID and VID 0 back and forth, so the software
mapping stays symmetric with the hardware lookups.

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 drivers/net/dsa/motorcomm/chip.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/net/dsa/motorcomm/chip.c b/drivers/net/dsa/motorcomm/chip.c
index 907f7a5b0687..447736854870 100644
--- a/drivers/net/dsa/motorcomm/chip.c
+++ b/drivers/net/dsa/motorcomm/chip.c
@@ -590,6 +590,9 @@ yt921x_fdb_dump(struct yt921x_priv *priv, u16 ports_mask,
 	res = yt921x_fdb_read(priv, addr, &vid, &pmask, &index, &status);
 	if (res)
 		return res;
+
+	if (vid == YT921X_VID_UNWARE)
+		vid = 0;
 	if ((pmask & ports_mask) && !is_multicast_ether_addr(addr)) {
 		res = cb(addr, vid,
 			 status == YT921X_FDB_ENTRY_STATUS_STATIC, data);
@@ -618,6 +621,8 @@ yt921x_fdb_dump(struct yt921x_priv *priv, u16 ports_mask,
 		if (!pmask)
 			break;
 
+		if (vid == YT921X_VID_UNWARE)
+			vid = 0;
 		if ((pmask & ports_mask) && !is_multicast_ether_addr(addr)) {
 			res = cb(addr, vid,
 				 status == YT921X_FDB_ENTRY_STATUS_STATIC,
@@ -740,6 +745,10 @@ yt921x_fdb_leave(struct yt921x_priv *priv, const unsigned char *addr,
 	u32 val;
 	int res;
 
+	/* See yt921x_fdb_join() */
+	if (!vid)
+		vid = YT921X_VID_UNWARE;
+
 	/* Check for presence */
 	res = yt921x_fdb_has(priv, addr, vid, &index);
 	if (res)
@@ -782,6 +791,13 @@ yt921x_fdb_join(struct yt921x_priv *priv, const unsigned char *addr, u16 vid,
 	u32 val2;
 	int res;
 
+	/* A vlan-unaware bridge reports vid 0, but untagged lookups on its
+	 * ports run with the unaware FID; map so that static entries match the
+	 * hardware lookups.
+	 */
+	if (!vid)
+		vid = YT921X_VID_UNWARE;
+
 	/* Check for presence */
 	res = yt921x_fdb_has(priv, addr, vid, &index);
 	if (res)
-- 
2.53.0

