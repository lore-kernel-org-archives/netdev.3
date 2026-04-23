Received: from mail-4318.protonmail.ch (mail-4318.protonmail.ch [185.70.43.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CCB52DEA74;
	Thu, 23 Apr 2026 07:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776928993; cv=none; b=TPsHjxRE/HUFcEiN3/vzNjzNtcW5LDQ2NcIs8spYRobRVBgIygHxr73y0ewYzqfS68XSqPqHHkRbj0mbVIXvmLxbSsOfBbhjv1B+cK/IUCQ66YTr66MjaSHQ2SmQ1AU1bH7VsNpIjoHRDx3Ldj8y+JzID1HgRVyAcd3gTHcAyfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776928993; c=relaxed/simple;
	bh=Arx4hOYjLkGsnfY6tXgcbFX1wKOxubgXKQeBDqdW4X4=;
	h=Date:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lDq4G7Am8mWvWRpCnIJF3UIlIvgqBn0jLIZIgVgUaqSeIYiDuHnDZO89tBKzRvwmmr8mBlMqrOz+ozE2R6UN5u4wWcICz+0O7JcOD8yYUSOPLHyTjQ/CIm4AIK9UvNqkXkJLO+zGJmyRgvL3owMUxpTflTA9kZku6csCzIoXJVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=leavitt.info; spf=pass smtp.mailfrom=leavitt.info; dkim=pass (2048-bit key) header.d=leavitt.info header.i=@leavitt.info header.b=Kz3+aLTi; arc=none smtp.client-ip=185.70.43.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=leavitt.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leavitt.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leavitt.info header.i=@leavitt.info header.b="Kz3+aLTi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=leavitt.info;
	s=protonmail2; t=1776928990; x=1777188190;
	bh=R3M4S5i9yX5QgyGHLDpIQ0EoTADd9Orpohb+BkQJq0g=;
	h=Date:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=Kz3+aLTioi8WF2EV1r/QiLGs+5J4XbE94aZMAwyuX7wbgyNwhrg+K8rdZXrxZ5lt/
	 h+tlX7x61iTGpG6ZykrBvr1MZAM1NzYUY4tdnSE4QLk66Dytz+AHFcOpyiWS2VF2vi
	 3G0K0rfUJ6RTXOpjVeSJPE3Jr0d4dncX6dBWY2Doue6eC9qox+ufjsBX/wVWdX+nYk
	 dub1wDs+2ZMLVyF+Pw5Sjc4k5hjQNFK/Gj2ITNtodMDvR/dmKXIULApoGk/gAuMLoK
	 2AIOM+zoVJMFVfQ77zv/eBHjMnFgVRMxl3TCGIeBzw1DL8ThKiKb1KG8bZUWmcOkej
	 HhAkEk+iHkzGQ==
Date: Thu, 23 Apr 2026 07:23:05 +0000
From: Corey Leavitt <corey@leavitt.info>
Cc: Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Corey Leavitt <corey@leavitt.info>
Subject: [PATCH RFC net-next 3/4] net: pse-pd: fire lifecycle events on controller register/unregister
Message-ID: <20260423-pse-notifier-decouple-v1-3-7d4856f686f6@leavitt.info>
In-Reply-To: <20260423-pse-notifier-decouple-v1-0-7d4856f686f6@leavitt.info>
References: <20260423-pse-notifier-decouple-v1-0-7d4856f686f6@leavitt.info>
Feedback-ID: 22087991:user:proton
X-Pm-Message-ID: 9786f841e078a3542c664a83c2acd05174e23d04
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hook the newly-introduced pse_controller_notifier chain so that
pse_controller_register() fires PSE_REGISTERED after the controller
has been added to pse_controller_list (i.e. is now resolvable by
of_pse_control_get()), and pse_controller_unregister() fires
PSE_UNREGISTERED before the controller is removed from the list
(while it is still valid to dereference from a subscriber's
pse_control pointer targeting it).

With no subscribers yet, this is observably a no-op. A later change
wires the phy subsystem in as the first subscriber.

Signed-off-by: Corey Leavitt <corey@leavitt.info>
---
 drivers/net/pse-pd/pse_core.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/pse-pd/pse_core.c b/drivers/net/pse-pd/pse_core.c
index 80c5c6c1758c..82125502a8e3 100644
--- a/drivers/net/pse-pd/pse_core.c
+++ b/drivers/net/pse-pd/pse_core.c
@@ -1138,6 +1138,9 @@ int pse_controller_register(struct pse_controller_dev=
 *pcdev)
 =09list_add(&pcdev->list, &pse_controller_list);
 =09mutex_unlock(&pse_list_mutex);
=20
+=09blocking_notifier_call_chain(&pse_controller_notifier,
+=09=09=09=09     PSE_REGISTERED, pcdev);
+
 =09return 0;
 }
 EXPORT_SYMBOL_GPL(pse_controller_register);
@@ -1148,6 +1151,9 @@ EXPORT_SYMBOL_GPL(pse_controller_register);
  */
 void pse_controller_unregister(struct pse_controller_dev *pcdev)
 {
+=09blocking_notifier_call_chain(&pse_controller_notifier,
+=09=09=09=09     PSE_UNREGISTERED, pcdev);
+
 =09pse_flush_pw_ds(pcdev);
 =09pse_release_pis(pcdev);
 =09if (pcdev->irq)

--=20
2.53.0


