Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ACC73264FD
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 04:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790570800; cv=none; b=QWx/DNIOEv9T9e+yk1nFiZSMOPk/JZ3t2nLkT+O1olkP3l8LWpw/1e45eeCf/fMLqKrGfJ2GOBv1GDIxRRW5vruSUi4Y+MkScGxfahg54ViAu8mbjHNVN9DAR6WEDvGOywm3Xi+Gl81PxDcNujAElaaWyJLsR2XGNvxRFfEwD+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790570800; c=relaxed/simple;
	bh=y2oX2C+1PWcvUePRLeVC2WrEQwNq744I2qXkHAN8bUE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jijw3/EMvLdJAWVeXbuveeWm1IRxdWfsWja6y9PAGyWxpgrEpktspOkLXfhPtvyzF5Llt/T8eW3ma+UDTxQpQ2KT3Lu7KxscwaOpu3ikv3EAx18hFD2WMMHcqk17H8lGzLl88z0hpWY00W6Zpju30BujgQSSIi1PUPPMt+g+92c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=q-lab.dev; spf=pass smtp.mailfrom=q-lab.dev; dkim=pass (2048-bit key) header.d=q-lab.dev header.i=@q-lab.dev header.b=SVe90heE; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=7cYgAZI+; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=q-lab.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=q-lab.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=q-lab.dev header.i=@q-lab.dev header.b="SVe90heE";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="7cYgAZI+"
DKIM-Signature: a=rsa-sha256; b=SVe90heEUMeEQiCYFeD21+8zfCcJs+Hq3d7m0LJh58mI41bAzvYAnu5ED08arlQ4lUkYqXlHPqotXc3aOQlrgCr6Sb0Y0/hD+zUDgB4nKLGQyBRYWC7bcmu1a73rOWZKAYiwppIfbMFC2gzeypWM3OyRIBmhXZwxQYpdylUuVQ77U1CDx1eb0EJgy3EVdHkdKMcOLh72I4HaXYe7avD5/irsei6VOtOWU4/KSXDUB0mYwv/Z3Em3HFSZGcwxha+k/8AFnmurKUZg6qfHT/Mw2KrVUQkudgxW/H31Qv4IyYMC9KSCmaXizAtoHdgxcx0shQab0q62Oa+ftLGZW1tJgg==; s=purelymail3; d=q-lab.dev; v=1; bh=y2oX2C+1PWcvUePRLeVC2WrEQwNq744I2qXkHAN8bUE=; h=Received:From:To:Subject:Date;
DKIM-Signature: a=rsa-sha256; b=7cYgAZI+3O6mjlhAIlfYtlnyYlqkeGLdO8dHWuAGcI6w2GAgkFO1EyRgnIj5jTmAhOULWqSjH9/1OTkTDrhohTnqWdzZ/JA5A9c6ozcdgye0N/aA70I3MECk/TgWHzMPU++t1Ujs4uV5s1DufwLpuNuMftlM4Df1XRi/F+WmAy+WHtv9o+kToomqAm8m9WUcBibNbhGwSMeYjh4eF/f0QQarJw1lM0bEUoipEGp34fV6zQFqE4oi7KnAkyN3H9PzYaBrwMaFnQSmTL53N7Gr3jdM7Tmywqfc8SY405MmEHwvEcrh0v2GUyhxrj5LTbzOTYro9qrPGcVw/f8urTWXjg==; s=purelymail3; d=purelymail.com; v=1; bh=y2oX2C+1PWcvUePRLeVC2WrEQwNq744I2qXkHAN8bUE=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 284201:25281:null:purelymail
X-Pm-Original-To: netdev@vger.kernel.org
Authentication-Results: purelymail.com; auth=pass
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 1853740651;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Mon, 28 Sep 2026 04:46:35 +0000 (UTC)
From: Quentin Freimanis <quentin@q-lab.dev>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Steen Hegelund <Steen.Hegelund@microchip.com>,
	Daniel Machon <daniel.machon@microchip.com>,
	UNGLinuxDriver@microchip.com,
	Richard Cochran <richardcochran@gmail.com>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] net: sparx5: skip ptp deinit if init was skipped
Date: Sun, 27 Sep 2026 21:45:42 -0700
Message-ID: <20260928044542.29287-1-quentin@q-lab.dev>
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

sparx5_ptp_init() returns early on the base lan969x variants
because they do not have the SPX5_FEATURE_PTP flag. It also returns early
when no "ptp" interrupt is described. Unbinding the driver then causes a
NULL pointer dereference when cleaning up uninitialized tx_skbs queues:

    Unable to handle kernel NULL pointer dereference at virtual address
    0000000000000008
    Call trace:
    skb_queue_purge_reason+0x68/0x120 (P)
    sparx5_ptp_deinit+0x64/0xc0
    mchp_sparx5_remove+0x38/0x70
    platform_remove+0x20/0x30
    device_remove+0x4c/0x80

Before per-port tx_skbs were added, a NULL dereference would have happened
when calling ptp_clock_unregister() on the never-registered PTP clocks.

Fix by returning early in sparx5_ptp_deinit() if PTP is not used.

Fixes: 0933bd04047c ("net: sparx5: Add support for ptp clocks")
Signed-off-by: Quentin Freimanis <quentin@q-lab.dev>
---
 drivers/net/ethernet/microchip/sparx5/sparx5_ptp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_ptp.c b/drivers/n=
et/ethernet/microchip/sparx5/sparx5_ptp.c
index a16ec8136d6d..5953e04ef14e 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_ptp.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_ptp.c
@@ -673,6 +673,9 @@ void sparx5_ptp_deinit(struct sparx5 *sparx5)
 =09struct sparx5_port *port;
 =09int i;
=20
+=09if (!sparx5->ptp)
+=09=09return;
+
 =09if (sparx5->ptp_irq >=3D 0) {
 =09=09disable_irq(sparx5->ptp_irq);
 =09=09sparx5->ptp_irq =3D -ENXIO;
--=20
2.55.0

