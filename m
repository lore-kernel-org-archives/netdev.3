Received: from mail-ej2-f42.google.com (mail-ej2-f42.google.com [74.125.228.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43352392831
	for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 21:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790200648; cv=none; b=i3nWvU6UY/qlEewA/NrjMZKk1zNZUY5cWec2DlVCe/XXRCy8sXFYulT3mD1cUg3wKbaiBuiTLIM5YNJSjUzjsmHQ09c6fVMPn5HG4ZZlIZdmrepw6vQXhvQblQWMHnGiHSRzlRpZppWiKf7tsB8Gn/FUgnWm6q3yvICnYeeN8+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790200648; c=relaxed/simple;
	bh=SCf6vNf8dd7fNoY/mRp9nnZ3ebaxr518P5ULTFmQIxo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=apFvOSVeyV+v/Xsxw1AkO0Kk6Kay9tFZMpcYaCinDt3HkMLaJJ90aS/Uacs6i9OrlFZq4hXYbNa1HO6i2dqczhM4hTksS+VcGvPx6UAYwMz7ILnMEa+RLR6WCAjg5fZ5lZfSBtihs9/t/hDaRPwSwO0MP0oDb1ImwPSJOqGb5U4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SQmi1CFk; arc=none smtp.client-ip=74.125.228.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SQmi1CFk"
Received: by mail-ej2-f42.google.com with SMTP id a640c23a62f3a-c254f6c7a56so185076166b.1
        for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 14:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790200645; x=1790805445; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SCf6vNf8dd7fNoY/mRp9nnZ3ebaxr518P5ULTFmQIxo=;
        b=SQmi1CFktGiriq0TX8VZemdmz29wGVjxuefDpckew8kMfBPZEJQvKPif4PAl+UWOl3
         QHkoBxu4mK4AG+2EvzTmcwHJUs+DPNr4E38Lc+p+yxk/EUHW0akZoO2+3tfdgTprkNjS
         o/yq1mRFRFJYV+GncW47lTavb1aHDGay6zqVQPEpY5Ay2uwUxTrITzO3dCbt39FOocCJ
         SYYqffBCu//c9TPJiF1uS+cV/ZeFO8TOJBKgNNc5+nW5UIfk2ShKHhy8ypE4/o7HXb19
         AHt6JhyrMuBoBIPz0Y685tHMMjlciHuA6xvSkKpXDfw6FRVf1XmUW7kfa6omrI5pZrbh
         qQzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790200645; x=1790805445;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=SCf6vNf8dd7fNoY/mRp9nnZ3ebaxr518P5ULTFmQIxo=;
        b=b+RDcMxu7Wh2Rkhdb6qcZiVp7BMZcUsa0DNKSVUVoV3PjuEJuSx/6v7Jq66uVMC7UA
         tyu1YgBExd7hJZxrmXmWLxGktfOSykejhvTbbxzgIHNxirn01y82CRgjNwBcTtct3n8l
         HXepBXl34SbKD86uL1eOlDPi8SS1PlFsjgWJGDdunfKHH+ewCfrj4N3/PO1cjt6c0hdy
         ziC5CbKdwB8dsegNDUmmIovaNqQu4MlOGW/DlPVxedtdVuIug1sEBIRDeKXMUjReP578
         Q47XTMgYXKInhBqVrUKYG+8immx7YnnZn0ojuj1ZgWbip2assyiKoOUEJEn8iWmYjTsd
         7crg==
X-Gm-Message-State: AFuF++m8vDqvs2kJxkXuFZvGiM6/gJ4IG4MHpjKNB6jTyucejsa4zN9g
	eBeY5iVrFq45dUACb/cvFEHi0H+xJ0QTGKIcE9B/Le5QUlUVP7m+wHon
X-Gm-Gg: AYBFou3yaPb/TcwfQFpoNAUuZ2UAb+gfDiuTMYO8JA9jpG1NYPvKUrzt+f9yi2CVtUP
	+SsufNpRW6+30Bj/1rqP7JdZ+t7hstBx9EW6w5Jmu7SJJU8zxK4oH7Qvhl+2q1yNgHPXQNovwPo
	F1udRow60BgHoo6CXwLyzfO2AuKUUPFJFTpI2C9038taV8vBjwkjfokuv5fJtnAayGPL0x/+UAU
	UZisWJM0a60wkwAsn/lSHzPPYVnnNZM81P+iet06OUJ9eotbr8FdaxPseNHLZ/dYDYWwG6xGqdF
	ykPFG3xjPBfubDZnZlkEks+fWNBs+w40yTnVepSl51v7UPkOFp7Tpo7Yz48lugAKmFNVarHhDjp
	Viizoa/3v2+NUIw3EcrVOg3IcRn7J5QTmtG79V7hEuftLBNOQMxg9PvfQq7fnNYRLlBFuIEp2EW
	WmW3wuBj1A22iWIb3lUR7x8MMXhLfDQV12xLRSwZsNLx6ZF1X2un6cQqTpLtwpTqeAyhQDhKQrE
	CC//bpJPzmgv2rIy4xfqja8mRdMGCyZ4wlqU41t9kVR6dgq9diMPQgE1eEU/M3xNRnfMceAb80i
	i92NEsJfXc/bP9BOUggr
X-Received: by 2002:a17:907:b04b:10b0:c29:4415:2ec6 with SMTP id a640c23a62f3a-c2ac528bcddmr464466b.12.1790200645262;
        Wed, 23 Sep 2026 14:57:25 -0700 (PDT)
Received: from localhost.localdomain (83-233-130-25.cust.bredband2.com. [83.233.130.25])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2aae6d2defsm196178066b.56.2026.09.23.14.57.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 14:57:24 -0700 (PDT)
From: Yongzhao Chen <yongzhao.derek@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org,
	Vladimir Oltean <olteanv@gmail.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Jonas Gorski <jonas.gorski@gmail.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	UNGLinuxDriver@microchip.com,
	Ziyang Huang <hzyitc@outlook.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Subject: Re: [RFC PATCH net-next v2 3/5] net: dsa: qca8k: serialize CPU MAC pause during MTU changes
Date: Wed, 23 Sep 2026 23:57:09 +0200
Message-ID: <20260923215710.1469-1-yongzhao.derek@gmail.com>
X-Mailer: git-send-email 2.45.2.windows.1
In-Reply-To: <367cdf4a-6944-4df1-a218-28fee926dc75@lunn.ch>
References: <20260922202653.1153-4-yongzhao.derek@gmail.com> <367cdf4a-6944-4df1-a218-28fee926dc75@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Andrew,

V3 patch 2 uses the existing reg_mutex across the CPU MAC pause,
frame-size update, and state restoration. The link and port-status paths
use the same lock, and the internal helpers do not reacquire it. I also
reordered the declarations in reverse Christmas-tree order.

Thanks,
Yongzhao Chen
