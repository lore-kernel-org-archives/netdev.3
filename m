Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793990910;
	b=PTuWJu3GP9nI4P2jdZrVl1wJOXJsTWyQtzvXfDT1HCtGmK7vyGinVMQ6KsgYvJMODDv/
	 SpW/oiKFruk4vgO3IYOcSpMn3rK4riE79LphZYfrgWkxLHqDhFDPkpdhUOGp3p4XW+7pO
	 VYyJxZv5MdanMBWmHsHjSEyZsbmGuOtk4GNj173Mu/nzpaYkz61e88R+tnGpqD2uFZQp2
	 Gvo9c4bKhc1A07FI7IgCi/jvT8Dqm+zxW/MX6IxhXeqtz3b5vS0FFW1WLUSsD5t/CdLN5
	 vXBzjH36fIKB5JnNBI7ahiMrZ5JGdsRHG15w8H0SpFz7ZchVqp/UGNSDEUgxT01lQYg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793990910;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=DVgDWv3VD/ui3HBKkgpjgxEmwBxnrXvFZzEKOZanqwY=;
	b=UVP29LZ1FTN/F7POCrI9ZlpLHCMkggVrlr7NjlFgKP9JsLaCTtG1fzxTCRWRbwcPiqgy
	 fIg/15VmRznPbdsgxdRKFGuGWxEIXm8gmPvsoisk66LI3iGX5UhZ+8Snz6K8tladvp9mk
	 3Mk1/vDSWVsIhEfqZTkpNH/12FtPcDOVyUnrHhA5IzNOKS6K5wPmjmGI3Ue26jzNcbnlR
	 7n+taZBMShVCFT7U8INiD8LsEew3pQ5Rt070UErRlwtT2/LgQ8aHJvAqPw3uIF5ih4op7
	 P3CdYTUzivNDMGPSrpvkFKEqghV5eHLoHjlMCWFruiPy79t1pcTB/DbQa2Mo3QH3Z+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FRc+cgD0;
	arc=none smtp.remote-ip=209.85.215.182
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DB34606A338
	for <netdev@vger.kernel.org>; Fri,  6 Nov 2026 18:48:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9DB34606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FRc+cgD0
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-cdaefe02d5dso586037a12.1
        for <netdev@vger.kernel.org>; Fri, 06 Nov 2026 10:48:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793990909; x=1794595709; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=DVgDWv3VD/ui3HBKkgpjgxEmwBxnrXvFZzEKOZanqwY=;
        b=FRc+cgD0sIAfcmtcLNakdeROnktdrMH3HQMBnntP+qo9DD0PAz0Be1jkr+iEsVxs0J
         L9DAwLOWMkQKNeN4o0Ut6mLDZZwg3KiK6lHh51yBdMKq/Ctw/E+RsisQBLlwJUfzpjEd
         aU/0665XmvbKlhTRU2PUfpDtrGoEPz6MfuGRQ+830BUcnL+trlHt+tC//pCNkwlLvca6
         DxfseBjzDn9pcOh6Oodn3983my35PkNL71JQsbP/dPzZNU4FeG5KikE/2qgOxXBWs8c7
         nIDAKZiiEh6nPA5Pw8BMBqqmRzoOaPLKvdgLlmy/SybaK0JQC6hniYM3HJBiZ7AEeajs
         KNzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793990909; x=1794595709;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DVgDWv3VD/ui3HBKkgpjgxEmwBxnrXvFZzEKOZanqwY=;
        b=1qtZXJd29kOAbFqH4v39lTZuolDSTsM7QENWuW1pzW2b5IMtZ3VOjYzgq74LYYUI/O
         MQoNpJRKr1Ub5c0+XIuSd6u+z1KYMmcKv9xaJfHLztOTPT+8lkRy2atzmE+JSZ0g5iFf
         h5EA5g/nXCadpG/s5Qq/5iSICeFrRxRRaww/b0od4QOTOTi9OdfttBQwRFrRIEQ9rnY9
         3gew0O2pGYLJApoPm9PU1b/yV13uGLyxPtt6EAkswxp5BejqV/wFdkURf7EpL1xZCP19
         m4+lTUR6qx83HAcZ2JQOg8afbStpz08YH61JugGIY7X9jjR15lwlAvxmFqSGi6o3yS3r
         xURg==
X-Gm-Message-State: APuU4Z9fjtU8mp9G90AXT8CLZMvLJWy2msUVijskhO/C1/H+QDlwnoAE
	0j2r53+33W+Y6DzGHUf1HuMePMmei3G1vaLFnKrEjy+7bIjLO7ghHG50SfIvvrPN
X-Gm-Gg: AYBFou2IAybHX0TrIQDWObGOF4LBCmVsC5NRbtzDCc7yTKeTINBCOdpFk3xizonhH6F
	00IbGNtMXCx9G41223G5BqAOknSfy+hB8TUoXWxr4hO5H+xd8tG639NIQAdXx/ePRLKtW2UWfYF
	8GjBmlQVtq1lTS78Ba7Jl7dWqMDCjD+pxBcKGNAiQ6I9IRCKvclKWRpRJKize4GYJXnGpUMdMg1
	7oRsSyL7s9Zj0HtK2DouTPpdoqhr8dylpaivcWzGQIBVY60z1FFWVNlPf1w2z+0et5XHREth6XD
	gqsdy4MoxYmm7ULzRNHLx+yuWqWtkF3ufK/3M5NrYFfbxIWmBVYF/638a8GMfEiP1AxT5+kt3qQ
	uKUxvHYJ5++Yul6H0jwQ7O5j/iVhFy8tNjq39IRXFfJIKb/7t6zuh/QkObXmR+u3oA5N5ojco2m
	weGAaUhFJiIX1587hB+mVUrxQbUvTRlcUq3+5LCNz1XobcyT/l1nQTZbuBw/GKfpn09vkoP9cxj
	W5nZbUthJ93uO1/LGiRWmBCvzJAzT1i1J3/GFOQBrMEDhggIRS6P6IP6dfVjWPPcRY2+MbwgVE2
	is4TQWdhyml+Gh0iD0D34Tliq9hE6drbCx1nBcxsOpVxRUW/Ql8e+TVQn/bZsQPQHgxuKmbfZik
	=
X-Received: by 2002:a17:90b:268a:b0:3ac:a204:aa27 with SMTP id 98e67ed59e1d1-3b0db70e107mr3411850a91.66.1793990908850;
        Fri, 06 Nov 2026 10:48:28 -0800 (PST)
Received: from d.home.yangfl.dn42 ([2a09:bac1:7680:28::4:396])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1054a53e4sm45036a91.0.2026.11.06.10.48.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 10:48:28 -0800 (PST)
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
Subject: [PATCH net-next 0/2] net: dsa: motorcomm: Add devlink info and resources
Date: Sat,  7 Nov 2026 02:48:06 +0800
Message-ID: <20261106184811.350700-1-mmyangfl@gmail.com>
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
FDB (with unicast/mcast/static occupancy) and meter usage.

David Yang (2):
  net: dsa: motorcomm: Report error when FDB fails to add
  net: dsa: motorcomm: Add devlink info and resources

 drivers/net/dsa/motorcomm/Makefile  |   1 +
 drivers/net/dsa/motorcomm/chip.c    |  45 +++++-
 drivers/net/dsa/motorcomm/chip.h    |   3 +
 drivers/net/dsa/motorcomm/devlink.c | 208 ++++++++++++++++++++++++++++
 drivers/net/dsa/motorcomm/devlink.h |  16 +++
 5 files changed, 266 insertions(+), 7 deletions(-)
 create mode 100644 drivers/net/dsa/motorcomm/devlink.c
 create mode 100644 drivers/net/dsa/motorcomm/devlink.h

-- 
2.53.0

