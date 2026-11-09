Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794242033;
	b=paws0u6xnEBjL1YrwLXKVNM7nbZnRes+WhO7I32NGUwveh8XkHiycmfP6RlbxtmgCHdI
	 W7GefRi6jpJ3J5ptJ/L1uMrSJNB99MW82meVgjvIWN6044ojeEfmwnWDp2Ay5GH7F4e3d
	 F9QUPq/oQoVt5BBejMRrKkIvds57Mh+kBe/H1UCCQE3iOO99JguL78nA0nllRwDvPd8eh
	 IlBjRevwO+0t9cWlo1+RfstW/Q6URJwOWUdX6kH+2r5AFqEvjDLc+iSuM2f2v/d+s8jFl
	 zQhuSOIdKwuesfusdmNJ9Wy1tbFKD1aYQqsynHRBSGT2orV29ckHWHtQkTjglakmJUw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794242033;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=5vz/9NIDjZrTZp4ZnQOvvrH+Frtsh6YWPF42Rz322DE=;
	b=3mw6qS3kXM/jQ6IUtdb8oKZDwi66BR2osemdh7fz9tqDzOcG2SNb/2nDNRq+sVR7/2n4
	 JLfcZ+DQYp2gQD4uHF6e33GhaOBtc68ACQ7IHJFd4Rz6YH84aWvXXGVfjjmr7RNlC8m2g
	 1hPR4LKYcxhr97ktjp/bmtOtaEoMRhevLQtTWhcBDX/eRYeSpfP/IWF5l6QJps90z9gkV
	 xvJG7qgWYB1lgJeOKN6T08GeMZHASSk8qHexSPezgysJzd0eHn2aNBsMlJUbgzC0d27PH
	 3rdsaQ7RJt6h3HZJmLLB+Kp/rKtdtRbuvx3+ZjRS3seXz+IahHXN251RjJ6qNAJ2lTg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="fVGN9q4/";
	arc=none smtp.remote-ip=209.85.216.54
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 857AD606A31C
	for <netdev@vger.kernel.org>; Mon,  9 Nov 2026 16:33:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 857AD606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fVGN9q4/
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3b12cb3c37bso520373a91.2
        for <netdev@vger.kernel.org>; Mon, 09 Nov 2026 08:33:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794242033; x=1794846833; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=5vz/9NIDjZrTZp4ZnQOvvrH+Frtsh6YWPF42Rz322DE=;
        b=fVGN9q4/czxm+amrWEBMg3deLYC0uergvAH2v8EEaHCvCwGcNPPLfjuePj2qt+4zuo
         PnYlSY3jKh6kAKwFopoLQdJjRxG2I4mZfVVqEe5EDCLo/uY6RzaGlnif2nq0rJcOZ5Kt
         0GKeNbECBVEFYgNxiy25dSS8Unuve3gyjaEAx/2ujPeUqNOO9UvP117plq+yOONd4roR
         RWVZb4sIeaXXApkhsBKkPe/t5C7RLcsEkA92sMuZA+fEIhczI+vLIqEEQd1uIsdl3Dph
         K4xqep/5FGnAAPc4PkIN6MxJR+l1z1ldBDvw7Nkr7ZPjms9DivoWMiufang2+NUG1t0U
         Wcmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794242033; x=1794846833;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5vz/9NIDjZrTZp4ZnQOvvrH+Frtsh6YWPF42Rz322DE=;
        b=YqjDJi3r2XWMhGuIR/SqxwjmlrAypasy0VJIL+GyvsnFWKWbT62bX/Zb0JpmlL5r7/
         X1TsoLtxruZDV+qz05WoC5LF6LzBjOFlXCrzv3B00cO2dHEtvdO4ebObeNMG6yseXUEr
         GuuOL7/DhbrognjlF6YJJsqxcqQ+fIFeIbNyvzNgx2LeD0vTT+NBxdQFkbBLhp65txmR
         5FMC6B+P+rN285ePsI7EeZJbd5aHsl1DWvhVnHgmFxYxsN2lyHEgFWH+4LpQ3oOw/0MZ
         mpEHZb/BXXqENm0/fmxLaCJCV8hvDzg9ZqZ+ZJhSjJJ7pYe3H3E8HaNgNEpu6rHDjFwr
         AsQA==
X-Gm-Message-State: APuU4Z+tNBpL7dXp4sVXX3aoltJ6WeIdPcKMN/6uLwhYPSmWLih/l33k
	JjvhgVEuOv+5UxSs2JIjPgoVK9HW/SLZcURZ0OmxiQg68kKeZyDkQZu3C3rlaYB4
X-Gm-Gg: AYBFou2rhv+1MPqRokT9ybGX/wDbuGVB0LaIKAR+SUBzbYj7AmvL04aLYHziAb+wiQD
	wKXSU1a6UGezYcqZDJwq0+h7mU3Z0FNr2frZ/UpvlVfJIwyofYIm9TbO4Jtg0Dg4RF/EKGoIWbH
	GWGvHnA4g6KgsjBPmeDvcp+bbeV//Agd6TcSoD3A9o81TtikHybn/5Dd3gUAN0uXS9Yw6y8TksL
	x0SIIk9rC4cBnhkQeUfppaWOf+U/Fh9RuezJdW3sgiK5QbM0KXef5tCtPZV3mp/OmOobS4C97iS
	bUrc7BnfwRN4QVZNyfgGa51bnCAV33cIP53gmGt/mD2IdR7fHMrJj92/p8fEUQhfUik+0tbNRqS
	8ezYdmY00SOxPBux4psNRWlJc9RbZuWjxR/6fy31AvZSvk+f5CidjZ9zzB/6Czc3TZ67dscFUGR
	oq9OFWxwGR9qqFK7b/qTF885voxyS1veqLADT9L8w2P5L/uDFLtgcxb1YKp40DoU2sQ+FA/rDEh
	ipfQEVY63GHCumLjtlPTTI4OoxJWS51g+oFBaColw17foBYs46eNnOmuz1oZWFWzb/kfhEyO3SZ
	DkVovAptu/Y2an/HfnojK/YK2avt5CXNTpYlsJJ1iw2lFtnLcfYBtw==
X-Received: by 2002:a17:90b:2550:b0:3ac:403d:6239 with SMTP id 98e67ed59e1d1-3b166d1a020mr121258a91.43.1794242032793;
        Mon, 09 Nov 2026 08:33:52 -0800 (PST)
Received: from d.home.yangfl.dn42 ([2a09:bac1:76a0:28::1d2:30])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1679c41aasm13995a91.0.2026.11.09.08.33.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 08:33:52 -0800 (PST)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v3 0/2] net: dsa: motorcomm: Add devlink info and resources
Date: Tue, 10 Nov 2026 00:30:07 +0800
Message-ID: <20261109163117.1792478-1-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.53.0
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

Add basic devlink support: expose the ASIC id through .devlink_info_get,
and register devlink resources for the hardware blocks, reporting ACL,
FDB and meter usage.

v3:
 - remove the buggy sub-resources
v2: https://lore.kernel.org/r/20261108094512.1285796-1-mmyangfl@gmail.com
 - fix issues reported by sashiko
v1: https://lore.kernel.org/r/20261106184811.350700-1-mmyangfl@gmail.com

David Yang (2):
  net: dsa: motorcomm: Report error when FDB fails to add
  net: dsa: motorcomm: Add devlink info and resources

 drivers/net/dsa/motorcomm/Makefile  |   1 +
 drivers/net/dsa/motorcomm/chip.c    |  46 +++++++--
 drivers/net/dsa/motorcomm/chip.h    |   3 +
 drivers/net/dsa/motorcomm/devlink.c | 148 ++++++++++++++++++++++++++++
 drivers/net/dsa/motorcomm/devlink.h |  18 ++++
 5 files changed, 209 insertions(+), 7 deletions(-)
 create mode 100644 drivers/net/dsa/motorcomm/devlink.c
 create mode 100644 drivers/net/dsa/motorcomm/devlink.h

-- 
2.53.0

