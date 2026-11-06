Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793950728;
	b=XVNmUsRtLdQGLi1vFzOLZz6FksJHk5vW33bo8umgq9Uxbm9dFDfMOPrsm/f5Yug0ga07
	 McO8ESp1VlQQkOloL9ZJpySULUKaiAHGZD5zEV00q+Oa55xkqlXg75N97QaGB4B8Za54U
	 oZzKAkmREoe+w/9jiJ1eMIF33JEwFRT4/9qQt/AfldjnwYHiIcxMNriTxVMCLyrLZ1zcY
	 EcOQ7nw2qUT0WLbLcaXi/bxkjZAk8P+EvLSf1F4L19ivOCMqbSz7xV0lbXVvDQEalr55F
	 pHGLE8LABXeFRxv99IjiNh00nFRenGgZffp9kHk3nZ+BV2bKyN8XUj2zjgha04SYUxQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793950728;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=TcYkro3OCO9AzDAkILfFADp57R1OwJJFMCiJFJWlr6Y=;
	b=ToDHcjbgWAfMN1OI6FHEOqbCx3aGuiPmkx2kjgPSSbCcdK+H//7qEML+uThx1IGhRpKh
	 ZkH10uwCmKxAFlg52KSKfUIoGKqUxD42YdkYQ6sXONM0Ij/rJcNo0NvdWy9jQqMfFdNYu
	 mydYrpq7XbHNMQY+CQE2tB85Kb85cirEzrN2S1/9nDA10WTco8MonHsumZZMBkLTe7/Vr
	 dak6v491djSykwV4lXhbGBmNYsVhT6162H0UdmND9CIJLjwlzuh6YhpQgwJOxd/9G96lc
	 snOtLtf8/yCSeYMwK8B5o8mIZ0tAOADwfVLrAE95S59F/nsusefRbE54oXHZq4n/6Kg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=URrZJ691;
	arc=none smtp.remote-ip=209.85.210.177
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43343606A328
	for <netdev@vger.kernel.org>; Fri,  6 Nov 2026 07:38:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 43343606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=URrZJ691
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-8a058f74a54so126590b3a.1
        for <netdev@vger.kernel.org>; Thu, 05 Nov 2026 23:38:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793950727; x=1794555527; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=TcYkro3OCO9AzDAkILfFADp57R1OwJJFMCiJFJWlr6Y=;
        b=URrZJ691JmVcD72j0SGaNZStzdayZrIFIHow+ExwIvgRqcMpD1eLXE61lIGxoePydc
         HlNv1Hzt+mAEzDSroZ8vm6qYAvNkJxZjgp5tfqM9RTqZjRys5XlKAkMCJjGjcFl7K3FA
         OohaON1wc4rbUXqiazpy+/FyX/nDwSL3i5rOe6KFASbecfQUPp5TNRK3peQVIrIJz21M
         ppF+oCnScVfQSpY0ixdIV1aJE4LFqoF/ZpRKtvmqYOzgp/orbr3QHuBGkjEB4/LeHrRF
         qtFsqqV4ZDvphOtRJs3IzJWIm+roa9Ph6KdeYIpx1cDMms2rXYpVep3Ph6nWxW9U/NJg
         2IFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793950727; x=1794555527;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TcYkro3OCO9AzDAkILfFADp57R1OwJJFMCiJFJWlr6Y=;
        b=Qsce3UcYm8FYP9U7AfvfqibB++E9jFTt7Oo8UUZMmajxTwc2T6aU/Z5pWu23WMiOgX
         63iLK04Rz9uPr8bLXNKe3Zm53udI9AluaBcVYA3e/SJvmjkuf15LMzidnSHy6rf71kgV
         bSF2EBemUUzUxiVfFj+Oe0fM6YtY7S9dggxG7R18pQHuiBrve08G1hrCUvlSgGewpi+n
         doxQTKm5PEXnUxkFvmTTlN/BwPOkZxAeUmu2G8gqBzdohqacxgk79/a8WreYWLwyKgeN
         z7H9OYbwG/WCM2BTdl2j8fLN5w/VFHOVTwU0YYlCVZkhEp6BK1U3I4fFiLILIj0zIHlY
         xoXQ==
X-Gm-Message-State: APuU4Z+h01dcLsbpYeKmVSDMOUtPAN6a6NevQ/KKYAqRQlH1mdK4XWbt
	gkxpOMEClY2CvEk0QdwZopdT9phKSud9dYs/YpGWMLMeuOJ6A0aK6tSwvEqyacuv
X-Gm-Gg: AYBFou3qqxip9HS4fDop3hQ25d2lTl3chR6QDtNbpfLoGy7kDLVraizumV4T6FbscxO
	v0STpzTPp1/u9OK6ZyMMP2hAwIdszD6Z8IpvW4VLP2S6+SQg+kLFVwIv1rvpvmcwM3TAq6VCBwz
	w5BuyTOLxuC+kkWMZ+y2AirKgGRoPB/tzykM5XHBnhLRk4AiAsaeGcYAcOrtB9oKCrQiSxHVQam
	abGHRQJXHoFOBD1MWnyno+06G4gkbLJNBdM2MNSwcXF6Nngel+4OwWz324/MjPc1jMlnWG4+otm
	rcvtYp2FkPbPGKX33foigAJwNb6q00nAqN4tczleLk91iLfUM4RsRGuhVFlp7cF5GrGOiQCbEGW
	Sxa4kFu8MCVq8Mje/7N3Pk2sMstg81dGM2lEGpudiItDJHbJ3qVgxvU1UPvxXSWBoyWX3cTWoaM
	I51iIOh3gXiK/a5U5LH0lR1QM76hoTaTDAWMaeMUB7H4h9GbuPtoz51fP07dZ2WwZ0d1i8jut+g
	VDdMLiv4M3ues6jdvT6d8sVdNORYnbY6P+6Ot4/QuFSLvG9I5HDY50OqKOzezd78XqGRQkDOTzz
	Ow/pCsmChAKIVcYWHUltow37Q+qMJo9FzjDlLdPyX20ynlQGLdDW
X-Received: by 2002:a05:6a00:2345:b0:88b:76e3:cd8a with SMTP id d2e1a72fcca58-8b37bc5fad2mr1635751b3a.38.1793950727410;
        Thu, 05 Nov 2026 23:38:47 -0800 (PST)
Received: from d.home.yangfl.dn42 ([2a09:bac1:7680:28::4:396])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8b3597efd53sm373484b3a.23.2026.11.05.23.38.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 23:38:47 -0800 (PST)
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
Subject: [PATCH net v3 0/3] net: dsa: motorcomm: ACL fixup
Date: Fri,  6 Nov 2026 15:37:59 +0800
Message-ID: <20261106073806.112122-1-mmyangfl@gmail.com>
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

Various ACL defects. Found by LLM and manually verified (on YT9215).

v3:
 - also unset `reason` initializer
 - fix action resolver again
v2: https://lore.kernel.org/r/20261103095514.338700-1-mmyangfl@gmail.com
 - withdraw patch 2 as it needs another test run on the device
 - fix patch 3 to align with software behavior
v1: https://lore.kernel.org/r/20261102071119.3435180-1-mmyangfl@gmail.com

David Yang (3):
  net: dsa: motorcomm: Fix extack message on unsupported TC actions
  net: dsa: motorcomm: Resolve the flower action list to one ACL verdict
  net: dsa: motorcomm: Delete the ACL rule of the port being unbound

 drivers/net/dsa/motorcomm/tc.c | 90 ++++++++++++++++++----------------
 1 file changed, 49 insertions(+), 41 deletions(-)

-- 
2.53.0

