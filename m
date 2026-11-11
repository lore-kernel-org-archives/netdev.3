Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794415278;
	b=4mERLOOmI+VkU0oc1uFkq6YrJSpvz5KWRMlpAKoqjvF+/XDr9/dd+d3Zehnn1mqNl6c8
	 DcMitoAv6+gR9IAukuRNw4elH2aAXnPi249pwwKSIz3+UDEINWr7e1gMBwGf50m0zUSDq
	 aRB+va0B/DuJi/a8JuD2ptHMo/2350oQgiplCNVd0h/adG4nHKJNpeRiPs5/baFghYBJ9
	 I4K3z6Ba1VwBVmKckc2BLXPYjiNXnTbTwoxYScibUFPJX543U8BseSOyMUItEbrlVzy6l
	 G8wif6E5dHnp6yyBPRyAweWDLNqqERi2zqwe9acca1EwV8g/Obalk5A/l7I6+tDJGtw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794415278;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Scanned-By;
	bh=jOxpAWZEDjh6YuLzUFmhUB+/S4//KD7ZYS5impIWXLs=;
	b=E40hBukZNA1AZ/GKn2YbIiQTBNu2a/d81/54KU8KnpuHpAbE+1vExj4tInv9sObFzw62
	 QvaYall4mGU5dtAMc5/NPJSROYSwr3BrjKf4i3pmkRClKXTojndudbORI8qAAyHGQ3z57
	 KYUfN7JeY9Og97RPEu8xsvp/qb/7JHDN5M1BCct0w9CBX8LJmc0zv1+02omLx733YPd+8
	 FbHRMQBwML0csiot8WgcHBNcR1Uj7fIYHkFH+ITW/GsLct3edW5ThVIWHaKXKKHhVeq2c
	 BKo/eDeJmBX2P+UcXOZ8tVCIgi5yeO45lCkvplhVbpEwwkoPxGDbh8e4y2lyH52r8iw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b="Ssbkb/M4";
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B62560A383B
	for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 16:41:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6B62560A383B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Ssbkb/M4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794415277;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jOxpAWZEDjh6YuLzUFmhUB+/S4//KD7ZYS5impIWXLs=;
	b=Ssbkb/M4hjVGgcTStFnCvemKHjJqqZJg8tYj1vvp9P1d7Bx5g/q5IFApXS1UEK7qJe8SVh
	NlBDRJpynvdbFtwT+PRMQRbdB5bHLRxQ8jEPI3SDewQiDna2AvPPaoMc7Xd3fFes4WNOoe
	ycLgmW/eWqmBmfzC8qzEWCcruaALTK0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-388-jlDh60aTO8q3L_Wbnk2pqg-1; Wed,
 11 Nov 2026 11:41:14 -0500
X-MC-Unique: jlDh60aTO8q3L_Wbnk2pqg-1
X-Mimecast-MFC-AGG-ID: jlDh60aTO8q3L_Wbnk2pqg_1794415272
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EAA7A1955DC5;
	Wed, 11 Nov 2026 16:41:11 +0000 (UTC)
Received: from ivecera-thinkpadp16vgen1.tpbc.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 61D1D410;
	Wed, 11 Nov 2026 16:41:06 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Min Li <min.li@microchip.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	Grzegorz Nitka <grzegorz.nitka@intel.com>,
	Karol Kolacinski <karol.kolacinski@intel.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Petr Oros <poros@redhat.com>
Subject: [PATCH net-next v2 7/9] dpll: zl3073x: update locking comments
Date: Wed, 11 Nov 2026 17:40:18 +0100
Message-ID: <20261111164021.273409-8-ivecera@redhat.com>
In-Reply-To: <20261111164021.273409-1-ivecera@redhat.com>
References: <20261111164021.273409-1-ivecera@redhat.com>
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
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

Callbacks are serialized by the DPLL core domain lock instead of dpll_lock.
All channels of a chip belong to one domain, so what the comments rely on
still holds.

Reviewed-by: Petr Oros <poros@redhat.com>
Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
No changes since v1
---
 drivers/dpll/zl3073x/dpll.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/dpll/zl3073x/dpll.c b/drivers/dpll/zl3073x/dpll.c
index 1cdadb8e46fb2d..6e5e2bb41f55d6 100644
--- a/drivers/dpll/zl3073x/dpll.c
+++ b/drivers/dpll/zl3073x/dpll.c
@@ -349,9 +349,10 @@ zl3073x_dpll_input_pin_ref_sync_set(const struct dpll_pin *dpll_pin,
 	if (rc)
 		goto unlock;
 
-	/* All code paths accessing per-channel reference priorities are
-	 * serialized by the subsystem dpll_lock, so it is safe to release
-	 * our lock here before iterating over the other channels.
+	/* All callbacks accessing per-channel reference priorities are
+	 * serialized by the DPLL core domain lock shared by all channels of
+	 * the chip, so it is safe to release our lock here before iterating
+	 * over the other channels.
 	 */
 	mutex_unlock(&zldpll->lock);
 
@@ -2401,7 +2402,7 @@ zl3073x_dpll_changes_check(struct zl3073x_dpll *zldpll)
 	mutex_unlock(&zldpll->lock);
 
 	/* Send notifications outside the lock to avoid ABBA deadlock
-	 * with dpll_lock taken by notification functions.
+	 * with the DPLL core domain lock taken by notification functions.
 	 */
 	if (dev_changed)
 		dpll_device_change_ntf(zldpll->dpll_dev);
-- 
2.56.0

