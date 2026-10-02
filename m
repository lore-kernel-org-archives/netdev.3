Received: from mail-dy2-f41.google.com (mail-dy2-f41.google.com [74.125.229.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6740D46E007
	for <netdev@vger.kernel.org>; Fri,  2 Oct 2026 13:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790948413; cv=none; b=fkqkWFxWW8MWnMBdH5TmJCdB9Q+2msg9qgiM+ir+kJzpBtgGGxHJM2zmLvEb95svGWKnZD2UzT9OwwEpGBcd1UUSbgV14VV/3DFHldy7ZwiHnPL0jF6ta8bjbHJR0GaE0wJ+O9p55tFG6fBVA7MYkPVBUtu88mPmKHBBDT75ek0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790948413; c=relaxed/simple;
	bh=Zxrx0jSSfnYnESeX6T3cR1BVsOxDyhirOyg0LdtndX8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=koQmJ0MBo/ccohdmf5VrSiacTpnvvL8fELMMZBXpPobsB5bXB0uK9WvKnKaUM8m+zRmHBUuWY2wQ9Z6s/d4XVDGvacXn0yhi0nPXYnYkRmVBlkIxk71J/FMjXZeR9Iei5LuL5/lpT3SjueyuwNyy5OmQQvJwDJ2Rj5rZqec3sCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=exDgv7nK; arc=none smtp.client-ip=74.125.229.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="exDgv7nK"
Received: by mail-dy2-f41.google.com with SMTP id 5a478bee46e88-346c612c7a8so4015293eec.1
        for <netdev@vger.kernel.org>; Fri, 02 Oct 2026 06:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790948409; x=1791553209; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=YiMhDvbsoBufNngs4Gaz/wiJMDRb8Qxn1k3zbEz6U1s=;
        b=exDgv7nKrMgkusrvG6jay4ufDaN6tx61SNFAirRYTlkxRY7QISEvNZ/6RzyoVWFZxW
         EhCByXtZjr0r8rpLEL+BHUqM1Xju6qqjFsJ7PDOGRrVcgUvNbtv4LqX77Bc6aQHfd+6m
         6yTmnhtiMhGigqkgZ2cHK6J9lD28p9T4QAlacz0Y0pYGHmhh8YgtgL4cUUBPNlJp8J8h
         1vqiipHgFlXabRpgMCme8e1vTYzRpcIBfNZ6xvJkuJt5VpgGLdrKKpExTCtn3tA0AIDK
         rKy9zacvC7yRD99x53KY9jvquIFVmz0fqyQJjYtRgdgtDsqIjhviW7wXTefTi8TbSpOL
         PTCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790948409; x=1791553209;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YiMhDvbsoBufNngs4Gaz/wiJMDRb8Qxn1k3zbEz6U1s=;
        b=HLZp2vR9LGseI6kKL5y+I5yx0T2UsOXvZ6pu/rtNW4HAVb69ilSKntrmTKemtccPTL
         XWP0VcE31oa81qcCZMqrW9Y0ZJFzFdu2zc7TfVvYdZPpU1BPSGQEE+ztez0yvB3u5V48
         BenujWQ/XrZWvO5izMmcpoWRf6pQj9ToHrqeFW1uVG7b6dyOTE50zdMIyhgPEPNaNIVA
         VssvTiEWmXTnIvHIhNKaiZ91MEZjKHUr66TKZX7TMe8iX2fPVTReOPWhKpItSpXm3kWV
         WRH8j5kABbW9pWxQ2X1T9QIppdkf3kPqcSVe02xW7uzTqHhyCaQUFAa2wHJ5jocKp7WT
         /Jkw==
X-Forwarded-Encrypted: i=1; AKwUvByZdUTaTlWHISF+/m8w5Y2l3pBk98kvrqgiE4Q6CgsJq1GCG1lzEioFnRsPoE+9+Gn/bkbZZwg=@vger.kernel.org
X-Gm-Message-State: AFq9FYIklmPjcF78Cpx5Geb9B70QrrXO4x047Tiqfvvej8O6b8sQ1ugv
	VSFeAO+kt/3+R5AjoyXDvxsQRXvp8+hUBwJJbEKB/du8Xet3CBSonG5OwgRFKA==
X-Gm-Gg: AYBFou3LnmwGQKaIgRQRJBWduYEpKFTzIHsvbOa2wl8hyVKijfLyysL4syPYI7e/Tji
	euKkpICpw4zQTCVg+eOI1aus2Ir5a52c3dIEBbQrwokgzoHsudJYIjZv9/+jPaS46hB7J5e0sPD
	LsDiP0joUuBNr7eHqcj32traDKO5/1mamOvzvC4d9ydzcSK/6TH+uuZGCRR3pqxnX43FOlUfUz3
	Qe6vM1MhDIpuSYZkwRTI7zfRYuoxjffaNUEL8lviOAjbO3+lAAmLtRdtryEpsPvK//J852f1luG
	8nIZEfF+ufi5tpmrxUELzf3QhfTrjUkjUMK1heGxdEVBbNBKfndx9q4kXCk4xfLn7F0N0ZhEIbp
	mn8FyaJeD7ZWcAb+ZIYv5KDCVK5aI15Kp5QQGezNgRtTXrV5TgAMjSCS0EQVbPOlpRV0LJpAhJ3
	+j0SDu6CmYECiiXjopfp90ZR4l6nvNWGjjHMlzgL23JnmtTicI9b5lWqSeh/bDp5M37svL2VlIH
	fl5ncgXYFmAtIxTO6n1UCBorvldlEmmnGwT2DqcLTCFTvbar3qBMx09kKxbsQaritfk59SEJbK5
	TEGPHzviN9gTUtZkpgVNrf01cOULmc1clGJzZAU2mgQ=
X-Received: by 2002:a05:693c:4154:20b0:351:853:54a4 with SMTP id 5a478bee46e88-35108535aa9mr1233654eec.33.1790948408810;
        Fri, 02 Oct 2026 06:40:08 -0700 (PDT)
Received: from ramen-dev-security-2.asia-south1-c.c.ramen-dev-345017.internal (90.156.200.35.bc.googleusercontent.com. [35.200.156.90])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34f0672c2d1sm9177866eec.4.2026.10.02.06.40.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 06:40:08 -0700 (PDT)
From: Anil Kaushik <anilkaushikwireless@gmail.com>
To: Pablo Neira Ayuso <pablo@netfilter.org>,
	Harald Welte <laforge@gnumonks.org>
Cc: Donald Hunter <donald.hunter@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	osmocom-net-gprs@lists.osmocom.org,
	Anil Kaushik <anilkaushikwireless@gmail.com>
Subject: [RFC] gtp: add 5G PDU Session Container (QFI) support?
Date: Fri,  2 Oct 2026 13:40:02 +0000
Message-Id: <20261002134002.3529706-1-anilkaushikwireless@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Pablo, Harald,

The in-tree GTP driver supports GTPv0 and GTPv1-U, but has no handling
for the 5G N3 PDU Session Container (PSC) extension header (type 0x85,
3GPP TS 29.281 / TS 38.415) that carries the QoS Flow Identifier (QFI).
drivers/net/gtp.c also still has the "TODO: Support for extension
header, sequence number and N-PDU" on the xmit path.

I'd like to add PSC/QFI support, but before writing the datapath code I
wanted to check two things with you.

1) Is this something you'd welcome in mainline gtp.c?  I'm aware a lot of
   5G user-plane work lives in out-of-tree datapaths (gtp5g, the eBPF
   eUPF), so I don't want to add datapath complexity you'd rather not
   carry here.

2) If yes: on RX, once the QFI has been parsed out of the PSC, what would
   you like the driver to do with it?  The options I see are:
     - stash it in skb->mark, so tc/nftables can classify uplink traffic
       by QoS flow;
     - attach it as skb metadata (tc_skb_ext / metadata_dst); or
     - just validate it and otherwise ignore it.
   The shape of the RX patch depends on this, so I'd rather ask than
   guess.

The plan would be a small incremental series:
  1. add a GTPA_QFI (u8) netlink attribute + ynl spec, stored per PDP
     context (control-plane plumbing only);
  2. RX: parse the PSC extension header and extract the QFI;
  3. TX: build the PSC from the per-PDP QFI on the downlink path (the
     existing extension-header TODO).

Patch 1 is already written and builds; I'll post the series once I know
whether you want it in mainline and how you'd prefer the RX QFI to be
surfaced.  Happy to adjust the approach.

Thanks,
Anil
