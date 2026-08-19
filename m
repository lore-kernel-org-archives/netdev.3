Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE2E331A66
	for <netdev@vger.kernel.org>; Wed, 19 Aug 2026 08:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787128561; cv=none; b=X6ayIqXIweaXw3jR3IuAYtmJ7X/+4SrWPlqvo4CXgWanzR77SNF0/5zGzoqbQIxEapwlfPkaxzDB6/v23UlHOQspvz15dEJoBJh2KM8JXH5BrTcdVTXjVN6AfhQObJpVtFeW46VZFK6OaJdPtSG+KItA0sjULl//lz3XgCLbRdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787128561; c=relaxed/simple;
	bh=dS383OCW1Aroludg0MR17FGf+auCs1CSSLtinSaFfCU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=okyfyV5m5uXJG5YVDMjq5K2zJYhY9F227aqSGALEwzd5hwNDuQkMaoUuF0RYmbBcQBLXKKEeIn3Gexc6muf0Pt81Rh8v7XHaQz9Y1xVS2K59Z08m7qvz/y6HfffF3jcsUInQk9vmh7DGZD4YUu77S+NrDkz0uYqdkFoY/zJTE5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rqZ914SA; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rqZ914SA"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4996f1ee4a4so5724045e9.2
        for <netdev@vger.kernel.org>; Wed, 19 Aug 2026 01:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787128558; x=1787733358; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Jmfu7b6PffpBgbX6nxuZgDbreM6nRsmbmyFL2AjCNig=;
        b=rqZ914SA60UhE5UYk4VSgbpTJIeC1KjOKoey6q1pRHNefu8FMFemicIg6NT2q+bJ/k
         XfwG0VqxgUbd/S12PAhERBfnmB6LW1b5meM6f8QEuHi7vaDYL27YJ/D0d0R4xCvEvayf
         zvZvMvrOsDiaDgMjQJFYNXKR1lXVr8TJ5l2QK2C2Ly3p/c7WH0mwkHEhfvQ54CFMsjEo
         aK18HParY8FG6r9+alFYOypSiS3kWV5Jp9dbtjXsx10J8KbeWDWda88liWPM6BgAuvSF
         oKSDrn0UwOCtBKut8NhTevUXbVAGx1X0mPybc/fNkT03CJpNZQKlRabXXVgs9KIVL+8s
         b8sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787128558; x=1787733358;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Jmfu7b6PffpBgbX6nxuZgDbreM6nRsmbmyFL2AjCNig=;
        b=MAWb0b7m13uysby3PNuJ63wan7CV6FadmcTZoPp/mJlhTwOj4azu6TzF3TzHQx26VI
         lklbBnegm17rgeJYGUf4znvxcQaLgveVXmJsZaPH21CrLGDlj7sHpwRsZF0dwwYcR2Hp
         Ht4C8h+GvUXSt0Aaf6sbzlFHcuRocXIEFo120T32o/x9I4neHm/Y/vK99QWZ1g0RgBtV
         VPoFWr3KldeEjACCiEkMRAUyNNq6M8jdznPEu0rl5aWnO9gjTreh8lRIedCcNho792uV
         TqL+Gz53+XPGI0ryiO70xQl0UcYuOk0NIAj7fQQ5jdlv4yShzGkchoGOQJ2mX1xh68Ki
         gIoQ==
X-Gm-Message-State: AOJu0YyNBjCoLnjfq2mqBY+Hzu5u/HTVK/B8VCclv+MMNalo4Lx1Lby9
	oCmKzU7a2AjUaD1sKh+afl5dnPWWlKpGT5+f2Ou7NuvyFFt1G0Zprsrqp5ahNw==
X-Gm-Gg: AR+sD12yYDqYkhlLIxgR3bzAMw9h8y8ljydS1g6/SbAGySiHwnQKG6AYyBtzCMxQhiN
	6rZC4kQiPM2X0b1AldrwMBJKfSmTgZw7lUBNatSrruwLUjK419mlrbyAxUNki2mFsvHmqHFjkrK
	S9/lkfDLibLrVy2KEzIEhh5zAhl5YdBNUXblqyhH8Dtckk5DQZwg/OTe52rE1IdRx8acEvDBfL2
	vd+mwr41re2MWZ8iTKpg5sL6486bAfRUlQH0vTmRxLncH1aDKmEdvXFMxYofBXmc4JCIG1fqaqu
	ec4oDnXMXRXlAdOBjKz1xQLlb4++mQwlTuXLAvNRFvP8svYJWOHy1h/Mu7ZRK/xv9PCky3yI8Fu
	J+dBFEe5EF5VwA0nJ3hq08zm7mvgSCLN8741bT2OuZJybVdSHirFlwKu5rIa30Zn4d1xU6DdKl+
	63kmj6Ylm4CmmmmAqVYPhtcUNg7wVlD/Tjfnr9Zz1UVMlYxmf/q2TOeTlnP8P/KNMHosVm
X-Received: by 2002:a05:600c:3f12:b0:499:7a4f:d13d with SMTP id 5b1f17b1804b1-499aa199777mr50672285e9.4.1787128557716;
        Wed, 19 Aug 2026 01:35:57 -0700 (PDT)
Received: from SurHub.localdomain ([196.188.112.82])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499a9e09e87sm29215205e9.4.2026.08.19.01.35.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 01:35:56 -0700 (PDT)
From: Abdifatah Suruur <suruurism@gmail.com>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	quic_subashab@quicinc.com,
	quic_stranche@quicinc.com,
	doruk@0sec.ai,
	kuba@kernel.org
Subject: [PATCH net v2] net: qualcomm: rmnet: require CAP_NET_ADMIN in the real device netns for changelink
Date: Wed, 19 Aug 2026 11:35:53 +0300
Message-ID: <20260819083553.1134-1-suruurism@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260813174727.14857-1-suruurism@gmail.com>
References: <20260813174727.14857-1-suruurism@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A changelink() on an rmnet device mutates the rmnet port state attached
to the real device (endpoint mux table, port->data_format and, via
rmnet_vnd_update_dev_mtu(), the real device MTU).  The real device may
live in a different netns than the rmnet device (rmnet_newlink()
resolves it in link_net), but the rtnl path only checks CAP_NET_ADMIN
against dev_net(dev).  A caller privileged only in the rmnet device's
netns can therefore rewrite the shared cellular data-path state owned by
another netns.

Gate rmnet_changelink() with rtnl_dev_link_net_capable(), matching the
"require CAP_NET_ADMIN in the device netns for changelink" series
(vxlan/geneve, CVE-2026-68432).

Fixes: 2abb5792387e ("net: qualcomm: rmnet: Allow configuration updates to existing devices")
Cc: stable@vger.kernel.org
Signed-off-by: Abdifatah Suruur <suruurism@gmail.com>

---
v2:
- drop Reported-by: (implied for the author), per Jakub Kicinski

--- a/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c
+++ b/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c
@@ -312,6 +312,14 @@
 	if (!rmnet_is_real_dev_registered(real_dev))
 		return -ENODEV;

+	/*
+	 * The rtnl path only checks CAP_NET_ADMIN against dev_net(dev),
+	 * but the port state mutated below is attached to real_dev, which
+	 * may live in a different netns.
+	 */
+	if (!rtnl_dev_link_net_capable(dev, dev_net(real_dev)))
+		return -EPERM;
+
 	port = rmnet_get_port_rtnl(real_dev);

 	if (data[IFLA_RMNET_MUX_ID]) {
