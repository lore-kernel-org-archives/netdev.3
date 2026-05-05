Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 339BB47F2E4;
	Tue,  5 May 2026 14:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777990583; cv=none; b=Y2ew2K/FmmIwx+3VgZzupeAgVi0EwUW04iEqmWT/jwb8agyr18hNI2dSkaV2mBcBtRWbRtX7QdnKIeFQVhtaCaQFS6dgeJQgmJ2iDkulc+TMI9alc6yh2DRY/3+Rv2VmfXBilpDr2naNwGzK+tAc2CSulqTr3LKWD0SqBWRsgTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777990583; c=relaxed/simple;
	bh=eozz5PgtLSMeaXnDUrKJ7JbM68q+LAM0bhErumiYpBs=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TKZQOlPV7MlpRp1w/Cgcorxgd0VWDwlOxns2ai2mR0vYwxtkH3rmc7lEwXWdEWZjl9Dlt5/1SGsEtk7brBhIum0EcgypakLmO82G1ds0e5fBE6xoxbiSAx2a+JUWJKzLO+HKfUEynbWo+nl4oKRRamPi5W4yHg/iIavNuOkNutQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1wKGZK-000000008Qu-3Q6t;
	Tue, 05 May 2026 14:16:14 +0000
Date: Tue, 5 May 2026 15:16:11 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: "Chester A. Unal" <chester.a.unal@arinc9.com>,
	Daniel Golle <daniel@makrotopia.org>, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	DENG Qingfang <dqfext@gmail.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	=?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
	Sean Wang <sean.wang@mediatek.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH net 1/5] net: dsa: mt7530: fix FDB entries not aging out with
 short timeout
Message-ID: <f285707e09a0febffd1b987f204ff4eb71736489.1777986341.git.daniel@makrotopia.org>
References: <cover.1777986341.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1777986341.git.daniel@makrotopia.org>

When setting a low ageing time such as 10 seconds, the algorithm in
mt7530_set_ageing_time() finds AGE_CNT=0 and AGE_UNIT=9 as the first
exact match (starting the search from tmp_age_count=0).

On the MT7530/MT7531 hardware, the per-entry aging counter is
initialized to AGE_CNT when a MAC address is learned. With AGE_CNT=0,
new entries start with a counter value of 0, which the hardware treats
as "already aged" and never removes, effectively disabling aging.

Fix this by starting the search from tmp_age_count=1 to ensure entries
always have a non-zero initial aging counter. For a 10-second ageing
time this yields AGE_CNT=1 and AGE_UNIT=4 instead: the timer ticks
every 5 seconds and entries are removed after 2 ticks.

Fixes: ea6d5c924e39 ("net: dsa: mt7530: support setting ageing time")
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 drivers/net/dsa/mt7530.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
index 44d670904ad8..b1903da7d500 100644
--- a/drivers/net/dsa/mt7530.c
+++ b/drivers/net/dsa/mt7530.c
@@ -1027,8 +1027,12 @@ mt7530_set_ageing_time(struct dsa_switch *ds, unsigned int msecs)
 	if (secs < 1 || secs > (AGE_CNT_MAX + 1) * (AGE_UNIT_MAX + 1))
 		return -ERANGE;
 
-	/* iterate through all possible age_count to find the closest pair */
-	for (tmp_age_count = 0; tmp_age_count <= AGE_CNT_MAX; ++tmp_age_count) {
+	/* Iterate through all possible age_count values to find the closest
+	 * pair. Start from 1 because the per-entry aging counter is
+	 * initialized to AGE_CNT and a value of 0 means the entry will
+	 * never be aged out.
+	 */
+	for (tmp_age_count = 1; tmp_age_count <= AGE_CNT_MAX; ++tmp_age_count) {
 		unsigned int tmp_age_unit = secs / (tmp_age_count + 1) - 1;
 
 		if (tmp_age_unit <= AGE_UNIT_MAX) {
-- 
2.54.0
