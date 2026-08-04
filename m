Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAEB336E468
	for <netdev@vger.kernel.org>; Tue,  4 Aug 2026 05:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785822415; cv=none; b=FKUOoB9oaw5iPzyq/Zj0KRqDmLg6FG3KWWRojtEyNdJbqFdxlwyDj+oCGz6N05yZo+il7jN6eXowuoqVcaht6RU1HKPAO5aqOy5GRS1SXocG09Bo2ZgasPP84y5atIBDPD210bLlhaVwH41VtwU8bDpjc8VASaqqLM7CK3LsszE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785822415; c=relaxed/simple;
	bh=Edg+9r5X6Hx937Ug59wtr9oIszVOyJNcrBmngu/d/Wo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lvi1HK0F8AphiF3g8o+z2CTLvBSM+lpKwNUU8Y9LFfTvCgRRIg/yesouxgPrADoTb5TIuL1dJIA6pB/gf+QELXTRa5JlzwPIMAg54wnv7PqUiXNTnieiAuE19H1TfwPVQRlboFIjCYQ2HcuZBpmQaTXkp6voWLd7qqWktsL47ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qt1Dcl15; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qt1Dcl15"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2d004f135b1so42367565ad.3
        for <netdev@vger.kernel.org>; Mon, 03 Aug 2026 22:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785822413; x=1786427213; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Edg+9r5X6Hx937Ug59wtr9oIszVOyJNcrBmngu/d/Wo=;
        b=qt1Dcl15Y6rTRJAmEoWT6rSKhsSA92hYmTT8zGBe9xiukuckWGhCW5U6iDpiUBKhfq
         jIHTWtPza4U6KJMm3eS8SfU3gyRvz/Yz14qansjAuZP4SS2QPYt72bJY0UbPHFhcURCA
         m53Qdv3N2yl1adlrJBxqXwAIXe6yUgt1th/Mdb/d99pXVnqlXUD/TKhtf2rMXySJ0R8k
         yt0RSOyePf2SMKVPOdyd+KjM1iGtis27IXdSNLkafLJyrtaNS8zS5FrKUJxUhOpOI+Qj
         9uUF+WZYfdH/+oeUvwfzgmRMCWzMvVrDlzV6AziUGXABUUdOUDrMmTj0lrKnoD2cCAOC
         TBtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785822413; x=1786427213;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Edg+9r5X6Hx937Ug59wtr9oIszVOyJNcrBmngu/d/Wo=;
        b=WW50HhS2YXMhtbayphEZtZEUKwxmGx61GImKVZiSANq3jLYnRWQw6vUWUCASAXKbRh
         PNJTHOIyLobbDE2KZ30wFm7KjDjSxdAHZF260lNzQ1Vv2QMHlUXKUKQlj1zjx17d0bPD
         jzJEDW/5lkuivleZInukmMznhiFZC2e7JjNmARojlnLkhTN16fKuPp/9n0Z9mv2t/f+F
         f1RcC+OjvHBeN7D0AqGu50imZ1hC9eXiwXIV8GDWfX283tVEz/oEbU/p6UAHzi0j9nRw
         41ZGOqLwSJVhTfpli9IYT0qO64YD8thxcukjmoSFaCPT8TUYw+5dFGSi8IzNeYgflyqb
         zqgw==
X-Forwarded-Encrypted: i=1; AHgh+RpuAGy2ZivgAcaiVMxyTRjHK3PMGLeJKKrpUlAzGrrrlu4kSbWlcxWCE0AgnyzrbIN6RYbh9zY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqHAVqIJRnruwmchx/poRfjm1mQx5tADgGfo3ymFKBZIcrCPbL
	yFMTZxMdYZlmq5VQqtgZsMkYEaxYJMHpggpk9vMawDou+11zQX3pmtP7
X-Gm-Gg: AR+sD11K2IztAuUNHKKKM5qfyvRXs2sjl0UpR9Irq17cuCbhZuLuH3p47bNmeyuWiWL
	hjYf5HTYLYOM6tnrh2qAquFAIclmbBnOR4nmybIrJb6hdpRq44qBKwyauasrPUKg17OKaISRgls
	cqgrD45oS6SzdhoR063gJRoNjWNx/7Q3HAr3Rf89osMGQL36p+2yJo4GNOp04j2owGw7dPN4R2K
	6RWuDX3aEBr7vYBgwI8+9OhlVVraS7zzcFVorYBUTbauiCcqRa22f5aHafXRrcTLiy+Qa2qqwWI
	oWr7F2fLhF32U+szsK/jrXPHUksSE61gCVFsNJkAWFcHlzx9g0S+QoeN+rD+UiS4y7U8GCV4h2o
	kI01WD2ZgQ+uFW5JQWHmSbHhaBNmwchyVwEUPhX0T86TAwkBxtuZW8FVVSntVWB9n8MSjiN5R2O
	pW1OogOOl3XbghiicyxZoh02hUoHp+RQIlnORjPVTMmoWh8oc2PhW6TscR4zzzBqs=
X-Received: by 2002:a17:903:2283:b0:2cf:dc6f:cc42 with SMTP id d9443c01a7336-2d0524b39a0mr116935565ad.46.1785822413062;
        Mon, 03 Aug 2026 22:46:53 -0700 (PDT)
Received: from [127.0.1.1] ([188.253.12.32])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3153e06f0f9sm45779556eec.23.2026.08.03.22.46.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 22:46:52 -0700 (PDT)
From: Jia Jia <physicalmtea@gmail.com>
To: michael.christie@oracle.com,
	mst@redhat.com,
	jasowangio@gmail.com
Cc: pbonzini@redhat.com,
	stefanha@redhat.com,
	eperezma@redhat.com,
	virtualization@lists.linux.dev,
	kvm@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH] vhost-scsi: flush backend after device ioctls
Date: Tue,  4 Aug 2026 13:46:37 +0800
Message-Id: <20260804054637.6238-1-physicalmtea@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <45a33302-0b28-4d00-8724-c3af6e1783f6@oracle.com>
References: <20260721073639.1532488-1-physicalmtea@gmail.com>
 <3d2dfa19-42f8-4d1f-a411-c72669f4c4bc@oracle.com>
 <20260723105451.1563439-1-physicalmtea@gmail.com>
 <45a33302-0b28-4d00-8724-c3af6e1783f6@oracle.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Okay, I will follow up with the changes.
