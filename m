Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8389312836
	for <netdev@vger.kernel.org>; Mon,  5 Oct 2026 05:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791178146; cv=none; b=bIutOoVYBSTvpqwqwvJ2ZQOcJz0AJnIfPzJZZgEeQE+rStMIEe301B51euX7tbC6FgVQ354OGMV2N6IgRO2AkvAvF017zCPmVLpRNe5MH4HsQeML9bVEGhWiFj9At/FFWMK0fm2TKgVoFwRYS14pWpVQunLLbNG5bVXoyWtWRgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791178146; c=relaxed/simple;
	bh=Vn3zjnwgyF/pasgQ2mGKhSYal+8VdI+0lX/7JlzOwXI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dqTWNosI9zCpuvgC0pKQd/r2LAiV6aK2AioU5o3TLhtEDVqMF4RtxU8kfr55wROIq7uh8bSNMl9wtNFAsof7ZU6GjJ1vwpJDGeM8v9SWynNZ6IKN0CTw+R4N1O+Cccs/K37td7J8nXFETaJAXt54CRFO9phCvUGXmMkr584+5ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=q-lab.dev; spf=pass smtp.mailfrom=q-lab.dev; dkim=pass (2048-bit key) header.d=q-lab.dev header.i=@q-lab.dev header.b=UNGHZEpE; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=MXj6K+MX; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=q-lab.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=q-lab.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=q-lab.dev header.i=@q-lab.dev header.b="UNGHZEpE";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="MXj6K+MX"
DKIM-Signature: a=rsa-sha256; b=UNGHZEpEiaD159QgaaDCEFfkcvxSa8QJjY+ciWNpxzDdPxsKsm98VDBPcpNYcjP0iizZx4cBjuCkbaBZajCKAPNp1a4ChmuSFWL3vl+UBfLS3FWgQ4IWJl+vL8XP4RKntLSAYU7GGvlJo1NI7uqBR7zX0ey6jE0gXhcpBldSwsVrKmUs95LGf4epmZjVv5jz19YnZgOJ5y7cpi3zPk7omiBHGtvjDvlbuK563LX2xNFFtyVH4V7wOB643uBJPlfSIxU98mGmMvetlOEtMbnwOdKYBkN5hnekEufx1oO98OefFZr1CaqATNCZxocwoC7ADXaO0CwFlePEAqHytaJ7jQ==; s=purelymail1; d=q-lab.dev; v=1; bh=Vn3zjnwgyF/pasgQ2mGKhSYal+8VdI+0lX/7JlzOwXI=; h=Received:From:To:Subject:Date;
DKIM-Signature: a=rsa-sha256; b=MXj6K+MXIMn/S7FkQ/jHU2nHJpWDQKj5OolVBlh/A8PLmRubDeTULqA+WGmnphHSXiwPP06+XDuv1BXwD2hiJLmcNkzpYEuRzle4CxM9lk2REF8NXO9EnPwoYbTYzldYBPpPMhEw7jKYlHb/MA/x1ga1FJO3aAo3TSLRgAqvqRLAK1uQAL8DX5amYBhg4D16AvH+uqIbDFNgGBWwT5V8IXxDrmD4Hjtq/L09gAdZdhdplXkG3EhG/vyN7RR0a910+paFM4qrPDW18zhYyRiojYDK0hhbnqYClhDJjYKXNETKkxtPaGQSNNYMtyNeEADiMAgeeSpE8o8bmFbWd3wfvA==; s=purelymail1; d=purelymail.com; v=1; bh=Vn3zjnwgyF/pasgQ2mGKhSYal+8VdI+0lX/7JlzOwXI=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 284201:25281:null:purelymail
X-Pm-Original-To: netdev@vger.kernel.org
Authentication-Results: purelymail.com; auth=pass
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -1344933009;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Mon, 05 Oct 2026 05:29:02 +0000 (UTC)
From: Quentin Freimanis <quentin@q-lab.dev>
To: netdev@vger.kernel.org
Cc: Daniel Machon <daniel.machon@microchip.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Steen Hegelund <Steen.Hegelund@microchip.com>,
	UNGLinuxDriver@microchip.com,
	Richard Cochran <richardcochran@gmail.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v2] net: sparx5: start the TOD counters on non-PTP lan969x variants
Date: Sun,  4 Oct 2026 22:28:26 -0700
Message-ID: <20261005052826.14251-1-quentin@q-lab.dev>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by Purelymail
Content-Type: text/plain; charset=UTF-8

Currently the base non-PTP-capable lan969x variants don't forward any
Ethernet frames:

  $ ip link set eth10 up

  $ ip addr add 10.0.0.54/24 dev eth10

  $ ping 10.0.0.1
  PING 10.0.0.1 (10.0.0.1): 56 data bytes

  --- 10.0.0.1 ping statistics ---
  7 packets transmitted, 0 packets received, 100% packet loss

  $ cat /proc/interrupts | grep fdma
    20:          0  GIC-0  120 Level     sparx5-fdma

  $ ip -s link show dev eth10
      RX:  bytes packets errors dropped  missed   mcast
           20828     102      0       0       0      72
      TX:  bytes packets errors dropped carrier collsns
               0       0      0       0       0       0

Testing showed that starting the domain 0 TOD counter gets networking
working again, but start all three for consistency with the PTP variants.

Fixes: 207966787b71 ("net: sparx5: add feature support")
Suggested-by: Daniel Machon <daniel.machon@microchip.com>
Signed-off-by: Quentin Freimanis <quentin@q-lab.dev>
---
Changes in v2:
- Drop the TOD start helper and start all three counters (Daniel)
- Fix capitalization in comment explaining why non-PTP parts
  need the TOD counters running (Daniel)
- Add test log showing user impact

v1: https://lore.kernel.org/netdev/20260928044955.29647-1-quentin@q-lab.dev=
/

 .../ethernet/microchip/sparx5/sparx5_ptp.c    | 28 +++++++++++--------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_ptp.c b/drivers/n=
et/ethernet/microchip/sparx5/sparx5_ptp.c
index 5953e04ef14e..2826e48af103 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_ptp.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_ptp.c
@@ -622,18 +622,9 @@ int sparx5_ptp_init(struct sparx5 *sparx5)
 =09=09sparx5->ptp =3D 1;
 =09}
=20
-=09if (!sparx5->ptp)
-=09=09return 0;
-
-=09for (i =3D 0; i < SPARX5_PHC_COUNT; ++i) {
-=09=09err =3D sparx5_ptp_phc_init(sparx5, i, &sparx5_ptp_clock_info);
-=09=09if (err)
-=09=09=09return err;
-=09}
-
-=09spin_lock_init(&sparx5->ptp_clock_lock);
-=09spin_lock_init(&sparx5->ptp_ts_id_lock);
-=09mutex_init(&sparx5->ptp_lock);
+=09/* The base, non-PTP-capable lan969x variants need the
+=09 * first TOD counter running to forward frames.
+=09 */
=20
 =09/* Disable master counters */
 =09spx5_wr(PTP_PTP_DOM_CFG_PTP_ENA_SET(0), sparx5, PTP_PTP_DOM_CFG);
@@ -657,6 +648,19 @@ int sparx5_ptp_init(struct sparx5 *sparx5)
 =09/* Enable master counters */
 =09spx5_wr(PTP_PTP_DOM_CFG_PTP_ENA_SET(0x7), sparx5, PTP_PTP_DOM_CFG);
=20
+=09if (!sparx5->ptp)
+=09=09return 0;
+
+=09for (i =3D 0; i < SPARX5_PHC_COUNT; ++i) {
+=09=09err =3D sparx5_ptp_phc_init(sparx5, i, &sparx5_ptp_clock_info);
+=09=09if (err)
+=09=09=09return err;
+=09}
+
+=09spin_lock_init(&sparx5->ptp_clock_lock);
+=09spin_lock_init(&sparx5->ptp_ts_id_lock);
+=09mutex_init(&sparx5->ptp_lock);
+
 =09for (i =3D 0; i < sparx5->data->consts->n_ports; i++) {
 =09=09port =3D sparx5->ports[i];
 =09=09if (!port)
--=20
2.55.0

