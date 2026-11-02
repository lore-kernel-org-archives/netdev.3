Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793614294;
	b=YzpI1mOlwR5inHuSetMkUILPLI9WPYfBBAhTXCjUgtfeoykmwDzxKm+J6CT8ZDoKoRgM
	 2LYO4nOS0OBn7v6SlOmPrvjBGrdTv2WGIUa3xK6anH3Yb8OrSGZCLsWQVqmg1IK2gFgnm
	 cLhZ3OhwH1H8aPwwstGCWvwiFe+F1Xg90gAC+gdWyuiHKB9hS4mpTi2/pnflcSaKpoA8a
	 yECjb4LfYkkgs341cfy/Eqp46vt97lQeEuQvbeShQpFMepbkZ5fEoMpL6LSNdya7urX2x
	 kk8ftuhyXsqwpcxlwk2Pvx6T1SV2gXoFDrIVNQ3nG+bfl5qeXCrZ79Sw4yDgMyHfnJQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793614294;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=2fesLx5j3c6ocneASa5f1jcn6vQE9b0l3vKBizXZuJY=;
	b=U7yhQfHuTRtVrZS0Z9zgYe573FCP70QwuLNZo/DVeAXpq+y7ykMeU68EHsbW2bvCXgCM
	 GtOZ6brGpil1VnNzKC1+nja84MQYiWwpfWzNjkxOX5BDOIhrabiN/K4h30of7ACoMHOQH
	 ieQplmRL2mK87Sb3D0ZiAtd7XzcUSEdjcLQjfBgYGt9S5TAPSjfjgMwS2K1T7LCP0mBcg
	 t6dPpMZsvtkjNvvdv0R+75uSEFcpUGntdxUfNfmJpX9psotkYteovreVrIsvYdeBinA6F
	 sHgIgW532GGGXo8svrAXjdCz2MrVuD0G+1AJuLyNXZS5+WzEJJky8RrH0Tb3YmDWDeQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="BS0P/Yey";
	arc=none smtp.remote-ip=209.85.214.178
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40193606A326
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 10:11:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 40193606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BS0P/Yey
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2e9eb579c0eso14191375ad.3
        for <netdev@vger.kernel.org>; Mon, 02 Nov 2026 02:11:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793614292; x=1794219092; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=2fesLx5j3c6ocneASa5f1jcn6vQE9b0l3vKBizXZuJY=;
        b=BS0P/YeyM6aG6e5heswCcwQeFFffXjiKuRIcmTIFPii2q+J0iRslffoHni+2Vwm2C8
         sJMXnOrriGjE6i66pL5WItmUwuoyiifPUABVxfHfnAO9zbZ1OL3G31ViFFhACfdZ4vzB
         ijMq4mz8WlyRKaTTXBwOYag5C5IAxHZEUcwF0g2NJdtzRFEZVVNGNhrWiQN6Xzysgx0r
         m8Ts/DrsNGnGQOPg8UxvKFBuEysUICKNyh50ACb/K4HhEDoVpMTiccaHPdXnDzfUKaX8
         l6p507ZWOC9VXDDIA8fdD4ICMnEBkWuPaW6SHHuPXM872/kWcOviS6qBs56I3piNWy7Z
         zD6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793614292; x=1794219092;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2fesLx5j3c6ocneASa5f1jcn6vQE9b0l3vKBizXZuJY=;
        b=UZH1WAgh0XZ1KGogDPZb70hbKyEJunGG5NRrg9nWxOTOcTM1pd1PYDO6VBbRJiRzie
         gh4AlBxG4SIojT1fQhWS1kSZAeY20kLHzgXvIfdubIbK8+/4+nMxy+raVxbg/mbVAjSs
         iRhLTeVUTAXCO787ZAUvEqOqPLegznsabmwSGDogtjIHFyPpUNJct6yl7jifVS56MVvE
         jSo8YEOfMaDWcZzh4c/8n/JmVwhRvd158iL76bfDbsrX1/8Jwhe5P3I1zfTvUgGnPORB
         OvvHlN3eU2P7rsNLGIgfzzTxA+3TO0hdthvP5gnHTkLY8yEr39+H2Z4re1id7zRfmq8h
         hFAA==
X-Gm-Message-State: APuU4Z8YJzAW3y1yKZLjDIGVfEc+wVreY4yo2n0t8JdQmbCJ6Oj6qukG
	nXwVc9YcPAX2k0wUMcFAzUGiyReTetgzoGfRXAM+mz0w991VP44JlLnOh0gZhw==
X-Gm-Gg: AYBFou1Ar4RexW2cyr1o5v4giQuVYp3vmGsmILoaXh4tpX0eIU4bUnE/F8QqEg/Pnl4
	Kx/uh4Xmili0QwbjaPT0EZvFwO6d9NZWKwNq9qhvBknhPPwhQ5gwkeFvUk0xFmkXQW1NC4dnkUZ
	VdZ0zdRMQAmTAW+wjww8AIBkjDe0D39Ei1ppWWn+7FKMP56i0q9jcwfOcxHPIBIShrey3opRdp6
	BUjctCfTDiloc5CAaFyOpEgzBYP/SCk67ePkJSFxADHece1K1HwdYhBFZSwBR5aRaxzWn6vZJFL
	9/8wN2Vg8KbO6NubnfuiqDHiOcIDovXnMOvTF2ymVt2Rwim2Mn7xsR4UVpHFoMjOYh/ghS4LXC6
	jxOn+QLSokblJGkWoobtv+kJxIsQim0ZGahLDa6q0FhNatAF2Z0aLJQf8+pUtw+hnG98wDANEfS
	ND6WpqSIXlDwtG++XDaSrcA292uERYkOJYhrrVaQpsmbvLTGbUvguxK2XKsoqCykCaYJR1IBQHf
	080St3l7JThFcwtPiDf8sC1hGsF7xIRVU/n9inWiLAEXbijEI7hjdrVLk+O5MqlFKi330kCPQVt
	FkyyyiWd8yIKbbqO2HzTs/Fp3Eat2st7/caQqrjoXsBAU/dZhdEp
X-Received: by 2002:a17:902:d510:b0:2df:8d6a:3548 with SMTP id d9443c01a7336-2eb3646e48amr84625755ad.48.1793614292469;
        Mon, 02 Nov 2026 02:11:32 -0800 (PST)
Received: from d.home.yangfl.dn42 ([2a09:bac1:7680:28::4:396])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eb392492fbsm25667235ad.32.2026.11.02.02.11.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 02:11:31 -0800 (PST)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] net: dsa: motorcomm: Clear the MIB buffer on chip reset
Date: Mon,  2 Nov 2026 18:11:21 +0800
Message-ID: <20261102101125.3523835-1-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.53.0
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

.setup() can run again within one registration: removing another switch
from the tree tears the whole tree down, and re-probing sets every
member switch up again. The hardware reset at the start of .setup()
brings the MIB counters back to zero, but a MIB block kept across that
cycle still holds the old software buffer, so the next yt921x_mib_read()
treats the small value as a 32-bit wrap and adds 2^32 to every counter
it extends.

.port_teardown() keeps the MIB block on purpose and .port_setup() only
zeroes a freshly allocated one, so clear the buffer in .setup() together
with the hardware counters it extends. The published stats need no
handling; every entry is republished from the buffer.

Fixes: 186623f4aa72 ("net: dsa: yt921x: Add support for Motorcomm YT921x")
Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 drivers/net/dsa/motorcomm/chip.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/net/dsa/motorcomm/chip.c b/drivers/net/dsa/motorcomm/chip.c
index 33e5fc127244..ff17233848a8 100644
--- a/drivers/net/dsa/motorcomm/chip.c
+++ b/drivers/net/dsa/motorcomm/chip.c
@@ -2458,6 +2458,16 @@ static int yt921x_dsa_setup(struct dsa_switch *ds)
 		return -ENODEV;
 	}
 
+	for (int port = 0; port < YT921X_PORT_NUM; port++) {
+		struct yt921x_port *pp = &priv->ports[port];
+		struct yt921x_mib *pm = pp->mib;
+
+		if (!pm)
+			continue;
+
+		memset(&pm->data, 0, sizeof(pm->data));
+	}
+
 	mask = priv->info->serdes_mask;
 	for_each_set_bit(port, &mask, YT921X_PORT_NUM) {
 		struct yt921x_port *pp = &priv->ports[port];
-- 
2.53.0

