Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793816484;
	b=JWlDDVtrFFz2Yg3LClb9tq7zYGCfaOZr20o4u7SEXhLOSXJ2AkB3KRR9Ti0C/qxtzmTY
	 dgCsxBNkFaaeLWMOPq8xl6CYbkgmd+dN4nYoC55lFbPWZHXE5ndJzYuj0jXk+rQnoXGzd
	 T8BCJ/Pdw8zfHogwVVZ5dgrdW8sia/+OMmUrmL1j71oBsLGZu6JOH87hDkSomwgyPtNGu
	 e3rWIJugoBuOpslm2kgzoD1NvWyPp6pvGHFgRvDpAiO8tP8v2tQ5ieLcm5EItIl+eDTe/
	 Ewa/4pgmFU3F9ybnl4XQsMv9dc7ZjzKZmbZS0IIfkFluQ0U0ENR+ngjpwiyAgkgy7xw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793816484;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=xAFQ4NIpw4G2h3WAzyEmbQDopp5teXSrxNa8N1logrI=;
	b=GMl6OvtMqiyjfLpqkOgSMIOyHF9+MLGBX0EEShAD+bg/L6tHJ4sZHn36dlRjRAbuOCaE
	 zzUr/S/TeCoyonMqMxm8dwem63xw3AKEi+/33ray9hKZ44ylvy97FPxvD3lg1NjTLs55/
	 dTWLqJnrIoAKWOg00vQ12G1PJB/GnZZSO4TN7tHCrWp1l5/WEruxOny8VqM1mD3fa8/Hx
	 oC8fPllNB79wzfxz5ZucmV4V0H3PDaT4JvNiNQ0/53V6w2npaMbjPqaQbhCBk3YhR0LVQ
	 Ralo7uUoSjQMGPnzvXw2+1uiMsxppX1Y8ltMxh7OcKXXRZtQA30pFKijFVqMI6zGLxw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=G+cJhG4b;
	arc=none smtp.remote-ip=209.85.221.42
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCCA660A2616
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 18:21:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DCCA660A2616
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=G+cJhG4b
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-490c1d337d8so330724f8f.2
        for <netdev@vger.kernel.org>; Wed, 04 Nov 2026 10:21:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793816482; x=1794421282; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xAFQ4NIpw4G2h3WAzyEmbQDopp5teXSrxNa8N1logrI=;
        b=G+cJhG4bvR6+Z+oY8S4RJlEN38IG1EGgaF8mSO5/bCTCqWATVsH+4Y1VZGtcuLRjMk
         VAFY+p/LPm43GaDRFhaqT+bL9cc5Jte+JSMCUNHxmogmCbkJMi533Q3QF07rFa+eR3C5
         3PWz3vYqfDX15L8ZdXL0oAETyLZj2WU9Cxzxpi7YJGR8slBt8rBqn2m/JXVXVbzZxAW8
         Wpb3HqBbwy670/5bgPUsSOOXWR/9wcNWZctApoIgpEW6rA5gtzwotyW6S9Gsn8TOwdMQ
         gwRXdgmEGQXbCKkelU52x4emvfJjeRi07OAnOnUcqD0bdTy/crxb1V5NoX1rZ3KXk2FG
         sQOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793816482; x=1794421282;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xAFQ4NIpw4G2h3WAzyEmbQDopp5teXSrxNa8N1logrI=;
        b=VVoWF32+v5rVyH20djqPOXEf+Ld0nrI0/Ea5OfkVQHkNga1zq+GthPvIrqlYQ9VEKU
         5D5PhT300FVJkiQGqs60w3nDlLSPCUlpg1aiaw0h5im7+/5kw7T0MFQNKiOypSf9hfbL
         tRm6XRrEC+g8TsWVpt9MM+Y0RIkxUH9bl9UzQGUuh4ZlbLEnLgsFpoiEsrFmJEG74k9b
         fI9u9CUZM+e2mCvVkmZ06aA22wDA7rUKd9hhn7j6N3HfVadD6YhjjF4Mqa5VGg6ewPxx
         c5ta/aEWbqiksSHxwFw5OKaNdS4nKMPoETvnFzuFsOGES3c8GFDkENXBeL7nwtnVyM1J
         v5MQ==
X-Forwarded-Encrypted: i=1; AKwUvByDHtd3brxPvwGi90/dynT1k2+L4IShayHyWtJrjf6En21KNALkzkx7b/ZScT1YOiGpx1fTigQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z9tbmLqJO1jyGUr0P6DT8VSBZpijzoiOneOzt+M+EGTB1ekoXO6
	3c0O50siRt8mR5CdXKfNFXF2FH8DYJ2rmFuRcisnu02obei/U3G91pWX
X-Gm-Gg: AYBFou1bLYKAgcwLMFnk6SDQQD1JS0JYCsGLhOjTQ1ZjH38EI+082CD8lo/bHB3eMDT
	e9U7LgPlviWYjbFDKq6D2dpjp2uy5xiKJ/DY/19NaHduKj/keiw+7AmZH6iXDf/jNTIGyvg4EXF
	16CrXEdj1Hbor3DuJ+QLcxozA8a3RMeBhlemIDaC84qKVJ0hYSmekO36HSj9OaRHpn9U0XjwJxg
	MIyMREO9HimNiM+gpW2gNhl7XmtmGPkS0yTjIEERKKQW9TwL09KI5Ig3WWAEqnsMKHJ7azquxfE
	ZlVxuZ0SnxEVfRwrt6Xk1gw3SUnh4Vcr7zfLEFIYiUx0s6m2/f9HqO7lO/n/t0rAkR2ANhQQN8y
	s1smWFWPeCThZirArGfKO0AjJctZbldPFarSFgmvAQ/XJudbb3xCHxQR2HaCq7rwLiBLVdDS9Cq
	6Jxdu4ena3U+bfyNu5K2/ZsEJu3iHK5mZxaAsW66Bm8YEoHiK8NnWzkCW/uDTyT18SqiPR2k4gw
	MkCKIdAz1E++xUjv68agirsCoaNoHo5M9Iem5E49s3Y9LnmDWfU+BS5LJsiuksc0EI6PSzq07TI
	VtM8R7lSWV9jmsN5lpbL0vwZx1QegtXGEO9H/th7O8CyN0D+LMos8ALHoxupv+m8/k4sgmRdibk
	O77ndHd6aQi72nTkRblVWVROiaPciKu9FXKK7Dg==
X-Received: by 2002:a05:6000:e89:b0:487:baa:aa6b with SMTP id ffacd0b85a97d-48e6e4fac5bmr27612625f8f.43.1793816482340;
        Wed, 04 Nov 2026 10:21:22 -0800 (PST)
Received: from iku.lan ([2a00:23c8:254f:fd01:b079:a2f1:caf7:b446])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48fed0844e2sm4073202f8f.28.2026.11.04.10.21.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 10:21:22 -0800 (PST)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <clement.leger@linux.dev>,
	Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Russell King <linux@armlinux.org.uk>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: linux-renesas-soc@vger.kernel.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prabhakar <prabhakar.csengg+renesas@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH net-next v4 11/14] net: dsa: rzn1-a5psw: Choose tagging protocol based on compatible string
Date: Wed,  4 Nov 2026 18:20:59 +0000
Message-ID: <20261104182105.1102555-12-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261104182105.1102555-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20261104182105.1102555-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Prepare the A5PSW driver for forthcoming RZ/T2H ETHSW support by making
the DSA tag protocol selectable through SoC match data. The RZ/N1 A5PSW
and RZ/T2H ETHSW share the same tagged frame layout, but interpret the
ControlData field differently, so the tag protocol cannot remain fixed.

The common tagged frame structure is:

  +----------------------+-------------------------------+
  | Field                | Size (octets)                 |
  +----------------------+-------------------------------+
  | Preamble             | 7                             |
  | SFD                  | 1                             |
  | Destination Address  | 6                             |
  | Source Address       | 6                             |
  | ControlTag (0xE001)  | 2                             |
  | ControlData          | 2                             |
  | ControlData2         | 4 (timestamp, portmask)       |
  | Type/Length          | 2                             |
  | Payload              | 0..1500 / 0..9000             |
  | Pad                  | 0..42                         |
  | FCS                  | 4                             |
  +----------------------+-------------------------------+

The ControlData semantics diverge between the two switch families:

  +---------+----------------------------------------------+
  | SoC     | ControlData bits                             |
  +---------+----------------------------------------------+
  | RZ/N1   | [0-3]: ingress port                          |
  |         | [4-15]: reserved                             |
  +---------+----------------------------------------------+
  | RZ/T2H  | [0-3]: ingress port                          |
  |         | [4]: timestamp timer select                  |
  |         | [5]: reserved                                |
  |         | [6]: RED period indicator                    |
  |         | [7-15]: reserved                             |
  +---------+----------------------------------------------+

Because these differences affect protocol semantics, select the tag
format through compatible specific data. This allows the driver to
choose the appropriate tagging protocol for each SoC while preserving
the existing RZ/N1 behaviour.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
v3->v4:
- No change

v2->v3:
- No change

v1->v2:
- Updated commit message
---
 drivers/net/dsa/rzn1_a5psw.c | 5 ++++-
 drivers/net/dsa/rzn1_a5psw.h | 2 ++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/dsa/rzn1_a5psw.c b/drivers/net/dsa/rzn1_a5psw.c
index ee0187aae2bd..f8fe6f3b8e12 100644
--- a/drivers/net/dsa/rzn1_a5psw.c
+++ b/drivers/net/dsa/rzn1_a5psw.c
@@ -97,7 +97,9 @@ static enum dsa_tag_protocol a5psw_get_tag_protocol(struct dsa_switch *ds,
 						    int port,
 						    enum dsa_tag_protocol mp)
 {
-	return DSA_TAG_PROTO_RZN1_A5PSW;
+	struct a5psw *a5psw = ds->priv;
+
+	return a5psw->of_data->tag_proto;
 }
 
 static void a5psw_port_pattern_set(struct a5psw *a5psw, int port, int pattern,
@@ -1324,6 +1326,7 @@ static const struct a5psw_of_data rzn1_of_data = {
 	.nports = 5,
 	.npcs = 4,
 	.cpu_port = 4,
+	.tag_proto = DSA_TAG_PROTO_RZN1_A5PSW,
 };
 
 static const struct of_device_id a5psw_of_mtable[] = {
diff --git a/drivers/net/dsa/rzn1_a5psw.h b/drivers/net/dsa/rzn1_a5psw.h
index 197ff5916578..e952afd95dca 100644
--- a/drivers/net/dsa/rzn1_a5psw.h
+++ b/drivers/net/dsa/rzn1_a5psw.h
@@ -236,11 +236,13 @@ union lk_data {
  * @nports: Number of ports in the switch
  * @npcs: Number of PCS connected to the switch
  * @cpu_port: CPU port number
+ * @tag_proto: DSA tag protocol used by the switch
  */
 struct a5psw_of_data {
 	unsigned int nports;
 	unsigned int npcs;
 	unsigned int cpu_port;
+	enum dsa_tag_protocol tag_proto;
 };
 
 /**
-- 
2.56.0

