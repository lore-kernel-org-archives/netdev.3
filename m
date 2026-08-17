Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C50444A701
	for <netdev@vger.kernel.org>; Mon, 17 Aug 2026 18:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786991439; cv=none; b=Rr0alD206LRs0oaKYjLIx4TA+Ov/7OhdA40dkRt41vgRJ9XhkkJxuriMjdWSXkWKKoaMHqceS8d+Yoz/tL60yFcoTqn13X0QnFjKsvUjk4tLzZKu7oukGZ1Qwb2Z6LmcMS1eHsI/y1B/TkdNYuRJae69WYooBye/GC7QCxXnJe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786991439; c=relaxed/simple;
	bh=EPjB20Fogyr2TiR3ADIAJKHs0Gck5wkREeCRWZ9GIYo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N2/xozFYLhtuvA7xFCx3Qgo2C+UpIKZxg1+xCaSSLL9kekOdsYn6yMcbwaRFOM5avSseihz8oyAphcdTjUKU6KStwxm0LSJkoWAuSy41ZCGndlGx18C2xfjF5zrsbFh/nZSg4lVwgCXM/eeAw2mztiL53xYUv4WGryjPfKRDxyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dkyq4yvt; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dkyq4yvt"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-cbedd5aece4so162884a12.0
        for <netdev@vger.kernel.org>; Mon, 17 Aug 2026 11:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786991434; x=1787596234; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=P1GNw1oc5mKGendQr+J/CjqB0epsxj+AwwgkHXTcoH4=;
        b=dkyq4yvtexxZPBxdpgLT4kzuZPxsJMCrf+Oq2gwsLAbi2TrtiP0/ZKzZC/SlAAWv6A
         o4CdusK+UdM9HFpIWEwQrA22JQRymnGKPcFsuFcm+s6iC1N5MJalevzbaQD/wHJQARJV
         XSMWoBYdMB2XGoXs2dH8nvzNBtKFSWMlpUzEbTTexphjM+SoFJeD2J6cVK9/JrOEOZLl
         XIgBTU/ur5m7ZNz2Qeinb6QlTxXwGXVV9e7YGVIyPI9TN5spnaf/nnZ0Ve+6Li6Nf+FP
         703BYb8+n41i5PSZ4n5m/jiYyQYYdLA4JI67asihZq3ZhWFkYi3aGL+499jeOv3RW4Qr
         bDYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786991434; x=1787596234;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=P1GNw1oc5mKGendQr+J/CjqB0epsxj+AwwgkHXTcoH4=;
        b=ev2H5T5kNMmz6xMhijGjnLbCu/sANuLB1++5gucllRoXgfikuhiX0rgUwZxKGwu2+P
         QPRcANpBlyrk1QN63Jv1D/fNTMdD/p5ADXQlvJNdjCQ7DuoE85ZVzoQIlWyX/HLBu6I5
         bF00Qwor1dxAC1o98lIyTTUdTCqtWm+pwCkoEWULlSbtdrJ7o1i5umhR1MFklXF2+QrX
         lBvlmbQeLzbPPkwa+Mu3TZoN3q77k+5YurxpPnoU/+CNnVag1f+YB39vLZl7i425BZMU
         LX0GLww8mGWIVRZz1nWWwSPZWmMVZ0ppx92hcn2+RNo+/npDfKF0JCslv9V2rKIjFZJ/
         b6eQ==
X-Forwarded-Encrypted: i=1; AHgh+RrzS27t44v/qninck7X7Lk4knNj7B9QDb3f4HH4OXQGT0w2oCgU1l7lCuESMP0MausJu3a5vkc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxl/Pfk2/NpHBgwtyghF0oTfDKKVEJ0qucsZW7W/WcEupJsTR3N
	tZ1DfVFv1La1YCzvPYQaNxjqq98XBn/2wOD2+KmTIAcfhOrp14SfZ68v
X-Gm-Gg: AR+sD12tsKUgZBSV9E3jBdbVhplWRx81tyTYglyuICjD4vFmzUZNyIPFA4jHuaab90W
	PrM9UFkBMGYrijfpzTEjD+rZenhQCM91JbyOEOMyEsEW/rISOHcDyXFJ4zBu0arVEdrNJPcDqdc
	WYCFaFCuHZSSbIGku5BHr2mx5K3AokIEzQMZd7qyvwT53Q9bcJGfgTEvv/AmwkwF4RC4gg1wvOS
	mAr+5KXL0bATMpO0V7umST+HtEidzhWdEbl7k02VUesai+C99ejgwPyDRjbVdD7nmxVxkHgZynU
	Hc57yatfQoPFu3vp2wyEKclvbTrr7RC44kYSae3C+BJsq/evQCasbm3W3Zdi2+euD5HifXcedPS
	VKtxmlm8zmJL27H2BIepTlzhnVMM1lE80GVJet6EdTipKK0aqLx/0yYpIxlXi3NQ3AHAl7pBt3w
	Fsf/Danw0ZdIP5MRfUlo2lLovMQKGV6AFTzdCWWyid8991Iu8WyCFlmAMRv4RoQLk/ZB6shBr92
	46QZRZ+8nGj0bqM/6Dfng==
X-Received: by 2002:a17:90b:37cb:b0:38f:657:6823 with SMTP id 98e67ed59e1d1-3955f173f67mr595766a91.8.1786991434426;
        Mon, 17 Aug 2026 11:30:34 -0700 (PDT)
Received: from DESKTOP-L9Q523D.localdomain ([39.113.3.223])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3954d2e1a09sm3359096a91.7.2026.08.17.11.30.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 11:30:33 -0700 (PDT)
From: Jongmin Jang <payload.jang@gmail.com>
To: Norbert Szetei <norbert@doyensec.com>
Cc: Jongmin Jang <payload.jang@gmail.com>,
	netdev@vger.kernel.org,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Aaron Conole <aconole@redhat.com>,
	Eelco Chaudron <echaudro@redhat.com>,
	Ilya Maximets <i.maximets@ovn.org>,
	linux-kernel@vger.kernel.org,
	dev@openvswitch.org
Subject: Re: [PATCH net v2 3/3] net: skbuff: don't touch shared zerocopy state in skb_tx_error()
Date: Tue, 18 Aug 2026 03:30:09 +0900
Message-ID: <20260817183009.357-2-payload.jang@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <F34B6E46-6B01-4106-A1DF-1BB9E29320BB@doyensec.com>
References: <AD1B7BEE-C04C-4A1B-982C-8385F1908911@doyensec.com> <F34B6E46-6B01-4106-A1DF-1BB9E29320BB@doyensec.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Norbert,

I independently tested this patch as part of the v2 series using a
separate, non-destructive page-cache canary reproducer.

The test exercised the cloned OVS path while the original skb continued
through the remaining actions:

  clone(userspace(pid=1)),2

Before the fix, the root-owned read-only page-cache canary changed. With
v2 applied, the canary remained unchanged. No kernel warning, oops, or
panic was observed.

Tested-by: Jongmin Jang <payload.jang@gmail.com>

Best regards,
Jongmin Jang
