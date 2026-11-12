Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794472677;
	b=fPuiMFjHTiowvI+oG389RPnY/Y7N5ewPxq2LNQJqCDCP4vuL/ZzGIyUtM6Be1nY9X/R5
	 xcdXbHv6ADtPZUk2cbz18DbXTu0XcvbvOCjkqyFk81wLUz9BdfeMHxSswdYfLwMwAh1cu
	 EqZNO6JMG78lsOoCUFwvpYvlB7vMO+3dLvmqj8pTFcfWFyjIXtp/7cDKCGcojFRKRvxjz
	 1m7Kr7trDHam+N0dl9zMx1CIo3FiuJrwbpI7oDuPljSH+Io9eXU3BdxtMm20TXLkLKAWd
	 84wTh/Nj4z5Jdij3mulcLqO57sX2aOeJDirEjV2nXx3cmUDUnbeLoGM9ERayXAdZb9g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794472677;
	h=DMARC-Filter:Received:DKIM-Signature:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer;
	bh=RQk4jWkk+NH4t7YyU4ZqKjMoejeTW5BAQK7uOBeQH7w=;
	b=LWyoN9t0tYNX37+B6xCJz5c0W6mq7b0deeP1lNwkcw3l2kFhPnwGVnqgOkKGv4GrlcC7
	 ckMchcOmmtJG3CtI+QlFKJfczCftZoGTe2UAOrCRDR84CgEt37NEVGJnzAMzHfRi0baYF
	 sqGOZk4ZopuBLRkVPzbWLjuMO7bjKL9Y/8fhv/60iig/HOOop7kZXRwuucxRlyBYn4ANQ
	 tTWmLgAEsTFvULS+1St9iRfF/7/1EHSUgq3VPdr3qbOkUdNti4493F9qxTsVvirDf94tu
	 gyFQRdkb5J8hmQA4ikv87RcBhP9WwBHQfsxwv1AqrNR749zdde9MEj/RYIZ4zZwYBMA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=Us3odBQ4;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76776607079E;
	Thu, 12 Nov 2026 08:37:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 76776607079E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=Us3odBQ4
Received: from dude04.red.stw.pengutronix.de (dude04.red.stw.pengutronix.de [IPv6:2a0a:edc0:0:1101:1d::ac])
	(Authenticated sender: relay-from-dude04.red.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 8A83B205836;
	Thu, 12 Nov 2026 09:37:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794472671;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RQk4jWkk+NH4t7YyU4ZqKjMoejeTW5BAQK7uOBeQH7w=;
	b=Us3odBQ4PsgrAfKuswlLtFYBgcPjvnFxMf/4yoa7ekxZq+dAPW52QwWTFGtgVi8ks6lS3Z
	nmC5QKy8Jg5I3ozUzRC+439FI251r4Ah2oZZCygHOZKqU7f9QYzgeuRqaGpeoijcy9IrHj
	rGDN+aZ6m1KWdVqM5ofjwnnNCwwhUkfYdv2qeUH5li4oCq7QceqHq3zpvPG9U7qC9bljvq
	7ATgL7IwiEu32GQkYBPisdNsjdl63UCbwX0DHFcCdGzAqlSMJ23f0S0LBvoFNlDFjDYHJt
	0vTYvDYiFdpFNKr+V5BPXCJz2GkeGxBrLRaEuMMX7fJyo7GWYC7xonEiOBTkZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794472671;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RQk4jWkk+NH4t7YyU4ZqKjMoejeTW5BAQK7uOBeQH7w=;
	b=a3mKe91slCzI+JBzYV3NUhJjWz/HDU1w/8TE8q5K2V/NAlHISw1/1OdV3wAyWnmhmAkOyO
	fZ27Fgs2nwpy0tg75BUG8/XFXMQQrIW981R48VPQoFp5ERbNKkdbov6r9kzrKj8H64NJjd
	ejRpPiBpmACvGa6D6n1yCVjm4Xtyo4LIQV+p/0hz4vj5mWK+q1l6Nzy91vApl93Ka/+3TG
	SpAQ/JQNw44MmtUlh58IdOTDFSGmrRh18LGYSi3JvLzg5ywo2WccgjUSH8YA7HWRSFHhG3
	XzVaKoVMWTsxcqmV87Jq/rx4UgShNI180Abb5chl3A9EtJblgy4Y1Us3vNs3bw==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1794472671; a=rsa-sha256;
	cv=none;
	b=RQjCywgxWl8NM8HOlGZKLZVxkvW0FimCUf2OQ4dm4K4rQbUKWSWmxIK4LlVaxo4ar+AKXG
	ZAD4C892gO7UGQJuDaYl/AMES9j5WslrtAJE0NPIpfTRDeDbYcoYclaZycb8MWPB4VqFa0
	KPtN8gRd6iPlZHqxvMLMQiIojMFqQeC7ETtHS8Zlpj33zPrV8DqZAh7YoTKtAmqh8AwOGR
	QV8TWD1ZTyg91Tu0BiXfV0MvMx7lOwhJ85TRSeHJttlqB1Ue4D/lH2Jt4ouDacELyssqks
	7uR3AiPN7EIhpw87p/sklXvoN9G0TlQJSTQz3O+DZcKO8cDgzPgW+H34pl8q8g==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-dude04.red.stw.pengutronix.de smtp.mailfrom=ore@pengutronix.de
Received: by dude04.red.stw.pengutronix.de (Postfix, from userid 1058)
	id 5C67D381DC0; Thu, 12 Nov 2026 09:37:51 +0100 (CET)
From: Oleksij Rempel <o.rempel@pengutronix.de>
Date: Thu, 12 Nov 2026 09:37:49 +0100
Subject: [PATCH net-next v2 06/10] net: dsa: realtek: rtl8365mb: store the
 egress queue count per chip
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
Message-Id: <20261112-rtl8365mb-dcb-ingress-v2-6-f8e6fbdf8c99@pengutronix.de>
References: <20261112-rtl8365mb-dcb-ingress-v2-0-f8e6fbdf8c99@pengutronix.de>
In-Reply-To: <20261112-rtl8365mb-dcb-ingress-v2-0-f8e6fbdf8c99@pengutronix.de>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Linus Walleij <linusw@kernel.org>, 
 Luiz Angelo Daros de Luca <luizluca@gmail.com>, 
 =?utf-8?q?Alvin_=C5=A0ipraga?= <alvin.sipraga@analog.com>, 
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de
X-Mailer: b4 0.14.2

Store the number of egress queues in the per-chip info structure and
advertise it through ds->num_tx_queues, following the ksz driver
(struct ksz_chip_data.num_tx_queues).

The queue count is a per-chip hardware property, and this driver supports
several chips of the rtl8367c family. All currently supported chips expose
eight queues, but keeping the count in chip_info lets the QoS code that
follows program the priority-to-queue map via the ieee8021q helpers for
whatever queue count a chip carries, so the 802.1Q collapse is correct
rather than hard-coded to eight.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
Reviewed-by: Linus Walleij <linusw@kernel.org>
Reviewed-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
---
Q: Linus: why is the queue count not in struct realtek_variant?
A: The count is per chip, while realtek_variant is per subdriver, and
rtl8365mb serves several chips. The QoS code added later in this series
reads ds->num_tx_queues, as Linus suggested in his v1 review, so
RTL8366RB can advertise its own count the same way.

Changes in v2:
- drop the num_tx_queues comment, which restated the assignment
- keep the Reviewed-by tags: v2 only drops a comment
---
 drivers/net/dsa/realtek/rtl8365mb_main.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/dsa/realtek/rtl8365mb_main.c b/drivers/net/dsa/realtek/rtl8365mb_main.c
index 1e6cdc61f6bd3b3f74e422dbbcfdcb67cc0532a7..f7960d94f1cd9f6a1982849a9e5a1b5d98880b4b 100644
--- a/drivers/net/dsa/realtek/rtl8365mb_main.c
+++ b/drivers/net/dsa/realtek/rtl8365mb_main.c
@@ -711,6 +711,7 @@ struct rtl8365mb_extint {
  * @extints: available external interfaces
  * @jam_table: chip-specific initialization jam table
  * @jam_size: size of the chip's jam table
+ * @num_tx_queues: number of egress queues exposed by the chip
  *
  * These data are specific to a given chip in the family of switches supported
  * by this driver. When adding support for another chip in the family, a new
@@ -724,6 +725,7 @@ struct rtl8365mb_chip_info {
 	const struct rtl8365mb_extint extints[RTL8365MB_MAX_NUM_EXTINTS];
 	const struct rtl8365mb_jam_tbl_entry *jam_table;
 	size_t jam_size;
+	unsigned int num_tx_queues;
 };
 
 /* Chip info for each supported switch in the family */
@@ -748,6 +750,7 @@ static const struct rtl8365mb_chip_info rtl8365mb_chip_infos[] = {
 		},
 		.jam_table = rtl8365mb_init_jam_8365mb_vc,
 		.jam_size = ARRAY_SIZE(rtl8365mb_init_jam_8365mb_vc),
+		.num_tx_queues = 8,
 	},
 	{
 		.name = "RTL8367S",
@@ -761,6 +764,7 @@ static const struct rtl8365mb_chip_info rtl8365mb_chip_infos[] = {
 		},
 		.jam_table = rtl8365mb_init_jam_8365mb_vc,
 		.jam_size = ARRAY_SIZE(rtl8365mb_init_jam_8365mb_vc),
+		.num_tx_queues = 8,
 	},
 	{
 		.name = "RTL8367SB",
@@ -776,6 +780,7 @@ static const struct rtl8365mb_chip_info rtl8365mb_chip_infos[] = {
 		},
 		.jam_table = rtl8365mb_init_jam_8365mb_vc,
 		.jam_size = ARRAY_SIZE(rtl8365mb_init_jam_8365mb_vc),
+		.num_tx_queues = 8,
 	},
 	{
 		.name = "RTL8367RB-VB",
@@ -790,6 +795,7 @@ static const struct rtl8365mb_chip_info rtl8365mb_chip_infos[] = {
 		},
 		.jam_table = rtl8365mb_init_jam_8365mb_vc,
 		.jam_size = ARRAY_SIZE(rtl8365mb_init_jam_8365mb_vc),
+		.num_tx_queues = 8,
 	},
 };
 
@@ -3288,6 +3294,8 @@ static int rtl8365mb_setup(struct dsa_switch *ds)
 		goto out_teardown_irq;
 	}
 
+	ds->num_tx_queues = mb->chip_info->num_tx_queues;
+
 	/* Start statistics counter polling */
 	ret = rtl8365mb_stats_setup(priv);
 	if (ret) {

-- 
2.47.3

