Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D34A53B8D4A
	for <netdev@vger.kernel.org>; Tue,  6 Oct 2026 11:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791286214; cv=none; b=olnniWzZHT2NOfqhYwNxUVWCP4zxPy6JLK53H6w1qLPi5LpecYu4kYrZLvkyfyATzgLWljqqc/FL32O8R4BHu56NuXEd89N87b3wT1YK630ZWRibw0SdT9XkINdmfodz5I+aCXroFFBKcyK0HrlOrNLzq/TWL8M4/GwUI2lNZ0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791286214; c=relaxed/simple;
	bh=t1eS7GNMzS/X1zSiiJQ+Thm7b5jH6tejPYkFnZ5ZqFM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=auKlMveW5OjVnVA+yon7KRBNzRb9l1vIeksU3M3RsLef89We2UV50LzZ3rrfGE6wJCcsVlnmV3ju2UWVvbyEiy3erjIv5Tz+7Ooe5MetbukHWp97UOCbGy26ajSgakQ/QYjTm33b6UtksN8PCMEZuUi+f1Dg1XjhrvIsp2xJgM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la; spf=pass smtp.mailfrom=lex.la; dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b=Mr0ld3vx; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lex.la
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b="Mr0ld3vx"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4a17b4c6133so5121905e9.1
        for <netdev@vger.kernel.org>; Tue, 06 Oct 2026 04:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lex.la; s=google; t=1791286211; x=1791891011; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=t1eS7GNMzS/X1zSiiJQ+Thm7b5jH6tejPYkFnZ5ZqFM=;
        b=Mr0ld3vxUODdq9tWW7gGE9RfU71+BPfUpVJs7NzE8MPzvW2M4yV3znHgKkowk/htu1
         mwWPcWvi25sMNdX2DnRYNSaqDNZR5fHH+42eon8o2BZT7amPEBjOEMTqsVYr0fH/0/gX
         HhaIcY+M1qQJbb1A6dXzq8LjhMx23Rr0aAMWB+WN+XfynDjs7mStTcQP1UEmzG9reZmv
         O43/G9sfxb7H/YArbVWrtdHe/QCEx9lMflQ94kRd0snMMlSatKhsAR3eTClTpWA3tWmo
         vdIx0TgdUF1DIesDKnZgBD/HizhEnpm/1B1WbFaYURHYzMEWF5rkRpq36EUlph31L3bx
         46jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791286211; x=1791891011;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=t1eS7GNMzS/X1zSiiJQ+Thm7b5jH6tejPYkFnZ5ZqFM=;
        b=be6icoEjj4BWQIdCAEKnlCIDngZ/HKYOU9123q7U6EQi2EcKjPHtU9Eh/MBqBJhzps
         /rC/BXkZKNdjGRYvL2IS7o+iUzINC5faaBJS8WWUbbH4U6/Oqa1S6+GMsNq+mnkjPWWi
         KabqhoLB6GDKU5IWP5CJuhxAZ4wpeQXYBcD6KcwJ+wFGGUTRNNThc2cn29VL60v16HlT
         4JnDFgAXzINicLsSuZSphN+JfRUrREa9HvLCUyoKiDttAWKr5NOXM9bcKSGcRuAYi//B
         vpQeDemtDI1oRBAnKRWzDQQ9hcmIWreKg3BoszMVC4/ML/UXnabpUSuNXB8o0ChdK7G+
         pK/w==
X-Forwarded-Encrypted: i=1; AKwUvBzkPjdBDKkBkstyjr9aujMmyKVBxDVMOM/clY2babtWKzXzSeQrSw+6q3iimNTl2rCsHDy4nog=@vger.kernel.org
X-Gm-Message-State: AFuF++kDiRYOVQvf/WlZejOXDHHMcJgbTWMv3BdauPblSp0fxoBKE7kg
	AzH8J5Gt6RMNLtlVtgM5Gw3iVEb/3bHPiPl5liwFxiESRcsVGuxqCoDf5KbE2hUa/x4=
X-Gm-Gg: AYBFou3Rg5BoRzRKLBY+9qtGVnGW2z3nJ7Quk3w+RnCokS1CGtT4Jb13EMtbWI2Hose
	ykrndKvdFIk5pn3tPuoUes/iXRCgDHjlDaZl320NAcFrLV6vEbcIUB/uQg3gGQ91H20g+1L53Md
	RLRqcCoeH8UrBuN2lCjE5fxlrCvSxHghe2+aM689x0sLYBM6ZwCf1kniYZ8V57PNFlbBplFZHSF
	A2geCfzMmjH0/saI584yA7uhg6khow47sCIIfwO6+bkLrRX3vDOPcPTEPR3llxL0b+KoMeUplRY
	9gbBjz6MHQ2M8HU+3XWYFtAMdzZHpkdlEb7WfTqYXJqC7d5ES/HmihQIbJuSMGIpWo6R1tuMAjc
	h6okTtS1jzl//OoUuM0LSL2mpg3JvmSGzci/JM1wfbreiTWA6ac6o699cRYye0//kMMwgnttt8Y
	+prFxZyu+TCv2wFJewQcPAabin4EDZHohbAjaHyvOXMBeDF3GKw0ws/1Ywdpw/IA==
X-Received: by 2002:a05:600d:82e5:b0:4a1:6c3d:cdcc with SMTP id 5b1f17b1804b1-4a17b5301camr21722325e9.15.1791286210143;
        Tue, 06 Oct 2026 04:30:10 -0700 (PDT)
Received: from remote-01 ([84.17.55.224])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a03ff106d8sm288381415e9.3.2026.10.06.04.30.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 04:30:09 -0700 (PDT)
From: Aleksei Sviridkin <f@lex.la>
To: netdev-bot+sashiko@kernel.org
Cc: andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	netdev@vger.kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	f.fainelli@gmail.com,
	woojung.huh@microchip.com,
	vladimir.oltean@nxp.com,
	maxime.chevallier@bootlin.com
Subject: Re: [PATCH net-next v4 4/4] net: phy: make an unbind wait for the attached consumer to detach
Date: Tue,  6 Oct 2026 14:30:04 +0300
Message-ID: <20261006113004.736294-1-f@lex.la>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <179120529945.434549.1233446733190047739@kernel.org>
References: <179120529945.434549.1233446733190047739@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Can this wake cause an ABBA deadlock between rtnl_lock() and the
> PHY's device lock when the PHY is driven by genphy and has an SFP bus?

A genphy-driven PHY never has an SFP bus: phy_setup_ports() skips
phy_sfp_probe() when is_genphy_driven is set. So phy_remove() takes no
rtnl there, and there is no cycle.

Aleksei
