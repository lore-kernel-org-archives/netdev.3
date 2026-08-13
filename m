Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82E2A36728F
	for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 07:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786606830; cv=none; b=XVUUqfGolHGQpjT0pkf3WlvbzujuwM/APXLM8ET6j229/BKRgzPjEKDie0vQ3yufOYpBULC8R72GetHlRJIuNwiipR644rd95ksun+8XniOFYzFExyTDk1jRFyoIJK/aDq4dLK9uRyvVKX8iyEz+UQol9EZWdHU/ZEQb5lZQARg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786606830; c=relaxed/simple;
	bh=lcy9GXzw+fVt6D5c66pluPLv/Njapm/Xrgbk1DH4ZoA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pN7DILY/Yd0WLmXYEOsiaXQ0QbZm2ir1r5oaHvjpjWFmSsMUBmZ91bTAXpUXn3PC8yvJPvXXaoGXPJP/ItGqLDkdDKlkG8u2fRt3jjGb5rvDKrL7RQhZc7Vq3FvPp9FsCrMm0cDv+Bhhn5bcaVGejS0zRkBZiLnVjAkfRSvCYUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=smartx.com; spf=pass smtp.mailfrom=smartx.com; dkim=pass (2048-bit key) header.d=smartx-com.20251104.gappssmtp.com header.i=@smartx-com.20251104.gappssmtp.com header.b=0v7QO0Ls; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=smartx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smartx.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=smartx-com.20251104.gappssmtp.com header.i=@smartx-com.20251104.gappssmtp.com header.b="0v7QO0Ls"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2ceb096e675so5741955ad.0
        for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 00:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smartx-com.20251104.gappssmtp.com; s=20251104; t=1786606828; x=1787211628; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lcy9GXzw+fVt6D5c66pluPLv/Njapm/Xrgbk1DH4ZoA=;
        b=0v7QO0LsRAvVF7rcH62iTbaf0XeiGYC0i1QpWKvIjrNDLxqy7Bc/qUCs86l9X4qd7j
         uHC4OigI/n6aByycszm6biYMDljluxKBYWbFn1qc9S3pk0w+A9q94SqS5x58TO+X4T0h
         px8QG7ibdspuF9KBFJCzdD16EefDqYLWpJ7eqw9UHsou9noGdBcL7MAkK/H1Jyw3zBoc
         3GypvClj7I40PC0HdS/Ftu469b/NXxRgwNpAbpFxLh0HbTPD6MR0LGrPWNA1H9v1spoS
         +vWoI+pVqUhLu9P4VDln6E1n4IH3iQSjw2QSZ6KMWC5e+6GJ3GFxQK/7YATXloyz65eT
         KZ/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786606828; x=1787211628;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=lcy9GXzw+fVt6D5c66pluPLv/Njapm/Xrgbk1DH4ZoA=;
        b=FSWG88KZy3TPCDbHYCMiwKsVtxmCV7vuU9cy+Ps8kRYybRji0cECCW8RN0m+5K06db
         fIZ0X4b4j78xhw2QvJ/O6RxlgDe1zQ+3Zve3x1gmFknXFtLMMz2O4AqdlRscNw3VfqBU
         7rb4+GukBHqcwF7mAy3DOf/z0HaggU4R3TFl9Zvge/Oh82Ob4Ee6eOJetzb4w49fC1pa
         IryMhd18ORwiwReBUr1Q6am1ARsFtGqoDzFdsCr9Y7zT4NuCXoRwvhmwCbTtwsUAuM42
         kAzVXhrLPWtVaGzgcm6opRCqbRFj33hFZdItXZT3bLlVD7AaggKceBcnh+PrxaBTCOLl
         vttA==
X-Forwarded-Encrypted: i=1; AHgh+Rq/z+thScZt2IIMd43yE9qFIYp746swgbNA7WhJNtqqb/YRXf+8W6RRBjycefvPrbIXdshgEgY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz53hPceQuXiFTY41dvQf/OWEI2ioti8RLa3EkLORLOQfwEfP/U
	kgDDD068wG4CId51z2OuzU1iRxMmm3pjSlqt50xXIrcGYOYGRWFofCDMPRqa5LZW5CYgtxpX71Q
	YCDVzozJkciItfHsKK0l/+UGbZ93Y/6zZ2tHYbeqy+avFgWenVtg=
X-Gm-Gg: AR+sD10eqC5VRJD5XocciDh2+IiBuVxDt2peOKCMZPLGs/6m5QwdgVCFh6bK6wBRnHY
	Q7q85rVuu+GgD0XspBvbNqlk+fP9plFW0sjxjUWlNH3mdK6vwdT7ufMeSiXmN9sa4A0Vu2PC29c
	aIaWWxsVepEBzGarDBHFB+fZSyvSQCfiw8COgE9gvthPfeEqnU7ts+K5kaMrJFw3q9Klpa9nUbS
	0F7YwLk0BvsCKtnczDtn3N8vVOjykc8Iz48p6IKfIynwOtIwf2RX9YwSiX9BAXede5Omn3rfDnh
	thb8Y02UYlgkSsvPK8pctFUnWaTovdjxcuey3oVmjyHt9UHxvk/kvsIwXJnHlW78wU1WPuBBIxc
	V28S3cd32ULeLkZrTiU54N40Sdd1YylzlufpW4QIM1IPwb94jK/ErxIDpzVMk2CHdwmsCzYj1VU
	tM+AdxyOztpslgCXB41q2M9/Z3VcJIzYiGZrSBon7fjcBv+Ma6OfGJIDWoeupdI5gv2lfuYse5i
	g==
X-Received: by 2002:a05:6a20:cd96:b0:3c0:b766:74f4 with SMTP id adf61e73a8af0-3cc553f71d1mr5904764637.31.1786606827218;
        Thu, 13 Aug 2026 00:40:27 -0700 (PDT)
Received: from localhost.localdomain ([23.148.204.128])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31ebcb6a9a3sm4648991eec.12.2026.08.13.00.40.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 00:40:26 -0700 (PDT)
From: Wang Zhan <wang.zhan@smartx.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Aaron Conole <aconole@redhat.com>,
	Eelco Chaudron <echaudro@redhat.com>,
	Ilya Maximets <i.maximets@ovn.org>,
	keyong.sun@smartx.com,
	netdev@vger.kernel.org,
	dev@openvswitch.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] openvswitch: enable ops lock for internal ports
Date: Thu, 13 Aug 2026 15:40:07 +0800
Message-ID: <20260813074007.3669651-1-wang.zhan@smartx.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260812164156.6bde8f4e@kernel.org>
References: <20260812123003.3634034-1-wang.zhan@smartx.com> <20260812164156.6bde8f4e@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Why are you sending this patch? Do you have an actual real life need
> for unlocked get_drvinfo??

Yes. The use case is broader than unlocked get_drvinfo.

We are trying to reduce cases where ovs-vswitchd gets blocked waiting for
the global RTNL lock. In production we saw ovs-vswitchd repeatedly report
"Unreasonably long" poll intervals. Tracing showed one OVS operation waiting
about 500 ms for RTNL while node-exporter was collecting the speed of an
mlx5 interface. The node-exporter process was CPU quota throttled, which
stretched that RTNL hold time; mlx5 can make this easier to hit because some
queries go through firmware/mailbox paths.

netdev_linux_set_ol() is one OVS path that can take RTNL. With
userspace-tso-enable, OVS uses this path to read ethtool feature information
through ETHTOOL_GSSET_INFO, ETHTOOL_GSTRINGS and ETHTOOL_GFEATURES. For
ovs-internal-port, these GET operations do not need RTNL, but currently take
it because internal ports do not opt into per-device ops locking.
