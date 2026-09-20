Received: from mail-pz2-f42.google.com (mail-pz2-f42.google.com [74.125.228.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEB154582C3
	for <netdev@vger.kernel.org>; Sun, 20 Sep 2026 17:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789925821; cv=none; b=OrOU8HcbtrQ0eU97ugU38G+MOi3NxFzgsD8Y6hF0FHyTH+6pgtdigtemgtFuPAaV0Ore/KzTs8DFYyskkkhusYyegztnWBmN3SXXXMubyW2FMFcIQh3CmVD6YFB00oEu4OgJfMbAMnBaP0dLUgiV/dRItZixxSL3Mkzeo7fe+Hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789925821; c=relaxed/simple;
	bh=a92njiB4lcuzGQPlkWbV0K9dAOsnl2+LFiifcTvyfrI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lUNafoJkRkVj/BfC93/AKhGSxz4LPJ263qgc6i4HRBTqxMEZlWhmzPGhKWG+4ja/ZT3wwqhgNEoTSjugsh+nxuDx5hWKpIA5W2iIklZuuo6oC/VlWFDeugARJkx58GaEbDHyWvrkEvz9uY5RjePUfypj9fSPnMZp6/wUu5sohG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=QCHUwSX7; arc=none smtp.client-ip=74.125.228.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="QCHUwSX7"
Received: by mail-pz2-f42.google.com with SMTP id 41be03b00d2f7-cc4bdf8abaaso1847354a12.2
        for <netdev@vger.kernel.org>; Sun, 20 Sep 2026 10:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1789925817; x=1790530617; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=E65XKpH6kWapiSh0ghymfVeoD0O5BKczmJvFOG2Qgds=;
        b=QCHUwSX7c3HqL4rs+4afWw/S/XjtCd7RRso7IZWJTpMoRzwXASlg+ViaIjOG/ifZue
         rZ02pQo1zcBzPcE5iQGxAdPKWBJCIHe7Pa96fNRxBLGPfIWc6g+XvBpXDH4WQcogIbdP
         tPZDfFaZNAlr+xStSHz6fldNqOUKwV5iCTVYUWw3IDB5RcZ3SEG3kkOk8oKJyLbm9GJ4
         kAPNii/hGqaGnBYJS1ylpUHfcssRcBs5s1nvVcozQ2Q62CM+TNbzYC2vXevd/V0VCO/X
         qC6HeIZCWb5wX/qT4G/VKOO3kC+DluU4Jf6T94C93PfrYBbl5KDdATOmxOW4/9CqV2zL
         SAXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789925817; x=1790530617;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=E65XKpH6kWapiSh0ghymfVeoD0O5BKczmJvFOG2Qgds=;
        b=xQ/LMu7sH9Q9jWUSdUVH8LUA0EiwrLSN3ph/Re2WDSFrzFOfZBvQ0LpHlXfbs3PFC7
         +5SwgXP8dFuuF4MpBuYJ5SBs49NYY6m+dPv9adh0SD2EfHj4wkvAaSs9YP1TeJBfUBx/
         BDHewJGyQsNys3W6ZnokPPXjn0DdNaMhqYbNIw7AVO/9+oR5px1p8ZLswn1hsnRkBLZt
         Y+n8QkBxEi3fCSzGIdc4tACiEUaxX88ONyS7UkVnv78VEx/mkSW2PjMaJYu8gTue4t0t
         KPpAY+r7IPGoSwcv9KOLuGoRNCRhHC47yXFpEJ3GD+9sowlk8FcKxZKRsUJRqAm9Df3H
         14MA==
X-Gm-Message-State: AFuF++loJEfHlOv+9UmLiCFGjr2k/JTsjPFl5yXrq6q1CS0aaetjCrMq
	fk/HARY8Wh+RjLsbBez1578LtKcrlWGxfr36Q4ePCVWBvLQPqxz9epn5vEH4vVpHNSmRBKQKA9K
	Squ5SdQ==
X-Gm-Gg: AYBFou0X7x4KXsJpBwnMqarqFIHcTArrsACjVLQlEvQaiiaPOBSmUMjBYPqd3Xpl0XB
	JIONA9zsQfcfEO5MVrokrUhiXaLyXOYMLFYc3hrolNw/Vcv8A2M+5aTUXtJ/KvSO9Erfenf5345
	iRpaMYa4U5mdX5uXIeNZ/QggXn6WXGcfC2xkRxmeXLUiFchZ3FN5bsa3hI7d7J/GQrSbqM40pt9
	3Bv4wK10O32l+tNPjwn2j/6fPEdpVOlcPRG9HWXexZfbNx+M3i5qvX9y12pukgfgtSWrK8+GddB
	QZGSN6V1Gn65u/M32Hz9RyGWFItAdSwmjiN7RDXqfEjfRHxCWmT/pVLuPwWCdzrG2S+gncL5zXM
	AIQi+xWjPdwKXV+fBWIRyMtND3cPYL9z1ePx9M1ALrOPWKAsgw+FOX/o8ZcaDYGleJjHgYR9WIt
	C9iCIFWnQFINt4CqPsx5htdHbSArNafVEytZ3mAH8/HBivXv/eMIXtwc3OO4Ki7s+3HwafVo3n4
	MSO6D7GPrAP8QaTj1E=
X-Received: by 2002:a17:90b:4c81:b0:3a0:40bb:eda3 with SMTP id 98e67ed59e1d1-3a040bbf49dmr1852692a91.31.1789925816978;
        Sun, 20 Sep 2026 10:36:56 -0700 (PDT)
Received: from enjou-Legion-Y7000P-2019 ([167.71.204.91])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e6cb3284asm10081850a91.14.2026.09.20.10.36.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2026 10:36:56 -0700 (PDT)
From: Ren Wei <weir@nebusec.ai>
To: netdev@vger.kernel.org,
	idosch@nvidia.com
Cc: dsahern@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	jiri@resnulli.us,
	vega@nebusec.ai,
	milkory@outlook.com,
	weir@nebusec.ai
Subject: [PATCH net v2 1/1] net: arp: terminate device name before lookup
Date: Mon, 21 Sep 2026 01:36:19 +0800
Message-ID: <fabf02a70787d17299e4b3153eadffaf20d154b3.1789910973.git.milkory@outlook.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1789910973.git.milkory@outlook.com>
References: <cover.1789910973.git.milkory@outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zijie Huang <milkory@outlook.com>

The ARP ioctl copies a user-provided struct arpreq into a stack object. Its
arp_dev field may contain IFNAMSIZ bytes without a NUL terminator.

Such input is passed to dev_get_by_name_rcu() or __dev_get_by_name(), where
strcmp() can read past the end of the stack object when a matching
alternative interface name exists.

Terminate the field before the lookup to prevent the out-of-bounds read.

Fixes: 36fbf1e52bd3 ("net: rtnetlink: add linkprop commands to add and delete alternative ifnames")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Assisted-by: LLM
Signed-off-by: Zijie Huang <milkory@outlook.com>
Signed-off-by: Ren Wei <weir@nebusec.ai>
---

changes in v2:
  - Change to terminate the field instead of returning an error, as
    suggested by Ido Schimmel.
  - Changed Fixes to be more accurate, as suggested by Ido Schimmel.
  - v1 Link: https://lore.kernel.org/all/cover.1789648438.git.milkory@outlook.com/

 net/ipv4/arp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/ipv4/arp.c b/net/ipv4/arp.c
index d409f606aec0..60009d92e071 100644
--- a/net/ipv4/arp.c
+++ b/net/ipv4/arp.c
@@ -1278,6 +1278,7 @@ int arp_ioctl(struct net *net, unsigned int cmd, void __user *arg)
 		err = copy_from_user(&r, arg, sizeof(struct arpreq));
 		if (err)
 			return -EFAULT;
+		r.arp_dev[IFNAMSIZ - 1] = '\0';
 		break;
 	default:
 		return -EINVAL;
-- 
2.47.3
