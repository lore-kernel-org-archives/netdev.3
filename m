Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 773A540DB55
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 17:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790099324; cv=none; b=bLrW2eilWLGmfZb9eHbYhriH1jnazrhP7NG29RLoJJKQ6b3a8gjIZ+xxyuhjoC9sfCzlEeFeCaoiucS271XaVmRXN82tFeqrAeQiDl3TePQMuu/vYCKsonjslRJUNkf1o540PihfgxD4cg1W35U3zGO/cJwq3Uw0qcUX2o5INVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790099324; c=relaxed/simple;
	bh=DYBLTmQm3d8z7Y/mvDX8uCAkuTIvawyenJwLpzlaAvk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iOBkKawhciB8IiJQ8Wsh2S4LAxYyNjnESWTgIV9nr/lZOHJSTEmZT6LVvAkIRIXhuzB9WRLxgmz/K3NizC5NjNYY2fQ0q/ci1w2MmX3W2IZeuR8niQQC/RoIavXL6lEoyvnT7DCd1vEYJF4ovNcMXgdS6nGzFX/9vOhoqNDblY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QGeRgXkj; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QGeRgXkj"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49b91369d18so552955e9.0
        for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 10:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790099322; x=1790704122; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DYBLTmQm3d8z7Y/mvDX8uCAkuTIvawyenJwLpzlaAvk=;
        b=QGeRgXkjJSf4vNpWFf+kqqUnLruePfWJtR4rrcATqKKvjvNCW8PvluQnmcHoC83Dze
         OFu+x5RcjTf78ZDs2ydJv1U6K0Jop1kWruVC9Ej1ailh4IMGhDQFfKjhwP5RFMOe9vtA
         oF6VXaA5CsJ+xlsLrNBzb9zQR8Be2CZrgZE7T4EBCTaSIbOplf/e/TgudmZXKWzFBSjD
         j+Ey5QzFji7OdvTO4zWLT9yBjDIFWCRVHWlW84oZZHakyVJy2QKj/DgrXTzeoDcL+nOa
         nKUE7DGW+yLCSB6USKC0LFNClHd4uNbiuFNAtDbavP1V1q7Eo/VMzyUPkGwiu4kyj1dL
         wv+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790099322; x=1790704122;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=DYBLTmQm3d8z7Y/mvDX8uCAkuTIvawyenJwLpzlaAvk=;
        b=NHCuPlPtqGZVf6VdDWsfp1hwo92lb6nxMymLMWs0yHJTOBZitjA0QBs3c2/nSjxbST
         kHF9PywFgkN1JlW1vIU90fXmg1hIVbEeK8EruIAe8QI8xUpWm82yj7A0c873uO9iepsY
         30vQLJv11+/xN0zfmKukk0oKk1yE7n1YnX5wJXKrkcHW+TSVOfsn8vHe8hL4a4o/M7eC
         cWobFtJA1gqffR6cd8xBXoaK6Nvl3Ww1ijXxMy4U4m2oVNeXc14uMPaspms+snjB5D+W
         g82NDJ/WTji+cuXYYU/ZZvag7sAhrRfUvwC8M8rK85zKRMjDVNQngcGLMUwN2z+3faKG
         apLA==
X-Forwarded-Encrypted: i=1; AKwUvBxvqty32CMH/hrIaP7pgdztd8oPx+pf9U2Q30n/5o7dOxXiX0R+mlBY9RPUdlws1WQDO7NkZ4Y=@vger.kernel.org
X-Gm-Message-State: AFuF++nlgYzYXyXHdXOwY52dDDq3hwoeEmgYhLGPNVO3bc8inXTIK3pz
	HkcZGpZkfXLUrDM8CkLOpnfBRsY8jxJP4rnsBH71UifDaYucdcwJCKdA
X-Gm-Gg: AYBFou3USF+yaa8+9wB7br4nJtbHwx2Se8CZuiwcamKdiIri4HWTHKEzH0feGK82iDj
	3VL3cpHY+U+O15+DSsTfQTiFPeSyLMiQrl2JwCAjm4Hgqhsjyj0EHB1u2UA+pDrKhdiEbGy2NNH
	g0d/VjO4gx2p1wjotMz6Fvt7QC7ksXJPVMJ7IuXRnsTby7JIDzO8Zu9HwlWgOvutjUkdNeivQKW
	4tr321eph8iz9cNl4BquQtS5W/KUvswJN4NvZhmQWsOUOAYgUJXuEjBGTN2Aq/i7e4ocolEx3Ya
	eGYX3Sdw0gbeZwY7A7gw4IRDHp8VG93f/zG00oI9LL5ysRVeqZDmSfNOLXvl2jpHa7IE/tgjLPQ
	X/J2Ndab9DGP8xxaDr1OqiIldAe5w2EOaWBcBRzOvIrUiJYF1SjWpdys3TzO8bQ0TmTEK8/QVXj
	Qzydr/VNpB1IvqxmM+EgxaSlp2enXNJQK6R/gjC4cSpaEPbU+n9Y+aYgRl8GHkoyhfr1R5ySUJn
	5XA3f9QEPEdYPTgPHw=
X-Received: by 2002:a05:600c:548d:b0:49e:816a:9bae with SMTP id 5b1f17b1804b1-49fc58500e5mr215554545e9.28.1790099321368;
        Tue, 22 Sep 2026 10:48:41 -0700 (PDT)
Received: from christian-ThinkPad-T470.. ([2a03:4460:170d:5700:2232:eeab:adbe:6c40])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fdaaf97e2sm36382125e9.2.2026.09.22.10.48.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 10:48:40 -0700 (PDT)
From: Christian Melendez <chrismelnu@gmail.com>
To: Jonas Gorski <jonas.gorski@gmail.com>
Cc: =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= <noltari@gmail.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	netdev@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: Re: b53.rst: is the 5325/5365 "no tagging support" section still accurate?
Date: Tue, 22 Sep 2026 19:48:01 +0200
Message-Id: <20260922174801.261426-1-chrismelnu@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CAOiHx=mJZKk9dT93am0o58Th+yPo2aGj6T4aFWkyeQphPwu4YA@mail.gmail.com>
References: <CAOiHx=mJZKk9dT93am0o58Th+yPo2aGj6T4aFWkyeQphPwu4YA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Jonas,

Thanks for confirming!

Quick follow-up on the "configuration examples look horribly outdated"
part. Once 5325/5365 move to the tagging-supported section, the single
port/bridge/gateway examples further down only apply to 539x/531x5. Were
those outdated specifically for 5325/5365, or wrong in general?

Best regards,
Christian
