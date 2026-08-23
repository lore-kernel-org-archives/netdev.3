Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 214811E1024
	for <netdev@vger.kernel.org>; Sun, 23 Aug 2026 00:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787444572; cv=none; b=J2HRDQH8qV5SYM1mHRTd6jrW2jCArJlx82b7+LjWYhrZZnfzfngoawHKqkB1RZ1Jz/ZwwyjsHdPW5dgobquYF233VvrV2S6Mo1tUkpWZjxa9iFcfMXDBMBzymSSlb7gul0gq5eHIKSDU6UyzLUEU9oeJQ7hutB/zA9fLNxET270=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787444572; c=relaxed/simple;
	bh=PnfycOpIeVLKHmflGiUF526cXqauQ3cReF2OjuRBrdk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bruwp7RKzs0wBjLAHuAqBpLENX182B69ipYbz10ic2vkfHZGCWr9Ktmfj67vlbyTdQ0AiBkuz9rFa4IJy3CUQnOdUi8n5LvLXDEmfk6dt6yHJUUa9w+8u1oOg9jK61KbvRy0jUiwJ60KnMzwYkHFz34ziViIkshwqYXpY/AUi+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la; spf=pass smtp.mailfrom=lex.la; dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b=GVO2adbP; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lex.la
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b="GVO2adbP"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-c15cf78d1a2so258338266b.1
        for <netdev@vger.kernel.org>; Sat, 22 Aug 2026 17:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lex.la; s=google; t=1787444569; x=1788049369; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PnfycOpIeVLKHmflGiUF526cXqauQ3cReF2OjuRBrdk=;
        b=GVO2adbP3Rh+tY9bjOWmsUTnK6YUer80M6KbtIHfR5BACdryy5Qf+kqHko+5yXIOYj
         DuoDS0aDtin/f9P2FsYsTrt++tXrMP8Yxyuqt+pCE6NcnKfZ2AVHHi0X386sQ2fPccSc
         dzuLvWCgWDQC7ejBPXg/PDQvrmdDXQ/m31qeXUsEMuqL8oRQXcT5nHFKe/4QN7sNvVPj
         691TQKh52gDGXw7cllPMnpLdNzTWtEt+0qv3lBOPNXqjMU4uQsnnzLEk8zUqM5+4v2XK
         ylhnz0rHPxNF2NO6yZtplZ3ycwGagC0gvprES6CfVi/VLIfkX0mB5x9edoEbwcjW59a3
         3ZWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787444569; x=1788049369;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=PnfycOpIeVLKHmflGiUF526cXqauQ3cReF2OjuRBrdk=;
        b=lc/IFL60YFIyHPsMoUxmR/c0hSjTS/7tdTW7ref9k6ObmgHHi0+2aSDx8MP/rgYVfk
         rhjCOE39yoYbYNKfB+vPmYEB89vuUzo2XCVzuUKXo7nvsvhMRG9m5++JmEemMN5LjVKn
         vpksXWXqNxSHcIS3atTYRNO5tVmENCccbw9GKA3FvzRv1sOaF41rESbsE37qHfGlKFNW
         3E7juIQ0JSQ4mD40u7nhWUqNRuEWBJMw9Emd4NBeWV4pZF1C4wVOJ+gIq/DzNSMLXdct
         te5fnkaty/gCsxq59jdqk8brqYSWpOeKqlds8Gylf7Xh2Vw25eIAnlNDEn4BX7/gxGDk
         lp5A==
X-Forwarded-Encrypted: i=1; AHgh+RqH/W52bspNABGnR1762mLWVpCl0Rl8qVGHCzayRh68Aoodc54oNAVDLXagVsHxI3F4IJdsMl0=@vger.kernel.org
X-Gm-Message-State: AFuF++ms6YcTz38BW5gCQ6/Luo9cwytkLfsajN3pHs6JKwV6j4TFtPPA
	rViRS3U1VlU67kVUC/9s1qePd6/RwMW7eZO2EwsogDrHU3lM/gref8UMtpTNQ477ioLkpTyVyGu
	uzsYDnZ5KQA==
X-Gm-Gg: AR+sD132D2HHYYM7Gz+ar/aRhWDMFrdyYLvrp4Eo99cApG7cVDTMKtdN5CbEZlo0aAl
	qVdr+qJEMTMEwlJRf4733GSszaabTUZepQbS5BkE7vPDL/NDYG+wiIvU8mcxzMJq5SAWZWg2v4A
	zojOoKaPp7RoAzCNwse61wl12H1R8lRCnp6JFGmntjieootCTAzhwwIDTyWq0uUJjE0Ez90wrmI
	HV9soqSwsT86piMXpF1RQI55ppyLo+wR78OXbAph1kFKqpN9+yu5dV/mdH+ZG1DpKjmOHwfonCP
	yoCbYEcdNb2AeR7vdd45AgLUjaDvbctOz36M5BKDhDrOOau/6ptUUf/xEhQ1bPHdBmUOerMosXj
	4Bn6IiiQFxMbqPyC5Aj3XwROVGF82cTGyWWwceUBUwlo1auvsi5IWiHrWMOcm0DqJVXOX21h3WA
	6Sn39af+OosgxH4mEjWjoj8RVNS7iEDN/IFWU45w/D1R+xCrSmZR+5dNBeIaJpLrOhPfUC291vH
	i1GiDZZ
X-Received: by 2002:a17:906:6a27:b0:c20:2eee:97be with SMTP id a640c23a62f3a-c246a33ed69mr1775593266b.7.1787444568708;
        Sat, 22 Aug 2026 17:22:48 -0700 (PDT)
Received: from ownbook.home.lex.la ([84.17.55.225])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c24968a2e42sm438394466b.59.2026.08.22.17.22.46
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 22 Aug 2026 17:22:48 -0700 (PDT)
From: Aleksei Sviridkin <f@lex.la>
To: Andrew Lunn <andrew@lunn.ch>
Cc: "Chester A . Unal" <chester.a.unal@arinc9.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Vladimir Oltean <olteanv@gmail.com>,
	Felix Fietkau <nbd@nbd.name>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	Russell King <linux@armlinux.org.uk>,
	Qingfang Deng <dqfext@gmail.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Aleksei Sviridkin <f@lex.la>
Subject: Re: [PATCH net 1/2] net: dsa: mt7530: populate lpi_interfaces to fix EEE support
Date: Sun, 23 Aug 2026 03:22:46 +0300
Message-ID: <20260823002246.28455-1-f@lex.la>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <c501d5f8-015c-4ce1-87ee-c4cdaea57f7e@lunn.ch>
References: <20260822195252.2934-1-f@lex.la> <20260822195252.2934-2-f@lex.la> <c501d5f8-015c-4ce1-87ee-c4cdaea57f7e@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> This is very verbose. Is it AI generated? Please revise it and make it
> suitable for a human.

AI assisted, English is not my first language and I lean on it for
prose. The verbosity is my fault though, I reviewed and approved every
word. v2 will carry the Why only and move the mechanism notes below
the scissors.

> It is normal to assume phylink is correct. Now, if you do find it
> doing the wrong thing, we want to know so we can fix it. So if you do
> want to validate it here, make it very noisy if the validation fails.

That note was about a possible defensive check in
mt753x_phylink_mac_enable_tx_lpi(), not something this series adds. If
I ever send it, it will warn loudly.
