Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B8DC40DFDE
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 21:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790111725; cv=none; b=QFx6U/0srFZJDrv2caYRuj7Q4SOnbqyPlpz1hfQz5vmUmmi0pDTa1FMksI+JUHkI9FoO7oZNiN7oMbgE24rsFBjO+drRLmlU3NOoczJJSBQbNCDBO+cZ5HVRP80yBrQ9QZU/OZrw3j+YMxAYgamAaxNk0QYv7SO2LodK2WCupx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790111725; c=relaxed/simple;
	bh=FawpcmzmmxnlHtD+GQiWKEP83HvtT9DOy1bIw2fjfys=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RsUSj1ph2scSMK/1Onl4LOyMxO4Rr2dXVBn4El8ytqc9Nib+lNY0G0YXi0vyu/eA4scxyk1FWRy0+dFGtdra6w2znLIdR2/lCoLUworsm9nyx0/Sq0FAksXQKD2LMyficODcWDMGiDa58xMXpk7iQcIq6PLOjXAXy516mQqCm/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YMGTiOjc; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YMGTiOjc"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-485933b24c3so270434f8f.0
        for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 14:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790111700; x=1790716500; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=flTePN2NkB0ZSxOdRerLk62XoVAGJA6/fEuIjEkWcNw=;
        b=YMGTiOjcct/we335Q+eOhlsVlmPv828ezilxLXox4g2vVGhwZed1qMJaSTIgyPmWRm
         Hnru/qhYl7xxirDkVmRBCS9COy8r4nZVe0/QyvQ8oq/Tba4slwHUEqFmqgozKLZzsmdG
         DuZLXem5cglEzU6bhB9eu2UN6UBMb/nizdateQVDV/Z4uk/r4R9FIFYQ4qSXpdP8CZHQ
         l09RhrSDAH/eluzqve+Zh40HBAFOVif0crvOWA0a0tEg5ofiTbtzo4P0wUUtlxPUvJKf
         gZLr2CaPs+HjGO5pwoyNXZQK7IvRWUGKZF2nsk+1IUsP1b6a4o/9NfT5JnzGa+Mkv1Kg
         +yPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790111700; x=1790716500;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=flTePN2NkB0ZSxOdRerLk62XoVAGJA6/fEuIjEkWcNw=;
        b=ERanli3BQCdwi+VEOHk1vS9Wiyku9jE+doeZr9JpYeTEaAVcdHpnAIev+xu8AjVx23
         WZVZgKf84D+hPDnVGxn/rU8YtzbTcDoBsS9GIiyK/yAEbNbpfGpAGZB+mFTGGDhLMYWf
         oaQtsN6lnG2glKJiqCvT/kd41GRdFou3w1tdf83pbVzLw0ldwj75PLuHQeXDjugWd0Ej
         DsYS+0cHqCqsqha+EZJvudvUEkrpcUxkL6eCMS7nykxZ4UPcl+Z08Hw3HIbswXYOouWb
         7sXCPOL18MjyIIaOVOGF4s8lI4W2uy1d3fnme013DId7RZJJQ66nT6C/9UsuG/gtFVxU
         KxEw==
X-Forwarded-Encrypted: i=1; AKwUvBwowN7Pod4HzJAQ3ijEUBKKibyUe1AmNZ109gle3wL2WQ0iS0FFCuw7LSQlQz2cbM2+NZ+5HaE=@vger.kernel.org
X-Gm-Message-State: AFuF++kCycX1umtJtBf3Znd2/jvZ088DIfpaj3DG4T8aQ8g00hDfdOcD
	b4B0CTLDffT43PxUHDQ2H+Wvw12BZXCpRmc5LEvjTyvxU+DjE1qcMmZb
X-Gm-Gg: AYBFou29i4ezk9wAq/xH/KYzbpqNaBhmMyje4oN6oOXpe9qsfRUqhKJtNdl9HzZdIk4
	tj6c1WiJQEFYknm5sEflrjo3tNgY+8ffxuAx/P3bYYzjdgCaqfh7H9QjZJZFOtQ7EnfsXsUuA8i
	snit6mFl4X/YJlr6s3R0jakJXL5/AleP06UdjjkKWt2pm561e6K5daYJMXZYYC6EifMRRtNi/cr
	CgJNz0RGrOkTfe873UECWiPjVZ+wQorUscbxBROirl5ebEoce1Zluv0EZ1/VhT82goCneTpgWtf
	Aoy5butB4XvlDyifpOo5N4pgb7ojKSOfgFJPWy2KN6y+7eqQxxTppaD7wHJzenXI4cknNXw7RGU
	tSek09zcmVnY4dpHcS1vy6Ji1yYykldBkEOEqDm72ipiTlWIwF87Tpvtw/RU1zo59ctg8mz+Yiu
	HoXTh1MlekSsK4vLFnFwZKx0GLcTIMGa9unwgvFd0hCCDG7QMsl2GSI3cG22h0xM2ZvJT8zo92r
	WWf1h9HhqhWR9dxk4M5YNJgqTkEKQ==
X-Received: by 2002:a5d:5846:0:b0:485:af9d:cd1f with SMTP id ffacd0b85a97d-488670b509fmr990235f8f.51.1790111699834;
        Tue, 22 Sep 2026 14:14:59 -0700 (PDT)
Received: from christian-ThinkPad-T470.. ([2a03:4460:170d:5700:7168:5af1:a975:cf85])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-488682673bdsm1221672f8f.2.2026.09.22.14.14.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 14:14:59 -0700 (PDT)
From: Christian Melendez <chrismelnu@gmail.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>,
	Jonas Gorski <jonas.gorski@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	netdev@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Christian Melendez <chrismelnu@gmail.com>
Subject: [PATCH 2/2] MAINTAINERS: add missing entry for b53.rst
Date: Tue, 22 Sep 2026 23:14:39 +0200
Message-Id: <20260922211439.369917-2-chrismelnu@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260922211439.369917-1-chrismelnu@gmail.com>
References: <CAOiHx==_ixY-VNWX=XxqCFoJvE-80i+r2y6SNnxwQe9uZQJL6w@mail.gmail.com>
 <20260922211439.369917-1-chrismelnu@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Documentation/networking/dsa/b53.rst is not covered by the BROADCOM
B53/SF2 ETHERNET SWITCH DRIVER entry.

Signed-off-by: Christian Melendez <chrismelnu@gmail.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index cc3cae2e378b..a1bf40c70a5f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5143,6 +5143,7 @@ L:	netdev@vger.kernel.org
 L:	openwrt-devel@lists.openwrt.org (subscribers-only)
 S:	Supported
 F:	Documentation/devicetree/bindings/net/dsa/brcm,b53.yaml
+F:	Documentation/networking/dsa/b53.rst
 F:	drivers/net/dsa/b53/*
 F:	drivers/net/dsa/bcm_sf2*
 F:	include/linux/dsa/brcm.h
-- 
2.34.1

