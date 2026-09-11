Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B56B43785D
	for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 10:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789122925; cv=none; b=QE+WnrJYfmJqhFprcJYrHfQ6cGhFvCu+ZfFM1/LecBKPoAIkr4oUk6dyHS3d02Qhaly+6q/8fLtt/oXyzfK8cLKGXji+aLFRxLBUQUE5nbFwN1sAfU03rcHo5rq/XCGVngwLeBrUnT/4CD9iHvUX4ZJg/tJM7R3+KkCF5azjz5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789122925; c=relaxed/simple;
	bh=zynlzfsI6UwwodopzfzzUnIdemfXBhgywKabtrp2jXI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=eN+gdVjMmwclFn1MXc63YrN2dzIfBRw+8elizjxiHYFQ/f1mBO/f+p2ZDQUzY9U+30nHNVAadkBL00DL4GAYCX95+yOMkRWVl5fFV8PgroLRt7rcFyWmiS/qKhpPIsWjw1uCNfO1rUG8qea9Aut6ulERqEEQ4+JNcQolA8PQ0sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jV2/Dn4G; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jV2/Dn4G"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-48436216a98so462472f8f.0
        for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 03:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789122918; x=1789727718; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zynlzfsI6UwwodopzfzzUnIdemfXBhgywKabtrp2jXI=;
        b=jV2/Dn4Gav/TFU6PQfgQkm6TgJUur+I1+tzLEKEzHygOoPGgDhwIN4dOzSNIoejmPd
         4Z2igqUKgoVEly/bFesNpaWauJ50EoOrSUef+d10o8Jvv3cQEtjiqv1EGO/DyE7y6Cc8
         PwX014jR85PAJGoQQ8qB0Zq+aD45fSBara2oQ5YpCYFQ4A/ACXhZcR51UDkSZ6Sqq49/
         yYfESF5fFT8bSvt/EsStNYnRjKarty/wjw7+v7OjylrhPiL2+XkWHmqznx/o5jsHD3Mz
         j6dzWV7Awpe45Sq1YxwnKl54b4Rt/AjNGn8WKU6NaZyUqp+cM0EJh90y2GBlYQP51Vda
         fbPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789122918; x=1789727718;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zynlzfsI6UwwodopzfzzUnIdemfXBhgywKabtrp2jXI=;
        b=DmCY0/XqNtbpQxk/nkS0BFqwU2t9B9v9RhhDVIk+EmGl7hWGf5XWJx/wYX73nSvr9h
         HivwhBiEPX/qLNaU6xq1zpAHh/q1790sJUT6yQYTM7yjRBfCI2twnX9bZ4YGWcN8JTwO
         ISkH4lcPgkFkjtGNTzMXuabOh6dwDTKaQpbPqXkCkAlu0J4khaz2pyNLd9nN5bCNzupl
         Ijte+gdnl1HNuZO7khLrg8ojWmGVIIFywLHjqILKzc5kjm1xV5xlI6SXddWbqYvdNf+n
         iVUFKQy4s8ZanbL6WnBOg1WzQmG3iWsvfy8LDGVeT9pHy9Lnvt8dG3AsayP3N+yRcxPZ
         koqg==
X-Forwarded-Encrypted: i=1; AKwUvBxjqeRfsrwvpwuEn3c5cFgMg5F9u7Ng99/eSFjj+6ObMVD0W80ZFDR658GvLtfBuh2WBpdUq38=@vger.kernel.org
X-Gm-Message-State: AFuF++l/nfjKTgncFBbzUtiayUXXSvcC1ppLjAqslIbfirzXOC3tJmGj
	4XImlz5H94Oi3ApET8pmWM7sRhMhWHR2gvxOAt7vCAVqOg4E+3yOihKo
X-Gm-Gg: AYBFou1OLnIqxzvbWO9hBZQwY+goECUbn7ZuM+FvVjQ3UFltXF5fPfP6k7GDHceV34Q
	BrduucMMvy/CsIt9WINhTtUFmGmknKGZWYuCM/YHxH/oEThzH6A9JsgWKx5o2psu8NYXAMF0Lfy
	tBsLp8cwX/bz37FbloQasBfBkxH1k31FvlRjy06McWh+EE3z3154WOqTEWLt33iS+SDP0NT22ce
	augW9hGwLRsMVBGrDlf6fCb8oHVOHGDGyyABzhrcS+3zpbDN9vuX3VvlMNBbEhly4YK+Ffrvkku
	QfXowrbTeE6abPE0Km6D1sNBfvArAsAdHWog5A+8kWbsNBo+OaQMvQYPosGcsUCBixzFB5SGIye
	keLj2tgVW/31PSSlD73D9GL9kcIMOu37L26H9WbkEv+v0BE5PkaA08Lrrav6rQpA+ws9+ky/Wro
	I2FqrXvioY1Z5hrpnDQEmIRLkksU3A+wTtpillLeLEFmHx/w5t2B4oR08j0A9ojt3yLnbk0QQA6
	K+O4y3kYtCiDV+3Fwc=
X-Received: by 2002:a05:6000:40e1:b0:485:8c17:9764 with SMTP id ffacd0b85a97d-486eb30bca7mr3554741f8f.38.1789122918156;
        Fri, 11 Sep 2026 03:35:18 -0700 (PDT)
Received: from christian-ThinkPad-T470.. ([2a03:4460:170d:5700:26da:f468:9a65:f2ce])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-486eb2ecf23sm5177613f8f.5.2026.09.11.03.35.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 03:35:17 -0700 (PDT)
From: Christian Melendez <chrismelnu@gmail.com>
To: =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= <noltari@gmail.com>
Cc: Jonas Gorski <jonas.gorski@gmail.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	netdev@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: b53.rst: is the 5325/5365 "no tagging support" section still accurate?
Date: Fri, 11 Sep 2026 12:35:10 +0200
Message-Id: <20260911103511.171722-1-chrismelnu@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Álvaro,

Documentation/networking/dsa/b53.rst still lists 5325/5365 under
"Configuration without tagging support", saying they "support a
different tag format that is not supported yet". But
b53_get_tag_protocol() assigns them DSA_TAG_PROTO_BRCM_LEGACY_FCS,
which seems to have an implementation in net/dsa/tag_brcm.c
(brcm_leg_fcs_tag_xmit). This looks like it's been true since
c3cf059a4d41.

Separately, ds->untag_bridge_pvid (b53_common.c) is only set when
tag_protocol == DSA_TAG_PROTO_NONE -- which I guess no longer applies
to 5325/5365 -- so the VLAN workaround described right after
(removing the default VLAN 1) may not apply to them either anymore.

Is the doc just stale on both counts, or is there a reason 5325/5365
still belong in that section in practice? I don't have this hardware
to test against. Happy to send a fix once I know which parts still
hold.

Thanks,
Christian
