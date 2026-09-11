Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E00A740E8D6
	for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 10:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789121234; cv=none; b=X+iqTkI4OK4mrn0Sd+vhhXaM7wEOiLe/ELz2RVGH9QNbwTuChLuQK3/p7tUm7ci+8IDVfOR/whlbesCdqLyLQRidWBIugzWBHLswrGhW2TTZGsM5SU+U8C8jT9mJMge0eFNlIhUE8AaKKtzUbRXSJP1kU3uVKbBRUv00XeshKJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789121234; c=relaxed/simple;
	bh=9Du5D+9bTvjoHkuLEaSKOMC8T6i+9gzrDjZZ2+4P0L4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MScthJNyg38G8Vq2b4DnYvzeVhSr+ovxEKlRBJIzBEZ9FbwMpBCD190aZC/7pik9i34k1gCBvJjpxifaRK0owBe/ojdqNXmv9NaDioqxDY2T4bb4NtlzRF3XtwV8HUZWjXRqsUqkhbWaSjxUY1Y83FcHv55xLVmrncYw6UTWn2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=Uzpq3nC4; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="Uzpq3nC4"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-485888b3c3dso652990f8f.2
        for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 03:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1789121229; x=1789726029; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=uMDFH7uEtER5Syx5bBRkse+NVD7Crdwd3os5D/thx0U=;
        b=Uzpq3nC4zK2vOKtBP84/YOgd2blUNjk9/ipTF0w5HJkqLY70xk1Qo+IYVZChj+U04p
         z76B5V4Ra2q/Alle89xhf4eCL+jXinZe4pFPW2IGNI70AwtheEV4QCnx+Rqt9IS/5R0x
         1lQaRcF97xxt7HJXHsfOKuiCUELb4Gdp6vr1o8GzxAq2ezwI0JWRmkPyptdlbZNmSmhq
         e3HhfFsHZ5KoEK7Oy7FOFrDkXyFCSXC1w+FHwIWK0KIFiApb1kYNhJVCC8UY3LR4YJIg
         yjANL14lo5XThfL5BkXTwybfmR2cfGTDHK+hgwkjgLypHf06WGW7GD22Gk89bwoSGuzg
         UapQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789121229; x=1789726029;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uMDFH7uEtER5Syx5bBRkse+NVD7Crdwd3os5D/thx0U=;
        b=UL6q2ShZCSfDyIw9CUsmACpjgam6kipKpI1k7WrCBV87FdmugsERoINN3cQFEjWzNo
         9TiX0cyKG0uYtTYaHT25mop9otnQV5WPwOUG1q4ZbqJiqifbXgTR5mjA8f1DG+Ix0+Oi
         AzZjFnFllYKKDY56QJyJworvNCl9wdxprjgw/zhUp0GY+415RzXOj3zpJZuSmubo/QWT
         hbLRLHgazPyqbjOwYMD84LcpoTQtFf1BkL1RZJx5d476Wct9pPJIeQj2acHVYzCdJtT3
         VOk9fwLeoecclck5kpxSx4zqWCEOeu8bYMDlgUMApXo65vxWkwloqdWyw8drfhe8aTVb
         64ZQ==
X-Gm-Message-State: AFuF++nHc8ok7w2BMACNHQohlJksysCzua7QK23DdM1TZR76o9AaIrwv
	p/NJmFvkOkLBtYEJ1L/mNB62+SBH+03OikUf/5f4ClVvesiUMsnmkt17F1JPaGdJ4HOGhLtpMyj
	i0LOPl9s=
X-Gm-Gg: AYBFou1Od3k+gIndFEIwmXxEUkD5iHZzVaVRnV4pKhm1miK+7tGJXf7PfygpXz6QIse
	Kh+4OnEtXFukNxQpY+DMpOoV+FuaKz4PyRAjt9rmOKJSeU2O0YmI/ZJLEQKqn9KnAFlIxrxkDiH
	nOOWD/7lHTuET0u4CFTZhP2Ro1b2YSE+58Fbz4ZUzypMaC8kBJaSjZXiPSyC4dRmVP5wVzb8XTy
	Z5LAzqtfR1XjIhrk9Xa8JRAQ/7BSQDMR6fzPLPgae0fiGmXvXw1lXZbx2foilOqpfvJbqTNaRQU
	JChJQcY9YuBsDKe6iuqawhywCNP/NGc46kWPa0LlDrA+RUixBzBbL7AmYDkeVbN1AHjTafoc7WE
	wxN1Kh5KSX4S/D5havPfo0j1msrfLwzIkNJi1hah1VAQsfq6F6Uhd4pwwpobY5OzNpMpy1gPDmB
	FJkGsVvmH1mV5S55RZP40HlAhcDnQf1qz5T/91bTfJWE/jXcNtMGtcNONCtoAWHuAgjHsstlTJS
	4riiS3HQJRhlqpvlCv7q4u4Vbo5TRAl
X-Received: by 2002:a05:600c:1c29:b0:49d:15f8:2bdb with SMTP id 5b1f17b1804b1-49e619806cemr37745745e9.7.1789121229167;
        Fri, 11 Sep 2026 03:07:09 -0700 (PDT)
Received: from localhost (78-154-14-127.ip.btc-net.bg. [78.154.14.127])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-49e60ac411asm62868685e9.8.2026.09.11.03.07.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 03:07:08 -0700 (PDT)
From: Nikolay Aleksandrov <razor@blackwall.org>
To: netdev@vger.kernel.org
Cc: idosch@nvidia.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	petrm@mellanox.com,
	vladimir.oltean@nxp.com,
	bridge@lists.linux.dev,
	Nikolay Aleksandrov <razor@blackwall.org>
Subject: [PATCH net 0/2] net: bridge: vlan: fix memory leak & null pointer deref
Date: Fri, 11 Sep 2026 13:06:43 +0300
Message-ID: <20260911100645.1360386-1-razor@blackwall.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,
These are two issues I found while reworking the bridge vlan fast-path.
I need to fix them before I can post my larger patch-sets because they
will make these bugs more visible and easy to trigger.

Patch 01 fixes memory leaks on the vlan flush path (teardown). These have
existed since I converted the VLAN code to use rhashtables, but are hard
to hit because they require __vlan_vid_del or switch dev error to hit.
It is ok to abort vlan deletion when removing a single vlan, but we must
free their resources on teardown otherwise they're left dangling.

Patch 02 fixes a NULL pointer deref that is a consequence of patch 01's
bug. If the vlan delete fails when removing a bridge device vlan, the
error printing will try to dereference the port which is NULL.

Thanks,
 Nik

Nikolay Aleksandrov (2):
  net: bridge: vlan: fix leaks on switchdev deletion errors
  net: bridge: vlan: avoid NULL dereference on flush errors

 net/bridge/br_vlan.c | 31 +++++++++++++++++++------------
 1 file changed, 19 insertions(+), 12 deletions(-)

-- 
2.47.3

