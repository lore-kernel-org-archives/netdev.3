Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 897AE41D214
	for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 14:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784815557; cv=none; b=Nqrc21JGfbRTJpDUDJONSFOnF64vvm+ForxYWJHAbVvn3YF9CCpcBLqZmA3OSFEReWVWBUGK2gdN7Br6qCX/GY2DSBJeUbvHCw+CTO8VnzKSlG8x+qKUm6Gb/KOJgxF0LyXiTjnXCJcDpbcMKf5Oh0kpfV45ECmMdNMW6rzbDIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784815557; c=relaxed/simple;
	bh=i0sL2xzcP+kHMlOaqKjFN75K9u2lW0n2suwfnA6NhF4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LbELvWJUUsVy2n0GFzpsYdALzDbIp/l3GFOFT2ml/7LaFkvBr+K6aG9DqO9AIivSZR0Lgeb0XhYdM9RvQOi/rTlSZNlvNgldC6Ec25N2TNViicxgmnJbJ+PeS4pKCC6sQ4nlN7mbIYDZ5pEg0psNZ3GdoVUeKIDo3w4e7rN9rJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E7veLQr9; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=nO7NdZKZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E7veLQr9";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="nO7NdZKZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784815555;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OAGB+hnDVwiPeefwu8aOxBU9oUq2vbyk1XBqwM5436A=;
	b=E7veLQr9ni9W0XDdUH9s5Uv8nMWgjn/asW0Mb6PXNnyHkiUXIxdJgOcuIfXM8mdz3MyRhs
	ESha1f4wDw/BXGMDUnkuWQWb/7P5JtzK/DirOKpv/dX9x2r+VBL0ukSXORrVVm6+v2FGZY
	IL0bMoZwm31zHme1hcjfWodVEsHm3DA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-530-ChMOVuE3MUC4NnsYLf2LJw-1; Thu, 23 Jul 2026 10:05:52 -0400
X-MC-Unique: ChMOVuE3MUC4NnsYLf2LJw-1
X-Mimecast-MFC-AGG-ID: ChMOVuE3MUC4NnsYLf2LJw_1784815552
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4926fa2cb17so4464795e9.1
        for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 07:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1784815551; x=1785420351; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OAGB+hnDVwiPeefwu8aOxBU9oUq2vbyk1XBqwM5436A=;
        b=nO7NdZKZ7V9A199BDoRILlWMXXTMmikPWmIxMSJL80iwlzl0hzDPzudobVskGosSNK
         /Tzc+kw7TPRnaOIe+vHaq0UNk7ohHgboymXdTlcLkE/KaWSbe7vpE1hGisnQp0B9OpDf
         bOsmq9yAjY1J/r6AnqjnnY0828ozUAX4+XU+35HXchO5oplqqfGdUJ2hViwoIm2I2nqh
         4eT/jAno/1SvRhsaM8NJvHI5Nl3uOt+fx8CB/e5Et5USgxiVx+vY3FejvSvYVXM80Upe
         QMZa1wbq+wDKR8ks3A8FRPrA7yaj7efloqOuB3R/ncEUMwsQoxPL+f9Fssa8BB7hEfbU
         k8FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784815551; x=1785420351;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=OAGB+hnDVwiPeefwu8aOxBU9oUq2vbyk1XBqwM5436A=;
        b=UQYUVAvTGwsSPDzc9oRpCyvRqjrmLfYvXECX04tVib6KHpsycKDE4WNC7fiQnBh/Tz
         QriLgClkrGD8/AMDmc77RnuGFubJE1zzSJVfGIJEG5KVfg1P3nLEEe4pWhQHBJ7Vzio1
         5sma/ePr4C52SJp+5IQrS9Ler0ABYnxOswufFfdJHmzEqvNXGY9xPnt1qsWWFmK+uFCP
         qBk/jsOYOZ3BnX8kPute88X9zXG6TAlw3eOTsLWCNrVjhXnFfEPL32E2z24mMwXw1zFw
         Rzpsm8FMBz2ODPbb1Kn1sHlpEA8mntUUy4uub0xZ/TexZ2ZVsMRgP3fOeE/Bfbndes/j
         n4iQ==
X-Gm-Message-State: AOJu0YzZ+rgPlX8rmXhk9KBkoc8RfAYHlcnMKCyGd+72gGSNdJuAgked
	dKSrL9WrYVTNCbG2U7nMObOlI3PbsvP4Wwr3IlDO9yDbu6+qgSoVPltu9sks3eps+uY16/Ybr7Y
	Qb0iEc7QDKl0zaXN+HoJdzG20gV71/xpMdEyGjrUwFV8QFHhAoDKgR8JtDw==
X-Gm-Gg: AR+sD10Kk1D4gWzYUXi6bXjs7CuF1iySdrZkPsLx35p20CmTYO1ORfAeLoHGlHcT/Mo
	z+aCFAI49l/Z2vcRc6OjHtGkbY3p80OL13a9uaXcO4Na29zwvXdy6cYj9H8898fAPh98MkO8o+e
	gOnwUjpjc9tNC2fz5wl619ail5S5M2VXO7VRsmyDYBseFUHuss3B5CEcFll1mlHT5Y9c/12cmvg
	jvatvxE6AaMt9HoRDW9OLwzUmX6BeMW+W/IWLdzVD7C8VKIyCTnsZwP8mVE/Dbqg8uMiaKW9wEg
	6LusbJb44KSJH3R5bAS1FQXRrzxniFvuPxHsI4S9Cl0sfsjQEk028DRf0T1JdNlul3yDT8Ekjxx
	m2qc7OOvyX44R2g==
X-Received: by 2002:a05:600c:630e:b0:493:f783:c46a with SMTP id 5b1f17b1804b1-49574589f9cmr28902785e9.6.1784815551559;
        Thu, 23 Jul 2026 07:05:51 -0700 (PDT)
X-Received: by 2002:a05:600c:630e:b0:493:f783:c46a with SMTP id 5b1f17b1804b1-49574589f9cmr28902145e9.6.1784815551125;
        Thu, 23 Jul 2026 07:05:51 -0700 (PDT)
Received: from fedora.redhat.com ([216.128.14.205])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4956a4aae16sm154261685e9.0.2026.07.23.07.05.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 07:05:50 -0700 (PDT)
From: mheib@redhat.com
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	jiri@resnulli.us,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	corbet@lwn.net,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Mohammad Heib <mheib@redhat.com>
Subject: [PATCH iwl-next v4 3/3] i40e: trigger PF reset when re-enabling ATR via ethtool
Date: Thu, 23 Jul 2026 17:04:17 +0300
Message-ID: <20260723140510.184819-4-mheib@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260723140510.184819-1-mheib@redhat.com>
References: <20260723140510.184819-1-mheib@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mohammad Heib <mheib@redhat.com>

Toggling flow-director-atr via ethtool private flags does not trigger a
ring reset. If ATR was disabled while fd_ena was cleared in the TX queue
HW context (e.g. after a ring reset with both ATR and ntuple off),
re-enabling ATR causes i40e_atr() to inject FDIR descriptors into a
queue where fd_ena is still 0.

Trigger a PF reset when ATR is re-enabled so that fd_ena is re-evaluated
based on the current flag state.

Signed-off-by: Mohammad Heib <mheib@redhat.com>
---
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index 6d2b076049f7..bb37f8cc4643 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -5301,6 +5301,13 @@ static int i40e_set_priv_flags(struct net_device *dev, u32 flags)
 	    test_bit(I40E_FLAG_SOURCE_PRUNING_DIS, changed_flags))
 		reset_needed = BIT(__I40E_PF_RESET_REQUESTED);
 
+	/* Re-enabling ATR requires a reset to update fd_ena in the
+	 * TX queue HW context.
+	 */
+	if (test_bit(I40E_FLAG_FD_ATR_ENA, changed_flags) &&
+	    test_bit(I40E_FLAG_FD_ATR_ENA, new_flags))
+		reset_needed = BIT(__I40E_PF_RESET_REQUESTED);
+
 	/* Before we finalize any flag changes, we need to perform some
 	 * checks to ensure that the changes are supported and safe.
 	 */
-- 
2.53.0

